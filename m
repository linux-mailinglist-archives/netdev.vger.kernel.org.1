Return-Path: <netdev+bounces-203474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26260AF5FF9
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EE31C43293
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9371309A58;
	Wed,  2 Jul 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YENirV6s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D977309A4F;
	Wed,  2 Jul 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477236; cv=fail; b=PdnYU7R8kgJz2GRG4UPDiZ/vebkB1zc06qs2H7+pRWcUUSs+cBpn6LcOEd18oV+VMQtrmVru0uuBrYxIHfC5QhmExUGXX8c/HkPXxl/TrIaV6Io96rP4FozzNiaucVLoZP9D+zOMc974FSERcLGlQnfOa1b+ra5qTN9XjHwBWCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477236; c=relaxed/simple;
	bh=fWthAkWOT4Yvxb0YBh10yT7+xuUYm1/50bfjeQzmssQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a963dpmmAmKaSYP80eEr/mIlyLSMxTJzPfR1Q7z7GkW6kexE6z9gYjwZj+qRv/McmjSd5wJr/GE/p1pAjqNaYkXRhTSumpOWgN/2kyNvMNcef+XIGUAl1cHRPSA2UB2hX3Oh1Qqfz8BTkxNaZlVJYXBaRTVgyOVY7hLxqA4E1ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YENirV6s; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/d2h0Z84xg8DZkDGMN0Y6JKCcK1lNWmdvPJoZYmAv1G+/McbsFO9F9Ng6L+AHDyjvciGe8utK46EnzZpTx5IyGhORJHDFCA4V7VlXozuqDxYqRPQ9i3W6iJM4Rn8FpUIlu9+YA8GVMV86E2eXkPTStzZzV5tY4XStD3LsZcUo1TKN3vV9SrpM1w10tpKb/4OssSS2qCLibCyzSu6d86ptYjudUg6GtFQHmVM4GK0PR6AC1njwWLOEwSSSzlgwmibUBLL+C1zt2AHO8lFFJdrz7ql8tOW+DSlp4iRQyIhcqEiOdvPGKUhH2ShKsa8gff1EqCzSs/Cw6BtLEIZI7GhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8D3oCB6bpJnwh9U3PEPWYvdHal1dC1XydPNIVKlNb0=;
 b=iQZsZ/eIMCEY9OPaoYX0plt6fgpaQtpcq4OPWNmuU3nHSYy4hKBNMNvwRU6tjG8xquZZH0ALDGhIxYNYYoUBDTOpSjKd/cC24KKXRf2bEa9B1coW0GUxig9ViQtUtXELTGsdPOyoaj3HMlOX0j8i6fBnpalXfPU5mNjh8ZLfpneiGX4an4EgU5OvYzP0CkCytetLpeWj9YYYBE2Nuq9xaIzlmiOibjt7u63ah+h9UOjR4UJ1nmIy/j+LMSbL9bn83yOtc5f3ZACdnd+y/exG4UZw5fHCDz7rrktF9Hhz5dwW2fvCMwcEW7ZEqdkulWXuIMi+fJGWAjIgz9aAR4p4AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8D3oCB6bpJnwh9U3PEPWYvdHal1dC1XydPNIVKlNb0=;
 b=YENirV6sGswCWhfp7NOokPS4dJHAYUkdX/98KQTbDMIz0mBz0HizX5cDrnkYxs1mt9tcsaDwlHG1vq+0hkDiIQ1J5l1A6/4Fk8lIE8Prxf0dzTXI8v0iHtGJDSiKNldLtG4v4ptxhA6U3OKpJCu3QpOV1sPelKhJfOUoVVKGHXQXoApfoDXvVeNgVNwOeFnxJhN9A5nEglyKaLZYMcsaXRN9gJBcRKcFOjrfV4vdNGYU/j8WGO9gGpDHmC9Ekx+V5r5xMtudw9Z6SLNRNrvgTrb3OdNL9lN0F5mIrhpHKzHC0wVEVGY5Ok5etRID9oBM/QHZ1SgVpmprOoN508w0eg==
Received: from MW4PR02CA0016.namprd02.prod.outlook.com (2603:10b6:303:16d::22)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 2 Jul
 2025 17:27:13 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::31) by MW4PR02CA0016.outlook.office365.com
 (2603:10b6:303:16d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Wed,
 2 Jul 2025 17:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Wed, 2 Jul 2025 17:27:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Jul 2025
 10:26:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 2 Jul
 2025 10:26:56 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 2 Jul
 2025 10:26:53 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	<tariqt@nvidia.com>, <cratiu@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC net-next 3/4] net: devmem: Use the new netdev_get_dma_dev() API
