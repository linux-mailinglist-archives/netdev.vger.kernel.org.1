Return-Path: <netdev+bounces-133617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 710C19967C4
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F2A1F2230F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CDD191F68;
	Wed,  9 Oct 2024 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VWih3RUo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22811917FB;
	Wed,  9 Oct 2024 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471273; cv=fail; b=HHGL0saEa/x+wZXDWogSEN+ssVSpZvWNJXUdQnPBZN+TPfWVc1H5WQOGrt0JaZE7kR3GubY1N5DoTvyH51LlNt1h1LaNgDh48ksEQHocxGr2mVKZ0R2XH0Xv3iAjJZqfVvhVGPcSMUmpOyTS/3Mq5uNvnbylxjXVqfahJ/y9zsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471273; c=relaxed/simple;
	bh=8D6KDI/gnZ4A9PvkQRUIGZqyIWb+IJYK3JJIgFjUuVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ala1xjpn8b1CsXTxjsXIohZ0Kf7SHufyck1SD9oLc5gtk6pbc7zckk4CzRfFWhbqTQixxCIczHKP2MM3sBqNTmQBgsDDMlcX7cX/N/R0PpZof8OWr0rWqZf62pmtoBB1lf5LeClaIZ/uPJFo6sfKW9cE9q+CSimzVfbIbpOoROQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VWih3RUo; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMPjnv/pQl5fDHGdebrbX70iE2NKkTFTuSUhmQxKxu46NVfyJWxhGhi8gTF925PdCSHwZOD/vtpJMK6VTu4MyWxPhssg/vt6Nc9dUjExfb1GrrCdamOLca+yuTD4UvgIhwBu8ZRFJPVnqYgt06M8HYL5/qlxqGNfPK8ipmjqubV0HWnmzQDeou8s1HXnpBx4e866qy5u/aW7Wh6CSTFN95wZEdII7RU5l79QH/TtI2JDpFNKmyaLSE4YGkYRcmmEidby1pswuOIifUXqfSbIpEw01XcMZcFAL+qHyLifLGDPa2GFlK+PliKXkTMMi8Ek4zbeJLgQfjE2QQT6SL/6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jZ1k7TEYX4WyrzYlhQ7KYBtLoRfQ5PsfRu8LeL8S2w=;
 b=JTEXdCKkE2U9MmWwd+shEASZYtx47sKeGq4dbwFi1iyd3y6k+rVAJmOhMoZbxMLrii23/UcIArB9L1LbbYf1SfCin8qKmytInZxb+IA50IbSKVocRi/EcFifGmaSQZrCR0rdHyzgrEsZAiqmtz2AR80kpuI2YYWYwB4d4AFH3fRubS3qUkirm/OU9ND8V5fgJQF16i9+VDx+RCVlFkZCLg8LQvzC4BcU2nHRRiJGPrvsPVLux17ekL4q9bQBNMGTOL2ltifK9kmOZMbRqAbgju00egiuNgCLTwD4K3BChkaKkbq0tVfUHqYNkWRh/sYBrchHwfO7xRCFq+f1eu1llA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jZ1k7TEYX4WyrzYlhQ7KYBtLoRfQ5PsfRu8LeL8S2w=;
 b=VWih3RUo+xd3tVVaggDgKAx8plQ2d1/XodEtjbLMSvgTF8o4M+VXyfa6DGssS1z9gxMP4eD+rls8q1RePFykhfdvfoEsdG18MbGMkieLMSgqct54FsvIWDIxFh21nbZEa6wKv5a8BTaJ8H62oYckLGCDoW+ORlsjgF+KYYxuijlmZwYYNLsSyoxTEiJGxmKfkolpLAVN3KiMbzypuY6eoPkKGt555D7vfuSAgJ97FA10k0Y1TgWvTQRaE21Dw5gFbMZfbnUWAAzwl20k4vfSkE2kRp85F1WLdirpdKc35Cb3jCQUakfVeI8eyJ9zI2XJZemUqpWmhTvClYp/oFbFBg==
Received: from MN2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:208:1a0::17)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 10:54:26 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::58) by MN2PR07CA0007.outlook.office365.com
 (2603:10b6:208:1a0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 10:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 10:54:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 03:54:09 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 03:54:06 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v5 2/2] net: ethtool: Add support for writing firmware blocks using EPL payload
