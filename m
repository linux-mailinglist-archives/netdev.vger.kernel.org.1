Return-Path: <netdev+bounces-132140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD19E9908D7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C565282FE0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A51E1C760B;
	Fri,  4 Oct 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XXZOTKXl"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20F1E3760;
	Fri,  4 Oct 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058577; cv=none; b=lpSLMB+5ATWC68z/3PiqINREgwU/rpPiYGZx2UsMdK0q8dd+7pne+DyshcAiFRNbFeUbEDTgOxy18SUVCkSU52lQXRQTjx+PACqF3iTmMIKlv3GzsW1AD55EIZdax2zf5x7jEl6Q5DuMxExK+ywAg4J1VDLvXOWT090EkGQgY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058577; c=relaxed/simple;
	bh=Nl9ovOr0JrFISdFoJ16CYHXfCUoM759fcxXvz+/XEps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipIe8ju3uBfJvfKVAGaRpNHS16isLhMdP9tOReAyzrxfeC/rvCCzxc76rb7wTyULI8j6ePMZub8QNHZLqv2XkjEkHBd1d2sOInJzaJEROBC8F03R3pDLcSRHmRqbN+oiBvoMFc0RHzz+V1WoE4H7YrmQ5soh4a8PefZkXFmgdmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XXZOTKXl; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A8072000D;
	Fri,  4 Oct 2024 16:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728058573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bbMTQ2Ujk5xefPwIIDflX8atbICLJzjWfHmkwLkMEk=;
	b=XXZOTKXlGW729F30JPg2425kU3jttNDmC5BAlvX0aBEmXaEkk4p1pK0eJ2Jtx6pBErIQ7T
	BIdePdzb1wqtPTnrUb3EfJ5vzSSFrzDc2fsYCyfe22/9CEtl0btrrptyW4CcdQ+GMs2F8g
	mULDRQc+3aTBR514Kl4GqKAIb51duuZz/gqJahGmupYG66xWgpt+oEpzSwLPGcCrxGMjNH
	rEdu2wNB4J7BVwgN9JyP/stpLwbdl5WRLOQ+YIpfreO/hezkOCsnLVmkhv6JOt3BeI5K9T
	mVPFakwcS2Uu1IUK1wKoJ3bghEiiFKnciSOAXU/oETNlmloI3QnLvBX96JE1hw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next v2 8/9] net: ethtool: phy: allow reporting and setting the phy isolate status
Date: Fri,  4 Oct 2024 18:15:58 +0200
Message-ID: <20241004161601.2932901-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Add the isolate status information to the ETHTOOL_PHY_GET
netlink command attributes, and allow changing this parameter from a
newly-introduced ETHTOOL_PHY_SET command.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2 : Dropped loopback mode

 Documentation/networking/ethtool-netlink.rst |  1 +
 include/uapi/linux/ethtool_netlink.h         |  2 +
 net/ethtool/netlink.c                        |  8 +++
 net/ethtool/netlink.h                        |  1 +
 net/ethtool/phy.c                            | 68 ++++++++++++++++++++
 5 files changed, 80 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 295563e91082..800a8812a760 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -2235,6 +2235,7 @@ Kernel response contents:
                                                 bus, the name of this sfp bus
   ``ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME`` string  if the phy controls an sfp bus,
                                                 the name of the sfp bus
