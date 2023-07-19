Return-Path: <netdev+bounces-18970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ACE7593D2
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950A21C20FDF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A75214AA8;
	Wed, 19 Jul 2023 11:02:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793AE14A92
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD7F19A
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKlnwjlEO0FYOR2LbW3fqOF0yXbx2J+h4eFUcj8cQGmyv2zy3liHN/qJ4BZYQtMF7wYO7Zr1n0Ww4KXEYVmL4nTwyJsulNxZcKR7Kt/VblsiVJahmUmamgtHEvBUKCkBHpwQFYkuL4jfygSowOKa7CFZBxEF/km8XaIk6wa1R//3n9r149jYm/SGYP+vhuLGaAjZtiZGLmqoDVudcJoQQxHWw1GOyYEI5GiqCI4YP9yf6UV9LdKpq+mlLIsmkUx/2V9gAbnwvzo/otCMV3Cny0Z3YFCjw53mYuLgYvhmS0kjIJvheoHEeG85IyQFRMMgBTP2pAsqXkCX5bu6n2atog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AKvmlslWDXzimHfINoD4lj32Ud0L0SOPbnVJuPFDco=;
 b=fXcTyGMNhKf3gv6Kp2rBWujO7OprEEkTffP/19FUpZ6zDNFKlneNGcf6Hkuj4Azpxmx81XSctW5QmdarwczECt2YR9joWt+aR+UmBI8bN0FA5M/KCtTcdmw3qyri2VV37q/lg0L/VsgOHX64p3WPh8/fGTvhYjkwFu2F47n8meCQU6y344PEaLDYwKoOixQK6+HDKBPZW7ZmPqaRPnXvkiHT0g3hHFn5FOx85sm7NFdSYu8hXS2hwN0+tOPf1dxciGoi3z5cRCc9XKs0WekTzDAeXFFJ+3Q1twJTTGmjNHY+yTi6lgIrTguU3xJgpl8CSgyCFyS7H1uzQvierAcycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AKvmlslWDXzimHfINoD4lj32Ud0L0SOPbnVJuPFDco=;
 b=eQtnNtnOtveM3cH9q/zhfgTyRGjzwicZ2ssiZNlKW0SgrZJ8CaP4Tt4Zpp+Pl3d9O0h3LkD4hGflDR7OBbQe8EXFhpClYhF5kBEDFDTCd8aeyBCYlh/pfyECYn+44Vfjhufp4tmKMuc/ItlHfWu/E9rn1slHaEp7H2ePHjTzl6vu1BYcovL7rIGPCPfioGXnfpJTlbLkn3ezF9Jd3/diAthvKMTGUec7TN26lw6SzDn3IUbeS4EUSnWmOo7UHjjqe5+VvYvDusHvGtda3d2QWsO0eUYl/TNTy4Qc/L+uxL8LvXetODTVxt6QM83YroS0o4tyYuqAwe7qjA6LkwqsFQ==
Received: from BN0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:408:ee::15)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 11:02:50 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::60) by BN0PR04CA0010.outlook.office365.com
 (2603:10b6:408:ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33 via Frontend Transport; Wed, 19 Jul 2023 11:02:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:33 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:30 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 13/17] mlxsw: spectrum_router: Replay MACVLANs when RIF is made
