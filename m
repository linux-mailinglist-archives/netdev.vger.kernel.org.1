Return-Path: <netdev+bounces-146147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20229D21BC
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766E328479D
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB12B1C173F;
	Tue, 19 Nov 2024 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oOpA9u+C"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5520A1C07E5;
	Tue, 19 Nov 2024 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005600; cv=fail; b=a4bza6gIIxVBz0KXr3tIKGUuV8tVBskEBApx7Ml/CFAqFRGl5RuoJKjYtL6Q9OIIYj+pLKbhctZ5A486/yvFAWgJi46QKgMVfso68Yxm9btFQHVykIDfrHf96C5n1cEACINE4u48dpkrJyriavasgWU2BneUgceaYqModMwccFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005600; c=relaxed/simple;
	bh=0zMCVcmhBjEAQB56ErX+Pg+cFqK8kJANGeBxfRcdOjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PCGuenVpcB4vzmqLXN/hI/FYHFK6KLtwQTIyEw/FfeQxYwUisNcBVsVRiv41NACwfaTUxY+Ld4ujL8i5MugPRsI/+1f1V7vsLdtWH9sHNrxDqM90H/x1grwBkDe1iCty9KJ2eiWbpOGh4ghUclHUNlKBmPhQTPBQ5IyXcXVBIhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oOpA9u+C; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9ibG0wfXtDiK/Dw/BeWA5IdFDgRjWhw8co0nRqzV0PEy9eTrSqhdsirgjxX3pd00ZQyQ3hnG4eh+AZtLoC4SC8VCSa2RrfqzVfx5P3ivhsI/ISKq8GAoZiF5Bp0dCcSuANUOC2/S2smMtqUw/O2R9y14JT8APznCPwAgea2zcnrQiEEaUdds0N08crcBiGK2oaqFP+6eKuWsoxR5Er21Gk3Bu/nMR6nwAXLext6fghYoYkRpLl2/He6BSgnFUmgfk4pbXAzVK/TBtrnfKPu2AF2tZiDQhSXH5Ya0L78i2ImWGeGIbZRIHWBM6ZiRbrwxfl9hkzg3GecSf0yZxQRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/AfWydI4suESLBCktZljT3VITlQfc8BgObbW/0oW4c=;
 b=KJsrBfsnpVHAxdbX1rWNUb9JhVpzAydPJH5Q//wZLFFw3aL6aaiJbABiufEt7UqhaO9/7UuApNHCPqRn3wFeqfQ5MmRO/B+gDssHjVUxm2jdIVkHsA9e3U+K75to9m+RgBI8hpmsfFw5EL80A5I7UQ1d2iS1aLOft/Vz9OhqjZlJdG+SjvvnZyhjZDEr1jlK1Cr+63OMFOdcFkKzOh4DTy8asHXSlZuiGOMgKXm/nHzrPlbn0aRSJCR1/hd+s+Xj76KlwSq5YcNMwKMW5nrKhAZ1Z0D9xxKsyjTLVeyO3TB0XRIhtDRO86NMCbAhBZnYJp/S3AYJQDcV1SVyVIng8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/AfWydI4suESLBCktZljT3VITlQfc8BgObbW/0oW4c=;
 b=oOpA9u+CdTJd2wq+WsgQeHknTlCpOccFCj0yfcv5t0ibsBqntsfYPJRicZ+5azK9ucACEV+t8nwku2jakBTO/+SpBmcq9RMUyvR4mEBWq9Yz8RWYmwZeLEP0zdHJshBHLd2WdjvrWsR81nhTjbNzhDmuiXENnp0dPcm3r5ZmtGAxuRP3gQVEtpAIGFGBcvpX+fWqRc6tuAHJ8IUYSlb2MTaGIhGz09EOPlxbgbaP3cfnnB8Epy8MoAFZrzbZHd7LO3rVvVZLlzsdaS01m4MeX02pAcN51ZC5fZoyZyRfD/9kB8YJsK7nG1R2spIUBiXETpBUJT9vUCzpPSNh1aqhBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7160.eurprd04.prod.outlook.com (2603:10a6:20b:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:39:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:39:55 +0000
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
Subject: [PATCH v6 net-next 4/5] net: enetc: add LSO support for i.MX95 ENETC PF
Date: Tue, 19 Nov 2024 16:23:43 +0800
Message-Id: <20241119082344.2022830-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119082344.2022830-1-wei.fang@nxp.com>
References: <20241119082344.2022830-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f63627-f134-439c-2546-08dd0875bdec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7wowZ3jOappM0hwFTRbuXtIgM5P3nrgJVLFOXqe7ez0TKEq7yaObi/4elVgD?=
 =?us-ascii?Q?eCy0D1e9z1ZhvJcI5XSKGiSfPauwUiPv6U4TuFiXeI3b+q76u8Q+lZ3yZrON?=
 =?us-ascii?Q?2pb27OZpPVW5+fto7SiTy56U/K2Zs8Z3mdtV8ZVkxIKXVfOma1bbcu9TCuQD?=
 =?us-ascii?Q?/Z8phAvk54NekV4oqkPal+sN9bLtuBx63gBnqyKvRVWO5PiuRFhbOYsVtdZk?=
 =?us-ascii?Q?c0BpU/CR64eX6yGYJ6/Nvh9uXHm+l25hhDGOvua/eNxFY/Zi49eObv6qK24v?=
 =?us-ascii?Q?Je4T/7UVO6FeHpoBa6YUm7wReNLunE0OqC/DKWBr9iHYBtSxAK3xdyX5bLY2?=
 =?us-ascii?Q?5K7BMnpSjloeYLtPkdFsjlfsgRjV/Bvg8jnamhaCRQxaWPC2qsHXfxwNg81l?=
 =?us-ascii?Q?TNLAqkm66P8LdSONLs92QJiv4YODb/OOgsoDihpPbJfIEKwnvp209fIL6CKz?=
 =?us-ascii?Q?NV7Di4tndiLoX7FNlNeIrBoYrbwGx7rXynV9vBI0M/L5cEKqUB8gWhddqPZp?=
 =?us-ascii?Q?WE0Il8nReQtxZlw5INXUFt0dadH/bLbROUfxwzdkmkKTtAh8VKON0SdKVCI1?=
 =?us-ascii?Q?7xmsN4EO/QJO+DVa30NBFI1G1PhfuarCnHFGblQLyahYq81WrBBJLvSbzNDq?=
 =?us-ascii?Q?uvKtrkQrtZZ4BMDm7azUPG1e/Hp2gS1SVS51de3lH5g3hnhaPuh8TyhbOXp5?=
 =?us-ascii?Q?sigIgFgYk6XJhED5ATSZJ8wZHDADGEPrtrTZMIwEc/8FIBDiPF+5o9OPvYTB?=
 =?us-ascii?Q?rE9UpwgaJKJQoVHDFFjeU5RR6L3nSkoPPGIu0nYiuA6X4V81TwPccfafJL4W?=
 =?us-ascii?Q?ow/KA4zVtKCHxKOjiDNe0Q4mKeoVyIV0PQu9ZjK8BHYPw/4+Io6ABhnulmA/?=
 =?us-ascii?Q?+kyei49lzgC/2eovSyIVL0QG41bNoyD5ttODf47/y4F7SBD99AfKGr6riFlz?=
 =?us-ascii?Q?Ykxok9KXoDbvkj2EuRyhv3vxLRl00iu8U9zeGPdcYX3snb6Ew+10m0ZghtrC?=
 =?us-ascii?Q?jNoTnNA4oaE1w4nQ2q71SQQfiw/9Psk/lqd3SUKNevKjWpLN8Wd5FA50WZMg?=
 =?us-ascii?Q?dDQWR9Vbi7oH3bcYrtPoJT05ym07wLSIaR6Atjb2wfMkjf84RBQjcARS1HxK?=
 =?us-ascii?Q?S/NzEKw3m5/HXpIxc6U1IVbmPZ1PNJ41/HPBCNH1/Fpeo2EiJWffcQVuU2/i?=
 =?us-ascii?Q?lN8SGdNNlK5qw9LduLsaDK3l3ww6zP73bzEFl0MfgpR6AXx6R/Yiok+ik3zd?=
 =?us-ascii?Q?tSKe00IRiPKos8E9TT6nbepOrlpT3LbIsxeZRJZklukmDzmAqSwvCb+tBSOQ?=
 =?us-ascii?Q?Oa4F4bzSINS/fjiDfYund+tnX3XatXALRvVTP0onfQmYxwOsup3lZ1kmBRmu?=
 =?us-ascii?Q?dRxE9AU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X2okPq4ZS1dxKpIq8AbIUijMDFxA5Cod+2x4ygbPWxnN7Gyzq3U/RGVWY4qw?=
 =?us-ascii?Q?LeSoyxMPwNsMD3WA3K2nQVMve5BhTN6zMyIesOmd+SXJk7o9ejhtiXEOVkri?=
 =?us-ascii?Q?w81XcYj1Ew1fUSGTwuohHLDNg1aZh280LP7QMGK7T4qLz2GmfC1BkF4tL13d?=
 =?us-ascii?Q?EuhkFhmaRKitQO6+xSi/BWFhfyQc5d8COb2e5vAsldK64gNv9OVejihMZZNb?=
 =?us-ascii?Q?uyVBrfHM829Fp0/Sv/y/X4/sg+bNQ+KEDci4EokDqUfL6l8lqzA5rhNWa61W?=
 =?us-ascii?Q?BR28gcsVCcLvJ7nPl47rBq5q0xPHTmRT2WgnRIN+/bZVbk0Ds/h6e0aYjcLZ?=
 =?us-ascii?Q?1GKjbQ0Tvl7WaeSk8bHgo/7Ivpdd0mWnEyC3JiyVSc8Dx6Rgnobb5E4vlTKy?=
 =?us-ascii?Q?zPLLG+BhfYa6fN446yqjr2VH1GaJR0jqMGwjQ6q7OymqpMbjIA4x/TUvbwbo?=
 =?us-ascii?Q?OBtEUW+1BeoVA2Wu/2KROZ5lLZmzPQ4pH/e9mExkScfMVIRMz6WlgXORUfNH?=
 =?us-ascii?Q?4UF4IOLRD/zH4eY6XXMxC8uODr+mlDkNpMr5g9YNpznFHPbsSjdwss24SLv0?=
 =?us-ascii?Q?7kbgw+foOymNSVuNBLhMua/HbmF07cEzLT/1gdOBP3O0DJO9QAgwhIyAZXzc?=
 =?us-ascii?Q?CqWdBdNmffsJCLTPRbhdHOsNUF4uny62F+Chb4nbjZ024ayryno64/VWndru?=
 =?us-ascii?Q?J8y9lfpWjrfDMviQU10y4PvnLgvZndfkxEWUTnQFxTeOE/uo2i6PjZyj3XTX?=
 =?us-ascii?Q?z5R1wJOqW/IRlyYXYvxKo2uHIQaCAEp1cJXrLlhZXwjyXF1WdMyPptH3wpnw?=
 =?us-ascii?Q?DrI67yx5Vw68wH+x6y23n5p/NI0iv882Z19tDMI22m3ouJheOUeRnf3jKzPg?=
 =?us-ascii?Q?/aNZCumMbznF1/DcJMS3FWv7MNoWoYNd/VQsi12vbkHmh6ujDOuDApPN41uz?=
 =?us-ascii?Q?e5i3euxAVH/3jIwq75p3a5onaWSQLI+FUFiUbdvuRxnVgTulV1r5Kd5vhIuN?=
 =?us-ascii?Q?IQTLGqS+6wBi4abul7wNatS9KgruA6+Mmuj8o1q+hzt0BMyusw87coHiWvZa?=
 =?us-ascii?Q?qNRsjVW0I6g7zEAB9kFGLsTKWEu/zSkJANnrEJ9UiUc5EIGhLOOkyqewTAE2?=
 =?us-ascii?Q?Cn1YY4dlgLTKHKAwuxcC710IKiDLQbEyqh4/BjstYLp/UkyFOw330FD2j8Ui?=
 =?us-ascii?Q?uhkoxtflgZmWJ3i1LJX9se1v//gNz8C0vWMph3fKPQPNiDkjsWU1IE1zzn3A?=
 =?us-ascii?Q?HymJ5uUsBa0dLHuWEtizRt4CrGIuDfDwllXQeC7MhMTtmal82wxKk7ir3ahP?=
 =?us-ascii?Q?JNBQBEiQVwhurTKLil0CUwMprDI/OsDUy08jfrGj80nLQbHHrIjBBC2ucHTc?=
 =?us-ascii?Q?5+v8dC8+0m2UsOqg6eEjG5y/WY55BKQADmtZZ78gpeF2H8s1bvK8HMtwwdkD?=
 =?us-ascii?Q?UpdNSltAtgqCQ3TYj9bltDO2NhImJxtS45v57oF+qT9Epa0sta7CcztLhCAX?=
 =?us-ascii?Q?LDGozxozOWXQcIJD3xY4ecbpOLRX0lt8lY9akJGy+DMHUOP2GpLsikIxVmSm?=
 =?us-ascii?Q?+MoXAiJIWxIJSPY6cMy4K5UEsRNI5a2R3xOTw3Wz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f63627-f134-439c-2546-08dd0875bdec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:39:55.1125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2WSxpHyJdTfYUWpagHhmZhTPdsFRrB75kwVbnYPU8+NAt9OeAZTFTA0p/sJeRIj44Z8x79PqSLGEY4wAKICjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7160

ENETC rev 4.1 supports large send offload (LSO), segmenting large TCP
and UDP transmit units into multiple Ethernet frames. To support LSO,
software needs to fill some auxiliary information in Tx BD, such as LSO
header length, frame length, LSO maximum segment size, etc.

At 1Gbps link rate, TCP segmentation was tested using iperf3, and the
CPU performance before and after applying the patch was compared through
the top command. It can be seen that LSO saves a significant amount of
CPU cycles compared to software TSO.

Before applying the patch:
%Cpu(s):  0.1 us,  4.1 sy,  0.0 ni, 85.7 id,  0.0 wa,  0.5 hi,  9.7 si

After applying the patch:
%Cpu(s):  0.1 us,  2.3 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  2.6 si

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: no changes
v3: use enetc_skb_is_ipv6() helper fucntion which is added in patch 2
v4: fix a typo
v5: no changes
v6: remove error logs from the datapath
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 259 +++++++++++++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  15 +-
 .../freescale/enetc/enetc_pf_common.c         |   3 +
 5 files changed, 304 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index dafe7aeac26b..82a7932725f9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -523,6 +523,226 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 	}
 }
 
