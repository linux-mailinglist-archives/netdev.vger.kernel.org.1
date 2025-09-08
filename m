Return-Path: <netdev+bounces-220884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7CEB495D4
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E18C204A08
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E453126C9;
	Mon,  8 Sep 2025 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bwVCvANK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F07311C38
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349796; cv=fail; b=LXWlhk1Q7lAWjGb3ezkW8mpXItHVbB2IMC/bqpzhJb2C0lxQ1GJ6u+DtFvhUxTN8JPdngJ7dmhS7ICIURKyPOdKYH2haitv7k4s40EdA+pzu9t7HMHfe2yA58Z1UiMI5jDdmQoxVwwlSzfb26XjR0cGIEG0MldBQfTGTLsAzx6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349796; c=relaxed/simple;
	bh=63cn3yC9g/ONKZZGsSkDZqm/VUC/mRRWGvdgzL4wfLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UeTmNt/nruvB2McIcgITLS1HZXe34paghKlC+YHMoNuKrcrFES9uAEDGVMbp1y+aTFwmQypkBiSCw1JwcYk1vRYhMsQel+uMeL7wnvO4+Fp5sIkwTHI5nUVDli93x4P7P+YEcEf6MpyTB/mlvPJxsVFuAX9REgl8jXNQeA9FH8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bwVCvANK; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnRTAvEw+teRBvdBn5Sll57tR5lLZc7pBjhnG1IQBmUAuZt7XM4Qpt2C93T4LW3hcIoIPkU4yWFE5fnSyiuuSZp9+IM0rYtLy2Ld2m/t0tO7FhxJF0v/nwQfdB76150h3fpvUktxo16jhG2+tFGPkPJszg3PADhq1aGXzrb84onhGBfpN+hrm4XFQi0qWSAVmkPW2Bju1qTJCDBtkvBqtyiotMMd0hL2dU5pXTptMdGmRf84rjptocD76T0kmJgeafvVKKrty9qJKwobqytpm5YDMH0hc2cqaYha+SRoyZUZRZpU5NmpZMQN2Dn6+0XzTauX5B0tLc9WXqixvibFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAqU4bG3JHUwmQ2EFyGeSnYMriYSICQNMTpFTdaZSEw=;
 b=p1kuJvs5Lo5bRQXQwzQe1e2WAqlooSP2REp+Ah63FzR7PrTSmbuL84hAhl54LFO0RYQNTyrGgUQqi19Bg0AqQj4V+BvyjL1siNsnmkvuqAzNExussTI8Iil1C3ONn9cFNF/tkCAHvpQz//uOMypD8kcCA3t7Thh0l/cJSWdoYNy1fKKKx/4PGP+KZygNppFxTlyDFa7s3ysbz1roBGcBQGW9Wu0MTwGmHUWxFmqEAKtBXR552J113lsFNiey7RFwbHvGb1N+HmeRZfo9nYHFDtGpuRMujDHqgQwuonQ9lOMF2aGh2i35TL8IgC8sWeGvaoCrogvxpe0sX40itMo4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAqU4bG3JHUwmQ2EFyGeSnYMriYSICQNMTpFTdaZSEw=;
 b=bwVCvANKl+T2Xaas1sF4d/WvbgdeuFoLAgvYDJBMIIwLiAYO93HpiIo+hmzrzb9NC/30swzyEZD3BthoVvoHoZ9bxeQ7VY6NwmM9hQxDlA7szaaikFcCiBJy8Fj+88NPbe9HvPVeZ9i3nY8sfsih6C81eoo2NSEA+cDvtufCk2WohuEE+0HRE3DhpanLBGiSCn1+NHDnEVt9OIacEKtkwzdzrWkUfpGx5Es0nQTXm4YCC+OQSalZgD4oPGyZR5nPI2rEDqhmes9mUflavi2uqzNLW6XDXdXwULgS1Do5ljR6VuKB6d7Tr+C2s6Oq4Be6Eu6nuY5llYw1mTTeXqY/cw==
Received: from MN2PR15CA0033.namprd15.prod.outlook.com (2603:10b6:208:1b4::46)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:43:10 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::a5) by MN2PR15CA0033.outlook.office365.com
 (2603:10b6:208:1b4::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 16:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:43:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 09:42:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 8 Sep 2025 09:42:47 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 09:42:46 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v2 11/11] virtio_net: Add get ethtool flow rules ops
