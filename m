Return-Path: <netdev+bounces-181347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CDCA8496C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3954188FF6D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB871EB9E3;
	Thu, 10 Apr 2025 16:16:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EC91D5CE8;
	Thu, 10 Apr 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301784; cv=none; b=kCn5nF4COai8IrL5YkxwNDIA9AqCEM3x4rcOhK1Pmqs9Zm5lw37yHsSww+r4GSBdSh1iDjPeI2KPZhGZM36jDdXILkE9x2vZ9RR9Q269VbSYjJu9rFAebAAGokzaLwLUheIMbJs9QifpiB+x1Z5j+Nkv6vRacY09jbV0bnF3Nck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301784; c=relaxed/simple;
	bh=qObBAuE4ohxgPRvelw7IDtEERtFwSOwMeN+0o0AwtYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gD3Z2q9ksJ9cKEDgXVK+UDTN9XObph5q92fsP78TvlEJhw7h6ZwfgXdHgRfC09CQvc9gFxXfrDNmmlGqjZbF7b+mFjOnTBHt3cECfuDkm+rDgbXlwSPZiq1BOSTNGmb/64au9a3HsudCJLwT4G3p7bO9wZqKWqjaVFPSmUlxA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227d6b530d8so10550555ad.3;
        Thu, 10 Apr 2025 09:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744301781; x=1744906581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+agMxJloJ2uRUEJZwb0DDEkPfkqwgCunsc+aZu+YfQ=;
        b=thO5RhEFXXnAIUdAQSyYhITfipY0xC4O6BvANiDe4LUCnUct7lnzE+s4Wtqt24cua7
         8SjKOJc/D/xtJFhlBymgcEjs98qcs3JE56TJdU/NfiRvyeT3VnmfkOX/tfTQmzbJvrDK
         KCFJhoJiO6D8DKXg+3PIhP1w03z+FAzYAUUBQCcSgqlC+HS9w0sukDcD/QXGrD9SLARI
         O0bmO3iEPd8GNAcitvIS+Fx69pBbReKwkNIMaMwmT4Wa1ckFs+mv0r8m5N37R8ZyykrA
         Ppgx75pd7PBCgFqxbdWlv5PnFNmPOh91xh11IWFjtyZGTokdDy/Bksx5jNTU93dFUIUE
         5WIA==
X-Forwarded-Encrypted: i=1; AJvYcCXgp9b2wf2Jc01B8nCmQKGMTcI/BPKtHrzZjtizETSxDBgWzl1QpHxILnF21QU6zQ+1zXARYdUGQ/3tdGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsiJDSC/bRos2ST3KW9FVQh+WI8Efxlq2/S6NPG9oDoqhwZu/i
	G6ekSD8D+WIJ8EiL3udtzkqGhvfhg2flLUiw5tl5cQLEHmkl6ZfJXjNBNpY=
X-Gm-Gg: ASbGncsEyt4im8QGR615ML/Ba8Y8eXvb/gV+1Wh50vuRMhLcKrzSil56NhrrrhU9qDF
	jCNfMj6xbl9yTTU9mMdEcmiBSUer1djw5LN6lYp8B/adLrjaUfcFdzhBc3GK+25KyyfcarlwwaV
	pGNOZoRJaY0AVbp06fC+0O+oZVPI596ltewKYbDgMBBwl/v5DiGJ4y5d7VRYevyy8PkQ/4BuINk
	etfSNOlOkSUwn4FX2NQfUtkruYVTqUJ7xlJUa8Zse/ULOcrnA17h+7/IDwfQjgTXz3sh/wA4yF3
	Ep0mGbW1bTNrxa9YG+zkfmjFmdna/WF+T8PdJ3Ni
X-Google-Smtp-Source: AGHT+IFltSmh3BGBWPytdAJ2BHqH8GRKi1PK1aDsb3CA0UJrbttMqWP+8WNZRx9qDY2LWBMhLSbfGg==
X-Received: by 2002:a17:903:41c8:b0:227:e980:9190 with SMTP id d9443c01a7336-22b42c4e68dmr49464795ad.44.1744301780615;
        Thu, 10 Apr 2025 09:16:20 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-306dd10c3dasm3899300a91.4.2025.04.10.09.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 09:16:20 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@amazon.com,
	horms@kernel.org,
	dsahern@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] tcp: drop tcp_v{4,6}_restore_cb
