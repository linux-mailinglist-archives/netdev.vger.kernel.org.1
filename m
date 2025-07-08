Return-Path: <netdev+bounces-204888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF18CAFC68D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0241BC3B84
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2132C3247;
	Tue,  8 Jul 2025 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="barhTpaY"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0B32BF3C7;
	Tue,  8 Jul 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965326; cv=fail; b=rS8jG5Tq6CPYCgzWZigr+B/Tjl2oigvqUsrvlqC0+JZzi7qsGPVnLzXs+g2OrW18CO4vzh9Lxz/jJlPUxPGF/+s5cyemiLuKHs8UMOlCx1oYzqP85u+NrAB1I0ci4w1WjoP7cSCtNmEgTgGKM+hYSILF1w3RmZzaFsAmQjcoj3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965326; c=relaxed/simple;
	bh=DQ6oQSyHksF2t1rZC6CSzwcrQopKawf840H7CldNvaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgIKKORd3Sx/517jRpIuZKQ1Qwy4NCLeJ/6OzoNGCieMZHZ4mgtTED7DIWhQ5gvPUUrBV/NISuwrHrQ6fWwxagxhHpkICKx40byJFiEiC2asCVsHMXDUoLhYrZs13/inqAoiPLAOG1SzSDWO9ZNJIpjXIGhsXIxbZFO3WrXnTRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=barhTpaY; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUJRar4CwJUgGyYvU8dksL01UVt5R2CJtA3CxbLDbjvi1ZkFcrNSWg6qMhPn1aG2SWm+/eftmEOPsQSSu6R8KADZYrfmDlcSNvHZSxT560SPHDPOIqyhEtHSxrz9eY9qDmaMqLmoiLKk9AaNmwrZPgNKd07alG2V6ALyTBida6OKtt52rZrcPGwwbKrWDoK6dgB4N4yTB9If+nTpymKBE8IWXEbRQOKCkwHvJYIxujstUC2k/AUIM1WGf4m+ICZ8WuwtmzrpLuUD+ZBI8JUchs/vQXtkzB5Vtcaj90aefNqHIaQ+TSRQ3l4csJlZFshSFDwyYVcGY5hCUI2wtBUt0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRuiVUJ4snJva6NDHYv5B2pWBqx0EqS/y3XSl4WHp4g=;
 b=FPAXBEHFfn5oLyPmIZftiISrUjgxGiUU1ST9Dmc0i/lgEvMvPDg6a4PvNwUQNF+gnlTaWu2nK9wW9tZJCLiLOfWGrwXBrJ66MdcCdm/1bOz5aQmqbOTBqkVeaICqdIjTyiwbs8oMFVn2wQQt6j2dn6SzI0Cw/uujqK/2/yCJJ9o7eAmNm25B7CLapfkj9OuFVSr0XSPGtrPCv3ld0jqnt1vbpEOZfViDANswK2HCKO/6iKkrcke+vlGBqCmr82TE7Q7yTYiZo3pUZ21ZN2INk5uQM54TDuS+4Apnm/NbFy0Irhe8DCWfpyRi5mSvHnXs4V3MMgR+HFF2Knwno2w1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRuiVUJ4snJva6NDHYv5B2pWBqx0EqS/y3XSl4WHp4g=;
 b=barhTpaYF+BmpFZTz21DRPWYHomkxJMOe05hvTR2OOfpFOs7FPFM0KckHoN155FMajzra6BpHWHe62glHmMks7fX/yLz0Lfu5tze3PhFv8G88ECc2f162G7LM8WrvL4wXRKxicKxZyXbpFFrEeCPkDdljLN8kiiACN6O1L4Wpg8=
Received: from DUZPR01CA0352.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::15) by PAWPR02MB9808.eurprd02.prod.outlook.com
 (2603:10a6:102:2ed::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 09:02:00 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::5d) by DUZPR01CA0352.outlook.office365.com
 (2603:10a6:10:4b8::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 09:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 09:01:59 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 8 Jul
 2025 11:01:57 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH net-next v7 4/4] net: phy: bcm54811: PHY initialization
