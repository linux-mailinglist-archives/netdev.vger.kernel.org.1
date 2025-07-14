Return-Path: <netdev+bounces-206808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DE9B0472A
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D7F1A611C9
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E3426CE27;
	Mon, 14 Jul 2025 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="yxr+68nQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BE726C3AD
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516572; cv=none; b=QtxU7n5R/G9VB1PlHxwCEDEDYEik4FKXGgPTxRiexEkbg6J4kosq6wIJ2sHnRnRfwjPXZf4eo/2gc+CGHOOM+w7RFaCGUV5ZJryhHE71uWs5SSSG6jolXRUtTF5kyUJrMn0EmYAW7K8+42fF3y2Llld0XRAFh1TRXDk2zuPgTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516572; c=relaxed/simple;
	bh=X2KBXE9XrAwenzh9ej9gHeOTHfpS4BCmkyXWHuVU1ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaBRjqu7BALQJIbwGsb/BwJpU8rsKgKAVveML4xG/MShL+oYLgVdHXwiIPPnLtWeIJ4PTueJ0MS4KGmF4XQLIEMAg4FC2rKvHjbj2sDHrulaCeR/ECtf9crTioeDWJZoCJyu8AGFh3bjq4GLsNHaJy8Jzv04BtOGl3bbF8bQRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=yxr+68nQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2369dd5839dso7380625ad.3
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516570; x=1753121370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0VjMzRhhkpd/1HKsTytas5+E+ZQEpUjMSfUPoDJGy4=;
        b=yxr+68nQmFGNDKNkAoRwqA25G1joayokD7HveLt/pOz1F/E4az4eTEodtjlAjsQQe5
         Zp1wIXBJti+K2w627jCjBH+tXPYJ7jAouxR8NH5/QdoBNqllNauzRGT3pBSvpaPK/ZrM
         GThlQNVomx8Eamw6AthcX5P0Bghvw7iYYA83NXbrnZcbidtkXPCBbh40KXpxidvB4Uk/
         5wkv1qk26pn979H4Fy/nDqoaxHgZn+1OHF95MyHHhCkgLqj5y5WBWC0XQEn8hHnCYaId
         knmITXAnKAPLo1L5LHPkQbS0rSdb7onECotzyh9ekOtEOzYIreoGHYNBYDUB1nvNJ4x3
         fMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516570; x=1753121370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0VjMzRhhkpd/1HKsTytas5+E+ZQEpUjMSfUPoDJGy4=;
        b=VDAaI/uJqXFeFBniPdRfujax2CCY8pujQn2S1dlU+nf32SYf3Pk6Fh/hMQTQNHcIl5
         Fqtv/gkW4ulTfk89GwrfXv7kbb8hzIkt4ht5nGdB5ESeT/KruIttorbnlstb91iNcJns
         mEPaka6YoIaXu6gGcX9Y5LHJMZZFouolqE5rHaqyAAsvpvP4HX10gzdWXoDhvvkHg4Ha
         0e3DwNkyHBxboN0F8U932n0x1nBj/WDDvmIUcSdzOlVLa2Yk/YXkd9NIiWKnbH/NtHHa
         ryYyZ9Iyq4E+I9jytmlHJTrgjWcpUmaOdXYuoI5xA92DZNbMRcyhb34xQnY3eW+yN1TS
         wdBw==
X-Gm-Message-State: AOJu0YxfmRhQjbtuLpc4cDJsdBGFPfgzyAtI24bUHo5HlKSRtXr1o9pM
	3XJwY/WG5f4JBJ9KN88CrlIMNlPfwMUC84JmOZI8qlGGKmIKNejGAUR/oSbIhkBVlGh/njMLUBM
	HHNrC
X-Gm-Gg: ASbGncvnmzZCcu4wjPGi3mzrQnjrzfKwvsUnk1bHUc6xawMZYAQUXaN6SQW0LD+CItB
	4A+CrHTbNGfNl3nTWUyYUO5fuB0Dnxm0UMXzyjGmKjvTfPE75DfyWN9ENdsYQqIxo363/VePrPl
	IhQq1NOascXvORVmZ3DcrzbHrNGLiRKj5JCK0WklQNsVFS/50fluKDo7gSHNBPZh1v4nqbJoMwU
	CqCxIgyFHBdvrOAgqRWXAZlIx3GVu+iYLUQ57/EtyMwuNxYdLTMDQQZp4oaFknyswtAd62YDHtJ
	dQkGdpbEEJosdsNgIfzSyty1LeVKfBuNg4jQ6nIj3oZPYBbKrbSsbEw0y2wgpFZyWh2fOq9HzxQ
	+4Ry3AEftol5/HAolgXy5
