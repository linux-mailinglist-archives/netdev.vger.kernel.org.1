Return-Path: <netdev+bounces-287606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHXcLk94BGqpKAIAu9opvQ
	(envelope-from <netdev+bounces-287606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:10:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF91533AF3
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD9DE30893AA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE5B4279E6;
	Wed, 13 May 2026 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uHe1HGfw"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5A34403A
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677564; cv=none; b=tbpY9xVALSsLN2m22FrOyv+7veCH0de88XZFmiWsympwbysGplyelr1yNbNV5ieh9Fk/ZwmIKQAqDZ7BtnbylgzDLQ6vn8lGKKwZKK15jQcDpcWaHTPqJE/6M8lB+XNGgxi3sqOkvM29Ko0pmMAHALdbgFcTls/IUJUNRRBSZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677564; c=relaxed/simple;
	bh=T30qyAN+f6mOl3y/7lI4UvVbAw6FGwP4tKVBBYTenuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCvriU5EiUzqfKyvMBSiZOtN6jBw1sx4se96YXDnZwY29w5smPlpsIv2AxMhS/RP4739tiwoPZc6zLhrVncrZXnMRhb0mjs2zbweN2YM6VDg5LiGWhjQfITs2nxpR7AO5ZteEKk9BxMFRofAqfwY8CLG7k48l9ysQzi9pC1XE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uHe1HGfw; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B26D04E42C8F;
	Wed, 13 May 2026 13:05:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8015F5FE21;
	Wed, 13 May 2026 13:05:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B2E711AF8D31;
	Wed, 13 May 2026 15:05:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778677558; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=qQX2TQuA5gPQcPKO63M0dFI7I64jdFr4A8PuxhNOahM=;
	b=uHe1HGfw3kxUu0W6Jkqzu1Q/HRRnatMtby6o+MnEojpOaQZP1poKdxJ0YuPGkro+EcgwCC
	tHY+BkXMAy5mw3yFADGYzL3pGnFkpNr1Q4NJOzvIvRX6lAjH8mzVcpliYUuAFl3A1Rm09H
	qUGHVTLocvAE01xo+9KmgOjU2a7EXQYwAFpz2UFf2iFWHl3m1R3utwldegmcBp8d9iHjw9
	z/sMDAQTJRRBp0hCHIi4fYuywyfC9EIzkfc3/Ye4gwVcgit4dlrazij7IwoRrnxlgQOlOS
	doGz+IKcdyaotRwS9fnsTdQeMWZGTw/VG1QQahzPtq8eG+pxD3HqTOk5r3daEw==
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
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>
Subject: [PATCH net-next v10 9/9] net: ethtool: Introduce ethtool command to list ports
Date: Wed, 13 May 2026 15:05:20 +0200
Message-ID: <20260513130521.1064094-10-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513130521.1064094-1-maxime.chevallier@bootlin.com>
References: <20260513130521.1064094-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 9BF91533AF3
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
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-287606-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
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
 net/ethtool/netlink.c |  25 +++
 net/ethtool/netlink.h |   8 +
 net/ethtool/port.c    | 368 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 403 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/port.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bbbbde6b907..be7d7e305706 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18567,6 +18567,7 @@ F:	Documentation/devicetree/bindings/net/ethernet-connector.yaml
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
index 5046023a30b1..7d23aba7c30d 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -19,6 +19,8 @@ static u32 ethnl_bcast_seq;
 			     ETHTOOL_FLAG_OMIT_REPLY)
 #define ETHTOOL_FLAGS_STATS (ETHTOOL_FLAGS_BASIC | ETHTOOL_FLAG_STATS)
 
