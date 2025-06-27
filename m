Return-Path: <netdev+bounces-201730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26F2AEAC89
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 04:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4FC562381
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF101A23B5;
	Fri, 27 Jun 2025 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UPHMuq10"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC21A08A4;
	Fri, 27 Jun 2025 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750990137; cv=fail; b=nob0UX5xraMalpJVw2FV5bKMNsFJ/xkZrq47JntEXoiBpx9adWNOrA0fknZ9/L9G9Y4QcbJH530Z5ehfAJSiuwbiiJCx0YTXi35nKNEINpyHIafl3aozlX7TnYsFZ6+yPFDDsV85y2DKtJfWdOGFsZpeK5UWWXWAZUV/nxf5v5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750990137; c=relaxed/simple;
	bh=4nHJdHRPcOYE2117p1MhYUoYi2kP7IwZ3yXTQo9vWxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XN+ZsISTg5nfwBmBIEntRl4CovpP6fXNfhC9QhHSedQR3ziCM94dxgjTVAPngv6JreZOaRHZJtkV2VHIKHrXeKOVXLP+g2UsKNiafNm/dKGyWaL7YkjSGr+gSiidTDFuN8QhPdz9+Bbsev3WonUaagx/S1/X/fdCrJd+qzWKTtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UPHMuq10; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRxp5l5+YTyyPWr+6+ccucinFM8DAMl+xK5UoOQ6Od7uRGxEZBLH5QOZOuFoCLwTjreRNzMWSI/Y5QDAe9MInAOm6aWnbFdtTcHZ//921l6hNwp7cD68HqHGp4A+9sahiYY704T5kjI8tzGBc2KsxIrgiEiBTJdvH61t7wMANmW1niP2KxwuBz7Ru8inEMIhItlOrW3Ffj/OVDL4MNR8EZu7i2T86peEvAaj7m0m0WLPIl7O/6bJmK0CH/8GZmJJiXZiiEFHMakTX3d9oB/TTbOvtATBFlW6Gy3sY7KYi8DCFFraH5N84808l6xDECnzQt6FPjepx3Z0CTwJBQWF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XYCmwFcTfhB8EbEFaK7RT9Uox6rhkFW9xaa+1kCeb4=;
 b=FQRP60Ey/3qJTG++Wa5pVRLnTB3Vp+eZQnm+ffF/jHrYkBXLwk5HK3BjlgBFNj1vKbUL44HczOSV+L/K87VPFmQ3YELlrZtGr7oGCNIPOttj9mnGnytKH/RaGcx8Hwv7RRAjOmCEMbAJyJtG2uoDwztPJ3vlHsL8hsBRo0qJwIBvvRBdsQMjVwkxkLyufd7oITscYF3RyKkfd0bFoMuekc4Q9BuF8rwUmVk3htJvAmix7wRtL2eOfAT9NECCeuMofR1o0rLm+WQIlnkwD3MDK+HhPeSB8iswJkTqZBbV+CyF8z7tmkw7By/mTaJ3h/7tMUkSrqjkuEEnkSi3NC00RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XYCmwFcTfhB8EbEFaK7RT9Uox6rhkFW9xaa+1kCeb4=;
 b=UPHMuq103GbboUUPpEJDwhcVMKlPA0+j5+BeywfuEfNyu9df4Zyr/spC33xrX52KGyAfAAzRK650FA7qGf3eXAHVBZJDgVMSlWSP48AUOVfGnp8vqRr8Z2vJY2N82d83s0ocjK1ICso0fTbwesPdNIUWVwukeB/8llO/hUv4DrzhJdWAVDpySaDbSb59lukelUShqX+BhrQixHYYUDt3fb3UT6xBU11N7tRFjJOgKSbQ7U3xDpKLic0DWj3cQ8af/92y2pIxQ3w+cosB3+KT0OcSB+q5LHq9Dcpg8GHYdPoXEhU3hlJEMFdygzPR+c6cB2J8yu7rb8OwwmKGQrFSNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8377.eurprd04.prod.outlook.com (2603:10a6:10:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 02:08:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 02:08:53 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 RESEND 3/3] net: enetc: read 64-bit statistics from port MAC counters
