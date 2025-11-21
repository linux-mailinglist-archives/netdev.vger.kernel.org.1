Return-Path: <netdev+bounces-240794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FFDC7A8C7
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4414F4EE857
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155CD34FF41;
	Fri, 21 Nov 2025 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="icYJwEog"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF56332EA2
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738276; cv=fail; b=tmMzWeNbhla52kbEbM7OKh76eTOYircscLfx2GLPP1x+FJ/+BMZ1IvnK/bsBuIx49FY6fb/YUN3Cln+BVxRAgFW756uc85XStJQ1fHFf2wGhZJbwiR3sUTA1LJd3zJk3HlkcmAXel50pedFrISfAd6vP+bfhPPiRU6lpeg+6SiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738276; c=relaxed/simple;
	bh=Rg6infuoQi+pkY/ptB0M2AFSISCn4A6ABbTEQJl2DYY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Opn53f+IPr53o0+hhdSU+CqMvzx1rauNeJNSiTl01pGOMpxE3dqBhrfER8iCUIAQR338nvqZxbQFXvPrKuBctEZZrOsRuEjR6P+SKcmNGqGyMRp2TmV4QRqaTyRgyniFWQqPnqsX13dVf/kKrUzzVb6qm3ERwBuKUhOplNL8PWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=icYJwEog; arc=fail smtp.client-ip=52.101.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMBj5/vsxzTZfNP8YSzU79vvsbsWxQ0ZudHFPyLTLvK10t8q7Zdb01Qo2Ra297qTALYgVb/WbpWH1PwJqziHMg+ZJ7Zljb2ihdmUiOzCCkQudwhZ9MQb4M9r5Qn9VkE0u7NIPMquxuM2l/RuHFiexmEQYoICPNRGlazHjj2Fma9PNG1Jp1IEf0ZkXNA4pQRjuxOCiMV6IunEtcsZMTpRY2RaNpkOCkKNxMcA3pTTl0Gt0lzCFYw1uCf+iLuDlZj57OqMm7JDSGMltYsIwK7ofPKbWvqQK8uDi9dbkRdSO92QVncojIq89w1Ap1R1WCj352tO0fFiW/RsWlH8OxQ3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKXNohB6PiT1/fqUiWEao+CxyBzP4JIApPOazO7lgZg=;
 b=WVMbHZDhQdcq2DpDBvm6VZoPvOOTJ1eXQWb7fLT7wicteWZfBEWYOxeLhbJ3WnPe7mWZzX9aqMn6Tbb+ZjW6HQJxuhPgdAid3ucVFdPM77wtzTkkAeft3US6MDLZ/tpWnER4SSU84n966WjMa3c7XcciWytvukdOu0aLCqeeERjJzOaifSHh2+g8Xad9hn6U5yVJA8hs3X3qEGavyeuVDA6ukNRwArNlGlxZRRxCp6e/bWsH2YVDcYgcB7Q3Gim4N1X41V1H6MW7wJCJqglwi/exVZzvzAsN/mwSpbEIURnVlg1+V8UqG0PTHknFScbhHGTDWqaPMKTDKYnBSYURaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKXNohB6PiT1/fqUiWEao+CxyBzP4JIApPOazO7lgZg=;
 b=icYJwEogZ2cfPWDSQ8/uJGeKh3hHqk7dYF+NxZysxm8gJ4jCLYSVYCPqR0z5qTDRfCuu0dtf1mYIuFODXntcWasM8RZFFLjL1uftdtBCNHvuemHmIO/uLIjvBN/TNYls6bk9OtZwy/72unkDNFpxtXmYtDLe2rLYGMOs14fwpc8h2i53FE7mdGdQoBeHTjLkCh0OS6uxsAIzsMnjBLshVSLRC+mhr8WKy6syJTJJrMs5ZnkRupFDpQQcy8fXhHRkxbOsyKumY9o50wOALukKbE5bqFFblawX1p1j7mWRdO4VjtGHLRTbg1k3XRCuvGlVvhKhEzruFay79s8neYXBJg==
