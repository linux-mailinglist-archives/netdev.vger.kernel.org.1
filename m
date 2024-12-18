Return-Path: <netdev+bounces-153090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8D19F6C2C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10AEE7A5FEF
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902BA1F2C21;
	Wed, 18 Dec 2024 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pYQe5Dpy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F21FA16E
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734542253; cv=fail; b=sWVO4iXkSjgPtxR5vaAszQLbP0vQWxVL+rW0+If3iI0VM3RjqRmu/Ij8A+JuKxPuOylKasunrxTAxytySsZAvQv5TPpQFDQ40wN5dTx9CuhN5VWgxiyU+jr8oLrczii2guKZhMsvinB801+ij/eBFrLOTImAS8lQdgsiexlrwAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734542253; c=relaxed/simple;
	bh=Q2iSzCs6zzgmUpugVYLCtxJdBo0eoGoIUmqME5GyrU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHA1iU+a3KtO0dROS7FjOQxsSbW6+1Fw/2Z4oRIaoGcgSeuEccW2g5eWe0GmTSyJiT6x/ZwhqHQ6OVheWhX1FB7wdH2HX0X0Chc0+eXCMR0GL6aoeAxzplrSS16K0JJagG/g9Uu/ATSJSAlps+OXyS4TIr6ctZtJcaTWJjlyMjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pYQe5Dpy; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvlLbnn3oiurrL0e9Le/eKM2s5jViT3GGtNQRQrVSGm3Whq+INCD8FBrdznIts7AZsoeNPJk6vvWU50+2s7/AReh1kkzx8a2PriLzkVXrFU7/gRvw+ORsmeWA5a4yektBzgAeu/2J29W0gEXwjQhLInyGRYNppwwRw2IJ1QPvY2cmoit7jj54D2Rn5KF8G8KPcCSEiaNwRWcGcrihS2BAz+nr311+u9e8+9FzVheuP/qNYQW5+tkjmuLszMQvKJPz0i2B80iXlCYnB6YjAn06GSPolRy9eysEVAiUHhoF2fxiiVbxFmMInevqPn/NXbL1KzKoLVzEOtTwtFQeJDvgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIAPo7kolJ9AUIS8506tvatukhKybVj0MKKJ68s3Ezs=;
 b=gH860FQO84oQXVjMKC0gw8w5HtmQBwzzZTZqrhVuffnjdlw5nRLm3uRr4yqLKATjR3LbjJyXWdP14dpDZsTOjOhk3py7kHod/MI/Uz+UoFAMyXOBBbWdkQ4pafmnHEnZ1qhMfWFpiJ/Izq97hkH49XNwJ58flS8DIq3bJ3spsgxLIKNMGJjhFlc0QjBBrXy56pbYy8YgLuceyl43HXbTE+h/F5Xx0SQET+I4h05fT/vuXDV4jcsvwsuGtUgQWe7Cx/1E76okiO2Nc/iltYuN/uqYzesYjdZ/6Ymk/C/P6INg84zJgIGUqb6xwGT/viSBkBJSZ8N0QqhZjBnLTKqd2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIAPo7kolJ9AUIS8506tvatukhKybVj0MKKJ68s3Ezs=;
 b=pYQe5Dpy7goSeH8KcbUotNsY7v+9wWP7TqLic+Z7ZfwIwrE07Bf8mgOImjT3FXd2XEwDKBZ9FBkmcz0VweKJ4bjd36q2zvAdd+8tYs/e4BC2lgyhwb5X4nREL8LV56BZnaBNYLvYhN4Xbr+2t0HalCKSyGBAewszpmGDbdT+62kiW2PlnlPbK8ftZuLL7sQm9qYispeAP99Jso7nM9AqbmJjDbFiGBEvnsQcXD1pUwGNJIpAulwExSUlStmw4GfhZgL0DFxLVSKmf/WGXueBI71mTbABw9Qam1PYWqrWF0XVxSiMyJDaXIkso1NKSCPSUWu80LhHpaIb06sxVSYl7g==
