Return-Path: <netdev+bounces-106221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DC19155E2
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B194B234D4
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FEA19FA8E;
	Mon, 24 Jun 2024 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X6fbJfx9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F51A01B4;
	Mon, 24 Jun 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251578; cv=fail; b=TTyofOlx+xfKpYUZTlmHIaZn6B234V9QLnrnpeh66/CmN3EkKhcNvulYPTA9pjbLWR63U1HynFtuRUPWR4MDdw60PcSkypX1zXdyTzHf9+iiWh2WLtYr+O+hlpqqGhhb9JattdxmUq+4kqRvK3x/IKBH3Gd4fn5AqR92vDuyqe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251578; c=relaxed/simple;
	bh=aTxRNMM1hRQggbP0Fr1hy+tstbDZJhg5+DMlYebEga4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyhznYpxdFg2M2W/v5CVLq3MQZxzq0O9WgYnMxr88B/NgL6JWS6kMTmP6ISOMLq9m0JlUJEr3j5CIA+zlk1o4xt9aOESmbIK8yGuIJlPCrXQW95kDaS9JdLkr3OrD/CK5c/GGSHoTyDUh+MOwqlmVjYK0hQv594B4WUrx21tgLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X6fbJfx9; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6bTILN24pj1r9qGAvhu8+/d74zhfVjQF/4QKgZgptOPQ/kjeAaF0v8+eZYWKDDv+jQtBpFjhchk9HoKD8+wl5YgZ0Ua5ArTAPWoeTESKJeAds5x2PC8VPcELOzs20YOSbnZ9ZG9U0xlU8oR587Ogj0Q+lhB5/nCuaQK+EOa3tHaMGzGz5yrPn2fw0a2U6XSk/h+E3qQqhFOLMClXtVdb631t1nLctW+iZ0gFwW5glwIvQ/2lb9AUoZbhdoK3cB3y2rSDhW2/tMWeo/VyAcJ4nLCiJCStMRyNCKmhA6KQbwJPXK1oSxqifw7sLga+Ay4n1bUJT3B7DoxSVnlPPYpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anWgWMEJrRNgLT/UmgYVrL+gM3k+NEPUfpKvFmqdBNA=;
 b=L+SZLaE8ieIHeShqaGwnQyehG5jPhEwwKIQskgGP9mutdxw/g7uUCOqcHqR5ELZ1vVl9go4VjEtunsF3/dFmujm2d78Rwe1Tp5J1f10qVU6q9PToz9T1am+liHYy9Fjmw50cdMOQ/DMAyvEKAjNgCP/iBq32weR9CWI0PGji+hfBbPXNFaqBlkwCAUIO0zWdIwsNv2xkxpX7fz3lyCf9+553fw6jpPRGio3T/vpKCz22g1R/fboOG1RXdtFhmQ2YU49KP/DlaSlTLFo8ZE6RFKf2JDufRbYKYOutR5RyRlP51qu6ZikLzap+bfoZk/tzapD1kHZGxXktrMs/vKCEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anWgWMEJrRNgLT/UmgYVrL+gM3k+NEPUfpKvFmqdBNA=;
 b=X6fbJfx9EwPnoNDqOsB2EH+b9P5G0bT8EPxP5I93DOH5ixicAmydjWOJWN2n1YS4dKrlaRGcijQaM4CTlDLEirb3jA4nZUUjD+6Tv88kscmH33acSjVA+RY6/p8ixkhUukAbKGIn1fk8kMCTS8VQ3X0N3Bz9H3sczzXB9f0Jb/7MK8gyIZHpQsDKeTngdZmx6GqDNuqp/KfIaPUtfIxtnwYU+CShB2TzWGf/IXUpBfLr6fKLbGGzLd08U4j9Cw8j5jbXCVm+DY0B9YRBNt3rDfS4tR27DyObQVJqK/iiYaeG4NmSDWUuVEA8A5BejWfQKGxh4l5t9fU0LOulbSMhsQ==