Date: Wed, 19 Jul 2023 13:01:28 +0200
Message-ID: <d0ecef7df1891ac790b12a3e96b43f301fccbdcf.1689763089.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689763088.git.petrm@nvidia.com>
References: <cover.1689763088.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8b7bc8-f276-4b35-7fd4-08db8847b161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ldkXwHmN9BfwECWhdogS4QxVmfCqwPRJuisDkVGNnKjHHi+1QkUMfLCeQ+rEdYvNP+YQO+Cjalx3aqh5zITncQkbj1coQz/HyomAzAKTqXeDnNFLL4IYr+XaflzFrhkTG57xEnzqs3nw8xu6NxKqeBLQpsaV4o1VU7ZgaWBV7tR45vFRXngEAGsDj+whTAxbaI94xZCcrhoLPkHPy2GqE5474vL7TZDDc8cfS2O6cGSr6CDm4ypES8J2TUVa9lct4S3s3yrUeu0KG4ibu6sYDqUvIN94D65k2a6j2ivQWBGzLTbndJU516EX6Pk1mWe/pvJj5wgTRKvWpvvZ4oWDH3oxnBc4hI5ueqNY2Wf0CD0iMDMj45bVqe/hLHmP/1Y9N8GayfCLddQmegy0Spxv0RivtYj8IKUT4JH/RHJoAlIy0pP1OwOlZaH7DcdqHBYFMD21md+3gJKwfILlOojpRHUTiyvQQDXFpjFdDL8hvTdCNFjkxd4eKYOSO/+TPftMrUJfBG9Wpnu8qiBgqKs91TCmemzaiOrntCa634Fnd0akM812jHi49Ke3+wglqhtWk7MxXNP6QJr6J4jmFJ6iUXIGYOGNhLhwV8guRX1Ht1UAGaUSYje3Wrdi88uqg/Py6VfedECOu+nfQnQz8AznQPSor6IGAXqvLbAG0nF7H34Vu8w8l9fjK2homSfTK0KaQYFYFnqOmbvdWbYd9s9rI9NSCJzYshW43MsB2O/ZKRHBUzhzjcSDVUWNKT2/dVdp
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(4326008)(54906003)(478600001)(110136005)(82740400003)(2616005)(36860700001)(83380400001)(426003)(47076005)(40460700003)(86362001)(66574015)(40480700001)(356005)(2906002)(70586007)(186003)(16526019)(107886003)(26005)(316002)(7636003)(336012)(70206006)(41300700001)(36756003)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:50.1038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8b7bc8-f276-4b35-7fd4-08db8847b161
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If IP address is added to a MACVLAN netdevice, the effect is of configuring
VRRP on the RIF for the netdevice linked to the MACVLAN. Because the
MACVLAN offload is tied to existence of a RIF at the linked netdevice,
adding a MACVLAN is currently not allowed until a RIF is present.

If this requirement stays, it will never be possible to attach a first port
into a topology that involves a MACVLAN. Thus topologies would need to be
built in a certain order, which is impractical.

Additionally, IP address removal, which leads to disappearance of the RIF
that the MACVLAN depends on, cannot be vetoed. Thus even as things stand
now it is possible to get to a state where a MACVLAN netdevice exists
without a RIF, despite having mlxsw lowers. And once the MACVLAN is
un-offloaded due to RIF getting destroyed, recreating the RIF does not
bring it back.

In this patch, accept that MACVLAN can be created out of order and support
that use case.

One option would seem to be to simply recognize MACVLAN netdevices as
"interesting", and let the existing replay mechanisms take care of the
offload. However, that does not address the necessity to reoffload MACVLAN
once a RIF is created.

Thus add a new replay hook, symmetrical to mlxsw_sp_rif_macvlan_flush(),
called mlxsw_sp_rif_macvlan_replay(), which instead of unwinding the
existing offloads, applies the configuration as if the netdevice were
created just now.

Additionally, remove all vetoes and warning messages that checked for
presence of a RIF at the linked device.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 22 -------
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 59 +++++++++++++++++--
 2 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 8087da00f38f..4346cc736579 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4786,11 +4786,6 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 			NL_SET_ERR_MSG_MOD(extack, "Can not put a VLAN on a LAG port");
 			return -EINVAL;
 		}
