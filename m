Return-Path: <netdev+bounces-108159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3885491E07D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88D00B25FF8
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C75116A942;
	Mon,  1 Jul 2024 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QqKefpP+"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788F41684A8;
	Mon,  1 Jul 2024 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839905; cv=none; b=hRDaVlc1C30Zkx1fUDh0POl1jZPmwsnbTSE8bwZVV2Qr6YI0gYqMOGdaefUGjSvG7aXw1X9vMrNSQUcbk6V/L7c135/CJ2Cx0Of1OudS9HOYm+ez6rFa7xhqrNCMbLLI0H4aL9qUyAOxJeNBGqFDP9Uf2TqT+964UO+B3NEH2Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839905; c=relaxed/simple;
	bh=KSSx+KYjMR7bCwhkJRCms51uHkqlXGtbtbHJUhgUXPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSBm1zo5fuiYxLJzKFEjv5K8PT8NGHEMJPHwyfUA91xsi9gB12r3/r+Dm5Q70eEQ/v6hdRun34/aXiHkTGt7h/yRdwzHdG20RDi3YNjrFwzX9YXKoTay69UY3etZjH5IxIH8gbQpTIu5Mq8HeN9JzMvfzKvbXe2S/s0+T+NpNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QqKefpP+; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1C32FF807;
	Mon,  1 Jul 2024 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719839902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBp0gu6RByXQ4En1iU80B6GBTpxFDS2OE397CJtr38o=;
	b=QqKefpP+E9RM1iOYiigBHywZgx5unxTJITYO2MCsXGONW5s5TUcl9una0Hc0iQCM2SLB7D
	c/R7lV3E9wUPJ3h2S8RvfN5PY2DKgtqh/4abFtPGtoTUBIAaMurraQFe/ulPNg5XyOgPBt
	HA4dI9QYgnvSHJsUPYWmaKoN+0mwq7Bi95mvR4LaOCnrzG8zzeNFwOmRl41jX+gu3FLBqm
	ybHUNKuCVjnhjfZ8i5Fq+nzj/dVMS9LfmztzWyMwJhI1km+eui31g9Jxcb6Oi5iFmHuO0Z
	hJadqrM7fYgS8QIHD+3clIOK84CjHhaTum/wl9stxWf2lW4Igt4rJo2onzrnAg==
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
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next v14 11/13] net: ethtool: cable-test: Target the command to the requested PHY
Date: Mon,  1 Jul 2024 15:17:57 +0200
Message-ID: <20240701131801.1227740-12-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240701131801.1227740-1-maxime.chevallier@bootlin.com>
References: <20240701131801.1227740-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Cable testing is a PHY-specific command. Instead of targeting the command
towards dev->phydev, use the request to pick the targeted PHY.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/cabletest.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index f6f136ec7ddf..01db8f394869 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -13,7 +13,7 @@
 
 const struct nla_policy ethnl_cable_test_act_policy[] = {
 	[ETHTOOL_A_CABLE_TEST_HEADER]		=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 };
 
 static int ethnl_cable_test_started(struct phy_device *phydev, u8 cmd)
@@ -58,6 +58,7 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 	struct ethnl_req_info req_info = {};
 	const struct ethtool_phy_ops *ops;
 	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
 	struct net_device *dev;
 	int ret;
 
@@ -69,12 +70,16 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	dev = req_info.dev;
-	if (!dev->phydev) {
+
+	rtnl_lock();
+	phydev = ethnl_req_get_phydev(&req_info,
+				      tb[ETHTOOL_A_CABLE_TEST_HEADER],
+				      info->extack);
+	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
 		goto out_dev_put;
 	}
 
-	rtnl_lock();
 	ops = ethtool_phy_ops;
 	if (!ops || !ops->start_cable_test) {
 		ret = -EOPNOTSUPP;
@@ -85,13 +90,12 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto out_rtnl;
 
-	ret = ops->start_cable_test(dev->phydev, info->extack);
+	ret = ops->start_cable_test(phydev, info->extack);
 
 	ethnl_ops_complete(dev);
 
 	if (!ret)
-		ethnl_cable_test_started(dev->phydev,
-					 ETHTOOL_MSG_CABLE_TEST_NTF);
+		ethnl_cable_test_started(phydev, ETHTOOL_MSG_CABLE_TEST_NTF);
 
 out_rtnl:
 	rtnl_unlock();
@@ -216,7 +220,7 @@ static const struct nla_policy cable_test_tdr_act_cfg_policy[] = {
 
 const struct nla_policy ethnl_cable_test_tdr_act_policy[] = {
 	[ETHTOOL_A_CABLE_TEST_TDR_HEADER]	=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 	[ETHTOOL_A_CABLE_TEST_TDR_CFG]		= { .type = NLA_NESTED },
 };
 
@@ -305,6 +309,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 	struct ethnl_req_info req_info = {};
 	const struct ethtool_phy_ops *ops;
 	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
 	struct phy_tdr_config cfg;
 	struct net_device *dev;
 	int ret;
@@ -317,10 +322,6 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	dev = req_info.dev;
-	if (!dev->phydev) {
-		ret = -EOPNOTSUPP;
-		goto out_dev_put;
-	}
 
 	ret = ethnl_act_cable_test_tdr_cfg(tb[ETHTOOL_A_CABLE_TEST_TDR_CFG],
 					   info, &cfg);
@@ -328,6 +329,14 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 		goto out_dev_put;
 
 	rtnl_lock();
+	phydev = ethnl_req_get_phydev(&req_info,
+				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
+				      info->extack);
+	if (!IS_ERR_OR_NULL(phydev)) {
+		ret = -EOPNOTSUPP;
+		goto out_dev_put;
+	}
+
 	ops = ethtool_phy_ops;
 	if (!ops || !ops->start_cable_test_tdr) {
 		ret = -EOPNOTSUPP;
@@ -338,12 +347,12 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto out_rtnl;
 
-	ret = ops->start_cable_test_tdr(dev->phydev, info->extack, &cfg);
+	ret = ops->start_cable_test_tdr(phydev, info->extack, &cfg);
 
 	ethnl_ops_complete(dev);
 
 	if (!ret)
-		ethnl_cable_test_started(dev->phydev,
+		ethnl_cable_test_started(phydev,
 					 ETHTOOL_MSG_CABLE_TEST_TDR_NTF);
 
 out_rtnl:
-- 
2.45.1


