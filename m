Return-Path: <netdev+bounces-196054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF60BAD352E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 13:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9F63A2A74
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 11:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2628C850;
	Tue, 10 Jun 2025 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2KmKgf9A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B829228C5B9;
	Tue, 10 Jun 2025 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555686; cv=fail; b=qkjhDe9YIdLnUk8sYvCv43UVSZ4A7kWHMl+QghsKUkc6SK8E0Owqc84KCw3fWZU1qd8nixype7ui4LTYGaFOH3PCvQf49Vg3HsXFBaDKrTaRp3ZmgiZ2foqy5b9ULoEifej5R3exICZmQYK7emo1ur9rMYERY6wJJVm1IHe231o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555686; c=relaxed/simple;
	bh=OOebeYAEksCuJUCvigL07ozKejScKNk4l33QPFwa7bM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e5fO8Vx6XV7Yh1jbCgoGjsKy5AoyQqYi4X+EVzwacORTOVcPTQOigWX6vLvfJ75K0mZT+pJkK7ViJmkDwik/iXuYrjEv4uh6BV8/3txRAs/KdJbkxo2FaAXBIOrMDt/pk8jB9GmPHJVhqiiIYCVxe3TZ58WwivipwR6IHfnLSm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2KmKgf9A; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJVVVwpeMpN8R6BaAoI6bB5pFXG855xlHzlIk8L5j539CXkUlZlJMzwZdoQrngHSqHKFGQ5Bmv4fo9Ex6Ek2oM/HgIAG7PEiUPgJ90uWbuLMoF1UgX7MEFbyuHnwMiV7VUNvPHK2q+fXYMnKjtALLBAPEZlgiPeV68Vpiy5IyjmxiPWN7OLv8f8Tx0iVY8qx1GZhsGKLKwzkTFdg4tsx3M/PSx3O+4VsuInpXL1jLtEwy8eu41thVLnjTD5CWiznN8xPJoPmnmUqb+rP3/lDAto8SvvvI9WNhoLDumgyV9EQxaMIXVpGvmhpO1I6LTBoSUjroQXiME3L+5XT971/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufLhMWzR/5Tbu7hhgPc+ummX0mqYB1smVSW3hlRdeiE=;
 b=llSyDJdhFmMgGOCI7q6gxqtOMysPdsXrS1Yey5pkVpvJCZdErsoJUoo+ZvSBRNEaW06M70ism4UfX0RiVFZlMzHjiiuFDN41//GQkEq6sd827GTbQ3eNwC9mdalzEDB1+eEiBeIGFJMe8rV339MGCdpxjNXO4gIgbH+TNE1+Hum45x1bKw9RExs+usAqn2lEnotpc8d1oOu7WKa/j7O00d2kzb68hoZ6r/e7aU1Uc7GHt7kvp2FNyd6qImURifllichsO8aMp3LpCp2xHJe3zgkgP2vO0x7wgJ2xozo26zEUsZ5AwUbmNYkQuNac1K8Oj8LoOsSvO8JqXs17eykgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufLhMWzR/5Tbu7hhgPc+ummX0mqYB1smVSW3hlRdeiE=;
 b=2KmKgf9A5yfh+D+BT7DCsERxMQGcVPNa/C2yZADEmZrqg3jKsYj1Cipnz9BOdviyP5QdKi110/xRjlvKR6VJDKo8PwN2vWpuzS0IVYUj+YfVQHiYy7h5M2sNp6nNilRlYgNxjyTvVc4gSrn/HOc0VnGRd/u6IlUe4nsqfkwqcHk=
