Return-Path: <netdev+bounces-42558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ACF7CF530
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EA11C20FFA
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC89418B0E;
	Thu, 19 Oct 2023 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xvz0iVvU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904F182D4
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:28:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9620011F
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RW8Kr6XcD1jsyLcJeUdJf72SgGcmLSl4M3a/MwE2z7wYW3Hk1b1UUf8JXoR68wu6QJAZtyXfeCtV5wUJ7XV0JYSXfRcWVsBlxbzNyItGmHtIGpe5WSRps6ObymgTF8ZlDfxqGFRToXmzs5MpJfB96BXcqZu2HgGNRmr2tFzC62UMMRXpXonbPXZ/9h7khC/QnE+5qgqXPv+1zolVX5G1mrgpVUAzQ7SbFbqtxPx22bWGiBjxOp6D7Hy32DtlBVSUsvMIe5y1nRBSxciNlilld+PX2qeKWjZeURvUBqagBVKWVI9Ew238bTG/IPpRLAmkwAAdg5kqCjoihJwnzwn5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEuy8nvmlw+gqvTG/BEwkS7wD6/I4GtnHUnsbMtK2MM=;
 b=YJFjs3NvVT/01Zz/CN2kIMyZGedC5GpkkP1oUZoQOw3dGe3fGz2BQik5asNd167O1DQv5eAmp3HQ4SZuAOon6p/Ec+zza74xfTMlk/iMRL3tn1swzZj3IEqxZoXR/TW3FRjrNl+g/nOyWdN2V/N6DqVkRGFxvm1dGyWRyvw4SKkaFarHAQW3t0B/vaBbVx6r5Dw9QlucYQVexKf9fWapNA59ZXC8CfJeB/ZtksnS++MVsg2pKNaehaNpw58gouMBbPlqH9OT3YdOMGuHMuVCOyfkd89CxdXztoI/VN5duzgKQotfkkC0UqQB90ZUq707a2sDuDPLjUBT/DdVU7zoYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEuy8nvmlw+gqvTG/BEwkS7wD6/I4GtnHUnsbMtK2MM=;
 b=Xvz0iVvU/AZGyzFu+/sLWHS5Z0WmEZnay9cS0k1bmZQKaB0CTaUFoHAdmqosgEicjJkTBJI9sMFk1KH4vJRpGFoupve0l82AspzeYsQ7mZffk6XVYPNE1Foy88RsHJjDOJ5lFBVWmv3/ub/Q6lBtHQ5bNS1NrYV7yTIwrxsIO9islViAtn5CLxh551hm8+1AtebT8EKtULRpxIp4I/RR1oKf8u6BVLyLdJeKt3xLcVGY2RnIohvIXa9Xfk8tBr7nvdQ/kMLeI69I0amFWivwUHenXMiWJXklDVqGhmmN/H8Ms+8Qir746ruhryP8zxx3z+hhN69BrLCmjCz6Rnwdzg==
Received: from SA0PR11CA0188.namprd11.prod.outlook.com (2603:10b6:806:1bc::13)
 by SA0PR12MB7477.namprd12.prod.outlook.com (2603:10b6:806:24b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 10:28:08 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::d3) by SA0PR11CA0188.outlook.office365.com
 (2603:10b6:806:1bc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Thu, 19 Oct 2023 10:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 10:28:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 03:27:52 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 03:27:50 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 06/11] mlxsw: core, pci: Add plumbing related to LAG mode
Date: Thu, 19 Oct 2023 12:27:15 +0200
Message-ID: <157dc5c3ed8e942083e4094577f3bc6db2512f23.1697710282.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697710282.git.petrm@nvidia.com>
References: <cover.1697710282.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SA0PR12MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: ba26b110-a5d4-4181-e46c-08dbd08e163f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gd5DbT+54FJf4XSpOCt1nmNCEJ7h8v1UDzXlp3bLT1Ciy+wXjp9WTm6nkqNhORtO45LEyRTb82KCDSpUvwrj7YnS0PR94uaEyhOSB9PAVDZvN7OYPwVO2Y4o943DKkiS+LQWh6uEsjJf1Js+n7GcGDmiWclFWPY/GP/xI8cKr9qqhQlSj2dNuTHk3D6C69AKkTW01vdbylsQwuDbltMF2Qd5Kqb6q4+Z+75imUZ75egID92lJbUtnvdpBe1oU0qhPH3awJBuB/W4KJd6sYOrgSZxHZ/6iR77BB8kzdjvW0B8INtPB/2Yq2SImjets6w9i0+kG2e8958rCTTsf24ebRqefUzIEuvOuaaSKCmk8F7MgYB8lsSaK3ON9hBh1R3nMykzvZNRFFjn6/J+apsKUMybgiQ9aLmSbdDYZCz9tnV52aXROPwPThwHOaQUTiyildeoY9yuBU87Zi4Gw3to0VqwH4Jk5C9NGTiD/WpIWK6dBe9e+uHkW1ZgRqlbv1+sMZBDv3kKdWnK/ueSHxgkjiO9ZsnjL1/wonVYv7SRIQhKUd2TCF34ojWv8BnaFzNrw+HMdj6aZgKtRS61CoJxgzAmVCr7VeeBkXIZMap6oLjcTtssl1HQY4qLdA3+yw946ReHcG8xKbL5l+nNtOWUu6Z0DYFBiKvvfxUTiBBsohgUx5Zn8zuxvae6etBByLs/6wo1JD2dPfkgQStucnO1steR5SzpGUvCevIWJ/sB9mk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(86362001)(47076005)(7696005)(36756003)(41300700001)(5660300002)(4326008)(2906002)(83380400001)(82740400003)(40480700001)(26005)(16526019)(7636003)(336012)(426003)(356005)(36860700001)(107886003)(2616005)(6666004)(8676002)(478600001)(8936002)(110136005)(70206006)(70586007)(316002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:28:07.8870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba26b110-a5d4-4181-e46c-08dbd08e163f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7477

lag_mode describes where the responsibility for LAG table placement lies:
SW or FW. The bus module determines whether LAG is supported, can configure
it if it is, and knows what (if any) configuration has been applied.
Therefore add a bus callback to determine the configured LAG mode. Also add
to core an API to query it.

The LAG mode is for now kept at the default value of 0 for FW-managed. The
code to actually toggle it will be added later.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c |  7 +++++++
 drivers/net/ethernet/mellanox/mlxsw/core.h |  3 +++
 drivers/net/ethernet/mellanox/mlxsw/pci.c  | 14 ++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 1ccf3b73ed72..67032b93fba9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -204,6 +204,13 @@ int mlxsw_core_max_lag(struct mlxsw_core *mlxsw_core, u16 *p_max_lag)
 }
 EXPORT_SYMBOL(mlxsw_core_max_lag);
 
