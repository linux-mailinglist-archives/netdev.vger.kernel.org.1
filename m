Return-Path: <netdev+bounces-157643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A46A0B171
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B24C1887BC5
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECA323DEAD;
	Mon, 13 Jan 2025 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jrOYDZq7"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2465423DE92;
	Mon, 13 Jan 2025 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757629; cv=fail; b=acEW7ci9winI+Gb0pkUqEdTe7LlVhEOcXjQPwawbm8JPxCFyodWqn6qyPc2610qjQcbo7nHAbN9W7yoDEpVHKwOakl9q+AadH1Uvx6J9U1w+z2cwc/WYnug+k3/V4OfyPgH0LVtGWltwa6lmIvHem/mpDtl71LfFtiGyqC11dRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757629; c=relaxed/simple;
	bh=I53O6bZp0ffnMWDFz38YY1xyCg4AfgxQo/D3qqhStCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lbxeOM4VW3RzrLGs4QceV1kr9IwZpkROitB05eFnv5Fu6NEvHeslSdpHG0tTqO52m83dUJPFmV9v9TT9u8zuAuzYSDAwtmTPiQdFEzQhgMuSBEPZD7m8YYCoC9JCn4N3bqAdLelbW1b+dvhcyGUGDIVhT5RpW5WV28hqEYaFdrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jrOYDZq7; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODpy1garz0gLSepNUB/H9sUZ+zro/JN5eYnr764iZpPkDtlzVSgksf0QsfQrEgbQ2AktktxOeIcMDzILKrRztgoGasRHdueo5qK5O3OpZMAl47oNxjG7uxCfJDR/wIpLtc64S01LZki77EaEIjVSgIcbo8xj2f5RN3UOmICg//Zf+oA+aaO4RvIbPZSx7lYCo8NMztpknsItJVnZutOJiWTS/rbyAAOuwPLjgVlxz9q9d20efCuSvfP7Wut68fTmxDkXCyStCO5rP4HH3rd89NDTrdgXvwtRSMd+YbnhjlT83OZNVJTBM/vQ5oPuh16Efs8xMlOORL71vPl+rsMG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Eut/oSc+g1Go8gtsL2w0y3LR6sstdGSy8Cm6RIW0js=;
 b=rF06qOqShUaCjq3Jm8tBwD9UIZElwf/yUFugvPZKYDkJ6DQHI5H+ISUos7gSGobNKgB3PeI09VNkjfMwx7A3628/BVSHloi7CRF8zShqxQcgA06Gg99Z4u3/2MTti7T0wq5BUUpvmc4mFe/p0QfG4WAUjJ6x3SbkCk77PJXn6IvcZqdPcolcwN89fGklNLtFoRqrw/npFuxHVZ+NQ4aEKSxj/9gYzF1hU8SrpA5vUj71PZk6sX+iULnAEJPcIZlmkkvKevqPFfGBAnt0qoPXYORDcs6CYscjC/Boe2g5wdNtqurNE3YKVZru7EHHFXrqcpMNzPx1gUs8VRSMsF1p+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Eut/oSc+g1Go8gtsL2w0y3LR6sstdGSy8Cm6RIW0js=;
 b=jrOYDZq7AVsC+qo6CGBWGl95NyDCDlao+QO0nIpHkc2jsF+F5qoenI72PuVKQ8J4ppiuO+rZP5HIGk99sAgLvUv2m216ur18UUGs74KI5FaUOd+OyB8bwLoQA8L61I9BDP98mmswKwzSm7tASaJn6q8wghNZX3aDcMqVfKIr8BhQxz4V+vUrW3ZcF8+DBBHmH5wTbVmQD2OpdmPfAK5LqLmG/M3FEnTE4xG7zWbmDst9wUvz8AkO4ac9JKQakGFATxFnxkKXYyp3pxeARyIwiQqj7KPvOyqy2FKB2kyPlvCZBeGAjDj1Fm0qLqJxkTQVlTmWVQSxUXgzQNGgeN6C6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB9882.eurprd04.prod.outlook.com (2603:10a6:800:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 08:40:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 08:40:26 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	christophe.leroy@csgroup.eu
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 09/13] net: enetc: move generic VLAN filter interfaces to enetc-core
Date: Mon, 13 Jan 2025 16:22:41 +0800
Message-Id: <20250113082245.2332775-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113082245.2332775-1-wei.fang@nxp.com>
References: <20250113082245.2332775-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB9882:EE_
X-MS-Office365-Filtering-Correlation-Id: 33121763-5bf1-4a4d-99f5-08dd33aded0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U8oYVeLW43AhAtxhqdN4jogK7LizfS+s7kM9qIvd0Yy8oEvLt1S6o5iN0QP/?=
 =?us-ascii?Q?JkCwYpm0E9LdjaH5QYX/bCVTdtBGa+O9xUG/psFBk3dNcxmXwFbST4WYqWj+?=
 =?us-ascii?Q?bUnmnq5ZoDPVjE6HacbjTFVWHu5RcjbdVPrLvmD1bQHjm5pEVG+FEkB3D2N8?=
 =?us-ascii?Q?t+N3QPsHVOs7t3N/e/yKOgaQMpG0t7FQoZui96MOJR/BZiG34nyT9L85eT74?=
 =?us-ascii?Q?L/r+/TB+4QIMUH0dRDB+8N3X5jACqBmnCTJNEJVzgoTqyudNuJZrocwjHdh1?=
 =?us-ascii?Q?v8ZPF8oNzMc6Has6ufPobSXlvSEIhF4+bol7wLEjCE2V5lta1SY03M+5G7cL?=
 =?us-ascii?Q?7k1XcUvvCEqH4vXQw9f0oReuaRLdT/gdgKNDpJIAZuBKT1KVrMcnbyDIs9Ro?=
 =?us-ascii?Q?qtXd+y0IadJ3oUnTcci4rrJ1++GGG1r4b6ACBlJX55G5K56nYnHAoaIQffX5?=
 =?us-ascii?Q?ljhvmbNa8TQlFxqytPzw6TDKQM9dixnLdxai9QrGrtG92OninytadOI8rSIf?=
 =?us-ascii?Q?XbWd1glPcvy+0ROKomyR80K4AnSwgkOWnnK2zXhz1Fza5zDN51V9QeKrDzrM?=
 =?us-ascii?Q?bbg6VrrSj0TsJwAhIe4Ao5gKm8Q4ifecch/odutIxbxYx2Ccyu0Abx1tZgm+?=
 =?us-ascii?Q?sJdCN3tZwfmAEFwxDSS6ykT+kOL8YkGcLEAz7BieJnbYPWYmQJckk8dt6+Qx?=
 =?us-ascii?Q?JMCOa+NTsMdtnSVYAbYlbJSWFNzTDoflZdeop7kU5E1gqew53IGa/iPbPsxV?=
 =?us-ascii?Q?3WwASEp4Gg3G5oCPM68OnJP5Cq2UDHgIPBeQpTL2r2lp09IulkvncS8Ef1P0?=
 =?us-ascii?Q?6QbYlC6n/yQB/4V/Vbl89+xwrEewSTHfUnfz+Tduf15e3lmEpYI6uGOm6tSt?=
 =?us-ascii?Q?qRq3w9fxbHydkXeoCqn5LmG8dx5Sg0FvVUwpwC+/aRWgaFmLM8311szdFyvn?=
 =?us-ascii?Q?POhpFbVyK764Ig/j4wxEpx5ECq0p81i7WzojLLw6XmXVkfZ9mPq4/rhxWH8A?=
 =?us-ascii?Q?D0w51uJdD8DXnzVtP/XHMgAHB58Atk6JTOugULvwKchShbAwOWIsyux45QKW?=
 =?us-ascii?Q?gvu2/wmw99BsIf+Ut/tGOnBJF0ZPGk/UXtVCQgLfIXv/4O5ivNR4ZBGIfsYL?=
 =?us-ascii?Q?+GFy6Kb5FwsXDfa4MftSEWAFPEjcGYd3TJRjYVoWsYKyPkNWCyO0Irllm+vC?=
 =?us-ascii?Q?13zEnHV6/M7xCK4+TYzVlj9szHuzwCj6RjSRi+UQB9g3fumawPcK9JIwm6jC?=
 =?us-ascii?Q?umXRG4qux60E1eyzzfhwNWs5KWebY50V4XnOPGGPcbnqzr6MYTkeUN+8SAw8?=
 =?us-ascii?Q?D3/uLNZ/KfnrQOGcPWSkLw4hWdMlkwWTWPvI4MAgF5ae9WA1sTkB/pMxfXZY?=
 =?us-ascii?Q?Q87TRX2yjxerOuVvlunTh1qd/vWWvINikrK2ahRknRuXu5FnATe8R0egoGJQ?=
 =?us-ascii?Q?PCIIZXnbabDJDFiEH+gCSLZig8s0yK0N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ViwcryjlTc/0q9cJqrbcXIaAIS9c3pStWevbamfvSFx/dTMNCY34V8BnGGm?=
 =?us-ascii?Q?9jhW5qGSaAiPJ2++diPCfUOYtoFFEzPOxtQRQAIJB9hhLok5wfmTTVbmcYu0?=
 =?us-ascii?Q?+T7kflFNQvCV/jl4lL4CIBfb5a12ksbyLvK/zPgSx5/HocPC4EBSIjoGxfDA?=
 =?us-ascii?Q?LHBb64MN5w14GoPN1zfvzsfRLKyR6Ak7YNaybuG5uGcTzgKwMUVcKFuzv+T5?=
 =?us-ascii?Q?Dff14mZPE8yEfBOMD2mMxGOeK5BfDDM+Yg2q1MnwuNiQgie4DxYupaUXViqZ?=
 =?us-ascii?Q?7EL56K8fuAXYQ4dY8abXZRTRVDtbDFiw4iUaHQJ2dgLsokh58NyVTBt4hitK?=
 =?us-ascii?Q?vemUiMtg8tUXmz4dVIgaXL4Pd7TvuxRR/GZ0YLdnEmUI3OPW5ovXmnwcwamL?=
 =?us-ascii?Q?wQEOCctUdgM621GZykvhEl0nJ82hK1DL/tBuSBVUwrpfKgum/v1nBXuL8YC/?=
 =?us-ascii?Q?Cxr9M7eQJ6JGXPM0dj+/pFy1jaNKfgaisQpEU3/9byVTdlGR5cjKBYmpduNc?=
 =?us-ascii?Q?7eMwYPCRLxrbhT/ulBnfhdPY/hIzZadtar30jRn5e9qttm1Pq47ZmgsQFxEr?=
 =?us-ascii?Q?KTQfbPkdqxZMu/gqmS+yoll6ZsgGvjKtJiJcj2BAU4zLx7ND4QKGe/nKLFo6?=
 =?us-ascii?Q?z+5MiNHtMAZQHT9/OIwxrRDkB7y/lViU+DJ8+qDFc5Nwqx4Agdwl3PUUL3GA?=
 =?us-ascii?Q?7TXzcCKq+P0Xx35Hqaq1rceX06wFdXYYb4uAnZs8ShBI5Prz82fniFwopKff?=
 =?us-ascii?Q?PtfYZCzma7fjrZiEtubaUnH+wrfjGZLbks7p7MCJcxJXy8udo3quxTkilWdW?=
 =?us-ascii?Q?L8trFKutWeppzwX3i52FErnhlE73aXvyB4S9rNaI4X5uiGCXyunPB4Yg6B0M?=
 =?us-ascii?Q?Hi6P6L2QCyqPV8364yUWdh2sePX1mVw0BDjV0gkG3na6gJ51BX1vefTMEQhl?=
 =?us-ascii?Q?x5JSNYMb8qPxEIBD5zksfz7XE0tLiT2Jtg7nio4JD4BMD8bI+nimQBoX+CI0?=
 =?us-ascii?Q?0/0U6EMguYxK0snNd385vW8Q17yFa684UOsLLdN4ZqpmPH9sszlockv9cSAx?=
 =?us-ascii?Q?FM8d6Je52AFehP+PxvrwZBzcqI3lb8lA+Bn3Wb8f/i0ZP5f8Am8ztVgxOwQb?=
 =?us-ascii?Q?9zp2luhVfiVFy6Sm15zxXaKnPG6jTwTSRmEXcTsR4r223BCpYbgttEVu5jW9?=
 =?us-ascii?Q?dA7SBkTQL3MnLv+MXYI2SJQ1VwHEZqk34mG2uCBPqqKwxZd9ajZtXhaVmXyt?=
 =?us-ascii?Q?VE8xOQNpqyiDrG8JW/y2B+Gj7L5Yuab56+NTVKqR1balbePSFmiljnUQUz6/?=
 =?us-ascii?Q?zD8FIpxHJSa/eeYqJ7FSwj8w2xZa3dPWwoZMd/eFhJwSHDXoXS0VUO6Hz+eC?=
 =?us-ascii?Q?aObn2tXV4468oUB46Ys6XupGE6WbEXCa6deVuHkPoGXamuSLezINVCFO5YTS?=
 =?us-ascii?Q?z2/aS/uXfoD60/3cEB25XDQrfnOl2HmqHZQP1KJcfOWV3QdmdwrwSgTioSSa?=
 =?us-ascii?Q?SMH5WZFXzU5EJLleM59AZw8UVhjmX3UbdzSUUVwu/zX3N8xMg5GOlANbjGpT?=
 =?us-ascii?Q?QPp9Zp7Dx5hA7T4fhCd3j+xmxwV0gwtffaOUL9gr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33121763-5bf1-4a4d-99f5-08dd33aded0c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 08:40:25.9146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CITZ2VtjvUTBnEqUYVuz7yfKBGXCQmrWXFFN0XTxGaudbzBe1vqMwj584iAiUaYJ5Vk960S817WvamL4BLg3BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9882

