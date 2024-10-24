Return-Path: <netdev+bounces-138767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF069AECD2
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 18:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6381C22AD2
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3CB1F8912;
	Thu, 24 Oct 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DnVSCP94"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67C16F910
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789118; cv=fail; b=f+P+h99SG72oFI4fatGO6DKXNDr+UIRFfCUYWAdGkDRrL8TF8v+og4NIPfldFFQWBUtFQ4Jspp9TuhZFi3l7OAosu8zPLTy/+4x4VpVKeQDhxJdnCgfBbpMQ4JjZnCTxHdTTmu0w9nlK8Q227N3ION+LNyWHio5e+VqQV8LCdgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789118; c=relaxed/simple;
	bh=q3ts4vUUQfYkL2Bbe1qkzu0i9GgOQqyjD0KcC0VzGq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLkpwTQDlOeGdUid5z77EDhuYBOrcUlKwRuQiHQ+S1uUHGPAaa+yPYtYdsKVK/l2gE7Al+drvSoI3VWvnT/Em0wcGqJwkYr7QV5yznFTjr+W8KMnvmtwicnr9VObsuO8tAJeMCg2jvGCdWwpgE4RL411nRzUwLHfkNCiWCJ+u4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DnVSCP94; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xi1spLHLkvekhz/0aDODb5owEkh8RavrpUBsFm3T4SlEGs1OD+FRQ6ZYTl/1Ru1YfoAS4cedxDv/d/rvh5tZwSlgE6XkECQZTw3OvALLiS21pQWNOtSzOnMyvoqYhN3SXUUu/icRNe36lqK4/9W1nGPGULYoXrPokdzCB8++8z/8dJGGYm7kEnV5Ahiy5zgHzJguI6Kj5mltZ++BTkDcYWyFep0UXn/Z0WwcezQBNLLGX/rNA5AG0v6pZNdcb3hVQ8FGVXa8+W92kNORewCadXtVoAhDq6Nt6z93wO9G0n7MQJO9tAJWzGmN98Qbl415MquBvr80yJBSBkVFEYktkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6o8GVt3j2bzQyzwjo+CDrFwovQ0czdOAGsQR+DF4ko=;
 b=YSuuy91UsVhlQhpAhI0WftLK4PSFyRg2FHUdu7G5yQYfWf24wRmCTX+k3fck0r526llibsXdZLXPjm4RMB+9BENhv6R5H1D4DzG6vgXtYZrnvp6Z77ou08CfbUO5VhEsF7NBKyMweQoyW6KKcRn8gHqZ4lIKXinNh97M+HCGOA2UzRuvahN8vdwcctBF4UeBS2/eIW2Vu2WY7lGtq5Cv+1NwzSe0rku6179C4d/1+WhKF+IqR/sc6Igotjt6xp9CJUlX7MF2bpVpA3BkUeTkEvdCf0E1hp73kYhC/Q2+1vOs0+jGacF9sKMzswQpvkJJ3Vr/pJdcq+uUCzNW1sNbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6o8GVt3j2bzQyzwjo+CDrFwovQ0czdOAGsQR+DF4ko=;
 b=DnVSCP9495U27NgFvAxkJjZtSpBKJHrZoYFrtwhYyg83iwh42c03v1lRbaksyIl4rXNgtrBuw9EiNiQ9EGzxi7q6xCXUut7MhZvelIVrfQROyz2V7iwg74guRFq1Bft1UTksL7rdThkgNZND5C6xZQzhl9ThvAfVTkz8vZb2ddESJ+uE5/iT8fIqU8KZ/E9UxzCB6Kf9pz5UTfzwgWm3jEt4mmXYPf/5Omim0jlvB4Q2xiYCeUq2xpUnzv4MRCFebS7YznH8udHtatzEPeC65g2VcIBq1DEVMdwSUAA01JwF/mOoYo1vP7plc5dZnsHRx8c8m1LT5k1PloiJLTYvCQ==
