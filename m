Return-Path: <netdev+bounces-239603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3654C6A0B4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B04FC2AE89
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEDE35C19E;
	Tue, 18 Nov 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RIwDBT1N"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86E34B410
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476793; cv=fail; b=bBYmBjcdK1P1YfPeTzIHJknuPKON/HtWj0py7KxIBMyZS2TRIUWhgG8b7kwurZ4mqJ1Y3N7ccfhi1pUQrBEnDd9jR8bAdo/0KbroY95zfrwubvPLViGi1o/qIaDUY4d3jEY/iR7zo8icThLBfcH+xfFJITj0Ugf4okZKd3KFCA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476793; c=relaxed/simple;
	bh=mX/nR74BjIfwUdPXt8LMgtfNoGQZddS1qpcvq/rrtCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvKq4gCb5vl5g/9QFOYJA9+Vg3knPTQw0BxloTWj+poBjplOZzSTfRTdl8z/4sib47zce6b1wQnCTSO4xy6uTjDuD9hmMwl8t3BoMgN21w0Ue7Kac0fopie5+vk6p6tSyju5ml+Nvg9iz25y1gfMeTw3uu+3BhNw/HRs+tW9gG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RIwDBT1N; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLkELwk++NmTGQ69oT0Ik0HPTDyeFPyCdvqytx8AASl7rlmF39YKUi7QBria9zyNpjClOy65hktRazKUTV6/g+UVgSSVSJcGEituYN91h8IbyqIeuN0bMFspxoqcj3ZVjefNO3FFn13VFKhUE2O0IsPd5fx6pjJMwNM5u7ZSpMqXhz5XXNKuP5ms71TU36tEf1qspwBODPZSbDlKNVlWKNam6OhdZsomKLcdCkBy1DuqzZ1oiFBBgAyxPPbzfL5iLKLuhniSGZy+ZJOoWWOri5zz3mDL1W+OCHTkHEml68CPfs9TWOhenY6uxhlMzUdMVJt9lVLrW0/tNdt2fFpOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFNydV1WutO8P+HmnW7tHU7yhlnerJEpe9Zbt6ocjaI=;
 b=r1t3p0chMAfPyqZjucetkzpiCPTMAfgK5FuK7z3NFukfXmSEE5YlOdx4au6ShMvTs90hiHQeGKuSxaJujvlO0hQEBWXyiIrH4ylIuIp5TAr6xp2OY2Gbe9vlM5vWLDR0JaKc3eLJn9SHbmvgbn9gzK3biEHvDlQ4I6ne3TlkPcvtM5tXB6bvkRIHHi3aqGMG88L23XAy6Wgch2VpELDmN645AGT23hAGgMCY7HTFuj1UTvHQWc3LJpfkFrAlpVN2VslvSmMINFRbsQMy19rik/xAqjEzExLErw8hynSGAZVNeT2IJVVemNi6LWHd+okfX1gbWusifS8aW8/X6dCIdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFNydV1WutO8P+HmnW7tHU7yhlnerJEpe9Zbt6ocjaI=;
 b=RIwDBT1NM0V4fBruJwoClCcaYwwbo/YQgaHcXcs912rbqWD4/5NUFQzRrDmpzMqxGNQdoxAw66LcO28ZG2ClT2QlGDLOivaSenh2GfSSMjxiLk5YOGc/xLmth6NyEXlLJoWepD4MWWEgHZFwDyAWSBiNMuhoWuE3xN2RfS5GLDXd264jyCAchLmWF+mk9C2dZLLd8U+a3MLHWWKz/oU2Y86eAcQYMXveup0ibBPwl2MbzJ1PxluOY3pSHRP1ZGnLYjim5tCVtE8sxCCKh7jxVv5VFN96+9fIB/cF3/7/2G7fEoMOXVwlcZLbCdai2V+A146UXIsnSuZ9qOStEhT1Xg==
Received: from BN0PR10CA0013.namprd10.prod.outlook.com (2603:10b6:408:143::17)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 14:39:42 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::2e) by BN0PR10CA0013.outlook.office365.com
 (2603:10b6:408:143::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 14:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:39:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:39:27 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 18 Nov 2025 06:39:26 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:39:25 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v11 12/12] virtio_net: Add get ethtool flow rules ops
