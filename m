Return-Path: <netdev+bounces-182138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66851A87FEC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7213ABD75
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7230328FFF8;
	Mon, 14 Apr 2025 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oqxtsy/Q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0DD17A305;
	Mon, 14 Apr 2025 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632203; cv=fail; b=hzI2FQgwAVTFSTDiTECZtTWqkg6CzxGyc7PN/IMMKB08f3CtH4HawCpA/t+4X+J24P7D0q9khhJJH5lbWaSmaCYtuUkr+f9ANzFdhuBiJyIAWeJr09ktdMdM+dOsR47NfcVlULrnjjC6fg4qjW/eO+zNaSQlzjfyinUWTFFZK0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632203; c=relaxed/simple;
	bh=rj3gMqphaSXH+10+QJjOVi8XsGXKdg/OEOUYC9aqZLo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l8BeJc2g1U5RiY0lbnLXa2ERRptaRIfd+lO1oOe3RNBzoKw9i9RX9nQmAg0f45yKbzrs6TLJZyb6q7LZzEtYA7ISDiEXU86sjc8R5B2nHI+eDCO8Qpl3+o/t8otF+nArif0FQnu3c672VDIX9Nuli7IJ5BEAtiw98fWBZZ+wuF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oqxtsy/Q; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScYuFwZJIYzJBgdMYml+hDeqZSW2SBmUr7MHLF+DwrLGNjibqVK0HiAV8FEFbUYe3vBpFXuX9HvPrNoIhxRlYfwfvaJKNBH5IOhDZvr6YDS/iS9j6BKWxb3x2Bs6DIH8sBRUwzLBSVo9CKlrIS5BQNqfPKHR/yCk3SJd4hGDiE/EJCpin3WmUoqmQEy5XEA8CQqvwcNs1fa3jE1XurG+vOYSyjGoYaaxL4SwsWg80FD2N2R9O/LPnsAJwPboe7Ef28ud2h9FOX20gq8kHzLj9vMJVM7sPWgKHNiAEU6xBybzKwUzl+Xd8GFB5Ou/Kv7FWYMTNPwMNAwUF/bilanVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxJxp438CIgqcPJ7/pkRn6KQ2bIiKFUzFFMpIn5Fj/k=;
 b=M0TbZTEt23PAERJhaAS2qpf/uUJ3Bzyk70+lCCxkjhw96Mvk2Wvd6ry+bt5FavrEk8d5tWjAfPgb6dAqZ/3BCwB5oKoB2+wz+WjpedtXXCmCCdZj/TR4GEVCb39H7fRODksMlaINCDLBNz1AadifPEnnHL3Pt0e2eh/pMY7ceWlhBGjhCY2ENhITkcxmtbqd7G+QXsMBmEB/jChiZ8wSYE6x1/bT9eOkZE2o0e6CMXL2oiq8mSuLPtlJz4LqxDG55ZRgv6QSxumwnGek+/XvmguhBf8/61+niISIbgeOWm4QJ3KaAuLrIaXbEsqzuy/BWFnrxDMuk96OImxPJv52dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxJxp438CIgqcPJ7/pkRn6KQ2bIiKFUzFFMpIn5Fj/k=;
 b=oqxtsy/Q+SIOPY6+IAMmeH1e32l2FquokqurfwvWB75hnQLh5sDAqBMfND2EUaz8qU8Cq/204Sqnow2yM0whcUCSmWEtSCArVf58uRYlrwk7glPciniHvQYb+yfpjwVaF+gMCQTZGNzxZfK5iakhWpx+q1m5eDADrNcpgEMWkqM=
Received: from MN0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::15)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 12:03:18 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::48) by MN0P220CA0004.outlook.office365.com
 (2603:10b6:208:52e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Mon,
 14 Apr 2025 12:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.4 via Frontend Transport; Mon, 14 Apr 2025 12:03:18 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 07:03:15 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Thomas.Lendacky@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH net 0/2] amd-xgbe: Fixes for RX checksum offloading and split header mode