Date: Fri, 27 Jun 2025 10:11:08 +0800
Message-Id: <20250627021108.3359642-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627021108.3359642-1-wei.fang@nxp.com>
References: <20250627021108.3359642-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 1841efbc-b254-4314-2b01-08ddb51f9085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IfaPloRLvZ1gPQSz7SrlmCGqu2iGvH3bU72NY1Rm1IZ0R6hFRAaNjDY5A1+l?=
 =?us-ascii?Q?kPcXm3U2+MYtYmnd6XhJfo0ujhAI77RTFBJWjrdbnsms5qyWmLVDXjpGGUcZ?=
 =?us-ascii?Q?VA+GSBAkiUzZEurjQgVKU1b7rykQWbTh6XTySV7A9Z9tJ/tx+f4NbmaLq91z?=
 =?us-ascii?Q?5KVB0MavWsEQ8zeBOtzJ8bzrCFNyWUYzWB9CtNQBO1+YXo+ddwiAf7Xokxta?=
 =?us-ascii?Q?zNwbMapjyS3xErhutrEMqf/avTtj5Q5tUw79Kw2Th2R3F9UutZNQZOGqT2Gc?=
 =?us-ascii?Q?tmMip9xIc+4qRVGZDZIw/zSRd4loRqk26KPSjWbzJexUOSuSzWVAUrGC27Qa?=
 =?us-ascii?Q?c7waGDcjLaRJy0rYofOFnMiHCDh9A1yrddC3yAiQSG7n5wkGCtmXbHtDq+rE?=
 =?us-ascii?Q?/9lk0vjBu0P2IZah/nS0jSe82Xnom6kWgNZk6vCncGZlYnxCGpFoXHxgholk?=
 =?us-ascii?Q?kiH0ujbE0T84aZSvLxMToy8+x9fzDBSpncS0WcqqNM331iJvYLigFj4H3Gbv?=
 =?us-ascii?Q?MhaRvMjOpFGBXNDwqrMAFnk6ZbTCHgIsdLi1sLuCLobEQiZ63hI6+wNmsukG?=
 =?us-ascii?Q?Fe8JnNsiP96Al1C6NMoKRd1XKNtufNNILF8mMxZLOXbKUa4xQs1iyTSdmvAJ?=
 =?us-ascii?Q?d8+AeqRPJYQqOsCi8zc9WPfb4DYPwWsoqfZAxRQHOA16awKA6WaT8FDSkOft?=
 =?us-ascii?Q?Dp/J2cwSC3K+V9ZSdNO+K/7NOqXQ5Wd5ykrEVFXcBAi/dR6HnK7iL/v3+w+c?=
 =?us-ascii?Q?Avg/J3xu9GO344HOf1nMHjmkTRGzP0Rnoa3Kw+wEIrqI8QhN1gmzUbQ1OuY7?=
 =?us-ascii?Q?Ze3kY6qISHflc67kSf0WqoplhTNcy63dlx3k7EjUq+quJniQBVAy/JJwdGXG?=
 =?us-ascii?Q?yqZZvn5ajnt6qDwc/VNDKGbswqXWgtWbC7mm7njCFgW8VKW4vcS4kII9dNGh?=
 =?us-ascii?Q?4gS/hyDQT/VQIB8vY0T5msWjUuT/zFFboUqnxmV/c0R3XN6t0dEOAvVwNTct?=
 =?us-ascii?Q?z0qyhedwyzS6laRZnwCbJyRA10p8NsyCfw/u0Qai4YZDIyif2PWRjOot51GR?=
 =?us-ascii?Q?7/DWTOC8zMWEy42RvmUlbcteE8fIBkt48DLpnXlG1enIFqwp4+xNnPKYnXun?=
 =?us-ascii?Q?34Bey6lU0ESABNTu2bnUIcQZZ6zTwUF4aI/gKxkSSM6JYW8Av6I3dQi8aIlf?=
 =?us-ascii?Q?FPWXZeBd9PySAvFimAdM7h+612BvWvEsRnT0/JNHmEO9UQMvDPqLwJNdOGPE?=
 =?us-ascii?Q?EexVG9bsWVNf+PRq8u+9t+Y2CMp5nxqrG6jKevzDFRdGuP1tHrJ4FEhPDi78?=
 =?us-ascii?Q?199m9nG23HcW2c21lv2ubzzBA4OFXoWCb4ZfLlAlzlE+UvshfXwi5m8kpegZ?=
 =?us-ascii?Q?uFmqnvsZycoK+cDBu7gL6vFZ8IL8oNf1SIz59xR92I6HFVdzO/bIRaVQYbSs?=
 =?us-ascii?Q?kIWh0RZGzF9BuNYqBBvJEyGFfVwHljzsZ88TEna+EusBYy/qy58Gv4U3v78L?=
 =?us-ascii?Q?K0kV5rkodm/DvTo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i6VuLbcdYpBMl9gv9VwbJFQ903FJQStfcs4tVxMEbTf3ieh4TTSqd4TXSa8A?=
 =?us-ascii?Q?/b58RFVnSTvZ+nB2nKJTxTRQIMpyHgoNcX4I7F94wno/XPI4lNH9pXaA6lbg?=
 =?us-ascii?Q?ke1itvWS5+j4joPoMiavSEB4CK2uvaLpc2KWM0pjd3s7FsaFwQ4zNHql7y24?=
 =?us-ascii?Q?MPwQ6BpO+w5BxbLkjhzpqXG8lJibKTIsesshx6idFj6mJC9AzbKX3FdSr1Zj?=
 =?us-ascii?Q?8pOoyjEt/SmrMV6i+61rdgKtniFqwCTVuSiyWs+rPL5bYB9X6FdCQ13wEH22?=
 =?us-ascii?Q?O3ws8lLeNllpecyWDWwEzG17yfrVvJDsXjBeVeJLNPbVmRv4ZyT+XBrdm317?=
 =?us-ascii?Q?yi4yCKSMBa7+dc6l3Q9p9R+/o1QK0aoslEydJJMdqAv5etBg5Dn/Aqrv5PZP?=
 =?us-ascii?Q?QtkekcYZM9RQ08sYK5002HNROWe3I/POZnbKhI0yFXHMZiHs8M8F6zJBq+Gz?=
 =?us-ascii?Q?RnLxZS7TghTMIkl7SBaPm+6NGsJbNJShFNe1wn1iOau83czj32nVhPB6Gp5K?=
 =?us-ascii?Q?Y/Nde2vpJqN5GN4UbIa2vqW/WeIH7mshWNzUSfTZp+fR8Yi5ZVq2L9bp6nNB?=
 =?us-ascii?Q?2OdxCRaTiJbrV9zx2t/p7RAceK0bGc7tP0qZ6Bz4pR420lQISJKC5t5LTQLX?=
 =?us-ascii?Q?xpqnxOs6s+wEO693gCxV7LVSxuUXbEWfO6RVXz+BZy/nn753GlLLmiXkdYLT?=
 =?us-ascii?Q?3w2kyxnwS0ZFcQeEFsDQYjLTQQDJkC57UA9SoQaRsJ9Hod8WGo+Mh7RWl5pi?=
 =?us-ascii?Q?f9ISmLYDcqpZf9QxTEuFUpi3dq/jhxzmQpWoFC/K4sgLWjFe9wt31z2uVPhj?=
 =?us-ascii?Q?Yd/KR0Xd6/VAavjN5Q0j9T9r29cBD8ZOk+wQXYB4Ox0XZ6cpl2QQrEH5Xsjn?=
 =?us-ascii?Q?IBDsP9BL33ym7nuVrxN+Ai6eHT1o6NlsP6Yg1OVaK/M3garFppkcwF6UgsRu?=
 =?us-ascii?Q?pgGH0/tBA2miA80GwrE9mmNtzbV9bXapAdQmxjCoUKWhkYddOhKHZOk0DbsB?=
 =?us-ascii?Q?9go7oNjqMnjOfR6hG83mvRJgrjhRQ++N8oK7MCfjygRTUU07cGm3HPvzIvp8?=
 =?us-ascii?Q?xxpl8DAh3wf3cU3kBoKCwfJEjTL3e/68iMY89YrtK6drGUrpPmHyH6UKNioE?=
 =?us-ascii?Q?wlGavM1P3sEKVkn1er+2APOV49fpsyK0CiQBAJni2P8PPK+m3Q87W2zGUrEg?=
 =?us-ascii?Q?j2WqjMc5FEMEwuS0ZGF8RURIWIHgDNZZyz3RMcAkD3yF+W2juychWNd1tZen?=
 =?us-ascii?Q?kQDcRWX6NeMN4wBaAmpJJsOQ2zmYgS6FZH7ig+qCdT/JCtUGwLnVhgj8qXWC?=
 =?us-ascii?Q?0Z7FB4pZgsLzrJ/OqqAaMjHbjpGch+LQMZ/D+GuLaZsagT2+yvr1XhYh5s49?=
 =?us-ascii?Q?cGzilmHIC0tgUOuoyDdlv2C7eySKpoMb7xZZwG4CnWl+SFFZ0mIpW00nP1fY?=
 =?us-ascii?Q?+XYg8drugQ2gUtQw39PtEcqJS0Ue+pz6Yj6eFgjQjhhNZXnmqQ92bOd+sPqU?=
 =?us-ascii?Q?VRpBjVRJjx66CeDEW5vH2MsvYx8k24lW9nfu7TnKMkb5YoJEERTWiGynmi8W?=
 =?us-ascii?Q?ZWtv5FiC7zOo2JMnsa7PcEoSIeNu2hZkW4jFOtl6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1841efbc-b254-4314-2b01-08ddb51f9085
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 02:08:53.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DVeLEv8rjRIhwc8vPwdslv6307cORrgXZ6YSnp8+ljccrx0cCM1dHs6p+hXdE2Z2G5x2vwakkGtdLXFIgiysw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8377

