Return-Path: <netdev+bounces-199138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7ACADF29A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A4C4A32CA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91762F2362;
	Wed, 18 Jun 2025 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="VEs2nvQn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522EB2F0050
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263957; cv=none; b=mcj3128z5FB/ZyHb0HofjfkMI75yCMLFjyqrbXiWAV6OA9spKdCYPH6iEfXBBDKSJ3rPqU96UPezrNvpW69HazHbYmxsRCJYB/PtfF4O2bB4V4U2C83ZS2f2hZ7+Lcgrk67OYFac2fJf92VKJjsfzyfEaRHqSrylGRFdH9aE7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263957; c=relaxed/simple;
	bh=FOcUHNTpKxanwjKC5eDfYqm4hOoO4sD1M81ThFNCU5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg0X4kT8379Ef5c1PqfwLlobdBmmb3X0MVMKdSf15Gjmt0Ob+n0EP5P7bx3/k8MwNh6XHiTmiRZnU9WrYiRDFm8yY5tUXU0I2D7UUXk1x9RXxgddakdvBK33Yuguakf+YzuRc3Y94je5CHZiTmHkj+bACbhgBbbmF8mUBOw+//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=VEs2nvQn; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313dc7be67aso948805a91.0
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263954; x=1750868754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAuMzqm0JIrbgbPTkm58pDclP9IWfOkAF/9DsG83V1U=;
        b=VEs2nvQnL+/BOUFB/H2UUWgIvcc/jLpjiRtWtyBRGmCjRkglcSyDo00Lf1iBNHiSv0
         2gkthxdr/hvJdsGD7ovmar1siuf3vWyhgpGxU7wqPE9lKiqsNf4nSuj3wQQDRbVqJc6/
         fP/PfmjW8vUCjAbAJlFtM7vrt/JWNHLA1jXlUKhAWl/271pc0AJKhRkL2xDRVoqqLxUq
         DdHrk+8qt3M3/E29/08N5DHffvHBs3Z/uBpUSjUh+/T0QRCi1LdLW0B/onMvc2aTAJdx
         sTAw5THQ1q/D0P1W+iyLQq2b3dj76ldCuJD/LrJ9R1/ElxcjQ4ejO54AxMpQVnf5rObh
         wpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263954; x=1750868754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAuMzqm0JIrbgbPTkm58pDclP9IWfOkAF/9DsG83V1U=;
        b=BGXSmqXFR6qQF3nbuYucznI0+mll0Kg2jXqB82e7B40TOmKtosn1LiOxZkiHX4fVrJ
         7wL6+KIEhO3orPGLAWvcEy0UFEGibFaNhbYE8jcfKbF4GukPFSsYPxKPtn3YfcrhEn1l
         /KjV7NUHWH8iXxyGkD5gvfoFyREnESS6zWfST+VoiGYna38hQ9IxxtUQZZ6jZ7hf9By6
         u+c4gsYKubqjJwNBkqOOUJB8x20RBTTgGh4T7aMXkbh1OyN9d2YjgIMozRlq7JuzXTAy
         r5/iAM+oNGuQbOTZ7UkkN6tDJaL8YGIEEcCMZ7o3zYaRrmdwUqcHFD6nku2avRaeavZf
         8HEQ==
X-Gm-Message-State: AOJu0Yw1pyK1xlGjVvgmeZBjYICWxu/t8+JA8xKD0qK7hOqFX7uC5iei
	Ao7mNTojipeU/6xWtRqsEi+nFjpYSH4PNHSMyov5r4qqG3isqGGZs+9YbSwvig+s0QPMioGAmLt
	W9aWKbnM=
