Return-Path: <netdev+bounces-107378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D88591AB80
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF241C24D11
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEACC199EB5;
	Thu, 27 Jun 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mi8e6FtB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF211991A1
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502491; cv=fail; b=LpLGAuh+CSBoExRWmrnRLM/1eXWZv8aScLRke8Ja8KEtapQVTilOHt9ylCaicHZ26k9yU1dIutaK19X9dVcmAUTpQiUEs9zKDCohnlOFjz92A/QWTYUum78tiTdvUzKxTkOYrS1cKOX0KMmAOQuKf1EUsmwmK5Qp2c6LT4C+FfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502491; c=relaxed/simple;
	bh=MVqFKwMuVbg1p1f133R9KZyczZ2dOPADbP9FY0KFgxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpG/31P/YvPn+ADCxFIGtFPEX9N9XhH0QgPUtQoEB5n4JycP34ETerzHCvIW+n0W081u2XhETUZoz1DqwgmaAul6eBwDJtg2j++Ux2wCvJ0bDRYet2oCHX7TzzfZ7++uFoZiTHx2xfYJJZUbhFLTgh5sYRzodk3uA7SmupHFlLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mi8e6FtB; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ex5fdz9oRr2zN88/rpl6UQQhqMDxVRCXA6LYMpL8sHK8oXPoX7wdz/r4nM+9M00w6Oee8/FlaW+fv1bjGBA9ghfEnNLsVN+uoBy+cn3FDIvdC31dWQJyKhlb2udXfeMXENsTcuVn8LyLSmu8O4IzmcktOAnntOKkFl8qYI6qKUZXHuyfjyCG4X6Nd3HYi0CkiDDe1B6Zg/2mIfupZXBnRQekUNXvFRc0wgtfQIdezkwgh24y2O+ENVXRiQ724RwzoilfnYnRWjJ1mBjE7huPSAjB+VJUPxIUSOFvDJ+km2sWPG86NEdztojbenmSR104xfg+fjOmpzgqbO+CTTKTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icFCc05ET0EWxPmpOG2nMouyuNc46mfQpKKUpaY6ZtQ=;
 b=g9+vLUFbUcowpC3pHLwdMVull7myrMwKgBouS8qNSyk4e1dzIJ93dyquRZ7t47DDQQR1X2OQ7xPmtPfPyVnRVoDp9QVwtHrIukmZcr3ibS+plCS/mGPWN/mz1ZefmxUsxZvD6jnqryyAaDPgu55HOGhgwfT3l4NinZrySRdzYmMlkGM3DJ48bJoDY63OZieNT8LiEEzS8w4Hs0Y1/3ptkRaA9BouaFdzJvLPuKyBNc22iRwOEZg73YTcLo+MOGSNt6xiw5yB65vPY+PsqN4oWzGT9og5qIm07ubLzkrqxWvE8jwT8MbqJ1hkQOwjCpnvrvId2XuqpHbqXhpNB0eJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icFCc05ET0EWxPmpOG2nMouyuNc46mfQpKKUpaY6ZtQ=;
 b=Mi8e6FtBi7zlfCZzlOnJEoelRQGsGhGhTYTCEXmhmlIRRq48eG3grC7sRADutaZ5Jgc07pDXYP4HxXHvjDP73eqUIJhKh2lNltXM+CasUmhgYQ0+tfEqntMq0/69PY4YMGS3Z0jRveMGKAIq7Ocomdcgf/8uSsn1abciOyGxjkA=
