Return-Path: <netdev+bounces-188265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CA9AABD3C
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 10:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3177B1C22467
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7D3257423;
	Tue,  6 May 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aGCEay7Y"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013034.outbound.protection.outlook.com [52.101.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3292571D3;
	Tue,  6 May 2025 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520071; cv=fail; b=FySRzzTHUtAI68R3a+gTFLd5vPifKPAfgTLo3+9Sablbf2SBjdc61AFOOyxpGmK5ZSCUvUxDrPykG1gQURlUFb12shJvMmX8rTSsH4vn+8frUajPMdmP7knXtRm8YM+A2dwii6l2djG0hb8I7dzRqWpKUBFfvVDOSTiKPzhV5ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520071; c=relaxed/simple;
	bh=auFXMCeAKdFhZVV5rncBYkz6ox+VacdlrfKSXOgqtAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XmUSWmzqaqS+ooM1hoKGSktyP1Fs8XKWwkBNFBdwHRM3x1TipiDikEv6gNketLEAfMY+PQZQ711R8ZmX9wbg3snQIgr8jO4WJcQn0fMvbhcqn+S3zN+wxHAolHVEs2kMToSX+nwIy/+QHBPRi/0zPeVdP8TwGgGiSiiOqGQzUlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aGCEay7Y; arc=fail smtp.client-ip=52.101.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjsmYdRcO9mNMh+5nfvA3WRhnqgH9P82ePP/03TNU7QMtbu+S7ezJkoobwFzBN1M5jsAg+MtSCF3ozfOTNftDur33MeDVnvfW1XfFTBMTHVyNn1dTuLY/c+3RGsU8cayveVi6nh1HajM7S0mf77JJKL3AyPmPIjQ4hYAmacK5yWPIad8HMEmjPcU7BUPu42ooZcLnZCULWfb0WnWScYsPMqhZMzOPuNXqzdJCs/XncigjJH3MGqktWorIjIMjl06mEhbVR2EnMVvW9gaqjozUJYp+N0CnwloryU8IUgNsZLafdZ1+Vo75Dum78LnM34OeH5WTQmnTGcN1VZpP/FVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMBuqmYPBblLzLFNOmHgfURQaycfr7NjJjs/x7szzdQ=;
 b=f89OwxcdBheiOcLqzVbdWLbUUDaPDidjLzs2PsjGK9KMp5ahMwSzB/41ypxjnsVG5xGsqje1eOzJy131/kB1tVGuSJFaQ+qzLeVs05keW9ssazEywmSMTOKJTOCblK6osFVqaYnsW26pqiwQDxpB7h3hKrLcrrZLqo/t5KpNyqQz6M1jUQjZbRtYXkLEIOdQ4UyIw1zxxO7VTxd4rWVvJWLZE0V7di8lU2Ys/66D4AIlFqDAtlnCNTzuXz/Vu3SsJcB7SfKbEEQCKsn7EsMn6mmaKCDpvhjJbHcvA7bEx11JkPosY5lsxrCFECbeJBqmrERl53WX5fH4wCimjEnx2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMBuqmYPBblLzLFNOmHgfURQaycfr7NjJjs/x7szzdQ=;
 b=aGCEay7Yi1VZ/MM4YiwMWxURmoaXY9SwfJgZ4S9HlIVrAeEg0mJvwebfGuaYHdCaOCu0BWEddVNyugzx3oWrA09CdwTg2lt6b3oc8oJ4ogN/rUpPT/rI/4JTSWGqQj4L+0ARjE9gKqI8UaTXqdxPaLvYfu/rMLRkC6wWDuKoZdmCuz42NT9yaqDyl1/qSzHduvH5ATvxPkkr267l8P3GGKHBE+MWp47ESOHPBtc+g1a/is5kYNd+mXDLqRvke9BtKXwtsYT8cid7UL97SiTjwWqNjrx8lvor3c5dYVZDCDxqejXrjQyWPccgqI7l/RGJodwVFUxKNnGlGbL2lSxJJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7744.eurprd04.prod.outlook.com (2603:10a6:102:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 08:27:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 08:27:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	timur@kernel.org
Subject: [PATCH v7 net-next 12/14] net: enetc: move generic VLAN hash filter functions to enetc_pf_common.c
Date: Tue,  6 May 2025 16:07:33 +0800
Message-Id: <20250506080735.3444381-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506080735.3444381-1-wei.fang@nxp.com>
References: <20250506080735.3444381-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 238fb1e0-3e42-42f6-5bbd-08dd8c77e0c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wePljX1OuSm3A8M3tFJBgdpouzQo31pEJpVvFm376y0A9J9ZzqRu8ZvyCU7c?=
 =?us-ascii?Q?8lQAufPyqSNNQF18UR9koDj8RtwKmGzREUiFFZMN6U6nCgPAYIXI+DKPd4Cy?=
 =?us-ascii?Q?X4G0SWiXxUksZOYOW5kWov/mSjOndp8oRBB6ItqO9r8e7oebv6bFWXc2aJQ8?=
 =?us-ascii?Q?HNqby3YUvEkGvzX2P+zIl5D6BdnP7vFXpQCCaMBfB6hdKFEsxQZsALbH7cKr?=
 =?us-ascii?Q?n5PjGndIEW4pDuBrGUL4iHwLqRZ16WsOT4q17WGWCchj2Bf70MyrqFwKXy2j?=
 =?us-ascii?Q?YNS8WFvEocQNwNi8aB7QiQfCsFviScKbqZo+WOsRx+x+zOHVwhp4N7FA6XKR?=
 =?us-ascii?Q?LW/2e6ZNztlIrJIXjsoIQoGJso3W69zalX+Dt1jfcA6frLOBoeZxEmO7j6h7?=
 =?us-ascii?Q?TglAm2tiUSZZYZ7bwzSuvPoJBOH+4LRdoz/7O+ZpNZYPv/URS//Bq31OGOcu?=
 =?us-ascii?Q?BBzvNiJhHtuKnAI9jLCly7q+sNdO8E1aTT+Wgj1x8KHdixHlyW3XjS8hn6VF?=
 =?us-ascii?Q?/V+djYZNfLy+OpLJE19w6uB93p8Pk8iPkF4pQDVFKolOD+1SODTJIAghe0q/?=
 =?us-ascii?Q?GV07lRvRbGD5LIW0rBpMHIZ4iJp79cSFDCqMcULhLRsZIZVmiiQ00b2Moie9?=
 =?us-ascii?Q?JCtjqTrp3Nuas/F7HtYZCQl7epB4zMRmJ4K4hNjDwkHG6vPGnJWSm4Jvclye?=
 =?us-ascii?Q?c2JBBuShsZJ7dSyxC9EYf+Ptp/5C4+c/L+WiGEiLaAM17S1a4fZJzjTY5yme?=
 =?us-ascii?Q?Q8d+PLuoEYgOz6MdJgqSuztksQ22rqnEI4txRa5W84jnhoYJdVjujRqDLJgw?=
 =?us-ascii?Q?B1aFpkUKPPB8DNWBp1DCUYLJ9dlAl9YZQUdG13xhyrMxI1jmCEY34Dvb6dSJ?=
 =?us-ascii?Q?lV+BntWv7ypnolvZDJKGne2HeXBc0w7bLwBcMGpgvrFkPeyeLLIIB+eoK8if?=
 =?us-ascii?Q?2F1TRKamDHuvQZGXE3GlkLMwLVAFg9+Uv75QHjHIkrAGUCDdFpL9r/xfnOcx?=
 =?us-ascii?Q?ySeSxX+FTOpj553Z09N1AEZdlGwHu6OML+4plXXw1Y3P2Ky05gVMB/RKT3Ad?=
 =?us-ascii?Q?HHccbpUezTYnCxNLwOKydDHiMtLNj2UsiYnUpQoafaARtPSBzlBioKUIaSBW?=
 =?us-ascii?Q?dsIMBT8eATyu/z1g7ALgbdgXL90hYg0pE9eDybh9bw0Q5da3CojbR2tzs+K0?=
 =?us-ascii?Q?mJLh4C4+X4GgBT1+M9DZrJrQk5R118ZxLfdMS45AJXlLJ1Ou9OdNNJdl7Fbu?=
 =?us-ascii?Q?YWf1HnDB/WdIR3Nv/051kfJQfkcdcT22H6DPnl5Xq77Odd//plmCC5lH/hBH?=
 =?us-ascii?Q?RWiU0QKaxx1fUSWZJk05HeRnYfSkSfH2dN8yiB4P//vNlseOhRw5F+68KXcd?=
 =?us-ascii?Q?MW570m3zKOWnG+n38aEZ+NxAjoPg9Zh3uZuKElk9SusitcZItonyU/GTX/2U?=
 =?us-ascii?Q?Ak1MYOCUZJ8tK2sNH1C9W9TxjjvYbEYqqDxX9FPBlqs+J07a9E1EgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RBP5hHjBLf6Z/0ZG1JtM3y51bc2zIgbhTPYRD0RkAHdH8mV4vvilzeVpReaK?=
 =?us-ascii?Q?6Clr16X1HEOjtbNSvraOocRodXGcle2AZqPgQkh1YZRrsvYEABQrYv5CGhOm?=
 =?us-ascii?Q?RL9YrIrua1cN1ho23ABTzUpWwqwcjAYkg6+r+qJaiMtkIGKVnFH6T43M0pMl?=
 =?us-ascii?Q?uRrs0pe84jt+VkewHSRysewMq6tIQM9VUTM9eciKYP9scvxRz5JJu1qQ6Ooc?=
 =?us-ascii?Q?IaVrVPExxCN4I3l3QAeghCU+k8pZnsNKzYS+3qlNnJHTqeFvWZ74h7Pz+/Hk?=
 =?us-ascii?Q?pNEaV/jd/mPutR8YtqXMNUAy16xTnXQ09KqPrUohAedjHtxGjyyQ+mUhS/gn?=
 =?us-ascii?Q?/DWFs1yXrUAvMxeOkMFCKzijTMAQWPH9vf66E4HoG2dTYkdGY0gN3f41KFpD?=
 =?us-ascii?Q?MUYkHNaPekeGl9tZcyQTDHdbunZOgKUgapWQutGOzsUpAHahea/HX/2BSTbx?=
 =?us-ascii?Q?9AbV+j0T1vgxDQX0j0pyuQxUzLFfeEkr+zuGfws9ERT68CdGe5Po0J2W5BEi?=
 =?us-ascii?Q?HLt4PD3EPkFql4fKsuJClZz48eLo7R9aC2SjoOBrZcHq01gXyxlUXwpExFWB?=
 =?us-ascii?Q?Anu7ai9RZbkTfPk45/PSnGJUmlQTjhkusNA+tpG4msSz+hGThwOnIpMA8d7U?=
 =?us-ascii?Q?b7CAo7BXBJPe84yK/E2jzIFsC48qy02WxNKID9I2UtPkOj9VO6SU6gqZ0t+2?=
 =?us-ascii?Q?JBM7P0xg+a5hVfqqhrX31myPPIE7gzJrKI0nvvgejNlpJ7Nn5T3I/ZoUBzBE?=
 =?us-ascii?Q?I5DCSAuZrB1hQKx+cHgMAU897/Utv4XEaRBrXKInJWzskYg03t55DbRA5AP7?=
 =?us-ascii?Q?lwX9BFhAWq6ErO4IOU2rzs+/5JH9X1yI75U3b5iBbycTfQRuefX6wG0HMyJu?=
 =?us-ascii?Q?dY89HELG19mZlK37X7YgPHU+mT8RxcUd8jSWVRtBSIrYQF1/YtfBmxc5w/Zx?=
 =?us-ascii?Q?XaWWsIUSAxyl/dUwWTcEkROya+5RyQUX2q47Dp0CqUBn1dY7Bl20bc5J0ii4?=
 =?us-ascii?Q?RIC7b5/SQCMbOU7qperxyrRD+8D5Zz8tTlRWMfEg/x/ClrNhU6IcNK9GFTfe?=
 =?us-ascii?Q?J7UDeuFXhRgDRsl6ZkOargz0CPLAsmnxXQZsOthmnMUPb2rkFKVCGJO8YMjL?=
 =?us-ascii?Q?yGbJNvTaIjb6Bo0O+pZVLH2i/mzUbCeaFw1vmViEVH8g0uSYXc7cWxeybokX?=
 =?us-ascii?Q?IcUfIyCEHaXktWpdeuOUqTJ21htICev9WRwfvpBLWqikyMDW3aQ6cCB2GDQn?=
 =?us-ascii?Q?JbCOtpLpjm8DABXgH0yb+0y+OoXepSv/k+QJQtaL1pohpuHeFXHc3POkCYaF?=
 =?us-ascii?Q?prvDWBmlROVvJUEey5OqgbiLSRldvMmBl5lCqbqcHlDTDMlp/vUrs8JYE3hU?=
 =?us-ascii?Q?BhjSEQBDJD3ZE+1YOBVhmL0zbNCTQSZsSVtTCpBpjkx0OhQia5s9HlzlkkZN?=
 =?us-ascii?Q?CkjiBQYH2C/XUjz3soIJAn/0oVyUlgAy2a29a5F5XZNlXvg3QfqxQpg2Oaeb?=
 =?us-ascii?Q?spRwEOCHZgWHTK5DVuyCzrCu+8CKWh6/Hj2exiBsGZHrRNp8d4mdtjcIf7GA?=
 =?us-ascii?Q?/92D5kmasbxUs+f2Vu0nbsdb86jQrdJ+7v1W4O0e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238fb1e0-3e42-42f6-5bbd-08dd8c77e0c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 08:27:46.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xEtNb7Nhxn9eljZjVzV8Wa3nXF54mpZYqoCXUepmnQKFWQobuwreL/VEVQzrPT8c18HjhdUU7Gt2cCV7L8OlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7744

The VLAN hash filters of ENETC v1 and v4 are basically the same, the only
difference is that the offset of the VLAN hash filter registers has been
changed in ENETC v4. So some functions like enetc_vlan_rx_add_vid() and
enetc_vlan_rx_del_vid() only need to be slightly modified to be reused
by ENETC v4. Currently, we just move these functions from enetc_pf.c to
enetc_pf_common.c. Appropriate modifications will be made for ENETC4 in
a subsequent patch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 57 ------------------
 .../freescale/enetc/enetc_pf_common.c         | 60 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 +
 3 files changed, 62 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index ae2dbd159ab4..6560bdbff287 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -216,63 +216,6 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 	enetc_port_wr(hw, ENETC_PSIPMR, psipmr);
 }
 
