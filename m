Return-Path: <netdev+bounces-265017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK76AsWRq2mkeQEAu9opvQ
	(envelope-from <netdev+bounces-265017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:47:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 980E5229AC2
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6C653078722
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 02:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4981DE3B7;
	Sat,  7 Mar 2026 02:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r//F17Bj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786832DCF55
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772851635; cv=none; b=MuHXQAMQn8TapWVZZ8L8ack3HkB1Y3H1BR69AqE3JGl5QmwdytybUfODgMmcXQcqqrsgB7fO92b+GzKD04K+OjuCuScDahMINg4wcbzuKGQ1P/lRwUiBA0GhOMK0qJ8smKgVQ5Ebd6RKZNwh2hgllxQk7hY//LRylsy2fv5qC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772851635; c=relaxed/simple;
	bh=xSUpKyUqiefYtnE4usC+rYtmZsVPKZZW2wiLcUfgKIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tCcNGbyFi/B2YDYXzEldDq2r+2DdHSx1Pb/x75Ongl5Et2WCwqX2gkwKxUeerAewUG8tN5zNa9GITgQ6dm2slARsn0nqVzL8LgjhrETobD+4nMGWTp+vqkT7jDj1SoqDPr5SFhqs+1qeRCl3JEVH1MYPJAm6FuXpoQMbBQYRbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r//F17Bj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae66ee7354so40050145ad.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 18:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772851634; x=1773456434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvQrkkAIV922a0MPbfbudJznaknrtut3M1bv7F6MyuE=;
        b=r//F17BjM2ehmXaWDLqYs1aRRtd07o7B4vFxgzIyd8q5jukOR1Mmu1e9iLRIBK3tkx
         20zkhc213AZ+f5ov9UI5tWI4IVXJ+lF0QDozulyx25rbLtCtiCpA4y4z/134kZnlK2Fh
         1hC3Cb041wEg2g+PWD9Om1iwhEFYCxideSZeDbecH8Zff69uFjTpodGcsg8qOAVtNSg4
         X5UiQnIFPva13fHGzpV7nXQwUmCJkHMnhpcBT/k5aH54fYBwpE2IwMobo7tpbkyTzxeL
         Iz7AsGUD1rMlTVI2wDwUhRZ68RL1AiudekINDpr7g5Gb0g27vyvA2jfSiZAOi/kMTQ0d
         HL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772851634; x=1773456434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvQrkkAIV922a0MPbfbudJznaknrtut3M1bv7F6MyuE=;
        b=qqnQEf4xEMqoK1eSeFGi314czTMu9ehq4zUQOTk1xDSduDFYM2a5Pef29ZW9WRc1dQ
         S9nCeeh9VnsG0XfjceIGT8caWxbKj4QQnb4zZjOHvqeMgMoXY3nIu4R27mV3BPJvChbA
         quIIe/ri8EaDJ5h7To5O0wNG1ETfO0nmyJCmrrtpoZSs4p38LmkUi5QASW1r17BECo4V
         dv9W1HWCbUmgSVKWO4LRBtWqz0vl7XGI7RQz1Q1qWIOUyqTISSqqVM3XysYQUluVTKdl
         NrdA1fqfojT13ZEzrK2VIxDU1VGzNJrJ7MqKI0NYdRJ1r34/p26FIhVk+4zpXwSj3V5+
         q+wg==
X-Forwarded-Encrypted: i=1; AJvYcCUuzxIuDwoYE29nr3H0mxXIXAk5K/bRHI/Mcr4rEUEzcNK1ql4kndXlfrkrkG4iVJ2wKfkoHps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp3yrxn8q3wrPmL2Q7O5bja6mWypgaZYzYF54iC+EswYjVX0zB
	BbzwFjDEjbO3W/c8LlgHa7deF2+M498lVAjMVzeWjZkU+MlprXLCnC2CmcPapIWNrK/8GJuuRiF
	eDTJr0g==
X-Received: from pluo12.prod.google.com ([2002:a17:903:4b0c:b0:2ae:44fc:75e9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eb83:b0:2ae:7efa:d804
 with SMTP id d9443c01a7336-2ae824e9c40mr40474095ad.36.1772851633654; Fri, 06
 Mar 2026 18:47:13 -0800 (PST)
Date: Sat,  7 Mar 2026 02:46:56 +0000
In-Reply-To: <20260307024709.718395-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260307024709.718395-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260307024709.718395-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/2] ipv6: Remove permanent routes from tb6_gc_hlist
 when all exceptions expire.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 980E5229AC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265017-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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


