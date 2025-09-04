Return-Path: <netdev+bounces-220105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC19CB4476D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B351BC4850
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6312877E3;
	Thu,  4 Sep 2025 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WLzow28V"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011038.outbound.protection.outlook.com [40.107.130.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74E528851C;
	Thu,  4 Sep 2025 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018167; cv=fail; b=YY+meG76E+xEPJLmuCwAitRXgtM6mSKlMHa6c8FaIQZA+eL3Z7SH9D3vg0HZI2hRgZ2dwDKtFMv29xgwVJECwqX3swxPVzpLj4NhYvPBD9ggHYRui4bT/SY9xGJfSyd5LC+knEtymTyoLc4Ul3BPdWwbodhsiSNzh5Iukc/SK6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018167; c=relaxed/simple;
	bh=OTvfoj/V3AvjLInaXwjYJnNSQZWcAC6AjG/JgtVhcnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z5fKkYoRSWgRdGgZzIEN3kxBlRO/bDwPI4bN4wohpJpa8yaVGAp1VV+gZRpxTBI3NQgCHSrkRT+wtRIbJ6p1T6qXzhtM94aWqmXRneBpySJS2H4IhoWKO6W6Mhd+G3uKVpF5wb450Js0XBOk2cbLQAgPL+rBkpBEHDmnOn+A/ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WLzow28V; arc=fail smtp.client-ip=40.107.130.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GajsE4SabuTo00LysWkIokVIzdIXEOdvCgfX+IBsdOfXIz+kSzUfsNtXaeLBPT5xTLyQU/tHKaKzJvmSkyljy86slqlXFWztI7hFqGPpeLnb5szDcYCerNBCcYfCgwU5X5naklVfyG90onjNF+WTEdeJVlSFU85IBCSWBmynOI+DQuy0HV2b4mBzqmSYP2lhE2wJwrZGCd0ydJ96j2wpA7ErwlEvzhmbYrxUNgSE9/JQJn9bkhS8NbYg25cQp5+jYSGW8DDSx/eowSF1qkewPtCPLqKw+oLbgDT+0gyYkBImhDmsMFQXv77kGHR5DjRe8z6K+L0i3s7ztv+ILr1bmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTCkxW5hj77uFMr8yRSkS/s9JyMlCe17E5h9uyjBN7Y=;
 b=nhrp6xg+vfeU9bCql4aCDsqipO0Y45TXFNz/NSy4NNlRM9Ur2TadQXKRkzKG6Hv77jzUl+T/Eq1Cv6EcS4SpQiRub0WCJg6QWKne3UFeLiYSoo3x9aFsx3mIa6f52HpNe2M7zRo4Xun9AvZ3Ah63wI+VkHWTCPKbiUgHT99+ozf3vOikXboCcsoOzcwE3GNUOXRKMJA+hDTXLuaqGXY7SH/uTJ95Kqz4mRwWsrUr7dHC2ZTat4kYYfpGHHIDg7koM/Cj7Ias/Cr2eqWddEiQQhH8QtbSHXoDPQx1rMUof90sQQdq4z+PJCKtqy1s2C++7awlPEOKmIIwh6xmBPXD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTCkxW5hj77uFMr8yRSkS/s9JyMlCe17E5h9uyjBN7Y=;
 b=WLzow28VbGji8BmfBg1Ebh/w6S0eYe7fIjFx/KuWZLoTvFOCjbLhNPE/o+RVmfZCJIOdbo+9aNIpjDpF3mFsC/64K7BniUR9qDvZqiWph8i9diAiZ8o7ANR2KYExpeJvw6wA+OawBLGxMJX+HG9vNeIl7DB4rAIenxomt+Rf1cJSFCTZen4T47SpTRTvvyfRfQT9NYAk54YSJz6BX4jWstXSe3jwy7RlhHRjXr82Ahyvy5WVrjCjTf25Mvx47wA7DmPHXT/+Y66vHm5AqUW/eYSOLCDKpXKTew60qfW36dP0/hZmga59Ik45P1f+1JlBC3kaL8GfTM+iGoPSuo4WgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB10027.eurprd04.prod.outlook.com (2603:10a6:800:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 20:36:01 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 20:36:01 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v5 net-next 5/5] net: fec: enable the Jumbo frame support for i.MX8QM
