Return-Path: <netdev+bounces-82283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1652E88D0B2
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358351C39CD4
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C57713DDBF;
	Tue, 26 Mar 2024 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Avdty/rg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687C613DDAF
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491699; cv=fail; b=hbZBPNyaPh7H351w3nTO5dcbNTPiruLcH+j5WoJTRcxuOaQlK+ZyRRJ7mR6oLnghdui88ZwI/G7HpO4CmFVCS80a/5V2e2vYR5LbaQfkUf9IV9stAOatOGnMOgpMgsSS5PAyuC8bDzjnxwhLtJ2zHAq/F6mbrl+JwpVuhwZDeOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491699; c=relaxed/simple;
	bh=HsWzzG2rIAK46x8zXfIhfNPsYEB6i/fwOAp5VuhXNlI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZ9Zmkp31YtlKPivzraaEBqKP1Ta/s5fukrQ7GzJ9b+8GbPbEsz66sfo7MN8CIhnXvmXUQ9Nu2T4Zp+cjvC7k2NRfr8RJuLKAcyGiuc0Q7AFLe3lPpr5Ckb3HCEZcMqYI4gui96hEPBtOBcy04h6U+V8dmpLp9Q2k5C9hAEQaIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Avdty/rg; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJCJUt2ra+rRQtrqwIZOTp+1aW4pqSlLb4Xg1T6CWFvoCuOffCvalcf0/EevZQCil5N6p0ZOVsy2081B6IDxJoY2iFBxkO8IS4L1srashVHQaRSYzr9pb9E2BcSYmJQmhPR9OZI6ek90K1dZRWDl/LQ8yyJRZ+6itGXTlYTbHiunmNqrqjWWfYOy6GI7Qls5/52kQd9lYIu5XaIgwroWTlg4brHgY6sNEewmSGwGRYOf4HpJUATwJ9QA3o85yATUXh6h6+VPtEGatZ/wMnz9u/CtsMxz5EEFqysCVv0MMgwdVQKVtME+oBB7bd9fJzAnDmW0wgjCCkOdqS8TGd2NaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHAqoQwliGMHaj7+WkORCXGafKBD7KmLG7ssEGyPNdQ=;
 b=gHRK3z0OqZvdTcMNcmD6vELjNt6l2cOx11SYS/Mc/o8Io4S9jxznJutmbmj4IVzm9oVtSkdTjxqeb0eQ8AnIH3h3g6uDt7QBvihkry9wlrNpM3TuCWTmYJiPJsUyfL3zmOOTCgr+3uMjJIGLLtNeK/RcZPsn11Oc0cUSxMTjvQVirHFT47zI7I8dVC+nuT6X8wUWOYApdGRx0N+/Fzdh9YP1BrpaSXHHvkd8BARSRP7tnIP9XLXUJxVp7+4ITkcQSFXK5qOP5GTj40tkC2lPpDlIZX7z4fhByTAXcqKCga4iB1BIFkqnpGdruylM03hCUAQLDjx4QNjYg08CbxXguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHAqoQwliGMHaj7+WkORCXGafKBD7KmLG7ssEGyPNdQ=;
 b=Avdty/rgfbBB3/f5sd+ctsi9S7BO4qtJkulsKqysFxAqxB10gbjQa4kiMGfckKUckmFYZFmP2y12Igl7K9mwLPV4NjNep7433i/gkRNL8oWZaZkH5LeKBKK2zGUUcvYbSpvP9EoVI3xddUQRiNG/VK6o3bRjyQ0zUx9nLw7oZ3dzuKdLpVtG1mt9Wg16LAsqa8QjR+DibwRk0/XFdndAbkCuV+3J48uazcHBrl+0CQPRyzCnXykNsbOsgKzsvj3B9szFg3AFXjoCjk+qgAGx5AVsQMoAefZXvfHVYEFdRkG8TmOlIBke+hq3ONfQpSmEvsiq4YxwQLkFRtYGeUkUZA==
Received: from CH0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:610:32::14)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 22:21:30 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::98) by CH0PR07CA0009.outlook.office365.com
 (2603:10b6:610:32::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 22:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 22:21:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 15:21:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 26 Mar 2024 15:21:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 26 Mar 2024 15:21:14 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 6/8] net/mlx5e: debugfs, Add reset option for command interface stats
