Return-Path: <netdev+bounces-240129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A02CC70C62
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E2D312B9CD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F950319852;
	Wed, 19 Nov 2025 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cc3Q4vy9"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7306371DD9
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579800; cv=fail; b=MyC2Fz6VjPwBSI1uG/Ja+rMi9ynFvrfsvHliD9mat3PVMawevtUJ/LTkuxiPSLHpjhGd1EwiteHLIC3l8eGvG682QBZHOXpqqoxIfIe+0AfH+kt/w9aUPVP6GZu5ZK2ZGF9zXuPVFbQVw7U/9xwbkTljoWAANLhNW8ryNeJGd0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579800; c=relaxed/simple;
	bh=sYmUd5wKhSvJZ3Wbk92Z1/pMRGG3cUgyBXNHtPzbCmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f08QA6BKN0VZ4Vvs/zsbkptem+zlL/CnrVCvnYoOCpFzRnmEjH8Pnj1N+QnKheHQrF4zcvFXH4k1CBWbEpOz7F6V1l55Lu/pC/QdV8pCM+ayVJWnmf0/y7OPOlvd5re4KuCIIbnwHfSbWaH3ZZCzJJ6zOdlSeEOkDJ+kqv0lraE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cc3Q4vy9; arc=fail smtp.client-ip=40.93.194.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scgp0ddd6fxH0U5567Cv5pYHm6/tJJBQpUPf8zM8usF9KBJew1S1hhLyGa42YMyM4rSWpAKDG8Lben80I4ZayVKJo4/GnPXRrsZekl3U5l0G5IAaNDEy1QMg9OQhZ0MQlir38ploAuArFq0uXV0QSx//tZKt1RnL+rLaKILF1AXuUHhGfJfXkGT+Pw7eYyycTq9cYMgDiCDFUZHm3W6RRHLW6AOLAvlrOvOFJ10PIhzxX8a5VJGz9oZrpt7G951JRPo6nTjhFIzwidNhxg8oIYoAJBHClGVVBHzoqpnySifG5BNWbpT61PvuWdoHoIgLyanu4ktraYRo9A9gp9kJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHpVNU8aDm/HlPU1nCy4kfLHW41/kuGbPULif/AsQaU=;
 b=GxUIND4VzXG/QhmZKWrylMcJjXyG/PfvhyTPdfuMYDkvjC3haYsF5R2uYHUcBSh8bkjbVYKgJ3egn5/Xznw+Emf7ByO5KdOw3JU8hnjlM7myj6CDi4+lrrwMYTmvRMvI2KnKGCcMukIXqORdcDVvuLpLngUuNMqxFAwU0/HjBOPKrLD2hTaHK3h05kg2sbC4nNCjjfZzcs3e/FdQRoKvP+NZEreJqBnP7C05sockIDVUv06KFAnmvty3+6B6uRUZUHzEgKAJNZlnxclAtOsWzXRDDLoJkrJ1Z3numDaZ/Y9zkgNt8RPe8x9s5Eyt5HhvufRw+RWSlxvrFi8KcbjlvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHpVNU8aDm/HlPU1nCy4kfLHW41/kuGbPULif/AsQaU=;
 b=Cc3Q4vy9+He0lHFlU1OazReL2AgeQOxgKTJ0jGwE6snzX6iuStFH1InglsG5/iOwShCDeybwpgTO10yJkGYJn9U5h1+AAoJOOKd53f3Km8o8+vEg8bmdYM/F/HKUxM7NnawF2vi42ZyGx+bcj8P3dTiV0MR+XKVKyG4WHLRxS3Wq0TsGIaoYGQ4s32PV5WKxM+k1t28YLsF62HCk/JRl9oRf2vf/XlnqgCcP6YD3iY9WxnvAHxqIGjsC4kgouP3p45s231TGM9wPDhVZ5ZfxNkkx56PwZhe/ThgCb8Kabj/Pjrm37kfax9ESHGT+jaXbWUodO0BcepfBWs3ckQ8S5w==
Received: from PH7P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::32)
 by PH0PR12MB8052.namprd12.prod.outlook.com (2603:10b6:510:28b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:16:14 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::58) by PH7P220CA0021.outlook.office365.com
 (2603:10b6:510:326::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:16:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 11:15:50 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 11:15:50 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 11:15:48 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v12 12/12] virtio_net: Add get ethtool flow rules ops