Received: from SJ0PR05CA0167.namprd05.prod.outlook.com (2603:10b6:a03:339::22)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 17:17:27 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:a03:339:cafe::ff) by SJ0PR05CA0167.outlook.office365.com
 (2603:10b6:a03:339::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Wed,
 18 Dec 2024 17:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.6 via Frontend Transport; Wed, 18 Dec 2024 17:17:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 09:17:03 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 09:16:57 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/4] net: bridge: Handle changes in VLAN_FLAG_BRIDGE_BINDING
Date: Wed, 18 Dec 2024 18:15:57 +0100
Message-ID: <90a8ca8aea4d81378b29d75d9e562433e0d5c7ff.1734540770.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734540770.git.petrm@nvidia.com>
References: <cover.1734540770.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e558c1-c1d6-4381-62d9-08dd1f87d84d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?30jd5Yf7d/vgf+nc9tYuwAjwX2DOOKS2YjzMs3M6Hwd9om54vTJ58FC9JjTO?=
 =?us-ascii?Q?pceRcVD/uRaEdtPoiLvKyrmRssZihKfHnKO+xooJUk9ACeSMZSJd8p9taRKe?=
 =?us-ascii?Q?Q/7rWsmsczpVPSI2efMCeseRy9hsszmZqOu3Bev4e7SkIx8dUbYG0KlJi4ON?=
 =?us-ascii?Q?MHbac8d4S/+2JR8NQW3U4YuEREoMzH/sMh7i37j8gBH2qErCrFfO11vCCDyn?=
 =?us-ascii?Q?lwnkRl49uXVqQDUuYE9CFmjp/dXYlcnPF5d0Dy4r36zzFvOtwvPdguNVarps?=
 =?us-ascii?Q?UJxu3OHfPZJ88Q+jkjg46WIN7K9+svrGjjgUtpq6S3/BBGsj4u1Ac298jbEp?=
 =?us-ascii?Q?AtCA4SuQsFJhKz2ptFYhC7m5H9UHc/53r7Qfwt03M/KDKrMmR538WUZ5kjae?=
 =?us-ascii?Q?jstgmRGoC6zwfwsYYk1zB49JbHb0oCjJRLLlKgvy2/KNgIPWVnkZGHWt7RNI?=
 =?us-ascii?Q?r+ZhEjgYTdah3/u54oLwPIX3LWUbLyeQcBpIi9wsKNdyNbalcOf6PoXHGPsw?=
 =?us-ascii?Q?CdpwOUdxiCDBZepLglD90S0k45NgE9KeDij89tHuYy5vUqv7oObx+T9PWG2N?=
 =?us-ascii?Q?UV+XGaUtUKSDMGXlavwsybNt4o/u4entQ7akoTFZ/N7Qj11Hzg866vvntQly?=
 =?us-ascii?Q?wfTJkJQFAv63aeAasT2ZKO2SwyGjcA4YPbeUPHmvenjvHRm7pY9lcBHC7utO?=
 =?us-ascii?Q?cxhOYBiQ8VgenkWdEoDVnlrVKvvsg0jcWunKmGluFNejD0PJA02z0BjfNj5i?=
 =?us-ascii?Q?TDnuLLrznYc+G/IDqX40PoMV+Ou07XcCIICHwmh/BxSvekPXlP/6sAc2aGZY?=
 =?us-ascii?Q?x8bru4jrn/vjxtnUwKff6+puiaZLxLg+OmENzLcUsWg5VhTeqSCUWTn7QqIb?=
 =?us-ascii?Q?VcgS2mPsm1lZv/V0Mq+x6wC+fuoVBc+bONT4//RrjQnvkVcKE39z4cNzAhKT?=
 =?us-ascii?Q?1tGpq4QyuyO4upXJjcriP8jbDz8crWZImPcaa9lwpFqVq9820c7CuEV7Tnna?=
 =?us-ascii?Q?OIDm2KIiScvxn3jmMozJL3l3J9QQQE4GHH/7ao/CcbgOccIM9k6t3VWny8LK?=
 =?us-ascii?Q?hMPlRb8qq7WLlD41c0F3k1Ah2ZFvIlleS2lJ7u2PSsS9Pph6mtTtH73MIZie?=
 =?us-ascii?Q?EC+fRpn0uFqYHFTTJ3hspx2KOmGFxEGY9zsuWi9vOmYuOQV9PLIc1s4KXjyI?=
 =?us-ascii?Q?sSZN2SV1xfRhaqL8aBqV3bgEHsPFIYjGy15xLcN6adVyT14UbMTGqdbtykS4?=
 =?us-ascii?Q?y7cqOf5gs3cyv71I3BjBURKlJs8z3CULHethTGKuS3LMpanAu+orge/YCZyR?=
 =?us-ascii?Q?Oe7Z1PrLwJ4uKbChJwO8WyUz8ZvfzlEtonohvuKNNPBoy5lYjJkQ9kgWfUxx?=
 =?us-ascii?Q?bOaU8/VB3/fW2c3YMt9TgTWegjl2b830O1cfuNVXQ2gypyuQEsFQwDZM0pZ0?=
 =?us-ascii?Q?5RuOOrRvZbSsEouDXpvwtxg7/ex9kI9Y+Vch0gxt2sNyn4jmihzQfvo+DDmL?=
 =?us-ascii?Q?R5BQOSs5JO1vffk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 17:17:26.4755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e558c1-c1d6-4381-62d9-08dd1f87d84d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801

