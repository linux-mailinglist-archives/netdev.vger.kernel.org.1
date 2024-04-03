Return-Path: <netdev+bounces-84538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BE2897333
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C376B1C20DE6
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E3D149C68;
	Wed,  3 Apr 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="sttZCW83"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2110.outbound.protection.outlook.com [40.107.101.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD8E149E18
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156308; cv=fail; b=YQTstEwMDKtG4po6crBsPNuYftpwHm+MZEkNyUmHSo5Ofm7KNw+nic8XHRQaY0yrZqu43QHWb3Y3dm4xr0N18QPifni7jS98as9OPS+7zGT0EixY9myoXekSkdLfsn29bh5J3A9ufwCtF1PvUurAUQ3tXR0wkA2mP1V0OpiG55o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156308; c=relaxed/simple;
	bh=agzWp3VOVq1Oz/7kzQaEoLFDretFiqXdBYdFnynV63k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ksYaGXlokwx6V2Z3QUrOmKq1CbUesb4YnV3eZX8hdZlHM+0HhumC8zLicb6TNxt2WXWbELhqYUDcLQojneGt56vXFlek7gAUuEBYu719qF9EVTrCkLr6IryQ9GCfqNSsHhamtQJBejSGTcQUB6+wd5xcYhBk1Vxf/pVl4LlmLjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=sttZCW83; arc=fail smtp.client-ip=40.107.101.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y25RUbaObzFHu4q3Lsd6GmX4z6KgOM9p8VoFE1G6fZmqJUlhjlqm4Yz+I4tS3TtFeJN7wjv3QacwzSH/FrQS0l8FgR2+qiGjqceWvq+aqozB6i68Tw5/hPdjIHtR8TN0wsJHwjNJnHLgxvFgIN6vcjr9DGbQmsPYoiTkFW/Moi7j1098corYzwH0Krd+l7nJqqbHYEDjEEAL9wRuLVYJPBqDDQJsYAoueP+U9gff4bWE5Z5ag3CrftYhm6zeivsPFd7BOOzWIR2eXPQLwxyNv92cgNFGLMIK6abvd0zYHa7158yoECE4IqMnjMhgsQf7tPmz1C7KjZDMhwsO1Nd+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEM9Ntv15JITqGwGVscksRiejSHFDqXaHiW8xgN6DNE=;
 b=LL/2y5q5A598z0Xsd/WlEz0KVBgrmDhXIVkkhFSJ99JzZp26YoLi96batZbbIssSDdFKULj9jMymN8J12pE8hoiKJIEUvOLY3ks+pulkQJ67AkykPNcLdlxljNaox1Pg2AhYjoNbyrL1x0T98CrcPsX3GzVzI6QPLuYWOv2b2nNq/wAaaaUCY/XqPLO98ho2Vi893H27Oeoc3y4Qged5mq/vt6Rkp3rWaSVGY+sHHW/rkXZZdaYn9Z8CE2EekwLuj8uHfTqjYDW8pX9/ykQnzAglSf9ensHpYZtcFJddwIx8wC3KkoKyfVt7nwSmbOl5i4FU2uaL5D1i3eiGm/oMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEM9Ntv15JITqGwGVscksRiejSHFDqXaHiW8xgN6DNE=;
 b=sttZCW83kAbLPmaoG8c9EbYg7h28zW4LTHMWmYSkiAr5RHbbEm/1hGwpbaU99eRawL3i1NFUjHZx1ZsDHQue1q78fcxHW2rzD5xk6AkzxopUxutlSjDN+l4mH2Gr+/Bdgr4cKAikzGXG/lBkII+rgHXI7XzOTdpZ8YxWmkJ3r5U=
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by DM6PR13MB4528.namprd13.prod.outlook.com (2603:10b6:5:208::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 14:58:25 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 14:58:25 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v3 3/4] dim: introduce a specific dim profile for better latency
Date: Wed,  3 Apr 2024 16:56:59 +0200
Message-Id: <20240403145700.26881-4-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403145700.26881-1-louis.peens@corigine.com>
References: <20240403145700.26881-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|DM6PR13MB4528:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TgTKczl1VFVCfD/vCT/7UDM6/x8DgHoO2vkdJPd4yI6R/JcIdThRk/pRz+MNTDtV37Nd3CadTmIng1LLsfoRTEs1IKTurEc1o9LfbJh9xTrlhTdknksrwJ50gYq5PGfhUzDGeaf4TCxl62GwHExwhHssNaEMcOr3nHzwMDID4/T/hGqAwjqQYMdhO7DattaGe8ZdELKDjgEVOOxQC40RN6st5r4C8WFIL4AJNBUVjqEzdPNrZgx6vvfNF7oOsXfr0C1lZr10t5pgHiqkFi9EyH2vlh3ZSaPe/1f9s6m1jIUt/uI5s+OQFbU9j0zrVmxpf0Y6humqgZtxJy3D4Lrrtzv8+xd+25leH3Xnsl3d7ijQbR9bEvenV82ZPuWzLXlqGt3nnxVhgyrmLcx4gVlueY+pwrYoWrRa/MKsKN9XBgnTlwudpix35Dvs1I5Uw+PHlh8xIet0AK1zDr2+8nL9kY8HEH/P2zsrIxNZCqigNh+JoKic39kKevQue5Kj36iieMKE25+bEDZZJ7m1ZMi2psi8tkp4t6yrm4lQBAZ/igg3UHkCcPraFqDh5FxSx9KDHxXveXcmPYF59Wfxkwveq7f/j/4y3aD5oHJE5ePe5hSEMiD2Q9OaVN3MOlW4shiyfW5nm7mnuMkxkGtuiIzN/cG/Qljdlzr2d+8uoZKFFhTm0OiZZwk8VX791yE6Q3zzvjQovJgPuvY0qt/cjYJ/2A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K62Gch+wJdUp8w10ZsMhaJ80+9FHNv6+Mx1vlfRNrsHjGaCqdKNTPAreOZNz?=
 =?us-ascii?Q?sh5ckgqI/YmALOh0L+JgBeV5kafF/Vxm1p3m4TiatCicGJbqyGqWCFjjbe/c?=
 =?us-ascii?Q?IvwDNGClUPsxlfVPBL4azqIalqXzsqmQMrOAuVMDAxTIO1nHkVABRiXbeNvj?=
 =?us-ascii?Q?O71IpjC3/fLFFvwaNfb28vo+LivKA7elQQ2gE75KnAJXT9q3LX0UXSku7csx?=
 =?us-ascii?Q?05Hcv9w1M+shB71A682F7WwSoUrUX1tQlNpuOFHwHkG0zaF9+HwOTdw2BF7h?=
 =?us-ascii?Q?IU2gJLeYVl4voBONo+vYQaxP25aDSdyRTSGRpBjCvtQEy88zPWqiZkJYdcls?=
 =?us-ascii?Q?9/lpyI4pwzeu1ZpcOJlRfQGFIRED7JnPsFl7awCCGCa3QLpCwXy169zKvILw?=
 =?us-ascii?Q?kdFC5/768EqSKVt0xEXziIasEzjdfGYj1zeCpMnmm2Y4kAaCzuoenzmNXDQb?=
 =?us-ascii?Q?wuL/HtSqyDtv98E9Lzinfj0OeStWftujFQjLMTeA8S06J1zBu+YkSjRVSRPn?=
 =?us-ascii?Q?zWpqy8pcwmy9pssqrwLbFHedhtKjza5UO/6PUvBU3zRe/yMa3jy5KUE3trnz?=
 =?us-ascii?Q?yNBrnDhcLTNHR5gmA085FL9JUmoz9Ek5wZH85L3EOhL82XzUmLJT6enAbrYE?=
 =?us-ascii?Q?1aJYaCm4gSNtgksUHMJmXRHr6rui7WAdZw/GdAhFEH/LL6M18ukEwTshI4tz?=
 =?us-ascii?Q?P0rU16hZN3CyZW6VrZxpek8Y14VYyIXEzm+tV8fVFKJFyDh006tg8ES39eqx?=
 =?us-ascii?Q?IIZPocZUDRMTsrUiDpb3DKJU3sZ8DrtlPsPWyth4e1lgaEeteRTTEDrjLZfz?=
 =?us-ascii?Q?D94SKaATIsf0HqysnDtESBe9a87wsQCsN9I3ynuTiG/7YkmrykKX0iC1HrPh?=
 =?us-ascii?Q?EllSs7/1htk76DbGdtc4ybRUKRlsgkfUU8XhtfDGmxwE+5itmiRc32e2DSEq?=
 =?us-ascii?Q?pG/7j8WRgXxR57hV67h9vesSdyAQC5oT2+6QZI1mJP0TIMVd1nn4m0eSA11j?=
 =?us-ascii?Q?OprDepfDcIEa8HMq5jDJi/36FPwHUnvCkijQ4t2rMrxo+rZrs9LuNFZWxGrH?=
 =?us-ascii?Q?ASN0f8BHhynSoBNInMRTpzpkZPsJ3Zmu5SYHxl/xCRgZAHNSXWemHNV/oBaw?=
 =?us-ascii?Q?3y2bDra2P0lhESjjKXH3TdybKM9UjD5MRm5dPM2oxctCsck2h1ZyL2KuBllI?=
 =?us-ascii?Q?DbCeCzbA2qHAvEJr6zpn2kpO4xW8QJetOFkqmY4MSlH4vz6PNSpzL4ZdsrY6?=
 =?us-ascii?Q?M3o3BAvywtaEvxAFTCWM8KO6AZF4YD6qFb0Vnv2I5pkb9z22N8E2JKKjkyCg?=
 =?us-ascii?Q?f/T/jSNRwcCyfHYqhMRXQABELqYL43LXpRRzUJg5JfSCCeId1mooUN0yhVYE?=
 =?us-ascii?Q?Fcpkv1BtjvkX9ssI4CjtADM9gjn44nyI7j+99o16Jorv7R8Ny2f4A0mzuiSi?=
 =?us-ascii?Q?QZDECpDje2zviqW2SDJc12KU0tTC0t0XxvBCcmhxR4MAQz1tbn+4AnvfRcvv?=
 =?us-ascii?Q?3o+DNKIs2tRtWi4ec0bw5tBahRtUYju3YLO4yi+FoYLtWDy1u5aFyLizRRoX?=
 =?us-ascii?Q?GQNDmiF5rewNCPbXkWRuoHfB8PHaAVYgFrlS6cQfFa2FNPmwa0Ys2US5sm/q?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870ef6be-8be8-4b37-4576-08dc53ee839f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 14:58:25.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0H4DvHBWHTDzSK9uyDXQc4JJ/TMDAHFFOSxl4a12WFbGOAfPSOi/1HarrZUPXSGIQcYGMpJ9o2VhE8xj3DDvW2v7NwH3KfccEIf37EAtyuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4528

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


