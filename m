Return-Path: <netdev+bounces-236627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A17C3E6F6
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 05:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C79F3AEA64
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 04:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61892EBB88;
	Fri,  7 Nov 2025 04:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BHGHwUgo"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8D2E2DF2
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 04:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762489014; cv=fail; b=M6Jm53fW1WtwRQiP9iSsSBu5RBVFK2XuQ8kLQ/aKp1Dyb2ZFRarRZK+rsxaS+14dxLUPsZGJfMIVzCaOyI2LmoCzen8QPox8Tlt6UnshO6bGMs99yyAiJ+Ks7MEn7cjcHL5kkurOT/4ict8TgNiFqfL/TmorwHpsX2e6TXZJV1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762489014; c=relaxed/simple;
	bh=fJ+cxr47p4NnE3n2LM/h8RvqRzdlwpURLvVcNk7SJ48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5cbt2hKrZDb3/hE8xjjEvedmgeUixmpmaRJsDRd1Lq6aFdK8MU6AFe/wG61JoNn5ysGZODjBhqDIfs+FYh1ZkFO6cNbyUgFyAuQlGY5ReB8m7Y9Aw8HCzD5q/nHivwk1UzbdrjiCqyifxLW2Hhgp06RRbCyFGfnQlHVlXBtH78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BHGHwUgo; arc=fail smtp.client-ip=52.101.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMvQpjQCJB6bhdjTHI+GJ4bOhNBLkz/8KT7pFvEMORE9IxlKE20AZm3U9H49vAVFlzjeSz7mhSBzuXXc4usLLHWSNOyOw4zdADHwZPAnmSvkbpPSbA7s+DGYfKPHutoU+lhcg8G477I50U3tJXLalphTndTFeD11aWciPuO8dVk0oUtog/5qkTJglLmBucz/WRi5sef0dtutdwNDDF1h50GG+y9HTVvafE4Sp2MBZmXTW6gYZb7JmmK26AKbTLfWb6Npa8D1pWOIsOLqhw4/BpRyv6g+K8mQmGDq7phKB9rguNK0If8gab4t0jhHjhfjctKh7g08QkQTsUMCuJNftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Td2MbBlSsqwKc4KC9F/+HUdg61E/V7VbP5Zmgx4zeFw=;
 b=KjnvvLok1C7RV0YKqVxQ93vxaNiAOwb4NoAy2CMLzvssZjwgapJdqUsF6TG1ga4l4yYKoDBKMJ/KAFAA2iKHjcl8CyeekVtKcdq6gKOHXdF7fE0YlGQfdN0EpMNl+gCSEpoaBdMU1HrHQsST6JqfGt1EaWSdUbosiA0iWz7QERNA70l/7M7ubV1KZHWfQb/H00X7tal1ELYjS1H7OlMrapdADUbeLV8SwsuAWNyiirL3g8GWjspEwRjbagyqPMLIuX5s9Ir3J+Ee9Boue9w1QB2rF2tHCLN9Fn8N/e70IUDclo8BKxKqWhNUbyr4dMIrKTOIws+P8QzC7kfzN9dmFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Td2MbBlSsqwKc4KC9F/+HUdg61E/V7VbP5Zmgx4zeFw=;
 b=BHGHwUgoGb1qbvbrxNQezrI0GCPYCImTj24RqWn1p03hlnYmk1IVWiPjEJVh2vALfHpA2j2NNDpccZDJccblH+bUbPVLQ4B7StLhYHo//h1WRlDfC1isTOj07FQSUs8ICG6wtA3vWCPqpPvNC4Zupdknz6WcpF13ekfA5GGAxX2QZHzgppol7C7ZbQaR0G4QBGPvVXE1k3xoUr7v8mFLv+N7tTErjh9VdEAIhEF9HORQ66gCtWQTiRUcNa6iIeZF80fe4FUcAbtfq6YFHdY9yHmyxdqC+/nRNl+dBsKoSG2B6boQ9pxN+al0BWwdLst6aUHFSOApGeannBUA46aAog==
Received: from DS7PR03CA0005.namprd03.prod.outlook.com (2603:10b6:5:3b8::10)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 04:16:46 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::23) by DS7PR03CA0005.outlook.office365.com
 (2603:10b6:5:3b8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 7 Nov 2025 04:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 04:16:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:35 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:35 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 20:16:33 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v9 12/12] virtio_net: Add get ethtool flow rules ops
