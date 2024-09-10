Return-Path: <netdev+bounces-126893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F963972CD1
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9417A1C242F6
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E254318CC14;
	Tue, 10 Sep 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r8wu+RZE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94018C913;
	Tue, 10 Sep 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958973; cv=fail; b=X9WGBsI5fVYOd9iSX/Kf/ZMBi3dWqBPlKmmL+uKcCNX72p/MqD9iGTrWqZ7hH1fMLLV/CdRT3B0v+dIHm9a1nCQPHlhTtLMVzKGdbzmM+Rtyi1fr/uuBjqV4o6YgrsfTLaK5du871BQf0P+JHQQSU+GAFn5YhsZRBYzUWPTHL5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958973; c=relaxed/simple;
	bh=Uv2qks99AUkse1lVbF5tn83T4kHTm2W1dSr2piuZLF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmfmaFw7HDJ4bd1ecr9NyI1SURuiyeNCXydTqCXsF1dNekoaaQBPjFIW/pnwU9vy/2Tkttxk0ynVhJZCKrN6ZlUQh+QTWnvhpZFiDyXd/9gMod3mM4yy4SCAKhdLi7emZr1ZwgSPDCf3TXACDFXEFXVdK1eMiDAOU4qb4famWpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r8wu+RZE; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/aDJESIHQzgreECU2lBd1TtLDj8Kj8mjFn+lvlPwbZBt/FNgmFL0ujBPJYP6XJApdo/oq8mLUBtTQJ7BBeA+wC+MBp/j37fW5M8/h1YOKQmIsFXnnFHAlkYS3Z1CPTeRwltVYOgRmAOAxFfEAic+60qt2TunPa0apjQJPyrpsXAoakcLXsBwCtBIpg/fQnQUJmmmFMvJsi6Co4pLpu1LaUrYQ5TpKeU4kkWlrJJzezrvyd8R4hMsT5qcyV+8OgvRgHulkTxxgy3NZbulj7yUxdEQ2vWjU827zFrzcK92QeB0gw9ReYqu20iNZ4Iy+7tz8CJAuEm6MA120EZuRPtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsCD/FxEnuC462ZBzIp0lMJW/RzDfnmsdvcpJo5deHU=;
 b=BFxssRGtHj3tvOxabrUgQDyme7+3A8pJ9YtRMstgrsv8Vigt1GvBp3x6XxMkKOoC/6Bx7j4Z1YAcPYDIdSbtdlg83AIu3olfB8fYNQPuJCD6jw7P1mvfmEEaJGZHn3LcPSRqThEj9S2VxZjROT3UfjRuGli+8Oc09z5f2Yh6txkEU549ztH5mzsi79uFYFpPOQuE1yWbPrxi1YQR+HDRfx1J+B1WAuNtafOTw6wkbA19R08UNZDtBSwls3XJ40ZiKmeeX+yE3ST235elvoZi1pe0n6YaW8HgQaQzhTe6xL7jt6ajVZcCrJOzdof9pdB167sAK7y//cMp8DkwYOaKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsCD/FxEnuC462ZBzIp0lMJW/RzDfnmsdvcpJo5deHU=;
 b=r8wu+RZE2nJ0rT/IX8CqkXrhTXG+pp2lqSLvii8LHkkXgwdQeJcbGcLgdemVCumDz3IuvDZTFjF47pVPgCw18gEUS554MBPpV4y3vMT7n3TuneV4D4MCZcM4TeG33pD4hUdhw8uIhMdZjlGzBrCsAAK8s4556NUP2NQQ/59vmJ0aOxYyDlto6Unsge4iTXhIBnsfjrhHbG595hyymy8trrKHZlX0ZXtqVaec5OHL1ErdFYVuagSlT5p1Wz77nAPBEtjdFy/we5PKyq7OcRCAVbgSwh+XHo8q97KX3aLv5QAxu/tFj3/FUw3TVmFR6V78Rs8gvZz2XFOEAeYOkCZ5Tg==
Received: from CH2PR20CA0029.namprd20.prod.outlook.com (2603:10b6:610:58::39)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 09:02:47 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::e6) by CH2PR20CA0029.outlook.office365.com
 (2603:10b6:610:58::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 09:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 09:02:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Sep
 2024 02:02:37 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 10 Sep 2024 02:02:34 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
	<petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v2 2/2] net: ethtool: Add support for writing firmware blocks using EPL payload
