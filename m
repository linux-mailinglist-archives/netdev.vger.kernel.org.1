Return-Path: <netdev+bounces-154577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCAF9FEB1A
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F053A272A
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381E519DFAB;
	Mon, 30 Dec 2024 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EZj7F1sW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D891A23A0;
	Mon, 30 Dec 2024 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595116; cv=fail; b=Bg5bmRUi6mkekKevBAvR0fI50Pf3aMnf4blRo4GLu37DGC4g+3wCFW61zRjwZ8A6a0o+L/Jq3ENhZCv8I41b/9RPImr74uD8fZC8/xlr4HuL85dgq2gpAJXeL1IbzBcKhw3vx9bFn4zWYZb330GgLOV7mYsCM4RptHRVHW/PmDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595116; c=relaxed/simple;
	bh=bceKgxZJ+f2OQrvqvHb8m9+RcOnEu4tqaCVbwEAERkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Azae+FINJk5UgrCspGrs7qkfgwCBCmkf7XC0bmvi5e80KUlr6X6PcM+gQtdA3OgoGOyD8INLmnUaoEhEeG0m/HQCkFasWAbGp7lHBgPy2MzbUG15ZR4qXCmPiuG/qTp5NGKq/XA5GwPK2Aqbq/5X7/fbcmr/ou6MMhn1P4CPyjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EZj7F1sW; arc=fail smtp.client-ip=40.107.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/1xG8ufO11m2pUYwk8P9qUzQ7uVu5THWeZP2aNVyMnsUZQRMOWwQA85wFUxsX1r01JKzve0tpSJFylDRbyzDaaES6C9dj3hl5Ur+FMWpYw+XP2sy7Aza3FVBldSNks6gOAojJ4V5hhVlWdpHp/VKh0E5n2vT1WqA8hTmv1Nhw16GCx6iyd5qGYSKYNGx9GJtL+ndLcMlx/B1JdTBzZKlqsOHrrh3iD5RcJVKyhHJMVcM5HEEKw3VBCh/5mb2xTpGCVzwFKmTSmytIppih6VUnZs2dB5Cstxk8mA+hnIeRphB4G1psJ+eIX3KAkFM84srL7hr6YDpBUOSNQvMBGP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKB0j1uGcLwlL8/EtymKc9I5H6PDbAUuMotax2dmgBE=;
 b=Y0/EWCU4hUen95UOYzoZCl2TYKvreJA0NAPFRxL5LS9CKnvr95e8cI4QppJKnRmfxFg6PagTc2lZ0TfZPEIs/QafxA0vU1wbmIWrd6LA3bGdP1YwA3WWORUbjaikXqJwaCh3i6Iy1Z5wF/cjxIedRd0BwjJzAq0uI2eogUMVERD8eVOoEteNWaqSSomyAVHLj1RHh5uICwSq53RhxlvrhHoxJkQsB2+Ljj3qFgh5+w5e006vT6xvFiw3u9wlWUZgAIX6x5uoO8oLHN7OihWLHztvTWi1L2YcNVGkcQpctiXb0EF0P/j2ekRyYuMnFgbYL73GP330L362UyfjOxEKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKB0j1uGcLwlL8/EtymKc9I5H6PDbAUuMotax2dmgBE=;
 b=EZj7F1sWrVp85/NON0GTxvTWVagcvrKNqlvr/vx9bRp9zGfyBpEqywU6lvlb9czEQ41b7byVEhwiu+UW1BuWpyT+rrj028NdHUum+HWzsmDEuk1xZGRvvoc9r7vMsj/iAA/rAvm9X+tpgJqKKj/4Sw62dsRp/g2hBhRzKQrn/Gg=
Received: from DM6PR17CA0033.namprd17.prod.outlook.com (2603:10b6:5:1b3::46)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 21:45:07 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::8e) by DM6PR17CA0033.outlook.office365.com
 (2603:10b6:5:1b3::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.16 via Frontend Transport; Mon,
 30 Dec 2024 21:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:06 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:05 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 09/27] sfc: request cxl ram resource
