Return-Path: <netdev+bounces-107315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 453B691A8BE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8C31F27851
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247D3195F3B;
	Thu, 27 Jun 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OeAwk///"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A6D195F1A;
	Thu, 27 Jun 2024 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497402; cv=fail; b=MddeVoIoNLp6jufgifBoBwZ4lAuiOGTleq+vhFJ56JgZPXwMqDZe7D5bUTIeHevgKnvdZRyzPIqEl3bDFPqrzuCoILB8Y8UBEUmEp3/qmtuWgVS4hgj4De/iFDoxPxw2wpf56m34D33QeEKwZ2qZiEOUyYknHJYOmNUqHkzdzXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497402; c=relaxed/simple;
	bh=tf8zyR1ijPaAa7uK+SGUvy3ps2hb4oUdo4xjsC8GkDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VeALocyk/iZQnmVPDqnLKX9+xYUB1hk6se4BbBj7crVKCyTSUqWRRGYCjQVTa2+lqvJn+4XoG773VdJW2oxMKZnMHkWGgXRW12CBPYtV4/nDBfrif21l52Nwk6c5qPMdPyzM4ieEk9mAjLk4qEAZuTXSY+QlA8BwPEPUVtpwHMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OeAwk///; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2ODf/8/Nzizbqg4LVkHgnq3B3/O292ExrCqNcdkk60l7UOS1GvcnzF/EeFUrTtpUoyE1/ZCcC8xI9hFshoLPwZcYY3iSzooQx0ISnZEgj5x9NH47yHTUthtOKfwH2FiRcMo+x3CuP58MmGQ99C7wbcsmO3gkd1XEKExVjLWZiRZYQtvDbW0av2U291hacys70eKAXvY1bAEwvnmUDr4EEm7We6ZlgrVTHq5dqewM16hBaj0++xcGZ1zxMYxz5LNCfSmQ9yrhvxWX/7wiMIg+Xu8P/oA+eRfJ2ri05CNPepVScZKjsU4MAh30NCLHrIQHE05HFE/UzPWiVSBi27DnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OUEJ1k/aC0RMnGreZplIUOSVB/4ZfXX8S+AyZU4KjQ=;
 b=CSZjxxdm1Hnggyxp3zUOKhsUhbUcmcdy0wE7g4vmgBWF1r/8ttRr7eRffWcqui7bsWGEs4nUQ9C+7yZYCfE5nUXubniCPJYdNJ14dBzOk+X8wiWXpmdkfa4nw2o5N2VK/tmxqsMyOcHc4/H7kBM5hCKdVsKLlDRTY1BApIycdTKl30Gsc6xbKMPBwUpl2+22ssVuUrKq1iz0OJ931RgBZ5Ua+A1ZNpe/r4vwKLtuGhjzWnDTd6yqOGR3XQgQ09CgFb2nB8kaLKj9Av4hCs1a4NyV09s/fGIO2ov4wl90QKt8OqEDMUGn2pTuMKsUx6eocYBLcxCh0oBZIhz7/OKCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OUEJ1k/aC0RMnGreZplIUOSVB/4ZfXX8S+AyZU4KjQ=;
 b=OeAwk///F/t9E2Kf/+sVBOKYvQjqv5GP6+OcVxjYjeGSLAIYTnI4PVCxtZY0TADIaIBX71Zx+UtLeGATqXYCJsiIYGOyozbwZ7qdxUOoV7f2MysWU8p3zP4NmlIkfDN1X5grE5Nll52H5rOD8KLVhE7yQP9ooJC7ktkn68VBQFACHI2lPPHwGphKS9UCd2DLAiyGtCRywAP6pVrNK56cKAdyZeYP/FZx4Vmi3kziCSJxs8GcL3/D8G5rIRNheSeC0nQ/3oGAjxpxHe1GNniPo4ImccENqa3ggaERbxacbhBg0iGjgTYRR8gcDDIbILrWleGt55xzcqJAMGbr2f/wKw==
