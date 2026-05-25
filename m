Return-Path: <netdev+bounces-291222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CPkMVaVE2oqDwcAu9opvQ
	(envelope-from <netdev+bounces-291222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 02:18:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ADD5C5010
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 02:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 816EE301303F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 00:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080A11D5174;
	Mon, 25 May 2026 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="caGI1DrI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757F184
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779668275; cv=none; b=MHlRKUHi9txzfbhrpb6D5+Po9jqs0evs0ZGqcRFRkJjQq/xmwrIBc+Um7WtSN3B+mK63BEPdMjPcsElclCuucyVhiv+P3Jbnby1IomRMfQxWvZhAYVidlx0cGwljhU+yuOfxBhozQWfl+odch1xXi7kTBl9T1vl1rZZTo+48Br4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779668275; c=relaxed/simple;
	bh=Y4+UIpcDLEr5sG3IN4JfWgsWsPtkzxPTHUA3fEo3D1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QfiIlbpFr1RfZqf31Cj976MvjqBGgcV/Ih0zGo1RfZhIExRY4SbN9ZOY1Pp/OFjIFluGAk0VSePBVVLv9VddWjYKqskgSLW3iyfJDHddAUyDrwp1HJfS6MZSHYFasdaExfG+D+pVACK5pVn+CCQEh97TMdzKbhkoI+g7w6gem94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=caGI1DrI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3663d5e9bf4so8844161a91.1
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 17:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779668274; x=1780273074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gWSTvOF/gzpYSCqq/FR9TOCszX7XxtE0WLsWHlZ8hBs=;
        b=caGI1DrIKgJPuxe2Ker2NYSKnvD8dRlYYPK61au3qQRFBpldIG4R7ZcM+8eXB79n6v
         ljBFvOmzS+xzUdDGnIdEQlVJTd1DCR8LV56WagaNO0bvjjZ9I551dNZSiIZmOPO7AJtA
         u02+94Dadp4cLZa1kuG/75b/79S5WbAsyqqtqHQzc6kmzQg3eKLi3XGCKb2sUhr3Qcfq
         qlLqpOrBW5ssD8ATQQgtlq0asQJ9UfmbCdecI50NL3oUeLiYixx/k4B3ctx5AShwEXRG
         BI2na2W69Q1YCTmyiW3KJVkCpO+BYW9FCKqkVAOYqnNxxxWs9+oOmK+LHgeeJFK11/bY
         ZvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779668274; x=1780273074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWSTvOF/gzpYSCqq/FR9TOCszX7XxtE0WLsWHlZ8hBs=;
        b=G9GuixTvDMYCzqT2CgAkR1f2l99/3TX1CavYSOzU7x1hIPxD3/b01oam7fBAjwGkYZ
         ZT/NjyzhGy82xfDPnBlkzWtuWorUUjzZ1s+6QkAux6XmFiJ3NuI1QMBfvJ1haTe46h4t
         h8kZNTsWXqrnCltOr8c5ByUEiH3kwDAlfIAswXA05sYZ/HFyjTgCCKiVKOWAeIBUUiPW
         4FkRMfD/W+BVz1oQy4n0/qRY+Z/hl6/ZzgXDm0Uf1S+WajHsuC3/oL0siMQ2xGNXmY1X
         CsvV2TBbHSsdLaYFu4MVFvd2AYlnE3OC9t265Ho/MZ1l3Utxh2jaBFG7NY0t6mRMD3Ue
         ENmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7fUOYLV9r3KSjbpIiidLlA/k2xO2LuVu4adTD4IXPWG4VmOg8zRs/wItC1/dZJBii3B6Ayys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjg0Y6cBCEN3/pms3OeBX2vp5nC9DyrxkdXCoHfl2FHxmemBR
	N/WT/h3cJQWYhFAvQ1evtmlT3yAOvZIN8MNq2p991IinEpaaaqyamFMoDJgFlEQmkrIAMhfgP3X
	pZIqjnQ==
X-Received: from pfbmu28.prod.google.com ([2002:a05:6a00:6e9c:b0:835:4037:1869])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:32ca:b0:829:7e6d:cf22
 with SMTP id d2e1a72fcca58-8415f615109mr10610756b3a.43.1779668273776; Sun, 24
 May 2026 17:17:53 -0700 (PDT)
Date: Mon, 25 May 2026 00:17:21 +0000
In-Reply-To: <20260525001745.1251640-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525001745.1251640-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525001745.1251640-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 3/5] geneve: Pass struct geneve_dev to geneve_find_sock().
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291222-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.942];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 42ADD5C5010
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
2.54.0.746.g67dd491aae-goog


