Return-Path: <netdev+bounces-249888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B999DD20387
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D23C130249EB
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A5A3A4AC3;
	Wed, 14 Jan 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZJvmLA0V"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6C3A4AC7
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408277; cv=fail; b=fqkiXxcnbPKEZjMBYABDOmKIGlAsG26uAqZAtEaJkuvuMsPZ9oOL0XN85CtGrK+662cD0LWwZ0pM184JOsDFblrfNJlU+4qIBpy6WhBvY+6VIEh4068W18RWEEit/ErO36Le6r+ugxuyN/nqsk0cdMc3xrBVD+OtMDnt67kPKWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408277; c=relaxed/simple;
	bh=G/7fcJTnwpe5KlgkSbY+ZZ829e2e3ebomrkqMy8E3s0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ijSXGfC2ilKwKIJ/ZKxYWb2EyZRfDtGl5E+sWjg7s1bYHoaqwJzPw5T83FzORna28CbB5uuqdwmuH+2mNQ96jejX1o53i+ln2d1Nv7a2CZOVcOMDdppqTemVNIkynaJpIhz84E33TMCobZATfoa2ri0EFtInhue020f1VUB5PE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZJvmLA0V; arc=fail smtp.client-ip=52.101.56.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMxraJtXWpognT5e1s5f4XJ4hf0u5YtFEJ7jM4VCD7rtTgEEQHTGfAlK5+yYCd+0iAq1A4d5ZfpF4blXEstEbM2A44/e5+ppDpsmYwE64g5sjdGaNR9o6jTPvWJF/kGB24cNj+KKzrSKo89mSkXjmebnDzro7h8mrmsphz/Li8RaUqAgmiMA8faGrDmGN+NR6+CqfOfq3LFB/I1xdQZ4hlmFE20CrwmXg5DW9cdyuZQtVm/PUu6pBKGB1Fk9utGJuNVxOildm9k392OpHHL3nBtckdKjppHhFBO4dMyutcDZZ2mZ3ao6IQPSkzQ36aub3ONomW52Ab6VkdAegMy9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiY5RYJy4+G6+tkU9jq0cZDe9OVvlmJ7oTywfGKl/l0=;
 b=Bvvfyx6TGuRHpEyihE7z6/xIjc+VFAef0HT9DY5Mfb/z6+Lc2XFNEESe9ZeGZv7GcbehPCIrWSpSPCOKI1G+MfovwCRHL1TjFMDqQYeFZ0pC0i/aqm5UMLtwZturmW3tbXQGRDV9HD2A68GXHVaBhajRJ/GodxOauHp/l6mzeekrATONk+FFmA9tRnr4iOXc8+F05IwXakl5tV0+hk6EXomwIRwJwzV9OK/NWpltNSUeSrKAKQNGjutsB5kRKv9ezfZyAdAMriCONsv2NaXJYueOjgCM5+Bg7ELM1g0CjH/G5xdBbAhHuXLwTxCzBwHWonGFjGSv6sXmTyWXFUW/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiY5RYJy4+G6+tkU9jq0cZDe9OVvlmJ7oTywfGKl/l0=;
 b=ZJvmLA0VjcWsU9VKtGH/iC2c9EpBc+ZO4lc46GfZ2eoxQFBGDk5Xro+SREFfNZNW8E20+aPNYU6yYSYuGhkU5nhi4T+KHZGGHpKHr+WhItQfQihv5vjVQ/RAWpXrIbU2nRMvapYex4/rkcu3bXBdItW7E0nIRoIG+p41/2Xr4RI=
Received: from BYAPR05CA0076.namprd05.prod.outlook.com (2603:10b6:a03:e0::17)
 by CY1PR12MB9651.namprd12.prod.outlook.com (2603:10b6:930:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:31:07 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::ec) by BYAPR05CA0076.outlook.office365.com
 (2603:10b6:a03:e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:31:06 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:31:01 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Thomas.Lendacky@amd.com>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net v2] amd-xgbe: avoid misleading per-packet error log
