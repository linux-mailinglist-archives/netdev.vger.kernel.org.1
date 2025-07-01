Return-Path: <netdev+bounces-202942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD0BAEFCD7
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B543AA686
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5AA277818;
	Tue,  1 Jul 2025 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l5nrwUBA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96FC277800
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380984; cv=fail; b=rVLws5Bh2Kcc4kv5Fs433WlGKwuo61+WK+H1P212z2sdVnZFNflxWk8lYMgX/stV6SpvXcgfzXWAJ7y15oDfwNlLnXJh9aaAcG0ka7agSUpLP2PErbvO/vCjkUUJeQPac1HdIAhovcGIIBHDR2ZZW8zuWPjj/U4vRpWZTZJD8W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380984; c=relaxed/simple;
	bh=Hsn7S3CgX594UD3IYMbqACWWni0JYK12GZItk5UUq+I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ejOCw4NpsR5dJadbM4KQ5aO5h5qjplTDJkxK/ZfnPrjdRG639DWRV14p8lsIgBd0GGK36seKerW2Muj5yMHMl3n+WCdKguGC+pO1nuvhAvvcp9ycWZ2uTcSHgoNdPEzsHiUTAjrlUiDeyDqBiXW3tIRj8cSp4gK6wBFrbvIIxCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l5nrwUBA; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuRmtw0d8hVdk1kT3lydgSf/OEUoEzlZPTBHe0y0pLOBt5CytXpSzWkaaAYfx0pF1v8Yvx00t5oNQCtLB4thaLZrxG1keSlmDlCE/IH7XFnUMzqlqssGJJtRk+kFL7grXaJtXLqO25V8uqTS8mqMR6iDXuscAQMcu1qHezGHzeV7HAm7FgQeq+MqseM1utu8dkxn39FChpReLWXOx6Y1hb41W1ZgZg2maITHszHwH3eJWc0Ffe1pw9CvFVm84MauNSlo11+x4IRJ8O6LbI+c0bV3uo9z+4UCrfCMUNkxWmEvRcfNJLLu7hchwo5eXz9ui35LfHyp7vqIoipwQKD6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ed9AkrIs8GV5HjNq3mXwso3VAFoZAnf5gZ1sg7jT7dU=;
 b=R9bo5yklY3Z4zhOFsHNIb7rW9Zene0KoQfIJRjqoYriM3X/2YxnfF/7zqQo+TLuLtkf2hPap+HYnWKjInL4xIHb9jTgKIc0LUFimGiNjqlljl3t8pLDkFZ9TM6M9YL0KHqYxAhsfMXBJb76wXxti/Jo9styromZ7TuPlLYf+fuMdnV7n+u0/idUhxYjS0236erYDaoS8k+b5Xe4GISk/TL0GjaImQQi2hsuFixCtkYmHWBXGOo5uVIK35HrECvRGL/QDT2EZn1AGjEIVMp10QKCb2DgvVf8dGaJ90MF/hOEwbHoqIEbN2WjpfwKOjtyawQbM4qnIzwgJ4V1JDQkvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ed9AkrIs8GV5HjNq3mXwso3VAFoZAnf5gZ1sg7jT7dU=;
 b=l5nrwUBAnzuWF7VOo2KT8F4hBHFpSXB+IVbE4r571WmPLHmZ33EFxDILtVrRs6S5g+uSph8/357KElbortkQPONQPOILdkr20Q9uI+v61NfH+yuw/2G461K6ge73HPZFatlulqV3dLfBYIrym5LcF4tG8FWLZox01janS64eFcQHTc3FsC4ox47yOkQYFoh1bGrpBS47X10arrI0ZNhRqZTLradMSnqXAPdL/9N9A8qRw/kY2bVCJX8Rb5TQs3ogzwyMd0Y20SO/mTKSM9TnytLCZPamfnSd51BnpG4NajsdJTc8uFn/TkAHohba71M7oGpSNU60BcKLcT2p1aalYQ==
