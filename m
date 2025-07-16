Return-Path: <netdev+bounces-207309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F62FB06A43
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D88B563DB5
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9471096F;
	Wed, 16 Jul 2025 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvWv+rXi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38494EAC7
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624255; cv=none; b=WTybG0vSY/iawsVpyItrRyywV/8mLLvBjJcUJmjhy44LhrCoKucyBp4bWBKRxX6lEmZe/YC3193vtNyEcm52WgoDNDgFilgkUsvdAnYnTrDjeEoI8IE3cqYdzXzOTyfnSyVQDcGLmnDg2uwlzSu3Kp0E/+wqQu/yZAUP49LYIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624255; c=relaxed/simple;
	bh=QT0TObAevpSdZzg9h133t40EEUZn0mnkNtMTaS98Ws0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rApzSfzh0JSOYKgoda4cdFjOHLdR5XPbISYwIErz3hMDhnZnTA0dyhh2DFKEUXzpHNF3pKbkr7xiTHHXS9jeRKs9qGZSyGIE6yRGHT9TO4HTHrAmF0UxipHrEvlR0Jk7UwibW/C22qcnT3tHtyKXf0rKehrMjl7UrX024U/MWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvWv+rXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03209C4CEF6;
	Wed, 16 Jul 2025 00:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752624254;
	bh=QT0TObAevpSdZzg9h133t40EEUZn0mnkNtMTaS98Ws0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvWv+rXieeKbbziobAZLkQqR86MyuYz6R3CADIa6F8GdEgMG4KCyXLmLhC54J1jIN
	 xv9i6OlR5fogfpSBuKPH265ArFiPTql65+fGRrOK/nSi44T8h6Xuk3uLzv7heEMQGt
	 V4UM7rXBnJdPeHNm2ojnIsmaB5FhGgz01thosAAYKseuhtm/tB9o16VIvrykCFa/P1
	 17XH6eZnC7klnmeYFu4OUjwhdggkDAGi6/GQynahXhZ4U+rqoeQnGB90KyIAbSfNDJ
	 4S65uA4XD4ZRmibM/KaSYMzMUjWb4JT/Eu+AVtExBTX3MjVyBOBtH+yR66l6yhtqGi
	 LlG6dDr/nui6Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	andrew@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 01/11] ethtool: rss: initial RSS_SET (indirection table handling)
Date: Tue, 15 Jul 2025 17:03:21 -0700
Message-ID: <20250716000331.1378807-2-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716000331.1378807-1-kuba@kernel.org>
References: <20250716000331.1378807-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for RSS_SET, for now only operations on
the indirection table are supported.

Unlike the ioctl don't check if at least one parameter is
being changed. This is how other ethtool-nl ops behave,
so pick the ethtool-nl consistency vs copying ioctl behavior.

There are two special cases here:
 1) resetting the table to defaults;
 2) support for tables of different size.

For (1) I use an empty Netlink attribute (array of size 0).

(2) may require some background. AFAICT a lot of modern devices
allow allocating RSS tables of different sizes. mlx5 can upsize
its tables, bnxt has some "table size calculation", and Intel
folks asked about RSS table sizing in context of resource allocation
in the past. The ethtool IOCTL API has a concept of table size,
but right now the user is expected to provide a table exactly
the size the device requests. Some drivers may change the table
size at runtime (in response to queue count changes) but the
user is not in control of this. What's not great is that all
RSS contexts share the same table size. For example a device
with 128 queues enabled, 16 RSS contexts 8 queues in each will
likely have 256 entry tables for each of the 16 contexts,
while 32 would be more than enough given each context only has
8 queues. To address this the Netlink API should avoid enforcing
table size at the uAPI level, and should allow the user to express
the min table size they expect.

To fully solve (2) we will need more driver plumbing but
at the uAPI level this patch allows the user to specify
a table size smaller than what the device advertises. The device
table size must be a multiple of the user requested table size.
We then replicate the user-provided table to fill the full device
size table. This addresses the "allow the user to express the min
table size" objective, while not enforcing any fixed size.
From Netlink perspective .get_rxfh_indir_size() is now de facto
the "max" table size supported by the device.

We may choose to support table replication in ethtool, too,
when we actually plumb this thru the device APIs.

Initially I was considering moving full pattern generation
to the kernel (which queues to use, at which frequency and
what min sequence length). I don't think this complexity
would buy us much and most if not all devices have pow-2
table sizes, which simplifies the replication a lot.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - check ops->get_rxnfc
v2:
 - make sure driver implements the set_rxfh op
 - add comment about early return when lacking get
 - explain why we accept empty request in commit msg
 - set IFF_RXFH_CONFIGURED even if user sets the table to identical
   to default
