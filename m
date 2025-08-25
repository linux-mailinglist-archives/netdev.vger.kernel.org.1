Return-Path: <netdev+bounces-216399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5530B3368F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 08:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780AA1737BF
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9DC287242;
	Mon, 25 Aug 2025 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YlV5n752"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B085284B37;
	Mon, 25 Aug 2025 06:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756103895; cv=fail; b=pEy6MvSHu7v+iMRSzsqjqFb91hTl6wtslH7nslk0C57M8ptpYC1E1AI8+FBKIQQdCzEgJc/LNH6gS5PeTpjjH2VxDgg8mMrvts+3g+H3Prc7772BRDkhRtlT+bMomoRd6HSQkWDbA6ujzSqtzwIpwGag1Q6Psg5wa4eBbUBcmQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756103895; c=relaxed/simple;
	bh=A4UzD/YYNDdfai4B+6c4VVam5boPDwNwB1DHS1Nbdqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/SpruHvAeYBclijG4hx8YlIvwUX7uBsTYhu2H1Iju4QdM6MllSYGPsl1z8PswpP23aNLlsbAvVUPswCEyk2nhDH3FwW2ftwIcJcMSnfnpuFVftbzGa2uXiPhw6c8bqVENKnVxknRiw75bEGDckV3GhqAX1CPKA/TG+kaRS7RnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YlV5n752; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqtUaFboVl68Pigh7bHDYb3QDzOmiUsACUGCRHdgdlCxwFeXN5mprY5LNDTYAmVtLr1nbf5rlza71Hg+1EgNIeBiTqs0OIZto2csintwZ2TJjKlF6OB7/6LYV+LyFxUq8djQAYQr1m82VDiXESiyXccEUfAqU9xcGHUS5rtIgXUYbQxJHc9WTGP2RlJS2SZJ2urj0ysqKjFHgim+pOZH2PnCvN+MQUnHASqIEW2jwB/qExozAB9Z0Ze1XcD/dRGcMym1h34SN7iWdXC2ibFAVf89t0wFlhVB4fmzgMJAi9fGGWIdDW3rPlXz1D55JVMH70NBz8NW2wBD4HajHlDTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUHXYvB2c6IQJcH4KAXG2p/nR2hXSvliigSz42y6AfU=;
 b=p0UoNZzAc1leDwLc5k3JwHA74t0xwi9uWKZ5Y7gtGv8DX1pGVpPP7DiklqfVf9glTGXlhKFH9ymOnahWUoXpGCqsgTQtjNnd6E191szi8HXtJS8BYUsJAwVM6/X18ITYMqcIKd22hRQfxKTB4kqGKh2kQ2ezLqzq9VV7pUmkz6YrjhMw+qf2fu01CQ9AgkZdzE37grQpkTGLjOa3/mAlvofd1VCqP0pS8ZtXY2Tk62gNNe/qaF3j7IJ/xXh4yvgBt6N8O7OgRhm4+uSGAFZbkmu4nFUQ20SjzzgihBODnNkFYGEA1sWFTiNcpQMjiTTy89NG/Uzlb/SLKkxYWG6u2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUHXYvB2c6IQJcH4KAXG2p/nR2hXSvliigSz42y6AfU=;
 b=YlV5n7522tMFhvrcVes7+E2wc/QWTgRQCXYEfDGaQGdkv2ubODIhcHaaW5DtFqWMybj/I2itol/w4UKglqo5c5p0ta+w/Dz1pOtBIDn+KZVhyxtbIh2OKR/fwZp/02TAz+LtwI8CtB28+c3n2Zvu7KWf1FdqR2H8QEtzKm2RwqEPfc6inCnEnUI/yLXr4oCgEAqldp2lLh8Pvzp7LZkYsplujJquuBEX0/EQ9b9dT8LnM8X+TFQ95MFfo/mPQeus5cmOxzkqxXFtSdlhPv2YcD+uM3bWzDgT58tblfgl/fkSYhQTohV2u6jfIIEf4A+dT0mRNoUaE9VnBt2Rt3p/+g==
Received: from SJ0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:a03:39e::16)
 by IA0PR12MB9010.namprd12.prod.outlook.com (2603:10b6:208:48e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 06:38:10 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::77) by SJ0PR03CA0281.outlook.office365.com
 (2603:10b6:a03:39e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 06:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 06:38:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 23:37:53 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 23:37:52 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 23:37:49 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 7/7] net: devmem: allow binding on rx queues with same DMA devices
