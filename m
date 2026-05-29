Return-Path: <netdev+bounces-293215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CpZFIbrGWrDzwgAu9opvQ
	(envelope-from <netdev+bounces-293215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:39:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C446D607F1A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D0B83009573
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2218D374183;
	Fri, 29 May 2026 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wn3kLz2w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC920340413
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083586; cv=none; b=SZszwVWTixFEeM0ntFYBK4EACIf7BsDzEavsW61bfqhvrN5TCDksQFotPlWj5i/uVxRq0szEM1TbECZShNvxNqhKldzka5pEaZleUjA1VSWcwAj41T8xgoZlTpUCZatOAanJ313VFHr8TXMqy0vynAOqcevWSjzI2H+5FY0Kxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083586; c=relaxed/simple;
	bh=D5LevdIMh6QHRwUW3ZUwKINvHPpDAnk/8ciQktkkn6M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p1GS/jHJMNyn5R9tADFmcGBuvkhtSBDZUhUlN2nfwyMfLdujDObRPI30ie+d8OMl7Ew6ErHT9V+B9nGS7AVWU3RQ/Hbf4Q8px8DLwHJgX0cl30i5cCuOifxbbaLUkM5R+onWenwY+HAiHi7NkkoTHkVNp06jac945kL/1B7Qtvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wn3kLz2w; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c827bda2e60so8416397a12.3
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780083584; x=1780688384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UvNbPePsMJ4Tw9B574ZFI9cvexcAYVtdVUU7rlslHbE=;
        b=Wn3kLz2wCRD9VZ8bZLJGPisAvI/jBNWDioxulHo3L2hb04ipYkPHxZfRNylaB2CiwY
         SId1PeaDMhp3Vo6fBdyxJ60nvvHcmbR/GgPtjH82g1cB/2Jdas7u3OMVteabldMLOCRK
         qkh5eriXnJ97vMG3uz15plD1oWLA2EouInSlG+ZZmRwsVc6G1ix7YO1weeoF4L8GHxw/
         Mac1PvsKJa11AlqIHCUvglYW1flxmzNf5vLlkmTfjI4TbbTLuXjLrhtyOIy9VBBZJGYv
         vDFgRys/AaJDxHb8VyTzMaPWUqqu9RfCagvMWWSQhYfYmuqD1xfh6mZ6ulUfq7WbUmTf
         CYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780083584; x=1780688384;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvNbPePsMJ4Tw9B574ZFI9cvexcAYVtdVUU7rlslHbE=;
        b=bOH9TPm/IY327eClE5kQaouI3eL8ibhSA9HDelXtpNUiwSNUx+2vI23Qc5/eDYxTRJ
         ob+RYtVT4LI3Xo1qlCWtR22ZUcwJAryJntdlB/v6HrEemmgfimvmzOP41PP+Hw976p8y
         3w+n+qVtge87shdePSBFaOuCYIqyVjSreS6gXtkcv9lQMVyVs9/pQtlIn7pXgNwCavMI
         QQehsD7D5GjhDHQ4+b2EAXqB7GQRkLPzem+yrIJcAlt+TPUmnvcGg3oOPBugfS0cHo/+
         nBRNJqNSOjIAiegdP7oRdMdcw5L0sD+ChuEMOL8h5/fw50KrgIcdTFIV39Jb0mwOW/db
         WEzQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WOUwI8YpIgQjmsA92oqOynyHyyhlBCYLD8WmkNtJ+SduYz0UsNb7qz+JRF0ZALZBJZ9sTqFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdrIMB4lHzhTxRdja8nAH9ICx5Ph/ux8O5vpYiE/2RPYDdrxGK
	jyMXzhffLI0MKyX0ByNYai6bFeG+CcHW8yancf+5ZKK/Co8qZC5vqpVyxZzZG0aH90cCNtMWICR
	Mui1Bxw==
X-Received: from pfbjf8.prod.google.com ([2002:a05:6a00:6e48:b0:835:20c7:97df])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:aa8c:b0:841:5701:16d9
 with SMTP id d2e1a72fcca58-842257ea1ecmr821314b3a.50.1780083583896; Fri, 29
 May 2026 12:39:43 -0700 (PDT)
Date: Fri, 29 May 2026 19:39:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529193941.3897256-1-kuniyu@google.com>
Subject: [PATCH v1 net] net: Annotate sk->sk_write_space() for UDP SOCKMAP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, Lorenz Bauer <lmb@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293215-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,cloudflare.com,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C446D607F1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

UDP TX skb->destructor() is sock_wfree(), and UDP holds lock_sock()
only for UDP_CORK / MSG_MORE sendmsg().

Otherwise, sk->sk_write_space() may be read locklessly while SOCKMAP
rewrites sk->sk_write_space().

Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().

Note that the write side is annotated by commit 2ef2b20cf4e0
("net: annotate data-races around sk->sk_{data_ready,write_space}").

Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/sock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index b37b664b6eb9..d097025c116a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2676,8 +2676,12 @@ void sock_wfree(struct sk_buff *skb)
 	int old;
 
 	if (!sock_flag(sk, SOCK_USE_WRITE_QUEUE)) {
+		void (*sk_write_space)(struct sock *sk);
+
+		sk_write_space = READ_ONCE(sk->sk_write_space);
+
 		if (sock_flag(sk, SOCK_RCU_FREE) &&
-		    sk->sk_write_space == sock_def_write_space) {
+		    sk_write_space == sock_def_write_space) {
 			rcu_read_lock();
 			free = __refcount_sub_and_test(len, &sk->sk_wmem_alloc,
 						       &old);
@@ -2693,7 +2697,7 @@ void sock_wfree(struct sk_buff *skb)
 		 * after sk_write_space() call
 		 */
 		WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc));
-		sk->sk_write_space(sk);
+		sk_write_space(sk);
 		len = 1;
 	}
 	/*
-- 
2.54.0.823.g6e5bcc1fc9-goog


