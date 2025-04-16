Return-Path: <netdev+bounces-183546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8B2A90FB2
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCA8446BB9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 23:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C38E24C085;
	Wed, 16 Apr 2025 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="nY7J7Q/A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8C024BCF5
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744846602; cv=none; b=Xwe+dGGBBwwpPeqVPhL6ZcE4/vNee9+J6PAgRm+2AhvrFenpi3wIOCAv4MFV16Uk/RAq9ntcndjlU0YV6M8g7el3LwbdqOLj+ANj4EHXPMv7GOaypJvRrE0xtU9QlnehHhoLoLkxOYFyiZkAH5WNMpDD0RsKq3CEXYL28XhV464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744846602; c=relaxed/simple;
	bh=bUFOWvMoUKJYHlZIdNMIysvu0TspbyBzFdL58cqcIIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCOyMf8iHua2Y9QhOAAZP0xHxKZDW+WK2d7+1WFFS9DkjrcP7NXlC1AoMG8iJmqRujoSXoT2rsFXjYamZ+dlGH5AeylOf6BnCyt4lozWSL0ix7iXLpKxLdbpyfRC9NuSBWwAzsi4QtwxdrhmcYVILxwC6/AP1dpjZiapJA8sJOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=nY7J7Q/A; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-301a8b7398cso30553a91.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744846600; x=1745451400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOFGCskrGuqxeuMelYkFo5dOAfEDvjGh2tyjWMV1Nwo=;
        b=nY7J7Q/AJ4aREuQAl40ZTGvoOJ1I13+2gZeLYWIgMzkOJq+XWUegdEBYYWDtlWXvK8
         +f4zKViX8k8sLAKLo/rf8VwoXT6xW4ffV4kWgPLW9wv4zgHXpwsenyn2SFMPkAFG8Flt
         6QlZDnDgviGT7m9l9VDXx6jb+vJlpAPN5YX/kZMzDlPl5T8AjSdzE1rvpHYnsVfAnfkx
         UrqA+hUjB2YeHH8xWr7PxxYKmVfxCwjcd8goePUxWnMXY3K4K7tTbkfQDtoimfvYfpd3
         5Xut8bJ073SGDJ7IV5r6T9LMx5bqlLuY8wNl/d9QArLKUwAl1l15SVAgHqllF7Hgr9GK
         7HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744846600; x=1745451400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOFGCskrGuqxeuMelYkFo5dOAfEDvjGh2tyjWMV1Nwo=;
        b=bPm3dPqQFR3Cw7fdbT/A2d71a+xXPxd0ucMP3FloBnEQ/Iwz2iI4VADGSGNGDj013m
         sKa52/537LM3XC3JEtilKzV3gkcF5xlQmzNA8aLWBVC8g3FAoj6bpbYOsT5tukxr2/mZ
         61Ll1yWi/Gv5AZBVr2Cu7Fh5kTSw3nWfuQH29QeFcYhqnEj0DdU254P0PzxUeU2GNSp1
         c24+Hn/UfzsnYVwfc3H79/FBy9t1/Vo02xiBoeQvAsB812/KMveufTN52qx9Ayi01hIw
         AkL7izyyHL9XqZUfiptnn5f8qrUbxIDAOEK4uZC/mEWni6j3bNHRhHMhghE9Xs7y2cOe
         z2LQ==
X-Gm-Message-State: AOJu0YxBN+m0TEhYftoNeDSMaLBU8HAZaqBn48E3EOxsnCVqOLjRRg2d
	DpDVG/dgVGny9TuVEQ8UUmIpEHGhIAQS9rXXkHhN7JgI09jTE7aVh2SQOxTmRhBwlkznoHuljXl
	aK9Q=
X-Gm-Gg: ASbGncvDVCNoNoMxRYKpay+Qyu/hBttC93x691lYpnR27NAGGpaAkx66H9ezbLV6R8i
	F9uUSLeAUtVmY853bfT3bxrWFdXKebcop0uST2C0m+md1NvLAvzoXlE6tsn3D9Kg1oMcKpt5YJ2
	BD9QZ949RspL9rjoXymPujRADc/NotVzisB8bGXdfwZztG6AXAqwVhB0Xqaw7211Ez7CYOlkOdH
	6KwMnlgj/FZM/na9GR8A5S4dKc+M4a7zCTdfw08N2rAiLFNJREoIkra6lWFSuw/rBkmnTuRILUl
	4h6yt/3XjUgmjP24dsPVXj2CKQIdFl24pCXW1rK5
