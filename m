Return-Path: <netdev+bounces-264013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIlZKnGIqGn2vQAAu9opvQ
	(envelope-from <netdev+bounces-264013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:30:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3BC20715B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 016BB3016268
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBA53DBD59;
	Wed,  4 Mar 2026 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xlPi/iCK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80EF35CB60
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652641; cv=none; b=nFDbGOjwlFMHa1LeZT3wNRKhaT6l1UZHR8DPgL96vQTws8WJydwkgXAAb2QwJ5LGOood7N4FEwRz+GeiAU/dJGU3YXRGx5EWpWhH7SbfSgbXzYq1KW+tgrhliSjdpx9QXHyDwyOq0qIUdJ8kYznpA2Anc4JO/xHX9UugwGaBR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652641; c=relaxed/simple;
	bh=J42IK2pYxCfwvO4zY5LNVqhwQehLEel4ejZtTaT5gIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K8kvjT/vUlGy+691vpcktfNIQazVNZUi6c/Leb1V7X+BI6UHFXeMpQFqnD38O0SHdq6m8XkUwCtiUrfizK1Ig3tHwHpoabO4sMmuOTXUNZHNOsvbXuXMdTJorwqTBGFjWIXuyYQcruV5jwLWHXOLZPQVsveRhQhw89y1TRGzsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xlPi/iCK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3598d3e3bc7so3280571a91.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 11:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652639; x=1773257439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=820qp88FB2ZYrEOcH4lmbCN2U7SmA7ky7gJyKx30l1s=;
        b=xlPi/iCKhGYqTdzRi6OAKe8sudNyuVSHfAOThZ34b1absT5bJdn9JMkQFEEGxw2Z0k
         RSURIxE9h5YG+DK9ImC3/kDdWNE12ni71I8h8kYYab4mDcTGQx1IXOzJq2PW/0l3B5Cj
         zSpqpV5XBGu6yi2RPSKSuC1j/T3uLHMA0wWf/L4HtZ4YAqUVNT/l45cHLDsJ9ogfKxd8
         ESHgOG8FJOjphCaK2D45ngMqyZPkSbkv0Ng7FnGo59+ruLvtWrUdvKROJ1FHRFS0oBSh
         IUlxuAPFZ33Tkx1Vl8wYRyKQ9pM883Hvriy/dW9igBId30bA58Nca/lOBjo2eSCyESGm
         xLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652639; x=1773257439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=820qp88FB2ZYrEOcH4lmbCN2U7SmA7ky7gJyKx30l1s=;
        b=pk805mqsZth1VxMnxADuDK98uIfnIe3hN6epeyZethEUR0+itOaSVV9kW2oT9EZkZ3
         ILBVWgNEtp5mbeOk+3p3y+yIrONX6J+DHzKwmHGrL7WbTsNKjSgCOieHCUIZBdGr30Pj
         6wwjhnyZ2WbwuXD2iEVDpvFo/Pwh/RfzMcaf4EbiZ8PAepOf8dOA8Hcenyioi3p+dibY
         0n/BjUkkoiy6ScZ28Od2G6YCrcr5935k/j+R7sy/yNuHLj0NXdLOXofr0pIhMu5T666M
         CBg6bnmGIBzR7xVZuGGLB4TmDEz/U1bKNtqLYJD/JpDVCYRwm2CTCZKKUxNEP1yZaq4I
         VM1g==
X-Forwarded-Encrypted: i=1; AJvYcCV0Eg1qs1u7LOAPaLvEo+EGPVD50DTD0WkRng/POgJEq5qd1EDWkfumCf/Ogw6ubE5akcVi7FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysDKqRQHzOh24K3ZEBGi2cFeQUACx33tXrWUvmgR9/mmdQ2VhG
	Cb+MHR7fKLERsKKr+OtRQ3TLTM8f1Ra8aXqYr1g0Mck/RKDNsafPvbSXEtcdsAqdjjJZDA7Odpc
	tlaonnQ==
X-Received: from pjsv2.prod.google.com ([2002:a17:90a:6342:b0:359:852c:bcbb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c4c:b0:358:dc04:a595
 with SMTP id 98e67ed59e1d1-359a6a3d240mr2741671a91.21.1772652639000; Wed, 04
 Mar 2026 11:30:39 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:32 +0000
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 01/15] udp: Make udp[46]_seq_show() static.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2C3BC20715B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264013-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Since commit a3d2599b2446 ("ipv{4,6}/udp{,lite}: simplify proc
registration"), udp4_seq_show() and udp6_seq_show() are not
used in net/ipv4/udplite.c and net/ipv6/udplite.c.

Instead, udp_seq_ops and udp6_seq_ops are exposed to UDP-Lite.

Let's make udp4_seq_show() and udp6_seq_show() static.

udp_seq_ops and udp6_seq_ops are moved to udp_impl.h so that
we can make them static when the header is removed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/udp.h   | 3 ---
 net/ipv4/udp.c      | 3 +--
 net/ipv4/udp_impl.h | 2 +-
 net/ipv6/udp.c      | 3 +--
 net/ipv6/udp_impl.h | 2 +-
 5 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index da68702ddf6e..b82343a095d1 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -575,9 +575,6 @@ void *udp_seq_start(struct seq_file *seq, loff_t *pos);
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