---
 Documentation/netlink/specs/ethtool.yaml      |  12 ++
 Documentation/networking/ethtool-netlink.rst  |  26 ++-
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 net/ethtool/netlink.h                         |   1 +
 net/ethtool/netlink.c                         |   8 +
 net/ethtool/rss.c                             | 195 ++++++++++++++++++
 6 files changed, 242 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index c38c03c624f0..1eca88a508a0 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -2643,6 +2643,18 @@ c-version-name: ethtool-genl-version
         attributes:
           - header
           - events
+    -
+      name: rss-set
+      doc: Set RSS params.
+
+      attribute-set: rss
+
+      do:
+        request:
+          attributes:
+            - header
+            - context
+            - indir
     -
       name: rss-ntf
       doc: |
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 248bc3d93da9..27db7540e60e 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -239,6 +239,7 @@ All constants identifying message types use ``ETHTOOL_CMD_`` prefix and suffix
   ``ETHTOOL_MSG_PHY_GET``               get Ethernet PHY information
   ``ETHTOOL_MSG_TSCONFIG_GET``          get hw timestamping configuration
   ``ETHTOOL_MSG_TSCONFIG_SET``          set hw timestamping configuration
+  ``ETHTOOL_MSG_RSS_SET``               set RSS settings
   ===================================== =================================
 
 Kernel to userspace:
@@ -292,6 +293,7 @@ All constants identifying message types use ``ETHTOOL_CMD_`` prefix and suffix
   ``ETHTOOL_MSG_TSCONFIG_GET_REPLY``       hw timestamping configuration
   ``ETHTOOL_MSG_TSCONFIG_SET_REPLY``       new hw timestamping configuration
   ``ETHTOOL_MSG_PSE_NTF``                  PSE events notification
+  ``ETHTOOL_MSG_RSS_NTF``                  RSS settings notification
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
@@ -1989,6 +1991,28 @@ hfunc. Current supported options are symmetric-xor and symmetric-or-xor.
 ETHTOOL_A_RSS_FLOW_HASH carries per-flow type bitmask of which header
 fields are included in the hash calculation.
 
+RSS_SET
+=======
+
+Request contents:
+
+=====================================  ======  ==============================
+  ``ETHTOOL_A_RSS_HEADER``             nested  request header
+  ``ETHTOOL_A_RSS_CONTEXT``            u32     context number
+  ``ETHTOOL_A_RSS_INDIR``              binary  Indir table bytes
+=====================================  ======  ==============================
+
+``ETHTOOL_A_RSS_INDIR`` is the minimal RSS table the user expects. Kernel and
+the device driver may replicate the table if its smaller than smallest table
+size supported by the device. For example if user requests ``[0, 1]`` but the
+device needs at least 8 entries - the real table in use will end up being
+``[0, 1, 0, 1, 0, 1, 0, 1]``. Most devices require the table size to be power
+of 2, so tables which size is not a power of 2 will likely be rejected.
+Using table of size 0 will reset the indirection table to the default.
+
+Note that, at present, only a subset of RSS configuration can be accomplished
+over Netlink.
+
 PLCA_GET_CFG
 ============
 
@@ -2455,7 +2479,7 @@ are netlink only.
   ``ETHTOOL_GRXNTUPLE``               n/a
   ``ETHTOOL_GSSET_INFO``              ``ETHTOOL_MSG_STRSET_GET``
   ``ETHTOOL_GRXFHINDIR``              ``ETHTOOL_MSG_RSS_GET``
-  ``ETHTOOL_SRXFHINDIR``              n/a
+  ``ETHTOOL_SRXFHINDIR``              ``ETHTOOL_MSG_RSS_SET``
   ``ETHTOOL_GFEATURES``               ``ETHTOOL_MSG_FEATURES_GET``
   ``ETHTOOL_SFEATURES``               ``ETHTOOL_MSG_FEATURES_SET``
   ``ETHTOOL_GCHANNELS``               ``ETHTOOL_MSG_CHANNELS_GET``
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 96027e26ffba..130bdf5c3516 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -840,6 +840,7 @@ enum {
 	ETHTOOL_MSG_PHY_GET,
 	ETHTOOL_MSG_TSCONFIG_GET,
 	ETHTOOL_MSG_TSCONFIG_SET,
+	ETHTOOL_MSG_RSS_SET,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 94a7eb402022..620dd1ab9b3b 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -484,6 +484,7 @@ extern const struct nla_policy ethnl_module_set_policy[ETHTOOL_A_MODULE_POWER_MO
 extern const struct nla_policy ethnl_pse_get_policy[ETHTOOL_A_PSE_HEADER + 1];
 extern const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1];
 extern const struct nla_policy ethnl_rss_get_policy[ETHTOOL_A_RSS_START_CONTEXT + 1];
+extern const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_START_CONTEXT + 1];
 extern const struct nla_policy ethnl_plca_get_cfg_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1];
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index b1f8999c1adc..0ae0d7a9667c 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -405,6 +405,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_PSE_GET]		= &ethnl_pse_request_ops,
 	[ETHTOOL_MSG_PSE_SET]		= &ethnl_pse_request_ops,
 	[ETHTOOL_MSG_RSS_GET]		= &ethnl_rss_request_ops,
