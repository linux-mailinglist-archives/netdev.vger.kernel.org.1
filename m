Return-Path: <netdev+bounces-138768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 438839AECD8
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 18:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB8E1F24A5D
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF0516F910;
	Thu, 24 Oct 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="idy3jsZD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7091F893B
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789121; cv=fail; b=ktFDbHs/WSLrSGviDx2at2V6c/SZ5ICuDjTEeLSHwtPFVq6eznoxMp6dfsOW0Z4W4A6VlNEocvdbgGWGvtLHLKyYy4T+wrUKMg9C6ReC90/b8IeF1dcaV/mrB354nMONmTqT8IK0TrrTJoO3qZ8oiVKhOn/t3XcSY+CwSv33XX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789121; c=relaxed/simple;
	bh=4uLHOiU9vgMrQjIhgxzt0qMhZHd+5zG3MUJHyME+SxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXssbfxXkA4C8xKGnY3HRdT6m0XrVGEGoWSJ6Fmuh8exeMTEFdTtU/FEFCAmEt8m7WUpJRfqHiP71vpzsbc4ztXL7PaD0m2GsYl6sLvvUSmwt8D9sjJYkR37znXSawQB+1hQwiVQDh869gnETtGCWxDfqPSnItAx2BtEMkxKFBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=idy3jsZD; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTN5DWJSC1np3DgItAhngRIbRTCKcFPKnfQmZlyfdKYfAoDwOMaQXQ/V9AODOuXPl8ydMkPEXKsz3oypOmQZOnxqBFV6E3hSzO8Re5hW0qaCjQv7x9oNg+IseHUKGOjn3ufBuVMPi1dcab5sTtt8F/E7OXkNHXi2ZUIrTIyOvUoosmjv77dZIVX7S9nzk6JNqL7VjP1DXKR94uL01ynUgf5xg48G2xv+VyCZaWiXzHvGwo/r3R57jYXDwrNAoSepXEfr0rCWn4S4DZwS4D3mM2AQGb0nbyWG76IDGMFU9YC1A9ewEDQTEHP0E7WHIa0k2i77MN1cZe+6ULkHoP8T4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBIFWuxjeftBm326+w2qINTjyCljOxo9XLDD0TN4p30=;
 b=ZybIpOfWzeTqRJidb1Gm1dReCPEi/WyxYU3E0/NFAlvZG173rbZ8ljIRC77fULeNNtEnVvjC85SsVX/8/kO8Yfa2U6fxHbMrXh67rX6God2kRbM0Cvt1QegpvAe6M67jJIA3ALAwUF/XsKGZ6JiSdaVMaFZrEZqFmhliUJG+Km3QSyzZEPGw7NHb9XgMOwndMRafz2VnhyfJp9ZiXAJOOTQZUEjOMoaXqd1X3aIDBuDBWsidvFHogdg9ZV1qdTiAbEjs66vhpR7gb3deL4yVQ6LHskBpaLvnYuJARQN0NtJH2QiVFeKw0wa/QK3pIU0Apl7F2EVFFT5T7uVJ7fGKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBIFWuxjeftBm326+w2qINTjyCljOxo9XLDD0TN4p30=;
 b=idy3jsZDmRUe/0ez3acjesz6SC7Cm60+UFgbfmx267CM+4o+lO5GZdthawt0/ALDJqGFuVrpeCPKS5Snp+t2wyhrQuTNTD69WLnu6OoHbvkqzoyKmyVaed8wWZNasp8/5LqWNPCdvn6j4AEaOvGEamcR+feKOMtb5iTnmzLOEA6y+K2srOsDaUeWYKHT/wgfVAyJQNDzZGUkAOO1YuRyJ6Hr1pHewyERbvXRQmLmM5fbRTJtuJ64Vscl/6raI53OwMxyHXiP8jZ3ZAoYZgET48KnNSGsC90EYCJ0nWH0SSKGFQSW3OfqXzH4SCS25Y8jdDFzy/tn2lxSklz3jjJ0Pw==
