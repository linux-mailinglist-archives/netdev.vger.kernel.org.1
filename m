Return-Path: <netdev+bounces-158849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39276A1383D
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22481888878
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AD81DE2BA;
	Thu, 16 Jan 2025 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jcFsgjAk"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2048.outbound.protection.outlook.com [40.107.103.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2804D1DDC28
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024415; cv=fail; b=knuMa6yvWr+xT9SsmZNhjyyZ9pN4fGqIh1hlZT9KhUtpwZOw4AHMDOpz9KV9hZ9kO6YxnY+J8CCKnBbIPNfCRTsF416xavEQoEeqfnuM+LTazyc8rDMhU+Lf1jOxEhtjm4SFWehxtKpR/XSNFY2UI/Bhk6inmCK3fQd/MYe6AME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024415; c=relaxed/simple;
	bh=qbaHkQRmofEg4awn9NyC6StmCVCFVB96Cs/AHFQfhMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TL+2eSElL+s/Ru+07AgYpYrEpgS6MAHMfxdolX0XkUHnh6MZeDjfs7hI4W686x4fq3C3RczVmRSr6FQOXDOZHcgSFx075JXjiTYZc3Lou2m6eGITJ0JIWEd89z97OtIbeEH/q4uY1rKZSGDsSmWPSeCEZSqg6IKue5LCYbggcsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jcFsgjAk; arc=fail smtp.client-ip=40.107.103.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTOdnvDVwR6nfSc3+qIrSOCff7CkiKfJO9+SKLfdn1enruWU1PgwHAREGFAPhr6aUBJgmRN9YpYieslVX0H54KoxsPZN8x6KHso1RZ1ZN1Uzfo8nwXh4hjrxu3o4owynalT9z13VBzJ1nhmEyYg8enMCG/dGfu1HHueCj1LdmYI4eo+Bf0T1xOrelIcQ0v1sUk+BIJBOdM9iOc1ftzaFr3l+X0G0we+5BuzdJ11U/M1wHqHCWWfURTiA5ZcqSSabVN61BAqE5rgh8VMHJ+4Gk3n1AYd6Ke/BOVwdicBiz3Ii/toHUiD99ZYlhCpeY0f/gN0bxytd3PWAEoMlRCI++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8VXBLzPSasIchTcZn6SpSIMzNcxSuD9y8MRI6fhNZk=;
 b=CfSTJplgaFnxk0cdlHvp3iFk+VrrNJnqJg8nHkxEOHhuAHjuPPm/mtIrha5nJyO5T1d+uqzePeVrMIXMEcdJ2AxJpINkEm7lljfSzYKk66ox4EFCZV6dyi1O889xAWungKF4Cqcnmp6Dxe/1annkxPj+9bUtLvicZ+rjs84CmJfkZrKy4QtdMdCRod3Uu2vlMYsPys6hFE7DJU2oRPXdQl7u8pNVb6x5pMt3P34UsM2+kXNu6D5HzgPA8ZGlQ7hjNmVCul6tHwI1pMP3HMRKhK4M5SCaPlBOyiaiMhkHYfykQwbg9jefPyKnNqqNQ0iNZV9PjkdHO7KCghrhSjoCoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8VXBLzPSasIchTcZn6SpSIMzNcxSuD9y8MRI6fhNZk=;
 b=jcFsgjAko35CCmpyRRHYtK378nVInrM5rkq9IRsO4Fqq99XdMeS48miRg/LHNS3ccHN9AKmdLkODsBCZ6gbDDyDrpv9yJx5xyYjH3hrLZ63rVAVKnoNddm2b84bNIeMx4Y2Iem7KOkHI1LaR6GfPBR2NZZTy8Y0sp+W5WxKY5x2BEC2Atah2cY7yfP8A4MDi0QXq347rv2G0iGvrkMijZuP7c4Cp5BaHuN12rWqyQqb1qt1G23ScfG4S/8wTFT+X9DVMkw5liJOSDkDKsTTun/AQ2Cs36cNd//QgHxsD/Sc7jCeGWZBWvv8fNCXU6fkf1II9oZz436HcfhBfujxGRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB9675.eurprd04.prod.outlook.com (2603:10a6:10:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 10:46:46 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 10:46:46 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v2 net-next 3/4] net: mscc: ocelot: add TX timestamping statistics
