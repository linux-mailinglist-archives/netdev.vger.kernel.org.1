Return-Path: <netdev+bounces-204626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414DCAFB7F3
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5466A3A2434
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A287215F56;
	Mon,  7 Jul 2025 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="zQ+MDreP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB14202F93
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903474; cv=none; b=IxKUecoAn6VAHhK5Za7SRhTfNmWJxNKC3gguKCkHW4Tw64/OCkcU0ZVFSWSx5i0o1TTnQrHdBDO2firitYesaGWdu5uwcJBApTgkNhrmV/q9G2faTF0aG3BLm+UUFYy0kjIKE5FAAUfPnu0ZmeKXJlS39sXiINJ08wwqKS9d8Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903474; c=relaxed/simple;
	bh=iojvmA1zH1Sj7ELLS6M+uvsE5gNKyzPPhzLZSXZRLLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk+kFeBzbEiVZU+LZhXh8x6ETdMc2W3O621O8gGsNyYUn4uIMgrHqc0B88wydphNS73RnHqnpxbGOtLrpYRMZHE1tEU1E3CWCAvyBwqTkcWgvP0D7l6RbkMShJnUTlBUBEl3kKyEHVpdbXOYAwYIDvemhgUhPm3BwsqR7UDm87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=zQ+MDreP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234d3103237so5561565ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 08:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903471; x=1752508271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOLPZareR6hnOCIL84CR8NCWnHYZ8Y7h4LQh3cKYu44=;
        b=zQ+MDrePlAe0TXb79At9g8JKPhh2tYCiDnW1+zjGyTsMfOAU2/2mEgZiLb9fkjwtjJ
         17WDj2yFLAEsHoIc5xtmz8J0nPiAuYGFIvhj3gjaiakchzpXVhbpjhIB+lPJx2iTwMty
         LFB4q7mMK+TRFo3txTRZzGlCBZhBb2dL67asUxx18f/sfVkrykGzfAJAd0Zo13X1aBoW
         ViqSDJuBU+9giKPeVeMaSUno88ptd8VEhOcJqJ5q2wKujNGFQG3jbmpqz3H6ieNLtZ18
         mt2i8ldnyLWBBEa8P1SVyzuMDvcvic9eyLNuPOvrdzJdKPCdOHw3qe0LhsVVlw3qQVRS
         MKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903471; x=1752508271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOLPZareR6hnOCIL84CR8NCWnHYZ8Y7h4LQh3cKYu44=;
        b=GLi6MFwXv3U4uiObNS3m3EOlQFDEHqL7tsBZC8BzIcNj01SG6M05N033x5uZCBiHiR
         weGSfXwwIcwawC1Pw2KUNTK1bpgDhI4TGV/K/2AMAez44GWK43kF82nh2Q8Jowi1ogaA
         yuwuHKSN0/JvDRsYJLz90O+g9THFzJLn5OlCNIFpezaUTehZIEjVS8UWmBS2FFB6vsl0
         nx01UT/Q0y8ESK+TWcZpyYl7mfxfulnx/mF53czpfvFSJD/jPdSTHXyIq2v2Rl2Te3cc
         dOxBdcPsKbvUYAVtWC/9adN1z8Hyt2MJpC3cSJPwmXETZy/IyyVEbznWiTc0mHc+6c4f
         k/Uw==
X-Gm-Message-State: AOJu0Yykq/hmpWSfElZ5Yfzsw/uxIz0lmZcs7hLkTUil/mS4ayKbwt5j
	4NBcXzdMx7+LqfcFz65k3zqewja27peqz972l7K4Oa/WVFxHEQOz4b59NE/r5qSd790DIZBDwbP
	WiGSB
X-Gm-Gg: ASbGnctuNOqvlPJSW3ENZ2L2H7dINRRO1MIczLRKV8qx1CJLxudnDl4UZ2pKtPUbn+t
	95LdG6a4CZh97sE3BQsnJcVpe2bdtVCR/ftR+1XY7zEZl1x3tXGQTs+Oi1VTAzvTaEnCyDTn1Rd
	dEiczhD03LYozjmSW+PYzrxQB75w84G0Nvu7wTUju5jMqg+b+idKtsSUsqozl5AQJ0/1YR0tMpE
	Mq4CEHdV3Jn6VqC08TZQ2e0Br2St+gLxx9RZJaJawTAnw0ChrYIDzZYxFp1ZpZiZ61bDotvRCDV
	/0sevT+a8DI3Gx6778Jx/sDQR8RF3fPaIcyU3/t02QeZaDQ2pHo=
X-Google-Smtp-Source: AGHT+IHUSmFmhYmpQ1iL1h0YjHAKL/ezcrit1L1j2c3LkoyQnYM44Wpud2Bo2pqHD0fUiY1HSDJg8w==
X-Received: by 2002:a17:902:f689:b0:234:d7b2:2abe with SMTP id d9443c01a7336-23c873b7648mr70148625ad.7.1751903470478;
        Mon, 07 Jul 2025 08:51:10 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:10 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 02/12] bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
Date: Mon,  7 Jul 2025 08:50:50 -0700
Message-ID: <20250707155102.672692-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707155102.672692-1-jordan@jrife.io>
References: <20250707155102.672692-1-jordan@jrife.io>
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
index 2e40af6aff37..565afaa1ea2f 100644
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
+done:
+	WARN_ON_ONCE(iter->end_sk != expected);
+	bpf_iter_tcp_unlock_bucket(seq);
+	return iter->batch[0];
 }
 
 static void *bpf_iter_tcp_seq_start(struct seq_file *seq, loff_t *pos)
-- 
2.43.0


