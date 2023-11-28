Return-Path: <netdev+bounces-51748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098B77FBE91
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2AE1C20CF1
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F231E4B6;
	Tue, 28 Nov 2023 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NdPZ3lwH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD9710DF
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:52:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVW3Bwf8ypuX5AtomK7gBk2MaoqppOh+FCgvd1cO1Ed9bEMIWPFkc0n/07EmxO84cKEJMsYSTr0+VYxgG9FXRzW0dTlRPu5rVdrA3g+dpwgy1PowOY0BWOMQO7p8kJ8dZrM3LYjc+HUrvYfBTl175qsCCoFg7d0wcxv4odehLUI08ws9Oq+kXW6LELnQFqF5zt8X3yPPA2sCuP3vMq0uddwOJ39OqKj8Ug7e0rLAjSu6RyaWkof5/WliZ14GD4i1uqsoF9S5VnCSglnyNnmR859kcRK5JtoAZlQgqKPGpjnHErFYjrhNRHNDH2y2tYs7mglklOodF9xJPgtmCpECnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCQPUcenD5ifWatDwRv8G9vki1Xb4Kr4/fxaff0wNio=;
 b=mXzQWjL4bhOtdpRPBZlHTeL6enD6scB5xL3lde93CHkIm49m6bN8SerzS4CEn+IRMclQsL6N8GIOlIfDu0zLVOrsCEq4sKur6aLYAcOnZ3Js8lxGqsz3HzVJQbuZt3pGPOD/RC+9it52W+ae3jA7lPxWoGzQtDnKALbkaNyH3UzMlrS8F2L6YFRdozRyUPLiQDjFgqx4WyD2huMjMrE/pOxuBd43kbzMgSrqRGc2mJ2z8CTWjYudnZDDqJI72CZtqjWydc9MCgVrs2MMltWWmF588WMa9/rhXK8ng2tmsBQOaKjAuLkbocafmzi35JcODAp6pbyQKVSbHRq1pA9t7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCQPUcenD5ifWatDwRv8G9vki1Xb4Kr4/fxaff0wNio=;
 b=NdPZ3lwHb8CIqRVl7TwoTl3pKzyLw3Tdvq91nv19/Xt5JIY4d+rPMoM39h4Wn4j7h/4rxjFdixYBnxZwgzZ8rNBvELV3yWyBYwrkaYA+glQTtDjQs21VcPwrXHtTtPkVn6pyGAWGu8P2p7r5znb9IEilK+/d7vb1tFbPxroWMMS6CV4tgdRx6rR6E4DzFlR1M47Esk5febnlK31v4GJ1vPvJBI0QRKTyZQLlpYjB+G0CiicbD1T/tiKPXABO18SWowPXBpAFHehXGDCzDEm+/rigGmG4vBC+qD0G07nCcqqg/CuAqanSFSjeaAkARKrNje2d3XYtnkhLG01cJBKCJQ==
Received: from CYXPR02CA0021.namprd02.prod.outlook.com (2603:10b6:930:cf::9)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 15:51:57 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::2a) by CYXPR02CA0021.outlook.office365.com
 (2603:10b6:930:cf::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:49 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:46 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 16/17] mlxsw: spectrum_fid: Add support for rFID family in CFF flood mode
