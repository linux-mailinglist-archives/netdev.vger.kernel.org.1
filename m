Return-Path: <netdev+bounces-174784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6D7A60600
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 00:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA9F7AE32B
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 23:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07D81FDE01;
	Thu, 13 Mar 2025 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDhtPhcV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3FF1FDE19
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908983; cv=none; b=iLsLImeUYY4IosNfmFBI8pKj3IMpok4+KRdJn6tn5ZNN9vvTcZucttUN8YlfvEHdWQA1r8+2WoNtz7C6nilSBgc/YE+ys3p26HxGt8u4cL11Ng2Z1hwD+6NXD3BqBVvMslwZxMD7kSRuqoiOByGcx/Gw722oFRXXxvrJAq2JC/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908983; c=relaxed/simple;
	bh=MEKI3VBnIur5t+UOWEUKJ3aasrnKw4wV31ERHLuUEng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FEYaRjVkhInEM+h8id8u8Z5Sd1r3oxefGeqtsstFG6CFF3/3NhCju1oDxEGbXE2ULVOQn0rbKPpSsRu/UC7SYplQkgb4lEm+CBqWNEcLcDtFBr0dz+/BhdqxtK2RDE0tU5KIj6mf1bMAvLmzD9raKOdCeb0SyjewOrzAojQ0rnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDhtPhcV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-223477ba158so41620195ad.0
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 16:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741908981; x=1742513781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGB+lOhCdqUZGn3xMYzsRRLShpHA743cfsiVh9w/5P8=;
        b=MDhtPhcV9SdhMWrMfko2KmGx1IwkeUaXwjOhcNSs9PUxtUMBOFcbxsYVhwMwHTgrhm
         FzNgC4YmKWf44vSMlXzYeJWvhBQb+37WrOkSErEgW+dx+PWDA2uM088P6Z5Lu1PusLUe
         A+uuhvwSiJVo/sktKJiUmgbrc0sW2uGeyFL2q/ReGcfbNgrjF9m5cAg+MZiTZbGBKqqK
         dfUDkYFfFgACxvBzPNejHJKUUBEfZqv2TadSgH9MOaEFHEcUSu4w31/dCm1nspfVcwRn
         ukqHLyHTt4YnCeIo75b44UtzLnOXSBpwugraZ+qNcDd+/ZHuBVRTNkX5XqiK7MKgMV0m
         dGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741908981; x=1742513781;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGB+lOhCdqUZGn3xMYzsRRLShpHA743cfsiVh9w/5P8=;
        b=lh2dhfTTQ/bMwDH3NnqndbEe758p7W511g0PsRGUiz9zHMiZvUlqziDTFB3tKSyt3u
         8uKSAowXeWKsldiXT+WV3Oc6PJE3Y6ZnLWaUEWt9llI+U4oDJ6z6gvxael57a6pCDU96
         IwDC5++e9i3efWtz+NtYYOAqCAlLBYnCEl1Xalu42oPxSTXz+Va2aNfT5hmYpUsuERXA
         fsTF5LaQlmm6YXhSXgTjPJiuISLH3vqO+KXmgUEvP4bwt5B2g2Bd4vCI3nFKCHsZsMaO
         LOovPkntdxxGp/7usw6aGb7jWOABN5mwYbbhs0DYA8flo8xOAVDtEt2gVlpG7PdUhmBp
         eGCQ==
X-Gm-Message-State: AOJu0Yws3eS/Ut1IXXwiKy3rYM49NuyUO2DDrnE1dLDOOD7LAqmpvXsO
	aLKzjpJOdzQt6nYNvtiZWE9DrMEcufdDENuu2J0gN/RzfShbax6q4XAR9loO4EnJEXcR9LaL6lp
	m1ndsTZnRw0tluMz708uKRvGzXzy6eOIAQTYmdTflsZO2KKkvKqnn2//rmeN2o4oxyqmcB5HRr4
	F8WPcvZya7mSCwH9ZzbxMRgVvioXM=
X-Google-Smtp-Source: AGHT+IE8gqQd2I6kG5u2tuh9cZNViDDzIsiyVIfJ7jYqIJC09AKhDccVCQzJSq7lJ9vGCq1nl1N7rRNwAQ==
X-Received: from pfjt14.prod.google.com ([2002:a05:6a00:21ce:b0:725:e4b6:901f])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1402:b0:736:73ad:365b
 with SMTP id d2e1a72fcca58-737223c0336mr419765b3a.14.1741908981193; Thu, 13
 Mar 2025 16:36:21 -0700 (PDT)