X-Google-Smtp-Source: AGHT+IFaANdEsoOI6JjsTYzHY0SHA3OpsGfJip9jrkWkfo0zHVFJilCf48S9mcy8YPg/UbIm4waBUQ==
X-Received: by 2002:a17:902:8bc9:b0:235:ee04:dd2e with SMTP id d9443c01a7336-23dede73cedmr70494245ad.10.1752516569653;
        Mon, 14 Jul 2025 11:09:29 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:29 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v6 bpf-next 02/12] bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
Date: Mon, 14 Jul 2025 11:09:06 -0700
Message-ID: <20250714180919.127192-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714180919.127192-1-jordan@jrife.io>
References: <20250714180919.127192-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Require that iter->batch always contains a full bucket snapshot. This
invariant is important to avoid skipping or repeating sockets during
iteration when combined with the next few patches. Before, there were
two cases where a call to bpf_iter_tcp_batch may only capture part of a
bucket:

1. When bpf_iter_tcp_realloc_batch() returns -ENOMEM.
2. When more sockets are added to the bucket while calling
   bpf_iter_tcp_realloc_batch(), making the updated batch size
   insufficient.

In cases where the batch size only covers part of a bucket, it is
possible to forget which sockets were already visited, especially if we
have to process a bucket in more than two batches. This forces us to
choose between repeating or skipping sockets, so don't allow this:

1. Stop iteration and propagate -ENOMEM up to userspace if reallocation
   fails instead of continuing with a partial batch.
2. Try bpf_iter_tcp_realloc_batch() with GFP_USER just as before, but if
   we still aren't able to capture the full bucket, call
   bpf_iter_tcp_realloc_batch() again while holding the bucket lock to
   guarantee the bucket does not change. On the second attempt use
   GFP_NOWAIT since we hold onto the spin lock.

I did some manual testing to exercise the code paths where GFP_NOWAIT is
used and where ERR_PTR(err) is returned. I used the realloc test cases
included later in this series to trigger a scenario where a realloc
happens inside bpf_iter_tcp_batch and made a small code tweak to force
the first realloc attempt to allocate a too-small batch, thus requiring
another attempt with GFP_NOWAIT. Some printks showed both reallocs with
the tests passing:

Jun 27 00:00:53 crow kernel: again GFP_USER
Jun 27 00:00:53 crow kernel: again GFP_NOWAIT
Jun 27 00:00:53 crow kernel: again GFP_USER
Jun 27 00:00:53 crow kernel: again GFP_NOWAIT

With this setup, I also forced each of the bpf_iter_tcp_realloc_batch
calls to return -ENOMEM to ensure that iteration ends and that the
read() in userspace fails.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/ipv4/tcp_ipv4.c | 109 +++++++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 32 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 2e40af6aff37..8dfb87be422e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3057,7 +3057,7 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 	if (!new_batch)
 		return -ENOMEM;
 
-	bpf_iter_tcp_put_batch(iter);
+	memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
 	kvfree(iter->batch);
 	iter->batch = new_batch;
 	iter->max_sk = new_batch_sz;
@@ -3066,69 +3066,95 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 }
 
 static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
-						 struct sock *start_sk)
+						 struct sock **start_sk)
 {
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
-	struct tcp_iter_state *st = &iter->state;
 	struct hlist_nulls_node *node;
 	unsigned int expected = 1;
 	struct sock *sk;
 
-	sock_hold(start_sk);
-	iter->batch[iter->end_sk++] = start_sk;
+	sock_hold(*start_sk);
+	iter->batch[iter->end_sk++] = *start_sk;
 
-	sk = sk_nulls_next(start_sk);
+	sk = sk_nulls_next(*start_sk);
+	*start_sk = NULL;
 	sk_nulls_for_each_from(sk, node) {
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
 				iter->batch[iter->end_sk++] = sk;
+			} else if (!*start_sk) {
+				/* Remember where we left off. */
+				*start_sk = sk;
 			}
 			expected++;
 		}
 	}