Received: from BY5PR17CA0044.namprd17.prod.outlook.com (2603:10b6:a03:167::21)
 by CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Thu, 24 Oct
 2024 16:58:29 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::1a) by BY5PR17CA0044.outlook.office365.com
 (2603:10b6:a03:167::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Thu, 24 Oct 2024 16:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 16:58:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:58:14 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:58:06 -0700
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
Subject: [PATCH net-next v2 2/8] ndo_fdb_add: Shift responsibility for notifying to drivers
Date: Thu, 24 Oct 2024 18:57:37 +0200
Message-ID: <5fb245d2d6a0ad78c42bba2a3d30dc1a42f9ea8f.1729786087.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: f2832bd5-6da4-42f0-0a15-08dcf44d15da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7sxn4AHgASYCaE+pIV7bVoh32FS6tw9zndUToVucgXz5H4874uYcTBfco/F1?=
 =?us-ascii?Q?gFloYnaTik75VBwTnk4sYXvTLFnutdO7zqSGS0pUDu9vTjQduBwfRXy8CGLg?=
 =?us-ascii?Q?RmS1/XWDrfvkflI8KNJeL6pFp7CY0F6AJyKGHfz4qWPFyFWSrkvGA1pL4Ykl?=
 =?us-ascii?Q?K2iEocmBV3T7J8P8yYNul9MfMFNKNsmBOaR8vP5+xEkuTCbxiDHb4+m2+0M3?=
 =?us-ascii?Q?szdMaNBZXy7NpzSYPew7PJY9Yv/tSFwNAXvsI6XSTv423glFRPY2jYjdnGdb?=
 =?us-ascii?Q?NjD/huwYpTSJ8aBzOM3GCaw6xMDm1Cd4j/BtA4nsh370TwDSAIzYc3U8x1Qs?=
 =?us-ascii?Q?/0rA0EZytnd6q0bDFIL8QeFKcqJnrJx5XDM6Uh0+0Q3ULjLw+2tTv7SW7PK8?=
 =?us-ascii?Q?tXBgbl36QA9L4rOH3fP90fog0LJjjrjyOhG3hbToJ76oW1CN2BU8s3YQBO75?=
 =?us-ascii?Q?w1FIj5RPIXgidKqPovsu1Iy1/JZFWuZ6dje0NBgyRvePPDEjwtYy9Jn/EjmL?=
 =?us-ascii?Q?ui8BU9VY5cwweyWNwvm1SCjlSQfDs/uY4SLXV8fwaYW4KE2JfalaNHUG4n1i?=
 =?us-ascii?Q?izH1QwsUzGyzjWRrkm/bapxtJjxErER65ftKvwx2/UjQ7LsCpskzztDSimu0?=
 =?us-ascii?Q?HKuBIZmAf/10zbWUKYV4SaN3pc0llpm4y1YtkVgJU4V8YQm/uWwfJFgszMMC?=
 =?us-ascii?Q?AmkfTiwg1jViaIDPsl00NUOfIrdzT6NNm7c/87xRjWA/NPkagOMRj6E8rZiu?=
 =?us-ascii?Q?bhFYIgbInOBmzF1gDmGVRwf7IBJHLngtLu6CP6a3WwnsFcIXKA9iGbESJtyr?=
 =?us-ascii?Q?r24Y8qjuRKCgIcNGAdabfx21rOnxX1JgS346TVnGAlH/rgqfSY+Xlw+zUbWL?=
 =?us-ascii?Q?iSRPwwMOkzFtXn/j64/FgadWY8tIaduKInPja/yFzOcQ+/VRJ3BJnV16xGw1?=
 =?us-ascii?Q?0Q3Nu06/FHe3sMJFxtpfAd8wm3K0B380gBRg3w6a53ARMhVnXfTtzEAoAQg9?=
 =?us-ascii?Q?WMEfvmZZrkVCBmX2h8AqlESI6yfAP1u5c5aePVGRrUmW4clh4kfkgwbQ0Lng?=
 =?us-ascii?Q?DqiKj5J0z7zGUu7zGtH6NVxOT2YSLMwiCofIye73ELbX3LrGWbPi4sjHJT8N?=
 =?us-ascii?Q?ZrhwCRiU+0FtI/tNqF4BwLMdL4j4WHiAf2ni7OHHXsPi3OFfAz/3JzWrS0HP?=
 =?us-ascii?Q?jTw45x/acmGKbaZ7GuaGffyNv/ILZJ984/V2JDdqbDdO2mCPBc3pCIJHXrTi?=
 =?us-ascii?Q?DazWpWXE6WwrrOfExu3WwrMowLNhGE4S1NDsekUP6Jan/Qw1y+DfqN2ig/mW?=
 =?us-ascii?Q?Ym9A9W8CzrBxpofr3atwFRLTjOjc7ggbGH+nWXD7o777LrfwtBnvaA5heHyR?=
 =?us-ascii?Q?t/TyIzZN+t85npKpKODpiv2vwZw+Yo2j9fpAPtfibuYLR6vl6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:58:29.5725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2832bd5-6da4-42f0-0a15-08dcf44d15da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021

Currently when FDB entries are added to or deleted from a VXLAN netdevice,
the VXLAN driver emits one notification, including the VXLAN-specific
attributes. The core however always sends a notification as well, a generic
one. Thus two notifications are unnecessarily sent for these operations. A
similar situation comes up with bridge driver, which also emits
notifications on its own:

 # ip link add name vx type vxlan id 1000 dstport 4789
 # bridge monitor fdb &
 [1] 1981693
 # bridge fdb add de:ad:be:ef:13:37 dev vx self dst 192.0.2.1
 de:ad:be:ef:13:37 dev vx dst 192.0.2.1 self permanent
 de:ad:be:ef:13:37 dev vx self permanent

In order to prevent this duplicity, shift the responsibility to send the
notification always to the drivers. Only where the default FDB add / del
operations are used does the core emit notifications. If fdb_add and
fdb_del are overridden, the driver should do that instead.

Drivers can use rtnl_fdb_notify(), exported in the previous patch, to get
the default notification behavior back. This function is made to notify on
success, which means several drivers do not need to change at all.

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

 drivers/net/ethernet/intel/i40e/i40e_main.c      | 3 +++
 drivers/net/ethernet/intel/ice/ice_main.c        | 3 +++
 drivers/net/ethernet/mscc/ocelot_net.c           | 8 +++++++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c | 7 ++++++-
 drivers/net/macvlan.c                            | 3 +++
 include/linux/netdevice.h                        | 3 +++
 net/core/rtnetlink.c                             | 8 ++++----
 7 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 25295ae370b2..6a1ac0f4f8a6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13126,6 +13126,9 @@ static int i40e_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err == -EEXIST && !(flags & NLM_F_EXCL))
 		err = 0;
 