For ENETC, each SI has a corresponding VLAN hash table. That is to say,
both PF and VFs can support VLAN filter. However, currently only ENETC v1
PF driver supports VLAN filter. In order to make i.MX95 ENETC (v4) PF and
VF drivers also support VLAN filter, some related macros are moved from
enetc_pf.h to enetc.h, and the related structure variables are moved from
enetc_pf to enetc_si.

Besides, enetc_vid_hash_idx() as a generic function is moved to enetc.c.
Extract enetc_refresh_vlan_ht_filter() from enetc_sync_vlan_ht_filter()
so that it can be shared by PF and VF drivers. This will make it easier
to add VLAN filter support for i.MX95 ENETC later.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 25 ++++++++++
 drivers/net/ethernet/freescale/enetc/enetc.h  |  6 +++
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 46 +++++--------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  4 --
 4 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e27b031c4f46..8b4a004f51a4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -72,6 +72,31 @@ void enetc_reset_mac_addr_filter(struct enetc_mac_filter *filter)
 }
 EXPORT_SYMBOL_GPL(enetc_reset_mac_addr_filter);
 
+int enetc_vid_hash_idx(unsigned int vid)
+{
+	int res = 0;
+	int i;
+
+	for (i = 0; i < 6; i++)
+		res |= (hweight8(vid & (BIT(i) | BIT(i + 6))) & 0x1) << i;
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(enetc_vid_hash_idx);
+
+void enetc_refresh_vlan_ht_filter(struct enetc_si *si)
+{
+	int i;
+
+	bitmap_zero(si->vlan_ht_filter, ENETC_VLAN_HT_SIZE);
+	for_each_set_bit(i, si->active_vlans, VLAN_N_VID) {
+		int hidx = enetc_vid_hash_idx(i);
+
+		__set_bit(hidx, si->vlan_ht_filter);
+	}
+}
+EXPORT_SYMBOL_GPL(enetc_refresh_vlan_ht_filter);
+
 static int enetc_num_stack_tx_queues(struct enetc_ndev_priv *priv)
 {
 	int num_tx_rings = priv->num_tx_rings;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 2b0d27ed924d..0ecec9da6148 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -24,6 +24,7 @@
 #define ENETC_CBD_DATA_MEM_ALIGN 64
 
 #define ENETC_MADDR_HASH_TBL_SZ	64
+#define ENETC_VLAN_HT_SIZE	64
 
 enum enetc_mac_addr_type {UC, MC, MADDR_TYPE};
 
@@ -321,6 +322,9 @@ struct enetc_si {
 	struct workqueue_struct *workqueue;
 	struct work_struct rx_mode_task;
 	struct dentry *debugfs_root;
+
+	DECLARE_BITMAP(vlan_ht_filter, ENETC_VLAN_HT_SIZE);
+	DECLARE_BITMAP(active_vlans, VLAN_N_VID);
 };
 
 #define ENETC_SI_ALIGN	32
@@ -506,6 +510,8 @@ int enetc_get_driver_data(struct enetc_si *si);
 void enetc_add_mac_addr_ht_filter(struct enetc_mac_filter *filter,
 				  const unsigned char *addr);
 void enetc_reset_mac_addr_filter(struct enetc_mac_filter *filter);
+int enetc_vid_hash_idx(unsigned int vid);
+void enetc_refresh_vlan_ht_filter(struct enetc_si *si);
 
 int enetc_open(struct net_device *ndev);
 int enetc_close(struct net_device *ndev);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 59039d087695..c0aaf6349b0b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -222,45 +222,18 @@ static void enetc_set_vlan_ht_filter(struct enetc_hw *hw, int si_idx,
 	enetc_port_wr(hw, ENETC_PSIVHFR1(si_idx), upper_32_bits(hash));
 }
 
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
-static void enetc_sync_vlan_ht_filter(struct enetc_pf *pf, bool rehash)
-{
-	int i;
-
-	if (rehash) {
-		bitmap_zero(pf->vlan_ht_filter, ENETC_VLAN_HT_SIZE);
-
-		for_each_set_bit(i, pf->active_vlans, VLAN_N_VID) {
-			int hidx = enetc_vid_hash_idx(i);
-
-			__set_bit(hidx, pf->vlan_ht_filter);
-		}
-	}
-
-	enetc_set_vlan_ht_filter(&pf->si->hw, 0, *pf->vlan_ht_filter);
-}
-
 static int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
 	int idx;
 
-	__set_bit(vid, pf->active_vlans);
+	__set_bit(vid, si->active_vlans);
 
 	idx = enetc_vid_hash_idx(vid);
-	if (!__test_and_set_bit(idx, pf->vlan_ht_filter))
-		enetc_sync_vlan_ht_filter(pf, false);
+	if (!__test_and_set_bit(idx, si->vlan_ht_filter))
+		enetc_set_vlan_ht_filter(hw, 0, *si->vlan_ht_filter);
 
 	return 0;
 }
@@ -268,10 +241,13 @@ static int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid)
 static int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
 
-	__clear_bit(vid, pf->active_vlans);
-	enetc_sync_vlan_ht_filter(pf, true);
+	if (__test_and_clear_bit(vid, si->active_vlans)) {
+		enetc_refresh_vlan_ht_filter(si);
+		enetc_set_vlan_ht_filter(hw, 0, *si->vlan_ht_filter);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 916818d2fdb5..d56b381b9da9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -6,8 +6,6 @@
 
 #define ENETC_PF_NUM_RINGS	8
 
-#define ENETC_VLAN_HT_SIZE	64
-
 enum enetc_vf_flags {
 	ENETC_VF_FLAG_PF_SET_MAC	= BIT(0),
 };
@@ -54,8 +52,6 @@ struct enetc_pf {
 	char msg_int_name[ENETC_INT_NAME_MAX];
 
 	char vlan_promisc_simap; /* bitmap of SIs in VLAN promisc mode */
-	DECLARE_BITMAP(vlan_ht_filter, ENETC_VLAN_HT_SIZE);
-	DECLARE_BITMAP(active_vlans, VLAN_N_VID);
 
 	struct mii_bus *mdio; /* saved for cleanup */
 	struct mii_bus *imdio;
-- 
2.34.1


