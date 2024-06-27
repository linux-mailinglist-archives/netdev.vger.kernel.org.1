Return-Path: <netdev+bounces-107321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 014D591A8D0
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCF42852BC
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6181991A1;
	Thu, 27 Jun 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EkRkwwuK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F851991A5;
	Thu, 27 Jun 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497431; cv=fail; b=MVLpPu7/WLalgqa5rWcbOjgn9bnKgBmc3XMH1BLfvt0rFr8EgyUj1a1AhSENOmNdxgKwRlHu7c2y1+afPB076p3IiPtu58/OqYGm8kspvr0PrUnOVaRuMVNlHYoOdZZWHbbKfaEQQeHxPU2mUdpUA4uwPbPqoPHQYah6tvaVVJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497431; c=relaxed/simple;
	bh=RqZrtF9hzPPydnCat2CKUJoLjAR3aJkQL8WArZqek3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdbARYmyIyoz3TohFfvv33ihIAx9r3AkdBPyUIPHv9UJz2oymF4/a5m8qGhFbKaO9hoWTREv5ZHNU6nqbC+eZ0MCgERMe1dEHYyIFsrLtHekaWa5RCHWZkp2irz0iMBIlXy0IMx3itMBVKn1OR+odaHoSnUnAW3hLQXO9Cilglc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EkRkwwuK; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dd5KyC+Xs+ENuYxhGBMiqFWguWfVwtAutGPO2Bthy9lB1Po4rGghGa8wKROrxTe2tCeCDrFL+DDDCgEOqT64XStzdHfpA/CoExcX7RgyJPfC2R4od90tuo+iAFZz7aVdepaVamWxkGjjNezRvlN2UONjYZpNTMV6w09OgQHdaHaEq/8CnazFMHfRj5MS64N2nHusp7GfsHraYklbD+9biimqEDUraXx8oe2ohYtTvi6DPxICD0GiAV2BjGgxnuWo3CN8uN1UkQz3yIxljBnpc6O9ewW3abzLFnHF86uDbM1bovoTP6HJKc+B3dR9wviWbN5OIBHnVhNVjp6NKue2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4khK5DkuVZdWTbZsjigRzdxqODND9aPqXhMDUBlsPI=;
 b=YW9nd2lwrpOENLR5rwJEiEN3RaOZCCPAADRCpj3anuKbOitM7w1rkEyapk/9jdpH2e+x4TbcyqJkMRx0kAQJpW0swIQ/EFaWiHH5uhQmthiIiyosIJLWczgLU5YKuZPOp3bJL8LcHSLckPpu/11T9uGJ+GULsijy0kMfIatIK9JQSGBlNLyoDXC2XPjnuT3Ai7Y5lGAuCToWpxf2pRHU6aKa6ZxVsmGP5vLeXEIVLgh1UNZVtnvtU7uLMJIvzb5SwwSswVTDkoYGofFdWXdiwsvf7ptGaWvBgfvmKmFpiZR/Z/gmuhm9mfAqOfNdpYOCMEBFrg9OaAibRflmaG4ZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4khK5DkuVZdWTbZsjigRzdxqODND9aPqXhMDUBlsPI=;
 b=EkRkwwuKug0JbKf0dWHxLAzzOCON6joDy0EMlVgBdqF19FfbNfK6ZzGlAGvqhiK754V7jkdtB40+onCk9qO/vzLsjaHo0ZqhdgYZ11uZ99rtgtgEb05wFS1P+DIRwVcJx4vGMfMoHfrxrS0d7Zn0qSLW21a3WfVQptky2os9YRFliyb1nPdfahI+w8iAjYLyNQFBx9QcJ808LpRandfRxz7YhRXhVVThwUDa/2PjbH0qjy2hiSjG9SBUyhRvGeSSRkeZymEzoYWyR2C9u1jW+HeUCPF68MiiJf9AyAw/ev4KeTSwG3SlYbQxXlS9nUeCEuZlJqKn7EXt3Nv3n3Yq3g==