Date: Tue, 10 Sep 2024 12:02:17 +0300
Message-ID: <20240910090217.3044324-3-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b1b843-e534-4ee5-27ae-08dcd1775703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2nCjd+ioTcA+YvjxAooSijr6Sa+hhexXp3Qo9o8RgnQI0wlDDU4ASfPS6eTO?=
 =?us-ascii?Q?F7qq6MToyd3Jw5C9HXRujxmJhMVB8AEHxT2tCf/1H2jFUo6AynHymWX/WCqJ?=
 =?us-ascii?Q?DyBUdV7pFxwBimeViBGKQnRWo9mcEKFy8k1VHGQMZhW5nnRtQZzNp+9FzkeM?=
 =?us-ascii?Q?+/ZPEnyLWPGS+xcW3EVhvgwMoUQ9fdTR2qo/ExK87LiLuw6zpm6VBMAo1+nT?=
 =?us-ascii?Q?7M2Kmsd35ggeWClExQk3RwiXUTh0DRdekY7bMxTQILEf+czg4aIZnEqf3+HJ?=
 =?us-ascii?Q?AQDtd2OXzXOZeHoEMXgT5tM6eqdQhSLEGFmkvCeh/vXwaw3pf1KQgkclIS7m?=
 =?us-ascii?Q?TMeoMkSFcghFloIp18Z0ja6v55p2/woVL49Lyq5SBZd5dUqtpi9o4wtiOqA+?=
 =?us-ascii?Q?7qR6LKAU3iwYm/SZSTmGo+ua7dt+d53Fqg7A6TxY5gUz14yzWP5sIwlK5mKB?=
 =?us-ascii?Q?wNHIuuVHpNqjpqZeZ2NlLEzlDDLSXT/2GHzK5kxEwehwG6mHAou3+9GsRlCN?=
 =?us-ascii?Q?c94aVS8EgDbC0tOPFzA+aACHJdIMASXSsiQdNF7Y3ih2wiimyw0j/5aw+ezZ?=
 =?us-ascii?Q?bXrDg0xu6/Bde5yeoT/cZ5mzT80hkhExfc0cwLqEd/th55bJuXrMvdJ/5bVb?=
 =?us-ascii?Q?VT0xOAFNMG2N8YDivZIopvetGiziSYDRVqkRCAewFBzof+nFt7lcIkpZbPxm?=
 =?us-ascii?Q?uay2UgR6mZkzF4lwo43NbTxHduN+3KSrDeyj1w7aZO3OAfymFogP46Uu4FS9?=
 =?us-ascii?Q?v5GuJgy0jpU2BbSc9/IfVIeNfGAXvL/wEx9Ous0fQqPBSlK78Psb5peYPhHu?=
 =?us-ascii?Q?M2fSFKlR1nfS1tBWYnSG0ZkWa/VMs/FGJ+jD6tGGKPxsOZdFLmnaF3Wtddt3?=
 =?us-ascii?Q?V/xx9MDXVxxTXW05VW9RVWgpGM3yRltpVwrp9L3c64ddVBZ0ee3frylTLsFr?=
 =?us-ascii?Q?zCTbwetcI8sTZOtbwsZVGimcgDW+otNolo5fvQV9fTY+6Id9KnXNEKzfx06O?=
 =?us-ascii?Q?yDEE/u/qzKPBdBQIyBORYdbN87KXSM9RC0Yg8QAI52qODAWBbDVVkh8sOH81?=
 =?us-ascii?Q?Oy8u0kzGxbp9EBXIX+8goKTmveTiqxgkZ/V5SAts440UFqZt++rlpnsd1AOZ?=
 =?us-ascii?Q?+4y1HcDzlowPqUoN9h0Kez5ZV6NvnXtAbZYjRmXiDjoKNaUFGwFiKL6VwnQs?=
 =?us-ascii?Q?/YLaQNqAd+/koFTerZHdwUWkrYJeYhM60jwbPw8Y5F0art/f8MAYUP5v2sm4?=
 =?us-ascii?Q?f6MlfNsgad34I1kTJfIoMNbwwoqx3ghUUfvUrspmINJuu1LA0xKSCIhole3I?=
 =?us-ascii?Q?MvIFn/cF/0fFq+w8hHoThndPcj0SI+N22OyicSwFaBOTRQkVh744SksSc4nJ?=
 =?us-ascii?Q?Zl+n3aVftqjkhZbcC8xA61np0hy8EJbp1cb7/hEoR6yjdpqCZAchJjANv/cE?=
 =?us-ascii?Q?jH13JPJXt9Vtn6IxqCUV1RLEEil3/Wof?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:02:46.9186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b1b843-e534-4ee5-27ae-08dcd1775703
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771

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
---

Notes:
    v2:
    	* Initialize the variable 'bytes_written' before the first
    	  iteration.

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
index f599b20479f6..e27cad17505e 100644
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


