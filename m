Return-Path: <netdev+bounces-229929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D08BE2234
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BF634E9911
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1512D30499A;
	Thu, 16 Oct 2025 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dfbrzfll"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A2303C9E;
	Thu, 16 Oct 2025 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603052; cv=fail; b=dr5q9C5BA17iQPNjyf+CehrK8LIrh3oVz/yVaab7TjRM8K3EeCpKvsZ/UkpUDg+qNdimhnaNNGVQKtkeeijku1qjbCewitVWOneZrtr2DXsBNGo1THtqredkNi8TzNZLjdG4gxotlW6qh9wzuSr019pm+G6U9/Yfj+u3ElINTRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603052; c=relaxed/simple;
	bh=CjHJWjmmO5APXNONJar6K5cpG+ABx1ocl2M/lRe5MKw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=f9n2ol1903ZnWeuMbBMQgRDbQ7n70zmJcAsgIZtAbeZ2J6OlqUHciRt1ADLqNB1fS49/m7r1GjQ1rUivolxAqCMuaMzUApPX1uVyG/4VPbwNhmbSrddv7rL58+A4ibPitYxzJAWzdwbW37y+gBnUFoZsIyI2hUBPWXixsGUpitM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dfbrzfll; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQ/3axbD/xflYz/5OkvUd2orXY7mlgHKMFLi+DcYcOrOBQvTGbpeWpURyr5Bpq8LlgvJwwngPcXQd3bygBPyE2PtQLqvE6psJ31QjJAx3vAukQ4I/PurvxgNAtvmn16UK2xb7yh9535jiCOgZjIgO4V7r5Hi/jqV2XQXZuXAZfAitJ9/XC+U1WmeIXg1uCHU68namaeq98dChyN3fV+UJOtG5Ub1DpBNqK1FdZJRqt6yM1mgp3ICrLCGB+epSUuzqkngC+TX+4GkhM3u7PUwyr4wzCjcouholqPCM+NpddHAfU7s3AfMKDiEAgjjKgPdkXBh+T33vmNHc1qiR4Ei/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDzmn9yHZjK4XpscNWbCne/3v85mEa9ghTB/mffoELM=;
 b=d8bqXCRxhD6+ZX1KwcrETjcVTVoBO/p//FM+X4n2nUu+Y1HlpmRemLMCVlGd6s3JcrsEed7Y09+Lp46US8ucpb0RmKL/Wn12Vfy/XnCv9aPT/5Fw9niqc51F0Et1fhj2/HGczY1Yp4bi9WaGWFn+RO5s+vJ6dtYfBBVRB9d55OWZGQ8O4YiSLCxckq2+eRpP1r8LCGCq9fvGjRyFSiMnFHIroGJm/sATjPIt3DekPjBkfgBYj8tC7SbmmN7P8rKGqvR4uiaJQ54P07tqgGg8texR3GbTi8u5emiVfQtqHBKhkGVS3rAvqTPIXeG0xcQZjEm/LHuW6aCNEK6TNi0vUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDzmn9yHZjK4XpscNWbCne/3v85mEa9ghTB/mffoELM=;
 b=DfbrzfllxeDDyYkKo/QEBvDo0HKEkM0kuGKnl6CeCGIXzrNxZ8p4rcIUjKFmyBQyEDuCpsWHTw0j53Z3t2IWuS7hmcnccGyvTMjhu1hzcsK/I3Ak7OCTW2CUMlTC7Gn0+0TqZbP+AjcZzroqRUVCdHGmpN43sJRGJbXABD8wYJM1QQ06nAu7G0j5PJVs8ekYxo9niea63fi/ukKh1SbxhdpHSQSFxf9VNlnDtIRRKwc0bUvdXTATaPjhqixzjtwMN8nl+QmXd35BzlW0liM7wNu+QztP4jkGhS6i0ZNLQcmNabAezp6Bu+ZF82Vz+s0iN4y6ox5iFnym07z6PiTxeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB9082.eurprd04.prod.outlook.com (2603:10a6:10:2f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 08:24:04 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 08:24:04 +0000
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
Subject: [PATCH v2 net] net: enetc: correct the value of ENETC_RXB_TRUESIZE
Date: Thu, 16 Oct 2025 16:01:31 +0800
Message-Id: <20251016080131.3127122-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0067.apcprd02.prod.outlook.com
 (2603:1096:4:54::31) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 0468f482-5b8f-4f5e-4b39-08de0c8d5dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BXPjsUvNSAb+JQ6IjV8GZDKTKRyIEmsCI9uzDSP3J/urROPsTOQhdctjOzEM?=
 =?us-ascii?Q?i9Y0MhjN+jLKW3A2jchJaa/zY/PpAI00W1p2Kjx+GICi1CJMmhUv+icj9Ocl?=
 =?us-ascii?Q?/GKIrKomhdXl7HoAS0dVD4OnvGANuOygxWY40DmL/BPMv/PunhzF/C4hAIy6?=
 =?us-ascii?Q?9WO5JrTZZtFbBCF+bsFdL78ODD++6XK4Lx0Jk5UnehJ+kVsKV+iepTvaNGtW?=
 =?us-ascii?Q?dqUAXfsPUFcrBA5m/vO1MK8BwfNC4+Lo2MhgBbmCT3vLrx/370qG1J8BlihH?=
 =?us-ascii?Q?mQ2StHbtx63k1mlvxjVKRMn30nGgIfTu15yUu8ThZbDpFBZNe3sb4rzlq9D5?=
 =?us-ascii?Q?WMF74XqBwQ/sVm2EDi4AzM0JWSmNH9pr6KW+5HBA+JeRHTifeWIBBzcMT1e/?=
 =?us-ascii?Q?z4TouwnVmQoE6o2+Qe5gCqpD/fFureKTCBV7BvMpz4fQvZnvwHIri9C0AvGc?=
 =?us-ascii?Q?RE9q6zkb054+0CLxLOA68CkkQbcerubIkN/CUQMloWDle8qpjy7QW2BH3xPU?=
 =?us-ascii?Q?eElwc3n1URt6JU6UBlazpEd+eVVknag53fTlubGRiSFavmA5mmVvy59VLKJU?=
 =?us-ascii?Q?x5HZmfbFnnfBVWhTrl3AYzo9KEqPyHqm0sJ1d0LnTaauG/VlbpTaX9kN28vu?=
 =?us-ascii?Q?PwN3GzwL7e9hucia/KLkV201rzAmmza/lh1WMno74IXNWy3yJjxYUpQouG0M?=
 =?us-ascii?Q?8qRu2mX60oAlhy75L78iHeqVRX33QWyqfKDvbgehhrWKtig/bLEC9OnQrcAX?=
 =?us-ascii?Q?ZCsjZr4nhkxl9y4vlHVseLwyg/Ik7pyoZlPGbyBeCSfQ+Ts2dzWN6EK1oG3j?=
 =?us-ascii?Q?o3nNysr7Oo+KOdALfMjqULWibuBMVAcsNN5cpVy3ZXkaB5v9yNIoM9V+K1p8?=
 =?us-ascii?Q?NT3X7rpjAz+CJKsolVzDL6Q989eUhCt7qiRKN/flmGhohWokDOL77vv/ppJf?=
 =?us-ascii?Q?mP8/2J2UsC7pIlb+LQGLtYD5gkKKz4BhkBlLspBa8sGkqEdF+FCRqLGlk30o?=
 =?us-ascii?Q?oyURWn16a5G6rdHGxtRBxkUJGG60BN8K/wQ9dii8QocmE6CULDIGFxpJgZSX?=
 =?us-ascii?Q?fH8JcsPb7XZiYf9JY+bJnf/Lk+mELHzTlWnkT+jS4AJ7mexjQ2DHa8FT8Wib?=
 =?us-ascii?Q?iQxEcbeKAGu0K3/XcOpIpZSp1fUoadZXdldexlaFii6BASsBxtXW48ThVQ82?=
 =?us-ascii?Q?e0eg5zlH+HcYjqPRlvsADGng7ExFZR8w7A82ZShuS2GcrLBzWL9CQ4gNcnlp?=
 =?us-ascii?Q?akW+6A3ttrakVNBVzMvtSAdLGbN96Ow4o96+IC00PqM+K49as3xA+HR+h0b3?=
 =?us-ascii?Q?GTrW2uS7MvwjL4oXkIXTeQq0p2X6iMNYGFgoq80Ik1xBxk4Owjm48u+img0W?=
 =?us-ascii?Q?uXyfQkZQir1SajcYFi1kiGHqbI2fjoC0mO19VqONKaRGpf6fSEOLsA7i7EhK?=
 =?us-ascii?Q?Z9KeaHlXc+KU78wyehPsj1oizhXjrwQAAMPjQHKp2sGhVvPBXZDVwHyAVPEY?=
 =?us-ascii?Q?GCj+WmHdHfpAbGKwf6i5IM67mQxb2GSiZ67z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eYvAI1/kpebxmZPw0JVqBT/oKZUicQaRZr3rQGBU1izLI1WM17bClPgfiTNo?=
 =?us-ascii?Q?oaANOEVuAs90cYGkXnJmeixDSuZDLh0uGkxuMKVd+6BYupQ6a6vt9+RRObtR?=
 =?us-ascii?Q?i3HdY2e3TzVTTAytuF8TubsdZM2HIUpCqGNdAzHHxzT2WOChfRt8s2zjDxUD?=
 =?us-ascii?Q?MvnoCzI1YzNpGdsOtps6hjPTeY1HxBK0Jf21GUz9b7m8gMb8kt+IEpyul3MH?=
 =?us-ascii?Q?pRcoXSBGxOCN0J2DI9/1J7Vd7tshNyo93TslTb4KMEP9PtSomjUWJ61e4otY?=
 =?us-ascii?Q?PgMFfo4HZHfS/BfntLPY6uRVXxanDN2qln8d9gNIScPq2NDwZ3r81pNlc1Ox?=
 =?us-ascii?Q?q7vpiYifDTjpvBFiAAPPiLJTsHKlQyrO0AS2w3uGRFGgxx8H67iFY34FXsV+?=
 =?us-ascii?Q?iNXpgexGTII7JTDJ+mUDElup3eXb2o1vU0NlEfJ7VUH7ZW6UrBKP1gpRr+55?=
 =?us-ascii?Q?8xclsqmGuC5o7k/aQVNCSM/eV2OtkbfW5LTG0m9bX3Pj6Brxgc5gk/h0FM11?=
 =?us-ascii?Q?20hs6cyM7t8WUyRGA0NKPMhMDSMqTjODqYmdLT6OSYcLjJgncbwgle/WhY3x?=
 =?us-ascii?Q?i6MofRwdnyN70GkjtvHhm4fyHC5WiW/X0Qut/krvbCNtzZWZkta0BxRNL5O9?=
 =?us-ascii?Q?X/t18NzUeUrdWtzq6NYjvxGCN5ASMR7Y8Hrz/7nzseWy+annrx8AOj+PAias?=
 =?us-ascii?Q?0HZfd/oJe+wX8e7HVSKQ8VgOFpUpFIWm8Vjs8zrb9wAwJdKJV6sym+Om/gK+?=
 =?us-ascii?Q?NjEtl0Tt7LTwZhmd5xf30TouG6qZ3NWLAeSea2qiuXUEE6tF9/ppmcEvghG8?=
 =?us-ascii?Q?gN7o4nXDiOa9Sex/dw9kXBdLOOftEVC5awfkatGok3mJFIMZPKxECi0rZhAn?=
 =?us-ascii?Q?7PxdlS+mFzYUlYf3qlF96fWeRZm8/Z6t0Vrt9GnetKKUNPCdzCGNjT2dG5Wz?=
 =?us-ascii?Q?E4CEvtglyu0WY67+KBr3vw7Wo9rVG648/f0HNTleWceq4u/liqw+zw1WZ1K8?=
 =?us-ascii?Q?kKRSABl2vUlIMXqHQLsPzwpVanpfaXcyH9W3Ef4DXEyU8vb/2JK4fSV54ncQ?=
 =?us-ascii?Q?fF77nyswgu4Pz3mw59iwK+TUf/bx8AVkuJWTKknqdGVlmXqYSq2WJTqFb7+S?=
 =?us-ascii?Q?o5fegpnBUxS8VkjBJXiAvrcd+IR5TnNuT1XwbbNxd9EQz/mO3jmhC2Np7YO4?=
 =?us-ascii?Q?LlXvAMxvRv9TpwytSUiZrW6RNot55AXCZ+Cv8ToOgu5gfeQMvYZRab/U8YMv?=
 =?us-ascii?Q?yp7+FzKCY27jhUow2cTfhHMLH2E6g39RyMw/b7RaOKM6bAB+NZz5xhg/aPOE?=
 =?us-ascii?Q?CuCwbWGKTVNUFmitUARyyXMQpDmQp4nrQHFfxeJlyHug/8QXi8V85d2iQrQ9?=
 =?us-ascii?Q?h3tJx3uy6kw0HqGG5vEZPwvqUC8WG2KpgFOeQ0d5wy53jInqtvfjKCO2m9v2?=
 =?us-ascii?Q?50YhHZ6oSp5OJI2AE8JXneR1iChpfyRsUAVCjqnyNkD5nS9hcR5BQl2NmyP3?=
 =?us-ascii?Q?y3PN98/tbkVueggiBOHjzUrk7cQmjYmNNuEcR7qpNLndf0s8m+EU3r/8kC+g?=
 =?us-ascii?Q?TGRuu6H24QC1rm8H+LB8LlC2XegL0g+5npOrX/7c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0468f482-5b8f-4f5e-4b39-08de0c8d5dd4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 08:24:03.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VRNkmQN/HKgXwxQ6v4DRgRbDMJ5GRtGejKgp5fvtqNB7sEtPP/tj0jjuSwo7yTNzq8lra7eHc3vbyZ5ssycbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9082

The ENETC RX ring uses the page halves flipping mechanism, each page is
split into two halves for the RX ring to use. And ENETC_RXB_TRUESIZE is
defined to 2048 to indicate the size of half a page. However, the page
size is configurable, for ARM64 platform, PAGE_SIZE is default to 4K,
but it could be configured to 16K or 64K.

When PAGE_SIZE is set to 16K or 64K, ENETC_RXB_TRUESIZE is not correct,
and the RX ring will always use the first half of the page. This is not
consistent with the description in the relevant kernel doc and commit
messages.

This issue is invisible in most cases, but if users want to increase
PAGE_SIZE to receive a Jumbo frame with a single buffer for some use
cases, it will not work as expected, because the buffer size of each
RX BD is fixed to 2048 bytes.

Based on the above two points, we expect to correct ENETC_RXB_TRUESIZE
to (PAGE_SIZE >> 1), as described in the comment.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2: Refine the commit message
v1 link: https://lore.kernel.org/imx/20251010092608.2520561-1-wei.fang@nxp.com/
---
 drivers/net/ethernet/freescale/enetc/enetc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 0ec010a7d640..f279fa597991 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -76,7 +76,7 @@ struct enetc_lso_t {
 #define ENETC_LSO_MAX_DATA_LEN		SZ_256K
 
 #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
-#define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
+#define ENETC_RXB_TRUESIZE	(PAGE_SIZE >> 1)
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
 #define ENETC_RXB_DMA_SIZE	\
 	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD)
-- 
2.34.1


