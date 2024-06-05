Return-Path: <netdev+bounces-101001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC68FCFC6
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA8DB30524
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3271C5392;
	Wed,  5 Jun 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="onoSsidm"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC6E1C370A;
	Wed,  5 Jun 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591786; cv=none; b=hD/RvmxmOJdqeeryE1VpfsaKD4yxYOv2V0jytdoebNou3kpN8DTpNs09QY59Uom2tugnfha+A1ai2hdOgKvdOn+Vlvwy8s9z/wmFbRALLfpkARXWbAGLO+1FAr7C8FUcT+3MkwQfqrpfILJhG0G1q/bPeow8drDEKACDkEHUnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591786; c=relaxed/simple;
	bh=e6fTToYWq45w/807OmOw6rMDMu3d5j5d5Sgp+iyhRSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaORevvxCzGTsiZGsgdvJJPjEe5Mv7VrmPrc4we7QjUpI8Rwf3be03eVKEs4Q9q6k7HE6Pg5DWUkvvKHgI1dFRuiazIMgkINcbyzQLVMRRGITF46bX3L89lrOOuSMyLmMz4RdZCbdnzNBtjv9zkxC7cbdHYn7fspg1kaTjniYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=onoSsidm; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C8CC20011;
	Wed,  5 Jun 2024 12:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717591782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTeslFgz8vSg7S4dfVYAbCiXpnFjv0CJKUEzc0dnIH0=;
	b=onoSsidm9K+0s5Q3/i+ipqD202bwbXnlOCpTQT7V4xdrpphK3/fX2gWUER3FreaNus04SX
	CsVDqSsQwFhFbEX7yklfY4S58X3LtgiGyCHSbf7+ZvvW7gFYe7SYGYPfrz3sSJpcclt8LR
	pbKjjAvswvFxwVwRMYcQT84sjYhcrvuRSewEF3lSoqknQUsF7f3f74HNfkx2JfoCTk4OmV
	HG4FJixJ44N9zaTt4T+1h3ATMyIYV7AT86W79rHQ48zRJqrEHNpD3wFw6Pu+SScd5nSX+B
	dMl/xOUFsiq++zsawRId4MMbNmQPmz4oQfory+TVmccEnFthp7IIimOufUGEkA==
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
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCH net-next v12 11/13] net: ethtool: cable-test: Target the command to the requested PHY
Date: Wed,  5 Jun 2024 14:49:16 +0200
Message-ID: <20240605124920.720690-12-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240605124920.720690-1-maxime.chevallier@bootlin.com>
References: <20240605124920.720690-1-maxime.chevallier@bootlin.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 net/ethtool/cabletest.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index f6f136ec7ddf..73dd4c439a3d 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -13,7 +13,7 @@
 
 const struct nla_policy ethnl_cable_test_act_policy[] = {
 	[ETHTOOL_A_CABLE_TEST_HEADER]		=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 };
 
 static int ethnl_cable_test_started(struct phy_device *phydev, u8 cmd)
@@ -69,7 +69,7 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	dev = req_info.dev;
-	if (!dev->phydev) {
+	if (!req_info.phydev) {
 		ret = -EOPNOTSUPP;
 		goto out_dev_put;
 	}
@@ -85,12 +85,12 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto out_rtnl;
 
-	ret = ops->start_cable_test(dev->phydev, info->extack);
+	ret = ops->start_cable_test(req_info.phydev, info->extack);
 
 	ethnl_ops_complete(dev);
 
 	if (!ret)
-		ethnl_cable_test_started(dev->phydev,
+		ethnl_cable_test_started(req_info.phydev,
 					 ETHTOOL_MSG_CABLE_TEST_NTF);
 
 out_rtnl:
@@ -216,7 +216,7 @@ static const struct nla_policy cable_test_tdr_act_cfg_policy[] = {
 
 const struct nla_policy ethnl_cable_test_tdr_act_policy[] = {
 	[ETHTOOL_A_CABLE_TEST_TDR_HEADER]	=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 	[ETHTOOL_A_CABLE_TEST_TDR_CFG]		= { .type = NLA_NESTED },
 };
 
@@ -317,7 +317,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	dev = req_info.dev;
-	if (!dev->phydev) {
+	if (!req_info.phydev) {
 		ret = -EOPNOTSUPP;
 		goto out_dev_put;
 	}
@@ -338,12 +338,12 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto out_rtnl;
 
-	ret = ops->start_cable_test_tdr(dev->phydev, info->extack, &cfg);
+	ret = ops->start_cable_test_tdr(req_info.phydev, info->extack, &cfg);
 
 	ethnl_ops_complete(dev);
 
 	if (!ret)
-		ethnl_cable_test_started(dev->phydev,
+		ethnl_cable_test_started(req_info.phydev,
 					 ETHTOOL_MSG_CABLE_TEST_TDR_NTF);
 
 out_rtnl:
-- 
2.45.1


