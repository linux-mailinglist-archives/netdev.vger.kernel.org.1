Return-Path: <netdev+bounces-84619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305608979BB
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA08C28DBB5
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADA7155A34;
	Wed,  3 Apr 2024 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEPIk78n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246911552FF
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175702; cv=none; b=bBjg8oEtlTq+fEZJm7JRkuedbCe0uQq6i6DxNwCXkykY6F3TJ/n9Acygd1QItz5J77Mkgh4nffcMykIalXntslLVSoWTlXoqOyWWavsiaek3C/OkM3XlDosKuBDsR9WSS77L6HMmhKB4h5yNwiInmZ5cEjaxDt1W69cvgV1vXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175702; c=relaxed/simple;
	bh=oyM5xfBt4RaoKlxaNDvf9L/ufs5t+pHydeP6Pcm++F4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Us+NKzcDyUNH/oqYr4F8P7kceW7SOK7yfopUUc16SCHXXknTycGRDZ7O08mHubj8+eyjk23Z9qxjF0SC2qJFKyaYVMJztwJjKXYXiYQ9ZLBaGc2brzktF2PBCqFbMCv2+zPfI+VHJtl3qLZ+o6HWP0CDJAMsFRmpKX9UdmtPtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEPIk78n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F85BC433F1;
	Wed,  3 Apr 2024 20:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712175701;
	bh=oyM5xfBt4RaoKlxaNDvf9L/ufs5t+pHydeP6Pcm++F4=;
	h=From:To:Cc:Subject:Date:From;
	b=WEPIk78nmXdhQNp7ae5QBDYsvUwdT8TWkqFiXvZoMfDkQ8y91odJp9sqOtY6ksPi7
	 ys2yxK3ViSVPr7OXciPFO2QOtcrR3WzbtoVqB1BpYOnPB7B6S7UuUKEkqc1Oa61LVj
	 tsdk5vwTY3C8SyzR5iALqAuBl0TTiz5F0YaxyXsZyR6G1lj3jfNxZpM6kmdb84yDFK
	 NL1MyIw7i62+OF1vo9DK2ZpZoMBip0Vtkt46+SLGzw7F4qt2rORgirzLY5JkYnWvyD
	 adVxCjVsZVdXkAVxpog6vt4jHEm2YMAWH2sRlh58RrY1tKLN5eYhV7LFCKjrVsRMe/
	 oiTBXnaVWHHQA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com
Subject: [PATCH net-next] net: skbuff: generalize the skb->decrypted bit
Date: Wed,  3 Apr 2024 13:21:39 -0700
Message-ID: <20240403202139.1978143-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ->decrypted bit can be reused for other crypto protocols.
Remove the direct dependency on TLS, add helpers to clean up
the ifdefs leaking out everywhere.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
I'm going to post PSP support.. as soon as the test groundwork
is in place. I think this stands on its own as a cleanup.

