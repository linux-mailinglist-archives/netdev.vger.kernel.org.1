Return-Path: <netdev+bounces-264023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOKeIsWIqGn2vQAAu9opvQ
	(envelope-from <netdev+bounces-264023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:32:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCB42071C7
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03DA5304200B
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D673DFC67;
	Wed,  4 Mar 2026 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIGE0x2W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB63E0C46
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652658; cv=none; b=FxzKvKtJDH/7ENM11+HlJtGVxfMUvNYfuN52ClJ+RR6z6tRFpekbLwEOh2QtaEqMnfv+iPok721IuhgJoZcCSOcwz3PWqwHGdDFiXRsTV36b+IsccHZ63X+6WYCLiZKOR8QhL2v8/vlsZzRdsyEg07ppRvT7B9aTxqwTWbLdTwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652658; c=relaxed/simple;
	bh=3hcuMHFJG6uPne7iYsMAsS3Y7tJIOtYfS/JZk5Cxy0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gPNPC8blhSVaJky7TUmHBsIdd/tuBccAc65Lko0NAE0/qhw6NqzUGDpuKzjpHFr4yGmJ7qJ10s0j5Yg4SOjSsTaYZ6CTAh+xFdMrQ51vfw9775rFNHnzsRExDwrKBEYAGdj5XfiEZGP6nNCJ+yeoW6v3Yb0vHpXEAgZ6wlsYiBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DIGE0x2W; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae59e057f1so37739075ad.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 11:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652655; x=1773257455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqfE372C3oK+paF7MDyEIjcB1BrKG5lriQHjGHFQwX4=;
        b=DIGE0x2WufI9SVJk4AOKlMoAdDT6me5WRtPMbL5aSWtwRFM+jPvEYtNHOf7Tfk1big
         uFInf12FxQpXU3nWPoahZKQuJOCoIAZZCqkyaDT/+dyTBTm2Q7GQRxDnwbIVX4X+acPK
         nNl/C4hIuJ42pNTaypk4MyltcEodeW+JpbxTBDwjM86lxjv2f//riqEPLD5IAB/7L4q1
         6yFNJMjWxKSrnwSTNzXy+OjmZfbequCZvIrFkAnNMB4ZI44mD9QAit6olVV+HLntwMIS
         ElBwjc3MktxGNIGNdq2DaqoetrkBT0zFaAyVELtN8UeChhjj+UU9PyrPaPeZC2fGqHs7
         EaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652655; x=1773257455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqfE372C3oK+paF7MDyEIjcB1BrKG5lriQHjGHFQwX4=;
        b=nW67z7HSgDQz2dy4Hy+Qrv1eA3QFVXM6OiFkMCvdB4/F6Nza27rfKIuYbYUdH+f6GU
         LE+pB7HXF+BN/McPdwW2dPS7zqKJz6fBfxom9wzfmuzj3ylBG+Z2MowZShiI2GJlzox4
         qfsBsUZEeSMagWHoTzlQ9lhsOllB0cA5vPj8PRKwlctDJc3VhD5DGHWJBmrayNpZeFQt
         SD7qar885nsQcI0UqcSIszldgVvq2sNxnY8eF/FKPpK2sC2CMUE4va7GYKxAMVJKcC7F
         PtVa+JS0AyXQVzjps9XuDMnKR9NL6MDF+tf7/AuOewp+D0nW/ijQSGbT/GF0Fv/r6tnx
         cUhw==
X-Forwarded-Encrypted: i=1; AJvYcCVHfDi0gTMsiOn0epgFbZzXD+SeJbOPfs2sXJEZzcLBYJfr9rtpgj3H0vajdSvKFhr35oYwaKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUFPcaezbYZ2yATE3aMkxEkLIvM4xZMEY3+DzY0cm/2JXdoNDx
	0qfDB8Skgjs83L/EJS040ZMhEiwl9Vk+b3y3feqP5kd4+WAtrGCGq4XHhhOPUDnVnpf3hnqFhpq
	OkDUjDA==
X-Received: from pjji8.prod.google.com ([2002:a17:90a:6508:b0:359:932a:2c65])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ace:b0:359:7ae5:89f0
 with SMTP id 98e67ed59e1d1-359a69adf3cmr2586372a91.6.1772652655189; Wed, 04
 Mar 2026 11:30:55 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:42 +0000
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-12-kuniyu@google.com>
Subject: [PATCH v1 net-next 11/15] udp: Remove udp_table in struct udp_seq_afinfo.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8CCB42071C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264023-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Since UDP and UDP-Lite had dedicated socket hash tables for
each, we have had to fetch them from different pointers for
procfs or bpf iterator.

UDP always has its global or per-netns table in
net->ipv4.udp_table and struct udp_seq_afinfo.udp_table
is NULL.

OTOH, UDP-Lite had only one global table in the pointer.

We no longer use the field.

Let's remove it and udp_get_table_seq().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/udp.h |  1 -
 net/ipv4/udp.c    | 22 ++++------------------
 net/ipv6/udp.c    |  1 -
 3 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 27c3c0c9cf7c..0279a2642c8f 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -551,7 +551,6 @@ static inline int copy_linear_skb(struct sk_buff *skb, int len, int off,
 #ifdef CONFIG_PROC_FS
 struct udp_seq_afinfo {
 	sa_family_t			family;
-	struct udp_table		*udp_table;
 };
 
 struct udp_iter_state {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index de8d55a9ea5d..6076e20f46f0 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3186,21 +3186,8 @@ static bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
 
 #ifdef CONFIG_BPF_SYSCALL
 static const struct seq_operations bpf_iter_udp_seq_ops;
-#endif
-static struct udp_table *udp_get_table_seq(struct seq_file *seq,
-					   struct net *net)
-{
-	const struct udp_seq_afinfo *afinfo;
-
-#ifdef CONFIG_BPF_SYSCALL
-	if (seq->op == &bpf_iter_udp_seq_ops)
-		return net->ipv4.udp_table;
 #endif
 
-	afinfo = pde_data(file_inode(seq->file));
-	return afinfo->udp_table ? : net->ipv4.udp_table;
-}
-
 static struct sock *udp_get_first(struct seq_file *seq, int start)
 {
 	struct udp_iter_state *state = seq->private;
@@ -3208,7 +3195,7 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 	struct udp_table *udptable;
 	struct sock *sk;
 
-	udptable = udp_get_table_seq(seq, net);
+	udptable = net->ipv4.udp_table;
 
 	for (state->bucket = start; state->bucket <= udptable->mask;
 	     ++state->bucket) {
@@ -3240,7 +3227,7 @@ static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
 	} while (sk && !seq_sk_match(seq, sk));
 
 	if (!sk) {
-		udptable = udp_get_table_seq(seq, net);
+		udptable = net->ipv4.udp_table;
 
 		if (state->bucket <= udptable->mask)
 			spin_unlock_bh(&udptable->hash[state->bucket].lock);
@@ -3288,7 +3275,7 @@ void udp_seq_stop(struct seq_file *seq, void *v)
 	struct udp_iter_state *state = seq->private;
 	struct udp_table *udptable;
 
-	udptable = udp_get_table_seq(seq, seq_file_net(seq));
+	udptable = seq_file_net(seq)->ipv4.udp_table;
 
 	if (state->bucket <= udptable->mask)
 		spin_unlock_bh(&udptable->hash[state->bucket].lock);
@@ -3392,7 +3379,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	if (iter->cur_sk == iter->end_sk)
 		state->bucket++;
 
-	udptable = udp_get_table_seq(seq, net);
+	udptable = net->ipv4.udp_table;
 
 again:
 	/* New batch for the next bucket.
@@ -3630,7 +3617,6 @@ const struct seq_operations udp_seq_ops = {
 
 static struct udp_seq_afinfo udp4_seq_afinfo = {
 	.family		= AF_INET,
-	.udp_table	= NULL,
 };
 
 static int __net_init udp4_proc_init_net(struct net *net)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index abbea5bcbd6f..54b5a92b04d0 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1873,7 +1873,6 @@ static const struct seq_operations udp6_seq_ops = {
 
 static struct udp_seq_afinfo udp6_seq_afinfo = {
 	.family		= AF_INET6,
-	.udp_table	= NULL,
 };
 
 int __net_init udp6_proc_init(struct net *net)
-- 
2.53.0.473.g4a7958ca14-goog