Date: Mon, 8 Sep 2025 11:40:46 -0500
Message-ID: <20250908164046.25051-12-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908164046.25051-1-danielj@nvidia.com>
References: <20250908164046.25051-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: b7743bcd-0b2f-477e-1074-08ddeef6cae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u/bsiizOE0MfbA2d0abkAhDtJYc7GuEtgdm5C6TDQvJcejRI98fMaLRTLwLa?=
 =?us-ascii?Q?HPEU4016Tjz8Yq71LNjyQkhsT78KzaNl1wqoPiTR9PUehZv538OMDHCv8B5v?=
 =?us-ascii?Q?VY8nZexzltR43CQR0acOD3XY4z7jbdRpDkvujmewfg+o95WSI26wLkmndqlg?=
 =?us-ascii?Q?Jo1BZMNNGdmvVt9N+iKpCeFXZBtpb0TZeFwDd5Y0bUa15InRTAwzQEbpu0w2?=
 =?us-ascii?Q?cyOUwbnNy6NjHIXfSyQSUyLhTmuYGQShCnYdrC3DRJt8EDuuNAeh0LADuEVa?=
 =?us-ascii?Q?EhW2GDvI+MQIYNSG+S4FcU5mVXWteJRWkjfLqZs/RqtNWQ4Yv2zc8W24b3Hl?=
 =?us-ascii?Q?WJkysNEoVowsXmbCKECRd7rKgVzwVND6nkfTRqyt85uRNuRJcXfmeOsYugqr?=
 =?us-ascii?Q?8QYupcnm/U9Pv3jdZXQELtju4fB0elBfukJCbo6WVyJBsjx5JbL9zrQ4va0X?=
 =?us-ascii?Q?bFPPO+PWrCWuiqnp0JSklWSuTJsx9kL4n4kGlUK46qejSA5z/U4VhMev4YWh?=
 =?us-ascii?Q?8UoyW26bn16seuBrd85Y4RikfXybIwx25jzixwzGXAc/eOwF/BXrLeo86pm0?=
 =?us-ascii?Q?TQy4/KJrQiquNuOUOBvnhSTJRdZL9ZQCvX+ZuoCapK4Lv2h9q3dQbojvRbA1?=
 =?us-ascii?Q?4PbijlxIvGiwdzHM5d1uN/O3WGYT9cnsTDF3Uw5xeu6dfTe1Hr5s6qWI1W2h?=
 =?us-ascii?Q?AE06GVPjFgaDiRoofh1OlXwsSogkOIsqX2NMAyE6nMbw3wgXid00EVK68gMN?=
 =?us-ascii?Q?6k37kL7WBZp4d+7l0DCLcByKzGIK+ouH4hp4h5AqIZQWsbkdTaZwaGus2S5F?=
 =?us-ascii?Q?Pt2rZhlOcdWy+LofBRrskZGKfe/TGDebQzG9nvXrN4Ifod5rI/siP/89mfuZ?=
 =?us-ascii?Q?r0mkoIZI+uGrGReIMj0ZBunbhaVxYdcVAh47T2mocCJlaQm2KhKPEhKFoinn?=
 =?us-ascii?Q?ILtPFl4mVhcnhmH+WJiew3/0olNAUSJPdJob+lNF5uvLSq38xFuybfDwvBWe?=
 =?us-ascii?Q?2/17xgGDbCtwWnvn/+eweog3EW8tKLRsL3qAnAHifipCIYgKRT4dOjXE9RXC?=
 =?us-ascii?Q?54o7MStJCExx4Rjj48X9crr5fTbUrsjoj+kfoYuxBKSJlbkCZRMrbnfz6+/k?=
 =?us-ascii?Q?5LXK+Sb/ljf0+S7TmSTXkS59kHbSnID9gKESM4NH/YgmnbxQ7bNVwgQivhwy?=
 =?us-ascii?Q?qbBD1qMIvfx6l09DdpU+Fyee6SMTMGMCzQnPOiLJ46PdcOTb90eNVc84Ci70?=
 =?us-ascii?Q?NYsBV3r47q/aGp0oaQCWvHaVJ0EFZVp3Mg5gcx4zoA/1JXoNil77J1TfMats?=
 =?us-ascii?Q?e8oMEtvr69OGc8RM5MTMyDSiMO+loTdgGdezBAHqWw6NXH0rfTd/BJGSUgai?=
 =?us-ascii?Q?73wAAkjrlEttMFEMZmA03HEVxlVgqWsWUBsJ+e5IjeXc16mktjrT0K8jQ9Op?=
 =?us-ascii?Q?L1cLwBXeWZ92gE8eyj8yeP1Xbz+niOH30ia6IzgcgedAV8t+7D5mSxSvtD4i?=
 =?us-ascii?Q?D1KF6HOBKfqD+DDHS8OGb3fZ4K4XLYVKlh2Y?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:43:08.8124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7743bcd-0b2f-477e-1074-08ddeef6cae7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

