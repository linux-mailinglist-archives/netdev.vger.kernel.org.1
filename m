Return-Path: <netdev+bounces-16898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3BB74F5FC
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E75D1C20FD1
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442F71DDE0;
	Tue, 11 Jul 2023 16:45:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDC51DDC2
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:45:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DA22695
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adrCAs0hue1vGo6xoV9WFu9Dnya+qid9F6vXcKNeRXvtRyU6GWj5v2mo4UAUe9fa+tjN7wRafFlowwIhshJ1vLs0N07NNEAAX+CknlkbZcdylcT5GW1b+AzgX2c16opkqikH6MNEvRmzqd6U8MX0kEg6v4dFWq52eGNyimbx1w54lMByonra14R5dX3Ko50/w5frpEO9WndL3f2hICfnYaCCcjU0KEM8DDB4m+gxHhjd9TU3QwnYk6YVGYp3MEQglDVYrbWcX5H/n2YQG/+EKsnmn4Vrjr/CDF3LY0SxuDjO1roy1tJaE7/b7aynSLuvx8NoplIG3rLCt7rhFKxK4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAYdKUu6kQXbmTjr0N/3jHv3tZu4g3Q5Gx05IxIxiZI=;
 b=kVj2NGDsi0Hwg2Fndymjuw1/NDswIs10wyNmjOEKCkuPGjxKYlCumkYjAF0gujuEgT2XA9ur9yDciPB51LhIoqH9r+ePl9vu7PzfLEHK7ZFsVgt7tH+HoZTXW6UIkTdXPDP949/PzXcnoVboFKMhHhAmv0WaMZvBy2X2B6BipaZ4F4v9U+YIid2tKEFgQCdTnMY2qwZ6WgAO8e2GLd4KlisIcW3EBImTgdYltaHl+4pH8NPNe2yCCQDWFpS8bVeCze5LrHY7JhiTayLV7KS9sNiGaZ+z7/0e9QnaqxfjZ2NyZyxX5cAiI4Q1zNFkCOA3/dh3BCTzi0vtm3C8zS9rhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAYdKUu6kQXbmTjr0N/3jHv3tZu4g3Q5Gx05IxIxiZI=;
 b=ldqOsjmEB7k91eJvF53t/BQ0uH252mlw2KXfVKJQ3UEZOHgKrpZjAcp1R4nwgr0Pw3g6crHhp8hnurDj+zAul6FB+uNPGlHZAlw7Oru5sQ4bvXPTyTfBGICFGjO72IYLKLORJzm9OTn3zfKGaJ7w8LECMjfYrAiF8FNPz/3v0TQ4Hby79VmVxvhoVVZv4imLimSD8J6hHLoOnfhdDIPP/f1rFds/g5Oa0RuQScv/K6Lc5yGbHpTyAXhjp6OhDu/omh5btGsinydATDg4kp2Z6p8ejY9Qdy7ByXMqFDH8qMRdPM1qI1yBBO7M7hBJGC1kVGUGBFsmXdjNNWvfxaICFw==
Received: from MW4PR04CA0059.namprd04.prod.outlook.com (2603:10b6:303:6a::34)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 16:44:42 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::1b) by MW4PR04CA0059.outlook.office365.com
 (2603:10b6:303:6a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Tue, 11 Jul 2023 16:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 16:44:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Jul 2023
 09:44:33 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Jul
 2023 09:44:30 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 03/10] mlxsw: spectrum_port_range: Add port range core