Date: Thu,  4 Sep 2025 15:35:02 -0500
Message-ID: <20250904203502.403058-6-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904203502.403058-1-shenwei.wang@nxp.com>
References: <20250904203502.403058-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::32) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI1PR04MB10027:EE_
X-MS-Office365-Filtering-Correlation-Id: 416792d9-cffd-4e21-64c7-08ddebf2a989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M2lNTiRCL11iJMOk4dNFbD1YMGw6V9b1zNJ8bEqbMraGbRer6szo5jDWOVg9?=
 =?us-ascii?Q?8P//j1L4NL4wwTTUJQ1qOfSw40iocqMRC+65RAPhpYMpXb92qQa2/Rqf+V54?=
 =?us-ascii?Q?NE8OfFqWN1ySGDW63NXfszZ4QAqoXWyAiSTnGxSjoYxQRHEyLFdpVbsfu29H?=
 =?us-ascii?Q?EenDyRStieyCSD4Q4E29m4lzdh33EvBIH2C5LVwjnB8lMCKjT0AA7XODWAMi?=
 =?us-ascii?Q?Lw6uZcSLoNtuymRyjwC6a8KfUELOK/rLnYS/cO/ZO2QdRc+JnjdVQyyo6L3W?=
 =?us-ascii?Q?2IxMETXTaiHKNB3yvRNDq6IJhskU9PM/3CjROLqLPEc1/jKAcluCHitSLa+F?=
 =?us-ascii?Q?ulRldY4aVPHbgwIHT6W1LOHroFz6hU3oQDjIA1l0Z4svDE8Kd3ldcZgr0LHR?=
 =?us-ascii?Q?ZWtWs24cNjNIRcKYamFrGoCfkfvutX4IZXUUjj9tvJOFZ0GBs36UYPGisykU?=
 =?us-ascii?Q?PyA108O4/qnHvG157A4VERXjGqho9qlein0o2jJr11Gn1AlyDLgMPFFlInrf?=
 =?us-ascii?Q?LR4jMBKd36ARwiahnFMt7X081homqYjv2ACyVwtFds5I5pRhgF9P+1Zjkf6w?=
 =?us-ascii?Q?60UGzLl7lROEP2AU9NcmJVMdbeyLkXEduTHsrLc4YRLNiV/E0gsV03fzRbv2?=
 =?us-ascii?Q?Lg0m5z+vTV/VJOOUDt0ZTXhFuXycDK6oD6EWW/bmcRn/UtHhshi5QPpnuAex?=
 =?us-ascii?Q?VG3CYf+OZJytMxYY6p6OodOQWzkPrxmJy1onZF6B14NxXQ6RarXopBrRk9X3?=
 =?us-ascii?Q?E3NhfiBSTNIm1jR/5TIB7NwfrCCrF1foOl/WK0jLWjOcRNTs36+Qp2LWJDhJ?=
 =?us-ascii?Q?EMtIVDYlUQiiLBNOZDvqKcUVl1FTpIF1cswiAr5H7GQQa4hW8yQ+GpLzRpm9?=
 =?us-ascii?Q?WBnAYl+65vY2DqobVn/ZxYx7s6AfVHLFla/rp3PK4oUASqEyAaVuwx4PXdUy?=
 =?us-ascii?Q?UokEO2DURtHf+B+gJgKgzzollzhn0URyhfrjGECgE7Qd4UjHlZH5UZA8MmEf?=
 =?us-ascii?Q?p8wP3CfhNXBJApgdAxEMmVS60vwSZCY3WkdLB6UpNjVECKygjg+KaZOGSaBd?=
 =?us-ascii?Q?uBILzsY4lf0B7eXG4RR2WzQy5A44+szdFZ06+0MBgm7gS3BjY0DDpKqpKhtv?=
 =?us-ascii?Q?IQQPHooDV1rLBdu7gEXT8rPH2iyV4xhqcGSa8UNL+9aOqxSsxGs0idx6qyDh?=
 =?us-ascii?Q?m2ku9S2P6om3bM9Zn8J3ZjAJ111d3eILQNhljYnv7Iw+wjOfrqVWDrxg5TSp?=
 =?us-ascii?Q?es26KzB7COgB/bqAngifu7FLt8xgupx1MckSoKnQXKnzu4Ofa4Cih1oWh1fF?=
 =?us-ascii?Q?iYE+IJtZ+G97DVC5pXsO+8JmSxY2MFZyCdRQymRMnGxMccobUmGwsQ197vkD?=
 =?us-ascii?Q?AAqFHOCzHxbxjLP1PJ6mICkwTpgbsAlA4B9VKVmxwhQpiy1BX/JplFRaWA5s?=
 =?us-ascii?Q?pFpT3zptOADnsTSCbYs9Ke9JqgHiNVJJaMw8jm7NoH/DFM6gUtn3mMPypzZK?=
 =?us-ascii?Q?QfcCxwiZzUtvgCY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gkBAc+u3S4TOgHSOSDoATRBIm2wE2uest1A/are8lTc62UjFxvFN/OVht/2/?=
 =?us-ascii?Q?nxo+CuT7n2craMuctR5Ve/7kK6BUsXJR+GzZU7qNXwq8S0hIv7AUySBFPRw0?=
 =?us-ascii?Q?N2uX6+RM9O9i/fuwShXh/WMab44zRDVt9euLRZa9if+PKd2U7SpUmM8Ru+Le?=
 =?us-ascii?Q?03l8TfZAXeoqpwm4JRUcfLpVUTcMNFFqMrUAxoiCnlq0VoA8u3aaMRifMyba?=
 =?us-ascii?Q?cWPqB+PV8vvmdfVuIOUx0FVtsYmduiBtxzLn0CZj0t60rA7kuEgrguYyeq1G?=
 =?us-ascii?Q?iUm8X7ruw8WX/lODqYzHYsCTn2AAhhO4tePrOAoimAzyG5YjXZ7R5V99wGf3?=
 =?us-ascii?Q?/EKur6BqZdK542gny2snWuGOsbyNguDqfdYXgDbIBk8w6bIDTYSBbJ8bt514?=
 =?us-ascii?Q?H6/y4qLc3sR88VMRVDWibiEtGc8qH0jmlEW42CyE2OZMk4G/crT5zYfJJdGB?=
 =?us-ascii?Q?b1GRpGLIcf9gYqpC4Xw0Rzy6C3oXDI6P27bmDIZAW/lbLeN799pCjD8q5eZR?=
 =?us-ascii?Q?NuEvKogakNu5HjhYoEidO3qhrE6tQ5utXK/sotwb+Jb1qN8H6NALBBrEjbtT?=
 =?us-ascii?Q?Mc8kpVtmbf15HpWquSfPfJVtaLYOahduAVJv06e+zeWHSjuAM5l1GDbJUGPS?=
 =?us-ascii?Q?0o87tf1Vusm41hXydng8RCNR1tRJmZNC2FIal2fgLaxyDS/+4Zmw7XzQ9Y3y?=
 =?us-ascii?Q?s+rLrYYnp6K1cQh2OgsggNvnDmIvJXQEf3QbVTbiA3rH7i1YveD/2gKbqrOE?=
 =?us-ascii?Q?+NPCgvlXfyv7WKI3yDy1xx38Ck2O+1ddu9ipX9JT3/2xxiZtZJLIDcC4LwGl?=
 =?us-ascii?Q?Ff+WDJOhkIIUmPsVZaiJarwD9SRnI0GcDkf6Ky8Xca3W5RIRxsX9FC/PUQkT?=
 =?us-ascii?Q?GHHnCcoMdihUuzrwySS31bp1asktxaRQ1C0GT0WBq4ehQcD+h3HS2WmVeSdt?=
 =?us-ascii?Q?mo55xVdV3+nnXWr1nJpYejXXdw3Ax5xLESG/wWzehbg0c0BSM+4LAy2hiTnN?=
 =?us-ascii?Q?Z90nyAfMs/sHAday4QVN8hUcTVCRZXPGA/fvCR7bOvAERoDJlr7AVgp8zmbD?=
 =?us-ascii?Q?aawuT+Y7VC6Jjf6506xGstgvLxdAy77hByBLVlNs54iXcnoR27j/CpGgD3Lx?=
 =?us-ascii?Q?9kuP/06DUnE6MRLvVbtAaXePShqCZAFueSp5rnWroyeYLGeZ+2KEA5SniLhg?=
 =?us-ascii?Q?z9UN497/9LjSTCs0LDI2fRh4vniN9zMi72HRB5gFkF4DP8BVXy/PRtYCQXw7?=
 =?us-ascii?Q?lrrBRitf/Ubb7CUVcf2fPRuyW+EJISR3a1+aBLFBL3oyljFue+u6btp6b2b2?=
 =?us-ascii?Q?rKq5MMORPwPAi2WH1+E08/oLV3mMoShpoCk9aMtMv5RdRUjO/O0OScnEKxwX?=
 =?us-ascii?Q?BwPD2g/VQCNSyZsUcf7flb2dBY6I77Ag6s0VVO6S6depvQ5zl95KvZNXGtud?=
 =?us-ascii?Q?U30ewCFVfi0oUmXvnTy39o7l3vnfT8X69HSyC/k+vF8IGQ2kv9qV4DQE2/dF?=
 =?us-ascii?Q?ShMZV2ri8UErdaJAeqNWu3dnoUO3PyRbRvlSfMfF8XCslxRoQgYvXA/6a+tA?=
 =?us-ascii?Q?cLCCwsYFJEovZ2KhCWwRHhrY/ESfW1Tsbnzx8CjF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416792d9-cffd-4e21-64c7-08ddebf2a989
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 20:36:01.7206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mp8/N4bFY5OFiXelCUT1maf9ZndJjyAKDObrOJqcvhQtxYkJ/0epaE9kZqpR4TCfR2PFtzSuQoWChomAgYyc6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10027