-	spin_unlock(&hinfo->lhash2[st->bucket].lock);
 
 	return expected;
 }
 
 static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
-						   struct sock *start_sk)
+						   struct sock **start_sk)
 {
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
-	struct tcp_iter_state *st = &iter->state;
 	struct hlist_nulls_node *node;
 	unsigned int expected = 1;
 	struct sock *sk;
 
-	sock_hold(start_sk);
-	iter->batch[iter->end_sk++] = start_sk;
+	sock_hold(*start_sk);
+	iter->batch[iter->end_sk++] = *start_sk;
 
-	sk = sk_nulls_next(start_sk);
+	sk = sk_nulls_next(*start_sk);
+	*start_sk = NULL;
 	sk_nulls_for_each_from(sk, node) {
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
 				iter->batch[iter->end_sk++] = sk;
+			} else if (!*start_sk) {
+				/* Remember where we left off. */
+				*start_sk = sk;
 			}
 			expected++;
 		}
 	}
-	spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
 
 	return expected;
 }
 
+static unsigned int bpf_iter_fill_batch(struct seq_file *seq,
+					struct sock **start_sk)
+{
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+
+	if (st->state == TCP_SEQ_STATE_LISTENING)
+		return bpf_iter_tcp_listening_batch(seq, start_sk);
+	else
+		return bpf_iter_tcp_established_batch(seq, start_sk);
+}
+
+static void bpf_iter_tcp_unlock_bucket(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+
+	if (st->state == TCP_SEQ_STATE_LISTENING)
+		spin_unlock(&hinfo->lhash2[st->bucket].lock);
+	else
+		spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
+}
+
 static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 {
 	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
 	struct tcp_iter_state *st = &iter->state;
 	unsigned int expected;
-	bool resized = false;
 	struct sock *sk;
+	int err;
 
 	/* The st->bucket is done.  Directly advance to the next
 	 * bucket instead of having the tcp_seek_last_pos() to skip
@@ -3145,33 +3171,52 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 		}
 	}
 
-again:
-	/* Get a new batch */
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
-	iter->st_bucket_done = false;
+	iter->st_bucket_done = true;
 
 	sk = tcp_seek_last_pos(seq);
 	if (!sk)
 		return NULL; /* Done */
 
-	if (st->state == TCP_SEQ_STATE_LISTENING)
-		expected = bpf_iter_tcp_listening_batch(seq, sk);
-	else
-		expected = bpf_iter_tcp_established_batch(seq, sk);
+	expected = bpf_iter_fill_batch(seq, &sk);
+	if (likely(iter->end_sk == expected))
+		goto done;
 
-	if (iter->end_sk == expected) {
-		iter->st_bucket_done = true;
-		return sk;
-	}
+	/* Batch size was too small. */
+	bpf_iter_tcp_unlock_bucket(seq);
+	bpf_iter_tcp_put_batch(iter);
+	err = bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
+					 GFP_USER);
+	if (err)
+		return ERR_PTR(err);
+
+	iter->cur_sk = 0;
+	iter->end_sk = 0;
+
+	sk = tcp_seek_last_pos(seq);
+	if (!sk)
+		return NULL; /* Done */
+
+	expected = bpf_iter_fill_batch(seq, &sk);
+	if (likely(iter->end_sk == expected))
+		goto done;
 
-	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
-						    GFP_USER)) {
-		resized = true;
-		goto again;
+	/* Batch size was still too small. Hold onto the lock while we try
+	 * again with a larger batch to make sure the current bucket's size
+	 * does not change in the meantime.
+	 */
+	err = bpf_iter_tcp_realloc_batch(iter, expected, GFP_NOWAIT);
+	if (err) {
+		bpf_iter_tcp_unlock_bucket(seq);
+		return ERR_PTR(err);
 	}
 
-	return sk;
+	expected = bpf_iter_fill_batch(seq, &sk);
+	WARN_ON_ONCE(iter->end_sk != expected);
+done:
+	bpf_iter_tcp_unlock_bucket(seq);
+	return iter->batch[0];
 }
 
 static void *bpf_iter_tcp_seq_start(struct seq_file *seq, loff_t *pos)
-- 
2.43.0