Received: from BN1PR13CA0030.namprd13.prod.outlook.com (2603:10b6:408:e2::35)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Thu, 27 Jun
 2024 14:09:54 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::a4) by BN1PR13CA0030.outlook.office365.com
 (2603:10b6:408:e2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Thu, 27 Jun 2024 14:09:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.0 via Frontend Transport; Thu, 27 Jun 2024 14:09:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:09:32 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 07:09:26 -0700
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
	<petrm@nvidia.com>
Subject: [PATCH net-next v8 2/9] mlxsw: Implement ethtool operation to write to a transceiver module EEPROM
Date: Thu, 27 Jun 2024 17:08:49 +0300
Message-ID: <20240627140857.1398100-3-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3de39f-1397-487a-2f35-08dc96b2d0f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+c4x5brRlLxYzjB9ZFtkaKchFWWUp5KoFnC1dFhqVh9nXlG9mcXIE0cQk85f?=
 =?us-ascii?Q?6iv+z0n8S1jBu7WSqcnKjzKkd63nlBMm6XiLA0ozCQg5VPCQuxqARd7P+IZV?=
 =?us-ascii?Q?MnMeI+tuVMdGBXC7PbswaPHZW5LNPSVGvYUEiFueYXo2FXGgjrjIS9+7GNEf?=
 =?us-ascii?Q?lRKMHVzgQqaCJY5JMjaO36SAbPaC+d7+Jhr7fLiNpAXqzYByn6xaNp2VIpmU?=
 =?us-ascii?Q?CH1ArY0/g6+4gjW5nvgXzQNpgnhXH9580tvMwQ5dtZUsWyJ4sgAUp/U4awuI?=
 =?us-ascii?Q?KCKi/zsDCNevuRJrp1GIKt6gnNPz38/gz6qWK3QDmsX1WUaO20RUPCTg5+li?=
 =?us-ascii?Q?HgIEf4clejtU95S2CBXr3xr4hKrnVnE9kLF3viL17Nj7Rjv6HRVdBJvERKMX?=
 =?us-ascii?Q?WX5z5EfMYDiSdu7bGMuh4jfn4yxTEJZgH9o4sUTthUfjSoTS1TGgXZMf7/9F?=
 =?us-ascii?Q?VWK6FB20tqCjloyoCAfNJAnVng9930fvnGYucsLVB32fPTbhOhYDb+mbLwII?=
 =?us-ascii?Q?ytxW+VHPd1BWWs0vQEaokXP23uDAR487viHcVKDIPHmOQ/WFpyDZ2VbB1XGB?=
 =?us-ascii?Q?T4JHWcNmER20vwWGsDozEPXCVblKtvc3EEFTZad7lfKdFINgiWV2NgUS7wNQ?=
 =?us-ascii?Q?22bzcKZyvglecvpuQrmMW913ivkPF4cMq8/XrSa/MkFq10fO1HzfFMKZZvJW?=
 =?us-ascii?Q?7EI20szzOXm2dxoJ7zcWzHm7GjKBMjSti9k/5AIDE58xnVPa56Af2uSokKOo?=
 =?us-ascii?Q?yR+RLzuvaJKMfn0M0WxyHzuzkt/AdfT+5V6dueSNDeZFJWo+V0QUnvlN+o9L?=
 =?us-ascii?Q?7Or6ZkAYJuwp3VLQov7uYciUYltHlZ2HQkEc9Y631o+hk1vzmsrMS4IIlRCS?=
 =?us-ascii?Q?ohpng/1miwJgfehhcOnV5NUuRIi8N0DEQ3/CcqMnXg08yCsHVJK8Yl33iWSH?=
 =?us-ascii?Q?gQtNyFfP9Mxbz69j6t9DYA9YqSaL6o5cx6NSZqI1nupTt3S6OHnYo7+NSjHd?=
 =?us-ascii?Q?crlnTvfMJhNHxN+zVyqLFqnM+G2K/EUzzhSUJ2eQfsvEo4bDyz0WMX7N1PzM?=
 =?us-ascii?Q?fszUx0WeftwNzyhcezBtiD66a7ltwYsW0IqCcsjBdKAkn49lU84qTv0mFhAj?=
 =?us-ascii?Q?iasMpLsSGiIdKsh4uB6nA2D9ZHBuTMr9U0JrtSvqH02NKTcoRTGJ9iGL1EbD?=
 =?us-ascii?Q?rSUP96DT2Y9VOhj1UtB+mUsA4rn3jlfT7oW65tRgudDadI5/2jIVFKYWTgRq?=
 =?us-ascii?Q?TbZzoMpEyCR32bB8VeiSW8eTV1BnWa6qOMmt8hgwkGqN0uJX1xe3S+5hhBoi?=
 =?us-ascii?Q?bnpxIqDCQxIOaMJLjcBfP/QNPotsDUJ8crSs3iWuSQU+XUoKrOehB5yHsdcs?=
 =?us-ascii?Q?3fhTRqdW9M0QWwXAcBpUVqR76GExgCyoOx3pITd4l2Iz3flsM/yE6VPReFV8?=
 =?us-ascii?Q?+vaEdR1TIPgvfgXZHZQ582l31g3V0M+7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:09:53.1679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3de39f-1397-487a-2f35-08dc96b2d0f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210

From: Ido Schimmel <idosch@nvidia.com>

Implement the ethtool_ops::set_module_eeprom_by_page operation to allow
ethtool to write to a transceiver module EEPROM, in a similar fashion to
the ethtool_ops::get_module_eeprom_by_page operation.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../net/ethernet/mellanox/mlxsw/core_env.c    | 57 +++++++++++++++++++
 .../net/ethernet/mellanox/mlxsw/core_env.h    |  6 ++
 drivers/net/ethernet/mellanox/mlxsw/minimal.c | 15 +++++
 .../mellanox/mlxsw/spectrum_ethtool.c         | 15 +++++
 4 files changed, 93 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.c b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
index 6c06b0592760..294e758f1067 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
@@ -513,6 +513,63 @@ mlxsw_env_get_module_eeprom_by_page(struct mlxsw_core *mlxsw_core,
 }
 EXPORT_SYMBOL(mlxsw_env_get_module_eeprom_by_page);
 
+int
+mlxsw_env_set_module_eeprom_by_page(struct mlxsw_core *mlxsw_core,
+				    u8 slot_index, u8 module,
+				    const struct ethtool_module_eeprom *page,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlxsw_env *mlxsw_env = mlxsw_core_env(mlxsw_core);
+	u32 bytes_written = 0;
+	u16 device_addr;
+	int err;
+
+	if (!mlxsw_env_linecard_is_active(mlxsw_env, slot_index)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot write to EEPROM of a module on an inactive line card");
+		return -EIO;
+	}
+
+	err = mlxsw_env_validate_module_type(mlxsw_core, slot_index, module);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "EEPROM is not equipped on port module type");
+		return err;
+	}
+
+	device_addr = page->offset;
+
+	while (bytes_written < page->length) {
+		char mcia_pl[MLXSW_REG_MCIA_LEN];
+		char eeprom_tmp[128] = {};
+		u8 size;
+
+		size = min_t(u8, page->length - bytes_written,
+			     mlxsw_env->max_eeprom_len);
+
+		mlxsw_reg_mcia_pack(mcia_pl, slot_index, module, page->page,
+				    device_addr + bytes_written, size,
+				    page->i2c_address);
+		mlxsw_reg_mcia_bank_number_set(mcia_pl, page->bank);
+		memcpy(eeprom_tmp, page->data + bytes_written, size);
+		mlxsw_reg_mcia_eeprom_memcpy_to(mcia_pl, eeprom_tmp);
+
+		err = mlxsw_reg_write(mlxsw_core, MLXSW_REG(mcia), mcia_pl);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack, "Failed to access module's EEPROM");
+			return err;
+		}
+
+		err = mlxsw_env_mcia_status_process(mcia_pl, extack);
+		if (err)
+			return err;
+
+		bytes_written += size;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mlxsw_env_set_module_eeprom_by_page);
+
 static int mlxsw_env_module_reset(struct mlxsw_core *mlxsw_core, u8 slot_index,
 				  u8 module)
 {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.h b/drivers/net/ethernet/mellanox/mlxsw/core_env.h
index a197e3ae069c..e4ff17869400 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_env.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.h
@@ -28,6 +28,12 @@ mlxsw_env_get_module_eeprom_by_page(struct mlxsw_core *mlxsw_core,
 				    const struct ethtool_module_eeprom *page,
 				    struct netlink_ext_ack *extack);
 
+int
+mlxsw_env_set_module_eeprom_by_page(struct mlxsw_core *mlxsw_core,
+				    u8 slot_index, u8 module,
+				    const struct ethtool_module_eeprom *page,
+				    struct netlink_ext_ack *extack);
+
 int mlxsw_env_reset_module(struct net_device *netdev,
 			   struct mlxsw_core *mlxsw_core, u8 slot_index,
 			   u8 module, u32 *flags);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/minimal.c b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
index 431accdc6213..828c65036a4c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/minimal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
@@ -140,6 +140,20 @@ mlxsw_m_get_module_eeprom_by_page(struct net_device *netdev,
 						   page, extack);
 }
 
