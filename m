Return-Path: <netdev+bounces-186102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03725A9D321
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A78F1B8117B
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 20:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C340221F03;
	Fri, 25 Apr 2025 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NRSO2Jut"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B2919E7FA;
	Fri, 25 Apr 2025 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745613562; cv=fail; b=AVTn3mVQumNRl+FErBIRRvIjBvYb51hFUtA2cevB54b+frlEU3K3GCoKmh/rl2veBOeaa8f9fRg9mAw0dcN/o0XlCdnJjPpMbYHckTqX9e19jR5GL2anVNr26WBj5x2i4SRx29AT3iQjSqVp5NKKmicgDFoOFDA3Wgf3WW89Pqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745613562; c=relaxed/simple;
	bh=txnHqF1V7FH4xM5S6Vy2mle6AbndXZahzdBOeDhItZA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G5wi5shx3dUpf6L2iXitnx0Tw7f/kUY3yghXthRQN296QGFz0ODRZbxTd73STHAJQpka3+pjZyaDerDUDwpaJgqGgHMS8vv9CcuG9a6Gsyk4wLyhw0XhhgYNdAMvkX6CqjFiAGt7HW3z0tJOE81/+gU5mqSr2I5b2J4anQ18iSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NRSO2Jut; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYimjEIoFUhMS106+SVwB3P1nJHgjR3PoSab2F13wEYydEtX38EePxyMfVrFd4wp+VSqM4Bjzz7Kz5PF93/ems+lsMJYVDrKqabPgv0PwFKGhbR5vmKQ7OiH2D2FwMi+Gw3J3U8GMrqCq9iH6s2/HPKZ2KHiXEVkmqOzOqeXWE25daSQl9Ms4fD3v7NImBkqh0rrxaOONBC+b+ib0c0zKKCuZnujBYOvx42qbUwurRgRFtqqQvrih/KFJmB7pAkNiBZ+j7O5NRDvFgx5X6kUEA3M25jSJ3qejNe++eAT5iiISC7LEHj0vFS3RJyRN6mogRFrhZ4EWSe/r9nrInU0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxPATLtb7zvpI69xtndS3JrZQyPRCqmbrbwDAm5bNl4=;
 b=kgli2aOzJeKA9yOlfY/6I/adn6GsHhj+SWMExftiyucdAjA109NeRMQlm/Nvt82F3UkWz+0o8NDrFru/AAfTs5ZDSQ3hUjEwXKYNqcWa64/bbHM14j/TebqVTOrK/8XW8TEExQbTpIH8Y0uQuFuQt7/oE24c/5Bjx4SWPfKsP0lq15bvP4MKTgEnCdf8OG1FsNEbpZikMNSWCiyn75qJTHbtnvvI3iBOUWf6VCnby3q3bqpKrNNKUQ+gfz7P20Ea9yrX86GxSrp4pDL84zJlip2ZHEeilxmKhKD0kZPJWV+F5uZeoa0K58or1DH24dS0NSIdA7mQl7vmjYLlQTyD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxPATLtb7zvpI69xtndS3JrZQyPRCqmbrbwDAm5bNl4=;
 b=NRSO2JutZ/yen2GiX1MIONNyvVX0xp8eDHdaz9mzFwYDsmhJYoARr/9z+GkdFEdsZMTWcrlycjTx9s0PU1dTp2NGyTzORyar4aD3SyGQhPEx98pzqukLozYQJDKB9tttCUaRjIGiPg94Vtn/SpDh56R5aVg6CsBoCN64aZQqcp8=
Received: from MN2PR20CA0066.namprd20.prod.outlook.com (2603:10b6:208:235::35)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 20:39:16 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:235:cafe::ba) by MN2PR20CA0066.outlook.office365.com
 (2603:10b6:208:235::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Fri,
 25 Apr 2025 20:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 20:39:15 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 15:39:14 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net] pds_core: remove write-after-free of client_id
