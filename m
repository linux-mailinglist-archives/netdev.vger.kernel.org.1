Return-Path: <netdev+bounces-234313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02704C1F36F
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D97B64E8049
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5A7341AC1;
	Thu, 30 Oct 2025 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sAJxCfGC"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431FA341678
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815669; cv=fail; b=TSOoy7IVpoNoLv+cEC53dORYVo+MGckD/g1Z0ow3aVfVitHCz0ZGbzrhuasFT+tp6JbkwigjezpF59lqfjYJ6tq2xviQeFrND/2KHAElXFTknesYOomrftaYNTSK/RlxlA5RoIrbcbPXr6M5ai/AsOVDGxbvePHbhZbprooxpv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815669; c=relaxed/simple;
	bh=abDbk1jpPjs5ZTtqSeUsDznc/0GK/eIbL8bc6Zt4gOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4hIncZb4tFLFw2LAI+giZP+hfK2/Y0Td8JoCDcOHKPkTbinbCAhQ2rKMyTzQdmScL1SvZ/9eKQOxdIy1H2AzQt4HKM7GyzLzBQuEYqS7+wu1ZcsqPQQxqW8GiRFxug9VhrAFYf8epkXyuyRs+ayHmwh/dWJLfShO/5Ms4+E8k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sAJxCfGC; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hy6P4r2eqqYqD4YNJUM3S49ZMvcmtw5C9bpAWciZe7WyAxMGQMfNODSN/x1ON4GUBuNpVvfQw2nu3nIzDlqxDS+UOcP4Wwj/fN8HWyRcfihelgBaA7vx06IVFanjqlSz1nOjxItlrp/mClN4EdZt0ifBZVyUOvtPXXWgZ3GUHhxlIVbzJ5EFVtyzE4Qt1GIwCjGZlOKRX4lBB/1Crh8ZBQ8RhX084mjh7u07M47wmd4vxK8j5LxZYjCEz18zdJ5rKkxuv43qMjikobpU8+lzu5Hk1nhYSdVlv4SiTWMJR8b3NTQl0iPJIr8920pJJHe3tizzmabOggqFfKq5SkYayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fps6GMxyvBk3YdviazYoEK7taTCNB21SgUnrPA9fXGk=;
 b=QOLV8l68WdRuZelgvH3bN5HNxloE/slNz2xGe6GPHWcvtfawmjR3Xiy56H2/GR38JSsYCH8/tSJlHTjkTfs4z6zoABf6YAqoKcUgvFENgHBaAw3AcwnavOmG8RKo4ZPsjd6seQZG/BVW41iK4/iNl3mf/kX7GLp0eS6NrgWVlopC25R1QY+f/q+6aNQ0heuQi1xmIF7eJ7xIMPHUPCD31TnAVgWnqzFdvCmE/ZpWSnARCZjfmL/QnRupMJVQpc8Zj2yc6Vgi9qle/kL4asasRfZg6M1zTHeQOi9NdwMZAtLlb8/rPmJtNlzwE+Arf5muYccy4oSmBZnIlcAAMvBcVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fps6GMxyvBk3YdviazYoEK7taTCNB21SgUnrPA9fXGk=;
 b=sAJxCfGCDAYsCa6A50AfgQyUIY6CxB5BMZc7N4DS3iIJJLBixX/sOW4KLvzPCFnwZvesgyYaxn3xIKbx3DHnsYqTRTJRLeWc6l8Dx17gB1lBn47JIFTAb7uKauznqi4zpGgKUTppT3c+5Gd73ErE4vo68DuMdEsUBEaH+JYeLyo=
Received: from MN2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:208:1a0::32)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 09:14:25 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::72) by MN2PR07CA0022.outlook.office365.com
 (2603:10b6:208:1a0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Thu,
 30 Oct 2025 09:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 09:14:25 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 02:14:22 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH RESEND net-next v5 5/5] amd-xgbe: add ethtool jumbo frame selftest
