Return-Path: <netdev+bounces-269812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADBdBGD2vGkt5AIAu9opvQ
	(envelope-from <netdev+bounces-269812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:25:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 645972D6943
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4360301AA4D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0474D35BDCE;
	Fri, 20 Mar 2026 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iCKeS5Ae"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF35535B63A
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991403; cv=none; b=cLX+4bVCqWaMIUMRbihjICbKPwBS1/Vbj+mzIb7A0k1BQ6ueR0b/lZ96Jgp/2VuRAXZ1sWgQjBm259oLVp2L9CoRfBYc45otfdhJj13q7Oxar3to1tPmJie0Cfx5KXkwr805C6tJ9cR/F+h/+F77/TEorIXoLM5BO9MGc2SI2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991403; c=relaxed/simple;
	bh=ReldcASHDrF2HHtmtAv54KTQ4ewXfdSe5rtGK3woxmc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HPAaDPf2LEFyVXGbrI0ktsH2bnS790hKTCRqold94KNupLHKfLeJnLBbtpUc/7NYfUMgqMtpOcLxCB9fOa8V8DdCwtEIdk1iU5yppcpnOonqcLq23XqX575T5+Hk8cOB+l4LlQ7RYvfsfaXvO6n1HHduokeuZ2etF3GsAwNjNxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iCKeS5Ae; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7414516609so1272565a12.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773991402; x=1774596202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+DPgy3H4jqGS0pHznUOF21SInzO8sFZVNK+gTs1qQh8=;
        b=iCKeS5AeoJQT98phrKlFiJPz4HDiy35QdEHw5i5dluGO6qoa4F4Jet7WLt1Q7uztZf
         ZBSl+CdbCdyiETB/bH04nGZFe0BwryPat2J+knkdDSWt6fGI2wSAtn0vEXvlJ9MNLGAq
         G/BaCgFD2Hi5ppiJVsnSrwKFoXyLRAamVGhfHNI64AAL1yWpBEBrK58oRphc3txto5Ra
         Xh/rgyB8LjxEqIVGeKxm8hOBkH3M5+Gno2vA7lKjQ4oAedjez4HQ6YDNveKWxeE19Q0q
         5OTmHHk54DwNL3rmADK7Hp76fPZ2YdHKuOhkgizAvZvRBUBWQJJIecp+lklWOHzpPPBf
         rsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773991402; x=1774596202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DPgy3H4jqGS0pHznUOF21SInzO8sFZVNK+gTs1qQh8=;
        b=EiHUesSBr+eXckCKjX1ZbX8onwGWZSYRrqatVxRaUX8kglRpTIwJ8lTHeJ/a7TKRKR
         UkWsRggiLLIMdpC4Ht2NYalevfOMSvV9yi8mZJAs9bZXrs/LqWMg97PMmP3FynG5xP4w
         7NsdJEmI0gNp6+t2af8uB9mIS1HPRMnAr/TT1O7j9aUxWnv4gwHSw5KRROsR5fA1B/B3
         2w8+p4p+SimuXzdAkwfKGLgxd3+5hJbQRa6NxOhY05K4BRP/ooxcQAyvaXJGbIn4FMYo
         9AO8EnqO2g9uVY7NBc29Yj8RBag0Dv5HSyZxC4GLOddwhgetrFLSg884N0AWb/EAv2ER
         kMvw==
X-Forwarded-Encrypted: i=1; AJvYcCWP4Gi+PWyzTemhO3s1RBRbOUBM3fZIPklXnynpRRKPkbUi02BCjovE8HDQ8N74ls04sUONy2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIkMm7TveA6Iqgk067xIg19G3pPdalA1toqZvZMTBitx01Ynd2
	YtEhIVfiaajMTD7MeNFcCeP3++Wf2yur2QV8Lw3YN/bAV3wJNHNhhTTYvxafvLszBNd7E64YmTG
	br1WIUQ==
X-Received: from pgdc29.prod.google.com ([2002:a05:6a02:511d:b0:c65:e8e7:d481])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d86:b0:398:93bb:f28a
 with SMTP id adf61e73a8af0-39bceb051f6mr1882164637.27.1773991401919; Fri, 20
 Mar 2026 00:23:21 -0700 (PDT)
Date: Fri, 20 Mar 2026 07:22:59 +0000
In-Reply-To: <20260320072317.2561779-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320072317.2561779-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320072317.2561779-2-kuniyu@google.com>
Subject: [PATCH v6 net 1/3] ipv6: Remove permanent routes from tb6_gc_hlist
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269812-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.870];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 645972D6943
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
2.53.0.959.g497ff81fa9-goog


