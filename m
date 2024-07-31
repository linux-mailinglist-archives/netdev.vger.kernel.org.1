Return-Path: <netdev+bounces-114450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD07D942A11
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3DC1F25A24
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81361AB53B;
	Wed, 31 Jul 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TOdL37G5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75811AB530;
	Wed, 31 Jul 2024 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417394; cv=fail; b=H413pBPGLZ4+CJ0jww7OXzK8nSZiNJllMKkfg+Fy+WOaBeWbC6ltciFRi4Bk2II0BI4W2BC6GLktYsYJIbGXB4535sFvWfhGEQTH+BuAjJEAm9VYkCyFNon/y0AOQWGyo5Kng+CKdofPx9IYUUvnMewy3hGcotTfhMGa2ZYH3YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417394; c=relaxed/simple;
	bh=xFAkEg+zBJao+xoXttgNPUvdT+wjLzXetGr6g+EqTGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iT9sMrjeuWn6TKo5sZZD4/G6IrPuwBA/s9uA7ldX4dOTe6WJQXZ0yXfiI2jqX6GeoEpUD5rAbJOjGTE9dlywXzIw7tItKqGsxgNuRpLbtIm1mgrPD0FHJsf4/n8FME9Vl8c7MuCp6+OOd7uGC/vBFa5pWZPWSkQpRDIB8cGbyOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TOdL37G5; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYqZbX/F74fDToN0TzK8Z7L93jn50JtY3v+7HsunEMiyFXkMfui96WcFmPuLqUokvpfCkOe0EMb7DZd+voiaDJlGEYcec9jaqbM0LTDbYFX5t16D3JcJOn79fVSEshk44qhChZEuK1nYc81QliTXVT4J4E3sDyST7OaIwIZKTUOAlYnreUp4aS4qIrvC4u9iqajkclA3LFV6JComCTluAAHRcWOMC37it7C0+Xzz96CekzMlN3nYSuqPHlyBzCPPjpnSX2ArGyBi1emJyzpJWTDHHSpKNkGpMXjIvKiiSmXVgMIjKQ8BHpeSfNgcN90676LcNl58E/8xV+LusW49nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRZlz8pfz0hpQ17yo6QgIE7HKBJNxuconVQPZB0LoJI=;
 b=MBTC+0CRX1FudbbmQYhC0zqhvirmrc+Abj7mMwsMwKYaO9z+dz3bIBcdk4XkmtkDafcv7dWBsPjKh9foKc6qFLYUMX4T9sliTYcZTqwndfsga/pQ/d7vpkOLyYULoGOhNCL/XNSZ73H0dbKpY5WYn9ZqmGMBMOVg6JuDNZNFvc1yf+RbJx1eacLpZoZLwqUSEPVFxB6Fs+ufd8JCsvtb3AgqF//DAovp3UUmN7kknhDMZ6kijaK/9nf5AJ9xXGda9JNn4JNYvQBXpG7hpKaju/SlSYzfsX2PVeDxe7rHiWKWVwZk5fd90jemtOwQnMpcwreq+FuXgJM9imr3qgRqFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRZlz8pfz0hpQ17yo6QgIE7HKBJNxuconVQPZB0LoJI=;
 b=TOdL37G5JkXDaNgc+72jPhqk1lzhnwcCljgouXIYHz4hKJ3IVNVhF+6zCsvs0ggb1UTlckzyipsIQFAXvJCx568XbD1qpPBQozg4hv/YH9HAOERP6sV4tgQ0N65QpWJzB2oaU1+0UsgsNLJ3NtZIbrbkLkBV2ia+FP6JOaYa3ow=
Received: from CH2PR10CA0003.namprd10.prod.outlook.com (2603:10b6:610:4c::13)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 09:16:29 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::61) by CH2PR10CA0003.outlook.office365.com
 (2603:10b6:610:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Wed, 31 Jul 2024 09:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 09:16:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 04:16:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 04:16:27 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 31 Jul 2024 04:16:24 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v2 2/4] net: axienet: add missing blank line after declaration
