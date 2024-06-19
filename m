Return-Path: <netdev+bounces-104850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70AE90EAC7
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65725281776
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8539C14375A;
	Wed, 19 Jun 2024 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j8fRVYgc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081014372C;
	Wed, 19 Jun 2024 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799498; cv=fail; b=nDtllq3ek8LoVAe1cew8/i6TzvFQDEH9xWjFohQnQqb7XueycBVntDzOqNCE+vmogCrpbv0fLAWerasWoPvBsKcAeB8Upmd/y2Tk2Oe34tNrhu4nmgUcmLHayvFrBYLt/VPwLf3aqMe5FrYMKBWl406YMifY27EpTVrz8ZoGLY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799498; c=relaxed/simple;
	bh=aTxRNMM1hRQggbP0Fr1hy+tstbDZJhg5+DMlYebEga4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rijd+l79DpTwt4cayCQbCCRBhOA2UQQVnTL49uRrNuDoYdyCi5nbIJrV94JEwaUwVkEmrCjtbLLcdB/JVGHmF/pY7mWPo7+ODIcEa4zwBquk/akeVO+MX8on+6DbgylPdxHM9y7/yu+tGSEAY9wKNWJsBf0jdKYmb95+9Z6YVQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j8fRVYgc; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG6o82j3ysMg4qwk0xxPL3+nPAp6Sf94b+MNEGkamMWsIPvmP3onsAEtfMvvGO6SqZVWHndtlmBeGztfiq8uZFy7vunbs2zx2iGRyMuXdDvaE7N/RcoHLg8dHjHz/eofvJ217YYygNlnrt4F/rjnqBMSQDeCJfhxp9O+mIPSBzuC2CETDSeyUMjculUrY7Be2eabgPIi2Bz+Lek2rvDj9GQse/4fpHpZRRCsN9GvUg8cu0uFSaC4wAa53XwUhm6ZVEdDBG3qVv4RjgGnD6epb8091KHZNXM9DREAVK/Vn25bzwAKdEOdv1HS9g9Sjub6pRFvf+J27tVSoyEu/O2sXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anWgWMEJrRNgLT/UmgYVrL+gM3k+NEPUfpKvFmqdBNA=;
 b=Jnkw14wHh7hLmU3/OGtnBuc9/cjPW161I1+F15rYPvu9BoAtAJBpIwThb07Cf+wXto4WQadIwpoEniYbozE5rENmbwPYyV8yL8z8cvo+azW1GhMueKIXOJn3fM0H4LhW7r0NPW68dl0V263B/gN+Cw/ki5BojbCmPWPkHb2OCWD8hsPq9HiKUv1PHi31cMW6gvunCe+aHDBuG0v89RSaD9dnXw9JKbT6LWKqOoYQVJb0yCQ+XPjFTfo7quPM/ZjlWwnEKaHYYfIEsUQoHmHWKvpOFakqUdKzebJb5T3+48eyITVxAAxLD2kFIKWr2vf27xCgPFa+/ZACzPnrfb9rbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anWgWMEJrRNgLT/UmgYVrL+gM3k+NEPUfpKvFmqdBNA=;
 b=j8fRVYgcIFmBNdXnssY/bJYYVTSoRPJxOxckkc9J7iKAIy9N+GX8pCAHHb/WjnkMSnkqdCtsqJpoXRzk9bbnV2fD+Kd+ihgCqbhzXOx3YRgcXy99xj8vlQZJu1mGTKWEAR0phzO7OrkitPR1TikRmj9wvklRUW4ZZ/aC9H401exYLaYHL/nsaUshTsRWN62Zdbe8A0dI5DRBlPeu9VeaOsxi12xkqJhCbg9ex+m7hbWzRd+FXdW/J+8NdR0zgTIudIIM2s2s0fn+hJ6gqvw1FGl+JNv0CG9UHhs+Vmv35sUBa7ke8jLOng9Gh02Bl4JMhWgsdxcg8TCHANR1tbMYAw==
