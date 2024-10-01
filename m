Return-Path: <netdev+bounces-130863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF3C98BC65
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6444A286A27
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C271A1C245E;
	Tue,  1 Oct 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n8IBveKq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A6E1BF7E0;
	Tue,  1 Oct 2024 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786560; cv=fail; b=eqna7Wsg9lzfNo1XmzxhgRt1sQW9+7H3LGEeWMBs0UyVUD6RGt6bNOsUxrZi3fAwN7MOftE4zmCnJ2f7qivFxyohkBxqAXew41FCJ+j38MIH8LBUg+0wwPVZXL68xY4u6pmZ6dtQr9QsBpeHxRWXd2mApl41vWgDeBC8fdnduAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786560; c=relaxed/simple;
	bh=8D6KDI/gnZ4A9PvkQRUIGZqyIWb+IJYK3JJIgFjUuVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkD22Hg6pZNdm5shVALpHpGHfuX6R4X//wo+blfkMYrlv6Juvx4aINUT8dbS+WVX0pDbzh0uli6kcAxGIKEiX/4MyQcGbr8zv+CaX1rn2OLSUXXseKAV79Wq3gGq3pojFLjtbXh2pcXJjm/Sp/uMmTh+VZI74ZMfc4g2WTlFlt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n8IBveKq; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6oGKBpCYOB/a8yWyZTyh7EQ2191pKtt8Fmrd9Dy2XRNy1knvJf9wk7K/QRZeTm+fBmjSfteNm3djWesBONIvsgpZne5o4xQOmhaKv3BiLj1UxU6PnAlhs9EsE3M7sDeOyGTCUFCQdy0Gc5eGmlo9502qV6GLU2khwXEt9mxNfO7XAX9qSG7PIVBVaPRi4js+Ok2+Zo8doJc+ESKUD+2jAoar/WCYbIIUO+hQ2utHGHZ8FwkMB4oDu2KGE8t8k1z+1jDo35Eys3RKUf7sBUg9CAA9HWZpRaIXocHgo4li/JA1B83ljUhHGaHZldEkhhcxp/UXyiZkYMcjhYRuKHJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jZ1k7TEYX4WyrzYlhQ7KYBtLoRfQ5PsfRu8LeL8S2w=;
 b=TGEj4kTYkD/E5nzTM/D34knVHmEEXKNIJo7sAvV19kGYZ5NwE/31cxZlkD4gE19OtgNXXdU+C48SjT0JQFkFoS7ZMGufC4QqOubwrBEJF35rLOCNRT4M4zF2TrT34ITiFuSbtpoIc7E8yczkHAhkICbFZkXlDqupyl/drJGP2CjvExKey4agU/m/WB2IQcuAuZt5vis8FOGZuC5e3mFLl76S+dDIRx80PgMr1eLACwU2Bb0rrWvW5VhTLIlOWHFWTY30+mralsk7aXeZtMJOg/4BEBlVjhYKDPUQmp+T8Jvy5rHKKSiyr1hjlbd2W5Ap5mizT/ToTwn7dEa33XUL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jZ1k7TEYX4WyrzYlhQ7KYBtLoRfQ5PsfRu8LeL8S2w=;
 b=n8IBveKqahVCjibzGeFUQnMbts7ywBi4pZiL5SgwrfLwvNoNdJiNZ7izKUJSIthlyuQclQ0RRNC6lO+79nSNIWNLWIXXjYt7A45P8W5y2vb6KIdgCRzzcUp+4YBOqR57/dqnvSxwBnZLVn/t/x4kHCOOK2l0/Rec/ZBhe6QQFQrHw7D4lleFBWzgn5rq8KzFsy4imu0qLI+nJK8AobE67u25enuIEt86Y/XegBK/v4tukDrJ7gCtEcUEV+VgsfOBaCaedxEIQwjq9iMSLK6tG4+EI0wNKKo6VEe/+rtfmKZsHTTZ9gBwKu4Mh+IOYnMKXVyZw822vkkzkWbPoNNSfA==
Received: from BYAPR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:74::16)
 by LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 12:42:35 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:74:cafe::70) by BYAPR05CA0039.outlook.office365.com
 (2603:10b6:a03:74::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 12:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 12:42:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 05:42:15 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 05:42:12 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v4 2/2] net: ethtool: Add support for writing firmware blocks using EPL payload
