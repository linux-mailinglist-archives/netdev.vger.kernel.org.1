Return-Path: <netdev+bounces-284679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIsyBw26+mnASAMAu9opvQ
	(envelope-from <netdev+bounces-284679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:48:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 831DF4D5FFC
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B758304185E
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 03:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A4829E10B;
	Wed,  6 May 2026 03:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOo/QlY9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5A23E320
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 03:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039304; cv=none; b=cYvRM1emRllIhZdkaVu2VPfIcguPAkIRmnMF4jrQtcRWuSIzmyGdrQlwf/KOOXuhcVpTfqsT/M/PJVJg/nKh29KdjKsrqgodu9sWkaYv+8yb4AzyUMDTIlpkYvuZ/UpPCAR+ZiC1dwkXdD5zFQ0I6e3lSQ24XlzZiNw4vL4lzoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039304; c=relaxed/simple;
	bh=kp9EmaELtFznK3tqcaykRyvjjiDWJWp6ZOMzJ57Cvl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThteeIJjhVWmuQ4oznFGALwb5txlWqfj7kiRqYE3YxgaVN/cTblUWxQHe4UgtqFU4bdb3YY6HSSQBa+uROZNNL+Lu7HHHDg9FFl1EXYjlJKx5MAfLAWjmoyaNpizQ9speGqntLcvquqrV9pniXqxHg89F6E8N44xaHV5oc4V8WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOo/QlY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC18C2BCB8;
	Wed,  6 May 2026 03:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778039304;
	bh=kp9EmaELtFznK3tqcaykRyvjjiDWJWp6ZOMzJ57Cvl4=;
	h=From:To:Cc:Subject:Date:From;
	b=mOo/QlY9F/RNJxDXZeCMe+2ndaufVSuM3LOS4b3aCWPoB8eW9ETY49Xc7Iy/OF8lu
	 nB51wNotZdgVjK1938OO+Oy2u6mKIJFvL4QobkoMNyHF9y0WhKK4BxCyr9Qp5LNhV3
	 eD20zyXxiNe6RGchNRsLByl1k2NKBCkECjfWfj2J0lRbX2oyfku+64Qs6gpUlQRS1w
	 7ehl2Y+BGfj+mEU2SOy3+RPs0AzT0d+91xbJVDIyuQZvR3KCE8mIvQ6HyF8TiiSnY2
	 O65322LZRmRuOMr+5UIWV+LtluuFwLTCTiYUsHyBj57VqX4QCSh8jGKvE124OuHZCx
	 M50cGLJGtsz4w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	daniel@iogearbox.net,
	skhawaja@google.com,
	sdf@fomichev.me,
	hawk@kernel.org
Subject: [PATCH net-next v3 1/2] net: page_pool: support dumping pps of a specific ifindex via Netlink
Date: Tue,  5 May 2026 20:48:20 -0700
Message-ID: <20260506034821.1710113-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 831DF4D5FFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,oracle.com,iogearbox.net,fomichev.me];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-284679-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iogearbox.net:email,fomichev.me:email]

NIPA tries to make sure that HW tests don't modify system state.
It saves the state of page pools, too. Now that I write this commit
message I realize that this is impractical since page pool IDs and
state will get legitimately changed by the tests. But I already
spent a couple of hours implementing the filtering, so..

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - regen with latest YNL
v2: https://lore.kernel.org/20260504214336.613107-1-kuba@kernel.org
 - adjust ynltool to pass empty req pointer now
v1: https://lore.kernel.org/20260319035649.2396137-1-kuba@kernel.org
---
CC: donald.hunter@gmail.com
CC: matttbe@kernel.org
CC: chuck.lever@oracle.com
CC: daniel@iogearbox.net
CC: skhawaja@google.com
CC: sdf@fomichev.me
CC: hawk@kernel.org
---
 Documentation/netlink/specs/netdev.yaml |  6 ++++
 net/core/netdev-genl-gen.c              | 38 ++++++++++++++------
 net/core/page_pool_user.c               | 47 +++++++++++++++++++++++--
 tools/net/ynl/ynltool/page-pool.c       |  6 ++--
 4 files changed, 82 insertions(+), 15 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index b93beb247a11..a1f4c5a561e9 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -649,6 +649,9 @@ doc: >-
             - dmabuf
             - io-uring
       dump:
+        request:
+          attributes:
+            - ifindex
         reply: *pp-reply
       config-cond: page-pool
     -
@@ -692,6 +695,9 @@ doc: >-
             - recycle-ring-full
             - recycle-released-refcnt
       dump:
+        request:
+          attributes:
+            - info
         reply: *pp-stats-reply
       config-cond: page-pool-stats
     -
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 81aecb5d3bc5..c7e138bfe345 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -51,14 +51,28 @@ static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1
 
 /* NETDEV_CMD_PAGE_POOL_GET - do */
 #ifdef CONFIG_PAGE_POOL
