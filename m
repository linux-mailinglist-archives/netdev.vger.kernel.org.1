Return-Path: <netdev+bounces-143792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53DF9C4350
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A93B2836C
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 17:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C5D1A3BDE;
	Mon, 11 Nov 2024 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qEQ6075s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026031A08C2
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345123; cv=fail; b=GeEJBsK9xSzU5EL5WzDVhlqa7QXnOYTKxuc+Y+ZVRPP9AKz5JKcn109filHU8HfpXlAV2p/QkSEuYURYwYI8dLzpkjKUgm4WpYcrJkeU5bAcrJD1oTwX1YwN8ddNFzQSqZ7V1SG3eN26nSgEZVxtYHThsGMjpY11xcToLXx76Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345123; c=relaxed/simple;
	bh=pgAnxQ27GUZ2HuqrVojxPQIAgqrxmy8TeUIoHoQtPCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvZhCEYKYIvgKCZx6JLX5mZ5hpVGBS6le1rj9OuFGuGgqrG4PrHUcCVb2W3b3FmfFFUGXLUf54QonYmR30TYVjAnI+NiqganGKkqEqQ4LSbJRXe+m4osiR4xTY+vhip4eKJ2XBT7gZ9cUDwFnSQMfByDftqFlP0bUy7Oux6Ilmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qEQ6075s; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8olvKo0J/GFSgG4JBEUsIO1UdpiRv3e+cHNTwVgG5KfHgab5tbDJCsT70IMU2H43+4fMgNGeoCyPpKVSmjtRauBaY0x4ZjZEpYCNq92LcZdG4arD9EjQb4kLy1HqBentCGS51rp15lx+poOAb5Lp91hboVzSQReFGMjZRjZEvxQPD/oq2dM/XQatLFFbEbsQuyen4DEqRMVCTDad0HtUhzZrc1mzU86wW/4Ft8bBPnZJcd8WqtF+iEQnblZudCtQdHulCRrKWwWszt4EmGuP5AhjoCTJDI8n3I5q1Apj5dHTOfZKCLMoLMXXzsqRMV/5MAAaeacuST3DgD9kJrLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPe7E02qWfKJZW3JtVBbnaT6rMR+7yHXV4knLJBqCNk=;
 b=W2n0pnGkjjxDp++XAVnKoa8ADAOllik6Di0MypTbnNi4MFMFKpbbrjyGMylORNVeTq6olB4t7U9R6Oa8m7cGo9t+QqFMtXeut786nJQSVOs/8bashwwDFzPxf2pK4yQ9H4P8oK1ZxbwZFIDH/4t/31jC0X40g2Y6c/RH7flRtq86CsVB/m0A5gDpeEKMGGFEELZ2DA4eY+TxDHuT6VbzgK156DR+SHls/MAQKE5gLgOz/mgO2+HJeHbRfnQz6FpAB8Bki0OATktQiMVDiXWEUeC01PCjvtHvHnH7VgfH1puvDBfgsqgL8kdVkrjqpczFGh869Rlr/PjAR44ubLQhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPe7E02qWfKJZW3JtVBbnaT6rMR+7yHXV4knLJBqCNk=;
 b=qEQ6075s+LsbMXJ6CkHw2fOQdyZWEMLgs4RCKqNcJXXnfpdjO5pt9yIjyRKUENwUSrqINz1aamKVVhsYm4dB6pjB/GJaw8+mCkswsh3lq1KfX9xmlPj7sXWuOKyWUUNIjS5csmVOY4Voy6W9lVuY/UcY4ZDoABZDHJlBcBG+ANnGx9pahL/yEnuGphyxqlo/l7BkNNg57qQJ7zSrIB/RFXMlJclVm0TOLNx9mBfFKEoDZv5X6XFeCQXHm7/WMGw+CF0pF+YhXHvpGJe6dd1rQ7NNh5vwiZ3VD9X3qfIoxyOSJekV+YCyOgXZrwq/+ZDgL/JtXgtgMbytH52CfoplLg==
