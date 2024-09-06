Return-Path: <netdev+bounces-125837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A096EE58
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC471F24961
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69022157E61;
	Fri,  6 Sep 2024 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="KAabVm1W"
X-Original-To: netdev@vger.kernel.org
Received: from mxe.seznam.cz (mxe.seznam.cz [77.75.78.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B6615852B
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611950; cv=none; b=ZR+tLxS32+Ag61gf8HwifUL/bvWr/x09ZDUn0a+wc3Wi+zWob9eHT29mlaqsDnznS90gVDSZR2/YPbsdRw56kswu776Nu3qCDdwgbfKdcz9rPTt3o/duFyjeitCiVvPRoa1jc3ANgWvQiDFmhy7Y+YSh0u7RE2hqluP9gDOlhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611950; c=relaxed/simple;
	bh=1CybpmpwQH/lQCvuXZ9Eish1mXUC0wWG3P10eP8BPrI=;
	h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type; b=e8mT7I3jAlO8XGjuFM3Sw30AgMJZbc6UyVJL4lcHW41fMOQjmu8ug58ylRMxPTR1yaU8a1cXwrVF7snHkDKvUtKwXtnUw7OosmHj5IkJffRVNCX6tZ42DYgz1kyacX4+qZi5n03sV6KK8IQY7qtnCW1z0ISUzWdnwN8v5btAX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=KAabVm1W; arc=none smtp.client-ip=77.75.78.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Received: from email.seznam.cz
	by smtpc-mxe-6f7b5db655-grmdl
	(smtpc-mxe-6f7b5db655-grmdl [2a02:598:128:8a00::1000:50f])
	id 26de91ebd82a234126501ff3;
	Fri, 06 Sep 2024 10:38:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
	s=szn20221014; t=1725611927;
	bh=HTqYFE7baJB6iNvfkHQ/wXgR3ULPMCsZL0LEQh5oJjs=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
	 Content-Type:Content-Transfer-Encoding;
	b=KAabVm1WpNALkLdcgbfoBJCkqCdirH3mIeFIKzYye9M5XNQPD+Tuyw7M6X4kQlntl
	 vJA6T2+Z+pXuVD/FJB7O47N6Zd+r4/nHbREjkzLfNK/Kk99licZvRW7RtRRC0/2bsy
	 y0XLFYEfqEJPao2QeZtu/UGId3yKCQHdXc32Eh4EKyiKYX/YK1ui6eQNfwz81oMH1E
	 aruslA5lTzgtu97LbGvsl02hPwAmzoTQWv/JEqQG2+N2InRFWc1aBS4Hozl/1sQd0X
	 96+t8UH32z7tn4V7EPaTgPEzSq1zgOn83pq0qFzqlfucKzaxx8RE3nQ7E1ro0oaXxy
	 9N6/eQgm79BrQ==
Received: from 215-143.ktuo.cz (215-143.ktuo.cz [82.144.143.215])
	by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
	Fri, 06 Sep 2024 10:38:40 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <netdev@vger.kernel.org>
Cc: "Andrew Lunn" <andrew@lunn.ch>,
	"Heiner Kallweit" <hkallweit1@gmail.com>,
	"Russell King" <linux@armlinux.org.uk>
Subject: =?utf-8?q?=5BPATCH=5D_net=3A_phy=3A_dp83822=3A_Fix_NULL_pointer_d?=
	=?utf-8?q?ereference_on_DP83825_devices?=
Date: Fri, 06 Sep 2024 10:38:40 +0200 (CEST)
Message-Id: <60o.ZbUd.3E5eHrOkFLD.1csh{G@seznam.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

The probe() function is only used for DP83822 and DP83826 models,
leaving the private data pointer uninitialized for the DP83825 models
which causes a NULL pointer dereference in the recently changed functions=

dp8382x_config_init() and dp83822_set_wol().

Add the dp8382x_probe() function, so all PHY models will have a valid
private data pointer to prevent similar issues in the future.

Fixes: 9ef9ecfa9e9f ("net: phy: dp8382x: keep WOL settings across suspends=
")
Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/net/phy/dp83822.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index efeb643..58877c0 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -271,8 +271,7 @@ static int dp83822_config_intr(struct phy_device *phyd=
ev)
 				DP83822_ENERGY_DET_INT_EN |
 				DP83822_LINK_QUAL_INT_EN);
 
-		/* Private data pointer is NULL on DP83825 */
-		if (!dp83822 || !dp83822->fx_enabled)
+		if (!dp83822->fx_enabled)
 			misr_status |=3D DP83822_ANEG_COMPLETE_INT_EN |
 				       DP83822_DUP_MODE_CHANGE_INT_EN |
 				       DP83822_SPEED_CHANGED_INT_EN;
@@ -292,8 +291,7 @@ static int dp83822_config_intr(struct phy_device *phyd=
ev)
 				DP83822_PAGE_RX_INT_EN |
 				DP83822_EEE_ERROR_CHANGE_INT_EN);
 
-		/* Private data pointer is NULL on DP83825 */
-		if (!dp83822 || !dp83822->fx_enabled)
+		if (!dp83822->fx_enabled)
 			misr_status |=3D DP83822_ANEG_ERR_INT_EN |
 				       DP83822_WOL_PKT_INT_EN;
 
@@ -731,6 +729,20 @@ static int dp83826_probe(struct phy_device *phydev)=

 	return 0;
 }
 
+static int dp8382x_probe(struct phy_device *phydev)
+{
+	struct dp83822_private *dp83822;
+
+	dp83822 =3D devm_kzalloc(&phydev->mdio.dev, sizeof(*dp83822),
+			       GFP_KERNEL);
+	if (!dp83822)
+		return -ENOMEM;
+
+	phydev->priv =3D dp83822;
+
+	return 0;
+}
+
 static int dp83822_suspend(struct phy_device *phydev)
 {
 	int value;
@@ -795,6 +807,7 @@ static int dp83822_resume(struct phy_device *phydev)=

 		PHY_ID_MATCH_MODEL(_id),			\
 		.name		=3D (_name),			\
 		/* PHY_BASIC_FEATURES */			\
+		.probe          =3D dp8382x_probe,		\
 		.soft_reset	=3D dp83822_phy_reset,		\
 		.config_init	=3D dp8382x_config_init,		\
 		.get_wol =3D dp83822_get_wol,			\
-- 
2.7.4
 

