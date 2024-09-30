Return-Path: <netdev+bounces-130280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836DC989D32
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 10:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E3C1C21264
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 08:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9AF18595B;
	Mon, 30 Sep 2024 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pl4gyuLj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5219D1850B6;
	Mon, 30 Sep 2024 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686040; cv=fail; b=oLMUjwqPtsIS+heJZCyd1FimB+c6lOSsrsHW2aC9r10GDH41XJDhhty0nXhw4f02FIoywZG0mmeikovZHppl0FrJiSDBIhIznBge5m3ie/6PFosD7LxQMCu8RNkaietQjt9UegY58xLQl9jH9FBafoYyKLPxHY1HpKwl0dojqUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686040; c=relaxed/simple;
	bh=HxJJyFY3TdeLBojoQ5xTa2kqxREPyMZAJ7f2XoMncH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2bKKYAslFBekUkPPLeDHHVhWjgtovKmbcDxxKipyMtEGoQsNCQPDigE1a6Ixn5a4ZWmIclbtWIzQqUa3JLHXp0gEjWp6yTnHADPGE4sH3X3ml5SOiIWYgCEKtSHxgBiPys5kpFMi4CvJpnnbnQJkD4lZSN7Sa/t54n9PAJ0+cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pl4gyuLj; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gaysr8ujnrkdWPjGwxWEhxzbgW5yI4wXbDMg3TnIwSFm37pykk8LTmDnvIi3RPUsuoco4E+O+f2H1n0PbJuyqjwRM0VKGXu/d8hoHUPt7uU3CpbKFT/4gRZ8GPGBtQUt2T4/gv5o3BPa/RAJeGMx5+RXSoE96oT1qinUe/5tbrV5UYG/21o8GuXxPPNLQWCr210uJ8a8uWFibljvuIx/irL9OwtA+54TZNtHgI4vvJl+uRHIzhcG7LMZW23mZlMt85Vr4UX8Bqekj4KtL8Xio0rITTHu/i4PhpSRimNBKW+mXwERBtgpYkSCZUl8YDvX8eRX8b5Mn3iM3r8yccfs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDnPNNj0158/2Pu1vfo3VqxcXwJAQI2gbHwONV5HztI=;
 b=gM0BeFbuCYT7WwOBOsYpjv1Hn7RvP0/8Q3Kox9oBlF4QDBwhNZPXAr81gFIlgM5J1pqhceFDAfZe33X8BCTsLbSHCgYScTGXV9TpIHKSgty9Wxs4t/9kiu/GaZaDQ7R9ydXQUD2iCzp92D3XQm8OzBKN7GqvGFLrKE1p+cMYjccKdw9pKk/QbAcp3E2BeF1qyIEhcywsz+TxMVArppQgFQuxhQsfhFaDlO4VRw7vzkIze50nfmE1fC7nvgArBi83/1bmr/pXVcTDzMobYv8eiOMpNTWVKBAMSpnoVk8lq1MWOqucNYa2OkD38dDEWQY4pIMzPJsiNJeeOluCRBNfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDnPNNj0158/2Pu1vfo3VqxcXwJAQI2gbHwONV5HztI=;
 b=pl4gyuLjFvK1miBZJeyh7SNI+Yc2Kcz0YT1u0QX+cJwLLKEPgNaXQHJqUmlND4/mreJPkppe+sUlxIu6flF1TJCstTOAeyngxrMFJZSWZg4ZzCC1+YYcPEg6GLzUJRxQuF532D2M2OJyLQsTEWYV/G+fboeBd+2jJHKCf6r5M4P403zJ96vcyMqkFbUbZJ8MVJ1qj8eE+pvZTH96+GS70z9zm7sonN/8lslXk8WVabQ84KKnVTPpv32PADbW9PZIpmXFdQPxteKt8PJ67pIuZsbwLLVIW1iDRnpQTAQgX0iKl3bIWerGZ2tVXSjvk/juPHtBnbpetgEnHxt8Y0Pmrw==
Received: from BN9PR03CA0534.namprd03.prod.outlook.com (2603:10b6:408:131::29)
 by SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 08:47:13 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::92) by BN9PR03CA0534.outlook.office365.com
 (2603:10b6:408:131::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 08:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 08:47:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 01:46:59 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 30 Sep 2024 01:46:56 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v3 2/2] net: ethtool: Add support for writing firmware blocks using EPL payload
