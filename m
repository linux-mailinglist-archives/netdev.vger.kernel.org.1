Return-Path: <netdev+bounces-225647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 633AFB96531
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D801890D69
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A046E221F20;
	Tue, 23 Sep 2025 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="oUnMIKMb"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C88E1F582F
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638133; cv=fail; b=EA0PzVR4WkJ7cdf000k7i2J8sE0MNWOp9Kt5j3w5X+fkurj+fdJxaEBPrqzI1o8Yv2NsJUUOvqnk+rny2l8Raw7HnA4q4fnXKsJobHAVCRVMSFhUgs0TYGdR1fpmqqFHdxfa15T1psWyA5XYgaH+EvTQh+OV7XRGptJHhAO0B3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638133; c=relaxed/simple;
	bh=yMsVgxlQGjny1qLG2nj/KO0ltBCPlu++0Y+dXXiXvzs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e5wC1w/YhbWweGEE0MKOJT3ALTAOlC/HFRQilpjtid+j21YE8h9ocwjjQheqEPvo9myBShmWGNMlVeNcPUq+aga3mndo60/2/x2HPJNivxZ5HigLPGKK3qEhGcs42nW0sJJGWMVR4kUE5nf2YT0PwPE6O5mxEj0eCt1HG856B80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=oUnMIKMb; arc=fail smtp.client-ip=52.101.84.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbzOwwVS/49+QkT7c3n57nppCBoYzdnvKo9iXSgLDJJoxi9nj4JIqXYHOdQSy8keQOTgZnPkznj2yrmgtyZS4ixjG77xlyI45sPx+RdDdJtsFgLewKN3otxak4vej/7k3ZqH1aK//jZqYp0KfQ9A+0qgjGWh9avSXSAvnjxtmJMgn4d810Y2YRWDDcOCUUdGyDYWCq5zhvOF2/N6Dgx0zZKm3W6o58P40erc7YKmK71xVXV65HCWCpNl+8hIbGSI5huTyKKcOABQbfEVLpLVs5XFvtwvxj0s/STNSYqcwdVfv9wPY4FSVT9G2M5lSgq1UHx7D6R1hqeyV0PNzKkJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7w6/B0mLS8xvNf06AfJQCA7piW3Kq4Zx+eUGuqgm7E=;
 b=DZfwMMHVNlVsIwQcQ0OwCwKUxkhd/qr+UhbOq2ybLRzg5BFF1O9pOR7d70gRQ6A5zuwEa5Ty6r8ZBs52J0dzNAut21GxFSr5TRrGOvJCklWfpZhiJ4QtJ7YKa5kLCIFOYGfmMGXT62bkBHLluEiIVk5FV4FZX1jnz+Zi34jFOEcwgRNQMDTPXNPKWSv1+sITL7SdrYGORbUb+4boC6XHjo0Bp3BPOSam6lisBB4yHR26LsTUmal+ePLybNDMHk+WNGCiHzIp1f7mmQgLEPH/we1q80LCucMdUWQk82sZC8BPpmbJWod56IHXdWB4mJQUWdf9vGnPu7wjVf9eEumNPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7w6/B0mLS8xvNf06AfJQCA7piW3Kq4Zx+eUGuqgm7E=;
 b=oUnMIKMbFUG9OGFkfcC56+X1CX//iNyxCyiGzUbMLQA0llTrXAuDmlLfRoNRNiQv/BJqAIyy5q4StXAPa4pw2qQauzGyO6o7+YMd9yQz47ap8AcKI64264V9cjsnFelEF3mbDqnrNOJBzgYsCb1v9GAmb2fyehYpScF/+sZtB+M=
