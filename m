Return-Path: <netdev+bounces-106483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F40CC916950
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57ABAB22C31
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3297015FA8A;
	Tue, 25 Jun 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YbSXUFtj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7B914F9E0
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323300; cv=fail; b=hm78CxKCFM7QyuHCnUw7tuBfPvLv2DwmKzjvCdXH12XiUhNkTRCsOVIomw5biToJTzytej4+rxLG3qyJxH6mCb6TL2Ps5xE1dyipcR1lVmybaO1jV4voQlBxZL/uDzYtv2ijwgkZmJVjIJG6TilGmSqEyWakTLDQTmjjZjAPxdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323300; c=relaxed/simple;
	bh=jpjwUNEFojeutiWcpNlsNUPXQVNP4mrXLpLzX2HlNKM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LLvjHOlcSpbxxHE9THoSE1YZKvT7JPhxkDgCzb0O0D7Vz9aoGpFPk52fgoUCwFZnsISACfWfxBZsU9twh1jcMwM0vDNDR36qZL9B2klE2/JiI0UWv8S7R1ZPFt56EVKurVTOe2GTQo540HEAlif8b6JRStplUJm59aN4qK3z3Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YbSXUFtj; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOneJctFeN7Ip547HFTVMPfCaFBhcy6um3q9kKvqv6GH1JkriyxfwH6+1QiAuijUz4tpV6Su0skHTMAongHVOou02S296YfqonnS8lBJPh1g78mwjLLBGdxdyvGyZZZMJkKitKaHdGp16c1gX3/BKO6EvxYlKrN15B921PoxpWbjjjESH8bXOy/eL03JeKFFOb8ITc7TfkjT6m8iLCtAnq7CTM0yiO8nUfTU8H5QmV9MRHNisbR3sVcMLsdDNhghWTYn5LU7dmvpmKe7nSxF9yem03v79NQMW/ciRW6CjUaXgeJSffscHR6iQpHFIShQ6A+jS7nWzfY+ESCUhXLRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgkRUeYxyHsD6sz+YGywobQu5WUrflJ0bTwm0NmG/FU=;
 b=Hdwf7eDEax6Lm5/9rUTNJAmM4aUrEdB/Ri179A2IK90W0HJpWRk0UmzsKjaBbOteElDs77Qq5jFiogBk0F8DAbHQ8S7EAKBlVnPniAg0s8Mjequ3ekUptlqrKwQytg3gFyURq0+qFHg/y17L/ARzbFgdEhufkTh2H2JLYVCGZOx98SyNdnRmZfVf8LYWKUHAAOHYZTxOqrHi2gKlgGC6kUFQlDo4hdTNWSOIM2TxWkX6E3wXogMdHHVFPf3VTXGLf2hSueq8+qqsd2Kkvx0BEB68JI5UNykGHfBaOAMSURI27Wndjrt5x6BRpV6zq+fnoMAKmAo6NPLdD6P0ewFFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgkRUeYxyHsD6sz+YGywobQu5WUrflJ0bTwm0NmG/FU=;
 b=YbSXUFtjtwz5zsr6nuLqwjK+53ANGRmdDtTh4tbPwy7PtO1uBm+Q6TJ//1eS+/TxJKVctmMNjiy3brcldx3PVjbR3+X8oWiu0x8kwsA3G6sIaZv9LqNlwWbrZH95VLu7rfoVM/l42QsKVmSmdUSDN08VRnPU6AERyAX0wF9FnPAE72qNG5eZdfo3EjA/vMl0RaJI8UQuNn4CrpZTOx4RJiynwrv4fxsrWdt7nSmtts3Ri/Gda3k5G+QjrCYiF9iTCSGe4YP3tVMH0k2nNURY2AQK21lLvSIcLVHukUomOwNmqgLacnakV80DROL07CMl9sfDsQlcD0euK9O+I+OD7A==
Received: from CH0PR03CA0315.namprd03.prod.outlook.com (2603:10b6:610:118::15)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 13:48:15 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::de) by CH0PR03CA0315.outlook.office365.com
 (2603:10b6:610:118::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 13:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 13:48:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 06:47:55 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 06:47:51 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/2] mlxsw: Reduce memory footprint of mlxsw driver
