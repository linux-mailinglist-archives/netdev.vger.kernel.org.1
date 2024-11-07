Return-Path: <netdev+bounces-143001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD9F9C0DE3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF452841EF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E7C216A15;
	Thu,  7 Nov 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b34JoOYt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAD0215F6E
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004597; cv=fail; b=LKn5kDnIb2w+sipW7U6sSWGV/HH+xK1k4IU5KE7EvvNGxSEYFBksnK+pH1pKFGnqXEjcPJex8hfLIVENWvFbVfK+nu1OR/jekPiCuhZ3vwJcnxnq9KOkYeoaVj8yIvg6a24QdjS1mxO+hLjBPfie3M9HR/fNrNlL0H1rAFQ6+Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004597; c=relaxed/simple;
	bh=KjOI+WI0zaUTeoKKorOxhLgiVdm5ULFXEFqJ61+IYfM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SiQLB1+Vh7gXxRXiRlUSkvEh3IHynif4/m8F4XhoN6wKhDp/T4tcZzXwPxLJ3FFmHUwTiUf/4DkndVR+Dg/GLdtCSFFKFJr3XcABVtfivnwT0fspjc1zBASVOO2ULtlAU4FTyDwYFFG32IV23j/5WHQf7AeOCEgvSJIkOzYZEhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b34JoOYt; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zM7AlyqckF7mwGWvU72eCr0Weh1AyaP3b5C8veBvX0S45JMHdy5OVpM+FkUS2V+rafmRnYo03HLwnki/zNMGdLRAb1wNxOL+yURv0VquyFMuR5tcCbvCVC7HUMt2JYA5Z/1iivXfjgqYpFSECnMapGJ+ZFgHBHO/e7cMPaiiNu+f6/9B4Mj+7tkHruuGQCBp95heLNtSmQpJ5Mno4skfntChojqoeJuTMQpaO7NVPrd84OzT2B6c+h3ws1NA929f5yL3uokk91fFHYl5A5iCNXjkX7HvRo3X36dJL+7tRsJQOt5bbFL1ki9hX+F7QtZCuM01p4cc39twNptFd1ZEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGnbLxr5TH0PuANDOYYGbRJ29+29Evr/vPAFjfBCjLA=;
 b=APX8TjL8wje+/sFvBy5CVL43I0C416F3pQrtDbPXQBd9RNYUqG7KtMQUv92tjaMHm9QheA+FuGah+wf8/WwOfhhKrgOEfTWKUak9j0ZT5KKFyiej7982zQbl5l9l98OfmQ4xVj45xtnYPuFRDyfAGOsYNzJRb9IKFfGG8ZK+mC2HDg9+QfP+1Jfb6+inKQVWKs6uLA19bc4flsiPEOpLDtaJxYR7xXCVKYRSr2xzf63/g+ALcX1y3puolI8Mu5rDl6MNKaw8EyIrIASWchJi2YhcEXNfYXjrXKdPnmKXRq4cJFxzDLQJdSdfgu8ZwaDVBmS+jyqgQJEeHwDvFPzslA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGnbLxr5TH0PuANDOYYGbRJ29+29Evr/vPAFjfBCjLA=;
 b=b34JoOYt5T/P8zFFICuuU2UfuwF5qVh+S7813FY3hiPax6+hNzcMIxxesAm/q7tuhpnmLvPdJzUx7LHzsuBCFBgaKsfdhflwCgkwBLogzuxyIG2rfVhbdQGW+z7bJr5m+6cr0ZIJehZWLaAo+k2C7DHKxrmLANkzNziX7Sh/t2UV+eFKTg8r+PIcBLUlvLvUF95RPZuhnTG9/bTaHBm2LnSclRE341HX1v0e43CNWIUlHPd14yuOiNSD8OnQaY2xX5dEb4UahuE5DwKTP9Pgi44u5W7xG0HcsgqzF3mgCuf/MAZhD9xKTMmRCvpazVsqJx69SkAPbPrH7w+2gYkEOw==
Received: from SA1P222CA0129.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::9)
 by BL4PR12MB9506.namprd12.prod.outlook.com (2603:10b6:208:590::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 18:36:32 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::96) by SA1P222CA0129.outlook.office365.com
 (2603:10b6:806:3c2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 18:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 18:36:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 10:36:10 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 10:36:09 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 10:36:07 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 0/7] mlx5 misc fixes 2024-11-07