Date: Fri, 25 Apr 2025 13:38:57 -0700
Message-ID: <20250425203857.71547-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 889ff9ac-85e0-4521-148e-08dd84393ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ZNyxUj4BnUdHOiZQx7+/OTatI1Hryg+OyRCAaCSQ1s77Xs73ldqHuPGrOS8?=
 =?us-ascii?Q?/V5h2ugQnhzbB6W68UlxI6oOYsrESbClQIMEyr6wZ4PPxuvLvpHBwH2EOq7q?=
 =?us-ascii?Q?VfCZukLdPt1IDAfGEwWAsDRM+wPke9SAvaJru8mniAO4fQjLVkaPI44IhJw4?=
 =?us-ascii?Q?YN3GVYdx6xKuQK1MtTtsRErPPOaQQM3ScEJvCTnjsUFszL3Coj8tZyPQuUUq?=
 =?us-ascii?Q?ZxCXh7rUo4ctBv/JVxTL79V5JJv1ybqq0JWkAfLK4NHkVWryHghd3rVWELob?=
 =?us-ascii?Q?QR0LlKlGPOZT9EA9QkwSMuiilfHHrYXTKBC4SvEVYiKtZLB6SKgAFZbjXwwT?=
 =?us-ascii?Q?bW1RewABWTKCDYwKKDMqaHlIns02MnrVZDVN47KWuZyZz5/IlOXzKGQukY3p?=
 =?us-ascii?Q?6LBGFzEeMp05e4kIs1YywfJN6dzYMScFVvDPbQmHRZtq8hZqtj4n2gEayKVF?=
 =?us-ascii?Q?d18m9d5oHO/L6TcgJJnElZgPNGAmgBT4gnD1fiKzyiVvK+m73K/WGmIdnUcT?=
 =?us-ascii?Q?Inb1JOgkZAkA6DN3o1t0tDBNQPzpcs6/KV7ZFTNEE21ByLUpZe4+ivaNeuSz?=
 =?us-ascii?Q?HL3eLl4ZVzDdR0k2f3ocgwu1Qcn/CUeooYK+osyXzpHlVO6rhn4WTFnqxctT?=
 =?us-ascii?Q?+hixExNsjufVDBTA0xg5EdjsjX+Pr5aM6ONhBCnTcDkKFsdpp8X+m0SspvyA?=
 =?us-ascii?Q?/wYnYPzYYQJeb/FWwKdk3EM4zlVknhUvgLtwk45+/3tQP7hOsT7CScZWHYpN?=
 =?us-ascii?Q?TnF+3w62h7CoiRDEmd47pRQ+jE2xgEx8TkLk+VsE4ykAiTgNjfMeo1922P3q?=
 =?us-ascii?Q?unxFWv9NpGHDpw4XzJj/WP0BHksJasDCXpBodf8eKdtKr8LbRlgpB35nUh1c?=
 =?us-ascii?Q?HvD5rD9t88FT+GjFDmc0G/R2tdNpe5FZo6mTXkMx61mYbkIUZY3UdchDOIp4?=
 =?us-ascii?Q?POoRJTFgBjL2diw3opbYdw3uET70a/1Q5XELeyMwxPUE5KWOiC4336On8yYQ?=
 =?us-ascii?Q?RjU/GHFutkSAF9ysPE0qM6J+0joq6W6jeTVGKshHHqFgfzqJG0N9V6anidBn?=
 =?us-ascii?Q?4tW73cMkA+WU8fRJVnQwEuR1fAaTxqyaXmn8tJoOeQapR3gUWrKqeoY3w8RC?=
 =?us-ascii?Q?lU5dIjIysIOyh/NIMUwKG161amFaChKokS3ev912D8xv/AqaKKxpgHv7mfny?=
 =?us-ascii?Q?r0zX6SMbz5mhubrSt51p9AkV6uAfK/0sd1gwuKmiae7NmjIul72S+A+JX3/r?=
 =?us-ascii?Q?gQWDX04AX4IwicvVwrN70Ao12GpUQdxtqdqJRwh2FiSU1JTqaXgQRnJ5yzwy?=
 =?us-ascii?Q?VZngTqqQqaLo81CU/Ho6nxmb51WzPaHenJz8fVrHyx/RzCzeW+wpD3kCJPD5?=
 =?us-ascii?Q?8XwcpQDP7czoVB4wb75OYs6cCm2AAb55u/4HefQDtESskUhJ6oI4kKXPNTHj?=
 =?us-ascii?Q?5Flm0WmzDPHJuE/8rQtXfKD+ruSUoiaYz+Qehrf7XxCu8XycK+3mThij1WdE?=
 =?us-ascii?Q?/jZzIA5fkkNxsCGIU+WDBep9UYmoG6rGDAkJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 20:39:15.6989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 889ff9ac-85e0-4521-148e-08dd84393ecf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465

A use-after-free error popped up in stress testing:

[Mon Apr 21 21:21:33 2025] BUG: KFENCE: use-after-free write in pdsc_auxbus_dev_del+0xef/0x160 [pds_core]
[Mon Apr 21 21:21:33 2025] Use-after-free write at 0x000000007013ecd1 (in kfence-#47):
[Mon Apr 21 21:21:33 2025]  pdsc_auxbus_dev_del+0xef/0x160 [pds_core]
[Mon Apr 21 21:21:33 2025]  pdsc_remove+0xc0/0x1b0 [pds_core]
[Mon Apr 21 21:21:33 2025]  pci_device_remove+0x24/0x70
[Mon Apr 21 21:21:33 2025]  device_release_driver_internal+0x11f/0x180
[Mon Apr 21 21:21:33 2025]  driver_detach+0x45/0x80
[Mon Apr 21 21:21:33 2025]  bus_remove_driver+0x83/0xe0
[Mon Apr 21 21:21:33 2025]  pci_unregister_driver+0x1a/0x80

The actual device uninit usually happens on a separate thread
scheduled after this code runs, but there is no guarantee of order
of thread execution, so this could be a problem.  There's no
actual need to clear the client_id at this point, so simply
remove the offending code.

Fixes: 10659034c622 ("pds_core: add the aux client API")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index c9aac27883a3..92f359f2b449 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -186,7 +186,6 @@ void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
 	pds_client_unregister(pf, padev->client_id);
 	auxiliary_device_delete(&padev->aux_dev);
 	auxiliary_device_uninit(&padev->aux_dev);
-	padev->client_id = 0;
 	*pd_ptr = NULL;
 
 	mutex_unlock(&pf->config_lock);
-- 
2.17.1