Date: Tue, 28 Nov 2023 16:50:49 +0100
Message-ID: <962deb4367585d38250e80c685a34735c0c7f3ad.1701183892.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701183891.git.petrm@nvidia.com>
References: <cover.1701183891.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 501adffc-6c96-45b1-f589-08dbf029f3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UK5QJOPy9T50+KCz2gFM1FcOpcBbaAZ0RVnp0N69BYMZd8pDfa5R3s9n1iB9/5eHnoepa3axVjGeu/22Q6juzPrfO9yrw4K0RHzhCdN0aHHt/hXdMiRb72YzNwwIEovL5dUYi5lMX2i/IlxgKUX8lCdvAcV1q/yxQovrg4ueczzpTcVn/+NNbGwuw5h9xdSjVeoP0EknNGXVTTgv0SHaAnfI98dHI1pVJeErnZvdnwCoP6zLBGDzUls4QjRlsWgHpWnnxllLagbWtdNbPpvx9anjVSjarV90aWCbV3YMUk7NIgR/xdujEvn0+I7/nFUjJTvENc5n+Fq60ncfXeNf8bwu0B/VO2Rhc4ZIHAdaMx2U+sUObaVCyarZv1IcCa8ow1ptG4LpmeuLyJmhdjbmeW275r8ysAYODoEUc2NOs+RKRwgcCJ7VZCm+Zykhj0DphEurMWQu4Gm6Ji78isowRrwZUNGbkbmxGp1gpH73/IKfwXjX91YtiekZcdKyMrjifhocK6SamwhDByuD2IKk6wmBb4yYd/Grgy7wWpCofUDXEQeodNO+vZDZ/iWx+CPgiCqVezmSeJ21PRa6OWHYok0SnD7Bg9LOa0WYV0vo28FHqsZz0fnswLx/c2oxiGnUOQpg1vPImVhRobB6BKiEX+sMsqEg+wYGALAzRjdTz6wiDfMGNJuMDuEZY+SfUUC3oPPU597nOa3QHtON6W+nAiwKP3t8Uurv6RR/OWJWHqZXI07EPCQQx+xfG/QVBj/p
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(46966006)(36840700001)(40470700004)(41300700001)(36756003)(7636003)(47076005)(356005)(30864003)(336012)(83380400001)(426003)(82740400003)(5660300002)(70206006)(66574015)(16526019)(2906002)(26005)(36860700001)(86362001)(107886003)(2616005)(70586007)(8676002)(8936002)(4326008)(478600001)(40460700003)(40480700001)(110136005)(316002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:57.4290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 501adffc-6c96-45b1-f589-08dbf029f3a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456

In this patch, add the artifacts for the rFID family that works in CFF
flood mode.

The same that was said about PGT organization and lookup in bridge FID
families applies for the rFID family as well. The main difference lies in
the fact that in the controlled flood mode, the FW was taking care of
maintaining the PGT tables for rFIDs. In CFF mode, the responsibility
shifts to the driver.

All rFIDs are based off either a front panel port, or a LAG port. For those
based off ports, we need to maintain at worst one PGT block for each port,
for those based off LAGs, one PGT block per LAG. This reflects in the
pgt_size callback, which determines the PGT footprint based on number of
ports and the LAG capacity.

A number of FIDs may end up using the same PGT base. Unlike with bridges,
where membership of a port in a given FID is highly dynamic, an rFID based
of a port will just always need to flood to that port.

Both the port and the LAG subtables need to be actively maintained. To that
end, the CFF rFID family implements fid_port_init and fid_port_fini
callbacks, which toggle the necessary bits.

Both FID-MID translation and SFMR packing then point into either the port
or the LAG subtable, to the block that corresponds to a given port or a
given LAG, depending on what port the RIF bound to the rFID uses.

As in the previous patch, the way CFF flood mode organizes PGT accesses
allows for much more smarts and dynamism. As in the previous patch, we
rather aim to keep things simple and static.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 231 ++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index 696a7ed30709..401117086235 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -11,6 +11,7 @@
 #include <linux/refcount.h>
 
 #include "spectrum.h"
+#include "spectrum_router.h"
 #include "reg.h"
 
 struct mlxsw_sp_fid_family;
@@ -115,6 +116,7 @@ struct mlxsw_sp_fid_ops {
 
 enum mlxsw_sp_fid_flood_profile_id {
 	MLXSW_SP_FID_FLOOD_PROFILE_ID_BRIDGE = 1,
+	MLXSW_SP_FID_FLOOD_PROFILE_ID_RSP,
 };
 
 struct mlxsw_sp_fid_flood_profile {
@@ -368,6 +370,36 @@ mlxsw_sp_fid_8021d_pgt_size(const struct mlxsw_sp_fid_family *fid_family,
 	return 0;
 }
 
+static unsigned int mlxsw_sp_fid_rfid_port_offset_cff(unsigned int local_port)
+{
+	/* Port 0 is the CPU port. Since we never create RIFs based off that
+	 * port, we don't need to count it.
+	 */
+	return WARN_ON_ONCE(!local_port) ? 0 : local_port - 1;
+}
+
+static int
+mlxsw_sp_fid_rfid_pgt_size_cff(const struct mlxsw_sp_fid_family *fid_family,
+			       u16 *p_pgt_size)
+{
+	struct mlxsw_core *core = fid_family->mlxsw_sp->core;
+	unsigned int max_ports;
+	u16 pgt_size;
+	u16 max_lags;
+	int err;
+
+	max_ports = mlxsw_core_max_ports(core);
+
+	err = mlxsw_core_max_lag(core, &max_lags);
+	if (err)
+		return err;
+
+	pgt_size = (mlxsw_sp_fid_rfid_port_offset_cff(max_ports) + max_lags) *
+		   fid_family->flood_profile->nr_flood_tables;
+	*p_pgt_size = pgt_size;
+	return 0;
+}
+
 static u16
 mlxsw_sp_fid_pgt_base_ctl(const struct mlxsw_sp_fid_family *fid_family,
 			  const struct mlxsw_sp_flood_table *flood_table)
@@ -519,6 +551,18 @@ static void mlxsw_sp_fid_fid_pack_cff(char *sfmr_pl,
 				      fid_family->flood_profile->profile_id);
 }
 
+static u16 mlxsw_sp_fid_rfid_fid_offset_cff(struct mlxsw_sp *mlxsw_sp,
+					    u16 port_lag_id, bool is_lag)
+{
+	u16 max_ports = mlxsw_core_max_ports(mlxsw_sp->core);
+
+	if (is_lag)
+		return mlxsw_sp_fid_rfid_port_offset_cff(max_ports) +
+		       port_lag_id;
+	else
+		return mlxsw_sp_fid_rfid_port_offset_cff(port_lag_id);
+}
+
 static int mlxsw_sp_fid_op(const struct mlxsw_sp_fid *fid, bool valid)
 {
 	struct mlxsw_sp *mlxsw_sp = fid->fid_family->mlxsw_sp;
@@ -1248,6 +1292,24 @@ struct mlxsw_sp_fid_flood_profile mlxsw_sp_fid_8021d_flood_profile = {
 	.profile_id		= MLXSW_SP_FID_FLOOD_PROFILE_ID_BRIDGE,
 };
 
+static const struct mlxsw_sp_flood_table mlxsw_sp_fid_rsp_flood_tables_cff[] = {
+	{
+		.packet_type	= MLXSW_SP_FLOOD_TYPE_UC,
+		.table_index	= 0,
+	},
+	{
+		.packet_type	= MLXSW_SP_FLOOD_TYPE_NOT_UC,
+		.table_index	= 1,
+	},
+};
+
+static const
+struct mlxsw_sp_fid_flood_profile mlxsw_sp_fid_rsp_flood_profile_cff = {
+	.flood_tables		= mlxsw_sp_fid_rsp_flood_tables_cff,
+	.nr_flood_tables	= ARRAY_SIZE(mlxsw_sp_fid_rsp_flood_tables_cff),
+	.profile_id		= MLXSW_SP_FID_FLOOD_PROFILE_ID_RSP,
+};
+
 static bool
 mlxsw_sp_fid_8021q_compare(const struct mlxsw_sp_fid *fid, const void *arg)
 {
@@ -1271,6 +1333,29 @@ static int mlxsw_sp_fid_rfid_setup_ctl(struct mlxsw_sp_fid *fid,
 	return 0;
 }
 
+static int mlxsw_sp_fid_rfid_setup_cff(struct mlxsw_sp_fid *fid,
+				       const void *arg)
+{
+	struct mlxsw_sp *mlxsw_sp = fid->fid_family->mlxsw_sp;
+	u16 rif_index = *(const u16 *)arg;
+	struct mlxsw_sp_rif *rif;
+	bool is_lag;
+	u16 port;
+	int err;
+
+	rif = mlxsw_sp_rif_by_index(mlxsw_sp, rif_index);
+	if (!rif)
+		return -ENOENT;
+
+	err = mlxsw_sp_rif_subport_port(rif, &port, &is_lag);
+	if (err)
+		return err;
+
+	fid->fid_offset = mlxsw_sp_fid_rfid_fid_offset_cff(mlxsw_sp, port,
+							   is_lag);
+	return 0;
+}
+
 static int mlxsw_sp_fid_rfid_configure(struct mlxsw_sp_fid *fid)
 {
 	return mlxsw_sp_fid_op(fid, true);
@@ -1410,6 +1495,139 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_rfid_ops_ctl = {
 	.fid_pack		= mlxsw_sp_fid_pack_ctl,
 };
 
+static int
+mlxsw_sp_fid_rfid_port_add_cff(struct mlxsw_sp *mlxsw_sp,
+			       const struct mlxsw_sp_flood_table *flood_table,
+			       u16 pgt_addr, u16 smpe, unsigned int local_port)
+{
+	int err;
+
+	err = mlxsw_sp_pgt_entry_port_set(mlxsw_sp, pgt_addr, smpe,
+					  local_port, true);
+	if (err)
+		return err;
+
+	if (flood_table->packet_type == MLXSW_SP_FLOOD_TYPE_NOT_UC) {
+		u16 router_port = mlxsw_sp_router_port(mlxsw_sp);
+
+		err = mlxsw_sp_pgt_entry_port_set(mlxsw_sp, pgt_addr, smpe,
+						  router_port, true);
+		if (err)
+			goto err_entry_port_set;
+	}
+
+	return 0;
+
+err_entry_port_set:
+	mlxsw_sp_pgt_entry_port_set(mlxsw_sp, pgt_addr, smpe, local_port,
+				    false);
+	return err;
+}
+
+static void
+mlxsw_sp_fid_rfid_port_del_cff(struct mlxsw_sp *mlxsw_sp,
+			       const struct mlxsw_sp_flood_table *flood_table,
+			       u16 pgt_addr, u16 smpe, u16 local_port)
+{
+	if (flood_table->packet_type == MLXSW_SP_FLOOD_TYPE_NOT_UC) {
+		u16 router_port = mlxsw_sp_router_port(mlxsw_sp);
+
+		mlxsw_sp_pgt_entry_port_set(mlxsw_sp, pgt_addr, smpe,
+					    router_port, false);
+	}
+	mlxsw_sp_pgt_entry_port_set(mlxsw_sp, pgt_addr, smpe, local_port,
+				    false);
+}
+
+static int
+mlxsw_sp_fid_rfid_port_memb_ft_cff(const struct mlxsw_sp_fid_family *fid_family,
+				   const struct mlxsw_sp_flood_table *flood_table,
+				   const struct mlxsw_sp_port *mlxsw_sp_port,
+				   bool member)
+{
+	struct mlxsw_sp *mlxsw_sp = fid_family->mlxsw_sp;
+	u16 local_port = mlxsw_sp_port->local_port;
+	u16 fid_pgt_base;
+	u16 fid_offset;
+	u16 pgt_addr;
+	u16 smpe;
+	u16 port;
+
+	/* In-PGT SMPE is only valid on Spectrum-1, CFF only on Spectrum>1. */
+	smpe = 0;
+
+	port = mlxsw_sp_port->lagged ? mlxsw_sp_port->lag_id : local_port;
+	fid_offset = mlxsw_sp_fid_rfid_fid_offset_cff(mlxsw_sp, port,
+						      mlxsw_sp_port->lagged);
+	fid_pgt_base = mlxsw_sp_fid_off_pgt_base_cff(fid_family, fid_offset);
+	pgt_addr = fid_pgt_base + flood_table->table_index;
+
+	if (member)
+		return mlxsw_sp_fid_rfid_port_add_cff(mlxsw_sp, flood_table,
+						      pgt_addr, smpe,
+						      local_port);
+
+	mlxsw_sp_fid_rfid_port_del_cff(mlxsw_sp, flood_table, pgt_addr, smpe,
+				       local_port);
+	return 0;
+}
+
+static int
+mlxsw_sp_fid_rfid_port_memb_cff(const struct mlxsw_sp_fid_family *fid_family,
+				const struct mlxsw_sp_port *mlxsw_sp_port,
+				bool member)
+{
+	int i;
+
+	for (i = 0; i < fid_family->flood_profile->nr_flood_tables; i++) {
+		const struct mlxsw_sp_flood_table *flood_table =
+			&fid_family->flood_profile->flood_tables[i];
+		int err;
+
+		err = mlxsw_sp_fid_rfid_port_memb_ft_cff(fid_family,
+							 flood_table,
+							 mlxsw_sp_port, member);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int
+mlxsw_sp_fid_rfid_port_init_cff(const struct mlxsw_sp_fid_family *fid_family,
+				const struct mlxsw_sp_port *mlxsw_sp_port)
+{
+	return mlxsw_sp_fid_rfid_port_memb_cff(fid_family, mlxsw_sp_port, true);
+}
+
+static void
+mlxsw_sp_fid_rfid_port_fini_cff(const struct mlxsw_sp_fid_family *fid_family,
+				const struct mlxsw_sp_port *mlxsw_sp_port)
+{
+	mlxsw_sp_fid_rfid_port_memb_cff(fid_family, mlxsw_sp_port, false);
+}
+
+static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_rfid_ops_cff = {
+	.setup			= mlxsw_sp_fid_rfid_setup_cff,
+	.configure		= mlxsw_sp_fid_rfid_configure,
+	.deconfigure		= mlxsw_sp_fid_rfid_deconfigure,
+	.index_alloc		= mlxsw_sp_fid_rfid_index_alloc,
+	.compare		= mlxsw_sp_fid_rfid_compare,
+	.port_vid_map		= mlxsw_sp_fid_rfid_port_vid_map,
+	.port_vid_unmap		= mlxsw_sp_fid_rfid_port_vid_unmap,
+	.vni_set		= mlxsw_sp_fid_rfid_vni_set,
+	.vni_clear		= mlxsw_sp_fid_rfid_vni_clear,
+	.nve_flood_index_set	= mlxsw_sp_fid_rfid_nve_flood_index_set,
+	.nve_flood_index_clear	= mlxsw_sp_fid_rfid_nve_flood_index_clear,
+	.vid_to_fid_rif_update	= mlxsw_sp_fid_rfid_vid_to_fid_rif_update,
+	.pgt_size		= mlxsw_sp_fid_rfid_pgt_size_cff,
+	.fid_port_init		= mlxsw_sp_fid_rfid_port_init_cff,
+	.fid_port_fini		= mlxsw_sp_fid_rfid_port_fini_cff,
+	.fid_mid		= mlxsw_sp_fid_fid_mid_cff,
+	.fid_pack		= mlxsw_sp_fid_fid_pack_cff,
+};
+
 static int mlxsw_sp_fid_dummy_setup(struct mlxsw_sp_fid *fid, const void *arg)
 {
 	fid->fid_offset = 0;
@@ -1726,10 +1944,22 @@ static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_8021d_family_cff = {
 	.smpe_index_valid	= true,
 };
 
+static const struct mlxsw_sp_fid_family mlxsw_sp_fid_rfid_family_cff = {
+	.type			= MLXSW_SP_FID_TYPE_RFID,
+	.fid_size		= sizeof(struct mlxsw_sp_fid),
+	.start_index		= MLXSW_SP_RFID_START,
+	.end_index		= MLXSW_SP_RFID_END,
+	.flood_profile		= &mlxsw_sp_fid_rsp_flood_profile_cff,
+	.rif_type		= MLXSW_SP_RIF_TYPE_SUBPORT,
+	.ops			= &mlxsw_sp_fid_rfid_ops_cff,
+	.smpe_index_valid	= false,
+};
+
 static const struct mlxsw_sp_fid_family *mlxsw_sp2_fid_family_arr_cff[] = {
 	[MLXSW_SP_FID_TYPE_8021Q]	= &mlxsw_sp2_fid_8021q_family_cff,
 	[MLXSW_SP_FID_TYPE_8021D]	= &mlxsw_sp2_fid_8021d_family_cff,
 	[MLXSW_SP_FID_TYPE_DUMMY]	= &mlxsw_sp2_fid_dummy_family,
+	[MLXSW_SP_FID_TYPE_RFID]	= &mlxsw_sp_fid_rfid_family_cff,
 };
 
 static struct mlxsw_sp_fid *mlxsw_sp_fid_lookup(struct mlxsw_sp *mlxsw_sp,
@@ -2180,6 +2410,7 @@ mlxsw_sp2_fids_init_flood_profile(struct mlxsw_sp *mlxsw_sp,
 static const
 struct mlxsw_sp_fid_flood_profile *mlxsw_sp_fid_flood_profiles[] = {
 	&mlxsw_sp_fid_8021d_flood_profile,
+	&mlxsw_sp_fid_rsp_flood_profile_cff,
 };
 
 static int
-- 
2.41.0