-static void enetc_set_vlan_ht_filter(struct enetc_hw *hw, int si_idx,
-				     unsigned long hash)
-{
-	enetc_port_wr(hw, ENETC_PSIVHFR0(si_idx), lower_32_bits(hash));
-	enetc_port_wr(hw, ENETC_PSIVHFR1(si_idx), upper_32_bits(hash));
-}
-
-static int enetc_vid_hash_idx(unsigned int vid)
-{
-	int res = 0;
-	int i;
-
-	for (i = 0; i < 6; i++)
-		res |= (hweight8(vid & (BIT(i) | BIT(i + 6))) & 0x1) << i;
-
-	return res;
-}
-
-static void enetc_refresh_vlan_ht_filter(struct enetc_pf *pf)
-{
-	int i;
-
-	bitmap_zero(pf->vlan_ht_filter, ENETC_VLAN_HT_SIZE);
-	for_each_set_bit(i, pf->active_vlans, VLAN_N_VID) {
-		int hidx = enetc_vid_hash_idx(i);
-
-		__set_bit(hidx, pf->vlan_ht_filter);
-	}
-}
-
-static int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	int idx;
-
-	__set_bit(vid, pf->active_vlans);
-
-	idx = enetc_vid_hash_idx(vid);
-	if (!__test_and_set_bit(idx, pf->vlan_ht_filter))
-		enetc_set_vlan_ht_filter(&pf->si->hw, 0, *pf->vlan_ht_filter);
-
-	return 0;
-}
-
-static int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
-
-	__clear_bit(vid, pf->active_vlans);
-	enetc_refresh_vlan_ht_filter(pf);
-	enetc_set_vlan_ht_filter(&pf->si->hw, 0, *pf->vlan_ht_filter);
-
-	return 0;
-}
-
 static void enetc_set_loopback(struct net_device *ndev, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index a751862a70b1..ed8afd174c9e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -353,5 +353,65 @@ void enetc_set_default_rss_key(struct enetc_pf *pf)
 }
 EXPORT_SYMBOL_GPL(enetc_set_default_rss_key);
 
