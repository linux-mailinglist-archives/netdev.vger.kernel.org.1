Return-Path: <netdev+bounces-220037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045E9B44402
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34394486CDE
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E09314B97;
	Thu,  4 Sep 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eJrn+sTU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20E3126DB
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005766; cv=fail; b=Kz3Uzt893LSc9WJPEGk4WzLdWTxR3aIw+9lW1IVcY1jYMZxcPSU6D8/uSYGya2+Xm6jMHql+BB564XuTIZ485dh1nD7B65N7VDggPN4WLx6FM9YwBSpF3r5iXyGSfiI9Bx+WrS+7xttv1mbg/BndHjwkai4dNuESyYswUjtodqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005766; c=relaxed/simple;
	bh=R99sTdQxQIJJeeQrYbqXyuzwsyNLt2X0QGvqvhqcbtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4lahu+tcttZYSWYjfH2k37X79GPOXSZjS8xVoMHE5qXsFDyBp66ezxS+Lb0i10rGyNm1EdzsNSYNVeQHKlMC4ow00LBQLdGg3gGXWZ+i2xed789HTjNRqB2NcKK5JEC6dvhiq+rVuYdt/il3VSPFjwlhbHlImKJBFYp8Z3Iw5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eJrn+sTU; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omr5UjqzZdALlK6J4V4Fd4YZWy/9tVKxQ0Q00Dnsx+Sr4vEBY93ErZCoP34+zSgyri34MUBYfm+Ri83NFWiKUgxq1Y2OlC3SsJD/d2BBOkgs2XG1xYMaj76K1wlOwJZFxfmTR+al5JoJKiFAOdUrSMELJ50kN4tYXjGm6W5HUyjMqA6YqcjaEXmO5U4bBN73wuSQAktRm+g4I5tr1TpuwMHHrqj8ERAxAjyTkbpRCz114+clQwXazTgThryan2KTymqruOiL+/aQToXg9L4/GC3+nnMUpr9SMkc1mFxHSxfxMfoG0KYa2pcK7g+17de2oE/VReSBv/FhK8K/ql9asQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIJuMi4Kqu69736asPiMXfdXkm3TSqoq2QFC2qYpPtM=;
 b=FNaElNkpMp2JEYmUb6RTzxdsavURs6qGYONFhDRIzb9aWLJ4dQgWvMOVmliuZbxHdwrzMq+xhhslcyw20H4PEVdbpz+SS8cki3oF8eVBEohnDuSDIkn6zfGpi8RtVDVAsmxJha1DC9bskQBdw3d7hdc9HcverIcZV2Z7pKB6PhdS9G5UQ5+HIJXNgdX3tQQwEyi714P0p8Mp+ZM6C0BlNCwvfTKPCLJ28wp+lF8yP8VDFMdmfJvBgfDMJ4PoxFpGvuVPP/4ab8nO8tmGjevebHgL51yLozZaJhGOfYNV01nRaMsA0IDvIvKoxg04XpaanNmcdRJaIiqkdMIdobzvBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIJuMi4Kqu69736asPiMXfdXkm3TSqoq2QFC2qYpPtM=;
 b=eJrn+sTUrx8Dscs9i0gMRi/JBI9OAocOxlYOb/6c5k1dZLLCraSlMkATR3B+zBh5giw16ihxs1k21xOxR1hxRwB9o6oCorAWWmRFQj0ZPLbCBjKiZlmCcPH8qqf6B9OQKlPCPZMVq/FLA1kkyzgoQEl7M9zko5NNPiu8e4Z/WvPUqSEAqFrENeGEo8pRtPzb4ezIJDReAtiblHLt4W4jxyVyOeplOKccaKmXouFVbxNjfhM137pJtERihOnrqSIc5gHwrRn0rcQGnpp7uU6/CZU5n7W3k75+nKMczoV3eGX0CpYvSyiTr4wvAIK2BDDx/OL77QtHuqerTWi0FnJbMQ==