Received: from MW4PR04CA0063.namprd04.prod.outlook.com (2603:10b6:303:6b::8)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 17:11:55 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::b0) by MW4PR04CA0063.outlook.office365.com
 (2603:10b6:303:6b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26 via Frontend
 Transport; Mon, 11 Nov 2024 17:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 17:11:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 09:11:36 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 09:11:28 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Andy Roulin <aroulin@nvidia.com>,
	<mlxsw@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <UNGLinuxDriver@microchip.com>, "Manish
 Chopra" <manishc@marvell.com>, <GR-Linux-NIC-Dev@marvell.com>, "Kuniyuki
 Iwashima" <kuniyu@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, <bridge@lists.linux.dev>
Subject: [PATCH net-next v3 2/7] ndo_fdb_del: Add a parameter to report whether notification was sent
Date: Mon, 11 Nov 2024 18:08:56 +0100
Message-ID: <8153c15a3a5d341642e8c176cfb0d32e4be3efeb.1731342342.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731342342.git.petrm@nvidia.com>
References: <cover.1731342342.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 623483f0-155f-408a-8319-08dd0273f182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gm0IqOM1Mr+EvBC7jKiAZrWD6335rCCbfoZUX/TP3e9vgJcs3nyEaOB9D1ra?=
 =?us-ascii?Q?61tBtXgtnBZ1EX3KHrYZa3gR2ZMW8DPCK2TQcIXNjNF/2hWPFyO+0/fElHMT?=
 =?us-ascii?Q?uaF1Wqfk2/KlTCLF+CA/3mtZ4+WSlQBumDyJSjl/bDn5eJ17sREE/tE8AYm7?=
 =?us-ascii?Q?t5giqn+obd41oJOtSrshm8gQ/vWGiBDzj0dirdixVx6FEcc9RzV/b2yIrg1I?=
 =?us-ascii?Q?sAgs7xQlsbq1c3c5eYkCdPW3WNwmNX6aixKGphxlrAPQubZn5bNk9j5yMgSZ?=
 =?us-ascii?Q?8SSji1FE3iw8MfWLZX37+6durcQogc+2E9/SABKa0XYGNwLAtys409WLRX5+?=
 =?us-ascii?Q?njeU3KofBsi1i/DHabvK2CHDZCAm7aavRj+D+iedjza01PbYtl3GeKVYaj09?=
 =?us-ascii?Q?mHpoBrGjGYfqJjcM/m6/nrGmiOCX7D38d2rfkAplhQEYY1brOlBv3hx7InK4?=
 =?us-ascii?Q?AmLJxB2pzu0QbAnCI7yqeUFcMv6OX+k8RYJTJaBHFxeEzraJhVzWgvdzt4kf?=
 =?us-ascii?Q?egUeAaK3TlJSdh0gNVntV7GdmlGj48/c98SagereakFFZpAP7NGGFlHRBMIV?=
 =?us-ascii?Q?nxULnqFYMpx4zjVDcbkG9Gm3YQrxTbZxuvSxCARJ0Km8iY2anFsDhHOGnyPd?=
 =?us-ascii?Q?et03aFm6gpcj9oTKo7SB8NVmWI/B8VLp+M7laBwa8gWpzYpCP8y2GbPJQpvh?=
 =?us-ascii?Q?93tlCRpSMoYT1ZHUcNkrgvV9p4lrWBCGlK4G8H3ZmDEFK8Km8Rs84piCXoRC?=
 =?us-ascii?Q?ACeturq2tgt0uiKtG4oJGXr3dZmrb9braA/1yP1V047SKizccgDiSf0eKqvE?=
 =?us-ascii?Q?ABwOnUCBAMYMbahXA19XAH7OY07m69GQ1FG/Y8w68IShXozylc8ntojXyWPz?=
 =?us-ascii?Q?jOQg38jTQh00HbZqhSt1vN+20wRHSIfMiYt4tIkXOlvI7kOPIaw4bHXbnIPi?=
 =?us-ascii?Q?gTCvgj0oQZqWt7skgaxdd/+g4dj1DT0cLuvnCmE1b2HzcZyKWEBJ5BUISj0y?=
 =?us-ascii?Q?4YRghpgzz868BqEEGqTM/2yIPQ+uTGg6WGN5cimQWlg/8dQSdkYm2c+jLVUx?=
 =?us-ascii?Q?P5qs2j59dao9OLAKMxL4DRM2MilTrh27KstcCiwSHgpMrVyT4i1gODW/XYRs?=
 =?us-ascii?Q?aYya1P4vgwCiaK30Sb69LMB5DS2G/YB/qPt3Cedf7lwicyLk6HA18NxrgXiR?=
 =?us-ascii?Q?v4C8bGpuxeaa5xX5QGbGNNXEbMST8yk/uOA2SD7XHQxzz50G5c9VqzheHA9A?=
 =?us-ascii?Q?puAUE9ajEBmQv8bpJOS4zu1hWs1KGVrdKYv2sRNc3ImFZwhyeZooM+ZZhGL/?=
 =?us-ascii?Q?/XdouUYXDUiPpuNZdB16hR9W/A4Rg9k9Nq2+JY8x/7QwOnrWnh2QRNvnrWh+?=
 =?us-ascii?Q?iPMb0uB3eof3kX2NwQNXvl4Ug3FNkPCCZclEFFzYkTuOlDkfyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:11:55.1428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 623483f0-155f-408a-8319-08dd0273f182
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926

In a similar fashion to ndo_fdb_add, which was covered in the previous
patch, add the bool *notified argument to ndo_fdb_del. Callees that send a
notification on their own set the flag to true.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---

Notes:
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: intel-wired-lan@lists.osuosl.org
CC: UNGLinuxDriver@microchip.com
CC: Manish Chopra <manishc@marvell.com>
CC: GR-Linux-NIC-Dev@marvell.com
CC: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Nikolay Aleksandrov <razor@blackwall.org>
CC: bridge@lists.linux.dev

 drivers/net/ethernet/intel/ice/ice_main.c        |  4 +++-
 drivers/net/ethernet/mscc/ocelot_net.c           |  2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c |  2 +-
 drivers/net/macvlan.c                            |  2 +-
 drivers/net/vxlan/vxlan_core.c                   |  5 ++++-
 include/linux/netdevice.h                        |  9 +++++++--
 net/bridge/br_fdb.c                              | 15 ++++++++-------
 net/bridge/br_private.h                          |  2 +-
 net/core/rtnetlink.c                             | 11 ++++++++---
 9 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c875036f654b..b79848fe2a9e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6166,12 +6166,14 @@ ice_fdb_add(struct ndmsg *ndm, struct nlattr __always_unused *tb[],
  * @dev: the net device pointer
  * @addr: the MAC address entry being added
  * @vid: VLAN ID
+ * @notified: whether notification was emitted
  * @extack: netlink extended ack
  */
 static int
 ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
 	    struct net_device *dev, const unsigned char *addr,
-	    __always_unused u16 vid, struct netlink_ext_ack *extack)
+	    __always_unused u16 vid, bool *notified,
+	    struct netlink_ext_ack *extack)
 {
 	int err;
 
diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 4f15ba2c5525..558e03301aa8 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -744,7 +744,7 @@ static int ocelot_port_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 static int ocelot_port_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
 			       struct net_device *dev,
 			       const unsigned char *addr, u16 vid,
-			       struct netlink_ext_ack *extack)
+			       bool *notified, struct netlink_ext_ack *extack)
 {
 	struct ocelot_port_private *priv = netdev_priv(dev);
 	struct ocelot_port *ocelot_port = &priv->port;
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index 2484cebd97d4..eb69121df726 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -367,7 +367,7 @@ static int qlcnic_set_mac(struct net_device *netdev, void *p)
 
 static int qlcnic_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
 			struct net_device *netdev,
-			const unsigned char *addr, u16 vid,
+			const unsigned char *addr, u16 vid, bool *notified,
 			struct netlink_ext_ack *extack)
 {
 	struct qlcnic_adapter *adapter = netdev_priv(netdev);
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index dfb462e63248..fed4fe2a4748 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1049,7 +1049,7 @@ static int macvlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 
 static int macvlan_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
 			   struct net_device *dev,
-			   const unsigned char *addr, u16 vid,
+			   const unsigned char *addr, u16 vid, bool *notified,
 			   struct netlink_ext_ack *extack)
 {
 	struct macvlan_dev *vlan = netdev_priv(dev);
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 7b6baa63b6b1..cdd36f76af55 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1322,7 +1322,7 @@ int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
 /* Delete entry (via netlink) */
 static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 			    struct net_device *dev,
-			    const unsigned char *addr, u16 vid,
+			    const unsigned char *addr, u16 vid, bool *notified,
 			    struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
@@ -1344,6 +1344,9 @@ static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 				 true);
 	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
 