X-Gm-Gg: ASbGncvAzH5E9D47F4yB058a7CFJVAzlmoN1fUGuYa5iwf8cUUbTnlqDgvNEu7ijdx/
	I7aRno+TmYdBEZONe69hUQ+BnF+WDUg47HtIqa5lt9wbbufQ85gLZWMzN07CU8UOkWjlxfgfmeL
	iDbGtjJPwVUAgYipoQ1fcQyUEoPQ+8DSw8cLplwK/JyjyZGiVdzEtFcY6B4dsDCtUhV5zRySS9O
	RHqqnWYtvkvPeCwUrco5Ud2i8zcTNiAjfuoBddufcrK0WDBPm9hDlq5YsODHWbcA6BHht9t+Flj
	M1ekHY26Zjj9fE5kb5Pl8XBOJuBnZ4puq8B0TfhtG9PyjFDoe7GVojgaFGPn+g==
X-Google-Smtp-Source: AGHT+IGspeVbwxO1GvshrL/fWlIu2IAT+URdmUqfrqAPZ2ixKsSUFXa/APdjxaque6X9FQlW7q9ypg==
X-Received: by 2002:a17:90b:4c45:b0:313:2bfc:94c with SMTP id 98e67ed59e1d1-313f1e70849mr9943508a91.8.1750263954290;
        Wed, 18 Jun 2025 09:25:54 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:25:54 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 05/12] bpf: tcp: Avoid socket skips and repeats during iteration
Date: Wed, 18 Jun 2025 09:25:36 -0700
Message-ID: <20250618162545.15633-6-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618162545.15633-1-jordan@jrife.io>
References: <20250618162545.15633-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the offset-based approach for tracking progress through a bucket
in the TCP table with one based on socket cookies. Remember the cookies
of unprocessed sockets from the last batch and use this list to
pick up where we left off or, in the case that the next socket
disappears between reads, find the first socket after that point that
still exists in the bucket and resume from there.

This approach guarantees that all sockets that existed when iteration
began and continue to exist throughout will be visited exactly once.
Sockets that are added to the table during iteration may or may not be
seen, but if they are they will be seen exactly once.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/tcp_ipv4.c | 142 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 114 insertions(+), 28 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c51ac10fc351..f32adf0b7cf5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -58,6 +58,7 @@
 #include <linux/times.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/sock_diag.h>
 
 #include <net/net_namespace.h>
 #include <net/icmp.h>
