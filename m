Return-Path: <netdev+bounces-106154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2126914FAD
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD7E1F22EBA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A96142E95;
	Mon, 24 Jun 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qs+NXrRC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4213A894
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238402; cv=fail; b=Cg2r+WS32IThdCPz2eOekbhkR7zpq84zTMQqcoD3rhK6eNT2btFfcuguXeZ0UN7QxruX7TCXTHH36kW7UQUPZNy+qm9HhGx+RcZl97+DqHwMAJsbtlukIRHwSCu5dF/Oo76eDlc+vjL9UFvqhqR1kBEAI3dkudZuTfrPZiSfzYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238402; c=relaxed/simple;
	bh=MVqFKwMuVbg1p1f133R9KZyczZ2dOPADbP9FY0KFgxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuYLV0hkYzjK8J7KiEoZ33vA3hxS1zvPx/Ija6r6pLKgP0gjK2AiMhDrBAxAg0OiKbXjY9rjTuSeCFj7qKg9HUPR1E4HPCQQVOi4YIWjTl1UsmO3MUvrlekOPbDcGRH1A1KpiXMN3eIh/N0Ak2weCXWK7mtymExT89rzqekvbQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qs+NXrRC; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H12HM1x/CbBpvyoh9INnI/NNOcz0cRRzcjcD8/AK8nu76ZCZ5Sl9hdeCsZXuHUGpJ7XjBnsIWt7GMuiec0z2+lPA8J3Pd3lSSatsK8x5rUQCXeWV2bkJzHaKSxz5fv6IvFN8lvpB9KYRFUbn4C1RFZFLplngQbx8WZC/hBG1ujEjSY3y/NJ4GyIvUthXgV6X2m/LOU7qZgxAJTO8E0rHcH4+mqVhjkZ4gjTPS4BAyQ79IAmfv4vYEr+PhJDc0qpfPJG7ie5hXZ/fCHRWG6iSZZLLvkAik9/eQM61xjEpqin+s6dRq9tu2YDY7j/WVFwwm/wWYYYohUg+kbv22/8MnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icFCc05ET0EWxPmpOG2nMouyuNc46mfQpKKUpaY6ZtQ=;
 b=A7gz8Idw3x8YvO1Tzt06Li9CtMKKn8Vf6Z+xuMgXWZzahrl0fy6IIl8uCFxMF2ykpmOFVgju1Li9IjlWRJNVmWszF9rfp1jJ0Hw7AhhFBBbMV4Zs8gt5sqCEm8LH48LxUoI7wmQkCtHgbNcMi20GF9kICxhMa81nMZp3MWCQg3U9gXcSwZBLXcwmIyjP4ppURhSLv9zR25mDP/xdkOk7o/YDCJDbv7eNaKg7cb4KUFeCkWY4GWDm9oB4rAt7LaKiXPGHOPnBr6EbX446tJ+ZEeBAiEaTJc633OVtDiLOLsZN4wZcvU9HpRJLyfCf5TlbHj953S0L7A8T/B52Y5qGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icFCc05ET0EWxPmpOG2nMouyuNc46mfQpKKUpaY6ZtQ=;
 b=qs+NXrRC8IfD5WVrH3l/HDuhM4vH0fosm9hjz3fzq9Ta4n0eBrVUjQ6vNy24HxrYMx7u9A1lVeujVQC3VohGPTYyErdDdwW25XmtrJPUo9PtmGl9m5B95CLtrCj8XufB7v+8VsYmoiLbYU0dmH6hsBS3SOg9tl4ocpCUV6pl1qw=
