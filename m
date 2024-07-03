Return-Path: <netdev+bounces-108926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08338926410
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E65E1F23045
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9411822C8;
	Wed,  3 Jul 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="NE8sgKhT"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02hn2228.outbound.protection.outlook.com [52.100.202.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708DF17E904;
	Wed,  3 Jul 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.202.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018663; cv=fail; b=o34tP1gWAe40sqnMRCJZvac0bc2IwH7In97BmuBsgNlWMFOEAUooJRglAqUor1YDQgcgMoW4SzQIXLOB8OiYFQordEBHRC/BKbre5nTEX+v2OBXoysyb5M8I0MFZWGTCUk5eKRJ5P3RbPBOVjl6A3RHcuS7BBvAt1XqZ7V9oWZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018663; c=relaxed/simple;
	bh=dH1lqlI73nwHTfmTtWhu6gg5rxKsFGlMPgaJUhDAD1U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vr+oB7DpI94sQv2JSRA8TcSss6KUmVA4QMiv/sRHlN8GvN5x7ht7wu+s3+S6zMAskbm4xgmfgOfb8sKq9oagy79xTfDi1oXhXPXJQ6y3Ln3jCg79EDzzqAGP3L4laaPW0pX7vADjrbesdhXzVS511859Up5yCZr8p4DPlx9l2zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=NE8sgKhT; arc=fail smtp.client-ip=52.100.202.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1Mptvr2FvfZCybkKyMfcJN4a6COgYrrcuJP1XFV3REM0u4ZWyCKI9bTqCRH/BSQpQwD8tKuzsjKJF9A/z7yIaD+CaYT2nkmqaB8QXiZq3TStJs+Ztss0N6umOeCx/WFdn5pYJg5jRcKfE45Q5GDgGv2Nrm6fIZY3bALjChOrD2v1zwvEPYDl5QaCgma/fD3otHS26ax1sEoOdC/tF7ia5L7RukA6hk36OODUHUQpJo9xuo6Bsg05ZdsjypvSrEPbxUWo5pt10gSUPpS9WE/2dI8x+kvKur2lMRP53vLwvaRlBv/67T/+uhvGe5Awkt7Gnd1gvavmsmreprIDQ1hFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwU9KFby2UrfklUYFq+Lg59U6fKOAcMEnNy+uqbKSZI=;
 b=ExZlONK2NUtvpGcvZoBhbYMopu36JXT92HNL3OzK0mXY40t8DkArPY+2eMnlrMCyqbQ848vDbGUbV7CReRGeGuDIExp9SH+c6wM6vaod4mAPERSV/z8/KXZocV92VY+DbmCL7hWwjAy6wLRfMe3z5slxHRaAhPT9Kr1XPcDVRKpT/XSwMxOwqGIVB+Wy5reqRJ7jp/U5qM08C6GpgMTu1jA3hO2O6F7X7OHC++r2WMd1R/yM0e1TzQtFEtwsko4lLsMTh/oh9iPAje8fADCQAeVPb9qRl2OVn/wzdqNU4AEAYCuHNX1MKbMAURz7OXftoXuD0R5u37d+19LGjAFHog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=lunn.ch smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwU9KFby2UrfklUYFq+Lg59U6fKOAcMEnNy+uqbKSZI=;
 b=NE8sgKhTcK02YhPnmOQhx4dHTJrJI+pfyVDjwe2GXOtbp5oR+GAIn43e8q/NF+MSD5ormq5QPamlUkPJO7GqZRVxukpaxbwoBhVuyzmGGmBvlr4ijObMQ6AQHkW9sq0GNLj2Np74fwuqw3TztBSeNmWf9jFeaCbJZtX70CUst0k=
Received: from DUZP191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::24)
 by AS5PR07MB9985.eurprd07.prod.outlook.com (2603:10a6:20b:67e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 14:57:36 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::cd) by DUZP191CA0028.outlook.office365.com
 (2603:10a6:10:4f8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 14:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 14:57:35 +0000
Received: from N9W6SW14.arri.de (10.30.4.245) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 3 Jul
 2024 16:57:35 +0200
From: Christian Eggers <ceggers@arri.de>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Juergen Beisert
	<jbe@pengutronix.de>, Stefan Roese <sr@denx.de>, Juergen Borleis
	<kernel@pengutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Christian Eggers
	<ceggers@arri.de>
Subject: [PATCH net 1/2] dsa: lan9303: Fix mapping between DSA port number and PHY address
Date: Wed, 3 Jul 2024 16:57:17 +0200
Message-ID: <20240703145718.19951-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|AS5PR07MB9985:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0af5bf-fc57-43da-42b0-08dc9b70797c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|34020700016|921020|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MMkVo5QLr2b5AV7Ztwi6U8Ar6BSYE7jGEwN+RoAo8u+Kk1Lk6NIXfNqzNMBA?=
 =?us-ascii?Q?Mw1De2jz4x0kFbUIQW84Ym+fDqc+NnfS1mwYLm3C+Nc08FwEQkXEGeQtpPu9?=
 =?us-ascii?Q?uAHmXGh9HlKaMqs1XxBTdxU3dpsG48mlK+xVmpASX8lxKe+Ac/ZMvgiYogxu?=
 =?us-ascii?Q?5GR0fZ0rBKgRPOtD9KWn33E6CdfPY4ov1Sd1QeGBwUQxw+gqa8o/PRuggTKK?=
 =?us-ascii?Q?frSEzXfTyTpJOQ2CSvNXNWyPiHIbHPiSfyCLd/cqiX832RLZXFfUXhIVE1Dl?=
 =?us-ascii?Q?4dRT/r0ABlesqD+vmNB+YR3rwjV+SjvOj03yXDUP2MFTU+1yEWY013mG/cYz?=
 =?us-ascii?Q?CaxF6TFyUbDAUM7K3NGLE3DdcNiDunnA4/P5mCLC8ZTzkfY0QJT6pyvaZovw?=
 =?us-ascii?Q?gtkG1JkVQ4UrGZ1r0fzaIhDTFI2JqbIDLIyCsj8vUtJO4bxh9d3PcTCzvepr?=
 =?us-ascii?Q?qA99h0mxCfIAevLTL2qJri3n30dxyhOkzsPx8QZ5l8TBR2gvZ5Vx0aQrXa8h?=
 =?us-ascii?Q?5Yk5k7OPQ6gOzvhoZtGpa0NLUv2Yb/3JxJZXHDx7GlMAi0YUSrzTpcGUAdst?=
 =?us-ascii?Q?2XOZEfFBAq+DKYgPD2YS+vG8y1qJpKAMArUfscYn7D2eOi6TzikA3PAbJPbl?=
 =?us-ascii?Q?zBrh+kvO5aN3j5kjv6vU4dF+B7SsgJu9EGUZwkRrDgP199758c+cUgYTybIj?=
 =?us-ascii?Q?voF1EWc7UPpXy0xqoS2zMrIpZhznL5wtSissle0KPGzuPcHLxmvPxVDp8Sg7?=
 =?us-ascii?Q?3FOaAFip2SkmIffN0CWZ9BmugKBaAqEgsoemPZKlvlWbh4aM2zowsWEp+HXW?=
 =?us-ascii?Q?lTUJ5wquaFmbRQkeMzDPiZgxtUTl84GxdTJb6sqpbVuvaHjG5+wyEixIVouv?=
 =?us-ascii?Q?5LK53//M1FkaOV7bDon4W/Nrp5rVfOoBDviiDwy2BALdfpjlYSRkxwNK/Air?=
 =?us-ascii?Q?PGOm5a0UnwJC7m0huh4YE9ic86a9Te7peHUSicPWscfRy8uVHzGFyKfFVDDH?=
 =?us-ascii?Q?bQmBmlPb+DpA/GcMSvTVXDe0eWN/uvqOEFxSqY2yxwSNigqRyhum6cC2BrRt?=
 =?us-ascii?Q?miLztMSE5NKaHLTPlodegnRdAY//PC/RM518R05YQLOZv66pMeW2SfjgEtZN?=
 =?us-ascii?Q?u19g7UXrTurCKldy14CPKHrr79Ia06yYy0JywfdZBrXFYxwSCNpWoepgpzq+?=
 =?us-ascii?Q?2WZSF5V4QUEx87bG5CGad67jaR7KVW8vkWEZst4RajSrNd6SDq7FZqx4f8bA?=
 =?us-ascii?Q?0Ny36sWd3YwneQ0o85ro9d7g1WY7ErDqa4AYoW8KTq2WaaPR4MLsb5S6SdWJ?=
 =?us-ascii?Q?YbJKnjsnps3No+RGO6bcRIrSbiEoiZ+43DPaExcFOHA8rJD7U3q2/wR2pnT5?=
 =?us-ascii?Q?efdCsWqoflSQxSAyC26a3xTleE+NcxKbTgU1r8wTIS5MfucPjkVxqBroeaUW?=
 =?us-ascii?Q?v7HANqO2O53PI8+8IIgHR+W9UKjPHE2Wm+jgOk6qBRj6xbpZeYDSNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(34020700016)(921020)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:57:35.5815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0af5bf-fc57-43da-42b0-08dc9b70797c
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9985

The 'phy' parameter supplied to lan9303_phy_read/_write was sometimes a
DSA port number and sometimes a PHY address. This isn't a problem as
long as they are equal.  But if the external phy_addr_sel_strap pin is
wired to 'high', the PHY addresses change from 0-1-2 to 1-2-3 (CPU,
slave0, slave1).  In this case, lan9303_phy_read/_write must translate
between DSA port numbers and the corresponding PHY address.

Fixes: a1292595e006 ("net: dsa: add new DSA switch driver for the SMSC-LAN9303")
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 drivers/net/dsa/lan9303-core.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index 02f07b870f10..268949939636 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1047,31 +1047,31 @@ static int lan9303_get_sset_count(struct dsa_switch *ds, int port, int sset)
 	return ARRAY_SIZE(lan9303_mib);
 }
 
