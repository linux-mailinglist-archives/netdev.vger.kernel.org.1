Return-Path: <netdev+bounces-269297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKGrKix4u2lvkgIAu9opvQ
	(envelope-from <netdev+bounces-269297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:14:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C98C2C5D71
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B673302B501
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C37329361;
	Thu, 19 Mar 2026 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnvUBRfa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D6E318EC4
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773893674; cv=none; b=qnNnwUYq9OgRDH7fpBFxPPGmSYLyL6U14lShiyE3LPSeYXs17RTLiDkxKnC3Sle9Z4X0yDiM+A9QOnpR3SSJxxMX9Fy0F44IW5LrOWRM6+Y9hptXV26ykkbvyz0a2oPYXk+L6UYxEuh6VMrEiWENx/hucHI+v5uoJp5bw3U3CaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773893674; c=relaxed/simple;
	bh=/SeceNk5b3/ODHjV3Khp6HncVyqya6ygjHbpfBRpoGY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nz03pEXNlhzRTIBjKMt2fOmc6HJqK4J3hbBigjpMLT9hQo2lWQ5Cq2O43jKiiHG+2o1de9lPpkq9FjgpJVDaTact2UZsuymFjtWePXu8a2plZV5rQtQ38w2sa2epUwdnu558uP0NrqCd0zYIuAUcC+ST1A1OdlgDun1nYgIdbVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnvUBRfa; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7381a95fffso388077a12.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773893672; x=1774498472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHyEN9gJRU4PUkQrf1lWMIXdvZ5sUViaeFxI+UmR9fg=;
        b=ZnvUBRfa0Tfm4rBc+X8liX+VdyGie0y00cj/fiIofv6N7rD1zckTAOsxB0gXGck6+9
         WUayIGH9inUgr6sXddxJH9kywb58Q6pjVZ2FJLTQfbgYNv42LgGvFHLLB6zhA8DNHVW4
         d0NHCGAsQAjz+jhertOzt5KJhHcmpNNHZQLJ/j4PFjiIh3dYo+73eyPoKLu1hLXCV4B+
         QLLT+NYIKoOR4uhPeHUuX/oqDox0L8YII+jAyPjUmtFtFKW+x8kSc9Kgt0kak3VrnSkY
         T2K01mUt4+TK37Uqsz3+y99iA1GTLTOu4aMhUP2jGB9eqLRHij/1elI7PS3OehKlZqJ9
         7zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773893672; x=1774498472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHyEN9gJRU4PUkQrf1lWMIXdvZ5sUViaeFxI+UmR9fg=;
        b=fwwQwiOFa7S5bcX6WtTwXaaU8yKhRcgK2GNk5RauNg0Eoxf8KOlXp2GeuJNMcDiq+k
         +EPWrrT0FHsBknn4Rry0eS1PuQVEyaR57hJr8qcySUjQaU3WfRwxqn1YZOXrlHsxpeFD
         Z0lkebxNpLlln5sQR3vainsa6zCuAasLwyygr5Pn3W1ZiXNwWi5hhbG9VWLMPBkYvcRm
         RjbmWKGGdLk4eyZboIEiHR/OyQalXVRchtQVd/D0amf6/miJSyh2QMR7W/OvC9oaT0mh
         7lQahPELQIN0004KIWpsJB80H4IzN+QapTWXy5bXur+3zrJQqFrnDcuRZ/lQ4a6JrfoS
         YSrg==
X-Forwarded-Encrypted: i=1; AJvYcCWlYI3FZfnvalE4Q03Ta2+bb+S29lPURky0sSR6UfoHeZ365XxisvDxJntyO+lU/OPv65+naGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxryO+obI6eOoYTweRXhDASlpx5ylxJwYQVRa4oThesxwSgkd11
	54Ut1rR3JhccqNrq3qoSW721Gm5BEZ83+rceaiLtj9DLiAbppXlcxht7i7xyh3GWg/gisxYbF5k
	0ud/4vQ==
X-Received: from pgbcr11.prod.google.com ([2002:a05:6a02:410b:b0:c73:8295:1401])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:478a:b0:398:9f1d:8a03
 with SMTP id adf61e73a8af0-39b9a07c7eamr5403659637.61.1773893672098; Wed, 18
 Mar 2026 21:14:32 -0700 (PDT)
Date: Thu, 19 Mar 2026 04:13:50 +0000
In-Reply-To: <20260319041427.1528743-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319041427.1528743-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260319041427.1528743-2-kuniyu@google.com>
Subject: [PATCH v5 net 1/3] ipv6: Remove permanent routes from tb6_gc_hlist
 when all exceptions expire.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269297-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.787];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C98C2C5D71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Reviewed-by: Xin Long <lucien.xin@gmail.com>
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
2.53.0.851.ga537e3e6e9-goog