Date: Tue, 8 Jul 2025 11:01:40 +0200
Message-ID: <20250708090140.61355-5-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708090140.61355-1-kamilh@axis.com>
References: <20250708090140.61355-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|PAWPR02MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: f1158f53-3742-4f5c-ca43-08ddbdfe1906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|19092799006|7416014|376014|82310400026|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEVYNDNVeWphUFlseEQyZ2NtRWNRRU9Bd1BxMUhmak8vWXVJdDNBdDhIQlJu?=
 =?utf-8?B?bmtlU3oxOWhvR1dGZ0xVNkxWQlhmZ2NoV0h0ZE5veG4zbklWSnNvYys0ZnJh?=
 =?utf-8?B?YlNKNHQwNnc2ZjJXWEZTbXhPZ0hXakV5REVGZ0pDaWlXREhzWjYzaFN2a1Uv?=
 =?utf-8?B?T0Z0b0hUNHN5Q3g3bFVScFZLUWNRUGRsbWlIMjhGVzlieFNVNWVkQ1lxK0tm?=
 =?utf-8?B?dmdtK2t4SFUvNE5JcDRPV2tqa2IzREk1OEZtdWtkdk1VZEU0YzZ1bVM2M0pO?=
 =?utf-8?B?ZlR5V29wQVVyUG1vQzgyYmI5RVFWNGxqYkNEYm42S1ZuNUdMdFh0MUxId2lT?=
 =?utf-8?B?V0RuYWcyQnlFS2VmY3ZMT1BmWmVjcXE1VWZPTlF3b2VjbmdDYjhTWklFbCtQ?=
 =?utf-8?B?YU1Ua0I5OHVDSDEzaElJM0lzUGZqcFdiNVZXNkpzRUMrYldOOExTSWFORW1N?=
 =?utf-8?B?TjFMRHNvMVBjTzlab2hlbFVoVkt3VFdiMkpNanl5UFVWMjIyTGZLbWliOWsy?=
 =?utf-8?B?a05GVjNDZ0FFTTJ0b2FTUEdtYjMrVUsxU3Z5WmtlYkRlUzdWb2hudlRLZi9B?=
 =?utf-8?B?ODZTWEhSWnJ3SFhqRnlqWVlZcUJoVittWVhqY1g1MDU3aU11aUk0eklYRjIr?=
 =?utf-8?B?T3FVWG5MMHdUU3BQM242cU1PZDE3VVNpalRNY0MxTHBQOXdiMlpNL1BRWllV?=
 =?utf-8?B?ZkJCVXAyNFZ4cmtnN2xVQTFnVS9PK2F4bTUrSkNsSytCK1UxcFo0RUEySTRk?=
 =?utf-8?B?MEY2ZFpla3YrLzhkblFtY3hVWGRMQWlWMlUvaDJIaXlrVW51bDJRc0FORk9R?=
 =?utf-8?B?akNNVWRPQ01PL090ZEVYR1krVTlMbW1VSHJvWndzdzQ5YlRzaTZUS2tKVHJF?=
 =?utf-8?B?MEpSVFZhMTlickF6Z3NrYS95dWdyUGJsVzhESDJ4b1ZjNklyOGo2T1hzdjlB?=
 =?utf-8?B?ck5lYVdqanBLeCs4VmJVTEkyOHZuSUs3SXpLMUhGbEhERlVjdlhEbmpFeEI1?=
 =?utf-8?B?aXpVbGlUSDBOaDREcHBGM2FsQUZHNkNCRHlFWWYvdk8zVGk0dWdLTUMrV1V5?=
 =?utf-8?B?czNFVmE0UExHcU9ScklDS0xDeFlDQkhHcG42ckNMLzc2ZzJxS0pmcWdRKzJT?=
 =?utf-8?B?QVhwR3gvcURRUm5QL3kzdk5VYWhFNDlEb3cwejJjSE5wdGo5enI1Z0h4L1dw?=
 =?utf-8?B?eDY4a1BtUUdPeVlPWDZJVzhDSVRHaUoxdWRyaHRmTmxUM3N0TjZGRWJkUHRy?=
 =?utf-8?B?ZVlWUU1iaTk0NUFqRVp1b2hpb2tPZTkzM1IyT2FnSE1sQlljREhETDl3dUw1?=
 =?utf-8?B?VWV5ekhNU0pkWDdJSVBKcWdFK2dGdjN3VmF1TTJwQUVWU3dkVGc4OGx4RUZW?=
 =?utf-8?B?TENVTHh4cUw4SWgyYkNIS2RYUVpzRVZXSFNGVWQyQ2FIcjNOc2oyWGlrZTdX?=
 =?utf-8?B?S2ZGVzNCRlhvL1pQeFBGeG1pVDAzbllBWjFwK0VNczNIbnlOdnU5SDcrSUVH?=
 =?utf-8?B?U0V5d3cwNlJnV010OXd5MFlHVDl6b2thVy9BK05NelpKa0cwL0IzVWNQdmpS?=
 =?utf-8?B?YXVQQ2U2elJlK0FxQTRRWlZjSXBKVmNIQWVvNmoydU9PTnBUeFJrT0VzRFJk?=
 =?utf-8?B?anlIQkZoS3ZQeVFYVDhlRU4yQmNMTlNMR1RSdVk5aUtvOG5tcE95MTV4YkJ2?=
 =?utf-8?B?RjJmeEc0WjJYRVdzMklCbXhWeVg4dUxnc1BzMWkwRlVqTHBGczlBUTRKaU02?=
 =?utf-8?B?VlpPM2pXaGtTKzhRSjZtb3Rlc213bU9LYlJlQ01tNlFiOVlvcytUZGhkbUpO?=
 =?utf-8?B?UzIzSlltSmNGRTRydG9IeXYwUTRPVXluMXFiMGlUdzlXZFYzMFR2SHVuWGw4?=
 =?utf-8?B?N1pkcXVMRERXUndvY1F1VXVnZ1RZQkJCMHcxRGNNaG1JcVdkbUlSTTlUMjVm?=
 =?utf-8?B?U0oydHlGYjB5STFvRGNaTlFVdE84cDM3RDc4REZ1eEZOVWx6bVVZZS8xb3dn?=
 =?utf-8?B?MHFOMjlIcXZzblZIZVNjanBkZ013RFJDa20xZXo0RmM1WnpTQ1hYcDM5U0h2?=
 =?utf-8?B?b1R3R1d4ajVKSnZ5QnpmL1V3bzJMd2VGWjRwZz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(19092799006)(7416014)(376014)(82310400026)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 09:01:59.5171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1158f53-3742-4f5c-ca43-08ddbdfe1906
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9808

