Return-Path: <netdev+bounces-145742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2689D098D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9509F28151B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 06:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA79178395;
	Mon, 18 Nov 2024 06:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="APHsICiy"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A69165EF8;
	Mon, 18 Nov 2024 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910959; cv=fail; b=pUTGIoEKLEDalRLAJ7fZh63JIZljXKLQE+tYc7/KdyENDyAEqE7atxv6oF+51cDqkZt+B2+kCHVKn+LfW8MHfiitUmrcaJHhJi0l2PCJbShqNmEUJ+ElbyGLOM898/iUBaHVmUfLa4he7BOYBdXIILjxy0ZDGlZDZL6m+83tPJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910959; c=relaxed/simple;
	bh=GcBRI3fRmqtHBLmmq84nuZuseIMLeVz9qNc80/VAe50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NF9O27cRqLTAqm6nIlskfKDTaqHyU+9Pa45Sf6E0/nhIp0DAG11Wj4RIzLnF3yPUDP7879AIV5M9RVSOw+kyiAyWlGSqHHLuYGeUNA3OM9aHz2HM8vYwWQVgBgZAvPpqRkvmkuqIDPwS2J1U7iBSA0JfyXA9adHNmSY45k1PEpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=APHsICiy; arc=fail smtp.client-ip=40.107.105.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7ecXkbBchN3JuGnfQ2+UExwhzgHcaVqPHQMoAFokatgXH8E/r0NkJs9uKbEg1ZgL6+v34fyJJ7DKmRHWPISC974XwmbybRjqsyUeZVe2urXbdlzJ3qycSlDOXR8Y89tIUUU5JbQzDCNMXkfLXb14jfEUNuaFUWuydgeTiX+4KawRAIoAFEyrx2AWyAPDJZk3AjlACj1o2C88ej68iiNx2VIprF6rprsi2FVilT0OO6gQZmBCYTKpT2luRsYfpfIyvNnaMS6PcghC42uzPEejoDpE+sy/KypP9IyXocxZFcQJ5T0xAbxBzGPtVoYBkFSliEwqElhVWHUrUhufvPDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIAAiB+DeVGJXe8iPw1R2VFttXf8547vGuC6PrmznoQ=;
 b=XBc7T1VdZCsUI/S2DN/51FXoqA+hfcyb2r2hvz0XhR0Vic0P1gDE13vP7CDgt2UQcm5pn7lFu7Ci9JVQQQqn97ZXIrxJF4shu2vZYuPMCcR2azD7bmYgBLrwixJ2DLYdn9yRoiAYKdzJT7y215UHroHIOBmbAabxs6ZjV2XwgDyV9rBewd+/qaNJEVidQgFmxINhDLt1rZfwoV52lU4W7VzfK/1BMb+noltkAmRoDrBoCz1Hghha5E81wCgOMTEe3rz/lcQStKpaKK9ZyltSRfbJLn9c9r6VPkTVMWj5f0n93ItcgR+/q9JBQ0h8FuuiqJxx7HC7t5hmDqBVqecDZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIAAiB+DeVGJXe8iPw1R2VFttXf8547vGuC6PrmznoQ=;
 b=APHsICiyxiqt7ADwbOl7ZBCGBl9WOoKKMQIACArAuyPXp20d7zHN1AYuIWa44axksPrEWLIzIzmHHEVFgihfI0vBVG4KWZET1El/bwFCXlA/GzhtAdJBNc7aCrXGvII8LIHuj7EI9UBy0AFhy0fJu+f6gbwwjfP/CwmkZXfwf1QxJ9d/rz47eO4Wg2Gfw5s0kHmj4YxNdzWzhJwtwgLeaEUtF9cK4jjPKmrxtmfKtFzA9MqK9ITCMytczfsbr3thUyyxWe+GQSGt3EDPSIv7eEdtDwFYfUKV87RKCcYGYn6Opw31KQYX4jirqcOYqQXg+yLRn5F0QwkJUCrIXxZl8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB9739.eurprd04.prod.outlook.com (2603:10a6:800:1df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 06:22:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 06:22:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 5/5] net: enetc: add UDP segmentation offload support
