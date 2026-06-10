Return-Path: <netdev+bounces-297471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e8VvJJ4CKWouOwMAu9opvQ
	(envelope-from <netdev+bounces-297471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:22:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01917666305
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:22:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=IBBtMjKP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297471-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297471-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E470306ED36
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5374C374E41;
	Wed, 10 Jun 2026 06:17:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BF537472F
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:17:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072270; cv=none; b=t7rMH4WxfwLiriCGmkfAxWnW3cUwNNJN07gL/G1OwVyZadCe/eRPqPLGn5o4il7aRPxHFNyKtLaJ0nf1JpKqhvYz6aFYe50QCz3sgJm2BEeZPzynXFzZpzzqiq44T5hO9kfCffU6C39qUVJFPMwOYlY//5p+EbIhPeG84Dy+okA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072270; c=relaxed/simple;
	bh=fs+GiyCcTlbuRdjgTZplnqlJqEpM7nLkPBhTuPpE+6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mMdkojTiqmh77dtHfN9/CMu69RcFADTszYsAx9uJjifDkrfl9wnm+SMGuqEV6pL7LxAZJFNfGxz3ay+Fu9TiV3LmYPa9nqAnjqEKcLWWMWNQmWoWl5xY16EF6stPb7GkSijeTruvRT9PZaviigpTtnjnoj95EWzdBDtMWI6GrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IBBtMjKP; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d98b74447so5026687a91.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 23:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781072268; x=1781677068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UmFHSv1iVtA1PT32HbvK0Yj2tj3uYAOf7hB2W3cJ4Uo=;
        b=IBBtMjKPSojF9HbhyBvlxhk4Hmp2eKyI0rvl2IZafWAveHfDkH18hvWr64krkq3xop
         gyAgTM6y3f8XoZJ98Qb4s+x78cIUNKuN5KPUt1YgbP+VTKl76nQ9+3EXvRFNDBG6+lkJ
         7YIQCGTCdtCpCgQlw/PLzd4MAFgeV09oZpvweSb6bctLIBwniWGjTUfa1dvUBQzjOd9e
         esBFxGQzJ/QERwWQglEgowpIapNEY2EO+/gXtF7uLQYNVbPlyRMlQTck0KKZ5AoqT37n
         Cj/VCdivmuMuuoa87QZ60big+GE1zvERdfZ6t7i2wtTPoOO6rwzQs2r9cRFfSkUqIMjn
         YICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781072268; x=1781677068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmFHSv1iVtA1PT32HbvK0Yj2tj3uYAOf7hB2W3cJ4Uo=;
        b=XdHleLkI9rthASCMVpcqQE9Kbv7tQsjE4XeN5gUGYOafjf5PLJ/36fZNAXQIQyrVYd
         ol0Ix1DFLOmoHFaw5Ng16kuck3Wml922TXR4Kst4SGFMKmQzVwGSyosgDgWirydm/GnL
         aJkXMQnIqHbB721Lc9UT1mYNKcMEQ3KtUNAEi8+RwPiJHDFaero0WKD2oNPS1E5nnZ23
         RHB4zUzFVEfcm1bvKa8IqEMqAGtaQ/k8v9KmxydxR12FecO4vswluQGD1OmO3Sz0E+5u
         6FAFNouTHZ1TOvwXMo9LqPWSTKdQGFFHTPqnrb6uEKpRE51Vu/ez1K57TW2/0xt3902+
         KESQ==
X-Forwarded-Encrypted: i=1; AFNElJ+liWR60QkbPjDr+BJ83LknOpEC7VtBRNcGI1kF/U2wVBGnn780bR0z9d6uq+U974tf1iqR4wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyP6t3P1+Pz3K7XkBz+1bucttfJV9dAkUZwYF+01m+53c6qyA+
	vwP5op5ttIPCzi2QSmwoVWrt8La1aVMltayIT1JAZOlE8PF7E497ScXH00tIxi8Td7rklzoJTRM
	EBD2z9w==
X-Received: from plbkc16.prod.google.com ([2002:a17:903:33d0:b0:2bf:e6c:c1de])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54d0:b0:36e:2106:dedc
 with SMTP id 98e67ed59e1d1-370f0c5060fmr24647632a91.22.1781072268076; Tue, 09
 Jun 2026 23:17:48 -0700 (PDT)
Date: Wed, 10 Jun 2026 06:17:19 +0000
In-Reply-To: <20260610061744.2030996-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610061744.2030996-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610061744.2030996-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/2] net: fib_rules: Don't dump dying fib_rule in fib_rules_dump().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Amit Cohen <amcohen@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:amcohen@nvidia.com,m:jiri@resnulli.us,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297471-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,resnulli.us,google.com,gmail.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01917666305

rocker_router_fib_event() calls fib_rule_get() during RCU dump.

If the fib_rule is dying, refcount_inc() will complain about it.

Let's call refcount_inc_not_zero() in fib_rules_dump().

Fixes: 5d7bfd141924 ("ipv4: fib_rules: Dump FIB rules when registering FIB notifier")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/fib_rules.h | 5 +++++
 net/core/fib_rules.c    | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/fib_rules.h b/include/net/fib_rules.h
index 6e68e359ad18..7dee0ae616e3 100644
--- a/include/net/fib_rules.h
+++ b/include/net/fib_rules.h
@@ -111,6 +111,11 @@ static inline void fib_rule_get(struct fib_rule *rule)
 	refcount_inc(&rule->refcnt);
 }
 
+static inline bool fib_rule_get_safe(struct fib_rule *rule)
+{
+	return refcount_inc_not_zero(&rule->refcnt);
+}
+
 static inline void fib_rule_put(struct fib_rule *rule)
 {
 	if (refcount_dec_and_test(&rule->refcnt))
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 8ca634964e36..cf374c208732 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -349,7 +349,7 @@ int fib_rules_lookup(struct fib_rules_ops *ops, struct flowi *fl,
 
 		if (err != -EAGAIN) {
 			if ((arg->flags & FIB_LOOKUP_NOREF) ||
-			    likely(refcount_inc_not_zero(&rule->refcnt))) {
+			    likely(fib_rule_get_safe(rule))) {
 				arg->rule = rule;
 				goto out;
 			}
@@ -410,8 +410,12 @@ int fib_rules_dump(struct net *net, struct notifier_block *nb, int family,
 	if (!ops)
 		return -EAFNOSUPPORT;
 	list_for_each_entry_rcu(rule, &ops->rules_list, list) {
+		if (!fib_rule_get_safe(rule))
+			continue;
+
 		err = call_fib_rule_notifier(nb, FIB_EVENT_RULE_ADD,
 					     rule, family, extack);
+		fib_rule_put(rule);
 		if (err)
 			break;
 	}
-- 
2.54.0.1099.g489fc7bff1-goog


