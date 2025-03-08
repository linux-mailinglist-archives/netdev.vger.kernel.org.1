Return-Path: <netdev+bounces-173178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4505AA57BB2
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 16:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02383B25C3
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFA01E5217;
	Sat,  8 Mar 2025 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LixB57eb"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE841DE3C9;
	Sat,  8 Mar 2025 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741449296; cv=none; b=AeLYENv41Rt6UQtJpA6xqrXqhzuW2pdhuGHxO5QN3AnY0VqudKPZbDQElND3prj/8G1s8VmcEJt7sVBQQ7j3TP1tb885qJQAlmyL6rb5QWO7098aeGXH6z/Cg4xrp65sG9BokqMlmX10ZJ6v/KiR5ZFe+tm3f8RmdbvQWhLmQms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741449296; c=relaxed/simple;
	bh=Le7iU2kz14hHkqMBiXqJQXW2tkN0IYSCehUL9QM0EBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2szRYBHRhgpJcCztZnj58z+yPnFrmUdBf+Ijvwq6F+DOsUBCMbdtehfEBIgvPoC9oB3QNo4etUvSM4nDVYJfjxSpXEJtcBqegSOOu+ItAr81Fk37qwjc/EUP6L/JYDFgE7ioW9a/TeNI4o4IvzdAYGmB8xgQRWngmAMxaGrQMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LixB57eb; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E0B0204D1;
	Sat,  8 Mar 2025 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741449291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSljUzfVjUS7vj/8lFVGAUTAWYg6fnBMTDrI8G2Z2oU=;
	b=LixB57eblbK8GYcASuDa9ONJwJh0syHZN6/nGu7FdmMzZLzc1PV7v79zh3DHNTD+DIDYSV
	xbIb7UBcJDabYBWoo1DQ/rp9cmASOXjFnhY7wcU7Ns+VeOGDdsOPEmp7nmsQv76STleftR
	umuDyjkzsTxj7JHzbykk9336NIoTIZ1XRblnXPwL9vKixPHrCnn5cEQHj3oyBKLnePw/OS
	7GR3VNMsXoN4lmBmz4b+46XiKif5PShSIaRfLcRbhzGDEL2cRo1x/0t9x96o81OL9VaWK8
	EwQL8i/K3G5EznhdDc8xIh4h55XbU3SwpdUaUWHp4c5AYbsX1BwNTTabpEBNkQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 5/7] net: ethtool: phy: Convert the PHY_GET command to generic phy dump
Date: Sat,  8 Mar 2025 16:54:37 +0100
Message-ID: <20250308155440.267782-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308155440.267782-1-maxime.chevallier@bootlin.com>
References: <20250308155440.267782-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudefleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvddtueefvdfhiefgieelfeeggeefiedvueevkedttddvffekleeujedtjeeuteehnecuffhomhgrihhnpegsrghsvgdruggvvhenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Now that we have an infrastructure in ethnl for perphy DUMPs, we can get
rid of the custom ->doit and ->dumpit to deal with PHY listing commands.

As most of the code was custom, this basically means re-writing how we
deal with PHY listing.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: Rebase

 net/ethtool/netlink.c |   9 +-
 net/ethtool/netlink.h |   4 -
 net/ethtool/phy.c     | 343 ++++++++++++------------------------------
 3 files changed, 103 insertions(+), 253 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index a09bcd67b38f..dcc2b84095ea 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -381,6 +381,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_MM_SET]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_TSCONFIG_GET]	= &ethnl_tsconfig_request_ops,
 	[ETHTOOL_MSG_TSCONFIG_SET]	= &ethnl_tsconfig_request_ops,
+	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -1344,10 +1345,10 @@ static const struct genl_ops ethtool_genl_ops[] = {
 	},
 	{
 		.cmd	= ETHTOOL_MSG_PHY_GET,
-		.doit	= ethnl_phy_doit,
-		.start	= ethnl_phy_start,
-		.dumpit	= ethnl_phy_dumpit,
-		.done	= ethnl_phy_done,
+		.doit	= ethnl_default_doit,
+		.start	= ethnl_default_start,
+		.dumpit	= ethnl_default_dumpit,
+		.done	= ethnl_default_done,
 		.policy = ethnl_phy_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_phy_get_policy) - 1,
 	},
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 530a9b5c8b39..60f16090640f 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -542,10 +542,6 @@ int ethnl_tunnel_info_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info);
 int ethnl_rss_dump_start(struct netlink_callback *cb);
 int ethnl_rss_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
