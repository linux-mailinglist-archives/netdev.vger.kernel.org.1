Return-Path: <netdev+bounces-207391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DAAB06F84
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620FB4A3031
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D775C299A83;
	Wed, 16 Jul 2025 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gF46Vr0X"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010069.outbound.protection.outlook.com [52.101.84.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493BB2918F1;
	Wed, 16 Jul 2025 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652299; cv=fail; b=nUABG3V2k0eUpcweMFMbGyScJqSfhH+B4KV0FbT4ZFmX9EIZdhVDIs1+Iug0tiLk8vTJH7XgS52oam00ATqeKbZFFZVGVD+nywwIcptsq5vwJSLOOFTtMEIdSH6ycaFFo3ZW3VI7lsqjQ9AxYJS06JdtazJgnWk83j5DXmaK7z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652299; c=relaxed/simple;
	bh=XhwEJnTzbWPMLkrZis0NgRLENFQYt4fAWJwSB43K2Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AXOUAsJLPxSIoyIew6dztzY2xr6luZdSsrw/xNNxsRShcIpzqqylq4TVNXCA75Aq1EmguyJKXUO76w5OQ/dPjYPBOLUZr+WihtCKEGSaPVqy1/LLUbPeG3HLSpI35LMslidKR6dSlQsmkaUdxCUVi4nb4MBCUoA/mYT4X4ShE+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gF46Vr0X; arc=fail smtp.client-ip=52.101.84.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEFf8H87xOYX2Mbu/7oX2+2LeWsBP6/FF4JIHU5LFzE5ei6TB7BaswpniZ072AFp8imQepmBnZuj4Qo0C4+RpKCNi5wEenbuYZb2fafwgl0+/ixMC44uczI/I5xKuSXcGzf0GsGgFkeJW6SYRdJ6a0Xy4bo3gFyC13Y2a+s6aoJUo05Xu4qJt/t6HRRFWb0ZgSnQ5ohjIG29m0e8xSbSNQ02Vp68JfCCezZ2QoSiLzIJurT6ckacMNIOTJr7OOu6GqCxqPv7xsWks1EryEs+KFa2lIVzEFFEpr0GtHhEPSKKZR1M3mDSWgT10Nf6lsuz6K2Tp47zJzsnIHRuoJ7lVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6mPKH+POCPjYIsyBAi2oLSDmmLlv2hUV9GICvUrSiw=;
 b=WV5UyMVsSTG7j0tiIcNhTXHsnTpaSnfnpljvDsjmofZ4qXiwRM3RSMXEe7vYWnTfEtlF5s30S4pQ00ZRTiUUuWWAybBTs4R6QrjHUGe1BiksSSDnGD0bMPGsD7ZeOWQcvNYAr++sPlrRr0s2UFu5r/5K9LgDH6vJwtYrLbkRfDNN7P0TdzXxPhq0LndC/3ic0TLqoZf2s10XtNKD+briCVEHAI7/C9sEVvVdE6AWo6iPHRHwFn7HT4rv1A1fbxzZKxOWz0lF4jVSbiVjSF+kPqY24IX2WFgIEV57RDQZ86TvQX4hQS+zcDm6dWoJLcSo/qSbxFH0c2pUxNh/A4xdSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6mPKH+POCPjYIsyBAi2oLSDmmLlv2hUV9GICvUrSiw=;
 b=gF46Vr0XkguBJ5Yg6ndgYLEe754dnBQVhywydnKZy2dZB0Bgcc/lJE+2bWclb8wNWjDGbZ/9x/jeVPCQIGuCXQDdjV3LNeUiFgOlbzgy6ekbVh5sBktTOB9JeQJrqxL2+vhQM6u6JmRdhXrDyxxn+fQs1J+4T1EI0VtDvyRalxvHCLLxzz8oVSjRbxtvpTNz+qa1xNhaYt+2O4aVmOSW7jiPBN0GNgECKMIIaet9pH+BFFHxIgSlpBgyrZ4lYrVyE3vrg1BtmqT4bCZXsdQ/ux0mnxz3l+KKdEZ0muUoUvyrPw5pGkrdmK+cKieuMw5dw7jPF1OR1nbkcvruOXcrQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v2 net-next 05/14] ptp: netc: add periodic pulse output support
