Return-Path: <netdev+bounces-244143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C4CB067B
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 16:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15C683004BB6
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4880326529A;
	Tue,  9 Dec 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Enir/qjw"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA51DE8AE
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294258; cv=fail; b=XmQcRvAB8+LKsNXfQ8lpfFp5NA7b2RkY7+GY52SteC9g2XNzePSFYbxpL87TXFWuckQ0UBy/bIiVQI+XKfVuAGyNynUPi5cW8QatvfEgPk8RhrzqTJ+wD8Sga96TSHikA17w07OjrYaFTxkks2eA242+LWKb4GtaQ8ul4bRcaiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294258; c=relaxed/simple;
	bh=KF865KYMvb48dtikeWdjg8bL8PUZDZVX3HhDF3LWEJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5O0t2O40EVSFBIo8C8o9ivDk/gG9v05303rtTqIwFJ/hL8WabVCjWlEjSUEZ+hSo33XkdYdM1HiRB4InQOP4u3564Kk+5bwog96GzydxKa37VBcLuNF5C2FBBPI68yB4nWm8zl49owsA5kLwYNB8T06wHJ/noJ8VoF6P+MEIXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Enir/qjw; arc=fail smtp.client-ip=52.101.56.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nl+3cljMUzDOUrloExVfn1+7RiulmWhl+/1C1fDGrGx4nxnwgBNBJtzaaKOzbkLH7e8B/kt6OcqjyKfwpucKbHL13kiE86Dh3kqQLVpVeld7ZsqdNY81q+gZCQJ3acdQmc1revazaDB8jWWVEA0lks0509HY769/DsiCe1sb/4BIxIZf6zyqNVgvef9McMMp9duqGNQ8Fhu6Frd89dcK9VSYz0yoCbRQhOnfdxfAkuEMfuOMJgG7pR1HLK9POdEhFRvS3jVfJYv63Du97m34zVlqutsawzt2mAFq/5sKPxP2w9JYvio1gau8fd1efSymL3MYIeqkN+mKAg4U8TL/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0KkbEt1tfnQU3aRgHZDY2vnLI05txl3PiyPbl33fLQ=;
 b=bD80qtgZIG9inxtVc9RJpR1FNAPlI+h05RL9eNxS1V7Me/2uVF4HU7uZdzXw/jpCpaUKL4Xe1t/+FaIL5hFM2YY6de6JB+6TSZUpnG3GSslH4Ms+6ZjgLQtg+xHt3uDS9x145/AKwsgRZGhP4p5nsfxnZ918bsQUzfroLD6SKDej9wP4zcPU7Ru3taCGar4hcK2qg0HDRjiJ8L4mN7C1AXJm63SuJ191NkLAzeDZm1PXieJh7UrpLoeSYX1ZzfASsLbH8X9ezmJ+jcn03kRN/D/mOAU1u3oJgBAnpgKQIm8r4lq1KzuFfYTvwwo+QTOI7gfYkyx8roJCCx285kUabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0KkbEt1tfnQU3aRgHZDY2vnLI05txl3PiyPbl33fLQ=;
 b=Enir/qjw4SXAgn7gc84E9qt2yyRYVwp2uS+JZj/QHnoMPVTPrttCdQb8o10lH+0ddrHd1GVOu0j6Cs1+E3SIfBoGYkyACmpWYRH3Z79EnlPBrXaZMTGU/6e1xwkAG4SdZEbetcffvPRmFHVqgNCoY/zF8rpXP8NAMAOOoCktPFA6O7o69OFH7gWeF9OITtqwVBfNm3Ieeh6jxXn3e3Llf1hN2U7cdLKgcUrjDGQwNjmsbfjn5IF91QeSqvc+Y8mQqwHQfvB8uIOwqEnPGYBDhoCOgwnCS78MRsXjXAcLbTa14q2Ha77Qoq4vbejCS2kGLMtKPVZ7SJ+NA40DoHKNZA==
Received: from BN0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:e7::30)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 15:30:47 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:e7:cafe::53) by BN0PR03CA0055.outlook.office365.com
 (2603:10b6:408:e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 15:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Tue, 9 Dec 2025 15:30:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 07:30:19 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 07:30:14 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 1/3] selftests: net: lib: tc_rule_stats_get(): Don't hard-code array index