Received: from MW4PR04CA0142.namprd04.prod.outlook.com (2603:10b6:303:84::27)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 16:58:34 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::27) by MW4PR04CA0142.outlook.office365.com
 (2603:10b6:303:84::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Thu, 24 Oct 2024 16:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 16:58:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:58:21 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:58:14 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Andy
 Roulin" <aroulin@nvidia.com>, <mlxsw@nvidia.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<UNGLinuxDriver@microchip.com>, Manish Chopra <manishc@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v2 3/8] ndo_fdb_del: Shift responsibility for notifying to drivers
Date: Thu, 24 Oct 2024 18:57:38 +0200
Message-ID: <8a28bbbe632e48613887aa7371cdc93ada36b0e5.1729786087.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729786087.git.petrm@nvidia.com>
References: <cover.1729786087.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e3a6fe-87c5-42a2-fb97-08dcf44d18da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GRNeehSFTE6xm+hcZSmtIjwLKfg47+WbAyTD87yb7V1vNCoaEfNurHXAi8mz?=
 =?us-ascii?Q?Tc8g4oblZS58n+CZDmI0cGTnXoBQcTwOS+rXvssmjIsGZsoCt1bs2R0S1yov?=
 =?us-ascii?Q?XjWx6rGO+snsIqrYyr9qapbzDcqLWxljzxZ6f1Q8yFnKVnLUXeD5Bc1JfTl9?=
 =?us-ascii?Q?MWQ0zNdsbWvj6Q/KqGsb10/Xzxh4moD1AljnrSJFGPYt3DT3ZS3MD7RmwEH0?=
 =?us-ascii?Q?S8The+1LC+Vu3b7UY18nyOiZGhZh7KBnNkg4McNzsXS9wLgIm6wbV9ZzLGkI?=
 =?us-ascii?Q?+f6pjvCC2EvfbwK6C5bQGc9g6RyDuw8+YJAOrWUJCnQcYiGc0FM4RhufyMRc?=
 =?us-ascii?Q?yv0YE9LsbBOfLwi7trVGTZea19NquJEzyjppFeEo7fP21Z2GsopEKhGa9i1a?=
 =?us-ascii?Q?5/JIiiWNfE2N7JWvuZsQSzgvT0eqyOeqc9qMj63EIjJdIIcKNSC8Fpa6iDJr?=
 =?us-ascii?Q?lwmMaq0btnqG4y0GZqRHjao7kCShZMRG17yALQJK1wmD4XXJLYks+aQYe8kJ?=
 =?us-ascii?Q?OAsr6ks/Dl+/yP2EZhEwbu+MzSlQTOPriUaIroK+NPW03banVXe3PYOwKMWS?=
 =?us-ascii?Q?u+/mdWeaUH7UzcTzs+bcnlhAmHZ+PomjVB/8KQfWlfCsGAOytOFfsv+BxTvi?=
 =?us-ascii?Q?XjA9Mr7QUNeE7OGF0dCQFzOxSiJxfjXRICZYAt2UO6tSDdS+BRsDJUqO8T59?=
 =?us-ascii?Q?CWtqvagMgYKEuuybxmuCXz71rOexu25c/HwaEP27cMVTZGu0I1gXn7mguB3l?=
 =?us-ascii?Q?XCQ0RILUBR/uhZhG4SQCux+JHlSrOdqBaz/YoDundPqFZ43OJJPLx2wZO8Vr?=
 =?us-ascii?Q?g2blwRh2uAb8Q/WkMtCbxrZH+BmKckfuab9zzjRrMT68ZQDuVCFkWlA75oN0?=
 =?us-ascii?Q?QWkzfakKFgkBqqwEGnYkJOjHL6LHB5b1hLs+HptbemOrTX3lJbtMIhQ/1J+2?=
 =?us-ascii?Q?YHV5jiPxwNM3B2fZ9Nxc6RmklqiT1kvj4oOsMOXmFAj7dSACdMP6Jba+xI2c?=
 =?us-ascii?Q?Dn6hbvVwLykN8XCvi70k8DfSS7T9BVNDcxphyNTwzJbs2ktbFtQbeJB+q4xf?=
 =?us-ascii?Q?iLod1W6prpdIokuljdQisBLaPzj1NhgONLUekG8qR2QcEHpUU75xYXzmxqD8?=
 =?us-ascii?Q?mUw5RcD67Hc3bdcf5Fo1ZE81agpc7ZAzKa1uo46/fTf5i1w8OGyGS9zFdzfc?=
 =?us-ascii?Q?gCpURdm8nhczpVm428hDuxanULie25gEJ618OW6DWnfmCObKenm1xyeLal2X?=
 =?us-ascii?Q?ys3l85qYbBxoq0Zz6laD93iBRoSh/fkXb1dnNVW12HodXpdAEa+aUR3Q/rYk?=
 =?us-ascii?Q?sDv1l1ckriJ8LDB+NdQFu8k4v7L1HBIkQiF2l9KAddrU/xSc9KLXSxuNsLgE?=
 =?us-ascii?Q?PHahzPnqkDvxadZAXiFklJf7hSDHh/GmlJc/DSzYvjhnhrswDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:58:34.5962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e3a6fe-87c5-42a2-fb97-08dcf44d18da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909

As described in the previous patch, the drivers that provide their own
fdb_add and fdb_del callbacks should from now on be responsible for sending
the notification themselves. In this patch, implement the fdb_del leg of
the change.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---

Notes:
    v2:
    - Fix qlcnic build
---
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: intel-wired-lan@lists.osuosl.org
CC: UNGLinuxDriver@microchip.com
CC: Manish Chopra <manishc@marvell.com>
CC: GR-Linux-NIC-Dev@marvell.com
CC: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>

 drivers/net/ethernet/intel/ice/ice_main.c        | 3 +++
 drivers/net/ethernet/mscc/ocelot_net.c           | 8 +++++++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c | 5 +++++
 drivers/net/macvlan.c                            | 3 +++
 include/linux/netdevice.h                        | 2 ++
 net/core/rtnetlink.c                             | 9 ++++-----
 6 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a3398814a1cb..65f9dcf4745b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6188,6 +6188,9 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
 	else
 		err = -EINVAL;
 
+	if (!err)
+		rtnl_fdb_notify(dev, addr, vid, RTM_DELNEIGH, ndm->ndm_state);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index cf972444e254..12958d985fd7 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -756,8 +756,14 @@ static int ocelot_port_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
 	struct ocelot_port *ocelot_port = &priv->port;
 	struct ocelot *ocelot = ocelot_port->ocelot;
 	int port = priv->port.index;
+	int err;
 
-	return ocelot_fdb_del(ocelot, port, addr, vid, ocelot_port->bridge);
+	err = ocelot_fdb_del(ocelot, port, addr, vid, ocelot_port->bridge);
+
+	if (!err)
+		rtnl_fdb_notify(dev, addr, vid, RTM_DELNEIGH, ndm->ndm_state);
+
+	return err;
 }
 
 static int ocelot_port_fdb_do_dump(const unsigned char *addr, u16 vid,
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index 584c85c10292..88308c30f88e 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -388,6 +388,11 @@ static int qlcnic_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
 			err =  -EINVAL;
 		}
 	}
