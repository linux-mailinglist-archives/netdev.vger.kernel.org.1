Return-Path: <netdev+bounces-130279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA89989D30
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 10:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D7C1C21715
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0C118132A;
	Mon, 30 Sep 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bnWGRee3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26802180A81;
	Mon, 30 Sep 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686036; cv=fail; b=gxCRwycNSHWY8gMnOl9eeAyLiwBL0AXfSXQssO24YBg0BjCPVITPksoeKX1zb2Ws56cE8nSOtYFemgUsG4fK/Z2jOWaMdOF/wMZWuyiATBaGstmBAn5BPQXfwO7fpm5ii3viVPFSn6nwezKeAM4+jdWlouGoHBXAhlG2nc3/Gqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686036; c=relaxed/simple;
	bh=7WYlarn7T5EusOTLYAasC4n2TiIZZcZE0msL46yaKfg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFGU4ZrgAdNLIpSFKFN0AJhE1m19odFL7Q1w5fq7V7baua4ydj0CnG60Hp8r93+4nKIKFO9LdjnF0SGR6tqQw6GqiesisJ8NnKDM+ADtoNx9AszceGQqz5dDPZdQOW9SzopNbF7E5Q3TiOyXk4HIwz+I3CB+DCJvFE/OabLdnnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bnWGRee3; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gP0VaIdFDbF+5WrSgBsp+Co9ZAO8fphCJbrvtr201uT5kc4GQ8uw23ME8mJkBhGAqyGRwZk5NDjq36Opdlf6LgWP0Xb0tSECtyS7IHLOS4s5c9AKtDNeX+qFebFTyDLx95tWiBOjhwN7JsjHW5Pw53POLiPN36Tt8SDIHLBohAm0Wvz0wPxOhJNlvmbdGbvDfuzEesmL8SKeBQPN6yFH27jU+/wE8ZXE8FEUzKMEplp44V0so1O93t/R7yDlKoatA3WSgLjpkHAny6gCp8s2FmPnf9D5QbSaPuTz86mepKdqGzSFhVGTMUlR5Nw+bYkDQqO2ApQeMutsaR6vM35DFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ay6ZEu1AJJtsUdoNFhxHL32336BU6eKyyN/OT51nSRY=;
 b=AryjVdHNR36dHaVa/o3aePgWgFwUpdgYQkcnRZssIXCRJSJ2ZMudvawb7epXvFCdU3PA56KaJzyNyJ57dib2WjaN9+B/bzRM+zcUWi20koriAaDEzloYMaaRwT59aDg2ZsN4KNmSo/pk4RO9O2przzqGbp/m5RHxMtdAWWZvZl7djE7L/H3LYGtv2B07aSQkaKZ6ZebzzGykbTese1Joz+1Px0v/i/A/yT+FmK/Sdz/3gpLyhv9b4N3ez5qcjt4BI3sX4ZJpJ8lQwh6sKrE+lzvzztWvkxdg/wQJDYsTZgsfAnrAiTmzeAP1j46Gbe9dK0rFGkFXn0MC1+SRvjV2Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ay6ZEu1AJJtsUdoNFhxHL32336BU6eKyyN/OT51nSRY=;
 b=bnWGRee3+INwVJC8qev3RuGHkgj6hKtpTCh4bNNXaB25CFJaPbEO4QvSJZzASWHHk43bLEVhkMDzCniQ0rExojugg2n958jRaQdoyT3gk7uazuFd+r/wXWQwWHDFriYxj00iUAfQa4WQsuY2zdAio4k9bbkw06YeRsEfBlgpUwafqpm/CvJ/zL3VM/9p6Asu3DNDfKKsUOgBUPs2Rcaytj+wfbbDJloCm6jXOqT8q2ZzsjKTGYx//t+TEZAcx2Ct2pV7/6CnB6FMD9lktyx5sMefq6J6XJPfUNQUaOsfNikdnBSEl9sgscWX5gCb0cJF5HQ78FDtA9OfYRlpQrxZPw==
Received: from BL1PR13CA0361.namprd13.prod.outlook.com (2603:10b6:208:2c0::6)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Mon, 30 Sep
 2024 08:47:09 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::e9) by BL1PR13CA0361.outlook.office365.com
 (2603:10b6:208:2c0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.13 via Frontend
 Transport; Mon, 30 Sep 2024 08:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 08:47:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 01:46:56 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 30 Sep 2024 01:46:53 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v3 1/2] net: ethtool: Add new parameters and a function to support EPL