Date: Thu, 13 Mar 2025 23:35:26 +0000
In-Reply-To: <20250313233615.2329869-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313233615.2329869-1-jrife@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250313233615.2329869-3-jrife@google.com>
Subject: [RFC PATCH bpf-next 2/3] bpf: tcp: Avoid socket skips during iteration
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

Replace the offset-based approach for tracking progress through a bucket
in the TCP table with one based on unique, monotonically increasing
index numbers associated with each socket in a bucket.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 include/net/inet_hashtables.h |  2 ++
 include/net/tcp.h             |  3 ++-
 net/ipv4/inet_hashtables.c    | 18 +++++++++++++++---
 net/ipv4/tcp.c                |  1 +
 net/ipv4/tcp_ipv4.c           | 29 ++++++++++++++++-------------
 5 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 5eea47f135a4..c95d3b1da199 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -172,6 +172,8 @@ struct inet_hashinfo {
 	struct inet_listen_hashbucket	*lhash2;
 
 	bool				pernet;
+
+	atomic64_t			ver;
 } ____cacheline_aligned_in_smp;
 
 static inline struct inet_hashinfo *tcp_or_dccp_get_hashinfo(const struct sock *sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2d08473a6dc0..499acd6da35f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2202,7 +2202,8 @@ struct tcp_iter_state {
 	struct seq_net_private	p;
 	enum tcp_seq_states	state;
 	struct sock		*syn_wait_sk;
-	int			bucket, offset, sbucket, num;
+	int			bucket, sbucket, num;
+	__s64			prev_idx;
 	loff_t			last_pos;
 };
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 9bfcfd016e18..bc9f58172790 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -534,6 +534,12 @@ struct sock *__inet_lookup_established(const struct net *net,
 }
 EXPORT_SYMBOL_GPL(__inet_lookup_established);
 
+static inline __s64 inet_hashinfo_next_idx(struct inet_hashinfo *hinfo,
+					   bool pos)
+{
+	return (pos ? 1 : -1) * atomic64_inc_return(&hinfo->ver);
+}
+
 /* called with local bh disabled */
 static int __inet_check_established(struct inet_timewait_death_row *death_row,
 				    struct sock *sk, __u16 lport,
@@ -581,6 +587,7 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
 	sk->sk_hash = hash;
 	WARN_ON(!sk_unhashed(sk));
 	__sk_nulls_add_node_rcu(sk, &head->chain);
+	sk->sk_idx = inet_hashinfo_next_idx(hinfo, false);
 	if (tw) {
 		sk_nulls_del_node_init_rcu((struct sock *)tw);
 		__NET_INC_STATS(net, LINUX_MIB_TIMEWAITRECYCLED);
@@ -678,8 +685,10 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 			ret = false;
 	}
 
-	if (ret)
+	if (ret) {
 		__sk_nulls_add_node_rcu(sk, list);
+		sk->sk_idx = inet_hashinfo_next_idx(hashinfo, false);
+	}
 
 	spin_unlock(lock);
 
@@ -729,6 +738,7 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 {
 	struct inet_hashinfo *hashinfo = tcp_or_dccp_get_hashinfo(sk);
 	struct inet_listen_hashbucket *ilb2;
+	bool add_tail;
 	int err = 0;
 
 	if (sk->sk_state != TCP_LISTEN) {
@@ -747,11 +757,13 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 			goto unlock;
 	}
 	sock_set_flag(sk, SOCK_RCU_FREE);
-	if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
-		sk->sk_family == AF_INET6)
+	add_tail = IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
+		   sk->sk_family == AF_INET6;
+	if (add_tail)
 		__sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
 	else
 		__sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
+	sk->sk_idx = inet_hashinfo_next_idx(hashinfo, add_tail);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 unlock:
 	spin_unlock(&ilb2->lock);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 285678d8ce07..63693af0c05c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5147,6 +5147,7 @@ void __init tcp_init(void)
 
 	cnt = tcp_hashinfo.ehash_mask + 1;
 	sysctl_tcp_max_orphans = cnt / 2;
+	atomic64_set(&tcp_hashinfo.ver, 0);
 
 	tcp_init_mem();
 	/* Set per-socket limits to no more than 1/128 the pressure threshold */
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 2632844d2c35..d0ddb307e2a1 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2602,7 +2602,7 @@ static void *listening_get_first(struct seq_file *seq)
 	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct tcp_iter_state *st = seq->private;
 
-	st->offset = 0;
+	st->prev_idx = 0;
 	for (; st->bucket <= hinfo->lhash2_mask; st->bucket++) {
 		struct inet_listen_hashbucket *ilb2;
 		struct hlist_nulls_node *node;
@@ -2637,7 +2637,7 @@ static void *listening_get_next(struct seq_file *seq, void *cur)
 	struct sock *sk = cur;
 
 	++st->num;
-	++st->offset;
+	st->prev_idx = sk->sk_idx;
 
 	sk = sk_nulls_next(sk);
 	sk_nulls_for_each_from(sk, node) {
@@ -2658,7 +2658,6 @@ static void *listening_get_idx(struct seq_file *seq, loff_t *pos)
 	void *rc;
 
 	st->bucket = 0;
-	st->offset = 0;
 	rc = listening_get_first(seq);
 
 	while (rc && *pos) {
@@ -2683,7 +2682,7 @@ static void *established_get_first(struct seq_file *seq)
 	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct tcp_iter_state *st = seq->private;
 
-	st->offset = 0;
+	st->prev_idx = 0;
 	for (; st->bucket <= hinfo->ehash_mask; ++st->bucket) {
 		struct sock *sk;
 		struct hlist_nulls_node *node;
@@ -2714,7 +2713,7 @@ static void *established_get_next(struct seq_file *seq, void *cur)
 	struct sock *sk = cur;
 
 	++st->num;
-	++st->offset;
+	st->prev_idx = sk->sk_idx;
 
 	sk = sk_nulls_next(sk);
 
@@ -2763,8 +2762,8 @@ static void *tcp_seek_last_pos(struct seq_file *seq)
 {
 	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct tcp_iter_state *st = seq->private;
+	__s64 prev_idx = st->prev_idx;
 	int bucket = st->bucket;
-	int offset = st->offset;
 	int orig_num = st->num;
 	void *rc = NULL;
 
@@ -2773,18 +2772,21 @@ static void *tcp_seek_last_pos(struct seq_file *seq)
 		if (st->bucket > hinfo->lhash2_mask)
 			break;
 		rc = listening_get_first(seq);
-		while (offset-- && rc && bucket == st->bucket)
+		while (rc && bucket == st->bucket && prev_idx &&
+		       ((struct sock *)rc)->sk_idx <= prev_idx)
 			rc = listening_get_next(seq, rc);
 		if (rc)
 			break;
 		st->bucket = 0;
+		prev_idx = 0;
 		st->state = TCP_SEQ_STATE_ESTABLISHED;
 		fallthrough;
 	case TCP_SEQ_STATE_ESTABLISHED:
 		if (st->bucket > hinfo->ehash_mask)
 			break;
 		rc = established_get_first(seq);
-		while (offset-- && rc && bucket == st->bucket)
+		while (rc && bucket == st->bucket && prev_idx &&
+		       ((struct sock *)rc)->sk_idx <= prev_idx)
 			rc = established_get_next(seq, rc);
 	}
 
@@ -2807,7 +2809,7 @@ void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
 	st->state = TCP_SEQ_STATE_LISTENING;
 	st->num = 0;
 	st->bucket = 0;
-	st->offset = 0;
+	st->prev_idx = 0;
 	rc = *pos ? tcp_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 
 out:
@@ -2832,7 +2834,7 @@ void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		if (!rc) {
 			st->state = TCP_SEQ_STATE_ESTABLISHED;
 			st->bucket = 0;
-			st->offset = 0;
+			st->prev_idx = 0;
 			rc	  = established_get_first(seq);
 		}
 		break;
@@ -3124,7 +3126,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	 * it has to advance to the next bucket.
 	 */
 	if (iter->st_bucket_done) {
-		st->offset = 0;
+		st->prev_idx = 0;
 		st->bucket++;
 		if (st->state == TCP_SEQ_STATE_LISTENING &&
 		    st->bucket > hinfo->lhash2_mask) {
@@ -3192,8 +3194,9 @@ static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		 * the future start() will resume at st->offset in
 		 * st->bucket.  See tcp_seek_last_pos().
 		 */
-		st->offset++;
-		sock_gen_put(iter->batch[iter->cur_sk++]);
+		sk = iter->batch[iter->cur_sk++];
+		st->prev_idx = sk->sk_idx;
+		sock_gen_put(sk);
 	}
 
 	if (iter->cur_sk < iter->end_sk)
-- 
2.49.0.rc1.451.g8f38331e32-goog


