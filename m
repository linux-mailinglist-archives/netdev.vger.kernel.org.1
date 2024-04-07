Return-Path: <netdev+bounces-85495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7639389B016
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 11:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242C5282334
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA0B179AD;
	Sun,  7 Apr 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOBL/wFL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6317554
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712482414; cv=none; b=XpJjnDtZlVk23eZRgTQorJ3OV5TEl2iZ6e+4vyepA9pd7byleSfr0Fc3I1ZfvNjncuG9aBhz8dOFAAx1yvS9ATFe+6nXfVgNZmrLktn1QGuuQjuM9CQfiXUp3eTUnGdkY9pXr038R6lVyHnFucG3D7dY7GwCvuuyh2be4B3vrKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712482414; c=relaxed/simple;
	bh=QbB2TLdW7jeBpsnipwV75g5X4RD7ZcBWAjNmwFqbThs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VLl+miRsD1xWrE513P1ztYhnTZlcHHMM3AOpi2FYd3Kz/YVFGrwgZ8OYqyKQSpl3aDb+gH2XeKO+oAT26z/2PEDxpfOQDgwOHODxDFLwMEOd9K0IS/dFRwPEhzwJrIULNZ/I1U6RITJYFEEcz9xU+yt4Bw45kPlQTK2f+4fLBWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOBL/wFL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd62fa1f9so54267257b3.0
        for <netdev@vger.kernel.org>; Sun, 07 Apr 2024 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712482412; x=1713087212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4AkDKKXa6u5c7ipjuKU/32hkAU0asGsloRy15k55MM=;
        b=sOBL/wFLAxcHWYRl1/6AJ1AS78EDJL7fqIhxMR4bjuyKJ3vAQzscmLvUKQJJP2EsN1
         U6X/81etsHGa7XSnx3wjsneCnoP+iBjTTAql5yd8DlWlLzualy6WJG/id2M9DR1brn0u
         PPeH/WmwFl7nIuPArrg1arCLG1rPvse5jPFq3uDYyzgBycrLWCLS6z+60Y8WxOId7xUh
         d2ZrTKleWYf3IqWaMrZPkLO1j63aim6WbApT3/SrmdEUbBPUcJ4QUJ87NbzganxXlPKR
         BTXu9YrbHLOQifhg5QC2ySgBXpbXksz0tBpPglTvuICakDNDvMFwc4kVPpMQzRkCl752
         NNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712482412; x=1713087212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4AkDKKXa6u5c7ipjuKU/32hkAU0asGsloRy15k55MM=;
        b=PH63W67vHF/AnvsYksDur9UNErWRdfZCaxPCJPCGAjhbE53gRPFgTOdTT5j0yrgnqj
         t72FVjQ+DXjHtIhKr0CWz7K6N10WvjyR88vMAYAIAzcFtI+fAaeWAxZXdpSSGRoRF3mX
         sSRZ/3xOKpLt0x72JD2WgDrRGIwQAXrNMW1RhJv+8ODYUq8oVlOqNSFrgqcnIpijFI27
         wRRmI7DR0C3Ft3mn1YtJAWH6ys/eG1QaJkxdIKJW5Jq39fMtxAUHfDBpFRl5tELDmwqm
         YaQy/lsTvB0ZkMfy7M4Ab6cgw2NjA6HP3ulewC+iQNFASoWGtHBk0pU/zsG7zUoN+R+C
         u5nw==
X-Forwarded-Encrypted: i=1; AJvYcCUs+DX3kxacJKNef3k0YrIS56YTSVA34Wn7rL0aQizXUSyVdQnunyTJpgh+L5KpP3vO2dky0vnZSFC/eSCuuWLJGE3Z26Se
X-Gm-Message-State: AOJu0YxKHLIdZvRadpj/wz2Ag32GAhvdDGcYP1Ey+clyaeW3a4o3ylcl
	IH9Taf4Cktu0/mY0addp2hwb8tMhA7ZTfCjLF2AhgmrYbz/me22d0cMqTCoB1LBHzUUZ1sjrCUq
	mC7Yadr5s5w==
X-Google-Smtp-Source: AGHT+IHNe3QXMj2+7Kd3NsaJ3dzY+j8jMLeTPp+lCEApL7773PKof45L7i7eAc6Gto85BhnAtwyj7hG7E8PhRg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:102e:b0:de0:ecc6:87b with SMTP
 id x14-20020a056902102e00b00de0ecc6087bmr124086ybt.1.1712482411803; Sun, 07
 Apr 2024 02:33:31 -0700 (PDT)
Date: Sun,  7 Apr 2024 09:33:22 +0000
In-Reply-To: <20240407093322.3172088-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240407093322.3172088-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240407093322.3172088-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] tcp: replace TCP_SKB_CB(skb)->tcp_tw_isn with a
 per-cpu field
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP can transform a TIMEWAIT socket into a SYN_RECV one from
a SYN packet, and the ISN of the SYNACK packet is normally
generated using TIMEWAIT tw_snd_nxt :

