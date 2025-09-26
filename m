Return-Path: <netdev+bounces-226568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68098BA22CE
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88E7D4E02F4
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 02:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C39E2397AA;
	Fri, 26 Sep 2025 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HgMCA8dr"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438F17C220;
	Fri, 26 Sep 2025 02:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758852112; cv=fail; b=aw2JIRToMQY2OkeSEwNvvhv8eIEBxhzwd/dQNabIe8m8AmhahJiVERGV+JWcFqlZNxTMXeyYXDaK4fQdCHrj6+L9oV1Vc/VrzAisDa0kHUXzKTFSBEFg9OVsJo/8kmo7sFeSf0/A0OyYAOBP8r9ykXcdeLAV5lMAlvnzJnNIA38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758852112; c=relaxed/simple;
	bh=TO2AWN0IswLnUjKw9cBLqkHf/XCvhAKKyutb3qLChaw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=La74+r6B/vwrkN5gSnuY9cwSXsr4Pth1x0YKmD8wPnSKZCJIy+jzzkINlgeI5yWTdW2bxBX2yRr7T+84e9hJ9zwN6BrBPB/rVuDSt2bcdOtKOCk8LPvLWgzNSO5fnb1pjTHgHM9/2yUwYiZdBuyscZN1oqUD/yLssJqN+Ox6SrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HgMCA8dr; arc=fail smtp.client-ip=40.107.159.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUCMhFJXxZPTPW/FU2PuuQMBGj9lteZ+0bdoFZqCsSmZo0K1YRX2uXRYXEx7IMU5d7CYacMMoaBwRmipQCY2m5Dl9qVVb970KKhDoIEX+m2sEMtXPjdWYdq6j7oVLuWD6meNQ+o9fPr47pjOg5neztERDOK8UddBsNOmMJJU8iFC2AsQG2WZAcVHwdQxVsxiBWdx92v1DMVS7QhdiqlWTcUJGerQyOgc12lj3xW/o/T7D8HFt3aUTY1WC7IonGbwgrO8dtUyVlk3MqYYVFJpUuICHzA8RjkpKkpOIrP0F83ZnhKAvew4nr6eT6KfOVrjQzv7SdC+KiMGXhHjTvL2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwJOds8XKpakLBH+dqCJ8OnblsZWa0B1JOY/VADKyZ8=;
 b=u+EeW+53L7dhq1ZvgeqsYfGhkfIL4iq91tHZYoZaAQ+P/GmtkWZoIwCRxyAiNLQ5fqDKVDIjgX70V7bB9xA/sn4YIIv0J18k9ZaHWCIYK4YyjjXJUFn+bProEuNfwJZ4aISnZOYg+6rqU0j6WiuatCcvG/stgVGtx8RwV8TCVDyXf6eqKbCgj9OGiI/SIZWtjZ/W4gOkzGJCPgTuYinzKoJzKpylJD4McTZHRD3itT99WEce9R8ogykIR0RxSbS4YyXG7CYd4DOc1LEgASWKvsqRpQN70fmmHRZ8h9TJg74ztfebRgT0VdzHTblK+MLmlpXkB16HlOifvZgwSwj0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwJOds8XKpakLBH+dqCJ8OnblsZWa0B1JOY/VADKyZ8=;
 b=HgMCA8drays26LeROJurC1+Uj6aYAg409gHDwOjVt+lBmQDfcoZoY4d2qU1O+RTrOi4NzOra0Tje+1Tcs7fvz4GaNuMlJVe6iDOtEyRj3RUxxr0V97CqKzCBI1s76Y2zBe3OGPhMw4Y0p5Kj8/LGicmZ4lvuvSmlWtkYraLPO8S50haQTd1aOpmNLZoPr0r5F4jpBEkY0cafv15pDtvl33G9JB2fA74t2nIpMbTPP5kyDVe4cnKke4nmALLDvgCdMHP8BeElIRkszn1aM8ggysxSzDqNEXcOtmliECBWkD6QmGN6nTjJPltKi7SSLvBJt4kgoexiTJ7MwDyj0Pv1bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10572.eurprd04.prod.outlook.com (2603:10a6:800:27c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 02:01:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 02:01:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: enetc: initialize SW PIR and CIR based HW PIR and CIR values
Date: Fri, 26 Sep 2025 09:39:53 +0800
Message-Id: <20250926013954.2003456-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB10572:EE_
X-MS-Office365-Filtering-Correlation-Id: ba14dd8c-aabf-436e-5960-08ddfca0a46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?334cAbipi9jy+NXa14J8WMg/Qt/MbFeFy4z9RGwNDkKLLg9omqDUK1nP/R4x?=
 =?us-ascii?Q?SEQsTVAhUtzibEgqmxpDoverPaswtGgrsK4iY4wo/+imlaz7LvplyJpenfvQ?=
 =?us-ascii?Q?AEZPo101MYGte/ADnmyYZIiVt2fdVRKHrJroQwz7fF1WfGlBtlrL4CJpWBxB?=
 =?us-ascii?Q?h7pwFr7BRTU+Gq84egbjiLp9CRWd40kV1CfJGShJURAWH3vXbU8GhYdiF4ne?=
 =?us-ascii?Q?+tyyJj9DIzRiF/Ak33b+sqWoaXlhd5DKnDByI+T9Ba51vGiV+YLi4KsG/GbD?=
 =?us-ascii?Q?CEKI5QA1UUuP0a5yL/Kg7nY1UUwCVf0hygOUGSEH/luUoJCu3PrlqCKgqCMq?=
 =?us-ascii?Q?yAQ4JziW6nDbOUBfabF+U7TkJZNA4+nS39q/90dHvEG7eDNOcy7XCAMfm08z?=
 =?us-ascii?Q?g0ZWz3usEzhdbFEyb3ACwQCsWtwvXEhwRkpeugP6w090iuFTgxb3lpkzo/hs?=
 =?us-ascii?Q?DD698hkj4hOy1J5xLerEbnyb6CVh56ez7c0c3HtbOdwwQ7dzRn3d6AbSq23h?=
 =?us-ascii?Q?ZGEO3hMJrh2y6zxvm9M32U0c6FgaaTF6Iwp68HwmAWEU6NperjQz9vIklqsg?=
 =?us-ascii?Q?itHUI2shdoe/jBf8jfb2SpGe/nHPaYJZFsdWqEQOxPq1NVJn+M8kxSurocPz?=
 =?us-ascii?Q?1ZIczk5qz2y/YwB8Vkp8eLckzd+R0KlwMiQZyM9gIs7hN4toGKHOwpcfzJOe?=
 =?us-ascii?Q?XWXLUbT4/sAz6nu0pdvUK9UQGAuHDIFmSwr64L+hUpbxrXI19p9gIVW1iAtT?=
 =?us-ascii?Q?CljeLdwF9cMmsGyVpH5WuXodVaMyGeL1ilgm9a/IwAjAkgoFJPUBVgWQALsz?=
 =?us-ascii?Q?S/cQO29n+EArGqE38yqgA7KcU0HVKCgzV4pfeIzRYBGqZeUW6qFbzRc1VcZW?=
 =?us-ascii?Q?oE5AapAPz8qE+ZRQ8qCikdpcW232fiBHgmTR87FBf9Yi4QR4Kp5+J5vk9svr?=
 =?us-ascii?Q?zpsyj8vCYVqGxrVQ6HB+lIIjG7OIfL2wQ/uxI0aU8RDASbd7d5aMyiqXUCPX?=
 =?us-ascii?Q?c9AnLxbAx9FMryPROpm/dehEpbxBVe81VchT/tpVooB3Ormsjpbg0EBZUWlW?=
 =?us-ascii?Q?tIPn+yD6s7aLy2DWBZBlEV3akXQBFUlT3/hUkItK+4cip51DOq5opmKvNt12?=
 =?us-ascii?Q?LMN1c4DrvNfnltKvtahvxIzNmbmFxiQCrEaGrqnZ4lth1IKYGy/HWsT6sfGn?=
 =?us-ascii?Q?ddR8CLP4DICrSIT8AGRkKCj6zRTIVao41x1EyTT49KicjrCpUE4Kd2WTPZym?=
 =?us-ascii?Q?bdtOLBJqS1mlZfpvbX3hl+iDdRGIssG97G1rxVrZzDM4ivo4WZDmZ8aPnSfm?=
 =?us-ascii?Q?nwrI6OTwpTfM0PGp0tLToH2FddxaEZ515h0p+00hiRMu/Y04B/+twWrr87Kt?=
 =?us-ascii?Q?zrL1PbaM0UHd057KlJYml5Ot0UkBxkarzsdA0is6vtnotMl3NEPOK97eP+D7?=
 =?us-ascii?Q?+1t3D2LsoT3+7GT9uCicLzBDfk4PEDuATUXiOx8w5zcVsAfiRlykR2IaaBhp?=
 =?us-ascii?Q?F9yj1nlAmOHS0H9n/pP6Wp/pHJidVsQt+PUy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p0L9FTkT24fN/eE2GGooLAZQZBzaeoRfsXWZhLrXGd8ocmwU9B6/3JCahpNY?=
 =?us-ascii?Q?hgWXt4nz0OfuIk+vAs5gUDHbKBqsCEgbYH5NdMFMieWn7imnL4VTW2K6IBzs?=
 =?us-ascii?Q?nwlyh+KKsm58oIUVpwfPGY0D4UyU7nJYrJ3qhJSFn03IjddFea+MZbv0DSQk?=
 =?us-ascii?Q?002kdpQ3jwZsWfg/nCI5xa1glJqSzDd8xr+1NSnPbCOzNU7cZoKZdcjEJM+Y?=
 =?us-ascii?Q?i33jywxNhb7OReQZyDTZ7JbVVkPOR9k2iYjLO0598jQIE1Ev2zVwBMpKn1ST?=
 =?us-ascii?Q?X65xJ0pfX/P2s8p1MeyhxC3ogRfDjVUMA6ISnlIxjs4RFYjHEqQgBOROit9W?=
 =?us-ascii?Q?tQrNGD1h8QRaDoRECyxzIPX/T3hOezygFjWZKS2j2voDG9V8MBkkJxWv4b88?=
 =?us-ascii?Q?hmvY7EudxAbjf9Ev4PlUHiS652RS7UdDMVu/TqkrE/tCXxU6MKmew2UGv6Uy?=
 =?us-ascii?Q?2TySBgNiVgp0+COnpTa12ETayHaAF2RP6/oDuF0tHQ0ZTwjVwAAvEojAJ1Gb?=
 =?us-ascii?Q?81NCIQnteBrWQyTJs/vYCzuy1YVP/fLE9pt1JTu2w1/KbLXF5z8vEYWYhUtW?=
 =?us-ascii?Q?eNfd9jDlnPHhsIttTctCR5oZRuTl9OhWxXxGFyArwY7O8JgNGjDX+aZv3x0f?=
 =?us-ascii?Q?19A8bIShynsWpAblnbh0WFgYmOydePO00u1v+8EzLmwqGCcoBkcXQX7sqyMT?=
 =?us-ascii?Q?+ghtY1+da+HbLSCbBF20EjpiYxFvVDjKCjpjC12XF2G6as0sDZeRUe2OHq+m?=
 =?us-ascii?Q?UbGDooIGtPa4QvAeKWYDsnc/zD6mlgsiE+MNnmSJLAHI1nPHXUDghsYTWBnz?=
 =?us-ascii?Q?jxNWFsD4x+TjAHdyDz7vo2B/MwP2wOUyXbZzrv78u2tkGAUo2ga/5Jy6rZR3?=
 =?us-ascii?Q?5sgNhS08E1macQs7dy5YZFrp+28Oz7DcO3hizwZYouA4n1hqzTgn3RNjvD3x?=
 =?us-ascii?Q?gdAv9lwSmVP986ucwCua28xeoW8tXwcsTJSqnk9hofMolyL40PwxBvGSorRW?=
 =?us-ascii?Q?vyJ7vRtQ/R3bJf5zq1QHzXtjnCNE1wFRYNX2+1M8se/WohMZAkfzN1U90lLj?=
 =?us-ascii?Q?Qgx43sWqjthRoTEv6HhXn/GIFbH/wy6WLNYyu1Uh4tvYhwpWKryHVHQXnPqz?=
 =?us-ascii?Q?7RRnaLIbfOf/pbQeZB/FiQbCT0E/7epGQ2+9B+ROzEeR0PoH+iUTnRbF5MNw?=
 =?us-ascii?Q?5LwWXNAxJXEnTemV6YHh2p/5hfxiPIgwmyzbm1wsS3+YruF14Tdvsm0PrZFl?=
 =?us-ascii?Q?IHjWKdmez2kuuTsvi7aCmXEp5u0BPPTU6QvqHoxFVewBasB0s40rxb+sdDF1?=
 =?us-ascii?Q?6MSsPtymBwMaSYskEN/8Hrz5MFA9f4iFN1xYcQfLuyAGAszbyx5L4skVgKV7?=
 =?us-ascii?Q?ZeYnoFGpcdMTXT/NSCA7Ljm1q2M6bI/PbtAQSucThwQt4x0bi90QSLi1IllY?=
 =?us-ascii?Q?L3F83ekJXH/lCnFwWY9gEHeYzN80e+iUPQoGAMTANYd98VEWJ1KXAWVVVcrR?=
 =?us-ascii?Q?HqfIPSlnSs9t8PliIvxocjs2G0/X/LmCMZTXtr/vgfJszngphz+fJnPiAnu7?=
 =?us-ascii?Q?s/i7Fs03Jm+G6zbIIR54ZebrYoNA0HsWxIt3Xffn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba14dd8c-aabf-436e-5960-08ddfca0a46e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 02:01:44.2172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snxkyYS0RjXb0quLdjUmVZgZ019nUWmQjI7sUcElaY0f+HjhVxpx6H5DCRmIr4OvZS8oUd74yg/k6sMNNRYP9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10572

Software can only initialize the PIR and CIR of the command BD ring after
a FLR, and these two registers can only be set to 0. But the reset values
of these two registers are 0, so software does not need to update them.
If there is no a FLR and PIR and CIR are not 0, resetting them to 0 or
other values by software will cause the command BD ring to work
abnormally. This is because of an internal context in the ring prefetch
logic that will retain the state from the first incarnation of the ring
and continue prefetching from the stale location when the ring is
reinitialized. The internal context can only be reset by the FLR.

In addition, there is a logic error in the implementation, next_to_clean
indicates the software CIR and next_to_use indicates the software PIR.
But the current driver uses next_to_clean to set PIR and use next_to_use
to set CIR. This does not cause a problem in actual use, because the
current command BD ring is only initialized after FLR, and the initial
values of next_to_use and next_to_clean are both 0.

Therefore, this patch removes the initialization of PIR and CIR. Instead,
next_to_use and next_to_clean are initialized by reading the values of
PIR and CIR.

Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to support NTMP")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index ba32c1bbd9e1..0c1d343253bf 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -52,24 +52,19 @@ int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 	cbdr->addr_base_align = PTR_ALIGN(cbdr->addr_base,
 					  NTMP_BASE_ADDR_ALIGN);
 
