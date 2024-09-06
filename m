Return-Path: <netdev+bounces-125791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4BB96E999
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A71B21B2A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 05:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0615D13C8F0;
	Fri,  6 Sep 2024 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iHWYKf//"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A713BC0D;
	Fri,  6 Sep 2024 05:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725602259; cv=fail; b=ASQ6hZjSTnmMg3FXENwed8q6LUkEBy2MwSEe953fiNgMkvYgajO8QZAPOYqoHm9Z/dcWruxQUJHK8GBXLde2QM+Qr1C1fZgBdfeHD+UAodCJaU6sX5qVrGjpGlT00ZMKygEc3eSRvWHA/pqZwLRkVn8abqpedidvTIyGzpCtiNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725602259; c=relaxed/simple;
	bh=Lzti+6fA6DX30mcmJUfThZmibCj9ICCBWwgvxqvwIz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVY7NvXXXBTZQ/xQg9c4pKfMf8Nk86CIdfiVapIgDuRiNu1eQ7VmNzYIy11r4AOjmxUJQ5dgr0aTosimO74zoi46S/Jl0Tl0f9/ukVpcxkDlEPkDCBz1VhooSNMVy1SMmKzQxQr/6pxgF7wi5JPQJNI7MjbGvx+fhKBAjtkUFW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iHWYKf//; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY8307pZ1bpZE1LOdD4T5pC2lxdR7m5XHxJ3TnP5Rl0COS5883InEkDdk1DvY+62xPVsxO++DLgAY9wgI1KsaJjwxjXP7KdEYgLjzfdK31PHLAiVo0AC1akribv/R0vY3zAsqNNVrB2RC4TmCBehx1lQg6e4AlnQsl307+b8XETScGx/LLz4jj4OpheAMa2byWtOCfVNAsr6blI43MfBkqvZTer3BzAFLzTLk7kwEeOLtbf7nDjG8F1WCzeFHP9f0oyYgcEs1VbH4wOBrb7m4c7f2aJpVuhbA2AONQtjTUTEP+D8tUX2prHTELuRzoIhy4j8vL9CwfhO2hhHalAK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVXkU7al47hHBU4tYMufEg1N51vl1YBgBp7pp9jNZe4=;
 b=SJLMhiT3drPjMkPMY8DaYj6bZlOPXb8e8wky0wsNTVKXXhRVU74ysALTyq5+t7lPQjWXanIfTCal4GCvwi92lp6fv4jtDI2iD+moGd3/0nru73ToOeKu+56v2vuSSHf8WBBsS1hsxR+tIrhKfL5NXtnkKGpZRJ9AdfyNvEWQBPbG3apv9XFBh8O6kXx5Mnt3gorPDHTLQqI6ib7Z3JthzYdz649YLezxhSSxHHJydSsGLXqz4RaaNqB7aisBwPqRx0URUOOUEk4WrHF95xkGkUGaORQ7RaumKSwcNOS2eqIScCL9JvN+OgoaTH/H9FJ5LfVQ3wLp1O4Vf/m21/yqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVXkU7al47hHBU4tYMufEg1N51vl1YBgBp7pp9jNZe4=;
 b=iHWYKf//Mtwi4mBf4JnIcSyAx9k8iIYivm+ejlT5xvJ44JbgtBgWGzycDm/MmAHiOvXVttUhVM4aGoc8GyBW7pPOmjccqd3zqHFJqpQXz+6MrQUQGW6BSg19th54Q3bMfwZujqLc5ZpQ29qoAk7eZGE4e+azkhTLeL4mUzYpoGJ2h88UNi82TJDZWfcjOd7bwz6UP+xvfJ34rFBFVTMGW+n3EuKl5mGSXc1BZnrCwTEXngGHBDJUG2+3Ii+Ns4mLNNeT3p4rCsEFeZWkbxwG1kErifQpN7bZK2SnI1iFjNDirye7jXAdP1iackOWyDqUF/8fn2xqszjXeGvvo31GHg==
Received: from SA9PR11CA0001.namprd11.prod.outlook.com (2603:10b6:806:6e::6)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 6 Sep
 2024 05:57:34 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:6e:cafe::47) by SA9PR11CA0001.outlook.office365.com
 (2603:10b6:806:6e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 05:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 05:57:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 22:57:23 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Sep 2024 22:57:20 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
	<petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next 1/2] net: ethtool: Add new parameters and a function to support EPL