tcp_timewait_state_process()
...
    u32 isn = tcptw->tw_snd_nxt + 65535 + 2;
    if (isn == 0)
        isn++;
    TCP_SKB_CB(skb)->tcp_tw_isn = isn;
    return TCP_TW_SYN;

This SYN packet also bypasses normal checks against listen queue
being full or not.

tcp_conn_request()
...
       __u32 isn = TCP_SKB_CB(skb)->tcp_tw_isn;
...
        /* TW buckets are converted to open requests without
         * limitations, they conserve resources and peer is
         * evidently real one.
         */
        if ((syncookies == 2 || inet_csk_reqsk_queue_is_full(sk)) && !isn) {
                want_cookie = tcp_syn_flood_action(sk, rsk_ops->slab_name);
                if (!want_cookie)
                        goto drop;
        }

This was using TCP_SKB_CB(skb)->tcp_tw_isn field in skb.

Unfortunately this field has been accidentally cleared
after the call to tcp_timewait_state_process() returning
TCP_TW_SYN.

Using a field in TCP_SKB_CB(skb) for a temporary state
is overkill.

Switch instead to a per-cpu variable.

As a bonus, we do not have to clear tcp_tw_isn in TCP receive
fast path.
It is temporarily set then cleared only in the TCP_TW_SYN dance.

Fixes: 4ad19de8774e ("net: tcp6: fix double call of tcp_v6_fill_cb()")
Fixes: eeea10b83a13 ("tcp: add tcp_v4_fill_cb()/tcp_v4_restore_cb()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h        | 10 +++++-----
 net/ipv4/tcp.c           |  3 +++
 net/ipv4/tcp_input.c     | 26 ++++++++++++++++----------
 net/ipv4/tcp_ipv4.c      |  5 +++--
 net/ipv4/tcp_minisocks.c |  4 ++--
 net/ipv6/tcp_ipv6.c      |  5 +++--
 6 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index fa0ab77acee23654b22e97615de983fc04eee319..ba6c5ae86e228a1633feaf39b0f1e053c3832b08 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -52,6 +52,8 @@ extern struct inet_hashinfo tcp_hashinfo;
 DECLARE_PER_CPU(unsigned int, tcp_orphan_count);
 int tcp_orphan_count_sum(void);
 
+DECLARE_PER_CPU(u32, tcp_tw_isn);
+
 void tcp_time_wait(struct sock *sk, int state, int timeo);
 
 #define MAX_TCP_HEADER	L1_CACHE_ALIGN(128 + MAX_HEADER)
@@ -392,7 +394,8 @@ enum tcp_tw_status {
 
 enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait_sock *tw,
 					      struct sk_buff *skb,
-					      const struct tcphdr *th);
+					      const struct tcphdr *th,
+					      u32 *tw_isn);
 struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req, bool fastopen,
 			   bool *lost_race);
