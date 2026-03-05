Return-Path: <netdev+bounces-264555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEMVHrr7qWlcJAEAu9opvQ
	(envelope-from <netdev+bounces-264555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:55:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B72218B49
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 110E13118B4F
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E466D354AC7;
	Thu,  5 Mar 2026 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aGQoV1bm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1ED35F5E8
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747420; cv=none; b=sVUMCJYSSiEIDlzPNWz8YfyguP6vWAILkwbV0aq0B8n5IPBail69xuAWkTF3xtqUpGy0TrejiFB385L7bLGzg/StINFz3deQR+OSSVyva+9doqg4JrwTi60eHgWBCsskTMJJc1sf0cg2pUjaXo3Q/l4JsuTJF1+YjEPqR3JOiRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747420; c=relaxed/simple;
	bh=aEZ8/alK/7R/5PNkJsE76WPLU9ewm3QRwokIbbHhRxQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mHUShKxdAsqhUtOldmtWD2P/kfdHcGKD31+S/9KPEVu6VEdtcl1ZhCcj1nhKjBYUxI7J3Wn8LbGQN6zaseCuGlX8QzlGMtp86V7XlQif73odIxLwd+oXG+Qkw/h0f9CF67Zz6NP16BLTrDnnSdTklQ+5vnbYyEpiTb5nJcBbkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aGQoV1bm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35982c5940cso3907139a91.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 13:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772747419; x=1773352219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bfWje5L/be/zIHBOlLcKStI7HaNrHbZhco6xO4xf7pM=;
        b=aGQoV1bmwMp9fWzVh8UNsqV/7SSX1ww9GOyvLmBJbD8kWJB2tUh0k21HVrIhRmcODb
         BM/iOMtVlphdUdL1rprnQYSjvJyfnghaWrG9tDxI65M/D13HLDF91Fy2jhg7h3v52Kff
         A0Kzs7pdjXQN3B5muIROM/aPaCYjHYO37OSlywvJX3+ZHPs0k5oMHkZSJMso56duRQgm
         PjUC09tQ/SEJWFnENvzGJQjgfZkxWC7KsMuaYnueIuGp7aC+eG5pHKBxMZoYhj+tb7il
         n9JBoxUz91Dm4lPhbgllGwkO87gVEwuMKaUJUGQF4BnJTtzpr0ELz99v1d+9cd5qebZS
         88XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747419; x=1773352219;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfWje5L/be/zIHBOlLcKStI7HaNrHbZhco6xO4xf7pM=;
        b=Dn6yJH6iL9/+qMVrqqTTbuu9mIJFNE2vno4dzEhvNrxmI5vfx6MX7g30NGwVdpYKnZ
         A3fO5cUAYQu/jjSpYo+Z0UzkpAyKmXcV1PS4gEpHMUuELt3OuMbg4kl4Bz1NPMczqXRA
         odgNP68w5iQiyRCkaLGE/Ub3MucUy7f6aZpfketKueXjw+vuQq1e7GhxSKdoAYRXfCGX
         j78JNi/crIX5L1bQVQMmGNsWJe9bA6NtyQGvwGagUdmtdamqWA+JvKzF7Wl64HLTj+Wz
         UyWkc3Sm5SXXlhnPIOHn0ORZctwa8xzi91a9/xtyZQEjXwpIjIFxHvim8CKjzjtQhJg6
         WDlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhm9aVraMIcpHngAm5dQSUzYsbx9QaX/mdGu8CNb2BzoVpfLUqBm8BufBDPeN5g3hebD6TPog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwdJXVpu/dBqYucT/XFosHfVdksmRonhj6wCWvoxyG4F2+ydl
	LS9pi4vS4tO0GTXbiQUHWrow3ARo9O24rdhfaGIa7Lr7Q3XT10fbPDLWxFmXtngnvE1RbgUdd4U
	W1RPASQ==
X-Received: from pjj5.prod.google.com ([2002:a17:90b:5545:b0:359:974a:3d42])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ecb:b0:340:bb64:c5e
 with SMTP id 98e67ed59e1d1-359bb39a8f1mr911056a91.14.1772747418806; Thu, 05
 Mar 2026 13:50:18 -0800 (PST)
Date: Thu,  5 Mar 2026 21:49:47 +0000
In-Reply-To: <20260305215013.2984628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305215013.2984628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305215013.2984628-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 01/15] udp: Make udp[46]_seq_show() static.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D5B72218B49
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264555-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Since commit a3d2599b2446 ("ipv{4,6}/udp{,lite}: simplify proc
registration"), udp4_seq_show() and udp6_seq_show() are not
used in net/ipv4/udplite.c and net/ipv6/udplite.c.

Instead, udp_seq_ops and udp6_seq_ops are exposed to UDP-Lite.

Let's make udp4_seq_show() and udp6_seq_show() static.

udp_seq_ops and udp6_seq_ops are moved to udp_impl.h so that
we can make them static when the header is removed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/udp.h   | 3 ---
 net/ipv4/udp.c      | 3 +--
 net/ipv4/udp_impl.h | 2 +-
 net/ipv6/udp.c      | 3 +--
 net/ipv6/udp_impl.h | 2 +-
 5 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index b648003e5792..f51a51c0e468 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -576,9 +576,6 @@ void *udp_seq_start(struct seq_file *seq, loff_t *pos);
 void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos);
 void udp_seq_stop(struct seq_file *seq, void *v);
 