+static inline int enetc_lso_count_descs(const struct sk_buff *skb)
+{
+	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
+	 * for linear area data but not include LSO header, namely
+	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.
+	 */
+	return skb_shinfo(skb)->nr_frags + 4;
+}
+
+static int enetc_lso_get_hdr_len(const struct sk_buff *skb)
+{
+	int hdr_len, tlen;
+
+	tlen = skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struct udphdr);
+	hdr_len = skb_transport_offset(skb) + tlen;
+
+	return hdr_len;
+}
+
+static void enetc_lso_start(struct sk_buff *skb, struct enetc_lso_t *lso)
+{
+	lso->lso_seg_size = skb_shinfo(skb)->gso_size;
+	lso->ipv6 = enetc_skb_is_ipv6(skb);
+	lso->tcp = skb_is_gso_tcp(skb);
+	lso->l3_hdr_len = skb_network_header_len(skb);
+	lso->l3_start = skb_network_offset(skb);
+	lso->hdr_len = enetc_lso_get_hdr_len(skb);
+	lso->total_len = skb->len - lso->hdr_len;
+}
+
+static void enetc_lso_map_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+			      int *i, struct enetc_lso_t *lso)
+{
+	union enetc_tx_bd txbd_tmp, *txbd;
+	struct enetc_tx_swbd *tx_swbd;
+	u16 frm_len, frm_len_ext;
+	u8 flags, e_flags = 0;
+	dma_addr_t addr;
+	char *hdr;
+
+	/* Get the first BD of the LSO BDs chain */
+	txbd = ENETC_TXBD(*tx_ring, *i);
+	tx_swbd = &tx_ring->tx_swbd[*i];
+	prefetchw(txbd);
+
+	/* Prepare LSO header: MAC + IP + TCP/UDP */
+	hdr = tx_ring->tso_headers + *i * TSO_HEADER_SIZE;
+	memcpy(hdr, skb->data, lso->hdr_len);
+	addr = tx_ring->tso_headers_dma + *i * TSO_HEADER_SIZE;
+
+	frm_len = lso->total_len & 0xffff;
+	frm_len_ext = (lso->total_len >> 16) & 0xf;
+
+	/* Set the flags of the first BD */
+	flags = ENETC_TXBD_FLAGS_EX | ENETC_TXBD_FLAGS_CSUM_LSO |
+		ENETC_TXBD_FLAGS_LSO | ENETC_TXBD_FLAGS_L4CS;
+
+	enetc_clear_tx_bd(&txbd_tmp);
+	txbd_tmp.addr = cpu_to_le64(addr);
+	txbd_tmp.hdr_len = cpu_to_le16(lso->hdr_len);
+
+	/* first BD needs frm_len and offload flags set */
+	txbd_tmp.frm_len = cpu_to_le16(frm_len);
+	txbd_tmp.flags = flags;
+
+	if (lso->tcp)
+		txbd_tmp.l4t = ENETC_TXBD_L4T_TCP;
+	else
+		txbd_tmp.l4t = ENETC_TXBD_L4T_UDP;
+
+	if (lso->ipv6)
+		txbd_tmp.l3t = 1;
+	else
+		txbd_tmp.ipcs = 1;
+
+	/* l3_hdr_size in 32-bits (4 bytes) */
+	txbd_tmp.l3_hdr_size = lso->l3_hdr_len / 4;
+	txbd_tmp.l3_start = lso->l3_start;
+
+	/* For the LSO header we do not set the dma address since
+	 * we do not want it unmapped when we do cleanup. We still
+	 * set len so that we count the bytes sent.
+	 */
+	tx_swbd->len = lso->hdr_len;
+	tx_swbd->do_twostep_tstamp = false;
+	tx_swbd->check_wb = false;
+
+	/* Actually write the header in the BD */
+	*txbd = txbd_tmp;
+
+	/* Get the next BD, and the next BD is extended BD */
+	enetc_bdr_idx_inc(tx_ring, i);
+	txbd = ENETC_TXBD(*tx_ring, *i);
+	tx_swbd = &tx_ring->tx_swbd[*i];
+	prefetchw(txbd);
+
+	enetc_clear_tx_bd(&txbd_tmp);
+	if (skb_vlan_tag_present(skb)) {
+		/* Setup the VLAN fields */
+		txbd_tmp.ext.vid = cpu_to_le16(skb_vlan_tag_get(skb));
+		txbd_tmp.ext.tpid = 0; /* < C-TAG */
+		e_flags = ENETC_TXBD_E_FLAGS_VLAN_INS;
+	}
+
+	/* Write the BD */
+	txbd_tmp.ext.e_flags = e_flags;
+	txbd_tmp.ext.lso_sg_size = cpu_to_le16(lso->lso_seg_size);
+	txbd_tmp.ext.frm_len_ext = cpu_to_le16(frm_len_ext);
+	*txbd = txbd_tmp;
+}
+
+static int enetc_lso_map_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+			      int *i, struct enetc_lso_t *lso, int *count)
+{
+	union enetc_tx_bd txbd_tmp, *txbd = NULL;
+	struct enetc_tx_swbd *tx_swbd;
+	skb_frag_t *frag;
+	dma_addr_t dma;
+	u8 flags = 0;
+	int len, f;
+
+	len = skb_headlen(skb) - lso->hdr_len;
+	if (len > 0) {
+		dma = dma_map_single(tx_ring->dev, skb->data + lso->hdr_len,
+				     len, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
+			return -ENOMEM;
+
+		enetc_bdr_idx_inc(tx_ring, i);
+		txbd = ENETC_TXBD(*tx_ring, *i);
+		tx_swbd = &tx_ring->tx_swbd[*i];
+		prefetchw(txbd);
+		*count += 1;
+
+		enetc_clear_tx_bd(&txbd_tmp);
+		txbd_tmp.addr = cpu_to_le64(dma);
+		txbd_tmp.buf_len = cpu_to_le16(len);
+
+		tx_swbd->dma = dma;
+		tx_swbd->len = len;
+		tx_swbd->is_dma_page = 0;
+		tx_swbd->dir = DMA_TO_DEVICE;
+	}
+
+	frag = &skb_shinfo(skb)->frags[0];
+	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++, frag++) {
+		if (txbd)
+			*txbd = txbd_tmp;
+
+		len = skb_frag_size(frag);
+		dma = skb_frag_dma_map(tx_ring->dev, frag, 0, len,
+				       DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
+			return -ENOMEM;
+
+		/* Get the next BD */
+		enetc_bdr_idx_inc(tx_ring, i);
+		txbd = ENETC_TXBD(*tx_ring, *i);
+		tx_swbd = &tx_ring->tx_swbd[*i];
+		prefetchw(txbd);
+		*count += 1;
+
+		enetc_clear_tx_bd(&txbd_tmp);
+		txbd_tmp.addr = cpu_to_le64(dma);
+		txbd_tmp.buf_len = cpu_to_le16(len);
+
+		tx_swbd->dma = dma;
+		tx_swbd->len = len;
+		tx_swbd->is_dma_page = 1;
+		tx_swbd->dir = DMA_TO_DEVICE;
+	}
+
+	/* Last BD needs 'F' bit set */
+	flags |= ENETC_TXBD_FLAGS_F;
+	txbd_tmp.flags = flags;
+	*txbd = txbd_tmp;
+
+	tx_swbd->is_eof = 1;
+	tx_swbd->skb = skb;
+
+	return 0;
+}
+
+static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
+{
+	struct enetc_tx_swbd *tx_swbd;
+	struct enetc_lso_t lso = {0};
+	int err, i, count = 0;
+
+	/* Initialize the LSO handler */
+	enetc_lso_start(skb, &lso);
+	i = tx_ring->next_to_use;
+
+	enetc_lso_map_hdr(tx_ring, skb, &i, &lso);
+	/* First BD and an extend BD */
+	count += 2;
+
+	err = enetc_lso_map_data(tx_ring, skb, &i, &lso, &count);
+	if (err)
+		goto dma_err;
+
+	/* Go to the next BD */
+	enetc_bdr_idx_inc(tx_ring, &i);
+	tx_ring->next_to_use = i;
+	enetc_update_tx_ring_tail(tx_ring);
+
+	return count;
+
+dma_err:
+	do {
+		tx_swbd = &tx_ring->tx_swbd[i];
+		enetc_free_tx_frame(tx_ring, tx_swbd);
+		if (i == 0)
+			i = tx_ring->bd_count;
+		i--;
+	} while (count--);
+
+	return 0;
+}
+
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
@@ -643,14 +863,26 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	tx_ring = priv->tx_ring[skb->queue_mapping];
 
 	if (skb_is_gso(skb)) {
-		if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
-			netif_stop_subqueue(ndev, tx_ring->index);
-			return NETDEV_TX_BUSY;
-		}
+		/* LSO data unit lengths of up to 256KB are supported */
+		if (priv->active_offloads & ENETC_F_LSO &&
+		    (skb->len - enetc_lso_get_hdr_len(skb)) <=
+		    ENETC_LSO_MAX_DATA_LEN) {
+			if (enetc_bd_unused(tx_ring) < enetc_lso_count_descs(skb)) {
+				netif_stop_subqueue(ndev, tx_ring->index);
+				return NETDEV_TX_BUSY;
+			}
 
-		enetc_lock_mdio();
-		count = enetc_map_tx_tso_buffs(tx_ring, skb);
-		enetc_unlock_mdio();
+			count = enetc_lso_hw_offload(tx_ring, skb);
+		} else {
+			if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
+				netif_stop_subqueue(ndev, tx_ring->index);
+				return NETDEV_TX_BUSY;
+			}
+
+			enetc_lock_mdio();
+			count = enetc_map_tx_tso_buffs(tx_ring, skb);
+			enetc_unlock_mdio();
+		}
 	} else {
 		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
@@ -1796,6 +2028,9 @@ void enetc_get_si_caps(struct enetc_si *si)
 		si->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(rss);
 	}
 