Date: Tue, 18 Nov 2025 08:39:02 -0600
Message-ID: <20251118143903.958844-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251118143903.958844-1-danielj@nvidia.com>
References: <20251118143903.958844-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: e66e6ef6-192c-4f9e-ebcc-08de26b04f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aEODHRZ/S+PWEdoGxYXdhaVl9QfYx8xe1FZOLzlFdgVn+GX+OV13wu2vHtdK?=
 =?us-ascii?Q?NhbOhsb55sBnZQKSSWjwVI1RnIVEn8nPqH1oqGU1jmHzjW6V5Ucz6Lrr7yED?=
 =?us-ascii?Q?FHxLzwkaWvXe2igc8Ln08h9dp0zyK1TQc4am9FQ4Un9OFRan8dL7ZUi/Ln1E?=
 =?us-ascii?Q?LR1DrE4yb1hOpDxARTlIZOrIR7kZNhO9tGGytRlNWCrk8aGEGhA3rLFVy6ah?=
 =?us-ascii?Q?TOXBpKcqh7GQaHtZu7VE+usSXS5T8MMHoNwZCN9NP7lGCWKGQKfThJ7seWEW?=
 =?us-ascii?Q?CqniKGRoKJqPxWgw53snI19NkCoEM+8xeAeqGLDWkocj+/58akUxXg1CjJOx?=
 =?us-ascii?Q?t3nZ2DQsrjFQ7OxnWBuoXtses9e4CpNLWyD0dzY/YTyCUVfMhk46Ca5Xi4a/?=
 =?us-ascii?Q?o4mfbB5HG/XBV1LMWd8lZG7/PkiWkKYNq6EESfV7r9gLm87TH3RZyb2V+QHy?=
 =?us-ascii?Q?neyf3759dhd6DbuK0rAQDu5yGhZ/bgZgU6y01T5cWNfCSKrZmWE8zADsBNcD?=
 =?us-ascii?Q?jKf5+7qqpWtTQ7jrYAIPjH7cG0KNk69qQRzljUFTJ17HiKaOEqmJCnxgsNTC?=
 =?us-ascii?Q?IbLo84JmNZ9dHnYJqq2lsr6tA+b/u2PMRmZVqPEpjevhXjdxpfKeDVDab6Uk?=
 =?us-ascii?Q?8dX3iwO5uSplHqs5Vh+3YeLF7IYhWy8RSmXzToj4wzzQ/D3iPkzsLC2DC6Tj?=
 =?us-ascii?Q?m1lUwO22YLZT504agZHUQpUO050CueLT3SIL23eay8udO8ITt/eO6xS0wwQL?=
 =?us-ascii?Q?V/cTZG/huJJPt8T/HZhJI4xpV9wHy/JN3atjjjUMkT98bKCkQaCremZ20HOr?=
 =?us-ascii?Q?89esG6JhCUswBTsQl5gQPTgEHRBPLyC9rjkVpjNwADjdQ+6dnpKdnInDhA9h?=
 =?us-ascii?Q?+nriPIJFjgXT1Jb3OQK+OQWfuPae9tuY+9CN22iSmfJX95po8xg4a6y76i3v?=
 =?us-ascii?Q?cWySOPD0YdWvEgsyPGuA03fVhZ6qvMZAMY126YWqYGyNfvuGDUvEeLb6g6BT?=
 =?us-ascii?Q?iQqJ1CDz1ZL3gHms2V8lo84AMM/o00f6KmjIcQ6CZgdGTzfuPMVko9IrrEBs?=
 =?us-ascii?Q?IVHyjjhf0PzGsQ8Mvk68hZ1DTKcVaAQL7UyvmcHINkf48Cc8+e5L3xc3RaZe?=
 =?us-ascii?Q?g/fhzi8Q21+2Oe8vGjzRg3U1KipqHD5SFmWw2Y35Z1gVSqk/F+BHMK37gonP?=
 =?us-ascii?Q?Ppv7v5c2gZw2brg97ZsPlYMwxwc/EzCqMMiEr7yWI/9vzAoSjxLtbYzTh0ql?=
 =?us-ascii?Q?e/6m+syl1cIyob6RwIPTdwMTh8/1Cm8fflwqTpORV2axLfdv2QlTYYarJpJB?=
 =?us-ascii?Q?JhLfF6eCaY9WK0rdYuvPrcrpcT+TOX3PTiNs7fDWsx/Vp3dUFTnkcB8x/cPU?=
 =?us-ascii?Q?M/4dKHm9F5tXt1H6ZXOfXJN6Pdoe1vC01+A0Cz7g+IJjTISHSaZG0T27cOGW?=
 =?us-ascii?Q?d53ySZaVxiXu8Yo7lMPwIuhBgNNRpUEd/VaxJgmQzPXsU8SmJWNyjjCGYulz?=
 =?us-ascii?Q?BP+SFRjciz7hVRFZuTaKcknsHALYhechqKLl2ajKcVFHj3K0dxVTW3Z05nZU?=
 =?us-ascii?Q?PbEs44DGmRuuXdCO6sI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:39:41.3202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e66e6ef6-192c-4f9e-ebcc-08de26b04f03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602

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
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: Answered questions about rules_limit overflow with no changes.
---
 drivers/net/virtio_net.c | 78 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 17e33927f434..5823ba12f1eb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -306,6 +306,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
 				       struct ethtool_rx_flow_spec *fs,
 				       u16 curr_queue_pairs);
 static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info);
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info);
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs);
 
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
@@ -5665,6 +5672,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
+static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int rc = 0;
+
+	switch (info->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		rc = virtnet_ethtool_get_flow(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	return rc;
+}
+
 static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -5706,6 +5735,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -7625,6 +7655,54 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
 	return err;
 }
 
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info)
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
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info)
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
+static int
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
-- 
2.50.1