Received: from DS7PR03CA0189.namprd03.prod.outlook.com (2603:10b6:5:3b6::14)
 by SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Tue, 1 Jul
 2025 14:42:58 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3b6:cafe::25) by DS7PR03CA0189.outlook.office365.com
 (2603:10b6:5:3b6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Tue,
 1 Jul 2025 14:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.1 via Frontend Transport; Tue, 1 Jul 2025 14:42:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Jul 2025
 07:42:40 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 1 Jul
 2025 07:42:38 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <petrm@nvidia.com>,
	"Ido Schimmel" <idosch@nvidia.com>
Subject: [PATCH iproute2-next 0/2] ip neigh: Add support for "extern_valid" flag
Date: Tue, 1 Jul 2025 17:42:14 +0300
Message-ID: <20250701144216.823867-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|SJ0PR12MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9d98bd-4e36-47ef-07a3-08ddb8ad926e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YdDC4OtXwh0W+5H4uk/RMM95meTqAlsmd1v/hHQflEC7kgePHCiwUoUIme2L?=
 =?us-ascii?Q?YesNAB4rvsIMLjIcAm1lnOqb2e/fcnC4fuuwvwp8hom5nb7QzK1kuVBmrNs+?=
 =?us-ascii?Q?xLdtJVyVNm0c6dEarggCA2q6ogk2oSbTq4ao73ZtX2fxmX+1Pv5Qq3JrgP0o?=
 =?us-ascii?Q?ShqfBga0AKn9keeIgKnp9dOLAkUQ6GK5eoNOWiU1YoqwQ8OkZOxi0I2jawnP?=
 =?us-ascii?Q?3nPPsHjo0+ZHpEefIfE11UnYxV2llBrWZgeK/VpR2vHbpo+ohY2zzBLKedNk?=
 =?us-ascii?Q?/Eo4rvk79sqtQQvz5l4LA8p3BN0volZEXvePlIym8sKRxhrhp9E3MEsbhAIY?=
 =?us-ascii?Q?mLF3Rr5ZfgdNtMYJGA3+e6iNLJ0+6XF5Pfv954tMDlunUhevO1xwUZJZgUQ+?=
 =?us-ascii?Q?qC+szFxJKrRUCR/Q1Ql9ePq2nRrKLzo/YJ1Zgq2jaNWh/I/3tvVzaRq8tpzq?=
 =?us-ascii?Q?MbTizFwzpIQclnslkLw/3a/Zulc09ug7YVfrZTj1UeOv8nE7rW9timm3jJxo?=
 =?us-ascii?Q?0W80A0eEFTO3LQ4B1h5ZsPnaiOEco9zR10Q+8JmafDBqPROLl3Ik+U4+U3Bf?=
 =?us-ascii?Q?E+Zu82DML9cZmzglnuFvE3qattLOlW9nqsr5DQTmTZE7uwzcx0FbWpK4y6P3?=
 =?us-ascii?Q?xaFhPdHoybBU6f6gJSNMBdsNsgLrvdHHr22ckH71Ny0hAnoM6XUxOb44HS/b?=
 =?us-ascii?Q?9XWKGgBsgZp5NM4LG25DuRpxsSNwajuz9f5vCVJc839uj2w+vO2raEX9gXGD?=
 =?us-ascii?Q?QCzME3dTe7Zb6DTOtZ+PhNiBwunxZvjNUiUgm9YFutwFYUOpM7sWSY/JJKln?=
 =?us-ascii?Q?QkwgJHfLqWngAsg2vUc25Hf8dfGefdVKLEcRP/nxHgv9AZMudd/WN3k678YX?=
 =?us-ascii?Q?dmnatwQXsmCgAklrNHWRe7kPoGFrniNBFf/LgpHcTGTEY8jYIDRnIHjea4We?=
 =?us-ascii?Q?fZ1T/7QQsmat353IFo9RNsXYLRZ5e3+fVk6vP6WrpTcWmeTszXRIFBI0TVSB?=
 =?us-ascii?Q?/Fsduh2x62S/q2i7+VnkZsqv2ttl0Z+/qStuIgFL2L9ooNyoIGUQisV8/WYb?=
 =?us-ascii?Q?BFFw+74XgapUaLvuzH+TXKDGGYXgsGDi7fF/KiWR6buznEGcYfNUslTZQVfQ?=
 =?us-ascii?Q?zcLoX8VV6OV77r+7arpjqNGH2HcyPzXeU8LSp9wKV4iioxy7VzXNcZz8w/p2?=
 =?us-ascii?Q?8kAYlo5nH3VGS07INX5+HTp3ZjrCHZDW6r2rA3Lis6bcsrfhssywuBrpDR4Z?=
 =?us-ascii?Q?3Iy4Nw0T0JlWCfIGFw7LJok5FhmCoUQxf4/dTBRPFoNFvDSBZ3JqkJH8RCxF?=
 =?us-ascii?Q?x9DdeTQxkwochUa3NwfBSevdF9sqA8wa1Jp4epQVbIDsLIaYkr5SOHN92XKr?=
 =?us-ascii?Q?xGULg2VWxJ9mOGCMEJYKNFXQb2+w3J7fZSu7BUyqWigodA288s14kLcsgUuP?=
 =?us-ascii?Q?GXH8LHX+RAAT0bNDxe13A2AexLEvf93ARh77jIfXd61QlkY0cunbdrQujQA0?=
 =?us-ascii?Q?D5JortIb5BY8veicfGIGJVkQ1qpcD0qq0Y1caZTCr58UM8toA6tgRv7CyQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:42:58.0476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9d98bd-4e36-47ef-07a3-08ddb8ad926e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733

Add support for the new "extern_valid" neighbor flag [1].

Patch #1 updates the uAPI headers.

Patch #2 adds support for the new flag. See the commit message for
example usage and output.

[1] https://lore.kernel.org/all/20250626073111.244534-1-idosch@nvidia.com/

Ido Schimmel (2):
  Sync uAPI headers
  ip neigh: Add support for "extern_valid" flag

 include/uapi/linux/neighbour.h |  5 +++++
 ip/ipneigh.c                   |  6 +++++-
 man/man8/ip-neighbour.8        | 10 +++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.50.0