Date: Mon, 30 Sep 2024 11:46:36 +0300
Message-ID: <20240930084637.1338686-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240930084637.1338686-1-danieller@nvidia.com>
References: <20240930084637.1338686-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: abf47240-ccde-42d0-b6b5-08dce12c7898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n1RMooDjPp3rY5wCVmrmALD+OjYdLLSc9JvrE7xSiF/i9k6nnw9mHzRgeOeC?=
 =?us-ascii?Q?H5ya+a4ODA4OIKJTTMOuru6W6AbcIr1h/UfPambNkcr9wIO0Kn5aZiD4RSQn?=
 =?us-ascii?Q?zDVN21v2vAPT/uhgpiH71SQgGPx1xH48ETXoWD+BJCUW+b6j+ZUm/+dnu2OH?=
 =?us-ascii?Q?7ND7Qeiealb3rwmpfNUvQGqLCC/YrHeB8sAILJtMkQUYCHsQI8Vw9i1SPVTI?=
 =?us-ascii?Q?RYzQFgoMT8WbrOtiWC7I0w1smrYH8JCQfUq92b12Gzp/bZYcCWS/m1f4QTC+?=
 =?us-ascii?Q?w+wVcW9hcxOmy2p84K+VHOO39mV44bx9lCggkIjc6Ai9BHeL9M3mcE4G1UAS?=
 =?us-ascii?Q?+/cxb9IJVOoiBOacTzJiH80RPOHjcrq6wFaaw6H24bMwi4nFB82t53JDdC1u?=
 =?us-ascii?Q?yzj0ughSosqE8QjCFK3Liq+Z2ybkEShvKTgu3RBZUj8OS4fYBKNY4pANFPIg?=
 =?us-ascii?Q?y5yN27f2K7h29QAh6+BvaH2fK3NQcthZzM25pey123Rttu8UmKOF0rgQqORV?=
 =?us-ascii?Q?fCq62yeYuMiuCgx6gAUvCHjovYZECahDPr4sHovA0J8juTCSp/e4g5RW/wb3?=
 =?us-ascii?Q?csCD/YUrT++P00VOiDrJ1gQykkhaFYfTU/kHcNdg25DPlf6/nqSJGryjIX5d?=
 =?us-ascii?Q?RmqhFWIImVhVqJXS1y+asNKqZ4CoUcD97NyV2RjvDJhoSEZs9OwCCCjbx9Qz?=
 =?us-ascii?Q?MtNPqhRKGoDIbXwwxLXn5s0udjwHQc+AVmIGyE5cV/mKBR0URNGoCVDRhOxJ?=
 =?us-ascii?Q?nwdSqNRjtVD5+2FvJxm1k7n03DBxWJ5zwFBQGLYqSeUr7QLlbtNzoRc5r2Xn?=
 =?us-ascii?Q?wfpLgzc3CCL+rBylGjeO5oG6b1ghgg8DSgefVGREZfjRPZ8EmgtAIft/7jx8?=
 =?us-ascii?Q?xZbb2bv/TOB0JZd90cHLCQY6JeNXcHfqQjlmLRpEUCEKnBEZrlgqoH1KfOoP?=
 =?us-ascii?Q?mhRkMHpDgHhocG3fqnOtUNOogZ9WcxIZFgdC4SILc7Bs9naSVC41vgHc+TN5?=
 =?us-ascii?Q?tM0Q/71fzA1oW9z2K+sopeZ0lzPRsQdIPlMbM+E4g1nepKdXdJc97BFHwm8c?=
 =?us-ascii?Q?cysQncIQ0bxQZvmJy/PCXaKUcN8h9wwVWDkMV6BS2Zgczp6M/xSgLTc6sDnC?=
 =?us-ascii?Q?RTpHtsvDjby9+WggTFfzAiJC+9eQ1bgkgX6xTld7SM50I+gvt8k/DN7luXvz?=
 =?us-ascii?Q?S5SKwYvyRuJUq/7kEvLWSOSb4mR/KSt9H7ClgQsOwZN8bmHzjXbZA/up1n/i?=
 =?us-ascii?Q?F63v6CRaHDDuHbGvi/QziySScJXYifYLJktfxuhqD9USgIHEvYyCmDL06sLz?=
 =?us-ascii?Q?1laC8B05sNuiD0p3x2RtSPMBOe/lEIK/32hOUJxrK4V5g5UF6k25L8CHMIkc?=
 =?us-ascii?Q?ti0KwbproWKjhZL5I8UMeFdAxAvgNRoY9GkjMnOO1vcqPHwXeXV/RnIFEQgK?=
 =?us-ascii?Q?leYRfF6NWAq8hGo4oSZGIfbeqs5EV1Q9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 08:47:09.5821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abf47240-ccde-42d0-b6b5-08dce12c7898
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432

In the CMIS specification for pluggable modules, LPL (Low-Priority Payload)
and EPL (Extended Payload Length) are two types of data payloads used for
managing various functions and features of the module.

