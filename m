Return-Path: <netdev+bounces-236748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B7C3FA74
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1D43B2C32
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B7A31B833;
	Fri,  7 Nov 2025 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W8r0SIey"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013019.outbound.protection.outlook.com [52.101.83.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB1831E10C
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513720; cv=fail; b=l6mXUrf/9YoxWna2fe0sY3PvnWs0VL9hTHEZHio7aLgZu+zsFBgdys9Uqlo4bx7uSZ15pAt5tPw3Lj4gJP1MLWBnlna9yUXDNpgTu2OtNUGO+BeaaLL13hK81Pm1pFhPWqICAk/foDtdWYxYC8piVeB7rTpwM7K+59DGFJOq4mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513720; c=relaxed/simple;
	bh=j4n5kvYHbCo65DG+qmJW1OSPVzXVEqn49Xe9cGxSOtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XM+5m/iLgj3Etzvsp5g3bxZWbef2NkHJ35/0xlWPVON67sCTmalxEr200Qq8y7K5fbbSeYL4eDOgdQuQIEvefYjWDr96+sPw06HGGSSqiUylIYAZX6AP3f5Ya01jGqYjWb+exsLe6LPSoEFTEZ9ffF4Lw/fJ+mvEDR8ymogn/oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W8r0SIey; arc=fail smtp.client-ip=52.101.83.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUmuvS0ixFqu4eUIp5O/h/5jU345r9UV8uOkioalFwp/6kdrYgDu5Y2fwoNXOl+R3ghCqKNS1dx1uCyrzEbhbbe+QKInJRFjHOdajxD47zkqK8cBPpa9014mSqmf6ntUYq01zGLEhLacYNHMd2wLMYNGDzKG7vS4wM7tUD+FBmjYlfEUOr6ui+ftU1BqhqiRgB9dvip4zgxUu6iom2WqXEn9E4WelVx0FF9j3EeK4P1VCVrgmHq++rzAwV+viiwT39aYu9EBnhelZiuVFKhsuQMFQ3+yICJY13ejJWKQrXRa8UuNMhePF+kpeuHQjTdSuFfQ7xIwtZ5ko/CczxXEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n99oYbHeVrIjZOTCP8q5YsZQLGOpG8hPnhuYTxGa2Es=;
 b=mfqcHG6MOwTzGc1UtpaQri6O96vm+SHCQ6jZvZSVE7dyh/KhNClrRRcNqD/P8VL7mr7G9gDavq6ZQDnJRYO7h3BZ+MIVaaKb5m8Pc/cfeB18+NzmhPC3JSN68XNTGMiV8s7smWzD/NQk9BoFOjEsx4P50z1HBy8KRhdz9RUauki6FGxvWfh1F3XJ5bjCu3yjE8x1lejNyFV+g+iVdCIhi+hsw+FcbEp17qdtwsQKCnWwLN4F4TLSO7KmPFS0lr8VXJfy09DxYGFAG3hj7VRm/oJ38LdTIoOESRvGoIJzONmRzpuD5+xqRBRYJXLSWJ8B5iPzPke0Ym+c5P2ZE4Y3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n99oYbHeVrIjZOTCP8q5YsZQLGOpG8hPnhuYTxGa2Es=;
 b=W8r0SIeycmWHfDWtb567LvnzzsjXoCDlYHJKSsNJB/MlIMKZ64nsrXZDmTh8zc3OLvd72TMySwXCdd+WOaThjs3+IDyGnYfzZkBtOSHLvlQfcg4pmWGWX9PiEo1Z3q7BpmwsWmddvgCS+dZh0Fxti4tHyoBydLO8WEqzsMX/UuLzlsy51XjG5OcZ80eSvKPjtTW6Qq40ts+vFaXvqJxuaiEV6sXeD/ze1kzkSl6NItCVyJ3bTYdz4vMJeFjWj2gz14iSjA1vE3wHYkwK7qNAME2UQKUsHMvKyV/R3nazVbJJ0w8ETq06DU3WxYuoEm3iD+JfXs5AvqOVZQRGEWdEMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9505.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 11:08:32 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 11:08:32 +0000
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
Subject: [PATCH v2 net-next 2/6] net: phy: realtek: eliminate priv->phycr2 variable
Date: Fri,  7 Nov 2025 13:08:13 +0200
Message-Id: <20251107110817.324389-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7437563b-a65c-45ab-221f-08de1dedfd2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|52116014|376014|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m4AtUNv+qgn+SGjA/Pz6zkxazSPWQ0pOIZYlq6uYZllt7OS+zZ0DfdU9BZ74?=
 =?us-ascii?Q?4rKx51kT/LrWOOrobGtKt5rJ+xPkEIv37abu/6Dz82rL9pELVbYdoea8yyx4?=
 =?us-ascii?Q?22Af7dFKzSC812k5P7itMmc+Jt2GXjRFi4fgj+CEraRfI9Qvp8xeosZBlRPE?=
 =?us-ascii?Q?kFr/rKt0oiy7DrLZj3Fv+XCKJ8Hw4VibUipi0NROCRYnxY5jBQ5aizTcgIxn?=
 =?us-ascii?Q?hHrvhrjm9W5Uskdvf3IBPwajko12KVXvTpPSiYYzxtjJRdHVt4vYo5TjBaOS?=
 =?us-ascii?Q?7+aOB07JDfNH94H+XqzGrYUD9adstqmxOsrQbzuwi3ivhQxeu4E8zT0cpqkm?=
 =?us-ascii?Q?t55gKqLJZNsQxy2guAQejds9n7uH4zw9JjdjY/5S1tUJuE4Uark59yNGSCGn?=
 =?us-ascii?Q?Z1VtH1MB8KvcLKRfBcBQRDuPIX1sYrb6fcD4YLAWO+kWXx4jrnj4UchKMlN7?=
 =?us-ascii?Q?Vi6mCt/Tz9kOBY07Hg19IFHHdJuQui/5iwuI5aBa2b0fnZNijyBSYVL8T3iX?=
 =?us-ascii?Q?DmKE7Pl4jAaXPh5pBcgAXuz6SoRp6Dh69yZo62RoFpgV13PAbYySEmTBFgA+?=
 =?us-ascii?Q?+Kgp9zf6a3g3UUqkOm3tz4KrWhgwMpZr/Zm2VZrvQsSZayov1WbG0JNUea6y?=
 =?us-ascii?Q?wqswMnxlZhobW+RmoiNv2rjS4ck3WYHby0y7134+sw8vBIrrfnDBXy5qGd6P?=
 =?us-ascii?Q?GAp98wsffS7ojt9fWi4TE8RSotYr2pNjbrcFR/O1t16DylDuiKpFZhkfu+bJ?=
 =?us-ascii?Q?v8p2Ax9GXlFOQcuETeyff2bfMpni9Xa4YDsDwk0jRNBcXJfVTYm4gK8+fzBc?=
 =?us-ascii?Q?0TaEmLI7dN9EDWjI4A7dm8wFlHSmY1OpniocoY4/ln9Uu6dd97fr24cgbocP?=
 =?us-ascii?Q?Q69HASi3iDYpzeyGU5qgiDmqsOv43J7EwFd3H8woUsMN7Zsnal/QFrasfV/c?=
 =?us-ascii?Q?fqdJV5Tjtb1Smnrj8lvc78gihUrjZUdnGf2Wdb71QLiTDX8JiFKA/dWnv5Lh?=
 =?us-ascii?Q?NAuL3nd56/zrQhP8izTWVtzDY8PX2GsK900LO/A46s5skNgbFjTDoqStzlbm?=
 =?us-ascii?Q?hSFI/eB20Kp5G4vD8+56mAfkGzPzW/Ffpc4W4Bm6ElZf36KRrZeRCJo7fjlv?=
 =?us-ascii?Q?xTrv7bz3qvkxGaKLHEBFjTL+HzqatDj6hxaPAu6Ae7FBPpSEM8NQxKwCQt01?=
 =?us-ascii?Q?YVzw+RhAXqZsHVA9JNlpbRzoxIggbvrMXNHeRZrNsFj+d3THTWBIrM0dqRnA?=
 =?us-ascii?Q?Xw9QXjTChFBiQy2X5d65XImTg1+CvwGU/YxMwH/t5C0V8n9pewog4kg+8ZKq?=
 =?us-ascii?Q?oISuvPRrQxttsnHcYGhysNxLY28/sx4pYTOmhNCRmSLNXeH0VpKmQJZemvzS?=
 =?us-ascii?Q?fqSjyTZREHJyH5gCAKE34ZvXMBsrC4AhyWjm54P71Ddq4rKVEIMsJIS+Rfz/?=
 =?us-ascii?Q?DtZHSYqW3pvf96fOV237lWoj8C4kmOzS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(52116014)(376014)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zlz8z1gcm+Do3PdRk6wRbcuuFy8thSEVk0CBXM8VasVeQguF2jKeVexy1Ds3?=
 =?us-ascii?Q?2DN+2v258F04upVkw+hkxcOatAhjxRj5q2MekjVArmmBqu5A/v5Yi61iIF6u?=
 =?us-ascii?Q?eY/YE8l+pgIvaZquk43HXvKHQJ6ol7q5flmXIFD4av2vEOfwXPJCpfVmUHM9?=
 =?us-ascii?Q?Q3tyIOsYduP4+h07u38badBWQbx6iONump4kx8rPj3a3kNmWo+fZi7WDAKwE?=
 =?us-ascii?Q?6eXbDWMiawzcM3wTmAwt3XijXTdnp2xddSjXDlPKQCpneGxgbTxtxcwzEcby?=
 =?us-ascii?Q?6/9BTJXP9dQr1Vxa8lG74PVD2WtHENFFz7D2tepLXCb52ux7yFMNJk0ZwBN8?=
 =?us-ascii?Q?uuae42aCDvzZ7vzTV8lAvByZPMlCdRrqjjTJfUHssM7rvqOKl1LYbT3pH8GL?=
 =?us-ascii?Q?zL0JY+0VTkUp67WPBSq/9R1SzbWt7DXRXyvH1zfNfgstd8nCsxe1TPhXlMSx?=
 =?us-ascii?Q?S6Ifqnp5yXOSUtYB/MUrpi3E4Otkj9vtrB1MmE56Pp65w7xQM7d0XP6SKscf?=
 =?us-ascii?Q?LTMgXJVUQx6B3jHaH1rJTaqMdjN98GO03eCNVK9uOU7ERDm+bAHHofqU+ULm?=
 =?us-ascii?Q?b2SDiIvNuW92oRRLOotsflMn2FFQULekAzIBnBoHScgrpX9UQo4YWuR6ZgAB?=
 =?us-ascii?Q?Yb5Yrv6aS5ySjXhZVRIk/HHUyttxHxNG4dAhtzjCkpre8Zwfop36y3MkXcgh?=
 =?us-ascii?Q?mwDYo3xe2IA1OA7plprn9SlXCnjbXOWDFQpja8Zd+ZlgDixYolGWMxkLmb7V?=
 =?us-ascii?Q?fSj3vrIHHx9IFHI8FGkAGTdiJN/DZoJsB6gINbfWlsarUCWE5gseJUdc/gNq?=
 =?us-ascii?Q?fKT2bZ6OMq2poD7iaU7ltDkv6zJgdPTRj8JCQZJo8KiS/giWGRaBx2NVZeIs?=
 =?us-ascii?Q?Lffq8LoaEAjtNDQc84o4prIdfj8bByH3gWNEy/Wm7VU82+8T67GkvLsmbCSW?=
 =?us-ascii?Q?voBOFTnAf+slk4lnwqFXMtSUKtnaSRVpU7qxY5WAx1FqyWrJ3Mpcoq/LZgPA?=
 =?us-ascii?Q?/mJ+2Y9K3BFWcz4bNXEBwTFYmU42juxe/ALS21qpmc4WETVS7MlsXM9RCgGw?=
 =?us-ascii?Q?LpoDf/2z1Ly/VGWOp9EEt7A5HoiT8g2M6m/RbmtiIopFxKpaR2p6bfmiET0G?=
 =?us-ascii?Q?Aex0oJszMNHpSHD2R0jZl+nNXRgxy3P62FPe1pdzHQrV/Hx1ZrTrm2UxfBpn?=
 =?us-ascii?Q?l6hwzmMAgzhAa6c1+mWrM0ngQu7ZeMkIAe3pBBjRieOBXT2a0PCaMFx5frDO?=
 =?us-ascii?Q?Pozar++kGxwsjEUOM8b8/AcrfahjkEj0p0fOsTtgcxjagPDBp7Eby9Z76KXD?=
 =?us-ascii?Q?/DQJWu7pKHUdA1QnAkzg1RcaUAgY5mIwrRqImMrjT+ntFi+NIldpUUftkdji?=
 =?us-ascii?Q?I3L+Kvj0yH9w8ocyJ4d1coQifxxz/wSXiuJ7VIqJDC9M2VGNwgrFwR3E10Fo?=
 =?us-ascii?Q?IU4vu1lrweUII8H+ntbtT4wKF9rO9W6/mCwU0SJox5NcCjwBBxmw1FX1OT6/?=
 =?us-ascii?Q?fnJrCafZS3F8/epZ6XSnXlEQz/H9PUfOyGdTVrqxeXPyQlFyRiI2j1wSgcJw?=
 =?us-ascii?Q?3gDREIkpV5wiN7b+4O2h5e85V2IWBsewNFfeu50JaX910U50HHj4C+o0ExIo?=
 =?us-ascii?Q?z4Xlu91Sj0NAMmxkwoE4cks=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7437563b-a65c-45ab-221f-08de1dedfd2a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 11:08:32.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSW+h8/bB5LaRjQ+a3pP9kv9O+vNJeASY32XHm19gvAB+TJjbiSVr4lki1iCl2TqS8QKTuRwcoqq2BuzqrX5xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9505

