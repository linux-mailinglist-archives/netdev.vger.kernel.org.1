Return-Path: <netdev+bounces-214039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A91B27ED7
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1E65C2D4D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B89830275B;
	Fri, 15 Aug 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hlogYyi2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7AE2FAC0B;
	Fri, 15 Aug 2025 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256048; cv=fail; b=nPwbTwJEy48GChp/I6ryq1Sse8gTJ3vgQ21GuYsvgcBCd2297pZCMUuICHVlK0b+6DvCVTl1id2b2qSGTvZLxfZcqTY+CE1tLGOyTmOx4KJokyKkvACLcAcLEGS6J7egd3OnxdE/RzsRLKN4b95Ar/sGuEk3JCTGVuarDySNe0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256048; c=relaxed/simple;
	bh=piQCW4Y/ARKLErABQPFMdpdAmfpPR+xD+gU6RR+JBZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvSKIGNtfFhRATQmewXw0luSiL/RRnzY18uPlAiTqNVB6haX0FCIJYyyIjv9+WoF7yXMPn3U6S24ehJjEHFKV6WSG5Ut0Kh4SaruK5cMctrBNlFIZqP6QShopfgZ4PaJ2GRMztfuGNGXAwY+9IbmqDiub6uWlR76Jikel/nTWvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hlogYyi2; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cB4W88HoeqLGonDlWdgQtIMnPr0pf3YteN9GN/k/6JFElz6CfXySawEeoK7eBKOZ15DJz8YbJjIZo67dGJ4o7ah4CIKyS8TPcdtcgsgfu1MQq63zathev6EnOoQa4LbEwChc1UEfYevqjciMcpG4ARpKRuDtB3WkJQeThmn3FihEKOgpjlDVekvnn65Gf2GlhyWlH5xvvE1lNLlQ5QJ53Qkyg9jDXSWmlI2lyYsIU6R0cTScLG+H+N29leZ/01x7pYq3c4v+QEiDONXdIpJ4QA4/UUq/Kaje0S0F6P6229ODALt8BSTwRdqWt9Okamlv4TiU/ahUTXJWLsKwHK9BYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjMlIFKGGcjJyUy+9rF2xSi4bmBNuK6lddkqHpygMQM=;
 b=DwheZnR6pe/Gk9xrWzb6niIkkPrNnKZ4PZQrkhSmzxAwX+QQurQsRjSOkXC3YqFK5SccJWixDI5iNcBkgFizZFAxaqx+CcbjrSEUnesIFNvng9cfam/f2peK9zaqryK3xne4Bn4chLHhwm4ySS1gmBYgBunjqBvA087YTbIeAhrYmzakpTLVVVFHTaEqMPeXdczwg2WCpC9jAfP3pR7IXisaw47k674Rj4wkr0iskYfGnTOrmS/q/DfiLQb9bl7hr+rc0hcUDMr4hXieRYuv3euKAMvt7ZpReYTqaXnOykx2WK/4mIsaD1k8b64V2+NaKqoDCcscoSw7U8eVbyonfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjMlIFKGGcjJyUy+9rF2xSi4bmBNuK6lddkqHpygMQM=;
 b=hlogYyi2yYJCV67/TAjXO8aUe08GFQKT/vLA+oMaKfMjacB/rqGgDvh/U2KUFdaSoQCe63XzeBcCYRA3qzNUBYinNZhRQ/W+RJfPAzUaQQ/1al3ib259nkoaUGN8bQ2X9PwuGxpMrI2o9k4qXq+TQQAk7ikftV8xJDfdwx1GT6O9dO8ITL74wnkCvN6J5A4wG0MJZgWYHb28hJmyr2lnTtg9OULPWI8wI4I+sKqg869d7karKsGmeIVn5tlSBQbg2yjOR1BGavygzJlD/0TSSIM3z3EO5uZBsjl6667uaFtTy1VppEbIKvSoyg4qP5gInYITHUfmiBL2uj+D6TmBjg==
Received: from MN2PR02CA0029.namprd02.prod.outlook.com (2603:10b6:208:fc::42)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Fri, 15 Aug
 2025 11:07:23 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:fc:cafe::75) by MN2PR02CA0029.outlook.office365.com
 (2603:10b6:208:fc::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 11:07:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.0 via Frontend Transport; Fri, 15 Aug 2025 11:07:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 04:07:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 04:07:11 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Fri, 15
 Aug 2025 04:07:07 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<tariqt@nvidia.com>, <parav@nvidia.com>, Christoph Hellwig
	<hch@infradead.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC net-next v3 6/7] net: devmem: pre-read requested rx queues during bind