Date: Thu, 10 Apr 2025 09:16:19 -0700
Message-ID: <20250410161619.3581785-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of moving and restoring IP[6]CB, reorder tcp_skb_cb
to alias with inet[6]_skb_parm. Add static asserts to make
sure tcp_skb_cb fits into skb.cb and that inet[6]_skb_parm is
at the proper offset.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/tcp.h   | 46 +++++++++++++++++++++++++--------------------
 net/ipv4/tcp_ipv4.c | 16 ----------------
 net/ipv6/tcp_ipv6.c | 25 ------------------------
 3 files changed, 26 insertions(+), 61 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4450c384ef17..e80fd505f139 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1010,6 +1010,27 @@ enum tcp_skb_cb_sacked_flags {
  * If this grows please adjust skbuff.h:skbuff->cb[xxx] size appropriately.
  */
 struct tcp_skb_cb {
+	union {
+		struct {
+#define TCPCB_DELIVERED_CE_MASK ((1U<<20) - 1)
+			/* There is space for up to 24 bytes */
+			__u32 is_app_limited:1, /* cwnd not fully used? */
+			      delivered_ce:20,
+			      unused:11;
+			/* pkts S/ACKed so far upon tx of skb, incl retrans: */
+			__u32 delivered;
+			/* start of send pipeline phase */
+			u64 first_tx_mstamp;
+			/* when we reached the "delivered" count */
+			u64 delivered_mstamp;
+		} tx;   /* only used for outgoing skbs */
+		union {
+			struct inet_skb_parm	h4;
+#if IS_ENABLED(CONFIG_IPV6)
+			struct inet6_skb_parm	h6;
+#endif
+		} header;	/* For incoming skbs */
+	};
 	__u32		seq;		/* Starting sequence number	*/
 	__u32		end_seq;	/* SEQ + FIN + SYN + datalen	*/
 	union {
@@ -1033,28 +1054,13 @@ struct tcp_skb_cb {
 			has_rxtstamp:1,	/* SKB has a RX timestamp	*/
 			unused:4;
 	__u32		ack_seq;	/* Sequence number ACK'd	*/
-	union {
-		struct {
-#define TCPCB_DELIVERED_CE_MASK ((1U<<20) - 1)
-			/* There is space for up to 24 bytes */
-			__u32 is_app_limited:1, /* cwnd not fully used? */
-			      delivered_ce:20,
-			      unused:11;
-			/* pkts S/ACKed so far upon tx of skb, incl retrans: */
-			__u32 delivered;
-			/* start of send pipeline phase */
-			u64 first_tx_mstamp;
-			/* when we reached the "delivered" count */
-			u64 delivered_mstamp;
-		} tx;   /* only used for outgoing skbs */
-		union {
-			struct inet_skb_parm	h4;
+};
+
+static_assert(sizeof(struct tcp_skb_cb) <= sizeof_field(struct sk_buff, cb));
+static_assert(offsetof(struct tcp_skb_cb, header.h4) == 0);
 #if IS_ENABLED(CONFIG_IPV6)
-			struct inet6_skb_parm	h6;
+static_assert(offsetof(struct tcp_skb_cb, header.h6) == 0);
 #endif
-		} header;	/* For incoming skbs */
-	};
-};
 
 #define TCP_SKB_CB(__skb)	((struct tcp_skb_cb *)&((__skb)->cb[0]))
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 8cce0d5489da..9654f663fd0d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2153,22 +2153,9 @@ int tcp_filter(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_IPV6_MOD(tcp_filter);
 
-static void tcp_v4_restore_cb(struct sk_buff *skb)
-{
-	memmove(IPCB(skb), &TCP_SKB_CB(skb)->header.h4,
-		sizeof(struct inet_skb_parm));
-}
-
 static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 			   const struct tcphdr *th)
 {
-	/* This is tricky : We move IPCB at its correct location into TCP_SKB_CB()
-	 * barrier() makes sure compiler wont play fool^Waliasing games.
-	 */
-	memmove(&TCP_SKB_CB(skb)->header.h4, IPCB(skb),
-		sizeof(struct inet_skb_parm));
-	barrier();
-
 	TCP_SKB_CB(skb)->seq = ntohl(th->seq);
 	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
 				    skb->len - th->doff * 4);
@@ -2293,7 +2280,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 				 * Try to feed this packet to this socket
 				 * instead of discarding it.
 				 */
-				tcp_v4_restore_cb(skb);
 				sock_put(sk);
 				goto lookup;
 			}
@@ -2302,7 +2288,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		nf_reset_ct(skb);
 		if (nsk == sk) {
 			reqsk_put(req);
-			tcp_v4_restore_cb(skb);
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
@@ -2430,7 +2415,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		if (sk2) {
 			inet_twsk_deschedule_put(inet_twsk(sk));
 			sk = sk2;
-			tcp_v4_restore_cb(skb);
 			refcounted = false;
 			__this_cpu_write(tcp_tw_isn, isn);
 			goto process;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index b03c223eda4f..f7734ba7f3e6 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1342,16 +1342,6 @@ static int tcp_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 	return 0; /* don't send reset */
 }
 
-static void tcp_v6_restore_cb(struct sk_buff *skb)
-{
-	/* We need to move header back to the beginning if xfrm6_policy_check()
-	 * and tcp_v6_fill_cb() are going to be called again.
-	 * ip6_datagram_recv_specific_ctl() also expects IP6CB to be there.
-	 */
-	memmove(IP6CB(skb), &TCP_SKB_CB(skb)->header.h6,
-		sizeof(struct inet6_skb_parm));
-}
-
 static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 					 struct request_sock *req,
 					 struct dst_entry *dst,
@@ -1552,8 +1542,6 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 			newnp->pktoptions = skb_clone_and_charge_r(ireq->pktopts, newsk);
 			consume_skb(ireq->pktopts);
 			ireq->pktopts = NULL;
-			if (newnp->pktoptions)
-				tcp_v6_restore_cb(newnp->pktoptions);
 		}
 	} else {
 		if (!req_unhash && found_dup_sk) {
@@ -1710,7 +1698,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (inet6_test_bit(REPFLOW, sk))
 			np->flow_label = ip6_flowlabel(ipv6_hdr(opt_skb));
 		if (ipv6_opt_accepted(sk, opt_skb, &TCP_SKB_CB(opt_skb)->header.h6)) {
-			tcp_v6_restore_cb(opt_skb);
 			opt_skb = xchg(&np->pktoptions, opt_skb);
 		} else {
 			__kfree_skb(opt_skb);
@@ -1725,15 +1712,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 			   const struct tcphdr *th)
 {
-	/* This is tricky: we move IP6CB at its correct location into
-	 * TCP_SKB_CB(). It must be done after xfrm6_policy_check(), because
-	 * _decode_session6() uses IP6CB().
-	 * barrier() makes sure compiler won't play aliasing games.
-	 */
-	memmove(&TCP_SKB_CB(skb)->header.h6, IP6CB(skb),
-		sizeof(struct inet6_skb_parm));
-	barrier();
-
 	TCP_SKB_CB(skb)->seq = ntohl(th->seq);
 	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
 				    skb->len - th->doff*4);
@@ -1849,7 +1827,6 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 				 * Try to feed this packet to this socket
 				 * instead of discarding it.
 				 */
-				tcp_v6_restore_cb(skb);
 				sock_put(sk);
 				goto lookup;
 			}
@@ -1858,7 +1835,6 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		nf_reset_ct(skb);
 		if (nsk == sk) {
 			reqsk_put(req);
-			tcp_v6_restore_cb(skb);
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
@@ -1987,7 +1963,6 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 			struct inet_timewait_sock *tw = inet_twsk(sk);
 			inet_twsk_deschedule_put(tw);
 			sk = sk2;
-			tcp_v6_restore_cb(skb);
 			refcounted = false;
 			__this_cpu_write(tcp_tw_isn, isn);
 			goto process;
-- 
2.49.0