-int ethnl_phy_start(struct netlink_callback *cb);
-int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info);
-int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
-int ethnl_phy_done(struct netlink_callback *cb);
 int ethnl_tsinfo_start(struct netlink_callback *cb);
 int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int ethnl_tsinfo_done(struct netlink_callback *cb);
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index 1a6b725d1f14..90c27dd1a5c6 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -11,304 +11,157 @@
 #include <linux/sfp.h>
 
 struct phy_req_info {
-	struct ethnl_req_info		base;
-	struct phy_device_node		*pdn;
+	struct ethnl_req_info base;
 };
 
-#define PHY_REQINFO(__req_base) \
-	container_of(__req_base, struct phy_req_info, base)
+struct phy_reply_data {
+	struct ethnl_reply_data	base;
+	u32 phyindex;
+	char *drvname;
+	char *name;
+	unsigned int upstream_type;
+	char *upstream_sfp_name;
+	unsigned int upstream_index;
+	char *downstream_sfp_name;
+};
+
+#define PHY_REPDATA(__reply_base) \
+	container_of(__reply_base, struct phy_reply_data, base)
 
 const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1] = {
 	[ETHTOOL_A_PHY_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
 };
 
-/* Caller holds rtnl */
-static ssize_t
-ethnl_phy_reply_size(const struct ethnl_req_info *req_base,
-		     struct netlink_ext_ack *extack)
+static int phy_reply_size(const struct ethnl_req_info *req_info,
+			  const struct ethnl_reply_data *reply_data)
 {
-	struct phy_req_info *req_info = PHY_REQINFO(req_base);
-	struct phy_device_node *pdn = req_info->pdn;
-	struct phy_device *phydev = pdn->phy;
+	struct phy_reply_data *rep_data = PHY_REPDATA(reply_data);
 	size_t size = 0;
 
-	ASSERT_RTNL();
-
 	/* ETHTOOL_A_PHY_INDEX */
 	size += nla_total_size(sizeof(u32));
 
 	/* ETHTOOL_A_DRVNAME */
-	if (phydev->drv)
-		size += nla_total_size(strlen(phydev->drv->name) + 1);
+	if (rep_data->drvname)
+		size += nla_total_size(strlen(rep_data->drvname) + 1);
 
 	/* ETHTOOL_A_NAME */
-	size += nla_total_size(strlen(dev_name(&phydev->mdio.dev)) + 1);
+	size += nla_total_size(strlen(rep_data->name) + 1);
 
 	/* ETHTOOL_A_PHY_UPSTREAM_TYPE */
 	size += nla_total_size(sizeof(u32));
 
-	if (phy_on_sfp(phydev)) {
-		const char *upstream_sfp_name = sfp_get_name(pdn->parent_sfp_bus);
-
-		/* ETHTOOL_A_PHY_UPSTREAM_SFP_NAME */
-		if (upstream_sfp_name)
-			size += nla_total_size(strlen(upstream_sfp_name) + 1);
+	if (rep_data->upstream_sfp_name)
+		size += nla_total_size(strlen(rep_data->upstream_sfp_name) + 1);
 
-		/* ETHTOOL_A_PHY_UPSTREAM_INDEX */
+	if (rep_data->upstream_index)
 		size += nla_total_size(sizeof(u32));
-	}
-
-	/* ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME */
-	if (phydev->sfp_bus) {
-		const char *sfp_name = sfp_get_name(phydev->sfp_bus);
 
-		if (sfp_name)
-			size += nla_total_size(strlen(sfp_name) + 1);
-	}
+	if (rep_data->downstream_sfp_name)
+		size += nla_total_size(strlen(rep_data->downstream_sfp_name) + 1);
 
 	return size;
 }
 
-static int
-ethnl_phy_fill_reply(const struct ethnl_req_info *req_base, struct sk_buff *skb)
+static int phy_prepare_data(const struct ethnl_req_info *req_info,
+			    struct ethnl_reply_data *reply_data,
+			    const struct genl_info *info)
 {
-	struct phy_req_info *req_info = PHY_REQINFO(req_base);
-	struct phy_device_node *pdn = req_info->pdn;
-	struct phy_device *phydev = pdn->phy;
-	enum phy_upstream ptype;
+	struct phy_reply_data *rep_data = PHY_REPDATA(reply_data);
+	struct phy_link_topology *topo = reply_data->dev->link_topo;
+	struct nlattr **tb = info->attrs;
+	struct phy_device_node *pdn;
+	struct phy_device *phydev;
 
-	ptype = pdn->upstream_type;
+	/* RTNL is held by th caller */
+	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PHY_HEADER,
+				      info->extack);
+	if (IS_ERR_OR_NULL(phydev))
+		return -EOPNOTSUPP;
 
-	if (nla_put_u32(skb, ETHTOOL_A_PHY_INDEX, phydev->phyindex) ||
-	    nla_put_string(skb, ETHTOOL_A_PHY_NAME, dev_name(&phydev->mdio.dev)) ||
-	    nla_put_u32(skb, ETHTOOL_A_PHY_UPSTREAM_TYPE, ptype))
-		return -EMSGSIZE;
+	pdn = xa_load(&topo->phys, phydev->phyindex);
+	if (!pdn)
+		return -EOPNOTSUPP;
 
-	if (phydev->drv &&
-	    nla_put_string(skb, ETHTOOL_A_PHY_DRVNAME, phydev->drv->name))
-		return -EMSGSIZE;
+	rep_data->phyindex = phydev->phyindex;
+	rep_data->name = kstrdup(dev_name(&phydev->mdio.dev), GFP_KERNEL);
+	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
+	rep_data->upstream_type = pdn->upstream_type;
 
-	if (ptype == PHY_UPSTREAM_PHY) {
+	if (pdn->upstream_type == PHY_UPSTREAM_PHY) {
 		struct phy_device *upstream = pdn->upstream.phydev;
-		const char *sfp_upstream_name;
-
-		/* Parent index */
-		if (nla_put_u32(skb, ETHTOOL_A_PHY_UPSTREAM_INDEX, upstream->phyindex))
-			return -EMSGSIZE;
-
-		if (pdn->parent_sfp_bus) {
-			sfp_upstream_name = sfp_get_name(pdn->parent_sfp_bus);
-			if (sfp_upstream_name &&
-			    nla_put_string(skb, ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,
-					   sfp_upstream_name))
-				return -EMSGSIZE;
-		}
+		rep_data->upstream_index = upstream->phyindex;
 	}
 
-	if (phydev->sfp_bus) {
-		const char *sfp_name = sfp_get_name(phydev->sfp_bus);
+	if (pdn->parent_sfp_bus)
+		rep_data->upstream_sfp_name = kstrdup(sfp_get_name(pdn->parent_sfp_bus),
+						      GFP_KERNEL);
 
-		if (sfp_name &&
-		    nla_put_string(skb, ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,
-				   sfp_name))
-			return -EMSGSIZE;
-	}
+	if (phydev->sfp_bus)
+		rep_data->downstream_sfp_name = kstrdup(sfp_get_name(phydev->sfp_bus),
+							GFP_KERNEL);
 
 	return 0;
 }
 
-static int ethnl_phy_parse_request(struct ethnl_req_info *req_base,
-				   struct nlattr **tb,
-				   struct netlink_ext_ack *extack)
+static int phy_fill_reply(struct sk_buff *skb,
+			  const struct ethnl_req_info *req_info,
+			  const struct ethnl_reply_data *reply_data)
 {
-	struct phy_link_topology *topo = req_base->dev->link_topo;
-	struct phy_req_info *req_info = PHY_REQINFO(req_base);
-	struct phy_device *phydev;
-
-	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PHY_HEADER,
-				      extack);
-	if (!phydev)
-		return 0;
-
-	if (IS_ERR(phydev))
-		return PTR_ERR(phydev);
-
-	if (!topo)
-		return 0;
-
-	req_info->pdn = xa_load(&topo->phys, phydev->phyindex);
-
-	return 0;
-}
-
-int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct phy_req_info req_info = {};
-	struct nlattr **tb = info->attrs;
-	struct sk_buff *rskb;
-	void *reply_payload;
-	int reply_len;
-	int ret;
-
-	ret = ethnl_parse_header_dev_get(&req_info.base,
-					 tb[ETHTOOL_A_PHY_HEADER],
-					 genl_info_net(info), info->extack,
-					 true);
-	if (ret < 0)
-		return ret;
-
-	rtnl_lock();
-	netdev_lock_ops(req_info.base.dev);
-
-	ret = ethnl_phy_parse_request(&req_info.base, tb, info->extack);
-	if (ret < 0)
-		goto err_unlock;
-
-	/* No PHY, return early */
-	if (!req_info.pdn)
-		goto err_unlock;
-
-	ret = ethnl_phy_reply_size(&req_info.base, info->extack);
-	if (ret < 0)
-		goto err_unlock;
-	reply_len = ret + ethnl_reply_header_size();
-
-	rskb = ethnl_reply_init(reply_len, req_info.base.dev,
-				ETHTOOL_MSG_PHY_GET_REPLY,
-				ETHTOOL_A_PHY_HEADER,
-				info, &reply_payload);
-	if (!rskb) {
-		ret = -ENOMEM;
-		goto err_unlock;
-	}
+	struct phy_reply_data *rep_data = PHY_REPDATA(reply_data);
 