Received: from SJ0PR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:33f::32)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Fri, 21 Nov
 2025 15:17:37 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::50) by SJ0PR05CA0057.outlook.office365.com
 (2603:10b6:a03:33f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Fri,
 21 Nov 2025 15:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 15:17:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 07:17:20 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 21 Nov 2025 07:17:16 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>, Jianbo Liu
	<jianbol@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [RFC PATCH ipsec 1/2] xfrm: Add explicit offload_handle to some xfrm callbacks
Date: Fri, 21 Nov 2025 17:16:43 +0200
Message-ID: <20251121151644.1797728-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251121151644.1797728-1-cratiu@nvidia.com>
References: <20251121151644.1797728-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: 4611defd-42d2-4544-bc8f-08de29111aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T+I0XYfxxvGIebnHus9WUjg/jJAwcMJmtG8YZGm+njGpHaxLOHYH2R9bqTWJ?=
 =?us-ascii?Q?STMiuY9Tw2xmRVVWoEgeE9wJ2Xyyw0WolY404Q+qbQaPnFOWvoUKgqg5VKJ9?=
 =?us-ascii?Q?sW+uFdWemEYSc/CWCQsj2Z+cWeIVTOCm+T0lwpHaGuEapMa2/KAqhsJpYM0x?=
 =?us-ascii?Q?+zFfyg3xRYZ/upOXJKUTcEkcGX4yNIVarBou2sPU/7dVo+8bWpn+y4jfk4mr?=
 =?us-ascii?Q?G1L+OBB77TT+lSDPG7BDA31qyvERXK2erb4kEL2H4LwLmt6e0ex1h02tXtfb?=
 =?us-ascii?Q?CP/QsJVlhihsrje+dNq8W+WVFhFgcsLjDS7JMPs6A618c7344BjHvzOIwAWN?=
 =?us-ascii?Q?1Rb/3VM5dV87LGJH5NYzMFzO/Vlk/reEghFpx9Xtt8UTWnNLLoMkXYR4SGOD?=
 =?us-ascii?Q?UgJ566TCuMSjq7gUE2QAoaKmMNuKaXC2Df7IJEnltTRa9jQ6gPVLJJU1KAIM?=
 =?us-ascii?Q?Qix9m78jV1gxUecUKTpptaIQ024WAriezeQeKGN4iQ9hM1W7lEJlGKBKQ3Ek?=
 =?us-ascii?Q?JA2/2sZmQoQ6PUxBHAK42zVzkSsWoo0StkXp6mUm3+VanBKKOBsIDbBfI3zf?=
 =?us-ascii?Q?rYHkfD+LdcmMZDVnI8qVVU+zaHY7g0C0sVmpv8O/8yHgB+Pi/e1sRXzyIdEt?=
 =?us-ascii?Q?nj3j9YxTtDUtK7QHyhXcOqtuer5y34veMeNxPh9+AzileWSRH0XEzfpzlvut?=
 =?us-ascii?Q?2DRYpOejfrEgZVsw0kNl1Qio5Li21A0/7+HdTaF32KN2kIudSJwy6V4zyJUX?=
 =?us-ascii?Q?J2SMUgbo5O3HhBlIoVnsEHc9zyl/PVZhj7XjnNVh2ibUPc5gSeUepjjOc6H2?=
 =?us-ascii?Q?s2fgHuALdsBV57PtEvg1Cyyqp87OPQYUaf+PY5HCbSLJKseMnh9tNWCGUSqT?=
 =?us-ascii?Q?54NFZZxnQI1/xpvjN3HEKrsVtct8Bu7ruTcliBNOzVvC3I/OQ1DCUwH45Ky1?=
 =?us-ascii?Q?t01O3/NO/a0+g4JEqQzCzTRJJijdBI62ziAgxjZEmrZJ9JS9Ss/mF32RXbQ5?=
 =?us-ascii?Q?QBkg/nRIBhTZDtfAxvR/SFFyQRfjhuK25n9M5P7zlfwVVR0cWQzDoGwolprl?=
 =?us-ascii?Q?phXma7I6MWMKPMozveAU02gOm+shZKS0Gss5i5LzD/QifKzFi2867dXsFW9O?=
 =?us-ascii?Q?HNJ3gTTCvWbDLLMqXPjGGV13xY04xheXhbk2iQbmA26K4etOtJ5un8Gc4s/7?=
 =?us-ascii?Q?fapx/h1SWcwRvlo4LqFqSdrQM0o7mMGzIT2dsuMcBV9Q66PSIOAfixbmZZm9?=
 =?us-ascii?Q?pNZ8gArpmnG/Rc+vn7TyJUiTkysqbkOAPUtn2BfylgEt8DQHjP70MJpMwvIQ?=
 =?us-ascii?Q?AOqRXngwVhE4cRzzfZsLHBoTx30+moYXZLK0zzkR4vE/unaA87inHHSUAw/+?=
 =?us-ascii?Q?/GuubQKbCrVAa5HcCYRO8IdZPt3+opJDTnnMmIcUVO8zGTlWLJHIZE/3b+Qi?=
 =?us-ascii?Q?UAasVYL9b3nSLnJsY4hW5kMAWNzIA2X8XnpaxKD48+sL5ngKNtodSxJ2rQqw?=
 =?us-ascii?Q?q9p5FXdbXL3PMJFR9qsEp3z6zTDNHAw/W+bVT3jfdtPovOf6JZCbdOFaX4YS?=
 =?us-ascii?Q?o1TB1In6aFWr3NOsrjk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:17:37.0189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4611defd-42d2-4544-bc8f-08de29111aa6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079

The offload handle is an opaque driver-managed value for an xfrm_state
offload and is stored in xs->xso.offload_handle.
But drivers accessing it directly means there is a 1:1 association
between an xfrm_state and a device that state is offloaded on.

Remove that 1:1 mapping by passing offload_handle as an argument to
callbacks adding, deleting and freeing xfrm_states.

This unfortunately makes these API calls more verbose, but is necessary
in the subsequent patch to fix some unpleasant bonding ipsec bugs.

After this patch, the meaning of xs->xso.offload_handle becomes 'the
offload handle on the active device where this xfrm_state is offloaded'
which implies there can be at most one such active device. The offload
handle is still used directly in the xmit path.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 Documentation/networking/xfrm_device.rst      | 13 +++--
 drivers/net/bonding/bond_main.c               | 57 ++++++++++++-------
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 20 +++++--
 .../inline_crypto/ch_ipsec/chcr_ipsec.c       | 25 ++++----
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    | 47 +++++++++------
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    | 18 +++---
 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 13 +++--
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 26 +++++----
 .../net/ethernet/netronome/nfp/crypto/ipsec.c | 10 ++--
 drivers/net/netdevsim/ipsec.c                 |  8 ++-
 include/linux/netdevice.h                     |  7 ++-
 net/xfrm/xfrm_device.c                        |  3 +-
 net/xfrm/xfrm_state.c                         |  7 ++-
 13 files changed, 159 insertions(+), 95 deletions(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 122204da0fff..0f9291469a5e 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -67,14 +67,19 @@ Callbacks to implement
         /* Crypto and Packet offload callbacks */
 	int	(*xdo_dev_state_add)(struct net_device *dev,
                                      struct xfrm_state *x,
+				     unsigned long *offload_handle,
                                      struct netlink_ext_ack *extack);
 	void	(*xdo_dev_state_delete)(struct net_device *dev,
-                                        struct xfrm_state *x);
+                                        struct xfrm_state *x,
+					unsigned long offload_handle);
 	void	(*xdo_dev_state_free)(struct net_device *dev,
-                                      struct xfrm_state *x);
+				      struct xfrm_state *x,
+				      unsigned long offload_handle);
 	bool	(*xdo_dev_offload_ok) (struct sk_buff *skb,
-				       struct xfrm_state *x);
-	void    (*xdo_dev_state_advance_esn) (struct xfrm_state *x);
+				       struct xfrm_state *x,
+				       unsigned long offload_handle);
+	void	(*xdo_dev_state_advance_esn) (struct xfrm_state *x,
+					      unsigned long offload_handle);
 	void    (*xdo_dev_state_update_stats) (struct xfrm_state *x);
 
         /* Solely packet offload callbacks */
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e95e593cd12d..4c5b73786877 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -456,10 +456,12 @@ static struct net_device *bond_ipsec_dev(struct xfrm_state *xs)
  * bond_ipsec_add_sa - program device with a security association
  * @bond_dev: pointer to the bond net device
  * @xs: pointer to transformer state struct