Received: from CH2PR14CA0039.namprd14.prod.outlook.com (2603:10b6:610:56::19)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Tue, 10 Jun
 2025 11:41:22 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::55) by CH2PR14CA0039.outlook.office365.com
 (2603:10b6:610:56::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 11:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 11:41:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 06:41:20 -0500
Received: from xhdsneeli41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 10 Jun 2025 06:41:17 -0500
From: Abin Joseph <abin.joseph@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3] net: macb: Add shutdown operation support
Date: Tue, 10 Jun 2025 17:11:11 +0530
Message-ID: <20250610114111.1708614-1-abin.joseph@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: abin.joseph@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e87330-26f6-4940-67f2-08dda813b966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UEva/+NtVSkEPiuYGJoNDvUOO9i612XTNKkZ/q4axH7ItRzW8nsOi+2+wdnm?=
 =?us-ascii?Q?ck82Ac9tdKYW6BXav8YDLnF/Tu/nVbahOM59vyKWGQfaDXOqcdWPLg3y+kBP?=
 =?us-ascii?Q?6OpqAYKSjWiYNGwNxAJJcKX66HfVZgqJumkNn6Pd4ja/PF9V66Nx2vTbgE4x?=
 =?us-ascii?Q?gPzJj34RPBQbqUa7XaI962NFRx5G4HlRGUkQzsdHpruZLW/5ts7JuLZZXTGS?=
 =?us-ascii?Q?edIg/h0CadG0e3aLvHWFndQmC5AT+1djAwzMz+b2rgpIwFBIOT7siQ3fN3/A?=
 =?us-ascii?Q?mnEGb3fOWmTTx3Ke8B6Uh8+ttrCiEHab5HTkPlPni2yrMBOkeauqDbLxTKo+?=
 =?us-ascii?Q?QWZr2UNb0gxkTXeBK4DSh6XGb/2WM901giOq2IKOObGfW2oVomN+UtUIL4cz?=
 =?us-ascii?Q?UImHqfv0jP0vhmuZIJtA+C9zAC9kmk9Xt1ET4p9VdSI32ozrPA8UD0TB0uSE?=
 =?us-ascii?Q?sHqgI9mjP3gtCcLFdbQg8452ZA/qEvJAAp4bpRxrIp/ickCpnGhLV324ehk3?=
 =?us-ascii?Q?J2ZetPrcGCN4aydi5GZ0n+mEforoRstZzgM1LpquxMxGh9ZUZFQWd68+xM8e?=
 =?us-ascii?Q?uLK3rg5VeJLb0DfLuwwtX2QhsU9v2RE08jxa6SFwMRyzRQyHpjHDyBYGFsV0?=
 =?us-ascii?Q?e6L52mnN+n9piFDe8kc6QuB6f/8jVNENZbPjm2sP3701+2jByiGlND0Ltn0m?=
 =?us-ascii?Q?xx7+1J+hpezmcUxYb58ikTQBVLELXSWhyV1TDX/ExlWZWSQDRkIV5YYHS1Bm?=
 =?us-ascii?Q?I0nSSdoORKm/l/rF/9UvANAW5h7B5u1Ww3WM6WaJf2Wjkg1w7+vRn48QOMeh?=
 =?us-ascii?Q?KM1jsx7fXF3wbr37Sp4VgOh66qL0PWJLS6hjivSg67BnUFbXFG0Auuwav5MG?=
 =?us-ascii?Q?NLsYszTXx4Uk85WTU7AP3+POhPXNsE9otxrpMODpdwpUgfANQm6h4QJKKZ5z?=
 =?us-ascii?Q?tmD5PghBQ7gXftt9i7bNlrR7kY7F3LMSh2/ob2ul208IPlFYZ/FixbjPP8g7?=
 =?us-ascii?Q?FXHMdrZsZBSjV29TsAMAN4uQg3/Cu0g3LA6Yd8fjv8OfHwRbX5eDxmuXlk2e?=
 =?us-ascii?Q?tzLG3+dJeghOghz/sZX9beWNLTZSynqH1rtrijy63hBFc8fxuoOVHcJPRCE6?=
 =?us-ascii?Q?LN4/GiRCIl0D1XQJdQShZfFKYeC2CAM6QbNL4Q6gLegvju5ZjBiWdnsMyEb2?=
 =?us-ascii?Q?ImpFkwYv8j0aPt3MZVpEO7IETInX0CNYbCTOEfuz/1P1bhJucguYZOJYSmzu?=
 =?us-ascii?Q?RaJAMLuepNwPp48drnlnnY08fW7jLtmztcIv2ucc+nXx95dAjPlTRNoyPdLO?=
 =?us-ascii?Q?0XMOr99Y91dMPYLZe7W0hoB8/QaRPC0JYT5/ynK+gIVXNx+B50htMpmx5u+e?=
 =?us-ascii?Q?1qnwHwZN7yBHvTfKy5j/PRPtbwT2eC/HulDAB+zyJLgsqms9sa1J5Y9jn3DP?=
 =?us-ascii?Q?vpsklJVfnnSO2QuBJ3h+9ypE+WPWQwarxeqWYF2jPRv71MYjLh78LLLBKTKK?=
 =?us-ascii?Q?LuMuMTJ1m6wzdlDJVlDDn8+KdD5amzBUZXTK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 11:41:22.4255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e87330-26f6-4940-67f2-08dda813b966
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568

Implement the shutdown hook to ensure clean and complete deactivation of
MACB controller. The shutdown sequence is protected with 'rtnl_lock()'
to serialize access and prevent race conditions while detaching and
closing the network device. This ensure a safe transition when the Kexec
utility calls the shutdown hook, facilitating seamless loading and
booting of a new kernel from the currently running one.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
---

Changes in v3:
Move netif_device_detach after dev_close
Added empty line after rtnl_lock


Changes in v2:
Update the commit description
Update the code to call the close only when admin is up

---
 drivers/net/ethernet/cadence/macb_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e1e8bd2ec155..9639c601fe64 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5650,6 +5650,20 @@ static int __maybe_unused macb_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static void macb_shutdown(struct platform_device *pdev)
+{
+	struct net_device *netdev = platform_get_drvdata(pdev);
+
+	rtnl_lock();
+
+	if (netif_running(netdev))
+		dev_close(netdev);
+
+	netif_device_detach(netdev);
+
+	rtnl_unlock();
+}
+
 static const struct dev_pm_ops macb_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(macb_suspend, macb_resume)
 	SET_RUNTIME_PM_OPS(macb_runtime_suspend, macb_runtime_resume, NULL)
@@ -5663,6 +5677,7 @@ static struct platform_driver macb_driver = {
 		.of_match_table	= of_match_ptr(macb_dt_ids),
 		.pm	= &macb_pm_ops,
 	},
+	.shutdown	= macb_shutdown,
 };
 
 module_platform_driver(macb_driver);
-- 
2.34.1