+static int
+mlxsw_m_set_module_eeprom_by_page(struct net_device *netdev,
+				  const struct ethtool_module_eeprom *page,
+				  struct netlink_ext_ack *extack)
+{
+	struct mlxsw_m_port *mlxsw_m_port = netdev_priv(netdev);
+	struct mlxsw_core *core = mlxsw_m_port->mlxsw_m->core;
+
+	return mlxsw_env_set_module_eeprom_by_page(core,
+						   mlxsw_m_port->slot_index,
+						   mlxsw_m_port->module,
+						   page, extack);
+}
+
 static int mlxsw_m_reset(struct net_device *netdev, u32 *flags)
 {
 	struct mlxsw_m_port *mlxsw_m_port = netdev_priv(netdev);
@@ -181,6 +195,7 @@ static const struct ethtool_ops mlxsw_m_port_ethtool_ops = {
 	.get_module_info	= mlxsw_m_get_module_info,
 	.get_module_eeprom	= mlxsw_m_get_module_eeprom,
 	.get_module_eeprom_by_page = mlxsw_m_get_module_eeprom_by_page,
+	.set_module_eeprom_by_page = mlxsw_m_set_module_eeprom_by_page,
 	.reset			= mlxsw_m_reset,
 	.get_module_power_mode	= mlxsw_m_get_module_power_mode,
 	.set_module_power_mode	= mlxsw_m_set_module_power_mode,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
index a755b0a901d3..c79da1411d33 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
@@ -1067,6 +1067,20 @@ mlxsw_sp_get_module_eeprom_by_page(struct net_device *dev,
 						   module, page, extack);
 }
 
+static int
+mlxsw_sp_set_module_eeprom_by_page(struct net_device *dev,
+				   const struct ethtool_module_eeprom *page,
+				   struct netlink_ext_ack *extack)
+{
+	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
+	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
+	u8 slot_index = mlxsw_sp_port->mapping.slot_index;
+	u8 module = mlxsw_sp_port->mapping.module;
+
+	return mlxsw_env_set_module_eeprom_by_page(mlxsw_sp->core, slot_index,
+						   module, page, extack);
+}
+
 static int
 mlxsw_sp_get_ts_info(struct net_device *netdev, struct ethtool_ts_info *info)
 {
@@ -1256,6 +1270,7 @@ const struct ethtool_ops mlxsw_sp_port_ethtool_ops = {
 	.get_module_info		= mlxsw_sp_get_module_info,
 	.get_module_eeprom		= mlxsw_sp_get_module_eeprom,
 	.get_module_eeprom_by_page	= mlxsw_sp_get_module_eeprom_by_page,
+	.set_module_eeprom_by_page	= mlxsw_sp_set_module_eeprom_by_page,
 	.get_ts_info			= mlxsw_sp_get_ts_info,
 	.get_eth_phy_stats		= mlxsw_sp_get_eth_phy_stats,
 	.get_eth_mac_stats		= mlxsw_sp_get_eth_mac_stats,
-- 
2.45.0