+  ``ETHTOOL_A_PHY_ISOLATE``             u8      The PHY Isolate status
   ===================================== ======  ===============================
 
 When ``ETHTOOL_A_PHY_UPSTREAM_TYPE`` is PHY_UPSTREAM_PHY, the PHY's parent is
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 283305f6b063..bee5bf7ef90d 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -59,6 +59,7 @@ enum {
 	ETHTOOL_MSG_MM_SET,
 	ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
 	ETHTOOL_MSG_PHY_GET,
+	ETHTOOL_MSG_PHY_SET,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -1079,6 +1080,7 @@ enum {
 	ETHTOOL_A_PHY_UPSTREAM_INDEX,		/* u32 */
 	ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,	/* string */
 	ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,	/* string */
+	ETHTOOL_A_PHY_ISOLATE,			/* u8 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PHY_CNT,
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index e3f0ef6b851b..26982f47a934 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -394,6 +394,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_PLCA_GET_STATUS]	= &ethnl_plca_status_request_ops,
 	[ETHTOOL_MSG_MM_GET]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_MM_SET]		= &ethnl_mm_request_ops,
+	[ETHTOOL_MSG_PHY_SET]		= &ethnl_phy_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -1243,6 +1244,13 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_phy_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_phy_get_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_PHY_SET,
+		.flags	= GENL_UNS_ADMIN_PERM,
+		.doit	= ethnl_default_set_doit,
+		.policy = ethnl_phy_set_policy,
+		.maxattr = ARRAY_SIZE(ethnl_phy_set_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 203b08eb6c6f..7ae73e2eab32 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -485,6 +485,7 @@ extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
 extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
 extern const struct nla_policy ethnl_module_fw_flash_act_policy[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD + 1];
 extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1];
+extern const struct nla_policy ethnl_phy_set_policy[ETHTOOL_A_PHY_MAX + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index ed8f690f6bac..b211bd83a3a0 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -30,10 +30,13 @@ ethnl_phy_reply_size(const struct ethnl_req_info *req_base,
 	struct phy_req_info *req_info = PHY_REQINFO(req_base);
 	struct phy_device_node *pdn = req_info->pdn;
 	struct phy_device *phydev = pdn->phy;
+	const struct ethtool_phy_ops *ops;
 	size_t size = 0;
 
 	ASSERT_RTNL();
 
+	ops = ethtool_phy_ops;
+
 	/* ETHTOOL_A_PHY_INDEX */
 	size += nla_total_size(sizeof(u32));
 
@@ -66,6 +69,10 @@ ethnl_phy_reply_size(const struct ethnl_req_info *req_base,
 			size += nla_total_size(strlen(sfp_name) + 1);
 	}
 
+	/* ETHTOOL_A_PHY_ISOLATE */
+	if (ops && ops->get_config)
+		size += nla_total_size(sizeof(u8));
+
 	return size;
 }
 
@@ -75,10 +82,20 @@ ethnl_phy_fill_reply(const struct ethnl_req_info *req_base, struct sk_buff *skb)
 	struct phy_req_info *req_info = PHY_REQINFO(req_base);
 	struct phy_device_node *pdn = req_info->pdn;
 	struct phy_device *phydev = pdn->phy;
+	const struct ethtool_phy_ops *ops;
+	struct phy_device_config cfg;
 	enum phy_upstream ptype;
+	int ret;
 
 	ptype = pdn->upstream_type;
 
+	ops = ethtool_phy_ops;
+	if (ops && ops->get_config) {
+		ret = ops->get_config(phydev, &cfg);
+		if (ret)
+			return ret;
+	}
+
 	if (nla_put_u32(skb, ETHTOOL_A_PHY_INDEX, phydev->phyindex) ||
 	    nla_put_string(skb, ETHTOOL_A_PHY_NAME, dev_name(&phydev->mdio.dev)) ||
 	    nla_put_u32(skb, ETHTOOL_A_PHY_UPSTREAM_TYPE, ptype))
@@ -114,6 +131,13 @@ ethnl_phy_fill_reply(const struct ethnl_req_info *req_base, struct sk_buff *skb)
 			return -EMSGSIZE;
 	}
 
+	/* Append PHY configuration, if possible */
+	if (!ops || !ops->get_config)
+		return 0;
+
+	if (nla_put_u8(skb, ETHTOOL_A_PHY_ISOLATE, cfg.isolate))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
@@ -304,3 +328,47 @@ int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 	return ret;
 }
+
+const struct nla_policy ethnl_phy_set_policy[] = {
+	[ETHTOOL_A_PHY_HEADER]		=
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
+	[ETHTOOL_A_PHY_ISOLATE]		= NLA_POLICY_MAX(NLA_U8, 1),
+};
+
+static int ethnl_set_phy(struct ethnl_req_info *req_info, struct genl_info *info)
+{
+	struct netlink_ext_ack *extack = info->extack;
+	const struct ethtool_phy_ops *ops;
+	struct nlattr **tb = info->attrs;
+	struct phy_device_config cfg;
+	struct phy_device *phydev;
+	bool mod = false;
+	int ret;
+
+	ops = ethtool_phy_ops;
+	if (!ops || !ops->set_config || !ops->get_config)
+		return -EOPNOTSUPP;
+
+	/* We're running under rtnl */
+	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PHY_HEADER],
+				      extack);
+	if (IS_ERR_OR_NULL(phydev))
+		return -ENODEV;
+
+	ret = ops->get_config(phydev, &cfg);
+	if (ret)
+		return ret;
+
+	ethnl_update_bool(&cfg.isolate, tb[ETHTOOL_A_PHY_ISOLATE], &mod);
+
+	if (!mod)
+		return 0;
+
+	/* Returning 0 is fine as we don't have a notification */
+	return ops->set_config(phydev, &cfg, extack);
+}
+
+const struct ethnl_request_ops ethnl_phy_request_ops = {
+	.hdr_attr		= ETHTOOL_A_PHY_HEADER,
+	.set			= ethnl_set_phy,
+};
-- 
2.46.1


