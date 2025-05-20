Return-Path: <netdev+bounces-191917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275EBABDE50
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9854E42B4
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CB8251780;
	Tue, 20 May 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="eiAbKu7b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D32500D0
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752686; cv=none; b=tHcvElkLaVfEN5A0XjWVXjvHHNK78MK2CUvvKyQIiSgS64xwYKK12xRGQT3co3jqe1jeq8OnUPLMOSAgEmoOOU6HYT7MGNDQA/oJWIrZruTi5NPV6yY7Enrficnyyg+1x1qXZLXwzwZivvhPH2JOWCgXQQrsXk53+07nZnZxKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752686; c=relaxed/simple;
	bh=xZu5RU2xfj+1Aq7W0zcY6ATmiERad9rGxbidxZ660DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=He4GGxBN6sMndSa7qSwW8WXyFtYmVPRHe3mqZO2s5vJ2tRJc2+5wKNwEapS2WQ3aCPCKSS27O8G4KjoqvBMQkDiflVtSerav9Z8n0hEgTYOIH0BYA9jnlS+wBbxxWtwQmS5a/VPZYXqxUDP1KRTXLMUt/8M6bwzglY7Q3KAFuhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=eiAbKu7b; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b16c64b8cbcso776817a12.3
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752683; x=1748357483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiNOin0yXrgmbQh3M6mcP6qo/GnxNy6CjxwraKGp1Pg=;
        b=eiAbKu7bTATDCT7fXIuupY3Gz0Dn75Ma/oLoile4eB5Aky5ikXJjckkbRARjZJ5RVA
         6tV7x55soiV8fseKYfO1cFSwq/V2O1r6nuikphThlQlJKIcfvk6q/8kCpacq1VhvLMIb
         jt33N93wAoOAeN0I+bZ3hFxn1haQs09OEmjKZKxfNtEMJNVBMZMuM+RDXEYUK52QW2gM
         z7JLF38QAaaRtWowIvGa0DmJ9YZjEb+k1qse5KnjD0d4LIhisiaLAdnktpU4zdAPWLRH
         LmeI6I30Y6VZ3VyYFldTXOUxcjnJzTvWXLug14UyQbLz+QBQp0Q5BZCJpK6fI1DxX8xt
         /XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752683; x=1748357483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiNOin0yXrgmbQh3M6mcP6qo/GnxNy6CjxwraKGp1Pg=;
        b=WHuBw52qALeWH0J+InFlH0ycCM/1NiOZ8ByQJTctySy8v/nGaSKp8R9b7qMIuPMJt5
         hkUcT92ssN7FlxCD/Wzb4iKnfcIiNakX4gNLuXin4wBZjNkMj/xMcUR6r9+kujqZLuq6
         EBUIsALlJn52YuFIQj/R+udl9n7ptSJymCABpz7Xyq0ukE3xPgQ3mKgw9iaUoI8wDGKw
         fbV/5SsYyFi4iNqUPO2ucamKAs2VHneUoIuwwxr8l8q6KmBl2xvr52cYDIB6uJm9wVmi
         LurxDFe5BKcKOveNHxpuYhcAQc0yJZ323MYcO7UwS4LMpZpoRdSaihQS2P9vAopLnLmc
         f/Jw==
X-Gm-Message-State: AOJu0YwSq7VlMW0unYl9mNE6qCYghY6b6QrS4jhE06snix6sWRR+eVct
	gcM/hgxQb+iyvlm9nrTHT3uAmB/XEzt7GUAgFotgYsSV5OhdU4XzsxEyLQno0iSxzx9caUccb3R
	ZJqkw1FI=
X-Gm-Gg: ASbGncvEZCw6vFN5597vLiztrvrTHU+tEPZ3kJ/Alabs9DynVYL4Zm+d0uGIoqRgZTl
	m3bac9CDU/Hx59ue0qo2p46xLjaKxtlM87MmzFIrvmzVTSSV5qzmUTHBqH2rVDsWeGzXYErnl0M
	VDwWKV4n059G808XuNKvPe2vlq/ubzoYM22ysne4VYkomNU8Xx4YbJxQYROSUN6Nj2KENeGD3sl
	u+2E/ecIG80+7djVnGHxGxQccrqt8d1YZr1j1rP36aTVBOinSvGp3XXvwie3E9hrsdZGFx1wtw4
	TRikhdxi14zm9CzIkahn58OUIJGkw4nNbW4cRB4AWIESJCfuw4I=
X-Google-Smtp-Source: AGHT+IEoQscaEAOdJ8oK/Qm91KK83Hb6Wp4IA0C4W5LVAzQclLDYqyIzPFGbQplJo+iM2yDkElNzKg==
X-Received: by 2002:a05:6a21:8cc4:b0:1f3:4439:658d with SMTP id adf61e73a8af0-2162187d535mr9347671637.2.1747752682789;
        Tue, 20 May 2025 07:51:22 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:22 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 05/10] bpf: tcp: Avoid socket skips and repeats during iteration
Date: Tue, 20 May 2025 07:50:52 -0700
Message-ID: <20250520145059.1773738-6-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520145059.1773738-1-jordan@jrife.io>
References: <20250520145059.1773738-1-jordan@jrife.io>
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

Remove the conditional that advances the bucket at the top of
bpf_iter_tcp_batch, since if iter->cur_sk == iter->end_sk
bpf_iter_tcp_resume_listening or bpf_iter_tcp_resume_established will
naturally advance to the next bucket without wasting any time scanning
through the current bucket.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/tcp_ipv4.c | 141 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 113 insertions(+), 28 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 65569d67d8bf..11531ed4ef3c 100644
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
@@ -3073,6 +3084,105 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
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
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+	struct sock *sk = NULL;
+
+	switch (st->state) {
+	case TCP_SEQ_STATE_LISTENING:
+		if (st->bucket > hinfo->lhash2_mask)
+			break;
+		sk = bpf_iter_tcp_resume_listening(seq);
+		if (sk)
+			break;
+		st->bucket = 0;
+		st->state = TCP_SEQ_STATE_ESTABLISHED;
+		fallthrough;
+	case TCP_SEQ_STATE_ESTABLISHED:
+		if (st->bucket > hinfo->ehash_mask)
+			break;
+		sk = bpf_iter_tcp_resume_established(seq);
+	}
+
+	return sk;
+}
+
 static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 						 struct sock **start_sk)
 {
@@ -3145,7 +3255,6 @@ static void bpf_iter_tcp_unlock_bucket(struct seq_file *seq)
 
 static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 {
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
 	struct tcp_iter_state *st = &iter->state;
 	int prev_bucket, prev_state;
@@ -3154,29 +3263,10 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
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
@@ -3245,11 +3335,6 @@ static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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


