Return-Path: <netdev+bounces-224281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE78BB836FA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973BA623E41
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496552EFDB7;
	Thu, 18 Sep 2025 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QLLqUrbW"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C72C0263;
	Thu, 18 Sep 2025 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182796; cv=fail; b=q/I53IRQbWGlCjMSQ7nAupZwWiBGpbh8d9Ki2yvr6n4zz35OM5KX3n7XUAQIVST3EdjPhP5kPt+tBHBGh678VzaDj67uQU1JdHrrBqc65HhHGJ/TVylsKXjGkoheEOoDIpvThQeUiVabYFYXpMZJpPTme3HwUxCDNkT8wwb2FPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182796; c=relaxed/simple;
	bh=DzYqxJd+N/6RIAaifseHPVTl1gvxFMHBWAzQvlNnMFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=llnIQzldAesr+py9nDuyVCDrZzpRnGZAwQZaeBP/knadT/AJfVlvqzG+zpzYDjE5t2FDZcme2JwZAqOAeMXrvC2xnLwrQoSwuz6WORpw1EUk1AOFb4EMtJ2wS236IbCAGXGym/RactJVMrH4a/xPgq19VVgpUmzP3jMsZINSm6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QLLqUrbW; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0QGOKMcm737mLGjXjoRClI2Gt2DF3WUG/xS31oMeAqpzJ+8QYZYXlNimnKuUuVKRPooBEBex8jon0wANuXEu8ekeW7PGWkxoC/vshVcA5U0ObGrmCuZYR2hkbQovWLl2xc3lCH/7GNd9enQE/0enzGcgG2v3BwQFBq+4PW5Iw8ZmiskHiUqyysR3IFnasDGjB8nhplbEIr9rZHW+xF9VymDib3nC4p0KUzej/Eqzsy9QffACkdLGE/xciUNDWqGu1otROkbwFZdhRSXh1V1LrITBvppgCOwDjFmP/Vx1AFDpPn0TJvKONiTLAt//j7eL0V+Cvod5883oZeXOBRWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvz9vdIuAkckdoa2rZEl/rEePEfdFMAW/gFGOZa4Vak=;
 b=IQq8uuoyOu6QL4sTfwIwythawb98mlvbGlEbPlyV9/S54ZqDoeNLJMjxAFEIBiba1sqvBoXIm94NOMCfZHIx/iHmr1e6PBzBVRlL11U7v/qCb45Jl94MBDiCzQY28spwgtyv+ShEifUl+U8c9qtdT4OS7hHRV1N1PWp8P4vby3Vb7SLChQm0iMZz8u2VZpASHavvo1PpXt7oXio6ukzvNdXC/tfb3luXXQ9s8ae4yFfSZmeyPYpZ+OjOsRBQUHM+sbLrlCtP1a8due/5ypyc9gHJlxKFtUn+xIgVwU4motk3Ws1kCg+72baPtyn4888nQUoTB9OwKgOuv1EeldAIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvz9vdIuAkckdoa2rZEl/rEePEfdFMAW/gFGOZa4Vak=;
 b=QLLqUrbWrGgels88Ygu6Uz99BGcRtPyFpp7Qt9guTkA/2/vyR5A1yS28pPJizqV+f4uoey4i9KKjtm5ZDrXbelf1/yH6xSAIcCjwH3GKdEYZsDudsbWChQHZ4aSH71NOuiq5TLU7S/GZcMaeLPK4gztvBoG1rm2klplCVbfxfVSQzxEfMKv2Jj82NP6wNpGN+AsN/4P/cPBVH2vxv2xxbvrMOT+s3hEgX6p8z8GxCTjmmRtJEL2AeP2jQHfYbDF/ewyrQRQ9BGB8jt5WHzYUPKH0s/I0nzROHK/k089QShxIGTLoKfKZp6N4PdPxPeZqvuhQnLxblxuN3n5QrKSsBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7617.eurprd04.prod.outlook.com (2603:10a6:20b:286::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 08:06:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 08:06:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	yangbo.lu@nxp.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: enetc: use generic interfaces to get phc_index for ENETC v1
Date: Thu, 18 Sep 2025 15:44:54 +0800
Message-Id: <20250918074454.1742328-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 321fc26a-319a-4415-1ddd-08ddf68a4697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4cMT++56SWF+L7VRq/YJVCsa4lYQJjieS3SBJQ2cppePAmI6IccyM5lqtV4r?=
 =?us-ascii?Q?5NzlErSfVlkWOC1t9tmiHsYdTgdPHb6tclEcXjNA8f9bXFP5qEs5rT73wv0l?=
 =?us-ascii?Q?NLk62AYiPz8WljT1+JO5T7Cuxd6mFj8nRnhfHnta9u/dpk9ou0SLURpjABGw?=
 =?us-ascii?Q?GmGiIEddFq/JQGTODCTSdVfgW1v+Zt19Z/83hQGGw3z40Fz25Yat1ysOFtOH?=
 =?us-ascii?Q?Vq77//iOid0uPXHKqtW8Q2CbMAfUBOCQrXbkCHruJg3MtdFrBxVSVXfRDVWe?=
 =?us-ascii?Q?O5HcL0jibV+FCtF/auxMMZlLiT7RaUyTsz9t8U7A1thaW5dMRoWgFfbDnp5K?=
 =?us-ascii?Q?radoM7FmGxDZX+ksY5oJAAsWvvcLUN1JYDApPpAlmRdNBBTbZ5FUp9IMsvq6?=
 =?us-ascii?Q?lhUXyU56atAr1TuGuyS7CE7znMTBw8HElYFa0sk1gMrts6c65JRjN/zFZDik?=
 =?us-ascii?Q?8/djKUg6tCJx8XR2G/0cBiWdx7XWJtbG27ds6+xRSL0qVWsUx02LG2b6Hw4k?=
 =?us-ascii?Q?JVE3tbf7DI+aRSCKNeX7edxLepeKXMBS4e0b/n0lcm42h2jtLthePDvVinoR?=
 =?us-ascii?Q?wbAHB+IWLDRgcXsGzcoK38Tn1ZCTgjFPDzXVC7zJOhrB7DIg3b0L+cv2pqfu?=
 =?us-ascii?Q?/+A04v89zf6vSgNP4KEQHvYzTAYxekKZvFOzVb26QDe/AJ5GzOvEwXA/4Psh?=
 =?us-ascii?Q?97zd0BAWtsW+F2U/c0UYntBrfuYcRVuGB/+/Jo3iDCIxRx4mhhGg2BBTPKul?=
 =?us-ascii?Q?EU20t3UwqdrmWTgDH3qOOvYnEH7w3gyDGvwsPm0Ysw/cvLN3HIQl4gGT7kZ2?=
 =?us-ascii?Q?N0yJOff4TorVvWNtebeIO26q+iGkOtxGa4jqZzXMhFQ0VBvg6eswX9rSK+6E?=
 =?us-ascii?Q?TLeSWLBtKMEL0IF9Yt43gdVoS+V2A/wWqJrS2FZ2kB/kETthgbfG0VinB6BF?=
 =?us-ascii?Q?BKBFqV7e7QrV6XA9bZXAarEUIMh0WximDtmLjupRMrso6JnyDwEzSI/O48aC?=
 =?us-ascii?Q?+yAhRS4F9k3jt3RLAyaFVU4vOu5eRtUxx+31RgoGc7DWPrDxzjegoDqiF7Us?=
 =?us-ascii?Q?FWi7r03b2WGqxMPdA04abWs17K/ugP9aBD96hNZYyI71KgzTnBlQs7wb6VJn?=
 =?us-ascii?Q?cg3OsWHOxZQVN0KGNZs1tEJ03WJn0bp70dPKMrFC5DnGKbVqglsGVoHtVOZf?=
 =?us-ascii?Q?J1GRR7/bQjGld9iOEj7/AfobKVRkjucPwbz/NEL6Z83NSsfz4CypZ51i/ojJ?=
 =?us-ascii?Q?GRHn/pRsWfKVqnYlASfQ5qdJ5yljfladW0y6+5956SSwgWK3ywL1ALP30x2s?=
 =?us-ascii?Q?V3L/gEUuTDCjNPn/OBSSiKoFzD8XlqexnDDoQwLKu4xof2G7C1P3ZWHjiDZi?=
 =?us-ascii?Q?BeotF45oAUf5vGpLTW67kSu57Wl4Js3VnOLaWV0xPTPW3NxX0qXGRWPnZ5Mw?=
 =?us-ascii?Q?owrUf9mhG5+xt7jR0paXHzhXz1M5lCUWxevAbOmiWNVKW5an6O8RCQtzL5GH?=
 =?us-ascii?Q?21kAMwREqxj137Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sRZfXng5WBgvJo+rCsQnB9uElW3Tcwwa2Ter2OlWPWqIuTew1j4MTZDCBVgM?=
 =?us-ascii?Q?5hQW4N/O0JNfGXa2VztTHfcls58DlH24yl5zMlBLYoxSMXDF0LfoKh1KjIEk?=
 =?us-ascii?Q?smxXwEBYuo0UDsgJLufOyA8MYfsf4p5+fjOZgLdVXzBmOSKO/52W23MJsz48?=
 =?us-ascii?Q?gnR2zA6LIcooTHfXCl8t83PDXapwDE1OwY3lwe3BM4d5mFtx7eIZqOUs/YEN?=
 =?us-ascii?Q?9gG1aRiuTSlY9sqV+tMLVqZQid1noIND4il1cDgk6x+VALHdlIKmC1om3GOi?=
 =?us-ascii?Q?X/LC6NplH76tqXgNhYWYszGuVAkHamhX9NIPGU6y1KYGsjJ5jAnNifQw/3aN?=
 =?us-ascii?Q?IXhDpXhEhxr94PXBFgW+XYuuwmL2oZD3k3lJ3AfujwM4LQkTrFzqtb0jUZvo?=
 =?us-ascii?Q?BmjogCAUmsnAnkdhX019xWHKiof0EhTvFUEfa3Kt6kCiZ28H72AH1ljw/2P/?=
 =?us-ascii?Q?VvKkl61VpoE5mPWSkZlt6y9eA1T4LVpRySAAObAVcS+wuXOaPq4gMXKv0fkY?=
 =?us-ascii?Q?GeNtWpufIurf3EEX0PiOljBFGgAGw0sSRymzz6wtyY/UAlvr1OtSmJ205Fk1?=
 =?us-ascii?Q?P/G+62iWi1gY+p6VDa/VE+RZ2dYFTdnop3CR6WJOtxAKu+y+9LZXefDljewR?=
 =?us-ascii?Q?pi/wjyPydZm2xqpd61eu0tg4sspQydPh47xZsOij9BxW1DZEgV/OTKAXYDpX?=
 =?us-ascii?Q?+K3mhX570mOgGC7/JVMga6Rvw+kFW0HSXYxBy36RwBlV/fLmRtVt+33sbLhH?=
 =?us-ascii?Q?MWb0Zqw1D51ne/JBpsLL9mai/xLmMVIRzfCOJkHSEAuXbSOiENEsjbyW5ukS?=
 =?us-ascii?Q?TjH1Hdwi/jfJcF+XzFDB54l2tgfeKYYyAfJeW6pK7glCuteidwp7sSFtQlFr?=
 =?us-ascii?Q?oaZWe3NYOg5/548jWsDiPbdAFroSyqHV0r1qtd1S8DREp/WmcAoMy0VBh1FV?=
 =?us-ascii?Q?gWj4kqWqIPztHlHvMwArz0QwE1QjlfZbTCciqrDugD3/PNE2U1m56E9t4KVw?=
 =?us-ascii?Q?B6db0SHwHjcXb7LX9r7OdRuOz/vv5svVCQCnnv/SddVUML5ULEdbEMbqB5qQ?=
 =?us-ascii?Q?ISt+FauvXq2WCGRwV3JOgHGR28SjBKeV+vBqsgdW304ptfP/z8/Hyrf4utVl?=
 =?us-ascii?Q?EuPgVA8qujaeppLdzB8BdHClDeiX2OH/Ay9eSxB9LAs6V9BPzkXGeqXXO0vI?=
 =?us-ascii?Q?NCn+Nr4do1F3kVmQM/fQ2u+qMXzwtq+BHAuh3UvOBs0th98sh92fJkvRrKYP?=
 =?us-ascii?Q?M50m9cWOqgnvYBDUkh4r8/2S34xp1xESAB6ZWqe/l3eReVnZVer6PH4NjEEk?=
 =?us-ascii?Q?Ih/8vRT2WbtUkbAc5UCCIjnT5X+zQvdtfG7sd/GolEjluRXRY++Nhy7ouy8r?=
 =?us-ascii?Q?5h/mJBcaXNZRvxV22oGsACQLi0204ZkVdcBpSqguAbf3WJBftWiPbp4MuiiY?=
 =?us-ascii?Q?AM/OYKHiVHXYlok3ChhfhDgBq2xCr8+HWfcOmR0veJAlPCJWLO6OuYarIX3p?=
 =?us-ascii?Q?viBIrqIKzGvsQXtmktflH4wPUDim/9I4LRA8G7UvWuwFLtpYne3PDzOQojg1?=
 =?us-ascii?Q?yk9VEV/zYPWdgUEeUS3IsJH2Os7ObZPpfvvrftFX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321fc26a-319a-4415-1ddd-08ddf68a4697
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:06:30.9375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSsSS9gtv/yAuYE4nmJE/k1Og2irX9yzN+R603WDWzamsiXvEdcxEfb1gpZ7swElUn5Gje8HRQ/SuLP6Nl75WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7617

The commit 61f132ca8c46 ("ptp: add helpers to get the phc_index by
of_node or dev") has added two generic interfaces to get the phc_index
of the PTP clock. This eliminates the need for PTP device drivers to
provide custom APIs for consumers to retrieve the phc_index. This has
already been implemented for ENETC v4 and is also applicable to ENETC
v1. Therefore, the global variable enetc_phc_index is removed from the
driver. ENETC v1 now uses the same interface as v4 to get phc_index.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  3 ---
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 25 ++++++++-----------
 .../net/ethernet/freescale/enetc/enetc_ptp.c  |  5 ----
 3 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 815afdc2ec23..0ec010a7d640 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -493,9 +493,6 @@ struct enetc_msg_cmd_set_primary_mac {
 
 #define ENETC_CBDR_TIMEOUT	1000 /* usecs */
 
-/* PTP driver exports */
-extern int enetc_phc_index;
-
 /* SI common */
 u32 enetc_port_mac_rd(struct enetc_si *si, u32 reg);
 void enetc_port_mac_wr(struct enetc_si *si, u32 reg, u32 val);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 6215e9c68fc5..5f17ff150fd5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -880,7 +880,7 @@ static int enetc_set_coalesce(struct net_device *ndev,
 	return 0;
 }
 
-static int enetc4_get_phc_index_by_pdev(struct enetc_si *si)
+static int enetc_get_phc_index_by_pdev(struct enetc_si *si)
 {
 	struct pci_bus *bus = si->pdev->bus;
 	struct pci_dev *timer_pdev;
@@ -888,6 +888,9 @@ static int enetc4_get_phc_index_by_pdev(struct enetc_si *si)
 	int phc_index;
 
 	switch (si->revision) {
+	case ENETC_REV_1_0:
+		devfn = PCI_DEVFN(0, 4);
+		break;
 	case ENETC_REV_4_1:
 		devfn = PCI_DEVFN(24, 0);
 		break;
@@ -905,18 +908,18 @@ static int enetc4_get_phc_index_by_pdev(struct enetc_si *si)
 	return phc_index;
 }
 
-static int enetc4_get_phc_index(struct enetc_si *si)
+static int enetc_get_phc_index(struct enetc_si *si)
 {
 	struct device_node *np = si->pdev->dev.of_node;
 	struct device_node *timer_np;
 	int phc_index;
 
 	if (!np)
-		return enetc4_get_phc_index_by_pdev(si);
+		return enetc_get_phc_index_by_pdev(si);
 
 	timer_np = of_parse_phandle(np, "ptp-timer", 0);
 	if (!timer_np)
-		return enetc4_get_phc_index_by_pdev(si);
+		return enetc_get_phc_index_by_pdev(si);
 
 	phc_index = ptp_clock_index_by_of_node(timer_np);
 	of_node_put(timer_np);
@@ -954,17 +957,9 @@ static int enetc_get_ts_info(struct net_device *ndev,
 	if (!enetc_ptp_clock_is_enabled(si))
 		goto timestamp_tx_sw;
 
-	if (is_enetc_rev1(si)) {
-		phc_idx = symbol_get(enetc_phc_index);
-		if (phc_idx) {
-			info->phc_index = *phc_idx;
-			symbol_put(enetc_phc_index);
-		}
-	} else {
-		info->phc_index = enetc4_get_phc_index(si);
-		if (info->phc_index < 0)
-			goto timestamp_tx_sw;
-	}
+	info->phc_index = enetc_get_phc_index(si);
+	if (info->phc_index < 0)
+		goto timestamp_tx_sw;
 
 	enetc_get_ts_generic_info(ndev, info);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
index 5243fc031058..b8413d3b4f16 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
@@ -7,9 +7,6 @@
 
 #include "enetc.h"
 
-int enetc_phc_index = -1;
-EXPORT_SYMBOL_GPL(enetc_phc_index);
-
 static struct ptp_clock_info enetc_ptp_caps = {
 	.owner		= THIS_MODULE,
 	.name		= "ENETC PTP clock",
@@ -92,7 +89,6 @@ static int enetc_ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_no_clock;
 
-	enetc_phc_index = ptp_qoriq->phc_index;
 	pci_set_drvdata(pdev, ptp_qoriq);
 
 	return 0;
@@ -118,7 +114,6 @@ static void enetc_ptp_remove(struct pci_dev *pdev)
 {
 	struct ptp_qoriq *ptp_qoriq = pci_get_drvdata(pdev);
 
-	enetc_phc_index = -1;
 	ptp_qoriq_free(ptp_qoriq);
 	pci_free_irq_vectors(pdev);
 	kfree(ptp_qoriq);
-- 
2.34.1