Received: from SN7PR04CA0151.namprd04.prod.outlook.com (2603:10b6:806:125::6)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 14:10:25 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::70) by SN7PR04CA0151.outlook.office365.com
 (2603:10b6:806:125::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.24 via Frontend
 Transport; Thu, 27 Jun 2024 14:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:10:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:10:08 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 07:10:03 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
	<sdf@google.com>, <kory.maincent@bootlin.com>,
	<maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
	<przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
	<richardcochran@gmail.com>, <shayagr@amazon.com>, <paul.greenwalt@intel.com>,
	<jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mlxsw@nvidia.com>, <idosch@nvidia.com>,
	<petrm@nvidia.com>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v8 8/9] ethtool: cmis_fw_update: add a layer for supporting firmware update using CDB
Date: Thu, 27 Jun 2024 17:08:55 +0300
Message-ID: <20240627140857.1398100-9-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240627140857.1398100-1-danieller@nvidia.com>
References: <20240627140857.1398100-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 2844cf55-c2c6-4e66-b8ff-08dc96b2e3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oh9b1AUqbkhF7nklnOgOPYwJOxARf11Jq4Z1hrd6l4qIX4v7IVV/UJr5F/lq?=
 =?us-ascii?Q?E8P6wNoKgdoCG4Wdaceeci0tqxAX6T6QHsyeV17MbWZZiYh0/A8pjnsDtutO?=
 =?us-ascii?Q?6M6lvGqlsaVmtUmLhUIEtIOTjRDKWw0p48Jlon6sGTeOMCq3TeQFsOlT8vA8?=
 =?us-ascii?Q?+HJPuOp3uIkpbNvnPXJfMWxwiQ7vw75jT3LkYwb9xggUc9Rhcbm4VBAuPumu?=
 =?us-ascii?Q?Nyp4Bc0THxSoc8cSokAZ/dDEdQi6r9kFpgscK4BbGPnGCETvBW6SLN7xPL4P?=
 =?us-ascii?Q?tLiYSVjHeHLe3nlbRoowu6zvmMs0yDtvxp8i0SplYtKbiLTxijnNMIwa9mmD?=
 =?us-ascii?Q?k4tISMmEn69O1rQRG4h2twqzkPVQxndK5tp0olktKnaP1WsYrefSoD3CoMom?=
 =?us-ascii?Q?akTUFBd5B9TtNgxBf8BjehY+fvbZy5+8uTkTiziWRdBqnkNHMeRcXUfplxwz?=
 =?us-ascii?Q?a0hiv9Om9SF8wD8QXvxtnjS80CA8ycYLvRk1rUsCuK88EtEB23tfwE+6pStj?=
 =?us-ascii?Q?yIRSsi96CdrAY2oUzOkYqP0OOiNWP1FdSSvT+R9zuZp5Z38M9Uih50ow02Zj?=
 =?us-ascii?Q?VJi6MxofzY2bJ1rU8ZSgCUwujWMDOtf2K1sY3YjKHs1Si2o1NL2LDZyGSa7l?=
 =?us-ascii?Q?SBB8/8uz5bW92iUeEOWRa8TmRzkhcDPbhWGQZ1ZgaiQKD0/B78XChpzaaZ7T?=
 =?us-ascii?Q?uqZCRh5kWPSuFtXskkGfkQ09GY+wNsCpI8OESgPSUefThAo9XD0vx/NcuStG?=
 =?us-ascii?Q?FnKhtxKqnucAZPxBYhcBFqxGSEeo4DY5WqgromIRijg+co9lrxKCnhBWBxM1?=
 =?us-ascii?Q?iYxGZk+RA+24zjCZ7VHmIjIHJfleDkzVBJFDpFS7u+zb36w4vl+4T3Eha99P?=
 =?us-ascii?Q?PWXsNZLhL9DtWshbOWLRHuJUhCxs+KACvoyF1i40+SdhZgoOvgauYFeCh2F4?=
 =?us-ascii?Q?3kXgAvGXbFxNxPg89Kf9CuplzvURDNS1oOddha8dxPLDV1M+dQ/EuQ96Hlwf?=
 =?us-ascii?Q?2ocqCHeE+9S5Xhp+nD4SBBYccx9tOaLB6PLWtuKEHZDuItVFGs718LjMbBas?=
 =?us-ascii?Q?1NESog9mHIvOJjYfu7QgWYE4EAGYGN0VJhKjUO4hPqQrnduI4BHz/8k1GN/i?=
 =?us-ascii?Q?/tt1Aw+rEvt/rhP3pXtix4g7sE4WkfTXvc84HfmRbUcwPfq7jjzdFdrcXvTr?=
 =?us-ascii?Q?9pZLtz1FP/3jjiEipeVlXNs/Yv61PlxoDgYGdzSOerAAZTggDoqlllC7/3mC?=
 =?us-ascii?Q?ezb7IS28o7RrxyqbYPbnoQ0TLI0nI9qtYvyprqUTiaAmdBvvMX/DdTe11hIh?=
 =?us-ascii?Q?ITQZ1AK3M5OyRm9Nz18CCBxJPY147+L4T/k+f4NfLGsEUL9vK/TEjwrGr5Ku?=
 =?us-ascii?Q?7HqKpcW9qUTVtLg4Pzie7WXbH42GY26yC3zeWsv/b5z1ZOEp4Okv5uS0yI4c?=
 =?us-ascii?Q?nVJn/W3hE+KzvIxTuvN9L7WG12gK+LJb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:10:25.1828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2844cf55-c2c6-4e66-b8ff-08dc96b2e3fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434