Date: Wed, 19 Nov 2025 13:15:23 -0600
Message-ID: <20251119191524.4572-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119191524.4572-1-danielj@nvidia.com>
References: <20251119191524.4572-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|PH0PR12MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f04e4b-937b-411d-ebdd-08de27a01b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vVqn/nDkq38egwsIqzlzV0lgitvi1c3gVfyxepl8MJSZv+KJGpV31DE2UR1X?=
 =?us-ascii?Q?zugyzWFrUkZCdP7Mfl1siwEzNDIeo8ZXwLuOmutCeovAry5M5jDetLL5Xjmg?=
 =?us-ascii?Q?ygXRiBhvSLv+Y9fn4Ua0RkgSGEqIwjvEGKHNfnyoZMbOnZnXoGV3R9aK3ET8?=
 =?us-ascii?Q?/nrJLezdncR++rWyGNzuqE+wgLprX5ZPbSLBdh1yUPf8S6ykWmXsaH9ZyoKK?=
 =?us-ascii?Q?ex05Vskgtp2DmeOrtTfnHk6XgRZtMzEjumWI6O9OGo/hqwfKqYNAQeV/w2Pt?=
 =?us-ascii?Q?waFSMStIJPtRHLtKLDMzVOgMD3EDNU7do6dCWzGrXFEKwnqku1o6YdcgGs4C?=
 =?us-ascii?Q?xoMJf7a8pLoEznS18iVdbe5ClX4o9boqF+njIUK5zfgGH9ciIl9uIdwZnBLB?=
 =?us-ascii?Q?JUaK53IzYyTRB7yYY48TDhIaZAVYHkjNlFupVSaLCc2HDGLTj7w/g2E5QQQX?=
 =?us-ascii?Q?J8OO2ZHOd6fvQA8NoBGcV7M1tMveqvZ0RgrAR5Yy2r8eJYMcyN8+LSiAcT6D?=
 =?us-ascii?Q?vn5SUtC4LwuN6eojElwP4O637t791tJ7iOmK3HpYycWuaJZILV3k/t8TjUHP?=
 =?us-ascii?Q?fidoMUSSgpndjTk3UDDL1EDSkR296oLgklsNqUMVu4gmUFddDAPSRBigvzCN?=
 =?us-ascii?Q?I2fe3b+ckQlcosNNZnJ9CtCFAfmKuWkmJWXISop1EbFPPe9o2Sa1hIQK+p+8?=
 =?us-ascii?Q?1neVrTZtvMbVV2UD5hVc4I+aXdl5rvXU5lxAQJS3AKi0hT/zIKPWUpvhO/sk?=
 =?us-ascii?Q?Gu8vvDHN3UJgtnLCOC1ROAyRd+iheEiU4pqgAi0LycjmAdA2jx/mVeoApgfO?=
 =?us-ascii?Q?vhBrVo/DOTr3C9YR8Zfun2gudTLwsanklrAxFypMTqo9ZMU7VdM+maI1+1RR?=
 =?us-ascii?Q?y8mysqa51EBDMKprrD6flCraLVDiTK0GFej8amLbjoastPyzjxbzm+UDB5Ko?=
 =?us-ascii?Q?Eqm8qXxdPOCiGvHr9XEXNPRHvCPcAQRzhJD48JStly1fFA6OF7/R0YE37PUz?=
 =?us-ascii?Q?pWjDnb5ayMkd1mI8HwMxvATMfWs5Z0J294itJUK1AHdRolJvjDMHsHYi54cW?=
 =?us-ascii?Q?aGeFozriXI7u3o9713RVKF4EersqdYpQ18/R6KCFvE+cY6gt+c4CmalT7xce?=
 =?us-ascii?Q?K4cC4OUyUsiWBV4v3CodthqWUHsQWIAX44Zbapcbi0BBUJTd69EProZfQzeJ?=
 =?us-ascii?Q?qPx9ALWlRqMyenuXK0hfxxa/m76KRqsIBvwMQ6AVyV/6iXYZrUC2TYA/1Ws+?=
 =?us-ascii?Q?goEiivQx2GTAT9G3+0ye04CGnAeGlJoWMw/2nhXt06OoLMSVF+GZsy/oJFwe?=
 =?us-ascii?Q?d0RHLiofswenoY7Rb85tUiGRtjk802M34EvnwYiXo0whvSBvyaT0YMZWYwV2?=
 =?us-ascii?Q?YZC+CmkpqWstwxoiPKkMj75IqrX/TLLuud4+FCyBRvm9zwaFElZcNWKK0cjp?=
 =?us-ascii?Q?dp6DdW6snhT269HmRjiqH1lqVxBli0upFAiFxsYMs+Hj3NaRWdsUXRVNeYgu?=
 =?us-ascii?Q?BH/1B1uIVqIrxOzTYl7C5KPnNwRwp/xF5HK5jdvZKYnb4dJL/oLzKydSrlcB?=
 =?us-ascii?Q?M5eXzA4yql3SaJ6dEU8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:16:13.5876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f04e4b-937b-411d-ebdd-08de27a01b24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8052

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

v12:
  - Use and set rule_cnt in virtnet_ethtool_get_all_flows. MST
  - Leave rc uninitiazed at the top of virtnet_get_rxnfc. MST
---
---
 drivers/net/virtio_net.c | 82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e6c7e8cd4ab4..2bd2bf6b754b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -310,6 +310,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
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
@@ -5669,6 +5676,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
+static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int rc;
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
@@ -5710,6 +5739,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -6628,6 +6658,58 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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
+	xa_for_each(&ff->ethtool.rules, i, eth_rule) {
+		if (idx == info->rule_cnt)
+			return -EMSGSIZE;
+		rule_locs[idx++] = i;
+	}
+
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
+	info->rule_cnt = idx;
+
+	return 0;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
-- 
2.50.1