EPL payloads are used for more complex and extensive management
functions that require a larger amount of data, so writing firmware
blocks using EPL is much more efficient.

Currently, only LPL payload is supported for writing firmware blocks to
the module.

Add EPL related parameters to the function ethtool_cmis_cdb_compose_args()
and add a specific function for calculating the maximum allowable length
extension for EPL. Both will be used in the next patch to add support for
writing firmware blocks using EPL.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/ethtool/cmis.h           | 12 +++++++-----
 net/ethtool/cmis_cdb.c       | 32 +++++++++++++++++++++-----------
 net/ethtool/cmis_fw_update.c | 17 ++++++++++-------
 3 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
index 3e7c293af78c..73a5060d0f4c 100644
--- a/net/ethtool/cmis.h
+++ b/net/ethtool/cmis.h
@@ -96,13 +96,15 @@ struct ethtool_cmis_cdb_rpl {
 	u8 payload[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH];
 };
 
-u32 ethtool_cmis_get_max_payload_size(u8 num_of_byte_octs);
+u32 ethtool_cmis_get_max_lpl_size(u8 num_of_byte_octs);
+u32 ethtool_cmis_get_max_epl_size(u8 num_of_byte_octs);
 
 void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *args,
-				   enum ethtool_cmis_cdb_cmd_id cmd, u8 *pl,
-				   u8 lpl_len, u16 max_duration,
-				   u8 read_write_len_ext, u16 msleep_pre_rpl,
-				   u8 rpl_exp_len, u8 flags);
+				   enum ethtool_cmis_cdb_cmd_id cmd, u8 *lpl,
+				   u8 lpl_len, u8 *epl, u16 epl_len,
+				   u16 max_duration, u8 read_write_len_ext,
+				   u16 msleep_pre_rpl, u8 rpl_exp_len,
+				   u8 flags);
 
 void ethtool_cmis_cdb_check_completion_flag(u8 cmis_rev, u8 *flags);
 
diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
index 4d5581147952..80bb475fd52a 100644
--- a/net/ethtool/cmis_cdb.c
+++ b/net/ethtool/cmis_cdb.c
@@ -11,25 +11,34 @@
  * min(i, 15) byte octets where i specifies the allowable additional number of
  * byte octets in a READ or a WRITE.
  */
-u32 ethtool_cmis_get_max_payload_size(u8 num_of_byte_octs)
+u32 ethtool_cmis_get_max_lpl_size(u8 num_of_byte_octs)
 {
 	return 8 * (1 + min_t(u8, num_of_byte_octs, 15));
 }
 
+/* For accessing the EPL field on page 9Fh, the allowable length extension is
+ * min(i, 255) byte octets where i specifies the allowable additional number of
+ * byte octets in a READ or a WRITE.
+ */
+u32 ethtool_cmis_get_max_epl_size(u8 num_of_byte_octs)
+{
+	return 8 * (1 + min_t(u8, num_of_byte_octs, 255));
+}
+
 void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *args,
