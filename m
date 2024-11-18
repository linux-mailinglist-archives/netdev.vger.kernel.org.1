Return-Path: <netdev+bounces-145772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103D79D0B05
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 09:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 154BBB20E0E
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 08:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E463154BF0;
	Mon, 18 Nov 2024 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QD7prt0K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB49C41C71
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731919081; cv=none; b=YtUQsuMo+a7ghIrkSU9223oJxnU4e/c4SjdV3hW5dAVfSqj9xAkhXedlKsKZ9mMmthlqtixYQSUWBDwHdHw6/Xv4CAA/C7rDx0m5X8O2VrfOkQuLYr9awO7Q3m47c70kthuM2hSJgvZ9UD3ClMdMebAHBvpGFjtq08KeddkzA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731919081; c=relaxed/simple;
	bh=Tc8V+PqQWgxcgTHSkAcENjqj8IprMoc8hCZpUTFoPVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Chms3EJ1mLsorXU1R6f6lxZoqdA46D4vE9sf/nk15+Tlr7PDhD358GnMM8RQtKjgPbm1eHBaqCI7+uNK/LUh9qL73Mj/mSMToOW83wKQaoQUlPIS3zlrZVElTkImsJ2bPrU3hMH/NeBqOLJt5bLXbW7lk7vDBzKzBVJbMwR+oH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QD7prt0K; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38245e072e8so574254f8f.0
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 00:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1731919076; x=1732523876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KI2157OW1DZGdUXkDjF4dBSMAk1Q8xLIbks/zV9QeA8=;
        b=QD7prt0KaaVfTtopCU8cVMxphbYouHG+gzux8pGV3CBPd6NLbnHkm251Kv0lRfx9Ob
         VG02617NyYNHA8Dylp2iA308XoCq5Ytv/oTV8kH0LcNTEmisozhf5LSdR7grVMhO0/i9
         Uyp6dQvwP6xEcGrP/TKDvZeChlP2NAmVoU9dFa926QbZm98QkgSniDKjUeCIPzX2g3Q2
         vBEa1BGrneFnHwCSK6a1FpQQKtzyKzY0aTmTxWDOHXz0cti2Ob9BX1+OSkXAd1KIbRf4
         KUW/bxl/T1ss5Ndd3L/HQ/jvnbKxoIFN6ZSRDrMTySzxfVzGLfoLFA/7wXUvLT6Vhdpu
         reTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731919076; x=1732523876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KI2157OW1DZGdUXkDjF4dBSMAk1Q8xLIbks/zV9QeA8=;
        b=K+ap0OvVRGKjCLCo/foAiHC2fDkrihYbxBghl7UYdb4qsqcBGHNJAWkQU1+OjRw0oZ
         EM1RXAQd5RC3+VygWfHJLhIHSlEruJ8keDY/pht3nR7RKBPMlW/NSn0aJFO6v5cF0ZEB
         nhCB1sj84h9k1hDEvltacwGvJbNNiOFKja1PsstkZtUBoxRy28cOavHZPaqo7uoxIU/O
         k66Bb9tttdm7b6DST9oxlGQZz/JbM0to7QRJJoIQIU7i8t/vuMkXQiruVflvYSK0l3du
         ysv5PEW6ll0X7O8a2q+QTagsgBAEeGwWMt34qPlss8PeWZUisoPJ59x9+BKRQDGd7zQt
         zl9w==
X-Forwarded-Encrypted: i=1; AJvYcCVhBKMwYIENkfgoxO83c0cEHuf7XstxY/BtG0/JalFKcvpVIJfQT9XmaBJsvzTjZxBjiX574Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbnndW67m7FDQ8czmZxSbj/mJgLsCNIEcLL/zvsqq1ADzBOlC+
	t0CYXIFWxGR8Gz654edfdYMPCwvhOCxYcvvvhzil4BJrOH5qttb99NU/6ku/xik=
X-Google-Smtp-Source: AGHT+IGuDhR8CdXl4j5J+osaK3dZgxrDSOgQvozaC8ME7CETI2pTv9Bgb327tkdqDJOVr/XhmMYNeQ==
X-Received: by 2002:a5d:648c:0:b0:37d:2de3:bf8a with SMTP id ffacd0b85a97d-38225a67e47mr10721479f8f.26.1731919075892;
        Mon, 18 Nov 2024 00:37:55 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382398aa925sm6005366f8f.50.2024.11.18.00.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 00:37:55 -0800 (PST)
