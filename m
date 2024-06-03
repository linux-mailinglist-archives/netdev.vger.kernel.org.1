Return-Path: <netdev+bounces-100350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F2F8D8B46
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7A21F236D7
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F5113B596;
	Mon,  3 Jun 2024 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fWil/NNg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C7813B58C
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448775; cv=fail; b=EK+H3hHtOm4DkR21qJbARv+gpEUVmAg4euO4WTrYWcnCartpSfpI9INBkiKx5Jd4OC6JVfz3E5QH7dhr2W3Uk/gkxx6OA+k+ZNUCcjYLgSx6vxFMnYIk0DC5JNHnkmGlKH7e/eTMlB1VUzrwzmLToIfxDhdtbJYUCONwvxs/5Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448775; c=relaxed/simple;
	bh=Kw2qqrdXzsXargIlFnI2YJamvoACcVgRzuzZ00C0yNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHt0qJPKJ/KJpKoncPHQf7GDnBQ6tqOYmIP5P5xbgNa26942GOnl3Wj3GftXMoVRU9bWEKzaJ9L0jBh4WHWI0CWwGv5wRErmgO3gQiq0HyLls/wfWTFHH9p61vhBqA8yNC2MxsHsdTZKAk1ijZV3vT+EknV/+CRF8ffqhFhRtT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fWil/NNg; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjMSKOTtHF+tchoyTuyA3mm7s5QpjFbMN6SQ1BPl+RuI05R7dDHw97sxsRFjUAW1Hg2fK6lx+6DJO7vJy49y3J9SSNL0YdJDJqauX/v/Za2aM6kJnVQpZhnJbjX6+idgJ0bRafWA6gCoKz4zt0bLzjAYHzQVSbpHWoA+q5l1ELs1O5X4hsaoKSjUU10ZfnXeyFNDZ0TRr2EmdzG2Ugu/qAFzf7fytI3k5cf7Afevkjtd8R/d4XwtueWv/YqyPTWHbLN2Ob+BwNz5ZzxFjZHNrGDajqld27/SrlOiMSJaiDWq4tXxOfVHU6yEToTPocKhVgKDHMGtAc1CTugGbHRdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wrXuEJWt4aW4ahbSUl6o09kWbZfUYg9qTQ54x/NqmI=;
 b=OHM4TaGvWD6IxjdYdPKvZjyGQOp8uoEdDJ55ojxbeskDPPbX2hS7dlE+VDisgSBja2mMp5EL3HE08EgutvKJzY7xYUqThTwz5Nj71bALLcaMUNUP3e5n/EI4gSvjipkxAbVF6y12sjQT1zc1pu7o/X4wO3UV3rWWiEXOXC3GjS/lnQkQUzNKnwOzP65SWK+KB4rFX4LQ6ro67bWivdQ88SO7zU+RudkfKx93ViJ3VzgfHevvOwW0+6++013LJ3fSrZWqGUhnT1SK1y50zRHXyp0Db2xoTJbvOQJ3XAAS95wuTLojpLeglV7quaWlFSlFhpw9D89Lmqqw6YwOGjcGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wrXuEJWt4aW4ahbSUl6o09kWbZfUYg9qTQ54x/NqmI=;
 b=fWil/NNg1ob9jPkK6y0s2eKOFbyZM3V3VVFgm0xLACiKqu1mJTisGHfSro4/FnTqzo5CnhcUh0i9qL/1UmTo1uL2c8qJaUk7BDjYv419kXC8WUxydGZQhRbGpWR5ErDHrNLT/ZmNnVhVJ2sSZlZTj++BD7r7QURYbXQk06RHpWwGpfJ4MQkQaMvM/AKL0Ad7nBT53zY4pEyW2gUqZKPxJAFoefiJdYB08352UkSuNScRqbohA+hE8q1IJGlLXIa9Jv6ZvjyReqgZo2QjJwWEbcTU7DZD+nSnO/XZmNk6NY2P3QMl72yVs5CUhDORtVZX+VN+Ki+zYwjV4qUEu6K9pg==
