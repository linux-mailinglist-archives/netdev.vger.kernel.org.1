Return-Path: <netdev+bounces-18965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133497593BD
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB29E28175E
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC8A14267;
	Wed, 19 Jul 2023 11:02:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889E14266
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D35186
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRv708R5X3Bx6sGCDKWOOmLF9+oAEqXV+5iBUafRBu41Rha2ZMHoaX7V8tKfBeLaZiGB9VGmI1GvyYbZyMVkVwtphEh3jM7Px+hKxTyy8QwT9vXX+YJBnbVHLf1REXsORa6S44FcXqd+OaD3uNCt/xGIfnzSohEOU55DxAabDwAdg2DfSX52iRPj4K8Qx93+UbX4QB54wRIVVSq3HlLRh91M5tKYwzGN0bFP1gRE+sYw4GZEFRJPkxr3NGvlOW65YhS40M/5cwDyd6JFGztqa5o7INUsRm5yxS4vFgmuIqvLEkw+EnYvkewkIra9rUDmfo7h3X7RJ0Bi1hmgOCK3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcYBKqRriWfnPMj+mnpMJ1Pr0V53DKVNrqfKl/4kJnw=;
 b=ht0OyKULecfwVMjgE3Gl9KGTgF+2f3xEV+Gkkc6GMODSh3meuIpLqsy/FqyL00J2b7P0ff8vXK7nCqbtengQMquYyHNTntxU184LWFmaZr0IWh2gIUC72HZ6Wt7yHilQxrQEA4vdNlgXCVmZIUJtvjYKlKXC/yYblpGOJ/8qefFvYX8AjQH5vwIVM3gLgBLHoFT0kvL2L2K7gh6XPvFG3Wzf3nqi4gBODPFRUd8pZQkrT2FdPSXYPtx+QMk7BGaKfY3T6YOXKXXNvpRHZ94qB3lOulZIHlmAOtE+awZRTRRVYiOyaBkfISyowX+h3MIFpig0jTC/r7wty+r2YMerAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcYBKqRriWfnPMj+mnpMJ1Pr0V53DKVNrqfKl/4kJnw=;
 b=Id/pbk3o6gl5a1rLpIOe6bzAUYTdDq8ibQkMvfay1dG5HTad8OjM/jrfhrzmNh0Q6yt0Mh05RRjjmIdVXS9hNTJ6xayNeteQNr8N4gLx8P2aqTbwroski2Rn2FX8QlGuU0UNUTOMh6VimNeU1uVf16xVNbDfEzjHG30Re64z3aWe2y7mkpQKNLc1AthoSqMGjN5YoPh3aBltNpSbZK6VIrbGnhnNVS/OYW++rHrbcrbFaiH+P+Vhtz+oHkjfLWsxL7Zqc7lb33PJvxCwJvVNX5Bb+MX27EMbJGDvuiU+kBSW4fXZYEgvvXaQxzdWiYu0A5RjYzk3qU/VHoE2ame6ow==
Received: from BN9P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::34)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 11:02:38 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::71) by BN9P222CA0029.outlook.office365.com
 (2603:10b6:408:10c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 11:02:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:25 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:22 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 10/17] mlxsw: spectrum_switchdev: Replay switchdev objects on port join
