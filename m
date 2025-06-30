Return-Path: <netdev+bounces-202607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8BCAEE57A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00B217C2F9
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532082951DD;
	Mon, 30 Jun 2025 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="O9v5b9zh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF028FAA7
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303852; cv=none; b=czvnfwNSrZru5oY2iwOZxibjTeHsPAGRsfPuKeeknmd9KIidS6ZiGW7C6vbjqljiTSxYYl43b0105xRJaGlW1/IF0AFTkZ/7GxZZ8OQDVaaKQvALqYI1kNzLqBTRLuE/nxnthCLYAz6PFVzgjoZzRnNz/NYvLIUMYbbW+AkN/8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303852; c=relaxed/simple;
	bh=uFg860jgBa1CCx3URnUWxMdzDUBmAts04pJV3xrxRdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1E8il6/kmCaV5g8k40Jwhz3HWuvLTqUppteBEE3YfPO/9Qhx9do6cfwVrxtprPGvVsc4jdKg/4JzGBVSo7zKUo0qteDTuj61w//oN02UeNdxbgB9Yqfy77tB11SFuASBpd6XonL1gi95wt6NodwFf3M9Z8OfmQROryP7CZP7hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=O9v5b9zh; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7493d4e0d01so356295b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303850; x=1751908650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg9R+0kjsks1pm+eNryfWrzkAfBZb+uHz/z8/dtczJs=;
        b=O9v5b9zh6QspCQzetaQbcrDi6PF8GDw32TYMWh6x4JlDOjXGZvY6eV8WtVTFajZilQ
         NSJVkpcL8W5q/UoM4b493RvxlnqI7teK6cwxTc+0GpQY5YgRBhCyGYZk7VtGHXwpilgG
         m8344/noZGdY8jAl8jzOcIkkS2AlPIUHJlzgm80g6OzM4UCM1OR3a7rFoeLsokWpPdfn
         MVzK7f1JTGOOPxR3cJo5rF6Zp5uBBuPURPEpEy7GBDW1/klZsF+Ii0t6dEQhnUtMX5HM
         gQpOvlxA0HunjcDX53qvA41spvYFWRb1rFbfL2t01ZnVKjG/UXQS0FNjdWjfGMMul0EO
         vwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303850; x=1751908650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gg9R+0kjsks1pm+eNryfWrzkAfBZb+uHz/z8/dtczJs=;
        b=Fw67qnBkkqKRXxDSEofhn56YQxNvOA60tQ/1bkW3awGLR+KNbEBZbwH95ocnn/HTQu
         qMoWJdSi+jcDM2dS8jtzdJP0Xn3ZTclIzg+xADcFfh/VPTXSf8PEZVE+aDRoJxexMQkH
         0JnciOJKqWkGmWOK0Rwp40nbibpeJXlaW/sYerJJmLeBcte1m7Cgx7x+8WPXVZv4Yn+y
         QSMZR4ozuvPSORJPkIPKvt1JRqBCgjqDqSXwXbcFkB165y+u6NsVI+lgEwRpKUi3Xp2Q
         0qc1aTCmFhF6sTstrBrG4N5oI1wiRXW3mRopyTUrc9OaWiRZp2MskwmzcEsF7WX/5Zsi
         o+9Q==
X-Gm-Message-State: AOJu0YzkH2vsfw0FcMYFecpx37utCWuCqc8r9A2JgD/CDNlxksNEUbYg
	IjUq+4jSgghW89DdcXle+kvSazi62EOL3h+vXSn+86Pl/BWmlE0xK/qqp3KETzctRqm/ykkjo1h
	wfZ6aTRs=
X-Gm-Gg: ASbGnctji80Ziw6veXHmUzkcLPzbcxtIWu/nC941mKG3J/mTTY+VohW/m3Glqw7m8i0
	fDwZ9B01p9dE/E/DH84TQm/esAT+Yric+N1vb9zpb3z8foIL0oO04oVMLSDOVaXmppD52cn+0I+
	sP6ZW4VxAzttojA/OjeF3SFkEyBuRwKEj/AsUSenbKVu2v+0hYsvLUs6InLmuFpFydyw/ysWHlO
	MZRYcQFM5gDUn4sJDeAOJFjjHm9XcwbbZjF4PVf60o7VY3DBakeA32V2hlRvk82443464CE/i/l
	0M0l5yLmDwgAkxhUkf//HFJYFsTqV/NhMUsQ9DojESPbwqSxtw==
X-Google-Smtp-Source: AGHT+IGC6GuoAcpADUmP3sBz6di8PVjt7JEQoyj4QJ170bKSBZAZqnKxT08EWxnD/TjUKRG2O96QRQ==
X-Received: by 2002:a05:6a00:870e:b0:73e:2b50:426 with SMTP id d2e1a72fcca58-74b0a633326mr3701571b3a.4.1751303849691;
        Mon, 30 Jun 2025 10:17:29 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:29 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 02/12] bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
Date: Mon, 30 Jun 2025 10:16:55 -0700
Message-ID: <20250630171709.113813-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630171709.113813-1-jordan@jrife.io>
References: <20250630171709.113813-1-jordan@jrife.io>
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