Received: from BL0PR02CA0050.namprd02.prod.outlook.com (2603:10b6:207:3d::27)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 21:06:05 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:207:3d:cafe::d9) by BL0PR02CA0050.outlook.office365.com
 (2603:10b6:207:3d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:06:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:05:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:05:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:05:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 1/2] net/mlx5: Stop waiting for PCI if pci channel is offline
Date: Tue, 4 Jun 2024 00:04:42 +0300
Message-ID: <20240603210443.980518-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240603210443.980518-1-tariqt@nvidia.com>
References: <20240603210443.980518-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e39cd6-974d-4e4f-62ba-08dc8410fb47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FPWicJmmdmPR/04+fGIhRjWcX1NXgXaZtUMPhfdFgkTbYAVZSOmDWOM1bbjN?=
 =?us-ascii?Q?6G3La8tFnFE3vkCjat7uGW0ewgRIRjOIDdjVbw8Tl9l/N3lyN374waR9O7Az?=
 =?us-ascii?Q?qFplkiu47rzqNjCbLkYU4AyhXuOYVIqPRB206Wwk++9ZZe9F0yz7ZX6iPNEj?=
 =?us-ascii?Q?nSNPgTvXRSVcgtVSvjAte6aq+zvmpWlz0QJbkGqQrRmrCNR+mf5bXzhbcEyi?=
 =?us-ascii?Q?OzwcwGNgLpC0OMgBCItQlEFD3q6epCmGcTBiBuGIqNt+QL9CdsuoQA3LTOva?=
 =?us-ascii?Q?hPmvdFmMtsxbd2HOQKGkSi614mEva4OkMWLUCmTysHquwZtfh6H3w+PQjWmO?=
 =?us-ascii?Q?hrdEzSxKDbkiTfrAFuf3TqL7w9pBDWkXBknjlXm102phZmNqJJAPAorbTVwu?=
 =?us-ascii?Q?Huz4zRhUnTzGbi054Js0sVjyKT6aSHFmDo2bIFEFYnN3iYgGNLte9AKFbS+n?=
 =?us-ascii?Q?guKr6h8zzgm88o00V4vxPtCa5+hZjsUR5tDc2oPI9vdby6R6A47zHtwLYqvB?=
 =?us-ascii?Q?rDhJXeW5bTBy9Dz/aAB9et009zFPqx9l9NzD/P/3TGRg6oeG3NH+v/SWipq7?=
 =?us-ascii?Q?QY+IhHlBBSycAFE4+wWVoOzyWlPcLyEmvpdb2rsuw9vAico0cQIZGQvAmHGz?=
 =?us-ascii?Q?uUf4Pv4/D+l5tOItXkDNVo0+xt1+F25G5/Z2Yt9cpL83zk8dGHc5PScdyrqR?=
 =?us-ascii?Q?yqQZWSgdBUqBWglL3zRIbPsW0Fv2YJbYt/y01w7bGcJAeQ3SC1ZJ8gRG0Ivp?=
 =?us-ascii?Q?Y2zAUXBpYcbo2ZZFSGWsiVQeCpwAZSkAX9iaMf4OokBVYpaFR/wwmEKyfWwP?=
 =?us-ascii?Q?wmgspuVQWndX4sFSfVanynGo0ewJmpXWzGM1EqWQXSIlQ0iKzs4Nt/X0TmcD?=
 =?us-ascii?Q?QKHjYi+WkJq/Rm5deGQDSwvj4rG9i7BblKklehVpYicKeZDkpNFQPH5/AiPM?=
 =?us-ascii?Q?WfjIav4cJYsJ83grESbx0EusBFAnyt0z6TqkAIxtz6HMwK9B+S0XCm6mUWZ3?=
 =?us-ascii?Q?nzGchpO7m7iLK7cATdgwi/ijmumB+FMZa8Nyi8C+rCCilH5Qoh0/4/vBC+R6?=
 =?us-ascii?Q?UT2Zveki6Z9/55f5K6EeAHq30eH3hmsWhBYpHz8RRfdTlTR3w2OWH+L5f+7I?=
 =?us-ascii?Q?8GoyoY2uVvhwF8ixJyMHvRJPe1T4p/bVVGRe5MYt9KooLog922oQapVEsW5U?=
 =?us-ascii?Q?JwbDfVpMJCuMnNArMx39XqQYO0Wpf/1ikm52ICwZ4K3blL60fzhi1Ygw0P5W?=
 =?us-ascii?Q?8wk8+x0GovgbLjAUGqp7ezmwsTfJRjadNJNWPvuhSYToXncoMhWBRmR9PsYi?=
 =?us-ascii?Q?0c6wDAwF0dJxZtuzhGU6Va/FRXrTLZxQgTbUTn+5C6gX2ZadKpIjd9WyKKoD?=
 =?us-ascii?Q?kdMQXbU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:06:04.7995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e39cd6-974d-4e4f-62ba-08dc8410fb47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541