Received: from CH0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:76::7)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 17:09:19 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::64) by CH0PR04CA0002.outlook.office365.com
 (2603:10b6:610:76::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 17:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 17:09:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 4 Sep
 2025 10:09:01 -0700
Received: from fedora.docsis.vodafone.cz (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 4 Sep 2025 10:08:56 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<bridge@lists.linux.dev>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 03/10] net: bridge: BROPT_FDB_LOCAL_VLAN_0: On port changeaddr, skip per-VLAN FDBs
Date: Thu, 4 Sep 2025 19:07:20 +0200
Message-ID: <0cf9d41836d2a245b0ce07e1a16ee05ca506cbe9.1757004393.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757004393.git.petrm@nvidia.com>
References: <cover.1757004393.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 692d9b2c-c472-4f2d-04a7-08ddebd5c8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3bReLpimfkqaNADvLAUDLl6QjaKe1oVmBsTd0PAiR52SqPjoMvZikhqFLx0Z?=
 =?us-ascii?Q?zKUj6wit7xeqsoc27ugE/3aKeI8CowNew+/PAznXpy4egBQVvv9fiB1w5d4U?=
 =?us-ascii?Q?LRa/1YjhSjs5m8zbwLDR9dehWkm3dC8RZpHw9b1RId7jurU3jO+75LDWLXoT?=
 =?us-ascii?Q?BhEtAGnIOwGKTmIODz5mRZt8bwXX/gZJbtxGQmJTTeAs1pbiL4hzpNYncQTJ?=
 =?us-ascii?Q?/4RiiSHrsTliXMrT1h9Z1yHNE66M3PQlfuIfiUFY0bUItEqd4sOVR4OJfJri?=
 =?us-ascii?Q?uT/HSmRvwuI/ghfY6PnbqY1Aj6AEeEuTshabKxrUS+7C+D+Ry25mvUwMFIu0?=
 =?us-ascii?Q?u6Q5TBybVAYK5qebctQ3QZyE4N41AWqxL1pizlfjkHBvGsMWHORM75o7+gk1?=
 =?us-ascii?Q?Zam2uv6NLXqrt4KWgOTKpeTim75UVg+fLxgare6SoSLRKYLvCEcqjIy+aMqT?=
 =?us-ascii?Q?9Aa3GtYpHCKKDIg0ujYzezLNGhEOGn+r63NY6+E5zlPyoMYCXb8gh5xUPusP?=
 =?us-ascii?Q?/kk4oL2zJDDU/AzGFJF3FyXHG7fHXYyZnGDSizTd3o2WKqPrTheepv6QRzLh?=
 =?us-ascii?Q?dXZFNRXp07Li50SWxlreGpl0838h/Dh8ttEJ3VsC/KtfjHOBxxXnq3tq8j0G?=
 =?us-ascii?Q?VCTWTvnD5E1bCQiH+OMeZsTB+sB6QHTF65QtC0NH8OWU1r8kf07FXv8adsyP?=
 =?us-ascii?Q?/t8RQaU0uY52+1exAmd+fhC6vIgx6GsT9BbPk9bwl7vdrMgYXUscqL6a9tED?=
 =?us-ascii?Q?5T34FLk5UyYaNH+14rfbNzhlfyHRi8v5uqVXUvlkf3FT/iSfob4lcU2dlM0S?=
 =?us-ascii?Q?h76VsLHO8+c0SYJg6/qeTKRHMIWUL1VrNLSeS/DyRnsSiFTxEsDvpQHiEnuU?=
 =?us-ascii?Q?396QCc+ECiC/dENBUpHNhnfcTpr1QjXEAV+rby+hyhekC/RSrMXDftxcMwSC?=
 =?us-ascii?Q?aBYhIhKzr4UXHrWKWhXd3wrjLq3b8IlwHrFsuQdlMwybzKCdlrCvCcWC+BdY?=
 =?us-ascii?Q?0VobDNgTjRtyQzIYhyw9yHBC1BpDbZKFaxR9rdppjiPI89s1QZKbqzLQppAt?=
 =?us-ascii?Q?o8KML2HA4BmxCeVSOjegM8WMCxOYfJ53CFDvw8QBzZNReUgKBGvLQRS3QcwG?=
 =?us-ascii?Q?0+92e3bEBmRbiqrtZY2a29CMmhaYsirkCNRkfvlnDAeK7lGjzM8zQPs4hR7H?=
 =?us-ascii?Q?kyCBW9t/Kvm78FHAOmujVtScd8q6gHguiYunBxMyIZtrABDaHSmkaCicR1bx?=
 =?us-ascii?Q?VUFrMXohDeiwQEpD7LF+7aNLnLot5bWRNixPeg98k7RimXfZ3RVyRkp8n5Yp?=
 =?us-ascii?Q?DasJfP9cG6WTb+2YSGp6a3HbBFEAJ271ZQsIOe920tvlTI/519+/NNE7TZ3O?=
 =?us-ascii?Q?F1YoN6njzJw6khGJ0ZnSCZyGhAXGUmvWyk1Oq6MSDn7juKr+5sDjc5Irh/Vf?=
 =?us-ascii?Q?A6guTSxNTpHhRS5dz+l73j/zZi+EE4BbD65cWiegvSViX3wOFmjmU30ceOkN?=
 =?us-ascii?Q?vWQ+dRaBECLuiiPd/TlJiUz37Fll/BTY8hoU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:09:18.6861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 692d9b2c-c472-4f2d-04a7-08ddebd5c8f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053

When BROPT_FDB_LOCAL_VLAN_0 is enabled, the local FDB entries for member
ports should not be created per-VLAN, but instead only on VLAN 0. When the
member port address changes, the local FDB entries need to be updated,
which is done in br_fdb_changeaddr().

Under the VLAN-0 mode, only one local FDB entry will ever be added for a
port's address, and that on VLAN 0. Thus bail out of the delete loop early.
For the same reason, also skip adding the per-VLAN entries.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/bridge/br_fdb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 902694c0ce64..918c37554638 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -459,6 +459,9 @@ void br_fdb_changeaddr(struct net_bridge_port *p, const unsigned char *newaddr)
 	struct net_bridge_fdb_entry *f;
 	struct net_bridge *br = p->br;
 	struct net_bridge_vlan *v;
+	bool local_vlan_0;
+
+	local_vlan_0 = br_opt_get(br, BROPT_FDB_LOCAL_VLAN_0);
 
 	spin_lock_bh(&br->hash_lock);
 	vg = nbp_vlan_group(p);
@@ -468,11 +471,11 @@ void br_fdb_changeaddr(struct net_bridge_port *p, const unsigned char *newaddr)
 			/* delete old one */
 			fdb_delete_local(br, p, f);
 
-			/* if this port has no vlan information
-			 * configured, we can safely be done at
-			 * this point.
+			/* if this port has no vlan information configured, or
+			 * local entries are only kept on VLAN 0, we can safely
+			 * be done at this point.
 			 */
-			if (!vg || !vg->num_vlans)
+			if (!vg || !vg->num_vlans || local_vlan_0)
 				goto insert;
 		}
 	}
@@ -481,7 +484,7 @@ void br_fdb_changeaddr(struct net_bridge_port *p, const unsigned char *newaddr)
 	/* insert new address,  may fail if invalid address or dup. */
 	fdb_add_local(br, p, newaddr, 0);
 
-	if (!vg || !vg->num_vlans)
+	if (!vg || !vg->num_vlans || local_vlan_0)
 		goto done;
 
 	/* Now add entries for every VLAN configured on the port.
-- 
2.49.0