-	ret = ethnl_phy_fill_reply(&req_info.base, rskb);
-	if (ret)
-		goto err_free_msg;
-
-	netdev_unlock_ops(req_info.base.dev);
-	rtnl_unlock();
-	ethnl_parse_header_dev_put(&req_info.base);
-	genlmsg_end(rskb, reply_payload);
-
-	return genlmsg_reply(rskb, info);
-
-err_free_msg:
-	nlmsg_free(rskb);
-err_unlock:
-	netdev_unlock_ops(req_info.base.dev);
-	rtnl_unlock();
-	ethnl_parse_header_dev_put(&req_info.base);
-	return ret;
-}
-
-struct ethnl_phy_dump_ctx {
-	struct phy_req_info	*phy_req_info;
-	unsigned long ifindex;
-	unsigned long phy_index;
-};
-
-int ethnl_phy_start(struct netlink_callback *cb)
-{
-	const struct genl_info *info = genl_info_dump(cb);
-	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
-	int ret;
+	if (nla_put_u32(skb, ETHTOOL_A_PHY_INDEX, rep_data->phyindex) ||
+	    nla_put_string(skb, ETHTOOL_A_PHY_NAME, rep_data->name) ||
+	    nla_put_u32(skb, ETHTOOL_A_PHY_UPSTREAM_TYPE, rep_data->upstream_type))
+		return -EMSGSIZE;
 
-	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
+	if (rep_data->drvname &&
+	    nla_put_string(skb, ETHTOOL_A_PHY_DRVNAME, rep_data->drvname))
+		return -EMSGSIZE;
 
-	ctx->phy_req_info = kzalloc(sizeof(*ctx->phy_req_info), GFP_KERNEL);
-	if (!ctx->phy_req_info)
-		return -ENOMEM;
+	if (rep_data->upstream_index &&
+	    nla_put_u32(skb, ETHTOOL_A_PHY_UPSTREAM_INDEX,
+			rep_data->upstream_index))
+		return -EMSGSIZE;
 
-	ret = ethnl_parse_header_dev_get(&ctx->phy_req_info->base,
-					 info->attrs[ETHTOOL_A_PHY_HEADER],
-					 sock_net(cb->skb->sk), cb->extack,
-					 false);
-	ctx->ifindex = 0;
-	ctx->phy_index = 0;
+	if (rep_data->upstream_sfp_name &&
+	    nla_put_string(skb, ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,
+			   rep_data->upstream_sfp_name))
+		return -EMSGSIZE;
 
-	if (ret)
-		kfree(ctx->phy_req_info);
+	if (rep_data->downstream_sfp_name &&
+	    nla_put_string(skb, ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,
+			   rep_data->downstream_sfp_name))
+		return -EMSGSIZE;
 
-	return ret;
+	return 0;
 }
 
