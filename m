Return-Path: <netdev+bounces-286387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLcUBrTcAGoXNwEAu9opvQ
	(envelope-from <netdev+bounces-286387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:29:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A78D1505FB3
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19FC3301F486
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55D5330301;
	Sun, 10 May 2026 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI0WKghc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917DF32ED39;
	Sun, 10 May 2026 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778441350; cv=none; b=tBPi1Ltm3eUD5s5TgSRjT199qtK3NHzagZE2yBvfhEG+ANGfwG+1x5NTnN+SWiVzE4t0UdIuM16UKIFfCsIcWMxZgKq5doCUIyVJT4Ur2XraBzN5/iYKBN9kU77a9e3EAiYEtZoZL9tL7JyDTcBxxDHaUWDHVOWIR7QGUkC3Uww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778441350; c=relaxed/simple;
	bh=NTXa2OzAR6LsAdljQYCQySpolQ9D92t/0E8nlVDX1iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OagAT8QQmYCY7i/StOv/0MSk8c1RRQIoCCzeuF78me4VlxVgydPUge40RXnVG4k+pEb2Uz3xsmcIWtyJqQ2ZBSsjKoinagaQvDyEGKrDKUzAetxfeyjXAq/LComrgw7eEVWoGjh536rFQYxfjCyAyP7ujwvzjkwFx3HKwc594kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI0WKghc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FF6C2BCB8;
	Sun, 10 May 2026 19:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778441350;
	bh=NTXa2OzAR6LsAdljQYCQySpolQ9D92t/0E8nlVDX1iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QI0WKghcpPlLzUriSz6h+EQ/s6S518f0NVXlc2uVF8d2SgfGrDPDOi2ZZQp01DM0i
	 CWm5qqZ11ILs1zNuuVr5m1xEad7ESo6wTxzIEXRLfSZ141+i9AXZ+cUcf6D/wfIdcK
	 fTY0qq68+4wxgD9gIqSbI1Z8HZF98qTm1kdkuVs46VwhVKmAPFSRikVCDbnrrvtyUk
	 7YS5CHQA3rPmgi4OeK98Dx4IASsihL0PWYtM0Oi040B2CBXg3bgPylMuHGPmM7LPW2
	 Sj4nkpl9zU6aweDds8eWxkpIgkM0dBvK1PK6Kq3ARnP+bTFzdGAuC9V07kY9YCtgzD
	 6pXGKiZ9BgLjg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 03/10] net: shaper: reject duplicate leaves in GROUP request
Date: Sun, 10 May 2026 12:28:57 -0700
Message-ID: <20260510192904.3987113-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510192904.3987113-1-kuba@kernel.org>
References: <20260510192904.3987113-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A78D1505FB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286387-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

net_shaper_nl_group_doit() does not deduplicate NET_SHAPER_A_LEAVES
entries. When userspace supplies the same leaf handle twice, the same
old-parent pointer lands twice in old_nodes[]. The cleanup loop double
frees the parent. Of course the same parent may still be in old_nodes[]
twice if we are moving multiple of its leaves.

Note that this patch also implicitly fixes the fact that the
i >= leaves_count path forgets to set ret.

Fixes: 5d5d4700e75d ("net-shapers: implement NL group operation")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/shaper/shaper.c | 60 +++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 86319ddbf290..c8960821cf23 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -941,6 +941,46 @@ static int net_shaper_handle_cmp(const struct net_shaper_handle *a,
 	return memcmp(a, b, sizeof(*a));
 }
 
+static int net_shaper_parse_leaves(struct net_shaper_binding *binding,
+				   struct genl_info *info,
+				   const struct net_shaper *node,
+				   struct net_shaper *leaves,
+				   int leaves_count)
+{
+	struct nlattr *attr;
+	int i, j, ret, rem;
+
+	i = 0;
+	nla_for_each_attr_type(attr, NET_SHAPER_A_LEAVES,
+			       genlmsg_data(info->genlhdr),
+			       genlmsg_len(info->genlhdr), rem) {
+		if (WARN_ON_ONCE(i >= leaves_count))
+			return -EINVAL;
+
+		ret = net_shaper_parse_leaf(binding, attr, info,
+					    node, &leaves[i]);
+		if (ret)
+			return ret;
+
+		/* Reject duplicates */
+		for (j = 0; j < i; j++) {
+			if (net_shaper_handle_cmp(&leaves[i].handle,
+						  &leaves[j].handle))
+				continue;
+
+			NL_SET_ERR_MSG_ATTR_FMT(info->extack, attr,
+						"Duplicate leaf shaper %d:%d",
+						leaves[i].handle.scope,
+						leaves[i].handle.id);
+			return -EINVAL;
+		}
+
+		i++;
+	}
+
+	return 0;
+}
+
 static int net_shaper_parent_from_leaves(int leaves_count,
 					 const struct net_shaper *leaves,
 					 struct net_shaper *node,
@@ -1197,10 +1237,9 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 	struct net_shaper **old_nodes, *leaves, node = {};
 	struct net_shaper_hierarchy *hierarchy;
 	struct net_shaper_binding *binding;
-	int i, ret, rem, leaves_count;
+	int i, ret, leaves_count;
 	int old_nodes_count = 0;
 	struct sk_buff *msg;
-	struct nlattr *attr;
 
 	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_LEAVES))
 		return -EINVAL;
@@ -1228,19 +1267,10 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto free_leaves;
 
-	i = 0;
-	nla_for_each_attr_type(attr, NET_SHAPER_A_LEAVES,
-			       genlmsg_data(info->genlhdr),
-			       genlmsg_len(info->genlhdr), rem) {
-		if (WARN_ON_ONCE(i >= leaves_count))
-			goto free_leaves;
-
-		ret = net_shaper_parse_leaf(binding, attr, info,
-					    &node, &leaves[i]);
-		if (ret)
-			goto free_leaves;
-		i++;
-	}
+	ret = net_shaper_parse_leaves(binding, info, &node,
+				      leaves, leaves_count);
+	if (ret)
+		goto free_leaves;
 
 	/* Prepare the msg reply in advance, to avoid device operation
 	 * rollback on allocation failure.
-- 
2.54.0


