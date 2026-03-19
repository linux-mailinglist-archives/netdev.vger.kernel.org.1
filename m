Return-Path: <netdev+bounces-269292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJpfIxx0u2mckQIAu9opvQ
	(envelope-from <netdev+bounces-269292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:57:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6922C5C04
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F5830A457C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274542EFDA2;
	Thu, 19 Mar 2026 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdHMh+nw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AFF1F16B;
	Thu, 19 Mar 2026 03:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773892633; cv=none; b=kyPl78vdWPHQIG+6CNQFzwHrBaNUdpdsshd9DWZYYPkWmD+GamUUi4MuDF0oBeZPCwuqq1g4tcYAWefeESmgyUtNy1KIwsBPqee1bAzw3vJ1MtkzUBeUvd1Irx1cyZoDT4/oj5hlfhDxv50iGYHj5B0zCdaw/SerCGBFubMV0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773892633; c=relaxed/simple;
	bh=6P99uQ6PSISkbdMjZiSifS+jdrotMOv3OezRoOWBeok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UkUqp5gnYg6gPzLK1PLeTwYvWk8c5KpVBTjEIVx9lTvowX0Rx2mULLLF9c3EYqjt1ASNEjbaxMo9qCwyntTAScV4S6sxqDemDwqRPOIetZqJq9hGnKmZiEr1VceLc9rB6z+V/ippRuAbglwsIwTrRjbvMVg3dU3f02pWBy3yuLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdHMh+nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D3EC19425;
	Thu, 19 Mar 2026 03:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773892632;
	bh=6P99uQ6PSISkbdMjZiSifS+jdrotMOv3OezRoOWBeok=;
	h=From:To:Cc:Subject:Date:From;
	b=MdHMh+nwLGzrC/DYmdDk2LfNepBxTjlVWef24An7kChgHqyyLNUuSvd6Epi53NTQ5
	 3LwmBF799Ca77K44PKX624qrsrKlbem5KeP4rwjSrzh98RE6N+Fb2PVURnKPZrG1/9
	 vZ19EUe0Vn39V9N5FS+2AftyXKoHzDwzfVUmI3n20q7dN5yC2+2wGv70aeBHsyo6sZ
	 LknM81or8VqU+jgpTuXO9U3l3EGfXKc1Pai5zoc+CqC/qPEgGOV/vwzbAaBvAck/GN
	 7FHE8kXUYpq5vi96BHeotm7oezuZu9i71WlOU306/E3iA6GMVJGUxMOGkiYXBzxh2B
	 53/+IEHojtGkw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	hawk@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] net: page_pool: support dumping pps of a specific ifindex via Netlink
Date: Wed, 18 Mar 2026 20:56:47 -0700
Message-ID: <20260319035649.2396137-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,oracle.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-269292-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.853];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC6922C5C04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NIPA tries to make sure that HW tests don't modify system state.
It saves the state of page pools, too. Now that I write this commit
message I realize that this is impractical since page pool IDs and
state will get legitimately changed by the tests. But I already
spent a couple of hours implementing the filtering, so..

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml |  6 ++++
 net/core/netdev-genl-gen.c              | 30 ++++++++++++----
 net/core/page_pool_user.c               | 47 +++++++++++++++++++++++--
 3 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 596c306ce52b..f998cc64323c 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -620,6 +620,9 @@ doc: >-
             - dmabuf
             - io-uring
       dump:
+        request:
+          attributes:
+            - ifindex
         reply: *pp-reply
       config-cond: page-pool
     -
@@ -663,6 +666,9 @@ doc: >-
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
index ba673e81716f..22cbbdc40c6a 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -48,6 +48,11 @@ static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1
 static const struct nla_policy netdev_page_pool_get_nl_policy[NETDEV_A_PAGE_POOL_ID + 1] = {
 	[NETDEV_A_PAGE_POOL_ID] = NLA_POLICY_FULL_RANGE(NLA_UINT, &netdev_a_page_pool_id_range),
 };
+
+/* NETDEV_CMD_PAGE_POOL_GET - dump */
+static const struct nla_policy netdev_page_pool_get_dump_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1] = {
+	[NETDEV_A_PAGE_POOL_IFINDEX] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_page_pool_ifindex_range),
+};
 #endif /* CONFIG_PAGE_POOL */
 
 /* NETDEV_CMD_PAGE_POOL_STATS_GET - do */
@@ -55,6 +60,15 @@ static const struct nla_policy netdev_page_pool_get_nl_policy[NETDEV_A_PAGE_POOL
 static const struct nla_policy netdev_page_pool_stats_get_nl_policy[NETDEV_A_PAGE_POOL_STATS_INFO + 1] = {
 	[NETDEV_A_PAGE_POOL_STATS_INFO] = NLA_POLICY_NESTED(netdev_page_pool_info_nl_policy),
 };
+
+/* NETDEV_CMD_PAGE_POOL_STATS_GET - dump */
+static const struct nla_policy netdev_page_pool_stats_get_dump_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1] = {
+	[NETDEV_A_PAGE_POOL_IFINDEX] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_page_pool_ifindex_range),
+};
+
+static const struct nla_policy netdev_page_pool_stats_get_dump_nl_policy[NETDEV_A_PAGE_POOL_STATS_INFO + 1] = {
+	[NETDEV_A_PAGE_POOL_STATS_INFO] = NLA_POLICY_NESTED(netdev_page_pool_stats_get_dump_info_nl_policy),
+};
 #endif /* CONFIG_PAGE_POOL_STATS */
 
 /* NETDEV_CMD_QUEUE_GET - do */
@@ -130,9 +144,11 @@ static const struct genl_split_ops netdev_nl_ops[] = {
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
@@ -144,9 +160,11 @@ static const struct genl_split_ops netdev_nl_ops[] = {
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
-- 
2.53.0


