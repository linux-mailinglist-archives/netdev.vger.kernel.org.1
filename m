Return-Path: <netdev+bounces-253892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI3IKOzBeGmltAEAu9opvQ
	(envelope-from <netdev+bounces-253892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:47:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D58995160
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35ABF301CBE1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C5235BDCF;
	Tue, 27 Jan 2026 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lGbouBSY"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F00835F8B1
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521375; cv=none; b=X+nUC4B4lmpzf3xLqWkHIzXDxRKY3cd+LQg0JLv/xopkr2KexEE4bDwT1o/lvAN+/wx5d/zcc0bhJU2er8U1Gr5N/LbcFON7z5lDTuua7yTTAP3+p2FA5MXVDkj+FyO6iAxAqeHjhLJLkglTdlWvqWh+W0lOnlVqAuf7aikgyig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521375; c=relaxed/simple;
	bh=pGmGlCKaaXi6n3kzu6pebk8nKqAgx61Vp2G+3MzMqzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgekJpadWvjO/Eo+QrAMAwwLYSKY3Ty3NSY6xwDEckAvuGRGwSjjg472ITIGo5ftb8UTRV/r8e5YC+WUtfg3Ng46IrAxT/qbTxsLts8US/iWPXMa051Ygyf6nGFJLN4h9+CHyTtinIzffZr0Q8IN7d+aXNOwX/+qDRuQet/ObNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lGbouBSY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E34CF4E422D2;
	Tue, 27 Jan 2026 13:42:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B8CF9606F5;
	Tue, 27 Jan 2026 13:42:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2931A119A864D;
	Tue, 27 Jan 2026 14:42:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769521370; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=jZWnm/yA0XYyoiDagHR7AQL8Azf/LmljhrPAtB/4/yU=;
	b=lGbouBSY/2O+Q6kwm0zJvG+0f3lRnQVUF3oz2jxxNluHtlkQwU5p5gkjsIddEa5YSMct+P
	A65lCu9cRCSFaXmhokUjZDGoosBcdb2O5quYoKpFLyfTb6hZBhxolWa34qjAZRvUAl5T6e
	bu/lakRw6r8VV/oU3k6+KPMG4AjTMj2SwQAzMKcvw81I+ZOgQ4lql910x5AdYmlEEllo76
	fVZbQr4DHDFWRlfAzCQ9KSMtBlrKlLqhtIanoWuJ/kBfsxiiuaHx1ALyBIWJyU7VST/pki
	ljlVrSWzZK/oMHvW3V3Prs4NF934G3cURHy53L4SgOpBcllja28pCUWyHQmVyg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: [PATCH net-next 13/13] net: ethtool: Introduce ethtool command to list ports
Date: Tue, 27 Jan 2026 14:42:01 +0100
Message-ID: <20260127134202.8208-14-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-253892-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D58995160
X-Rspamd-Action: no action

Expose the phy_port information to userspace, so that we can know how
many ports are available on a given interface, as well as their
capabilities. For MDI ports, we report the list of supported linkmodes
based on what the PHY that drives this port says.
For MII ports, i.e. empty SFP cages, we report the MII linkmodes that we
can output on this port.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 MAINTAINERS           |   1 +
 net/ethtool/Makefile  |   2 +-
 net/ethtool/netlink.c |  11 ++
 net/ethtool/netlink.h |   5 +
 net/ethtool/port.c    | 373 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 391 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/port.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c3df85fd5acd..a8272e169888 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18226,6 +18226,7 @@ F:	Documentation/devicetree/bindings/net/ethernet-connector.yaml
 F:	Documentation/networking/phy-port.rst
 F:	drivers/net/phy/phy_port.c
 F:	include/linux/phy_port.h
+F:	net/ethtool/port.c
 K:	struct\s+phy_port|phy_port_
 
 NETWORKING [GENERAL]
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 629c10916670..9b5b09670008 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -9,4 +9,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
 		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o \
-		   phy.o tsconfig.o mse.o
+		   phy.o tsconfig.o mse.o port.o
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 6e5f0f4f815a..82d94a2da55c 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -421,6 +421,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_TSCONFIG_SET]	= &ethnl_tsconfig_request_ops,
 	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
 	[ETHTOOL_MSG_MSE_GET]		= &ethnl_mse_request_ops,
