Return-Path: <netdev+bounces-292502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHqJNHaUF2oiKAgAu9opvQ
	(envelope-from <netdev+bounces-292502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:03:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E37A5EB786
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7044E303A93E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8228C221F1F;
	Thu, 28 May 2026 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qc7QXyIM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299102248A3
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929824; cv=none; b=otWHdf+AKNfLWGAjCgpnPPuXClqgXTzyt6IpwBcu6iD9RTaDGA6Qq8B9ZYhdHSd0rnT14tptu3a7EbaTL4c0LzFsFgwcxIk+DO6uD2FTcznMOAmbKiX57OyUi0b/l29ASngX7eQK2aH2LkpoyZKHRqRT1lbgB2+M0X9VrTMLiKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929824; c=relaxed/simple;
	bh=pABNsvUPTRZZqku0XIt/xGhhTRpKsgMXZsJprF9uu8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FpHdjF7U0WHci6k2EdL5MjLEBfO09QK/VMKlX1m2md0oIrwgvR5UHWzd/s8lvraPWO8jyikJmVe1z4ykamF5K3uK+K/QrTJkzrh2ZXVWfzUi5MwjWCAX8d0kj8jknfJDhOm/9ktnF9549PgFNTmwks79Sk92TM9WCxwEglVKwQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qc7QXyIM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83ef22f8e8bso8102818b3a.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779929822; x=1780534622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGh4ERo58PbaHikJEsmf2jWU+6yuofYfnX8FF5yqumc=;
        b=qc7QXyIMFjL3pTBzJ0J9dvu1EbEM/Q14PfSNAqmh/GbJyEwO2TVr7sggrMt2Jk7stD
         mj5rMoDIySODD2svX40/DKjhlwsoKzJ5o0Z1ojWUtiGCPW95MC2guOlwfEGtcOfk5RMI
         cES71wpnBfqZux9b6fVIymLvH6OpCP9bP4JL0VtIoLeDtYTWf7TOm8SMXx+7QJXNRFxy
         eSeG3n1i9n1yzUn29mgCfOwuUbnWP7YvYvZf/5E/xxfVKoyv02NOQWL2lqKyOBTJDLjt
         /w9D8eee/hlCq8UwI562WjX02lumnSb4BiLnQHAN10HhEEuaQU5hdUatH4EvP1ytOfmA
         yrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929822; x=1780534622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGh4ERo58PbaHikJEsmf2jWU+6yuofYfnX8FF5yqumc=;
        b=DrxXXjcJuAp/yAsKzN9ByHHIjW/ftjZM11Nb0VT9FTBVcDZpjbzE6Rxqz+He2dfV0z
         iotPXMagOXg5EVgR/G5vCCrc2rxZWjQ6GvX6VDcQv6+VmQMVW666+vB1YjWMI6r2zv+I
         /PV7UTV7GNe7mz9pYbEnjGtGj1ZDtziGUwnwhfj8BSxgtAZTBFY0KTiM10u+o+8XH0Df
         u/GIy5LUKDBWNNgDbyCiWWuqD/q8c+r4kgYjV2tVMq4vvXGlOtCpPCkEMV8JqaeDeyC6
         5o5Vs3IJiFwOKo7zm+d5PxiuJsIBsG+oDt4dPfBJvtZ4Zz/B4AaGbv/HXI1CPe4Agd7V
         mcxA==
X-Forwarded-Encrypted: i=1; AFNElJ9zcatEE5Ai4ZqhZbx5CuwKN9sN6utKZi+vTf+z6PGTiCoykdgps9Hmb438/bcBN/wU4Sa1sxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRe4euT48W5eY+aR39DeWGUVT8RS3EX1Ip0Mc2ZRAfz+OmiDgq
	5h/mmd3DVBLl/dPsnish14z1H/i8HUrcXIw9cNNkI7hfu7/5u/i5VlkcL1sKWI8vp8u3o4ENB/f
	6InoeGw==
X-Received: from pfsu7.prod.google.com ([2002:a05:6a00:187:b0:82f:9be8:3f2c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1d9e:b0:835:38db:82f6
 with SMTP id d2e1a72fcca58-8415f69ea9cmr24750436b3a.36.1779929822196; Wed, 27
 May 2026 17:57:02 -0700 (PDT)
Date: Thu, 28 May 2026 00:56:46 +0000
In-Reply-To: <20260528005658.1756248-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528005658.1756248-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260528005658.1756248-4-kuniyu@google.com>
Subject: [PATCH v4 net-next 3/5] geneve: Pass struct geneve_dev to geneve_find_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292502-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3E37A5EB786
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.54.0.794.g4f17f83d09-goog


