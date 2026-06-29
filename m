Return-Path: <netdev+bounces-302773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YEkdEUK2Qmo/AAoAu9opvQ
	(envelope-from <netdev+bounces-302773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:15:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 908946DDF3B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:15:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="ANHD/PU0";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302773-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302773-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1068D3062F52
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDDD33EB06;
	Mon, 29 Jun 2026 18:12:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87644381AEA
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:12:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756759; cv=none; b=DoisxU3nAUHe8DKtPPLmLKTjmwSGGK5KwVR3AVuUCq2FYdjRfebZoVLr5kbostn+JCzP5/Dg2mQ89zshHH7I15w1U5STEWtCd96NvV5kQ/WYY4Z2qu13HmCr/dwU7QI75ljoMAzJ4Te+HXTmVPhy79jxTvzkJt0JpQFfh4dvwRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756759; c=relaxed/simple;
	bh=7jcOFCD+7YNXNME2SUr6saxb1aNuS84eGItYU6wFAfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jK0ruSUiFtF7r0GBuI5QQnZdlKgB06QlumGPhH+eFbgzBBnyadX7bu4hii4EKMIqSNFccjXaf3zIBBBjlzb7CjX006Ula5j6uiQpb8PuCgrLs2eO/LE/km89YmVa/b9ui6kJgH1xQcSlGV6FkVufNRFuKSRXdVL32VlTSp0jHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ANHD/PU0; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso1864244a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782756758; x=1783361558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nw1Day6wizsK4mDhSIM05TVrVczUH+WQqkbZfo7P0bk=;
        b=ANHD/PU0nZM2Is4zETfUEXW1k4uooLa+1Eoj7exfbmY0dyAZv5XsrDaOGFja/oikKQ
         l2VmvxPIbXPY9H99gDSwQwPxHk/Oj3N7qjZEfcIMIVxgiAPNe+M1mRRBJMMdFYk2hO+K
         qjrs/SmZ0ANiXh1UsRCgPiupL7lh7FbozVGBHVbyANuKinO6gtMY1jCOpzaNfIKnWekJ
         BQFQYIJJLXxSDJvLoQjuX2IrQC7WqY9edDmqvbAk5dFh9PK3fQgY2JgYkU7TF9PJlw+t
         zHFrX7Smgzf+owHZjVWs965l3v+Rhs1sHZ4Sh927ZmYSiuk5Fq+dgSn/wmxxsHx5e+JX
         3j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756758; x=1783361558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nw1Day6wizsK4mDhSIM05TVrVczUH+WQqkbZfo7P0bk=;
        b=B5NJw5TeGvR1BYygeV2y9awUh2aq6L63xTdchwr1Sw8QdnKtPzhAGdncWz0IY3oujg
         //AT9tX/bmuL6ZvGrjJpXsBWXfpOiM1SDA69BIZvzQB8HDkuge0OHYGGfLf6Tz2l12ZY
         Jf56O50y1GkbWO76ybRF+o4bo71eULCpu98qF6MuFFrRnQyRjjCcp21Y1LTnj91OkqC1
         mJ2ZXTQ5M/Lav71wUYUyBDvq+hkZVDOq2N3WYFc3FrgNiZTdfVbawYsfrHTFnSxhpUYQ
         LCA9UawlMaz8/CvpjCgyjo7Rnk9H2ovEEaXpqORFpBh+Y1vZWKm89qKCm4RZkx8Jlq00
         KY+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpfpANdAUiR+DxcbJ432Zde/WLfkWTHPuwPUzwrHXpE5bNAEpZM32tc3/Q6MGVniZxrTzSf+IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/NO9lWAFlhbVvt88a4YzKU/R8sv3ma1uKmChRWlX25oFZ7WJ
	LeVVs1QOSloXuL8uNYJ5YfO6oeJjGJ72C4bWe/tM0UUAboj8OWZREoHG7gnaiHgxnf6PCDkSpxz
	4eaLCNA==
X-Received: from pjbnm23.prod.google.com ([2002:a17:90b:19d7:b0:37d:f6cb:ce79])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c9:b0:36d:689a:cb27
 with SMTP id 98e67ed59e1d1-380527eee5bmr286999a91.24.1782756757685; Mon, 29
 Jun 2026 11:12:37 -0700 (PDT)
Date: Mon, 29 Jun 2026 18:11:02 +0000
In-Reply-To: <20260629181226.1929658-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629181226.1929658-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629181226.1929658-11-kuniyu@google.com>
Subject: [PATCH v1 net-next 10/10] ipv6: fib_rules: Convert
 fib6_rules_net_exit_rtnl() to ->exit().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302773-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 908946DDF3B

Now fib_rule is protected by per-ops mutex.

fib6_rules_net_exit_batch() no longer needs RTNL.

Let's convert it to ->exit() and drop RTNL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/fib6_rules.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 5ab4dde07225..04dab9329d0c 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -635,21 +635,14 @@ static int __net_init fib6_rules_net_init(struct net *net)
 	goto out;
 }
 
-static void __net_exit fib6_rules_net_exit_batch(struct list_head *net_list)
+static void __net_exit fib6_rules_net_exit(struct net *net)
 {
-	struct net *net;
-
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list) {
-		fib_rules_unregister(net->ipv6.fib6_rules_ops);
-		cond_resched();
-	}
-	rtnl_unlock();
+	fib_rules_unregister(net->ipv6.fib6_rules_ops);
 }
 
 static struct pernet_operations fib6_rules_net_ops = {
 	.init = fib6_rules_net_init,
-	.exit_batch = fib6_rules_net_exit_batch,
+	.exit = fib6_rules_net_exit,
 };
 
 int __init fib6_rules_init(void)
-- 
2.55.0.rc0.799.gd6f94ed593-goog


