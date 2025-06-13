Return-Path: <netdev+bounces-197396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD05AD889B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5B5189A95B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 09:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093132C15B6;
	Fri, 13 Jun 2025 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bAt4K4n6"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C972C15B3;
	Fri, 13 Jun 2025 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808608; cv=fail; b=afIresinfzxmBDRoSRCsWtKSi40WMNMuI2bV592VLgZJqFgC7uittkWNxpWq/M0YRS7z6kjxFx2Ebe1DUryTlFzD6B747fFB4PL6mbOVA/2tPnuPxBmEaL06d6bIwSnOjy9G1V1Vd0F2XEbnQwxYcbkm5XjLhfL3HFHFmacW8sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808608; c=relaxed/simple;
	bh=xErebxN/v0nlpKGeazrYorx94qUzGGpOlgVEqf/MhG8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=T6rSKXthZt6dtmgTCOeJ4e8IRYHwRFBlz2kL3gJ/JdcbjauArjjMKB+y9STA2D92rSKwUhQ5e0wY32Hpi+GV9QGYbpQgzRDh99/dmRIgjzf5ArkXEXcJYvbfRSjP5I+HR4Irwo4T2OaZzEJuA6w2slBLJbha9AOuHEPJkbLqsfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bAt4K4n6; arc=fail smtp.client-ip=40.107.162.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwgTJ6CWWvpKXm4FhXAeCLa+ydsRvLYhA11an+jloVJDYM9x26g4i1anBlwBumhytyo+b1mi9ROFj3Q+DfeXuGWVJ9c+LplJLNY5yWt944QoeL7ExQ/Y39H1XydYa59kdYuUxpvwh2MioddGcCk4fcCktKY3KvrgS8y06fOGAX7oFlcw1xCF8aHcw348RRtcr0hXfUlOwrC/hXkL9tR2+B1+XvN6m9TeT99fTXbOP2Mp4WqfKSA/PCLfo/aAfsCHoHHw4IEOLeAbC2rJD4QBp6z7LePkp0fz2DIbW0M4tindPox0YH8Fdg6WCpwkwPRftL/nF7w9fLF1sUfBpMiWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/oq2gTWGGCTnp7Edd1gANJoCRjc/sTGEDXJ3aG+6sI=;
 b=XDbWLbBo4hbPAIcj2HozJVx5n42ttXr7F+ltZR3gaJWTv0hbusMJtSSMukjpT8rKoEcAcnDOXLhjKuLm+iKiWpMMUi4B7QnsDjjWXC9eCXsGdvgCR4h0X4hv8vczuLwNqVBFZirZr0JBJAZ3k5/W8qh8opIpEvJGJwMcRYbHnDub1kTQ0Vu21mSYxqp31ecZHIM17zdTWa6fnu3Bgo0AYzmEbGDGa12ENeVp4Nl9t9MZXAatqqKElEk3/0L7IQEcS23Tt3b5/YnyhXxm+w41rIfYPp45XR0yIqvGedDxCKh2wWz+8lr2JNB0ZchuzsDNbe25GYoAh8AVrmreZnK9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/oq2gTWGGCTnp7Edd1gANJoCRjc/sTGEDXJ3aG+6sI=;
 b=bAt4K4n6AcXti8bI2/5mTPTiz5RctV12T960zYcdD3bRXwz/XSDANDbuo0kKMtCeoYTOTYFvlw4JnQRr2sTvE/nzCDnCEccNYnBVjPp7+50nylB18tlgW3ALbQpxh0KlTriVH3GzcXawHXzbcDQqg+HQW/SOGpHmbCi3q7Z/VcuJ/ubSAhOVv2aKCIBPHX5aoqBH2WJkne5PLICEqwhfkx/M+MbpRXL9LO/Tm8kuB04wHHU3qNr7sT78TK07xXREzbv/n6A6kmL0/b2Dp7U1VKAxYUaoOiUiEyXByaHEEp9OzLSZ52ckNt71jS5sLB5Y56ew1NYd0dL5iYoMvvveBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB11000.eurprd04.prod.outlook.com (2603:10a6:800:268::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 09:56:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 09:56:42 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next] net: enetc: replace PCVLANR1/2 with SICVLANR1/2 and remove dead branch