-extern const struct seq_operations udp_seq_ops;
-extern const struct seq_operations udp6_seq_ops;
-
 int udp4_proc_init(void);
 void udp4_proc_exit(void);
 #endif /* CONFIG_PROC_FS */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 27384024ebc0..f0e7e2e919ad 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3438,7 +3438,7 @@ static void udp4_format_sock(struct sock *sp, struct seq_file *f,
 		sk_drops_read(sp));
 }
 
-int udp4_seq_show(struct seq_file *seq, void *v)
+static int udp4_seq_show(struct seq_file *seq, void *v)
 {
 	seq_setwidth(seq, 127);
 	if (v == SEQ_START_TOKEN)
@@ -3748,7 +3748,6 @@ const struct seq_operations udp_seq_ops = {
 	.stop		= udp_seq_stop,
 	.show		= udp4_seq_show,
 };
-EXPORT_IPV6_MOD(udp_seq_ops);
 
 static struct udp_seq_afinfo udp4_seq_afinfo = {
 	.family		= AF_INET,
diff --git a/net/ipv4/udp_impl.h b/net/ipv4/udp_impl.h
index 17a6fa8b1409..0ca4384f9afa 100644
--- a/net/ipv4/udp_impl.h
+++ b/net/ipv4/udp_impl.h
@@ -22,6 +22,6 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags);
 void udp_destroy_sock(struct sock *sk);
 
 #ifdef CONFIG_PROC_FS
-int udp4_seq_show(struct seq_file *seq, void *v);
+extern const struct seq_operations udp_seq_ops;
 #endif
 #endif	/* _UDP4_IMPL_H */
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 5a3984e59c90..5fef1c226697 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1903,7 +1903,7 @@ int udpv6_getsockopt(struct sock *sk, int level, int optname,
 
 /* ------------------------------------------------------------------------ */
 #ifdef CONFIG_PROC_FS
-int udp6_seq_show(struct seq_file *seq, void *v)
+static int udp6_seq_show(struct seq_file *seq, void *v)
 {
 	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, IPV6_SEQ_DGRAM_HEADER);
@@ -1924,7 +1924,6 @@ const struct seq_operations udp6_seq_ops = {
 	.stop		= udp_seq_stop,
 	.show		= udp6_seq_show,
 };
-EXPORT_SYMBOL(udp6_seq_ops);
 
 static struct udp_seq_afinfo udp6_seq_afinfo = {
 	.family		= AF_INET6,
diff --git a/net/ipv6/udp_impl.h b/net/ipv6/udp_impl.h
index 1bd4a573e1bb..525ea600228a 100644
--- a/net/ipv6/udp_impl.h
+++ b/net/ipv6/udp_impl.h
@@ -26,6 +26,6 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags);
 void udpv6_destroy_sock(struct sock *sk);
 
 #ifdef CONFIG_PROC_FS
-int udp6_seq_show(struct seq_file *seq, void *v);
+extern const struct seq_operations udp6_seq_ops;
 #endif
 #endif	/* _UDP6_IMPL_H */
-- 
2.53.0.473.g4a7958ca14-goog


