Return-Path: <netdev+bounces-265683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIizJqANr2lVNAIAu9opvQ
	(envelope-from <netdev+bounces-265683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:12:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D988023E5CC
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7983301FD9D
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1FF2D94A2;
	Mon,  9 Mar 2026 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2YlN2Q5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F204729D26E
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079704; cv=none; b=mbHJcujJbqFZ6HpQotVI9PvuxudSbpCKh4Z22NthRxmtz0xgctfDoI3yZfDI1Buf0VfDkuv87ORAQIf76007vNJHnZfJXTyUCMBVPxuW+zT6kxbAXcl8zvL91s41Kq3IuOVwnqD+WKS16Ak+zKo0zcjHuc2aippjfHRz2tSQXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079704; c=relaxed/simple;
	bh=xSUpKyUqiefYtnE4usC+rYtmZsVPKZZW2wiLcUfgKIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aHdmJN8H/bmry7rHl58dqgMo9YKY63eG3qb0UsdmfblmS3kBzROw97NT8r5ae623DLFyuZ98iHuN4p9wMS5cksBzEnfEJ/fyYUmSDXJRDR14T0e+RLQI3x0IEbAg8J9ESO5I/fdUmnzwb3W5Je8BKBuJ6vNRurnHB8vsbN4EIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2YlN2Q5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so7526264a12.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079702; x=1773684502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvQrkkAIV922a0MPbfbudJznaknrtut3M1bv7F6MyuE=;
        b=J2YlN2Q5Yi3/qoCdch22+0A8cTBgg26jy2zNKrU65ti1+Bd1vUPixxhNQlH+XtbMvC
         21ulOefEJqvqM6W+sV7rDKHKO+yQL3RmD+NyshqWHADpNM+x9uWV2exFTGLVS6U+XO9S
         aYBhv3/mOX3zuelkywohm/++37N52hwnB6VlwCuAnFo+nXWWScP//dSfmoN/Z5RnaEbn
         1Ryb6UzG4pp9+4q3xdn54266hrMj4ig9HLC+s41IpXOy9JjNTDUUOkRquVVjnoZ80RcL
         FKkY2umZ9YYug5wWbYxwSH+VG8rwdoU+Gn/vpVdgr760o7i5W1/JEW4IfkU+CXsCuz3D
         /vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079702; x=1773684502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvQrkkAIV922a0MPbfbudJznaknrtut3M1bv7F6MyuE=;
        b=cw1qNn6coOET9rfB2o2TshOqgKGABmR1USfhYykpGUR91+fpsIZ73GcssuU0sG3HjV
         RQTBKSon3Ny8DVxSnb2LGA3cG1loZxCvFz8cK4cY7FELMzlBEJiMvos7f2EfDPgvkhVK
         L9JKdtrz1WpgV8ubYSiFeaIKw92WVGUyIVmnBY9Of7UKwggp+6J5w2EGxP/DXZ4JtkJs
         FyF+rBjgmDjP9obOSvvfA6xEJ2MHNpITmYEcpI0sNqj7k4E6nFYqa0c77bcbQm1K7pub
         BJkQGC3yBXRsOH58I5DzRI5V4+boM7fsrgmKsSEqwox6oc1+tw4Il79PP8MGzRIOffOL
         ZPOg==
X-Forwarded-Encrypted: i=1; AJvYcCXHVmNdLi9kazFgMLM5JoRhe0Sf4VoOwy0Jkpaqv2jeXFCMhtCYxMyXkQ4+b5vqTvqTxn5brdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNpviK+JFhpieCv3z82LVDdOp73n6qEoAxrI7xeQQwCUlDd8v
	62+XJNK2UyGxbMLoqEIvWdIQX/1l2Jar2/Ng8aqVHYhGiMFX0hOV20DDLWStUami9TJdqEqp+g5
	tb5BK4Q==
X-Received: from pfbna10.prod.google.com ([2002:a05:6a00:3e0a:b0:824:9c5c:98f3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1581:b0:81f:3f03:6832
 with SMTP id d2e1a72fcca58-829a2f8be8fmr8678269b3a.44.1773079702068; Mon, 09
 Mar 2026 11:08:22 -0700 (PDT)
Date: Mon,  9 Mar 2026 18:06:48 +0000
In-Reply-To: <20260309180804.3471287-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309180804.3471287-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309180804.3471287-2-kuniyu@google.com>
Subject: [PATCH v3 net 1/2] ipv6: Remove permanent routes from tb6_gc_hlist
 when all exceptions expire.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D988023E5CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265683-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Commit 5eb902b8e719 ("net/ipv6: Remove expired routes with a
separated list of routes.") introduced a per-table GC list and
changed GC to iterate over that list instead of traversing
the entire route table.

However, it forgot to add permanent routes to tb6_gc_hlist
when exception routes are added.

Commit cfe82469a00f ("ipv6: add exception routes to GC list
in rt6_insert_exception") fixed that issue but introduced
another one.

Even after all exception routes expire, the permanent routes
remain in tb6_gc_hlist, potentially negating the performance
benefits intended by the initial change.

Let's count gc_args->more before and after rt6_age_exceptions()
and remove the permanent route when the delta is 0.

Note that the next patch will reuse fib6_age_exceptions().

Fixes: cfe82469a00f ("ipv6: add exception routes to GC list in rt6_insert_exception")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_fib.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 9058e71241dc..fadfca49d6b1 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2348,6 +2348,17 @@ static void fib6_flush_trees(struct net *net)
 /*
  *	Garbage collection
  */
+static void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_args *gc_args,
+				unsigned long now)
+{
+	bool may_expire = rt->fib6_flags & RTF_EXPIRES && rt->expires;
+	int old_more = gc_args->more;
+
+	rt6_age_exceptions(rt, gc_args, now);
+
+	if (!may_expire && old_more == gc_args->more)
+		fib6_remove_gc_list(rt);
+}
 
 static int fib6_age(struct fib6_info *rt, struct fib6_gc_args *gc_args)
 {
@@ -2370,7 +2381,7 @@ static int fib6_age(struct fib6_info *rt, struct fib6_gc_args *gc_args)
 	 *	Note, that clones are aged out
 	 *	only if they are not in use now.
 	 */
-	rt6_age_exceptions(rt, gc_args, now);
+	fib6_age_exceptions(rt, gc_args, now);
 
 	return 0;
 }
-- 
2.53.0.473.g4a7958ca14-goog