@@ -3016,6 +3017,7 @@ static int tcp4_seq_show(struct seq_file *seq, void *v)
 #ifdef CONFIG_BPF_SYSCALL
 union bpf_tcp_iter_batch_item {
 	struct sock *sk;
+	__u64 cookie;
 };
 
 struct bpf_tcp_iter_state {
@@ -3046,10 +3048,19 @@ static int tcp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
 
 static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 {
+	union bpf_tcp_iter_batch_item *item;
 	unsigned int cur_sk = iter->cur_sk;
+	__u64 cookie;
 
-	while (cur_sk < iter->end_sk)
-		sock_gen_put(iter->batch[cur_sk++].sk);
+	/* Remember the cookies of the sockets we haven't seen yet, so we can
+	 * pick up where we left off next time around.
+	 */
+	while (cur_sk < iter->end_sk) {
+		item = &iter->batch[cur_sk++];
+		cookie = sock_gen_cookie(item->sk);
+		sock_gen_put(item->sk);
+		item->cookie = cookie;
+	}
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
@@ -3073,6 +3084,106 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 	return 0;
 }
 
+static struct sock *bpf_iter_tcp_resume_bucket(struct sock *first_sk,
+					       union bpf_tcp_iter_batch_item *cookies,
+					       int n_cookies)
+{
+	struct hlist_nulls_node *node;
+	struct sock *sk;
+	int i;
+
+	for (i = 0; i < n_cookies; i++) {
+		sk = first_sk;
+		sk_nulls_for_each_from(sk, node) {
+			if (cookies[i].cookie == atomic64_read(&sk->sk_cookie))
+				return sk;
+		}
+	}
+
+	return NULL;
+}
+
+static struct sock *bpf_iter_tcp_resume_listening(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+	unsigned int find_cookie = iter->cur_sk;
+	unsigned int end_cookie = iter->end_sk;
+	int resume_bucket = st->bucket;
+	struct sock *sk;
+
+	if (end_cookie && find_cookie == end_cookie)
+		++st->bucket;
+
+	sk = listening_get_first(seq);
+	iter->cur_sk = 0;
+	iter->end_sk = 0;
+
+	if (sk && st->bucket == resume_bucket && end_cookie) {
+		sk = bpf_iter_tcp_resume_bucket(sk, &iter->batch[find_cookie],
+						end_cookie - find_cookie);
+		if (!sk) {
+			spin_unlock(&hinfo->lhash2[st->bucket].lock);
+			++st->bucket;
+			sk = listening_get_first(seq);
+		}
+	}
+
+	return sk;
+}
+
+static struct sock *bpf_iter_tcp_resume_established(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+	unsigned int find_cookie = iter->cur_sk;
+	unsigned int end_cookie = iter->end_sk;
+	int resume_bucket = st->bucket;
+	struct sock *sk;
+
+	if (end_cookie && find_cookie == end_cookie)
+		++st->bucket;
+
+	sk = established_get_first(seq);
+	iter->cur_sk = 0;
+	iter->end_sk = 0;
+
+	if (sk && st->bucket == resume_bucket && end_cookie) {
+		sk = bpf_iter_tcp_resume_bucket(sk, &iter->batch[find_cookie],
+						end_cookie - find_cookie);
+		if (!sk) {
+			spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
+			++st->bucket;
+			sk = established_get_first(seq);
+		}
+	}
+
+	return sk;
+}
+
+static struct sock *bpf_iter_tcp_resume(struct seq_file *seq)
+{
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+	struct sock *sk = NULL;
+
+	switch (st->state) {
+	case TCP_SEQ_STATE_LISTENING:
+		sk = bpf_iter_tcp_resume_listening(seq);
+		if (sk)
+			break;
+		st->bucket = 0;
+		st->state = TCP_SEQ_STATE_ESTABLISHED;
+		fallthrough;
+	case TCP_SEQ_STATE_ESTABLISHED:
+		sk = bpf_iter_tcp_resume_established(seq);
+	}
+
+	return sk;
+}
+
 static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 						 struct sock **start_sk)
 {
@@ -3145,7 +3256,6 @@ static void bpf_iter_tcp_unlock_bucket(struct seq_file *seq)
 
 static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 {
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
 	struct tcp_iter_state *st = &iter->state;
 	int prev_bucket, prev_state;
@@ -3154,29 +3264,10 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	struct sock *sk;
 	int err;
 
-	/* The st->bucket is done.  Directly advance to the next
-	 * bucket instead of having the tcp_seek_last_pos() to skip
-	 * one by one in the current bucket and eventually find out
-	 * it has to advance to the next bucket.
-	 */
-	if (iter->end_sk && iter->cur_sk == iter->end_sk) {
-		st->offset = 0;
-		st->bucket++;
-		if (st->state == TCP_SEQ_STATE_LISTENING &&
-		    st->bucket > hinfo->lhash2_mask) {
-			st->state = TCP_SEQ_STATE_ESTABLISHED;
-			st->bucket = 0;
-		}
-	}
-
 again:
-	/* Get a new batch */
-	iter->cur_sk = 0;
-	iter->end_sk = 0;
-
 	prev_bucket = st->bucket;
 	prev_state = st->state;
-	sk = tcp_seek_last_pos(seq);
+	sk = bpf_iter_tcp_resume(seq);
 	if (!sk)
 		return NULL; /* Done */
 	if (st->bucket != prev_bucket || st->state != prev_state)
@@ -3245,11 +3336,6 @@ static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		 * meta.seq_num is used instead.
 		 */
 		st->num++;
-		/* Move st->offset to the next sk in the bucket such that
-		 * the future start() will resume at st->offset in
-		 * st->bucket.  See tcp_seek_last_pos().
-		 */
-		st->offset++;
 		sock_gen_put(iter->batch[iter->cur_sk++].sk);
 	}
 
-- 
2.43.0


