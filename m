Return-Path: <netdev+bounces-174783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6A0A605FC
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 00:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEBF170688
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 23:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8622139D4;
	Thu, 13 Mar 2025 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZyhkKXaA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696E21FE443
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908982; cv=none; b=feTDyq98dlIBE+5TKMtlchbRiAmVW/BGskSX8UIVGFQU6128xIjOl00aP4bRCdLzPP8Zv81WEXu1UHM8an8V0Hfv9mniRTXSBTay4PM7N+JdARk3Et3Vg7uPAlPSGvxzIAvJ4G4+w8IGXYqy2y08chZaRp1IQ2V6GSDi31D6BP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908982; c=relaxed/simple;
	bh=pDqx/oBd4EkxVRGrbsc8//FAwklwDKmmwxtAokH5X40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FanQ0y05BJ1z0SJ/EmGSBrheKyC1jEfyikKBCNqwiSaHin9v4gfh6Sd5BRNG7pfnZITWrTcB7wGxoSarMwwOKZUTCQEg4hGll77cK5OAH9GKINJh2b4XFTQsop/Z4rFz/yZ4En2qD4d/166zWmMagyXSHTyXvSpYPSRgFh+vaYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZyhkKXaA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso4025653a91.2
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 16:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741908980; x=1742513780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLnFFEgXuV02S88NGJhDng33QYC4VcTtXVXim4Kjqkw=;
        b=ZyhkKXaAGLvmRwnD6bUdf5g0PjdMvZg8rku29lvkA8+3ruFbILbldw2iTlw7dHOpjs
         lVoupTvVXFgEwiwfDci7lYjceW7Ihd/MbMTIbWIbH98WGEc/IkzSvthyj6gLYBLMDFmK
         Df55hoqLLBhylow+NCTaX6lfem0UDALKX+AovM43Ghnawm0Y1ilpUtoquHRMaxjPl65U
         bruuJ1eOcQXwVnnicl/uvQBlJVBvssrNZXdhNWIw6DCroA4xssmcGXpKaMs1Xu43g1AW
         t+M+sck3f7Ifit6UCrY+O6fRPtHkF8DqWrwau2GVM2jxla3JVPxbUggmBQzFIh+dDsvy
         O86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741908980; x=1742513780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLnFFEgXuV02S88NGJhDng33QYC4VcTtXVXim4Kjqkw=;
        b=tP/MD2TfayIar9Q4VOOXawG6mXmx89uo7szrkr0HIvHetG4dQSvNpkCagFF7cCyWmG
         NjcGABWneRShh8hBIo/8CW+HbAsVjQbnjSFD/5ygH2Lgid2EbXXWUGwmr0bevXuLvGZ/
         UyF48LEVG+YQbeRP7pVqviuBV+fmMxvKbRtvgzBDBQs0ei5+icwaMSFWGK6aDWYRT1o4
         otKbv0rz0mwFlXbCaSNA3T2DJY2AaLS1vsiEhjv3o6SKxkihRhvcZseBPrF3SLaqj/dX
         Rs56izaojLCgL1dhOKJApPhbgbKXkNHMcapEKfIIEmrC5IAL6DrvKYhgsxDorlc1JZX0
         ZGkQ==
X-Gm-Message-State: AOJu0YzSye85EwCgiXyZF/qNDxwySrqxL1d9ydSq5od6nTkOvRvJqRj4
	Vpun0jcyVvMTqn16zRz4QrEB77YUeqldxAaHWPKdBgfXHzqQCZ6OwvvFdBRDsDzeG/m1T0dS/XO
	/d3Z10mpn7exx7270PuofM94NnhAZ7XUGX8u4hhirq7yWsCoYPFXS++wxXsfFBykXNowI3Ud27K
	5qGvNfQdOOLh4ZJfYS7niUNI33rHM=
X-Google-Smtp-Source: AGHT+IHCQe+x5Ig6/+JG4qWJq6nfvhnp/R8Ca+8RPm3mEv2B7nL0yruekONFz6MBhh9E1zQzaUnrAbPiLw==
X-Received: from pjbsp12.prod.google.com ([2002:a17:90b:52cc:b0:2ff:5516:6add])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc4d:b0:2fa:1851:a023
 with SMTP id 98e67ed59e1d1-30151d65226mr427988a91.35.1741908979675; Thu, 13
 Mar 2025 16:36:19 -0700 (PDT)
Date: Thu, 13 Mar 2025 23:35:25 +0000
In-Reply-To: <20250313233615.2329869-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313233615.2329869-1-jrife@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250313233615.2329869-2-jrife@google.com>
Subject: [RFC PATCH bpf-next 1/3] bpf: udp: Avoid socket skips during iteration
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

Replace the offset-based approach for tracking progress through a bucket
in the UDP table with one based on unique, monotonically increasing
index numbers associated with each socket in a bucket.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 include/net/sock.h |  2 ++
 include/net/udp.h  |  1 +
 net/ipv4/udp.c     | 38 +++++++++++++++++++++++++-------------
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8036b3b79cd8..b11f43e8e7ec 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -228,6 +228,7 @@ struct sock_common {
 		u32		skc_window_clamp;
 		u32		skc_tw_snd_nxt; /* struct tcp_timewait_sock */
 	};
+	__s64			skc_idx;
 	/* public: */
 };
 
