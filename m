Return-Path: <netdev+bounces-116227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B75F694985D
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F356B238C8
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE2158DC5;
	Tue,  6 Aug 2024 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxvJWM2K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED19158DBF
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972824; cv=none; b=FbPUPFO1f5dj7BuJ7LtLq07MySbq+m89UsumQiKvrsytndaJu9vty8rOC7rAgA/YgHHxfWV3aqwjcvhpF1bIx/XmFsxL1qgdWhZnR0uW4MPyfgCL8sxN+LXcq6TbbgQagQCGC65eC0mTXLUlFqXe2lyJpbJOnEkjzoM/GRrEB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972824; c=relaxed/simple;
	bh=6F7camCDIKKK2sxB2S5wzNjfhMOUeLbsxlYULACcv/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekXzyS/33cptD3BpFjjamZj+BmSxwwAVAKtqIdoVMtR7vpeMzFqsIW+z1hRuX00EpQKksPHct5n/v6y5oKriQvDy34d6h6JY97gkMEVkbEM8tCqEqqzKmpOShlyO3LEk8DKGIbw2yE4H/hjWYEvVCSLPBV1eEC/fSeYlGnZ/0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxvJWM2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17C5C4AF0E;
	Tue,  6 Aug 2024 19:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722972824;
	bh=6F7camCDIKKK2sxB2S5wzNjfhMOUeLbsxlYULACcv/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxvJWM2KhwggoiWJvPsamuVd6sxIAd9N7aO4TWgUTNfXCa4PE6ALHHUcaINZVUA0W
	 HzHONvceBessMb4+I2ZciWKAbvWuQxTUB7umyld+2zyxzsWcXWAxaK9ZNbDo2XSK2h
	 I/eLwfzP/TlHkI9/eu3jyJnBpzpYyOxP+knk5J9jFnebwqLLUsFTLcMSGvIzWNNOCV
	 M66il5nSUgjAAqCMr2iMrB4MGy8Mih1o9/vuEQsKqBAf6RWYFBOuwJGLEgzDRlhsuh
	 5hDB/JvmsIoIOvM+8vTTz+qvQiAFjDvo+vGQFWj/sgSeIncOQBjI4hwKHmDnoJp8la
	 m1aSubHm7+FWA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 09/12] ethtool: rss: support dumping RSS contexts
Date: Tue,  6 Aug 2024 12:33:14 -0700
Message-ID: <20240806193317.1491822-10-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806193317.1491822-1-kuba@kernel.org>
References: <20240806193317.1491822-1-kuba@kernel.org>
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

Don't use the XArray iterators (like xa_for_each_start()) as they
do not move the index past the end of the array once done, which
caused multiple bugs in Netlink dumps in the past.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - one_ifindex -> match_ifindex, add a comment
 - add comment about context 0 not being in XArray
 - extend commit message (XArray iterators)
---
 Documentation/netlink/specs/ethtool.yaml |   9 +-
 net/ethtool/netlink.c                    |   2 +
 net/ethtool/netlink.h                    |   2 +
 net/ethtool/rss.c                        | 135 +++++++++++++++++++++++
 4 files changed, 146 insertions(+), 2 deletions(-)

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
index 023782ca1230..2865720ff583 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -208,6 +208,141 @@ static void rss_cleanup_data(struct ethnl_reply_data *reply_base)
 	kfree(data->indir_table);
 }
 
+struct rss_nl_dump_ctx {
+	unsigned long		ifindex;
+	unsigned long		ctx_idx;
+
+	/* User wants to only dump contexts from given ifindex */
+	unsigned int		match_ifindex;
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
+		ctx->match_ifindex = req_info.dev->ifindex;
+		ctx->ifindex = ctx->match_ifindex;
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
+	/* Context 0 is not currently storred or cached in the XArray */
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
+		if (ctx->match_ifindex && ctx->match_ifindex != ctx->ifindex)
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


