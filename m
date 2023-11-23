Return-Path: <netdev+bounces-50578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A077F62B3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385841C20382
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F2035887;
	Thu, 23 Nov 2023 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbMAjlv0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07F2C1
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 07:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700753110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7ijQP282NEHm7t7gKfIuSk88seljdhuJ6fz2bu7WLas=;
	b=AbMAjlv0HTjSyCGP08s5cYLimNut11/m+e5VLFj/c1MJVrwuOjaauo4hNE/pDaIfVADyHw
	t8BUMK0ikSb4XYC60NI8OaBwoaPYjIqLCiMZbVRpxFuHciNncXJIbKsaD+BHAtIqEhuory
	3dY5z5ixeRyMboa+2LP1KchuqdIqp6g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-qbeTdoUpOn2tSeqJMEwSyg-1; Thu,
 23 Nov 2023 10:25:06 -0500
X-MC-Unique: qbeTdoUpOn2tSeqJMEwSyg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C433D38130AF;
	Thu, 23 Nov 2023 15:25:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.207])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 44DD02166B26;
	Thu, 23 Nov 2023 15:25:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Neil Spring <ntspring@fb.com>,
	Paolo Abeni <pabeni@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH net] tcp: fix mid stream window clamp.
Date: Thu, 23 Nov 2023 16:24:07 +0100
Message-ID: <fab4d0949126683a3b6b4e04a9ec088cf9bfdbb1.1700751622.git.pabeni@redhat.com>
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
same logic used at buffer initialization time.
When increasing the clamp value, give the rcv_ssthresh a chance to grow
according to previously implemented heuristic.

Fixes: 3aa7857fe1d7 ("tcp: enable mid stream window clamp")
Reported-by: David Gibson <david@gibson.dropbear.id.au>
Reported-by: Stefano Brivio <sbrivio@redhat.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Tested-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/tcp.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 53bcc17c91e4..1a9b9064e080 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3368,9 +3368,22 @@ int tcp_set_window_clamp(struct sock *sk, int val)
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
+			tp->rcv_ssthresh = min(tp->rcv_ssthresh,
+					       new_window_clamp);
+		} else {
+			new_rcv_ssthresh = min(tp->rcv_wnd, tp->window_clamp);
+			tp->rcv_ssthresh = max(new_rcv_ssthresh,
+					       tp->rcv_ssthresh);
+		}
 	}
 	return 0;
 }
-- 
2.41.0