-		if (netif_is_macvlan(upper_dev) &&
-		    !mlxsw_sp_rif_exists(mlxsw_sp, lower_dev)) {
-			NL_SET_ERR_MSG_MOD(extack, "macvlan is only supported on top of router interfaces");
-			return -EOPNOTSUPP;
-		}
 		if (netif_is_ovs_master(upper_dev) && vlan_uses_dev(dev)) {
 			NL_SET_ERR_MSG_MOD(extack, "Master device is an OVS master and this device has a VLAN");
 			return -EINVAL;
@@ -4979,11 +4974,6 @@ static int mlxsw_sp_netdevice_port_vlan_event(struct net_device *vlan_dev,
 			NL_SET_ERR_MSG_MOD(extack, "Enslaving a port to a device that already has an upper device is not supported");
 			return -EINVAL;
 		}
-		if (netif_is_macvlan(upper_dev) &&
-		    !mlxsw_sp_rif_exists(mlxsw_sp, vlan_dev)) {
-			NL_SET_ERR_MSG_MOD(extack, "macvlan is only supported on top of router interfaces");
-			return -EOPNOTSUPP;
-		}
 		break;
 	case NETDEV_CHANGEUPPER:
 		upper_dev = info->upper_dev;
@@ -5052,13 +5042,6 @@ static int mlxsw_sp_netdevice_bridge_vlan_event(struct mlxsw_sp *mlxsw_sp,
 			NL_SET_ERR_MSG_MOD(extack, "Unknown upper device type");
 			return -EOPNOTSUPP;
 		}
-		if (!info->linking)
-			break;
-		if (netif_is_macvlan(upper_dev) &&
-		    !mlxsw_sp_rif_exists(mlxsw_sp, vlan_dev)) {
-			NL_SET_ERR_MSG_MOD(extack, "macvlan is only supported on top of router interfaces");
-			return -EOPNOTSUPP;
-		}
 		break;
 	case NETDEV_CHANGEUPPER:
 		upper_dev = info->upper_dev;
@@ -5135,11 +5118,6 @@ static int mlxsw_sp_netdevice_bridge_event(struct mlxsw_sp *mlxsw_sp,
 			NL_SET_ERR_MSG_MOD(extack, "VLAN uppers are only supported with 802.1q VLAN protocol");
 			return -EOPNOTSUPP;
 		}
-		if (netif_is_macvlan(upper_dev) &&
-		    !mlxsw_sp_rif_exists(mlxsw_sp, br_dev)) {
-			NL_SET_ERR_MSG_MOD(extack, "macvlan is only supported on top of router interfaces");
-			return -EOPNOTSUPP;
-		}
 		break;
 	case NETDEV_CHANGEUPPER:
 		upper_dev = info->upper_dev;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index fe1855cc2c76..2322429cdb72 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -9121,10 +9121,8 @@ static int mlxsw_sp_rif_macvlan_add(struct mlxsw_sp *mlxsw_sp,
 	int err;
 
 	rif = mlxsw_sp_rif_find_by_dev(mlxsw_sp, vlan->lowerdev);
-	if (!rif) {
-		NL_SET_ERR_MSG_MOD(extack, "macvlan is only supported on top of router interfaces");
-		return -EOPNOTSUPP;
-	}
+	if (!rif)
+		return 0;
 
 	err = mlxsw_sp_rif_fdb_op(mlxsw_sp, macvlan_dev->dev_addr,
 				  mlxsw_sp_fid_index(rif->fid), true);
@@ -9857,6 +9855,40 @@ static int mlxsw_sp_router_netdevice_event(struct notifier_block *nb,
 	return notifier_from_errno(err);
 }
 
+struct mlxsw_sp_macvlan_replay {
+	struct mlxsw_sp *mlxsw_sp;
+	struct netlink_ext_ack *extack;
+};
+
+static int mlxsw_sp_macvlan_replay_upper(struct net_device *dev,
+					 struct netdev_nested_priv *priv)
+{
+	const struct mlxsw_sp_macvlan_replay *rms = priv->data;
+	struct netlink_ext_ack *extack = rms->extack;
+	struct mlxsw_sp *mlxsw_sp = rms->mlxsw_sp;
+
+	if (!netif_is_macvlan(dev))
+		return 0;
+
+	return mlxsw_sp_rif_macvlan_add(mlxsw_sp, dev, extack);
+}
+
+static int mlxsw_sp_macvlan_replay(struct mlxsw_sp_rif *rif,
+				   struct netlink_ext_ack *extack)
+{
+	struct mlxsw_sp_macvlan_replay rms = {
+		.mlxsw_sp = rif->mlxsw_sp,
+		.extack = extack,
+	};
+	struct netdev_nested_priv priv = {
+		.data = &rms,
+	};
+
+	return netdev_walk_all_upper_dev_rcu(mlxsw_sp_rif_dev(rif),
+					     mlxsw_sp_macvlan_replay_upper,
+					     &priv);
+}
+
 static int __mlxsw_sp_rif_macvlan_flush(struct net_device *dev,
 					struct netdev_nested_priv *priv)
 {
@@ -9879,7 +9911,6 @@ static int mlxsw_sp_rif_macvlan_flush(struct mlxsw_sp_rif *rif)
 	if (!netif_is_macvlan_port(dev))
 		return 0;
 
-	netdev_warn(dev, "Router interface is deleted. Upper macvlans will not work\n");
 	return netdev_walk_all_upper_dev_rcu(dev,
 					     __mlxsw_sp_rif_macvlan_flush, &priv);
 }
@@ -9937,6 +9968,10 @@ static int mlxsw_sp_rif_subport_configure(struct mlxsw_sp_rif *rif,
 	if (err)
 		goto err_rif_subport_op;
 
+	err = mlxsw_sp_macvlan_replay(rif, extack);
+	if (err)
+		goto err_macvlan_replay;
+
 	err = mlxsw_sp_rif_fdb_op(rif->mlxsw_sp, dev->dev_addr,
 				  mlxsw_sp_fid_index(rif->fid), true);
 	if (err)
@@ -9952,6 +9987,8 @@ static int mlxsw_sp_rif_subport_configure(struct mlxsw_sp_rif *rif,
 	mlxsw_sp_rif_fdb_op(rif->mlxsw_sp, dev->dev_addr,
 			    mlxsw_sp_fid_index(rif->fid), false);
 err_rif_fdb_op:
+	mlxsw_sp_rif_macvlan_flush(rif);
+err_macvlan_replay:
 	mlxsw_sp_rif_subport_op(rif, false);
 err_rif_subport_op:
 	mlxsw_sp_rif_mac_profile_put(rif->mlxsw_sp, mac_profile);
@@ -10038,6 +10075,10 @@ static int mlxsw_sp_rif_fid_configure(struct mlxsw_sp_rif *rif,
 	if (err)
 		goto err_fid_bc_flood_set;
 
+	err = mlxsw_sp_macvlan_replay(rif, extack);
+	if (err)
+		goto err_macvlan_replay;
+
 	err = mlxsw_sp_rif_fdb_op(rif->mlxsw_sp, dev->dev_addr,
 				  mlxsw_sp_fid_index(rif->fid), true);
 	if (err)
@@ -10053,6 +10094,8 @@ static int mlxsw_sp_rif_fid_configure(struct mlxsw_sp_rif *rif,
 	mlxsw_sp_rif_fdb_op(rif->mlxsw_sp, dev->dev_addr,
 			    mlxsw_sp_fid_index(rif->fid), false);
 err_rif_fdb_op:
+	mlxsw_sp_rif_macvlan_flush(rif);
+err_macvlan_replay:
 	mlxsw_sp_fid_flood_set(rif->fid, MLXSW_SP_FLOOD_TYPE_BC,
 			       mlxsw_sp_router_port(mlxsw_sp), false);
 err_fid_bc_flood_set:
@@ -10200,6 +10243,10 @@ static int mlxsw_sp_rif_vlan_configure(struct mlxsw_sp_rif *rif, u16 efid,
 	if (err)
 		goto err_fid_bc_flood_set;
 
+	err = mlxsw_sp_macvlan_replay(rif, extack);
+	if (err)
+		goto err_macvlan_replay;
+
 	err = mlxsw_sp_rif_fdb_op(rif->mlxsw_sp, dev->dev_addr,
 				  mlxsw_sp_fid_index(rif->fid), true);
 	if (err)
@@ -10215,6 +10262,8 @@ static int mlxsw_sp_rif_vlan_configure(struct mlxsw_sp_rif *rif, u16 efid,
 	mlxsw_sp_rif_fdb_op(rif->mlxsw_sp, dev->dev_addr,
 			    mlxsw_sp_fid_index(rif->fid), false);
 err_rif_fdb_op:
+	mlxsw_sp_rif_macvlan_flush(rif);
+err_macvlan_replay:
 	mlxsw_sp_fid_flood_set(rif->fid, MLXSW_SP_FLOOD_TYPE_BC,
 			       mlxsw_sp_router_port(mlxsw_sp), false);
 err_fid_bc_flood_set:
-- 
2.40.1