+	if (!err)
+		*notified = true;
+
 	return err;
 }
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cc5f5cca4ef1..d2b23df8cf6f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1252,8 +1252,11 @@ struct netdev_net_notifier {
  *	notification(s). Otherwise core will send a generic one.
  * int (*ndo_fdb_del)(struct ndmsg *ndm, struct nlattr *tb[],
  *		      struct net_device *dev,
- *		      const unsigned char *addr, u16 vid)
+ *		      const unsigned char *addr, u16 vid
+ *		      bool *notified, struct netlink_ext_ack *extack);
  *	Deletes the FDB entry from dev corresponding to addr.
+ *	Callee shall set *notified to true if it sent any appropriate
+ *	notification(s). Otherwise core will send a generic one.
  * int (*ndo_fdb_del_bulk)(struct nlmsghdr *nlh, struct net_device *dev,
  *			   struct netlink_ext_ack *extack);
  * int (*ndo_fdb_dump)(struct sk_buff *skb, struct netlink_callback *cb,
@@ -1531,7 +1534,9 @@ struct net_device_ops {
 					       struct nlattr *tb[],
 					       struct net_device *dev,
 					       const unsigned char *addr,
-					       u16 vid, struct netlink_ext_ack *extack);
+					       u16 vid,
+					       bool *notified,
+					       struct netlink_ext_ack *extack);
 	int			(*ndo_fdb_del_bulk)(struct nlmsghdr *nlh,
 						    struct net_device *dev,
 						    struct netlink_ext_ack *extack);
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 5f29958f3ddd..82bac2426631 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1287,7 +1287,7 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 
 static int fdb_delete_by_addr_and_port(struct net_bridge *br,
 				       const struct net_bridge_port *p,
-				       const u8 *addr, u16 vlan)
+				       const u8 *addr, u16 vlan, bool *notified)
 {
 	struct net_bridge_fdb_entry *fdb;
 
@@ -1296,18 +1296,19 @@ static int fdb_delete_by_addr_and_port(struct net_bridge *br,
 		return -ENOENT;
 
 	fdb_delete(br, fdb, true);
+	*notified = true;
 
 	return 0;
 }
 
 static int __br_fdb_delete(struct net_bridge *br,
 			   const struct net_bridge_port *p,
-			   const unsigned char *addr, u16 vid)
+			   const unsigned char *addr, u16 vid, bool *notified)
 {
 	int err;
 
 	spin_lock_bh(&br->hash_lock);
-	err = fdb_delete_by_addr_and_port(br, p, addr, vid);
+	err = fdb_delete_by_addr_and_port(br, p, addr, vid, notified);
 	spin_unlock_bh(&br->hash_lock);
 
 	return err;
@@ -1316,7 +1317,7 @@ static int __br_fdb_delete(struct net_bridge *br,
 /* Remove neighbor entry with RTM_DELNEIGH */
 int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 		  struct net_device *dev,
-		  const unsigned char *addr, u16 vid,
+		  const unsigned char *addr, u16 vid, bool *notified,
 		  struct netlink_ext_ack *extack)
 {
 	struct net_bridge_vlan_group *vg;
@@ -1339,19 +1340,19 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 	}
 
 	if (vid) {
-		err = __br_fdb_delete(br, p, addr, vid);
+		err = __br_fdb_delete(br, p, addr, vid, notified);
 	} else {
 		struct net_bridge_vlan *v;
 
 		err = -ENOENT;
-		err &= __br_fdb_delete(br, p, addr, 0);
+		err &= __br_fdb_delete(br, p, addr, 0, notified);
 		if (!vg || !vg->num_vlans)
 			return err;
 
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			if (!br_vlan_should_use(v))
 				continue;
-			err &= __br_fdb_delete(br, p, addr, v->vid);
+			err &= __br_fdb_delete(br, p, addr, v->vid, notified);
 		}
 	}
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index ebfc59049ec1..9853cfbb9d14 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -853,7 +853,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 
 int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 		  struct net_device *dev, const unsigned char *addr, u16 vid,