When bridge binding is enabled on a VLAN netdevice, its link state should
track bridge ports that are members of the corresponding VLAN. This works
for newly-added netdevices. However toggling the option does not have the
effect of enabling or disabling the behavior as appropriate.

In this patch, react to bridge_binding toggles on VLAN uppers.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br.c         |  7 +++++++
 net/bridge/br_private.h |  9 +++++++++
 net/bridge/br_vlan.c    | 24 ++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 2cab878e0a39..183fcb362f9e 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -51,6 +51,13 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 		}
 	}
 
+	if (is_vlan_dev(dev)) {
+		struct net_device *real_dev = vlan_dev_real_dev(dev);
+
+		if (netif_is_bridge_master(real_dev))
+			br_vlan_vlan_upper_event(real_dev, dev, event);
+	}
+
 	/* not a port of a bridge */
 	p = br_port_get_rtnl(dev);
 	if (!p)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 9853cfbb9d14..29d6ec45cf41 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1571,6 +1571,9 @@ void br_vlan_get_stats(const struct net_bridge_vlan *v,
 void br_vlan_port_event(struct net_bridge_port *p, unsigned long event);
 int br_vlan_bridge_event(struct net_device *dev, unsigned long event,
 			 void *ptr);
+void br_vlan_vlan_upper_event(struct net_device *br_dev,
+			      struct net_device *vlan_dev,
+			      unsigned long event);
 int br_vlan_rtnl_init(void);
 void br_vlan_rtnl_uninit(void);
 void br_vlan_notify(const struct net_bridge *br,
@@ -1802,6 +1805,12 @@ static inline int br_vlan_bridge_event(struct net_device *dev,
 	return 0;
 }
 
+static inline void br_vlan_vlan_upper_event(struct net_device *br_dev,
+					    struct net_device *vlan_dev,
+					    unsigned long event)
+{
+}
+
 static inline int br_vlan_rtnl_init(void)
 {
 	return 0;
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index b728b71e693f..d9a69ec9affe 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1772,6 +1772,30 @@ int br_vlan_bridge_event(struct net_device *dev, unsigned long event, void *ptr)
 	return ret;
 }
 
+void br_vlan_vlan_upper_event(struct net_device *br_dev,
+			      struct net_device *vlan_dev,
+			      unsigned long event)
+{
+	struct vlan_dev_priv *vlan = vlan_dev_priv(vlan_dev);
+	struct net_bridge *br = netdev_priv(br_dev);
+	bool bridge_binding;
+
+	switch (event) {
+	case NETDEV_CHANGE:
+	case NETDEV_UP:
+		break;
+	default:
+		return;
+	}
+
+	bridge_binding = vlan->flags & VLAN_FLAG_BRIDGE_BINDING;
+	br_vlan_toggle_bridge_binding(br_dev, bridge_binding);
+	if (bridge_binding)
+		br_vlan_set_vlan_dev_state(br, vlan_dev);
+	else if (!bridge_binding && netif_carrier_ok(br_dev))
+		netif_carrier_on(vlan_dev);
+}
+
 /* Must be protected by RTNL. */
 void br_vlan_port_event(struct net_bridge_port *p, unsigned long event)
 {
-- 
2.47.0


