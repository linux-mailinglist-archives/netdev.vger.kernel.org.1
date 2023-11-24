Return-Path: <netdev+bounces-50678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2907F69D4
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 01:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02818B20C74
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 00:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF0B625;
	Fri, 24 Nov 2023 00:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="C3x6Ua/p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8B310F0
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:27:39 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b2afd049aso9527895e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700785657; x=1701390457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LV5EkLuNSBfoQx/kzqLjwykT0kFRG1MCX3eqbiNCe28=;
        b=C3x6Ua/pj0oOXjgeuzhqWpgjUj23qAaw6dbelQhqM3IsVzzqwA1te5VDD4epFakXLZ
         1aLXQ/UP2L8bGB96BEKKYg61xHGbMM43jCYqcg274nF+1ueBozuSaytNxkMTtKT8fXiI
         wEo2YcX7V3kbybBDzjNYF0UZrI1QTtsUPLYFxgKIRtkajhnzgZ7VT0fpyxj3kHC0BWxS
         xmHWRPjqWvC+kLwodMl3Q6tZPMk2banA7D3oe7H6FE9hW9IypUz+JjSlzyGeftZk7khl
         sd+vYCgiqoq6eSHizoc1IeYO22D4kSDYApJvUJYpi9u399avVz/hqUHxazqI57AvkJzc
         xDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785657; x=1701390457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LV5EkLuNSBfoQx/kzqLjwykT0kFRG1MCX3eqbiNCe28=;
        b=QCOaU7wdCay+J8p42CsnAOayxIXvTACMjjC+yxRhlevbcFvHvluEn78qBmo3jBhgir
         zrqCD333la/mKqnAwqxVPa+iyPreSi6qrDX0MAQtrnRn3NKXcvqn6MHCRSbwksWmhGws
         ryeg/toUcqqS1Q7PHbbJG/XidZvqPeByNzhcZ93cW9a2NMrxh8r4uTX3ofvisSD6gIoO
         Cavo++IqkV1UwzrZWHv5IcKFnFdyFLfygZKl3/4oGuiHtVTnbEqRdiL+ZsZjaL3jHCGZ
         89bxwkAtqoTbhWqKX+b0Uq4Q0KE/26zlOu+XVBPpKdyBK8cRFWrYfQ0TBsYOU1fHar/9
         7OuQ==
X-Gm-Message-State: AOJu0YyX+SIPzYZL1qJcZl+DaXMZOAT471BUY5A1sbwxZmxCRcCSdgsT
	/7F2ubKrpEHV1l8B4MLi5SMcBQ==
X-Google-Smtp-Source: AGHT+IEtMz34JcW1vswAZ9iuNJ5pIajSVsqMInCxGKXkwHpYb4iNfvC5/PyDF6S/UhnHKNquYq5uBA==
X-Received: by 2002:a05:600c:1d1b:b0:40b:36e6:9f15 with SMTP id l27-20020a05600c1d1b00b0040b36e69f15mr928127wms.26.1700785657476;
        Thu, 23 Nov 2023 16:27:37 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b004094e565e71sm3453230wmo.23.2023.11.23.16.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:27:36 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	Salam Noureddine <noureddine@arista.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v2 6/7] net/tcp: Add sne_lock to access SNEs
Date: Fri, 24 Nov 2023 00:27:19 +0000
Message-ID: <20231124002720.102537-7-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124002720.102537-1-dima@arista.com>
References: <20231124002720.102537-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC 5925 (6.2):
> TCP-AO emulates a 64-bit sequence number space by inferring when to
> increment the high-order 32-bit portion (the SNE) based on
> transitions in the low-order portion (the TCP sequence number).

snd_sne and rcv_sne are the upper 4 bytes of extended SEQ number.
Unfortunately, reading two 4-bytes pointers can't be performed
atomically (without synchronization).

Let's keep it KISS and add an rwlock - that shouldn't create much
contention as SNE are updated every 4Gb of traffic and the atomic region
is quite small.

Fixes: 64382c71a557 ("net/tcp: Add TCP-AO SNE support")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp_ao.h |  2 +-
 net/ipv4/tcp_ao.c    | 34 +++++++++++++++++++++-------------
 net/ipv4/tcp_input.c | 16 ++++++++++++++--
 3 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 647781080613..beea3e6b39e2 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -123,6 +123,7 @@ struct tcp_ao_info {
 	 */
 	u32			snd_sne;
 	u32			rcv_sne;
+	rwlock_t		sne_lock;
 	refcount_t		refcnt;		/* Protects twsk destruction */
 	struct rcu_head		rcu;
 };
@@ -212,7 +213,6 @@ enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 			const struct sk_buff *skb, unsigned short int family,
 			const struct request_sock *req, int l3index,
 			const struct tcp_ao_hdr *aoh);
-u32 tcp_ao_compute_sne(u32 next_sne, u32 next_seq, u32 seq);
 struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk, int l3index,
 				    const union tcp_ao_addr *addr,
 				    int family, int sndid, int rcvid);
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 2d000e275ce7..74db80aeeef3 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -230,6 +230,7 @@ static struct tcp_ao_info *tcp_ao_alloc_info(gfp_t flags)
 		return NULL;
 	INIT_HLIST_HEAD(&ao->head);
 	refcount_set(&ao->refcnt, 1);
+	rwlock_init(&ao->sne_lock);
 
 	return ao;
 }
@@ -472,10 +473,8 @@ static int tcp_ao_hash_pseudoheader(unsigned short int family,
 	return -EAFNOSUPPORT;
 }
 
