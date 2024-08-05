Return-Path: <netdev+bounces-115630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB97B947482
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 07:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E6328129F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 05:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB9513E05F;
	Mon,  5 Aug 2024 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IWMS8UT9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59164381BD
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722834366; cv=fail; b=RrIhJlq8dKp81pnSYc870qrVDjiRivSd60+Zg8FYVMZfhCd4UHKMfJBiBwXOANckcuRP09sSZscBH6xmjBKgvmeouRYbpnUnw3C1Y3xtIoTou5Pyl/fSh3XPwrtK4ctwEKFTtvonVgiuVyYu8l/TVbHMA3TyO3awwXmsmJwr2Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722834366; c=relaxed/simple;
	bh=QT/gBJ6flRRMTtwO+x05mkQmb/yX7eRDBD1oEyKM1nw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbBViN+WvSSaXwFiyPWdcnwp9ZDiNlzh5xBdH9x7rDNs9M3E7Tnw8r5N9ycFS7t00jW/kL18vqrhK8X0+Je84JiU6/HourX/C7t2qh+/w/70TzuOV63GKt/DwtyBaajgz+z9rrcujvPJPy6zHOHdYJ7ERXI+dQ30cZj0GkgQLAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IWMS8UT9; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xsc7JHeaG3Xu2A/X4UfxJ0s+UfBSA6Htl5TUj4qX6f14fVQb+U7OQTuVCvvCvo6/kSHh6/h4s3i07O7zSOaLcdPdHemix9OLcbw1ZODNUW1+FYfKPy+TMqx9NVH1uMRzj2H32DJnEDY0WnoqL4SnaSIDxYIa9aifw5TTxO8NCkmsRWpT0NAMjeNUJTHbxCQy75njg2BuwbOB3OXKH1UhgXcnCOqyBBLowUkfzXANrBEqZwIYBKwoM0IHVbcarFxu45RqxkOhaczXIzGx/CoSeZmegpuP9qg3hoN5WiOh4DTs98iA02hozBc9fXomAQPsRe7Vs/5cmbhF0x/uKqSFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfCKW+A4ChSNYTNy5jNn2eCieGmS4SWr1BaajKLWSeM=;
 b=dSgKb+4GcA7IRsqM/lHEOiPIFzWSjImrSIrt/5A52WRsSkhzh0pXuUQhziX0d8NopHORatoKxNs5yrEYtKNJ1IiRvV0J9YLUcpYOUlbVC0RdEOAG3fyWGccs+HRUEYfR8nW8rMyB0T7rW/4phjZ0jkTvPfESIXfq/OxOFaYKd0A08ZR0bW+bLULZxxEAHi/g9LTbezOFpNHlCd/IXtBdoLFpjHUYIYEJdnpYwJZABCmQayYt+sGMc7sgK2iNhpv+1TkmAlZ6YZFsWimzb9iEYaNVzlwq7jifNXplr5CH+OSIfE7FMzakud1H2pBp5LE9O1bD3CftV8yWROuzoHAWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfCKW+A4ChSNYTNy5jNn2eCieGmS4SWr1BaajKLWSeM=;
 b=IWMS8UT9XGdTBA/4GDSayEobdVhNM7YpXTKWV4I+/4Te1ZZQNSkSMzkV3Pxxt9JQKvMWgMOSOcMWUiSY6J+Hb1cikFr8GzvXJKrWhSvh8Ez3aaf4guiXx9CbDYLvl/l6FUBg81oOqNGKPkeXTzBBwWgYuMQh+getH11eYmWHfcslANb7xWn3v76JAk2anZ6yPhaza7Vsgtuj0y8QdBnMNdPH5BLxdFh4O9+Cq0/dw5HzQlBs8nqZuewip7H4BkTxOI0xmw2Rwo2qQS+0fEa4bg54B3I4C1kRk/ekEk/UT0ju69pcl8xorb+3uuCG3AXTDkN0SR4/yvg0R0LnMdspgQ==
