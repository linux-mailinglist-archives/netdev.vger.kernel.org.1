Return-Path: <netdev+bounces-130865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D48A98BC67
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA231F22439
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84DD1C2DD0;
	Tue,  1 Oct 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J14JA/b/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3761C244C;
	Tue,  1 Oct 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786561; cv=fail; b=aexUXD0WByxOKoTtjYOlExOx3mPXnpg5hMaxlZZjQcbz6fJp3IPXt7ifMebU1b2Xk1A+Ij7ekdgWisZGRnyyB52aXUExOHcwbCwPJoDLbg6obnXi2kpA0nA6JPhDMNY1V0IMgduOJrP61/IBkP8B39k0l7HfGrddcxtC4uNg98E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786561; c=relaxed/simple;
	bh=6QZR5MqtLaYYkd/0TflD7bsJ2K2011ih6cNPq0AixqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRLQAiin5Z82xQcpHRVOkdbWFnCNf3CaSGD5LFEK77YKBhI208+6tMue8FvGaRcdwdHN3SzX2jbCkP+HgGG25DcER3PapMDZpOaVp4a0OyNQBQiZwnAIafj3QusP1ykCooXb91Gq04b8jEhdBZIZ2GMIjBsRCfA741Us9UbZVwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J14JA/b/; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rB+L14vzBwMEfQpkcM5o2eOUJICzMifkBr0KOoMthMB1kdcTTPGEwcytc9lSZ8w78f9VICuNPWxhvJdlsCp32E4dpefoVKUn8b1xMV7ibVkxb0cSQkMb3cP0K8mYy5Np5LGHHdWHFP7Q0hJQoOWSVF9Uu/jrChr7NZAWbV6C6PpRRXq6TpdkZJSYiBotRGD82drvpvjnJCXRla8JLbIJ1LmyzD2p2vbG9e5ON+E0+OaGEWwdboSqgwBz+3VSgZp5NSS9DzQ6eC5CkifxQ2+QBt3BMfaS4M9RlPTSTEQ9wpyuAIw7kfgtbtUJU5xwnfSBeRrykpzFRrpZIB0o1Oxowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPHMiR2KdTzqjbgRMxGY1OJYkRW/hjnNjNZBuGr67/k=;
 b=feVLI5nk0UPpIQJp15Uau3hkdTbq8phtG2P1vdrcMkApPFDsNn8noeiiGmJ5StGXSPLOAeACRvu0VnKNCI1ADS2TEzPYPTtKl2Krvn2bW/IVUjaMRYXqcfvWsk+yDsIhtkMhbE5fkCeMDgjx2L4uTAFfsAI868oTWrFTJh0qh2oK3TyfpkQn4ahZwhRxcWWJa9u7kRcKqut4s0kd3q1vjAZUk5/f7pdRGwxqQsaM9Qm5wsgyW7/w2+zSJvNf3+wFnwFt1zApTlG83cgh2LVDgUj1Z+aRnpiAyZvbP7UEYbDxsyeA2FiE6hzKNYPW+bEid3jfh5FeUDp+IwHUh6PEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPHMiR2KdTzqjbgRMxGY1OJYkRW/hjnNjNZBuGr67/k=;
 b=J14JA/b/GP+VqQRl20UUCm+w1Li2DlG4YPCoxP9aIAZz88pvuqdXBPE+xA1Z+LCULOkmtV09HPTos+vm43neqZ5ctVXe0DsuOI5lwbb82DzdfzsLZ8MRdhPyFy5+dzEjbMxpgI9L+LR35g38zVrRsurCV/abPfjK3M7pCkNXyhtL4CULd5nouTOrFqVldB8qrbaaOmP32HS7cYi2lHNGM0Ow6F0cmw82/5UTYi1hBOmBsZAcMltJsKGSlEnOwBQrEGz/bXoDC14gh26zrlefmotfZvrWbV8BxRRNLDnqNJ6rlSGt8wKtI3xH5RHBBZC7kSzAREP99UZP6lD96NWJ8A==
Received: from PH7P221CA0086.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::13)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 12:42:34 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:510:328:cafe::69) by PH7P221CA0086.outlook.office365.com
 (2603:10b6:510:328::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 12:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 12:42:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 05:42:12 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 05:42:09 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v4 1/2] net: ethtool: Add new parameters and a function to support EPL