+	[ETHTOOL_MSG_RSS_SET]		= &ethnl_rss_request_ops,
 	[ETHTOOL_MSG_PLCA_GET_CFG]	= &ethnl_plca_cfg_request_ops,
 	[ETHTOOL_MSG_PLCA_SET_CFG]	= &ethnl_plca_cfg_request_ops,
 	[ETHTOOL_MSG_PLCA_GET_STATUS]	= &ethnl_plca_status_request_ops,
@@ -1504,6 +1505,13 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_tsconfig_set_policy,
 		.maxattr = ARRAY_SIZE(ethnl_tsconfig_set_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_RSS_SET,
+		.flags	= GENL_UNS_ADMIN_PERM,
+		.doit	= ethnl_default_set_doit,
+		.policy = ethnl_rss_set_policy,
+		.maxattr = ARRAY_SIZE(ethnl_rss_set_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 41ab9fc67652..c8db523671de 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -218,6 +218,10 @@ rss_prepare(const struct rss_req_info *request, struct net_device *dev,
 {
 	rss_prepare_flow_hash(request, dev, data, info);
 
+	/* Coming from RSS_SET, driver may only have flow_hash_fields ops */
+	if (!dev->ethtool_ops->get_rxfh)
+		return 0;
+
 	if (request->rss_context)
 		return rss_prepare_ctx(request, dev, data, info);
 	return rss_prepare_get(request, dev, data, info);
@@ -466,6 +470,193 @@ void ethtool_rss_notify(struct net_device *dev, u32 rss_context)
 	ethnl_notify(dev, ETHTOOL_MSG_RSS_NTF, &req_info.base);
 }
 
+/* RSS_SET */
+
+const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_START_CONTEXT + 1] = {
+	[ETHTOOL_A_RSS_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_RSS_CONTEXT] = { .type = NLA_U32, },
+	[ETHTOOL_A_RSS_INDIR] = { .type = NLA_BINARY, },
+};
+
+static int
+ethnl_rss_set_validate(struct ethnl_req_info *req_info, struct genl_info *info)
+{
+	const struct ethtool_ops *ops = req_info->dev->ethtool_ops;
+	struct rss_req_info *request = RSS_REQINFO(req_info);
+	struct nlattr **tb = info->attrs;
+	struct nlattr *bad_attr = NULL;
+
+	if (request->rss_context && !ops->create_rxfh_context)
+		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_CONTEXT];
+
+	if (bad_attr) {
+		NL_SET_BAD_ATTR(info->extack, bad_attr);
+		return -EOPNOTSUPP;
+	}
+
+	return 1;
+}
+
+static int
+rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
+		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh,
+		   bool *reset, bool *mod)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct netlink_ext_ack *extack = info->extack;
+	struct nlattr **tb = info->attrs;
+	struct ethtool_rxnfc rx_rings;
+	size_t alloc_size;
+	u32 user_size;
+	int i, err;
+
+	if (!tb[ETHTOOL_A_RSS_INDIR])
+		return 0;
+	if (!data->indir_size || !ops->get_rxnfc)
+		return -EOPNOTSUPP;
+
+	rx_rings.cmd = ETHTOOL_GRXRINGS;
+	err = ops->get_rxnfc(dev, &rx_rings, NULL);
+	if (err)
+		return err;
+
+	if (nla_len(tb[ETHTOOL_A_RSS_INDIR]) % 4) {
+		NL_SET_BAD_ATTR(info->extack, tb[ETHTOOL_A_RSS_INDIR]);
+		return -EINVAL;
+	}
+	user_size = nla_len(tb[ETHTOOL_A_RSS_INDIR]) / 4;
+	if (!user_size) {
+		if (rxfh->rss_context) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[ETHTOOL_A_RSS_INDIR],
+					    "can't reset table for a context");
+			return -EINVAL;
+		}
+		*reset = true;
+	} else if (data->indir_size % user_size) {
+		NL_SET_ERR_MSG_ATTR_FMT(extack, tb[ETHTOOL_A_RSS_INDIR],
+					"size (%d) mismatch with device indir table (%d)",
+					user_size, data->indir_size);
+		return -EINVAL;
+	}
+
+	rxfh->indir_size = data->indir_size;
+	alloc_size = array_size(data->indir_size, sizeof(rxfh->indir[0]));
+	rxfh->indir = kzalloc(alloc_size, GFP_KERNEL);
+	if (!rxfh->indir)
+		return -ENOMEM;
+
+	nla_memcpy(rxfh->indir, tb[ETHTOOL_A_RSS_INDIR], alloc_size);
+	for (i = 0; i < user_size; i++) {
+		if (rxfh->indir[i] < rx_rings.data)
+			continue;
+
+		NL_SET_ERR_MSG_ATTR_FMT(extack, tb[ETHTOOL_A_RSS_INDIR],
+					"entry %d: queue out of range (%d)",
+					i, rxfh->indir[i]);
+		err = -EINVAL;
+		goto err_free;
+	}
+
+	if (user_size) {
+		/* Replicate the user-provided table to fill the device table */
+		for (i = user_size; i < data->indir_size; i++)
+			rxfh->indir[i] = rxfh->indir[i % user_size];
+	} else {
+		for (i = 0; i < data->indir_size; i++)
+			rxfh->indir[i] =
+				ethtool_rxfh_indir_default(i, rx_rings.data);
+	}
+
+	*mod |= memcmp(rxfh->indir, data->indir_table, data->indir_size);
+
+	return 0;
+
+err_free:
+	kfree(rxfh->indir);
+	rxfh->indir = NULL;
+	return err;
+}
+
+static void
+rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
+		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh)
+{
+	int i;
+
+	if (rxfh->indir) {
+		for (i = 0; i < data->indir_size; i++)
+			ethtool_rxfh_context_indir(ctx)[i] = rxfh->indir[i];
+		ctx->indir_configured = !!nla_len(tb[ETHTOOL_A_RSS_INDIR]);
+	}
+}
+
+static int
+ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
+{
+	struct rss_req_info *request = RSS_REQINFO(req_info);
+	struct ethtool_rxfh_context *ctx = NULL;
+	struct net_device *dev = req_info->dev;
+	struct ethtool_rxfh_param rxfh = {};
+	bool indir_reset = false, indir_mod;
+	struct nlattr **tb = info->attrs;
+	struct rss_reply_data data = {};
+	const struct ethtool_ops *ops;
+	bool mod = false;
+	int ret;
+
+	ops = dev->ethtool_ops;
+	data.base.dev = dev;
+
+	ret = rss_prepare(request, dev, &data, info);
+	if (ret)
+		return ret;
+
+	rxfh.rss_context = request->rss_context;
+
+	ret = rss_set_prep_indir(dev, info, &data, &rxfh, &indir_reset, &mod);
+	if (ret)
+		goto exit_clean_data;
+	indir_mod = !!tb[ETHTOOL_A_RSS_INDIR];
+
+	rxfh.hfunc = ETH_RSS_HASH_NO_CHANGE;
+	rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
+
+	mutex_lock(&dev->ethtool->rss_lock);
+	if (request->rss_context) {
+		ctx = xa_load(&dev->ethtool->rss_ctx, request->rss_context);
+		if (!ctx) {
+			ret = -ENOENT;
+			goto exit_unlock;
+		}
+	}
+
+	if (!mod)
+		ret = 0; /* nothing to tell the driver */
+	else if (!ops->set_rxfh)
+		ret = -EOPNOTSUPP;
+	else if (!rxfh.rss_context)
+		ret = ops->set_rxfh(dev, &rxfh, info->extack);
+	else
+		ret = ops->modify_rxfh_context(dev, ctx, &rxfh, info->extack);
+	if (ret)
+		goto exit_unlock;
+
+	if (ctx)
+		rss_set_ctx_update(ctx, tb, &data, &rxfh);
+	else if (indir_reset)
+		dev->priv_flags &= ~IFF_RXFH_CONFIGURED;
+	else if (indir_mod)
+		dev->priv_flags |= IFF_RXFH_CONFIGURED;
+
+exit_unlock:
+	mutex_unlock(&dev->ethtool->rss_lock);
+	kfree(rxfh.indir);
+exit_clean_data:
+	rss_cleanup_data(&data.base);
+
+	return ret ?: mod;
+}
+
 const struct ethnl_request_ops ethnl_rss_request_ops = {
 	.request_cmd		= ETHTOOL_MSG_RSS_GET,
 	.reply_cmd		= ETHTOOL_MSG_RSS_GET_REPLY,
@@ -478,4 +669,8 @@ const struct ethnl_request_ops ethnl_rss_request_ops = {
 	.reply_size		= rss_reply_size,
 	.fill_reply		= rss_fill_reply,
 	.cleanup_data		= rss_cleanup_data,
+
+	.set_validate		= ethnl_rss_set_validate,
+	.set			= ethnl_rss_set,
+	.set_ntf_cmd		= ETHTOOL_MSG_RSS_NTF,
 };
-- 
2.50.1


