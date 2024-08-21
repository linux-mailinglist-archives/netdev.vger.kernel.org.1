Return-Path: <netdev+bounces-120650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A395A114
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE921F217EC
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2DE15B0E2;
	Wed, 21 Aug 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="To+OO1+6"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A34714D28E;
	Wed, 21 Aug 2024 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253037; cv=none; b=mydkrZd/Yd8rsK6GTXpggOkqDkeJPzC10yiWA3s6OTyRcMZSZl48DApaBBWdHuO+UUTf3zQD02FM5dRXA8Rhh4t2bovCeIzqLA0NDKJU9tqpzaIilPJvjY/qK9e7v/JeE+bkEK8MThB5vbXyctuMwDiDTVoWowN99P2J3baJ2jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253037; c=relaxed/simple;
	bh=9pOVqHCctrSuXgxCVrGYFLTbjtlnJDvWNmj6PAM0vBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAnVLUGSdL5Y06sGHK6HMgkdDuYAaBy0qJkiixlFZNqiEM9Fa3dvdGXTBfPVvwa2InlC4WoejDom1peDN88O0KPFUbMCZFXeQrNhT70WJ2x0EbUIO0bdzqEiTGPaNgFZqLK0sZdbtts9vlxQ4EUqtBCy/jTJXiv3R/CWbQAOUKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=To+OO1+6; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 419D540004;
	Wed, 21 Aug 2024 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724253029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gwqbj98vuyM7J95UWGmzg8cn+b44rPUXY5HHwKHfQ4=;
	b=To+OO1+6j5svzpn8SVwXehDH93r9mZdjzNw5PEHBiCtQS5+oa7AdDTwR6GRSxYfZzlCq1J
	dBedBn6g+bkpkqYyLS1R7KyFbuCbVhDtArFHL0Nl1jtnWoIAlz0VtwpmZCriUskrxsZIUR
	t8heJfEif66LRtwNokQgMdF0TIf891qBt2JlIvahe4X8hrU07xtamY7vuKAVQHNSUQ3jbA
	rK+fWq1IgU/uxe7Pwp8RiMshGTqaPxkcEuGcAZu/C9uE38nxwRxVB61a2X8fCGbqrf3MiE
	Pg2sPrHeSs5Ji7rRlXDlltpodOhm+zXht3Fdl1MB0GCLnRf51VF4ofAGWejsHw==
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
Subject: [PATCH net-next v18 09/13] net: ethtool: plca: Target the command to the requested PHY
Date: Wed, 21 Aug 2024 17:10:03 +0200
Message-ID: <20240821151009.1681151-10-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821151009.1681151-1-maxime.chevallier@bootlin.com>
References: <20240821151009.1681151-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

PLCA is a PHY-specific command. Instead of targeting the command
towards dev->phydev, use the request to pick the targeted PHY.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 net/ethtool/plca.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index b1e2e3b5027f..d95d92f173a6 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -25,7 +25,7 @@ struct plca_reply_data {
 
 const struct nla_policy ethnl_plca_get_cfg_policy[] = {
 	[ETHTOOL_A_PLCA_HEADER]		=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 };
 
 static void plca_update_sint(int *dst, struct nlattr **tb, u32 attrid,
@@ -58,10 +58,14 @@ static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
 	struct plca_reply_data *data = PLCA_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
 	const struct ethtool_phy_ops *ops;
+	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
 	int ret;
 
+	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PLCA_HEADER],
+				      info->extack);
 	// check that the PHY device is available and connected
-	if (!dev->phydev) {
+	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -80,7 +84,7 @@ static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
 	memset(&data->plca_cfg, 0xff,
 	       sizeof_field(struct plca_reply_data, plca_cfg));
 
-	ret = ops->get_plca_cfg(dev->phydev, &data->plca_cfg);
+	ret = ops->get_plca_cfg(phydev, &data->plca_cfg);
 	ethnl_ops_complete(dev);
 
 out:
@@ -129,7 +133,7 @@ static int plca_get_cfg_fill_reply(struct sk_buff *skb,
 
 const struct nla_policy ethnl_plca_set_cfg_policy[] = {
 	[ETHTOOL_A_PLCA_HEADER]		=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 	[ETHTOOL_A_PLCA_ENABLED]	= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_PLCA_NODE_ID]	= NLA_POLICY_MAX(NLA_U32, 255),
 	[ETHTOOL_A_PLCA_NODE_CNT]	= NLA_POLICY_RANGE(NLA_U32, 1, 255),
@@ -141,15 +145,17 @@ const struct nla_policy ethnl_plca_set_cfg_policy[] = {
 static int
 ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 {
-	struct net_device *dev = req_info->dev;
 	const struct ethtool_phy_ops *ops;
 	struct nlattr **tb = info->attrs;
 	struct phy_plca_cfg plca_cfg;
+	struct phy_device *phydev;
 	bool mod = false;
 	int ret;
 
+	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PLCA_HEADER],
+				      info->extack);
 	// check that the PHY device is available and connected
-	if (!dev->phydev)
+	if (IS_ERR_OR_NULL(phydev))
 		return -EOPNOTSUPP;
 
 	ops = ethtool_phy_ops;
@@ -168,7 +174,7 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (!mod)
 		return 0;
 
-	ret = ops->set_plca_cfg(dev->phydev, &plca_cfg, info->extack);
+	ret = ops->set_plca_cfg(phydev, &plca_cfg, info->extack);
 	return ret < 0 ? ret : 1;
 }
 
@@ -191,7 +197,7 @@ const struct ethnl_request_ops ethnl_plca_cfg_request_ops = {
 
 const struct nla_policy ethnl_plca_get_status_policy[] = {
 	[ETHTOOL_A_PLCA_HEADER]		=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 };
 
 static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
@@ -201,10 +207,14 @@ static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
 	struct plca_reply_data *data = PLCA_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
 	const struct ethtool_phy_ops *ops;
+	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
 	int ret;
 
+	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PLCA_HEADER],
+				      info->extack);
 	// check that the PHY device is available and connected
-	if (!dev->phydev) {
+	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -223,7 +233,7 @@ static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
 	memset(&data->plca_st, 0xff,
 	       sizeof_field(struct plca_reply_data, plca_st));
 
-	ret = ops->get_plca_status(dev->phydev, &data->plca_st);
+	ret = ops->get_plca_status(phydev, &data->plca_st);
 	ethnl_ops_complete(dev);
 out:
 	return ret;
-- 
2.45.2


