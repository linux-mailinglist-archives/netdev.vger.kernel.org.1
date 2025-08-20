Return-Path: <netdev+bounces-215344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AFAB2E32C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 19:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1025E58AC
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2433375BD;
	Wed, 20 Aug 2025 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cHU8kkZQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91BF33A00D;
	Wed, 20 Aug 2025 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710045; cv=fail; b=vCNOV0FlfZAWYD1kR4E2rpQs2eo1kpVQouCkXppqwWABMWaBSxY3Md7tAdlnm8ZZsZPXSaU/b51g6BharP1OMbA7flnPD9EAr53mJ9xTvIprIYZHapBMbXxXp1mVrDydOtNVTRDooMpPKf1kJ+3xGrLKjiXpHQAHGNILLq6pMwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710045; c=relaxed/simple;
	bh=Wl4bj64miFECdtz9tkorJIrguvHN20vYT8DIRvi3ryQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLCzPZUtbtCsXejQEDvd/q6o5J4izxKquzyZgkS5q2UQhQLC0ZnmPZT9wQahRGiCLpo2mhP1WKwMYgjCgXY9BEVvTcvPqS6/4s8NavWdE1R/+tSbZg+up9RBX6/zxxHR6cBvAHL5+LkzcqD6iXrgIUxa642WN3HV4PfXw16bCsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cHU8kkZQ; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wgwz7XlcOz3KeDgxpftD7QwAQCgXJyMYbTx9peJ7YmVgAb/FNhBMs4wjsdCyghHZdV2VjOBdzLGiTqkmJgbV6OfVV4lKHPtIcNoFVxramRQlGDMawlB+OL9+PTDEJuKFPO2emZdZNwOAUkksI0aPm2jLXK+zKmqKfTPlCS+8et1DdHc9MBvXyjz88Pxz/rVGBl0xi7zaZuroB5wZ5LHyrWAVIziMz/vMN44/mNxMC1T3kbZ79s61Ki928zNNGKSoYysqN9Tg7p3wRsRGgBMGveo+U4BoEZSgD7p+S8ZavlpteNDqQll0xkgJi7TEJop9hi+6CfuQS7+IDcLejMdPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rwrXrxI9rIJCg4skJgyT/yQXnkNM5TCRGl0o8QWyJk=;
 b=ANsUc0gwaxEBVAqqIIJAEcctZWcaJM/5DTVS9pGgnEVD7Nv208zDNW4WbDX3pGYBZ0V60L85Fe50VSFDuwEoQmplccQg3O8emQOeA0e7/7fZV9Z4pMcwz/7L782vMXrChDzJshVtv3YJV7i+fOPGEqkMmzQEPGoHl5sI+mcNU4GUaIdqyiNYHFhFqD/SI4FFUEMkO3l8G67iYrhSgWfGt/IEV+gSupDSfdSRiBpP80ZuNEGJhDXNAyiJUY7aaUR62F1G6+nFoCAkpeKXW0Ww1Tkgaj14/08qfFTuww7VL58w11+6NBTnA/1RD/qr5mKIK+ZMC8Z9aPlxIUdwsG8w/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rwrXrxI9rIJCg4skJgyT/yQXnkNM5TCRGl0o8QWyJk=;
 b=cHU8kkZQT9dMr5mio9qTqBxA7091K3momc5zCpyyjen1M2kXbRIwIqJaxMtv/sH/2Qh7thPkh+Gz8H7bhsZV7DORY6L92ZiLASoexjMhoC6Rtx7gb6O4ipVNQ+/wwgaT5B8YFEW5gE6kDHZLPhb0oxoTzT8MM7kJD4G6S/393G2hf9+z4yJBmXNAzpZM4w4jFiT8xs2j0a4kuHUUPsMWOWb953DFhR+IQLGscCzMVfvvoRYvFB5nb5D3Kn3YsSA72mu0pn3THYZXukrVp9DRA+5uO33eIsbu64ZFdStzrosD/3NK0T1Ewoqoxt26+xAOHLfqW1MbY0FbkdDCL/4qGw==
Received: from CH2PR07CA0006.namprd07.prod.outlook.com (2603:10b6:610:20::19)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 17:13:57 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::16) by CH2PR07CA0006.outlook.office365.com
 (2603:10b6:610:20::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 17:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 17:13:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 10:13:31 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 10:13:31 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 10:13:27 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 6/7] net: devmem: pre-read requested rx queues during bind