+enum mlxsw_cmd_mbox_config_profile_lag_mode
+mlxsw_core_lag_mode(struct mlxsw_core *mlxsw_core)
+{
+	return mlxsw_core->bus->lag_mode(mlxsw_core->bus_priv);
+}
+EXPORT_SYMBOL(mlxsw_core_lag_mode);
+
 void *mlxsw_core_driver_priv(struct mlxsw_core *mlxsw_core)
 {
 	return mlxsw_core->driver_priv;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.h b/drivers/net/ethernet/mellanox/mlxsw/core.h
index c6bc5819ce43..5692f34b2a63 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -36,6 +36,8 @@ struct mlxsw_fw_rev;
 unsigned int mlxsw_core_max_ports(const struct mlxsw_core *mlxsw_core);
 
 int mlxsw_core_max_lag(struct mlxsw_core *mlxsw_core, u16 *p_max_lag);
+enum mlxsw_cmd_mbox_config_profile_lag_mode
+mlxsw_core_lag_mode(struct mlxsw_core *mlxsw_core);
 
 void *mlxsw_core_driver_priv(struct mlxsw_core *mlxsw_core);
 
@@ -485,6 +487,7 @@ struct mlxsw_bus {
 	u32 (*read_frc_l)(void *bus_priv);
 	u32 (*read_utc_sec)(void *bus_priv);
 	u32 (*read_utc_nsec)(void *bus_priv);
+	enum mlxsw_cmd_mbox_config_profile_lag_mode (*lag_mode)(void *bus_priv);
 	u8 features;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 8de953902918..3e8347585e42 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -105,6 +105,8 @@ struct mlxsw_pci {
 	u64 free_running_clock_offset;
 	u64 utc_sec_offset;
 	u64 utc_nsec_offset;
+	bool lag_mode_support;
+	enum mlxsw_cmd_mbox_config_profile_lag_mode lag_mode;
 	struct mlxsw_pci_queue_type_group queues[MLXSW_PCI_QUEUE_TYPE_COUNT];
 	u32 doorbell_offset;
 	struct mlxsw_core *core;
@@ -1313,6 +1315,7 @@ static int mlxsw_pci_config_profile(struct mlxsw_pci *mlxsw_pci, char *mbox,
 					profile->cqe_time_stamp_type);
 	}
 
+	mlxsw_pci->lag_mode = MLXSW_CMD_MBOX_CONFIG_PROFILE_LAG_MODE_FW;
 	return mlxsw_cmd_config_profile_set(mlxsw_pci->core, mbox);
 }
 
@@ -1640,6 +1643,8 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 	mlxsw_pci->utc_nsec_offset =
 		mlxsw_cmd_mbox_query_fw_utc_nsec_offset_get(mbox);
 
+	mlxsw_pci->lag_mode_support =
+		mlxsw_cmd_mbox_query_fw_lag_mode_support_get(mbox);
 	num_pages = mlxsw_cmd_mbox_query_fw_fw_pages_get(mbox);
 	err = mlxsw_pci_fw_area_init(mlxsw_pci, mbox, num_pages);
 	if (err)
@@ -1949,6 +1954,14 @@ static u32 mlxsw_pci_read_utc_nsec(void *bus_priv)
 	return mlxsw_pci_read32_off(mlxsw_pci, mlxsw_pci->utc_nsec_offset);
 }
 
+static enum mlxsw_cmd_mbox_config_profile_lag_mode
+mlxsw_pci_lag_mode(void *bus_priv)
+{
+	struct mlxsw_pci *mlxsw_pci = bus_priv;
+
+	return mlxsw_pci->lag_mode;
+}
+
 static const struct mlxsw_bus mlxsw_pci_bus = {
 	.kind			= "pci",
 	.init			= mlxsw_pci_init,
@@ -1960,6 +1973,7 @@ static const struct mlxsw_bus mlxsw_pci_bus = {
 	.read_frc_l		= mlxsw_pci_read_frc_l,
 	.read_utc_sec		= mlxsw_pci_read_utc_sec,
 	.read_utc_nsec		= mlxsw_pci_read_utc_nsec,
+	.lag_mode		= mlxsw_pci_lag_mode,
 	.features		= MLXSW_BUS_F_TXRX | MLXSW_BUS_F_RESET,
 };
 
-- 
2.41.0