Date: Fri, 15 Aug 2025 14:03:47 +0300
Message-ID: <20250815110401.2254214-8-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815110401.2254214-2-dtatulea@nvidia.com>
References: <20250815110401.2254214-2-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: c6db060e-7b1d-467a-d704-08dddbebe92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U2qIFNbWKggWJsG4c3zv+A2xOr6WB3vzh6qGJDWJaNmHqtNe1P57//Oh5rYD?=
 =?us-ascii?Q?r9z8iIycKEbhkRnaTax8UZ+kuh55s6740Wmt6arl/vyokU3rW5vKhLyMKDzo?=
 =?us-ascii?Q?IMkQytqYQf03SefIuzaZzAANhH0mc0hesl4UfmoPPyAHxqDuAKdaSUKqXT2m?=
 =?us-ascii?Q?HIzGac4+mWHaP8HSGedWFDpeDxZCVgaSKU8xTw6zQnqgGD9fQfNY2yjuLHNV?=
 =?us-ascii?Q?W/sQQdmmh9j4S7afF32ICc035r7Ydf06LM7Q/JPNnhMPdKDVcWCgn0rRd+p+?=
 =?us-ascii?Q?OOVSRdJaeReoWxA2hM76Kqvmira/8pEcH3Z/GKAKCy9jLFbPAdd65QMkz3JZ?=
 =?us-ascii?Q?HGxiG8oBnWPYSK5OPi5kabEXA7fyikQrQjNrnSxGkUdRxjhIQRCMxnK10eMe?=
 =?us-ascii?Q?3O9Yj8xpiaVqllywB2vZeByvAL5FCBdzUiQL8Tl5gG54S4XbjOJu7QHWVDj7?=
 =?us-ascii?Q?pzQxAf1Uhcqj72u7lkr27BGh/DoLOl5OcCDE2PlMbp5nmAYMkoWf6CXy67Ez?=
 =?us-ascii?Q?SZFI0FADzPQKDhYB+akymonHbpx+A8zpXx9OpM82/RX1jRKHJbXpUDZkCt8V?=
 =?us-ascii?Q?ef88Mxs4DS5992mq3BfzUORnrixO4wGKeBbXOkXQJ36H7YZLihf6ywhz7b5W?=
 =?us-ascii?Q?2U2sMJiKiKIOM2oC4E3WstX4ZS7Y3wMVj/iSc3d8JANsSQDSUd8OCYH2I/XL?=
 =?us-ascii?Q?rPxEULooZ1Qp5fawTPRYSf0mjmnGJBDkYdRrE7cJ/f5o9BqSP3c5COLgG1Cr?=
 =?us-ascii?Q?2QGswq0zeCfDcVJcZz196ankCuvX6WY/SLW9J9qqlp0Kmw9UWS+8NOx72kfH?=
 =?us-ascii?Q?gwl3/VVvTUbtcAVy7t5TeK2f7NQLLAd6Tg9T2VcC3oKCiSVyo0WRWuMZXbFN?=
 =?us-ascii?Q?MUW5udTPXG8wf0HGvq+bFWl8aMlRsZd0lpdRA7AAMyWzJFjlsW7qhLi8dqmL?=
 =?us-ascii?Q?2vcUhi1Qh9H+eBUOK0Jw8DTGl9iRcOtUy4xCaKdmqDNGX/10SUedmwVo5U0g?=
 =?us-ascii?Q?6hdtjJjIP3Rqn1MwNl20/LZX2zOwDAj8df/0Z+bmxMPAD36sR68UpUCz8RtZ?=
 =?us-ascii?Q?fx1sDKDWSEabe0QlOEsQ4wL9euf6icxVtRyXdAD0X2pIXyDBve2tUF+AfEf0?=
 =?us-ascii?Q?7Ssplzu69+xj/kiOZti0UGCYAdqlrqzi46Wfj3p+sFvMtkM4Jt0AnZomPbEg?=
 =?us-ascii?Q?xqgR0A82FYxJKka7M4IlU4iyRkQXeMDb0qK8Y5qmUN0m0h2/JUR9bqqCtgvB?=
 =?us-ascii?Q?BQPTRmbOdbDpIVodrYl3oLbnfCNfAWLmvrjmnTGogVrYE/WBxSig2Q+TeXQW?=
 =?us-ascii?Q?sKLEFUOFQEoHD/PfauGVJXh1sEDKi7ImEzLOJOtSiHk4CfBb0yF978+lJA9C?=
 =?us-ascii?Q?biQ54/VlO/4tBcgzZP3jeEaPSiBuIa9wyuk9kTxFYJRgZXXFtU09ZU0HR2RZ?=
 =?us-ascii?Q?Jo09Ew0XxSWn6gjbK/4stD/m9I6z6ai+oM0O9SWkIhPL4ldBybKpDaC1CKBY?=
 =?us-ascii?Q?0TiMZ5qscpq1zjpYw3FmBk5p4hsn66KU/aqb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:07:23.0411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6db060e-7b1d-467a-d704-08dddbebe92f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873

Instead of reading the requested rx queues after binding the buffer,
read the rx queues in advance in a bitmap and iterate over them when
needed.

This is a preparation for fetching the DMA device for each queue.

This patch has no functional changes.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 net/core/netdev-genl.c | 76 +++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 27 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 3e2d6aa6e060..3e990f100bf0 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -869,17 +869,50 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	return err;
 }
 
-int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
+static int netdev_nl_read_rxq_bitmap(struct genl_info *info,
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
@@ -922,37 +955,22 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
+	rxq_bitmap = bitmap_alloc(netdev->num_rx_queues, GFP_KERNEL);
+	if (!rxq_bitmap) {
+		err = -ENOMEM;
+		goto err_unlock;
+	}
+	netdev_nl_read_rxq_bitmap(info, rxq_bitmap);
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
+	for_each_set_bit(rxq_idx, rxq_bitmap, netdev->num_rx_queues) {
 		err = net_devmem_bind_dmabuf_to_queue(netdev, rxq_idx, binding,
 						      info->extack);
 		if (err)
@@ -966,6 +984,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto err_unbind;
 
+	bitmap_free(rxq_bitmap);
+
 	netdev_unlock(netdev);
 
 	mutex_unlock(&priv->lock);
@@ -974,6 +994,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 
 err_unbind:
 	net_devmem_unbind_dmabuf(binding);
+err_rxq_bitmap:
+	bitmap_free(rxq_bitmap);
 err_unlock:
 	netdev_unlock(netdev);
 err_unlock_sock:
-- 
2.50.1