Date: Wed, 16 Jul 2025 15:31:02 +0800
Message-Id: <20250716073111.367382-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073111.367382-1-wei.fang@nxp.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: b5dbaafc-a62b-4d8d-6bbb-08ddc43d9549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aW+QAjlhFGO6ZdW3giZJDyBlUgNxtkzH6wXs2eA+HSLj7sxmavMgcYhy8Ryv?=
 =?us-ascii?Q?96Q9uSFnXDYEdKkCmaQdrRZcex33nXw9xK+arqJEh7WOqPCBKjQhkgkBtSvg?=
 =?us-ascii?Q?ImyzaK3nNN/bowmuw9zTGvrEbfC0aM8Zv/RT0BUKl4CmSyswFN3ABuoeHfS3?=
 =?us-ascii?Q?IzMdNVZ8uDN3El3Jl03I2uw9Xd8RJNeLujPxQvYFFsCI/HQ6+7bGdPGM0XRu?=
 =?us-ascii?Q?S3dLHoAXOkeOcN9HENPOsk+CVsRZVv4dfL2C0vGFKj5Z4DqWA0PdjSNTuuby?=
 =?us-ascii?Q?/HhwE9ejdH5hmRztp+Bm2HPznrfb4wZdbdclrkczpzP3s55CEuvHwzcN4EOI?=
 =?us-ascii?Q?HugDs2+B/NMHb2asTh5Yrh93a8nfxvM2uziCbdipEBD9TfFF8+pM6R2jW5w8?=
 =?us-ascii?Q?OR0813Cov/7llmrK9YMv32PDzN53hXH5LxELQuZ/2ock+dVqNpD/P11/useO?=
 =?us-ascii?Q?tB9q6DNrLrs/qzgQX8yYEYdldBEGBalQxsWUymAYEJz3B5YQdcdQUOmxA+G1?=
 =?us-ascii?Q?upcoBrS7HatVG4MWWM+/NZbPruRiE8bmt3h8JY8DpkAJ9I7y78HDHiiqDuo/?=
 =?us-ascii?Q?n0UByaiRB9gX2rx/nQzCLke5xiDSJcUPV7RgEnGjbVcNpopxXQKGaC8QvkM8?=
 =?us-ascii?Q?zOQYpi5xwzr8ICS6oUK/Yt4CBdZtuGUobNJKiYP3P4L2dl3GwCGWbivcMb/q?=
 =?us-ascii?Q?00/8PZYCRyD4ZhPY7eTaRpuANP5Ub3tgoMiVHAX+aS7zdBOS2DyIVNjF9gpi?=
 =?us-ascii?Q?sJTI0k2yUnxIebvGDHPy/4qk5I3018u5TWIgmQxnfgEVEngJ0C+UlQa0aHL5?=
 =?us-ascii?Q?AFu6r1Y2HbEZeOHtVluWj+TbMiD5Rnxu0XsaxBuFk/NMiGYqrYeRgLV47opY?=
 =?us-ascii?Q?4hHASv2Gdea7LqQwIBVec8Fo7HxuVKY8lL+FDDLod8yeefwkZW1NEtVZni0g?=
 =?us-ascii?Q?v51lVcOsGkSkDqpsY08sHu/0HSZ0iOChx174Ay0zxdpkC8R9koVLsgPrq5gU?=
 =?us-ascii?Q?V3BcorpIbOHR3xyv58eJsCeB9fpmp3USYog3B85vkBtD+Zk9FFtMD1pAm6Ve?=
 =?us-ascii?Q?urE9KsedWvTgpCgl3tlL/cbTXSb77QTLZj2LvwKMIggvWmBmdNcnITcLeHO5?=
 =?us-ascii?Q?pbEUThW1lfiIR1ZOXfQLdJ1D6MyByGhLGA2v5sbyDDxM7WG5VgWZTxJ6QNyx?=
 =?us-ascii?Q?iZplHBadq/26UJhP0bX7timHmgsOid2ZIh2xLXCjFGOhe36tUzbl/j2LYaql?=
 =?us-ascii?Q?Bq8KH6SNWKf8m8p7epSg7MYGOBIu5przREzutr/PTmT2jHaBHuDw3GAwlaju?=
 =?us-ascii?Q?IAp0bFiyj6qE6KovoTAz8W9z3G6uZErJDjJhT4iEXTcCIvERIQUDUGZD2Lql?=
 =?us-ascii?Q?5jP7eC/+pXUTBq+ENZg4fjzazOTC5V3NQLQZ4uj8Vk+PE3Ur0MHLdC0nxMzi?=
 =?us-ascii?Q?04EFbOVDx9dmWzra2Xt54lJQ1b7pUButWvRPFPGJrXldXe5msXn2Z3dFe/c3?=
 =?us-ascii?Q?SRG4fEuhw42pF9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eF4kyZEXG9PmJUANtbVE+eEhlbs3Pyfam7RFS0xX5QNZBHYLbbKWMc/r6nCN?=
 =?us-ascii?Q?UX5Bydvz7fMiOnNDXAzDYl3L82VQ0OUcpG2GsFjTH1DxFEtR5zG7V5iVnYE2?=
 =?us-ascii?Q?7mDIwDAzPmbHGRo0TGZTQFITFuoyNXjQzckR/xps9jdZzjGX+MAQ28GaR59/?=
 =?us-ascii?Q?39iavQDNdC2Qete/uKFAa8FGbE8HNH2wcLWtjXDjU6t7uGo53cugdfXB0cEm?=
 =?us-ascii?Q?sww/qr7nRPSBaCn7SuQgQ691mKpdOwTKo++nt6p5ZyvATkGnC7CaCAiVijfC?=
 =?us-ascii?Q?GJ9QMYGDdJWIuz9Cp7vOGZjAb7ncbAhZPKgYG1SodXsYV77Nn58Wb/PJeKZI?=
 =?us-ascii?Q?YAhLub9xM27i6sKkY7km1qlGwa6v27Oaka6ZibYzHfn++IkjLG3ObEtydFMJ?=
 =?us-ascii?Q?+Hu9MOsWfLWYk2WauX8Y00OMnHrq1KjTq3J5CKq8QJFoeZz7nrpjHGkBM0RY?=
 =?us-ascii?Q?9yryJ30cNzBSCJqxmp3CXiyFAAuM1UQ5eN4AbROOUZSu83tqLFsJXGIdWIuG?=
 =?us-ascii?Q?kOBcmYh+P0SBjjNKIR6wHb2jzWr0BT16XfP+UYe0zJEVTFvwRGBtW+9CrdK9?=
 =?us-ascii?Q?xrvtNbl3tkiOhOSyufY7iuXygg+wgcjkuPwBu8zPjvMBX5VhBa1mg+a1p3al?=
 =?us-ascii?Q?eQNLIVRNXtAVn9gnqQpbUrc4dMgDi3AheUfc5yyjEVM6EKDP6Kks2aIDnXdI?=
 =?us-ascii?Q?nRaCPy1Qcl/rKs5if0aHTboH/Kac1dFluBOdNdKP+VD2fY58cbF80LkwhNbn?=
 =?us-ascii?Q?qxxdcWxnbHGaz+cdd7iUUnmOK70W/v7DN0ftLNtjEye++mxw5YZ9dLWNcHLl?=
 =?us-ascii?Q?6IAp2R95PRgWosEsj6eHRRlpSoj+8CTdEv/L6l8i9Gpp9cmiKkR5UqC7GvEm?=
 =?us-ascii?Q?f7Wy4DN156fJ+EeehuqmFGdYrV8sYiRheB/rndWdj4KJVO98bmtKZuYxvem8?=
 =?us-ascii?Q?ay+O/lqySAcWb/pZ262VckRrEmjq4wQkCrSAZVjlJKWxYacEZTUMLp3W6bsu?=
 =?us-ascii?Q?XSH3gXIBM41hEkV8+57DK/ivh1A9XOQaNoPvKkdwUqQ5MaYio3z1nkvjiVm0?=
 =?us-ascii?Q?bn8YERIC2uqzfUan1AXI78G3iMYzUVajdgP3ihTTvg8aqfklJmKnoJQiPdHM?=
 =?us-ascii?Q?coH6U4X35LRU8qCMxIByep5bJwZJgwvcQCU/+XA3aF5T57LyxtYyJwZnxeWg?=
 =?us-ascii?Q?l2X6J9DM5IrQ3TNx/DYkyVDKfSxQU0x0DvgiD119ixjaNAErY3CGyHVvb1Kt?=
 =?us-ascii?Q?TxU783EY6O9q5jiMMG9KatcdDiU981AmKeBbTsNXkA0fNw6QAfoTDE/fvgkb?=
 =?us-ascii?Q?oJhtju1VmYMIf1gQS51e4fJK8t93tcjfiy3781P3K8IiywRgqe4ARg936QGX?=
 =?us-ascii?Q?p0GJ53F5dX6UARFlhRKMypdyf23LpJNVkxJA5stchv+jakPXuBDCIjV2GdMV?=
 =?us-ascii?Q?/R8wuuLLOhEDQ9Gg3J64w0arZlnd4fMHHr8ULAkCNYLr/nI+WK8AtmPFzpzH?=
 =?us-ascii?Q?jtUDm2dDGkZia36xUKuGvnCY7HkQp0rSnLzu8hSM7hLXAPU1hrj1y5j4DNZV?=
 =?us-ascii?Q?H5X+MjYn4OUlszJQpTDUI0DdM66YAtwD9B6uw2Ra?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dbaafc-a62b-4d8d-6bbb-08ddc43d9549
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:33.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32sY/DGwmOdV9oNiQflBqXjGQqyFHGKUX88KVmSkDzxHq1LSFROgKxw3m9HzVHZP7PzYrlsDbED5vBW5EefxPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708