Date: Wed, 14 Jan 2026 22:00:37 +0530
Message-ID: <20260114163037.2062606-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CY1PR12MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: de3eaa07-5205-4798-cf93-08de538a50ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rt9RHNmdehuszLEcrub/naEtlABKGObePywch0AU2CqiM69uxgmLsaAQcU0K?=
 =?us-ascii?Q?TSpca+/HMhmwyyZR1e8e39LF2aI5dyLwdVeu1T4kfoz1udC45HjSnVwu/0KC?=
 =?us-ascii?Q?6iKgwDKiIzHtOQBpxYFdH3ae62bNZmAe0grSRRW5bARr/kGFR8P4SU0NzyPX?=
 =?us-ascii?Q?hzpyfX+Kp8TB/LfyyrRJEAmmjyzmcwUBmhaQEG2F15HJpwOqctJyEs9mX+HR?=
 =?us-ascii?Q?UOUw4HpwhJPXIINPDNVBTX301kAo9XkPO5+0gpp1M3USulgRuyVq7C7rrbsD?=
 =?us-ascii?Q?G93/we1PBKqGvi39/QyDMWbqSz666rYQaK3n/zUdsfg40C2ZcBaUb/Nx6nfY?=
 =?us-ascii?Q?4bpxG0Kd5iJ6+2Jjgo0enU/PXq6Txyzn04/u4HmoQXr3akdyfeFtdf4LCppM?=
 =?us-ascii?Q?nsCzJFIHhJi8GtqHvuA+89BPswlG9o/2MCnqvHqaTHvL8E8+GKqjFd/Rb1qW?=
 =?us-ascii?Q?EpWKZU9lb3MnfBgRj2wwIcGmmqO9mXnZjRssHW8vvJ1CKxxxjoplqqYbiNRB?=
 =?us-ascii?Q?s7KHE5dVGfbaq+JCkvBgEXpI2e7P6bsn2UdRTOYdJCDbI/OxO1BmVIvIgGjG?=
 =?us-ascii?Q?JrDO38Qx4Xu4MwQpjLxTXCOj6gk121c3Cp/6MuatLkzHfdSPD32ewalWqGdx?=
 =?us-ascii?Q?IAJ/o90M/1iLfjcQmHpi6TS+tgmfdQy0H67/wudHi9c4tKHI8Ur3UkkRi1dT?=
 =?us-ascii?Q?crlnS/T0OJfy8kp269HAQJ7xtLhRlHOphBuSrXaLdj1/f9Qzcs2XuxrQ0hEx?=
 =?us-ascii?Q?FdbFiMK8e6srMYLDKOB8yE+JiRelhzk40nwreMUfbEtUSYWJNwVS7H3PALxy?=
 =?us-ascii?Q?8O1cFsppj6qb4d27apMqdb4AEbm4+UTQfONfV71GppK5job/l/Z4fKGcmHm4?=
 =?us-ascii?Q?+aDs3jSweEFkBGX8f1ZcWh0u1v6srSh7i2uUiQbyHewTET+Q4ARTj8quJ5DH?=
 =?us-ascii?Q?bxnlQnezmp6j28kKV0wSO2RFp+oWELr3uVnjxLmTR7bB812L5751hbV6Cwxp?=
 =?us-ascii?Q?5GWoy2hgLHAmiiG3+pTynLe5XLhS8ytSfzUFE4tUX88lEZPyIYT3RnzzAA1o?=
 =?us-ascii?Q?vNGCewd+NbICQBs6o0WAENocI2hrA8V3PLbbOeewmutppfM5n0c5fty27ZAW?=
 =?us-ascii?Q?OCNRYHCd5Ms4aO1sjclY0zH5udn4lMJzfHA48HOGOxP1YAMLxi/lK6ZAn9b7?=
 =?us-ascii?Q?5F8SMvtz15gqTrljJCmBZbjhrypOhoCSPvZAwdcOtXmN9Tzj6CBHllI+TexE?=
 =?us-ascii?Q?I+OC6ZXiu4EIicDq3HfDB6Vw7X0JnwdGqFEsTUbMYtrkH7PT0eiA5rEugoWV?=
 =?us-ascii?Q?CCDj0FTYHrMUgyB1VwygysqYAB1Fflz6oKKth687sHAqb44d4/oc1Jqg1CK5?=
 =?us-ascii?Q?Pz8lVF4yTn80kIhx//WpNCdA1M2JE3qKO91jwjlG0S0+eTOviQsRA/btGSoi?=
 =?us-ascii?Q?M+Nt5UvK79hg1ElD0ClzpFvHrr/Tf2XfC4KcxEDbeDUECnSb5WYoO52nO0w2?=
 =?us-ascii?Q?4IZEchD0m8tNGdclrguNGAvxV69952GfUhZIBwXld1QXAWIPS7PrEFrRTack?=
 =?us-ascii?Q?4I3soSRe/AJ9KB7L5yaEehzEffdHUmwVj6X80VuhUg4tpI0tAyyUSLYLmmuX?=
 =?us-ascii?Q?fKPydq+UdyLVX7oUECtwT4zDJq74L8saHrOH+gLDxkAmvn9gzakckTBPt8Gi?=
 =?us-ascii?Q?gBqUTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:31:06.0334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de3eaa07-5205-4798-cf93-08de538a50ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651

On the receive path, packet can be damaged because of buffer
overflow in Rx FIFO. Avoid misleading per-packet error log when
packet->errors is set, this can flood the log. Instead, rely on the
standard rtnl_link_stats64 stats.

Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v1:
 - fifo overflow errors are counted as part of standard
   rtnl_link_stats64, so remove them from non-standard stats

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 3ddd896d6987..b5a60a048896 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1837,7 +1837,7 @@ static void xgbe_get_stats64(struct net_device *netdev,
 	s->multicast = pstats->rxmulticastframes_g;
 	s->rx_length_errors = pstats->rxlengtherror;
 	s->rx_crc_errors = pstats->rxcrcerror;
-	s->rx_fifo_errors = pstats->rxfifooverflow;
+	s->rx_over_errors = pstats->rxfifooverflow;
 
 	s->tx_packets = pstats->txframecount_gb;
 	s->tx_bytes = pstats->txoctetcount_gb;
@@ -2292,9 +2292,6 @@ static int xgbe_rx_poll(struct xgbe_channel *channel, int budget)
 			goto read_again;
 
 		if (error || packet->errors) {
-			if (packet->errors)
-				netif_err(pdata, rx_err, netdev,
-					  "error in received packet\n");
 			dev_kfree_skb(skb);
 			goto next_packet;
 		}
-- 
2.34.1


