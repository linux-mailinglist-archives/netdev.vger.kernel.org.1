Return-Path: <netdev+bounces-126892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E01A972CCF
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF12C283E6C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11240189B9D;
	Tue, 10 Sep 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DSSv5CFW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B7188CD8;
	Tue, 10 Sep 2024 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958971; cv=fail; b=iVDEDLwIeUeGUhSWH7oK5UiSHLRio+jXkzdlIfFVMAlqiQuzB1S6MypyO8Q/Qm+LU76gjsJ+BZ8wCGWJVXF1MJbInRmzn+AGJFSUtnZd/d2S5ASPwZaT9r563Qwetx/4KHnLQs3nUnvVTA15LNHMtBAJ3+qBcFENk+xDygLWQyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958971; c=relaxed/simple;
	bh=ma2TQEeQ4gtlCA0J5Xm9CWOcGvQSfiruS/PvUhh1ig0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glc5JMA6IcdyxvyUiw03U19CjA3KxT+FdpTZklUwFI8JBfsIjdIKfx1LvbEbDnpwrXcAn44mT/UUusGQ9YoPACPiRh9wHDdkZmXCc8G/5/3dGfq087yViGeRIO3mzjCEvyBcxUpX3keBCJgIq5HIjPRSJsFwTVLF4NqYE3jbr2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DSSv5CFW; arc=fail smtp.client-ip=40.107.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwtWYxTpQRhmIA8mcUZ4CMxIp+V0IPX2opEKg5lI6OD+yRnEY1jT2WnUOyuFyZUbZhjDIQSL7nALJNQgSGzvDBikZV+KHy/tqURhycV7O4XQujb52dCjpRYlG6iwcioTKcZV8FC3+EaqZMg5zaZJogexLIDp+yOUIby+lQPMa0HhplUysqXz5s5rTtAII0jAEzCUU/K8lV5vI4RkIKK7LN30f58lJE0Uhhv/xIBZjMmEsEAiYE3L96UMNMP2lufO9mMotmhVHmgLl1/rKtJ9BxrL13gQkVRal/hIk3f+e6raJ/RT/bgq1YIX8VsLO7gQU5h/6HnKGKWwX0JQ9DatEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdX8LXVx2IubkFyVgkQbCjRjt9R+g9V0yM03hoKEq0w=;
 b=b3vrI4L0ak2lrg6x80SNaO8m/0kRLAPhBpE/VjEFGCmapEEXbyGIjMIE5mdz+JuWMuBAD1X3KaHvYoAo/Oqvq8HDV8jyfnHcb0QjW8xkYm9WE2erM8RLUbQ/9R5m8oQykutsQQawBvCJC0dAwPwqZ5eMEAB8QAP6pAwjv3ZHqkB08+gAlr6cX5YAz1nnZyv9GMi94ETEzwVyI92YSdrAC+ZlEAqYRj17xemcl3e5Kv29fvYCv6cuUI048xNw9q0gPPH1JhArhIeUxZqGs/1q8IWA5Y2Udc0CrIG0oGqdBQJFbE9CuRJETlxV7N8y41zj4BHXFBl+oxVBOhKfadtQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdX8LXVx2IubkFyVgkQbCjRjt9R+g9V0yM03hoKEq0w=;
 b=DSSv5CFW6zjbUxK6bLH9/9ZCKer3I4rMOOJAvL/GVDQ3fSTAKohemHWUXchy7/jbqvCKWoYwZRi5lGlp+VAWwE3qzDJqiUu9JsUvC6DDguljzHLlkfsrJ96jv5n/eX8OjyreXBS88UhJWIVmGSWidDat5Ze4zaxZIDPMjps/sJJgrRa8Vz/LMAkPfEpNN0ccmK93/wic2idw1Ti10Iuqq2Zi8sF9//aOYrAaddBcdNy0ask7zfK13UYHd7gcuo3DKuZ+2ja/yp2CyCd1HfMEPzQVD9038R8iLQOW/8AjwJpSkhNCFtK0xoUsbnsXFtc5H/3Qms/tlwhuMO43Y0An8Q==
Received: from CH5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:1f1::8)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 09:02:44 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::b7) by CH5PR03CA0022.outlook.office365.com
 (2603:10b6:610:1f1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 09:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 09:02:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Sep
 2024 02:02:34 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 10 Sep 2024 02:02:32 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
	<petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v2 1/2] net: ethtool: Add new parameters and a function to support EPL