Date: Thu, 6 Nov 2025 22:15:22 -0600
Message-ID: <20251107041523.1928-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251107041523.1928-1-danielj@nvidia.com>
References: <20251107041523.1928-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f388651-f634-4cdb-93f2-08de1db47774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5IrVshpFmb5tQT79SU+5qyEQzTC/qXrT7tk4NZDhLE1ONR4w1R/Hw5kQTj5m?=
 =?us-ascii?Q?I8GVpCA58dvJgKGlk7priM4CWPdz/BYXc5kFuXFzcmpKmNmK4KtVb3dISt1l?=
 =?us-ascii?Q?JJwN2TKTpn67GHkYaCqj7kPSeURC2e6XOlW8gbbYdmyOkr0JJjloFMsG0H3h?=
 =?us-ascii?Q?OklYbjQOQ2AVhQdVXRTK8d64WumDtddBjSdmS3m+kt+4x+cxFWMi4XKbSYX0?=
 =?us-ascii?Q?/scU6qJB3sRMHfgHEW2mPd7XpakhAdOLndlpnf56RRbFzTmk0rWrlXNUBAc+?=
 =?us-ascii?Q?jPk8AXczXbOj8VMjs1DIM6K+q3ZlL3MBsHh8VjfoKngc4hAyKeNFEsggzJzo?=
 =?us-ascii?Q?2GCpxkCx5dOsuo+vidyrO/1oNqhSY6xHFW2uUp881oS/RcKXEfsn7afgZl9W?=
 =?us-ascii?Q?2/tEZ4pbE0NijPSBms8ff6bNubTtPJWHbbx8UQp9X/IWuLcWcLA4vdM0S7H7?=
 =?us-ascii?Q?OA91vtdmeClqXKNLpiS4C/nzC5M06bl5k3tGShLGXXsrOhumB7QV7V3ho0Hh?=
 =?us-ascii?Q?7aC4d8Ana+mestvSM0g5EhBU3sFjPAqhQHSLTzbxkCxkDnBEl7Qkj62LWWO7?=
 =?us-ascii?Q?BNUV1Uwts2A4U6+01H/iqVYnfYwqdiXQ5Btig+4JsILkOUqocPIBiNu3cGrA?=
 =?us-ascii?Q?KQO73li1FkH5h4dGnMX4DuZb6129xtszeYVOHmVB/VJo/4U2YzefRzihF/4v?=
 =?us-ascii?Q?C6mNove1EoMDhgn7iHQHaZeNp77Yg4oNYMyd/YmAY9N+VGJaJLPlS9lx6RFH?=
 =?us-ascii?Q?lbFCbinM9e6a3n4zluOsIwYJughYbLqaj5ZbpUHjotAbi4mqGTQRmvlMtC9t?=
 =?us-ascii?Q?uXXZbk6hZLmYUMkKHEbttFXCHxwblwEy76QmElXfJ6AS1TWSo21tR9yQnQk5?=
 =?us-ascii?Q?rtrBiJB0jFHzfQHTNfg+KZmTuem0wpoQaeIVMLdwPeXJewgGEJmfKMn0Hnsz?=
 =?us-ascii?Q?2HqbzBsL3abNBHSgGkSnpyw1lBXOVi34Bxs963K9Dcw9AVfmquFqwgwFqoyk?=
 =?us-ascii?Q?assmmPYsyld03ybzAP+7z8ceYkhXx23wjY/bQsAogvuFjCG4lky2ie7B6Swo?=
 =?us-ascii?Q?kvBTNSBoS/yt19dAy2VimaQsoTaVCJZsn8fHo7D7Z6++U0yvTzaQkJqpzXY8?=
 =?us-ascii?Q?dpYFBZ0XB8/YBZ2Nf20MI8zNhGraPXz1CM5a8AduDOrWGLh2lsfc4RrYckdN?=
 =?us-ascii?Q?VzqG8dK0erIfqZE8jUqTJgfElPNrcGlNZ759ST41KwSl4QDtwB37/VMxZM1W?=
 =?us-ascii?Q?CNIKPw9h1zdAOwRvDyaZIyV6/jgsRUH2opfQVVVT3Tb+d1kjAWb+xU6lEsUk?=
 =?us-ascii?Q?NXwYSMXb2sUG3jeHVux4j3qD94C1GpNLMUudWV9hg1jf8GdPpUnlrrwymptX?=
 =?us-ascii?Q?fFNHaHdx/Yx/DKBVW1h0cy6Xd999bv0z2xuXgNZl5WFgba4/CfE3luYX64zj?=
 =?us-ascii?Q?ZKB9bBKmhELRjit/xNv8D8jPOKuBtd+9LxfqKdPy220Cbu0m5YDGe4RL/qof?=
 =?us-ascii?Q?BhIaBTNCb6BU43w4LwOxMK0hTPu8FL6tr7TqF7GAb3l4mfuFCUbVBdOswxWI?=
 =?us-ascii?Q?CS9a3b+XZ3EQBUBQYuE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 04:16:46.7199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f388651-f634-4cdb-93f2-08de1db47774
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787

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
index 576ce44d7166..cfa4e204e2ce 100644
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
@@ -5649,6 +5656,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
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
@@ -5690,6 +5719,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -7609,6 +7639,54 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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


