Return-Path: <netdev+bounces-265223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLrwI6HrrGkYwAEAu9opvQ
	(envelope-from <netdev+bounces-265223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 04:23:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4D222E6D5
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 04:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EE053010B7D
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 03:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2582D320CBE;
	Sun,  8 Mar 2026 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TareodbK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72E2DCC1C
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772940191; cv=none; b=i9lUtahjfFm5pohdEskeVW5TgCM3OfDxoIXHVTIVzdOCiPC1kIYwbRxuMeap3FjvsIMujIgjY2+TfZVWj82TG7Xde/eQJovx+yioc5wmdgHuLC4jw/2milpfP2OKOkcivokuKcyJOMtWtDON4eSobidk5vYmUuw0GU9KtJ6gzJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772940191; c=relaxed/simple;
	bh=xSUpKyUqiefYtnE4usC+rYtmZsVPKZZW2wiLcUfgKIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fOu1QF6VfuQfShc9MgNh2HW9TOfCOEswQc8s3A9wGpSDRvr1AO0w8SCmOND/3pG9x6KzMPmy/J+kUKKdKxxXUfG0/VpmHRAP6xM2Mr73yIxVmJMaRL2zKOF57VBwQ3y5/uXW/ObO+Sir0/stKP8IQtxjzUqb3o2HFqirDKPFXxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TareodbK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c44bf176so10045321a91.0
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 19:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772940189; x=1773544989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvQrkkAIV922a0MPbfbudJznaknrtut3M1bv7F6MyuE=;
        b=TareodbKI2/zXLG4Y4TCNF6VSw8hdlARjZtumx/Sgah4z10euIu5vHksJNzcwqkMrc
         dCTrqbqrRuq8d+HwfGqmL4sh+BsNucsOlMQrtGIk/Msz6OsmFelYqrDUGNrrPspWBnq3
         Xka+0+u1yCDsx13pG/p26/kHbYr9Dr56iIukx17V0p01YVza1Ll607JJhH/8MDoCfFBn
         iT37uaH3Ods8g0+hKpY3nTlM2f1LP5hPj5IrojFy7Fqmj/F8HXwt1YmveGi1W5anuoHO
         auJnGvThSZnyj1/uW35At7eQE5Pwn8LWD8/yIGwfmzU2g252d/4oZ61W/v4o9RYEHyAq
         kCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772940189; x=1773544989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvQrkkAIV922a0MPbfbudJznaknrtut3M1bv7F6MyuE=;
        b=C7I9Ma4xnK92RUPxuZAipFSAIu7q1Zu+olrEtnl21KBRkHeQ2oVk0x/e248+yCmUlO
         PLEOAmlQp7WbCYLf2+jclmwNlf7g+QPCBSwIxgFMr9DYUGv2msNYTNwq+gZVHJyTZ98Y
         JtwXHUvLj7zRPsHvU5zw4gL2BMmFPBq0UTg0y2kD8eK4ejatdCxoNWnAPFj44O0/5EwA
         ONJGQgJI8pTU2Wpu9gCP/n/3qMbdJfGsL8pYjbDkl2fGv7n3KTM1YGNvcYlAD81T1jAO
         EU4zFHtNlypSfnET2AO7f1IpkYWI3gsbJoN4F1eXtY6FQa0ET7j+tPxUQVLIH0Ojx//7
         d3hw==
X-Forwarded-Encrypted: i=1; AJvYcCX3QjXNHNJyfPpBvMQYVmrFnHdu1VZiL6OIf+svJM2LXjO1uxWUORYbY/qCcje9tospVA7bXWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQcQxQwHcTiZVTNXVPsa4gwIe/ysN5/kB3vH2zaVzw9M7n8E6e
	iKvAl3ZDNIAz2P/t8xbX436c9uDOagJ+mg19wfaTzseKN7U9cOLcm0mtn6o0iO+BTxN4umlmSvS
	Js9ULEQ==
X-Received: from pjrx11.prod.google.com ([2002:a17:90a:bc8b:b0:359:f40:eaa1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2ce:b0:34c:fe57:278c
 with SMTP id 98e67ed59e1d1-359be353f40mr6184818a91.34.1772940189193; Sat, 07
 Mar 2026 19:23:09 -0800 (PST)
Date: Sun,  8 Mar 2026 03:22:54 +0000
In-Reply-To: <20260308032304.1841198-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260308032304.1841198-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260308032304.1841198-2-kuniyu@google.com>
Subject: [PATCH v2 net 1/2] ipv6: Remove permanent routes from tb6_gc_hlist
 when all exceptions expire.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2B4D222E6D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265223-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
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


