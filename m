Return-Path: <netdev+bounces-108160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E03191E080
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A132F1C216B8
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4920B16B735;
	Mon,  1 Jul 2024 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pBGp3rrB"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3630316A937;
	Mon,  1 Jul 2024 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839907; cv=none; b=J8MeAgqwelwISFT9WBDfmiDyi78W4xnhLpTdcQfn9jM144rEs7Nvq/CDRM0Qa0PVSa4cA+P68iV3CjkTwkXeDk569ju8tHIaI2jxUZlbGmGFLa/n0OnPXtSTuejKRgJUDtn0/W9crI8XroYQzrxUQGARlrZX4V2VFHjlqalMjUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839907; c=relaxed/simple;
	bh=FCDkSxFWUhty8Zv7KbwkClsMF8gNXnMLTLlFCzEd/z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGcHXgQmPVYl7HvtJFL+NMPBF9+E2uiyrCv99I6x0nLIhDSPjq27YnDRmIhg1AC55pDwgpGMW2IOZ4SY9mK+YrFWevvt4nGV1KM68/yltSXMrx3TtzENDJxFl1glWUBxW+mFP2yMu5TE4Tet/o5IhwTG4W+4pMgEbbqDaAdOTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pBGp3rrB; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55F60FF811;
	Mon,  1 Jul 2024 13:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719839903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+qM2bzOsMqGJFpoKWeEd0u85jgdYg/zUwjtUwA1x4Mo=;
	b=pBGp3rrB6/ZumfOBAItRFlJu4CaAU9YL2YFxCRBuQz3kVwSFoo/+0Y3AwTwWOFyozMRi3Y
	1NE0OnzTD/bIJmzJsrDRbR0FFokiznbVmdxuyPw2WyarrWBKFehveWbh5czAkAfggKO1+n
	2olmh95S6RixulbgVhzRWx4Wsp1IvmpKtM9cSFr+ma9QiWcmYojso7tzFPqkYzZj4EIbs0
	aelytbamvIlO3oBRTF9Ecu92ZqxDWoGFRaLqBAe0DEr2TrSSGKf4/xAJS8wE8aG9f6rabd
	X3NoH9wifEWX8k3TbTMUfeZp5GswdXqPm8qG8gMFLPYpo8mBckBtQLqFtng7Ww==
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
Subject: [PATCH net-next v14 12/13] net: ethtool: strset: Allow querying phy stats by index
Date: Mon,  1 Jul 2024 15:17:58 +0200
Message-ID: <20240701131801.1227740-13-maxime.chevallier@bootlin.com>
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

The ETH_SS_PHY_STATS command gets PHY statistics. Use the phydev pointer
from the ethnl request to allow query phy stats from each PHY on the
link.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/strset.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index c678b484a079..ebc3a7ad0558 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -126,7 +126,7 @@ struct strset_reply_data {
 
 const struct nla_policy ethnl_strset_get_policy[] = {
 	[ETHTOOL_A_STRSET_HEADER]	=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 	[ETHTOOL_A_STRSET_STRINGSETS]	= { .type = NLA_NESTED },
 	[ETHTOOL_A_STRSET_COUNTS_ONLY]	= { .type = NLA_FLAG },
 };
@@ -233,17 +233,18 @@ static void strset_cleanup_data(struct ethnl_reply_data *reply_base)
 }
 
 static int strset_prepare_set(struct strset_info *info, struct net_device *dev,
-			      unsigned int id, bool counts_only)
+			      struct phy_device *phydev, unsigned int id,
+			      bool counts_only)
 {
 	const struct ethtool_phy_ops *phy_ops = ethtool_phy_ops;
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	void *strings;
 	int count, ret;
 
-	if (id == ETH_SS_PHY_STATS && dev->phydev &&
+	if (id == ETH_SS_PHY_STATS && phydev &&
 	    !ops->get_ethtool_phy_stats && phy_ops &&
 	    phy_ops->get_sset_count)
-		ret = phy_ops->get_sset_count(dev->phydev);
+		ret = phy_ops->get_sset_count(phydev);
 	else if (ops->get_sset_count && ops->get_strings)
 		ret = ops->get_sset_count(dev, id);
 	else
@@ -258,10 +259,10 @@ static int strset_prepare_set(struct strset_info *info, struct net_device *dev,
 		strings = kcalloc(count, ETH_GSTRING_LEN, GFP_KERNEL);
 		if (!strings)
 			return -ENOMEM;
-		if (id == ETH_SS_PHY_STATS && dev->phydev &&
+		if (id == ETH_SS_PHY_STATS && phydev &&
 		    !ops->get_ethtool_phy_stats && phy_ops &&
 		    phy_ops->get_strings)
-			phy_ops->get_strings(dev->phydev, strings);
+			phy_ops->get_strings(phydev, strings);
 		else
 			ops->get_strings(dev, id, strings);
 		info->strings = strings;
@@ -279,6 +280,8 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
 	const struct strset_req_info *req_info = STRSET_REQINFO(req_base);
 	struct strset_reply_data *data = STRSET_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
+	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
 	unsigned int i;
 	int ret;
 
@@ -297,6 +300,13 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
 		return 0;
 	}
 
+	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_HEADER_FLAGS],
+				      info->extack);
+
+	/* phydev can be NULL, check for errors only */
+	if (IS_ERR(phydev))
+		return PTR_ERR(phydev);
+
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		goto err_strset;
@@ -305,7 +315,7 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
 		    !data->sets[i].per_dev)
 			continue;
 
-		ret = strset_prepare_set(&data->sets[i], dev, i,
+		ret = strset_prepare_set(&data->sets[i], dev, phydev, i,
 					 req_info->counts_only);
 		if (ret < 0)
 			goto err_ops;
-- 
2.45.1