Date: Wed, 19 Jul 2023 13:01:25 +0200
Message-ID: <7b10ccf0e5faae9a324259ed0bb05ccdaecb2415.1689763088.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 811776ad-1dcf-42f4-937b-08db8847aa46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0a2dktdF/4EoktrPzqFQF6CMx9wz8YT0aD66d2WlWp7Le1GD44DmmJmyengueTDlgLKPyVz2KB05AyZ5g7DYlMGW+rKKndC0WIucwL76txnUcOCcsDY2jjBCeT0wj9XXqXRmpjeYRkJvqf3S6Kj9AtVHMoLDjYpgE+qnoLF9+Q7+05lMTLKpsTheja628zg9sISytMv3arJL7L1t97wQqce7zmt0SL/tFyD037fu62S8dJk3+6bKfz8pCajLq69h/koTIGVrpVyeAXVxwQQoYQ/MmGhtC4WMUKeQag58LNwjYrP0NVidy3xsklEKuOY/FVpgIETIprQA2GcOFLOvFjI8KFr+95e5buryZbb8k5FdQbax5Triv8QWypue7on/cbCpcqfFJ1shhli577zpXuowfFI39sN4Vulk56Y95RT25UalvTHVw8Ls+WDQE0KjBPzF2WG6SFd8DIasNKweyEW3/Z2DqRr7YQ20y5sxxL3JGMqA26yb9BT4WcevFvujoTKnZir+EVGeBA9Fo3Bv1Q841apUJHX/3pGOatGI9XuMVrmJqQL/iUndr/Thez/9wQ3Raf3p61EIpX8OCagja8/XdPpEUk93sgXYClcBBxBj4xYJevkYDrb87Khcyn2YdiZ4MZ6fqKYc9M78yxBhro+0KewNAp3fF/IN8PKxcynHRMOXKvJshLZCJOR/6L9WdC2khqHSePVb/UkW+NDKEjt3Mb26tTsl+DWtIwo38tC1+IbaBz+Epn96QOM0Il0F
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(4326008)(86362001)(36756003)(2906002)(40460700003)(40480700001)(47076005)(83380400001)(426003)(16526019)(66574015)(336012)(36860700001)(186003)(26005)(107886003)(82740400003)(7636003)(356005)(54906003)(8936002)(110136005)(70206006)(316002)(70586007)(8676002)(478600001)(2616005)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:38.1364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 811776ad-1dcf-42f4-937b-08db8847aa46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently it never happens that a netdevice that is already a bridge slave
would suddenly become mlxsw upper. The only case where this might be
possible as far as mlxsw is concerned, is with LAG netdevices. But if a LAG
has any upper (e.g. is enslaved), enlaving mlxsw port to that LAG is
forbidden. Thus the only way to install a LAG between a bridge and a mlxsw
port is by first enslaving the port to the LAG, and then enslaving that LAG
to a bridge. At that point there are no bridge objects (such as port VLANs)
to replay. Those are added afterwards, and notified as they are created.
This holds even for the PVID.

However in the following patches, the requirement that ports be only
enslaved to masters without uppers, is going to be relaxed. It will
therefore be necessary to replay the existing bridge objects. Without this
replay, e.g. the mlxsw bridge_port_vlan objects are not instantiated, which
causes issues later, as a lot of code relies on their presence.

To that end, add a new notifier block whose sole role is to filter out
events related to the one relevant upper, and forward those to the existing
switchdev notifier block. Pass the new notifier block to
switchdev_bridge_port_offload() when the bridge port is created.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |   4 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   2 +
 .../mellanox/mlxsw/spectrum_switchdev.c       | 131 +++++++++++++++++-
 3 files changed, 132 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 9a6e1ce4e786..8087da00f38f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1132,8 +1132,8 @@ static int mlxsw_sp_port_add_vid(struct net_device *dev,
 	return PTR_ERR_OR_ZERO(mlxsw_sp_port_vlan_create(mlxsw_sp_port, vid));
 }
 