Date: Mon, 18 Nov 2024 14:06:30 +0800
Message-Id: <20241118060630.1956134-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118060630.1956134-1-wei.fang@nxp.com>
References: <20241118060630.1956134-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d822ed-793f-4315-51e4-08dd079963d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h3zTkNNADBUbBe0TewV3xQTkrJEBlQp5jGbkrPX+ENteKbAkl5vGB7lKtj/j?=
 =?us-ascii?Q?cCG80Ij8lRULGF5zCBR4EUUyFnOnOfphimM3IKWpU1vXSQSurt/T/qKqwVyu?=
 =?us-ascii?Q?0K4n4iXz9NDDdEuMq3zPNY85kFjfstcW5zJDYK/XxxYbQ/qKQ/WdiudOEzJZ?=
 =?us-ascii?Q?FBQoRcO9Op31GFGIjZkoZt4++NROzCBUNoNW6CI4mTrlD2lveXOeTG7YT29W?=
 =?us-ascii?Q?55pGMqCHTlpFIZDmdD02AdNyHs0pYRGOGgb8d7tEMfohUALszsraUVRUdEOV?=
 =?us-ascii?Q?FkgfyKweIBPBbkM2zXXnpNRwz+pVdYi60Yj5icB06zQDxr36/Hga0wG0X+aT?=
 =?us-ascii?Q?tpOWIiKugUWskvs5QzAnd4cyZzfWojV8SCpsX2f1VmEo9LzZsc0JHGVGwKsw?=
 =?us-ascii?Q?2bv3rWTh1IOeM4H3mv4HxY7/SLvnKusHq/8KO98yCjKL4sr0YDIRxVtydoKT?=
 =?us-ascii?Q?N+dX8vP1VJ2WoJj13Dqpi5vC7HIeTUvnFAd1jz5WXGoZKKXQ/NlICM1lSdef?=
 =?us-ascii?Q?588P3xi8mk0Bja1fM4toOEyU91nqTE304xxQlLb2jNW1jh13w2i9Cb1Qb1Kf?=
 =?us-ascii?Q?stazXG9g3Mgdjq2GH8L/JKS2yfoCx+i3DA3yB4I3R9vgTbagBqV7HrBndYag?=
 =?us-ascii?Q?pop1s85SXDaiWb4oAnp52sQtvrySxUXwNkLu3MKT8WMLRz3wjVDT1soDglPu?=
 =?us-ascii?Q?yMryErInp6GWPqjDd41Dx49tix8HDZFazMpWsH6HtZpBsxTB6oOMz8xYKAFc?=
 =?us-ascii?Q?a9sfi4nG4YoNuwV2a/2XPFZOSguLMjwnYbqAGl9Sv2IziaAb42rnDuBDFBTU?=
 =?us-ascii?Q?gNvxTcrfu6vklXGCkvDId7kXUYxPs25adVz75GkMiUaHnj1tr1CXEoOrl6e/?=
 =?us-ascii?Q?xSvn0meRc73gyA4KwUT7P0moxHqD5RxjSnh2miKRHJpfoHlVktYje5UcAo+9?=
 =?us-ascii?Q?U68CcZYJxlDauGDLUBVQftlz3IMn3cTQeei6d1nWgtOSiDeXV1kd5bgTKZpe?=
 =?us-ascii?Q?DtKZdJSOtd4q5elaWt5bQKMMOZP0u+FaSwb9XObd3eLFLXhajFwqkADJvg/c?=
 =?us-ascii?Q?W/B7sTy4FSFN3BXGsZP6qGV5ihc0XTzSRLTF7a11ObA32tg6UlzQ5+KsZGkx?=
 =?us-ascii?Q?zpYFAIc1ma4P01w7r2rSIBS7BW6HYdLhB8UWDgaKp3HRbp2GFzKXzSY4Oesj?=
 =?us-ascii?Q?bvqy8XbvTMyt2bzgard6mS9OeC3P0wPFRbhtiq4BankrLsz+YqLSiUgu7A/Q?=
 =?us-ascii?Q?Gzp9PVAL8ILu+PAfFQxeBKYPvqDwHF36cbw8BpH6qu+jzaGRJCJdtDqNPmIx?=
 =?us-ascii?Q?hm/4m3dlCuYhfqrhcnS4fQwId0a0FKx63CWJ5dw1O/aIHwTR1C6lrmcfz8DE?=
 =?us-ascii?Q?aUtK9NU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bIBJs9xWl8aKr/V/2tq3iCN5Gn4FyDKkb0W90NCqJewxW0dn7Vu8LQXYtn3P?=
 =?us-ascii?Q?G/eLSWOyh1S0EMFsno193sEl/3QVausd1zGcOGYU8+bVYe+7EEXhrBrMOuP4?=
 =?us-ascii?Q?/Chue54kvtqBn5ITM7Yq9LF1ywsfhMhgad3qQRZpDyC9XQ1wJka3BbI4FwY+?=
 =?us-ascii?Q?JQVqS1XUnDf7mjE35TKjG/yh1VGWVSHDM0fykN5bq6De4ZbXhSKcQp7vYyHi?=
 =?us-ascii?Q?m0HbU2gw6MJk1RuPVpOX3HsqlO8fzacoFUQMXDuM7BEFKrL/JH1ZsL2+mzXq?=
 =?us-ascii?Q?2Xjt6HrzMHjE0nkuc/PhUzC15LPFvQFC6x1kaCy+mVzjsVJRhuntv3DYnlgS?=
 =?us-ascii?Q?9e0hG8odhrVFelRfPGmIdg14FvHYGNKywgIOA2usvZLdvN3vBlM5Z7Tp8e32?=
 =?us-ascii?Q?k2ESkE8iCU9TrBxqGeTyYzi4BtKKkeGi0nwL9ToQD5bEON/dLlenfyXM/7md?=
 =?us-ascii?Q?jpUTXukKf8p6iQ/XSI1ZJYc1sy19A8XonijhlsX8Ox724+iRte9KWBRRpwGT?=
 =?us-ascii?Q?YHpMieD8UYRJg+tuvZLnxwUU2GQmizTgSlfIkIX0NRjky+9vryd5t5fbZ2YV?=
 =?us-ascii?Q?Lzop4kRIxoo6ObtLSRtynE/arhNYo9JVBxwrfjR2M/bCzrnzPQrzDy95fGQ7?=
 =?us-ascii?Q?rHjPSNUO9v6JzLSADkyZGeP+cfc2MxpAcCn1lYNiWg8XWrZV/nAdYoTZZom5?=
 =?us-ascii?Q?fpC4Wmn8nSCzPbBaHnF3TJGaGVoQvD3uOE2xgEQt5X8XKoYbJVCahUZQ8FcG?=
 =?us-ascii?Q?gRtpDIwWfRGNYb8hDhBPVSNT2gD+TRR3WtzCKS+xVDcfm4FWOO1HN7Q7hs/D?=
 =?us-ascii?Q?GqDaylpYwxjSWgdAG66c5lNtY4l52OhQb4mGQjh5m11uwX3mj6it+8xaDK98?=
 =?us-ascii?Q?zOo7MICMbEmK7hH0MsbQxn5sU/LixHCegQl+iOlUtomCCaHkrQpveR7TPELi?=
 =?us-ascii?Q?l3N+eNwUGRZkr+xFd7yWqnh3SNLCRau/P9ZlgD68nMpG/+w2nUFmPTv9PITs?=
 =?us-ascii?Q?TjpcbByAgMjjatTZabrrlqeMaqRD0QQGjwBEb9YD9iSePCNrPw7BPROqUu0M?=
 =?us-ascii?Q?XbmgPQRw6dB7o9ZuIlYSE/6vaszUuUnFCyrQYO4z+crCITU8qBTSXkQLGpzY?=
 =?us-ascii?Q?bw627Xf7eRkSQWq+dttISJDysMRfyqHN8/+IHRBZWvJmKun/hsphAVU5yrPO?=
 =?us-ascii?Q?3jJiUeNSN+x79qf7CAIjUG7Qcl9st3g8HJbPvUx2HIUxDzMxSwW6A/V8B9m8?=
 =?us-ascii?Q?FW9dGrQlFu8AeMD1Z//cebfHheObGdMuzB1MAvvRSPxbPaIUtfHbO/PRavU8?=
 =?us-ascii?Q?H+nCec/5bkkJziBLkXXiskq3XwoZkGxWiUu37GT/56llHoJ6iNuIGe1HNftT?=
 =?us-ascii?Q?PWCZYQphe7Jw4oEfnsBkznlNspv54v0bpG38w1vf8aDmhxpQqAIggRXtmk/s?=
 =?us-ascii?Q?D6/LCdN+0UfutRiDfMRTSvKNLYpDHj794gwL7wqEnKY/Q450Q7XtVGJPPGjt?=
 =?us-ascii?Q?G5VkUCdUNa9t/3KMVMd+nL7Af5zufWB3VN/6Cdxzrqjvym+EcZ6M7OZEhc2K?=
 =?us-ascii?Q?dFMZyDOJWaVaoqM6cUkyaMSK1IElm8RJMKWpH30C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d822ed-793f-4315-51e4-08dd079963d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 06:22:34.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXHFWiT8vhjhUsb5WjXm+eITAtTT8+N/L13HCjncvwUZQG5K/hvTGHEnokyXPCAgcV12v55bjkaQZHqoh5uNLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9739

Set NETIF_F_GSO_UDP_L4 bit of hw_features and features because i.MX95
enetc and LS1028A driver implements UDP segmentation.

- i.MX95 ENETC supports UDP segmentation via LSO.
- LS1028A ENETC supports UDP segmentation since the commit 3d5b459ba0e3
("net: tso: add UDP segmentation support").

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2: rephrase the commit message
v3: no changes
v4: fix typo in commit message
v5: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++--
 drivers/net/ethernet/freescale/enetc/enetc_vf.c        | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 82a67356abe4..76fc3c6fdec1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -110,11 +110,13 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 052833acd220..ba71c04994c4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -138,11 +138,13 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX |
 			    NETIF_F_HW_VLAN_CTAG_RX |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
-- 
2.34.1


