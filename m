Return-Path: <netdev+bounces-118859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E1C95346B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D771F290D0
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594831A7056;
	Thu, 15 Aug 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mK0x5uD5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83A71A2C04
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731939; cv=fail; b=V0IfOjWgt6IxaJHgJubXWYI2Av+nhYgVdXjvZgMkdQFeeL8xJxer/xK/Kq5pY5ZNYPpRcsnrCrkjuvZzIPqm/rUkJpz+0l21n7AN++1vNf65TPilsYwmEpTffDZn+HFgYtno3vse4j98D27xEu6PuBy5+No9S1KZ0RscoT9T86g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731939; c=relaxed/simple;
	bh=gb+5BcTATOnIyV/b/es0OCYq0+/pxM305D4WnfJ3hW8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n8OrItcI8w+3OhU2zkmC8IunT0w4NBP8wWVxtWOH7vQ+RquVrZ9ELZb2Hp3lYKHvGz/rxnyMIPaBtNdPrNPTTLzdFVgjymn4JEhaXhHQpcwRSAZhrJGt8LfLS1JpSxe9NcEcl754NYa+mlmwOP+7Rz8jq89zDY+yFM88VSAjR20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mK0x5uD5; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erXRH3EIoScKJgzrZaoPMlMaYCFFsjYv8Ux8vZE1d0TE+CV7XhTvkbKusO5fTMPBvpoyxQalJ8uab/1wx8jfjlvvdE4vFQdrJtijJfwOIBNWkn20CutWkcxQShO61wqr9PDsCGjeLNZalNesS1fzWMauomecxZoIPPjg5D3jdhcnHSTuAP8g3A5Hxw8BaNUxICOSKwc/hFhUrQrVLmtJNCykdG0cVGiU0eqgRLhWdJ1/ngv49aPL3dgdW3BhaJcz/r7AuxfpvEcEx3j8NEM4lAeA9wZQDHXPieiVhqiDlyk1+ixJWLLlEmbSI90JDcyS/F4X/cW4z/HIBIDqzt8F5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5uQ0xP262AsYW7nNUwbDUtZswPbOO6NFEjX8yzirww=;
 b=qJt08aFqSYdnSGHc9PPJ3OOzZu64c+fX2R4gvZcaN8aFMLw2yUZMcigJ6La8Mn69NjnFGTLq4VAssEOHtAPiWisvgRmC3FRSWQyBc8CvM3tWoYjDihOJwq15pw4m8nsNZPouSUTNUp/BA17SZb9fqI+X0Y6rdKmUAvNFJsa6xpn4hMF79CHZOZcd2MDui2HZP8CpgTZg5QTMb1wQ7a4Z++2XQMAPwBe5xXb0nzrjVUYIywwfaMjE2pGv/LrLt4S/62gYrH9D+7FQfKW3cINVMpU3IdCAV9CSbHMK1E6xw/doux5pF+LtL5Ow+uFA1pLXjjGnYN0zyx6Npqk0iBWVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5uQ0xP262AsYW7nNUwbDUtZswPbOO6NFEjX8yzirww=;
 b=mK0x5uD53awfmueZBZlyi9m1h7mT9trb3euwLVlAy3qnGxgpcYHT1KhEdJ0eAVco2B/Rf7AF60IEEfJ1v/noP0VsS17Uic0mWP7lKHcpqxgIQE7ulY8BRTLxLnK4kgvRuSZU/ASiS9jaPZ/1iRXsK76hWpHkI65DBcvJX2VFYDxu+gMMmmdbx+GJccPVvnPwHLmwkIhHVgHqw+SiPJfOIUxGX/nU+IBAZxC+A6Aw6YBi3w76llEGvMRuUCuDw7s59LnP7epoAV+frhCAygFzcY2y3ggplECmLsgODmZh4BVOpfqHfl5jo8XCKQan7B25noZkapyvn9n1tynpYr/4+A==
Received: from SA0PR11CA0183.namprd11.prod.outlook.com (2603:10b6:806:1bc::8)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 14:25:34 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::28) by SA0PR11CA0183.outlook.office365.com
 (2603:10b6:806:1bc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 14:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 15 Aug 2024 14:25:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 07:25:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 Aug 2024 07:25:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 07:25:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next] docs: networking: Align documentation with behavior change