NETC Timer has three pulse channels, all of which support periodic pulse
output. Bind the channel to a ALARM register and then sets a future time
into the ALARM register. When the current time is greater than the ALARM
value, the FIPER register will be triggered to count down, and when the
count reaches 0, the pulse will be triggered. The PPS signal is also
implemented in this way. However, for i.MX95, only ALARM1 can be used for
periodic pulse output, and for i.MX943, ALARM1 and ALARM2 can be used for
periodic pulse output, but NETC Timer has three channels, so for i.MX95,
only one channel can work at the same time, and for i.MX943, at most two
channel can work at the same time. Otherwise, if multiple channels share
the same ALARM register, some channel pulses will not meet expectations.
Therefore, the current implementation does not allow multiple channels to
share the same ALARM register at the same time.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 281 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 250 insertions(+), 31 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index e39605c5b73b..289cdd50ae3d 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -55,6 +55,10 @@
 #define NETC_TMR_CUR_TIME_H		0x00f4
 
 #define NETC_TMR_REGS_BAR		0
+#define NETC_GLOBAL_OFFSET		0x10000
+#define NETC_GLOBAL_IPBRR0		0xbf8
+#define  IPBRR0_IP_REV			GENMASK(15, 0)
+#define NETC_REV_4_1			0x0401
 
 #define NETC_TMR_FIPER_NUM		3
 #define NETC_TMR_DEFAULT_PRSC		2
