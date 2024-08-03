Return-Path: <netdev+bounces-115476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68863946768
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 06:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE821C20CBE
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 04:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF8A74068;
	Sat,  3 Aug 2024 04:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="herrzlyu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A56D13AA27
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 04:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659217; cv=none; b=ExlWoWuRHetPIhRHiHn7l463MsjeNzKSU+6T/QSqgshahwZAxfUQaYawxtd23QPgRfTTUQmNkZ7qWEMthiy7r29mE+eDbv0stgQSc1BctHMORARnSTTLyn4cWWbearx8dSsugbqqykCqeTtADqEEnyJqkjfTYASxQTMyOkjCDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659217; c=relaxed/simple;
	bh=dsI44HnnbM8/pEEg9gFV1THg4aAyCd5fuqN/kU8GyDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IC+8y9gE54CXjXa6JvlF1AYosUViTPdQE8uhWRQK1HMoNYryQ9E+AZVTC9u8EH/5diwhKiQloqtZZqLo9OFlkRaIwwNCUI5z31FOqpGsoqOuBI/9tO0RNiuZcIGavUrq1WzkQ/zDkYYPsAyp+32tY2oPtiMw3AHFO1Aj2ZJRWcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=herrzlyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78093C4AF0A;
	Sat,  3 Aug 2024 04:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722659217;
	bh=dsI44HnnbM8/pEEg9gFV1THg4aAyCd5fuqN/kU8GyDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=herrzlyut3i5i9xc0SYCOd4ZMMyHU+tFQyBmRSiCjBfr4AyDaRqkQSPbHgPd/FT2Q
	 PvjmjPQBAviChJ52kpSPO5CZkW/f4eeKCX/LZuYbLDq/Ne/rKkJE0N+z8k1Oq7g5Ri
	 2ifJ5Tx7V3D78cgd9NHnHfrl8/us902PBrISwuiUKRlXAm17xjNAClLr0pGCfNRfsY
	 bH+6P4n0j6rdO6J1HKMUw1gAgv151vDMMrOYrg6r4T+JD8r36iPHnoZe9M/gONPIk9
	 MxKsPYLmoVkzkDAixbk/brj4wVqSrm5U6Pv7o2W1G49E5GRBt/oGsmJUHwLoAicOgh
	 x8BJEHtdIWccA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dxu@dxuuu.xyz,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com,
	gal.pressman@linux.dev,
	tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 09/12] ethtool: rss: support dumping RSS contexts
Date: Fri,  2 Aug 2024 21:26:21 -0700
Message-ID: <20240803042624.970352-10-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803042624.970352-1-kuba@kernel.org>
References: <20240803042624.970352-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we track RSS contexts in the core we can easily dump
them. This is a major introspection improvement, as previously
the only way to find all contexts would be to try all ids
(of which there may be 2^32 - 1).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml |   9 +-
 net/ethtool/netlink.c                    |   2 +
 net/ethtool/netlink.h                    |   2 +
 net/ethtool/rss.c                        | 133 +++++++++++++++++++++++
 4 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index ea21fe135b97..cf69eedae51d 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1749,12 +1749,12 @@ doc: Partial family for Ethtool Netlink.
 
       attribute-set: rss
 
-      do: &rss-get-op
+      do:
         request:
           attributes:
             - header
             - context
-        reply:
+        reply: &rss-reply
           attributes:
             - header
             - context
@@ -1762,6 +1762,11 @@ doc: Partial family for Ethtool Netlink.
             - indir
             - hkey
             - input_xfrm
+      dump:
+        request:
+          attributes:
+            - header
+        reply: *rss-reply
     -
       name: plca-get-cfg
       doc: Get PLCA params.
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index cb1eea00e349..041548e5f5e6 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -1128,6 +1128,8 @@ static const struct genl_ops ethtool_genl_ops[] = {
 	{
 		.cmd	= ETHTOOL_MSG_RSS_GET,
 		.doit	= ethnl_default_doit,
+		.start	= ethnl_rss_dump_start,
+		.dumpit	= ethnl_rss_dumpit,
 		.policy = ethnl_rss_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_rss_get_policy) - 1,
 	},
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 46ec273a87c5..919371383b23 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -464,6 +464,8 @@ int ethnl_tunnel_info_doit(struct sk_buff *skb, struct genl_info *info);
 int ethnl_tunnel_info_start(struct netlink_callback *cb);
 int ethnl_tunnel_info_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info);
+int ethnl_rss_dump_start(struct netlink_callback *cb);
+int ethnl_rss_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 
 extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 023782ca1230..62e7b6fe605d 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -208,6 +208,139 @@ static void rss_cleanup_data(struct ethnl_reply_data *reply_base)
 	kfree(data->indir_table);
 }
 