Date: Mon, 14 Apr 2025 17:32:26 +0530
Message-ID: <20250414120228.182190-1-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 6233a11d-dc7b-4a03-ff00-08dd7b4c583c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?03pVlpMTEEbwYLhyCzXkguZ/dX7JaO/4zJ45aAsVBOggN2irOXGKi4FBc7f9?=
 =?us-ascii?Q?GHTroHnJxpnwNty48axFWwUY9z0Z0kaCIjrMh4DgZI81Vfo7JGCHIm9XPNqp?=
 =?us-ascii?Q?jllLJvKDPguluUNVAz256jHgcMxEVQ1k+hHz0ytaBBhmbCk+oPEly/uREhp1?=
 =?us-ascii?Q?TNZJ1gTou/Rm3k06OFPgzKLKfI3uHZ0Wwow3fIr/fMAcYVX5UDhh0D0GE4Wr?=
 =?us-ascii?Q?84CO+Ubsty1VC43IPpmC7iPPhl8qS8GF+5wpjTkOOzbHWnlOet60+0h+WC3m?=
 =?us-ascii?Q?xiRYHdVmfi320cc5nF55ANzPOfh4luyVL+fGKTkvjTxoTJzhQ/9DN5WD/Xx2?=
 =?us-ascii?Q?EcxMk2H3U/LB09q/jRr5hDl+N7wlKZ06122Wx3Ye/24H3Aff36X7UeVom48S?=
 =?us-ascii?Q?8kI8aO7KqmiGlQxbmsvBBQmNT4oUjD/mSeVo/6/L+GUsj4pEDW9nKV6NREq3?=
 =?us-ascii?Q?IZ8PfpOvBJHCGr1cjj4664aSKHH722KiCDNUFYmr6VrICuy0pK6LzXeZ4xWH?=
 =?us-ascii?Q?NWp7h9YhEUHj0ROXSvw0A+/hyYviV5Z5sUIQFPsnTmDLltWVM18kbdRgdUSS?=
 =?us-ascii?Q?Isg9HOaVaPReCxmAK+2nwAPb5auBye8H+mIKQwL5Ktgys3a5UjSrWhaXfvg9?=
 =?us-ascii?Q?HZWCI9hGQn6K0ZxSSjKmLwxhAK6V8cCzcBV3UrpSQUIzLFnBXgMpY5sClKYu?=
 =?us-ascii?Q?D7hPsTfODlps1Pl3s3J87sBmaF/A3Tm5TGxrpf41iobApZCI4xyhgRE+Rq4z?=
 =?us-ascii?Q?3GxLxWnHkFkzGnBoLYZYyLyc7zxRuHl6U7X3A19HzcoaQ5cqzGcVVacVfnnX?=
 =?us-ascii?Q?oKuRuPOA1k2PlBWMmBMM18hUsUx+B9n5r7IAZtErnN7QFyt68/XU6KiELd4b?=
 =?us-ascii?Q?Cp1WPe8x5SUdlCBYMZKGmkblWinx2uaiN8byotLgb7nR7RLKmYlFzsBmXjSK?=
 =?us-ascii?Q?D8NtVoPKRd7Azmiv7v/b3sFcaE2gA+7dGPvIMbk+tKfF8PGtGpaPNGtfaDyD?=
 =?us-ascii?Q?jzyzgXQmq/m+c3GO+op6aY4u0L2whl5LroQbbkmeE2IYrtICvDE46aefYYKN?=
 =?us-ascii?Q?/JLTdCITMfh70sw8J3wj8SOzzEnO3layo4oTUzi+opd3mFtyYoYG9zNPnVt7?=
 =?us-ascii?Q?8SzbP9toX6NsDJCObDbTSRskgBN+P9rL46lh1/gClfA3GY4WUyywgObp63f1?=
 =?us-ascii?Q?bDEpFSvFbxUAW2TbhYR4HrCyc0WG3325/di/FI2/kWKXTU/W5mGnJodNmD2I?=
 =?us-ascii?Q?DPd3nKD5ISc06sZzVunJ90LwmwPsJyueqT4cwlHS9rdvNN2Ir40FQVNRqDlG?=
 =?us-ascii?Q?YYzEh8LhRW+akxz/UtteZ81yZnobqzjnkcrMkDUuo48qROWI6PG+wuA8qLZR?=
 =?us-ascii?Q?6g+d2RkqqQHA0yqLfgWcvQeItrB0vpFbJZqLC9/Ya9goSPz7sJLgR2IcqMhP?=
 =?us-ascii?Q?WxJr1aqhGVmWNXc/jw2oqZCAVQTgPpopXy0parQvSoQMrNnFstPJj7a2Fu2U?=
 =?us-ascii?Q?iKWVk/iOO+KP/H1/mwpeHz5vaHehn2w/YkdX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 12:03:18.4170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6233a11d-dc7b-4a03-ff00-08dd7b4c583c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539

Address two issues in the AMD XGBE driver related to checksum offloading
and split header mode. These changes ensure proper handling of dependent
features and resolve data loss caused by mismatched configurations.

- Patch 1/2 resolves an issue where disabling checksum offloading
  with disabling split header mode leads to packet data loss.
- Patch 2/2 ensures that enabling or disabling RX checksum offload
  properly toggles all dependent features to prevents abnormal behavior
  caused by mismatched feature dependencies.

Vishal Badole (2):
  amd-xgbe: Fix data loss when RX checksum offloading is disabled
  amd-xgbe: Fix to ensure dependent features are toggled with RX
    checksum offload

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  2 ++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 26 +++++++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 19 +++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  5 ++++
 4 files changed, 48 insertions(+), 4 deletions(-)

-- 
2.34.1