Date: Mon, 25 Aug 2025 09:36:39 +0300
Message-ID: <20250825063655.583454-8-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825063655.583454-1-dtatulea@nvidia.com>
References: <20250825063655.583454-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|IA0PR12MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: 3484c45e-fb47-43aa-18f9-08dde3a1f53d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V3tjvKCZWhsa2ZuTuoEcxcgh3hMZUWJfdT42rKMtyAkhoX/3khn9nCHT9tEp?=
 =?us-ascii?Q?zni9wP4CzYYRjoAfZXWTVdxhCskzanMdgrCqZPKSQGvwtwt99YfWAxxMYPjW?=
 =?us-ascii?Q?YNvUEmG5EKDWqRX2bS9qL7plhr2eqm4YT4xWIHRuziShpW8IVQmhikCRcp53?=
 =?us-ascii?Q?nig/nYgnP5Csa4zftDeDGAUVXogUzqm1n9sZlTTlrki31fbCSxcej5P9tg9W?=
 =?us-ascii?Q?kwRuVDWu6i7JVaDmy70AsiqoZ2Qv0cA/asevzn5EIiVMyx5UgOAaBv8/HXus?=
 =?us-ascii?Q?660jjw4eLP96Dg4M/r+mYHcKnVmyqb9qeqiHkrY9fY8Cect+ff+m4MMZBCh+?=
 =?us-ascii?Q?r7tLzNM43chkgP5EveNICUffCNASXMnfVVPIOhE/sZGwj8DWX1bv/hgryyjK?=
 =?us-ascii?Q?1p6HQ5EeVLNtd06O+9504jHFQlI/TT69J7iVHCfXj62ibi1hvTdjwpNH60o3?=
 =?us-ascii?Q?tl1eAx6J4+4G1olR332uO9IFmTmRWegJVpFPznM/VwhogX5c5P3yfJfGzkXB?=
 =?us-ascii?Q?PLXNRkP8qwANt+0hKLO0BJ5ER97UODdlnwwk43F7/Wf2mulFwxkinPiuGiQA?=
 =?us-ascii?Q?bkAkGMJfJoRBnfQTINen8ppw+2q/yIJK3oBwBtrrZ/KjfUsQPOjqUL8JWf8V?=
 =?us-ascii?Q?plKuQUE27Lhbd9JoFtzrgzw2yaayDXSi6sAQIxVHLpNsgGtnLxWI8cHFa2oM?=
 =?us-ascii?Q?Fjj8ftbF69MADwNsVPjY3rmhmrghCYDmIy/FCaFB3jHOeevQR3jwqWq0k7Hz?=
 =?us-ascii?Q?VQepkl9yxkcaEVXWRV6CboP/jbMXOqkkSPijoGrNXBDpyiY+t4nD/i99nGAy?=
 =?us-ascii?Q?RJrS64HDfrJFsKrpMmOnI+7w014SU0eau4NWP6IZxUZxZIjEDKkwi7XR/kyf?=
 =?us-ascii?Q?HWvYHWHcx9mOTypl5BGIez6LmA3dZKQYA9RloxaMLJ7K6afyX73iaNwXdb0u?=
 =?us-ascii?Q?MvHv41TG00oVImHmJxz7P8w/7ne9Kv3abeJLFCjEcJeVTYNJfPK9Ob3P1Ezl?=
 =?us-ascii?Q?UYG17X7/zpsnPdaVT5PJtCanVcMc7mOPmrTyExn1R4QJSe/JQvXu3shkRSIt?=
 =?us-ascii?Q?Ifj8tTdTMtdNQ1nW1IeepqGx5RG+oNDJEzerOE/vQhmi0e++4sNEot6ibYM0?=
 =?us-ascii?Q?2zIQaHjSQGtZpQQxyNLtG1Kklv+qNnGBJrUCaQ5GLeG25YlaTpWndWsJmj9+?=
 =?us-ascii?Q?tlO7ASprBOA2+7OV862CNDcSQqfU0TykRAssqfP+lMVszkXGZZ0FbHwrxFLf?=
 =?us-ascii?Q?2dpvqVAhkDtrJXjjKbrEQ/my777tKamr8Sf9a1rPjtAr3gozvhH9Jb2nQtcc?=
 =?us-ascii?Q?PkuVhemQgIl1J69fY9VeNKo6PnTSikF4iG5PEtEyqvx2hD0PPmx0HDmwpRFU?=
 =?us-ascii?Q?mn0N6fVM8FbnZrnw/dAX/HWU0VMiIjAq0uw6aC+T3luAoc9SFiTtYXOYeQqW?=
 =?us-ascii?Q?taCCXrWwvJ1Pz2XAM1OIWJHD1+mBQ/yQwxyTZlc4qnPk26tmYkQ9uPWYveB2?=
 =?us-ascii?Q?WyPLtyfRL2hTESOkPzWLCnPmHh0fnLPpjmdN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 06:38:09.8885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3484c45e-fb47-43aa-18f9-08dde3a1f53d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9010

Multi-PF netdevs have queues belonging to different PFs which also means
different DMA devices. This means that the binding on the DMA buffer can
be done to the incorrect device.

This change allows devmem binding to multiple queues only when the
queues have the same DMA device. Otherwise an error is returned.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 net/core/netdev-genl.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 75d600c24caf..81e55adf0ecb 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -906,6 +906,30 @@ static int netdev_nl_read_rxq_bitmap(struct genl_info *info,
 	return 0;
 }
 
+static struct device *
+netdev_nl_get_dma_dev(struct net_device *netdev, unsigned long *rxq_bitmap,
+		      struct netlink_ext_ack *extack)
+{
+	struct device *dma_dev = NULL;
+	u32 rxq_idx, prev_rxq_idx;
+
+	for_each_set_bit(rxq_idx, rxq_bitmap, netdev->real_num_rx_queues) {
+		struct device *rxq_dma_dev;
+
+		rxq_dma_dev = netdev_queue_get_dma_dev(netdev, rxq_idx);
+		if (dma_dev && rxq_dma_dev != dma_dev) {
+			NL_SET_ERR_MSG_FMT(extack, "DMA device mismatch between queue %u and %u (multi-PF device?)",
+					   rxq_idx, prev_rxq_idx);
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+
+		dma_dev = rxq_dma_dev;
+		prev_rxq_idx = rxq_idx;
+	}
+
+	return dma_dev;
+}
+
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net_devmem_dmabuf_binding *binding;
@@ -969,7 +993,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto err_rxq_bitmap;
 
-	dma_dev = netdev_queue_get_dma_dev(netdev, 0);
+	dma_dev = netdev_nl_get_dma_dev(netdev, rxq_bitmap, info->extack);
+	if (IS_ERR(dma_dev)) {
+		err = PTR_ERR(dma_dev);
+		goto err_rxq_bitmap;
+	}
+
 	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVICE,
 					 dmabuf_fd, priv, info->extack);
 	if (IS_ERR(binding)) {
-- 
2.50.1