Date: Tue, 11 Jul 2023 18:43:56 +0200
Message-ID: <674f00539a0072d455847663b5feb504db51a259.1689092769.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689092769.git.petrm@nvidia.com>
References: <cover.1689092769.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0d0790-1ab4-4c11-3d48-08db822e2078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YYWjPpYqykfxiGcgnY9s7tOSHJHhVYIIRHWB0I0RE955QjWQ5QHSic9Uo8J6KWpbeIg0ZjbtYI8nF+Jk8h/8QL+IxAqGJuFtU3P8ilSqFH0Cb+uOx7tweVkEdtrsJqadyI6/y0O4WMeTdhmjR3ghdVG67FreX3eXKXKDe7Np1AzWLXsvdZ32Le9sMONzzCmPogvlUSzT4YwGvPIy9Ndp0+xxl6pdbOdajHQe+jelL6FLXIRT9NTh1RhKRgfmveQb/VeE58vT+6GAWzbPWA2GS2wMEXPKk+JxENzGp7fO+9+Ic1gExPWfeEYu6T8sQw/p0Do474T6/t6Y4apb93BLjEzCecn9J7j1oXvqVPdjJ9c99keNwwt+YUDGvvKJBhgsAECxn8oMR6OZQMsu9NnTLFTaOWsgQ+u7voL2+2Hv7n7W3bstihuNZq6LEBv4fVSYYnJY80Inyx9BdT3+8heceE8iWXRbFUsnfpDnFMSH+fEAULyCCfQ4jMtSLXMuMn7HCoVw2j/oRAEWxnWbos+/Gml9QPV6pjDNyNdYUeSUgj4vZ3OrdCc+4UrvHQqphXuG5cdO3lkZ+Cp+KhbQ5Nx7x2uhg6xzZVUePtr3fNMZJnT8BjRyAd0cyexeo420aIKordt1TqoYITB5D9SzK8cYrrqzg6f2aYattlzdhpJ7SnNRWLDC5mvQGp8a/EF04vllhYAjVm9zLnt0Zsu2XPYL0TY8OdLNFVu5+vF1gtd1aKsE/srR3onK/8A90zzE5/Is
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(4326008)(70586007)(70206006)(316002)(41300700001)(30864003)(2906002)(478600001)(8936002)(8676002)(5660300002)(110136005)(54906003)(36860700001)(40460700003)(6666004)(107886003)(40480700001)(26005)(336012)(186003)(36756003)(83380400001)(66574015)(426003)(47076005)(16526019)(7636003)(356005)(82740400003)(2616005)(82310400005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:44:42.6977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0d0790-1ab4-4c11-3d48-08db822e2078
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

The Spectrum ASICs have a fixed number of port range registers, each of
which maintains the following parameters:

* Minimum and maximum port.
* Apply port range for source port, destination port or both.
* Apply port range for TCP, UDP or both.
* Apply port range for IPv4, IPv6 or both.

Implement a port range core which takes care of the allocation and
configuration of these registers and exposes an API that allows
in-driver consumers (e.g., the ACL code) to request matching on a range
of either source or destination port.

These registers are going to be used for port range matching in the
flower classifier that already matches on EtherType being IPv4 / IPv6 and
IP protocol being TCP / UDP. As such, there is no need to limit these
registers to a specific EtherType or IP protocol, which will increase
the likelihood of a register being shared by multiple flower filters.

It is unlikely that a filter will match on the same range of both source
and destination ports, which is why each register is only configured to
match on either source or destination port. If a filter requires
matching on a range of both source and destination ports, it will
utilize two port range registers and match on the output of both.

For efficient lookup and traversal, use XArray to store the allocated
port range registers. The XArray uses RCU and an internal spinlock to
synchronise access, so there is no need for a dedicate lock.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |   9 +
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  15 ++
 .../mellanox/mlxsw/spectrum_port_range.c      | 181 ++++++++++++++++++
 4 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlxsw/spectrum_port_range.c

diff --git a/drivers/net/ethernet/mellanox/mlxsw/Makefile b/drivers/net/ethernet/mellanox/mlxsw/Makefile
index 3ca9fce759ea..71cad6bb6e62 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/Makefile
+++ b/drivers/net/ethernet/mellanox/mlxsw/Makefile
@@ -29,7 +29,7 @@ mlxsw_spectrum-objs		:= spectrum.o spectrum_buffers.o \
 				   spectrum_nve.o spectrum_nve_vxlan.o \
 				   spectrum_dpipe.o spectrum_trap.o \
 				   spectrum_ethtool.o spectrum_policer.o \
-				   spectrum_pgt.o
+				   spectrum_pgt.o spectrum_port_range.o
 mlxsw_spectrum-$(CONFIG_MLXSW_SPECTRUM_DCB)	+= spectrum_dcb.o
 mlxsw_spectrum-$(CONFIG_PTP_1588_CLOCK)		+= spectrum_ptp.o
 obj-$(CONFIG_MLXSW_MINIMAL)	+= mlxsw_minimal.o
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 25a01dafde1b..c0edcc91f178 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3188,6 +3188,12 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 		goto err_nve_init;
 	}
 
+	err = mlxsw_sp_port_range_init(mlxsw_sp);
+	if (err) {
+		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize port ranges\n");
+		goto err_port_range_init;
+	}
+
 	err = mlxsw_sp_acl_init(mlxsw_sp);
 	if (err) {
 		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize ACL\n");
@@ -3280,6 +3286,8 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 err_router_init:
 	mlxsw_sp_acl_fini(mlxsw_sp);
 err_acl_init:
+	mlxsw_sp_port_range_fini(mlxsw_sp);
+err_port_range_init:
 	mlxsw_sp_nve_fini(mlxsw_sp);
 err_nve_init:
 	mlxsw_sp_ipv6_addr_ht_fini(mlxsw_sp);
@@ -3462,6 +3470,7 @@ static void mlxsw_sp_fini(struct mlxsw_core *mlxsw_core)
 	}
 	mlxsw_sp_router_fini(mlxsw_sp);
 	mlxsw_sp_acl_fini(mlxsw_sp);