Date: Mon, 30 Sep 2024 11:46:37 +0300
Message-ID: <20240930084637.1338686-3-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|SN7PR12MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a401b6-a12c-4304-9d23-08dce12c7a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7RW1FlgXhzEM9sOjahH9ce+Amtnc/+c+7jWm7pRNCh0JqIOw7+0PgYd+dV+9?=
 =?us-ascii?Q?Q+Ikyb7+n1/6QbtAZqywzm/8U2MacEb7dWLXzcqL9o/inLPNNGnSpKJNIXsG?=
 =?us-ascii?Q?+agkvTl58kcQ9fdc5T0Utbz+/R+TeBvOzxc3MAGgfHY/FHfyry3VdeSh6oyp?=
 =?us-ascii?Q?ki0sMs33ISdFzl9NYPZccF0ynCw1lQKXMIu468mc129+TsCJ56S3CKUKKASn?=
 =?us-ascii?Q?H8kScL7I3U6mypSqN7QNfU8GavhDpwKJGTWM4HU6KSU8pWeKVGlpoXlHz4O5?=
 =?us-ascii?Q?nZnCf6nj0DErCFBkU9nmBrz3mJ7Tt34perlH8F0h5Z2FWVouocRaIWbErkUC?=
 =?us-ascii?Q?SC7tjTwZWEAuFIaTtIv4yNrdEbf4Sy26uCzBoQWOwxR0TrkkI7AMraDOxAKY?=
 =?us-ascii?Q?IwfsqIKABfdqat3VwtZ6X3faY+RKX9FxeRor1ys0H2UPka6g4OmNGGbZWei7?=
 =?us-ascii?Q?M7a5en/IFCcONbY8GBymFV9T+5UhCOJJKd4TwGawINvH4geuHwW8BK+MrOf8?=
 =?us-ascii?Q?uT6fsph12UlHOLtDYJnfp9IBWHFmG4/RAMmVNOoreYTLda9HNwO9Uw5Zhq5R?=
 =?us-ascii?Q?+A3JwFUimB+amEnr480sWNvTz2oST39W37f/CIOnKAy1FFCC15eXlArau34e?=
 =?us-ascii?Q?CSpopnTtaXvt5B/E5E+iPaS+n5qw+qSKbfVqu6wl7Yjey7wxuSDqj/2YIo/5?=
 =?us-ascii?Q?VmwqHrfJMwbY35NGRU+TB+M+d/MP5HXLxdDqJ8ihhUWvYMZ4Y54F4O4xwU3M?=
 =?us-ascii?Q?dSfZfEI/pV8HcaakVCzs/CStBOOz2BebdknNeMtJmfRLHD+5SQZjUjZPy735?=
 =?us-ascii?Q?YBwCpx9juvfW/1D+gUgIMEfjp81uKNl2oqiobHjL7YqAqyZMRmLZzlQDrqf0?=
 =?us-ascii?Q?1NdoqZjA/t3f1x5+uTQhmgJI9gNQPbTgfqKwxN5iQr+3clMAX10un2YJW2pp?=
 =?us-ascii?Q?lpoQ4mWYeeHKwuwIq75P4ZrL6UbboLwky6UHHkuoL5xNDIvcre/PnKDMcNaB?=
 =?us-ascii?Q?XaAMUVY+q+y9iZ1VyJhLmk+pAV0n7ew56BlMMOLWDjhFBlfMoPcgZFWicAxg?=
 =?us-ascii?Q?kvGUUZfHEEVlBPhej09ijrZqW78FN/ozaL/e3tOMaAa7bPz7g7R96w9ANrVk?=
 =?us-ascii?Q?NeoEJgYYmN/b98XdroERDkTvroDnrq8DG4HDlvFfloUqDtxl1osu0QxdRmK2?=
 =?us-ascii?Q?d0qdaeymN+ijdP7YIUmGrb1yqCm3zkXlLGhiC0UeG6RNcKfayL+E7//7tikU?=
 =?us-ascii?Q?BoRLg0Hx8xGmciWun8k4DKZ2TNhoTtPbU0RSsyqujM0LlugAWu3d+iBkLgsY?=
 =?us-ascii?Q?LVTXmaCG6I6T+GwUW3Dyt5dI2SddTUGW0bvzJzaL9nrtpkS+kfM1q/o+9lgW?=
 =?us-ascii?Q?OfHf1UHHJykbjnvP7kCvxzEn3D0e?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 08:47:12.7665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a401b6-a12c-4304-9d23-08dce12c7a7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204

In the CMIS specification for pluggable modules, LPL (Low-Priority Payload)
and EPL (Extended Payload Length) are two types of data payloads used for
managing various functions and features of the module.

EPL payloads are used for more complex and extensive management
functions that require a larger amount of data, so writing firmware
blocks using EPL is much more efficient.

