Return-Path: <netdev+bounces-110121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739D592B037
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297981F2299F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2753B156220;
	Tue,  9 Jul 2024 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DR9JsVzb"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1290F1553B7;
	Tue,  9 Jul 2024 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506667; cv=none; b=dxVs1rtwCgTyE1fxjhIMdT3rZ8N+SKDtNtSJmPiYuzu0txJgE9rSWWxgbhmrcO3WwTIOne4oNDxUitu34rSPU3gCd996IAwp9KYM2OMo688oABJXA+wD1l9QHpgPyGsZ6/1IHFz4n4z824bmM9MbmtiQC0Q9uU+zaBBU6wVIKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506667; c=relaxed/simple;
	bh=0ZUa1Fak+q04M/9vHFmWrxuQdPAbuEV/riaxeV4T430=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktj/CQki1p1Ds73RiwWp/lFTb9VXuewD6asMel+fYBOCkdxW6/ssgDpDmsRy5ZChlD5xBcHdrGFmJAOzPm41CCRuZKnNOsqfm63DColFcDYz2Foar4XB5p+dM/shOiAzSczccBS+8Sd3cPyIm7vRa+gn61gm5yq3f4MqMFr9YYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DR9JsVzb; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C11E1BF20D;
	Tue,  9 Jul 2024 06:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720506663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thN6IdfOGL5JBJUVblIwdG2InFbFxvoTmh4Xec8y75w=;
	b=DR9JsVzbZO1dMFGPJ5Kdud6LOuZf/VcXfZD5KilHRZfpg4yQcbai2ffHGmvOAPRiBTaH/O
	aoEoOLvfeU/MaJmvJrz6UlfDLeEJvUmDioaiHrxWHdt1VoRyYWW0fcWCl2hRDF69gUb0Tt
	0MCt1+oDQ/woVRNhnygWUW4VFWo3e7QW7kamPweemG4rrk9VuP1eTT3eN3vaeyz9MBi5QJ
	ePLK8HD8l6I9TH/8WYkK8iDPr7qZhHo0yuCgyNDXikiqzLeE7eFHU9cyW1WBTv3Kjr06dS
	GwjtqqvXi8l2vpStaQI+iUeID1bY/HKWLQM2mPWqrcU2stsn5wutwlmZjaYvng==
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
Subject: [PATCH net-next v17 13/14] net: ethtool: strset: Allow querying phy stats by index
Date: Tue,  9 Jul 2024 08:30:36 +0200
Message-ID: <20240709063039.2909536-14-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
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
index 56b99606f00b..b3382b3cf325 100644
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
 
@@ -296,6 +299,13 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
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
@@ -304,7 +314,7 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
 		    !data->sets[i].per_dev)
 			continue;
 
-		ret = strset_prepare_set(&data->sets[i], dev, i,
+		ret = strset_prepare_set(&data->sets[i], dev, phydev, i,
 					 req_info->counts_only);
 		if (ret < 0)
 			goto err_ops;
-- 
2.45.1


