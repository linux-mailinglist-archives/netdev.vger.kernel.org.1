Return-Path: <netdev+bounces-134086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A41997D50
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA319284859
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046271BBBD3;
	Thu, 10 Oct 2024 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mXiHYHnE"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E335C19DF95;
	Thu, 10 Oct 2024 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542084; cv=fail; b=pwQLFJtWvNlRf9NigyGqeLrMltAfsL7j4aHUtxE/y1ys+mZSg3VSmRCfNV84HpaJEq2BM80z4bN+JKwSpV+7C4b/tUALtM/TXKFlEHYn8B/uS/EDmOEY6Ac+4aFfQxhK/aT/MfZAeNZdr+624abFbW11dQkBhcbQk1QnMF8EEQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542084; c=relaxed/simple;
	bh=OmnnzJFWPKnKzbN4t6iMA8QHfnS4uBIc5LmVcHZCHYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GbpuP8INC8RZUG8AjfEB+MjCX2oteetcV6inCFHtIFd/ETgAZrv9GqB7Z5SfW0aPVcD/z0xS2LO2znFGiiAa/NpTBCDurwNbdmu3BQL6OUylmjCz1rhl3wQntjU05AW7JG+MSl5i71rc+90cJQglqipqurIe2VSXePaq5UVMIw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mXiHYHnE; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+jFS0ONc1WRBVFtSRDrdDTiz7gshV4W/fOxW1+siYtibxcAKubpaNuAbhdnldSbWt1WpOU6csSeV4xL9cVgIJs+/cQz4IeA8IRZnpu6txFU+Y7IZT2Xi38d+y4/aCRdj5/q/oxE9a0wMsHrmATN8Y6OwLa/80WtB9j222O1SLnEC4Jgrw1205I3mfuztZ6wT92ZZGUqrKKc1oLpIqCIMUwS19rfnIlHz5c64jvxvQIyIhxIlclFb1uIxh8oVhCpl2WUwP9iEUnHpD/UKXlzQsPiN+uIbu0PFCgYE/J18qS+EMZ0DZk55u/GkX0LlJlBEFf8ylHd2s0wp86Vui8oCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gazQZpnL3yw8d0QcAL4ds6NBA8uJCwuGERfmN8WNCyI=;
 b=sd8yvJ22zMR3fmw/E9xc/L0WTPQT/xRNaZX4lcyqDCtKDZFrzGmcOrLwBnKr0ijld9s5KlSASkJE8OSOh738/5m8merq3xs5Aqm0sOUoUkLJj1NZFvcryFwp3aNJxvxGI6L8o14x1x8SappM01PwH3XaN5+A79QMAUbQLAXIBVKbZMbNJjMRkvavrDRUktI8Mv57PvsTLNZ8uRvzoV/5TrFYFoo6yLrhHsRenkUo6BYAzP8TCyYootKgjDX2bL1czUfNXCOYszGqXd3SZDX96YeWtmZYB3x12loGFtI0x43m1N5Z0+thGIQi24JGjo21e8PlqUvKuNfWpP5HsXddVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gazQZpnL3yw8d0QcAL4ds6NBA8uJCwuGERfmN8WNCyI=;
 b=mXiHYHnEDkGzi6UJvvkSnSzTZGWKjVNnF3i+E50nNA/aR7tXn/dyh4isJUidiY19UsURuwaD6jwThkbAV4Ntikxrvpf9/VRFzL9jSnayNk5CtqBy8o8WWTt5yS/yAKduzR8PWiium9pa70zYjm1axVxbStw+7jTGXLHoU9ZBNzk5Q5RCAb9GYXNHzPGFFUF5ytbb0rUEFO0CxUb+t+fBqgEZh5Vxdeq9VnoB3FVP9paKvUWAwUtTBbMYVi939j1XaOmVncmjPS//83ZEk6koHiwNgX1mXBt5FYDonGXTyoBdxOV2fSRAZA+xIMOo0yQttARppFznrfKGlQ7GIlDe0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8101.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 06:34:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 06:34:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	andrei.botila@oss.nxp.com,
	linux@armlinux.org.uk,
	horms@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 2/2] net: phy: c45-tja11xx: add support for outputting RMII reference clock
