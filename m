Return-Path: <netdev+bounces-294365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /C73FagpH2o6iQAAu9opvQ
	(envelope-from <netdev+bounces-294365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:06:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF736314A7
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:06:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=NsyqpKPj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294365-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294365-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EB3B301D114
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F329E3A6405;
	Tue,  2 Jun 2026 19:04:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F373A5E80
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:04:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427082; cv=none; b=raFgqeQDDwFjTxVOawaNlEnEzathmiD5AHHzHmQoJ8z4ybgtbyi8DNiavMKQBoahZlKl5qxabNjp/ZnfNh8XGqi8WftkVnXfm5rwkcO1WMgdsOGyY+roPBUaetn/0k7PTXCMeEzF1dkmUQIDMWn9XtdM3U65o8HKQKD4U4+fanY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427082; c=relaxed/simple;
	bh=9Yo/TVlY4TGAmeXw5J83bBJGEmsQCRKefnxUSX6pvWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IiJL20XIxxpbWqU8e3Dz+E8spg1aojXckJx8tGx/bCDV50GhtuoVuDdKkOGaHmuEbBrt8Bc6RKv0GSJdSjx6oHbjjjlUTMXrfnsg052rwTDvdyqU1icFmsfR7SNqG10MmlY0mYxXabW62JBSJ3wcUZdpeRe7S2VTNlYbAB4tIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NsyqpKPj; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c856470fe9fso3651829a12.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 12:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780427081; x=1781031881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8sRIbUudhuC9QSnfpjJ5+uQ9wbLrhawuW8vZsptn08E=;
        b=NsyqpKPjq0wy2VzouX7IVj+QocPmqpniR6oNjo1WwUImC5P1t+sb7md8nQnQIRP3ay
         KfQn34rRWIvfB/ngyvI8zSlxbgYe/3kMsMFjeLnggSUBw3UCdUMPC2Q9tWFm4DFsse+7
         qoXcP6qpAkQI1gM0ADXhkVaHx2wc76Bsvhm7HAAPlWHP2vYTy3U9PQ0KQblatw44f5f+
         XWaO5palMKvIF0cL3brRSbtoVKop8z3pmwIjQiQpeQGtfpzgk1DsWlmi1LlxQMDTkZHm
         B0nj5WU/ashSxHdWkEmZ+aVUslfhX9ph1H1UcLMCDRC4IwsqkzeWHTymwC8vwaXJlCFP
         m5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780427081; x=1781031881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sRIbUudhuC9QSnfpjJ5+uQ9wbLrhawuW8vZsptn08E=;
        b=HpxEpYpqqYMGTdo7BoXAxPJrhKOj2YihG65URcQBq3UEQ8UJAkj1CEQZif3FIWzKXo
         6+YNjZUoQR3HAraQiAvXfW+yjpPPXmhIqqWhbMYecyqn9hZsClrWeUs80VFWKMTxZR9x
         Rhsgfa7a5t3vwRjvKIpXLPcUb0P8iym7M2eTX8akoCYg0hLlJi0tuee9v5X6j2S3u9gd
         l8mHKE5LwV3fEhy5jqMHzyDqDSnM5SQz/aAlwNNIos4IIQM/dPPu10vFlzDS1RH+ZcUK
         bLw+Y8x+nNZJ4SF3nPwLA94ePdX1E+zFTjfxWmYfyVj2J+1+3WqLwV73HY7Cygcg9f5M
         +5qA==
X-Forwarded-Encrypted: i=1; AFNElJ/VIiPyhJs+W1RS//2kW2WiGzvWmMn6lMrH/V4Y92mUJXrBOH6+K2K6BMC7jlAkTQNg6LUxwEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAs3qTxeaAFwccr6VNp5sO5fXt+aCVanpQG9j1n7pMs0RxSOGF
	YhSP3JUbZ38y+/m2S8IUZdVSNWOiJUs02WMbW9YMQEXOpfASCQchDq01G8ieaeUf3priwUOreHl
	YULuwsQ==
X-Received: from pggh22.prod.google.com ([2002:a63:c016:0:b0:c80:1ab9:b111])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4d8c:b0:3a2:7ef4:81d9
 with SMTP id adf61e73a8af0-3b4977b0970mr139893637.44.1780427080666; Tue, 02
 Jun 2026 12:04:40 -0700 (PDT)
Date: Tue,  2 Jun 2026 19:03:43 +0000
In-Reply-To: <20260602190436.139591-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602190436.139591-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602190436.139591-4-kuniyu@google.com>
Subject: [PATCH v5 net-next 3/5] geneve: Pass struct geneve_dev to geneve_find_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294365-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:stephen@networkplumber.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FF736314A7

This is a prep patch to make a subsequent patch clean.

We will need to access geneve_dev->cfg.info.key.u.{ipv4,ipv6}.src
in geneve_find_sock() later and extend conditions there.

Let's pass down struct geneve from geneve_sock_add() to
geneve_find_sock() and flatten the conditional logic.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 7e8c3023842e..4f841eced028 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1040,35 +1040,41 @@ static void geneve_sock_release(struct geneve_dev *geneve)
 #endif
 }
 
-static struct geneve_sock *geneve_find_sock(struct geneve_net *gn,
-					    sa_family_t family,
-					    __be16 dst_port,
-					    bool gro_hint)
+static struct geneve_sock *geneve_find_sock(struct net *net,
+					    struct geneve_dev *geneve, bool ipv6)
 {
+	struct geneve_net *gn = net_generic(net, geneve_net_id);
+	struct ip_tunnel_info *info = &geneve->cfg.info;
+	sa_family_t family = ipv6 ? AF_INET6 : AF_INET;
+	bool gro_hint = geneve->cfg.gro_hint;
+	__be16 dst_port = info->key.tp_dst;
 	struct geneve_sock *gs;
 
 	list_for_each_entry(gs, &gn->sock_list, list) {
-		if (inet_sk(gs->sk)->inet_sport == dst_port &&
-		    geneve_get_sk_family(gs) == family &&
-		    gs->gro_hint == gro_hint) {
-			return gs;
-		}
+		if (inet_sk(gs->sk)->inet_sport != dst_port)
+			continue;
+
+		if (geneve_get_sk_family(gs) != family)
+			continue;
+
+		if (gs->gro_hint != gro_hint)
+			continue;
+
+		return gs;
 	}
+
 	return NULL;
 }
 
 static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 {
 	struct net *net = geneve->net;
-	struct geneve_net *gn = net_generic(net, geneve_net_id);
-	bool gro_hint = geneve->cfg.gro_hint;
 	struct geneve_dev_node *node;
 	struct geneve_sock *gs;
 	__u8 vni[3];
 	__u32 hash;
 
-	gs = geneve_find_sock(gn, ipv6 ? AF_INET6 : AF_INET,
-			      geneve->cfg.info.key.tp_dst, gro_hint);
+	gs = geneve_find_sock(net, geneve, ipv6);
 	if (gs) {
 		gs->refcnt++;
 		goto out;
@@ -1080,7 +1086,7 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 
 out:
 	gs->collect_md = geneve->cfg.collect_md;
-	gs->gro_hint = gro_hint;
+	gs->gro_hint = geneve->cfg.gro_hint;
 #if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6) {
 		rcu_assign_pointer(geneve->sock6, gs);
-- 
2.54.0.1013.g208068f2d8-goog