Date: Thu, 16 Jan 2025 12:46:27 +0200
Message-ID: <20250116104628.123555-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116104628.123555-1-vladimir.oltean@nxp.com>
References: <20250116104628.123555-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0136.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7f7bdd-ccd4-4fc7-f641-08dd361b11a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a5ZI5S6zUibL3DjPr5Sj/aG5hjlQMSOhMht6ebqZe/BuGKA+21QOFI/5TdIx?=
 =?us-ascii?Q?lrlK605OvXh3vJ4Sil1Kj46AMJvi1EesOIMSv3NJz15j7JGntpQJxiT/vUzL?=
 =?us-ascii?Q?MfCJ+ZkcT3JLwwPZuAF5JgUmqHFtOMkmh+HR2UtvQKZ/dIursubH2tqxvEhC?=
 =?us-ascii?Q?ehjOUlf8/197mWT+TfW+pBI986MbkGID78+TeOBpsy5o0Rvr6xihDVcbFr6Q?=
 =?us-ascii?Q?jTKg8cYlgXLxfUYCl1cl1EnkGNsZ67+1vpSu1rydgXsFYYYF/zTjvZPocNBX?=
 =?us-ascii?Q?WCDU07Q5YGoCy/qmNc+Nue1HSJCubwPQ0/j5pLdIMHc41ZRgArk4hLO1OX37?=
 =?us-ascii?Q?l/zCs112fEvSWuLlrhuCcgnIi9ae3XUORlMlMFfo7Rym2nhRQBdoFXGUkeOP?=
 =?us-ascii?Q?Zv6f76CGY4+puziOVQnZ/E5S6UjtC7Z5FpjfJyHivn0uxleSlLX87HxHFEU9?=
 =?us-ascii?Q?M0AI72Q4uwL1iPpfsoOlr9HVyeD/I21Ri7gJgY0B0rfFEV3Edh7/tmq2qrA3?=
 =?us-ascii?Q?J3p1VMP7sup0ece7KFglSkXD2RcUMbhdiReabNua1FyS1GCiggNJM0ZfRrSq?=
 =?us-ascii?Q?kK6+c81ojBHGhG4bufV6NccROAMb89gUbMIiBSBoToX9/8BtvDPIItgdkUss?=
 =?us-ascii?Q?3vvAEOzHxx+6tdCJGru8lJhF2DeK6jOUuPdtWflTmqe935iOqi6dP+xkjZji?=
 =?us-ascii?Q?dQ9dVZobkysuQ9cwl7khE1Ucw87c2Mzm2JCYaMYWkMn+xZAXGV4FJ0B78vwe?=
 =?us-ascii?Q?jfq8qas4dsVgBm/3/Tfrhc8YFYUXHx2KJxlj7PAU5HxJ0ehXpb8z/a4DnRTh?=
 =?us-ascii?Q?CxruRm4ZgayZ6F/CtrK72cVnAPL/edZqT1/iD9zxgV5ttJgRFoK2pP8CmxWW?=
 =?us-ascii?Q?uqcUN7TL/o+b+wA0yDJGqaGJoaxIk2We9BiaJ5/hPJEBTzUqkPUOoeSnim8B?=
 =?us-ascii?Q?V+QITmKVNE/POhQyAMIW9lhYpxz7yjHGkfiwJ4xxZAlA6L3DvJgMyXYOlj2N?=
 =?us-ascii?Q?NY0PDjGgqwHhejzkqW83ng6GBMho8y598kUjLX+DAnVIi87hFic6X+FvIWO+?=
 =?us-ascii?Q?WTrMEpP3Jv9PqpxNjWUxYfFwjCwR3T2yAuWGFpRIX5mawdzLt+p/5wR6JbcC?=
 =?us-ascii?Q?ms3SrvNoQTs2FFPGGDyd4hZGaxzTWDaPdMvGTK33xG3OQNeESOEKoBhcbKuW?=
 =?us-ascii?Q?BScOZBdMXYk35I4EeLXTi6NEgVgVI75paCJfUxmLg6glBLK1z5UFHZlvyeMS?=
 =?us-ascii?Q?mKGPYph9SiAGTIe9ycqEIq9+hhFPnsCAbhlUDrVbZxZ9DxQuNqVNWV7JpWoU?=
 =?us-ascii?Q?bASRRCmca2pzFLmHXZBH7FJN96LlUxOO4l0A+WakgDwyevo9WvhWOxxeAFSj?=
 =?us-ascii?Q?nODldKFYORunIUaMqLsDGATL5RuFcf5/s7CJgbuTyZ9u74S8GWk4pEke9i+m?=
 =?us-ascii?Q?hXQgMTSczUZCyBfZU/Z+q2aNuMWH856E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iuw5u2SGghpxBpeTa7z2DO1gAsow2U5Mo0RXgHILrPF8hcykN/f6a4FsRKGv?=
 =?us-ascii?Q?5T6eOJ4uGQWCV7qp/aErHxFCiPsPf9r7KYyKH7DaQfttQtAj/Gpa/1+o74aJ?=
 =?us-ascii?Q?IFglVLrWb/JBGXZPdYIZcFkaSaIeLI1wL7JCnASs6J/Kx0N5m+ElfwosWAZU?=
 =?us-ascii?Q?fQ0XlW+N46aPNmcazoLyfEBIG0xYnmu52ksXbbeYt1zRy3g6iQfWGlGQVbth?=
 =?us-ascii?Q?7cyD7chC3GyfbmaGey91cPNsUzhjxOysoeVrwBd5+Z786QLayCULEC+IUEQ9?=
 =?us-ascii?Q?DdiJKuQbhySH9Pw9PAnxZhquiWaTKiD5jLSXlTtusrU48fc+8GIOeHrbPSOR?=
 =?us-ascii?Q?aGdmPjTj5XsLkLvnMq4xNFEIHrsoVhR+hvFQyDKPlUT6dGSVq6OVi5sYmzPW?=
 =?us-ascii?Q?srdQMM1y4GYl3YHXhOmnVG07TBMeUQj7LHJ4c+rvXyYFQ2/zYL855bnXx3t5?=
 =?us-ascii?Q?CCiUrSrjFAH4yMao0Z6rIpoD1RZCsXh/f2DLU0L2j52XOYKYjLc7Z9Dkk1us?=
 =?us-ascii?Q?5qiHJ+/5dLejnWmwD6h8hnd1M3+EKXAKClZ1ZAkwPhtS2+gTWsySB8rz9Pu0?=
 =?us-ascii?Q?tl5wAvmjQJoK9UdDPq4oxlCfzZ1Nq2KYb+dXHfm0OweZunbETYSB1KA6usqb?=
 =?us-ascii?Q?cj1BX2cVR9Tz8xThvFCelNB1eWgETfLCjAsaa+LLbVjIPwGyg2vd4JDHTUD6?=
 =?us-ascii?Q?S0+ofpQ/SICz6URuRfE/UKetyjv+Ugl0Ia6RGtvc/woUQq7pHnZZ8EwPacXP?=
 =?us-ascii?Q?3dgyD+5DmsiKoFgB1MBU3c6mqj2aanGJnEh0fdrxCbvxaxXg33jQuXV8ZmFB?=
 =?us-ascii?Q?lF7ZRQokE/H7fEoz6vO956bRx6RxXv926Adq2cqiiaWdUaQLOqQ6UP/SPO8q?=
 =?us-ascii?Q?U13IDO2mNAQz1u+h9YJ3PA2zLL4XvmfMxO0aSl8fF1DNkjZ7bcLOHZKSeQEs?=
 =?us-ascii?Q?Q1fK8L+P5xdarYIXs0OxCvYOxw/oGsPifpcTXU0GXTWS2uxIKCE7Qfnvn9Qf?=
 =?us-ascii?Q?xO8eVqU3VMKO9EFOoiVW9TkrZjOrDs+BQg6+6jfuaVkLva3k7Rjo4gsXPTKA?=
 =?us-ascii?Q?gRd1yAxncL3tBaG64+v0aYTyaUWzAPqfUuqz1461Yc/8+ksKtPahFaPBxQbk?=
 =?us-ascii?Q?vHxXUmlC/dfPI07Dv4mdjKLijJL+HuGPoQBvoMOc0HL81Vfbx40oqp0poOaw?=
 =?us-ascii?Q?3qPWxXHMMZOK8RTFRnYUrJc+WRg6qPZnONeSHdvocwP+knHLb964bKStf04O?=
 =?us-ascii?Q?3LGYIs5W1zXG3VlKtVw9ZThxrwg4Jr6vi2loq7xBL7VfpLa4355taBROYmCH?=
 =?us-ascii?Q?hbpQ2N5ivh87ZECCKoACRVxEvE5gY+dePU5EkG4DVvT0oCA8ztNQUDMk+SpW?=
 =?us-ascii?Q?Hc1zOkCiDgbcKqp3sOWLzi/nw5t1rUCQalxeW3HEdJwZUjM2b7LMEApLeP0D?=
 =?us-ascii?Q?q4/pNZYRh+uuULoUxOh85pSgZWKncRtNnREuUdFL/xaqmQSi82CJusuFcw5Q?=
 =?us-ascii?Q?Co/Z8bWFMgOj5+VN/hefW0tpv6Gw7yA/M/Op97FX7B84uiilQj3bQFK8vTHa?=
 =?us-ascii?Q?iiFrJkF128+hkJqAxpOmkcUiq/H5s4TM1FzrGtlEj65n1i6XjbNM+jRNGeln?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7f7bdd-ccd4-4fc7-f641-08dd361b11a7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 10:46:44.7180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vv/W/sVd1z9o7R2bbW46Qwn/bKLLRw+iSdkuh9GSW2MNk+LktvH3JxdSyuQ9LscADutqCI0QqRif+8boVQ5OJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9675