The RTL8211F(D)(I)-VD-CG PHY also has support for disabling the CLKOUT,
and we'd like to introduce the "realtek,clkout-disable" property for
that.

But it isn't done through the PHYCR2 register, and it becomes awkward to
have the driver pretend that it is. So just replace the machine-level
"u16 phycr2" variable with a logical "bool disable_clk_out", which
scales better to the other PHY as well.

The change is a complete functional equivalent. Before, if the device
tree property was absent, priv->phycr2 would contain the RTL8211F_CLKOUT_EN
bit as read from hardware. Now, we don't save priv->phycr2, but we just
don't call phy_modify_paged() on it. Also, we can simply call
phy_modify_paged() with the "set" argument to 0.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: rename rtl8211f_disable_clk_out() to rtl8211f_config_clk_out()

 drivers/net/phy/realtek/realtek_main.c | 31 ++++++++++++++------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 896351022682..ba58bdc3cf85 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -194,8 +194,8 @@ MODULE_LICENSE("GPL");
 
 struct rtl821x_priv {
 	u16 phycr1;
-	u16 phycr2;
 	bool has_phycr2;
+	bool disable_clk_out;
 	struct clk *clk;
 	/* rtl8211f */
 	u16 iner;
@@ -266,15 +266,8 @@ static int rtl821x_probe(struct phy_device *phydev)
 		priv->phycr1 |= RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF;
 
 	priv->has_phycr2 = !(phy_id == RTL_8211FVD_PHYID);
-	if (priv->has_phycr2) {
-		ret = phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2);
-		if (ret < 0)
-			return ret;
-
-		priv->phycr2 = ret & RTL8211F_CLKOUT_EN;
-		if (of_property_read_bool(dev->of_node, "realtek,clkout-disable"))
-			priv->phycr2 &= ~RTL8211F_CLKOUT_EN;
-	}
+	priv->disable_clk_out = of_property_read_bool(dev->of_node,
+						      "realtek,clkout-disable");
 
 	phydev->priv = priv;
 
@@ -654,6 +647,18 @@ static int rtl8211f_config_rgmii_delay(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl8211f_config_clk_out(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+
+	/* The value is preserved if the device tree property is absent */
+	if (!priv->disable_clk_out)
+		return 0;
+
+	return phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
+				RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN, 0);
+}
+
 static int rtl8211f_config_init(struct phy_device *phydev)
 {
 	struct rtl821x_priv *priv = phydev->priv;
@@ -682,10 +687,8 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
-			       RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN,
-			       priv->phycr2);
-	if (ret < 0) {
+	ret = rtl8211f_config_clk_out(phydev);
+	if (ret) {
 		dev_err(dev, "clkout configuration failed: %pe\n",
 			ERR_PTR(ret));
 		return ret;
-- 
2.34.1