- Get total number of rules. There's no user interface for this. It is
  used to allocate an appropriately sized buffer for getting all the
  rules.

- Get specific rule
$ ethtool -u ens9 rule 0
	Filter: 0
		Rule Type: UDP over IPv4
		Src IP addr: 0.0.0.0 mask: 255.255.255.255
		Dest IP addr: 192.168.5.2 mask: 0.0.0.0
		TOS: 0x0 mask: 0xff
		Src port: 0 mask: 0xffff
		Dest port: 4321 mask: 0x0
		Action: Direct to queue 16

- Get all rules:
$ ethtool -u ens9
31 RX rings available
Total 2 rules

Filter: 0
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 192.168.5.2 mask: 0.0.0.0
...

Filter: 1
        Flow Type: Raw Ethernet
        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Dest MAC addr: 08:11:22:33:44:54 mask: 00:00:00:00:00:00

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net/virtio_net_ff.c   | 48 ++++++++++++++++++++++++
 drivers/net/virtio_net/virtio_net_ff.h   |  6 +++
 drivers/net/virtio_net/virtio_net_main.c |  9 +++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index d4a34958cc42..5488300a4fc3 100644
--- a/drivers/net/virtio_net/virtio_net_ff.c
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -809,6 +809,54 @@ int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
 	return err;
 }
 
+int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+				   struct ethtool_rxnfc *info)
+{
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	info->rule_cnt = ff->ethtool.num_rules;
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit) | RX_CLS_LOC_SPECIAL;
+
+	return 0;
+}
+
+int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+			     struct ethtool_rxnfc *info)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, info->fs.location);
+	if (!eth_rule)
+		return -ENOENT;
+
+	info->fs = eth_rule->flow_spec;
+
+	return 0;
+}
+
+int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i = 0;
+	int idx = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	xa_for_each(&ff->ethtool.rules, i, eth_rule)
+		rule_locs[idx++] = i;
+
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
+
+	return 0;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
diff --git a/drivers/net/virtio_net/virtio_net_ff.h b/drivers/net/virtio_net/virtio_net_ff.h
index 94b575fbd9ed..4bb41e64cc59 100644
--- a/drivers/net/virtio_net/virtio_net_ff.h
+++ b/drivers/net/virtio_net/virtio_net_ff.h
@@ -28,6 +28,12 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev);
 
 void virtnet_ff_cleanup(struct virtnet_ff *ff);
 
+int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+				   struct ethtool_rxnfc *info);
+int virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+				  struct ethtool_rxnfc *info, u32 *rule_locs);
+int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+			     struct ethtool_rxnfc *info);
 int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
 				struct ethtool_rx_flow_spec *fs,
 				u16 curr_queue_pairs);
diff --git a/drivers/net/virtio_net/virtio_net_main.c b/drivers/net/virtio_net/virtio_net_main.c
index 14ee26fc9ef3..63bf5fdc084f 100644
--- a/drivers/net/virtio_net/virtio_net_main.c
+++ b/drivers/net/virtio_net/virtio_net_main.c
@@ -5619,6 +5619,15 @@ static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 	int rc = 0;
 
 	switch (info->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		rc = virtnet_ethtool_get_flow(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
+		break;
 	case ETHTOOL_GRXRINGS:
 		info->data = vi->curr_queue_pairs;
 		break;
-- 
2.50.1


