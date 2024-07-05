Return-Path: <netdev+bounces-109485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B209289A2
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1D928860A
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6171607B0;
	Fri,  5 Jul 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YkdNO5DZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17C15FA6A;
	Fri,  5 Jul 2024 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186049; cv=none; b=Mx1DBUQYD6ntCEAExGlvSX94atdS99ucR0tOsFCNRWOlH60BLysvXhhfPAlLPdEBcEqI75W4Jp8vEOj1xtDWX8ncxXavlYQVK3hLNmUN+jOq3RQD7U92r837fnIf5wKicluKUtXpu6GOdvaVZbF4wZ34ik9cXvP13psIE9XmJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186049; c=relaxed/simple;
	bh=KSSx+KYjMR7bCwhkJRCms51uHkqlXGtbtbHJUhgUXPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5yeNv0YOBSeXU+WIQS2q+/ARGQnfRdOtpWRwKvma+tSfdxCWSUEhDANo5b/rXdtAYSbiJY2VpTSFk0kS1L8oWbJXkNlfwTfV83xXFVeTIPqaGcnFA5N4PaJ9IL3lqs5AVDp1Zz0qlBV3MthSpnlEtbC6/XuV/HzbD85Xavcl9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YkdNO5DZ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AEE401C0004;
	Fri,  5 Jul 2024 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720186046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBp0gu6RByXQ4En1iU80B6GBTpxFDS2OE397CJtr38o=;
	b=YkdNO5DZEN35DWuVM4a+71IzV63hwLWJBUqcfEfhk23OWwnuXL/FVJAYrznseBSI86WIqJ
	yA3PiTcM6SGDAygwrpXn6ZFW131a4NG690pgwEctifq8UFvfChkZRXw4/c5px5h6MvuKHf
	kvlXyDZyPOZn8bsjUJ0/bmAiFp1JtDeZp42KBURoV/oaiSqImdFD92d61BsJcbN7+eZUNK
	CMq49gVzHISnvaiqttaW2CoMrBoTQFa6sfLNcDKOgbS/oKvtl8HVZAF63czD2NjQ7z/9iR
	DRPUUm49hqv0i/ieO1ut4ydP8Hshf70NsEPzXTRFdc59rmCEUGN4VZaEW4bJdg==
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
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v16 11/14] net: ethtool: cable-test: Target the command to the requested PHY
Date: Fri,  5 Jul 2024 15:27:02 +0200
Message-ID: <20240705132706.13588-12-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240705132706.13588-1-maxime.chevallier@bootlin.com>
References: <20240705132706.13588-1-maxime.chevallier@bootlin.com>
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


