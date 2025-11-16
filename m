Return-Path: <netdev+bounces-238909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A13C60ED3
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 02:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271FC3B35C0
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 01:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9222256F;
	Sun, 16 Nov 2025 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IWTQg/6O"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F205C21CC44;
	Sun, 16 Nov 2025 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763258344; cv=fail; b=R4nTyAv0tB+EQ2W96QkGSpoHWBu9NkX6fPVBfgluIS1aL92bFOP6j5iK+XLI+mozDveC+3bDLhNlflbqPVXFmf9MnHspt93JRjyTtEyeD47ZQjaAjgp5ZcCMONR4VXHWSjPC4Gu/1LoKuLEIUMWvLIfo324cyVSvQnZv1sgjYkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763258344; c=relaxed/simple;
	bh=uKRzvXDIRe+SRe/UqIH7n4kt3KirJ8gW6ivGxJ9DM44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DbY21cI93oq/j5jHjkp/lts3G9YitE9GZHJkgfDvzGvEBSn+9CJF2YnQOVT6Y+cGru3AMP11IkD4qBuz6zizQBBq/f8NrLVCnrl7DGopNCMPk9UBxXQJOhhytqfvR5EKCE1v/Qy3sd81ZGhrywiSctb8yoBxuTbNsu2L78z2bYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IWTQg/6O; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WonAeIoKnzjfousPsTsChEngi313UXi34qWN9M0/7M4kWZ3PBFwjsDU67MjuI+zOY6fPf1J2EDAuEkNH5Alq2zZP077ysli7FAQc/61hB1aEfCsngRjdkCmVC1jgNr9zamrrPld400h5GIs4t8JAODL3amdU/s9TkuCxFJOM1AfCQaQ5bTSzuyz+1QKqJyWtKOIQI0+qjT+CSzg4CB+oLdpvC2C4hgBdpVImDXVfD2loWv8IgC+uKyX3z0B2ouXi/xfeWc3Mk3lLiqnG/gKYToGsukQ9UKylMa6OGWDp3Lae2yu9hcRFP5bnM7K888SykSAxee8zdDkSnhLR02VkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3DooT3rETQYdJUgptyRHxtXI7xTqcHXtdL1VxTgneg=;
 b=OOjWU6UxY2mwU8KM2+8LJI0afjyOmH/AEPYU70cXbYRfnE5BfTz0WkM0UMy2S1rDMA6/EGAAtQVl0yb6uy1TKuGCyXpZMQWTN8lm5cvm4hHeecoWhBlQTu14SNNUZd1dN/S613AFiIlaPmtIv4+0lsO/BB3tNVK1bAefTQyB/ktJRNQ91s2afr1+w+7q8jvcwCymSwBhUiXEslWtCw1OuVBf0hlsmrL6BTJY0aoa5vDjV3rIFaHmOUiGa17kNL1WSmZulJUZgG/Y1eBfGU/DlkZHs+iz4JulmU/kKFK+ySuTTojyT/8nlfvNU6tsW11F8jHSy7nKIy/g0rlLfpRnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3DooT3rETQYdJUgptyRHxtXI7xTqcHXtdL1VxTgneg=;
 b=IWTQg/6OhzceevJHOVVihe8TsOUM5El+qyPXfchegLHAY3MuFquYq40E/EaIu8SSKvqcU9JnEDxmKcJrLUmu6pD7nWryqDK9jIVBVL4mHLlVU8HAXDir9g7rdBVUMe3N1859SoRwZv8zxMkSos4sUNYdHNxFtvx6D+LvOliadmo23eTF01scQu2XYO9oxUlFfsrvihKlGlBmIp6BxVMQXPPOz2uaX2gwzfSHqLZkxFvBEk1H0NJmLduDjEoGt7XvpRx8Q315Mks1Lc8KMCNDsO0Fce1Ay7ArK83AvvRmm9If+ZhTLERrv4Y7RM1Gg3kVBl1rq1XEGeysHceH8OGiaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8469.eurprd04.prod.outlook.com (2603:10a6:20b:414::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Sun, 16 Nov
 2025 01:59:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.018; Sun, 16 Nov 2025
 01:59:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	richardcochran@gmail.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx94: add basic NETC related nodes
Date: Sun, 16 Nov 2025 09:35:57 +0800
Message-Id: <20251116013558.855256-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251116013558.855256-1-wei.fang@nxp.com>
References: <20251116013558.855256-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 27502e99-5c69-42e9-2057-08de24b3b5dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q1I2MoZ4yg1/hGQ6f+MDHBCfDQ4JdGOcvXItFNCEmrImA5X3VC0aGpvCG6Eu?=
 =?us-ascii?Q?lw9ER4t8XWHAWJazywWFQdkYSA1dOXlkAQefIP/hW+Wn5/lfQYctgVMhhuhW?=
 =?us-ascii?Q?lzXs6OlL7OfauTLJmigHmc+V1EHczrk7GzgsejpLOPL+DQFcv+XFVk4WCian?=
 =?us-ascii?Q?ZOh3W2loBLMGb1rWNQFJhM4HdG7Jaj6SGSBhE4+egHuLiXYI2dC1f0cXuyXq?=
 =?us-ascii?Q?VMK/xzfjoh+hF56XQbcZ5vnu/RXUdAzKw222JG+k2fIbtNXgOIoQTlUHW44Z?=
 =?us-ascii?Q?N5XZqZdggCXaPmFUk9Sv/1NHBqk2CjsRRqp1DUrCAvrDjLAGknJ/EC2sZkQs?=
 =?us-ascii?Q?trQPCjsm7wTlB0U1PqW1TNjR1G1oGdVSf3z5tuYmDZMjDePz2bLp6lkHLUCi?=
 =?us-ascii?Q?L6URPNrffC8wMPXjt5aV69qcZU49SzeRLvXhS2K+G9bYs2Tviooq8+wDWDQz?=
 =?us-ascii?Q?+Ak95Yb84tnJjhtDfwRYh/k/iNxLQhHO8gpofIoyycf854jHtZY6QUbPrGfV?=
 =?us-ascii?Q?hcHh6y6bTMZbFecYVNWrNhtGnCcTBUX/+Z/RUZr/UlMu6KY6+EyrKI09/wpn?=
 =?us-ascii?Q?DBMr1lAXRonatSxGulJZhESCdIl0xj8b0nY+zF8lesHWGUiBL+6hJWqIdpzr?=
 =?us-ascii?Q?oiGL1y5onKj84f6f2WPLk6OyyT2EpyQUoPXsD21Ypc3RhjjPWHkgBpCgTvUw?=
 =?us-ascii?Q?Y6D9kZ2vd3I4soRzOXnaYgfx1AV1RxY9DXb2axK7UZ4uJ2A6CFU4VhHFnY6N?=
 =?us-ascii?Q?khWjrcIlpC8fS2Dx5gPMPkQ+2WzwuMeG2LPeL9/5eRDLLmlf5aajRQVZeD8Q?=
 =?us-ascii?Q?UrPueKVAoA/JUzh02lLkjM2Z6jFFqAqJuZ2zIk5PjQ8slseyS06cVz/uZsvo?=
 =?us-ascii?Q?0Osb+3EoTRnO9clob9eL4Avr4YRzCg3rmDPjcc/yjRksy8YCpaRvHe9XFJUN?=
 =?us-ascii?Q?TBoVctXYu/zfOqw0PwX8xatKk9gBZ6jSGKtkm+brYXON/NpvT+bm6yccZYqg?=
 =?us-ascii?Q?AAS41JylXC++bIpffkQobsBZuMNqn6E4qBl8JmrtQdzCH0XENQZGIp7/rew5?=
 =?us-ascii?Q?teyVR78TqeB0+2ESvHNugl6k00XbeqbATlkLvDCnfCNt4PVoR89hFkcgmey8?=
 =?us-ascii?Q?ZHfjsrUy/UOwSrv2v6Hv3DCxBO8qSEitDT0AhpM06iMsSBz8gA5ksljPpx+2?=
 =?us-ascii?Q?4gY3S005FvAn8Hy3QrlbCckPc6XLGGJH/5qJcLlU90Tnt9Isl/106yYuHkuX?=
 =?us-ascii?Q?+HJvJyhDWsNWNIPBTLhshWw04NiA0RSCbx7m0QG8U2nZb0o0B1ZQkfrvIC3d?=
 =?us-ascii?Q?+tPCyBleymfdZEQJbuXIBk+Hc0hbBSHiSGIcvQo6xUuL4/RAlGh3TUSVbZP0?=
 =?us-ascii?Q?79Z0ZudIjoovKjer+NkNljXYbdr6m1JTq5rASBVbJst53nbael0V5YWK8h4Z?=
 =?us-ascii?Q?Nx4l9qaBrwF85lUVyOU8k4G/MA8IxJvEijGkhZ74mzCauu6bmQuzDaGNVpIg?=
 =?us-ascii?Q?OJRe7KF0Ounp8I8SLLn2q7EilBqGnosyTf2Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4EZXaVBkkuFXV0IRG7NL3qaYWWwLwQK8rWCM6Gxot52jqCqBULroPSV3AMtt?=
 =?us-ascii?Q?h+ELai+GbRJz3av7xpLHuKmZ9CoUHeZ4DJsQszVl8emjhNTQqOHYMxS1goNn?=
 =?us-ascii?Q?fm4YcQYtOqwQzl+yxnYOPMWe9D7HTiYc8WeWuQ54zqJXWOLe/0+Qy7PQX+8F?=
 =?us-ascii?Q?opuWDyfK1V0PFUfaGKUxERLG01KHuFcUn9b1u7/F14rXqB6ompQZWC0CD4DV?=
 =?us-ascii?Q?TReIoxrBhEuIH01SQamyDMs/9zPm6A+ackCjBW6pfw8OXLLbEAn8jqoRJ7cc?=
 =?us-ascii?Q?YKsapIF2P2pPIMRCg8YDgnZaaMam84aV0jqOOslERY3mZx0j4CT9cm20L7XM?=
 =?us-ascii?Q?Qo9syLF4DFQi6s0+a7QXtXuD4i8OjaPAZA+sMTGerwYSPmViGr57S73t2FN2?=
 =?us-ascii?Q?RWEARX3NHrMv5IkV2co/AgEqvyB/DXpTh4AfZdWveDI7UqfATgJ7mDyxvuKi?=
 =?us-ascii?Q?YykssLuw5dPCH1HOAGzAvjMdlgYanjVOWgFWWgQ/tJKXjgZOJrAKJGmqQ7/c?=
 =?us-ascii?Q?VpDia68jj7Pe41pKYv4s98oAw61TbiTVaHIidWSza4GLmp4aMIbrFSLmvv/z?=
 =?us-ascii?Q?9uuyVm/cTfjYlh3yfxI9q2MljaNhBJzW8vR/sAAcD4JyUsO8aRDmg1rH5MBu?=
 =?us-ascii?Q?M8qY27X8iPv6n/EN0sQ40Z3+61YKbjso6TLLTzC48QWiPMq6zk9olJ8IUDnD?=
 =?us-ascii?Q?hWT18g0n31YG32fAQzy9hQwOGHq9wzJ3qJv+IiPG3aczsTRNCJ8LL3aeMduM?=
 =?us-ascii?Q?+tMAcFaTUkaCmzyz/OCIWNuC+Qlx7D3kjl8g2rdP0nELAYuZsoRT55eL/bsZ?=
 =?us-ascii?Q?ifgNPTT3fDqMPQz936xFbvKnS03GL13NWtkvudWKyu0q4CUKdC5ZeLaXJYKb?=
 =?us-ascii?Q?LVaMuLLmljUz5nt9wFryD5sgAFaXmHoJ24dPUkkPxSC/ZN24QFyJbu/yx6Gs?=
 =?us-ascii?Q?9I5ybO2sWB0NwVGE7bDBCHIOtFUy+k5B4U7hwGzBF9XhNkXfiidObEYjCdQV?=
 =?us-ascii?Q?oEAY4y+LeOEeR5RsNSE6EmcTSPKn+wrpmcturGiyUfqIIMiFJycsgEmcOi5u?=
 =?us-ascii?Q?jQUoRCiT1MDcM2yhpYWbGFf0591cjPvmEeOP5zaYtYPMU4ELv2Ofcko+i4Dr?=
 =?us-ascii?Q?Iey3VByIUr85bZzBsoxNRbCzodU3LAtUG+LPWMRhJVTL2Pqa3y4A83XDAn1Y?=
 =?us-ascii?Q?gEUPAXLzMyCh+7s9qT6vOV6uv5xXsW6iC07Sy/5i7I/6r0/shEyVaQ7QMOna?=
 =?us-ascii?Q?XHfignnEZV3RBa+kxNHUkLp/ESkED0LPgzDKX5o+nL4LXqcJmfwUO9deQ7Hz?=
 =?us-ascii?Q?fa8+KICQa9HDSxmvwrNPvI0bP8BWn36dkO4B8cCd1Q3z5Bv7PErATfaKK5Pi?=
 =?us-ascii?Q?ZEDZJiSxI/kKGWQORxPUXGdiw1jSsCyL2RmNwweLmMrepcDFL4CWFm6UM7QG?=
 =?us-ascii?Q?wF6e6VgkfKUYzBD4C3HCJ3nc1LkPri5TPVEl4YvUj6zEp8eyJfjni0rg6q5k?=
 =?us-ascii?Q?8oKxlxulNZMeppR60U/qbh/fKOeYUOYtbWHSx2OHdFrUzXj/+TOQzFM43NPc?=
 =?us-ascii?Q?UXyMQFrQGPrKDcsg0iijdgT0YaiyLkVqXWHIYFTl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27502e99-5c69-42e9-2057-08de24b3b5dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 01:59:00.7311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8oQj/r06J/sH8+GZqaubloTpV7LghwG1Sdp9jFGz13jvMV/crhDY3YFLWPo5T9qynarVzuzD6O9sgUa+gXbUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8469

The NETC related nodes for i.MX94, this NETC has two PCIe buses, the bus
0 has 1 ENETC instance, one PTP timer, one RCEC and a switch, currently,
the switch is not added due to the DT binding and the driver is not
ready at the moment. The bus 1 has three ENETC instances, 2 PTP timers,
1 RCEC and one EMDIO.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi | 138 +++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index 73184f03f8a3..4fdec712307f 100644
--- a/arch/arm64/boot/dts/freescale/imx94.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
@@ -1191,6 +1191,144 @@ wdog3: watchdog@49220000 {
 			};
 		};
 