-static int mlxsw_sp_port_kill_vid(struct net_device *dev,
-				  __be16 __always_unused proto, u16 vid)
+int mlxsw_sp_port_kill_vid(struct net_device *dev,
+			   __be16 __always_unused proto, u16 vid)
 {
 	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
 	struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index c6231e62a371..65eaa181e0aa 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -700,6 +700,8 @@ int mlxsw_sp_port_pvid_set(struct mlxsw_sp_port *mlxsw_sp_port, u16 vid,
 struct mlxsw_sp_port_vlan *
 mlxsw_sp_port_vlan_create(struct mlxsw_sp_port *mlxsw_sp_port, u16 vid);
 void mlxsw_sp_port_vlan_destroy(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan);
+int mlxsw_sp_port_kill_vid(struct net_device *dev,
+			   __be16 __always_unused proto, u16 vid);
 int mlxsw_sp_port_vlan_set(struct mlxsw_sp_port *mlxsw_sp_port, u16 vid_begin,
 			   u16 vid_end, bool is_member, bool untagged);
 int mlxsw_sp_flow_counter_get(struct mlxsw_sp *mlxsw_sp,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 79d45c6c6edf..982eae6bd63e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -384,6 +384,91 @@ mlxsw_sp_bridge_port_find(struct mlxsw_sp_bridge *bridge,
 	return __mlxsw_sp_bridge_port_find(bridge_device, brport_dev);
 }
 
+static int mlxsw_sp_port_obj_add(struct net_device *dev, const void *ctx,
+				 const struct switchdev_obj *obj,
+				 struct netlink_ext_ack *extack);
+static int mlxsw_sp_port_obj_del(struct net_device *dev, const void *ctx,
+				 const struct switchdev_obj *obj);
+
+struct mlxsw_sp_bridge_port_replay_switchdev_objs {
+	struct net_device *brport_dev;
+	struct mlxsw_sp_port *mlxsw_sp_port;
+	int done;
+};
+
+static int
+mlxsw_sp_bridge_port_replay_switchdev_objs(struct notifier_block *nb,
+					   unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	struct switchdev_notifier_port_obj_info *port_obj_info = ptr;
+	struct netlink_ext_ack *extack = port_obj_info->info.extack;
+	struct mlxsw_sp_bridge_port_replay_switchdev_objs *rso;
+	int err = 0;
+
+	rso = (void *)port_obj_info->info.ctx;
+
+	if (event != SWITCHDEV_PORT_OBJ_ADD ||
+	    dev != rso->brport_dev)
+		goto out;
+
+	/* When a port is joining the bridge through a LAG, there likely are
+	 * VLANs configured on that LAG already. The replay will thus attempt to
+	 * have the given port-vlans join the corresponding FIDs. But the LAG
+	 * netdevice has already called the ndo_vlan_rx_add_vid NDO for its VLAN
+	 * memberships, back before CHANGEUPPER was distributed and netdevice
+	 * master set. So now before propagating the VLAN events further, we
+	 * first need to kill the corresponding VID at the mlxsw_sp_port.
+	 *
+	 * Note that this doesn't need to be rolled back on failure -- if the
+	 * replay fails, the enslavement is off, and the VIDs would be killed by
+	 * LAG anyway as part of its rollback.
+	 */
+	if (port_obj_info->obj->id == SWITCHDEV_OBJ_ID_PORT_VLAN) {
+		u16 vid = SWITCHDEV_OBJ_PORT_VLAN(port_obj_info->obj)->vid;
+
+		err = mlxsw_sp_port_kill_vid(rso->mlxsw_sp_port->dev, 0, vid);
+		if (err)
+			goto out;
+	}
+
+	++rso->done;
+	err = mlxsw_sp_port_obj_add(rso->mlxsw_sp_port->dev, NULL,
+				    port_obj_info->obj, extack);
+
+out:
+	return notifier_from_errno(err);
+}
+
+static struct notifier_block mlxsw_sp_bridge_port_replay_switchdev_objs_nb = {
+	.notifier_call = mlxsw_sp_bridge_port_replay_switchdev_objs,
+};
+
+static int
+mlxsw_sp_bridge_port_unreplay_switchdev_objs(struct notifier_block *nb,
+					     unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	struct switchdev_notifier_port_obj_info *port_obj_info = ptr;
+	struct mlxsw_sp_bridge_port_replay_switchdev_objs *rso;
+
+	rso = (void *)port_obj_info->info.ctx;
+
+	if (event != SWITCHDEV_PORT_OBJ_ADD ||
+	    dev != rso->brport_dev)
+		return NOTIFY_DONE;
+	if (!rso->done--)
+		return NOTIFY_STOP;
+
+	mlxsw_sp_port_obj_del(rso->mlxsw_sp_port->dev, NULL,
+			      port_obj_info->obj);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block mlxsw_sp_bridge_port_unreplay_switchdev_objs_nb = {
+	.notifier_call = mlxsw_sp_bridge_port_unreplay_switchdev_objs,
+};
+
 static struct mlxsw_sp_bridge_port *
 mlxsw_sp_bridge_port_create(struct mlxsw_sp_bridge_device *bridge_device,
 			    struct net_device *brport_dev,
@@ -2350,6 +2435,33 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port(struct mlxsw_sp *mlxsw_sp,
 	return NULL;
 }
 
+static int
+mlxsw_sp_bridge_port_replay(struct mlxsw_sp_bridge_port *bridge_port,
+			    struct mlxsw_sp_port *mlxsw_sp_port,
+			    struct netlink_ext_ack *extack)
+{
+	struct mlxsw_sp_bridge_port_replay_switchdev_objs rso = {
+		.brport_dev = bridge_port->dev,
+		.mlxsw_sp_port = mlxsw_sp_port,
+	};
+	struct notifier_block *nb;
+	int err;
+
+	nb = &mlxsw_sp_bridge_port_replay_switchdev_objs_nb;
+	err = switchdev_bridge_port_replay(bridge_port->dev, mlxsw_sp_port->dev,
+					   &rso, NULL, nb, extack);
+	if (err)
+		goto err_replay;
+
+	return 0;
+
+err_replay:
+	nb = &mlxsw_sp_bridge_port_unreplay_switchdev_objs_nb;
+	switchdev_bridge_port_replay(bridge_port->dev, mlxsw_sp_port->dev,
+				     &rso, NULL, nb, extack);
+	return err;
+}
+
 static int
 mlxsw_sp_bridge_vlan_aware_port_join(struct mlxsw_sp_bridge_port *bridge_port,
 				     struct mlxsw_sp_port *mlxsw_sp_port,
@@ -2364,7 +2476,7 @@ mlxsw_sp_bridge_vlan_aware_port_join(struct mlxsw_sp_bridge_port *bridge_port,
 	if (mlxsw_sp_port->default_vlan->fid)
 		mlxsw_sp_port_vlan_router_leave(mlxsw_sp_port->default_vlan);
 
-	return 0;
+	return mlxsw_sp_bridge_port_replay(bridge_port, mlxsw_sp_port, extack);
 }
 
 static int
@@ -2536,6 +2648,7 @@ mlxsw_sp_bridge_8021d_port_join(struct mlxsw_sp_bridge_device *bridge_device,
 	struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan;
 	struct net_device *dev = bridge_port->dev;
 	u16 vid;
+	int err;
 
 	vid = is_vlan_dev(dev) ? vlan_dev_vlan_id(dev) : MLXSW_SP_DEFAULT_VID;
 	mlxsw_sp_port_vlan = mlxsw_sp_port_vlan_find_by_vid(mlxsw_sp_port, vid);
@@ -2551,8 +2664,20 @@ mlxsw_sp_bridge_8021d_port_join(struct mlxsw_sp_bridge_device *bridge_device,
 	if (mlxsw_sp_port_vlan->fid)
 		mlxsw_sp_port_vlan_router_leave(mlxsw_sp_port_vlan);
 
-	return mlxsw_sp_port_vlan_bridge_join(mlxsw_sp_port_vlan, bridge_port,
-					      extack);
+	err = mlxsw_sp_port_vlan_bridge_join(mlxsw_sp_port_vlan, bridge_port,
+					     extack);
+	if (err)
+		return err;
+
+	err = mlxsw_sp_bridge_port_replay(bridge_port, mlxsw_sp_port, extack);
+	if (err)
+		goto err_replay;
+
+	return 0;
+
+err_replay:
+	mlxsw_sp_port_vlan_bridge_leave(mlxsw_sp_port_vlan);
+	return err;
 }
 
 static void
-- 
2.40.1


