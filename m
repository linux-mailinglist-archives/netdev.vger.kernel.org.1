Return-Path: <netdev+bounces-264565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFEeHAz7qWlcJAEAu9opvQ
	(envelope-from <netdev+bounces-264565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:52:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B29218ACB
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1206530517FB
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FA035F8C9;
	Thu,  5 Mar 2026 21:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhrVy4gZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39C359A9C
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747439; cv=none; b=g9LOTcrqNWxqgX4lXvs4IneN1HSMJ3Gxp4W41vEBjp3OFxJs82funwgmcFgOU1Q/r4kVLvpv7f5YfeMVe4xCcD3eh0nNkhqvTVc+3ivOCoWO21DWHMQMD0y1lb6NGzt73iD8uU7HkMSpMtR5Me1DulHa1fowI5QbQSpFasJH2wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747439; c=relaxed/simple;
	bh=0+RBZIIT4xNtm0VK8KDNkl1yqh8vRw5GXINFi+V1fg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oWzRYul2OFNiYfGIKc7cblBG/Do+MXZJJCoBOeX/Y+3h5+o6HtSBPOR5q9rajlYRThs6Nb0rSzYRDY40OReE4icasFhcVyiA7EqzDnQuv9lwULsPJPZo/IiXHG5oAsKpmaGDBWkdHPfrb+OWqSwbGCF1xabc6A95epZItqUF9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hhrVy4gZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3597baf976dso19089000a91.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 13:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772747437; x=1773352237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kiQ7I2q18ZKIQGyW7V/mY93CrUJa2g7aGuYgsTqsfzg=;
        b=hhrVy4gZ4nF/Btn8UxzULOuRyUPlsolOezOpb6kb9VWbQysdf4ARBCGEleNtFeOBTI
         7PIRBOp2tEZ8ZM3qEuL4MlEj35DfuUMMl2bc6+kqaq3ZpzKwQK8HAEW1GxeFy6Sii/Ib
         BevbYBBAXWsPxDeoOFGneFwUSAgxKf81QXjvQLvM/o19LOici003Bs8kvSozithVwL4Y
         34HUiqfx15qC22gW5nv6dccQBy9MeZJzrg9HBFPgYpEmABd9OnFklYe28adUDIRs06ZA
         15xyqT+aJ99GUUh8CJTsXtk3qQqpFbmTNjlhzzk+AZmIZsqOjaU1X/6+BSHUY6DhMsL0
         GqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747437; x=1773352237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiQ7I2q18ZKIQGyW7V/mY93CrUJa2g7aGuYgsTqsfzg=;
        b=L5xyxUsVbdSc8W1VkuJDAVSrMOncGCeknPALSGO5/S5mUqi6cwTfkUhOs6trToihRe
         QGu5b+V14QAjr9fgCUXmVpFvwCvIGSht7Zd/jrDaB06ZUtNt2HJpMaHNcRsmYAjjEwuC
         6NbCxYxSdAR5YM/0VvlGeGHgOTGwVe7WTkv5dFFomEUopqrstHgPwk39f5oYlNIbFlfL
         vGqi0htG4TA2e6SnLbvi787RzscXz6yIzYiJHQy2hbxjN2rNLk5z5saxqTZOAB4JIDB+
         4uHLiqE7ralH4PFqb6+BzgQHpmaWjwSSrDzUkPER86PlJIJMQuYM0wcVyC+VH1EVSwpU
         TLzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkxq0vCQ+3xkrbjC54kzVI0OFfzV6OOirkR4/fwyQtJqf3CdhZIdmdP3/EI0GUuF92wjgbZcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2/aNEa4QdqxH5pJUEh8smDFjrkl+kuT2WxCQ3WXo5Z4G7gxL
	DIa9f1rjwGwB1ZYnJwxStK5ROiDcOrmAdYCTP4LC7tQCaVwwk+5iX9+8QtyNKuonaYbSZYSnQlC
	8S2wXrA==
X-Received: from pjbpq2.prod.google.com ([2002:a17:90b:3d82:b0:359:8007:207d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d8a:b0:34c:9cf7:60a0
 with SMTP id 98e67ed59e1d1-359bb37cf73mr805911a91.5.1772747437209; Thu, 05
 Mar 2026 13:50:37 -0800 (PST)
Date: Thu,  5 Mar 2026 21:49:57 +0000
In-Reply-To: <20260305215013.2984628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305215013.2984628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305215013.2984628-12-kuniyu@google.com>
Subject: [PATCH v2 net-next 11/15] udp: Remove udp_table in struct udp_seq_afinfo.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 27B29218ACB
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
	TAGGED_FROM(0.00)[bounces-264565-lists,netdev=lfdr.de];
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
index 432b4c5e7ad4..5ae0d88e3cca 100644
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
@@ -3630,7 +3617,6 @@ static const struct seq_operations udp_seq_ops = {
 
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


