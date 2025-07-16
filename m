Return-Path: <netdev+bounces-207397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35677B06FA2
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA761AA22AD
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B82E9739;
	Wed, 16 Jul 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="homMKht+"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC04296152;
	Wed, 16 Jul 2025 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652344; cv=fail; b=Cn1y28k7Jp3pFFSvE4csOxemeS8zVxQx6MnooD9X+QArYHIn0h9eCIrHLcMIp7OVQNLJ7wUqhYv3IYawsldN0qOO0QN95ZcSVdVqCLVaVovfyoahJsM0iNVLetY/ULOGg4KP+PF/rcRLftpcLVxra7jaw8/HTlpG1l7d5POUmAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652344; c=relaxed/simple;
	bh=jutYRWMCKy6fbvKEtKv10TU+HpvT4lQ3MWg02jD6a6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQt1tg1A98h0R5fskHHu3i0CttGAW7FJQRI0mbQ1k6xzU2VVfzroes7iVcRlbEQcnXSeedtJJGGVsth3DZl9iHCRQ8xyekWzBMcuJXCF8H7ZloSyLq1I1LW9GGL9BBgj8yObko6wsQYHdc1bySeydWF133srH4tFfN3SBZuhePs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=homMKht+; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQUC7ukESOagZm6dz3YMmQEyHLpG0o1bClIlMRWVHbAmrZl+7ZStWK59b2bgcG/LOQNwzn0a+GAlLfbHbZGKBlgJ0rOYV3lBcSKSuWCy4TTlA8iO+NseIFP6XWzRn0ESRU/0MOOp4eS7NByUE1Cbfnd1H3uX23IZOE2RDK1eZ9VAekWRGOWdxKXOzNrqt760pUCFiAYkmsDO7Z9YHQf5mrX8U7l0m+5eas6sHjIMqVVMOPFxB6vFOYPIcotr/Oh6wqYnLCFFdsmwt0emKZ61eHEYrcAUQbZOnQdBxNjKEl4408X5GYfdit0h63AvXJOF/GSNitJNmr4fkkLfiiMVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwD3AsGou/jyf0y1fv7qP3lFXj4cgpUcqTO48Dakq08=;
 b=Me4/L+3ArUYkgp4Ap3b7PoN4oxjy+SOJ/wES0AzUoH0kDue7vZXuY477qmsL/lVI0zxcPeEchdOdV5um7meUk+4vDjK0cR1Vm0r+coGwpfGJlkRlaW+YmnaF1ILevk2DaHe7GXZGi6DUilwkKsZdLBSAWMqvYx5UrMno24fjykBbdVtxZamY/l80s5ThwqoIlvT6Y2DCSXv364/vJzeeUBNOZVW5bYO8RlJoRQbAg2KDEggv+9EwiCs9EE52rYw0xJxCPYVGP7K3C0NnbH/IBmV9CADJ+Nuaw5yM0NsiI231BXuESchazEM3dGRzbWM4mFxqhwpOADNDNlY7hZkSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwD3AsGou/jyf0y1fv7qP3lFXj4cgpUcqTO48Dakq08=;
 b=homMKht+Fe5HDFipaucrqGCkNnqPB2tn/86WWLrAkZ68+DSHQwKMa5jsSLaFCryKAqThSdjae5Hw++JaLy3h2YiCfSdWq6DqCvrhPBu98XnBb4glFXCirRdMB+70XWS8mjw2OcAwhiKQjBIOcle5x4traLdHNRPSmz5u1w4liCdMuUvsMx+tz0M/CrKYbidCTJaT057GUEz6QBzk1C1/ywfzIxAtsvn6P40YP1z66183XLVzeHDmwN+n3BdR2BttgLlSceEMPO16hHzEwJVeIct5ah9JTLDCVOVbvMmIPJcKJzSFNcP4FKV5MjfWo3qnBuRicTxtt8R0p0+xdy+XyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7709.eurprd04.prod.outlook.com (2603:10a6:102:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:52:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:52:19 +0000
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
Subject: [PATCH v2 net-next 11/14] net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
Date: Wed, 16 Jul 2025 15:31:08 +0800
Message-Id: <20250716073111.367382-12-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3b481e-f712-4c6e-6f3e-08ddc43db0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CpaKt+1cCr+pRtAK0FyIFnULD+QcOrB6PxnUNMYsgSOmhe51g0Yt2Q11Y/4R?=
 =?us-ascii?Q?NMHIhJcoWQu1V8M1El3rnUgUusTbzJJD/dTH24wDEcvz9IntWzgUFCG9SWic?=
 =?us-ascii?Q?hUa0Pxp9bmzaso1HBDuySlj5Pe8GCF56XrbHa2eZavZx/FryO3VoA4mjrHBF?=
 =?us-ascii?Q?oC7evVKw2OlbltQo68vsTcs3mLEbQZeFPHvCDqAXfh6okYb2Vui8otXj+4qm?=
 =?us-ascii?Q?4YuF7SrsTArOBCbmzQvBZqi5kEWuSJtdLpghn0d8zjVg2H/XYT87r42gXobW?=
 =?us-ascii?Q?E0mF/6jDmu0G1om28jV6jsqNPKu9+dSNcyDlcQhieRp3xhRHAhndEwFpHiKg?=
 =?us-ascii?Q?7uYKSOvT4P0rvSeZ7khL7Nb91DjJrPqH8IeXN1wNSpUyOUtpRGgPUh1xStU0?=
 =?us-ascii?Q?8T6YMXGzY3ANJd7kOsBGUy2rdD3NSkH3X+8YrTQ96xQ/rx6rcHS2aQg0rsG5?=
 =?us-ascii?Q?5TaYj2zOV7y6bJ4pRtpbqJkJYksNt8aiLfq+if4ck2/lGJiF350m4cKk/ZNw?=
 =?us-ascii?Q?Zg4wycwaHMdLsDjOKPSdvQqefQtUfSt8D5ABKGyRIuBhdEDb7cP3epoOa41j?=
 =?us-ascii?Q?49WBW952tVR8gTK89zYiwF7P3XMdjuKB2gpsypnum7FsocvPtWwb+FCH9bYY?=
 =?us-ascii?Q?sl/STlal6dP1h/e6AWuZopY+ExbgBF974SohOU4V2L/knSiCRymLoXPVEcnk?=
 =?us-ascii?Q?XykrW3OlGTfRwb4x/s5ASihi70FG4qkjNB2anjQZFoX60idHL0PfpdwD1Ko1?=
 =?us-ascii?Q?40icI/HWnzqssh8EZh+bLRGrd8Hm7IOfh2JXzr9IEaVyDBsUfoWOk1pO/NZJ?=
 =?us-ascii?Q?W77ypbhwhFhiUeGwIRQGGftT7nxQjJRRxdSJ5onmaDk2IecR5kB68d1Kqp/A?=
 =?us-ascii?Q?d86TaHk284eL4KviEDQaPJpvlhs543A6ZAyCAN8qi5S32/0EtLYn/xChqf90?=
 =?us-ascii?Q?4zfZVbXYPkjzzVIoHFV19Fu05OmBGlq7IFcKnaSUG1AoU5wdqXzkxn1k3stC?=
 =?us-ascii?Q?a6+Y4y9km23uV/tiNej9xhkPC6BESwcvmNYaCi3ckgMm3Il4pnrMq93I4aY6?=
 =?us-ascii?Q?fB9YMAbWJDnVknlDv/v1L6RuwrnGXFyk//cBFxwKu7FfnIF2rDbWwl3ucvn0?=
 =?us-ascii?Q?wL4SjQKAgqh8GUlgqQQf8LyBt2OdMQOn3G2DCgPRNZDxang+jHNLIRsnuAXw?=
 =?us-ascii?Q?SRt/kBJpKKgm8qgqaV8WOWOpeUiaNLH5+SBQZ5DRZuYHu1hWRnSMKyMrHHyh?=
 =?us-ascii?Q?OFblWDydMSvP2FE2xNBI9dWnx+u6u/IQ19oDn4qvXFL6OwgSpz0k8FgE0Qzm?=
 =?us-ascii?Q?rogQTBAs62SCABJRs7hnv+Xer6yTzr91wLX8n6ZHtMyvNOPlZQbbvRP1viqg?=
 =?us-ascii?Q?s/h5tOq+PtpLwA7/ngmMn5w4JD7CbhnipAkW1zW0mol75OtcXlLXSMhbHtOn?=
 =?us-ascii?Q?pgDfIkqVRBwC/e8oHF4lbdxk4Jx1yb0kWaQuGPlhDAzMEq297nHNSOSrAwqr?=
 =?us-ascii?Q?szToxgI4P7l9BEk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yz1ASy90fost1OFH5V5vujnrHvogx1IK/gH861A5myzADqoeGzJKRhHZW42x?=
 =?us-ascii?Q?IEIPW0IgshnYHivnUO6hiTzaj3DAlzuupFoanMMXOfQL3VZ2vZRN96CyMIpY?=
 =?us-ascii?Q?fOsgioZHftR89NtkNaNRHQvjIuJHguZiyqWxTDHR6cE6wXzfKeF8XVnSKEGe?=
 =?us-ascii?Q?PM67LJi4AmDM8KOcM+VOfmN3hieo0ZecY8lZcB//Vi9FrXxRTjNKGDNlkwX+?=
 =?us-ascii?Q?rgzmeuDRCf1eCQIRL9VAAy61j9ZJteNbzv92QotnrfH/RZxVUBJYZe2PnxkJ?=
 =?us-ascii?Q?erYju9lA3iSFv6bBqdzLtC6liHM0Vka2mAqfzQqdYMhVKCpvqK25o3RwmXnj?=
 =?us-ascii?Q?EJlGlC3vUddoQiEUfp+sbl/vMcxNdo4ip31ALQhvUPRq7JCppRN+ZVp13y2e?=
 =?us-ascii?Q?Ff2ZViy5gHLi4O6gzfPpAOAFIm+vMWdem6s1sgW2qE6MKpOlbHWArLA8wd1J?=
 =?us-ascii?Q?Bt+RB5NyAFD/Qd9413LfVxg5uQ2gWgFA6gVCouUeugjrk3xk1ca/jQ6RM/ve?=
 =?us-ascii?Q?RivQWD0c7gOXS0vH1YgT24aPcOEVtKBVU0YSUl6ru+ZAiNJIpDeWSZHksHRL?=
 =?us-ascii?Q?RJcPTK4A5Z6qtqmDD+XDDU/lCPlxdZUpkE12GgTTKP4OZFTe33Nsqk7IOWFJ?=
 =?us-ascii?Q?xmYAME4tR9FSN4nVBOeortH1GYQBYKXgMpKNOCPyL9MkmkRkYVPzMLyRXYLz?=
 =?us-ascii?Q?4RmpeYvhUhV/de4IbY9Vr9Ywq4h/hvX9z9UlpfvifPAzfslCg9OaXItVSx09?=
 =?us-ascii?Q?rhZfcKAnG5tRxv+lXdeF7GjiRg3DQbB/WvpdVhK8NiQ1G0+Ms13+AThuidJ/?=
 =?us-ascii?Q?9YH26sQmqAfyOxpeTxUP6bKaTAeajt4Oh8yUcmfvmzTWziZuG4bMHBbaDnHf?=
 =?us-ascii?Q?BC/khdSXDqsZfGLGKHpKEy+Dizw8Z39XOugi1wDPS8Fs/a1HYD+gWO34A62A?=
 =?us-ascii?Q?ZbJk0UWjIbsQgM0e5XquXFR816zZAi4j/2OTyQ/d4tXGNbkoMCSJwkUkynBh?=
 =?us-ascii?Q?mYSXbUCsOu4a4fWcmfV5cMNKNcalFRKqaUvRl/0tssJwRynk8FRWfsIW0O6y?=
 =?us-ascii?Q?4FJnD/xQIQtKys6KzUQ9rIwu0G4mHZVeB99s2zw3ijBKoHPNvwXqwTh+JFBS?=
 =?us-ascii?Q?9tedyb96JaivU1rjnVQF4UBCjBKFIjyxPTHaCDHWjjzvybnPMT1xBCUyqYJY?=
 =?us-ascii?Q?nzJX7E4ZzIygk5/c+YRCzg2gTqNbY7MQTOWyFaMWY6mjrVWdbya2E8dYK7cK?=
 =?us-ascii?Q?Kd6aJZQmxnWuHYr2UW5u/eJ8EnVwud9q/q63oFneLzIhx9DL6AFFeycGy9FI?=
 =?us-ascii?Q?pxzWEsY/ny+qycSkOAV3XZBZZtekQ83+vYTLOIJH3v8IEQtiphtFgoyDH6PR?=
 =?us-ascii?Q?83L3H/WwE4A6aYG04Q1W4hlViC5bU5wXU+TOveHB29PxVzaB0BJciA7AlkQH?=
 =?us-ascii?Q?H/jip/xuQJI5cggGcDjI3Kyqbj5tqNYQhLuvlI/Wt89KKUmj0Ox5/kRIzRjM?=
 =?us-ascii?Q?K8jLjNTav3yNGQhlTeYdXCGhjKwJTRNb/EsWUle2frgvazI/bBKkyq0nXwgP?=
 =?us-ascii?Q?pGypXMzBCs5SOE9FvjiDZfMjmqs1wTV3TFwgYFT/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3b481e-f712-4c6e-6f3e-08ddc43db0cf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:52:19.7376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xenm/l/PZ5KTgxd8HGGM//aTTshP7a4Mg1Or23h8LfIphYNbujsRwBEFcasCVPlhyFozVvkOh7XcLG1gW09sVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7709

The ENETC_F_RX_TSTAMP flag of priv->active_offloads can only be set when
CONFIG_FSL_ENETC_PTP_CLOCK is enabled. Similarly, rx_ring->ext_en can
only be set when CONFIG_FSL_ENETC_PTP_CLOCK is enabled as well. So it is
safe to remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 +--
 drivers/net/ethernet/freescale/enetc/enetc.h | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index ef002ed2fdb9..4325eb3d9481 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1411,8 +1411,7 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
 	}
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) &&
-	    (priv->active_offloads & ENETC_F_RX_TSTAMP))
+	if (priv->active_offloads & ENETC_F_RX_TSTAMP)
 		enetc_get_rx_tstamp(rx_ring->ndev, rxbd, skb);
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index ce3fed95091b..c65aa7b88122 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -226,7 +226,7 @@ static inline union enetc_rx_bd *enetc_rxbd(struct enetc_bdr *rx_ring, int i)
 {
 	int hw_idx = i;
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
+	if (rx_ring->ext_en)
 		hw_idx = 2 * i;
 
 	return &(((union enetc_rx_bd *)rx_ring->bd_base)[hw_idx]);
@@ -240,7 +240,7 @@ static inline void enetc_rxbd_next(struct enetc_bdr *rx_ring,
 
 	new_rxbd++;
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
+	if (rx_ring->ext_en)
 		new_rxbd++;
 
 	if (unlikely(++new_index == rx_ring->bd_count)) {
-- 
2.34.1