+static int enetc_vid_hash_idx(unsigned int vid)
+{
+	int res = 0;
+	int i;
+
+	for (i = 0; i < 6; i++)
+		res |= (hweight8(vid & (BIT(i) | BIT(i + 6))) & 0x1) << i;
+
+	return res;
+}
+
+static void enetc_refresh_vlan_ht_filter(struct enetc_pf *pf)
+{
+	int i;
+
+	bitmap_zero(pf->vlan_ht_filter, ENETC_VLAN_HT_SIZE);
+	for_each_set_bit(i, pf->active_vlans, VLAN_N_VID) {
+		int hidx = enetc_vid_hash_idx(i);
+
+		__set_bit(hidx, pf->vlan_ht_filter);
+	}
+}
+
+static void enetc_set_vlan_ht_filter(struct enetc_hw *hw, int si_idx,
+				     unsigned long hash)
+{
+	enetc_port_wr(hw, ENETC_PSIVHFR0(si_idx), lower_32_bits(hash));
+	enetc_port_wr(hw, ENETC_PSIVHFR1(si_idx), upper_32_bits(hash));
+}
+
+int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	int idx;
+
+	__set_bit(vid, pf->active_vlans);
+
+	idx = enetc_vid_hash_idx(vid);
+	if (!__test_and_set_bit(idx, pf->vlan_ht_filter))
+		enetc_set_vlan_ht_filter(&pf->si->hw, 0, *pf->vlan_ht_filter);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_vlan_rx_add_vid);
+
+int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+
+	if (__test_and_clear_bit(vid, pf->active_vlans)) {
+		enetc_refresh_vlan_ht_filter(pf);
+		enetc_set_vlan_ht_filter(&pf->si->hw, 0, *pf->vlan_ht_filter);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_vlan_rx_del_vid);
+
 MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index e07cf3c35001..96d4840a3107 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -13,6 +13,8 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 			 const struct phylink_mac_ops *ops);
 void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
 void enetc_set_default_rss_key(struct enetc_pf *pf);
+int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid);
+int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


