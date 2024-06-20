Return-Path: <netdev+bounces-105127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50F090FC50
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A151C23594
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 05:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2FC3987D;
	Thu, 20 Jun 2024 05:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UgZCXFPi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962E3BB50
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862508; cv=fail; b=BEjjQv8iVXhplLmvcAYk6qtu73t9rYr2iS0MApqGScZtBg6UvTad9iCccAMnB7/uIyTy3Ce10CKwxzVj8hznEyXOAuUTI2KU2KCY562k2luonDyM0pOQYK70TxbQmegGajZDp6/cu7ETQsna72qzaSfQFf47pdKm6C/gp8qqG+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862508; c=relaxed/simple;
	bh=MVqFKwMuVbg1p1f133R9KZyczZ2dOPADbP9FY0KFgxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsaRfMB4mcbnBuq6Hqpul4YOLcxZI3KIUUaw74b3pq7w6YD1DQdM9c0s0Prwv5b1GRUmMOubVomE7VTFUS04VlHghM3OY4b+XDViW+MlgstKZKCEt3LaEIdMEgH5t/hgEDH75qwo6CMvxGUSVmY+D3Rs7iDiIee+XBy2ZSwTbWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UgZCXFPi; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1vf6aK3Mx4GVqUy37LpirjJwAwBjJqWJ1kqyF0NLYRBCXOcKtaw7Mcmk1C6Yzzb8k1M4zYywQjVtOX46nNxV2Te+KGX48h6TCN3atHa1HzYf734RvueC5FWMKBjd8BumRLmOgGqRVOeQmH6krBCLUGv15mi4B7ktwu8JK0yKdj9jUW8lIR9XMLikAc/tqDDOIeZUvN/H4vDj97TLV8vpD2MS54khPb9LcowPk3omGFYYQozTIL1Idc1L40pjlhw+MsAfg2toRa1NymLqsMxPSg20WJ4WzLbr0D8j0+nps0TVfHZqPRedsmctG4YB6fspsnmwfrYkgt1jVxm+50OLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icFCc05ET0EWxPmpOG2nMouyuNc46mfQpKKUpaY6ZtQ=;
 b=doQNIkJAojDciVVQgd833WfJp6yVucNFhKCI9GeiFv+R6L83576k+KsSG4DQV37Q6NWp2DAAv8Cp3k5ROs6pdZ0bQqanpQtQRk1bAPJmPgdzN9ITkZjqI50QM1MBrXzvmc965kg7us1TssM3BWBLLrLSoDJ1N1ou6vPEE3l2ue4GhPS/sInwqYjLN9nIUq2fi/WBwwu9cGOzqY0ZDtLM/5v8n2N4iLbRNBtQwyo5p6BaH6qmfg+DcY7qT37yRdTzojSWyJjiqMM2gdBAOOMu/PhdaV/mWuVc7XeOmD15cWzxl1C0sDisiF+FEGoD44mKV3e51zw3RwKPlVZdRXnlIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icFCc05ET0EWxPmpOG2nMouyuNc46mfQpKKUpaY6ZtQ=;
 b=UgZCXFPi3/h1/cFQ4GBJILIf9ibO1zoid7qYVJLEGK7MP+AdZwHhoXW0AGHtkVeojWTkEuLy1GF3hUWK42AhPf3OQQhSrFAupwMdEloFAakM9gbDyzLreqz1BHBqL43w/f4z7ak0lL01c9HhhSeGRP3k0vCTJpEG4ZPkyb77Ez0=
Received: from SJ0PR05CA0180.namprd05.prod.outlook.com (2603:10b6:a03:339::35)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 05:48:24 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::de) by SJ0PR05CA0180.outlook.office365.com
 (2603:10b6:a03:339::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 05:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 05:48:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 00:48:22 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 00:48:20 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v6 net-next 9/9] sfc: remove get_rxfh_context dead code