Date: Wed, 9 Oct 2024 13:53:47 +0300
Message-ID: <20241009105347.2863905-3-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CY8PR12MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd9ed6e-ccd9-435c-5a6e-08dce850bda8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UhYSb8ydYJ60grpCqZJa1F5zbgHcExsMFwbdMYRSqN9YV5ms9/OBJsKpp0T4?=
 =?us-ascii?Q?MP8/8XdL4gn+Yt121e8wTlCEcrQ5tLFoZid9dDNxdkQRGXmp56oDJ4sn5Gxu?=
 =?us-ascii?Q?s8IrdRMQrOV9cDm8tDX1RkDy4PolbJuBEsW1S0D1/xNodyU4ZDOq0qcZHrkY?=
 =?us-ascii?Q?jZsLL28TnM6NR6aWAUDZjpodOusCmXsK17fjeT6CoBCNnI0SyTOqTn15NhrK?=
 =?us-ascii?Q?UhqXJeJ/KSKMuLtsxLQuUs7sU9Coxv5JyRY36+cfDQLbtkYkRUme/7zWBZVH?=
 =?us-ascii?Q?4qYpgPnp2K5EprpCBLDPvsjv9PX88uWhmZH6wTAviD+3p+XyRN/MPpgQlvzH?=
 =?us-ascii?Q?jzRdSZAPOn8kCGfubJlI2cAcw25WlfQRb02sAs859MwBhcX26ItTyOQZPllT?=
 =?us-ascii?Q?ujuoXdJtiAVojTUrnWDFBo/9MEqmCtnThL4n/E3cinwMK6z/ZBC//kkiizcW?=
 =?us-ascii?Q?zalUce70Xp1cwLBqytT90eB9v/yxOX0oobxiRRkE2KlJn1i1HgqQwRfUG82D?=
 =?us-ascii?Q?D3ieFeIcPrJPdODbWVQC+Y6c31wt6XPZfZXOqSK4PicbCD5KPxKWeZerGfM8?=
 =?us-ascii?Q?0KLIvI81pzIv/ldl8EPDNEgLfQFOFD6NsaHfXxXNrpky0LzCrgcpRMFQku30?=
 =?us-ascii?Q?yk8eToSt1iUPSkYbSfdc8TDiCEFExs9+3xp3J4OM8HsYdVmG6yzGhlN003PQ?=
 =?us-ascii?Q?MNnFCz/tqDX+LEa8Ca9agc22rsU/ar7UHG7ANsqz5MpMCHfxqsNXH4hZqEPI?=
 =?us-ascii?Q?rxS1p6665N8E25N8tStEv8Awg8NC7+NPs0p2cRW2/VeH68oJFztJR0ZbsYbm?=
 =?us-ascii?Q?QiatfVR/BXdKtA9imBoG1i7GV4h8D8sK0GzNLBlQvWOgVpJOciC+DHGZNCrV?=
 =?us-ascii?Q?Q+aGO/bhqDQTD5ibhj1N0gCZ16Us9qi2drxOn5waxTpJcMsIwao1agp4PVAl?=
 =?us-ascii?Q?GztuG8qwuDonW8FwRaQZ3Ihsqid2SBFmjoECa5/Asl2VvstXuaPjvEkOWWpS?=
 =?us-ascii?Q?9NBMjYcVAnAm+vwCkhPMpSojJ+w+HvrlfGWA1md6CDusv9Afcp+trv6kUzf/?=
 =?us-ascii?Q?MidKxTORp2cCcowuSWmgy8nkAt0bH3yBp3fC75VlpwTb3IxG2ynPSPVMj1oi?=
 =?us-ascii?Q?Zc/KJhwDUMWXNU6q9EIKp2IC/tFI+yiMqvI2QfYLmyvTWz7MVX3DW32EV1Yj?=
 =?us-ascii?Q?8krEyUmHB/Rvv5HO6AxyzdZPWCr2G+9LVgdRhE7aa8Xp37fFKnQIC4UHMsM4?=
 =?us-ascii?Q?FebtJF0uokhbJLWTiVPmAMic6FHI7PNkOlDhn3BYI++KxJRAbicnEYtanKG3?=
 =?us-ascii?Q?jb+fLHMTOQ5xFGwWmN+6iipildSrb0Oulx25pB4Nzk4P9TbdBteVfIgzdtCw?=
 =?us-ascii?Q?cuD7MzRrMOq+COFZgqkT39pBuiVd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:54:25.4847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd9ed6e-ccd9-435c-5a6e-08dce850bda8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215

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