Date: Tue, 25 Jun 2024 15:47:33 +0200
Message-ID: <cover.1719321422.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: d325ea0a-174f-4538-9809-08dc951d75a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|82310400023|36860700010|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?13YgoaofatMxguJ6rYVv6DdU+guvpRGOgquBGZmJkXc0btCE0AphVG6WsYJ4?=
 =?us-ascii?Q?WsDPtHEqpP3r+Rh01h2eq3jiCMYiNZmt6kOkj7cqSNR4RpC0SjkPnpm+GrOV?=
 =?us-ascii?Q?BCbBA+CMkkhJBfqBdkghmazhUbkDKg2c4yRdfdlvD4xR8BGYY5j2+kaZ+/mz?=
 =?us-ascii?Q?X0rTRUZNn1Gnd7NPlMSJcY931QwZo5EdSNtYM/5bmaKdGDgjkMZEkHrlmgbh?=
 =?us-ascii?Q?t3hcjVHMm3SDJz4WNZmZk9Rd5vZFCWcF/UVjJIBIJPPm4ouucJW1QdoXO02D?=
 =?us-ascii?Q?13YwVBwRGIu5vn0SYFqo34qjxQGCZpvcbseaRvyTmnpRchuThWov2o11zStJ?=
 =?us-ascii?Q?Kyxg5Q8A6vumcJ2HtFq2Jdoaxt5RACcHsLQ9kmBEB58IIqXQW997OT6mvPzR?=
 =?us-ascii?Q?aGdUIQ178j/ictujYz66efDqdyOCLVcGmStO/Boq270TGKHZosjQP/MeIO3q?=
 =?us-ascii?Q?K28HlXLYc0cbUmUHrw3nAN/Sh9al/q6Nl/dZdif0puDAAvmlVjdqMGkvM5mI?=
 =?us-ascii?Q?uAzBcMCdraUvw4Pos+ttQYyuHK0vf5HGjRW792fR+Y0GGhZnwzaAsfB+zhpO?=
 =?us-ascii?Q?w2uRJcm4/9y1kkxNriGAOfpQVO6vls9ZnFUGDdxaQ6RQvkR2Df1DtuTDnGzH?=
 =?us-ascii?Q?slbhpEJSeP0ti4URUhTEwORZyYhZtVjquE15cltolIRUVIIRrrNQ0cBB5KGn?=
 =?us-ascii?Q?N2z3dL1R41fwhZD7SUtXcqrLT68XaA/U79NR0GooBMRq9j3UNsR+c3BWCoH3?=
 =?us-ascii?Q?1T2iCn0JmVcHFxFNt06l0lmkXy7uQ3JBPEp6Zkacc1vWQWpFI1HgCp2T9JsF?=
 =?us-ascii?Q?5JSnG7KqvQnMf9fo31hHGLlau1owcObmuBB+Roc17VYkRVYBmohGSxpG7wZK?=
 =?us-ascii?Q?mt1rPp9odMAAaZkBP0RFurRw0MffO5hl8XsBqdZzfPS71t6/+Mx7FeBcKGdf?=
 =?us-ascii?Q?4b18FJPxxSTgfTw+TXhHuKaPpOnQP+x1A8rVl/QaacgTCD27OmqXh5T7XDqq?=
 =?us-ascii?Q?Vq8y3CNcihCnngAqxm1gYfLRdc+ED+5nsAY/j8jHFi7H1mvO0eo6DX/FMK2f?=
 =?us-ascii?Q?aXtPwYhrzNNLwBoNHYv1/r3NfTQJ4PvDZ1cfu6YXcB05dX6Nb5lDKcQDLuq+?=
 =?us-ascii?Q?1Ts7HBnmnmaLmw4KVB1kTiDTxL0vgxdEaPTwN4503QMeFX3SmAQYAvD0PxDc?=
 =?us-ascii?Q?gB+bJyUvdG7E2A4tqcoasyfxY+dRy8rLhvPhM528EmOQRpeerJlHjNg8z/PM?=
 =?us-ascii?Q?G2X7vvvxt+ZVkselslZal16SeG8i7a5BxVabJtYfK9qm6bIj78dUuTHy99+a?=
 =?us-ascii?Q?mnFEMxf7xOulZceK5YdPhAcRQHbtVS5bgOqsXQfEi+BgR+10yhkxniZ5ddrg?=
 =?us-ascii?Q?Y1FjDhYGX0gIofp8B31OYmQjTEUEKxYtjbuQFPlDOr+bTnVOOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(82310400023)(36860700010)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 13:48:13.8451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d325ea0a-174f-4538-9809-08dc951d75a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188

Amit Cohen writes:

A previous patch-set used page pool to allocate buffers, to simplify the
change, we first used one continuous buffer, which was allocated with
order > 0. This set improves page pool usage to allocate the exact number
of pages which are required for packet.

This change requires using fragmented SKB, till now all the buffer was in
the linear part. Note that 'skb->truesize' is decreased for small packets.

This set significantly reduces memory consumption of mlxsw driver. The
footprint is reduced by 26%.

Patch set overview:
Patch #1 calculates number of scatter/gather entries and stores the value
Patch #2 converts the driver to use fragmented buffers

Amit Cohen (2):
  mlxsw: pci: Store number of scatter/gather entries for maximum packet
    size
  mlxsw: pci: Use fragmented buffers

 drivers/net/ethernet/mellanox/mlxsw/pci.c | 183 ++++++++++++++++++----
 1 file changed, 149 insertions(+), 34 deletions(-)

-- 
2.45.0


