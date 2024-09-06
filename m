Return-Path: <netdev+bounces-125891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D07C96F1F2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DCD1C220A7
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D751C9ED1;
	Fri,  6 Sep 2024 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="WsZt2791"
X-Original-To: netdev@vger.kernel.org
Received: from mxe.seznam.cz (mxe.seznam.cz [77.75.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4C149013
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620020; cv=none; b=YOlSTd8gAOjHlYV+q6FpQB70Qu91r5Ukjbec+LHVUNM+rYS5BHBBY55EcY1suL1ea90MMuSvdI9V8ayPU8zDvZiyi7O5eGROOMWymeAyqTR3T6DgQaPoksztWHkYiuuygPh9U5A4k1KMgPtDG6Z6wRMLOV1FYRtVIr5Y+2ac/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620020; c=relaxed/simple;
	bh=nCBQAauA2ILCBmP6CvuTWLmj6nXO7ZVYQUlsyc4Nn4I=;
	h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type; b=W0ICRrnAjCmyeWvaKjW3JdK40TEOPstisjqDkBnhxUpHqHl4dn43B5ARQlbhfMDBkIA573KKi4G4M76485zuUaRcqXunwRtvj/SSdXokvXI0MAiaXtwShtXeoTLEm3/MPktTxtZ22WuPxkgTxuf9AcbMEoTmRRYavtrgXBpgPv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=WsZt2791; arc=none smtp.client-ip=77.75.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Received: from email.seznam.cz
	by smtpc-mxe-6f7b5db655-grmdl
	(smtpc-mxe-6f7b5db655-grmdl [2a02:598:128:8a00::1000:50f])
	id 20c4a0bede301214204a2ea6;
	Fri, 06 Sep 2024 12:52:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
	s=szn20221014; t=1725619964;
	bh=L9fSUq9wqsb6tjOKmQgNimpO8VBJXjzkjf6Vt4Q8Jro=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
	 Content-Type:Content-Transfer-Encoding;
	b=WsZt2791To6yIoZN7ZJBI7JPg4gaWsXKqqA5HSA/kzu6RYOaiPrhiowgT3FIxk6U1
	 Nioqm/cEdlkUKBM0GMKHSHVDk0Np7wZKfwnorK7Q0OdGnxq3+95hU42xepu3Llwoml
	 POKvPLAwLJe6U+8/lBqsC6Ka4Z/rWf2WyxVfAPCg51reNHiqcTIdtvfL3Bmk8ABRT2
	 mtbAfa5Nbo+7/DvccsU6qtbgc3+wffmKi7ZfHCTw4qunO+HQ5q4cKwHiWquV9LmOP+
	 lKie0F77Fqe6osJKNsk/JTJzmJ6ps48KZ4p60bXZ2yWpcAhKdTvoW5JWYPAPKMW3qJ
	 n8BkZMJqw+Dwg==
Received: from 215-143.ktuo.cz (215-143.ktuo.cz [82.144.143.215])
	by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
	Fri, 06 Sep 2024 12:52:40 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <netdev@vger.kernel.org>
Cc: "Andrew Lunn" <andrew@lunn.ch>,
	"Heiner Kallweit" <hkallweit1@gmail.com>,
	"Russell King" <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Catalin Popescu" <catalin.popescu@leica-geosystems.com>,
	"Simon Horman" <horms@kernel.org>
Subject: =?utf-8?q?=5BPATCH_net_v2=5D_net=3A_phy=3A_dp83822=3A_Fix_NULL_po?=
	=?utf-8?q?inter_dereference_on_DP83825_devices?=
Date: Fri, 06 Sep 2024 12:52:40 +0200 (CEST)
Message-Id: <66w.ZbGt.65Ljx42yHo5.1csjxu@seznam.cz>
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

The probe() function is only used for DP83822 and DP83826 PHY,
leaving the private data pointer uninitialized for the DP83825 models
which causes a NULL pointer dereference in the recently introduced/changed=

functions dp8382x_config_init() and dp83822_set_wol().

Add the dp8382x_probe() function, so all PHY models will have a valid
private data pointer to fix this issue and also prevent similar issues
in the future.

Fixes: 9ef9ecfa9e9f ("net: phy: dp8382x: keep WOL settings across suspends=
")
Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
Changes since v1:
- Reused the newly introduced function in dp83822_probe() and dp83826_prob=
e()
---
 drivers/net/phy/dp83822.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index efeb643..fc247f4 100644
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
 
@@ -691,10 +689,9 @@ static int dp83822_read_straps(struct phy_device *phy=
dev)
 	return 0;
 }
 
-static int dp83822_probe(struct phy_device *phydev)
+static int dp8382x_probe(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822;
-	int ret;
 
 	dp83822 =3D devm_kzalloc(&phydev->mdio.dev, sizeof(*dp83822),
 			       GFP_KERNEL);
@@ -703,6 +700,20 @@ static int dp83822_probe(struct phy_device *phydev)=

 
 	phydev->priv =3D dp83822;
 
+	return 0;
+}
+
+static int dp83822_probe(struct phy_device *phydev)
+{
+	struct dp83822_private *dp83822;
+	int ret;
+
+	ret =3D dp8382x_probe(phydev);
+	if (ret)
+		return ret;
+
+	dp83822 =3D phydev->priv;
+
 	ret =3D dp83822_read_straps(phydev);
 	if (ret)
 		return ret;
@@ -717,14 +728,11 @@ static int dp83822_probe(struct phy_device *phydev)=

 
 static int dp83826_probe(struct phy_device *phydev)
 {
-	struct dp83822_private *dp83822;
-
-	dp83822 =3D devm_kzalloc(&phydev->mdio.dev, sizeof(*dp83822),
-			       GFP_KERNEL);
-	if (!dp83822)
-		return -ENOMEM;
+	int ret;
 
-	phydev->priv =3D dp83822;
+	ret =3D dp8382x_probe(phydev);
+	if (ret)
+		return ret;
 
 	dp83826_of_init(phydev);
 
@@ -795,6 +803,7 @@ static int dp83822_resume(struct phy_device *phydev)=

 		PHY_ID_MATCH_MODEL(_id),			\
 		.name		=3D (_name),			\
 		/* PHY_BASIC_FEATURES */			\
+		.probe          =3D dp8382x_probe,		\
 		.soft_reset	=3D dp83822_phy_reset,		\
 		.config_init	=3D dp8382x_config_init,		\
 		.get_wol =3D dp83822_get_wol,			\
-- 
2.7.4
 