+char phy_interface_names[PHY_INTERFACE_MODE_MAX][ETH_GSTRING_LEN] __ro_after_init;
+
 const struct nla_policy ethnl_header_policy[] = {
 	[ETHTOOL_A_HEADER_DEV_INDEX]	= { .type = NLA_U32 },
 	[ETHTOOL_A_HEADER_DEV_NAME]	= { .type = NLA_NUL_STRING,
@@ -422,6 +424,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_TSCONFIG_SET]	= &ethnl_tsconfig_request_ops,
 	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
 	[ETHTOOL_MSG_MSE_GET]		= &ethnl_mse_request_ops,
+	[ETHTOOL_MSG_PORT_GET]		= &ethnl_port_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -1546,6 +1549,15 @@ static const struct genl_ops ethtool_genl_ops[] = {
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
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
@@ -1568,10 +1580,23 @@ static struct genl_family ethtool_genl_family __ro_after_init = {
 
 /* module setup */
 
+static void __init ethnl_phy_names_populate(void)
+{
+	const char *name;
+	int i;
+
+	for (i = 0; i < PHY_INTERFACE_MODE_MAX; i++) {
+		name = phy_modes(i);
+		strscpy(phy_interface_names[i], name, ETH_GSTRING_LEN);
+	}
+}
+
 static int __init ethnl_init(void)
 {
 	int ret;
 
+	ethnl_phy_names_populate();
+
 	ret = genl_register_family(&ethtool_genl_family);
 	if (WARN(ret < 0, "ethtool: genetlink family registration failed"))
 		return ret;
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index aaf6f2468768..8b131e53fba4 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -5,11 +5,14 @@
 
 #include <linux/ethtool_netlink.h>
 #include <linux/netdevice.h>
+#include <linux/phy.h>
 #include <net/genetlink.h>
 #include <net/sock.h>
 
 struct ethnl_req_info;
 
+extern char phy_interface_names[PHY_INTERFACE_MODE_MAX][ETH_GSTRING_LEN];
+
 u32 ethnl_bcast_seq_next(void);
 int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 			       const struct nlattr *nest, struct net *net,
@@ -444,6 +447,7 @@ extern const struct ethnl_request_ops ethnl_mm_request_ops;
 extern const struct ethnl_request_ops ethnl_phy_request_ops;
 extern const struct ethnl_request_ops ethnl_tsconfig_request_ops;
 extern const struct ethnl_request_ops ethnl_mse_request_ops;
+extern const struct ethnl_request_ops ethnl_port_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
@@ -500,6 +504,7 @@ extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_get_policy[ETHTOOL_A_TSCONFIG_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_set_policy[ETHTOOL_A_TSCONFIG_MAX + 1];
 extern const struct nla_policy ethnl_mse_get_policy[ETHTOOL_A_MSE_HEADER + 1];
+extern const struct nla_policy ethnl_port_get_policy[ETHTOOL_A_PORT_ID + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
@@ -515,6 +520,9 @@ int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
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
index 000000000000..2b32c99e06f0
--- /dev/null
+++ b/net/ethtool/port.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2026 Bootlin
+ */
+#include <linux/phy.h>
+#include <linux/phy_link_topology.h>
+#include <linux/phy_port.h>
+#include <net/netdev_lock.h>
+
+#include "bitset.h"
+#include "common.h"
+#include "netlink.h"
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
+	bool vacant;
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
+	[ETHTOOL_A_PORT_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+};
+
+static int port_parse_request(struct ethnl_req_info *req_info,
+			      const struct genl_info *info,
+			      struct nlattr **tb,
+			      struct netlink_ext_ack *extack)
+{
+	struct port_req_info *request = PORT_REQINFO(req_info);
+
+	if (GENL_REQ_ATTR_CHECK(info, ETHTOOL_A_PORT_ID))
+		return -EINVAL;
+
+	request->port_id = nla_get_u32(tb[ETHTOOL_A_PORT_ID]);
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
+	reply->vacant = port->vacant;
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
+
+		size += ret;
+	}
+
+	/* ETHTOOL_A_PORT_TYPE */
+	size += nla_total_size(sizeof(u32));
+
+	/* ETHTOOL_A_PORT_VACANT */
+	size += nla_total_size(sizeof(u32));
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
+			return ret;
+	} else {
+		ret = ethnl_put_bitset(skb, ETHTOOL_A_PORT_SUPPORTED_INTERFACES,
+				       reply->interfaces, NULL,
+				       PHY_INTERFACE_MODE_MAX,
+				       phy_interface_names, compact);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (reply->mii || reply->sfp)
+		port_type = ETHTOOL_PORT_TYPE_SFP;
+
+	if (nla_put_u32(skb, ETHTOOL_A_PORT_TYPE, port_type) ||
+	    nla_put_u32(skb, ETHTOOL_A_PORT_VACANT, reply->vacant))
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
+	req_info = kzalloc_obj(*req_info);
+	if (!req_info)
+		return -ENOMEM;
+
+	reply_data = kmalloc_obj(*reply_data);
+	if (!reply_data) {
+		ret = -ENOMEM;
+		goto free_req_info;
+	}
+
+	ret = ethnl_parse_header_dev_get(&req_info->base, tb[ETHTOOL_A_PORT_HEADER],
+					 genl_info_net(&info->info),
+					 info->info.extack, false);
+	if (ret < 0)
+		goto free_rep_data;
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
+free_rep_data:
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
+	ehdr = ethnl_dump_put(skb, cb, ETHTOOL_MSG_PORT_GET_REPLY);
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
+		if (ret)
+			break;
+
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
2.54.0