-int ethnl_phy_done(struct netlink_callback *cb)
+static void phy_cleanup_data(struct ethnl_reply_data *reply_data)
 {
-	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
-
-	if (ctx->phy_req_info->base.dev)
-		ethnl_parse_header_dev_put(&ctx->phy_req_info->base);
-
-	kfree(ctx->phy_req_info);
+	struct phy_reply_data *rep_data = PHY_REPDATA(reply_data);
 
-	return 0;
+	kfree(rep_data->drvname);
+	kfree(rep_data->name);
+	kfree(rep_data->upstream_sfp_name);
+	kfree(rep_data->downstream_sfp_name);
 }
 
-static int ethnl_phy_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
-				  struct netlink_callback *cb)
-{
-	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
-	struct phy_req_info *pri = ctx->phy_req_info;
-	struct phy_device_node *pdn;
-	int ret = 0;
-	void *ehdr;
-
-	if (!dev->link_topo)
-		return 0;
-
-	xa_for_each_start(&dev->link_topo->phys, ctx->phy_index, pdn, ctx->phy_index) {
-		ehdr = ethnl_dump_put(skb, cb, ETHTOOL_MSG_PHY_GET_REPLY);
-		if (!ehdr) {
-			ret = -EMSGSIZE;
-			break;
-		}
-
-		ret = ethnl_fill_reply_header(skb, dev, ETHTOOL_A_PHY_HEADER);
-		if (ret < 0) {
-			genlmsg_cancel(skb, ehdr);
-			break;
-		}
-
-		pri->pdn = pdn;
-		ret = ethnl_phy_fill_reply(&pri->base, skb);
-		if (ret < 0) {
-			genlmsg_cancel(skb, ehdr);
-			break;
-		}
-
-		genlmsg_end(skb, ehdr);
-	}
+const struct ethnl_request_ops ethnl_phy_request_ops = {
+	.request_cmd		= ETHTOOL_MSG_PHY_GET,
+	.reply_cmd		= ETHTOOL_MSG_PHY_GET_REPLY,
+	.hdr_attr		= ETHTOOL_A_PHY_HEADER,
+	.req_info_size		= sizeof(struct phy_req_info),
+	.reply_data_size	= sizeof(struct phy_reply_data),
 
-	return ret;
-}
+	.prepare_data		= phy_prepare_data,
+	.reply_size		= phy_reply_size,
+	.fill_reply		= phy_fill_reply,
+	.cleanup_data		= phy_cleanup_data,
 
-int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
-{
-	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
-	struct net *net = sock_net(skb->sk);
-	struct net_device *dev;
-	int ret = 0;
-
-	rtnl_lock();
-
-	if (ctx->phy_req_info->base.dev) {
-		dev = ctx->phy_req_info->base.dev;
-		netdev_lock_ops(dev);
-		ret = ethnl_phy_dump_one_dev(skb, dev, cb);
-		netdev_unlock_ops(dev);
-	} else {
-		for_each_netdev_dump(net, dev, ctx->ifindex) {
-			netdev_lock_ops(dev);
-			ret = ethnl_phy_dump_one_dev(skb, dev, cb);
-			netdev_unlock_ops(dev);
-			if (ret)
-				break;
-
-			ctx->phy_index = 0;
-		}
-	}
-	rtnl_unlock();
+	.dump_start		= ethnl_dump_start_perphy,
+	.dump_one_dev		= ethnl_dump_one_dev_perphy,
+	.dump_done		= ethnl_dump_done_perphy,
 
-	return ret;
-}
+	.allow_pernetdev_dump	= true,
+};
-- 
2.48.1