X-Google-Smtp-Source: AGHT+IHNQgfjOgZH8VWVCeH/LSswEkVgEdCmHlJw0O+qgfADcxG7PTCeol9q9rtLEr8Fe0u3Y18uYg==
X-Received: by 2002:a17:90b:4c4c:b0:305:5f25:59ad with SMTP id 98e67ed59e1d1-3086d47823bmr783331a91.7.1744846599598;
        Wed, 16 Apr 2025 16:36:39 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:b7fc:bdc8:4289:858f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d6166sm2269251a91.7.2025.04.16.16.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 16:36:39 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v3 bpf-next 4/6] bpf: udp: Avoid socket skips and repeats during iteration
Date: Wed, 16 Apr 2025 16:36:19 -0700
Message-ID: <20250416233622.1212256-5-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416233622.1212256-1-jordan@jrife.io>
References: <20250416233622.1212256-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the offset-based approach for tracking progress through a bucket
in the UDP table with one based on socket cookies. Remember the cookies
of unprocessed sockets from the last batch and use this list to
pick up where we left off or, in the case that the next socket
disappears between reads, find the first socket after that point that
still exists in the bucket and resume from there.

In order to make the control flow a bit easier to follow inside
bpf_iter_udp_batch, introduce the udp_portaddr_for_each_entry_from macro
and use this to split bucket processing into two stages: finding the
starting point and adding items to the next batch. Originally, I
implemented this patch inside a single udp_portaddr_for_each_entry loop,
as it was before, but I found the resulting logic a bit messy. Overall,
this version seems more readable.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 include/linux/udp.h |  3 ++
 net/ipv4/udp.c      | 77 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 0807e21cfec9..a69da9c4c1c5 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -209,6 +209,9 @@ static inline void udp_allow_gso(struct sock *sk)
 #define udp_portaddr_for_each_entry(__sk, list) \
 	hlist_for_each_entry(__sk, list, __sk_common.skc_portaddr_node)
 
+#define udp_portaddr_for_each_entry_from(__sk) \
+	hlist_for_each_entry_from(__sk, __sk_common.skc_portaddr_node)
+
 #define udp_portaddr_for_each_entry_rcu(__sk, list) \
 	hlist_for_each_entry_rcu(__sk, list, __sk_common.skc_portaddr_node)
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index bcbee5cbb504..de698138bbe9 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -93,6 +93,7 @@
 #include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/slab.h>
+#include <linux/sock_diag.h>
 #include <net/tcp_states.h>
 #include <linux/skbuff.h>
 #include <linux/proc_fs.h>
