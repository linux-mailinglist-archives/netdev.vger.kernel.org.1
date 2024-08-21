Return-Path: <netdev+bounces-120483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAFB959865
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4621C20D8C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91661C2DBE;
	Wed, 21 Aug 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kPxaofK9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F7819ABCB
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231142; cv=fail; b=PPGWzRkhj9+UwEBQeuQJapvyOvzIGakabSxmMbPH4zI4mQn8mQsYIzs5OrUtGBRA+5fKVsXTAOufGyofWwl/54/RTS8XzTXC1yuGVGtpBDNZmAMV+feFhRJLDAn8m3BiXxGthDsTKv4WC3sn+7RKeP04gFMQIHZLox2dKzEcaN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231142; c=relaxed/simple;
	bh=1fsVwhwSlDJMUzO8E6zzTklC/832QnRObS1E2BKYRHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+7uvGMc9wZbVgIOUIocpDxX6kCB8604WOFP/tfCvig0Qf4Yyz/dXn3otCtjrb7H6zalvvfw6n4gzIIVCk9ELws6YW2kxtxViSRQ3jO35zkxyv3x3TipS7j6CGYPu8y1/5R5ohvNLmpZUf5s1V7jY7sSPo6ODM/kDNwiYNjuJsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kPxaofK9; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtP7iY/vpPdhDQ+GQKsMwmNAgnRFJERtQJK3FqdzxQ0ze1xAWOmQqTXF5pZRXZuNLZdkZvps8MYRmO7vLmsmHayDtJSwXzkQK/C9XTF2hZ6vnZTCVZPrlAwwitCaSKI1MuaTT4SVxKDQJrELRxaOlFacqubTOnIKqPTU9PjXFPT+CRAbYuFLing9otvTV61E2iO7aTCj6acCXn/Ee8ou8efnr92tJaFYn+2gGlK/uIimFjylEqZazCB+HkNG36gUuGxdfBzThXmxXdOkAcUMpBu+QFchryo+/49TRsCQ1DdbRi26dt2RKBSKvysDClc7Yyn/vx9X6GQNp4uIMLpfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjoXng7HgutpG1x82wGknrqmu/DK+zjrdiZBsrdgOo4=;
 b=FzV6lYg2W0M2bejmMslz309wnO6n87kQrDjmCtr7XU8JqrEiQg5W7ZePgRHnVDAAtusUou7y9e6tOdKR2M4swmjBltCKcSWS5g2ZnKem8mPaOUcpp0laP5eljvMuzx5f7EC1C+ChCg7Rldz8lgoC/ai0HJj8f/k4jGySZP50KWYopY1DJwmFbpczoqAmbmfNikvsUiJTL1yDl0yZr9Uyc/jMNlyzVSAV6oc6Tj65zvapaBT7hmoHQ4eshNMIZ5zhBzmjugpV/y8oT2mr0NaOBkxmJRrg44IqMf4XdQB3fe/YsSuK4tFfcvI6fwYjfRP2yhabN3Jm2ZnPDG4hnazByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjoXng7HgutpG1x82wGknrqmu/DK+zjrdiZBsrdgOo4=;
 b=kPxaofK9pxLKSgacM22eeFKheyg4VR0iEcw0YerSSuXzdgOLrSgk96SYQxcUZcRqE6mmt4G3t2II1ZW8OIcQQdLdoTHwPretfSABlAyvpa1Z88lAzVa11XCTbQvcJh7m/WvqCq3aPu0Sp2s5KGp0h6ZTgG09WguUXcwudElHY8ObqIG8ovNzthX86G61jHdZxJNoJA3Nf0GhzNv2PFBF0QyKJwJGl7+Dn542AQQ2HpIQa/wfvDgawFr5Dcvva/IGRUJnk1z9Xbx6TkktFwGoerwijqr76iAOYduaNPFmZr5f2a0J7KLPHbIiKst7rUnwL1TZRDMfZ2ONTXzDRTeyjQ==
Received: from CH0PR03CA0405.namprd03.prod.outlook.com (2603:10b6:610:11b::15)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 09:05:37 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:11b:cafe::62) by CH0PR03CA0405.outlook.office365.com
 (2603:10b6:610:11b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 09:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 09:05:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 02:05:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 02:05:22 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 21 Aug 2024 02:05:19 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <jv@jvosburgh.net>,
	<andy@greyhouse.net>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<liuhangbin@gmail.com>, <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net V5 1/3] bonding: implement xdo_dev_state_free and call it after deletion
