Return-Path: <netdev+bounces-143629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DDA9C365E
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 03:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82CE0281248
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0131369B4;
	Mon, 11 Nov 2024 02:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cRjE0iZH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50885260;
	Mon, 11 Nov 2024 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731290887; cv=fail; b=bh/oEdXLj9tB38edHnny7jj3UCNyP85k1RE3uk2UmCqsZs+vXTT4iHAP98JYE8LSoLLzc1X1li9yV9eNxxDySj5XdRgWLLJT+K6UQgxCpOG+Sx29h22t/O0+ecP+I3pBmWVD8Ow18/AVz/6TnhhLknog9CDIYA07kFVrjwdSPwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731290887; c=relaxed/simple;
	bh=2qqGIs3/VSIePvGmEDPHHzT/nB3Dw4/8aF41T4RvTmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TgM/LEFRUFI+CiyqiG1rPQTAi5GEZ8AOFCCPIa90fecW0yInI6NogvHNGUm4YzR0HbcKi3ANI7FTDneYU6Lz6d3Tw1ndfzdZEbnMRt8s+aFQWz6zRD5NTS0OcRa7M7cb64iyBoCbJnW3+9eDhXhCwd8vEMa7PEtIztHb+D3IcEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cRjE0iZH; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ml+vbUBWl8QGPLzF8ol4ae7eWr4+z3xMZC43zyy2k8Mo/H/69MGYoL1vAFlEsD+U+3IyzyoPpjCRVBbcJTH+BauqAxBwpM6Ev1j+iB1FhH3qVw5gBcZZRNVSsUlvV+vhmx0h0hBxfyjifeF3/pJQ96BVi3i3us2Jej97qy/JeRRrA8NWqGkgRUPRX1ZwC7OvP0FTpGue/DMTgfEOurd5ApSPJt1OQi0iz8Ttd3pHJajCdeOCytNM5Qz/lMB5eab6XAnxZBjL7VhleSJZ1I6H/rKMgKtj1MltIZ4RO8sivQzpKG3zkyHwtTb8zV+JzSWXn5Np239r+8zwDS9VsOWFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDcmo91d7aSf9dKaxzuY5sw/lnFyQr2oFgJgtqCk6r0=;
 b=Nl4itr9YTt5Ig+A5/z2x5XPXbWx8Ie6iVswIjouqN3aR2R+EG7pt7dpkjhUt1r30vsNXnhfX/Q+ZvTEc3QA4jgzBDs/PBTlfaKlLb3EHmsP1heRhFvKGhJ434TJEGrC8xA/e8hVROAiO1BTC0/eAoGJgnyy1gwH63X9ZaMI4Edb/WSkMH8/JRHcHjvzs/9su5EnJFEIjazMh0UN+ZNDgMBtDesS+DLw6jmhh4tZ/yMprrBCEC3tHPttcHyWt2hcDpP/EAc48b0ZJtwGKHHra9xtfah0US1fMrX7eu95+sgsrk6pf9D1nSua88pYBWLTHoS0AkgQm3SPmd4n4Z4f47g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDcmo91d7aSf9dKaxzuY5sw/lnFyQr2oFgJgtqCk6r0=;
 b=cRjE0iZHuCS7G0PxnbLuYDXtONu99/J8gUGLTrNuo186GUJG4X0gOPvFfMw6Cl6IxSn/6PR6KErlX1EHQdM3lR3/oXZyOsyvlMFK0JHYMpjnmQxJAq3W2fWZAGj8gYIcaz0oBH9wWSfndsLhWclq00ywP+sdaHORdohK01d3TpGAObZ4NctTQNvZuHgfcez8FF95uRNyxMZgtXrN2phHpRhe/f0i6QyurlPv6RfgCs/Ryw7uW81FkfT47iWvVZ+v32cnHcY+4diQYVLLPh8ylbQJSDHiYoOC8ytJbrJuohRZip40lyusiDuRvmqJZ9ZAEMYt84wjLlgbUGODJOLRJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7745.eurprd04.prod.outlook.com (2603:10a6:20b:234::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 02:08:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 02:08:02 +0000
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
Subject: [PATCH v2 net-next 1/5] net: enetc: add Rx checksum offload for i.MX95 ENETC
Date: Mon, 11 Nov 2024 09:52:12 +0800
Message-Id: <20241111015216.1804534-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111015216.1804534-1-wei.fang@nxp.com>
References: <20241111015216.1804534-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f643d2b-8b81-499f-91c3-08dd01f5ac0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wepjC4ldWQbrkxiqI3IfUugEpuANbHt12AR5X4rFAk5VUFoXrJZ/FUAD/i9g?=
 =?us-ascii?Q?VY/qZxwRSPjFjQHmkfx7fVgf7sYtLfBcBmk7v2kLu82j53nv21bWfaoJt3GX?=
 =?us-ascii?Q?pagiTbbkSWSq3/FFsjL1gs9RXuwRPpZIqS8Up+soLWn8JeM9XlYX6egOA7Aa?=
 =?us-ascii?Q?xg2XituL16TPRtB/BeZrTh9m19XP1DVaTqdxzuexbYwtF2jM1P8jcSipFydA?=
 =?us-ascii?Q?zttt6h43tUNaRWTrxadPvYXvxNk/sTm0RGFVzkYvz5Ced1j7vcmuNqrZyXb9?=
 =?us-ascii?Q?oQAdXy4hOkJ/cRzWNc3pa/WNdu2KrvvLNx0quZ/Ie4fyn9n+MEdjT3Ggob7Y?=
 =?us-ascii?Q?CIH0WgPiloL4ozfciLiLWfrMzYX5WohsxXS5IenCt2idRyXGT/sem77QEgvx?=
 =?us-ascii?Q?+Xq2J+J0/q42SI1BeCnTTbZhisASTP7U4SsSv6SS9Hd/pRH+bdwA/nNPYYTq?=
 =?us-ascii?Q?akbXWTtdZhsGgopVSr3UTBdTXpnISGjNNTGuXR++escH7QBLIHCQsoqdK9F+?=
 =?us-ascii?Q?tSOeBjZwETmYiVHI1i9UwjdkLqQdC0U2lvTJ71u987tQW2uyb8KuI/zgxYnt?=
 =?us-ascii?Q?lj+/DfvrtLqh0QvCuC2mj/dTauoW+ewnujmDfsRWHhFhExYfINlJOWh/bzn1?=
 =?us-ascii?Q?T4JQXT7vLMIQloMmQKi1UEcOmDFp+p+Q4+q0N/m+4EFTOtxDp8pxGqOtCoUH?=
 =?us-ascii?Q?R7VpLsRSDp9jwSSVH8zXeQEo3R/OFooFBTwoJF4rDXUka9rUaLo5TJhAaG9o?=
 =?us-ascii?Q?arJURmCyErdKwchAKF+L+oJMHntoojd2A+/s6C9og5h1lxBOqFjp1v0NSXwX?=
 =?us-ascii?Q?ryiRfP9RhOuRaSQHCRZxTziMFs5bl9Dc4PAKFf4oOj9uGoD1kOYuJ2OI4kDL?=
 =?us-ascii?Q?Qba8i9Si6vrYPalj8b0Pe6KWgkbOSPvoTKORqZEeTimyEaBANTmLO3QGyGE8?=
 =?us-ascii?Q?tAk6H0xmVb80ZfyStJSs0K4+O6P1tcOmSSb3CvaX2iPKNbC/2iRYM0PjYtt9?=
 =?us-ascii?Q?FoiEjMnrKA51zScCWbx9qoR2mN0r9DvBT+Qx+rrADheZ2tV+Ifp6+RpMJvq7?=
 =?us-ascii?Q?7+UQHIV8PuXn4KG2c66LrpMzhCf9ik6ETbluTApBMYLjjjlhfBQCjRoRAi7V?=
 =?us-ascii?Q?13d1j9FfoYiK1EovN3MaGg+xc15KFeBvHjUdR1it8i2HFDLA8WYpbl53dTsf?=
 =?us-ascii?Q?JQxqQYfUUax4u9X3dSnkvy5Be9Nlr1/PlrWQL1qYZwfdsrJ68AEQXWuqslzv?=
 =?us-ascii?Q?67sTy70F+LsSBI+wajEjOFM0VfqxCQLlNKBgAF50sVqMMq5nyfc57ew3kp4P?=
 =?us-ascii?Q?ZgQsqRl918N8dzGBWLFDkdyyPw/lx0IxIGuBf+8/2hRSNW+AFqEte402hSrx?=
 =?us-ascii?Q?4ctdv2E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3qt+2ODbKLL4d3EpMRhzAgmmcpRtEIR83Wg+a8yze4HF9u/5KM1C4YXjmVjN?=
 =?us-ascii?Q?JIgd9+dOOCcyOxVjHpbwiixg1Bm2Qc/ftHPmsishILRqEKkbw01ktSpaIkDs?=
 =?us-ascii?Q?tdPrS6dLEtZTv30vhfVMdyz73sHp0434aeLPrftDfJwGf0jYA0xsoTiJdakI?=
 =?us-ascii?Q?qOZ6DN2jqSPTWshcmqtDGgGzHdViI3t2fdlxsUPO5Sx9x7JjG59flrtnhm/z?=
 =?us-ascii?Q?u9SCJ0hB6B+Ou+FIy/5pqwMrjcIbLiVLFKzKDfFuOODG86G91cV/twNdleXp?=
 =?us-ascii?Q?21HOXtm2NKqajxloYxTTgqzT7duj67W59m481PBulqfDkSpw0FcCa/wlcdjM?=
 =?us-ascii?Q?rijv/oZEQImumQDKOBiMCn9lISkFNAsdy9kOrLjq026w1Ji5YtgHCK5varZN?=
 =?us-ascii?Q?VNy5hFb0/gzzP4IbuNBe2Cfx6D/a79jEhLHAXch6zBbW8rBxIMWO40Y4Z1oO?=
 =?us-ascii?Q?lO/+Z1XEVK/9gyhakoOndZt5WNUcTnDQqL68I/kzdK8BiPYF+cC15XVizqGH?=
 =?us-ascii?Q?H51OkqZOokFBJ7ArYX8sQMPvtw+Eac05gQMGetAlgBfd0tD4cacOrSLVP+M5?=
 =?us-ascii?Q?Udnn7n/f3/I3gabi+1OwAfES3qRqfHEcr+ffEtuTaUQK6FB/Q77Lbl62o6od?=
 =?us-ascii?Q?uWS1L3wPv2hbi0JFNGyHk/c2xJFzZ68VuzE8dOgA62rl3FQvp1jdusW4bLqc?=
 =?us-ascii?Q?2t4v93Q0zFuQQ9h4Ud8peTx39nLfFfMhVj5XGOOzbGfkDyuigWUjfbhnr00N?=
 =?us-ascii?Q?oa6XuqnBxbUVXk9BQid8b0x0K+0tyk0Ee2dr97XJFdRl0FbORh9ViUTXPVNv?=
 =?us-ascii?Q?inA9chZy8kWF2UMqkYkFCa+7jf7B1NfCVUW69kM8bjBt4XLSQKSbUSjlcsgX?=
 =?us-ascii?Q?gOCNq/Ey9OWH4uNLwz67z8W1baGICj0kCu9ZM96MIMItvaYwNAiioc+8j6D7?=
 =?us-ascii?Q?o8EWlaF1Sic9D+cSPa/A0bzDtNKVhZ/COU0e7tjEnIZ75U9H2a5K4ks0JYF4?=
 =?us-ascii?Q?4nQDqgNwl4bsN4Zr4h2TZ1w9I5bEjHihtnoE67qLzIcuwPs84N8X4pxZJa4w?=
 =?us-ascii?Q?T3OaZ7KJX+GNVfkCv+cxtiAS4UHb49QoVpgCQ4FaR0DyqY+FRf7j4JNtMJ06?=
 =?us-ascii?Q?XHFDtPZsvfp+zYmX2p3p3/hWcPbUliWLayzwfFguRGXfnOqvRKU178bNfgYQ?=
 =?us-ascii?Q?azxDbXFF/IBXIdbd2cz00HzhNQEQIBwa/N1R6zd1NncKcV6+ONjrdP9TOfsf?=
 =?us-ascii?Q?W817RQGGoVTL0C5z0SYhFe2PwBoqlAnuXK4CEIkLIrRRN5EopKe9D1GJgx3h?=
 =?us-ascii?Q?1IWi1lgpYdLnwYyPaVvxQ5cu9gwRgj9P8FY/MiW+qJqcAhmrh1lkoDCLPq+k?=
 =?us-ascii?Q?I2d+FnEsyuRXfc+Bd/VeJqbcqQJUujdvzev305x6kOXBOqWeWnbgPK0gECO+?=
 =?us-ascii?Q?0MhKKFpw/0aRZ9RjigmNkvpkyz2lYdQkaxiuUEfAYVNu5QqDfcKyYkLnH/fE?=
 =?us-ascii?Q?mh0E0WWJFaA3NYCBoNyS165lvpinPkb9KGvXxa/LILKU8fNfX0vuYPGp4+B9?=
 =?us-ascii?Q?3QZnlirzPWc7twlmqHPmH3mDmyAXiPxYcQeiinrC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f643d2b-8b81-499f-91c3-08dd01f5ac0d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:08:02.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXqSmSBP7bCQHuFjiD/seh0e4JdiKQ0AvVrSefmaXdEmT6H/9QcJnruxXD+yWZ5xpX6ybofysECeM2rKp9Chyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7745

ENETC rev 4.1 supports TCP and UDP checksum offload for receive, the bit
108 of the Rx BD will be set if the TCP/UDP checksum is correct. Since
this capability is not defined in register, the rx_csum bit is added to
struct enetc_drvdata to indicate whether the device supports Rx checksum
offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c       | 14 ++++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h       |  2 ++
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |  2 ++
 .../net/ethernet/freescale/enetc/enetc_pf_common.c |  3 +++
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 35634c516e26..3137b6ee62d3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1011,10 +1011,15 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 
 	/* TODO: hashing */
 	if (rx_ring->ndev->features & NETIF_F_RXCSUM) {
-		u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
-
-		skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
-		skb->ip_summed = CHECKSUM_COMPLETE;
+		if (priv->active_offloads & ENETC_F_RXCSUM &&
+		    le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_L4_CSUM_OK) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		} else {
+			u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
+
+			skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
+			skb->ip_summed = CHECKSUM_COMPLETE;
+		}
 	}
 
 	if (le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_VLAN) {
@@ -3281,6 +3286,7 @@ static const struct enetc_drvdata enetc_pf_data = {
 static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
+	.rx_csum = 1,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 72fa03dbc2dd..5b65f79e05be 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -234,6 +234,7 @@ enum enetc_errata {
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
+	u8 rx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -341,6 +342,7 @@ enum enetc_active_offloads {
 	ENETC_F_QBV			= BIT(9),
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
+	ENETC_F_RXCSUM			= BIT(12),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 7c3285584f8a..4b8fd1879005 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -645,6 +645,8 @@ union enetc_rx_bd {
 #define ENETC_RXBD_LSTATUS(flags)	((flags) << 16)
 #define ENETC_RXBD_FLAG_VLAN	BIT(9)
 #define ENETC_RXBD_FLAG_TSTMP	BIT(10)
+/* UDP and TCP checksum offload, for ENETC 4.1 and later */
+#define ENETC_RXBD_FLAG_L4_CSUM_OK	BIT(12)
 #define ENETC_RXBD_FLAG_TPID	GENMASK(1, 0)
 
 #define ENETC_MAC_ADDR_FILT_CNT	8 /* # of supported entries per port */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 0eecfc833164..91e79582a541 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -119,6 +119,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	ndev->priv_flags |= IFF_UNICAST_FLT;
 
+	if (si->drvdata->rx_csum)
+		priv->active_offloads |= ENETC_F_RXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