Date: Wed, 2 Jul 2025 20:24:25 +0300
Message-ID: <20250702172433.1738947-4-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702172433.1738947-1-dtatulea@nvidia.com>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 3472547e-0517-4209-0f03-08ddb98daeb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sm/Mbbl4vdT8S0wJuGc4SQgO9YwpHfqSPe5twNrG7yDJzmWnFLV9LVy2UH01?=
 =?us-ascii?Q?lwgOjznLIxKFgTgVGjYT8Ebh9h7ZSCCfqoldi6rdywJmZUbFu5PIV3lJXW7S?=
 =?us-ascii?Q?SK+7RN05VXDlNGPcgYsNn99uQOoGMe7bvncv+Eto+N0RohDhXJGJu8CmvOd5?=
 =?us-ascii?Q?WJdUkFB/TFh6a8EZSeP18PXXkrGYdaZ3EtgSuo8jAEviLCVoTtsMId8LYken?=
 =?us-ascii?Q?c9PqkcimGtFT1pWN36Ny0xAgNLuzKVbCQItVR3niFz5wDtie83m/jxaoEttc?=
 =?us-ascii?Q?vQpdwozopA47PYj7GdU2s7KmTsU4ebHfu4WZnTCEQlT4oJpgH8LSVNdjOnA2?=
 =?us-ascii?Q?FpQSeU5mAb1v6PbrrF9fLmImQ2KevaeY54I+HA0Bsi0VWNsLjNMYzdWvv+C0?=
 =?us-ascii?Q?zZ2jGnvhYW9sTS9kzpiljMO0InwBQ7IfV9+HiKeFBCGRqMM82xd2wd+ukhvs?=
 =?us-ascii?Q?EdOUSL+ieAXweahpUuLuPRLn5d2IJeoS+CQdBdSwoYtmAzoq7ZVtQEMWQx5B?=
 =?us-ascii?Q?mDPPq7NyBztvy543gnyGaZAWPVQgczWCPrvP1/qsmA5nenWA7y1jUhDEyGSL?=
 =?us-ascii?Q?zJuX9CmnqPFfxPMjlmf+A+V/7PTy6au8y9pOkKB5oIkUDeWcruPa02IgNU0k?=
 =?us-ascii?Q?gKbsFJ0DMrBz7kM59ORxGgHHLXMxvddHHnsq+t5Oj0Fi3WI0SuxMAjTe3mlv?=
 =?us-ascii?Q?gxmJAe4Q6WYjmgIb0gZumDwGgXxfaxobhiTGqXnGJ+NClPxaYEM4H8My5DRy?=
 =?us-ascii?Q?rlK/+5yZ0BxJuuu6jgmRM6fVl77Epa/U69hix1bEJCeRo/EFv6VK+s6XgeNF?=
 =?us-ascii?Q?qwXTL3xAOWnEaIxi+AZa45pWyc1BchgZggR76cQqbNrJwk7tiPJhzudU+zk6?=
 =?us-ascii?Q?5gb/+cevQHOZw764iBYL4HKsCH2GqrocbwyhfpxhBA+ywHBRAkYUf0Q1wgvM?=
 =?us-ascii?Q?fA6Y3Pt3Pif3esaFyCefRUsvDuOWjQLwdLnYrZRlRH0g1bjlJtAkwgE3H2Hc?=
 =?us-ascii?Q?8xInIiXhF03OEmS/lI6Da6gmTDxyQiMtdhDuvDFE05GDjDpuaoUiDe+v8t2m?=
 =?us-ascii?Q?/+nKS7cPIxO+W2ecadwlZvKmD2dmNKI+nJYV/64SNdlyFCJQ/JLboCJM8NEI?=
 =?us-ascii?Q?8NU7r7VZ81dBtWHYDjiH7rAKecmuFbMPkpIgO4HbuNlSMhOk79zxjZJxqIPY?=
 =?us-ascii?Q?8KhwFVMe6/la1/XYfaI+cZBAr6Qr2vqZwAlJnrkriK5yGovsZ23tjjGu0tQT?=
 =?us-ascii?Q?NtZzvvo8n5UvJjP8vuCW0Bxshza6QNzJNgcv/TWgKtqJ45PeDyb+JilcpI2b?=
 =?us-ascii?Q?43T1MHU6dVGjA3E3nthyMGNdAYtG6xBz6lVOqfChs1hf8mtnyUnzgY7fXunV?=
 =?us-ascii?Q?E/LvSTOKGyAVQOjYNO33iXqcdW3r0SkAOFecqlYXLSUBeJFmzGRWDw/WO3m8?=
 =?us-ascii?Q?RtFetxjRdCQBw94vABy/xp3rvaTTuMRZ4BHgoggt8yMeyqRbzF+LInIc/BEs?=
 =?us-ascii?Q?5ColKAvvCVAHo8zAeFSYtH2blUftrYx6Qnxd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:27:12.7295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3472547e-0517-4209-0f03-08ddb98daeb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366

Using the new DMA dev helper API, there will be an error on
buffer binding if the device does not support DMA.

Previously this went through and was returning success event if the
mappings were not done. Only a warning was printed.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 net/core/devmem.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index b3a62ca0df65..c6354b47257f 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -183,6 +183,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 {
 	struct net_devmem_dmabuf_binding *binding;
 	static u32 id_alloc_next;
+	struct device *dma_dev;
 	struct scatterlist *sg;
 	struct dma_buf *dmabuf;
 	unsigned int sg_idx, i;
@@ -193,6 +194,13 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	if (IS_ERR(dmabuf))
 		return ERR_CAST(dmabuf);
 
+	dma_dev = netdev_get_dma_dev(dev);
+	if (!dma_dev) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(extack, "Parent device can't do dma");
+		goto err_put_dmabuf;
+	}
+
 	binding = kzalloc_node(sizeof(*binding), GFP_KERNEL,
 			       dev_to_node(&dev->dev));
 	if (!binding) {
@@ -209,7 +217,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 
 	binding->dmabuf = dmabuf;
 
-	binding->attachment = dma_buf_attach(binding->dmabuf, dev->dev.parent);
+	binding->attachment = dma_buf_attach(binding->dmabuf, dma_dev);
 	if (IS_ERR(binding->attachment)) {
 		err = PTR_ERR(binding->attachment);
 		NL_SET_ERR_MSG(extack, "Failed to bind dmabuf to device");
-- 
2.50.0


