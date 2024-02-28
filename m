Return-Path: <netdev+bounces-75576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDC286A948
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D811C25AAC
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 07:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FC325579;
	Wed, 28 Feb 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="GgK8VJK/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2117.outbound.protection.outlook.com [40.107.96.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54BE2562E
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106749; cv=fail; b=mnG3WojRpM3Ope2QCEWYbP8IJ03hlgXEv3lv5XCa6BextEKLRxig7Q97nC8Jzrcn2I8RVH/4Pr2uXnmoFjzsJanQPHdB2kvPZfJpXoABBF7/a6Elqk4aHAF4/HGxSzEFwKxqZtHf5P+6kAG9i4WqppmvrKkkkw/L+M8GVu4xsD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106749; c=relaxed/simple;
	bh=agzWp3VOVq1Oz/7kzQaEoLFDretFiqXdBYdFnynV63k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qQun+mbg3RDMdrnO6H3qC4fDMVIMF0/mrCwFk3HUT3ki/1EbDJjsnxUrygr8wG6p/tyKpXUQlKv9nD+0tnj46Uq3BlTZKpPFTR0lALfHXg1XHkstkSFnN5E5wqh9txwuqrJldEHW+PA0fZgKVUMi9IOYmNR9PT4ctVQgGzeY0pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=GgK8VJK/; arc=fail smtp.client-ip=40.107.96.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OH+uqMKT8Ae6drJ/iilaiLcZuHDm9T+pCx1P5BSJlqLl879kPrPgAsOEQn8DEZVbTkZgPl9CXPEwbU/fnwwiTFrmQ/F/oI+rdpOggl/2KIkYM8mzRy9iWPV6CFUCA7bIxA0LdvULp0HxeRR+Y3WEsEtPkMpczP8cSQiTb1RAKMvmprDe2LmDNMaVLq3V13tykXkXgcrWmY7uGyMbAankEGltGZUgTXcCd3OWDCaUIfAm1VV9VSHf5457E8+9TL0mzJrq08GqWE4iSu38geb6iCbKVAHpwQG+dRHhdFMOZ6ArNhsMzqNv8jyyQFLEePQ64qdSz69DCUCBYiEqtVuccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEM9Ntv15JITqGwGVscksRiejSHFDqXaHiW8xgN6DNE=;
 b=fmj6qv3H94Na7vR0okejW3W2zKJy67Ykn/Ghv6hrbefGYK5gsj4jnJ613/iRGTbim1xXy30YjKYZRl3sCAH+/ILTnBMx6Z8NClWcPdKxQsCY1jgNOpSxz+TBJVVFCWzf60ixmkJ1gYh11l+ttwPtIp49nR+7ohMov+gkLwZCpr7dwy1CmY+7mGK8xAegDzMB4HSVXhO0fKgJkIsdHfqwO2/y0KMlwlp2qFvq8jW7df3BJGWAIObRd8uouVmr0IWP3G7dyI1o6gexnB1pzFOuxbdyzPzcGmo5pWcH8qBIbaeaI5lpgyCkPyYhUjnBFQ1GANMo8sT8OG5i5KfuXMSOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEM9Ntv15JITqGwGVscksRiejSHFDqXaHiW8xgN6DNE=;
 b=GgK8VJK/TB/xWE5GFhTWmB4ruO/K7W1X8X+B0bkavBY9FnnqcIVRCgNA5RfBzO+iBHIHaaxHWnR5XEazKeGfE+0GBcsDedmg4Gy4k9SEVtWCmPN89wp7eNDi+sALIcAvy2XWU1GztQC/Z+OJ/sxjS0qm5xqfYFBkwQKxWKmrs+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by DM6PR13MB4496.namprd13.prod.outlook.com (2603:10b6:5:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Wed, 28 Feb
 2024 07:52:26 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 07:52:25 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 3/4] dim: introduce a specific dim profile for better latency