CC: dsahern@kernel.org
CC: borisp@nvidia.com
CC: john.fastabend@gmail.com
---
 include/linux/skbuff.h | 15 ++++++++++++---
 include/net/sock.h     |  4 +---
 net/Kconfig            |  3 +++
 net/core/sock.c        |  5 ++---
 net/ipv4/tcp_input.c   | 12 +++---------
 net/ipv4/tcp_ipv4.c    |  4 +---
 net/ipv4/tcp_offload.c |  4 +---
 net/tls/Kconfig        |  1 +
 8 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 03ea36a82cdd..7dfb906d92f7 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -992,7 +992,7 @@ struct sk_buff {
 #ifdef CONFIG_NETFILTER_SKIP_EGRESS
 	__u8			nf_skip_egress:1;
 #endif
-#ifdef CONFIG_TLS_DEVICE
+#ifdef CONFIG_SKB_DECRYPTED
 	__u8			decrypted:1;
 #endif
 	__u8			slow_gro:1;
@@ -1615,17 +1615,26 @@ static inline void skb_copy_hash(struct sk_buff *to, const struct sk_buff *from)
 static inline int skb_cmp_decrypted(const struct sk_buff *skb1,
 				    const struct sk_buff *skb2)
 {
-#ifdef CONFIG_TLS_DEVICE
+#ifdef CONFIG_SKB_DECRYPTED
 	return skb2->decrypted - skb1->decrypted;
 #else
 	return 0;
 #endif
 }
 
+static inline bool skb_is_decrypted(const struct sk_buff *skb)
+{
+#ifdef CONFIG_SKB_DECRYPTED
+	return skb->decrypted;
+#else
+	return false;
+#endif
+}
+
 static inline void skb_copy_decrypted(struct sk_buff *to,
 				      const struct sk_buff *from)
 {
-#ifdef CONFIG_TLS_DEVICE
+#ifdef CONFIG_SKB_DECRYPTED
 	to->decrypted = from->decrypted;
 #endif
 }
diff --git a/include/net/sock.h b/include/net/sock.h
index 2253eefe2848..a495330c5c49 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2835,12 +2835,10 @@ static inline struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
 
 	if (sk && sk_fullsock(sk) && sk->sk_validate_xmit_skb) {
 		skb = sk->sk_validate_xmit_skb(sk, dev, skb);
-#ifdef CONFIG_TLS_DEVICE
-	} else if (unlikely(skb->decrypted)) {
+	} else if (unlikely(skb_is_decrypted(skb))) {
 		pr_warn_ratelimited("unencrypted skb with no associated socket - dropping\n");
 		kfree_skb(skb);
 		skb = NULL;
-#endif
 	}
 #endif
 
diff --git a/net/Kconfig b/net/Kconfig
index 3e57ccf0da27..d5ab791f7afa 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -60,6 +60,9 @@ config NET_XGRESS
 config NET_REDIRECT
 	bool
 
+config SKB_DECRYPTED
+	bool
+
 config SKB_EXTENSIONS
 	bool
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 5ed411231fc7..fe9195186c13 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2526,13 +2526,12 @@ EXPORT_SYMBOL(skb_set_owner_w);
 
 static bool can_skb_orphan_partial(const struct sk_buff *skb)
 {
-#ifdef CONFIG_TLS_DEVICE
 	/* Drivers depend on in-order delivery for crypto offload,
 	 * partial orphan breaks out-of-order-OK logic.
 	 */
-	if (skb->decrypted)
+	if (skb_is_decrypted(skb))
 		return false;
-#endif
+
 	return (skb->destructor == sock_wfree ||
 		(IS_ENABLED(CONFIG_INET) && skb->destructor == tcp_wfree));
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1b6cd3840012..9fb9d704c4d9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4803,10 +4803,8 @@ static bool tcp_try_coalesce(struct sock *sk,
 	if (!mptcp_skb_can_collapse(to, from))
 		return false;
 
-#ifdef CONFIG_TLS_DEVICE
-	if (from->decrypted != to->decrypted)
+	if (skb_cmp_decrypted(from, to))
 		return false;
-#endif
 
 	if (!skb_try_coalesce(to, from, fragstolen, &delta))
 		return false;
@@ -5375,9 +5373,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			break;
 
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
-#ifdef CONFIG_TLS_DEVICE
-		nskb->decrypted = skb->decrypted;
-#endif
+		skb_copy_decrypted(nskb, skb);
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		if (list)
 			__skb_queue_before(list, skb, nskb);
@@ -5407,10 +5403,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 				    !mptcp_skb_can_collapse(nskb, skb) ||
 				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
 					goto end;
-#ifdef CONFIG_TLS_DEVICE
-				if (skb->decrypted != nskb->decrypted)
+				if (skb_cmp_decrypted(skb, nskb))
 					goto end;
-#endif
 			}
 		}
 	}
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1e0a9762f92e..004e5d67c1d3 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2045,10 +2045,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	      TCP_SKB_CB(skb)->tcp_flags) & TCPHDR_ACK) ||
 	    ((TCP_SKB_CB(tail)->tcp_flags ^
 	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_ECE | TCPHDR_CWR)) ||
-#ifdef CONFIG_TLS_DEVICE
-	    tail->decrypted != skb->decrypted ||
-#endif
 	    !mptcp_skb_can_collapse(tail, skb) ||
+	    skb_cmp_decrypted(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
 		goto no_coalesce;
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index ebe4722bb020..fab0973f995b 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -265,9 +265,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 		flush |= (len - 1) >= mss;
 
 	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
-#ifdef CONFIG_TLS_DEVICE
-	flush |= p->decrypted ^ skb->decrypted;
-#endif
+	flush |= skb_cmp_decrypted(p, skb);
 
 	if (flush || skb_gro_receive(p, skb)) {
 		mss = 1;
diff --git a/net/tls/Kconfig b/net/tls/Kconfig
index 0cdc1f7b6b08..ce8d56a19187 100644
--- a/net/tls/Kconfig
+++ b/net/tls/Kconfig
@@ -20,6 +20,7 @@ config TLS
 config TLS_DEVICE
 	bool "Transport Layer Security HW offload"
 	depends on TLS
+	select SKB_DECRYPTED
 	select SOCK_VALIDATE_XMIT
 	select SOCK_RX_QUEUE_MAPPING
 	default n
-- 
2.44.0


