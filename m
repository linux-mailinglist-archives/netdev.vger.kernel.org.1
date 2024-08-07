Return-Path: <netdev+bounces-116546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025F294ADAE
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0291F20F1B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2F013DBB7;
	Wed,  7 Aug 2024 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MEVWoJzu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782FD13B295
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046825; cv=fail; b=VXn4eeCEw+uN/bdmQIgUCflm95YszSPnGDvtWM55FY3BEXfBTwbr2EaI2At3jvi0UnEIYcoFqTxRSrQFExBTOpqNAa7tsN8fuBm5xO1gjxiyk/q9aqu1fh25OV97B27jn8J+ys+z9o6EWKIXFvI/+tXHNU3qusJ51IKaYQqqYNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046825; c=relaxed/simple;
	bh=HWiZ2stvWVrisEeADF526g1VXHYia3k++32mzkrN4hk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ls9vqKH6mipJ36oWCrKEw+qlJItkbvmPXIgyowv/itXdBSk3+NgQPChksRucrR2PWkPZH25Kc4ZJHxTkhYG2WmFKR1VoYWi2/FYQ9UZWk3cXcq5tBDNAzxXm/LyW/0l71k3Kk2HNjJvMR8lw6GWJ9SMDNY4dmzM17F6K2Ua4WAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MEVWoJzu; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whE0yDmxjgsOXYC0fJXD4kWp/f2imMIMQce7RpvnSkMl6dQZ8E10aPpIHtcT0lnKYmrGgsNabzqkWzc3uf2zY34c71GyxBcPOdI6k8EwzsbDbssUDKpDUrmFFm9hcgna58jBNf2WaP/PkX9dkf5bCFkxYLWpBwxqIuDkbkEkCRzjVt9s/Js1CID0tEh4/2UtP8Kg535lyRu2jN+6yJFLDczDmI0ii2bsyDi4Fp1qqvSx0KXCJg52JxQk1Svhq7jifdm0fB3YNhmg/nEHxOZnMUEHomOFie4j2O3yr2Vfv2OcqwDfR+EPjVq71tzI80s8J05weEKsDqOtEvXcRbH9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4ZPnKyMSPAeEubhxvmwOVLa/2OGOAJ8JJWg8fgkbtI=;
 b=W0go7wVt1fUd1ZoN7gKsLz2tdCEOQWRhWG9xQkSBswe+lWqgNpzAr+9BxmaDwgoNVVC9Wv7cKaSduHoYFKBtm38RcbO2T8+LPL7sGxlKAMBiJTXwnjemGEgV1STa/+esl+f4XRqRtA5GxxUx50l2Vt8LeHgVVTZoxXclJgnywDEMUEPLdXbbqlorqTKNEQbvCqlus4Oqbx6wGPrA2fw7BT3565xgqpuBVivB0+klO6MYtKr/MifHt8pN/Tqbw2IsmTTG1+OCoO5V1vqYLTSQ9m71cFGjDXuglwoVNpKFR68RTuOcRco8Vqh3n/rth4SQNEuFCO6MKGJkYr7qCk/Lkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4ZPnKyMSPAeEubhxvmwOVLa/2OGOAJ8JJWg8fgkbtI=;
 b=MEVWoJzuhxKJA7e9AHqnKlTEZym93DPbtQ8G47zn7NEmYRDwQFgmcKyLDr5qtYMrR7c7vqEiUmO22riZDLfC2Kxwh+4GNPxnZ50mr6DqswgWWYqT8QutI2iFZvp9eLO67UBMDuV7RN7G/5SqX9WFUQASoeIAY5KUpU12eclMObg=