Certain i.MX SoCs, such as i.MX8QM and i.MX8QXP, feature enhanced
FEC hardware that supports Ethernet Jumbo frames with packet sizes
up to 16K bytes.

When Jumbo frames are supported, the TX FIFO may not be large enough
to hold an entire frame. To handle this, the FIFO is configured to
operate in cut-through mode when the frame size exceeds
(PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN), which allows transmission
to begin once the FIFO reaches a certain threshold.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  3 +++
 drivers/net/ethernet/freescale/fec_main.c | 25 +++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 0127cfa5529f..41e0d85d15da 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -514,6 +514,9 @@ struct bufdesc_ex {
  */
 #define FEC_QUIRK_HAS_MDIO_C45		BIT(24)
 
+/* Jumbo Frame support */
+#define FEC_QUIRK_JUMBO_FRAME		BIT(25)
+
 struct bufdesc_prop {
 	int qid;
 	/* Address of Rx and Tx buffers */
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 295420d2b71b..bf854abf982d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -167,7 +167,8 @@ static const struct fec_devinfo fec_imx8qm_info = {
 		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
 		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
 		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES |
-		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45,
+		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45 |
+		  FEC_QUIRK_JUMBO_FRAME,
 };
 
 static const struct fec_devinfo fec_s32v234_info = {
@@ -233,6 +234,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
  * 2048 byte skbufs are allocated. However, alignment requirements
  * varies between FEC variants. Worst case is 64, so round down by 64.
  */
+#define MAX_JUMBO_BUF_SIZE	(round_down(16384 - FEC_DRV_RESERVE_SPACE - 64, 64))
 #define PKT_MAXBUF_SIZE		(round_down(2048 - 64, 64))
 #define PKT_MINBUF_SIZE		64
 
@@ -1278,8 +1280,18 @@ fec_restart(struct net_device *ndev)
 	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
 		/* enable ENET endian swap */
 		ecntl |= FEC_ECR_BYTESWP;
-		/* enable ENET store and forward mode */
-		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
+
+		/* When Jumbo Frame is enabled, the FIFO may not be large enough
+		 * to hold an entire frame. In such cases, if the MTU exceeds
+		 * (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN), configure the interface
+		 * to operate in cut-through mode, triggered by the FIFO threshold.
+		 * Otherwise, enable the ENET store-and-forward mode.
+		 */
+		if ((fep->quirks & FEC_QUIRK_JUMBO_FRAME) &&
+		    (ndev->mtu > (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN)))
+			writel(0xF, fep->hwp + FEC_X_WMRK);
+		else
+			writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
 	}
 
 	if (fep->bufdesc_ex)
@@ -4614,7 +4626,12 @@ fec_probe(struct platform_device *pdev)
 
 	fep->pagepool_order = 0;
 	fep->rx_frame_size = FEC_ENET_RX_FRSIZE;
-	fep->max_buf_size = PKT_MAXBUF_SIZE;
+
+	if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
+		fep->max_buf_size = MAX_JUMBO_BUF_SIZE;
+	else
+		fep->max_buf_size = PKT_MAXBUF_SIZE;
+
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
 	ret = register_netdev(ndev);
-- 
2.43.0