Date: Wed, 21 Aug 2024 12:04:56 +0300
Message-ID: <20240821090458.10813-2-jianbol@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240821090458.10813-1-jianbol@nvidia.com>
References: <20240821090458.10813-1-jianbol@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 534c4463-ddcb-4c19-040a-08dcc1c06c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AAB27V/AJt1wk/dWnZ73EyWhnr3cz3DXAmqLBMWtDwPOXwz/E2/oHu4oylpo?=
 =?us-ascii?Q?MoDwX8k3IYEQXkFueBVKSV7C5an4RLkI5H9mhxorN3a0dJFxjCCB5wukGAJ9?=
 =?us-ascii?Q?X1wUFxV7RyvNrLtdCC7LnBM4LrzJ7lkwbODBR3TzsMwNiAVAZBzj43w1Bkna?=
 =?us-ascii?Q?b9TYOG64vGguUJjIhGYWRFQs06No0GiIv5jFB8D0hyYLmzdgWuVFJyAK7PSS?=
 =?us-ascii?Q?WCyeZ4MsTrDGVIagscYAo8prrwje637D07gzQLi8HvEkzJivaUGsgP5UCfWk?=
 =?us-ascii?Q?ZM9I5pdggV/PNrjLV4Mib2FY70L4E1rpojOegnzbAMPVRv91g6xc1bfJ8K27?=
 =?us-ascii?Q?hXPqquzSSw131t/sUdsJIQGugFghyBb62MoeQdqr4JEdwp2f2CBvS6303A34?=
 =?us-ascii?Q?twcsG0FUQAA36RobQP3tM6ipBBsyPkNlUliJM7uUlES4BahyO60llI/LUow+?=
 =?us-ascii?Q?oxdCTX2kDFjUgtnVlA6NRDUwjQcUqc7xFaccmzPGHgqAh656L7zKNEzAeZjV?=
 =?us-ascii?Q?L0m5A99xsLYQrchUBkgXWSIiv4ZYz2wwWOaYX2GP8gLAk3EQPGZFpAVR5kD3?=
 =?us-ascii?Q?UjrPrCt2Ejuw+YxdWCDT2lwc635w8u79XlhwPlhUj7YyfL5fGv8qJ3NfBB70?=
 =?us-ascii?Q?n3rm0PsgSblTAlrj5vwnPuzYi89G6RyL73wPnX+clj/6QWhavLypRa8jWpQY?=
 =?us-ascii?Q?UZyCMOYTmBbBUk88XdMFjtrhPmW9+ge/K+R+J1khxTALoT3h+9dTWVHVKRcd?=
 =?us-ascii?Q?dlr2CACwCxbYAZA8CqwC942Dfi1SYhAOKWLNCmWcDXlOZkLHIL/s69oIsfOU?=
 =?us-ascii?Q?KsvV/OXVXpQg9CordlXndT04yZzrnj5PeglYUgkvV7HMgSuDelFjVVsl2Y62?=
 =?us-ascii?Q?7LffVdBdk9msreykd0jEgxn9oaNAhMPiK2+PVyT5hy7GMwIj/K8bE/5MlBQ9?=
 =?us-ascii?Q?+mb4VnCH8nwwLqHR/V/QGV7ziiKohJapR5heifjXyYdgex5Az+exFk2Cc3f3?=
 =?us-ascii?Q?WcINceyvS6puAxnT1IlWc0qlR0zSarJE2clOhIlQTNA89Y5UhPuK+hQGQbBD?=
 =?us-ascii?Q?gz7H1ECGFYTKH2apJyxn9ASL9PEgDSM4rHFWF67RZuupXDlejD++cKddYgSy?=
 =?us-ascii?Q?cXWQyt4G9CaSVVdfTB3ZFd+I0fYrI01oLdQIFi5wTU95a+Dm/wEPrtX2LqDV?=
 =?us-ascii?Q?q1RJmvOQ6PXvAa2I4VcaXPRSREkc0CH+p3+nIhdb4EBZv87edM8vKlom+MEX?=
 =?us-ascii?Q?w/IbkhmSbhKBflXbyFHYPoQTU5C5uxE0czBRsksgEtW8m84NE2LhmTasWEP9?=
 =?us-ascii?Q?BprnQBTrYnBSgncEC7AKYuSjXpfCC8C/+/zZJo1RH3V70mGpyz+1QMOdkssI?=
 =?us-ascii?Q?vZ1gx5RT01dclrU327uU4NmVIUG7yP5d76v2n0jCwkE5UVtsAp1siMe4YYMR?=
 =?us-ascii?Q?sNX8mPwfi6WpKaT+bHQ6usXutoAHfWLQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:05:36.8617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 534c4463-ddcb-4c19-040a-08dcc1c06c09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

Add this implementation for bonding, so hardware resources can be
freed from the active slave after xfrm state is deleted. The netdev
used to invoke xdo_dev_state_free callback, is saved in the xfrm state
(xs->xso.real_dev), which is also the bond's active slave.

And call it when deleting all SAs from old active real interface while
switching current active slave.

Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f74bacf071fc..f191a48c7766 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -581,12 +581,43 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				   __func__);
 		} else {
 			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
+			if (slave->dev->xfrmdev_ops->xdo_dev_state_free)
+				slave->dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
 		}
 	}
 	spin_unlock_bh(&bond->ipsec_lock);
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
@@ -627,6 +658,7 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
+	.xdo_dev_state_free = bond_ipsec_free_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
-- 
2.21.0


