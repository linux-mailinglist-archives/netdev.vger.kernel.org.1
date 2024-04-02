Return-Path: <netdev+bounces-84028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084AF895570
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EEB1F23D41
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BED880BEE;
	Tue,  2 Apr 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KAlppjcw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8997084A48
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064743; cv=fail; b=BGpRBV459RGLv2BXg9YsbdZRv1r/4TtoBrGgIUF4F8a76yev3cxDT+pb6rprYUaxjzEMAKHJ3gQ6+wdXk8EVINb2wmxoQ6rjUzb5ccDogq1R7KVII8WorooUTJP1I2DK9zWbIgw7ruxt8+UsQoSh8wZ2bsK9jAAMF6AVGwTPcN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064743; c=relaxed/simple;
	bh=qbov8sK5fu5GYsN+rs5sOr4T8g/v4OVIlK09/RgmQXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4bmp1Rb42f51h0tfDyfk3ns3xai/3dOJYpwNDWcz351QdfbZnugAMa914S+Z5pJ2zCYWgrwHFB2P/cBC9Jed6ipxHphPoPBoKCiR3X30WEFJv6Irmf319qJ713gQOkhJk9+fc0COYt4YtkVkKmnslGZiCA3ywdyZXnkb4dPm2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KAlppjcw; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFi/bKaxPLsE6giTNcaAWkq7HnxZQHOwoSMUon7ID6wj4jm+NRT3PWMlXlhX8Y5CL/XrXjv/GuEpc7l+XlHIcd0+1mYnBz+35Nr4lzvIyivn3jNEpn65mCN750hNG2MZYe1npX59CEw4sL9HzVD4G61RQ+2HWYXZeQjRtjY6JaatVrucNa771PAtQuPh+YVArvjdg2e1d/PoV86pQoEIhv4cknBd3PfZE/nP47CdCiSQ3YTLEvtjZKqwLDTiEhz5hrNPhW+qfAYR57t0vA6BnhEeMA7zuBucABSECqKSt3mnTuwjisc17mYwpENW77/SgW3Ts+74548OkGmwVXtC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3Cj99P0H5PszaD3niKnPrDLC/qZNcmm5+sYhzHirDs=;
 b=fKRuVpsMczawuIN+KXDAoMcrUvivvmDBQnVFzXduvO0cXrxeynzdyavxKQ7dfSHDe7iZAWYVTbq30MCEsYEVCKRdzZd9ureDlKPWHjdM0XnBT5ZXZ7r9QDKGDsc3rnnRIvzOCCgSuEK1sHcZq7HqgWQ953yPfordmyDKmVpxdAT4enXiJ7My/cNp4AFPyPTCsUtDI1hGwaNzu9Q2M5C3iWP277lnt0RISIK+MANQXoNr1rhESrqj0U8rU5FoAUFvNBF2V4Y8m2rWwkYT6oPnnvoIi3H69AdaR7YYdtKNKZzmrSM6LTW0FQAm5WW2KeRYUFALX6VAQEVzRKpoM7fkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3Cj99P0H5PszaD3niKnPrDLC/qZNcmm5+sYhzHirDs=;
 b=KAlppjcwl7ZHa2qvJpwCGz6TJFNdeyaPO791UhxlSvb81O0rna10KcNXpDp5kkAQLN/+8QqFcn5hH9vXhx8p1Qt3y+cqDT0EIFtQtYSSrnrusQjzJvcUr3QU9hJfTngOAiW5MlH/N3KjfN5jKJ7tqmO1xkNvHDn7zn5cskk0ij/8upn80zleyUQsH+VIwAGVxRo+ngmJaWUVkXupJUIm5fDRFHBgRrrJ6DHiZ2TEpPt/KUucK7POup7BSadRLqqjRj7tKlMHgt3VizPUh3X9BwVPwNY4U1Qcv2Y3XkovTl7kjGpl26uT8UDsCdQ+uIHFHYpfEAgRdgn/Sl5WeEPhXw==
Received: from CH2PR15CA0014.namprd15.prod.outlook.com (2603:10b6:610:51::24)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:32:17 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::a) by CH2PR15CA0014.outlook.office365.com
 (2603:10b6:610:51::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:32:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:31:52 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:31:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 2 Apr
 2024 06:31:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 05/11] net/mlx5e: debugfs, Add reset option for command interface stats
Date: Tue, 2 Apr 2024 16:30:37 +0300
Message-ID: <20240402133043.56322-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402133043.56322-1-tariqt@nvidia.com>
References: <20240402133043.56322-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 064c30ad-d234-440c-1059-08dc53195048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ahN2Trygv8r2umZt3p9ijB00Qbe0EEHzOO7D6L0m7Tu3+AsAn0L9OS5O1ko/D4/edbHl+ToRsXhR9xWNF3kupz4aYSpWggOcxdIj0HcMJf5W6xuykvobE/1MNfADgq4qiWDGyOPvIdjkfWDtR1N2DpdjcJlYvbKS7JdcalB9UfVrNgnxCtQ6rtgXT+LDrg48jKSbfSzGiu5rk+jkshx5cCvaa75iYMdwKnEPnenyz64Z57dUebg3b4TXpRv13x8SHs/L6yCklvCI4NfUvfaBVPvI2Hm3FHGkCMbYGzpQ44aV5ZEEPznfm7SP14nS14oV8AV9cFKRJo0Uz7iLtnap0cSpAeNb5BZaCI0mkhL9vuOKJmnSbD5D3J/IQSYLRNNzH2ESZ6WnjpcJ5gLd4gkFDlc+zrwgkcufhP3dsw67gz5VEFKeUmWCWegjWApA2hZRKG9pOZcO945t5XbwGSy0cAZSZFJYPFSaTWEzsXFdydqWTMNo+BovMWtMRvZQr+AnwikIryuMzBMOrepz4GXtlogCzbw3SbNqyXaPV+3aDvnNieZWgD80RtPVyrKa5roYfvg1IisAhDFymf4Xdg6KxoJSExRscVysDbkbT2J+e0yosfNohxfovdJI15Ec1rU0x32rRzpMlpnOb3pejJpc5w/NslH/uSXBuFo+NKg+b7xOsDnDf2fuS4MuHNiIxscN4VhQwqGHGnr26WHd1GKFdhAYESQ4Ba/LNooCc90X/kHiJkVCu8PfTuVI5j+fKU3d
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:32:16.4393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 064c30ad-d234-440c-1059-08dc53195048
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855

Resetting stats just before some test/debug case allows us to eliminate
out the impact of previous commands. Useful in particular for the
average latency calculation.

The average_write() callback was unreachable, as "average" is a
read-only file. Extend, rename,  and use it for a newly exposed
write-only "reset" file.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