+ * @offload_handle: pointer to resulting offload handle
  * @extack: extack point to fill failure reason
  **/
 static int bond_ipsec_add_sa(struct net_device *bond_dev,
 			     struct xfrm_state *xs,
+			     unsigned long *offload_handle,
 			     struct netlink_ext_ack *extack)
 {
 	struct net_device *real_dev;
@@ -497,7 +499,8 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
 		goto out;
 	}
 
-	err = real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev, xs, extack);
+	err = real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev, xs,
+						       offload_handle, extack);
 	if (!err) {
 		xs->xso.real_dev = real_dev;
 		ipsec->xs = xs;
@@ -537,29 +540,33 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	}
 
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		struct xfrm_state *xs = ipsec->xs;
+
 		/* If new state is added before ipsec_lock acquired */
-		if (ipsec->xs->xso.real_dev == real_dev)
+		if (xs->xso.real_dev == real_dev)
 			continue;
 
-		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
-							     ipsec->xs, NULL)) {
+		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev, xs,
+							     &xs->xso.offload_handle,
+							     NULL)) {
 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
 			continue;
 		}
 
-		spin_lock_bh(&ipsec->xs->lock);
+		spin_lock_bh(&xs->lock);
 		/* xs might have been killed by the user during the migration
 		 * to the new dev, but bond_ipsec_del_sa() should have done
 		 * nothing, as xso.real_dev is NULL.
 		 * Delete it from the device we just added it to. The pending
 		 * bond_ipsec_free_sa() call will do the rest of the cleanup.
 		 */
-		if (ipsec->xs->km.state == XFRM_STATE_DEAD &&
+		if (xs->km.state == XFRM_STATE_DEAD &&
 		    real_dev->xfrmdev_ops->xdo_dev_state_delete)
 			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
-								    ipsec->xs);
-		ipsec->xs->xso.real_dev = real_dev;
-		spin_unlock_bh(&ipsec->xs->lock);
+								    xs,
+								    xs->xso.offload_handle);
+		xs->xso.real_dev = real_dev;
+		spin_unlock_bh(&xs->lock);
 	}
 out:
 	mutex_unlock(&bond->ipsec_lock);
@@ -569,9 +576,11 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
  * bond_ipsec_del_sa - clear out this specific SA
  * @bond_dev: pointer to the bond net device
  * @xs: pointer to transformer state struct
+ * @offload_handle: offload handle to delete
  **/
 static void bond_ipsec_del_sa(struct net_device *bond_dev,
-			      struct xfrm_state *xs)
+			      struct xfrm_state *xs,
+			      unsigned long offload_handle)
 {
 	struct net_device *real_dev;
 
@@ -587,7 +596,8 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
 		return;
 	}
 
-	real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev, xs);
+	real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev, xs,
+						    offload_handle);
 }
 
 static void bond_ipsec_del_sa_all(struct bonding *bond)
@@ -604,7 +614,9 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 
 	mutex_lock(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		if (!ipsec->xs->xso.real_dev)
+		struct xfrm_state *xs = ipsec->xs;
+
+		if (!xs->xso.real_dev)
 			continue;
 
 		if (!real_dev->xfrmdev_ops ||
@@ -616,23 +628,25 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 			continue;
 		}
 
-		spin_lock_bh(&ipsec->xs->lock);
-		ipsec->xs->xso.real_dev = NULL;
+		spin_lock_bh(&xs->lock);
+		xs->xso.real_dev = NULL;
 		/* Don't double delete states killed by the user. */
-		if (ipsec->xs->km.state != XFRM_STATE_DEAD)
+		if (xs->km.state != XFRM_STATE_DEAD)
 			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
-								    ipsec->xs);
-		spin_unlock_bh(&ipsec->xs->lock);
+								    xs,
+								    xs->xso.offload_handle);
+		spin_unlock_bh(&xs->lock);
 
 		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