Date: Tue, 9 Dec 2025 16:29:01 +0100
Message-ID: <12982a44471c834511a0ee6c1e8f57e3a5307105.1765289566.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765289566.git.petrm@nvidia.com>
References: <cover.1765289566.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa895f7-faed-429e-7b6f-08de3737ed49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RNkUgRbo8H6KdGMr4uy9fbH5rKBEE0cxpVVutPPtutVH6ljTOnyAI4Q3fSul?=
 =?us-ascii?Q?4MR2BTORUqaI2eLLziw3C6eMWC8KUIA97vNn70HfIpRl6ZOzObmnYk05phPr?=
 =?us-ascii?Q?uyCOswAJo9ItEZuBsQcxbt9JqiintsiWQFHKsXN325Cz0M9+tCjnGCVbzZmO?=
 =?us-ascii?Q?FtU9JlmVFXW5Rd2aqNF3mbqqk6/9fvfORnIxuzHre3Bq3lFSNSZDUK/UsA+P?=
 =?us-ascii?Q?8Aeo3wwhuqNIdTY7CbdnSjsBqnc1Fw6/mLv56exhoUtmoT/maeHyMAz4idgB?=
 =?us-ascii?Q?KiSwTGCC/7J6Y6SuEMmuo9OdngyAT/mi3YHE0apSOxqQxvEXajLjbA5413BQ?=
 =?us-ascii?Q?EV2pYfas0+t38D9k5inOqiR7oBeFvAs+ChnSW3zrrSC/WlA5wJNCXFPYhKTB?=
 =?us-ascii?Q?tTwSImmOuHKOHU4GdcENtBvK9s3qHapqyh9omzZZ3CAaAYZjWDcwHuwgab2y?=
 =?us-ascii?Q?Z4e4kJIcd6QqK/IhA/mC88VzynaatM9wMbp+dAOCSqQTGIPTojeZioD1IgFq?=
 =?us-ascii?Q?1M4Ei4P9EtqtLRb4SqfnMKIqn/UcPDn9PfXuJgHnCmQsR1Wnw08WSn1GH560?=
 =?us-ascii?Q?NY0uQiW2dZRid32QQPf5TsJuWP+3LWPVxg8xZsuh5Ir1wNs1LuNjJOqItsS2?=
 =?us-ascii?Q?2wwEaSdcJPcjmSIqTUWjOofPOzEoAfzkB4wT2RH9ym5MgOG+23/ra9fIrpzU?=
 =?us-ascii?Q?nTdpi4veusMrXqU/0YLgIyBJNcUAyaC80BqL+/LnhyDuIhyMhX5e9OlwwDh1?=
 =?us-ascii?Q?++vZgwadWezwju16LBUmBd0TugMGoFlFjXmlmb4wuwZEgBmC9NxAzs6BSIIp?=
 =?us-ascii?Q?q5vCg9g7zfP15kuABZmfSWJ8f7txVNpNIChbNIYup1duLNopQuulnCPeItgy?=
 =?us-ascii?Q?cpxjuCqzjQ6zIXv4HUXKyVloCRhMBH1fbIFVyY+FQHnuXNvAyhTvXimJ8kC6?=
 =?us-ascii?Q?czisgnsDi2ScZi4mJH8SjVXWXVOSj4Fm2MvyanRi+QlLVTN92vvnfzGKyB1V?=
 =?us-ascii?Q?CBnIPA53KAlQx2/Ok6zTtzJNAjklzbTlOHtx+IaCLp9Ybi6//L356EOJJJ/W?=
 =?us-ascii?Q?Px/ayqSUpIDvK4Gcjil+tNaaT0v+Oq9HyqDeFrhbH116QmcQSDNwF+3Y5qeL?=
 =?us-ascii?Q?zZ15JB/UXwYegipUIqdm6Y7PvK7bGbYDNa/4HUVWPCBDTQQUY9wM5PpzhBgK?=
 =?us-ascii?Q?Bd9E7TKxjkJ2hcYxaHmal22DWx7X/iaYaOMhiMEegXpTGAhLnUKQXKEPSV2u?=
 =?us-ascii?Q?m2oZfbtlUNYid9kV/ldlpSKzOjK42ilMtzeD4cZg1Fq4jEJMdda2AbOvsqfN?=
 =?us-ascii?Q?Tjc1E5tKCoxu/Pogno7WX+S1seqWYIzl1mJVmz7PdmD2nGRhdiAdQ/9uBtwF?=
 =?us-ascii?Q?Y2sFX/4uyb6gpJmpC/sD10S0KGweW2Sz81fNo9Az5N9lhUR0n7vrGUVaRcXg?=
 =?us-ascii?Q?rCZT++IXsLlzhMqbmR4z/3uejPbuESzYwsjPjRy8V3lgYem2jjErs7mzOcrn?=
 =?us-ascii?Q?mA/ECDFmN1tKGJv7iEOaKZQE1sUhIGBeN7GNzVppeMkzP5NEyChW/1vrJ1X9?=
 =?us-ascii?Q?lHPjpe6qxvBzrdnoN/w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:30:47.5391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa895f7-faed-429e-7b6f-08de3737ed49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726

Flower is commonly used to match on packets in many bash-based selftests.
A dump of a flower filter including statistics looks something like this:

 [
   {
     "protocol": "all",
     "pref": 49152,
     "kind": "flower",
     "chain": 0
   },
   {
     ...
     "options": {
       ...
       "actions": [
         {
	   ...
           "stats": {
             "bytes": 0,
             "packets": 0,
             "drops": 0,
             "overlimits": 0,
             "requeues": 0,
             "backlog": 0,
             "qlen": 0
           }
         }
       ]
     }
   }
 ]

The JQ query in the helper function tc_rule_stats_get() assumes this form
and looks for the second element of the array.

However, a dump of a u32 filter looks like this:

 [
   {
     "protocol": "all",
     "pref": 49151,
     "kind": "u32",
     "chain": 0
   },
   {
     "protocol": "all",
     "pref": 49151,
     "kind": "u32",
     "chain": 0,
     "options": {
       "fh": "800:",
       "ht_divisor": 1
     }
   },
   {
     ...
     "options": {
       ...
       "actions": [
         {
	   ...
           "stats": {
             "bytes": 0,
             "packets": 0,
             "drops": 0,
             "overlimits": 0,
             "requeues": 0,
             "backlog": 0,
             "qlen": 0
           }
         }
       ]
     }
   },
 ]

There's an extra element which the JQ query ends up choosing.

Instead of hard-coding a particular index, look for the entry on which a
selector .options.actions yields anything.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index f448bafb3f20..0ec131b339bc 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -280,7 +280,8 @@ tc_rule_stats_get()
 	local selector=${1:-.packets}; shift
 
 	tc -j -s filter show dev $dev $dir pref $pref \
-	    | jq ".[1].options.actions[].stats$selector"
+	    | jq ".[] | select(.options.actions) |
+		  .options.actions[].stats$selector"
 }
 
 tc_rule_handle_stats_get()
-- 
2.51.1


