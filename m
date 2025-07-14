Return-Path: <netdev+bounces-206812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E40B0472C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577F97A3BE0
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACDF26E713;
	Mon, 14 Jul 2025 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Ba0ybpCE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E926D4D4
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516576; cv=none; b=Try+RNpBe8DIs5ZiwcSIwdlATh7HXJ6iFh06oPWOdVS/YCr8P3lIWpN5yc75R74KiN/7IZt5DYJSbOFfzz3bKIdiz92RQnaazLjhrL4MNXcsYnVSym39qgAS+WhkRStUDUwSIQld1CmFThf/JFdCVS6HBEn13qadtdpFPTg8uJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516576; c=relaxed/simple;
	bh=sYWOZm0Nj5UMgVSXgPrhl24dBpDGgP/k5g9bt0RwTvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skoX9reIXT/CfR/RsfGVZV6SA7xzigB6HMvry628eJtyDvtcZfoHZMmeF4i+u2cYMP0pgEE0WiF43q5/k352+R3j3WruQbQ9jahP0ghKWxfN3WvVoU6Kzplw97APjR2E17hYcO1rCidrzikXTD8baFv7d+GnMp3GgCPKLpgLNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Ba0ybpCE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234d3103237so7591895ad.0
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516573; x=1753121373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pm7urr0OP6gNh2yXnRhBw1Qil6TmuRhdcNIhBL7LwuI=;
        b=Ba0ybpCEdODs9xKo4PWfzxT8Fb4yIgnZsp+vdgd9UTGJOAwR/RIWdKDWxJ50qs6m8M
         lrAtCUURZNEof0alKfCryPgOBPc4I2a3nlZbLr3KtO1gIbHp7Fkm0Yx5R86wg8r+9zp2
         lHURv0HsB1A4y0wwW3mKttCmPpZKrP43EIlA1abQswwLU59oBkKfGr3kB8BjKuR73W7i
         Nr5mWFPG8IXk2EXVdhuu+qn4UH6zD2jf9pzCp6oY9HT5F9gOC/eVT6RtlAw59Hps1wyZ
         SV+n578oHb6WPhIExwqf8dJyLwBva5BdXlQUMM8rXj06/Pk+tB3bkeDC+gbgLDPQdq72
         jwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516573; x=1753121373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pm7urr0OP6gNh2yXnRhBw1Qil6TmuRhdcNIhBL7LwuI=;
        b=ilNgsSqqVzRDOg21702cSrL4hWGZ9WUiLVqnU29GyVzuFcq2yl7A+mMKw4O17a650A
         HefT07XR7auXlmNzbJWA5hhQvg5o0UfmA3/2FoAw294Mc/UKtpauiJALvVpSyEsKyypT
         NIffLsxTIdeSlAjjCFjFFzkaL+sMxx4YyzF9JJ6/cgUbiBM4K5rEUMgQarizmrzIIH3t
         9Zmwx3cZSq7zAtA7icuQSmqPA/6gv02GlGmEy+7sCmiufWm45sqgSunqovcLR/NVcs3Z
         RTeQoRf5bLdL+3gNk3russVbVvYSVbucH/KVHzWYUGrvcpq5ypZ5cyP127JOLWenCu4i
         5jPQ==
X-Gm-Message-State: AOJu0YwAxbyDajwS9w/61DidAg7+gZctJWjR1jMfDae7xQFiG7e2mPYy
	b+0Y3prr/D2+uuGzzUmPgQpw/J91eNrkodcTaWXeJTQ6DvKn91Fla/nHP0Uxy4G4vOQG++u1dDj
	qEupC
X-Gm-Gg: ASbGncs0rjdZnco7GqEzA31ItZJydPA5b+iwGb/4k4NvvMc/ki0TY5O4khQ5ueo79So
	yz/AOAPv4DsDLTEmxVsHOid7lYx+SESA5p9knGzoHCBgfgP7ZxIoYPlSpeo/ki/BA8NzID7GQ0q
	Ij1ZH2r82pLpfxqJlK/ltxSTNkzAssm7cv4kftz6q9xP1rttMOXPy7OlkihBI1pHUp+fl4JlwML
	ilSvx8frTYZDqcO4Ya+eZhOytPJZM8F0rMB10q03u0SFFX37RHTD1VuZjBg4oWBMx73j3k7npzX
	qHy/JdZ2XWEcBBoszITbpjOCgqWNTg0Z/lEQAmo8z1kXHkerG1k7NOmW2BD0mQvwyVUCvMALuqn
	zor9CJLhDjw==
X-Google-Smtp-Source: AGHT+IG1n91wxdihHRG1I0MKWuD/B7YxZSNCVwUhv9byS5DYUAZl49AvKI1q1a6AX+P6NsXXpyBAzw==
X-Received: by 2002:a17:902:d4cc:b0:234:db06:acf with SMTP id d9443c01a7336-23def8a5a3fmr72678885ad.2.1752516573177;
        Mon, 14 Jul 2025 11:09:33 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:32 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 05/12] bpf: tcp: Avoid socket skips and repeats during iteration
Date: Mon, 14 Jul 2025 11:09:09 -0700
Message-ID: <20250714180919.127192-6-jordan@jrife.io>
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
 net/ipv4/tcp_ipv4.c | 147 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 115 insertions(+), 32 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d2128a2b33bc..48c0ad77cc0f 100644
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
@@ -3070,6 +3081,106 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
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
+		sk_nulls_for_each_from(sk, node)
+			if (cookies[i].cookie == atomic64_read(&sk->sk_cookie))
+				return sk;
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
+		break;
+	}
+
+	return sk;
+}
+
 static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 						 struct sock **start_sk)
 {
@@ -3154,32 +3265,12 @@ static void bpf_iter_tcp_unlock_bucket(struct seq_file *seq)
 
 static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 {
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
-	struct tcp_iter_state *st = &iter->state;
 	unsigned int expected;
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
-	iter->cur_sk = 0;
-	iter->end_sk = 0;
-
-	sk = tcp_seek_last_pos(seq);
+	sk = bpf_iter_tcp_resume(seq);
 	if (!sk)
 		return NULL; /* Done */
 
@@ -3195,10 +3286,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	if (err)
 		return ERR_PTR(err);
 
-	iter->cur_sk = 0;
-	iter->end_sk = 0;
-
-	sk = tcp_seek_last_pos(seq);
+	sk = bpf_iter_tcp_resume(seq);
 	if (!sk)
 		return NULL; /* Done */
 
@@ -3250,11 +3338,6 @@ static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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