Date: Thu, 20 Jun 2024 06:47:12 +0100
Message-ID: <382dbfb2d2469c19beb01ffce3377b7f3158c3fd.1718862050.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1718862049.git.ecree.xilinx@gmail.com>
References: <cover.1718862049.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e644aae-943d-49a5-261e-08dc90ec994b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|376011|36860700010|7416011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gy/7sPEzLned9Z8HPmyd4M1dG6uXrEY8ww1LGtl1G3qIH4lVBsYlvaZ8mN4i?=
 =?us-ascii?Q?WQSH6JA0Scm2K9CoZEj2cTeZ9xYEdD2ZozSdCpI+wNPD7gpfdiZPGv0il+2v?=
 =?us-ascii?Q?dwZ0hT4HI+/ZHcKQlkH0aoUu50Oz1lr/NyEXyD+EdpyziCXgU29CQtGcWDcY?=
 =?us-ascii?Q?nVO+77RWc6JrcqfcDPnStLqk83X/A6esJQlQerYIip7Vz6h8qgRO/eAYJSny?=
 =?us-ascii?Q?gvJp2hxPIEJ28yQqniuaceA4YEl0bvwUHf6z1wSch/8HEGgFXhwyawv1wYu1?=
 =?us-ascii?Q?OOaEtOhL3m9IYo4USNn68GNDVk/tzbKoKPJOdUb3O8qlP5MKwJ8REw7N2CME?=
 =?us-ascii?Q?FQ5ggeJ5SHVo0+rgSuZXQ8reGcqw1RcCHZIJPTz4s7mw6H93UvuDY2XOCMkw?=
 =?us-ascii?Q?EIH4Gacve0oOfUYn3/MjCPw1d+Zq+9EpSJ/hcPrc6SqTiiCYf3y8u7YQiaT3?=
 =?us-ascii?Q?ahqO5aVwyboUwywyKHkWjCxvW9v9H1TMcNIzzDUbiyOmc6tCh0O8fdmfBpw+?=
 =?us-ascii?Q?pmw9QiULdzbtpgRh9RLCK9jQ8/dN9pjjRvPq+ULhMx32FdqzF7wm0oFwnOKR?=
 =?us-ascii?Q?eF25lVXT+cCYANY4CIvVHKUtpw09Aplz120m1SJ23eqLedrzDTNPXKTx2uBg?=
 =?us-ascii?Q?xf0kV98vQoGdMCYvKwS8AlOIfR3zV7ncQZ/SnVebf15Lev4ozCHEoVSzt16V?=
 =?us-ascii?Q?fHJf4cakIyX6Csu1wNZyR00zOjwCg4xoprpClmDpwRZ/CTL1+dAvFrSWiNPv?=
 =?us-ascii?Q?PzMBAZi6uFdKFfu9G953kvzFlyI1DeONqrzSmWkG6IKGz2MlJnjmQGllOJfw?=
 =?us-ascii?Q?bl8gFpuw5DVmkLsIh2wdZtIWecdnC7jB9sOcNfvueJh57lAtBy1D/tA6hMd4?=
 =?us-ascii?Q?hsGMKw9SCRzXtIdQq3soQJUPNY19zmG6ESAg6yBiap219h4p56FfrcrQLJyN?=
 =?us-ascii?Q?eEV4u0FVOEvbAsoOG2YyG26qX6qeG4hQkHZZ3pSgipQIHEYF4QaZPN+v2mFe?=
 =?us-ascii?Q?ojAp359bWd+Vy0XwKh6YkTzE6XBbHy0hVULYHBn1OvgypYDHLlCPsKYpdpjz?=
 =?us-ascii?Q?7faJZNhWcw2t8NJGji6R8l0CxIK5OzLdonSQ13VcsfWl4vYjDWnsWU4rMzei?=
 =?us-ascii?Q?HIAq8pOn5CWj8iB8uKMVPfQGORzpbtXAEMtfD8J5RnVpt9JPQ9bUXufBk5DS?=
 =?us-ascii?Q?IzoHjz6P64ixDKaao5APg6AgaEpoXKozn2wCm06SyXVmkkY72e2fEbeJKfks?=
 =?us-ascii?Q?M9nqZbwnsKulA31G7wePD3anzYiPoOJwMnGoqVo4wkg52ObcvtaEEmiSDKy+?=
 =?us-ascii?Q?mXK/59yGllLa2+6D3x6erB1RN4RjsdHRZwyB0QGfhXYtDfiioKNrV2zcQg7j?=
 =?us-ascii?Q?quUZC57XwFx6s40QEYtGt6Uff4qAPXGi/hT3om7l8XMj51SKTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010)(7416011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:48:23.6882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e644aae-943d-49a5-261e-08dc90ec994b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487

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