Received: from PH7PR03CA0026.namprd03.prod.outlook.com (2603:10b6:510:339::11)
 by CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 16:06:58 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::ee) by PH7PR03CA0026.outlook.office365.com
 (2603:10b6:510:339::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Wed, 7 Aug 2024 16:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 16:06:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 11:06:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 11:06:55 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 11:06:55 -0500
From: <edward.cree@amd.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 1/2] net: ethtool: fix off-by-one error in max RSS context IDs
Date: Wed, 7 Aug 2024 17:06:12 +0100
Message-ID: <5a2d11a599aa5b0cc6141072c01accfb7758650c.1723045898.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1723045898.git.ecree.xilinx@gmail.com>
References: <cover.1723045898.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c14b70-76e0-4ff0-84ae-08dcb6faf640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mTDRPe9/OZXlfyGiqPgCPzwxN6WdHFO1MCIPBgXsC0nhCg4fvpidNeS4Ag2u?=
 =?us-ascii?Q?Er0XD4pdjlvX+cnIHiRKO0cMP4KQyNizchUQkN6qxyt46HUMdSOj1Fkf5ZhI?=
 =?us-ascii?Q?ecNiyOyBagezb4Qf2TnGO2X50EikHcmlOr/T4vRW4LFXK2vb4CS2f+uGp9yB?=
 =?us-ascii?Q?FqFR/H0mymqDtALgrxLs5nsyDEmBQQN0Bbf8sMJdHqskUgcl/RawAtxeQ9uF?=
 =?us-ascii?Q?l92rb8wwHXAb/5ozENqM5YsNDojgOAvobeCQm3k9DBak7f8hQcK5wsltLVMX?=
 =?us-ascii?Q?SqP51NiesqgcpJ68ygon+fr8epiDusGwiBVppZo7pS6V8iOHskXBZO86uvSH?=
 =?us-ascii?Q?stfwhoy0i/7uT+JQ0zhFvlu6xFU5JQhSY7PfTZ/OnpbCyChl1PefZ1T48hTZ?=
 =?us-ascii?Q?WtVWvfTjVUw396WrwLosLMwtUObqsXdTzaVSM25XkmaQ8/P+xiDzfQomacow?=
 =?us-ascii?Q?Mx5TEvB5eVmJCicmkQApFkhU//VZ7wxhFp6ao2CrKAgA8l9CE0iIZbz6LRH/?=
 =?us-ascii?Q?O3XHASR28WzQpvXDLdhg2ofdKNaMPcdRbw/XDLa6h3UIEwz07+TJuqEI+o38?=
 =?us-ascii?Q?F61+vkF+xvcOEhYyVzghzuHEWZeK+JfJgRzOSBQ4ZKjokZTSi07qfe4UdrG3?=
 =?us-ascii?Q?RQtmkKjY7CkVCAUbeWPe3PUjGMZCKubw9bcuEq4nMx2VtiRXvyQOV1iZJJAV?=
 =?us-ascii?Q?TNI4tqimX4I3rwNe59a5HTACMLOdksJymJ/7GIXZ1vx2LduYBlSCIzHuHA5X?=
 =?us-ascii?Q?RAWCJqcW06hc6f9cstNtcA7IcvLxXERSw1TLCimLIJ8YmTavn4vDvxIqL7DL?=
 =?us-ascii?Q?UtbwhFXKz7R4m3SjpzkwZPl06BbBwvqbQl1BcxOQOdpDsoyf5bI0EOwmv8f4?=
 =?us-ascii?Q?MBd9zOei71viZax6YpEVAc3ks65GcK144Ak9LYCj66pzjn00bjsL/d4gVawd?=
 =?us-ascii?Q?dgpqqrI+dUSIHwT5BHZAQW7Zuu1V+G7BDTFRZPKb6JIcxNCNWNzh3eOKwSW/?=
 =?us-ascii?Q?tu6chp/avXR8C0QKlSj3yrjWlrQCVqu/ADrOk3iJ8z6e9KiRkT+PNca/V7q+?=
 =?us-ascii?Q?NPYbgwP9aRjmP/FEkhDovIaUGwdZ61iNPLXKSbi9JCulaHJECqSQm7pdRFj+?=
 =?us-ascii?Q?JAJmNZKzCDU636ERHJMBWmLbIPua4sGHpaF8/I6EysjTPBd6i/JFGCsh6Eqc?=
 =?us-ascii?Q?0lWEwQzihHmNtkTS1CARwWjtjD4xE7W7vgQ88MF7kXWQ2IRTQbLRidgjk02S?=
 =?us-ascii?Q?EdsSrRYTOduZ9AaQ5RptRT2Euxz59ZrtjBDSodu+RXn4bBA0RiPjf+p756Sv?=
 =?us-ascii?Q?/4h9cMjAsbq8+OlItQWMWRImS4CA2jHc89nxFjhKRmk1dbRPNxBylZBV6j/W?=
 =?us-ascii?Q?bajMym9bzjJ9wInDq6e4M9SdKFED18uSn0GsMmqr59SBTAsCnPZpUqWJB/KK?=
 =?us-ascii?Q?+yun+1DPW2yEkZVhXthuoqFv2+W/e3OB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 16:06:56.8021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c14b70-76e0-4ff0-84ae-08dcb6faf640
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268