Date: Thu, 30 Oct 2025 14:43:38 +0530
Message-ID: <20251030091336.3496880-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030091336.3496880-1-Raju.Rangoju@amd.com>
References: <20251030091336.3496880-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b5a97d-ab7f-40ce-b480-08de1794b8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4V2Qnh64xZLk3U/17XiXdQa4A3NxX7WoGQ+6S84epTl7lb0WmOJtrTzid2gb?=
 =?us-ascii?Q?xYsMEpIyELsaUDlkxEsp5dd59GVNOIiIXLJPilZwSNeVMozUAFjA2a2nWBcS?=
 =?us-ascii?Q?Jmet4WaOqSrAxADKvQKBPZXn169xcvbx5gr9gwmKvMcQywOe8JBW0WPQq86j?=
 =?us-ascii?Q?xWB5vew+UdR/SSgcZ3tWxB75kblh8C0zHMmDlZvEDuihkwx1tT5GvpfRR1vm?=
 =?us-ascii?Q?OPc2EetdZInzepjmxC2SDoVfG7PDjZjedFa+AKKg7zG3DeseMB+Tv7+PxDvf?=
 =?us-ascii?Q?ZKcd0HCwklWjHraKVW5LRKvwHGNHi8GWmzfcDAUuhVFGrdYjP9zVM4esYRXT?=
 =?us-ascii?Q?X6aHOQC4EfUPS0Zju4MdpjrP8G6Yjbl003qKVwobnpb1xotK1ad0fC0W3D/V?=
 =?us-ascii?Q?MFHx8ggDCnyXMQbOvSyPqlscXhVoqToD3V1IMfRq9jOkqBHFtTyvYTdgEgfK?=
 =?us-ascii?Q?2zFPpUcvgIASvEz2wkuI+i84/rw3tVJT19cjuCGcfviSGeqRwhCm5kKg3txN?=
 =?us-ascii?Q?tkHD19GEn/wIC1tm8Vam6qkWS0gF2lxswmHgleuYe/3WFx/VkHyoUhvA+qZT?=
 =?us-ascii?Q?3gVNaozvcBtEluQsREYbL8bTp861mvJJPKU3DWyt0j94C84EiUzZU5VrejtG?=
 =?us-ascii?Q?HVZz3n8ATracMyTx3l4At9dO4gMuJObGK3WR4xZ0ypcMT0ULXqjx5amWgBuJ?=
 =?us-ascii?Q?BLUmxR+tYduIckFIUohuHW1wgSPhXXEd0fk7YMv2cuCeUzxMRmlrCBPV3OZD?=
 =?us-ascii?Q?4U6tV98kI/aQkE5nWlGnB/O9PGcaRuMGSF1eXSzwrYcxZZIIjSRMo8cSCu95?=
 =?us-ascii?Q?0H3X1LhoN+Pcr/d85mCkB6Jnm9BQ34DwfNlHO8tAAscJu0CIudB7c/MiI/gd?=
 =?us-ascii?Q?g1c6oYV2eJDjmuoVgwrtrEnaWrbiBISRKbQg+lItMnyESpLZufodFniLXyA6?=
 =?us-ascii?Q?bTvlNJAjjWP2f91Tyg4AtICcv1cIXYQGimOERQjXCgPV7kNQZO84O3qAxuC2?=
 =?us-ascii?Q?vgiRn8YBhj/1kx4LINFZCK14q51FIKXc2hEOjN+L5DP1ZncOTbdELViw+n29?=
 =?us-ascii?Q?a6cKxaG/BR7oOyBLkcBSthvoMERyMwMYiTwvONK5BgS9mY1rmYh8x/HqMxmR?=
 =?us-ascii?Q?DCbbWDcxKEU5ccnz4DMn3PUgsm45r1NtwaAxGzfeJSemOwSW1crjbUUdh42o?=
 =?us-ascii?Q?2pI0WE2NGfIWK3QpUpswbjM4zPmlZOdt3CnjF8LkviJimCKWIbXytdgvEm+S?=
 =?us-ascii?Q?lEi//STikjhykXsraM/6WiJuxKY1kSwOuc5T0yfNFGdikCn9eJRoYCkpMgBJ?=
 =?us-ascii?Q?1Mi6zKcML+T+aDDkcjl46a0tfg4krmul2SEyDZvKk8paQ3Y3SSEAZMBr3Kp8?=
 =?us-ascii?Q?dlpxYZVTFYEWjaTS+ntBwDDB7kiKhkgT6M9xiR5mpG1bPWh6cAGNHkO7uxMo?=
 =?us-ascii?Q?qpQSmR5gtZi+ksl2e4Dzmc/0Er9wrL1S9MwMCQdSdVLgV4pTEhGZlE2nQdMs?=
 =?us-ascii?Q?gBaks08pTO6vxpyJNUS3WiCPs8z+2XtZnwEV/Q2wHnM09Wk6nuvrPX1IfcW6?=
 =?us-ascii?Q?o3MH9M/Qki9mU0q8ilk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:14:25.3027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b5a97d-ab7f-40ce-b480-08de1794b8a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362

Adds support for jumbo frame selftest. Works only for
mtu size greater than 1500.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v4:
 - remove double semicolon

 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 1a86375201cd..2f39971547f2 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -42,11 +42,19 @@ static int xgbe_test_loopback_validate(struct sk_buff *skb,
 	struct iphdr *ih;
 	struct tcphdr *th;
 	struct udphdr *uh;
+	int eat;
 
 	skb = skb_unshare(skb, GFP_ATOMIC);
 	if (!skb)
 		goto out;
 
+	eat = (skb->tail + skb->data_len) - skb->end;
+	if (eat > 0 && skb_shared(skb)) {
+		skb = skb_share_check(skb, GFP_ATOMIC);
+		if (!skb)
+			goto out;
+	}
+
 	if (skb_linearize(skb))
 		goto out;
 
@@ -215,6 +223,17 @@ static int xgbe_test_sph(struct xgbe_prv_data *pdata)
 	return 0;
 }
 
+static int xgbe_test_jumbo(struct xgbe_prv_data *pdata)
+{
+	struct net_packet_attrs attr = {};
+	int size = pdata->rx_buf_size;
+
+	attr.dst = pdata->netdev->dev_addr;
+	attr.max_size = size - ETH_FCS_LEN;
+
+	return __xgbe_test_loopback(pdata, &attr);
+}
+
 static const struct xgbe_test xgbe_selftests[] = {
 	{
 		.name = "MAC Loopback   ",
@@ -228,6 +247,10 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "Split Header   ",
 		.lb = XGBE_LOOPBACK_PHY,
 		.fn = xgbe_test_sph,
+	}, {
+		.name = "Jumbo Frame    ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_jumbo,
 	},
 };
 
-- 
2.34.1


