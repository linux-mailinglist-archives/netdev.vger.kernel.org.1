Return-Path: <netdev+bounces-125792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0699796E99B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235C31C2338C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 05:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C56C13DDD3;
	Fri,  6 Sep 2024 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="prHhIorN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C769413D8B4;
	Fri,  6 Sep 2024 05:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725602266; cv=fail; b=DLiEBUzvhxKSwPO5V4ncp80SG+p9CRGxZxkiCJFNZLH5nGx7xTJ3uSiQQrpMITDLah4IwxcbD6MOyg0OuprtdOTinGJbL7GmRdyZvUFEyyejkgTCBKKbWPq34WzMUMi1qIIDdj9YBF8CE2Qe2b3uExlK9qFp55xDeQtrio8aGSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725602266; c=relaxed/simple;
	bh=8EGNphpZacWWXCeZUcDh851mS8GUEgRgs5Q7PkRA/Po=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhlm6H8buBpQYWTdhtdIa7w8frY9AaqWwelzgInpHZ+DRDygomykYtlYTZbjeQJhRvZjt2ipCaepqudFwzCPK1WsLpyp42UI83O/4rO86aNs05oEf0LIPOMcyo6GPIAioK7QhfaN1oQcdhr2A45f4CmLBDxyyYl/o2IOBPBTOMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=prHhIorN; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNTKawQJr67rRMR2fuFbsxVnqZcO3QNzrXQ3UEOix0fnXbrzIroO5s3O+nTzPIBvliob55n4qN7XE8JOuE4H5upCYbqwqHaLPpeAsPEA3JiLte31TznkQwm0nKj4ezBfVvEA4cfhTIyXF/Am6IOQ+567fMQA82dU6Q6wMTmAWrq0x/WBybZq7bTBFatr2B11oJ0b/TqCvpRH0IToUWpskzpu3BjF10306/SaMC1ASFxXxZGz26uKrhPEpN4euTTV0VahUm9g5DdrxqddiSegZgDdkGQoVMQgeJRZDdtRfjs4xg0/FXw58n3QwrCXVbJM4JbqaE24iZoabrKaosmBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTxNXA0L6ky+0l316YNHpDs5Tjw5eUFnqlDwIv7fDg8=;
 b=gLpIgKYjQVLK82A2Xmrg8GZzJ1ICnrsp/oCp3Z57+l9R1fAtSSJTBeSBZVHEI06drwNQnvKXU3F6gU+I42CILrrGECp1Q/gEKBkfkJfqdm3EwIksTRMwS5bTZc5Wmkk6Lsco/aT+Fmy4bhg8RvPLamhMWX5kewiJoW4BFQKIATnuFcRTq8WSKhGad693fFiKspttY7IJzRJMenLR/BfgjJdQtb6PwVwtoIeCqpqL8MmSuJ0kGfDIhx4NEUaYxTSs6uQFULE1LRUS3tQpRaxjycRLr9cYq372d8xQa7rsdVS0KM+9YzHTDZd4lnsmM5Ph+9LwzGAYy8kATXtMDE3oBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTxNXA0L6ky+0l316YNHpDs5Tjw5eUFnqlDwIv7fDg8=;
 b=prHhIorNMaXKo9lQqudnMadrMn24rud/+O6EZmldPjwDY93FmvyZIJsImEjTrviwOIG9kVfdqgJmrh/vbFOAjkfM8zRRHPmkDZF14EIrZzCRYki9pkBMsX+0mT/VTjaShY3gzx0v+9ra8krVMWC9Ls6iSB+oV3V2N39BVu6CixEfyerfNxMKRSz9HVtfBMm5BDXDz8s49KnAj8q2MT0PsWIhiXFxtINYqrPM+ZZu1lzcjNO1jcPbXFwBLAOrVjuAI1VJg89UjiFEkxqEpwiDfCyvRUWllFK7vGuDVPQqbMpQMcKAXkiZ174xOrPd5DEp0UANs0TOit4aDuA//6joqA==
Received: from BYAPR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:c0::38)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 05:57:39 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::29) by BYAPR05CA0025.outlook.office365.com
 (2603:10b6:a03:c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 05:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 05:57:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 22:57:25 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Sep 2024 22:57:23 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
	<petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next 2/2] net: ethtool: Add support for writing firmware blocks using EPL payload