Date: Mon, 18 Nov 2024 09:37:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V3 3/8] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <Zzr84MDdA5S3TadZ@nanopsycho.orion>
References: <20241117205046.736499-1-tariqt@nvidia.com>
 <20241117205046.736499-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117205046.736499-4-tariqt@nvidia.com>

Sun, Nov 17, 2024 at 09:50:40PM CET, tariqt@nvidia.com wrote:
>From: Carolina Jubran <cjubran@nvidia.com>
>
>Introduce support for specifying bandwidth proportions between traffic
>classes (TC) in the devlink-rate API. This new option allows users to
>allocate bandwidth across multiple traffic classes in a single command.
>
>This feature provides a more granular control over traffic management,
>especially for scenarios requiring Enhanced Transmission Selection.
>
>Users can now define a specific bandwidth share for each traffic class,
>such as allocating 20% for TC0 (TCP/UDP) and 80% for TC5 (RoCE).
>
>Example:
>DEV=pci/0000:08:00.0
>
>$ devlink port function rate add $DEV/vfs_group tx_share 10Gbit \
>  tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0
>
>$ devlink port function rate set $DEV/vfs_group \
>  tc-bw 0:20 1:0 2:0 3:0 4:0 5:20 6:60 7:0
>
>Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>---
> Documentation/netlink/specs/devlink.yaml | 22 ++++++++
> include/net/devlink.h                    |  7 +++
> include/uapi/linux/devlink.h             |  3 +
> net/devlink/netlink_gen.c                | 14 +++--
> net/devlink/netlink_gen.h                |  1 +
> net/devlink/rate.c                       | 71 +++++++++++++++++++++++-
> 6 files changed, 113 insertions(+), 5 deletions(-)
>
>diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>index 09fbb4c03fc8..fece78ed60fe 100644
>--- a/Documentation/netlink/specs/devlink.yaml
>+++ b/Documentation/netlink/specs/devlink.yaml
>@@ -820,6 +820,19 @@ attribute-sets:
>       -
>         name: region-direct
>         type: flag
>+      -
>+        name: rate-tc-bw
>+        type: u32
>+        doc: |
>+             Specifies the bandwidth allocation for the Traffic Class as a
>+             percentage.
>+        checks:
>+          min: 0
>+          max: 100
>+      -
>+        name: rate-tc-bw-values
>+        type: nest
>+        nested-attributes: dl-rate-tc-bw-values

Hmm, it's not a simple nest. It's an array. You probably need something
like type: indexed-array here. Please make sure you make this working
with ynl. Could you also please add examples of get and set commands
using ynl to the patch description?