Date: Wed, 31 Jul 2024 14:46:05 +0530
Message-ID: <1722417367-4113948-3-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a63df3-0477-4279-f7e1-08dcb14175c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TEkEwX+DD2KkgFX4z5XOB+zHTNhD41Jl6IzDJNchE8FAyD5jEEnDzVKMv6mZ?=
 =?us-ascii?Q?Zuo9f4HNAK0DdG/qGGLdbjwbErP7f5AWRunEVanU+IJqg7Q3AXDl6IP1t0YE?=
 =?us-ascii?Q?o8UA0cVk8Q8oJfwYyRocEP+6o4X1bpmFC3DYTAezygPLRK72dnGc8CpEFE6D?=
 =?us-ascii?Q?aOqXy8JTiEaGHZXmGHJgirAD9o1xC4Et4ABfnRtnhr497HLxK4/S0Ql9BWW7?=
 =?us-ascii?Q?uR2fXPIV5wfWWOKcF8Bt7vLpyPRYV0GXfbQA5R7jXrqgKqierXoH7Z2tlj9h?=
 =?us-ascii?Q?5qQVFl/8fp+miGNN6efmTm/owuI2cYd9l9a+5YkWn3b4md2jyopzxvVChOod?=
 =?us-ascii?Q?2vPP9F/LCCN724I306r2s+jvZVhZ9YsrBA5klH22TgXwiEMO194vfkDIFDv0?=
 =?us-ascii?Q?xi8xMJZJJ34Sg9ivTnXWprW7CY1PisN0er9267xOKmA5tLXOr7Y8G+QlrWlJ?=
 =?us-ascii?Q?WsCEVEm9zgkOXFPM5YpXR8PR7mIVG7uVQVcg7JMi2RDEjsTW50ob46i3Vkmt?=
 =?us-ascii?Q?Ir/PN/pboq1qkkwgZMItL+NgGWIqygV34G3j0Q+gP0b5uaQ9XFCyUXYwzsBC?=
 =?us-ascii?Q?bj+60PcZbMkCGq/p8JpyqaP7DMK4pY5GK0xME0Wup5IFkeCvkma8F/xEiUJY?=
 =?us-ascii?Q?WaGGyRnT5BSwP65GiHdS5vlsY2YuIsINv1+3/q/6wpxpwTEuLbvntPpcFrDM?=
 =?us-ascii?Q?TFfPGahdK3Bm92yi1HciFLubpAxkrubvAlXaOjULib+WPT2e0ZSdML29o7YA?=
 =?us-ascii?Q?LeJ1Pv4tbw8XCGgzpC8O5i/znTUmgzrR3Bw/v3S5s74Pnd8/xeZWh4zrCQkc?=
 =?us-ascii?Q?xczR796ibvof4D4SGzZ6alo3ibyJasZCUZ7wkYMpoGwzmu5onJ475nP8QtTe?=
 =?us-ascii?Q?2YK+C4XD1kqaeb+H1J5RXp7sGKpIT6/CBC0tdvsh0JsDhKTrfRbzGNxclh67?=
 =?us-ascii?Q?vkUXCmu9VMwhSJ3fhcr+s6tWhXvF6Y/b5YK+q6vejegRs/E+wJY8H02HGodG?=
 =?us-ascii?Q?SwgJORhDp0rpxWdCXmDD1PVgRsXiq+/7DHkIZlJ30ga3SnuoynIkESlVKSDV?=
 =?us-ascii?Q?NlizAahIZ3kyf9goW1oHO+7YTjiTYYXPTslcyTdYU/q8imAAXOsMx3lwSRyq?=
 =?us-ascii?Q?uZuXUETcIyhTxWf2OSnh/zo8gKJwe+udLIxBrscCRE1HU85TV3ZxN9ivsRgR?=
 =?us-ascii?Q?J4Y6hMmnQU3OKlscTAnwNTbxd2Lt6BnXb/wWtFlwFvbjYMsEH9/faF/rXSUa?=
 =?us-ascii?Q?Ry97hiz62Kc4AwuH3pN5pcYnN7t+mQJ4vGSiYD21kTQ11ABPmhEeBNKqXWGx?=
 =?us-ascii?Q?NrS8hIxksBaf4vjuzIMAprQQ2xMFi0jMuu5YgnUFAGYkBsiaz+bIPRx6TDxI?=
 =?us-ascii?Q?83f5D2cIK2/E7BySxvjiz8LsPTVKOXxz5w9OKhO08+t8TsVOug9AifwGUhgg?=
 =?us-ascii?Q?AY1Yz06BzCC8Jl3OqVov014NK+WvIFzG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:16:28.5951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a63df3-0477-4279-f7e1-08dcb14175c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033

Add missing blank line after declaration. Fixes below
checkpatch warnings.

WARNING: Missing a blank line after declarations
+       struct sockaddr *addr = p;
+       axienet_set_mac_address(ndev, addr->sa_data);

WARNING: Missing a blank line after declarations
+       struct axienet_local *lp = netdev_priv(ndev);
+       disable_irq(lp->tx_irq);

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v2:
- Split each coding style change into separate patch.
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index e342f387c3dd..7a89d4fbc884 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -415,6 +415,7 @@ static void axienet_set_mac_address(struct net_device *ndev,
 static int netdev_set_mac_address(struct net_device *ndev, void *p)
 {
 	struct sockaddr *addr = p;
+
 	axienet_set_mac_address(ndev, addr->sa_data);
 	return 0;
 }
@@ -1657,6 +1658,7 @@ static int axienet_change_mtu(struct net_device *ndev, int new_mtu)
 static void axienet_poll_controller(struct net_device *ndev)
 {
 	struct axienet_local *lp = netdev_priv(ndev);
+
 	disable_irq(lp->tx_irq);
 	disable_irq(lp->rx_irq);
 	axienet_rx_irq(lp->tx_irq, ndev);
-- 
2.34.1


