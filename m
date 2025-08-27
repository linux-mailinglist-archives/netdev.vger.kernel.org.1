Return-Path: <netdev+bounces-217325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EE2B38545
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41657980EBE
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC2F218E8B;
	Wed, 27 Aug 2025 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oKz7EXmj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254819922D;
	Wed, 27 Aug 2025 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305724; cv=fail; b=AnfxE/VIP0fhjkmf6aaolAw+Yyj1TVLnXrEpUnHwivKZtFTxGKlxdw+5964tv77I/Sa6zXyUpUVe/pTh3sE3tIDYNIgPnHRzrdnp716W7vGo6jNuxWEFw8gVBhfdE7hiWaZlZZ3a4x0AWhAEqbCieYS6sz3UIctG/Q62T1nvo3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305724; c=relaxed/simple;
	bh=DWufN2C0mdlk8uGcdsfTDK0CbHwX3h2PAkN6FW8QgCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogoMXafOSGHBaogwSssuHFK1xvDrsiNDCYi0hvPylhn2VBNckU5EiigSDlYzrvzpv6F21Ha4lZoC0g1kH1vDvJb9ABmskYX0TsA6RyKmOTgI4v5jvvC0sZhJg1xnFrA+CqOYUBj5aB/HnaI3MCxusZ5CbW/C1n0heDEgi4mqHVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oKz7EXmj; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1xFoNWG3vxzB5b+neZtZOCuVXWzXJL0Td4iaaECN26GLlSe6hYUJp+QFLgMtISo1q6EY+mPRNZQr3E8HWfnKBIfsFwLEVUFBh4m8xKSnyljgOHgN4WKn4l6Nd2XoJnLtHXGn82gVthu0AiZ6mxBBFfy5PRMMxY0vbXbbVtmCefU2C5she+WEC0NwgIZKQnEiQN/5UNLekEf089TKDzhzf2+vZ3GfBFbltswkpB1AaSBNvX5FcHoBKIcdqscJARXEiV4CKfU/YH27xS8EWl1RhUVnXM+eZCVDkk7u0UAaY9bCru2ii+rfQHsq3inukZuOAHiDnWZVYwfKkYxUa7JMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqCZEAreC9yAhvpT1ggdisLkrzLHuy+dpRPhV04p8C0=;
 b=l/fedNzsk4W6PTxQwrBbCffPAk+MwELdYxku4S8dsitbmq4cwS5XLf3ynEbw17aCjZXT5z5vrjnxT2nT/6tBZpSNGXNE33CT8HIlrSQ6iwOs/xIRMs67urA7665oIwMkmpzo6NMazBn6h1+HPMYAJ0zMrCfrHk0L6lRyW3PW2hcDG0RJEsk6Np+brUXBfwjyq3EkkCg4d4I4DwhJgfb8QO5C+weG4Hn3esYRQZJuX5X6UsJCAmNfrsSsq3atJ23Viaa18pBWjc1Egg6Dju5WnN9KJpkX992IVm5ip+V6dpWmiPc1umaitaO3tY2Ifk77Fw2PIhxa7OyQjjzZ4AzhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqCZEAreC9yAhvpT1ggdisLkrzLHuy+dpRPhV04p8C0=;
 b=oKz7EXmjhpBJv7o/R4RqBvyFG9OeMEHiPCaDNYv2vSW5sjM1VvDE0yTInork2XOsAFRp1a1O7XzVHoiqyPV/TqZHIBSG3nQE1gJ+ZDtuagxhtpr7a+9p+qTsrZPCdHHT7oIoJUacaXHF1IiQa9EQo0aixwlFctJTgT3Dr34GEcG3KBtydRfrgTs3bDbb74iKLnLeKI/LeIRvkdh3Cesllt62g257JXCf6fvNc1KX5jsi7q5Oj1ZBPwfSc3UoObXo4tVM0Gh4uz/iWxrf/m4edRAUYYULq6VBbC6hmEffcwP0PXT+hrSnPxQUh9Xggn1msEMRamrQjgECgTVwPg2rVw==
Received: from BYAPR21CA0021.namprd21.prod.outlook.com (2603:10b6:a03:114::31)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::623) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 14:41:59 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::2b) by BYAPR21CA0021.outlook.office365.com
 (2603:10b6:a03:114::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.4 via Frontend Transport; Wed,
 27 Aug 2025 14:41:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 14:41:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 07:41:23 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 07:41:23 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 27
 Aug 2025 07:41:20 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 6/7] net: devmem: pre-read requested rx queues during bind