@@ -3387,6 +3388,7 @@ struct bpf_iter__udp {
 
 union bpf_udp_iter_batch_item {
 	struct sock *sock;
+	__u64 cookie;
 };
 
 struct bpf_udp_iter_state {
@@ -3394,28 +3396,44 @@ struct bpf_udp_iter_state {
 	unsigned int cur_sk;
 	unsigned int end_sk;
 	unsigned int max_sk;
-	int offset;
 	union bpf_udp_iter_batch_item *batch;
 	bool st_bucket_done;
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 				      unsigned int new_batch_sz, int flags);
+static struct sock *bpf_iter_udp_resume(struct sock *first_sk,
+					union bpf_udp_iter_batch_item *cookies,
+					int n_cookies)
+{
+	struct sock *sk = NULL;
+	int i = 0;
+
+	for (; i < n_cookies; i++) {
+		sk = first_sk;
+		udp_portaddr_for_each_entry_from(sk)
+			if (cookies[i].cookie == atomic64_read(&sk->sk_cookie))
+				goto done;
+	}
+done:
+	return sk;
+}
+
 static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 {
 	struct bpf_udp_iter_state *iter = seq->private;
 	struct udp_iter_state *state = &iter->state;
+	unsigned int find_cookie, end_cookie = 0;
 	struct net *net = seq_file_net(seq);
 	int resizes = MAX_REALLOC_ATTEMPTS;
-	int resume_bucket, resume_offset;
 	struct udp_table *udptable;
 	unsigned int batch_sks = 0;
 	spinlock_t *lock = NULL;
+	int resume_bucket;
 	struct sock *sk;
 	int err = 0;
 
 	resume_bucket = state->bucket;
-	resume_offset = iter->offset;
 
 	/* The current batch is done, so advance the bucket. */
 	if (iter->st_bucket_done)
@@ -3431,6 +3449,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	 * before releasing the bucket lock. This allows BPF programs that are
 	 * called in seq_show to acquire the bucket lock if needed.
 	 */
+	find_cookie = iter->cur_sk;
+	end_cookie = iter->end_sk;
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
 	iter->st_bucket_done = false;
@@ -3442,21 +3462,29 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		if (hlist_empty(&hslot2->head))
 			goto next_bucket;
 
-		iter->offset = 0;
 		if (!lock) {
 			lock = &hslot2->lock;
 			spin_lock_bh(lock);
 		}
-		udp_portaddr_for_each_entry(sk, &hslot2->head) {
+		/* Initialize sk to the first socket in hslot2. */
+		sk = hlist_entry_safe(hslot2->head.first, struct sock,
+				      __sk_common.skc_portaddr_node);
+		/* Resume from the first (in iteration order) unseen socket from
+		 * the last batch that still exists in resume_bucket. Most of
+		 * the time this will just be where the last iteration left off
+		 * in resume_bucket unless that socket disappeared between
+		 * reads.
+		 *
+		 * Skip this if end_cookie isn't set; this is the first
+		 * batch, we're on bucket zero, and we want to start from the
+		 * beginning.
+		 */
+		if (state->bucket == resume_bucket && end_cookie)
+			sk = bpf_iter_udp_resume(sk,
+						 &iter->batch[find_cookie],
+						 end_cookie - find_cookie);
+		udp_portaddr_for_each_entry_from(sk) {
 			if (seq_sk_match(seq, sk)) {
-				/* Resume from the last iterated socket at the
-				 * offset in the bucket before iterator was stopped.
-				 */
-				if (state->bucket == resume_bucket &&
-				    iter->offset < resume_offset) {
-					++iter->offset;
-					continue;
-				}
 				if (iter->end_sk < iter->max_sk) {
 					sock_hold(sk);
 					iter->batch[iter->end_sk++].sock = sk;
@@ -3526,10 +3554,8 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	/* Whenever seq_next() is called, the iter->cur_sk is
 	 * done with seq_show(), so unref the iter->cur_sk.
 	 */
-	if (iter->cur_sk < iter->end_sk) {
+	if (iter->cur_sk < iter->end_sk)
 		sock_put(iter->batch[iter->cur_sk++].sock);
-		++iter->offset;
-	}
 
 	/* After updating iter->cur_sk, check if there are more sockets
 	 * available in the current bucket batch.
@@ -3599,8 +3625,19 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 
 static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
 {
-	while (iter->cur_sk < iter->end_sk)
-		sock_put(iter->batch[iter->cur_sk++].sock);
+	union bpf_udp_iter_batch_item *item;
+	unsigned int cur_sk = iter->cur_sk;
+	__u64 cookie;
+
+	/* Remember the cookies of the sockets we haven't seen yet, so we can
+	 * pick up where we left off next time around.
+	 */
+	while (cur_sk < iter->end_sk) {
+		item = &iter->batch[cur_sk++];
+		cookie = __sock_gen_cookie(item->sock);
+		sock_put(item->sock);
+		item->cookie = cookie;
+	}
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
@@ -3871,6 +3908,10 @@ static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 		return -ENOMEM;
 
 	bpf_iter_udp_put_batch(iter);
+	/* Make sure the new batch has the cookies of the sockets we haven't
+	 * visited yet.
+	 */
+	memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
 	kvfree(iter->batch);
 	iter->batch = new_batch;
 	iter->max_sk = new_batch_sz;
-- 
2.43.0


