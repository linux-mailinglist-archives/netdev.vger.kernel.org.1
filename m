Return-Path: <netdev+bounces-236750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DFAC3FA7A
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DED224F2426
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3FF31E110;
	Fri,  7 Nov 2025 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aX+Rfqd3"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013019.outbound.protection.outlook.com [52.101.83.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FEF31DD8A
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513724; cv=fail; b=dfco/08QZWQ+cBm3HCqRl8ZMPyYYxPhJFB85JF8Hm2S4irwfQ8N6RACgLAsPoa0fZ8EY5Yg0GZiF25Fj9MYQP7+Feg/aNVnXDC+l1jA4CubXVumhNR5AzNKY5RZagg6SMqe6MHsbv0C9fKAVa/Tl85rgdGCvAuteoSl3bs296CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513724; c=relaxed/simple;
	bh=p0Z/v/iYrl84BDllL264zvIc70+Uy1V+dlTTRt1EQHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kHXc411sd85eZY2qvieu7I38b4WQ0qwZXra8AYhccEyMsHZrgbr777ajEjGIJoOWnYHD+UXf4fMobRTgIPLloM5YcI4svBVR92VekBoeAA1A6u/oIFtkZtpp0Tw3j3xyUI6NliGGhnod0zEPxOelkwkipNicPR1yKYvIuXYi7Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aX+Rfqd3; arc=fail smtp.client-ip=52.101.83.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B83ie5UBv7yUTDJkVRpw9nC/3M1ClmHPUNxppQFiSiju0T5pTpoPCqFg3L28SlORk9Jc3jc91zdslkghsHXWdyF8512Bn5pmZw2CzvBERuzPy2s2sf4LP+p+NECvzJEEFkU8y9e8jvUnoCInD7fhVm+f/LApBwayYvCYfx8MjZDkuP+v845hYxNGpHYYJ+ujEhSqMTSQ3FitGGPYVeiJXc3brype2ieiX/BStTLiw9oTE9HOCHX7DdBFYQZ/P74HcoFAYKltLfRZ2B+t23zj/KtMfnUCImMxMXQO/xcpX3vglw/WzP2sTBzLrUWIrMBdW53TLhjR/cbsuOJQgRmtVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5yy/1RdjzGxaru1yndjCLZk6fYCCA7CnYm68ANMG/A=;
 b=Ja7DhSMZ4JxK817grtgcC9yweuY5R4Rh7dvWpEV5Tr+3ThmevYBkdrSivh/WN2hemnooBvIpzNmuCe4599liTq22ARmBlfDPEgfv2lg7vP7Iycc47cX7W6UbEJ6ObEIT510KhJUs3a2Cy1xx+g9gFg4vNzOpSszsHwUtunuDRP+04fXg+vVDtmVdurOAZh2GLvyWaIMv0lVSG46MPzFfp1CZx/0okPXzGXMgfakqrIuIj6yq7/ICkgIogAEvzk1b76N1I42fXvlTkSE9aloY3AMHeJDRQs1Xm4zvWNownxmMd8iPaSwUtSfPK2Bl+uKtNBU3qTHSIQeJGCLVUzuHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5yy/1RdjzGxaru1yndjCLZk6fYCCA7CnYm68ANMG/A=;
 b=aX+Rfqd3ux/rt7MCUHVsncdS3co2dsBXefM3VAqpEICWYRaqdjMdEy4Z8k1uVLCykPQ3pleLS5QC3yz/3vatPTQbBX0vFzYpEEGac61fazp8c6qKXWg1268QGO33KiMfp+JWa8kH8qRofG2P8kc4LGzddLMn+sbRjfHGfhwFcS7gedafrhigbdjaw7grx+Ir5a5Kk7grpOEDx1xDNopOYwtCdJRtynbKs5rf7nIYQE9ycS18xLBLshUYloDA/l0X9lU34f6zMc7GF3F1dstK4lSMXwpMot1pKr8x494XqUbVwbduphsqMl9Fgg9j4WVr8gpintKftGn3AbJOGuCWKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9505.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 11:08:36 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 11:08:36 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH v2 net-next 4/6] net: phy: realtek: allow CLKOUT to be disabled on RTL8211F(D)(I)-VD-CG