-static const struct nla_policy netdev_page_pool_get_nl_policy[NETDEV_A_PAGE_POOL_ID + 1] = {
+static const struct nla_policy netdev_page_pool_get_do_nl_policy[NETDEV_A_PAGE_POOL_ID + 1] = {
 	[NETDEV_A_PAGE_POOL_ID] = NLA_POLICY_FULL_RANGE(NLA_UINT, &netdev_a_page_pool_id_range),
 };
 #endif /* CONFIG_PAGE_POOL */
 
+/* NETDEV_CMD_PAGE_POOL_GET - dump */
+#ifdef CONFIG_PAGE_POOL
+static const struct nla_policy netdev_page_pool_get_dump_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1] = {
+	[NETDEV_A_PAGE_POOL_IFINDEX] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_page_pool_ifindex_range),
+};
+#endif /* CONFIG_PAGE_POOL */
+
 /* NETDEV_CMD_PAGE_POOL_STATS_GET - do */
 #ifdef CONFIG_PAGE_POOL_STATS
-static const struct nla_policy netdev_page_pool_stats_get_nl_policy[NETDEV_A_PAGE_POOL_STATS_INFO + 1] = {
+static const struct nla_policy netdev_page_pool_stats_get_do_nl_policy[NETDEV_A_PAGE_POOL_STATS_INFO + 1] = {
+	[NETDEV_A_PAGE_POOL_STATS_INFO] = NLA_POLICY_NESTED(netdev_page_pool_info_nl_policy),
+};
+#endif /* CONFIG_PAGE_POOL_STATS */
+
+/* NETDEV_CMD_PAGE_POOL_STATS_GET - dump */
+#ifdef CONFIG_PAGE_POOL_STATS
+static const struct nla_policy netdev_page_pool_stats_get_dump_nl_policy[NETDEV_A_PAGE_POOL_STATS_INFO + 1] = {
 	[NETDEV_A_PAGE_POOL_STATS_INFO] = NLA_POLICY_NESTED(netdev_page_pool_info_nl_policy),
 };
 #endif /* CONFIG_PAGE_POOL_STATS */
@@ -138,28 +152,32 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 	{
 		.cmd		= NETDEV_CMD_PAGE_POOL_GET,
 		.doit		= netdev_nl_page_pool_get_doit,
-		.policy		= netdev_page_pool_get_nl_policy,
+		.policy		= netdev_page_pool_get_do_nl_policy,
 		.maxattr	= NETDEV_A_PAGE_POOL_ID,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
-		.cmd	= NETDEV_CMD_PAGE_POOL_GET,
-		.dumpit	= netdev_nl_page_pool_get_dumpit,
-		.flags	= GENL_CMD_CAP_DUMP,
+		.cmd		= NETDEV_CMD_PAGE_POOL_GET,
+		.dumpit		= netdev_nl_page_pool_get_dumpit,
+		.policy		= netdev_page_pool_get_dump_nl_policy,
+		.maxattr	= NETDEV_A_PAGE_POOL_IFINDEX,
+		.flags		= GENL_CMD_CAP_DUMP,
 	},
 #endif /* CONFIG_PAGE_POOL */
 #ifdef CONFIG_PAGE_POOL_STATS
 	{
 		.cmd		= NETDEV_CMD_PAGE_POOL_STATS_GET,
 		.doit		= netdev_nl_page_pool_stats_get_doit,
-		.policy		= netdev_page_pool_stats_get_nl_policy,
+		.policy		= netdev_page_pool_stats_get_do_nl_policy,
 		.maxattr	= NETDEV_A_PAGE_POOL_STATS_INFO,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
-		.cmd	= NETDEV_CMD_PAGE_POOL_STATS_GET,
-		.dumpit	= netdev_nl_page_pool_stats_get_dumpit,
-		.flags	= GENL_CMD_CAP_DUMP,
+		.cmd		= NETDEV_CMD_PAGE_POOL_STATS_GET,
+		.dumpit		= netdev_nl_page_pool_stats_get_dumpit,
+		.policy		= netdev_page_pool_stats_get_dump_nl_policy,
+		.maxattr	= NETDEV_A_PAGE_POOL_STATS_INFO,
+		.flags		= GENL_CMD_CAP_DUMP,
 	},
 #endif /* CONFIG_PAGE_POOL_STATS */
 	{
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index ee5060d8eec0..01509d1b3cba 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -79,7 +79,7 @@ struct page_pool_dump_cb {
 
 static int
 netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
-			     pp_nl_fill_cb fill)
+			     pp_nl_fill_cb fill, struct nlattr *ifindex_attr)
 {
 	struct page_pool_dump_cb *state = (void *)cb->ctx;
 	const struct genl_info *info = genl_info_dump(cb);
@@ -88,9 +88,17 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	struct page_pool *pool;
 	int err = 0;
 
+	if (ifindex_attr)
+		state->ifindex = nla_get_u32(ifindex_attr);
+
 	rtnl_lock();
 	mutex_lock(&page_pools_lock);
 	for_each_netdev_dump(net, netdev, state->ifindex) {
+		/* Either the provided ifindex doesn't exist or done dumping */
+		if (ifindex_attr &&
+		    netdev->ifindex != nla_get_u32(ifindex_attr))
+			break;
+
 		hlist_for_each_entry(pool, &netdev->page_pools, user.list) {
 			if (state->pp_id && state->pp_id < pool->user.id)
 				continue;
@@ -206,10 +214,40 @@ int netdev_nl_page_pool_stats_get_doit(struct sk_buff *skb,
 	return netdev_nl_page_pool_get_do(info, id, page_pool_nl_stats_fill);
 }
 
+static const struct netlink_range_validation page_pool_ifindex_range = {
+	.min	= 1ULL,
+	.max	= S32_MAX,
+};
+
+static const struct nla_policy
+page_pool_stat_info_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1] = {
+	[NETDEV_A_PAGE_POOL_IFINDEX] =
+		NLA_POLICY_FULL_RANGE(NLA_U32, &page_pool_ifindex_range),
+};
+
 int netdev_nl_page_pool_stats_get_dumpit(struct sk_buff *skb,
 					 struct netlink_callback *cb)
 {
-	return netdev_nl_page_pool_get_dump(skb, cb, page_pool_nl_stats_fill);
+	struct nlattr *tb[ARRAY_SIZE(page_pool_stat_info_policy)];
+	const struct genl_info *info = genl_info_dump(cb);
+	struct nlattr *ifindex_attr = NULL;
+
+	if (info->attrs[NETDEV_A_PAGE_POOL_STATS_INFO]) {
+		struct nlattr *nest;
+		int err;
+
+		nest = info->attrs[NETDEV_A_PAGE_POOL_STATS_INFO];
+		err = nla_parse_nested(tb, ARRAY_SIZE(tb) - 1, nest,
+				       page_pool_stat_info_policy,
+				       info->extack);
+		if (err)
+			return err;
+
+		ifindex_attr = tb[NETDEV_A_PAGE_POOL_IFINDEX];
+	}
+
+	return netdev_nl_page_pool_get_dump(skb, cb, page_pool_nl_stats_fill,
+					    ifindex_attr);
 }
 
 static int
@@ -305,7 +343,10 @@ int netdev_nl_page_pool_get_doit(struct sk_buff *skb, struct genl_info *info)
 int netdev_nl_page_pool_get_dumpit(struct sk_buff *skb,
 				   struct netlink_callback *cb)
 {
-	return netdev_nl_page_pool_get_dump(skb, cb, page_pool_nl_fill);
+	const struct genl_info *info = genl_info_dump(cb);
+
+	return netdev_nl_page_pool_get_dump(skb, cb, page_pool_nl_fill,
+					    info->attrs[NETDEV_A_PAGE_POOL_IFINDEX]);
 }
 
 int page_pool_list(struct page_pool *pool)
diff --git a/tools/net/ynl/ynltool/page-pool.c b/tools/net/ynl/ynltool/page-pool.c
index 4b24492abab7..9487eda6b3aa 100644
--- a/tools/net/ynl/ynltool/page-pool.c
+++ b/tools/net/ynl/ynltool/page-pool.c
@@ -327,7 +327,9 @@ static void aggregate_device_stats(struct pp_stats_array *a,
 
 static int do_stats(int argc, char **argv)
 {
+	struct netdev_page_pool_stats_get_req_dump pp_stat_req = {};
 	struct netdev_page_pool_stats_get_list *pp_stats;
+	struct netdev_page_pool_get_req_dump pp_req = {};
 	struct netdev_page_pool_get_list *pools;
 	enum {
 		GROUP_BY_DEVICE,
@@ -374,14 +376,14 @@ static int do_stats(int argc, char **argv)
 		return -1;
 	}
 
-	pools = netdev_page_pool_get_dump(ys);
+	pools = netdev_page_pool_get_dump(ys, &pp_req);
 	if (!pools) {
 		p_err("failed to get page pools: %s", ys->err.msg);
 		ret = -1;
 		goto exit_close;
 	}
 
-	pp_stats = netdev_page_pool_stats_get_dump(ys);
+	pp_stats = netdev_page_pool_stats_get_dump(ys, &pp_stat_req);
 	if (!pp_stats) {
 		p_err("failed to get page pool stats: %s", ys->err.msg);
 		ret = -1;
-- 
2.54.0


