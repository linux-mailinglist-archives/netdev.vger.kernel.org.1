Return-Path: <netdev+bounces-133616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516949967C1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD55A1F21906
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FAC18FDAF;
	Wed,  9 Oct 2024 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O+hsDMou"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27304189F20;
	Wed,  9 Oct 2024 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471269; cv=fail; b=sd8Zh+kRDLyj4aUAHtpR7L//voJueLaKB5dUbkl9pNbH+9gsze2xG9Cye+8Deqlp+IlQjEc+jaWg/ALCcFHbDWQlyPC8UDuzhoBqKgej0JwD0OZ59pLJXtnt+qOUDR2oGFqsO/e/p6ET0a3sNhP0EaFqxU0w7/EYZ6Qb9JH/h8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471269; c=relaxed/simple;
	bh=6QZR5MqtLaYYkd/0TflD7bsJ2K2011ih6cNPq0AixqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnJkZ1NdMv2wyvRUDM/xlxTyQNFdelYpBDzkdSOCGUk+4/DR4tmI3zHUPyKbXcHT16r6hy5p/lZayGZD25Z4QD6dz0NNFE8UhztiQUAQWRyX3muBAOAgo+c/XUKGPAmFHCVJi0M2fQ/IRrW7kq1XJz16UOcAYWLQEXlUENvMdP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O+hsDMou; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDhS1eJuo/D7fcVll6sWmCp0Jd6FM9z1OnbSC2KFeFHFJVBo5th62lrH2zmOPORPtT3B2jwQzoF8HwZ5VyJ4R2PMrhdmFdNPPGjB9eVAh+cmuf+i8jArocBT5/cHJhMiDnB98n40PCzsdMET1rSnmKbO03P6sXcel62nvnyMton+01wA1ea5Uf+PWaFqIXu0Q4GNlA3jNWZ0cEV/2rA0AH5TcfDAJkL9HqHL0QhndzKf62ZiYfFg4LeCpFYFH5mRDtC4MahUhQs8vrYjqHL4m8iIjgwrjeRg4JQP43DOfJGCiAoW+o7XpbZvnAATQQPxfhoPm0ZXy5oqHeZTpWHsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPHMiR2KdTzqjbgRMxGY1OJYkRW/hjnNjNZBuGr67/k=;
 b=w5wPoq3I9AGcNjKjrZoo4VcqouYPKxGpagem6eGmCRa1xNpiJeo7TInpF2/WdZHjlPgkNz03d3Bol8Yzecyx9OS/xpyfwEyAERRm0f1wv7+e7c2mKcE83JM7zHHSVmJVguhyiLw1S8yJrniSqq3NjDaciQjeWfn0yslU5lAyDd6nBhKZsHcHgGqNONBFQJrGGiXk8aKPZ1Jpc8qT/RtuzHJvjyEoxVuHhQH1wAuWtWVts+W7huzFIsmSiwZCEe4sn4jd0iz0RkEsBF6CkuU9O38alTF6dizhkRjzu6QHvTgpPba9AWEE8rDX8SuAH+eF5LyBVskeAikXO+NgZlk5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPHMiR2KdTzqjbgRMxGY1OJYkRW/hjnNjNZBuGr67/k=;
 b=O+hsDMouTiH3fKirW01R0P8/SCH3qjwuk5/r4z0QDfwMNQJp0aV1dgRom0j9icRHXH6vL/pT41dFjX0hAboSktnb8FWCRmMcWU/fLwo2ZF/Vngc99r9VVU/FSGU0Sh34MGMC18oMvSoo5Kz1RR3V1ad8ofGfJAPRHGygc3yGGXckkTLuafQhaR3XajXra6i1/iWPZfpuy1RbjWV9Bw+jv0hp2b5GWSW7StEfNLv+HP87W2RzD3OazEMk9z5OfM5zt087pl1uyn88qPj4CKQv4DMcKfWpIEp9n47gIJbG8BanXicEUVVml1d1s+yWbpWTL/vxIFvVAyKZvj+HNHR+Ww==
Received: from BN8PR07CA0033.namprd07.prod.outlook.com (2603:10b6:408:ac::46)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 10:54:20 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:408:ac:cafe::39) by BN8PR07CA0033.outlook.office365.com
 (2603:10b6:408:ac::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Wed, 9 Oct 2024 10:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 10:54:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 03:54:05 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 03:54:02 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v5 1/2] net: ethtool: Add new parameters and a function to support EPL