Date: Tue, 10 Sep 2024 12:02:16 +0300
Message-ID: <20240910090217.3044324-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240910090217.3044324-1-danieller@nvidia.com>
References: <20240910090217.3044324-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 7665567a-f378-465a-722e-08dcd177551f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?prMPKXNNYDFcoxNHEFmOG2UarB3tW6tv97RKku40DBLFXHyEwbUlKv7OoeYQ?=
 =?us-ascii?Q?Ex8BsZ2bdy1YcLXegzCLpe3BEfDtNzx7hkzhkAMcnMnV/uBFsrPcJG0QLJ1w?=
 =?us-ascii?Q?zxq0yBXKSwrwOjlkLRItlk9rJSveuwoixB7c4uUbMqZxgmh9tr42HRmKDbAw?=
 =?us-ascii?Q?mBW3pus+Iv+TfZC2TTrVH7CAn3diqNrhJK8Ry0BMlYenB2ms2JfgKzjcojg6?=
 =?us-ascii?Q?6l7u7LkSu7GlXY2MRDZ17M4u19YNLr4E8TWiRqgNhBN7GBYxmZrfPBRlZjkm?=
 =?us-ascii?Q?4f1EIXQNAhQGERsBRfH/AsjzPFlvm3QEjdQ9cpMKObi7QOYy9jO8LrCOHLFW?=
 =?us-ascii?Q?KD/xWlSfgkt+aZC4tssCuoeiHh8U55+V0H1kYFiTqQq+a6r01yOa2SvuQHSz?=
 =?us-ascii?Q?R5kBrWaNWTAjos16WyTv0WpLcMmT8ASFCDRJnrbSnJbGhlkyV4S4n4Eey3NY?=
 =?us-ascii?Q?aFOnJ7saZXhUH5rUCgWhkK/1SI04Z8EKSsWn6I8gnqR8AprWUHAqHMsfN3og?=
 =?us-ascii?Q?5yrroBsgksAeYOjOrsQ2zlECEHBtr/NRBUirq7oqJe6su/JQe5w5rIa6s2n/?=
 =?us-ascii?Q?93xrthHS1i3oR5vLUHtkeSfzDLci56/wJ/Z8NzahZqgYP2oBtu3UHFAK+nwC?=
 =?us-ascii?Q?eoVdOD3raEqN7agXXCeq2YAhi8c0iCW1gwpdiliHR01oAc/LUGXbB9DqZUKK?=
 =?us-ascii?Q?RpXTJnjrNSRH4BgHaQpcK0aMO4X34uRdqfGJWw4uRWNvnjB8oT/hEHcior6r?=
 =?us-ascii?Q?xtjwoEQGHhMQ5VBznZA65iBuNWuMxld9QWJOE2wfKTRiBU8z5nRd/CyJw272?=
 =?us-ascii?Q?POTXIXE1cXFTMwnICfFbiiy2iM7uy61lK0nxJe1Ww7dRsdOhMKwda5H1xEVk?=
 =?us-ascii?Q?oKBxL4Bxtj73/oZ/yobHeLWDPdcAiBwRmm0hrnvDAHaUXs3o9Vmwjok4AD5x?=
 =?us-ascii?Q?yyNW17QdKkwtMCmvdwdBsKKszNGjdZR2OD9XIowd/P9PUXqzd8P//vF8WKmR?=
 =?us-ascii?Q?MIvgj3y0kxSGBupjFQEZlLy81TROwPKIT5FR39MOLy8baIFGJI6aTcqgF2FE?=
 =?us-ascii?Q?CTZvE8RxiDKX74uXCkqKBMBpv9tn+4mHS0sptuTrOY+vWA0pwfm56x2Sv7Vm?=
 =?us-ascii?Q?Pb99McFk4jSz+1U5VjdFjIOCHsdKMyyuY/sT6YvqKwsy2Oywi2LBXBUh+Coh?=
 =?us-ascii?Q?hdKnkI90L0mdriHxinv8n1MzFsw/f9fjf6S/AGZfEmn7IjbR84lbnIT0BYJZ?=
 =?us-ascii?Q?dCW/4WwDIzsFzwvGSHW6OPQgQzu+UBBGSdcifPViM9/XoMclpRnuziuCcnLQ?=
 =?us-ascii?Q?mWU1Cvrn1euGnGzMZKUyfkWR/OWemQfgAZqB1GAOOiPBJoOdM5TrKt+UH6uk?=
 =?us-ascii?Q?qwdv5jhuC1sCcFEi8Vby5g9RifN3jUCMtzaBi/+VJ1WQjZOnjfecswENFStt?=
 =?us-ascii?Q?BqvnFPiUgP6YeOELe1zRrqoIlYihZwQm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:02:43.7642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7665567a-f378-465a-722e-08dcd177551f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102

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