Add an u64 hardware timestamping statistics structure for each ocelot
port. Export a function from the common switch library for reporting
them to ethtool. This is called by the ocelot switchdev front-end for
now.

Note that for the switchdev driver, we report the one-step PTP packets
as unconfirmed, even though in principle, for some transmission
mechanisms like FDMA, we may be able to confirm transmission and bump
the "pkts" counter in ocelot_fdma_tx_cleanup() instead. I don't have
access to hardware which uses the switchdev front-end, and I've kept the
implementation simple.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
v1->v2: none

 drivers/net/ethernet/mscc/ocelot_net.c   | 11 +++++
 drivers/net/ethernet/mscc/ocelot_ptp.c   | 53 +++++++++++++++++++-----
 drivers/net/ethernet/mscc/ocelot_stats.c | 37 +++++++++++++++++
 include/soc/mscc/ocelot.h                | 11 +++++
 4 files changed, 101 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 8d48468cddd7..7663d196eaf8 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -993,6 +993,16 @@ static int ocelot_port_get_ts_info(struct net_device *dev,
 	return ocelot_get_ts_info(ocelot, port, info);
 }
 
+static void ocelot_port_ts_stats(struct net_device *dev,
+				 struct ethtool_ts_stats *ts_stats)
+{
+	struct ocelot_port_private *priv = netdev_priv(dev);
+	struct ocelot *ocelot = priv->port.ocelot;
+	int port = priv->port.index;
+
+	ocelot_port_get_ts_stats(ocelot, port, ts_stats);
+}
+
 static const struct ethtool_ops ocelot_ethtool_ops = {
 	.get_strings		= ocelot_port_get_strings,
 	.get_ethtool_stats	= ocelot_port_get_ethtool_stats,
@@ -1000,6 +1010,7 @@ static const struct ethtool_ops ocelot_ethtool_ops = {
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 	.get_ts_info		= ocelot_port_get_ts_info,
+	.get_ts_stats		= ocelot_port_ts_stats,
 };
 
 static void ocelot_port_attr_stp_state_set(struct ocelot *ocelot, int port,
diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index 808ce8e68d39..cc1088988da0 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -680,9 +680,14 @@ static int ocelot_port_queue_ptp_tx_skb(struct ocelot *ocelot, int port,
 	skb_queue_walk_safe(&ocelot_port->tx_skbs, skb, skb_tmp) {
 		if (time_before(OCELOT_SKB_CB(skb)->ptp_tx_time +
 				OCELOT_PTP_TX_TSTAMP_TIMEOUT, jiffies)) {
-			dev_warn_ratelimited(ocelot->dev,
-					     "port %d invalidating stale timestamp ID %u which seems lost\n",
-					     port, OCELOT_SKB_CB(skb)->ts_id);
+			u64_stats_update_begin(&ocelot_port->ts_stats->syncp);
+			ocelot_port->ts_stats->lost++;
+			u64_stats_update_end(&ocelot_port->ts_stats->syncp);
+
+			dev_dbg_ratelimited(ocelot->dev,
+					    "port %d invalidating stale timestamp ID %u which seems lost\n",
+					    port, OCELOT_SKB_CB(skb)->ts_id);
+
 			__skb_unlink(skb, &ocelot_port->tx_skbs);
 			kfree_skb(skb);
 			ocelot->ptp_skbs_in_flight--;
@@ -748,13 +753,20 @@ int ocelot_port_txtstamp_request(struct ocelot *ocelot, int port,
 		return 0;
 
 	ptp_class = ptp_classify_raw(skb);
-	if (ptp_class == PTP_CLASS_NONE)
-		return -EINVAL;
+	if (ptp_class == PTP_CLASS_NONE) {
+		err = -EINVAL;
+		goto error;
+	}
 
 	/* Store ptp_cmd in OCELOT_SKB_CB(skb)->ptp_cmd */
 	if (ptp_cmd == IFH_REW_OP_ORIGIN_PTP) {
 		if (ocelot_ptp_is_onestep_sync(skb, ptp_class)) {
 			OCELOT_SKB_CB(skb)->ptp_cmd = ptp_cmd;
+
+			u64_stats_update_begin(&ocelot_port->ts_stats->syncp);
+			ocelot_port->ts_stats->onestep_pkts_unconfirmed++;
+			u64_stats_update_end(&ocelot_port->ts_stats->syncp);
+
 			return 0;
 		}
 
@@ -764,14 +776,16 @@ int ocelot_port_txtstamp_request(struct ocelot *ocelot, int port,
 
 	if (ptp_cmd == IFH_REW_OP_TWO_STEP_PTP) {
 		*clone = skb_clone_sk(skb);
-		if (!(*clone))
-			return -ENOMEM;
+		if (!(*clone)) {
+			err = -ENOMEM;
+			goto error;
+		}
 
 		/* Store timestamp ID in OCELOT_SKB_CB(clone)->ts_id */
 		err = ocelot_port_queue_ptp_tx_skb(ocelot, port, *clone);
 		if (err) {
 			kfree_skb(*clone);
-			return err;
+			goto error;
 		}
 
 		skb_shinfo(*clone)->tx_flags |= SKBTX_IN_PROGRESS;
@@ -780,6 +794,12 @@ int ocelot_port_txtstamp_request(struct ocelot *ocelot, int port,
 	}
 
 	return 0;
+
+error:
+	u64_stats_update_begin(&ocelot_port->ts_stats->syncp);
+	ocelot_port->ts_stats->err++;
+	u64_stats_update_end(&ocelot_port->ts_stats->syncp);
+	return err;
 }
 EXPORT_SYMBOL(ocelot_port_txtstamp_request);
 
@@ -816,6 +836,7 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 
 	while (budget--) {
 		struct skb_shared_hwtstamps shhwtstamps;
+		struct ocelot_port *ocelot_port;
 		u32 val, id, seqid, txport;
 		struct sk_buff *skb_match;
 		struct timespec64 ts;
@@ -832,17 +853,27 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 		id = SYS_PTP_STATUS_PTP_MESS_ID_X(val);
 		txport = SYS_PTP_STATUS_PTP_MESS_TXPORT_X(val);
 		seqid = SYS_PTP_STATUS_PTP_MESS_SEQ_ID(val);
+		ocelot_port = ocelot->ports[txport];
 
 		/* Retrieve its associated skb */
 		skb_match = ocelot_port_dequeue_ptp_tx_skb(ocelot, txport, id,
 							   seqid);
 		if (!skb_match) {
-			dev_warn_ratelimited(ocelot->dev,
-					     "port %d received TX timestamp (seqid %d, ts id %u) for packet previously declared stale\n",
-					     txport, seqid, id);
+			u64_stats_update_begin(&ocelot_port->ts_stats->syncp);
+			ocelot_port->ts_stats->err++;
+			u64_stats_update_end(&ocelot_port->ts_stats->syncp);
+
+			dev_dbg_ratelimited(ocelot->dev,
+					    "port %d received TX timestamp (seqid %d, ts id %u) for packet previously declared stale\n",
+					    txport, seqid, id);
+
 			goto next_ts;
 		}
 
+		u64_stats_update_begin(&ocelot_port->ts_stats->syncp);
+		ocelot_port->ts_stats->pkts++;
+		u64_stats_update_end(&ocelot_port->ts_stats->syncp);
+
 		/* Get the h/w timestamp */
 		ocelot_get_hwtimestamp(ocelot, &ts);
 
diff --git a/drivers/net/ethernet/mscc/ocelot_stats.c b/drivers/net/ethernet/mscc/ocelot_stats.c
index c018783757fb..545710dadcf5 100644
--- a/drivers/net/ethernet/mscc/ocelot_stats.c
+++ b/drivers/net/ethernet/mscc/ocelot_stats.c
@@ -821,6 +821,26 @@ void ocelot_port_get_eth_phy_stats(struct ocelot *ocelot, int port,
 }
 EXPORT_SYMBOL_GPL(ocelot_port_get_eth_phy_stats);
 
+void ocelot_port_get_ts_stats(struct ocelot *ocelot, int port,
+			      struct ethtool_ts_stats *ts_stats)
+{
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	struct ocelot_ts_stats *stats = ocelot_port->ts_stats;
+	unsigned int start;
+
+	if (!ocelot->ptp)
+		return;
+
+	do {
+		start = u64_stats_fetch_begin(&stats->syncp);
+		ts_stats->pkts = stats->pkts;
+		ts_stats->onestep_pkts_unconfirmed = stats->onestep_pkts_unconfirmed;
+		ts_stats->lost = stats->lost;
+		ts_stats->err = stats->err;
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
+}
+EXPORT_SYMBOL_GPL(ocelot_port_get_ts_stats);
+
 void ocelot_port_get_stats64(struct ocelot *ocelot, int port,
 			     struct rtnl_link_stats64 *stats)
 {
@@ -960,6 +980,23 @@ int ocelot_stats_init(struct ocelot *ocelot)
 	if (!ocelot->stats)
 		return -ENOMEM;
 
+	if (ocelot->ptp) {
+		for (int port = 0; port < ocelot->num_phys_ports; port++) {
+			struct ocelot_port *ocelot_port = ocelot->ports[port];
+
+			if (!ocelot_port)
+				continue;
+
+			ocelot_port->ts_stats = devm_kzalloc(ocelot->dev,
+							     sizeof(*ocelot_port->ts_stats),
+							     GFP_KERNEL);
+			if (!ocelot_port->ts_stats)
+				return -ENOMEM;
+
+			u64_stats_init(&ocelot_port->ts_stats->syncp);
+		}
+	}
+
 	snprintf(queue_name, sizeof(queue_name), "%s-stats",
 		 dev_name(ocelot->dev));
 	ocelot->stats_queue = create_singlethread_workqueue(queue_name);
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 2db9ae0575b6..6db7fc9dbaa4 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -759,6 +759,14 @@ struct ocelot_mm_state {
 	u8 active_preemptible_tcs;
 };
 
+struct ocelot_ts_stats {
+	u64 pkts;
+	u64 onestep_pkts_unconfirmed;
+	u64 lost;
+	u64 err;
+	struct u64_stats_sync syncp;
+};
+
 struct ocelot_port;
 
 struct ocelot_port {
@@ -778,6 +786,7 @@ struct ocelot_port {
 
 	phy_interface_t			phy_mode;
 
+	struct ocelot_ts_stats		*ts_stats;
 	struct sk_buff_head		tx_skbs;
 
 	unsigned int			trap_proto;
@@ -1023,6 +1032,8 @@ void ocelot_port_get_eth_mac_stats(struct ocelot *ocelot, int port,
 				   struct ethtool_eth_mac_stats *mac_stats);
 void ocelot_port_get_eth_phy_stats(struct ocelot *ocelot, int port,
 				   struct ethtool_eth_phy_stats *phy_stats);
+void ocelot_port_get_ts_stats(struct ocelot *ocelot, int port,
+			      struct ethtool_ts_stats *ts_stats);
 int ocelot_get_ts_info(struct ocelot *ocelot, int port,
 		       struct kernel_ethtool_ts_info *info);
 void ocelot_set_ageing_time(struct ocelot *ocelot, unsigned int msecs);
-- 
2.43.0


