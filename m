Return-Path: <netdev+bounces-116106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300159491C3
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CF42834E6
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCAE1C4622;
	Tue,  6 Aug 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mC+mozQi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C51D47BA
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951601; cv=fail; b=SM3cIWssY5FIrl1Ov9xzPb++nFGr7COK3SIr0njTdygvvjux7iurT77pHxf4OthTLW6AR9r7BNDDZi/ckWVTsrzpfiuK9c8LrsX149TgthWtK+qoGI0ZdiJboCUrGyXyRwPzU7NKkg5vufbEYNL9/mTtmASFhLT0F3DIPFopbyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951601; c=relaxed/simple;
	bh=3JvIEnEjs5cAcZKw4zLYA+BWxnwuIJd/JS3lpjBFBew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seOBVrpOdtwKRF+qs6nwDvA+9yXaD7LEP8j8RMMw9peUGCoprHs4C47D/JZAKB7/5fFi/7jhYyXI3n71Oe05vsJpbeuQqtnmnrNu8RK5gssgew9vS+3KwqW6sEGKbgxF/SyjY9HExfocUERyRr6vSw/uZz3ItxPYVxnq0oPbG08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mC+mozQi; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgIWJ1fSmGBKU6fBt/QxLJLjsCllNUHAvE0oVccdG7xyFU437C73p+ePpLNPpH0IYktKI5s6Sj1VieegKIQTg6hMkwDIpcirZYApdev6NqGsZnGkGg+Efv1WY3z6PhD6PbfUUrrXsTM9bWR7QJbEGlfXqHa4mNmxv6e62hPlH4LQ9l87Erck0QBUD/SdPAFfb6QnE0XT5psTWcqgymEVV7CZUiJHV41T73Gz62bB6NlG6JlXnFMwCP1ISsYuYCKZV3ihUA6NGzcZkBPsYnGaXZ8KNgEqkG5p3kesPmItKLpRerlD8wq9rmAU7fA5zM2/S7nzzCyJ2jatu6bxa12XFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVWxM5t3OzYm1Y5nWo/HsbfatV6H131EU/oaxY8stFo=;
 b=ySETwBLiBBkKASclwzg/DFTciviasFMpCKFiI9QAvyvZf560742CjRLgJyiBXrfmgeYBhrC1y5xyHEWtjOrN2zw2AKPuPWsABva8mr3yBc6qvjhxOUxhKECUVG7an2PT7S9H81dmd78232fL3dxu0/V6ePDJbVyKa8Aq4JOrAuKEcue7kXQxX5XCiQckhii6OiJN9W813nG+auhpSnV8ggq5nQ78Hm0xqelrI65IxtKrUDIKGUqbEX+EdbVrXUWgGTxeCf+v1ULWk2r5nVALWQVKM7o+doR+Q46C8y7qT5ls1GzUWMuWZrVSnu6lCACtjZVvfK9d+JJAtrDweaNbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVWxM5t3OzYm1Y5nWo/HsbfatV6H131EU/oaxY8stFo=;
 b=mC+mozQiB7V7/xdxxzRleJIITqx4QhVlEYgSPWOObfhsRDVf4Zon7Uuh64oUtNUf/BqzCxemP/t82OzZM5oQ1xcarX1HBAaiJZDaxetaN+voaFhyYdarR32dnV7/BIRDE5LgsdcqDkBMXstrGJEp8fVAFPANisw2z3aBhS4oqeIqy/Bow4H2M07ZwNg0KABq586GCo/+CE88CVHdWhOihy0aBqNGJLcFvQQpupTwtkz1eQMVr865O2+urHzlcPsoNi0ZnCCz1+pRBHiXlNum/JoPnMCphO2SmrNaRfshHAKFa2oqfKCq01f8+emvxdgX/Gcw+pTA8J4U015/JkJfoA==
Received: from PH7P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::11)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Tue, 6 Aug
 2024 13:39:50 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::5f) by PH7P223CA0015.outlook.office365.com
 (2603:10b6:510:338::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Tue, 6 Aug 2024 13:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 13:39:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 06:00:05 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 06:00:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 06:00:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 09/11] net/mlx5e: Use extack in get module eeprom by page callback