From: Edward Cree <ecree.xilinx@gmail.com>

Both ethtool_ops.rxfh_max_context_id and the default value used when
 it's not specified are supposed to be exclusive maxima (the former
 is documented as such; the latter, U32_MAX, cannot be used as an ID
 since it equals ETH_RXFH_CONTEXT_ALLOC), but xa_alloc() expects an
 inclusive maximum.
Subtract one from 'limit' to produce an inclusive maximum, and pass
 that to xa_alloc().
Increase bnxt's max by one to prevent a (very minor) regression, as
 BNXT_MAX_ETH_RSS_CTX is an inclusive max.  This is safe since bnxt
 is not actually hard-limited; BNXT_MAX_ETH_RSS_CTX is just a
 leftover from old driver code that managed context IDs itself.
Rename rxfh_max_context_id to rxfh_max_num_contexts to make its
 semantics (hopefully) more obvious.

Fixes: 847a8ab18676 ("net: ethtool: let the core choose RSS context IDs")
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  2 +-
 include/linux/ethtool.h                           | 10 +++++-----
 net/ethtool/ioctl.c                               |  5 +++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index ab8e3f197e7b..9dadc89378f0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5290,7 +5290,7 @@ void bnxt_ethtool_free(struct bnxt *bp)
 const struct ethtool_ops bnxt_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
 	.cap_rss_ctx_supported		= 1,
-	.rxfh_max_context_id		= BNXT_MAX_ETH_RSS_CTX,
+	.rxfh_max_num_contexts		= BNXT_MAX_ETH_RSS_CTX + 1,
 	.rxfh_indir_space		= BNXT_MAX_RSS_TABLE_ENTRIES_P5,
 	.rxfh_priv_size			= sizeof(struct bnxt_rss_ctx),
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 303fda54ef17..989c94eddb2b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -736,10 +736,10 @@ struct kernel_ethtool_ts_info {
  * @rxfh_key_space: same as @rxfh_indir_space, but for the key.
  * @rxfh_priv_size: size of the driver private data area the core should
  *	allocate for an RSS context (in &struct ethtool_rxfh_context).
- * @rxfh_max_context_id: maximum (exclusive) supported RSS context ID.  If this
- *	is zero then the core may choose any (nonzero) ID, otherwise the core
- *	will only use IDs strictly less than this value, as the @rss_context
- *	argument to @create_rxfh_context and friends.
+ * @rxfh_max_num_contexts: maximum (exclusive) supported RSS context ID.
+ *	If this is zero then the core may choose any (nonzero) ID, otherwise
+ *	the core will only use IDs strictly less than this value, as the
+ *	@rss_context argument to @create_rxfh_context and friends.
  * @supported_coalesce_params: supported types of interrupt coalescing.
  * @supported_ring_params: supported ring params.
  * @get_drvinfo: Report driver/device information. Modern drivers no
@@ -954,7 +954,7 @@ struct ethtool_ops {
 	u32	rxfh_indir_space;
 	u16	rxfh_key_space;
 	u16	rxfh_priv_size;
-	u32	rxfh_max_context_id;
+	u32	rxfh_max_num_contexts;
 	u32	supported_coalesce_params;
 	u32	supported_ring_params;
 	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 8ca13208d240..a8e276ecf723 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1449,12 +1449,13 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		}
 
 		if (ops->create_rxfh_context) {
-			u32 limit = ops->rxfh_max_context_id ?: U32_MAX;
+			u32 limit = ops->rxfh_max_num_contexts ?: U32_MAX;
 			u32 ctx_id;
 
 			/* driver uses new API, core allocates ID */
 			ret = xa_alloc(&dev->ethtool->rss_ctx, &ctx_id, ctx,
-				       XA_LIMIT(1, limit), GFP_KERNEL_ACCOUNT);
+				       XA_LIMIT(1, limit - 1),
+				       GFP_KERNEL_ACCOUNT);
 			if (ret < 0) {
 				kfree(ctx);
 				goto out;

