Return-Path: <netdev+bounces-118856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A831695342C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C381C25D27
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49BC19E808;
	Thu, 15 Aug 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M0Gs1Bbq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAAD19DF6A
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731786; cv=fail; b=eTVQHcUqYUzNweAMFS+E7heX8cedBw4FcTw07tvSNyrqBaOIeNb4chQtRxKVwFsmEJJTaCbdrBbEKsVen3BwOlHUrmNKvbXgVh3ul29OSh29FYOVPPnQ0mj1V/fGQ2QDvw4fuQl2yhaBzbmyTPdGRUdZUuyJgyXlFe5mSOFmWnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731786; c=relaxed/simple;
	bh=ykKP6b99iN6FoxG4mthILFG7JY7ySWjD0bkYCET3iXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7ecb3/CzkUFafv2PopiDngyrOsR1UGHQW0HkGCpTKrdhi/ueTwVCNfOi+5rEjcwZeRemlXwbVDDfv+EEl03Q5a6vhfyF5+GjqJUF7QxIJFFV39MVZDbMomb4IE7ncWb1GGk9H7nJc5G2XCEtnhrTLjqzvMOATWOiy5XwNuxBa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M0Gs1Bbq; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quo4YHXAlWOkCMk+w4L5lRoMsu7tlWR+/1IiDzIQpnBglilU6G8EhgcR1GmvBW3l5z7roo2O2U2/YdP9SH49nFosFWmmKDWffWj9YFM5bsUczj4K940MVPB89oM4ifK1YJy/1dd13zfV+MywZvE9f5BaWnhiTaubcIGVBuwoQgKdxhgtLn7QuwcM9YZF0dEgiRvtdjXChDLgNKPzE6CM7P8yaA9Y1Q92ApZZ7Nbb6maPwp1Wn6LS9AKUC+0Dzx49lAtiFUpml63yICuQk34zbqoZ0Mzo4iN4jpGoUigaxj3JeMFIG6G4A3KVFLD7LPcI3Jlx4wtmPGIXwIX9scb6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEkD/UXq7/RnnUunKx478PLvbUrgojR2h43Ad6dIkMQ=;
 b=wOqzJZgvHbk0D8R1KxiZWLdgSWOi/pwam62ntXU+Wy0aGemAGaNWiKbVrc1OXDY8vmvdwuESYBRP1BjzpH80V5KjOg4RjPjmmcQL7x0m8DV6hEDD7z6+tWAwfqxtViu27W3nJ+WLK/pLQkT0+PUdq+Q9yCWmDmT4/gX5g5W5EP3pOr0QfVFK+ve6eDUazXj2hlKIEv/pwz7nVM0SiSfvGk2YAKdZ8c069JMv6czi0fJ086QdSK6fsW1TY9eDfAR71kcyqtOTiJwlf4Rw4z6YwKZ8ZyfJeqRZcN0N9NgdcYqmJ/td5Q+pPjylxwMnRU7It3p5fVwn0CkoGXkf3LDR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEkD/UXq7/RnnUunKx478PLvbUrgojR2h43Ad6dIkMQ=;
 b=M0Gs1BbqiiKoh9w0ayY6Go7Bk3eJHpSriFnLAp9YHGNQXJRREf88NCV0s3d6zotLP64LQIZLCYafLezRqwpyaMggrkgusdkHTtC3dUxriNQCRJyza9CHVC+71nWOZAB/K08eruFYKieFnFCq3qrGXrFwx0V/LRDYZBqFNv9su6ktxBRvgwhnsyPQ8iXcsTw8+Q33JNZpMJh3zgVVySTd+Rc/PdXRqjI0MAm6eqftTRfcYr1YxaNHCoCrpAW01LC/cAIk80jcP1SbQMYtgL9BuJ9vNxtKmU4qD7te8oiZoT/eWU2/xpsUCf7tXmK9RADALkkV+QnWJynjDnQo7pnfSA==
Received: from MN2PR16CA0064.namprd16.prod.outlook.com (2603:10b6:208:234::33)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 14:23:00 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::f3) by MN2PR16CA0064.outlook.office365.com
 (2603:10b6:208:234::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 14:23:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 14:22:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 07:22:41 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 07:22:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 15 Aug
 2024 07:22:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V4 1/3] bonding: implement xdo_dev_state_free and call it after deletion