Date: Wed, 27 Aug 2025 17:40:00 +0300
Message-ID: <20250827144017.1529208-8-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827144017.1529208-2-dtatulea@nvidia.com>
References: <20250827144017.1529208-2-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: db97e483-09b0-4d84-8b98-08dde577e076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/qoPzLqcjeD+4W0uYwG46P/l9MeU/o1RtwchNCIA4ce5Lsf5s/QjlDvshgHq?=
 =?us-ascii?Q?vHgmgkOg1TT5L7yt4rw7xLBSavX85Y83RQ+TmSH7AbNJUi9RkjEDSD7gIy9C?=
 =?us-ascii?Q?UZTkWwIpIu8W4uOJyZFzoMgkXXESJYQNpjlTKHRKb5kqVrCUpfPlX1IQOORD?=
 =?us-ascii?Q?ikSqMEgQAkNklfbBfe1ene3vXEUu9JH9YMQra+ycNU0GMNdZYSlMVSpuwh/I?=
 =?us-ascii?Q?sVbJh79CfEUjGAmuIdVJZ7uECqFDjmwYS9aaGyJDDqFpqvM8aYUxAps62ZTz?=
 =?us-ascii?Q?4a3zGAD/aBnPCOk2eEU+KrmFsAmjS60+z71Zrk90PvVgoD8JIXMGQZsxYCIC?=
 =?us-ascii?Q?UYOBfCHj54lAFSXx49ivcwIygvngPOSAGFvc3LyYytE8TddyNh0Djvl6jpz3?=
 =?us-ascii?Q?1ozTsYGmETaWRymgkmBFNrP6mzOBuWpT4+AinZTjbkpcvedDU+Sr2dXLC+9Q?=
 =?us-ascii?Q?w609X8Qzw5j+DUxz8IZj4uugwimsWQSpTGd3cb/9QRKTnA/Ip7Wi0t9h8vHJ?=
 =?us-ascii?Q?V++eozz+NTNjItEH7csC9yIr9OVQ9FJGDenrnCsh3oQtHIw6RLuw1PrDykSW?=
 =?us-ascii?Q?AzXKhb0AETzCJRxRdtTFprNB95IJ2ImlrlzdZnlnUfujg2cH3vv73+mCTwRF?=
 =?us-ascii?Q?qzMfDBLgoM75paqJv9W9atIaRCbVSg6SCubgmrqJNWqqXOap0PXWRIX9a0+g?=
 =?us-ascii?Q?1RKb6cBu8ScaYQkrZv3WwJfM7o8yu8j80LI8hsMgimjtWuyFTW9oHOAlCpxs?=
 =?us-ascii?Q?Zj1sIgqh7ELoQJo8utyXHp/9pV3ssTcChvXznOZTJ1S9Bszj95uR6LJSQ2YB?=
 =?us-ascii?Q?nWhIKvJlhBNtmVj5ZwTQIU4AexlBJZfvd0A9hur26nbxpS5xw7YUZKoVpgIm?=
 =?us-ascii?Q?cPGZttzeaeHhNSOz9UEUrrNenUL34iwVJC3G6Wzvz204xh2wAyJY07/kDcJR?=
 =?us-ascii?Q?PdEPGHdhI3SvThfaTYUyrbHjysXSPL5YoslF6f3HU7psRgoVVk5TPOhmde2O?=
 =?us-ascii?Q?KVMIqPU9JV4Tp8Ofva+iLXYehH6AvKG5045vbyemxZyE1MSfxsZ9J+msOXWj?=
 =?us-ascii?Q?mFZBiVXkY90jrA6xubopmBuWmO/kPAcepsPr/UYPtvnBbti3RAEvCgFljNTZ?=
 =?us-ascii?Q?c4ZTvJXLiRgJeIVXcNfp4G9lHeoHhqbkY7H+TxfhrQKhMEMhWDB5bgDDgZUZ?=
 =?us-ascii?Q?uGLUrIy+HyAXM0+Ri72vVptQ3wOTJskw2uFgGbmQXQbM3Pu4BmVxuY9uRvq2?=
 =?us-ascii?Q?j3JDPzwZI2hheZdGnD34jDzMjUHe+a42GHUFEvD/0PhOk8wEkFsZgPMyxTT6?=
 =?us-ascii?Q?HfUGOAhoJVofVMgJHBc7gcgPc9j7LGbPuyZWMxAgGeO8IaoLuidGi6j/PmG0?=
 =?us-ascii?Q?YUp3rcQ+NrWcgD1OD9EGRoToHzo2Nypay3OEhLb29NqjIv1fIw+R+4rkAfnh?=
 =?us-ascii?Q?M4ArW+sgTJcdD9UQsVnjLNcpKruljeUeXw0/UTOxEEsk7WhpojLf+Iwh4QNI?=
 =?us-ascii?Q?tF1MpZEzG4AW4DBb3qZuwb5/V12FGTdJvQUU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:41:57.3392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db97e483-09b0-4d84-8b98-08dde577e076
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1

Instead of reading the requested rx queues after binding the buffer,
read the rx queues in advance in a bitmap and iterate over them when
needed.

This is a preparation for fetching the DMA device for each queue.

This patch has no functional changes besides adding an extra
rq index bounds check.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/netdev-genl.c | 85 ++++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 27 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 3e2d6aa6e060..739598d34657 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -869,17 +869,55 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	return err;
 }
 
-int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
+static int netdev_nl_read_rxq_bitmap(struct genl_info *info,
+				     u32 rxq_bitmap_len,
+				     unsigned long *rxq_bitmap)
 {
+	const int maxtype = ARRAY_SIZE(netdev_queue_id_nl_policy) - 1;
 	struct nlattr *tb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
+	struct nlattr *attr;
+	int rem, err = 0;
+	u32 rxq_idx;
+
+	nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
+			       genlmsg_data(info->genlhdr),
+			       genlmsg_len(info->genlhdr), rem) {
+		err = nla_parse_nested(tb, maxtype, attr,
+				       netdev_queue_id_nl_policy, info->extack);
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
+		if (rxq_idx >= rxq_bitmap_len) {
+			NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_ID]);
+			return -EINVAL;
+		}
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
@@ -922,37 +960,26 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -966,6 +993,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto err_unbind;
 
+	bitmap_free(rxq_bitmap);
+
 	netdev_unlock(netdev);
 
 	mutex_unlock(&priv->lock);
@@ -974,6 +1003,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 
 err_unbind:
 	net_devmem_unbind_dmabuf(binding);
+err_rxq_bitmap:
+	bitmap_free(rxq_bitmap);
 err_unlock:
 	netdev_unlock(netdev);
 err_unlock_sock:
-- 
2.50.1