+		netc_blk_ctrl: system-controller@4ceb0000 {
+			compatible = "nxp,imx94-netc-blk-ctrl";
+			reg = <0x0 0x4ceb0000 0x0 0x10000>,
+			      <0x0 0x4cec0000 0x0 0x10000>,
+			      <0x0 0x4c810000 0x0 0x7C>;
+			reg-names = "ierb", "prb", "netcmix";
+			ranges;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			clocks = <&scmi_clk IMX94_CLK_ENET>;
+			clock-names = "ipg";
+			power-domains = <&scmi_devpd IMX94_PD_NETC>;
+			status = "disabled";
+
+			netc_bus0: pcie@4ca00000 {
+				compatible = "pci-host-ecam-generic";
+				reg = <0x0 0x4ca00000 0x0 0x100000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				linux,pci-domain = <0>;
+				bus-range = <0x0 0x0>;
+				msi-map = <0x00 &its 0x68 0x1>, //ENETC3 PF
+					  <0x01 &its 0x61 0x1>, //Timer0
+					  <0x02 &its 0x64 0x1>, //Switch
+					  <0x40 &its 0x69 0x1>, //ENETC3 VF0
+					  <0x80 &its 0x6a 0x1>, //ENETC3 VF1
+					  <0xC0 &its 0x6b 0x1>; //ENETC3 VF2
+					 /* Switch BAR0 - non-prefetchable memory */
+				ranges = <0x02000000 0x0 0x4cc00000  0x0 0x4cc00000  0x0 0x80000
+					 /* ENETC 3 and Timer 0 BAR0 - non-prefetchable memory */
+					 0x02000000 0x0 0x4cd40000  0x0 0x4cd40000  0x0 0x60000
+					 /* Switch and Timer 0 BAR2 - prefetchable memory */
+					 0x42000000 0x0 0x4ce00000  0x0 0x4ce00000  0x0 0x20000
+					 /* ENETC 3 VF0-2 BAR0 - non-prefetchable memory */
+					 0x02000000 0x0 0x4ce50000  0x0 0x4ce50000  0x0 0x30000
+					 /* ENETC 3 VF0-2 BAR2 - prefetchable memory */
+					 0x42000000 0x0 0x4ce80000  0x0 0x4ce80000  0x0 0x30000>;
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0000 0 0 1 &gic 0 0
+						 GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+
+				enetc3: ethernet@0,0 {
+					compatible = "pci1131,e110";
+					reg = <0x0 0 0 0 0>;
+					phy-mode = "internal";
+					status = "disabled";
+
+					fixed-link {
+						speed = <2500>;
+						full-duplex;
+						pause;
+					};
+				};
+
+				netc_timer0: ptp-timer@0,1 {
+					compatible = "pci1131,ee02";
+					reg = <0x100 0 0 0 0>;
+					status = "disabled";
+				};
+
+				rcec@1,0 {
+					reg = <0x800 0 0 0 0>;
+					interrupts = <1>;
+				};
+			};
+
+			netc_bus1: pcie@4cb00000 {
+				compatible = "pci-host-ecam-generic";
+				reg = <0x0 0x4cb00000 0x0 0x100000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				linux,pci-domain = <1>;
+				bus-range = <0x1 0x1>;
+				msi-map = <0x100 &its 0x65 0x1>, //ENETC0 PF
+					  <0x101 &its 0x62 0x1>, //Timer1
+					  <0x140 &its 0x66 0x1>, //ENETC1 PF
+					  <0x180 &its 0x67 0x1>, //ENETC2 PF
+					  <0x181 &its 0x63 0x1>, //Timer2
+					  <0x1C0 &its 0x60 0x1>; //EMDIO
+					 /* ENETC 0-2 BAR0 - non-prefetchable memory */
+				ranges = <0x02000000 0x0 0x4cC80000  0x0 0x4cc80000  0x0 0xc0000
+					 /* Timer 1-2 and EMDIO BAR0 - non-prefetchable memory */
+					 0x02000000 0x0 0x4cda0000  0x0 0x4cda0000  0x0 0x60000
+					 /* Timer 1-2 and EMDIO BAR2 - prefetchable memory */
+					 0x42000000 0x0 0x4ce20000  0x0 0x4ce20000  0x0 0x30000>;
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0000 0 0 1 &gic 0 0
+						 GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+
+				enetc0: ethernet@0,0 {
+					compatible = "pci1131,e101";
+					reg = <0x10000 0 0 0 0>;
+					status = "disabled";
+				};
+
+				netc_timer1: ptp-timer@0,1 {
+					compatible = "pci1131,ee02";
+					reg = <0x10100 0 0 0 0>;
+					status = "disabled";
+				};
+
+				rcec@1,0 {
+					reg = <0x10800 0 0 0 0>;
+					interrupts = <1>;
+				};
+
+				enetc1: ethernet@8,0 {
+					compatible = "pci1131,e101";
+					reg = <0x14000 0 0 0 0>;
+					status = "disabled";
+				};
+
+				enetc2: ethernet@10,0 {
+					compatible = "pci1131,e101";
+					reg = <0x18000 0 0 0 0>;
+					status = "disabled";
+				};
+
+				netc_timer2: ptp-timer@10,1 {
+					compatible = "pci1131,ee02";
+					reg = <0x18100 0 0 0 0>;
+					status = "disabled";
+				};
+
+				netc_emdio: mdio@18,0 {
+					compatible = "pci1131,ee00";
+					reg = <0x1c000 0 0 0 0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					status = "disabled";
+				};
+			};
+		};
+
 		ddr-pmu@4e090dc0 {
 			compatible = "fsl,imx94-ddr-pmu", "fsl,imx93-ddr-pmu";
 			reg = <0x0 0x4e090dc0 0x0 0x200>;
-- 
2.34.1


