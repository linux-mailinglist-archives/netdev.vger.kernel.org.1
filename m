Return-Path: <netdev+bounces-266467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDbUHqj7sGnCpQIAu9opvQ
	(envelope-from <netdev+bounces-266467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:20:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0E525C5CC
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCC393118E96
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D7D1DF736;
	Wed, 11 Mar 2026 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bP4zkEMA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D8278161
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206427; cv=none; b=RuapYMRKAj9KKjs7owc4c5L1nsiEZdb0V5NyTdQengXtg+8hgU8zcIifl+sFZr2U8AacawI5Tnvi/cCKBO5jHewlrR4c08o5zMVwdMzlxPuFVNGkQ7Pk6ZDPwR0TwrF1X8w6w94ISmNFrs2JvrR+SgMhcYGrcOMBd6pAir1Xrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206427; c=relaxed/simple;
	bh=u0ACyTiQrfQAQtYUlUG6X4XABOIonnr5KcujL1J5HlQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rcx2eixN2oF70A56lSdVPYJUQgfiQGMAdKzYHbVK9kiBZ1whFXj+ka8M9vqB69szcLI4VhP77MdpFwSgEKBy9jhKTd7hftUFPqz4Ob36k0/5jA9mK6Sh0S9FxVEJ1mGx1hy/omr0adQ+zWge2GWLh0UgI5kfDzKuwLBK9G0xRrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bP4zkEMA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c737ced4036so4123846a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206426; x=1773811226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBRxx2+J/y1iYXy166Sw2QUxngyOG26wtzcLlNfd8Qw=;
        b=bP4zkEMAf7TmCV2WVTlqhO1/d9/CHXjSVHx845qwBQgN0pzi0n4gEtGVas4L8MeZtu
         ysTTm062wrsRanprkXQ8W/Z6uIv5yCegA9d28vTnT0IEXOXHGqNz78WNCD8U362pwHrE
         2Qy425Hq6iSllwUfZng3p61880p+kkqfiA6M1WkqphPlPN6ALG4EFCwvuiwkSwfGNSlL
         ZYFIVTPunnzOWGYILA49PohsBqIekSuTRjJNRAabIjjwXZa3c+MDJYFPEa4ZKHXleqj4
         qXtcbxttRGuufklBYWdpz5FTgQKGJXMJcoXFDTZZxRsVrIQimT7bZVEdeqyDiOebvKMe
         TA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206426; x=1773811226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBRxx2+J/y1iYXy166Sw2QUxngyOG26wtzcLlNfd8Qw=;
        b=jlw2H0IPqDkBYvXysRJuRB6CAgelf40CE5oNro8OsTX+rAGj8v++5l9slOM5SpFb5b
         ui9iCzlgFhszVAPwWSuzRwEhs7R7KtBzumkh6bs7aArPHpUB+jtJTT8jcuEe+ogILJmR
         BpljaJI+71U3OK9FJcgmEwngCa2ThYW0zCjooO9D89SNc65PgpIwFtkeRr/AmzBRyU7Y
         5sAuVl3p93Cuf/blqlbjeB1nmwIkD0SAuZRQtSQx0jpzIOVUQ9Bd/WO1Uq8Zwm/ysDdb
         GmihAQGg8oOO3kGvoLaFJ+N/eSuvAXl8IocS1YP3IHDnkf9c+TvvKdhYmCGUjikLM787
         +x+w==
X-Forwarded-Encrypted: i=1; AJvYcCVb6R4440w72b/povBUXELZ/KMCnH/qRc+CeaiyquN5ybsP9qQecPhNDd7BD5uto9kCa+FZChE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvwBbtwrpajQ/Uc4cONeIs0l51X73kn/tykbhrS4XkanlCd9zP
	jVNgwyE1bYlv4PHgSRzf4WIJEQYPVSNtxOBWKnI6TeU1j2kWXuIEvXGah19YQClDQ5ysYXRUDgy
	YCqYI8Q==
X-Received: from pfig8.prod.google.com ([2002:aa7:8188:0:b0:829:8d7b:fdc7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:278a:b0:81f:3f6e:166
 with SMTP id d2e1a72fcca58-829f709bf31mr1112107b3a.46.1773206425429; Tue, 10
 Mar 2026 22:20:25 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:19:48 +0000
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052020.1213705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-2-kuniyu@google.com>
Subject: [PATCH v3 net-next 01/15] udp: Make udp[46]_seq_show() static.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EB0E525C5CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266467-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
index 668a0284c3d5..1fcdc5482594 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3443,7 +3443,7 @@ static void udp4_format_sock(struct sock *sp, struct seq_file *f,
 		sk_drops_read(sp));
 }
 
-int udp4_seq_show(struct seq_file *seq, void *v)
+static int udp4_seq_show(struct seq_file *seq, void *v)
 {
 	seq_setwidth(seq, 127);
 	if (v == SEQ_START_TOKEN)
@@ -3753,7 +3753,6 @@ const struct seq_operations udp_seq_ops = {
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