> 
>   -
>     name: dl-dev-stats
>@@ -1225,6 +1238,13 @@ attribute-sets:
>       -
>         name: flash
>         type: flag
>+  -
>+    name: dl-rate-tc-bw-values
>+    subset-of: devlink
>+    attributes:
>+      -
>+        name: rate-tc-bw
>+        type: u32
> 
> operations:
>   enum-model: directional
>@@ -2149,6 +2169,7 @@ operations:
>             - rate-tx-priority
>             - rate-tx-weight
>             - rate-parent-node-name
>+            - rate-tc-bw-values
> 
>     -
>       name: rate-new
>@@ -2169,6 +2190,7 @@ operations:
>             - rate-tx-priority
>             - rate-tx-weight
>             - rate-parent-node-name
>+            - rate-tc-bw-values
> 
>     -
>       name: rate-del
>diff --git a/include/net/devlink.h b/include/net/devlink.h
>index fbb9a2668e24..277b826cdd60 100644
>--- a/include/net/devlink.h
>+++ b/include/net/devlink.h
>@@ -20,6 +20,7 @@
> #include <uapi/linux/devlink.h>
> #include <linux/xarray.h>
> #include <linux/firmware.h>
>+#include <linux/dcbnl.h>
> 
> struct devlink;
> struct devlink_linecard;
>@@ -117,6 +118,8 @@ struct devlink_rate {
> 
> 	u32 tx_priority;
> 	u32 tx_weight;
>+
>+	u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
> };
> 
> struct devlink_port {
>@@ -1469,6 +1472,8 @@ struct devlink_ops {
> 					 u32 tx_priority, struct netlink_ext_ack *extack);
> 	int (*rate_leaf_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
> 				       u32 tx_weight, struct netlink_ext_ack *extack);
>+	int (*rate_leaf_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
>+				   u32 *tc_bw, struct netlink_ext_ack *extack);
> 	int (*rate_node_tx_share_set)(struct devlink_rate *devlink_rate, void *priv,
> 				      u64 tx_share, struct netlink_ext_ack *extack);
> 	int (*rate_node_tx_max_set)(struct devlink_rate *devlink_rate, void *priv,
>@@ -1477,6 +1482,8 @@ struct devlink_ops {
> 					 u32 tx_priority, struct netlink_ext_ack *extack);
> 	int (*rate_node_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
> 				       u32 tx_weight, struct netlink_ext_ack *extack);
>+	int (*rate_node_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
>+				   u32 *tc_bw, struct netlink_ext_ack *extack);
> 	int (*rate_node_new)(struct devlink_rate *rate_node, void **priv,
> 			     struct netlink_ext_ack *extack);
> 	int (*rate_node_del)(struct devlink_rate *rate_node, void *priv,
>diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>index 9401aa343673..0940f8770319 100644
>--- a/include/uapi/linux/devlink.h
>+++ b/include/uapi/linux/devlink.h
>@@ -614,6 +614,9 @@ enum devlink_attr {
> 
> 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
> 
>+	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
>+	DEVLINK_ATTR_RATE_TC_BW_VALUES,		/* nested */

"values" sounds odd. When I look at the rest of the similar nested
attrs, we use either "S" or "_LIST" as suffix. Also, Please have the
nested attr first and the u32 as second (again, the rest of the attrs
have it like that). So something like:

	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */


>+
> 	/* Add new attributes above here, update the spec in
> 	 * Documentation/netlink/specs/devlink.yaml and re-generate
> 	 * net/devlink/netlink_gen.c.
>diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
>index f9786d51f68f..231c2752538f 100644
>--- a/net/devlink/netlink_gen.c
>+++ b/net/devlink/netlink_gen.c
>@@ -18,6 +18,10 @@ const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_
> 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
> };
> 
>+const struct nla_policy devlink_dl_rate_tc_bw_values_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
>+	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_RANGE(NLA_U32, 0, 100),
>+};
>+
> const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
> 	[DEVLINK_ATTR_SELFTEST_ID_FLASH] = { .type = NLA_FLAG, },
> };
>@@ -496,7 +500,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
> };
> 
> /* DEVLINK_CMD_RATE_SET - do */
>-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
>+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BW_VALUES + 1] = {
> 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
> 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
> 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
>@@ -505,10 +509,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_W
> 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
> 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
> 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
>+	[DEVLINK_ATTR_RATE_TC_BW_VALUES] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_values_nl_policy),
> };
> 
> /* DEVLINK_CMD_RATE_NEW - do */
>-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
>+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BW_VALUES + 1] = {
> 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
> 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
> 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
>@@ -517,6 +522,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_W
> 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
> 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
> 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
>+	[DEVLINK_ATTR_RATE_TC_BW_VALUES] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_values_nl_policy),
> };
> 
> /* DEVLINK_CMD_RATE_DEL - do */
>@@ -1164,7 +1170,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
> 		.doit		= devlink_nl_rate_set_doit,
> 		.post_doit	= devlink_nl_post_doit,
> 		.policy		= devlink_rate_set_nl_policy,
>-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
>+		.maxattr	= DEVLINK_ATTR_RATE_TC_BW_VALUES,
> 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> 	},
> 	{
>@@ -1174,7 +1180,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
> 		.doit		= devlink_nl_rate_new_doit,
> 		.post_doit	= devlink_nl_post_doit,
> 		.policy		= devlink_rate_new_nl_policy,
>-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
>+		.maxattr	= DEVLINK_ATTR_RATE_TC_BW_VALUES,
> 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> 	},
> 	{
>diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
>index 8f2bd50ddf5e..a8f0f20f6f0b 100644
>--- a/net/devlink/netlink_gen.h
>+++ b/net/devlink/netlink_gen.h
>@@ -13,6 +13,7 @@
> 
> /* Common nested types */
> extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
>+extern const struct nla_policy devlink_dl_rate_tc_bw_values_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1];
> extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
> 
> /* Ops table for devlink */
>diff --git a/net/devlink/rate.c b/net/devlink/rate.c
>index 8828ffaf6cbc..4eb0598d40f9 100644
>--- a/net/devlink/rate.c
>+++ b/net/devlink/rate.c
>@@ -86,7 +86,9 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
> 				int flags, struct netlink_ext_ack *extack)
> {
> 	struct devlink *devlink = devlink_rate->devlink;
>+	struct nlattr *nla_tc_bw;
> 	void *hdr;
>+	int i;
> 
> 	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
> 	if (!hdr)
>@@ -129,6 +131,19 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
> 				   devlink_rate->parent->name))
> 			goto nla_put_failure;
> 
>+	nla_tc_bw = nla_nest_start(msg, DEVLINK_ATTR_RATE_TC_BW_VALUES);
>+	if (!nla_tc_bw)
>+		goto nla_put_failure;
>+
>+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
>+		if (nla_put_u32(msg, DEVLINK_ATTR_RATE_TC_BW, devlink_rate->tc_bw[i])) {
>+			nla_nest_cancel(msg, nla_tc_bw);
>+			goto nla_put_failure;
>+		}
>+	}
>+
>+	nla_nest_end(msg, nla_tc_bw);
>+
> 	genlmsg_end(msg, hdr);
> 	return 0;
> 
>@@ -316,11 +331,46 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
> 	return 0;
> }
> 
>+static int devlink_nl_rate_tc_bw_set(struct devlink_rate *devlink_rate,
>+				     struct genl_info *info,
>+				     struct nlattr *nla_tc_bw)
>+{
>+	struct devlink *devlink = devlink_rate->devlink;
>+	const struct devlink_ops *ops = devlink->ops;
>+	u32 tc_bw[IEEE_8021QAZ_MAX_TCS] = {0};

You don't need 0 between brackets.


>+	struct nlattr *nla_tc_entry;
>+	int rem, err = 0, i = 0;
>+
>+	nla_for_each_nested(nla_tc_entry, nla_tc_bw, rem) {
>+		if (i >= IEEE_8021QAZ_MAX_TCS || nla_type(nla_tc_entry) != DEVLINK_ATTR_RATE_TC_BW)

Fill up an extack message with proper reasoning.


>+			return -EINVAL;
>+
>+		tc_bw[i++] = nla_get_u32(nla_tc_entry);
>+	}
>+
>+	if (i != IEEE_8021QAZ_MAX_TCS)
>+		return -EINVAL;
>+
>+	if (devlink_rate_is_leaf(devlink_rate))
>+		err = ops->rate_leaf_tc_bw_set(devlink_rate, devlink_rate->priv, tc_bw,
>+					       info->extack);
>+	else if (devlink_rate_is_node(devlink_rate))
>+		err = ops->rate_node_tc_bw_set(devlink_rate, devlink_rate->priv, tc_bw,
>+					       info->extack);
>+
>+	if (err)
>+		return err;
>+
>+	memcpy(devlink_rate->tc_bw, tc_bw, sizeof(tc_bw));
>+
>+	return 0;
>+}
>+
> static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
> 			       const struct devlink_ops *ops,
> 			       struct genl_info *info)
> {
>-	struct nlattr *nla_parent, **attrs = info->attrs;
>+	struct nlattr *nla_parent, *nla_tc_bw, **attrs = info->attrs;
> 	int err = -EOPNOTSUPP;
> 	u32 priority;
> 	u32 weight;
>@@ -380,6 +430,13 @@ static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
> 		devlink_rate->tx_weight = weight;
> 	}
> 
>+	nla_tc_bw = attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES];
>+	if (nla_tc_bw) {
>+		err = devlink_nl_rate_tc_bw_set(devlink_rate, info, nla_tc_bw);
>+		if (err)
>+			return err;
>+	}
>+
> 	nla_parent = attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME];
> 	if (nla_parent) {
> 		err = devlink_nl_rate_parent_node_set(devlink_rate, info,
>@@ -423,6 +480,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
> 					    "TX weight set isn't supported for the leafs");
> 			return false;
> 		}
>+		if (attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES] && !ops->rate_leaf_tc_bw_set) {
>+			NL_SET_ERR_MSG_ATTR(info->extack,
>+					    attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES],
>+					    "TC bandwidth set isn't supported for the leafs");
>+			return false;
>+		}
> 	} else if (type == DEVLINK_RATE_TYPE_NODE) {
> 		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE] && !ops->rate_node_tx_share_set) {
> 			NL_SET_ERR_MSG(info->extack, "TX share set isn't supported for the nodes");
>@@ -449,6 +512,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
> 					    "TX weight set isn't supported for the nodes");
> 			return false;
> 		}
>+		if (attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES] && !ops->rate_node_tc_bw_set) {
>+			NL_SET_ERR_MSG_ATTR(info->extack,
>+					    attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES],
>+					    "TC bandwidth set isn't supported for the nodes");
>+			return false;
>+		}
> 	} else {
> 		WARN(1, "Unknown type of rate object");
> 		return false;
>-- 
>2.44.0
>