@@ -62,6 +66,7 @@
 #define NETC_TMR_DEFAULT_PPS_CHANNEL	0
 #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
 #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
+#define NETC_TMR_ALARM_NUM		2
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -70,6 +75,19 @@
 
 #define NETC_TMR_SYSCLK_333M		333333333U
 
+enum netc_pp_type {
+	NETC_PP_PPS = 1,
+	NETC_PP_PEROUT,
+};
+
+struct netc_pp {
+	enum netc_pp_type type;
+	bool enabled;
+	int alarm_id;
+	u32 period; /* pulse period, ns */
+	u64 stime; /* start time, ns */
+};
+
 struct netc_timer {
 	void __iomem *base;
 	struct pci_dev *pdev;
@@ -87,7 +105,9 @@ struct netc_timer {
 
 	int irq;
 	u8 pps_channel;
-	bool pps_enabled;
+	u8 fs_alarm_num;
+	u8 fs_alarm_bitmap;
+	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -199,6 +219,7 @@ static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
 static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 				     u32 integral_period)
 {
+	struct netc_pp *pp = &priv->pp[channel];
 	u64 alarm;
 
 	/* Get the alarm value */
@@ -206,7 +227,51 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 	alarm = roundup_u64(alarm, NSEC_PER_SEC);
 	alarm = roundup_u64(alarm, integral_period);
 
-	netc_timer_alarm_write(priv, alarm, 0);
+	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
+}
+
+static void netc_timer_set_perout_alarm(struct netc_timer *priv, int channel,
+					u32 integral_period)
+{
+	u64 cur_time = netc_timer_cur_time_read(priv);
+	struct netc_pp *pp = &priv->pp[channel];
+	u64 alarm, delta, min_time;
+	u32 period = pp->period;
+	u64 stime = pp->stime;
+
+	min_time = cur_time + NSEC_PER_MSEC + period;
+	if (stime < min_time) {
+		delta = min_time - stime;
+		stime += roundup_u64(delta, period);
+	}
+
+	alarm = roundup_u64(stime - period, integral_period);
+	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
+}
+
+static int netc_timer_get_alarm_id(struct netc_timer *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->fs_alarm_num; i++) {
+		if (!(priv->fs_alarm_bitmap & BIT(i))) {
+			priv->fs_alarm_bitmap |= BIT(i);
+			break;
+		}
+	}
+
+	return i;
+}
+
+static u64 netc_timer_get_gclk_period(struct netc_timer *priv)
+{
+	/* TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz.
+	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq.
+	 * TMR_GCLK_period = (NSEC_PER_SEC * oclk_prsc) / clk_freq
+	 */
+
+	return div_u64(mul_u32_u32(NSEC_PER_SEC, priv->oclk_prsc),
+		       priv->clk_freq);
 }
 
 /* Note that users should not use this API to output PPS signal on
@@ -217,20 +282,43 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 static int netc_timer_enable_pps(struct netc_timer *priv,
 				 struct ptp_clock_request *rq, int on)
 {
+	struct device *dev = &priv->pdev->dev;
 	u32 tmr_emask, fiper, fiper_ctrl;
 	u8 channel = priv->pps_channel;
 	unsigned long flags;
+	struct netc_pp *pp;
+	int alarm_id;
+	int err = 0;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
+	pp = &priv->pp[channel];
+	if (pp->type == NETC_PP_PEROUT) {
+		dev_err(dev, "FIPER%u is being used for PEROUT\n", channel);
+		err = -EBUSY;
+		goto unlock_spinlock;
+	}
+
 	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
 	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
 
 	if (on) {
 		u32 integral_period, fiper_pw;
 
-		if (priv->pps_enabled)
+		if (pp->enabled)
+			goto unlock_spinlock;
+
+		alarm_id = netc_timer_get_alarm_id(priv);
+		if (alarm_id == priv->fs_alarm_num) {
+			dev_err(dev, "No available ALARMs\n");
+			err = -EBUSY;
 			goto unlock_spinlock;
+		}
+
+		pp->enabled = true;
+		pp->type = NETC_PP_PPS;
+		pp->alarm_id = alarm_id;
+		pp->period = NSEC_PER_SEC;
 
 		integral_period = netc_timer_get_integral_period(priv);
 		fiper = NSEC_PER_SEC - integral_period;
@@ -238,17 +326,19 @@ static int netc_timer_enable_pps(struct netc_timer *priv,
 		fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
 				FIPER_CTRL_FS_ALARM(channel));
 		fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
+		fiper_ctrl |= alarm_id ? FIPER_CTRL_FS_ALARM(channel) : 0;
 		tmr_emask |= TMR_TEVNET_PPEN(channel);
-		priv->pps_enabled = true;
 		netc_timer_set_pps_alarm(priv, channel, integral_period);
 	} else {
-		if (!priv->pps_enabled)
+		if (!pp->enabled)
 			goto unlock_spinlock;
 
+		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
+		memset(pp, 0, sizeof(*pp));
+
 		fiper = NETC_TMR_DEFAULT_FIPER;
 		tmr_emask &= ~TMR_TEVNET_PPEN(channel);
 		fiper_ctrl |= FIPER_CTRL_DIS(channel);
-		priv->pps_enabled = false;
 	}
 
 	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
@@ -258,38 +348,150 @@ static int netc_timer_enable_pps(struct netc_timer *priv,
 unlock_spinlock:
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	return 0;
+	return err;
 }
 
-static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
+static int net_timer_enable_perout(struct netc_timer *priv,
+				   struct ptp_clock_request *rq, int on)
 {
-	u32 fiper = NETC_TMR_DEFAULT_FIPER;
-	u8 channel = priv->pps_channel;
-	u32 fiper_ctrl;
+	struct device *dev = &priv->pdev->dev;
+	u32 tmr_emask, fiper, fiper_ctrl;
+	u32 channel = rq->perout.index;
+	unsigned long flags;
+	struct netc_pp *pp;
+	int alarm_id;
+	int err = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
 
-	if (!priv->pps_enabled)
-		return;
+	pp = &priv->pp[channel];
+	if (pp->type == NETC_PP_PPS) {
+		dev_err(dev, "FIPER%u is being used for PPS\n", channel);
+		err = -EBUSY;
+		goto unlock_spinlock;
+	}
 
+	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
 	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-	fiper_ctrl |= FIPER_CTRL_DIS(channel);
+	if (on) {
+		u64 period_ns, gclk_period, max_period, min_period;
+		struct timespec64 period, stime;
+		u32 integral_period, fiper_pw;
+
+		period.tv_sec = rq->perout.period.sec;
+		period.tv_nsec = rq->perout.period.nsec;
+		period_ns = timespec64_to_ns(&period);
+
+		integral_period = netc_timer_get_integral_period(priv);
+		max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
+		gclk_period = netc_timer_get_gclk_period(priv);
+		min_period = gclk_period * 4 + integral_period;
+		if (period_ns > max_period || period_ns < min_period) {
+			dev_err(dev, "The period range is %llu ~ %llu\n",
+				min_period, max_period);
+			err = -EINVAL;
+			goto unlock_spinlock;
+		}
+
+		stime.tv_sec = rq->perout.start.sec;
+		stime.tv_nsec = rq->perout.start.nsec;
+
+		tmr_emask |= TMR_TEVNET_PPEN(channel);
+
+		/* Set to desired FIPER interval in ns - TCLK_PERIOD */
+		fiper = period_ns - integral_period;
+		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
+
+		if (pp->enabled) {
+			alarm_id = pp->alarm_id;
+		} else {
+			alarm_id = netc_timer_get_alarm_id(priv);
+			if (alarm_id == priv->fs_alarm_num) {
+				dev_err(dev, "No available ALARMs\n");
+				err = -EBUSY;
+				goto unlock_spinlock;
+			}
+
+			pp->type = NETC_PP_PEROUT;
+			pp->enabled = true;
+			pp->alarm_id = alarm_id;
+		}
+
+		pp->stime = timespec64_to_ns(&stime);
+		pp->period = period_ns;
+
+		fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
+				FIPER_CTRL_FS_ALARM(channel));
+		fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
+		fiper_ctrl |= alarm_id ? FIPER_CTRL_FS_ALARM(channel) : 0;
+
+		netc_timer_set_perout_alarm(priv, channel, integral_period);
+	} else {
+		if (!pp->enabled)
+			goto unlock_spinlock;
+
+		tmr_emask &= ~TMR_TEVNET_PPEN(channel);
+		fiper = NETC_TMR_DEFAULT_FIPER;
+		fiper_ctrl |= FIPER_CTRL_DIS(channel);
+
+		alarm_id = pp->alarm_id;
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, alarm_id);
+		priv->fs_alarm_bitmap &= ~BIT(alarm_id);
+		memset(pp, 0, sizeof(*pp));
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
 	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+