-u32 tcp_ao_compute_sne(u32 next_sne, u32 next_seq, u32 seq)
+static u32 tcp_ao_compute_sne(u32 sne, u32 next_seq, u32 seq)
 {
-	u32 sne = next_sne;
-
 	if (before(seq, next_seq)) {
 		if (seq > next_seq)
 			sne--;
@@ -483,7 +482,6 @@ u32 tcp_ao_compute_sne(u32 next_sne, u32 next_seq, u32 seq)
 		if (seq < next_seq)
 			sne++;
 	}
-
 	return sne;
 }
 
@@ -763,14 +761,15 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 		*keyid = (*key)->rcvid;
 	} else {
 		struct tcp_ao_key *rnext_key;
-		u32 snd_basis;
+		const u32 *snd_basis;
+		unsigned long flags;
 
 		if (sk->sk_state == TCP_TIME_WAIT) {
 			ao_info = rcu_dereference(tcp_twsk(sk)->ao_info);
-			snd_basis = tcp_twsk(sk)->tw_snd_nxt;
+			snd_basis = &tcp_twsk(sk)->tw_snd_nxt;
 		} else {
 			ao_info = rcu_dereference(tcp_sk(sk)->ao_info);
-			snd_basis = tcp_sk(sk)->snd_una;
+			snd_basis = &tcp_sk(sk)->snd_una;
 		}
 		if (!ao_info)
 			return -ENOENT;
@@ -781,8 +780,10 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 		*traffic_key = snd_other_key(*key);
 		rnext_key = READ_ONCE(ao_info->rnext_key);
 		*keyid = rnext_key->rcvid;
-		*sne = tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne),
-					  snd_basis, seq);
+		read_lock_irqsave(&ao_info->sne_lock, flags);
+		*sne = tcp_ao_compute_sne(ao_info->snd_sne,
+					  READ_ONCE(*snd_basis), seq);
+		read_unlock_irqrestore(&ao_info->sne_lock, flags);
 	}
 	return 0;
 }
@@ -795,6 +796,7 @@ int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_ao_info *ao;
 	void *tkey_buf = NULL;
+	unsigned long flags;
 	u8 *traffic_key;
 	u32 sne;
 
@@ -816,8 +818,10 @@ int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
 		tp->af_specific->ao_calc_key_sk(key, traffic_key,
 						sk, ao->lisn, disn, true);
 	}
-	sne = tcp_ao_compute_sne(READ_ONCE(ao->snd_sne), READ_ONCE(tp->snd_una),
-				 ntohl(th->seq));
+	read_lock_irqsave(&ao->sne_lock, flags);
+	sne = tcp_ao_compute_sne(ao->snd_sne,
+				 READ_ONCE(tp->snd_una), ntohl(th->seq));
+	read_unlock_irqrestore(&ao->sne_lock, flags);
 	tp->af_specific->calc_ao_hash(hash_location, key, sk, skb, traffic_key,
 				      hash_location - (u8 *)th, sne);
 	kfree(tkey_buf);
@@ -938,8 +942,9 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 
 	/* Fast-path */
 	if (likely((1 << sk->sk_state) & TCP_AO_ESTABLISHED)) {
-		enum skb_drop_reason err;
 		struct tcp_ao_key *current_key;
+		enum skb_drop_reason err;
+		unsigned long flags;
 
 		/* Check if this socket's rnext_key matches the keyid in the
 		 * packet. If not we lookup the key based on the keyid
@@ -956,8 +961,11 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		if (unlikely(th->syn && !th->ack))
 			goto verify_hash;
 
-		sne = tcp_ao_compute_sne(info->rcv_sne, tcp_sk(sk)->rcv_nxt,
+		read_lock_irqsave(&info->sne_lock, flags);
+		sne = tcp_ao_compute_sne(info->rcv_sne,
+					 READ_ONCE(tcp_sk(sk)->rcv_nxt),
 					 ntohl(th->seq));
+		read_unlock_irqrestore(&info->sne_lock, flags);
 		/* Established socket, traffic key are cached */
 		traffic_key = rcv_other_key(key);
 		err = tcp_ao_verify_hash(sk, skb, family, info, aoh, key,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bcb55d98004c..fc3c27ce2b73 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3582,8 +3582,14 @@ static void tcp_snd_sne_update(struct tcp_sock *tp, u32 ack)
 
 	ao = rcu_dereference_protected(tp->ao_info,
 				       lockdep_sock_is_held((struct sock *)tp));
-	if (ao && ack < tp->snd_una)
+	if (ao && ack < tp->snd_una) {
+		unsigned long flags;
+
+		write_lock_irqsave(&ao->sne_lock, flags);
 		ao->snd_sne++;
+		tp->snd_una = ack;
+		write_unlock_irqrestore(&ao->sne_lock, flags);
+	}
 #endif
 }
 
@@ -3608,8 +3614,14 @@ static void tcp_rcv_sne_update(struct tcp_sock *tp, u32 seq)
 
 	ao = rcu_dereference_protected(tp->ao_info,
 				       lockdep_sock_is_held((struct sock *)tp));
-	if (ao && seq < tp->rcv_nxt)
+	if (ao && seq < tp->rcv_nxt) {
+		unsigned long flags;
+
+		write_lock_irqsave(&ao->sne_lock, flags);
 		ao->rcv_sne++;
+		WRITE_ONCE(tp->rcv_nxt, seq);
+		write_unlock_irqrestore(&ao->sne_lock, flags);
+	}
 #endif
 }
 
-- 
2.43.0