Date: Fri, 13 Jun 2025 17:36:05 +0800
Message-Id: <20250613093605.39277-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::8) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB11000:EE_
X-MS-Office365-Filtering-Correlation-Id: f3cf1489-5a85-444a-0dbb-08ddaa609922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Rzve0rwafDRfKmVsTrfilC2xcf9KTLweYIhBIePd6UWx/fD8ES+IrT5U3Ue?=
 =?us-ascii?Q?MYZ6MEbiOdYRNJf+1M+4ZVBp2QK6IAcfi2flpKqxvO9zRUqxa9ZFfLzYZXry?=
 =?us-ascii?Q?/NFoeEV0E0yswqsKvedyYMpjA+NTyc/G6el1z4pRcXgvGnmVhP8ZJhGiG7Ug?=
 =?us-ascii?Q?bv8sIiKzyXUwwh/Tydcem5hseYyWLvESD+qlUh4unj8YNqI2BwqfcnIxWsGD?=
 =?us-ascii?Q?NYjQ+7ltUKOxJgHh95GHtgXLCMuNTt1YkK3VL4Zbcq9TUcsQwEdTHnRK/TVz?=
 =?us-ascii?Q?CUOHzlLfmIhzQPNJztL6PjJ394h003YArA8AFUA8k4OShRTHDw72itiWpNhe?=
 =?us-ascii?Q?R/D2jSTnmhg7Vc8V11f5jvVeysYIcMDFnCtzppA6Wy7LUimvsEaQbBhQEJrg?=
 =?us-ascii?Q?U2ZAqdgQchhbiqfK9n37W2ky27XguwmFZiSsE055UzBsXubwFVjbzryP3+EH?=
 =?us-ascii?Q?2ZP7x/bcbWNaYoC4UorCbavs9tjl9rFdIiSExuwDTCFZScof+qyZ6WbUNyUN?=
 =?us-ascii?Q?HGlO4Th/qbfq6/wcLCy660gi8SesOtmlGJniNcoLaI7zAzOYZQzJPGIYvgKg?=
 =?us-ascii?Q?ycKiavJGmfcmHenrEcfU9BUFzXaTvBDW/s59rKKKslg+//trhXJ+tVSlvHvb?=
 =?us-ascii?Q?xR29w5urcyqCIph1FKwRuiz5VGB0HTBEabRzqD81EWXA2kQaIuoKEQApnQkY?=
 =?us-ascii?Q?9aLS49ez47TKoH6Bj+fpHNoMfSLvwfmFz4QGJH0VXxhTZFE0y2U4T2eLosUt?=
 =?us-ascii?Q?fKOlUZOWikAlkTAl7KwRZ2E3En12rDZy2TkcCJEPSnjlICehuPFAZXGjCxlb?=
 =?us-ascii?Q?B5qdck5DuNUY0+1UhIP3I8NWGTJx4mlWquxopn+cKNmfMOWF6z7kds5NSng+?=
 =?us-ascii?Q?RHogLI86O5MBEQ+TA/rzmkN8tkVkvpFO+t6E+nEMWs3uT1HkCdoD3i3Y7lf/?=
 =?us-ascii?Q?Clo5thNr1ogbN9f22KqqdpfthzWciqZD+AAh18aW9jt3uvOMYH8UQehY1pER?=
 =?us-ascii?Q?rn95fwcONoZ7PSsXTtb/UemjeOdtY2m1UP5eqDhQgIfugFTay225TFAsX0MB?=
 =?us-ascii?Q?WIQc7NGQyd/CCn8Ekvs26eLFXDpqvPJVOFsz8iG16Kw/7hMWPNzcPVvYgrp9?=
 =?us-ascii?Q?YRNfjc4mhL3DwIzoi+dVA+LebfLHNHbTU2ZZrAwU08Z5Bd313DlxM5ylQxmM?=
 =?us-ascii?Q?V39z4Ywiqg06GL9gL1t5Cuqc+1N5OM8PPZUvSAsflryvrqzsDxurA6Dzb/2J?=
 =?us-ascii?Q?dAtTmcBRprViLUEiAHSgFHrQxt66/jJfQKnlfd3zX3Kqu5V1eo/FvrZZp6xb?=
 =?us-ascii?Q?7lQ9uRrHLDozbPUZmxuXpLobW+40kGA38HlWGCQH0HhZJBlXb0Gh6bj2549M?=
 =?us-ascii?Q?ahf2pGbNYkE7KvRCVSWwWazMLSWqV4LW5aJuKmFR2UC8Kn+TT33ZtjLXeRNE?=
 =?us-ascii?Q?6G+57nhp/+puiCtdRl605HobBk77Nsr2+U1aGQYPSdIPb0StXEsp7sVUS5+v?=
 =?us-ascii?Q?rDbQyTay6V0oBcM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RW1IQceMK/bWOle8oYtiz4PzR42kVjSG9COl5/SHW1h3BsH6hr3I+F1oiQOI?=
 =?us-ascii?Q?Sy26VeLym4+r2Kuwa3fIYta625hCR2R0qx3c5lVzqb0t9Tgn1Y+9BZ+FOmuv?=
 =?us-ascii?Q?I5HvbR3U32K5IldVDsMAHJm9SoPUKRpRqCMVNXQ6l9O+Wdz57SDG5QkuAUZK?=
 =?us-ascii?Q?zjc0ySilHa+4h2TzPHPUt+eAoJqJTfx9AB3ClyTUgSz9TusAvq7Vf2eG4uCa?=
 =?us-ascii?Q?12F4jcUPVvqYDeBWfDenU9YtjR/MDDccpFVvDPimZJPnEU3PATXXHHF9Sckq?=
 =?us-ascii?Q?MszzofY+ThysIrQl65Uwk53RrF6rbHUlPAHTkhMWGqfNXEMmptDahfwcwARH?=
 =?us-ascii?Q?Piv5M44V4ZD7LA6PT+NXBw9tscekTSA/n0HufyBoheVeCrd05jVgJcNCJhP3?=
 =?us-ascii?Q?a/vHR+pQks342qF7yVn8xlzziupU8VZwFVSTgoVaGzt60F/ktAH2iWPvEzJr?=
 =?us-ascii?Q?JVgZZF7oQ2ld3JSBem/AAx4wNSZ8voucuFZSopxAeMxcxkUTsnWvLGe5Rf6g?=
 =?us-ascii?Q?uZ5tlXqXlUFmv/QV2tDPFf24M9ECoz+515R/uggPj5LLaNUjDj5vWgDsxEjs?=
 =?us-ascii?Q?uWNbY1gyME2xAxtyBBs6kfZWZQpAcTKex7H2opQuwHbao9b0/3Wb632x0ZMn?=
 =?us-ascii?Q?rrZ9Qyy5shrJIulKE/gUVLuhjfKUA/lc37el7JJ7gxS5gGy9TyzvP9ZTb3V+?=
 =?us-ascii?Q?v53e3VMpSm02XRMty3rfFBB2YBo8zGrci+Zh7azn83ERVP7+USbu5e5h0c4U?=
 =?us-ascii?Q?laEeDX8e1DN4T7o9xnGd+08lqCGmq1ktp3roTrIHozUUL4X78DttKJGYbxWn?=
 =?us-ascii?Q?1CWDhmuyhNcKQ24yE62rqYQx+53CALho3ynekU9CEX4iCUxkcM2Okj5MtwoR?=
 =?us-ascii?Q?CODG9k/9FPPCe8RAr2IOQiHGMIFE38e5WbAxaWctspMAGgRD4Mw8sR3wcvUY?=
 =?us-ascii?Q?Sxi85SA87TyJ9e/bJyThgYJJL7TBA2nxnLWRcIOX6vigPnxjhhsn+6glEBtF?=
 =?us-ascii?Q?30hjo5FADdkuPs1h4wl8BNyJtKf82QKaw0pJw74eC/5VxR3XINZyhOJcGcEj?=
 =?us-ascii?Q?3BnfWTU59A1BKWapwoWsmS2tDjbWLNqL+PG2w6UsVs3W7i2bIAItIxFn7w+K?=
 =?us-ascii?Q?B8JSzV1sPJcpqoPealoltn9LlPtbPJ6mzttrsTELRAV00MXDwkHkDJfuiuIg?=
 =?us-ascii?Q?J0jdmaR825DUznzHgKpiyKqxvLkpBywG3ocO+GanJ9yqNKcXCzF2Y9hdQnyP?=
 =?us-ascii?Q?gRQq+QcPGX7mxZfHohC1ZqL0LGL3HOTn8lOTORinAsevLqUeWHF0Y6maReqb?=
 =?us-ascii?Q?lTkzYMoZB5kbE2i+x+Zy1rVJ2w5WQ3JKdU9HqtkaaFOK/mIk6N3Yf1522QZb?=
 =?us-ascii?Q?XoJESGQT4Mizv/6AxqsPuiCpOLkNr6Aehz3Bvv+FKrplb96pNtSvaDKAEn3w?=
 =?us-ascii?Q?QgnAvBP+WGaQwMYqBTvj12PNclmxM8QQaN+q3V/kqelP5JtIDe2RSRCWrd+r?=
 =?us-ascii?Q?jKCCuDSG0oAGkrd3SrjWOj3YDdRSz/Yz0AgWANQa9flJO7LA+gdTu4Yx6qYL?=
 =?us-ascii?Q?B/pEgvTeeYs2E2CGwx+ROQzqmlxWH+gc52sd4/Yk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cf1489-5a85-444a-0dbb-08ddaa609922
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 09:56:42.2716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWoZkfdQXhNW6jP3ZhVPkv5zqqUX1UtRpbujL9uOM+kBiIzJ0Ym4feojgOKj9BlBU8Ll+pxuhaf04G541kNtjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11000