Date: Thu, 15 Aug 2024 17:23:43 +0300
Message-ID: <20240815142343.2254247-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf29a9f-8856-4225-28b0-08dcbd361fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUlUA7xK7oa1OJTY2t2Fb9p3r3Wp+S8TiP0gwVNhY17neDrBHqfh3/69LIX6?=
 =?us-ascii?Q?Ry0B2o/qBn9+mArrN2uGHVV3GRtOBLpONmwa8d7zLN+ImRsufYnjagS66E4L?=
 =?us-ascii?Q?dxo0e+fdL9ed6OfwJZWRg1dFfvYxsmjmxWUyJanKqQ7QVgpTbATzKIsF0c3W?=
 =?us-ascii?Q?LiLm6GRWFjh4svbegs+PQ2AqoCHrL538r1JUyHcg8vFnyeei4ynHrxDdDWnQ?=
 =?us-ascii?Q?mKtL62HGWhjf0ig2AaZupCOdTjjHaWlR68MVcGizJcqid8y91tJAxC6Hoc2y?=
 =?us-ascii?Q?RKBJubrX78OZjhAFs20io7r7OpU4O4dRq6aQ0cB0NjdQ3WED2ZXwPClSKR92?=
 =?us-ascii?Q?egFgJp7ItdokvEqjLkfbshH0dhBvkhKLHLAb8yuottsH9D44twiYIrQnfNNS?=
 =?us-ascii?Q?9wooMmYlMegxusfesbTrvrGJRxGLV2/8SIXxJizwi9KTeOrjz4RtnAm4HwWc?=
 =?us-ascii?Q?7f1EiY92wFKQtIfg7Uq2HCb3ppmzeMtuJVYa598xXEMz83jEIf71Bq0dMIrU?=
 =?us-ascii?Q?GLbT0wC93vGXiZysz/ytf+A1cxTu+X7GjQCqoTzBcy38a1C3nUQAP3MQ/qmF?=
 =?us-ascii?Q?qqdeUVKM7Fkv589/9c7yFvQo2WYSBSEssAXGoZEwYhT3L5zxmNEUx+8Wrm3N?=
 =?us-ascii?Q?cTfgTENooExU0gN6n6rgWs8ocaN6c4AHW4uxKyS5VBQ5nYwusfYpqYsvxWgM?=
 =?us-ascii?Q?AupLEVY4JbJm62aB6JwCKd90wo0Nf3QBJFdGeZH2UTL0DHuXubf1BQ5eXLnU?=
 =?us-ascii?Q?8ilOayQIA6C+HWUX6EOamzzFtLQDZuhVLf49T6DQv9zC+iPkCDhvZ0AlB4jG?=
 =?us-ascii?Q?/JgZtjCgigJ1wGVGJfEZD+KEGMxPfnx/AVdp4urIetkmGz83Jc6bVvy6MP7s?=
 =?us-ascii?Q?A/dPtrtCZ+54MJE/pfAc17koJLWNM5nRYyLBrb6l2xrcGHuqpht3okakJUL+?=
 =?us-ascii?Q?qkBnWjrAGVWhbzuUBi2APXhcsdXM6JsmBBSTk6JsOTKL9JUxlw7ltag2BAn/?=
 =?us-ascii?Q?exnE3OhZCw5ofnN2q5lo1626cE+McGm+nwfnTvchcZs9HWK3wNcvMKQI5/iK?=
 =?us-ascii?Q?q6qBeNMhvBH49r3eIqJjWD5LKmIl3ugiLrSK2BZ2etP2bClZzrsNiBgxiVtu?=
 =?us-ascii?Q?80KHwidyZFEdtRLCKYbTJakw9tKqwj6vYabObVI6E+hhTaunb8zrifSDwhfx?=
 =?us-ascii?Q?x6diHC/sXLmL2/nX7+ZSwEdmNhksgvZeiGSKqJNQeSFLmmPTZM3xMZOU1rNV?=
 =?us-ascii?Q?8VOy9caV9OzyJ+Zn9+lXPF5qLQjL9Wr3kfrLk4Nwn5sjXYNAsGEbVfdxBP/x?=
 =?us-ascii?Q?es7RxAFqZyREPoPJlmKkQKbSWSo+/EPGj5ZY1qtdJqKxwuibNl0nSASVL8XW?=
 =?us-ascii?Q?rDrBs8eDXqvFLkaF4wJKgta465JW9iQbFtV1kMPS9qjZZDhprynDAmGDW15D?=
 =?us-ascii?Q?NVHmFj2m8RMWsC9Y/nJ4RNZypoVD+8ke?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 14:25:33.8348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf29a9f-8856-4225-28b0-08dcbd361fd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485

Following commit 9f7e8fbb91f8 ("net/mlx5: offset comp irq index in name by one"),
which fixed the index in IRQ name to start once again from 0, we change
the documentation accordingly.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 Documentation/networking/multi-pf-netdev.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/multi-pf-netdev.rst b/Documentation/networking/multi-pf-netdev.rst
index 268819225866..2cd25d81aaa7 100644
--- a/Documentation/networking/multi-pf-netdev.rst
+++ b/Documentation/networking/multi-pf-netdev.rst
@@ -111,11 +111,11 @@ The relation between PF, irq, napi, and queue can be observed via netlink spec::
 Here you can clearly observe our channels distribution policy::
 
   $ ls /proc/irq/{36,39,40,41,42}/mlx5* -d -1
-  /proc/irq/36/mlx5_comp1@pci:0000:08:00.0
-  /proc/irq/39/mlx5_comp1@pci:0000:09:00.0
-  /proc/irq/40/mlx5_comp2@pci:0000:08:00.0
-  /proc/irq/41/mlx5_comp2@pci:0000:09:00.0
-  /proc/irq/42/mlx5_comp3@pci:0000:08:00.0
+  /proc/irq/36/mlx5_comp0@pci:0000:08:00.0
+  /proc/irq/39/mlx5_comp0@pci:0000:09:00.0
+  /proc/irq/40/mlx5_comp1@pci:0000:08:00.0
+  /proc/irq/41/mlx5_comp1@pci:0000:09:00.0
+  /proc/irq/42/mlx5_comp2@pci:0000:08:00.0
 
 Steering
 ========
-- 
2.44.0