Date: Thu, 10 Oct 2024 14:19:44 +0800
Message-Id: <20241010061944.266966-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010061944.266966-1-wei.fang@nxp.com>
References: <20241010061944.266966-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 974434b5-b63d-47f3-97ad-08dce8f59e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b51F7dAyeJ/jJLhL24/oucysrZVl59eZ1v4hsHe0nW/Vk3ssDNMTp9EuJ6wo?=
 =?us-ascii?Q?gO49RhgIPBWdwLcz6Qws3pn5yMskEbASJnkYXI49PSNbsDVXcPIt2ETzqzww?=
 =?us-ascii?Q?YKMPh3HGTjthYDado6EvWUsDNWnRYE7d4o8or7+wE8lO5A5edF6etCF/e1vZ?=
 =?us-ascii?Q?ff8uB9s5AoAbDLr4+SpnScb2sFWCoiThMzNVlANvbuXJ2iJlhCWL6itmq9Ov?=
 =?us-ascii?Q?QrFRlLIjbTI5yICXhEBkaXNjuPJNHolLq2vCc2Qw9/SqvfR25sYJv95JTTzq?=
 =?us-ascii?Q?dJ7toqGD7ZWSzRh9y1vo94oObnGLPW/3QTgdIBjfzSZqLqgNsjMXwPIl0bVc?=
 =?us-ascii?Q?Z8jpJ80TvDTmt0dGhk0m8VKbnAq+jZraxtEBH44TAOgMBBcN4ettOEuqsSQ+?=
 =?us-ascii?Q?vzrKWZCI2IWOWFTYEF0nETM2gB4b4I1N+kBwM8QC+4P78jMMJvETvQO6GChj?=
 =?us-ascii?Q?mb0zdIkSzgJh2fBHuuLYmVtv5Bbm+uwM4/eKPBpWMTC2oju5e47tsyqfTkwv?=
 =?us-ascii?Q?pKC+9cFd3c+ynZ5PVWmWjDkOSy+jQb/bA1T9C411J9VNMtzwYv8cbNqOl2Zh?=
 =?us-ascii?Q?79GPAxP3gvvx8+2YeNOq+WK2mW187rWBjxrykErINWXZKODBzMnOxYIzYbqQ?=
 =?us-ascii?Q?69IDBh3GGC+sVwdPz85PXyJQthx8IbQS2i/IwirmDlW2yyqCxHdR1xlIhl7Q?=
 =?us-ascii?Q?7+S3rsp3tNYah/TFjCZsNjSYfiJpAO5Vdd8Y8kJ0coyMeAgoCj5Bk4jOP0zy?=
 =?us-ascii?Q?I/3vLfHNxCtlPAhxM4TAXGq6KOZijiTnqFtCw2NsAZZlNwLEw8L5jM50eGck?=
 =?us-ascii?Q?i0uQTP0jLUsvTYIOSibEel52FHHsCzOefZXmMh7oBlweL8bdvXsKUJJ3wQHH?=
 =?us-ascii?Q?VfC7YcdllURv9+roZTdqDYr1g7cS3Yt5RII2OM6RWlAGB6aGeRKxSPyULZFi?=
 =?us-ascii?Q?tV1+usTOnXvrncrs8DpKMsLR74Uy5AeFT2aTzpJ1tuKw2hxV6UfjzEze+VBF?=
 =?us-ascii?Q?MrFkIqEVKXLWJXB0wT//W9D2QDFSWB/EwEkpRe1jQ9KmRK6E7R68VHX/Ub5V?=
 =?us-ascii?Q?sql0MbVyLBFay23N+qnD1L3HFApVDuZaV83Z74sbc7GNFEGo3w01ViNfHVcz?=
 =?us-ascii?Q?+W7A84V9/5Tlka7/YwvFlgZq+wnkHq6cgecaX+u+c9uFb3EBSNYVXXnZ3V5q?=
 =?us-ascii?Q?4oa/JGN+gmaGtP4t8s8ktgYuXx5irgfYk1OL3cFelfDCJSUrlrq1wCTN2Vbn?=
 =?us-ascii?Q?N8HXTZHIGDhFivEN6mLibgBLY7qIaX166Ov0YWli/4sHxn5wvwPEUxIQ9Ckk?=
 =?us-ascii?Q?TRXDxAsr2MH+LO3h7aPX2K47ay1YG3pvzHaNWJlcZVfySg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UdEBo8M8en8zBVP9pxwIuPycDfhEy+BPTsYPrEobbK27TDVNp05tZCTrXh4J?=
 =?us-ascii?Q?Wk3wxGSmxwyc2lHUCHpTML6OWiYZS3O2e3gIq1XRlPo4EosaoS7z8IwpLZW9?=
 =?us-ascii?Q?TBY35wsd6M2IA5nORFvz6ebtGvfI0P4rSLPlsrUDn1L/fXojCBpZylyO/375?=
 =?us-ascii?Q?HbV3//2G/CgouAw5y1mL3/pUCefuKsddawfyALotkBOlGE/qfuBPM0iQjh9D?=
 =?us-ascii?Q?INNt5+mhcFUT9T+1Rb7ki2I5nUT/Gwifzju3QO/WruLgYQzc7xMYCcbZyH8f?=
 =?us-ascii?Q?aTW7HGSOe4mmVjTDxXTs4o5X+xPA4tFiqK8V/vxNp8U5mWAeOWCvMumOJs7m?=
 =?us-ascii?Q?lanXUG3PIgVlObD/9rSGDOgGogy2hR1PuVGQBsX8W/3FE5OpzUvVoUf4q6rM?=
 =?us-ascii?Q?BkOb9uYif5ylE1jOug8kPKA6KO6J7tzPYpIUMOObAnhWhWXSOkJTSdn/vCxM?=
 =?us-ascii?Q?mFEXexMFObEGapaQSdUBQIGmMTl92E1G+jskQ6taH0/avOujLGRV8wmCX/1X?=
 =?us-ascii?Q?P5yMJKO+tPQfp5oPvYkJSZ2HgYVzNFJP+2Yy3n1AaM8Hye8aWWnU1+aZSCZz?=
 =?us-ascii?Q?kg76UKSvdLuI51EUejdMpdHNNjIbUZUP6RgZpC/2K/pZsRYS52VFoWZtbhLx?=
 =?us-ascii?Q?LHInEJG5D330PqBzekqNmc3i7wKHcwQEqlyxglxBE8kPUuRNc7M2XBYImLRZ?=
 =?us-ascii?Q?YYzzWi0rEe3ORFBFZLHS7B//Zfx6Jy+l3J8UEdPXRe7LDEI9C6xbFtMdM+12?=
 =?us-ascii?Q?d7urSkx+Dxc7utiLwrMY1+Idn2C6N/nIepetBQLTvn0a+eXZYbETN9Gu0M1e?=
 =?us-ascii?Q?gzb77iMOhXw4Q88BfU2BDIVnI2GolSFRgK0JF79PpbKy/GbEAkD+pqTzVedL?=
 =?us-ascii?Q?0S+1B6rrXsUZLDLckdsM/9XPTu9wLPr2/79hzn+IZLSdR26Eq9fox3s5/2x0?=
 =?us-ascii?Q?xVtrv7GF64QaTdhH9qaRsVLPnV5y9E4WMYqhmA13PGSA6aUnxj5P55SqzaoM?=
 =?us-ascii?Q?ER62k2Y91FP07n8G/K7wJ1v9sR2NE6k9ZmY1cKDUk3qwzhfq37qYPFPLMBiV?=
 =?us-ascii?Q?NCaM/g8rNZHm3BSr+gKOSKTJPVtxyFsscUEG3rPg3zV7nNQmakWWBj4HBcKw?=
 =?us-ascii?Q?MYoCiQmXDJN4OTYcMXet+6/psIjMo40UamMDG+K5BpIlK9PBbcPb7xi/iI5v?=
 =?us-ascii?Q?gmaOav1S/i4SgDu1aRbm5mkaDkIvnxYKZZ01OjrNZLbaBs2A7OvhHQ7iQ2Ps?=
 =?us-ascii?Q?ezhfrTN39JsCINxcKKtX8OR45XH7r85YzmZk2HZ2YTh6v5TbGLxaEGc2Y2AB?=
 =?us-ascii?Q?8gsjrDhS2nKWUMzA5A3/qmpf6OpYa6pBZplWEXC5sPI+VKDgSNS7S715TzJ7?=
 =?us-ascii?Q?2roxTUOboyz6JqdHuX7B4UZVETmsvIeXqzqAEslgHy1f3ZZpIwtBOaSK7Vrf?=
 =?us-ascii?Q?2KKH1IqwlRwCn0sEweMo19p/BYssMmtFVj5sH2PvK8C3HwvmqXmlgpIS24ji?=
 =?us-ascii?Q?UP2kXxIfA9ghodSwcS1SBcYzfWf4MlQGllUZFoWWXXtomVX8EZBdoRoO6tKS?=
 =?us-ascii?Q?uGvVJ5f7q6QkkQ2dc6qBdos/U7c229EtDFdYA+cn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974434b5-b63d-47f3-97ad-08dce8f59e07
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 06:34:39.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMxIF1JixswP3G8qz+DmxOSyvRzKPO3mnCVWFfKrXUKE+Il3KrB7IbQXeWTIgRsoGQf/EFCZk320UkQFypIchg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8101