Date: Tue, 1 Oct 2024 15:41:50 +0300
Message-ID: <20241001124150.1637835-3-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|LV8PR12MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: 82047fd7-6e3a-4e85-fec2-08dce2168630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u9qMbmV4znYC5PygSeHBi9OuCtYGhzxcyRAEQNOOVb4ZsFcuiDaNrH0BZn+3?=
 =?us-ascii?Q?IdKy2WaIJ4ZXHkQXBPvhLXAhuv90BjruKxBJ93rFfpyASEGSw4H22RB0llRn?=
 =?us-ascii?Q?GVy88tIOl6KdR/0B8YIs31uoPpX0PVa+iZNbN7R1hrMLmfivjGE4voyTOL4v?=
 =?us-ascii?Q?Br8CG0GW1xHDZdqv2HuyYOfSHIKNYNyWrXCFEBdtt3pPM8pO2KL4/bCv4keH?=
 =?us-ascii?Q?f9jQwCfUMWlpqVHkVHiLwP/x3LUkQEUGP7vV6azliFrD/LWRhTppR9gzKI8I?=
 =?us-ascii?Q?LNbozzfYs86oVRN55L5YFVoj0VW8XNsrQLgEZgkYmiDuDGRnStLX+ZM3Cq8z?=
 =?us-ascii?Q?7b/u1c6nWjqeyTTHzDUiig4A5pVkzDBIL720LGAnTeSEt07TGb5/qV7FLL9I?=
 =?us-ascii?Q?lz97E+P1hm3mzh0zBz8yGQZIg0yn1mHOjSxz22uyb9gyNLlGbjk0HIwUg8mh?=
 =?us-ascii?Q?lIj4zhgYjJUjiua9HsRbxmBDPPhFCDDVERRZmxdIyNWyhEpwa6E7R6/fLn/9?=
 =?us-ascii?Q?5H34O4c8Q70k2NDaUGJavNDRIP+4pBtHwT9NihVlqGTVi1MvqeaYtGxdf+Yv?=
 =?us-ascii?Q?8WZ22ARGaxyzMWOs13amb7tKFivXF/hDLzwmZnPh7c1zCgNkIm8eCh/Pe0Ua?=
 =?us-ascii?Q?nZWOHORehf3yt4afc23m6Enp2szAvhhgEqUNM37Qu2TDjIePekzlfcRCrHRT?=
 =?us-ascii?Q?3DrwQXX5ivzH6d2BxF+wMUKKPzm0geZ1gi0/H9t98PuSbvkI2LQaWHF6SBjt?=
 =?us-ascii?Q?EJfy7EQyvAYU1akYy1xlifr2CimZuqIuMQ91AlEGzF1x6ZrY4tuFGaFhascK?=
 =?us-ascii?Q?0MAsw8/gbwPVC3NDVErz5pwrciL4U7AetSGUykX0bbxjjsxc9DPBtnwApybQ?=
 =?us-ascii?Q?QUsD6joDPnuX0cITOqfuEGHUrQ/yu73RT2OQmIVnPXy7yvWkSQQ6NDU7KXfV?=
 =?us-ascii?Q?MD+OgycHPnrlcR9iYH8d07mpaFTjoPi/UeFp6Urq78LeB3wCa4QEwfBHNFgR?=
 =?us-ascii?Q?ibDpSn7J9NdxOkbBX+ZDIj3lX9ifCmvIAMGkXCrqBOfAbDZFOUxjoPt+V2J5?=
 =?us-ascii?Q?sl/CDVcLpyd/x7aaSG0nhOPn77xdBs0zVFJqQfDwB0vUtXofTR17jUmmq686?=
 =?us-ascii?Q?T9cEKE/RflkTqg+hpywXcf5GmyH0KJIRukgg6PW+IGhtQakgYk+g7qMz3otx?=
 =?us-ascii?Q?08tgd5MeMAmUrxbg7YQAdCvE5Zwy1RIdaRGTWOSftEcB2VfcjuXKDyKkTQdZ?=
 =?us-ascii?Q?bGMFFpb234d6OD9LEmehm+XrzTZ8gwEaY1NT3zy7YKLyT24OIFjl2si9S4n8?=
 =?us-ascii?Q?pgfVxR5jh5dyQmJJVaL/KxYF8pFTV8qsH/E2yMtGKxRPpj01K1oPJ+u7fKY8?=
 =?us-ascii?Q?WAGJbuVoogJ8l1U5xSj8t2GXQL9j?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:42:34.6096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82047fd7-6e3a-4e85-fec2-08dce2168630
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336

In the CMIS specification for pluggable modules, LPL (Local Payload) and
EPL (Extended Payload) are two types of data payloads used for managing
various functions and features of the module.

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
index 80bb475fd52a..d159dc121bde 100644
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
+	u32 bytes_written = 0;
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