+	if (!err)
+		rtnl_fdb_notify(dev, addr, vid, RTM_NEWNEIGH, ndm->ndm_state);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a6f586f9bfd1..a3398814a1cb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6154,6 +6154,9 @@ ice_fdb_add(struct ndmsg *ndm, struct nlattr __always_unused *tb[],
 	if (err == -EEXIST && !(flags & NLM_F_EXCL))
 		err = 0;
 
+	if (!err)
+		rtnl_fdb_notify(dev, addr, vid, RTM_NEWNEIGH, ndm->ndm_state);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 7c9540a71725..cf972444e254 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -737,8 +737,14 @@ static int ocelot_port_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	struct ocelot_port *ocelot_port = &priv->port;
 	struct ocelot *ocelot = ocelot_port->ocelot;
 	int port = priv->port.index;
+	int err;
 
-	return ocelot_fdb_add(ocelot, port, addr, vid, ocelot_port->bridge);
+	err = ocelot_fdb_add(ocelot, port, addr, vid, ocelot_port->bridge);
+
+	if (!err)
+		rtnl_fdb_notify(dev, addr, vid, RTM_NEWNEIGH, ndm->ndm_state);
+
+	return err;
 }
 
 static int ocelot_port_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index b3588a1ebc25..584c85c10292 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -409,7 +409,7 @@ static int qlcnic_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	}
 
 	if (ether_addr_equal(addr, adapter->mac_addr))
-		return err;
+		goto out;
 
 	if (is_unicast_ether_addr(addr)) {
 		if (netdev_uc_count(netdev) < adapter->ahw->max_uc_count)
@@ -422,6 +422,11 @@ static int qlcnic_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		err = -EINVAL;
 	}
 
+out:
+	if (!err)
+		rtnl_fdb_notify(netdev, addr, vid, RTM_NEWNEIGH,
+				ndm->ndm_state);
+
 	return err;
 }
 
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index cf18e66de142..b1e828581ec4 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1044,6 +1044,9 @@ static int macvlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	else if (is_multicast_ether_addr(addr))
 		err = dev_mc_add_excl(dev, addr);
 
+	if (!err)
+		rtnl_fdb_notify(dev, addr, vid, RTM_NEWNEIGH, ndm->ndm_state);
+
 	return err;
 }
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8feaca12655e..9f7de8d0414a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1247,6 +1247,9 @@ struct netdev_net_notifier {
  *		      const unsigned char *addr, u16 vid, u16 flags,
  *		      struct netlink_ext_ack *extack);
  *	Adds an FDB entry to dev for addr.
+ *	Callee is responsible for sending appropriate notification. The helper
+ *	rtnl_fdb_notify() can be invoked to send a generic notification in case
+ *	the driver does not need to customize the notification.
  * int (*ndo_fdb_del)(struct ndmsg *ndm, struct nlattr *tb[],
  *		      struct net_device *dev,
  *		      const unsigned char *addr, u16 vid)
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e5c6dd4c5cf5..a9f56a50fa57 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4376,6 +4376,9 @@ int ndo_dflt_fdb_add(struct ndmsg *ndm,
 	if (err == -EEXIST && !(flags & NLM_F_EXCL))
 		err = 0;
 
+	if (!err)
+		rtnl_fdb_notify(dev, addr, vid, RTM_NEWNEIGH, ndm->ndm_state);
+
 	return err;
 }
 EXPORT_SYMBOL(ndo_dflt_fdb_add);
@@ -4473,11 +4476,8 @@ static int rtnl_fdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 			err = ndo_dflt_fdb_add(ndm, tb, dev, addr, vid,
 					       nlh->nlmsg_flags);
 
-		if (!err) {
-			rtnl_fdb_notify(dev, addr, vid, RTM_NEWNEIGH,
-					ndm->ndm_state);
+		if (!err)
 			ndm->ndm_flags &= ~NTF_SELF;
-		}
 	}
 out:
 	return err;
-- 
2.45.0