Date: Fri, 6 Sep 2024 08:57:00 +0300
Message-ID: <20240906055700.2645281-3-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: da287661-c7b7-4a47-3d92-08dcce38cfd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZG+Vc0GWGBt2eedB2xt33lSlQBHDmjA9ufBZzoV4cvrtLs4r6Nk2WaHEUH+Z?=
 =?us-ascii?Q?kYQ6FRom9hMKIo/KKL+xomGPL3tG902hMoUKnSJ06i+O1d1ix0qz7DpzFcQl?=
 =?us-ascii?Q?I6fuPQT7A/qZud48Xa3fgJlMqNeC93epD7LjGx8MrwgpbrP+zHE3WKP3Ggj6?=
 =?us-ascii?Q?6mqSE5mvHpqwdBYzJSVJdhLm5wVV7MoG/RBPTRNWwdDmxVs6LADvrq5bwChV?=
 =?us-ascii?Q?5S/uoFiHNMXseZdF5l6b/zsFIZWL3EKqNe+lcD1ybk0m8IVlNihhbS+KmTOJ?=
 =?us-ascii?Q?wCYuAdOCePQ0BRqIRDwD9JqH4fMPEA7KnFpMFBPU72KarlxGtmHuMuXC2JmX?=
 =?us-ascii?Q?fPwdCicbQVDddgpuVkY2bTTg9Delr0W5/pNb+tXwn7+zC1MmJgrCP8q324VO?=
 =?us-ascii?Q?RVvrkS7/9tPuxQZn+B9ZHxF4gjkqu3tTHrsa8PyDKxg6eJRE3xkWW5OcKul9?=
 =?us-ascii?Q?WZA2/b8Awfb0x4FVT2bBHdG4TbZqEyYvHIeH5yjN7lzxFJb2VkgVPfS6aHSs?=
 =?us-ascii?Q?M38yDe9LXjSq483A0EiNiNEfC41rfpVdsBpl23jYKz1SEd7XEJhgAwBtLHyq?=
 =?us-ascii?Q?HFQ6FRKMAgI5g8xnx/BOTsVMpuArW49ndfUAniUHCHTER25WJ8zMPiXqYk3N?=
 =?us-ascii?Q?4TNfFClr/Nvennx7nQ+EA8RjwwhkO3ZEO5PsIjz3dtw+V1ceG6tjaOJAUew5?=
 =?us-ascii?Q?xApMMICFLTCMgl7NMbyTW3B8xpXaKupq3lk0bNVBpIKTXEjwkQK/SOxapMIj?=
 =?us-ascii?Q?OLwfilr/iLIQa4QWjtCwtzTXtvJVcGzWbY4hsk/fC/bjJ8YtAY3VRM8uBQWc?=
 =?us-ascii?Q?ebCixf0IZUUYvvw+bjbprYB877KOaTzMu5bml0CPqSoEQyCrll4a+pMvwm8a?=
 =?us-ascii?Q?vbcQ3oUPFy+G/3d4xdRIK16SxEZ1Di+fiEBZ1AlpkEVlNXoUrPDEQyoYEt3S?=
 =?us-ascii?Q?SERwqgvQhJKhStIayoin/+hXXpvBeXgGYi3ektEA+KvVKPwVvKmYjF0vIFbJ?=
 =?us-ascii?Q?WMbGr+RZyrBI7jhHOdcw4w7c51wMr45f5dEg6vAXqlSMHmvP9dIjIOjYeeqp?=
 =?us-ascii?Q?SLXESlSraR4i1vvGMbfwudd0IEN3oqF9HTYnpgh0MKaGZEpj2TVfrxU/JAaV?=
 =?us-ascii?Q?etUueEVEAHC34DML9Hx1J+y1VitZ7eurDx9FhOD6bjHtwLA7WFX3ePBZ61kH?=
 =?us-ascii?Q?1peCM2/3+vYgZ2eKHOfF10zAIh7tibHAeJpN3ZxE2gZvcLELU33Ka++nUy7Z?=
 =?us-ascii?Q?tQajDVI22uMGBWKbry6hPfvHHYh+FATk407b3RlBRpy74OAoHeT2pJKeM0QZ?=
 =?us-ascii?Q?wu0Qe+8LvwkAkq0L/UYGZPZzfGjQTByKC9vvgp8FOK60mu+9b+c7Wv2/di+c?=
 =?us-ascii?Q?H0dPVVKVaM1JRHnvD2VYPvjGN6nVO0hRzOgWh8AwK84SfbxlXVurpL47mkEm?=
 =?us-ascii?Q?vSZv/dKVVCgsRI/r1fu3b3z6GkcAIQEm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 05:57:38.0066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da287661-c7b7-4a47-3d92-08dcce38cfd9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082

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
index f599b20479f6..86d93f6c68c2 100644
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
@@ -548,6 +555,49 @@ __ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
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
@@ -569,7 +619,9 @@ int ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
 	int err;
 
 	args->req.chk_code =
-		cmis_cdb_calc_checksum(&args->req, sizeof(args->req));
+		cmis_cdb_calc_checksum(&args->req,
+				       offsetof(struct ethtool_cmis_cdb_request,
+						epl));
 
 	if (args->req.lpl_len > args->read_write_len_ext) {
 		args->err_msg = "LPL length is longer than CDB read write length extension allows";
@@ -591,6 +643,12 @@ int ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
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