Date: Thu, 15 Aug 2024 17:21:01 +0300
Message-ID: <20240815142103.2253886-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240815142103.2253886-1-tariqt@nvidia.com>
References: <20240815142103.2253886-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4bf6f6-71e1-4ef5-7d09-08dcbd35c3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GE2Yhd6q9/vZr41s1wtv9FWfv9yh5iu31kLbAnFTL3+3G67AiB1nZ27m2faF?=
 =?us-ascii?Q?V3ZChT8xeSCsCj1M6iRhyebhYArUXEr1/0cDp+TO14Is1Nxl39y1jO51C1lm?=
 =?us-ascii?Q?Lw1IRYSeW6h09HHj5keteLL/MiHFsk1J7dECJ/JyaUlmAo7UjsC3WScyZqTJ?=
 =?us-ascii?Q?j4+D06gGWw9ugklClmEWdSDP7nHG2TMeuFxfVrcRFtokeAit5LPrc6RTEF/t?=
 =?us-ascii?Q?CRS5U+JIL/CrCEWwns7lwIwvGVfmq5U0N2THVUYWaYXFc77h1HA4v4m8Vn2w?=
 =?us-ascii?Q?15QHZ2PhG904vBWUB0titpD834fYY/Fua1YUc2r8T5NyhbSNsOgQMvniaVFL?=
 =?us-ascii?Q?TMLgFo98l0swC0KUemCdvw4WZIjPLMkNzdyt5ERIs3spOXGL4KsZhYn+vGHZ?=
 =?us-ascii?Q?yrRfh5bVuFzgSP53vnIzuHep1Lt66ZZK4VCBwGSAbtVIr86BRMh727ualC6N?=
 =?us-ascii?Q?nPuUGDweorTZNuIoPPwjyn+FMvGui0PdBnRRJUpe1EifKyYAXlt7q+oKU73A?=
 =?us-ascii?Q?Ud20NigCaZkInwPeLQpsxLWXxFC9R1R28ko7ZkV52mlGBLkiiUnZ+JR6KLcK?=
 =?us-ascii?Q?qZW2jJEWGpVcTlbjTJZ1r4PpymQM5v850eOkoIXD4MjRDZPNvyBoEZcjxNax?=
 =?us-ascii?Q?TjObpfSSK/eJDuGz7Ss1GTvYWZSoWy8SjGNeLeIFJB/Cx6Dg9B8+Cn/++0QH?=
 =?us-ascii?Q?6cKYumkUFR++0dVGgbMcQJcnnv5f3ReABzTw19tUp/YRM9GXWrDgeVeItali?=
 =?us-ascii?Q?dUcQnmmXRi59X4PO1D5f6LdmCpHY3rAYA0JzSCG/vl6WHwtzMo17t+JHYped?=
 =?us-ascii?Q?0JBYbnpHds3xkBtPcRqVAakclYCF1sn5kZgjA/tgIarpUFhg03D6jkE607yZ?=
 =?us-ascii?Q?TZauq0VhlrbAOIuRBwSvpOay4ZlOsGRATbxhQ8ZHTeesuSvtDj4iyfG6BWq3?=
 =?us-ascii?Q?ctue8kFju8fuXyO5YXFjnzsE7knW1t2GawaIz793o2RzYsoZoG8u2pecxrfP?=
 =?us-ascii?Q?1i98kikMBrPFZ8hOPWP8IVtv+IG4eYaWBBGPxDd+EOArismwIKboq7J5Moki?=
 =?us-ascii?Q?+yL44LFwuN/XKul7JXdS9qZXBGL/S3kMdtfmK8yKtzrLeWRIaCMCQXNkxeUF?=
 =?us-ascii?Q?s+4TQgeMDvvaWbMNaEHPpsmxgAss3B2VjaI3wJPGyVmYtPlGR5ItdCQ0a3MZ?=
 =?us-ascii?Q?xJxdvRwOMF0ljVyvD+DvvQ+KcRQdaIb8KhpUgES6IwlypnrnnQ59Mw3EgbXs?=
 =?us-ascii?Q?3lk68immP9ccZPNuWspHYn6CZOheiEtKnTo4PHb7RehyqEpccfi/lHMg5k1/?=
 =?us-ascii?Q?A5u8eEIsGzcKVds0CvD95OLmNiz++GnAK2cbcJAB//AbmyYuq305/dS593/4?=
 =?us-ascii?Q?VPZoFf3bZAI0GOgLbEyLUpn7ECSjoiPm1x5WBW+ajlMBb1l/Zh+wgnHpGvYv?=
 =?us-ascii?Q?VYz66vp/34BYG7CQJAeHTsXNYGpDqx2l?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 14:22:59.5577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4bf6f6-71e1-4ef5-7d09-08dcbd35c3ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

From: Jianbo Liu <jianbol@nvidia.com>

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