+struct rss_nl_dump_ctx {
+	unsigned long		ifindex;
+	unsigned long		ctx_idx;
+
+	unsigned int		one_ifindex;
+};
+
+static struct rss_nl_dump_ctx *rss_dump_ctx(struct netlink_callback *cb)
+{
+	NL_ASSERT_DUMP_CTX_FITS(struct rss_nl_dump_ctx);
+
+	return (struct rss_nl_dump_ctx *)cb->ctx;
+}
+
+int ethnl_rss_dump_start(struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct rss_nl_dump_ctx *ctx = rss_dump_ctx(cb);
+	struct ethnl_req_info req_info = {};
+	struct nlattr **tb = info->attrs;
+	int ret;
+
+	/* Filtering by context not supported */
+	if (tb[ETHTOOL_A_RSS_CONTEXT]) {
+		NL_SET_BAD_ATTR(info->extack, tb[ETHTOOL_A_RSS_CONTEXT]);
+		return -EINVAL;
+	}
+
+	ret = ethnl_parse_header_dev_get(&req_info,
+					 tb[ETHTOOL_A_RSS_HEADER],
+					 sock_net(cb->skb->sk), cb->extack,
+					 false);
+	if (req_info.dev) {
+		ctx->one_ifindex = req_info.dev->ifindex;
+		ctx->ifindex = ctx->one_ifindex;
+		ethnl_parse_header_dev_put(&req_info);
+		req_info.dev = NULL;
+	}
+
+	return ret;
+}
+
+static int
+rss_dump_one_ctx(struct sk_buff *skb, struct netlink_callback *cb,
+		 struct net_device *dev, u32 rss_context)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct rss_reply_data data = {};
+	struct rss_req_info req = {};
+	void *ehdr;
+	int ret;
+
+	req.rss_context = rss_context;
+
+	ehdr = ethnl_dump_put(skb, cb, ETHTOOL_MSG_RSS_GET_REPLY);
+	if (!ehdr)
+		return -EMSGSIZE;
+
+	ret = ethnl_fill_reply_header(skb, dev, ETHTOOL_A_RSS_HEADER);
+	if (ret < 0)
+		goto err_cancel;
+
+	if (!rss_context)
+		ret = rss_prepare_get(&req, dev, &data, info);
+	else
+		ret = rss_prepare_ctx(&req, dev, &data, info);
+	if (ret)
+		goto err_cancel;
+
+	ret = rss_fill_reply(skb, &req.base, &data.base);
+	if (ret)
+		goto err_cleanup;
+	genlmsg_end(skb, ehdr);
+
+	rss_cleanup_data(&data.base);
+	return 0;
+
+err_cleanup:
+	rss_cleanup_data(&data.base);
+err_cancel:
+	genlmsg_cancel(skb, ehdr);
+	return ret;
+}
+
+static int
+rss_dump_one_dev(struct sk_buff *skb, struct netlink_callback *cb,
+		 struct net_device *dev)
+{
+	struct rss_nl_dump_ctx *ctx = rss_dump_ctx(cb);
+	int ret;
+
+	if (!dev->ethtool_ops->get_rxfh)
+		return 0;
+
+	if (!ctx->ctx_idx) {
+		ret = rss_dump_one_ctx(skb, cb, dev, 0);
+		if (ret)
+			return ret;
+		ctx->ctx_idx++;
+	}
+
+	for (; xa_find(&dev->ethtool->rss_ctx, &ctx->ctx_idx,
+		       ULONG_MAX, XA_PRESENT); ctx->ctx_idx++) {
+		ret = rss_dump_one_ctx(skb, cb, dev, ctx->ctx_idx);
+		if (ret)
+			return ret;
+	}
+	ctx->ctx_idx = 0;
+
+	return 0;
+}
+
+int ethnl_rss_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct rss_nl_dump_ctx *ctx = rss_dump_ctx(cb);
+	struct net *net = sock_net(skb->sk);
+	struct net_device *dev;
+	int ret = 0;
+
+	rtnl_lock();
+	for_each_netdev_dump(net, dev, ctx->ifindex) {
+		if (ctx->one_ifindex && ctx->one_ifindex != ctx->ifindex)
+			break;
+
+		ret = rss_dump_one_dev(skb, cb, dev);
+		if (ret)
+			break;
+	}
+	rtnl_unlock();
+
+	return ret;
+}
+
 const struct ethnl_request_ops ethnl_rss_request_ops = {
 	.request_cmd		= ETHTOOL_MSG_RSS_GET,
 	.reply_cmd		= ETHTOOL_MSG_RSS_GET_REPLY,
-- 
2.45.2