-	cbdr->next_to_clean = 0;
-	cbdr->next_to_use = 0;
 	spin_lock_init(&cbdr->ring_lock);
 
+	cbdr->next_to_use = netc_read(cbdr->regs.pir);
+	cbdr->next_to_clean = netc_read(cbdr->regs.cir);
+
 	/* Step 1: Configure the base address of the Control BD Ring */
 	netc_write(cbdr->regs.bar0, lower_32_bits(cbdr->dma_base_align));
 	netc_write(cbdr->regs.bar1, upper_32_bits(cbdr->dma_base_align));
 
-	/* Step 2: Configure the producer index register */
-	netc_write(cbdr->regs.pir, cbdr->next_to_clean);
-
-	/* Step 3: Configure the consumer index register */
-	netc_write(cbdr->regs.cir, cbdr->next_to_use);
-
-	/* Step4: Configure the number of BDs of the Control BD Ring */
+	/* Step 2: Configure the number of BDs of the Control BD Ring */
 	netc_write(cbdr->regs.lenr, cbdr->bd_num);
 
-	/* Step 5: Enable the Control BD Ring */
+	/* Step 3: Enable the Control BD Ring */
 	netc_write(cbdr->regs.mr, NETC_CBDR_MR_EN);
 
 	return 0;
-- 
2.34.1


