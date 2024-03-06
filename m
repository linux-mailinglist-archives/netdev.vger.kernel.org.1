Return-Path: <netdev+bounces-78177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2918743EF
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65794B23E0A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E142D22F17;
	Wed,  6 Mar 2024 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kznDdVi6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A6521106
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767829; cv=fail; b=M1QpjIo7O74kAc2/mNH+Mpml6Ye+FOoAgrRsyd9XIjmlPXfW3LtquZVKMOeOgWSejNNT4GZ0+jQmd+ZHDFYLHPsMmHIxXD6i8d9VIEAyurD2BBddrOA0kg0KOrroXyt3/UAfqlzXv9f679ezFzaG3Wi8QLsN6KFlhER/ps24R2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767829; c=relaxed/simple;
	bh=R4wlB4EXVIXj4PY2Aj3yvcVts9mhlOyol3PcZaU/H+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gff9I5fH3gD0HSmUJlji5hLsPZDGp3AprTOgQPFbf4RUGW5HtVrYAEg2d0eEOqQtikMmrHRts1VtgiHTZC7cAlN2g0pKAoV+FPal2CP3MB6pbk2XwIHudaDNyKxn3ui1gjXEDtqdwuXGt7uMkmXBjP3wlubzTKLKuj4PXaMs91A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kznDdVi6; arc=fail smtp.client-ip=40.107.96.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqQRzd8kCVZTUoiyrEq75yzg0VGo0U2asWG/utbl6P+0YtopXJuhoD82OX98MDSsHwm+IblbX1yiswo9WOgQihQVCWR66GxbfrhZzWR4Aep41xTRfnsz0JEiO22mXOTVkNNv1LwjLmAzk7b+kXUVYTfcnYllnDG902gE9VZVDLfdIaEzko2klWXaNy+N24Z1H1A3YatfVX8hUWZ7XOFhXYXSWvvn8fpm895A6reMvEsBdbHjxr/WlPbwGZ33RbgfFq/L9LxhhrXJcSDOCR9zJd+1atw2S6ritGPrCtpUdxp/pS6awTPlISsK79Cg8LZQWYvl5UwgQTVMkI3ziMaBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMsThwYy3WBr3QYbP907ydWZesCS5Fb31ZIpvcRtvTI=;
 b=BeEC/xaGp09JgEdrUH5li4sK+5hGCWRW+tYySCUQ5jlgPjGy4jHB5Z5/LrM+DzqrJpfKyDUEhS5ooURAmz5FPyR0ZgvUPiDk2xjdIuRXfbqjkbO2vfjAJ+MUnwLhnn5O8DjQ31iOXLjfhIgIFfz+x3LPFotQCJ3A6yJKFDe0XdFduc86R9yHov19PRO21i/cdshKO7u9K5T9I2G66HFYs/YciswuILN+KWZj7AruBCq9KXD28wg8dAuH0Op3qOfVfPrXMvBvrOal6+f1YKkyGUgo/AF4SmU29RY1rQ1/9Qfu6EfM4EcRkStaklMhWt9yc8KO3d7HtT+hOFolVmsm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMsThwYy3WBr3QYbP907ydWZesCS5Fb31ZIpvcRtvTI=;
 b=kznDdVi6qcBSq0/Pp6tSKs5DsYLKbWTFoZ/GX9BahchqkHuuiSNCCepuq/tcIdr08Wa5sgI5JhQqvuKOC85XoWLo5C5q6gelTxaENigb39vEdaLFOsQsBJ4tGPGf5qlfPUbnr+TPxon1V0iGiebbe6F0ZjH3jKBFVO6fM820AnM=
Received: from SA9PR13CA0028.namprd13.prod.outlook.com (2603:10b6:806:21::33)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 23:30:26 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:21:cafe::c9) by SA9PR13CA0028.outlook.office365.com
 (2603:10b6:806:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:25 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:24 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 10/14] ionic: rearrange ionic_qcq
Date: Wed, 6 Mar 2024 15:29:55 -0800
Message-ID: <20240306232959.17316-11-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306232959.17316-1-shannon.nelson@amd.com>
References: <20240306232959.17316-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d1a8c2-9063-4351-98c9-08dc3e3566d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qfsqnMZYnicnZDh3bhrsEaKxCKosZPhTREnI2ZVaxpYsO+Svu7crq8mho+HrXx3rDPw22LaakUhPB89cYvcTRfWvqU82G6Fb2IBxKX3BTPr5h22W/eOOnGtj6d1mh9+gdURynswY37EO6DK1YAME4lqY/3S8eCv1yhzN0Pd9o11EIdNrRTpbcZwoid2u9PQSg20bLnLQbyjSfF6l7tI+gkhWGTSMIBOHhzG7JVWfCx1mDexuPk0SRh5OGmKOf6n2oht3ZVq/3HXpbiJZ88iPlQYzqsyy9CR1+tsTLMOAHzSY1JzfPeQLKL0BXrzmtX44wyiVQv4QcspiXdiV/MA6K5IoZ+PTejRqtijy3jjy0nj7XhjxQ03ejwwSQqyeyM62EmmCZfwk+F41hKFa+GJeyuHKhupvwi42S0Zwi1YUkPVK9Wp7S1Nvo/MUR1N+nq11ZC53AKEqR22H3KJKesqX7bjXWlhWb/KKIoK8H9oik/eGuzq3zx9RXA3+Yc+HDtnrO3uD3WfG6kPnS49h7Ohsecc6EWTjIRQY/yTpSmoMbUlt2eZhBljWVSgkpEhuMtQ/6sjzq6YmIMviSKR5FnDuyGC3T+2f24hNCjGsIPAKUAbUlxcFLvLyOoTBXuXeC1xGgP6ziLiVPcFYq1r3b9lMCxwMaLAQbZ/+2cLyK0HXx7bMO77R8e4O95KO7jOhMj/bqHEVDJT6Q9XfpH24Ckth28DHxU0zrdtwSednvmMH52Q5pfFCc7b8aLK5pUdTjvnP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:25.8671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d1a8c2-9063-4351-98c9-08dc3e3566d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496

Rearange a few fields for better cache use and to put the
flags field up into the first cacheline rather than the last.

    struct ionic_qcq
	Before: /* size: 2176, cachelines: 34, members: 23 */
	After:  /* size: 2112, cachelines: 33, members: 23 */

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index b4f8692a3ead..08f4266fe2aa 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -71,25 +71,25 @@ struct ionic_qcq {
 	void *q_base;
 	dma_addr_t q_base_pa;
 	u32 q_size;
+	u32 cq_size;
 	void *cq_base;
 	dma_addr_t cq_base_pa;
-	u32 cq_size;
 	void *sg_base;
 	dma_addr_t sg_base_pa;
 	u32 sg_size;
+	unsigned int flags;
 	void __iomem *cmb_q_base;
 	phys_addr_t cmb_q_base_pa;
 	u32 cmb_q_size;
 	u32 cmb_pgid;
 	u32 cmb_order;
 	struct dim dim;
+	struct timer_list napi_deadline;
 	struct ionic_queue q;
 	struct ionic_cq cq;
-	struct ionic_intr_info intr;
-	struct timer_list napi_deadline;
 	struct napi_struct napi;
-	unsigned int flags;
 	struct ionic_qcq *napi_qcq;
+	struct ionic_intr_info intr;
 	struct dentry *dentry;
 };
 
-- 
2.17.1