Date: Wed, 9 Oct 2024 13:53:46 +0300
Message-ID: <20241009105347.2863905-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241009105347.2863905-1-danieller@nvidia.com>
References: <20241009105347.2863905-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eecc391-60e1-46b9-30c6-08dce850b9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FA2g/NLm4Y5SBnXdHj2O3cS7Dy+Ky2EOh3r+WDD9m5g6pYw5FXkhoCBeYaMm?=
 =?us-ascii?Q?iKM+M1ORghF6nbdWqZmzrB9OLZQIE+o5ughFqeOMv6Fxzjiu6eLsKRr5he+3?=
 =?us-ascii?Q?iwtLQ2hfg2jcSKVb3j2UWp4YiKHjAfP2iUZSGdLow2DfWEPQtfRzWkLXZEPj?=
 =?us-ascii?Q?TZLBqn8YFU1Omr7f3/GM6KAQZWInQlSs763TXEEBGCGIOEYGRXIQFjmPzl/Q?=
 =?us-ascii?Q?2SrMGx6qP53Srpmc6ANrRx4cQjSzXmrGwg7qWXsTTgM2wrY7VYAagSPWLdHz?=
 =?us-ascii?Q?wLuRzk3r5scs50SK/iV8KgnnMTXOnj9BTFpWQqWVl+6puWPkiuBykPki1NZS?=
 =?us-ascii?Q?hqUXjSGZQoTK4OM9XSaJNwpFpLoWRdPVzvlX7NxqZVfDPwa5VZVc9q1lGrCi?=
 =?us-ascii?Q?AAfmqWdPDlVSn90sZm7uZjGfGDGPfdS2J2DZuUly6J3A2QCt/fagSfH0QPjm?=
 =?us-ascii?Q?SyWs7yOVGPlD1nycsfkTfuJE47NemBC4rXNECIhIxyHiqSmcc1iJmBOxpMqE?=
 =?us-ascii?Q?570JJ5fIHiy4GOE5HCB5OTaJRI77y3P59365cKoLIM5vICkSWOeoWvK0bw8m?=
 =?us-ascii?Q?qvmzQZZ1EVnrFJ5vrnJTNgnaf/gc2q2imu676+Nho3VLoGs61Kt/S7k/L7fN?=
 =?us-ascii?Q?uOx5KHZKu473GPWdlxsWZ0hDzbTVuaVwoSiB+x/Yp7oM85MHL2sR3aAskdLd?=
 =?us-ascii?Q?VBmHIyTEScW5kjFiAFBtaXoNWTa+oWBudoj0UL5/vGIQOcUS7nQt53U3LKXE?=
 =?us-ascii?Q?41D9wEnP/Z0YIiebcfhYm7jnxEmlRzCQy+EmvKYGV8/mwWIEN3PKpLzxY5jR?=
 =?us-ascii?Q?+4A1PBTAlm6PR8ia+ty5PTtYZnLLrgAGHZ2AyLwKMzelvsvFO3cr15Hl3Ewi?=
 =?us-ascii?Q?Yk8XNMChB7bGjsrxwQ5MvgFbet/Ip+NAmueHXCcKDkUEmsUeql2iCMb4CTvP?=
 =?us-ascii?Q?c7UfTn+T/mYlYnNDZ1kU+aSOOa2Mi97Yay18TtVpGqZuM8Aox6+dH/GJ5g91?=
 =?us-ascii?Q?ERKbkxGhLtjbZvvWm8OWJMQv610O6XCo7AsJSbdO4uDGdALY8p6T7KGSd6+X?=
 =?us-ascii?Q?K+oyCOpA5+7aC+f4QxrNATsgzr95tmEynY3KQyl9+k21YcpSMcta1R7uBQmO?=
 =?us-ascii?Q?k42XvgnvvoORJhmNv9XcoKK2G08PuRH2+84j3ycaE6LLDleJ+wuofIw6u8bV?=
 =?us-ascii?Q?vv96DEkBBbg7gWrCKO/Sv7Uwjh8zYq0JZCMyFxviMckj+1GgMZPsDhZ7ga+C?=
 =?us-ascii?Q?z+eL6zTvOajRxtdhSQ0mvdleNdd6/hLfliWz+faRKmELI3KdWqWoxYfaV7p9?=
 =?us-ascii?Q?c0BOi2D9I3eIlgJfy39o1lKuAKw+EG+fL/FlL9OKVN+W0r+U/iEdcI2pdUxc?=
 =?us-ascii?Q?+gA/bm4KmcR4Aghz8qPCv0D+SeAX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:54:19.2814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eecc391-60e1-46b9-30c6-08dce850b9f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306

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