For TJA11xx PHYs, they have the capability to output 50MHz reference
clock on REF_CLK pin in RMII mode, which is called "revRMII" mode in
the PHY data sheet.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 changes:
1. Change the property name.
2. Modify the subject and commit message.
V3 changes:
No changes.
V4 changes:
1. Change the property name based on patch 1.
V5 changes:
1. Fix a typo in the title.
2. Based on Russel's suggestion, add comment to MII_BASIC_CONFIG_REV
and the basic_config variable to make the code clearer.
---
 drivers/net/phy/nxp-c45-tja11xx.c | 30 +++++++++++++++++++++++++++++-
 drivers/net/phy/nxp-c45-tja11xx.h |  1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 5af5ade4fc64..7e328c2a29a4 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/mii.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/processor.h>
 #include <linux/property.h>
@@ -185,6 +186,8 @@
 
 #define NXP_C45_SKB_CB(skb)	((struct nxp_c45_skb_cb *)(skb)->cb)
 
+#define TJA11XX_REVERSE_MODE		BIT(0)
+
 struct nxp_c45_phy;
 
 struct nxp_c45_skb_cb {
@@ -1510,6 +1513,8 @@ static int nxp_c45_get_delays(struct phy_device *phydev)
 
 static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 {
+	struct nxp_c45_phy *priv = phydev->priv;
+	u16 basic_config;
 	int ret;
 
 	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_ABILITIES);
@@ -1561,8 +1566,15 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 			phydev_err(phydev, "rmii mode not supported\n");
 			return -EINVAL;
 		}
