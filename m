Return-Path: <netdev+bounces-48720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1F87EF56F
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C2B1F26B0B
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD913D3A3;
	Fri, 17 Nov 2023 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e0kItRtr"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7753211D;
	Fri, 17 Nov 2023 07:40:27 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1CC401BF204;
	Fri, 17 Nov 2023 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700235625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m2+rY8uZYdxjl8tssWKAYCzjgSzumnM1Z1aVzBnQkVM=;
	b=e0kItRtr9WgR4t9hvwrQA9gzRCvFYqf0gh3Fdm7EoY0ZnsICZ9GDbFcVOi11hJsdU8zM8g
	n3y14Sd3LlGbycEFa0g7aafBQYP6jjNAMNb7pBXoDupWi71V5iFYTflQE1iToqhXoNKYDS
	oeNaj3REahJxU9s/S4p7ZcWTRO0cH4z0XRm5pXR7wiJTHtFX5/sQE35YHtSjGbZdhJmpZR
	Jkfjk26sFCcw/i/VQrXjoCytUQh7Ssy8Ec7M3U0izdwBKrtpijAU5nvSg5lfnDTbCF9vjT
	ibebjq3VQU5EahsFXJ8xE279klWCJFCsMDC2FGOS+EB7oWPzuAFKnoAWAkg4kA==
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
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [RFC PATCH net-next v2 09/10] net: ethtool: cable-test: Target the command to the requested PHY
Date: Fri, 17 Nov 2023 17:23:20 +0100
Message-ID: <20231117162323.626979-10-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
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
 net/ethtool/cabletest.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index 06a151165c31..6b00d0800f23 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
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
@@ -321,7 +321,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	dev = req_info.dev;
-	if (!dev->phydev) {
+	if (!req_info.phydev) {
 		ret = -EOPNOTSUPP;
 		goto out_dev_put;
 	}
@@ -342,12 +342,12 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
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
2.41.0