+
+	if (!err)
+		rtnl_fdb_notify(netdev, addr, vid, RTM_DELNEIGH,
+				ndm->ndm_state);
+
 	return err;
 }
 
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index b1e828581ec4..2c61b7b83875 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1069,6 +1069,9 @@ static int macvlan_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
 	else if (is_multicast_ether_addr(addr))
 		err = dev_mc_del(dev, addr);
 
+	if (!err)
+		rtnl_fdb_notify(dev, addr, vid, RTM_DELNEIGH, ndm->ndm_state);
+
 	return err;
 }
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9f7de8d0414a..9e1ffb21de18 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1254,6 +1254,8 @@ struct netdev_net_notifier {
  *		      struct net_device *dev,
  *		      const unsigned char *addr, u16 vid)
  *	Deletes the FDB entry from dev corresponding to addr.
+ *	Callee is responsible for sending appropriate notification, as with
+ *	ndo_fdb_add().
  * int (*ndo_fdb_del_bulk)(struct nlmsghdr *nlh, struct net_device *dev,
  *			   struct netlink_ext_ack *extack);
  * int (*ndo_fdb_dump)(struct sk_buff *skb, struct netlink_callback *cb,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a9f56a50fa57..4788bfc58aa2 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4506,6 +4506,9 @@ int ndo_dflt_fdb_del(struct ndmsg *ndm,
 	else if (is_multicast_ether_addr(addr))
 		err = dev_mc_del(dev, addr);
 
+	if (!err)
+		rtnl_fdb_notify(dev, addr, vid, RTM_DELNEIGH, ndm->ndm_state);
+
 	return err;
 }
 EXPORT_SYMBOL(ndo_dflt_fdb_del);
@@ -4604,12 +4607,8 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 				err = ops->ndo_fdb_del_bulk(nlh, dev, extack);
 		}
 
-		if (!err) {
-			if (!del_bulk)
-				rtnl_fdb_notify(dev, addr, vid, RTM_DELNEIGH,
-						ndm->ndm_state);
+		if (!err)
 			ndm->ndm_flags &= ~NTF_SELF;
-		}
 	}
 out:
 	return err;
-- 
2.45.0