Date: Tue, 6 Aug 2024 15:58:02 +0300
Message-ID: <20240806125804.2048753-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240806125804.2048753-1-tariqt@nvidia.com>
References: <20240806125804.2048753-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1824b9-edb7-4d36-09e3-08dcb61d3c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ZBnlZQD51+qhILo+41GIYhk29qvu8Gj53iANnOS2dFOMimhyFKdheXFWb74?=
 =?us-ascii?Q?zoxJ5DZ7oOeAd0pTCtPaIj9FCc+pZ13qRCugDHlu/tdfz2S/UaRxIX0g29d2?=
 =?us-ascii?Q?EEsaHi/rYWQFxMwiQVuOY1MuNbeAysTvyRLjFOzL7eUEElCHHP7SmeE3IQFY?=
 =?us-ascii?Q?i6/zcYWQD0TQx89AYOOVXQCrBXOu8iJs5dZ3jjd95yX7QwmiRnXDzMKPgTRK?=
 =?us-ascii?Q?wsEJyFyqiJTBmU29uFitbrCZ5458AT0Viqqk8x8UcqGRtjeKiMRHL0npjcT/?=
 =?us-ascii?Q?mQVUNHvjOBT11sedS9pJ9vYTkfFbbcJO9RbHvobsRIFtMO0D6zCeFCb5ZEaQ?=
 =?us-ascii?Q?TpJkpUib+d4MiismVqltNoM4s13kOkGv4Ra0JIE9QvN3AV580+6raeBNo0/0?=
 =?us-ascii?Q?94RgVt9RmETjU9JyR8OXlb7PS504XKV00WbHAosuUinGEbV9OPFjS0cSTjie?=
 =?us-ascii?Q?K8OzfPhi5rWypjPxrkjIhC41UmTEYJJjk2Z8ZadST47ttNXzhfWph4hlUFty?=
 =?us-ascii?Q?y4/T2qFfR97GP/niAenKZMEqKaYj9b/AehLCncVmHCziNc/t81iIvDnJnc2N?=
 =?us-ascii?Q?6iWI6x/duy7RAigpYkccg836x/+R5RziHP3TzNqgZhz3ZGgqtqAaHZjcit51?=
 =?us-ascii?Q?KEzkoggbx9SVba54yLAqmPwbnXkerRj0maITdiRJLNg0O2+C6BclQAXRotQv?=
 =?us-ascii?Q?QqojPDAoT7UOY/7sQiUkmT6YmjNJJ83uhLRCzhVRRGFEu69kLCqlVio10G0j?=
 =?us-ascii?Q?Udw9+3Sm2RVnoaxeYFdRiMvnNjKPWyrFf2KW+Gyf0A3auJCSmtnT2IIu+RrH?=
 =?us-ascii?Q?Lur/hnNoT8fuQ2E7tArjVu8r7gI1oyACmwn4XH0Dyk8THP+tljkU9D5X5YHl?=
 =?us-ascii?Q?j0kiQzdu0G5XRylvbRWeicY3jGU3YPpHOpx+arj7+bpZZCAxlmLqssamroY2?=
 =?us-ascii?Q?dmPc4WwxWvq5STygtwyJMLFDgm+jOxkOFtaAah1w9KZeEz5Fi+oQBU5LM9rJ?=
 =?us-ascii?Q?P5/FphzKdC1CqPi5YkCgyEuG6cXX+4roa8sc29rL9ItTqkba0mipBRHrZDPF?=
 =?us-ascii?Q?EkSLTXUtGQW0kr+qkHiv6dQ8yIkx76EG/ODw4U3z9pWIRD56PnfdxM/3HxeS?=
 =?us-ascii?Q?UZLW1sgDmlei4kn+aVAy9HKFEQXcHCPvnZVHgZCfTO5NAW8NqLcgVoUDc6xH?=
 =?us-ascii?Q?A+nZbD5pRImBe5NsTqhUibb6kYUUsx1nr3BqR2QPGkrSEuG2TFx3jceGRW1j?=
 =?us-ascii?Q?vh1FDzB+rUrvj2+g+dXSHX5SNlmORvWdzTRR+n1ZAhZuZjQf+eF/XuoppbCl?=
 =?us-ascii?Q?o+P9VS9p9RV54slHOm3nZDoDn3Ne9a5EgHKSWWyWO/Gu5dasuuo5gkmZaOuI?=
 =?us-ascii?Q?/fR4KmZ90v1Psf/G5ougCSDI6VQnlJtOGe+xpZ0HmcWBh/Lac4F4KXtdNXCz?=
 =?us-ascii?Q?PG8UPYbTX3dg5p82TjvKFRuBDwwJbO6l?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:39:46.0793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1824b9-edb7-4d36-09e3-08dcb61d3c4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067

From: Gal Pressman <gal@nvidia.com>

In case of errors in get module eeprom by page, reflect it through
extack instead of a dmesg print.
While at it, make the messages more human friendly.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 455d6ef15d07..71c02e77d037 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2024,8 +2024,10 @@ static int mlx5e_get_module_eeprom_by_page(struct net_device *netdev,
 		if (size_read == -EINVAL)
 			return -EINVAL;
 		if (size_read < 0) {
-			netdev_err(priv->netdev, "%s: mlx5_query_module_eeprom_by_page failed:0x%x\n",
-				   __func__, size_read);
+			NL_SET_ERR_MSG_FMT_MOD(
+				extack,
+				"Query module eeprom by page failed, read %u bytes, err %d\n",
+				i, size_read);
 			return i;
 		}
 
-- 
2.44.0


