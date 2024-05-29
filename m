Return-Path: <netdev+bounces-98830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4D38D293B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A98F1C2403D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAED33D1;
	Wed, 29 May 2024 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ocnm2PHj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DC93232
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941020; cv=fail; b=flmK0vBiQAY4A8FAv3torRzYjOGbtczt7h+jTp5GjFKOI2lFJjes2k3AZRZUTeBgs7Ebmeq5kh4TcQuNueE76pNX9ZqiGQqEZ4QHoA0jCl4zEeP58Bezxo9xBZxX6V2lgQ2SZg5jGgjitROOo4HWPFdY0x4xqfnGUXF8EHev4mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941020; c=relaxed/simple;
	bh=IkD0opelpeJCc6EHQX/PVenogqUgm/CdR/eX5s+TO8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6RjoR8KHhBbhjnjk+rRo0IZU0w/O5U1NmqucyBxh6wXBvERFCIDovMcFDugvLbXwgot0i9vLljQ6RMDY4BAph65xHCzdl1kPYZavN+Q6EPKpf5M5WtUl/Z59D+lVY/peh2+rphRTZ6oErRQZ2jnapMJwwmwRlEiZMgI52nux9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ocnm2PHj; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=III6bHWZp5JP6FbH9mTouuNh1kdGvR8sLgaj7+ClR6XUoMTo9Ua/FWB2RqRUh0qD499jK4bl7QssEQfIBZ3vmeQX4KCgjz9QIZG26SOHrOxraw0Ax7OHRG1hNNrSTj/lxMOiaW3RUu/D/Xj9J+bzSP8c1yoq0XoQKxTYaGHB2V7ToHlekbhlP+SeD2rQ/WHsN62fBYEbQ4VtN5x8zWtxT1pWV2gSbO1L374JlWN3TW2UrszzDp2mL2emq0V87QhGrdk5aPSgIc+6FdK6+otyHun3j1uIXMqvkuZAvzKmIXOf8yLR8s2PKDsDQ3pH2z2CoNM7iq1pPK0fHgR8o0Og8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV7QcSZ+rqRkpv0aCROezu8S79Li6hhlQYcl6L38GU0=;
 b=N7s+Cg+AK+bl29HqKagg4bIsTAzr3/5l0wt1A4gAddgRdO/Y0NgxUy73bXckoAT5/3TU8JXgrim71piWJuAXRjn6eRHHaKs9GlDpdvGPjqlkWQDdlQBUFeCjnIUMblT/v8ADrufISg1bBXmLOLnz+FeTa2Cd8U4HwWjVCXGZbRPar60CGEwTRrDhxIZWHYAGt5IGn8q7r5wfh887J6tQz5GCqlok8S8WMcB6SkkQLzVDkmXBuViPLbrMLEP9SrJSRgJuOm+dnIUfwfPnc3g/3tPUSEWr8Zc4ajdJpqDY3eUGZsppGcsPMyBaVVu+ENtXWgmE1EtUXLVq3J6cjC21Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV7QcSZ+rqRkpv0aCROezu8S79Li6hhlQYcl6L38GU0=;
 b=Ocnm2PHj+27znCB223JUOmi/sIvC+m8vEcjgquccnhplzEqYVZSFF3h3Xs6AKkGkj0OtRUohI5slBhJb4s4Gw67+AHWj3XVXBnshH9DKiZHqQKAUFZggV21AtBJZ2n8e8N+Av3nFGpj9ROcYjRknGIHsLzLo4W9or6JStzyb/M8=
Received: from MW4PR04CA0347.namprd04.prod.outlook.com (2603:10b6:303:8a::22)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:b7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Wed, 29 May 2024 00:03:36 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::94) by MW4PR04CA0347.outlook.office365.com
 (2603:10b6:303:8a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 00:03:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 00:03:36 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 19:03:30 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next v2 5/7] ionic: Use netdev_name() function instead of netdev->name