Date: Wed, 28 Feb 2024 09:51:39 +0200
Message-Id: <20240228075140.12085-4-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228075140.12085-1-louis.peens@corigine.com>
References: <20240228075140.12085-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|DM6PR13MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 0193e50b-b455-40db-3812-08dc38323465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/YrvYZUjo0qXBLqOe2UrEw1KT6R+mCpckHT3yTootdFxzoWo80HlcNqLyyP6h1JN3J3N82NbkMVvEpgauiZ3ytsX1xfnsB1FItJaRAWt5mlTm5uxXKsVL4FIA9LBxuU9J+jkzG1cygMl0FZ4ZvrLtApN41WcqaWBxjMVZgUllH6AURc3zfgfGnbRwbknvakH5MupPynpa0otO+0VA47Gb/L1WVyz627JBwURxSWqXU/B+XE+JogdmEkz8REnCmiV7Bd42h+QZxTRwyhmebCteOCEw6bHGjpQL1dNd7Vq2zyBsc6RAiflcWH3H4IwCsiv2Pn1XMo5cPamykVAmdkEk9bxRjB/Fk9xWyHllMlxckoJo/Oyk8nWIB4yobBk4kX8w5kzlWBFff3KiIRAVVOA9xFBwojp8TX6vc6FpAOluwc+6S6VHMCkHK0TuD6KOr6hywXb9D+R7TrL9OHB1cQVFffLWOpiWgJN7eY4sGh9FRtVMUGHuDFI/HOupcmWYSnimN75lwIUgprSeWP0k1NMlPuH0jbTY6dFf5GsZOP/AIDrogM0TvnoH4GsC+I62iBZ3AHbliP5TMf6BTT7cVmyh5vhXpl1pmA85YXELbbdd+vlUF35x/GscnZrDja62BqSL/O4eLl0SbJntbax4HEOwr/hIU+sjL9wq0xmWBk0ZYEfCK4wXPgB+bH6PNXvXzv/W+eV7HojIbOORFFiqwGXyQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iVpvCiYwapT7/j2lqXkGNicrMMSLjq0yA4fUbWUFkBqG0E/Z7Da1TwwED/YA?=
 =?us-ascii?Q?4PHvh6Tr+OtpkWaJyjXYdaQMCtDXN107ETN7hsL2zYIWLBwD+dfxkSPJOWRM?=
 =?us-ascii?Q?d7DHBQ2vbRyHWONvf5jFeeCIHM+p/dw/FaU7oSzVzkzY+Sz/72hkCEXCMhyV?=
 =?us-ascii?Q?/SfYqTD5U4avf1MbMGoeTbWOjfll79F1UGTx4I5Rbt2DIAXxvS3Bd2pOroA1?=
 =?us-ascii?Q?pjt5vhwVfOS4tBcgC8onQ0LgpH4Ib18ovNZfKSZQRb+1XhEjImFzgKNbyLSA?=
 =?us-ascii?Q?c6PYPdTsnsc/va5srGqlrNUlY1Uhp3YtNH6Avz0PeIZiqHqvVU9SUMygCqtK?=
 =?us-ascii?Q?5Zoar2VD9zoFaQNFNOrGSeDO1doKZQT1+bI6VmQCt/yjoX2+xLscSVt0qqWr?=
 =?us-ascii?Q?774Pk+QeQ9dXnc7ECkgNjFJy3PBCKKpLct0o7ARGnwr0j5RZdjX2uPfpNNWt?=
 =?us-ascii?Q?nDXA31qP2WKgmLco5iVrSPiSwwBVuZPbOqHOZfILrt9eIEYATLaKkXzJoGzi?=
 =?us-ascii?Q?xHqLfSGSlUaTvr+JDS3R85aZ+8ce0oa6prENagmPWTFq7fiT+QYFFPCgFV9Y?=
 =?us-ascii?Q?whO1/G1+YEVPrf1bYAxjTE2Q94UVOxu2tsw67m/VNwZVS0Vaz0URG01WobjQ?=
 =?us-ascii?Q?5VptflbIMypqWlRnPv5TkRGQuQHECPGZ5EAktw7hStUW/UhEHnlrlxsv3ovH?=
 =?us-ascii?Q?FoXoVlzdoyRfJ6tkDn2l3se40xKyf1nSHtYtz8WmgWizDht2tQgBXjKRFaqp?=
 =?us-ascii?Q?rqtDRDSl0WcxBs2a6jTh5TTFIP8dKShOhTU0S9C70VkMF5ADX7ghH+y7g+mN?=
 =?us-ascii?Q?VSi8I6PNS7NeIobyV2rpNLA1yKZ+Bm/jKAJBUkHehC+ttjBg4gkwqESa8fvs?=
 =?us-ascii?Q?le1/0Qz7Q+SKUor+4BZn0oGxALNWdX/wKepnre/sdoeQZTxl+dFYANbUF5RT?=
 =?us-ascii?Q?hBYBIp16d6/cvtuVqEXrhJM2rgsbc0/NXFtM24loPpPXHhB+cA/aOs3s1V39?=
 =?us-ascii?Q?WDzkfRzQAsaWibMKnEhyZhZJ6qsCGfKLS+8vBOD3o2b6mx074b34vqZY5a5U?=
 =?us-ascii?Q?uYYIg+vXAlHBZKEQ3G3tmzO9MN5c2c7+121Puc+cLoO7gADlVm5uCjftBdX+?=
 =?us-ascii?Q?minyInfSMlZKNb320FmXCd87bD82xZk0rGoLgYZQcy7IQKpNIPHAcsbRJ42v?=
 =?us-ascii?Q?nxRJ5vSZARi6imvzxT6TJ8I38NmtHBDjSE4hDCAVKS+ndZ8GMXFtLnC5yrWV?=
 =?us-ascii?Q?Grn+Yo5o/wkymOgk6NC9UJ9Cv2EKUNLaymF/xtj0Zt9/cJeZV/spr7yWlHcg?=
 =?us-ascii?Q?nBeVtLk/fOvM0Y8vfcdWYVFvL0NxvwWuQK+ous1loM5/egmPnhrUbRb4xRDW?=
 =?us-ascii?Q?ewcFATCYKDI4uiB00dkb9r8p9yPvIqjT99gIZP9i6ZJH0XrjMyfMZ0LwcH5P?=
 =?us-ascii?Q?Np19uRwnEXNMBSibzuiYs/Y9BQMH/TLvwEVi3/gtDvSM/EFGqsup7PeaLSBf?=
 =?us-ascii?Q?amh97gBTf5r8xkoivlHWLoCY9s6tZE0IEGhMDJpoiCoQAdQW9ddZbEELh1d/?=
 =?us-ascii?Q?LXoEcbxMO3sadjej2gG7C+z1QgZrtLWUNGEGHDChNqFOb85l420azvddG8RM?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0193e50b-b455-40db-3812-08dc38323465
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 07:52:25.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSVL0h9T6y/mabDnaFtMhmDDB5sd/5cP+gKNwp5W/izvYQHHucAd4EmrfU0lM6gPa3cTo1wi5Dfftf1U4gNACtYy7YkKCIOyK3a5K/GdzK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4496