Reset the bit 12 in PHY's LRE Control register upon initialization.
According to the datasheet, this bit must be written to zero after
every device reset.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/broadcom.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 8547983bd72f..a60e58ef90c4 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -667,7 +667,7 @@ static int bcm5481x_read_abilities(struct phy_device *phydev)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
 	struct bcm54xx_phy_priv *priv = phydev->priv;
-	int i, val, err;
+	int i, val, err, aneg;
 
 	for (i = 0; i < ARRAY_SIZE(bcm54811_linkmodes); i++)
 		linkmode_clear_bit(bcm54811_linkmodes[i], phydev->supported);
@@ -688,9 +688,19 @@ static int bcm5481x_read_abilities(struct phy_device *phydev)
 		if (val < 0)
 			return val;
 
+		/* BCM54811 is not capable of LDS but the corresponding bit
+		 * in LRESR is set to 1 and marked "Ignore" in the datasheet.
+		 * So we must read the bcm54811 as unable to auto-negotiate
+		 * in BroadR-Reach mode.
+		 */
+		if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM54811)
+			aneg = 0;
+		else
+			aneg = val & LRESR_LDSABILITY;
+
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 				 phydev->supported,
-				 val & LRESR_LDSABILITY);
+				 aneg);
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
 				 phydev->supported,
 				 val & LRESR_100_1PAIR);
@@ -747,8 +757,15 @@ static int bcm54811_config_aneg(struct phy_device *phydev)
 
 	/* Aneg firstly. */
 	if (priv->brr_mode) {
-		/* BCM54811 is only capable of autonegotiation in IEEE mode */
-		phydev->autoneg = 0;
+		/* BCM54811 is only capable of autonegotiation in IEEE mode.
+		 * In BroadR-Reach mode, disable the Long Distance Signaling,
+		 * the BRR mode autoneg as supported in other Broadcom PHYs.
+		 * This bit is marked as "Reserved" and "Default 1, must be
+		 *  written to 0 after every device reset" in the datasheet.
+		 */
+		ret = phy_modify(phydev, MII_BCM54XX_LRECR, LRECR_LDSEN, 0);
+		if (ret < 0)
+			return ret;
 		ret = bcm_config_lre_aneg(phydev, false);
 	} else {
 		ret = genphy_config_aneg(phydev);
-- 
2.39.5