+	if (val & ENETC_SIPCAPR0_LSO)
+		si->hw_features |= ENETC_SI_F_LSO;
+
 	if (val & ENETC_SIPCAPR0_QBV)
 		si->hw_features |= ENETC_SI_F_QBV;
 
@@ -2100,6 +2335,13 @@ static int enetc_setup_default_rss_table(struct enetc_si *si, int num_groups)
 	return 0;
 }
 
+static void enetc_set_lso_flags_mask(struct enetc_hw *hw)
+{
+	enetc_wr(hw, ENETC4_SILSOSFMR0,
+		 SILSOSFMR0_VAL_SET(TCP_NL_SEG_FLAGS_DMASK, TCP_NL_SEG_FLAGS_DMASK));
+	enetc_wr(hw, ENETC4_SILSOSFMR1, 0);
+}
+
 int enetc_configure_si(struct enetc_ndev_priv *priv)
 {
 	struct enetc_si *si = priv->si;
@@ -2113,6 +2355,9 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
 	/* enable SI */
 	enetc_wr(hw, ENETC_SIMR, ENETC_SIMR_EN);
 
+	if (si->hw_features & ENETC_SI_F_LSO)
+		enetc_set_lso_flags_mask(hw);
+
 	/* TODO: RSS support for i.MX95 will be supported later, and the
 	 * is_enetc_rev1() condition will be removed
 	 */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index a78af4f624e0..0a69f72fe8ec 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -41,6 +41,19 @@ struct enetc_tx_swbd {
 	u8 qbv_en:1;
 };
 
+struct enetc_lso_t {
+	bool	ipv6;
+	bool	tcp;
+	u8	l3_hdr_len;
+	u8	hdr_len; /* LSO header length */
+	u8	l3_start;
+	u16	lso_seg_size;
+	int	total_len; /* total data length, not include LSO header */
+};
+
+#define ENETC_1KB_SIZE			1024
+#define ENETC_LSO_MAX_DATA_LEN		(256 * ENETC_1KB_SIZE)
+
 #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
 #define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
@@ -238,6 +251,7 @@ enum enetc_errata {
 #define ENETC_SI_F_PSFP BIT(0)
 #define ENETC_SI_F_QBV  BIT(1)
 #define ENETC_SI_F_QBU  BIT(2)
+#define ENETC_SI_F_LSO	BIT(3)
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
@@ -353,6 +367,7 @@ enum enetc_active_offloads {
 	ENETC_F_QBU			= BIT(11),
 	ENETC_F_RXCSUM			= BIT(12),
 	ENETC_F_TXCSUM			= BIT(13),
+	ENETC_F_LSO			= BIT(14),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 26b220677448..cdde8e93a73c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -12,6 +12,28 @@
 #define NXP_ENETC_VENDOR_ID		0x1131
 #define NXP_ENETC_PF_DEV_ID		0xe101
 
+/**********************Station interface registers************************/
+/* Station interface LSO segmentation flag mask register 0/1 */
+#define ENETC4_SILSOSFMR0		0x1300
+#define  SILSOSFMR0_TCP_MID_SEG		GENMASK(27, 16)
+#define  SILSOSFMR0_TCP_1ST_SEG		GENMASK(11, 0)
+#define  SILSOSFMR0_VAL_SET(first, mid)	((((mid) << 16) & SILSOSFMR0_TCP_MID_SEG) | \
+					 ((first) & SILSOSFMR0_TCP_1ST_SEG))
+
+#define ENETC4_SILSOSFMR1		0x1304
+#define  SILSOSFMR1_TCP_LAST_SEG	GENMASK(11, 0)
+#define   TCP_FLAGS_FIN			BIT(0)
+#define   TCP_FLAGS_SYN			BIT(1)
+#define   TCP_FLAGS_RST			BIT(2)
+#define   TCP_FLAGS_PSH			BIT(3)
+#define   TCP_FLAGS_ACK			BIT(4)
+#define   TCP_FLAGS_URG			BIT(5)
+#define   TCP_FLAGS_ECE			BIT(6)
+#define   TCP_FLAGS_CWR			BIT(7)
+#define   TCP_FLAGS_NS			BIT(8)
+/* According to tso_build_hdr(), clear all special flags for not last packet. */
+#define TCP_NL_SEG_FLAGS_DMASK		(TCP_FLAGS_FIN | TCP_FLAGS_RST | TCP_FLAGS_PSH)
+
 /***************************ENETC port registers**************************/
 #define ENETC4_ECAPR0			0x0
 #define  ECAPR0_RFS			BIT(2)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 590b1412fadf..34a3e8f1496e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -28,6 +28,8 @@
 #define ENETC_SIPCAPR0_QBV	BIT(4)
 #define ENETC_SIPCAPR0_QBU	BIT(3)
 #define ENETC_SIPCAPR0_RFS	BIT(2)
+#define ENETC_SIPCAPR0_LSO	BIT(1)
+#define ENETC_SIPCAPR0_RSC	BIT(0)
 #define ENETC_SIPCAPR1	0x24
 #define ENETC_SITGTGR	0x30
 #define ENETC_SIRBGCR	0x38
@@ -554,7 +556,10 @@ static inline u64 _enetc_rd_reg64_wa(void __iomem *reg)
 union enetc_tx_bd {
 	struct {
 		__le64 addr;
-		__le16 buf_len;
+		union {
+			__le16 buf_len;
+			__le16 hdr_len;	/* For LSO, ENETC 4.1 and later */
+		};
 		__le16 frm_len;
 		union {
 			struct {
@@ -574,13 +579,16 @@ union enetc_tx_bd {
 		__le32 tstamp;
 		__le16 tpid;
 		__le16 vid;
-		u8 reserved[6];
+		__le16 lso_sg_size; /* For ENETC 4.1 and later */
+		__le16 frm_len_ext; /* For ENETC 4.1 and later */
+		u8 reserved[2];
 		u8 e_flags;
 		u8 flags;
 	} ext; /* Tx BD extension */
 	struct {
 		__le32 tstamp;
-		u8 reserved[10];
+		u8 reserved[8];
+		__le16 lso_err_count; /* For ENETC 4.1 and later */
 		u8 status;
 		u8 flags;
 	} wb; /* writeback descriptor */
@@ -589,6 +597,7 @@ union enetc_tx_bd {
 enum enetc_txbd_flags {
 	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
+	ENETC_TXBD_FLAGS_LSO = BIT(1), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_W = BIT(2),
 	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 2c4c6af672e7..82a67356abe4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -126,6 +126,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->drvdata->tx_csum)
 		priv->active_offloads |= ENETC_F_TXCSUM;
 
+	if (si->hw_features & ENETC_SI_F_LSO)
+		priv->active_offloads |= ENETC_F_LSO;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