+
+		basic_config = MII_BASIC_CONFIG_RMII;
+
+		/* This is not PHY_INTERFACE_MODE_REVRMII */
+		if (priv->flags & TJA11XX_REVERSE_MODE)
+			basic_config |= MII_BASIC_CONFIG_REV;
+
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
-			      MII_BASIC_CONFIG_RMII);
+			      basic_config);
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
 		if (!(ret & SGMII_ABILITY)) {
@@ -1623,6 +1635,20 @@ static int nxp_c45_get_features(struct phy_device *phydev)
 	return genphy_c45_pma_read_abilities(phydev);
 }
 
+static int nxp_c45_parse_dt(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct nxp_c45_phy *priv = phydev->priv;
+
+	if (!IS_ENABLED(CONFIG_OF_MDIO))
+		return 0;
+
+	if (of_property_read_bool(node, "nxp,rmii-refclk-out"))
+		priv->flags |= TJA11XX_REVERSE_MODE;
+
+	return 0;
+}
+
 static int nxp_c45_probe(struct phy_device *phydev)
 {
 	struct nxp_c45_phy *priv;
@@ -1642,6 +1668,8 @@ static int nxp_c45_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
+	nxp_c45_parse_dt(phydev);
+
 	mutex_init(&priv->ptp_lock);
 
 	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
diff --git a/drivers/net/phy/nxp-c45-tja11xx.h b/drivers/net/phy/nxp-c45-tja11xx.h
index f364fca68f0b..8b5fc383752b 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.h
+++ b/drivers/net/phy/nxp-c45-tja11xx.h
@@ -28,6 +28,7 @@ struct nxp_c45_phy {
 	int extts_index;
 	bool extts;
 	struct nxp_c45_macsec *macsec;
+	u32 flags;
 };
 
 #if IS_ENABLED(CONFIG_MACSEC)
-- 
2.34.1