+	mlxsw_sp_port_range_fini(mlxsw_sp);
 	mlxsw_sp_nve_fini(mlxsw_sp);
 	mlxsw_sp_ipv6_addr_ht_fini(mlxsw_sp);
 	mlxsw_sp_afa_fini(mlxsw_sp);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 231e364cbb7c..fe6c6e02a484 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -175,6 +175,7 @@ struct mlxsw_sp {
 	struct mlxsw_sp_acl *acl;
 	struct mlxsw_sp_fid_core *fid_core;
 	struct mlxsw_sp_policer_core *policer_core;
+	struct mlxsw_sp_port_range_core *pr_core;
 	struct mlxsw_sp_kvdl *kvdl;
 	struct mlxsw_sp_nve *nve;
 	struct notifier_block netdevice_nb;
@@ -1484,4 +1485,18 @@ int mlxsw_sp_pgt_entry_port_set(struct mlxsw_sp *mlxsw_sp, u16 mid,
 int mlxsw_sp_pgt_init(struct mlxsw_sp *mlxsw_sp);
 void mlxsw_sp_pgt_fini(struct mlxsw_sp *mlxsw_sp);
 
+/* spectrum_port_range.c */
+struct mlxsw_sp_port_range {
+	u16 min;
+	u16 max;
+	u8 source:1;	/* Source or destination */
+};
+
+int mlxsw_sp_port_range_reg_get(struct mlxsw_sp *mlxsw_sp,
+				const struct mlxsw_sp_port_range *range,
+				struct netlink_ext_ack *extack,
+				u8 *p_prr_index);
+void mlxsw_sp_port_range_reg_put(struct mlxsw_sp *mlxsw_sp, u8 prr_index);
+int mlxsw_sp_port_range_init(struct mlxsw_sp *mlxsw_sp);
+void mlxsw_sp_port_range_fini(struct mlxsw_sp *mlxsw_sp);
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_port_range.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_port_range.c
new file mode 100644
index 000000000000..a12a62632721
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_port_range.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/bits.h>
+#include <linux/netlink.h>
+#include <linux/refcount.h>
+#include <linux/xarray.h>
+
+#include "spectrum.h"
+
+struct mlxsw_sp_port_range_reg {
+	struct mlxsw_sp_port_range range;
+	refcount_t refcount;
+	u32 index;
+};
+
+struct mlxsw_sp_port_range_core {
+	struct xarray prr_xa;
+	struct xa_limit prr_ids;
+};
+
+static int
+mlxsw_sp_port_range_reg_configure(struct mlxsw_sp *mlxsw_sp,
+				  const struct mlxsw_sp_port_range_reg *prr)
+{
+	char pprr_pl[MLXSW_REG_PPRR_LEN];
+
+	/* We do not care if packet is IPv4/IPv6 and TCP/UDP, so set all four
+	 * fields.
+	 */
+	mlxsw_reg_pprr_pack(pprr_pl, prr->index);
+	mlxsw_reg_pprr_ipv4_set(pprr_pl, true);
+	mlxsw_reg_pprr_ipv6_set(pprr_pl, true);
+	mlxsw_reg_pprr_src_set(pprr_pl, prr->range.source);
+	mlxsw_reg_pprr_dst_set(pprr_pl, !prr->range.source);
+	mlxsw_reg_pprr_tcp_set(pprr_pl, true);
+	mlxsw_reg_pprr_udp_set(pprr_pl, true);
+	mlxsw_reg_pprr_port_range_min_set(pprr_pl, prr->range.min);
+	mlxsw_reg_pprr_port_range_max_set(pprr_pl, prr->range.max);
+
+	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(pprr), pprr_pl);
+}
+
+static struct mlxsw_sp_port_range_reg *
+mlxsw_sp_port_range_reg_create(struct mlxsw_sp *mlxsw_sp,
+			       const struct mlxsw_sp_port_range *range,
+			       struct netlink_ext_ack *extack)
+{
+	struct mlxsw_sp_port_range_core *pr_core = mlxsw_sp->pr_core;
+	struct mlxsw_sp_port_range_reg *prr;
+	int err;
+
+	prr = kzalloc(sizeof(*prr), GFP_KERNEL);
+	if (!prr)
+		return ERR_PTR(-ENOMEM);
+
+	prr->range = *range;
+	refcount_set(&prr->refcount, 1);
+
+	err = xa_alloc(&pr_core->prr_xa, &prr->index, prr, pr_core->prr_ids,
+		       GFP_KERNEL);
+	if (err) {
+		if (err == -EBUSY)
+			NL_SET_ERR_MSG_MOD(extack, "Exceeded number of port range registers");
+		goto err_xa_alloc;
+	}
+
+	err = mlxsw_sp_port_range_reg_configure(mlxsw_sp, prr);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to configure port range register");
+		goto err_reg_configure;
+	}
+
+	return prr;
+
+err_reg_configure:
+	xa_erase(&pr_core->prr_xa, prr->index);
+err_xa_alloc:
+	kfree(prr);
+	return ERR_PTR(err);
+}
+
+static void mlxsw_sp_port_range_reg_destroy(struct mlxsw_sp *mlxsw_sp,
+					    struct mlxsw_sp_port_range_reg *prr)
+{
+	struct mlxsw_sp_port_range_core *pr_core = mlxsw_sp->pr_core;
+
+	xa_erase(&pr_core->prr_xa, prr->index);
+	kfree(prr);
+}
+
+static struct mlxsw_sp_port_range_reg *
+mlxsw_sp_port_range_reg_find(struct mlxsw_sp *mlxsw_sp,
+			     const struct mlxsw_sp_port_range *range)
+{
+	struct mlxsw_sp_port_range_core *pr_core = mlxsw_sp->pr_core;
+	struct mlxsw_sp_port_range_reg *prr;
+	unsigned long index;
+
+	xa_for_each(&pr_core->prr_xa, index, prr) {
+		if (prr->range.min == range->min &&
+		    prr->range.max == range->max &&
+		    prr->range.source == range->source)
+			return prr;
+	}
+
+	return NULL;
+}
+
+int mlxsw_sp_port_range_reg_get(struct mlxsw_sp *mlxsw_sp,
+				const struct mlxsw_sp_port_range *range,
+				struct netlink_ext_ack *extack,
+				u8 *p_prr_index)
+{
+	struct mlxsw_sp_port_range_reg *prr;
+
+	prr = mlxsw_sp_port_range_reg_find(mlxsw_sp, range);
+	if (prr) {
+		refcount_inc(&prr->refcount);
+		*p_prr_index = prr->index;
+		return 0;
+	}
+
+	prr = mlxsw_sp_port_range_reg_create(mlxsw_sp, range, extack);
+	if (IS_ERR(prr))
+		return PTR_ERR(prr);
+
+	*p_prr_index = prr->index;
+
+	return 0;
+}
+
+void mlxsw_sp_port_range_reg_put(struct mlxsw_sp *mlxsw_sp, u8 prr_index)
+{
+	struct mlxsw_sp_port_range_core *pr_core = mlxsw_sp->pr_core;
+	struct mlxsw_sp_port_range_reg *prr;
+
+	prr = xa_load(&pr_core->prr_xa, prr_index);
+	if (WARN_ON(!prr))
+		return;
+
+	if (!refcount_dec_and_test(&prr->refcount))
+		return;
+
+	mlxsw_sp_port_range_reg_destroy(mlxsw_sp, prr);
+}
+
+int mlxsw_sp_port_range_init(struct mlxsw_sp *mlxsw_sp)
+{
+	struct mlxsw_sp_port_range_core *pr_core;
+	struct mlxsw_core *core = mlxsw_sp->core;
+	u64 max;
+
+	if (!MLXSW_CORE_RES_VALID(core, ACL_MAX_L4_PORT_RANGE))
+		return -EIO;
+	max = MLXSW_CORE_RES_GET(core, ACL_MAX_L4_PORT_RANGE);
+
+	/* Each port range register is represented using a single bit in the
+	 * two bytes "l4_port_range" ACL key element.
+	 */
+	WARN_ON(max > BITS_PER_BYTE * sizeof(u16));
+
+	pr_core = kzalloc(sizeof(*mlxsw_sp->pr_core), GFP_KERNEL);
+	if (!pr_core)
+		return -ENOMEM;
+	mlxsw_sp->pr_core = pr_core;
+
+	pr_core->prr_ids.max = max - 1;
+	xa_init_flags(&pr_core->prr_xa, XA_FLAGS_ALLOC);
+
+	return 0;
+}
+
+void mlxsw_sp_port_range_fini(struct mlxsw_sp *mlxsw_sp)
+{
+	struct mlxsw_sp_port_range_core *pr_core = mlxsw_sp->pr_core;
+
+	WARN_ON(!xa_empty(&pr_core->prr_xa));
+	xa_destroy(&pr_core->prr_xa);
+	kfree(pr_core);
+}
-- 
2.40.1