-				   enum ethtool_cmis_cdb_cmd_id cmd, u8 *pl,
-				   u8 lpl_len, u16 max_duration,
-				   u8 read_write_len_ext, u16 msleep_pre_rpl,
-				   u8 rpl_exp_len, u8 flags)
+				   enum ethtool_cmis_cdb_cmd_id cmd, u8 *lpl,
+				   u8 lpl_len, u8 *epl, u16 epl_len,
+				   u16 max_duration, u8 read_write_len_ext,
+				   u16 msleep_pre_rpl, u8 rpl_exp_len, u8 flags)
 {
 	args->req.id = cpu_to_be16(cmd);
 	args->req.lpl_len = lpl_len;
-	if (pl)
-		memcpy(args->req.payload, pl, args->req.lpl_len);
+	if (lpl)
+		memcpy(args->req.payload, lpl, args->req.lpl_len);
 
 	args->max_duration = max_duration;
 	args->read_write_len_ext =
-		ethtool_cmis_get_max_payload_size(read_write_len_ext);
+		ethtool_cmis_get_max_lpl_size(read_write_len_ext);
 	args->msleep_pre_rpl = msleep_pre_rpl;
 	args->rpl_exp_len = rpl_exp_len;
 	args->flags = flags;
@@ -183,7 +192,7 @@ cmis_cdb_validate_password(struct ethtool_cmis_cdb *cdb,
 	}
 
 	ethtool_cmis_cdb_compose_args(&args, ETHTOOL_CMIS_CDB_CMD_QUERY_STATUS,
-				      (u8 *)&qs_pl, sizeof(qs_pl), 0,
+				      (u8 *)&qs_pl, sizeof(qs_pl), NULL, 0, 0,
 				      cdb->read_write_len_ext, 1000,
 				      sizeof(*rpl),
 				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
@@ -245,8 +254,9 @@ static int cmis_cdb_module_features_get(struct ethtool_cmis_cdb *cdb,
 	ethtool_cmis_cdb_check_completion_flag(cdb->cmis_rev, &flags);
 	ethtool_cmis_cdb_compose_args(&args,
 				      ETHTOOL_CMIS_CDB_CMD_MODULE_FEATURES,
-				      NULL, 0, 0, cdb->read_write_len_ext,
-				      1000, sizeof(*rpl), flags);
+				      NULL, 0, NULL, 0, 0,
+				      cdb->read_write_len_ext, 1000,
+				      sizeof(*rpl), flags);
 
 	err = ethtool_cmis_cdb_execute_cmd(dev, &args);
 	if (err < 0) {
diff --git a/net/ethtool/cmis_fw_update.c b/net/ethtool/cmis_fw_update.c
index 655ff5224ffa..a514127985d4 100644
--- a/net/ethtool/cmis_fw_update.c
+++ b/net/ethtool/cmis_fw_update.c
@@ -54,7 +54,8 @@ cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
 	ethtool_cmis_cdb_check_completion_flag(cdb->cmis_rev, &flags);
 	ethtool_cmis_cdb_compose_args(&args,
 				      ETHTOOL_CMIS_CDB_CMD_FW_MANAGMENT_FEATURES,
-				      NULL, 0, cdb->max_completion_time,
+				      NULL, 0, NULL, 0,
+				      cdb->max_completion_time,
 				      cdb->read_write_len_ext, 1000,
 				      sizeof(*rpl), flags);
 
@@ -122,7 +123,7 @@ cmis_fw_update_start_download(struct ethtool_cmis_cdb *cdb,
 
 	ethtool_cmis_cdb_compose_args(&args,
 				      ETHTOOL_CMIS_CDB_CMD_START_FW_DOWNLOAD,
-				      (u8 *)&pl, lpl_len,
+				      (u8 *)&pl, lpl_len, NULL, 0,
 				      fw_mng->max_duration_start,
 				      cdb->read_write_len_ext, 1000, 0,
 				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
@@ -158,7 +159,7 @@ cmis_fw_update_write_image(struct ethtool_cmis_cdb *cdb,
 	int err;
 
 	max_lpl_len = min_t(u32,
-			    ethtool_cmis_get_max_payload_size(cdb->read_write_len_ext),
+			    ethtool_cmis_get_max_lpl_size(cdb->read_write_len_ext),
 			    ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH);
 	max_block_size =
 		max_lpl_len - sizeof_field(struct cmis_cdb_write_fw_block_lpl_pl,
@@ -183,7 +184,7 @@ cmis_fw_update_write_image(struct ethtool_cmis_cdb *cdb,
 
 		ethtool_cmis_cdb_compose_args(&args,
 					      ETHTOOL_CMIS_CDB_CMD_WRITE_FW_BLOCK_LPL,
-					      (u8 *)&pl, lpl_len,
+					      (u8 *)&pl, lpl_len, NULL, 0,
 					      fw_mng->max_duration_write,
 					      cdb->read_write_len_ext, 1, 0,
 					      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
@@ -212,7 +213,8 @@ cmis_fw_update_complete_download(struct ethtool_cmis_cdb *cdb,
 
 	ethtool_cmis_cdb_compose_args(&args,
 				      ETHTOOL_CMIS_CDB_CMD_COMPLETE_FW_DOWNLOAD,
-				      NULL, 0, fw_mng->max_duration_complete,
+				      NULL, 0, NULL, 0,
+				      fw_mng->max_duration_complete,
 				      cdb->read_write_len_ext, 1000, 0,
 				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
 
@@ -294,7 +296,7 @@ cmis_fw_update_run_image(struct ethtool_cmis_cdb *cdb, struct net_device *dev,
 	int err;
 
 	ethtool_cmis_cdb_compose_args(&args, ETHTOOL_CMIS_CDB_CMD_RUN_FW_IMAGE,
-				      (u8 *)&pl, sizeof(pl),
+				      (u8 *)&pl, sizeof(pl), NULL, 0,
 				      cdb->max_completion_time,
 				      cdb->read_write_len_ext, 1000, 0,
 				      CDB_F_MODULE_STATE_VALID);
@@ -326,7 +328,8 @@ cmis_fw_update_commit_image(struct ethtool_cmis_cdb *cdb,
 
 	ethtool_cmis_cdb_compose_args(&args,
 				      ETHTOOL_CMIS_CDB_CMD_COMMIT_FW_IMAGE,
-				      NULL, 0, cdb->max_completion_time,
+				      NULL, 0, NULL, 0,
+				      cdb->max_completion_time,
 				      cdb->read_write_len_ext, 1000, 0,
 				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
 
-- 
2.45.0