-		  struct netlink_ext_ack *extack);
+		  bool *notified, struct netlink_ext_ack *extack);
 int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 		       struct netlink_ext_ack *extack);
 int br_fdb_add(struct ndmsg *nlh, struct nlattr *tb[], struct net_device *dev,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 09d5085d4f7f..860993aa1b06 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4588,11 +4588,13 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if ((!ndm->ndm_flags || ndm->ndm_flags & NTF_MASTER) &&
 	    netif_is_bridge_port(dev)) {
 		struct net_device *br_dev = netdev_master_upper_dev_get(dev);
+		bool notified = false;
 
 		ops = br_dev->netdev_ops;
 		if (!del_bulk) {
 			if (ops->ndo_fdb_del)
-				err = ops->ndo_fdb_del(ndm, tb, dev, addr, vid, extack);
+				err = ops->ndo_fdb_del(ndm, tb, dev, addr, vid,
+						       &notified, extack);
 		} else {
 			if (ops->ndo_fdb_del_bulk)
 				err = ops->ndo_fdb_del_bulk(nlh, dev, extack);
@@ -4606,10 +4608,13 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	/* Embedded bridge, macvlan, and any other device support */
 	if (ndm->ndm_flags & NTF_SELF) {
+		bool notified = false;
+
 		ops = dev->netdev_ops;
 		if (!del_bulk) {
 			if (ops->ndo_fdb_del)
-				err = ops->ndo_fdb_del(ndm, tb, dev, addr, vid, extack);
+				err = ops->ndo_fdb_del(ndm, tb, dev, addr, vid,
+						       &notified, extack);
 			else
 				err = ndo_dflt_fdb_del(ndm, tb, dev, addr, vid);
 		} else {
@@ -4620,7 +4625,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 
 		if (!err) {
-			if (!del_bulk)
+			if (!del_bulk && !notified)
 				rtnl_fdb_notify(dev, addr, vid, RTM_DELNEIGH,
 						ndm->ndm_state);
 			ndm->ndm_flags &= ~NTF_SELF;
-- 
2.45.0