Received: from SJ0PR03CA0078.namprd03.prod.outlook.com (2603:10b6:a03:331::23)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 14:13:12 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::bd) by SJ0PR03CA0078.outlook.office365.com
 (2603:10b6:a03:331::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 14:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 14:13:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:13:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:13:08 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 09:13:06 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>,
	<horms@kernel.org>
Subject: [PATCH v7 net-next 9/9] sfc: remove get_rxfh_context dead code
Date: Mon, 24 Jun 2024 15:11:20 +0100
Message-ID: <edb6b51c0722a9a5c5e4cee68305b0ce986cbea2.1719237940.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1719237939.git.ecree.xilinx@gmail.com>
References: <cover.1719237939.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: d9469a6d-5de0-41f5-63af-08dc9457c830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|376011|7416011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+EloA7vtdI0pk2fHkIVupxFEOIy74l4Rd29qVTtcbmgg3udX/Iwimt/PdJn6?=
 =?us-ascii?Q?W26eyGQu8FOoo5wfBKzmqPvhd39qi+k9x/t/6K8wrAUMzjfCylnnKOgHlvOH?=
 =?us-ascii?Q?Rk2XohGlRRdqUVh4g5FIKmuGWvzgZUt0+wlgTnYR7fJTqKk3PlffEGgo3K1S?=
 =?us-ascii?Q?ShPNF0jQywRixFrkoriLe0+aIZ12Jg0LgSWOLmfpqCC9mpsei7e1jbJ6Ih8L?=
 =?us-ascii?Q?PY6dAuvTWwsOjGjCnViAm9+x5gNoI+geFTRmmr048uhkF+6QMBW9mW1Mxi+8?=
 =?us-ascii?Q?wUAeaMNTZyw8autlnlV92f2kC45idmVfJlf3GtFqYmcU/sh9VcnH2CKsanfa?=
 =?us-ascii?Q?3pmlirPL4M7iI6c2mVKIh2Ys/EOA43kxZUYsqiP3MwDK/y0Jl+jMlPs07ZQU?=
 =?us-ascii?Q?hHs7cXw4SStmxwk4GKc/CaGka1Yl2xblSPejYQOVhIBPOX3inlAOpoG4FKKY?=
 =?us-ascii?Q?+SStO3JQPGVFzQpfEBmrJWwN54b6txsK5K2KJ2grqaCn3wD9fBB/tGj6mK9a?=
 =?us-ascii?Q?tQ/4RMnGTRr9DabBH4t9dbxdQjVLMSS+Ax0Dj2QQPM0N5PDudp02Otzb3wEw?=
 =?us-ascii?Q?Gah4qupW1K70eE3jv/Oz5hoVJXprKo4Z4Hxaaw/ZaGT9WY/Y37wNuEroPb1h?=
 =?us-ascii?Q?ni7/LqaoTFa8SI7Naqxfnlq1tC3Vj/DysOw7xOdmr0Zgm/MddJFKqh8FPDr5?=
 =?us-ascii?Q?QEm5VRgUpRixTTw5Lj3OLdRszqYvdwa3EhLDGqUueQCQgSmgkgqRmuoezZOv?=
 =?us-ascii?Q?hKhufP3T6f/n27mHaWjW1+EwHv4UPjzZ+F2H32bUBZYMsawCajxRYiXwW8OY?=
 =?us-ascii?Q?9R+k3wJLsHYLi8tvXgL0Co5VZxR1yTsS9eByVNCKauoFQTC2SMuipWk4Z+pu?=
 =?us-ascii?Q?2bDdlfcUGvPnvJxdi+2v0YKpC0B/3HdaK/9PStMRc+9OfUIlUBR1bK+A6hYS?=
 =?us-ascii?Q?TCOAAWfWHvwPWqFy9fGbbzv+Pf1BLKw5uR6iFRz2GHOsjGontKZSBCPDqeDJ?=
 =?us-ascii?Q?IWnMR1u8yE240UzKO5nHi5D53HszrPZnzUuQPr0TZ/eBofqOwLsNre17LNap?=
 =?us-ascii?Q?07sc3JIWsIO6HRyfqz/YCS21PJvCqQOsREeLRAwJn0VuTJak4gNYkTSVhHiK?=
 =?us-ascii?Q?ercuGuHFIoTOI+jjFh0CbZsfyLA+ny1y3sSVAv+33BuS0B0f5Kru5yc/TG3p?=
 =?us-ascii?Q?Z6Q+zwRdjDhB8rMsvQR6rHyNP9UZ27jATe0Kzw3NIxtjfi65BYDeqCzAV7WY?=
 =?us-ascii?Q?h+NZOuZ1bjNS6cB+6vwpYcvQoZnVvB5b6KS9bSA10US+WhlyA9TlbbHhsOGk?=
 =?us-ascii?Q?2ja78Ea62dC1qblrs7qNgK69BCpp0JExOfiI0gSY60g+qTJQs4s+e2aojY05?=
 =?us-ascii?Q?0CAwyGCNU+iDf8RFajHXWWTR8Zu7EIGl8/AvzESmWJ+Zxjganw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(7416011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:13:12.0041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9469a6d-5de0-41f5-63af-08dc9457c830
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428

From: Edward Cree <ecree.xilinx@gmail.com>

The core now always satisfies 'ethtool -x context nonzero' from its own
 tracking, so our lookup code for that case is never called.  Remove it.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ethtool_common.c | 38 ++---------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index 0a8d2c9ffce6..6ded44b86052 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -1163,48 +1163,14 @@ u32 efx_ethtool_get_rxfh_key_size(struct net_device *net_dev)
 	return efx->type->rx_hash_key_size;
 }
 
-static int efx_ethtool_get_rxfh_context(struct net_device *net_dev,
-					struct ethtool_rxfh_param *rxfh)
-{
-	struct efx_nic *efx = efx_netdev_priv(net_dev);
-	struct efx_rss_context_priv *ctx_priv;
-	struct efx_rss_context ctx;
-	int rc = 0;
-
-	if (!efx->type->rx_pull_rss_context_config)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&net_dev->ethtool->rss_lock);
-	ctx_priv = efx_find_rss_context_entry(efx, rxfh->rss_context);
-	if (!ctx_priv) {
-		rc = -ENOENT;
-		goto out_unlock;
-	}
-	ctx.priv = *ctx_priv;
-	rc = efx->type->rx_pull_rss_context_config(efx, &ctx);
-	if (rc)
-		goto out_unlock;
-
-	rxfh->hfunc = ETH_RSS_HASH_TOP;
-	if (rxfh->indir)
-		memcpy(rxfh->indir, ctx.rx_indir_table,
-		       sizeof(ctx.rx_indir_table));
-	if (rxfh->key)
-		memcpy(rxfh->key, ctx.rx_hash_key,
-		       efx->type->rx_hash_key_size);
-out_unlock:
-	mutex_unlock(&net_dev->ethtool->rss_lock);
-	return rc;
-}
-
 int efx_ethtool_get_rxfh(struct net_device *net_dev,
 			 struct ethtool_rxfh_param *rxfh)
 {
 	struct efx_nic *efx = efx_netdev_priv(net_dev);
 	int rc;
 
-	if (rxfh->rss_context)
-		return efx_ethtool_get_rxfh_context(net_dev, rxfh);
+	if (rxfh->rss_context) /* core should never call us for these */
+		return -EINVAL;
 
 	rc = efx->type->rx_pull_rss_config(efx);
 	if (rc)