From: Moshe Shemesh <moshe@nvidia.com>

In case pci channel becomes offline the driver should not wait for PCI
reads during health dump and recovery flow. The driver has timeout for
each of these loops trying to read PCI, so it would fail anyway.
However, in case of recovery waiting till timeout may cause the pci
error_detected() callback fail to meet pci_dpc_recovered() wait timeout.

Fixes: b3bd076f7501 ("net/mlx5: Report devlink health on FW fatal issues")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c          | 4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/health.c      | 8 ++++++++
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 2d95a9b7b44e..b61b7d966114 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -373,6 +373,10 @@ int mlx5_cmd_fast_teardown_hca(struct mlx5_core_dev *dev)
 	do {
 		if (mlx5_get_nic_state(dev) == MLX5_INITIAL_SEG_NIC_INTERFACE_DISABLED)
 			break;
+		if (pci_channel_offline(dev->pdev)) {
+			mlx5_core_err(dev, "PCI channel offline, stop waiting for NIC IFC\n");
+			return -EACCES;
+		}
 
 		cond_resched();
 	} while (!time_after(jiffies, end));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index ad38e31822df..a6329ca2d9bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -248,6 +248,10 @@ void mlx5_error_sw_reset(struct mlx5_core_dev *dev)
 	do {
 		if (mlx5_get_nic_state(dev) == MLX5_INITIAL_SEG_NIC_INTERFACE_DISABLED)
 			break;
+		if (pci_channel_offline(dev->pdev)) {
+			mlx5_core_err(dev, "PCI channel offline, stop waiting for NIC IFC\n");
+			goto unlock;
+		}
 
 		msleep(20);
 	} while (!time_after(jiffies, end));
@@ -317,6 +321,10 @@ int mlx5_health_wait_pci_up(struct mlx5_core_dev *dev)
 			mlx5_core_warn(dev, "device is being removed, stop waiting for PCI\n");
 			return -ENODEV;
 		}
+		if (pci_channel_offline(dev->pdev)) {
+			mlx5_core_err(dev, "PCI channel offline, stop waiting for PCI\n");
+			return -EACCES;
+		}
 		msleep(100);
 	}
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
index 6b774e0c2766..d0b595ba6110 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
@@ -74,6 +74,10 @@ int mlx5_vsc_gw_lock(struct mlx5_core_dev *dev)
 			ret = -EBUSY;
 			goto pci_unlock;
 		}
+		if (pci_channel_offline(dev->pdev)) {
+			ret = -EACCES;
+			goto pci_unlock;
+		}
 
 		/* Check if semaphore is already locked */
 		ret = vsc_read(dev, VSC_SEMAPHORE_OFFSET, &lock_val);
-- 
2.31.1