-static int lan9303_phy_read(struct dsa_switch *ds, int phy, int regnum)
+static int lan9303_phy_read(struct dsa_switch *ds, int port, int regnum)
 {
 	struct lan9303 *chip = ds->priv;
 	int phy_base = chip->phy_addr_base;
 
-	if (phy == phy_base)
+	if (port == 0)
 		return lan9303_virt_phy_reg_read(chip, regnum);
-	if (phy > phy_base + 2)
+	if (port > 2)
 		return -ENODEV;
 
-	return chip->ops->phy_read(chip, phy, regnum);
+	return chip->ops->phy_read(chip, phy_base + port, regnum);
 }
 
-static int lan9303_phy_write(struct dsa_switch *ds, int phy, int regnum,
+static int lan9303_phy_write(struct dsa_switch *ds, int port, int regnum,
 			     u16 val)
 {
 	struct lan9303 *chip = ds->priv;
 	int phy_base = chip->phy_addr_base;
 
-	if (phy == phy_base)
+	if (port == 0)
 		return lan9303_virt_phy_reg_write(chip, regnum, val);
-	if (phy > phy_base + 2)
+	if (port > 2)
 		return -ENODEV;
 
-	return chip->ops->phy_write(chip, phy, regnum, val);
+	return chip->ops->phy_write(chip, phy_base + port, regnum, val);
 }
 
 static int lan9303_port_enable(struct dsa_switch *ds, int port,
@@ -1099,7 +1099,7 @@ static void lan9303_port_disable(struct dsa_switch *ds, int port)
 	vlan_vid_del(dsa_port_to_conduit(dp), htons(ETH_P_8021Q), port);
 
 	lan9303_disable_processing_port(chip, port);
-	lan9303_phy_write(ds, chip->phy_addr_base + port, MII_BMCR, BMCR_PDOWN);
+	lan9303_phy_write(ds, port, MII_BMCR, BMCR_PDOWN);
 }
 
 static int lan9303_port_bridge_join(struct dsa_switch *ds, int port,
@@ -1374,8 +1374,6 @@ static const struct dsa_switch_ops lan9303_switch_ops = {
 
 static int lan9303_register_switch(struct lan9303 *chip)
 {
-	int base;
-
 	chip->ds = devm_kzalloc(chip->dev, sizeof(*chip->ds), GFP_KERNEL);
 	if (!chip->ds)
 		return -ENOMEM;
@@ -1385,8 +1383,7 @@ static int lan9303_register_switch(struct lan9303 *chip)
 	chip->ds->priv = chip;
 	chip->ds->ops = &lan9303_switch_ops;
 	chip->ds->phylink_mac_ops = &lan9303_phylink_mac_ops;
-	base = chip->phy_addr_base;
-	chip->ds->phys_mii_mask = GENMASK(LAN9303_NUM_PORTS - 1 + base, base);
+	chip->ds->phys_mii_mask = GENMASK(LAN9303_NUM_PORTS - 1, 0);
 
 	return dsa_register_switch(chip->ds);
 }
-- 
2.43.0