The counters of port MAC are all 64-bit registers, and the statistics of
ethtool are u64 type, so replace enetc_port_rd() with enetc_port_rd64()
to read 64-bit statistics.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 84 +++++++++----------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 2c9aa94c8e3d..961e76cd8489 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -320,8 +320,8 @@ static void enetc_get_ethtool_stats(struct net_device *ndev,
 static void enetc_pause_stats(struct enetc_hw *hw, int mac,
 			      struct ethtool_pause_stats *pause_stats)
 {
-	pause_stats->tx_pause_frames = enetc_port_rd(hw, ENETC_PM_TXPF(mac));
-	pause_stats->rx_pause_frames = enetc_port_rd(hw, ENETC_PM_RXPF(mac));
+	pause_stats->tx_pause_frames = enetc_port_rd64(hw, ENETC_PM_TXPF(mac));
+	pause_stats->rx_pause_frames = enetc_port_rd64(hw, ENETC_PM_RXPF(mac));
 }
 
 static void enetc_get_pause_stats(struct net_device *ndev,
@@ -348,31 +348,31 @@ static void enetc_get_pause_stats(struct net_device *ndev,
 static void enetc_mac_stats(struct enetc_hw *hw, int mac,
 			    struct ethtool_eth_mac_stats *s)
 {
-	s->FramesTransmittedOK = enetc_port_rd(hw, ENETC_PM_TFRM(mac));
-	s->SingleCollisionFrames = enetc_port_rd(hw, ENETC_PM_TSCOL(mac));
-	s->MultipleCollisionFrames = enetc_port_rd(hw, ENETC_PM_TMCOL(mac));
-	s->FramesReceivedOK = enetc_port_rd(hw, ENETC_PM_RFRM(mac));
-	s->FrameCheckSequenceErrors = enetc_port_rd(hw, ENETC_PM_RFCS(mac));
-	s->AlignmentErrors = enetc_port_rd(hw, ENETC_PM_RALN(mac));
-	s->OctetsTransmittedOK = enetc_port_rd(hw, ENETC_PM_TEOCT(mac));
-	s->FramesWithDeferredXmissions = enetc_port_rd(hw, ENETC_PM_TDFR(mac));
-	s->LateCollisions = enetc_port_rd(hw, ENETC_PM_TLCOL(mac));
-	s->FramesAbortedDueToXSColls = enetc_port_rd(hw, ENETC_PM_TECOL(mac));
-	s->FramesLostDueToIntMACXmitError = enetc_port_rd(hw, ENETC_PM_TERR(mac));
-	s->CarrierSenseErrors = enetc_port_rd(hw, ENETC_PM_TCRSE(mac));
-	s->OctetsReceivedOK = enetc_port_rd(hw, ENETC_PM_REOCT(mac));
-	s->FramesLostDueToIntMACRcvError = enetc_port_rd(hw, ENETC_PM_RDRNTP(mac));
-	s->MulticastFramesXmittedOK = enetc_port_rd(hw, ENETC_PM_TMCA(mac));
-	s->BroadcastFramesXmittedOK = enetc_port_rd(hw, ENETC_PM_TBCA(mac));
-	s->MulticastFramesReceivedOK = enetc_port_rd(hw, ENETC_PM_RMCA(mac));
-	s->BroadcastFramesReceivedOK = enetc_port_rd(hw, ENETC_PM_RBCA(mac));
+	s->FramesTransmittedOK = enetc_port_rd64(hw, ENETC_PM_TFRM(mac));
+	s->SingleCollisionFrames = enetc_port_rd64(hw, ENETC_PM_TSCOL(mac));
+	s->MultipleCollisionFrames = enetc_port_rd64(hw, ENETC_PM_TMCOL(mac));
+	s->FramesReceivedOK = enetc_port_rd64(hw, ENETC_PM_RFRM(mac));
+	s->FrameCheckSequenceErrors = enetc_port_rd64(hw, ENETC_PM_RFCS(mac));
+	s->AlignmentErrors = enetc_port_rd64(hw, ENETC_PM_RALN(mac));
+	s->OctetsTransmittedOK = enetc_port_rd64(hw, ENETC_PM_TEOCT(mac));
+	s->FramesWithDeferredXmissions = enetc_port_rd64(hw, ENETC_PM_TDFR(mac));
+	s->LateCollisions = enetc_port_rd64(hw, ENETC_PM_TLCOL(mac));
+	s->FramesAbortedDueToXSColls = enetc_port_rd64(hw, ENETC_PM_TECOL(mac));
+	s->FramesLostDueToIntMACXmitError = enetc_port_rd64(hw, ENETC_PM_TERR(mac));
+	s->CarrierSenseErrors = enetc_port_rd64(hw, ENETC_PM_TCRSE(mac));
+	s->OctetsReceivedOK = enetc_port_rd64(hw, ENETC_PM_REOCT(mac));
+	s->FramesLostDueToIntMACRcvError = enetc_port_rd64(hw, ENETC_PM_RDRNTP(mac));
+	s->MulticastFramesXmittedOK = enetc_port_rd64(hw, ENETC_PM_TMCA(mac));
+	s->BroadcastFramesXmittedOK = enetc_port_rd64(hw, ENETC_PM_TBCA(mac));
+	s->MulticastFramesReceivedOK = enetc_port_rd64(hw, ENETC_PM_RMCA(mac));
+	s->BroadcastFramesReceivedOK = enetc_port_rd64(hw, ENETC_PM_RBCA(mac));
 }
 
 static void enetc_ctrl_stats(struct enetc_hw *hw, int mac,
 			     struct ethtool_eth_ctrl_stats *s)
 {
-	s->MACControlFramesTransmitted = enetc_port_rd(hw, ENETC_PM_TCNP(mac));
-	s->MACControlFramesReceived = enetc_port_rd(hw, ENETC_PM_RCNP(mac));
+	s->MACControlFramesTransmitted = enetc_port_rd64(hw, ENETC_PM_TCNP(mac));
+	s->MACControlFramesReceived = enetc_port_rd64(hw, ENETC_PM_RCNP(mac));
 }
 
 static const struct ethtool_rmon_hist_range enetc_rmon_ranges[] = {
@@ -389,26 +389,26 @@ static const struct ethtool_rmon_hist_range enetc_rmon_ranges[] = {
 static void enetc_rmon_stats(struct enetc_hw *hw, int mac,
 			     struct ethtool_rmon_stats *s)
 {
-	s->undersize_pkts = enetc_port_rd(hw, ENETC_PM_RUND(mac));
-	s->oversize_pkts = enetc_port_rd(hw, ENETC_PM_ROVR(mac));
-	s->fragments = enetc_port_rd(hw, ENETC_PM_RFRG(mac));
-	s->jabbers = enetc_port_rd(hw, ENETC_PM_RJBR(mac));
-
-	s->hist[0] = enetc_port_rd(hw, ENETC_PM_R64(mac));
-	s->hist[1] = enetc_port_rd(hw, ENETC_PM_R127(mac));
-	s->hist[2] = enetc_port_rd(hw, ENETC_PM_R255(mac));
-	s->hist[3] = enetc_port_rd(hw, ENETC_PM_R511(mac));
-	s->hist[4] = enetc_port_rd(hw, ENETC_PM_R1023(mac));
-	s->hist[5] = enetc_port_rd(hw, ENETC_PM_R1522(mac));
-	s->hist[6] = enetc_port_rd(hw, ENETC_PM_R1523X(mac));
-
-	s->hist_tx[0] = enetc_port_rd(hw, ENETC_PM_T64(mac));
-	s->hist_tx[1] = enetc_port_rd(hw, ENETC_PM_T127(mac));
-	s->hist_tx[2] = enetc_port_rd(hw, ENETC_PM_T255(mac));
-	s->hist_tx[3] = enetc_port_rd(hw, ENETC_PM_T511(mac));
-	s->hist_tx[4] = enetc_port_rd(hw, ENETC_PM_T1023(mac));
-	s->hist_tx[5] = enetc_port_rd(hw, ENETC_PM_T1522(mac));
-	s->hist_tx[6] = enetc_port_rd(hw, ENETC_PM_T1523X(mac));
+	s->undersize_pkts = enetc_port_rd64(hw, ENETC_PM_RUND(mac));
+	s->oversize_pkts = enetc_port_rd64(hw, ENETC_PM_ROVR(mac));
+	s->fragments = enetc_port_rd64(hw, ENETC_PM_RFRG(mac));
+	s->jabbers = enetc_port_rd64(hw, ENETC_PM_RJBR(mac));
+
+	s->hist[0] = enetc_port_rd64(hw, ENETC_PM_R64(mac));
+	s->hist[1] = enetc_port_rd64(hw, ENETC_PM_R127(mac));
+	s->hist[2] = enetc_port_rd64(hw, ENETC_PM_R255(mac));
+	s->hist[3] = enetc_port_rd64(hw, ENETC_PM_R511(mac));
+	s->hist[4] = enetc_port_rd64(hw, ENETC_PM_R1023(mac));
+	s->hist[5] = enetc_port_rd64(hw, ENETC_PM_R1522(mac));
+	s->hist[6] = enetc_port_rd64(hw, ENETC_PM_R1523X(mac));
+
+	s->hist_tx[0] = enetc_port_rd64(hw, ENETC_PM_T64(mac));
+	s->hist_tx[1] = enetc_port_rd64(hw, ENETC_PM_T127(mac));
+	s->hist_tx[2] = enetc_port_rd64(hw, ENETC_PM_T255(mac));
+	s->hist_tx[3] = enetc_port_rd64(hw, ENETC_PM_T511(mac));
+	s->hist_tx[4] = enetc_port_rd64(hw, ENETC_PM_T1023(mac));
+	s->hist_tx[5] = enetc_port_rd64(hw, ENETC_PM_T1522(mac));
+	s->hist_tx[6] = enetc_port_rd64(hw, ENETC_PM_T1523X(mac));
 }
 
 static void enetc_get_eth_mac_stats(struct net_device *ndev,
-- 
2.34.1