Received: from MW4PR03CA0300.namprd03.prod.outlook.com (2603:10b6:303:b5::35)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 15:34:41 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::b7) by MW4PR03CA0300.outlook.office365.com
 (2603:10b6:303:b5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.23 via Frontend
 Transport; Thu, 27 Jun 2024 15:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Thu, 27 Jun 2024 15:34:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 10:34:37 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 10:34:35 -0500
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
Subject: [PATCH v8 net-next 9/9] sfc: remove get_rxfh_context dead code
Date: Thu, 27 Jun 2024 16:33:54 +0100
Message-ID: <b426fcc416dedc8f203e52eebef6891eccebe4c1.1719502240.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1719502239.git.ecree.xilinx@gmail.com>
References: <cover.1719502239.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b4b609-5139-43e3-3aeb-08dc96bea8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Og7cG72XwjQErHGwExDjFM4+OsKJIAhTnU/8qkQrx6ZKLs5gN6YkkVHgzJj6?=
 =?us-ascii?Q?KI2MdZU22xzC+zDdL92cfi1FlyidGOHFFDfXrVdjKKEWy7D9idkPAaNwJo+d?=
 =?us-ascii?Q?RPW30HMlKF0GCLGuNXgVR2iZoCWZrgPKN2sMME5onBq5vya94OcBrsAorJzl?=
 =?us-ascii?Q?aBpksV/i2/LVliqyo1sKtx14bnTTd3O9E6FlEpXf7A+eqtg/bUFNbPpuZ8Mv?=
 =?us-ascii?Q?wACdvOCuBAEXIscrcnUb/yEgn1gnRbe2cEC5sg9uz9th71Y75qhB3Zv6agz7?=
 =?us-ascii?Q?uG6ricBMDHlU2EEaj7zL+P7CcZ7nLpAxVZ+MMj+YnT1GUiD65QelUcF/lZMU?=
 =?us-ascii?Q?+EpMYk92McOoets4TQ+o0m8D9ZiRURmmVTjYab+PDP9UYIahieL09oVpVvX5?=
 =?us-ascii?Q?4njwg3qYqMvfpBb4Q8FIZvBZAWaMGP0pCcw7VXUeJpaQGCdODd3pSEU2URzG?=
 =?us-ascii?Q?sK1yy+CsbS/W31XRW7vKgkml5LFj8PWB7GlilqyXGnUf6lPUJBz2WTZMnh+1?=
 =?us-ascii?Q?In0dZAIGXnOyFoeFQh3W0YbeSTKUMT0Rjqm/TuVU4LUwFL3EELUYgf3Uvrl5?=
 =?us-ascii?Q?VdSisX5hMgw3O/+ILPidz/xRYJ7SaCgpfIyQ/izSMi2UBt6d8ibBoANr7tgm?=
 =?us-ascii?Q?2Uz8kOnhnm5CLKJwspvuH+cQ9WHVBIv5EC2cQk/vqIHUilGOPICgy0nsENJl?=
 =?us-ascii?Q?xFltM5HIbyKWYf1o9oRLy5CuxyxrHEp/IwR9aB2D94oAGltVrMvtO4IZwNwl?=
 =?us-ascii?Q?mT6D8RU90vZHFrTFW2w4Xhz1Emhi6lmHZkylfWS6QQt6DceVqCfPVOYahbjj?=
 =?us-ascii?Q?S8uaBIdG6rXoNBclA4QIX7XXWgLtLU8uKg7TrnF75TSKxGyl0qn1+26JqmUI?=
 =?us-ascii?Q?3QSgeyId9iT+4X5xulNDmEd/YJ5G7ptNrqZTwAUPfQSrkBI3B7I/leTVS1BL?=
 =?us-ascii?Q?rKXsJrAAFXxCZdV3jaJuao05GZJ929VFO0N3skXb3ou2DzRHYAHAbgD41w1F?=
 =?us-ascii?Q?V5LGJxfQb/1LO2aZImonjPYj1wLqkS4UqO8F8yMIEQ1Y5jYwxZup/ppmVoLU?=
 =?us-ascii?Q?cMj9FMtNhNUzm7NT4rMpSPrN5G1vd6lBc3vhoRfUuXUl5ODb1SeObn6sU+jp?=
 =?us-ascii?Q?Pn6C94LE0T6/nna1gvyJa6Fyfz8mGfXYVgId/272BPtcCl429v9AbWsQcG93?=
 =?us-ascii?Q?dlShLJzN3sPbSaSSifW/+MkKHrRr+VBZBVpB3XxOsmkL5V0KEv0inT2XDSo6?=
 =?us-ascii?Q?AayLEO3zWIS5YWd4sogx5ztPrLglv3hAu0txd5ABsNubASXWZLpizoE2czSL?=
 =?us-ascii?Q?Mqj/RHcRVwavpobT7cFN9EM2AiAt5YKmxuWytopC23rFh7H8w8UApXq68tkN?=
 =?us-ascii?Q?iMxAVC7hWjEDM/BPm+x+hmsUxqxIhtJqssNjc+joAtWz2DJYrL+gQlcPCH4J?=
 =?us-ascii?Q?HlAB2UzdLmxSm9MLWGegK4ogKqhIlz8L?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 15:34:40.1703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b4b609-5139-43e3-3aeb-08dc96bea8fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690

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

