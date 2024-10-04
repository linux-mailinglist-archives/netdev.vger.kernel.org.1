Return-Path: <netdev+bounces-132136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C51759908C9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8971C2186B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D041C3035;
	Fri,  4 Oct 2024 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nQ2zjjAQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FE81AA79D;
	Fri,  4 Oct 2024 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058575; cv=none; b=XAP97wtAsDqK+FDVYlZwkDb7W02Hu8/J5l7SqKK7Vgm90giI76sa1SN/qe+xEiTgIRHUxzynyftVNofM8fSjJr/SQvam+SbpYDODJ2AUDv7jXOnEAqQIXWm/5KQq8gRnd7+Ec84tRtrgqifp7a2IfH08jnZ1RqftmhmqiJOLi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058575; c=relaxed/simple;
	bh=MXRnTnSJrBb1vnWAX8AVE5zZEfy5t/0VU3LPcntsBkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAw6PZEFp/WnbE20i6u4/0t3mfsAaSDGIz5dv8A5SUtS0wtirDfITxiQ/X17DKQ3xbe10VkvRfi8rVX0ME4pc8o/QNko90LrPCmKAxAxvA2ohITpPQAblap60HH1hvS6JiEeYx6/B4Gs4/Fn7ZDfcRWL5YZKtq1Nk17jkAnyOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nQ2zjjAQ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ACE122000A;
	Fri,  4 Oct 2024 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728058571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WFvkoN0tzzAFwJQTN+9OZPcm7C12bxp5VehHzezOGxs=;
	b=nQ2zjjAQlt78dYOu0azZAA8LApDVs8sqGRzduRI0Q77ScZDM8EovGkfJup3Kt8KRk0SRDK
	FI35D4EVOm5eLhbjlxt7SrN9xB6Y/ldF72ZCCuDWhzjASUla+iNxbcAaODYABOELlZu0N4
	HJUwdmPhjQm+iQHwZbs6oriIhb82MNfYTuRCowgg0frvQAOMxw+jhYajfL85RK7Z2Oe37l
	3Cdxa9zyUQ5Lc4wU01d/Jd9lcDGMNu7AvZpP8/jEucICgW+oZ+obA2LWE2usGt8kX4lAXO
	PqSIvJeBoGo22TxqPFMJSke+eOfoTR876OO1S2hEDkNkMDNAXkS9jkgYSWIpsw==
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
Subject: [PATCH net-next v2 6/9] net: phy: marvell: mv88e1111 doesn't support isolate in SGMII mode
Date: Fri,  4 Oct 2024 18:15:56 +0200
Message-ID: <20241004161601.2932901-7-maxime.chevallier@bootlin.com>
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

The 88e1111 datasheet indicates that it supports the isolate mode in
GMII, RGMII and TBI modes, but doesn't mention what it does in the other
modes. Testing showed that setting the isolate bit while the PHY is in
SGMII mode has no effect.

Reflect that behaviour in the .can_isolate() driver ops.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2 : New patch

 drivers/net/phy/marvell.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 9964bf3dea2f..912b08d9c124 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1092,6 +1092,14 @@ static int m88e1111_set_tunable(struct phy_device *phydev,
 	}
 }
 
+static bool m88e1111_can_isolate(struct phy_device *phydev)
+{
+	if (phydev->interface == PHY_INTERFACE_MODE_SGMII)
+		return false;
+
+	return true;
+}
+
 static int m88e1011_get_downshift(struct phy_device *phydev, u8 *data)
 {
 	int val, cnt, enable;
@@ -3704,6 +3712,7 @@ static struct phy_driver marvell_drivers[] = {
 		.set_tunable = m88e1111_set_tunable,
 		.cable_test_start = m88e1111_vct_cable_test_start,
 		.cable_test_get_status = m88e1111_vct_cable_test_get_status,
+		.can_isolate = m88e1111_can_isolate,
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1111_FINISAR,
-- 
2.46.1


