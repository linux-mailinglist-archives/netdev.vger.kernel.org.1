Return-Path: <netdev+bounces-266476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEL6KuP7sGnCpQIAu9opvQ
	(envelope-from <netdev+bounces-266476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2018B25C608
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AA90307A127
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55446282F0C;
	Wed, 11 Mar 2026 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v92Fnx7W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FED30ACE6
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206446; cv=none; b=Yov3XDPGuABopInYHaWmf0YKzQBTRgRb/yF5Yuz0bMLwbujnNhqaQPqsHbfVNOZvMEkXctOi4Y1PSEPDh5run/8anoMZprTN6UAZMbAPa35tH9Dc/GFAiYFmvzcxyKLkFWWqfbmM6Kq98M/PCZHWbsnMo4mf856WeRA4tNU5qsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206446; c=relaxed/simple;
	bh=zMDUXntD2Nb6bVdkVodHnG9Vw42DjP53ndXkazSW+O0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rEdkKAaFjU7iccicEjKOx+UcrvOz7j492CLJ5d1l8dLnHKSu/sNDAgvbBI79jnfHensb17HmPDxZ6FIFtI0Q6YLIlW1VhGo1eZYZG2UPyKoqRCC7St7qV+3AwexhUoFlHKLtB4R/JSnGZe3//56rB/ZdzizvoFigHnEkOQv4C+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v92Fnx7W; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae4a6bb316so104312955ad.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206444; x=1773811244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3xe68LKkEdyA/bhBANHm4Wn8C11rnHsJOu2IZvlLFLQ=;
        b=v92Fnx7WPx8o0hhkdW7DksV0Mjo271ogmDPaJwIL1EXjy/cdiOCZKCYVwLLYkCAmYp
         Dnjsv7OaLZBn3MXkt7V/Hoj6eLTVhoQES/Hnw58FMOct4TOB6HQ4UeBbL6ubYLQ5XRZ/
         0YOVMEvFNJ7k5Mo5hZ2V1EHkQC1l6qnCbVRU6twC/z6zuH28BUvWmZscJXMB5HSCaChK
         Yyrzh3MhxyoI+yGt9rPpIS8YQQ47s3GU5/pdP09VZKBotzuFOz2wpw8IjdOEOOIIPmx1
         8hF9OMR3xPhcmEtUhXV9TBaHBWjCOx+RkaS/0fk9Mc/oG6OTDWJBY4w8K3vj5Yb7rTBx
         g0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206444; x=1773811244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xe68LKkEdyA/bhBANHm4Wn8C11rnHsJOu2IZvlLFLQ=;
        b=ELPfkdFdVm6A9EIJU4rQf4DpgD5CE2bkGZ6rL8Fc5Ta2qC7bXiTly4RC68Bu9GrfRJ
         7tAL9N1lW4lkMQeyXSeww18j/ZsDVCp7TSodIYYoIcK7g0oOKYE6eWMi0kshfsSwPhEs
         8nkoS12XVOangiwtiLDLXRThIfaCjeQPRwniOfxV3zDK/ip0T7bkFaaHLgtvKSgBI/sN
         ulzz4UNP4hfh3k8ydQqrqD4w1Fa+2BoF3N87YgWLPC/3qT4weMcVMzcakb6B3fbCjbRB
         n7h+gOhEwJKy3d7WiWEQwKmykrBnvVmoNzMN1Fm8nD+oh7U0shIX9EvrhZo0BAdbYGTV
         1dCg==
X-Forwarded-Encrypted: i=1; AJvYcCXjTz9PssMMpQdH7DwH30S5mylNNWjQ1K47VPZepGdNfoomOoV6zjh99qwPx1VGOKCwKFrboWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxArs+NQRUTSUByxF01dQFzb8NzeqgjJ84hKfTl3KYadYNr/SX1
	Q0NukNu1TDkkxZlQ7Tyu6lnTnFth/q/jkOkWQENqDBD5AH+yBIDtvRiT8w30QJxTEkEPM+I4IsO
	2nVGbxg==
X-Received: from pjqx13.prod.google.com ([2002:a17:90a:b00d:b0:359:86b9:176d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:558e:b0:359:f77f:8cd9
 with SMTP id 98e67ed59e1d1-35a00fb2391mr1285344a91.0.1773206444286; Tue, 10
 Mar 2026 22:20:44 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:19:58 +0000
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052020.1213705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-12-kuniyu@google.com>
Subject: [PATCH v3 net-next 11/15] udp: Remove udp_table in struct udp_seq_afinfo.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2018B25C608
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266476-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/udp.h |  1 -
 net/ipv4/udp.c    | 22 ++++------------------
 net/ipv6/udp.c    |  1 -
 3 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index bc275cda9f8c..76f401988353 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -552,7 +552,6 @@ static inline int copy_linear_skb(struct sk_buff *skb, int len, int off,
 #ifdef CONFIG_PROC_FS
 struct udp_seq_afinfo {
 	sa_family_t			family;
-	struct udp_table		*udp_table;
 };
 
 struct udp_iter_state {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a7ca727347ce..14b372b211be 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3193,21 +3193,8 @@ static bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
 
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
@@ -3215,7 +3202,7 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 	struct udp_table *udptable;
 	struct sock *sk;
 
-	udptable = udp_get_table_seq(seq, net);
+	udptable = net->ipv4.udp_table;
 
 	for (state->bucket = start; state->bucket <= udptable->mask;
 	     ++state->bucket) {
@@ -3247,7 +3234,7 @@ static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
 	} while (sk && !seq_sk_match(seq, sk));
 
 	if (!sk) {
-		udptable = udp_get_table_seq(seq, net);
+		udptable = net->ipv4.udp_table;
 
 		if (state->bucket <= udptable->mask)
 			spin_unlock_bh(&udptable->hash[state->bucket].lock);
@@ -3295,7 +3282,7 @@ void udp_seq_stop(struct seq_file *seq, void *v)
 	struct udp_iter_state *state = seq->private;
 	struct udp_table *udptable;
 
-	udptable = udp_get_table_seq(seq, seq_file_net(seq));
+	udptable = seq_file_net(seq)->ipv4.udp_table;
 
 	if (state->bucket <= udptable->mask)
 		spin_unlock_bh(&udptable->hash[state->bucket].lock);
@@ -3399,7 +3386,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	if (iter->cur_sk == iter->end_sk)
 		state->bucket++;
 
-	udptable = udp_get_table_seq(seq, net);
+	udptable = net->ipv4.udp_table;
 
 again:
 	/* New batch for the next bucket.
@@ -3637,7 +3624,6 @@ static const struct seq_operations udp_seq_ops = {
 
 static struct udp_seq_afinfo udp4_seq_afinfo = {
 	.family		= AF_INET,
-	.udp_table	= NULL,
 };
 
 static int __net_init udp4_proc_init_net(struct net *net)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 5bddbf457b61..eeb77363a556 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1872,7 +1872,6 @@ static const struct seq_operations udp6_seq_ops = {
 
 static struct udp_seq_afinfo udp6_seq_afinfo = {
 	.family		= AF_INET6,
-	.udp_table	= NULL,
 };
 
 int __net_init udp6_proc_init(struct net *net)
-- 
2.53.0.473.g4a7958ca14-goog