Date: Mon, 30 Dec 2024 21:44:27 +0000
Message-ID: <20241230214445.27602-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SN7PR12MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: afc5c873-701a-4c1d-45f8-08dd291b3a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aQ+N2M4m9HrdDwVqiFm+onRjidC8wK6f1w9AOvT9mJoA3dRX1lFwRchT5jjE?=
 =?us-ascii?Q?nELsHjHk/2y2Dc4VFKnxQTBOT+w++iBnOmStF9v67EiEYMpkmCSLDe5RyVvn?=
 =?us-ascii?Q?qmZeBtthNV/M+76ECWxPPU1Hh6LyRE3RDhKAMCaKF18yt2KYyEvakXhMU8ny?=
 =?us-ascii?Q?8bic9OYLbFNOU0QAbKtaQ7NhUNShMxBamxIPSfEB8hvihUdKyXO3BpLpYt4Z?=
 =?us-ascii?Q?7BrHjQd0+cdHu93ILzXRl+fUQY3PHzPPJjFFfxPssqJ/G35YNp/ZkDMz7fp9?=
 =?us-ascii?Q?G2tW4CN+3tX3KrgtX+me0cC8/lC/wWrqQ70TB/2SISMWIv2CsE4C8128e86i?=
 =?us-ascii?Q?oG6En6akedGX388k1dmMfe60IRdZpmIwaHY4Cv63HCWrQvAGS624Dm/1J37f?=
 =?us-ascii?Q?ie/dmBj114ujRxb2jQhVPs8swO1mAvYJXI4PVX9WztVQa29XrOCjshcfZy7I?=
 =?us-ascii?Q?EJBtrODcdafymRlGozqr5Zru2+QfZd7NsKFy8gd8RQTeNLDjDBIbV54sU6y3?=
 =?us-ascii?Q?NujpkOTB/GBjdaVxurhRZBGR18iOy4m1C9zY3pTDFF/kZ7R40CUctpv/hxUP?=
 =?us-ascii?Q?HO8ozBkpoVye/o4tDwg8xfOzLLeLV/3lCBAo3LuKF/L8HMWN0W7sBm7MLoJ1?=
 =?us-ascii?Q?rdFKszjhFxZH55ixpoZhopGBMzWi1PdAO8DugWArOk+hvH9gWOg6HLfXo/SD?=
 =?us-ascii?Q?QOa5Z6e3+eBmBwUq5w7gOZFP4g0LIJhZ9SnKXsVHXpNkl8qZ6bH/PzeGNeZU?=
 =?us-ascii?Q?ad5ir4i46R8slszqa9CQGQXbnkq4NqspP4IZMrO0Q+v7ZbV8bcwRdFIOnOlS?=
 =?us-ascii?Q?gX7omseafPbVujUySp2Swv6VHyJPpjAbmnFaJrRS6FrAwJR0aOtAON0qyj41?=
 =?us-ascii?Q?MNGJgKINVM9Iuip/5o0ChWK69d8Z+I1GAwQUei4sZypNFcpgEzgxDd+uRAjL?=
 =?us-ascii?Q?b73imLr62EvHT3W1VTLRRjbJhhsf0BvtcnSgE9jbMJYCH4Pj+8mtYr4uYdLr?=
 =?us-ascii?Q?px3uQ0vD7u+q5ZF06KD3qr7L7DJtaXlNygWVFUmKDVhW8NPnBi/6LMKrsxnQ?=
 =?us-ascii?Q?+xiP32DGytRS5an1Wg2XtraPGla3HDCG6u/byOZKmu0QDreqDNPgZK4sUkqx?=
 =?us-ascii?Q?12bfy7jjq2t01HKqMbnxb547KXWeMraScaSNmtafdEtJhu1nCBqJWXk1sBfH?=
 =?us-ascii?Q?C0BOhm/mxmQ3JzHv+c/9qKhlIJ71uAg4SaeIL0qmsVf45BgecrwxzdNpGZ6w?=
 =?us-ascii?Q?U14LxLEB6VWkvFC2NV3Oj6qgKYGmts2H2JDmqTF/z8TY5F/FBi8ql4Bst7su?=
 =?us-ascii?Q?oX+a6ED00QjCsogZ2AkqSB4lEglcsIl3Z4lPNTNBEt/xGwz8/Thr5B4KD7/L?=
 =?us-ascii?Q?gChQ/iOlm8bc/vXlofNf0a2pH82YTYa5M1JOc9jqVbqwxhX3QZn2lJbtw4+J?=
 =?us-ascii?Q?7QLqIgYq3GH26DXNJpUYw2IVh8FQLG/bLMgKP8iuAB0+uWR1/Nh2XuVzM9nW?=
 =?us-ascii?Q?VxZT4ffUbyfP+P0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:07.5719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc5c873-701a-4c1d-45f8-08dd291b3a5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057

From: Alejandro Lucero <alucerop@amd.com>

Use cxl accessor for obtaining the ram resource the device advertises.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 29368d010adc..2031f08ee689 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -85,6 +85,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_resource_set;
 	}
 
+	rc = cxl_request_resource(cxl->cxlds, CXL_RES_RAM);
+	if (rc) {
+		pci_err(pci_dev, "CXL request resource failed");
+		goto err_resource_set;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -99,6 +105,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
 		kfree(probe_data->cxl);
 	}
-- 
2.17.1