+	[ETHTOOL_MSG_PORT_GET]		= &ethnl_port_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -1544,6 +1545,16 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_mse_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_mse_get_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_PORT_GET,
+		.doit	= ethnl_default_doit,
+		.start	= ethnl_port_dump_start,
+		.dumpit	= ethnl_port_dumpit,
+		.done	= ethnl_port_dump_done,
+		.policy = ethnl_port_get_policy,
+		.maxattr = ARRAY_SIZE(ethnl_port_get_policy) - 1,
+	},
+
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 89010eaa67df..ea033992ba56 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -443,6 +443,7 @@ extern const struct ethnl_request_ops ethnl_mm_request_ops;
 extern const struct ethnl_request_ops ethnl_phy_request_ops;
 extern const struct ethnl_request_ops ethnl_tsconfig_request_ops;
 extern const struct ethnl_request_ops ethnl_mse_request_ops;
+extern const struct ethnl_request_ops ethnl_port_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
@@ -499,6 +500,7 @@ extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_get_policy[ETHTOOL_A_TSCONFIG_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_set_policy[ETHTOOL_A_TSCONFIG_MAX + 1];
 extern const struct nla_policy ethnl_mse_get_policy[ETHTOOL_A_MSE_HEADER + 1];
+extern const struct nla_policy ethnl_port_get_policy[ETHTOOL_A_PORT_ID + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
@@ -514,6 +516,9 @@ int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int ethnl_tsinfo_done(struct netlink_callback *cb);
 int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info);
 int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info);
+int ethnl_port_dump_start(struct netlink_callback *cb);
+int ethnl_port_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ethnl_port_dump_done(struct netlink_callback *cb);
 
 extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