Date: Tue, 28 May 2024 17:02:57 -0700
Message-ID: <20240529000259.25775-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240529000259.25775-1-shannon.nelson@amd.com>
References: <20240529000259.25775-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DM4PR12MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 063ac2b2-8f50-40a9-c8a4-08dc7f72c96d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2v5zeKqRDiuNGWeTZawRAhihSO/ean7WaQuBmocfgNp3IEZTwn0FmCr0Inyi?=
 =?us-ascii?Q?cdF3Ww+dFrdizjuK0exUbA3RjSo8Ogk9647plmdXRVwp6IGKMe7Nhxd4oZ8F?=
 =?us-ascii?Q?q0O2ONvnY7xb7/VMZlKZSvNfovhKIWoRU6Zel34F9CdC9MJpF/sw/IHfF16Q?=
 =?us-ascii?Q?P2ePVcyZyGtJbrzr4ZHxV600tmKL6/uMN75jREJW0TKiWKnbRC0h2eFRzxIe?=
 =?us-ascii?Q?EhufqmeQOnOkbrC0WDMAkDUBoj9JLxcXtnRaEMvvpJN2BPi5Eg8vvTAAt7+2?=
 =?us-ascii?Q?DhFdivpTvzXFpl5ehCedXKSkKRUgWBbp7P+fTnnyjbZzFmXZCWl+VNXVqKC8?=
 =?us-ascii?Q?MWrDWsmCYP9+hDIBhKD9GjqSW3QpN7aDE8hDATox1r6aM+UkLq+zMQkvQ72J?=
 =?us-ascii?Q?kh/KAha70BCGsz5HzyiWkEGj010A9hAgXk3apHzPPmTlI0qCYmydj5YflpLF?=
 =?us-ascii?Q?DolmTjU7D5Yfk3B+67tKdLqWbsJJqaSjR7N3be1aLRXxrqacwp7KnVYb4A7u?=
 =?us-ascii?Q?UPEnVALn+WrqwbpDfhtikR3Thwkc4zpWeCc7t3Nb1kY/swHcACdm0nYcHUpP?=
 =?us-ascii?Q?tULPLKUmTv5tKOMy1eoOIbz0iB877kn9XBkv6hyHI3H5ab88z35oV/cNDHL4?=
 =?us-ascii?Q?4vgu4WBzhbvWELQv+anHe7oojkysZOzp8YYBeHRdhiDAANxZdzRNgkQmYlfm?=
 =?us-ascii?Q?t++Z/RCjQ5LOCuzH6w+1eqb6OGcHNG0l3mWQpcvYKzU3AKAQfoq9Rjnnqj5e?=
 =?us-ascii?Q?mFEMoxyTOoD1OkB15a6BoaKxjkAKBk4uLMeLi2FXSSFAXuuFjlb5E3bd9now?=
 =?us-ascii?Q?QkYawx+1ZRCE5L8SqFcEAc/8mOvwrEG5uVzWuPXOfRo1IblbKPO0YYHBT/wP?=
 =?us-ascii?Q?eaKw70tpzYxPE5WPgAn6GYbikMJ83g07isMm0cxq9Sq2UAqrE0AYdTK5oQiR?=
 =?us-ascii?Q?ED6k2XVDl2osQPGblPuQRDXAR4KnbQmZQWwgDtA56cCUt8mT1qPjnVZWPw/1?=
 =?us-ascii?Q?IWu/OVDlBYEGcd1AQrliHwzaUR4a/91eWCvWZezeAl5yvdBJbFbjAXaf2qdf?=
 =?us-ascii?Q?y/PMMfsnomUuWmwVdVmwZF+I5AzRMRdH6as4ck3Suyu4qRlcgSIQypaQo1Fi?=
 =?us-ascii?Q?PHxk2JaAajuf5Rc+2X+Lsh3RXBE39b/0M2aGSGpprUTcwAYxlcbj7p7Zx+lk?=
 =?us-ascii?Q?xDjBqKRgG6kW2gIiZ49aPhG267cdVxDcgAs/D2MJ6Tg0DRWuQqwnDy3ZNUvJ?=
 =?us-ascii?Q?XXyG6vH1S8C67F9wwfM4CSDvARJ710ddBAdmcTCF5vZuG6PDGNVL9isP+X7H?=
 =?us-ascii?Q?gd5vMNlEeOIDFckhtdJIHpVRVl3/7j+iEj0YCnY9PtVcQnj2b/zqizYCsItc?=
 =?us-ascii?Q?nXxNCcM0Zbb/LBOGl/hRPbt76DfO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 00:03:36.0932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 063ac2b2-8f50-40a9-c8a4-08dc7f72c96d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661

From: Brett Creeley <brett.creeley@amd.com>

There is no reason not to use netdev_name() in these places, so do just
as the title states.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_debugfs.c | 2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
index c3ae11a48024..59e5a9f21105 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
@@ -220,7 +220,7 @@ static int netdev_show(struct seq_file *seq, void *v)
 {
 	struct net_device *netdev = seq->private;
 
-	seq_printf(seq, "%s\n", netdev->name);
+	seq_printf(seq, "%s\n", netdev_name(netdev));
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 101cbc088853..23e1f6638b38 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -237,7 +237,7 @@ static int ionic_request_irq(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	const char *name;
 
 	if (lif->registered)
-		name = lif->netdev->name;
+		name = netdev_name(lif->netdev);
 	else
 		name = dev_name(dev);
 
@@ -3732,7 +3732,7 @@ static void ionic_lif_set_netdev_info(struct ionic_lif *lif)
 		},
 	};
 
-	strscpy(ctx.cmd.lif_setattr.name, lif->netdev->name,
+	strscpy(ctx.cmd.lif_setattr.name, netdev_name(lif->netdev),
 		sizeof(ctx.cmd.lif_setattr.name));
 
 	ionic_adminq_post_wait(lif, &ctx);
-- 
2.17.1