+unlock_spinlock:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return err;
 }
 
-static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
+static void netc_timer_disable_fiper(struct netc_timer *priv)
 {
-	u32 fiper_ctrl, integral_period, fiper;
-	u8 channel = priv->pps_channel;
+	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	int i;
 
-	if (!priv->pps_enabled)
-		return;
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		struct netc_pp *pp = &priv->pp[i];
+
+		if (!pp->enabled)
+			continue;
+
+		fiper_ctrl |= FIPER_CTRL_DIS(i);
+		netc_timer_wr(priv, NETC_TMR_FIPER(i), NETC_TMR_DEFAULT_FIPER);
+	}
+
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static void netc_timer_enable_fiper(struct netc_timer *priv)
+{
+	u32 integral_period = netc_timer_get_integral_period(priv);
+	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	int i;
+
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		struct netc_pp *pp = &priv->pp[i];
+		u32 fiper;
+
+		if (!pp->enabled)
+			continue;
+
+		fiper_ctrl &= ~FIPER_CTRL_DIS(i);
+
+		if (pp->type == NETC_PP_PPS)
+			netc_timer_set_pps_alarm(priv, i, integral_period);
+		else if (pp->type == NETC_PP_PEROUT)
+			netc_timer_set_perout_alarm(priv, i, integral_period);
+
+		fiper = pp->period - integral_period;
+		netc_timer_wr(priv, NETC_TMR_FIPER(i), fiper);
+	}
 