According to the CMIS standard, the firmware update process is done using
a CDB commands sequence.

Implement a work that will be triggered from the module layer in the
next patch the will initiate and execute all the CDB commands in order, to
eventually complete the firmware update process.

This flashing process includes, writing the firmware image, running the new
firmware image and committing it after testing, so that it will run upon
reset.

This work will also notify user space about the progress of the firmware
update process.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v6:
    	* Add a list field to struct ethtool_module_fw_flash for
    	  module_fw_flash_work_list that will be presented in the next
    	  patch.
    	* Move ethtool_cmis_fw_update() cleaning to a new function that
    	  will be represented in the next patch.
    	* Move some of the fields in struct ethtool_module_fw_flash to a
    	  separate struct, so ethtool_cmis_fw_update() will get only the
    	  relevant parameters for it.
    	* Edit the relevant functions to get the relevant params for them.
    	* s/CMIS_MODULE_READY_MAX_DURATION_USEC/CMIS_MODULE_READY_MAX_DURATION_MSEC.
    
    v2:
    	* Decrease msleep before querying completion flag in Write FW
    	  Image command.
    	* Change the condition for failing when LPL is not supported.
    	* Re-write cmis_fw_update_write_image().

 net/ethtool/Makefile         |   2 +-
 net/ethtool/cmis.h           |   7 +
 net/ethtool/cmis_fw_update.c | 399 +++++++++++++++++++++++++++++++++++
 net/ethtool/module_fw.h      |  31 +++
 4 files changed, 438 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/cmis_fw_update.c

diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 38806b3ecf83..9a190635fe95 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -8,4 +8,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   linkstate.o debug.o wol.o features.o privflags.o rings.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
-		   module.o cmis_cdb.o pse-pd.o plca.o mm.o
+		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o mm.o
diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
index 295f5d0df915..e71cc3e1b7eb 100644
--- a/net/ethtool/cmis.h
+++ b/net/ethtool/cmis.h
@@ -20,6 +20,12 @@ struct ethtool_cmis_cdb {
 enum ethtool_cmis_cdb_cmd_id {
 	ETHTOOL_CMIS_CDB_CMD_QUERY_STATUS		= 0x0000,
 	ETHTOOL_CMIS_CDB_CMD_MODULE_FEATURES		= 0x0040,
+	ETHTOOL_CMIS_CDB_CMD_FW_MANAGMENT_FEATURES	= 0x0041,
+	ETHTOOL_CMIS_CDB_CMD_START_FW_DOWNLOAD		= 0x0101,
+	ETHTOOL_CMIS_CDB_CMD_WRITE_FW_BLOCK_LPL		= 0x0103,
+	ETHTOOL_CMIS_CDB_CMD_COMPLETE_FW_DOWNLOAD	= 0x0107,
+	ETHTOOL_CMIS_CDB_CMD_RUN_FW_IMAGE		= 0x0109,
+	ETHTOOL_CMIS_CDB_CMD_COMMIT_FW_IMAGE		= 0x010A,
 };
 
 /**
@@ -47,6 +53,7 @@ struct ethtool_cmis_cdb_request {
 
 #define CDB_F_COMPLETION_VALID		BIT(0)
 #define CDB_F_STATUS_VALID		BIT(1)
+#define CDB_F_MODULE_STATE_VALID	BIT(2)
 
 /**
  * struct ethtool_cmis_cdb_cmd_args - CDB commands execution arguments
diff --git a/net/ethtool/cmis_fw_update.c b/net/ethtool/cmis_fw_update.c
new file mode 100644
index 000000000000..ae4b4b28a601
--- /dev/null
+++ b/net/ethtool/cmis_fw_update.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/ethtool.h>
+#include <linux/firmware.h>
+
+#include "common.h"
+#include "module_fw.h"
+#include "cmis.h"
+
+struct cmis_fw_update_fw_mng_features {
+	u8	start_cmd_payload_size;
+	u16	max_duration_start;
+	u16	max_duration_write;
+	u16	max_duration_complete;
+};
+
+/* See section 9.4.2 "CMD 0041h: Firmware Management Features" in CMIS standard
+ * revision 5.2.
+ * struct cmis_cdb_fw_mng_features_rpl is a structured layout of the flat
+ * array, ethtool_cmis_cdb_rpl::payload.
+ */
+struct cmis_cdb_fw_mng_features_rpl {
+	u8	resv1;
+	u8	resv2;
+	u8	start_cmd_payload_size;
+	u8	resv3;
+	u8	read_write_len_ext;
+	u8	write_mechanism;
+	u8	resv4;
+	u8	resv5;
+	__be16	max_duration_start;
+	__be16	resv6;
+	__be16	max_duration_write;
+	__be16	max_duration_complete;
+	__be16	resv7;
+};
+
+#define CMIS_CDB_FW_WRITE_MECHANISM_LPL	0x01
+
+static int
+cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
+				   struct net_device *dev,
+				   struct cmis_fw_update_fw_mng_features *fw_mng,
+				   struct ethnl_module_fw_flash_ntf_params *ntf_params)
+{
+	struct ethtool_cmis_cdb_cmd_args args = {};
+	struct cmis_cdb_fw_mng_features_rpl *rpl;
+	u8 flags = CDB_F_STATUS_VALID;
+	int err;
+
+	ethtool_cmis_cdb_check_completion_flag(cdb->cmis_rev, &flags);
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_FW_MANAGMENT_FEATURES,
+				      NULL, 0, cdb->max_completion_time,
+				      cdb->read_write_len_ext, 1000,
+				      sizeof(*rpl), flags);
+
+	err = ethtool_cmis_cdb_execute_cmd(dev, &args);
+	if (err < 0) {
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "FW Management Features command failed",
+					      args.err_msg);
+		return err;
+	}
+
+	rpl = (struct cmis_cdb_fw_mng_features_rpl *)args.req.payload;
+	if (!(rpl->write_mechanism == CMIS_CDB_FW_WRITE_MECHANISM_LPL)) {
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "Write LPL is not supported",
+					      NULL);
+		return  -EOPNOTSUPP;
+	}
+
+	/* Above, we used read_write_len_ext that we got from CDB
+	 * advertisement. Update it with the value that we got from module
+	 * features query, which is specific for Firmware Management Commands
+	 * (IDs 0100h-01FFh).
+	 */
+	cdb->read_write_len_ext = rpl->read_write_len_ext;
+	fw_mng->start_cmd_payload_size = rpl->start_cmd_payload_size;
+	fw_mng->max_duration_start = be16_to_cpu(rpl->max_duration_start);
+	fw_mng->max_duration_write = be16_to_cpu(rpl->max_duration_write);
+	fw_mng->max_duration_complete = be16_to_cpu(rpl->max_duration_complete);
+
+	return 0;
+}
+
+/* See section 9.7.2 "CMD 0101h: Start Firmware Download" in CMIS standard
+ * revision 5.2.
+ * struct cmis_cdb_start_fw_download_pl is a structured layout of the
+ * flat array, ethtool_cmis_cdb_request::payload.
+ */
+struct cmis_cdb_start_fw_download_pl {
+	__struct_group(cmis_cdb_start_fw_download_pl_h, head, /* no attrs */,
+			__be32	image_size;
+			__be32	resv1;
+	);
+	u8 vendor_data[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH -
+		sizeof(struct cmis_cdb_start_fw_download_pl_h)];
+};
+
+static int
+cmis_fw_update_start_download(struct ethtool_cmis_cdb *cdb,
+			      struct ethtool_cmis_fw_update_params *fw_update,
+			      struct cmis_fw_update_fw_mng_features *fw_mng)
+{
+	u8 vendor_data_size = fw_mng->start_cmd_payload_size;
+	struct cmis_cdb_start_fw_download_pl pl = {};
+	struct ethtool_cmis_cdb_cmd_args args = {};
+	u8 lpl_len;
+	int err;
+
+	pl.image_size = cpu_to_be32(fw_update->fw->size);
+	memcpy(pl.vendor_data, fw_update->fw->data, vendor_data_size);
+
+	lpl_len = offsetof(struct cmis_cdb_start_fw_download_pl,
+			   vendor_data[vendor_data_size]);
+
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_START_FW_DOWNLOAD,
+				      (u8 *)&pl, lpl_len,
+				      fw_mng->max_duration_start,
+				      cdb->read_write_len_ext, 1000, 0,
+				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(fw_update->dev, &args);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(fw_update->dev,
+					      &fw_update->ntf_params,
+					      "Start FW download command failed",
+					      args.err_msg);
+
+	return err;
+}
+
+/* See section 9.7.4 "CMD 0103h: Write Firmware Block LPL" in CMIS standard
+ * revision 5.2.
+ * struct cmis_cdb_write_fw_block_lpl_pl is a structured layout of the
+ * flat array, ethtool_cmis_cdb_request::payload.
+ */
+struct cmis_cdb_write_fw_block_lpl_pl {
+	__be32	block_address;
+	u8 fw_block[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH - sizeof(__be32)];
+};
+
+static int
+cmis_fw_update_write_image(struct ethtool_cmis_cdb *cdb,
+			   struct ethtool_cmis_fw_update_params *fw_update,
+			   struct cmis_fw_update_fw_mng_features *fw_mng)
+{
+	u8 start = fw_mng->start_cmd_payload_size;
+	u32 offset, max_block_size, max_lpl_len;
+	u32 image_size = fw_update->fw->size;
+	int err;
+
+	max_lpl_len = min_t(u32,
+			    ethtool_cmis_get_max_payload_size(cdb->read_write_len_ext),
+			    ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH);
+	max_block_size =
+		max_lpl_len - sizeof_field(struct cmis_cdb_write_fw_block_lpl_pl,
+					   block_address);
+
+	for (offset = start; offset < image_size; offset += max_block_size) {
+		struct cmis_cdb_write_fw_block_lpl_pl pl = {
+			.block_address = cpu_to_be32(offset - start),
+		};
+		struct ethtool_cmis_cdb_cmd_args args = {};
+		u32 block_size, lpl_len;
+
+		ethnl_module_fw_flash_ntf_in_progress(fw_update->dev,
+						      &fw_update->ntf_params,
+						      offset - start,
+						      image_size);
+		block_size = min_t(u32, max_block_size, image_size - offset);
+		memcpy(pl.fw_block, &fw_update->fw->data[offset], block_size);
+		lpl_len = block_size +
+			sizeof_field(struct cmis_cdb_write_fw_block_lpl_pl,
+				     block_address);
+
+		ethtool_cmis_cdb_compose_args(&args,
+					      ETHTOOL_CMIS_CDB_CMD_WRITE_FW_BLOCK_LPL,
+					      (u8 *)&pl, lpl_len,
+					      fw_mng->max_duration_write,
+					      cdb->read_write_len_ext, 1, 0,
+					      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+		err = ethtool_cmis_cdb_execute_cmd(fw_update->dev, &args);
+		if (err < 0) {
+			ethnl_module_fw_flash_ntf_err(fw_update->dev,
+						      &fw_update->ntf_params,
+						      "Write FW block LPL command failed",
+						      args.err_msg);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int
+cmis_fw_update_complete_download(struct ethtool_cmis_cdb *cdb,
+				 struct net_device *dev,
+				 struct cmis_fw_update_fw_mng_features *fw_mng,
+				 struct ethnl_module_fw_flash_ntf_params *ntf_params)
+{
+	struct ethtool_cmis_cdb_cmd_args args = {};
+	int err;
+
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_COMPLETE_FW_DOWNLOAD,
+				      NULL, 0, fw_mng->max_duration_complete,
+				      cdb->read_write_len_ext, 1000, 0,
+				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(dev, &args);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "Complete FW download command failed",
+					      args.err_msg);
+
+	return err;
+}
+
+static int
+cmis_fw_update_download_image(struct ethtool_cmis_cdb *cdb,
+			      struct ethtool_cmis_fw_update_params *fw_update,
+			      struct cmis_fw_update_fw_mng_features *fw_mng)
+{
+	int err;
+
+	err = cmis_fw_update_start_download(cdb, fw_update, fw_mng);
+	if (err < 0)
+		return err;
+
+	err = cmis_fw_update_write_image(cdb, fw_update, fw_mng);
+	if (err < 0)
+		return err;
+
+	err = cmis_fw_update_complete_download(cdb, fw_update->dev, fw_mng,
+					       &fw_update->ntf_params);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+enum {
+	CMIS_MODULE_LOW_PWR	= 1,
+	CMIS_MODULE_READY	= 3,
+};
+
+static bool module_is_ready(u8 data)
+{
+	u8 state = (data >> 1) & 7;
+
+	return state == CMIS_MODULE_READY || state == CMIS_MODULE_LOW_PWR;
+}
+
+#define CMIS_MODULE_READY_MAX_DURATION_MSEC	1000
+#define CMIS_MODULE_STATE_OFFSET		3
+
+static int
+cmis_fw_update_wait_for_module_state(struct net_device *dev, u8 flags)
+{
+	u8 state;
+
+	return ethtool_cmis_wait_for_cond(dev, flags, CDB_F_MODULE_STATE_VALID,
+					  CMIS_MODULE_READY_MAX_DURATION_MSEC,
+					  CMIS_MODULE_STATE_OFFSET,
+					  module_is_ready, NULL, &state);
+}
+
+/* See section 9.7.10 "CMD 0109h: Run Firmware Image" in CMIS standard
+ * revision 5.2.
+ * struct cmis_cdb_run_fw_image_pl is a structured layout of the flat
+ * array, ethtool_cmis_cdb_request::payload.
+ */
+struct cmis_cdb_run_fw_image_pl {
+	u8 resv1;
+	u8 image_to_run;
+	u16 delay_to_reset;
+};
+
+static int
+cmis_fw_update_run_image(struct ethtool_cmis_cdb *cdb, struct net_device *dev,
+			 struct ethnl_module_fw_flash_ntf_params *ntf_params)
+{
+	struct ethtool_cmis_cdb_cmd_args args = {};
+	struct cmis_cdb_run_fw_image_pl pl = {0};
+	int err;
+
+	ethtool_cmis_cdb_compose_args(&args, ETHTOOL_CMIS_CDB_CMD_RUN_FW_IMAGE,
+				      (u8 *)&pl, sizeof(pl),
+				      cdb->max_completion_time,
+				      cdb->read_write_len_ext, 1000, 0,
+				      CDB_F_MODULE_STATE_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(dev, &args);
+	if (err < 0) {
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "Run image command failed",
+					      args.err_msg);
+		return err;
+	}
+
+	err = cmis_fw_update_wait_for_module_state(dev, args.flags);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "Module is not ready on time after reset",
+					      NULL);
+
+	return err;
+}
+
+static int
+cmis_fw_update_commit_image(struct ethtool_cmis_cdb *cdb,
+			    struct net_device *dev,
+			    struct ethnl_module_fw_flash_ntf_params *ntf_params)
+{
+	struct ethtool_cmis_cdb_cmd_args args = {};
+	int err;
+
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_COMMIT_FW_IMAGE,
+				      NULL, 0, cdb->max_completion_time,
+				      cdb->read_write_len_ext, 1000, 0,
+				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(dev, &args);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "Commit image command failed",
+					      args.err_msg);
+
+	return err;
+}
+
+static int cmis_fw_update_reset(struct net_device *dev)
+{
+	__u32 reset_data = ETH_RESET_PHY;
+
+	return dev->ethtool_ops->reset(dev, &reset_data);
+}
+
+void
+ethtool_cmis_fw_update(struct ethtool_cmis_fw_update_params *fw_update)
+{
+	struct ethnl_module_fw_flash_ntf_params *ntf_params =
+						&fw_update->ntf_params;
+	struct cmis_fw_update_fw_mng_features fw_mng = {0};
+	struct net_device *dev = fw_update->dev;
+	struct ethtool_cmis_cdb *cdb;
+	int err;
+
+	cdb = ethtool_cmis_cdb_init(dev, &fw_update->params, ntf_params);
+	if (IS_ERR(cdb))
+		goto err_send_ntf;
+
+	ethnl_module_fw_flash_ntf_start(dev, ntf_params);
+
+	err = cmis_fw_update_fw_mng_features_get(cdb, dev, &fw_mng, ntf_params);
+	if (err < 0)
+		goto err_cdb_fini;
+
+	err = cmis_fw_update_download_image(cdb, fw_update, &fw_mng);
+	if (err < 0)
+		goto err_cdb_fini;
+
+	err = cmis_fw_update_run_image(cdb, dev, ntf_params);
+	if (err < 0)
+		goto err_cdb_fini;
+
+	/* The CDB command "Run Firmware Image" resets the firmware, so the new
+	 * one might have different settings.
+	 * Free the old CDB instance, and init a new one.
+	 */
+	ethtool_cmis_cdb_fini(cdb);
+
+	cdb = ethtool_cmis_cdb_init(dev, &fw_update->params, ntf_params);
+	if (IS_ERR(cdb))
+		goto err_send_ntf;
+
+	err = cmis_fw_update_commit_image(cdb, dev, ntf_params);
+	if (err < 0)
+		goto err_cdb_fini;
+
+	err = cmis_fw_update_reset(dev);
+	if (err < 0)
+		goto err_cdb_fini;
+
+	ethnl_module_fw_flash_ntf_complete(dev, ntf_params);
+	ethtool_cmis_cdb_fini(cdb);
+	return;
+
+err_cdb_fini:
+	ethtool_cmis_cdb_fini(cdb);
+err_send_ntf:
+	ethnl_module_fw_flash_ntf_err(dev, ntf_params, NULL, NULL);
+}
diff --git a/net/ethtool/module_fw.h b/net/ethtool/module_fw.h
index 6c86d05ab6cf..d0fc2529b60e 100644
--- a/net/ethtool/module_fw.h
+++ b/net/ethtool/module_fw.h
@@ -25,6 +25,35 @@ struct ethtool_module_fw_flash_params {
 	u8 password_valid:1;
 };
 
+/**
+ * struct ethtool_cmis_fw_update_params - CMIS firmware update specific
+ *						parameters
+ * @dev: Pointer to the net_device to be flashed.
+ * @params: Module firmware flashing parameters.
+ * @ntf_params: Module firmware flashing notification parameters.
+ * @fw: Firmware to flash.
+ */
+struct ethtool_cmis_fw_update_params {
+	struct net_device *dev;
+	struct ethtool_module_fw_flash_params params;
+	struct ethnl_module_fw_flash_ntf_params ntf_params;
+	const struct firmware *fw;
+};
+
+/**
+ * struct ethtool_module_fw_flash - module firmware flashing
+ * @list: List node for &module_fw_flash_work_list.
+ * @dev_tracker: Refcount tracker for @dev.
+ * @work: The flashing firmware work.
+ * @fw_update: CMIS firmware update specific parameters.
+ */
+struct ethtool_module_fw_flash {
+	struct list_head list;
+	netdevice_tracker dev_tracker;
+	struct work_struct work;
+	struct ethtool_cmis_fw_update_params fw_update;
+};
+
 void
 ethnl_module_fw_flash_ntf_err(struct net_device *dev,
 			      struct ethnl_module_fw_flash_ntf_params *params,
@@ -39,3 +68,5 @@ void
 ethnl_module_fw_flash_ntf_in_progress(struct net_device *dev,
 				      struct ethnl_module_fw_flash_ntf_params *params,
 				      u64 done, u64 total);
+
+void ethtool_cmis_fw_update(struct ethtool_cmis_fw_update_params *params);
-- 
2.45.0