Date: Fri,  7 Nov 2025 13:08:15 +0200
Message-Id: <20251107110817.324389-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107110817.324389-1-vladimir.oltean@nxp.com>
References: <20251107110817.324389-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b95594-65dc-4d3e-5f35-08de1dedff1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|52116014|376014|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4UjVXUuLiwEyNq+pbX4rvU9iKIhr/cDTmo+2qC30RmTb938CrjCHthCYWe57?=
 =?us-ascii?Q?D9JKTWO5YQUPAVgNdgHp9as79AKbInmLcPuFEJCzz+RNHZ8UK5T6XltOOwX9?=
 =?us-ascii?Q?UQWZm8IwoV+AT6WlE+ijztc7zbK1lucE8SGLIaIIMDBMLvGxQRsRBvaPl/p+?=
 =?us-ascii?Q?fLzvpOnRp32n1O+d+A+SHqv48reueFiN9Q5H/IRT0FzPBMdhyMTKPnRJ7eDq?=
 =?us-ascii?Q?4AOV6r+441d8BXGs0VwRI2yGBuS3gdB0vSqFr6I9ca8tx8NsasSME8xxYpXa?=
 =?us-ascii?Q?+IpqZtfIsbRBwNYk5Xey2TVROb7FNWNxeOiuOZCxTpc5fWzELV//OYIsdP8C?=
 =?us-ascii?Q?z1xEoPB7NYjmt/+QeOTRcCEQPROyPbZUYy7kKhS262j8kUzIuIiQvOcTScrp?=
 =?us-ascii?Q?ZtbyTgb80oNssYxMTpiBMHAFxsatRB5OuI1pnUbb8CwG/v/7msYZ/4Tp3Kvt?=
 =?us-ascii?Q?dfAMDRe1eQNN6s6si5f6mTpP8quOzv1qHmqc7J17HFDuYWBbFyWvQA5MJkmT?=
 =?us-ascii?Q?Pq0ssw6q1ydDAkXpi9P1FkC5X1O6C1x4AMDocCUeLa8qTkEovjpEIQKBvY0x?=
 =?us-ascii?Q?crY7ZdUC7XhvZiDcEzYG/IeXXJU9MC23CEkbj10BsqsrOmhLiKGhyAxXbUfo?=
 =?us-ascii?Q?VOaMMdbRO1aZBZkFgeMvDFPRjTjhFu2daugyHmVDRHaOgknlx3yPefi4So0L?=
 =?us-ascii?Q?wKKwn9hJYQWkdf7SFq6e93MAZ9xSjDOGnupDWXgnmpNhOMLEVKNdo6nUK6gH?=
 =?us-ascii?Q?Zj1yvDz1hoer0GJiuCQNnYSGoox+KZi++iXzUIXpO7UOsjKfPDq0mFfwT8sl?=
 =?us-ascii?Q?XvOVBNV3K/uEt6klYX5NlGezI55ZNp3rmrs25Durt2ocLyzT5uTpsh2Is+bI?=
 =?us-ascii?Q?BUCdSTBlK+kfLie4gdxMRIvs7V6HIx2NY0MOMSSHkFaMbYW00a2h4xuy4Czy?=
 =?us-ascii?Q?lfnM4uQpdRZhNiLJyLzNnWtigaYJ9nSv1FdyIkqyuKYcihTNGCTCInesmoix?=
 =?us-ascii?Q?EgCCzP/IAaetZ/ImJnpbI3/L+pobhGVKgz3iXGH1RrH+HfYdAV6Jx9QAsIck?=
 =?us-ascii?Q?gaDhuxDXjUF/DJGWp2Bn1PSt3WoahWxeDrtiE17LAcjUXX5GA7xt/zB39mTM?=
 =?us-ascii?Q?ZC6O6vxQLz24gUfsNq4QtN12jf6rcBY1wEeo89rrSoxRLvpW8vX8Dep506eJ?=
 =?us-ascii?Q?+66pE+OVMvnIxH+vmCuhFMKnDLELwWPwup4K3CooVfvwFcBh7DdkAwfIz2p4?=
 =?us-ascii?Q?5LT2AdQAJnggaAsqmFfbimzPmJoR5bc0sl34j9VULWWPxg/rj/nSFgvS74xh?=
 =?us-ascii?Q?lAlIDOMwOvpC+tKvRanvEGXgQSpf4cvHvrL5gsqII6bQE0cgsF8SIIiTqmrv?=
 =?us-ascii?Q?h3STM1W9jCo6KISJAux6UnwvCik9KtRHnYHSAA7cg0sotepyfa3EWpOadMBn?=
 =?us-ascii?Q?H0MPRVMMsX9lcUykOKul7dGCVpI7SPXI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(52116014)(376014)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vtpMw8BdAMcSfgGZOaCQVEDnN/tbaa2HB/8Lht7v5Ep2kPGYcFsic3vDp0DQ?=
 =?us-ascii?Q?nCrtCikPm/4s+XVAoUVm+SShMHd1V23dNc5RQ5OfRJ3z2sgKrCOcnsg3w3TS?=
 =?us-ascii?Q?LxqqhU7tYg9fTaTXCuwFqPpfydeZuksljdA9OCV0N1zQtSzMBe+4/iJ2RGBh?=
 =?us-ascii?Q?vdVwzRAgaXVGzNLXRNjTl0mkp+ehTiVv7iRGo+C+QCvIHZrADm3doEPm4VAL?=
 =?us-ascii?Q?XHHGKB2r5eUfkM0coHIv7msdxQCPn/S1oU6s/DLBJmE94KH0HRpncu0bSkFC?=
 =?us-ascii?Q?r5OMyZkj4BSpxcR50fkuJSVXVupJSfUYeXHfOtN/pJpiBEzjd3tvtdQUsatn?=
 =?us-ascii?Q?3+j8YEo5fnlXEXm6XW7I5XPem1sT9nGMzZI4h8sRHaOkDP6fhOWdjTkGhJsC?=
 =?us-ascii?Q?JJGkge7y0OcW8SdzRtzw5WavOvPVrIJtwYMxfLY1Q+DFtuyIVGNv8rABTLNB?=
 =?us-ascii?Q?jy/FD6BPGQklzudFZE58VqRE3nmCVRxqUBNPO1N9XBQCYEOhT67fESvp7+SV?=
 =?us-ascii?Q?XlsdvPJzC91K6OTEDNdcy6ZdkuTW5Myhtjm5ysEyVKetMpJWfvWdu2UaE8tv?=
 =?us-ascii?Q?qbAGzW6bwbO/BwrDEFtjRmnSXhoRsio5lmyUirSAw7bXQnKUXZatL0ozEydv?=
 =?us-ascii?Q?hbSmW0pgGKjD1gLUyhbwOjLpsm6vEwmlkiJx/cbZrDhnR8r0p/U/E5bKSn+S?=
 =?us-ascii?Q?b0XcYJxyRz41nWwrACpZ0fhXMJzykG59ssZpd4LCU1kph0YjY6j8IuEYJUX9?=
 =?us-ascii?Q?5jj6o5Lwd0nywtJz+UyB+ZTAZykmnhB8j0tgb2mG/Nc3tvimQ6BgsMRe6yeu?=
 =?us-ascii?Q?m1zzoY8Jkyo4tG+VAJ9moHYHctiU0F9r0D8bHMMb3EEtXUpAqqg9gt4enODe?=
 =?us-ascii?Q?rI0jqQ1TFssS7jg8CJJSgnc7QU74Aof+kmOHGlJpZt0Ul1Foudl5rRByBmUY?=
 =?us-ascii?Q?IbX3lwyQUU+WgDd7i8fwN8uqjkWe/yiJ2uKCzd+Rm81eatG7TE1myC05pUB6?=
 =?us-ascii?Q?rcvOzlDbIhKd4N3ube4bLIjdltT4LE1Y0ZatR4uNAub6vqFYZeNPJWTCv5WT?=
 =?us-ascii?Q?aAyssjUv9j+6a1jbQqFhXyx4ramv+JpqHQeMc4tgp23vna6OfoMSp1tPBku0?=
 =?us-ascii?Q?AYOapt7+BwgDZu2eV1wUGv5MZX/PBsAqVwJGm1VIoraaIrKjGBQfLxtjHtw8?=
 =?us-ascii?Q?FV/jR3MKifJiYtPp6cbhnl6tezS9VtOeVKK4Mg8WtZQzDHk1xOBWUtrXl+dv?=
 =?us-ascii?Q?UBx7Jx3W2Xm37SIEfn4uX3kAB4KSCmVAMn/yh4zKlY6JoU34f3uURJ+bQ+Qz?=
 =?us-ascii?Q?OXVqq9p8KuvK8qSWXQoPohSsXbk/67EGgn53o17wkKcPpVCooILCpl07HEVo?=
 =?us-ascii?Q?h0J6MawvvR96X2FW5qLBI1KPloQRxu7yRmqzn4r9jyRsczeUYdqtAhByamkS?=
 =?us-ascii?Q?Z6Tf0LJEiX5zikfKo1f+5S5AfXIbLirHFLv8KKUIdEl1Kd7p1RmML35Z3StS?=
 =?us-ascii?Q?q9SzqZV9s2SSeQrJh2GqMXQgRR40nW9nAz3EV5sk/JwRlVChkWIHVcUOZrpf?=
 =?us-ascii?Q?zQiSpf4ZYalskQhlNrONeAAP185sVN5PgAR6kScT+iWw+37lgAeecenwiEBp?=
 =?us-ascii?Q?jy4R52L6+0mLFxL92UVNMHs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b95594-65dc-4d3e-5f35-08de1dedff1f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 11:08:36.3208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7Y8b69xuiPws0j0fX4uNRCtBl6k/na2NECExsS4LgYSg2FAivceD+aKecaF5JIABHZCjlMandcIy48GpyaN7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9505