Date: Wed, 20 Aug 2025 20:11:57 +0300
Message-ID: <20250820171214.3597901-8-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820171214.3597901-1-dtatulea@nvidia.com>
References: <20250820171214.3597901-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 818e5c02-2578-4514-5940-08dde00cf261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AbVUr0GCjynR22dOFT3o8fiCafxT0ZtAph3qZ2M4dZZgTWbaTfpVQlZRVb0/?=
 =?us-ascii?Q?g51Jbx2NXUU/LNGaL2IWvybdgl38Gf0sEJZo0j0C+Z1cV2dY0C4Yoe0JlDO8?=
 =?us-ascii?Q?po2rB8QuF95F59UWaNhemqYZbyUjPpqZzuOJ1A1gn9V2y/QtN/6ZSz3aLEUT?=
 =?us-ascii?Q?eSgwDNYbNop24OqCApcHMa4G8WkJc6AUdH5izuwte4bhmtNvRULP4MNA0cxe?=
 =?us-ascii?Q?vg9oZM3sTWWeFLzK7UUqh7TsSuodn8ySxUsCfgcrLV8oj6KCfA0xmLCrGRNI?=
 =?us-ascii?Q?AszzuxuHIlNydSVEW6TP+QeGzfN+Xi8ZQaHCEZW/E39Pi9IgpvdN6MflyCPL?=
 =?us-ascii?Q?WcQAIquIvFwuJiSDsaZESQBEG+l2DGcGH20HvMtlivgMCDAbaxgo8xLEMiAl?=
 =?us-ascii?Q?evUEjUgimYJ/h5MRasXpG8htSKj8h89zMO68DTNYLbAzUSa4A2tX8EcuTaOt?=
 =?us-ascii?Q?VwsOPDYR2xPmOfJqFl6BcgoMMenwj0V+zYPK3VA2OD/JY3g26rgzOIRCa6Eu?=
 =?us-ascii?Q?W9GscyYhlmvVT3eQMuSSJiOniAp+8MfrlMZlnA4KFW34HtD+hrZK2qb8+0IW?=
 =?us-ascii?Q?6cMreg6sNrqr/q4q1vBPhrCTBKwEPMA9cVb3PjZFncH4vGAYJDsToA3R0IKU?=
 =?us-ascii?Q?1qAqNM/pnkQ3cKmWEqkkxUjMAdaduljY77CYWjpQ7EQ1c+7BMzaojyM4aBHh?=
 =?us-ascii?Q?0YxpOq6GSz3ngzSchLEuQVBYRgny8Ry7YV2dfKLXy3hkaid452AD/75bmWCb?=
 =?us-ascii?Q?YeSn34Ss0WN8vvH0yUVxmZ143w+fj1eBRbtjFziEMdBmr1wdDduaEmvZrOAp?=
 =?us-ascii?Q?ymEsnf8dErpYHi0H+VAdomOYclANX6j6uU9wBH+xo+CaayhFTowGn6MIc8Da?=
 =?us-ascii?Q?FG0Jn0wh0giVJlDoY3Y1Qj27G6V2YvFQDpX3XdjxWl09b5OOCXnE5L4G9yJI?=
 =?us-ascii?Q?4vwjwBXHuIt5Z0G+ItWoU/tqfl5inmxuQCLlQMltr5xGwsZRheE2K/0OeX6Q?=
 =?us-ascii?Q?W1gOf/yfblHQoOuQTWB6fQ24y1igRTn24NIl8t42x56UsP4x7EX+EBY3N104?=
 =?us-ascii?Q?1NmFDQa/0B8scpV6KLwzXTtzH/uo6o0WU+lLnAdpsYw6+AfdR/1IW3r1/sh6?=
 =?us-ascii?Q?S1okHle6ks6rPUj1WzNEzoVL+hXNljMihoIWP+XMtOyNKUcZ3q4u5Z5Y7zwU?=
 =?us-ascii?Q?oVCycUQSQrAmU30n0ZaMilp4GwFvsBY1F/6cOdMj54ikQbiR3R+b/hepPh7x?=
 =?us-ascii?Q?AZtX6HwhknAegHuYKXaeB/WRDhQRCOrWCe9YeGFGkz3JHRb7H0hfq3TXWN2k?=
 =?us-ascii?Q?vpc86HO66oAqTol2RvIyWjK4E/PxjoIuC1RI103y+OezIFuftUDNCVWwNdx1?=
 =?us-ascii?Q?/pzeCSK3nGcEW0RrRRwprmFNA9qqCSmKPu6Sjlgrq5qgfWQc/w6If82VtQl1?=
 =?us-ascii?Q?/2g06xqC6ZSzPB3VofOzYrn260WH36DD7C7dsk8yJLMoPFAqfS7icsHnvYuX?=
 =?us-ascii?Q?3CqdC/gmObuWP5AIALsLl/0JkBzCjINr6Xhd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:13:56.0678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818e5c02-2578-4514-5940-08dde00cf261
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916

