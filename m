Return-Path: <netdev+bounces-282321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMOkCvjN8WlrkgEAu9opvQ
	(envelope-from <netdev+bounces-282321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:23:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B766E491CEE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 120EF30B74D9
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111F73C1400;
	Wed, 29 Apr 2026 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="rQEhSziT"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C1B3C0607
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454211; cv=none; b=TqE0OVL+24vZ/C/+pDixwLf62h90UIMcmu8YnFGENBBMi3+UeBwEu8PYFfNGogn8hC1ldPbI7gUKlpGpaXffCjsLgiGvPB+p3ce6XkDm1ykNf7V6LIRrbbAQZvsaOzQUd5R7+GVi1Lgri0dYurYOpuJPArYOpw3PBeIHAMxBPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454211; c=relaxed/simple;
	bh=jooEF0Q2ODBHr+EeWZk3cn58gUgpPnmfj/zlBZ4xAes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCT+pwDVGN0l/hc1RfL902MMSLE5wJY+Avt1oqkh20wlC6IOxslwC0WJsFaVAlzhmvB9NRke8CePN1v6HZVSpoi81TpH7KjcTAMayUDurZU27rge1aQ00gC0U/NJJP5gEEtCo6xE5DRjav0BuxUR1t8VMSKhPr/mtXFBwGLyb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=rQEhSziT; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (197.87.13.160.dy.iij4u.or.jp [160.13.87.197])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63T9Gl79043858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 29 Apr 2026 18:16:47 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=VNsqaO4VKM8duP7X8u8FBpIkMOKyeVk0AVzZrcnvqQk=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1777454208; v=1;
        b=rQEhSziTaV0FBpgEarw4ucX8bjV0NzKD6QXkBZ5aqUTVRatvlFm0OtMQc44rgxUJ
         0qPPxlKIL+tX1tAbZHE0CyWNZeijJUmKb1/4PGO01THNbf7tSzRn8dnE29JjzbEE
         J8KOn0wM4y8IDRxwCvrYoyNB61hwQ6+XgV+MaRfLTqltIPfqSF3SgfIXeLdKOkBw
         hMxHM45BCjQ4QHIQ2gB6BHsQPIG9ah5a4XP6j1PW6rs58UMGp1ZvmpfAR8noozkT
         jHHNHh7HfEhsdgjNG/p8z054cAMN0CzvpdGWCVNnDwDgZ3C+XTLweTmQT1NTrg0v
         kgU2YZZPMvtWSmLryHzKVA==
From: Kohei Enju <kohei@enjuk.jp>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Willem de Bruijn <willemb@google.com>,
        David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH net v1 3/3] tcp: use skb_get_hwtstamp() for hardware timestamps
Date: Wed, 29 Apr 2026 09:16:19 +0000
Message-ID: <20260429091632.26509-4-kohei@enjuk.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429091632.26509-1-kohei@enjuk.jp>
References: <20260429091632.26509-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B766E491CEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,engleder-embedded.com,gmail.com,enjuk.jp];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282321-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,enjuk.jp:dkim,enjuk.jp:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Since commit 97dc7cd92ac6 ("ptp: Support late timestamp determination"),
skb_shared_hwtstamps may contain netdev_data instead of hwtstamp. TCP
receive timestamping can then interpret the stored value as a ktime_t
and report bogus hardware timestamps to userspace.

Use skb_get_hwtstamp() instead of reading hwtstamp directly, so TCP
sockets follow the same hardware timestamp resolution path as the socket
layer. When coalescing SKBs, resolve late timestamps before copying them
to the merged skb. Additionally, recognize SKBTX_HW_TSTAMP_NETDEV as
indicating a receive timestamp is present.

Note that skb_get_hwtstamp() is called with cycles == false, since TCP
hasn't honored SOF_TIMESTAMPING_BIND_PHC so far, and this patch doesn't
change that behavior.

Fixes: 97dc7cd92ac6 ("ptp: Support late timestamp determination")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 include/net/tcp.h    | 2 +-
 net/ipv4/tcp_input.c | 3 ++-
 net/ipv4/tcp_ipv4.c  | 6 ++++--
 net/ipv6/tcp_ipv6.c  | 3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ecbadcb3a744..7b5fcee97079 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -524,7 +524,7 @@ tcp_update_recv_tstamps(struct sk_buff *skb,
 			struct scm_timestamping_internal *tss)
 {
 	tss->ts[0] = skb->tstamp;
-	tss->ts[2] = skb_hwtstamps(skb)->hwtstamp;
+	tss->ts[2] = skb_get_hwtstamp(skb, false, NULL);
 }
 
 void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d5c9e65d9760..9fd473559b58 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5237,7 +5237,8 @@ static bool tcp_try_coalesce(struct sock *sk,
 	if (TCP_SKB_CB(from)->has_rxtstamp) {
 		TCP_SKB_CB(to)->has_rxtstamp = true;
 		to->tstamp = from->tstamp;
-		skb_hwtstamps(to)->hwtstamp = skb_hwtstamps(from)->hwtstamp;
+		skb_hwtstamps(to)->hwtstamp = skb_get_hwtstamp(from, false, NULL);
+		skb_shinfo(to)->tx_flags &= ~SKBTX_HW_TSTAMP_NETDEV;
 	}
 
 	return true;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 8fc24c3743c5..c35d82317764 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1993,7 +1993,8 @@ enum skb_drop_reason tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 		if (TCP_SKB_CB(skb)->has_rxtstamp) {
 			TCP_SKB_CB(tail)->has_rxtstamp = true;
 			tail->tstamp = skb->tstamp;
-			skb_hwtstamps(tail)->hwtstamp = skb_hwtstamps(skb)->hwtstamp;
+			skb_hwtstamps(tail)->hwtstamp = skb_get_hwtstamp(skb, false, NULL);
+			skb_shinfo(tail)->tx_flags &= ~SKBTX_HW_TSTAMP_NETDEV;
 		}
 
 		/* Not as strict as GRO. We only need to carry mss max value */
@@ -2062,7 +2063,8 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 	TCP_SKB_CB(skb)->ip_dsfield = ipv4_get_dsfield(iph);
 	TCP_SKB_CB(skb)->sacked	 = 0;
 	TCP_SKB_CB(skb)->has_rxtstamp =
-			skb->tstamp || skb_hwtstamps(skb)->hwtstamp;
+			skb->tstamp || skb_hwtstamps(skb)->hwtstamp ||
+			(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV);
 }
 
 /*
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2c3f7a739709..3361ed7f94de 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1704,7 +1704,8 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 	TCP_SKB_CB(skb)->ip_dsfield = ipv6_get_dsfield(hdr);
 	TCP_SKB_CB(skb)->sacked = 0;
 	TCP_SKB_CB(skb)->has_rxtstamp =
-			skb->tstamp || skb_hwtstamps(skb)->hwtstamp;
+			skb->tstamp || skb_hwtstamps(skb)->hwtstamp ||
+			(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV);
 }
 
 INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
-- 
2.53.0