From: Fei Qin <fei.qin@corigine.com>

The current profile is not well-adaptive to NFP NICs in
terms of latency, so introduce a specific profile for better
latency.

Signed-off-by: Fei Qin <fei.qin@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 include/linux/dim.h |  2 ++
 lib/dim/net_dim.c   | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index f343bc9aa2ec..edd6d7bceb28 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -119,11 +119,13 @@ struct dim {
  *
  * @DIM_CQ_PERIOD_MODE_START_FROM_EQE: Start counting from EQE
  * @DIM_CQ_PERIOD_MODE_START_FROM_CQE: Start counting from CQE (implies timer reset)
+ * @DIM_CQ_PERIOD_MODE_SPECIFIC_0: Specific mode to improve latency
  * @DIM_CQ_PERIOD_NUM_MODES: Number of modes
  */
 enum dim_cq_period_mode {
 	DIM_CQ_PERIOD_MODE_START_FROM_EQE = 0x0,
 	DIM_CQ_PERIOD_MODE_START_FROM_CQE = 0x1,
+	DIM_CQ_PERIOD_MODE_SPECIFIC_0 = 0x2,
 	DIM_CQ_PERIOD_NUM_MODES
 };
 
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index 4e32f7aaac86..2b5dccb6242c 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -33,6 +33,14 @@
 	{.usec = 64, .pkts = 64,}               \
 }
 
+#define NET_DIM_RX_SPECIFIC_0_PROFILES { \
+	{.usec = 0,   .pkts = 1,},   \
+	{.usec = 4,   .pkts = 32,},  \
+	{.usec = 64,  .pkts = 64,},  \
+	{.usec = 128, .pkts = 256,}, \
+	{.usec = 256, .pkts = 256,}  \
+}
+
 #define NET_DIM_TX_EQE_PROFILES { \
 	{.usec = 1,   .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,},  \
 	{.usec = 8,   .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,},  \
@@ -49,16 +57,26 @@
 	{.usec = 64, .pkts = 32,}   \
 }
 
+#define NET_DIM_TX_SPECIFIC_0_PROFILES { \
+	{.usec = 0,   .pkts = 1,},   \
+	{.usec = 4,   .pkts = 16,},  \
+	{.usec = 32,  .pkts = 64,},  \
+	{.usec = 64,  .pkts = 128,}, \
+	{.usec = 128, .pkts = 128,}  \
+}
+
 static const struct dim_cq_moder
 rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_RX_EQE_PROFILES,
 	NET_DIM_RX_CQE_PROFILES,
+	NET_DIM_RX_SPECIFIC_0_PROFILES,
 };
 
 static const struct dim_cq_moder
 tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_TX_EQE_PROFILES,
 	NET_DIM_TX_CQE_PROFILES,
+	NET_DIM_TX_SPECIFIC_0_PROFILES,
 };
 
 struct dim_cq_moder
-- 
2.34.1