Received: from BN9P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::19)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Mon, 5 Aug
 2024 05:05:59 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::cf) by BN9P222CA0014.outlook.office365.com
 (2603:10b6:408:10c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 05:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 05:05:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 4 Aug 2024
 22:05:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 4 Aug 2024
 22:05:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 4 Aug
 2024 22:05:38 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and call it after deletion
Date: Mon, 5 Aug 2024 08:03:55 +0300
Message-ID: <20240805050357.2004888-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240805050357.2004888-1-tariqt@nvidia.com>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: e1321f7e-0d59-44a0-4f22-08dcb50c4b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1LGn5ZEQBTXJHZkk53GuOIiJNW7zFswKujlSaqcsIjIrO3NeVu3BtJw56goK?=
 =?us-ascii?Q?Rk/etRZ4cb0NcVQ0MRfNcCz7G9amI5UoEca7zvMWV1onOV2NHcKUrQp2vivW?=
 =?us-ascii?Q?WU+4oJY5QseNJzGxY4dJnSSpiosKIvpkBChi37fBP/Li/+lsDJLBlIo/jOU5?=
 =?us-ascii?Q?PpeKcTCmwC/6ushsJoLbbBm2/eq4FUOnUYSvK7jBfBxYdR+nkmvTIPsMSjEe?=
 =?us-ascii?Q?eJCuP/SofVvJ4vKxrtCGT7frqw8VKm7E5ZVv6EefSFEDGqZGvfp/ELYPWJt1?=
 =?us-ascii?Q?FPG7sH6xFDVBVfZimEwlvnI3aMpicX7cbljEz2pgIr4Q1/bCEDMBLIaJqwsT?=
 =?us-ascii?Q?w/suGewiv6tijp4n4rFl3/EKnsf9xrAolBj77XG+FGpd/UtWMCsGdSxdDk9p?=
 =?us-ascii?Q?XD7Z94DLLKGiJwgQfEGtt7DxAdQm1299U+tM5APqwnipUTUMdsdsnVDO3S/y?=
 =?us-ascii?Q?u9NRirgJGnF5jGLcUGhE5EmaFk5ag7a11ublqK22uuyNAwjRm2ymd/n3WojG?=
 =?us-ascii?Q?ZsWQK8rnfpCJnWjHl7/CIPvQf5R09tg52Vs2lPxLMpJs7HBOgOv3DV+Ek2hY?=
 =?us-ascii?Q?HqKBf3uTvn4q2SYkZptw+SJcXRG0Wmc6wLS1f+CsvLW9TF5jvINx4rDb9EcA?=
 =?us-ascii?Q?Ly1PHuZ/CFqUe1CyHyZ9ULr7yaRKMh7iafGI7eCaN3LpWHaSAc6soAebbxNg?=
 =?us-ascii?Q?JinpGB5YpkcPX4IdWQOhoEmuL/NoE/8uH3/CdBndQPVLl/ODPvqU3ZN+DHv3?=
 =?us-ascii?Q?m3o+OD+CIhaVlf9li44mVpQ6eECibOQzQUes2Rh7kKtVDVpUmRtAnCGXkSSY?=
 =?us-ascii?Q?D1bA516kBqcbpS69eREdpGwaAQelE4dFYUxVixtQn3M1D3cGkeGVi8yiSh70?=
 =?us-ascii?Q?AForyPLt0+R+Sh7+wy+7UUpXjD5uswB7vO3hbIYLhavCC7MD/j4laeKCbevH?=
 =?us-ascii?Q?rHnPosb6+rLFeJFUX2N4PRPgjKNVNA/vWzMmiWashcrAI7n0Aw/b/O6+8QsT?=
 =?us-ascii?Q?STpjomtgqGh2KlR+RjMHZTyIVIlRlE3L5Al3cTrwoP5/p9PzagztbQEt7BLA?=
 =?us-ascii?Q?BhCqUPfyei2OW4GYkwtEv6g4fouDAUNTE7dGR/pPEyyI/HRRSIRcR0kSWDAm?=
 =?us-ascii?Q?hpKD+5Z7PHLemKr5SJK8gn+7gWYMpjtNQK7IoD0PXQ9U7TlwH9WBbWiny5wf?=
 =?us-ascii?Q?5qUiTWX/z4E/Bi3PFNMo1jS7Q3vB6KfpM/UkS/2nGrBITcFlvzfZVO7xDAkF?=
 =?us-ascii?Q?4pHLVeR61F3WLD+c8zEGirvocD9c0RycSUNV4AOJMUvjiZeBS2/QNFH6jPhk?=
 =?us-ascii?Q?ey5dA/Sq86VPoNzG2V3PAnsiilrw9U02EJmUxxEHiNVjd8m15AoBV1ZbJuKm?=
 =?us-ascii?Q?GEPnnpkkM0oWySAGEO23T0JFi8MDCBHXWBT2jrUncaya212Vr2JXyNiXXBVB?=
 =?us-ascii?Q?T0sm2Z9sB4VQ14W31pp9ZR0qWMZ7h3lY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 05:05:58.8606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1321f7e-0d59-44a0-4f22-08dcb50c4b7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964

From: Jianbo Liu <jianbol@nvidia.com>

Add this implementation for bonding, so hardware resources can be
freed after xfrm state is deleted.

And call it when deleting all SAs from old active real interface.

Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 1cd92c12e782..eb5e43860670 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -581,6 +581,8 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				   __func__);
 		} else {
 			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
+			if (slave->dev->xfrmdev_ops->xdo_dev_state_free)
+				slave->dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
 		}
 		ipsec->xs->xso.real_dev = NULL;
 	}
@@ -588,6 +590,35 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 	rcu_read_unlock();
 }
 
+static void bond_ipsec_free_sa(struct xfrm_state *xs)
+{
+	struct net_device *bond_dev = xs->xso.dev;
+	struct net_device *real_dev;
+	struct bonding *bond;
+	struct slave *slave;
+
+	if (!bond_dev)
+		return;
+
+	rcu_read_lock();
+	bond = netdev_priv(bond_dev);
+	slave = rcu_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
+	rcu_read_unlock();
+
+	if (!slave)
+		return;
+
+	if (!xs->xso.real_dev)
+		return;
+
+	WARN_ON(xs->xso.real_dev != real_dev);
+
+	if (real_dev && real_dev->xfrmdev_ops &&
+	    real_dev->xfrmdev_ops->xdo_dev_state_free)
+		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
+}
+
 /**
  * bond_ipsec_offload_ok - can this packet use the xfrm hw offload
  * @skb: current data packet
@@ -632,6 +663,7 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
+	.xdo_dev_state_free = bond_ipsec_free_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
-- 
2.44.0