Received: from BN9PR03CA0983.namprd03.prod.outlook.com (2603:10b6:408:109::28)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 12:18:12 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::ab) by BN9PR03CA0983.outlook.office365.com
 (2603:10b6:408:109::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 12:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 12:18:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 05:17:58 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 05:17:52 -0700
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
Subject: [PATCH net-next v6 2/9] mlxsw: Implement ethtool operation to write to a transceiver module EEPROM
Date: Wed, 19 Jun 2024 15:17:20 +0300
Message-ID: <20240619121727.3643161-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619121727.3643161-1-danieller@nvidia.com>
References: <20240619121727.3643161-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: f26cc1d8-bb1f-48c6-7549-08dc9059e396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|36860700010|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xJkCJ/Tbe0eSFIz73jed0LirbEt2CA+cCSx3oEkculAyvJNSRLL7te6phx69?=
 =?us-ascii?Q?j1D+9PHa6/FsNvcDfVNyzYybqM5rv7nl3g1tn1l8xCarClfwDKhg9ebTUjPq?=
 =?us-ascii?Q?IbDUsOoIkL1Cwx6DPdLEBscBEzLEUWv1uI1T2qci5WO/l/0rIQZAmUxuBS69?=
 =?us-ascii?Q?biAggzrNz+nUZMPOIUvPkh87fYLwW48Rj98yc86ZgDLwUt0y5zKRr7C2IY6y?=
 =?us-ascii?Q?WSioGpLARupu8y3FDnrcTNrZokUURpZmD1pGbSLnWTvumqe5WNTE8E4guvBZ?=
 =?us-ascii?Q?6SGJvvSFipFDLGO7hIZDjwaLTzI+xbVYB2FQiw3cDlUiUMwgpbSPhDIpOenN?=
 =?us-ascii?Q?suh6fjRkJ+7yG8AqBv2CCP0EjrZbxBPX2el/h2n193FTwjcKTjKAo6aNPRa9?=
 =?us-ascii?Q?uETGriT6YjdPg9ujTBSO48BpRq4DsqguvEr1znuM9kV9zgANu/8vXrpXV4Ma?=
 =?us-ascii?Q?yKaASwU+EvCXrbg0Lk2VeDqeJTYv4DZmVjnGkPxQ77hSZS7MpwVwO1UrX9NR?=
 =?us-ascii?Q?fH7FJL1LrpXQA9JIylxE5IHvPxuiuWXRezsYNq4tifXuO94SkcOc9YAD/XCX?=
 =?us-ascii?Q?A0t9x/nkRWhGP8ctrHgKc//I6nYQr+lnskY1nXGDVMJrXpCaj1hwKC55CRQT?=
 =?us-ascii?Q?GMLeEVWofl/nlVs9cteEesSZeZbtT5qu5MG52x4YPUDDKRwWKXiN4A5d2Slh?=
 =?us-ascii?Q?IKYVF4bJwwxmCQyus21QzVhA1/pB6QLmUbjhisxlP0wJ2s9NEwkHKHDuCZFA?=
 =?us-ascii?Q?vGBQdBfkAlhgnxfcjDuN4+KHtWMXZKLs4ku7hUcot+MKlLOElmsd2kj9r3oq?=
 =?us-ascii?Q?f62KHfS/o7esqzG5NNVhZIr1YqyojLm1p4ReqrPcHkBFNxa/u2s2+HiJg048?=
 =?us-ascii?Q?1Fk7mGuNLQOx10pObsY11APW7sg+S5cDlhV55PlddCECH1aNSS38Kv+JluwI?=
 =?us-ascii?Q?ZvHjY4KyZ9q+loB4KiyFckxFIWxE3DnwMJgGUgVbrbcD66HGJZgPN1S9XiDe?=
 =?us-ascii?Q?/066WMfq+4U30H6ZunT9GSYj0IQ/aLzvsObh9BBmeNOVSuHCJ9P1RxMRxYnC?=
 =?us-ascii?Q?CYAIz8gXP2KVty7y6KGRpefCXBg3nGQXUwynRaIS/qvllStM/PhH1UegI2zS?=
 =?us-ascii?Q?QJyW8BtEs2tJb7uJBcnQuoMFEqdEoGVsGgKfAxh0qPyeh7+bDqlVCwKW6QlW?=
 =?us-ascii?Q?p8Mmb2Ba6iGSIUtjNPdjL6p9lBL3a8ZqvHPBy4dD6XmsATvpCHssNd1cpCGq?=
 =?us-ascii?Q?v97LuvPN2got7DoFkJ2Gi6HnL2r7mWVEMiMDOcekBJJyJ8OXBVWhfeD1SmF7?=
 =?us-ascii?Q?UD4qVyzUR/CNXYEhvl0yMdLlN8E4uyDYh9J4frE46xUuQUH9QGf2qeB71uyU?=
 =?us-ascii?Q?jX5JCGskxcT6RqDcNY1kX25A4edZeb//XI2hlYEphiNio7AjOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(7416011)(36860700010)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 12:18:12.2514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f26cc1d8-bb1f-48c6-7549-08dc9059e396
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894

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