Add CLKOUT disable support for RTL8211F(D)(I)-VD-CG. Like with other PHY
variants, this feature might be requested by customers when the clock
output is not used, in order to reduce electromagnetic interference (EMI).

In the common driver, the CLKOUT configuration is done through PHYCR2.
The RTL_8211FVD_PHYID is singled out as not having that register, and
execution in rtl8211f_config_init() returns early after commit
2c67301584f2 ("net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not
present").

But actually CLKOUT is configured through a different register for this
PHY. Instead of pretending this is PHYCR2 (which it is not), just add
some code for modifying this register inside the rtl8211f_disable_clk_out()
function, and move that outside the code portion that runs only if
PHYCR2 exists.

In practice this reorders the PHYCR2 writes to disable PHY-mode EEE and
to disable the CLKOUT for the normal RTL8211F variants, but this should
be perfectly fine.

It was not noted that RTL8211F(D)(I)-VD-CG would need a genphy_soft_reset()
call after disabling the CLKOUT.

Co-developed-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: adapt to renaming of rtl8211f_config_clk_out() function

 drivers/net/phy/realtek/realtek_main.c | 27 +++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 9413c5e52998..dc2b0fcf13b2 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -90,6 +90,14 @@
 #define RTL8211F_LEDCR_MASK			GENMASK(4, 0)
 #define RTL8211F_LEDCR_SHIFT			5
 
+/* RTL8211F(D)(I)-VD-CG CLKOUT configuration is specified via magic values
+ * to undocumented register pages. The names here do not reflect the datasheet.
+ * Unlike other PHY models, CLKOUT configuration does not go through PHYCR2.
+ */
+#define RTL8211FVD_CLKOUT_PAGE			0xd05
+#define RTL8211FVD_CLKOUT_REG			0x11
+#define RTL8211FVD_CLKOUT_EN			BIT(8)
+
 /* RTL8211F RGMII configuration */
 #define RTL8211F_RGMII_PAGE			0xd08
 
@@ -652,6 +660,11 @@ static int rtl8211f_config_clk_out(struct phy_device *phydev)
 	if (!priv->disable_clk_out)
 		return 0;
 
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
+		return phy_modify_paged(phydev, RTL8211FVD_CLKOUT_PAGE,
+					RTL8211FVD_CLKOUT_REG,
+					RTL8211FVD_CLKOUT_EN, 0);
+
 	return phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
 				RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN, 0);
 }
@@ -675,6 +688,13 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ret = rtl8211f_config_clk_out(phydev);
+	if (ret) {
+		dev_err(dev, "clkout configuration failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
 	/* RTL8211FVD has no PHYCR2 register */
 	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
 		return 0;
@@ -685,13 +705,6 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	ret = rtl8211f_config_clk_out(phydev);
-	if (ret) {
-		dev_err(dev, "clkout configuration failed: %pe\n",
-			ERR_PTR(ret));
-		return ret;
-	}
-
 	return genphy_soft_reset(phydev);
 }
 
-- 
2.34.1