-	integral_period = netc_timer_get_integral_period(priv);
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-	fiper_ctrl &= ~FIPER_CTRL_DIS(channel);
-	fiper = NSEC_PER_SEC - integral_period;
-	netc_timer_set_pps_alarm(priv, channel, integral_period);
-	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
 }
 
@@ -301,6 +503,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
 	switch (rq->type) {
 	case PTP_CLK_REQ_PPS:
 		return netc_timer_enable_pps(priv, rq, on);
+	case PTP_CLK_REQ_PEROUT:
+		return net_timer_enable_perout(priv, rq, on);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -319,9 +523,9 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
 				    TMR_CTRL_TCLK_PERIOD);
 	if (tmr_ctrl != old_tmr_ctrl) {
-		netc_timer_disable_pps_fiper(priv);
+		netc_timer_disable_fiper(priv);
 		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
-		netc_timer_enable_pps_fiper(priv);
+		netc_timer_enable_fiper(priv);
 	}
 
 	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
@@ -348,7 +552,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	netc_timer_disable_pps_fiper(priv);
+	netc_timer_disable_fiper(priv);
 
 	tmr_off = netc_timer_offset_read(priv);
 	if (delta < 0 && tmr_off < abs(delta)) {
@@ -364,7 +568,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 		netc_timer_offset_write(priv, tmr_off);
 	}
 