Both PF and VF have rx-vlan-offload enabled, however, the PCVLANR1/2
registers are resources controlled by PF, so VF cannot access these
two registers. Fortunately, the hardware provides SICVLANR1/2 registers
for each SI to reflect the value of PCVLANR1/2 registers. Therefore,
use SICVLANR1/2 instead of PCVLANR1/2. Note that this is not an issue
in actual use, because the current driver does not support custom TPID,
the driver will not access these two registers in actual use, so this
modification is just an optimization.

In addition, since ENETC_RXBD_FLAG_TPID is defined as GENMASK(1, 0),
the possible values are only 0, 1, 2, 3, so the default branch will
never be true, so remove the default branch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v1 link: https://lore.kernel.org/imx/20250530090012.3989060-1-wei.fang@nxp.com/
v2 changes:
1. Change target tree to net-next and modify the subject
2. Add a description in the commit message that the current patch is
just an optimization.
3. The definitions of ENETC_PCVLANR1 and ENETC_PCVLANR2 are retained
---
 drivers/net/ethernet/freescale/enetc/enetc.c    | 12 +++++-------
 drivers/net/ethernet/freescale/enetc/enetc_hw.h |  3 +++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index dcc3fbac3481..e4287725832e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1375,6 +1375,7 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 	}
 
 	if (le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_VLAN) {
+		struct enetc_hw *hw = &priv->si->hw;
 		__be16 tpid = 0;
 
 		switch (le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_TPID) {
@@ -1385,15 +1386,12 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 			tpid = htons(ETH_P_8021AD);
 			break;
 		case 2:
-			tpid = htons(enetc_port_rd(&priv->si->hw,
-						   ENETC_PCVLANR1));
+			tpid = htons(enetc_rd_hot(hw, ENETC_SICVLANR1) &
+				     SICVLANR_ETYPE);
 			break;
 		case 3:
-			tpid = htons(enetc_port_rd(&priv->si->hw,
-						   ENETC_PCVLANR2));
-			break;
-		default:
-			break;
+			tpid = htons(enetc_rd_hot(hw, ENETC_SICVLANR2) &
+				     SICVLANR_ETYPE);
 		}
 
 		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 4098f01479bc..cb26f185f52f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -43,6 +43,9 @@
 
 #define ENETC_SIPMAR0	0x80
 #define ENETC_SIPMAR1	0x84
+#define ENETC_SICVLANR1	0x90
+#define ENETC_SICVLANR2	0x94
+#define  SICVLANR_ETYPE	GENMASK(15, 0)
 
 /* VF-PF Message passing */
 #define ENETC_DEFAULT_MSG_SIZE	1024	/* and max size */
-- 
2.34.1