Received: from BYAPR11CA0087.namprd11.prod.outlook.com (2603:10b6:a03:f4::28)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 17:52:50 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::31) by BYAPR11CA0087.outlook.office365.com
 (2603:10b6:a03:f4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 17:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 17:52:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 10:52:33 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 10:52:27 -0700
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
Subject: [PATCH net-next v7 2/9] mlxsw: Implement ethtool operation to write to a transceiver module EEPROM
Date: Mon, 24 Jun 2024 20:51:52 +0300
Message-ID: <20240624175201.130522-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624175201.130522-1-danieller@nvidia.com>
References: <20240624175201.130522-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 41141bac-de92-46ee-5512-08dc947676fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|376011|7416011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AH9TFo0MLvEoYSIusTRRnxOLf2mgG3QBzNZH9I4MWzDD7JTAs63TTwog73ZH?=
 =?us-ascii?Q?dKf2e4K+/SpXsEnsP5DD6MLHZlXzFaT+7QDCydC7JdEBEdyua+cuDJl4pzH6?=
 =?us-ascii?Q?aIghQjoliIkSJkXymILYvSXMVyeJrTotCo66E08GURKfB91qUz8WIfWuxKyB?=
 =?us-ascii?Q?5OzbNjXHfUGD+3U1tG1aWUE7a4mhT5ngsIRQf6Xc8Qdw/QoJWqc2wzGC7q6D?=
 =?us-ascii?Q?uSEeaOpi9wm3L6XQKpdsWzBZI8P/KaIGOTYGVSg3CBFGLErjKZtMol4A6osA?=
 =?us-ascii?Q?MBISz/F7ot48ajWOiAtIzqS/VR3GbCc1pgX3e4rULRgzzKth37CYyWcwWYMU?=
 =?us-ascii?Q?sP5bOC7zwLKog3ALLlKRSeL4grVg9RkudyWyCE+3M+uRrD2S+c3E2RFtnKSz?=
 =?us-ascii?Q?LBfP/kdmz1CSqUpTD8qCuzOBOreolUDeBYxtSFXJNi+6AdcuAMPOYuBuiSG0?=
 =?us-ascii?Q?C09MsCNKQt9N1qbKErjS9kC0+ZU+NOVnLLIandrySUuUKqK/9U536wh4ZDH+?=
 =?us-ascii?Q?2/ZSy921TvX7pcaFLDuq3wb+foQZ3wv9IuVGQ6ed4LK816ASvz9uZoNPdhw6?=
 =?us-ascii?Q?klFqbD+wCT8W5sNlA4boLEuhZBQdzXxabqJ7s0KW5VMX3fFlZ1xXjN51c6oj?=
 =?us-ascii?Q?QvwQVvtjA4mY6Rx/dKS09RjSTB/YlrCx+k5HvC8z31JxOd6FzXqKSLB1WFVh?=
 =?us-ascii?Q?NWXCSFN+9WUReD9KZVmroxHYRI44FIMJmsnlI1f7c6yW+foaVhM6IHqePSuv?=
 =?us-ascii?Q?qtuYEmIE8c4//6wlM/2nKqhHcljUlaEUnDQGBy99XYEFwtoYKgNaPituzBs8?=
 =?us-ascii?Q?/iaH38CcFVjmMDgL0ZkO18txpzPrlVPYN0vFQxNSa6n67+rKP3sIS4EntPYO?=
 =?us-ascii?Q?E+EGVRbwiIwxahKeYBnLgVDlXlQxuYEbc865DWmBOKxCgIwVtZZZ9PcxHkLP?=
 =?us-ascii?Q?tHSDwcHOXbhe6sQ12sf9BG5niOsUa1sK+KQxuB0NK89b8Bn1TY0QF/EqvTIc?=
 =?us-ascii?Q?US7HSRHAhQjCauBinm3xCjwMdxXLWm5+NN0f/0nHY5GeneKd16eCIoN6UFBz?=
 =?us-ascii?Q?6C9lvZH/N6uxe+es8/ZzFHE/ezbKykrqtiV7lz7tLxThwfkt4zkr5qxwJNby?=
 =?us-ascii?Q?cs5AY+5AMpY1hvPkzAJ5xgY+V13HtGNqDA4wPLISc9DNGd7OdnFRAO3YAHCt?=
 =?us-ascii?Q?ddGDVKeqbO8gMasjQfG1cDrAS72cW5tLYcOgtkQHEx44gB1OzUY7lbY9Wat/?=
 =?us-ascii?Q?408cqsHiYi13TOKj1bZA0eVT5tvLzJT2f4TItwqgX6CKeTlSsA0ZAHI93XSO?=
 =?us-ascii?Q?RYNIevPHZdVBmv91B4LCS7tPyena2FPWlIDC8+3RErzem2ncc0xdPMAflIRC?=
 =?us-ascii?Q?67QDP2f1OybvNNjBXJFIv23LhyZPC1JOnQInikHDMgCLq1Zlvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(376011)(7416011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 17:52:50.2599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41141bac-de92-46ee-5512-08dc947676fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199

From: Ido Schimmel <idosch@nvidia.com>

Implement the ethtool_ops::set_module_eeprom_by_page operation to allow
ethtool to write to a transceiver module EEPROM, in a similar fashion to
the ethtool_ops::get_module_eeprom_by_page operation.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
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
index f0ceb196a6ce..448263423e36 100644
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


