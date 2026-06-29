Return-Path: <netdev+bounces-302765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gTUwG7O1QmonAAoAu9opvQ
	(envelope-from <netdev+bounces-302765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:13:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E616DDF0F
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:13:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ZXziLQtC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302765-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302765-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E38C13035B49
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907A7380FE6;
	Mon, 29 Jun 2026 18:12:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A566372B4B
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:12:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756753; cv=none; b=Z2/T9lEh5nRUs48t3ikGdNKqdCVNZ2zyFVM531YGyTV12wQ2rxkfvctcPszzgxMucfMn/stUSj9Vp4ZIgolOMJO1MWmTw70AfBa4zQYH0wDFnlXQq62N72x5bOMzPlT6gMJ1mGgHkRUAVH1wA8TIuxbJUyePKG09MybWGQMqIjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756753; c=relaxed/simple;
	bh=w40yZ5MJYHS2pr2MwShzm05JTL4ss/IMwryti29kRcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VkTLceXC+svQi0XlvkynFHERcjIBtNabO6+/CSwDwWcOGC/G8wInPOuoQz7VBdYAl3T7cu+eCLk0R8hp7jwMecJgu5iKYEidbHqIrZOFhrah4Ftt7GQLMMzDjW+3ZPD8sG7WqcSSFulUsdnV0jbaFNyBg8BRHVeGuykDaTBr9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXziLQtC; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c9ed5caa3bso9397245ad.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782756751; x=1783361551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy/hCXit96TLAlp1EnAmOeuByVTqYVPjHSYBe1p0OWo=;
        b=ZXziLQtCGnpv+7UVBuosg8vF62xMwJf9XrqMLA+Y4uK5V7qGep8xyXnBLN2lFIpzWv
         wBXyaKyFVoK+nx25jzw3AGlxEtS+OtMaEFSrPw1Qvi41rxouQcQGcLYJXk7at848DZKP
         yQZi8WLP8WjAzKM3AJkEdP5DyGRGjUMJMi7mw62juud4v2YjQJ+zfGExEcz0m1F24UEg
         pp/brX3VeMy1aBM7tuFiMqkLXDtpNnzHy4orc/tQdTbpIVjyx3dj8iRS1YpbBxje7Ee9
         ThN/8AyJ+59GVsorA2dyFHTfZKQGNjoRG9urIDxanDNjN4BYoQfEEK3H87pP0rYosbYc
         AN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756751; x=1783361551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy/hCXit96TLAlp1EnAmOeuByVTqYVPjHSYBe1p0OWo=;
        b=CRURJ/llcALwW2FUKAqhLMjYl82cCy+vEEEkYmrQz/YsQv1doCK+Cn/Got+FjuoWxQ
         BacG9fIE/v3iUg6edJ8PgjXQhA7Jm5qpRbrQPTMCL8B3izmNmm/HPC0nIKvUASPq/nO7
         yKWKb93+mR/lxA+F/7PvCv2J0iKt/L1kzcqfmGLAL1W4aA+DMBenSYjbS9LFZbIkWhSs
         nT8gWzqWgWT2CGh+C2MZTM6YfIR7PgOEzUF9z90snY77ZvRcy8dAQa9ruGsTK7ZpGnMZ
         kXdmgnpFW9eszHY0jLkwKND7luBEDmjz894sHnDzr7Mk8HyAtFaHqcbiX+gvbSA+OByT
         BXfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJQMIy2mRrXiWASGpN9xTswvrZWaRG0Nxg3ohv9eHpnOFHSNqUnLWIlVsALZPH4vZqKdFYN+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfARws8/cLjNX4F33W5sPn1cKUUeTcQIuiHYr2A5SFmRiJ8oFE
	Y4RG4KQ20kclAyYWfcmaMoq3vIRJUOWE0NiV2x0J9n8IrYHp+o0+IvxBz/bmJ+MDm8VutWFAVFl
	xKwvpWQ==
X-Received: from plw20.prod.google.com ([2002:a17:903:45d4:b0:2c7:ef74:dfc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea07:b0:2c8:5de:a84e
 with SMTP id d9443c01a7336-2ca2ea335cemr2514365ad.10.1782756751285; Mon, 29
 Jun 2026 11:12:31 -0700 (PDT)
Date: Mon, 29 Jun 2026 18:10:54 +0000
In-Reply-To: <20260629181226.1929658-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629181226.1929658-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629181226.1929658-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 02/10] ipv4: fib_rules: Make the need for
 fib_unmerge() explicit.
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302765-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7E616DDF0F

IPv4 local and main route tables are merged by default to avoid
unnecessary rule lookups.

When the first IPv4 rule is created, fib_unmerge() splits the
two tables.

However, fib4_rule_configure() currently always calls fib_unmerge(),
and even fetching a table via fib_get_table() requires RTNL (or RCU).

We will drop RTNL from fib_newrule() if not needed.

Let's call fib_unmerge() only once for the first rule.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/fib_rules.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 51d0ab423ed4..16d202246a36 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -301,10 +301,12 @@ static int fib4_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 	    fib4_nl2rule_dscp_mask(tb[FRA_DSCP_MASK], rule4, extack) < 0)
 		goto errout;
 
-	/* split local/main if they are not already split */
-	err = fib_unmerge(net);
-	if (err)
-		goto errout;
+	if (!net->ipv4.fib_has_custom_rules) {
+		/* split local/main if they are not already split */
+		err = fib_unmerge(net);
+		if (err)
+			goto errout;
+	}
 
 	if (rule->table == RT_TABLE_UNSPEC && !rule->l3mdev) {
 		if (rule->action == FR_ACT_TO_TBL) {
-- 
2.55.0.rc0.799.gd6f94ed593-goog