Received: from AM0PR02CA0034.eurprd02.prod.outlook.com (2603:10a6:208:3e::47)
 by PA4PR02MB6559.eurprd02.prod.outlook.com (2603:10a6:102:f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 14:35:28 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:208:3e:cafe::99) by AM0PR02CA0034.outlook.office365.com
 (2603:10a6:208:3e::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Tue,
 23 Sep 2025 14:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 14:35:27 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 23 Sep
 2025 16:35:27 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>
Subject: [PATCH] net: phy: bcm5481x: Fix GMII/MII/MII-Lite selection
Date: Tue, 23 Sep 2025 16:34:53 +0200
Message-ID: <20250923143453.1169098-1-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|PA4PR02MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d846d42-e63c-42d3-3657-08ddfaae70bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|19092799006|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K21NSkVjaEplN2UxRU9aTjJlTFNhbUMvWXJQd0pqVmZ3T1B4V3BzWkVaRC9H?=
 =?utf-8?B?eW0rdHNLM09ZOHFtQ1RrNHVwdjNodWZMYkJDdXF1d0Fxb0xMQmFoVGxERk94?=
 =?utf-8?B?TmxtSDZUdmdId0VSYkxwQ0VEcjdubmxxWmlLRGtzOVNsZ1NkS2ZwdWlCQkpB?=
 =?utf-8?B?c29Kbll1SFV0MlJaT1dSVkU4TUdEVzhCVktBdWtGYUdPU2xIN3ZmbDlFaDVs?=
 =?utf-8?B?bnc4RmtyQ2QrbG8zRGFqdm9oZUovSm5xejdYTkhuVDc2ZEdxTzN6ZG5zWjVO?=
 =?utf-8?B?MjBMSnc1V3lZWmJJVy9OMVZhT2grUFlCWnZRMUVwK3hpemNmU3NTSERiM25B?=
 =?utf-8?B?ZHoxblduQzZiSlpCQ1B2Wk1QYStHamNjMjRNaWlZT3lqV1NrUm4rUmViRisz?=
 =?utf-8?B?Z011Zkx5b2d6ZFh5QUJjK0MwN3JKcXZjdk5XVzhkOXQ0VVlyelkyMEhxTjNK?=
 =?utf-8?B?NWI5RE94UjMwTlNJQm9iQ2RxdFpTM1NMS0VibURGU2w1eEM0WFQvZ1IzUWNO?=
 =?utf-8?B?VjFUbzVGNWE4SWNvaTVoV2JYUzF1LzYxQm0rZXZLaWhPb09Uc0VHaytseGI0?=
 =?utf-8?B?OUg1M2FOOWZXL2JSUXdOUDNXQ3JINmNoVmU5QkNiWWo0TXdOT2FHNVVTZUFj?=
 =?utf-8?B?M3BtYW05ZVNIYlNaVWF2bEo3Y3llWDB5OFNaTVpvUnd4clB2KzBBSEt4MWwv?=
 =?utf-8?B?K1JOU0hxQVZyS1pYT25pbGlFZEpHZm1YclZNOWZDQTNQUTNLR2NsNUp6M1VO?=
 =?utf-8?B?M1ZCdzlBQjdEV09QZmNnVHNQT3FsNDZzZUc3R3RuSm40b2lXVnRiR1hqbUcz?=
 =?utf-8?B?ZFU0RkQ3d2ZoTUhCYjVmejBpK3hRVlVyRmYyRThDWkFOeEhnRjl3aVBlN2Rn?=
 =?utf-8?B?UVFpZXBpaWFadXNxTVREb2o0RVhSWHN6SkZsbWRnbXIwakE5SFh4T3ZWSEVw?=
 =?utf-8?B?cmlJcFhmQ3pvdkVOeS9taEFDbGZJTXJNN2JhQlNXT0JSb2ZiUGk2QVM0endT?=
 =?utf-8?B?Ryt4N2RoRm5jbFpjSGxCekl0Ry9aT0gzVWlsT1JwSU5senlJSTRKdlZuVkdG?=
 =?utf-8?B?L2JxQ2xQR25NTDJCS2VBdUExVHErVXo2bVVUTE1zcG5qS2pwM2s0YlRVN0t1?=
 =?utf-8?B?ckFqMDBzRGwyZ3FpOWhBTnMxWVRkWk9aZ2xiMVh3RGxKbEhBYm13OWtaWldH?=
 =?utf-8?B?VHZadTZpRlNCc3ZPd245WUZxandnRVFERU9lVUdOTU9ZQndodndFbUNFMGp6?=
 =?utf-8?B?aWFld0sybDRsWGVrdkZiRUtnWFZHMVFKemYwMDVIb3ZuR0FuQlRHbmdock5y?=
 =?utf-8?B?Qy91bG9ZWDF2bUsyWWpKL0dSb2NrRitBNGNuODAxb3lwa3F1M0w1SUI4czdR?=
 =?utf-8?B?cTVLKzJVdjB4czRRQSs4aHpvcHdEd0lnbTIwbEQvVG4vbDg2WkhlWHFHd3dY?=
 =?utf-8?B?WU1ZS1hJdzZuT1FoU2d3Vi9aWW5USUl5Mnhib2NzQWpLQnpEYzhmcDlEQ1BY?=
 =?utf-8?B?TWNQajdxNWRwZTBSaG9JZlN5ZWM0eXVxc00ra1pKZStYNkZjdHZKZmpJVERW?=
 =?utf-8?B?cVBOQkpZNHR6RUk3RFg4MVNLZDllRnJiTThjbFJGOFl4VW04NVRITjNzd1BJ?=
 =?utf-8?B?aGVPVTFwL2ZtT3BGb2pHWGMyTUc4VnVNVzdTR1V6VHJlNDVtUVdVbDhlaVlU?=
 =?utf-8?B?NjdaREIrMnA1eHlRNnh0ZndQcG5sd2dVb3JJOUd4Y05SVnlUTDhUdnVGMlNC?=
 =?utf-8?B?cWpkOUtieFNKWTRXM3BtV0Jub1JXUER0REZzVks5ekFENG5uN2YzTE5jbUsv?=
 =?utf-8?B?c0sxMUc2OXRGZXdWd0pGZTlrb2gxSkhCbnRiSmd2czZyTGZiSXdwaVI3Q3pt?=
 =?utf-8?B?UmxQR3pTUmpQSGtUbWpQS25tZE1KNk8ra2orbDBHVGJqR2k2WUYzMGlxcnN4?=
 =?utf-8?B?R29qT3JEQURaS3U4NjAvVmxIU0xESmhzbDZERVV2bWh3OU1OazhNcVFROFg2?=
 =?utf-8?B?dGphOUJUanlGcm84aEIzdnMxMVBnNXg1RExSQ1JXVnFPczFJaktiNGd0cWNX?=
 =?utf-8?Q?q/s9EU?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(19092799006)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 14:35:27.8644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d846d42-e63c-42d3-3657-08ddfaae70bb
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6559

The Broadcom bcm54811 is hardware-strapped to select among RGMII and
MII/MII-Lite modes. However, the corresponding bit, RGMII Enable in
Miscellaneous Control Register must be also set to select desired RGMII
or MII(-lite)/GMII mode.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/broadcom.c | 10 ++++++++++
 include/linux/brcmphy.h    |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index a60e58ef90c4..492fbf506d49 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -436,6 +436,16 @@ static int bcm54811_config_init(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
+	if (!phy_interface_is_rgmii(phydev)) {
+		/* Misc Control: GMII/MII/MII-Lite Mode (not RGMII) */
+		err = bcm54xx_auxctl_write(phydev, MII_BCM54XX_AUXCTL_SHDWSEL_MISC,
+					   MII_BCM54XX_AUXCTL_MISC_WREN |
+					   MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN |
+					   MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD);
+		if (err < 0)
+			return err;
+	}
+
 	return bcm5481x_set_brrmode(phydev, priv->brr_mode);
 }
 
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 15c35655f482..115a964f3006 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -137,6 +137,7 @@
 
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC			0x07
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_WIRESPEED_EN	0x0010
+#define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD		0x0060
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_EN	0x0080
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN	0x0100
 #define MII_BCM54XX_AUXCTL_MISC_FORCE_AMDIX		0x0200
-- 
2.39.5