@@ -378,6 +379,7 @@ struct sock {
 #define sk_incoming_cpu		__sk_common.skc_incoming_cpu
 #define sk_flags		__sk_common.skc_flags
 #define sk_rxhash		__sk_common.skc_rxhash
+#define sk_idx			__sk_common.skc_idx
 
 	__cacheline_group_begin(sock_write_rx);
 
diff --git a/include/net/udp.h b/include/net/udp.h
index 6e89520e100d..9398561addc6 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -102,6 +102,7 @@ struct udp_table {
 #endif
 	unsigned int		mask;
 	unsigned int		log;
+	atomic64_t		ver;
 };
 extern struct udp_table udp_table;
 void udp_table_init(struct udp_table *, const char *);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a9bb9ce5438e..d7e9b3346983 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -229,6 +229,11 @@ static int udp_reuseport_add_sock(struct sock *sk, struct udp_hslot *hslot)
 	return reuseport_alloc(sk, inet_rcv_saddr_any(sk));
 }
 
+static inline __s64 udp_table_next_idx(struct udp_table *udptable, bool pos)
+{
+	return (pos ? 1 : -1) * atomic64_inc_return(&udptable->ver);
+}
+
 /**
  *  udp_lib_get_port  -  UDP/-Lite port lookup for IPv4 and IPv6
  *
@@ -244,6 +249,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 	struct udp_hslot *hslot, *hslot2;
 	struct net *net = sock_net(sk);
 	int error = -EADDRINUSE;
+	bool add_tail;
 
 	if (!snum) {
 		DECLARE_BITMAP(bitmap, PORTS_PER_CHAIN);
@@ -335,14 +341,16 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 
 		hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
 		spin_lock(&hslot2->lock);
-		if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
-		    sk->sk_family == AF_INET6)
+		add_tail = IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
+			   sk->sk_family == AF_INET6;
+		if (add_tail)
 			hlist_add_tail_rcu(&udp_sk(sk)->udp_portaddr_node,
 					   &hslot2->head);
 		else
 			hlist_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
 					   &hslot2->head);
 		hslot2->count++;
+		sk->sk_idx = udp_table_next_idx(udptable, add_tail);
 		spin_unlock(&hslot2->lock);
 	}
 
@@ -2250,6 +2258,8 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 				hlist_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
 							 &nhslot2->head);
 				nhslot2->count++;
+				sk->sk_idx = udp_table_next_idx(udptable,
+								false);
 				spin_unlock(&nhslot2->lock);
 			}
 
@@ -3390,9 +3400,9 @@ struct bpf_udp_iter_state {
 	unsigned int cur_sk;
 	unsigned int end_sk;
 	unsigned int max_sk;
-	int offset;
 	struct sock **batch;
 	bool st_bucket_done;
+	__s64 prev_idx;
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
@@ -3402,14 +3412,13 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	struct bpf_udp_iter_state *iter = seq->private;
 	struct udp_iter_state *state = &iter->state;
 	struct net *net = seq_file_net(seq);
-	int resume_bucket, resume_offset;
 	struct udp_table *udptable;
 	unsigned int batch_sks = 0;
 	bool resized = false;
+	int resume_bucket;
 	struct sock *sk;
 
 	resume_bucket = state->bucket;
-	resume_offset = iter->offset;
 
 	/* The current batch is done, so advance the bucket. */
 	if (iter->st_bucket_done)
@@ -3436,18 +3445,19 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		if (hlist_empty(&hslot2->head))
 			continue;
 
-		iter->offset = 0;
 		spin_lock_bh(&hslot2->lock);
+		/* Reset prev_idx if this is a new bucket. */
+		if (!resume_bucket || state->bucket != resume_bucket)
+			iter->prev_idx = 0;
 		udp_portaddr_for_each_entry(sk, &hslot2->head) {
 			if (seq_sk_match(seq, sk)) {
-				/* Resume from the last iterated socket at the
-				 * offset in the bucket before iterator was stopped.
+				/* Resume from the first socket that we didn't
+				 * see last time around.
 				 */
 				if (state->bucket == resume_bucket &&
-				    iter->offset < resume_offset) {
-					++iter->offset;
+				    iter->prev_idx &&
+				    sk->sk_idx <= iter->prev_idx)
 					continue;
-				}
 				if (iter->end_sk < iter->max_sk) {
 					sock_hold(sk);
 					iter->batch[iter->end_sk++] = sk;
@@ -3492,8 +3502,9 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * done with seq_show(), so unref the iter->cur_sk.
 	 */
 	if (iter->cur_sk < iter->end_sk) {
-		sock_put(iter->batch[iter->cur_sk++]);
-		++iter->offset;
+		sk = iter->batch[iter->cur_sk++];
+		iter->prev_idx = sk->sk_idx;
+		sock_put(sk);
 	}
 
 	/* After updating iter->cur_sk, check if there are more sockets
@@ -3740,6 +3751,7 @@ static struct udp_table __net_init *udp_pernet_table_alloc(unsigned int hash_ent
 	udptable->hash2 = (void *)(udptable->hash + hash_entries);
 	udptable->mask = hash_entries - 1;
 	udptable->log = ilog2(hash_entries);
+	atomic64_set(&udptable->ver, 0);
 
 	for (i = 0; i < hash_entries; i++) {
 		INIT_HLIST_HEAD(&udptable->hash[i].head);
-- 
2.49.0.rc1.451.g8f38331e32-goog