Currently, only LPL payload is supported for writing firmware blocks to
the module.

Add support for writing firmware block using EPL payload, both to
support modules that supports only EPL write mechanism, and to optimize
the flashing process of modules that support LPL and EPL.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/ethtool/cmis.h           |  4 ++
 net/ethtool/cmis_cdb.c       | 66 ++++++++++++++++++++++++--
 net/ethtool/cmis_fw_update.c | 91 ++++++++++++++++++++++++++++++++----
 3 files changed, 148 insertions(+), 13 deletions(-)

diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
index 73a5060d0f4c..1e790413db0e 100644
--- a/net/ethtool/cmis.h
+++ b/net/ethtool/cmis.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
 #define ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH		120
+#define ETHTOOL_CMIS_CDB_EPL_MAX_PL_LENGTH		2048
 #define ETHTOOL_CMIS_CDB_CMD_PAGE			0x9F
 #define ETHTOOL_CMIS_CDB_PAGE_I2C_ADDR			0x50
 
@@ -23,6 +24,7 @@ enum ethtool_cmis_cdb_cmd_id {
 	ETHTOOL_CMIS_CDB_CMD_FW_MANAGMENT_FEATURES	= 0x0041,
 	ETHTOOL_CMIS_CDB_CMD_START_FW_DOWNLOAD		= 0x0101,
 	ETHTOOL_CMIS_CDB_CMD_WRITE_FW_BLOCK_LPL		= 0x0103,
+	ETHTOOL_CMIS_CDB_CMD_WRITE_FW_BLOCK_EPL		= 0x0104,
 	ETHTOOL_CMIS_CDB_CMD_COMPLETE_FW_DOWNLOAD	= 0x0107,
 	ETHTOOL_CMIS_CDB_CMD_RUN_FW_IMAGE		= 0x0109,
 	ETHTOOL_CMIS_CDB_CMD_COMMIT_FW_IMAGE		= 0x010A,
@@ -38,6 +40,7 @@ enum ethtool_cmis_cdb_cmd_id {
  * @resv1: Added to match the CMIS standard request continuity.
  * @resv2: Added to match the CMIS standard request continuity.
  * @payload: Payload for the CDB commands.
+ * @epl: Extended payload for the CDB commands.
  */
 struct ethtool_cmis_cdb_request {
 	__be16 id;
@@ -49,6 +52,7 @@ struct ethtool_cmis_cdb_request {
 		u8 resv2;
 		u8 payload[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH];
 	);
+	u8 *epl;	/* Everything above this field checksummed. */
 };
 
 #define CDB_F_COMPLETION_VALID		BIT(0)
diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
index 80bb475fd52a..9178822223a8 100644
--- a/net/ethtool/cmis_cdb.c
+++ b/net/ethtool/cmis_cdb.c
@@ -33,12 +33,19 @@ void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *args,
 {
 	args->req.id = cpu_to_be16(cmd);
 	args->req.lpl_len = lpl_len;
-	if (lpl)
+	if (lpl) {
 		memcpy(args->req.payload, lpl, args->req.lpl_len);
+		args->read_write_len_ext =
+			ethtool_cmis_get_max_lpl_size(read_write_len_ext);
+	}
+	if (epl) {
+		args->req.epl_len = cpu_to_be16(epl_len);
+		args->req.epl = epl;
+		args->read_write_len_ext =
+			ethtool_cmis_get_max_epl_size(read_write_len_ext);
+	}
 
 	args->max_duration = max_duration;
-	args->read_write_len_ext =
-		ethtool_cmis_get_max_lpl_size(read_write_len_ext);
 	args->msleep_pre_rpl = msleep_pre_rpl;
 	args->rpl_exp_len = rpl_exp_len;
 	args->flags = flags;
@@ -556,6 +563,49 @@ __ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
 	return err;
 }
 
+#define CMIS_CDB_EPL_PAGE_START			0xA0
+#define CMIS_CDB_EPL_PAGE_END			0xAF
+#define CMIS_CDB_EPL_FW_BLOCK_OFFSET_START	128
+#define CMIS_CDB_EPL_FW_BLOCK_OFFSET_END	255
+
+static int
+ethtool_cmis_cdb_execute_epl_cmd(struct net_device *dev,
+				 struct ethtool_cmis_cdb_cmd_args *args,
+				 struct ethtool_module_eeprom *page_data)
+{
+	u16 epl_len = be16_to_cpu(args->req.epl_len);
+	u32 bytes_written;
+	u8 page;
+	int err;
+
+	for (page = CMIS_CDB_EPL_PAGE_START;
+	     page <= CMIS_CDB_EPL_PAGE_END && bytes_written < epl_len; page++) {
+		u16 offset = CMIS_CDB_EPL_FW_BLOCK_OFFSET_START;
+
+		while (offset <= CMIS_CDB_EPL_FW_BLOCK_OFFSET_END &&
+		       bytes_written < epl_len) {
+			u32 bytes_left = epl_len - bytes_written;
+			u16 space_left, bytes_to_write;
+
+			space_left = CMIS_CDB_EPL_FW_BLOCK_OFFSET_END - offset + 1;
+			bytes_to_write = min_t(u16, bytes_left,
+					       min_t(u16, space_left,
+						     args->read_write_len_ext));
+
+			err = __ethtool_cmis_cdb_execute_cmd(dev, page_data,
+							     page, offset,
+							     bytes_to_write,
+							     args->req.epl + bytes_written);
+			if (err < 0)
+				return err;
+
+			offset += bytes_to_write;
+			bytes_written += bytes_to_write;
+		}
+	}
+	return 0;
+}
+
 static u8 cmis_cdb_calc_checksum(const void *data, size_t size)
 {
 	const u8 *bytes = (const u8 *)data;
@@ -577,7 +627,9 @@ int ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
 	int err;
 
 	args->req.chk_code =
-		cmis_cdb_calc_checksum(&args->req, sizeof(args->req));
+		cmis_cdb_calc_checksum(&args->req,
+				       offsetof(struct ethtool_cmis_cdb_request,
+						epl));
 
 	if (args->req.lpl_len > args->read_write_len_ext) {
 		args->err_msg = "LPL length is longer than CDB read write length extension allows";
@@ -599,6 +651,12 @@ int ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
 	if (err < 0)
 		return err;
 
+	if (args->req.epl_len) {
+		err = ethtool_cmis_cdb_execute_epl_cmd(dev, args, &page_data);
+		if (err < 0)
+			return err;
+	}
+
 	offset = CMIS_CDB_CMD_ID_OFFSET +
 		offsetof(struct ethtool_cmis_cdb_request, id);
 	err = __ethtool_cmis_cdb_execute_cmd(dev, &page_data,
diff --git a/net/ethtool/cmis_fw_update.c b/net/ethtool/cmis_fw_update.c
index a514127985d4..48aef6220f00 100644
--- a/net/ethtool/cmis_fw_update.c
+++ b/net/ethtool/cmis_fw_update.c
@@ -9,6 +9,7 @@
 
 struct cmis_fw_update_fw_mng_features {
 	u8	start_cmd_payload_size;
+	u8	write_mechanism;
 	u16	max_duration_start;
 	u16	max_duration_write;
 	u16	max_duration_complete;
@@ -36,7 +37,9 @@ struct cmis_cdb_fw_mng_features_rpl {
 };
 
 enum cmis_cdb_fw_write_mechanism {
+	CMIS_CDB_FW_WRITE_MECHANISM_NONE	= 0x00,
 	CMIS_CDB_FW_WRITE_MECHANISM_LPL		= 0x01,
+	CMIS_CDB_FW_WRITE_MECHANISM_EPL		= 0x10,
 	CMIS_CDB_FW_WRITE_MECHANISM_BOTH	= 0x11,
 };
 
@@ -68,10 +71,9 @@ cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
 	}
 
 	rpl = (struct cmis_cdb_fw_mng_features_rpl *)args.req.payload;
-	if (!(rpl->write_mechanism == CMIS_CDB_FW_WRITE_MECHANISM_LPL ||
-	      rpl->write_mechanism == CMIS_CDB_FW_WRITE_MECHANISM_BOTH)) {
+	if (rpl->write_mechanism == CMIS_CDB_FW_WRITE_MECHANISM_NONE) {
 		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
-					      "Write LPL is not supported",
+					      "CDB write mechanism is not supported",
 					      NULL);
 		return  -EOPNOTSUPP;
 	}
@@ -83,6 +85,10 @@ cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
 	 */
 	cdb->read_write_len_ext = rpl->read_write_len_ext;
 	fw_mng->start_cmd_payload_size = rpl->start_cmd_payload_size;
+	fw_mng->write_mechanism =
+		rpl->write_mechanism == CMIS_CDB_FW_WRITE_MECHANISM_LPL ?
+		CMIS_CDB_FW_WRITE_MECHANISM_LPL :
+		CMIS_CDB_FW_WRITE_MECHANISM_EPL;
 	fw_mng->max_duration_start = be16_to_cpu(rpl->max_duration_start);
 	fw_mng->max_duration_write = be16_to_cpu(rpl->max_duration_write);
 	fw_mng->max_duration_complete = be16_to_cpu(rpl->max_duration_complete);
@@ -149,9 +155,9 @@ struct cmis_cdb_write_fw_block_lpl_pl {
 };
 
 static int
-cmis_fw_update_write_image(struct ethtool_cmis_cdb *cdb,
-			   struct ethtool_cmis_fw_update_params *fw_update,
-			   struct cmis_fw_update_fw_mng_features *fw_mng)
+cmis_fw_update_write_image_lpl(struct ethtool_cmis_cdb *cdb,
+			       struct ethtool_cmis_fw_update_params *fw_update,
+			       struct cmis_fw_update_fw_mng_features *fw_mng)
 {
 	u8 start = fw_mng->start_cmd_payload_size;
 	u32 offset, max_block_size, max_lpl_len;
@@ -202,6 +208,67 @@ cmis_fw_update_write_image(struct ethtool_cmis_cdb *cdb,
 	return 0;
 }
 
+struct cmis_cdb_write_fw_block_epl_pl {
+	u8 fw_block[ETHTOOL_CMIS_CDB_EPL_MAX_PL_LENGTH];
+};
+
+static int
+cmis_fw_update_write_image_epl(struct ethtool_cmis_cdb *cdb,
+			       struct ethtool_cmis_fw_update_params *fw_update,
+			       struct cmis_fw_update_fw_mng_features *fw_mng)
+{
+	u8 start = fw_mng->start_cmd_payload_size;
+	u32 image_size = fw_update->fw->size;
+	u32 offset, lpl_len;
+	int err;
+
+	lpl_len = sizeof_field(struct cmis_cdb_write_fw_block_lpl_pl,
+			       block_address);
+
+	for (offset = start; offset < image_size;
+	     offset += ETHTOOL_CMIS_CDB_EPL_MAX_PL_LENGTH) {
+		struct cmis_cdb_write_fw_block_lpl_pl lpl = {
+			.block_address = cpu_to_be32(offset - start),
+		};
+		struct cmis_cdb_write_fw_block_epl_pl *epl;
+		struct ethtool_cmis_cdb_cmd_args args = {};
+		u32 epl_len;
+
+		ethnl_module_fw_flash_ntf_in_progress(fw_update->dev,
+						      &fw_update->ntf_params,
+						      offset - start,
+						      image_size);
+
+		epl_len = min_t(u32, ETHTOOL_CMIS_CDB_EPL_MAX_PL_LENGTH,
+				image_size - offset);
+		epl = kmalloc_array(epl_len, sizeof(u8), GFP_KERNEL);
+		if (!epl)
+			return -ENOMEM;
+
+		memcpy(epl->fw_block, &fw_update->fw->data[offset], epl_len);
+
+		ethtool_cmis_cdb_compose_args(&args,
+					      ETHTOOL_CMIS_CDB_CMD_WRITE_FW_BLOCK_EPL,
+					      (u8 *)&lpl, lpl_len, (u8 *)epl,
+					      epl_len,
+					      fw_mng->max_duration_write,
+					      cdb->read_write_len_ext, 1, 0,
+					      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+		err = ethtool_cmis_cdb_execute_cmd(fw_update->dev, &args);
+		kfree(epl);
+		if (err < 0) {
+			ethnl_module_fw_flash_ntf_err(fw_update->dev,
+						      &fw_update->ntf_params,
+						      "Write FW block EPL command failed",
+						      args.err_msg);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static int
 cmis_fw_update_complete_download(struct ethtool_cmis_cdb *cdb,
 				 struct net_device *dev,
@@ -238,9 +305,15 @@ cmis_fw_update_download_image(struct ethtool_cmis_cdb *cdb,
 	if (err < 0)
 		return err;
 
-	err = cmis_fw_update_write_image(cdb, fw_update, fw_mng);
-	if (err < 0)
-		return err;
+	if (fw_mng->write_mechanism == CMIS_CDB_FW_WRITE_MECHANISM_LPL) {
+		err = cmis_fw_update_write_image_lpl(cdb, fw_update, fw_mng);
+		if (err < 0)
+			return err;
+	} else {
+		err = cmis_fw_update_write_image_epl(cdb, fw_update, fw_mng);
+		if (err < 0)
+			return err;
+	}
 
 	err = cmis_fw_update_complete_download(cdb, fw_update->dev, fw_mng,
 					       &fw_update->ntf_params);
-- 
2.45.0


