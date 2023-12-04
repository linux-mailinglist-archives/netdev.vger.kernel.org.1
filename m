Return-Path: <netdev+bounces-53533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01588039AE
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595E5280F91
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2252D627;
	Mon,  4 Dec 2023 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAhywY+b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88541B0
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701706120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nmt0EvtUGdPueK6Mkim5XBEne1PTOlidHT6ZZv5BEp4=;
	b=WAhywY+b+sXuiq7Vz/KyAn6TfRNdztBxZC85eoKHCfk3KaEVk4pvcot/eXuVOtf78UbDNl
	ooZ6BJAlzFtgDGDRku/51DEN+H95YByivDxpmTtMfJ4mnTEPlsmQEHsIw+suw0ldcjdw5u
	zZM6A8ZhPfoVcsklmUuMlylPNLlrgqA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-cHZc5QvNOrG5C0_aO_uizw-1; Mon, 04 Dec 2023 11:08:37 -0500
X-MC-Unique: cHZc5QvNOrG5C0_aO_uizw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A8B0811E86;
	Mon,  4 Dec 2023 16:08:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.237])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ACB672166B26;
	Mon,  4 Dec 2023 16:08:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Neil Spring <ntspring@fb.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Stefano Brivio <sbrivio@redhat.com>
Subject: [PATCH v2 net] tcp: fix mid stream window clamp.
Date: Mon,  4 Dec 2023 17:08:05 +0100
Message-ID: <705dad54e6e6e9a010e571bf58e0b35a8ae70503.1701706073.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

After the blamed commit below, if the user-space application performs
window clamping when tp->rcv_wnd is 0, the TCP socket will never be
able to announce a non 0 receive window, even after completely emptying
the receive buffer and re-setting the window clamp to higher values.

Refactor tcp_set_window_clamp() to address the issue: when the user
decreases the current clamp value, set rcv_ssthresh according to the
same logic used at buffer initialization, but ensuring reserved mem
provisioning.

To avoid code duplication factor-out the relevant bits from
tcp_adjust_rcv_ssthresh() in a new helper and reuse it in the above
scenario.

When increasing the clamp value, give the rcv_ssthresh a chance to grow
according to previously implemented heuristic.

Fixes: 3aa7857fe1d7 ("tcp: enable mid stream window clamp")
Reported-by: David Gibson <david@gibson.dropbear.id.au>
Reported-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - respect SO_RESERVE_MEM provisioning (Eric)
---
 include/net/tcp.h |  9 +++++++--
 net/ipv4/tcp.c    | 22 +++++++++++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d2f0736b76b8..144ba48bb07b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1514,17 +1514,22 @@ static inline int tcp_full_space(const struct sock *sk)
 	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
 }
 
-static inline void tcp_adjust_rcv_ssthresh(struct sock *sk)
+static inline void __tcp_adjust_rcv_ssthresh(struct sock *sk, u32 new_ssthresh)
 {
 	int unused_mem = sk_unused_reserved_mem(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	tp->rcv_ssthresh = min(tp->rcv_ssthresh, 4U * tp->advmss);
+	tp->rcv_ssthresh = min(tp->rcv_ssthresh, new_ssthresh);
 	if (unused_mem)
 		tp->rcv_ssthresh = max_t(u32, tp->rcv_ssthresh,
 					 tcp_win_from_space(sk, unused_mem));
 }
 
+static inline void tcp_adjust_rcv_ssthresh(struct sock *sk)
+{
+	__tcp_adjust_rcv_ssthresh(sk, 4U * tcp_sk(sk)->advmss);
+}
+
 void tcp_cleanup_rbuf(struct sock *sk, int copied);
 void __tcp_cleanup_rbuf(struct sock *sk, int copied);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 53bcc17c91e4..c9f078224569 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3368,9 +3368,25 @@ int tcp_set_window_clamp(struct sock *sk, int val)
 			return -EINVAL;
 		tp->window_clamp = 0;
 	} else {
-		tp->window_clamp = val < SOCK_MIN_RCVBUF / 2 ?
-			SOCK_MIN_RCVBUF / 2 : val;
-		tp->rcv_ssthresh = min(tp->rcv_wnd, tp->window_clamp);
+		u32 new_rcv_ssthresh, old_window_clamp = tp->window_clamp;
+		u32 new_window_clamp = val < SOCK_MIN_RCVBUF / 2 ?
+						SOCK_MIN_RCVBUF / 2 : val;
+
+		if (new_window_clamp == old_window_clamp)
+			return 0;
+
+		tp->window_clamp = new_window_clamp;
+		if (new_window_clamp < old_window_clamp) {
+			/* need to apply the reserved mem provisioning only
+			 * when shrinking the window clamp
+			 */
+			__tcp_adjust_rcv_ssthresh(sk, tp->window_clamp);
+
+		} else {
+			new_rcv_ssthresh = min(tp->rcv_wnd, tp->window_clamp);
+			tp->rcv_ssthresh = max(new_rcv_ssthresh,
+					       tp->rcv_ssthresh);
+		}
 	}
 	return 0;
 }
-- 
2.42.0