@@ -935,13 +938,10 @@ struct tcp_skb_cb {
 	__u32		seq;		/* Starting sequence number	*/
 	__u32		end_seq;	/* SEQ + FIN + SYN + datalen	*/
 	union {
-		/* Note : tcp_tw_isn is used in input path only
-		 *	  (isn chosen by tcp_timewait_state_process())
-		 *
+		/* Note :
 		 * 	  tcp_gso_segs/size are used in write queue only,
 		 *	  cf tcp_skb_pcount()/tcp_skb_mss()
 		 */
-		__u32		tcp_tw_isn;
 		struct {
 			u16	tcp_gso_segs;
 			u16	tcp_gso_size;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 92ee60492314a1483cfbfa2f73d32fcad5632773..6cb5b9f74c94b72fec1d6a3cc8e6dc75bd61ba2f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -290,6 +290,9 @@ enum {
 DEFINE_PER_CPU(unsigned int, tcp_orphan_count);
 EXPORT_PER_CPU_SYMBOL_GPL(tcp_orphan_count);
 
+DEFINE_PER_CPU(u32, tcp_tw_isn);
+EXPORT_PER_CPU_SYMBOL_GPL(tcp_tw_isn);
+
 long sysctl_tcp_mem[3] __read_mostly;
 EXPORT_SYMBOL(sysctl_tcp_mem);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 48c275e6ef02bfc5dd98f0878c752841f949c714..5a45a0923a1f058cdc80255be0f76a71fd102d4d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7097,7 +7097,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		     struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_fastopen_cookie foc = { .len = -1 };
-	__u32 isn = TCP_SKB_CB(skb)->tcp_tw_isn;
 	struct tcp_options_received tmp_opt;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
@@ -7107,21 +7106,28 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	struct dst_entry *dst;
 	struct flowi fl;
 	u8 syncookies;
+	u32 isn;
 
 #ifdef CONFIG_TCP_AO
 	const struct tcp_ao_hdr *aoh;
 #endif
 
-	syncookies = READ_ONCE(net->ipv4.sysctl_tcp_syncookies);
+	isn = __this_cpu_read(tcp_tw_isn);
+	if (isn) {
+		/* TW buckets are converted to open requests without
+		 * limitations, they conserve resources and peer is
+		 * evidently real one.
+		 */
+		__this_cpu_write(tcp_tw_isn, 0);
+	} else {
+		syncookies = READ_ONCE(net->ipv4.sysctl_tcp_syncookies);
 
-	/* TW buckets are converted to open requests without
-	 * limitations, they conserve resources and peer is
-	 * evidently real one.
-	 */
-	if ((syncookies == 2 || inet_csk_reqsk_queue_is_full(sk)) && !isn) {
-		want_cookie = tcp_syn_flood_action(sk, rsk_ops->slab_name);
-		if (!want_cookie)
-			goto drop;
+		if (syncookies == 2 || inet_csk_reqsk_queue_is_full(sk)) {
+			want_cookie = tcp_syn_flood_action(sk,
+							   rsk_ops->slab_name);
+			if (!want_cookie)
+				goto drop;
+		}
 	}
 
 	if (sk_acceptq_is_full(sk)) {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 81e2f05c244d1671980a34bb756f528f3e6debcc..1e650ec71d2fe5198b9dad9e6ea9c5eaf868277f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2146,7 +2146,6 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 				    skb->len - th->doff * 4);
 	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
 	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
-	TCP_SKB_CB(skb)->tcp_tw_isn = 0;
 	TCP_SKB_CB(skb)->ip_dsfield = ipv4_get_dsfield(iph);
 	TCP_SKB_CB(skb)->sacked	 = 0;
 	TCP_SKB_CB(skb)->has_rxtstamp =
@@ -2168,6 +2167,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	bool refcounted;
 	struct sock *sk;
 	int ret;
+	u32 isn;
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (skb->pkt_type != PACKET_HOST)
@@ -2383,7 +2383,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		inet_twsk_put(inet_twsk(sk));
 		goto csum_error;
 	}
-	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th)) {
+	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn)) {
 	case TCP_TW_SYN: {
 		struct sock *sk2 = inet_lookup_listener(net,
 							net->ipv4.tcp_death_row.hashinfo,
@@ -2397,6 +2397,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 			sk = sk2;
 			tcp_v4_restore_cb(skb);
 			refcounted = false;
+			__this_cpu_write(tcp_tw_isn, isn);
 			goto process;
 		}
 	}
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 5b21a07ddf9aa5593d21cb856f0e0ea2f45b1eef..f53c7ada2ace4219917e75f806f39a00d5ab0123 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -95,7 +95,7 @@ static void twsk_rcv_nxt_update(struct tcp_timewait_sock *tcptw, u32 seq)
  */
 enum tcp_tw_status
 tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
-			   const struct tcphdr *th)
+			   const struct tcphdr *th, u32 *tw_isn)
 {
 	struct tcp_options_received tmp_opt;
 	struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
@@ -228,7 +228,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		u32 isn = tcptw->tw_snd_nxt + 65535 + 2;
 		if (isn == 0)
 			isn++;
-		TCP_SKB_CB(skb)->tcp_tw_isn = isn;
+		*tw_isn = isn;
 		return TCP_TW_SYN;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 5141f7033abd8bb03bc4e162066ca4befe343bdc..3aa9da5c9a669d2754b421cfb704ad28def5a748 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1741,7 +1741,6 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 				    skb->len - th->doff*4);
 	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
 	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
-	TCP_SKB_CB(skb)->tcp_tw_isn = 0;
 	TCP_SKB_CB(skb)->ip_dsfield = ipv6_get_dsfield(hdr);
 	TCP_SKB_CB(skb)->sacked = 0;
 	TCP_SKB_CB(skb)->has_rxtstamp =
@@ -1758,6 +1757,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	bool refcounted;
 	struct sock *sk;
 	int ret;
+	u32 isn;
 	struct net *net = dev_net(skb->dev);
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
@@ -1967,7 +1967,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		goto csum_error;
 	}
 
-	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th)) {
+	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn)) {
 	case TCP_TW_SYN:
 	{
 		struct sock *sk2;
@@ -1985,6 +1985,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 			sk = sk2;
 			tcp_v6_restore_cb(skb);
 			refcounted = false;
+			__this_cpu_write(tcp_tw_isn, isn);
 			goto process;
 		}
 	}
-- 
2.44.0.478.gd926399ef9-goog