-	netc_timer_enable_pps_fiper(priv);
+	netc_timer_enable_fiper(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -401,10 +605,10 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	netc_timer_disable_pps_fiper(priv);
+	netc_timer_disable_fiper(priv);
 	netc_timer_offset_write(priv, 0);
 	netc_timer_cnt_write(priv, ns);
-	netc_timer_enable_pps_fiper(priv);
+	netc_timer_enable_fiper(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -433,6 +637,7 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.n_alarm	= 2,
 	.n_pins		= 0,
 	.pps		= 1,
+	.n_per_out	= 3,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
@@ -659,6 +864,15 @@ static void netc_timer_free_msix_irq(struct netc_timer *priv)
 	pci_free_irq_vectors(pdev);
 }
 
+static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
+{
+	u32 val;
+
+	val = netc_timer_rd(priv, NETC_GLOBAL_OFFSET + NETC_GLOBAL_IPBRR0);
+
+	return val & IPBRR0_IP_REV;
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -689,6 +903,11 @@ static int netc_timer_probe(struct pci_dev *pdev,
 		goto timer_pci_remove;
 	}
 
+	if (netc_timer_get_global_ip_rev(priv) == NETC_REV_4_1)
+		priv->fs_alarm_num = 1;
+	else
+		priv->fs_alarm_num = NETC_TMR_ALARM_NUM;
+
 	err = netc_timer_init_msix_irq(priv);
 	if (err)
 		goto disable_clk;
-- 
2.34.1