Date: Thu, 7 Nov 2024 20:35:20 +0200
Message-ID: <20241107183527.676877-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|BL4PR12MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: 7baba3c9-926d-4588-8f88-08dcff5b19af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlcxaXREUHRrNGsyYldQdTNiUDFZanVZdFo5NTRMOGExc05ZVHRUY3JBWmJ0?=
 =?utf-8?B?WVBOTDc3N1dTaGtVeWJBeUE4T1JLWXlTdWpobTdFeUZHU0RVaHpaS0FHc3Yr?=
 =?utf-8?B?bHdiU1Z3bFFSNlFqeGd5c3czY3l3QnBHZUgreUxKWVJTcTZybzhoOW9kTXBH?=
 =?utf-8?B?cVVkb0dUcnJmOW1vZU16TTExVWFqK3E0UlErdlNBWEtNdUZyVnk0SnZPMzI5?=
 =?utf-8?B?THVIL3RVK3dneTNGUW51VjVsQUpxQUJDWkdKVVl6anUza0daYWF5ZVRUSHEy?=
 =?utf-8?B?ODcvRXkrajFNcjRBR2RJNEh2cFc1aXRpMnYvbHpOb0hESmlpZ1J2bnNybU4v?=
 =?utf-8?B?MzMyQXgwZXVic1hBejVOUDFSUnhtVkJxV0EvNDVFSTVLYW5KVGt1NHBoRTBj?=
 =?utf-8?B?a2pjS2Zyc01QajRRV0tFL1I5eGJmS1BuZU1abFVoUUhQUmY1enlRVFJaQXdv?=
 =?utf-8?B?OWVJOTVLcWo3WkNqdExCL1hMNWV3c201a3kwYXpKVmtSdlVqd1JFOUpId3dm?=
 =?utf-8?B?bVd3Z0VNcVAvMVVIaVBza1FPbXcxanYvcVNidHo4emJUejNHVm55UE1UREZo?=
 =?utf-8?B?ZGEvR1UvNnF0ei9Od2x5dE5yckpBdVJWK04ydXlQUGhOTUQrMzh4ZUpMRVpV?=
 =?utf-8?B?aFBTcklFTlhuQnFSSDZOMUdDb1RSZ3o2OGUybE5JaEpKL1piVllUK2drbHEx?=
 =?utf-8?B?MTNCVzhQdndGd0tndmczd0FCeWdtZVlhcGNOR0FwbFBDM3R5Z1FwZklmM3U0?=
 =?utf-8?B?bmxPVitseUhaWXltNlhnQkxBRDM3TkNrZWJyTCtEb2pXbnRncFd6dWFpczBT?=
 =?utf-8?B?RlNtak1CQUU2clUyMERoblJ2b2FPRnR4MWxWVG5KV0U5Y3grcTE4ZlBGU0dI?=
 =?utf-8?B?d285Q01HTVpjeUsyNGorSnZjTVdHOEVBQmNsQUgxV3IxdjZ4b3R2ZTR6bU9U?=
 =?utf-8?B?dFlpdEVOVzhNa2g4aWJlQVhjU1BacXh1dWVCY09tV3pQbFgrUkQ1VzVhZ1VZ?=
 =?utf-8?B?K1hla1ZONTU3dEY2bVo4ckkvbjFkbm5QNEdsSTFySTZYMHVWVlYrUW1iL1Vl?=
 =?utf-8?B?NUFSRExNb1pFZHNDWWt3VXkyRW1hNlUvR0txT1lYUEcwaFZRYmt0Y1pmQ3NX?=
 =?utf-8?B?RndHYlpwbnFWZGFRMVJ4TjJqZ3RyZ2ZqR281R3hMUHRWTTBnN3Z1TVM5NGly?=
 =?utf-8?B?VDc2L3FnVDdVMnZFeEdpWFg3ckZuRTQrSVBiVEpGL3NpbkdoYXJVUHE4NnNG?=
 =?utf-8?B?T2VuODNhZDl2VUhYWWxqWDZWN01ub2lDQndLRnd5cmhBcnhZN3pCME5mdDlq?=
 =?utf-8?B?S2pzUGI0YkFCWFpCanJsSGJTam5zWGx6cGpjdVMrZmU2MndQUVhOdURhNU8x?=
 =?utf-8?B?aWFlVkdTUCtuNkUzMjNZTGFnc0VFVjF0QkZDRFQ0U2VueEkzQUJjN2FaRlNo?=
 =?utf-8?B?YVVMOWozdjBCK0RIQW5yRloyT3FRend4RUk2TUtydVRsYm5EK0dUWjFGNVVj?=
 =?utf-8?B?cnZKYlN1S0JDaXF4S2laSDFpUnlKS1NERHZ6OHlRS3ozb05CNnJFQWQxRW5o?=
 =?utf-8?B?ZS8zMUc1dFNvWmxKb3RyZGlaWG8yb1BzNG8vYXNEZUF3M0NXNFdpSXRjUTA2?=
 =?utf-8?B?Q3FialRhSmpINUxUa1ZRMytBTC9JOUlnK1NndHlQRXdqK0pjMnczdGFXR01H?=
 =?utf-8?B?UXlqV3hYS3oxTmVybXVMRXk0YTFoa0RuL0w3MStrL0w2SGJqWjAwWVZ2WVB6?=
 =?utf-8?B?Q0dGanhIeW5RdXZyMFZvYm1MTnRaQURuczRYUHN2Q1lqSEJzYlorT1RBQ3NE?=
 =?utf-8?B?WUhZc0pRdmVMN21yWmRkeE5GNmxHTTB0ZndEUEZhUzJIWFZ1TW5xYWlidmFV?=
 =?utf-8?B?SUR4WldYZ1pHeFhDSTJUNGd5KzZmVDBGMFNQMXF1UWVaRGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 18:36:31.6560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baba3c9-926d-4588-8f88-08dcff5b19af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9506

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Series generated against:
commit 5f897f30f596 ("Merge branch 'fix-the-arc-emac-driver'")

Thanks,
Tariq.


Carolina Jubran (1):
  net/mlx5e: Disable loopback self-test on multi-PF netdev

Chiara Meiohas (1):
  net/mlx5: E-switch, unload IB representors when unloading ETH
    representors

Dragos Tatulea (1):
  net/mlx5e: kTLS, Fix incorrect page refcounting

Mark Bloch (1):
  net/mlx5: fs, lock FTE when checking if active

Moshe Shemesh (1):
  net/mlx5e: CT: Fix null-ptr-deref in add rule err flow

Parav Pandit (1):
  net/mlx5: Fix msix vectors to respect platform limit

William Tu (1):
  net/mlx5e: clear xdp features on non-uplink representors

 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    |  2 +-
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |  8 ++---
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  3 +-
 .../ethernet/mellanox/mlx5/core/en_selftest.c |  4 +++
 .../mellanox/mlx5/core/eswitch_offloads.c     |  5 ++-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 15 +++++++--
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 32 ++++++++++++++++---
 7 files changed, 54 insertions(+), 15 deletions(-)

-- 
2.44.0