diff --git a/net/ethtool/port.c b/net/ethtool/port.c
new file mode 100644
index 000000000000..efad1b88d909
--- /dev/null
+++ b/net/ethtool/port.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2026 Bootlin
+ *
+ */
+#include "common.h"
+#include "bitset.h"
+#include "netlink.h"
+
+#include <linux/phy.h>
+#include <linux/phy_link_topology.h>
+#include <linux/phy_port.h>
+#include <net/netdev_lock.h>
+
+struct port_req_info {
+	struct ethnl_req_info base;
+	u32 port_id;
+};
+
+struct port_reply_data {
+	struct ethnl_reply_data	base;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
+	DECLARE_PHY_INTERFACE_MASK(interfaces);
+	u32 port_id;
+	bool mii;
+	bool sfp;
+	bool occupied;
+};
+
+#define PORT_REQINFO(__req_base) \
+	container_of(__req_base, struct port_req_info, base)
+
+#define PORT_REPDATA(__reply_base) \
+	container_of(__reply_base, struct port_reply_data, base)
+
+const struct nla_policy ethnl_port_get_policy[ETHTOOL_A_PORT_ID + 1] = {
+	[ETHTOOL_A_PORT_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_PORT_ID] = { .type = NLA_U32},
+};
+
+static int port_parse_request(struct ethnl_req_info *req_info,
+			      struct nlattr **tb,
+			      struct netlink_ext_ack *extack)
+{
+	struct port_req_info *request = PORT_REQINFO(req_info);
+
+	/* PORT id is required for GET requests */
+	if (tb[ETHTOOL_A_PORT_ID])
+		request->port_id = nla_get_u32(tb[ETHTOOL_A_PORT_ID]);
+
+	if (!request->port_id) {
+		NL_SET_ERR_MSG(extack, "port id missing");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int port_prepare_data(const struct ethnl_req_info *req_info,
+			     struct ethnl_reply_data *reply_data,
+			     const struct genl_info *info)
+{
+	struct port_reply_data *reply = PORT_REPDATA(reply_data);
+	struct port_req_info *request = PORT_REQINFO(req_info);
+	struct phy_port *port;
+
+	/* RTNL must be held while holding a ref to the phy_port. Here, caller
+	 * holds RTNL.
+	 */
+	port = phy_link_topo_get_port(req_info->dev, request->port_id);
+	if (!port)
+		return -ENODEV;
+
+	linkmode_copy(reply->supported, port->supported);
+	phy_interface_copy(reply->interfaces, port->interfaces);
+	reply->port_id = port->id;
+	reply->mii = port->is_mii;
+	reply->sfp = port->is_sfp;
+	reply->occupied = port->occupied;
+
+	return 0;
+}
+
+static int port_reply_size(const struct ethnl_req_info *req_info,
+			   const struct ethnl_reply_data *reply_data)
+{
+	bool compact = req_info->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+	struct port_reply_data *reply = PORT_REPDATA(reply_data);
+	size_t size = 0;
+	int ret;
+
+	/* ETHTOOL_A_PORT_ID */
+	size += nla_total_size(sizeof(u32));
+
+	if (!reply->mii) {
+		/* ETHTOOL_A_PORT_SUPPORTED_MODES */
+		ret = ethnl_bitset_size(reply->supported, NULL,
+					__ETHTOOL_LINK_MODE_MASK_NBITS,
+					link_mode_names, compact);
+		if (ret < 0)
+			return ret;
+
+		size += ret;
+	} else {
+		/* ETHTOOL_A_PORT_SUPPORTED_INTERFACES */
+		ret = ethnl_bitset_size(reply->interfaces, NULL,
+					PHY_INTERFACE_MODE_MAX,
+					phy_interface_names, compact);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* ETHTOOL_A_PORT_TYPE */
+	size += nla_total_size(sizeof(u8));
+
+	/* ETHTOOL_A_PORT_OCCUPIED */
+	size += nla_total_size(sizeof(u8));
+
+	return size;
+}
+
+static int port_fill_reply(struct sk_buff *skb,
+			   const struct ethnl_req_info *req_info,
+			   const struct ethnl_reply_data *reply_data)
+{
+	bool compact = req_info->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+	struct port_reply_data *reply = PORT_REPDATA(reply_data);
+	int ret, port_type = ETHTOOL_PORT_TYPE_MDI;
+
+	if (nla_put_u32(skb, ETHTOOL_A_PORT_ID, reply->port_id))
+		return -EMSGSIZE;
+
+	if (!reply->mii) {
+		ret = ethnl_put_bitset(skb, ETHTOOL_A_PORT_SUPPORTED_MODES,
+				       reply->supported, NULL,
+				       __ETHTOOL_LINK_MODE_MASK_NBITS,
+				       link_mode_names, compact);
+		if (ret < 0)
+			return -EMSGSIZE;
+	} else {
+		ret = ethnl_put_bitset(skb, ETHTOOL_A_PORT_SUPPORTED_INTERFACES,
+				       reply->interfaces, NULL,
+				       PHY_INTERFACE_MODE_MAX,
+				       phy_interface_names, compact);
+		if (ret < 0)
+			return -EMSGSIZE;
+	}
+
+	if (reply->mii || reply->sfp)
+		port_type = ETHTOOL_PORT_TYPE_SFP;
+
+	if (nla_put_u8(skb, ETHTOOL_A_PORT_TYPE, port_type) ||
+	    nla_put_u8(skb, ETHTOOL_A_PORT_OCCUPIED, reply->occupied))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+struct port_dump_ctx {
+	struct port_req_info	*req_info;
+	struct port_reply_data	*reply_data;
+	unsigned long		ifindex;
+	unsigned long		pos_portid;
+};
+
+static struct port_dump_ctx *
+port_dump_ctx_get(struct netlink_callback *cb)
+{
+	return (struct port_dump_ctx *)cb->ctx;
+}
+
+int ethnl_port_dump_start(struct netlink_callback *cb)
+{
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
+	struct nlattr **tb = info->info.attrs;
+	struct port_reply_data *reply_data;
+	struct port_req_info *req_info;
+	int ret;
+
+	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
+
+	req_info = kzalloc(sizeof(*req_info), GFP_KERNEL);
+	if (!req_info)
+		return -ENOMEM;
+
+	reply_data = kmalloc(sizeof(*reply_data), GFP_KERNEL);
+	if (!reply_data) {
+		ret = -ENOMEM;
+		goto free_req_info;
+	}
+
+	ret = ethnl_parse_header_dev_get(&req_info->base, tb[ETHTOOL_A_PORT_HEADER],
+					 genl_info_net(&info->info),
+					 info->info.extack, false);
+	if (ret < 0)
+		return ret;
+
+	ctx->ifindex = 0;
+
+	/* For filtered DUMP requests, let's just store the ifindex. We'll check
+	 * again if the netdev is still there when looping over the netdev list
+	 * in the DUMP loop.
+	 */
+	if (req_info->base.dev) {
+		ctx->ifindex = req_info->base.dev->ifindex;
+		netdev_put(req_info->base.dev, &req_info->base.dev_tracker);
+		req_info->base.dev = NULL;
+	}
+
+	ctx->req_info = req_info;
+	ctx->reply_data = reply_data;
+
+	return 0;
+
+	kfree(reply_data);
+free_req_info:
+	kfree(req_info);
+
+	return ret;
+}
+
+static int port_dump_one(struct sk_buff *skb, struct net_device *dev,
+			 struct netlink_callback *cb)
+{
+	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
+	void *ehdr;
+	int ret;
+
+	ehdr = ethnl_dump_put(skb, cb, ETHTOOL_A_PORT_HEADER);
+	if (!ehdr)
+		return -EMSGSIZE;
+
+	memset(ctx->reply_data, 0, sizeof(struct port_reply_data));
+	ctx->reply_data->base.dev = dev;
+
+	rtnl_lock();
+	netdev_lock_ops(dev);
+
+	ret = port_prepare_data(&ctx->req_info->base, &ctx->reply_data->base,
+				genl_info_dump(cb));
+
+	netdev_unlock_ops(dev);
+	rtnl_unlock();
+
+	if (ret < 0)
+		goto out;
+
+	ret = ethnl_fill_reply_header(skb, dev, ETHTOOL_A_PORT_HEADER);
+	if (ret < 0)
+		goto out;
+
+	ret = port_fill_reply(skb, &ctx->req_info->base, &ctx->reply_data->base);
+
+out:
+	ctx->reply_data->base.dev = NULL;
+	if (ret < 0)
+		genlmsg_cancel(skb, ehdr);
+	else
+		genlmsg_end(skb, ehdr);
+
+	return ret;
+}
+
+static int port_dump_one_dev(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
+	struct net_device *dev;
+	struct phy_port *port;
+	int ret;
+
+	dev = ctx->req_info->base.dev;
+
+	if (!dev->link_topo)
+		return 0;
+
+	xa_for_each_start(&dev->link_topo->ports, ctx->pos_portid, port,
+			  ctx->pos_portid) {
+		ctx->req_info->port_id = ctx->pos_portid;
+
+		ret = port_dump_one(skb, dev, cb);
+		if (ret)
+			return ret;
+	}
+
+	ctx->pos_portid = 0;
+
+	return 0;
+}
+
+static int port_dump_all_dev(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
+	struct net *net = sock_net(skb->sk);
+	netdevice_tracker dev_tracker;
+	struct net_device *dev;
+	int ret = 0;
+
+	rcu_read_lock();
+	for_each_netdev_dump(net, dev, ctx->ifindex) {
+		netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
+		rcu_read_unlock();
+
+		ctx->req_info->base.dev = dev;
+		ret = port_dump_one_dev(skb, cb);
+
+		rcu_read_lock();
+		netdev_put(dev, &dev_tracker);
+		ctx->req_info->base.dev = NULL;
+
+		if (ret < 0 && ret != -EOPNOTSUPP) {
+			if (likely(skb->len))
+				ret = skb->len;
+			break;
+		}
+		ret = 0;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+int ethnl_port_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
+	int ret = 0;
+
+	if (ctx->ifindex) {
+		netdevice_tracker dev_tracker;
+		struct net_device *dev;
+
+		dev = netdev_get_by_index(genl_info_net(&info->info),
+					  ctx->ifindex, &dev_tracker,
+					  GFP_KERNEL);
+		if (!dev)
+			return -ENODEV;
+
+		ctx->req_info->base.dev = dev;
+		ret = port_dump_one_dev(skb, cb);
+		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
+			ret = skb->len;
+
+		netdev_put(dev, &dev_tracker);
+	} else {
+		ret = port_dump_all_dev(skb, cb);
+	}
+
+	return ret;
+}
+
+int ethnl_port_dump_done(struct netlink_callback *cb)
+{
+	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
+
+	kfree(ctx->req_info);
+	kfree(ctx->reply_data);
+
+	return 0;
+}
+
+const struct ethnl_request_ops ethnl_port_request_ops = {
+	.request_cmd		= ETHTOOL_MSG_PORT_GET,
+	.reply_cmd		= ETHTOOL_MSG_PORT_GET_REPLY,
+	.hdr_attr		= ETHTOOL_A_PORT_HEADER,
+	.req_info_size		= sizeof(struct port_req_info),
+	.reply_data_size	= sizeof(struct port_reply_data),
+
+	.parse_request		= port_parse_request,
+	.prepare_data		= port_prepare_data,
+	.reply_size		= port_reply_size,
+	.fill_reply		= port_fill_reply,
+};
-- 
2.49.0