Instead of reading the requested rx queues after binding the buffer,
read the rx queues in advance in a bitmap and iterate over them when
needed.

This is a preparation for fetching the DMA device for each queue.

This patch has no functional changes besides adding an extra
rq index bounds check.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 net/core/netdev-genl.c | 83 ++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 27 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 3e2d6aa6e060..0df9c159e515 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -869,17 +869,53 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	return err;
 }
 
-int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
+static int netdev_nl_read_rxq_bitmap(struct genl_info *info,
+				     u32 rxq_bitmap_len,
+				     unsigned long *rxq_bitmap)
 {
 	struct nlattr *tb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
+	struct nlattr *attr;
+	int rem, err = 0;
+	u32 rxq_idx;
+
+	nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
+			       genlmsg_data(info->genlhdr),
+			       genlmsg_len(info->genlhdr), rem) {
+		err = nla_parse_nested(
+			tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, attr,
+			netdev_queue_id_nl_policy, info->extack);
+		if (err < 0)
+			return err;
+
+		if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_ID) ||
+		    NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_TYPE))
+			return -EINVAL;
+
+		if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) != NETDEV_QUEUE_TYPE_RX) {
+			NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_TYPE]);
+			return -EINVAL;
+		}
+
+		rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
+		if (rxq_idx >= rxq_bitmap_len)
+			return -EINVAL;
+
+		bitmap_set(rxq_bitmap, rxq_idx, 1);
+	}
+
+	return 0;
+}
+
+int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
+{
 	struct net_devmem_dmabuf_binding *binding;
 	u32 ifindex, dmabuf_fd, rxq_idx;
 	struct netdev_nl_sock *priv;
 	struct net_device *netdev;
+	unsigned long *rxq_bitmap;
 	struct device *dma_dev;
 	struct sk_buff *rsp;
-	struct nlattr *attr;
-	int rem, err = 0;
+	int err = 0;
 	void *hdr;
 
 	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
@@ -922,37 +958,26 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
+	rxq_bitmap = bitmap_zalloc(netdev->real_num_rx_queues, GFP_KERNEL);
+	if (!rxq_bitmap) {
+		err = -ENOMEM;
+		goto err_unlock;
+	}
+
+	err = netdev_nl_read_rxq_bitmap(info, netdev->real_num_rx_queues,
+					rxq_bitmap);
+	if (err)
+		goto err_rxq_bitmap;
+
 	dma_dev = netdev_queue_get_dma_dev(netdev, 0);
 	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVICE,
 					 dmabuf_fd, priv, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
-		goto err_unlock;
+		goto err_rxq_bitmap;
 	}
 
-	nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
-			       genlmsg_data(info->genlhdr),
-			       genlmsg_len(info->genlhdr), rem) {
-		err = nla_parse_nested(
-			tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, attr,
-			netdev_queue_id_nl_policy, info->extack);
-		if (err < 0)
-			goto err_unbind;
-
-		if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_ID) ||
-		    NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_TYPE)) {
-			err = -EINVAL;
-			goto err_unbind;
-		}
-
-		if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) != NETDEV_QUEUE_TYPE_RX) {
-			NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_TYPE]);
-			err = -EINVAL;
-			goto err_unbind;
-		}
-
-		rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
-
+	for_each_set_bit(rxq_idx, rxq_bitmap, netdev->real_num_rx_queues) {
 		err = net_devmem_bind_dmabuf_to_queue(netdev, rxq_idx, binding,
 						      info->extack);
 		if (err)
@@ -966,6 +991,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto err_unbind;
 
+	bitmap_free(rxq_bitmap);
+
 	netdev_unlock(netdev);
 
 	mutex_unlock(&priv->lock);
@@ -974,6 +1001,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 
 err_unbind:
 	net_devmem_unbind_dmabuf(binding);
+err_rxq_bitmap:
+	bitmap_free(rxq_bitmap);
 err_unlock:
 	netdev_unlock(netdev);
 err_unlock_sock:
-- 
2.50.1