Date: Fri, 6 Sep 2024 08:56:59 +0300
Message-ID: <20240906055700.2645281-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240906055700.2645281-1-danieller@nvidia.com>
References: <20240906055700.2645281-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5e3960-8509-47bb-d02e-08dcce38cd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uTS8KOHJgjNt5Xnq3OtX5BD+8CLyFj1MpAK8eNpIC76VynDhQT5SU+nleIuH?=
 =?us-ascii?Q?zZj8Jjcc8g27lOd8byWtNzW1Pf5j5jRoqKe3pen5LcCz5rK3csPzOXtV1LS2?=
 =?us-ascii?Q?iMpNAfFup7uupko2ax8W+8Dvo057FI65rdNBFbs1H8wfjkqqhzIgxZdGcAk6?=
 =?us-ascii?Q?tAOvHkYVYZzi00aUpa2fdcilxSHUee6SoKl7ucTNw66s++1SO7nwK3GVHmFk?=
 =?us-ascii?Q?i162D4DajkN+sma5NIaxd+ZGOwQWaXS4cFZF+7wzYkBwN14cZkeNP6GWsINN?=
 =?us-ascii?Q?IYreDRrdWDkhnzwXgQutICBTWzQ3WV0+HG6B0cthWhENfWGIxMJwU4HS24t7?=
 =?us-ascii?Q?2XGNQXLzVlHqeSLjwKYFiW3HtoSrEsuiUE2vY8VqFuxq8wgR2e3Yovg0njbv?=
 =?us-ascii?Q?CRzgfOr6pMSPD4dhjgMH3xDZxMl0wTd5b3VlhUX0ysxEZkaAeld47Zm/MAYU?=
 =?us-ascii?Q?KbnxExy1n4yFKzMNtotaEVngaOBwAIueMIl8hlG2bSdu7EqujWfA7VBwZyKj?=
 =?us-ascii?Q?cPpuhYq61LVUGPAYPyeXfv3KHEHjKy4vSZF+HACeXSPqWRjeDuQnaM2PwmmI?=
 =?us-ascii?Q?DkghK5WdyiBDy7Sm0+ONRPadZ9N01El3IChMBlkSQ/eIKhj6Nb1U7yJ650zm?=
 =?us-ascii?Q?sNGyIGKpCuEFG2Yc+rkR6/E1iEUE/qHL9/QoxOBht9ZrMeibICzdirQVNfpF?=
 =?us-ascii?Q?U6QIcwKqdKRkKs0SPyGHi9pU0mkHqMnKn1DMyoxrA6hWV+hKYEeHfT568RDs?=
 =?us-ascii?Q?uYPvdJ8225Xs6YcTBRWq3ipznrPVJxmFYcB1CKyAkyQKQ0QIcEW/qv2JbvlN?=
 =?us-ascii?Q?99u+Yzy6G4/1AOJGyXH6wnCWOIjUo1rymttcNVEPKBPvuAEssX5P1KmPlJMd?=
 =?us-ascii?Q?dXx71ZRxcpa1D4rIsYVnex3rux4AwRZR1gJhe1zr+CV058EW1fRWpgJAj+sA?=
 =?us-ascii?Q?8ANNnFLqbDdzQSOUFMe8BG3NuK1Wr2GRmIYO5NRpk352kiOMfjTsWjpfHKtw?=
 =?us-ascii?Q?tJ/SAGGK6RFRN1trhHfDDtjTOQA3uTQZtfEPyJKt4Hqw+iMHhCSoUY4/4zEl?=
 =?us-ascii?Q?nSV/4meiHOsDf72lgP+CAT0DctN9qKCw4YccAFmHPF2WSVc96J7Xt1/yjMNH?=
 =?us-ascii?Q?K73zSvjAWm/GQXdgXqs/GArDzj+vBEQuUQ5DTyV4vueV9E/oIXEV14Xc++q9?=
 =?us-ascii?Q?2UrikkK0CAF2pKO1ml7F9grmdxhF2vrsCCMbGk4rBvpj47qvCAHGu5aWBCgI?=
 =?us-ascii?Q?rKVJ14XYOXL7Wysh3W676VOiSTnAGwPVEmROFZ5hgzBmI3mGsCWMeekemwio?=
 =?us-ascii?Q?yN1wugpMVGUHYK7sLUKub6pmOF75r9VvRdpeY4u/asIP+owh7YRnxG9IY+IC?=
 =?us-ascii?Q?hWBVhMUgXScGJxA1uHgIGgEaH7pa/lmVnYm+1pRJCOrZ7niyk2Ors8U4L6Ay?=
 =?us-ascii?Q?isdf8rj/G/5vy1qoWYO/qduA8QGsDazF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 05:57:33.9492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5e3960-8509-47bb-d02e-08dcce38cd7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954

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
index 1bb08783b60d..f599b20479f6 100644
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
@@ -178,7 +187,7 @@ cmis_cdb_validate_password(struct ethtool_cmis_cdb *cdb,
 	}
 
 	ethtool_cmis_cdb_compose_args(&args, ETHTOOL_CMIS_CDB_CMD_QUERY_STATUS,
-				      (u8 *)&qs_pl, sizeof(qs_pl), 0,
+				      (u8 *)&qs_pl, sizeof(qs_pl), NULL, 0, 0,
 				      cdb->read_write_len_ext, 1000,
 				      sizeof(*rpl),
 				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
@@ -240,8 +249,9 @@ static int cmis_cdb_module_features_get(struct ethtool_cmis_cdb *cdb,
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