Date: Tue, 1 Oct 2024 15:41:49 +0300
Message-ID: <20241001124150.1637835-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241001124150.1637835-1-danieller@nvidia.com>
References: <20241001124150.1637835-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e07222-81ad-4aae-da79-08dce216856b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OhxTXn9sv9v0iBWaRc2mZnu37/o/apgh4WyFM4YI9ZlLiRuCKeF/Q1mlp0BS?=
 =?us-ascii?Q?BxvgHvYD9uKTRyQnik+6xQgKz201vmppXOjPBNKQCh7P1pImDc21gAPhlxr/?=
 =?us-ascii?Q?5l+a91ljZ01Q/NJpFtNSIqteJYT9jrGiWWcPIoDAcC7EqKPJMu2nKd8p0Ita?=
 =?us-ascii?Q?sOJ4L+GHPYSVCoq99ZV0B2g3Fb79TmphxszPqlLCl//By5/Q0U/4ifmb56fg?=
 =?us-ascii?Q?ARUAjL+YLpUJDf0OuqFYjT4lhK+YvdcOsp4lqXMhRbFKUgQqSMCtuRj9aXzD?=
 =?us-ascii?Q?vF7eUW4MHKvuoaVC/pjVzeZs5a6mkJw8rgwjtv3WM1ox3QxGxM982gTJZcFw?=
 =?us-ascii?Q?iqt3GoYVeWyy58uexd+sTX34Q+OV6neRL9PWY+ytJ7hYEf5mfGrgduMuUD7L?=
 =?us-ascii?Q?x4vfFDK+lci9wzY5cKhv27ZQCZNo8Tsi9NNjh0mOfs9H24anu9XemH0tr6Q9?=
 =?us-ascii?Q?EVh5ADTpoeFxwEmKVxFC/AYwxGSVY4u7QBs5NuEcAuoxiHDocm1VoDKpZ21N?=
 =?us-ascii?Q?HTJPha9oRcXIoJbbTvMfR11ndIttL0Wm5hdJIyYH1WHfbc4FKTkrP2Nlg8XV?=
 =?us-ascii?Q?YegMwItzdo0oxireFECg1r1YbyWon2SmaEnMfnvuZUJINnTPD7jrZEZWC0ot?=
 =?us-ascii?Q?TfkpfJwpgWmFH2aKDdL0O04BQkrpB+GjTm3dwjg8zfHvJ19FqasncHLmXpnA?=
 =?us-ascii?Q?lt9/evVLjHU0+J3jgA5GeVX1Mq2af6g48nY3LEPtF3lJxM8fkFvBHl3W4Xyy?=
 =?us-ascii?Q?HnhT335Mpeyp5yas5CQUql//wAKgwjM+airUW5X7uhva7KV0U9/M+7hi/3Qb?=
 =?us-ascii?Q?UybcYp9caOGRMv5M31N97HU57sSc4mIai/P1j9Rh9sAGcZG98GdWOE+zhWG6?=
 =?us-ascii?Q?odaSgLotQcu4ew7FyM7uwY9Amay5lFCXWhJ3yy9XQvOZ0uBZoxIeSd3s1hVZ?=
 =?us-ascii?Q?pTiaQVmKqDVxHmA2D7h3KnJfBucHc//bWKzMzC5bl27BANTgthKgY5jK8InF?=
 =?us-ascii?Q?KI+9R/1EWqLK+0wWl6z6tLyxnbq33RFDnfKEIKIRxH+R51lapN8V6JMwKTGD?=
 =?us-ascii?Q?Pdo8N/e+mJfuG55xlAopSVQByXPqZNji5IgWcWxY5BLPfc+HPpWVj1DlGcjp?=
 =?us-ascii?Q?YglIa9Li0gQVvk+u8prN5NSzVG8l2bwVYyfhbOagYXpoWQ2ENzbI729BHBVv?=
 =?us-ascii?Q?wHr97QdwCEim9beI7Hhx7JQgHSAB6MbD4u78t1Q2YYNmkV29sD7dnYvMj4sW?=
 =?us-ascii?Q?VgENbcTdVUpZQ/8f4NWiQZV2T5JqKXaNVh7l9m0NtJIMi6UC3/S1w+o3d1oe?=
 =?us-ascii?Q?ivECsholBgRmJduGwO+vzWFLzqttCUBm5HcyH2JFpFrSILPFD1tQpsUUIBpM?=
 =?us-ascii?Q?2ROQhzMSaf7MSSq778IXV0uVrmDl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:42:33.3176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e07222-81ad-4aae-da79-08dce216856b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

In the CMIS specification for pluggable modules, LPL (Local Payload) and
EPL (Extended Payload) are two types of data payloads used for managing
various functions and features of the module.

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