-			real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev,
-								  ipsec->xs);
+			real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs,
+								  xs->xso.offload_handle);
 	}
 	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_free_sa(struct net_device *bond_dev,
-			       struct xfrm_state *xs)
+			       struct xfrm_state *xs,
+			       unsigned long offload_handle)
 {
 	struct net_device *real_dev;
 	struct bond_ipsec *ipsec;
@@ -652,7 +666,8 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
 	xs->xso.real_dev = NULL;
 	if (real_dev->xfrmdev_ops &&
 	    real_dev->xfrmdev_ops->xdo_dev_state_free)
-		real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs);
+		real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs,
+							  offload_handle);
 out:
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
 		if (ipsec->xs == xs) {
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 392723ef14e5..3db034a2db13 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -6482,9 +6482,11 @@ static const struct tlsdev_ops cxgb4_ktls_ops = {
 
 static int cxgb4_xfrm_add_state(struct net_device *dev,
 				struct xfrm_state *x,
+				unsigned long *offload_handle,
 				struct netlink_ext_ack *extack)
 {
 	struct adapter *adap = netdev2adap(dev);
+	const struct xfrmdev_ops *ops;
 	int ret;
 
 	if (!mutex_trylock(&uld_mutex)) {
@@ -6495,8 +6497,8 @@ static int cxgb4_xfrm_add_state(struct net_device *dev,
 	if (ret)
 		goto out_unlock;
 
-	ret = adap->uld[CXGB4_ULD_IPSEC].xfrmdev_ops->xdo_dev_state_add(dev, x,
-									extack);
+	ops = adap->uld[CXGB4_ULD_IPSEC].xfrmdev_ops;
+	ret = ops->xdo_dev_state_add(dev, x, offload_handle, extack);
 
 out_unlock:
 	mutex_unlock(&uld_mutex);
@@ -6504,9 +6506,11 @@ static int cxgb4_xfrm_add_state(struct net_device *dev,
 	return ret;
 }
 
-static void cxgb4_xfrm_del_state(struct net_device *dev, struct xfrm_state *x)
+static void cxgb4_xfrm_del_state(struct net_device *dev, struct xfrm_state *x,
+				 unsigned long offload_handle)
 {
 	struct adapter *adap = netdev2adap(dev);
+	const struct xfrmdev_ops *ops;
 
 	if (!mutex_trylock(&uld_mutex)) {
 		dev_dbg(adap->pdev_dev,
@@ -6516,15 +6520,18 @@ static void cxgb4_xfrm_del_state(struct net_device *dev, struct xfrm_state *x)
 	if (chcr_offload_state(adap, CXGB4_XFRMDEV_OPS))
 		goto out_unlock;
 
-	adap->uld[CXGB4_ULD_IPSEC].xfrmdev_ops->xdo_dev_state_delete(dev, x);
+	ops = adap->uld[CXGB4_ULD_IPSEC].xfrmdev_ops;
+	ops->xdo_dev_state_delete(dev, x, offload_handle);
 
 out_unlock:
 	mutex_unlock(&uld_mutex);
 }
 
-static void cxgb4_xfrm_free_state(struct net_device *dev, struct xfrm_state *x)
+static void cxgb4_xfrm_free_state(struct net_device *dev, struct xfrm_state *x,
+				  unsigned long offload_handle)
 {
 	struct adapter *adap = netdev2adap(dev);
+	const struct xfrmdev_ops *ops;
 
 	if (!mutex_trylock(&uld_mutex)) {
 		dev_dbg(adap->pdev_dev,
@@ -6534,7 +6541,8 @@ static void cxgb4_xfrm_free_state(struct net_device *dev, struct xfrm_state *x)
 	if (chcr_offload_state(adap, CXGB4_XFRMDEV_OPS))
 		goto out_unlock;
 
-	adap->uld[CXGB4_ULD_IPSEC].xfrmdev_ops->xdo_dev_state_free(dev, x);
+	ops = adap->uld[CXGB4_ULD_IPSEC].xfrmdev_ops;
+	ops->xdo_dev_state_free(dev, x, offload_handle);
 
 out_unlock:
 	mutex_unlock(&uld_mutex);
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
index 49b57bb5fac1..90a101711a98 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
@@ -76,11 +76,14 @@ static int ch_ipsec_xmit(struct sk_buff *skb, struct net_device *dev);
 static void *ch_ipsec_uld_add(const struct cxgb4_lld_info *infop);
 static void ch_ipsec_advance_esn_state(struct xfrm_state *x);
 static void ch_ipsec_xfrm_free_state(struct net_device *dev,
-				     struct xfrm_state *x);
+				     struct xfrm_state *x,
+				     unsigned long offload_handle);
 static void ch_ipsec_xfrm_del_state(struct net_device *dev,
-				    struct xfrm_state *x);
+				    struct xfrm_state *x,
+				    unsigned long offload_handle);
 static int ch_ipsec_xfrm_add_state(struct net_device *dev,
 				   struct xfrm_state *x,
+				   unsigned long *offload_handle,
 				   struct netlink_ext_ack *extack);
 
 static const struct xfrmdev_ops ch_ipsec_xfrmdev_ops = {
@@ -228,6 +231,7 @@ static int ch_ipsec_setkey(struct xfrm_state *x,
  */
 static int ch_ipsec_xfrm_add_state(struct net_device *dev,
 				   struct xfrm_state *x,
+				   unsigned long *offload_handle,
 				   struct netlink_ext_ack *extack)
 {
 	struct ipsec_sa_entry *sa_entry;
@@ -306,29 +310,28 @@ static int ch_ipsec_xfrm_add_state(struct net_device *dev,
 	if (x->props.flags & XFRM_STATE_ESN)
 		sa_entry->esn = 1;
 	ch_ipsec_setkey(x, sa_entry);
-	x->xso.offload_handle = (unsigned long)sa_entry;
+	*offload_handle = (unsigned long)sa_entry;
 out:
 	return res;
 }
 
 static void ch_ipsec_xfrm_del_state(struct net_device *dev,
-				    struct xfrm_state *x)
+				    struct xfrm_state *x,
+				    unsigned long offload_handle)
 {
 	/* do nothing */
-	if (!x->xso.offload_handle)
+	if (!offload_handle)
 		return;
 }
 
 static void ch_ipsec_xfrm_free_state(struct net_device *dev,
-				     struct xfrm_state *x)
+				     struct xfrm_state *x,
+				     unsigned long offload_handle)
 {
-	struct ipsec_sa_entry *sa_entry;
-
-	if (!x->xso.offload_handle)
+	if (!offload_handle)
 		return;
 
-	sa_entry = (struct ipsec_sa_entry *)x->xso.offload_handle;
-	kfree(sa_entry);
+	kfree((struct ipsec_sa_entry *)offload_handle);
 	module_put(THIS_MODULE);
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index d1f4073b36f9..385413206887 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -9,7 +9,8 @@
 #define IXGBE_IPSEC_KEY_BITS  160
 static const char aes_gcm_name[] = "rfc4106(gcm(aes))";
 
-static void ixgbe_ipsec_del_sa(struct net_device *dev, struct xfrm_state *xs);
+static void ixgbe_ipsec_del_sa(struct net_device *dev, struct xfrm_state *xs,
+			       unsigned long offload_handle);
 
 /**
  * ixgbe_ipsec_set_tx_sa - set the Tx SA registers
@@ -321,7 +322,8 @@ void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter)
 
 		if (r->used) {
 			if (r->mode & IXGBE_RXTXMOD_VF)
-				ixgbe_ipsec_del_sa(adapter->netdev, r->xs);
+				ixgbe_ipsec_del_sa(adapter->netdev, r->xs,
+						   r->xs->xso.offload_handle);
 			else
 				ixgbe_ipsec_set_rx_sa(hw, i, r->xs->id.spi,
 						      r->key, r->salt,
@@ -330,7 +332,8 @@ void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter)
 
 		if (t->used) {
 			if (t->mode & IXGBE_RXTXMOD_VF)
-				ixgbe_ipsec_del_sa(adapter->netdev, t->xs);
+				ixgbe_ipsec_del_sa(adapter->netdev, t->xs,
+						   t->xs->xso.offload_handle);
 			else
 				ixgbe_ipsec_set_tx_sa(hw, i, t->key, t->salt);
 		}
@@ -560,10 +563,12 @@ static int ixgbe_ipsec_check_mgmt_ip(struct net_device *dev,
  * ixgbe_ipsec_add_sa - program device with a security association
  * @dev: pointer to device to program
  * @xs: pointer to transformer state struct
+ * @offload_handle: pointer to resulting offload handle
  * @extack: extack point to fill failure reason
  **/
 static int ixgbe_ipsec_add_sa(struct net_device *dev,
 			      struct xfrm_state *xs,
+			      unsigned long *offload_handle,
 			      struct netlink_ext_ack *extack)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
@@ -698,7 +703,7 @@ static int ixgbe_ipsec_add_sa(struct net_device *dev,
 
 		ixgbe_ipsec_set_rx_sa(hw, sa_idx, rsa.xs->id.spi, rsa.key,
 				      rsa.salt, rsa.mode, rsa.iptbl_ind);
-		xs->xso.offload_handle = sa_idx + IXGBE_IPSEC_BASE_RX_INDEX;
+		*offload_handle = sa_idx + IXGBE_IPSEC_BASE_RX_INDEX;
 
 		ipsec->num_rx_sa++;
 
@@ -739,7 +744,7 @@ static int ixgbe_ipsec_add_sa(struct net_device *dev,
 
 		ixgbe_ipsec_set_tx_sa(hw, sa_idx, tsa.key, tsa.salt);
 
-		xs->xso.offload_handle = sa_idx + IXGBE_IPSEC_BASE_TX_INDEX;
+		*offload_handle = sa_idx + IXGBE_IPSEC_BASE_TX_INDEX;
 
 		ipsec->num_tx_sa++;
 	}
@@ -757,8 +762,10 @@ static int ixgbe_ipsec_add_sa(struct net_device *dev,
  * ixgbe_ipsec_del_sa - clear out this specific SA
  * @dev: pointer to device to program
  * @xs: pointer to transformer state struct
+ * @offload_handle: offload handle to delete
  **/
-static void ixgbe_ipsec_del_sa(struct net_device *dev, struct xfrm_state *xs)
+static void ixgbe_ipsec_del_sa(struct net_device *dev, struct xfrm_state *xs,
+			       unsigned long offload_handle)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
 	struct ixgbe_ipsec *ipsec = adapter->ipsec;
@@ -770,12 +777,12 @@ static void ixgbe_ipsec_del_sa(struct net_device *dev, struct xfrm_state *xs)
 		struct rx_sa *rsa;
 		u8 ipi;
 
-		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_RX_INDEX;
+		sa_idx = offload_handle - IXGBE_IPSEC_BASE_RX_INDEX;
 		rsa = &ipsec->rx_tbl[sa_idx];
 
 		if (!rsa->used) {
 			netdev_err(dev, "Invalid Rx SA selected sa_idx=%d offload_handle=%lu\n",
-				   sa_idx, xs->xso.offload_handle);
+				   sa_idx, offload_handle);
 			return;
 		}
 
@@ -800,11 +807,11 @@ static void ixgbe_ipsec_del_sa(struct net_device *dev, struct xfrm_state *xs)
 		memset(rsa, 0, sizeof(struct rx_sa));
 		ipsec->num_rx_sa--;
 	} else {
-		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_TX_INDEX;
+		sa_idx = offload_handle - IXGBE_IPSEC_BASE_TX_INDEX;
 
 		if (!ipsec->tx_tbl[sa_idx].used) {
 			netdev_err(dev, "Invalid Tx SA selected sa_idx=%d offload_handle=%lu\n",
-				   sa_idx, xs->xso.offload_handle);
+				   sa_idx, offload_handle);
 			return;
 		}
 
@@ -833,6 +840,7 @@ static const struct xfrmdev_ops ixgbe_xfrmdev_ops = {
 void ixgbe_ipsec_vf_clear(struct ixgbe_adapter *adapter, u32 vf)
 {
 	struct ixgbe_ipsec *ipsec = adapter->ipsec;
+	struct xfrm_state *xs;
 	int i;
 
 	if (!ipsec)
@@ -843,9 +851,11 @@ void ixgbe_ipsec_vf_clear(struct ixgbe_adapter *adapter, u32 vf)
 		if (!ipsec->rx_tbl[i].used)
 			continue;
 		if (ipsec->rx_tbl[i].mode & IXGBE_RXTXMOD_VF &&
-		    ipsec->rx_tbl[i].vf == vf)
+		    ipsec->rx_tbl[i].vf == vf) {
+			xs = ipsec->rx_tbl[i].xs;
 			ixgbe_ipsec_del_sa(adapter->netdev,
-					   ipsec->rx_tbl[i].xs);
+					   xs, xs->xso.offload_handle);
+		}
 	}
 
 	/* search tx sa table */
@@ -853,9 +863,11 @@ void ixgbe_ipsec_vf_clear(struct ixgbe_adapter *adapter, u32 vf)
 		if (!ipsec->tx_tbl[i].used)
 			continue;
 		if (ipsec->tx_tbl[i].mode & IXGBE_RXTXMOD_VF &&
-		    ipsec->tx_tbl[i].vf == vf)
-			ixgbe_ipsec_del_sa(adapter->netdev,
-					   ipsec->tx_tbl[i].xs);
+		    ipsec->tx_tbl[i].vf == vf) {
+			xs = ipsec->tx_tbl[i].xs;
+			ixgbe_ipsec_del_sa(adapter->netdev, xs,
+					   xs->xso.offload_handle);
+		}
 	}
 }
 
@@ -935,7 +947,8 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 	memcpy(xs->aead->alg_name, aes_gcm_name, sizeof(aes_gcm_name));
 
 	/* set up the HW offload */
-	err = ixgbe_ipsec_add_sa(adapter->netdev, xs, NULL);
+	err = ixgbe_ipsec_add_sa(adapter->netdev, xs, &xs->xso.offload_handle,
+				 NULL);
 	if (err)
 		goto err_aead;
 
@@ -1039,7 +1052,7 @@ int ixgbe_ipsec_vf_del_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 		xs = ipsec->tx_tbl[sa_idx].xs;
 	}
 
-	ixgbe_ipsec_del_sa(adapter->netdev, xs);
+	ixgbe_ipsec_del_sa(adapter->netdev, xs, xs->xso.offload_handle);
 
 	/* remove the xs that was made-up in the add request */
 	kfree_sensitive(xs);
diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index fce35924ff8b..6d5585f51991 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -259,10 +259,12 @@ static int ixgbevf_ipsec_parse_proto_keys(struct net_device *dev,
  * ixgbevf_ipsec_add_sa - program device with a security association
  * @dev: pointer to net device to program
  * @xs: pointer to transformer state struct
+ * @offload_handle: pointer to resulting offload_handle
  * @extack: extack point to fill failure reason
  **/
 static int ixgbevf_ipsec_add_sa(struct net_device *dev,
 				struct xfrm_state *xs,
+				unsigned long *offload_handle,
 				struct netlink_ext_ack *extack)
 {
 	struct ixgbevf_adapter *adapter;
@@ -344,7 +346,7 @@ static int ixgbevf_ipsec_add_sa(struct net_device *dev,
 		/* the preparations worked, so save the info */
 		memcpy(&ipsec->rx_tbl[sa_idx], &rsa, sizeof(rsa));
 
-		xs->xso.offload_handle = sa_idx + IXGBE_IPSEC_BASE_RX_INDEX;
+		*offload_handle = sa_idx + IXGBE_IPSEC_BASE_RX_INDEX;
 
 		ipsec->num_rx_sa++;
 
@@ -385,7 +387,7 @@ static int ixgbevf_ipsec_add_sa(struct net_device *dev,
 		/* the preparations worked, so save the info */
 		memcpy(&ipsec->tx_tbl[sa_idx], &tsa, sizeof(tsa));
 
-		xs->xso.offload_handle = sa_idx + IXGBE_IPSEC_BASE_TX_INDEX;
+		*offload_handle = sa_idx + IXGBE_IPSEC_BASE_TX_INDEX;
 
 		ipsec->num_tx_sa++;
 	}
@@ -397,9 +399,11 @@ static int ixgbevf_ipsec_add_sa(struct net_device *dev,
  * ixgbevf_ipsec_del_sa - clear out this specific SA
  * @dev: pointer to net device to program
  * @xs: pointer to transformer state struct
+ * @offload_handle: offload handle to remove
  **/
 static void ixgbevf_ipsec_del_sa(struct net_device *dev,
-				 struct xfrm_state *xs)
+				 struct xfrm_state *xs,
+				 unsigned long offload_handle)
 {
 	struct ixgbevf_adapter *adapter;
 	struct ixgbevf_ipsec *ipsec;
@@ -412,11 +416,11 @@ static void ixgbevf_ipsec_del_sa(struct net_device *dev,
 		return;
 
 	if (xs->xso.dir == XFRM_DEV_OFFLOAD_IN) {
-		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_RX_INDEX;
+		sa_idx = offload_handle - IXGBE_IPSEC_BASE_RX_INDEX;
 
 		if (!ipsec->rx_tbl[sa_idx].used) {
 			netdev_err(dev, "Invalid Rx SA selected sa_idx=%d offload_handle=%lu\n",
-				   sa_idx, xs->xso.offload_handle);
+				   sa_idx, offload_handle);
 			return;
 		}
 
@@ -425,11 +429,11 @@ static void ixgbevf_ipsec_del_sa(struct net_device *dev,
 		memset(&ipsec->rx_tbl[sa_idx], 0, sizeof(struct rx_sa));
 		ipsec->num_rx_sa--;
 	} else {
-		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_TX_INDEX;
+		sa_idx = offload_handle - IXGBE_IPSEC_BASE_TX_INDEX;
 
 		if (!ipsec->tx_tbl[sa_idx].used) {
 			netdev_err(dev, "Invalid Tx SA selected sa_idx=%d offload_handle=%lu\n",
-				   sa_idx, xs->xso.offload_handle);
+				   sa_idx, offload_handle);
 			return;
 		}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 77543d472345..8f65106e5f20 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -665,6 +665,7 @@ static int cn10k_ipsec_inb_add_state(struct xfrm_state *x,
 
 static int cn10k_ipsec_outb_add_state(struct net_device *dev,
 				      struct xfrm_state *x,
+				      unsigned long *offload_handle,
 				      struct netlink_ext_ack *extack)
 {
 	struct cn10k_tx_sa_s *sa_entry;
@@ -692,7 +693,7 @@ static int cn10k_ipsec_outb_add_state(struct net_device *dev,
 		return err;
 	}
 
-	x->xso.offload_handle = (unsigned long)sa_info;
+	*offload_handle = (unsigned long)sa_info;
 	/* Enable static branch when first SA setup */
 	if (!pf->ipsec.outb_sa_count)
 		static_branch_enable(&cn10k_ipsec_sa_enabled);
@@ -702,15 +703,18 @@ static int cn10k_ipsec_outb_add_state(struct net_device *dev,
 
 static int cn10k_ipsec_add_state(struct net_device *dev,
 				 struct xfrm_state *x,
+				 unsigned long *offload_handle,
 				 struct netlink_ext_ack *extack)
 {
 	if (x->xso.dir == XFRM_DEV_OFFLOAD_IN)
 		return cn10k_ipsec_inb_add_state(x, extack);
 	else
-		return cn10k_ipsec_outb_add_state(dev, x, extack);
+		return cn10k_ipsec_outb_add_state(dev, x, offload_handle,
+						  extack);
 }
 
-static void cn10k_ipsec_del_state(struct net_device *dev, struct xfrm_state *x)
+static void cn10k_ipsec_del_state(struct net_device *dev, struct xfrm_state *x,
+				  unsigned long offload_handle)
 {
 	struct cn10k_tx_sa_s *sa_entry;
 	struct qmem *sa_info;
@@ -722,7 +726,7 @@ static void cn10k_ipsec_del_state(struct net_device *dev, struct xfrm_state *x)
 
 	pf = netdev_priv(dev);
 
-	sa_info = (struct qmem *)x->xso.offload_handle;
+	sa_info = (struct qmem *)offload_handle;
 	sa_entry = (struct cn10k_tx_sa_s *)sa_info->base;
 	memset(sa_entry, 0, sizeof(struct cn10k_tx_sa_s));
 	/* Disable SA in CPT h/w */
@@ -734,7 +738,6 @@ static void cn10k_ipsec_del_state(struct net_device *dev, struct xfrm_state *x)
 	if (err)
 		netdev_err(dev, "Error (%d) deleting SA\n", err);
 
-	x->xso.offload_handle = 0;
 	qmem_free(pf->dev, sa_info);
 
 	/* If no more SA's then update netdev feature for potential change
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 801527947c23..a83403b1101b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -47,11 +47,6 @@
 #define MLX5_IPSEC_RESCHED msecs_to_jiffies(1000)
 #define MLX5E_IPSEC_TUNNEL_SA XA_MARK_1
 
-static struct mlx5e_ipsec_sa_entry *to_ipsec_sa_entry(struct xfrm_state *x)
-{
-	return (struct mlx5e_ipsec_sa_entry *)x->xso.offload_handle;
-}
-
 static struct mlx5e_ipsec_pol_entry *to_ipsec_pol_entry(struct xfrm_policy *x)
 {
 	return (struct mlx5e_ipsec_pol_entry *)x->xdo.offload_handle;
@@ -767,6 +762,7 @@ static int mlx5e_ipsec_create_dwork(struct mlx5e_ipsec_sa_entry *sa_entry)
 
 static int mlx5e_xfrm_add_state(struct net_device *dev,
 				struct xfrm_state *x,
+				unsigned long *offload_handle,
 				struct netlink_ext_ack *extack)
 {
 	struct mlx5e_ipsec_sa_entry *sa_entry = NULL;
@@ -868,7 +864,7 @@ static int mlx5e_xfrm_add_state(struct net_device *dev,
 	}
 
 out:
-	x->xso.offload_handle = (unsigned long)sa_entry;
+	*offload_handle = (unsigned long)sa_entry;
 	if (allow_tunnel_mode)
 		mlx5_eswitch_unblock_encap(priv->mdev);
 
@@ -899,9 +895,11 @@ static int mlx5e_xfrm_add_state(struct net_device *dev,
 	return err;
 }
 
-static void mlx5e_xfrm_del_state(struct net_device *dev, struct xfrm_state *x)
+static void mlx5e_xfrm_del_state(struct net_device *dev, struct xfrm_state *x,
+				 unsigned long offload_handle)
 {
-	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
+	struct mlx5e_ipsec_sa_entry *sa_entry =
+		(struct mlx5e_ipsec_sa_entry *)offload_handle;
 	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
 	struct mlx5e_ipsec_sa_entry *old;
 
@@ -912,9 +910,11 @@ static void mlx5e_xfrm_del_state(struct net_device *dev, struct xfrm_state *x)
 	WARN_ON(old != sa_entry);
 }
 
-static void mlx5e_xfrm_free_state(struct net_device *dev, struct xfrm_state *x)
+static void mlx5e_xfrm_free_state(struct net_device *dev, struct xfrm_state *x,
+				  unsigned long offload_handle)
 {
-	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
+	struct mlx5e_ipsec_sa_entry *sa_entry =
+		(struct mlx5e_ipsec_sa_entry *)offload_handle;
 	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
 
 	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
@@ -1054,7 +1054,8 @@ void mlx5e_ipsec_cleanup(struct mlx5e_priv *priv)
 
 static void mlx5e_xfrm_advance_esn_state(struct xfrm_state *x)
 {
-	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
+	struct mlx5e_ipsec_sa_entry *sa_entry =
+		(struct mlx5e_ipsec_sa_entry *)x->xso.offload_handle;
 	struct mlx5e_ipsec_work *work = sa_entry->work;
 	bool need_update;
 
@@ -1068,7 +1069,8 @@ static void mlx5e_xfrm_advance_esn_state(struct xfrm_state *x)
 
 static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 {
-	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
+	struct mlx5e_ipsec_sa_entry *sa_entry =
+		(struct mlx5e_ipsec_sa_entry *)x->xso.offload_handle;
 	struct mlx5e_ipsec_rule *ipsec_rule = &sa_entry->ipsec_rule;
 	struct net *net = dev_net(x->xso.dev);
 	u64 trailer_packets = 0, trailer_bytes = 0;
diff --git a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
index 9e7c285eaa6b..c259c40bc867 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
@@ -268,6 +268,7 @@ static void set_sha2_512hmac(struct nfp_ipsec_cfg_add_sa *cfg, int *trunc_len)
 
 static int nfp_net_xfrm_add_state(struct net_device *dev,
 				  struct xfrm_state *x,
+				  unsigned long *offload_handle,
 				  struct netlink_ext_ack *extack)
 {
 	struct nfp_ipsec_cfg_mssg msg = {};
@@ -542,15 +543,16 @@ static int nfp_net_xfrm_add_state(struct net_device *dev,
 	}
 
 	/* 0 is invalid offload_handle for kernel */
-	x->xso.offload_handle = saidx + 1;
+	*offload_handle = saidx + 1;
 	return 0;
 }
 
-static void nfp_net_xfrm_del_state(struct net_device *dev, struct xfrm_state *x)
+static void nfp_net_xfrm_del_state(struct net_device *dev, struct xfrm_state *x,
+				   unsigned long offload_handle)
 {
 	struct nfp_ipsec_cfg_mssg msg = {
 		.cmd = NFP_IPSEC_CFG_MSSG_INV_SA,
-		.sa_idx = x->xso.offload_handle - 1,
+		.sa_idx = offload_handle - 1,
 	};
 	struct nfp_net *nn;
 	int err;
@@ -561,7 +563,7 @@ static void nfp_net_xfrm_del_state(struct net_device *dev, struct xfrm_state *x)
 	if (err)
 		nn_warn(nn, "Failed to invalidate SA in hardware\n");
 
-	xa_erase(&nn->xa_ipsec, x->xso.offload_handle - 1);
+	xa_erase(&nn->xa_ipsec, offload_handle - 1);
 }
 
 static const struct xfrmdev_ops nfp_net_ipsec_xfrmdev_ops = {
diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index 47cdee5577d4..146dec01d0e8 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -131,6 +131,7 @@ static int nsim_ipsec_parse_proto_keys(struct net_device *dev,
 
 static int nsim_ipsec_add_sa(struct net_device *dev,
 			     struct xfrm_state *xs,
+			     unsigned long *offload_handle,
 			     struct netlink_ext_ack *extack)
 {
 	struct nsim_ipsec *ipsec;
@@ -193,19 +194,20 @@ static int nsim_ipsec_add_sa(struct net_device *dev,
 	/* the XFRM stack doesn't like offload_handle == 0,
 	 * so add a bitflag in case our array index is 0
 	 */
-	xs->xso.offload_handle = sa_idx | NSIM_IPSEC_VALID;
+	*offload_handle = sa_idx | NSIM_IPSEC_VALID;
 	ipsec->count++;
 
 	return 0;
 }
 
-static void nsim_ipsec_del_sa(struct net_device *dev, struct xfrm_state *xs)
+static void nsim_ipsec_del_sa(struct net_device *dev, struct xfrm_state *xs,
+			      unsigned long offload_handle)
 {
 	struct netdevsim *ns = netdev_priv(dev);
 	struct nsim_ipsec *ipsec = &ns->ipsec;
 	u16 sa_idx;
 
-	sa_idx = xs->xso.offload_handle & ~NSIM_IPSEC_VALID;
+	sa_idx = offload_handle & ~NSIM_IPSEC_VALID;
 	if (!ipsec->sa[sa_idx].used) {
 		netdev_err(ns->netdev, "Invalid SA for delete sa_idx=%d\n",
 			   sa_idx);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d1a687444b27..46045acc9a44 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1018,11 +1018,14 @@ struct netdev_bpf {
 struct xfrmdev_ops {
 	int	(*xdo_dev_state_add)(struct net_device *dev,
 				     struct xfrm_state *x,
+				     unsigned long *offload_handle,
 				     struct netlink_ext_ack *extack);
 	void	(*xdo_dev_state_delete)(struct net_device *dev,
-					struct xfrm_state *x);
+					struct xfrm_state *x,
+					unsigned long offload_handle);
 	void	(*xdo_dev_state_free)(struct net_device *dev,
-				      struct xfrm_state *x);
+				      struct xfrm_state *x,
+				      unsigned long offload_handle);
 	bool	(*xdo_dev_offload_ok) (struct sk_buff *skb,
 				       struct xfrm_state *x);
 	void	(*xdo_dev_state_advance_esn) (struct xfrm_state *x);
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 44b9de6e4e77..5c60ca36e586 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -325,7 +325,8 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 	else
 		xso->type = XFRM_DEV_OFFLOAD_CRYPTO;
 
-	err = dev->xfrmdev_ops->xdo_dev_state_add(dev, x, extack);
+	err = dev->xfrmdev_ops->xdo_dev_state_add(dev, x, &xso->offload_handle,
+						  extack);
 	if (err) {
 		xso->dev = NULL;
 		xso->dir = 0;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index d213ca3653a8..56bf824ec7a1 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -767,7 +767,8 @@ void xfrm_dev_state_delete(struct xfrm_state *x)
 	struct net_device *dev = READ_ONCE(xso->dev);
 
 	if (dev) {
-		dev->xfrmdev_ops->xdo_dev_state_delete(dev, x);
+		dev->xfrmdev_ops->xdo_dev_state_delete(dev, x,
+						       xso->offload_handle);
 		spin_lock_bh(&xfrm_state_dev_gc_lock);
 		hlist_add_head(&x->dev_gclist, &xfrm_state_dev_gc_list);
 		spin_unlock_bh(&xfrm_state_dev_gc_lock);
@@ -787,7 +788,8 @@ void xfrm_dev_state_free(struct xfrm_state *x)
 		spin_unlock_bh(&xfrm_state_dev_gc_lock);
 
 		if (dev->xfrmdev_ops->xdo_dev_state_free)
-			dev->xfrmdev_ops->xdo_dev_state_free(dev, x);
+			dev->xfrmdev_ops->xdo_dev_state_free(dev, x,
+							     xso->offload_handle);
 		WRITE_ONCE(xso->dev, NULL);
 		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
 		netdev_put(dev, &xso->dev_tracker);
@@ -1542,6 +1544,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			xso->flags = XFRM_DEV_OFFLOAD_FLAG_ACQ;
 			netdev_hold(dev, &xso->dev_tracker, GFP_ATOMIC);
 			error = dev->xfrmdev_ops->xdo_dev_state_add(dev, x,
+								    &xso->offload_handle,
 								    NULL);
 			if (error) {
 				xso->dir = 0;
-- 
2.45.0