Date: Wed, 27 Mar 2024 00:20:20 +0200
Message-ID: <20240326222022.27926-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326222022.27926-1-tariqt@nvidia.com>
References: <20240326222022.27926-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b890d94-989e-4360-e7c9-08dc4de31612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zf3Qhz6age1ble+vB8OvAqQF20SH2u+6ilazXFoiYSYe5bfK6IzsE5AswgkoKkHOy4PV2jT+kqfneC7/SxjFAEwyV22cQ7kiJk4gRbYu3M2QTD4m/bdmBfOVQGZNboKZOcrScXBLQ0UdgUWOM861mfpIS0MvS3i989mFJQbqMyWz7hQpzCeYY1kdPZmbPO3If/JrkSaIqbvb3H/XV+jhdigPz97G9+YFpIJ6Dw86UCJYHZQ9lrcc61KhoszK8pU5ko47Qq0aTOIjfcLkFMjreyWRIEwWwQklUko6swc/jo1fuLcql7+TsggZNq7ORuoZorLxpz9MJWtZJcIa1r8B2SHl3h11hR9CPTckP5vUVh//wl4K4AaEAeA3jHrLbj3/yduL0sCyetN2xzoiPieRdaeYxIuQhPnOc4OUgnN21z85kp89J2Qy74ynPRcF3wNzOImPrEUl3Eyz+GvDG78GEZX50RlJAHcAfD7kc+EJteIhUSWU1eJ9mh0qrfeYJV9CjxdS8G541q23Idd1uGKmIBs/PodOmPg1zi0w5SstubI2ZT4zfyYiVUP63P4MrvG3axhw/cAsFP4CtwHWQInn5KdqkneNvdhGYnyJsPJWN6+j4vVg0cGvZnMuk3NLK/nyEAD8TpDnh+wnqvnbNtCu/Je9vFIM8VJEu4rqyrCbQw+KDXKr3rUw8p2Rplma3VxnTpD2aaSi735+B6SLYnMcqhVQwcksFDWInwrYFESqInmVWYxned4eTsJiCoLzQG86
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 22:21:30.1301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b890d94-989e-4360-e7c9-08dc4de31612
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458

Resetting stats just before some test/debug case allows us to eliminate
out the impact of previous commands. Useful in particular for the
average latency calculation.

The average_write() callback was unreachable, as "average" is a
read-only file. Extend, rename,  and use it for a newly exposed
write-only "reset" file.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/debugfs.c | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
index 09652dc89115..36806e813c33 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
@@ -143,8 +143,8 @@ static ssize_t average_read(struct file *filp, char __user *buf, size_t count,
 	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
 }
 
-static ssize_t average_write(struct file *filp, const char __user *buf,
-			     size_t count, loff_t *pos)
+static ssize_t reset_write(struct file *filp, const char __user *buf,
+			   size_t count, loff_t *pos)
 {
 	struct mlx5_cmd_stats *stats;
 
@@ -152,6 +152,11 @@ static ssize_t average_write(struct file *filp, const char __user *buf,
 	spin_lock_irq(&stats->lock);
 	stats->sum = 0;
 	stats->n = 0;
+	stats->failed = 0;
+	stats->failed_mbox_status = 0;
+	stats->last_failed_errno = 0;
+	stats->last_failed_mbox_status = 0;
+	stats->last_failed_syndrome = 0;
 	spin_unlock_irq(&stats->lock);
 
 	*pos += count;
@@ -159,11 +164,16 @@ static ssize_t average_write(struct file *filp, const char __user *buf,
 	return count;
 }
 
-static const struct file_operations stats_fops = {
+static const struct file_operations reset_fops = {
+	.owner	= THIS_MODULE,
+	.open	= simple_open,
+	.write	= reset_write,
+};
+
+static const struct file_operations average_fops = {
 	.owner	= THIS_MODULE,
 	.open	= simple_open,
 	.read	= average_read,
-	.write	= average_write,
 };
 
 static ssize_t slots_read(struct file *filp, char __user *buf, size_t count,
@@ -228,8 +238,10 @@ void mlx5_cmdif_debugfs_init(struct mlx5_core_dev *dev)
 				continue;
 			stats->root = debugfs_create_dir(namep, *cmd);
 
+			debugfs_create_file("reset", 0200, stats->root, stats,
+					    &reset_fops);
 			debugfs_create_file("average", 0400, stats->root, stats,
-					    &stats_fops);
+					    &average_fops);
 			debugfs_create_u64("n", 0400, stats->root, &stats->n);
 			debugfs_create_u64("failed", 0400, stats->root, &stats->failed);
 			debugfs_create_u64("failed_mbox_status", 0400, stats->root,
-- 
2.31.1


