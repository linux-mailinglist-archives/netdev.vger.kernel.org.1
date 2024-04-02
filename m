Return-Path: <netdev+bounces-84049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5209A895612
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB550B2EDE0
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE7D84FCC;
	Tue,  2 Apr 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ASR3XOsP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB27A85624
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066261; cv=fail; b=qyOX0kHnFoPf8coEc7xQyZEkoh4PNVa6f6UheYUAQFpqQ3uQtCVdiIdz5yq2xShCVAAcV3zGHx2ZcG0XSDyekw7lm2orzeFtMpJ+ZF9isODiCb1F6wLH6BG282laTWe6oGtsX4hAJ1F7/NlW/VUrRe0/ZnOq2oUhc9xkhmqedGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066261; c=relaxed/simple;
	bh=2njgSWhJxachikx+Mf01KLDmGQ6GStdy7EW0supzxV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ku2wchSnshbd/wvgbEwzEQ3E8Lyo5CvOPQPwiZA5evZsz6V229e2va6XOQovoHQBy/sxsmY5F1h+xc3dT1xddrZLG5y4mfh8MUrQajI2iKErPccrLM3iIQm6ARSp4jYFF+vGe8ljozdyZQ+PcgASxh6U04NUNwkcR5K7SUUT6KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ASR3XOsP; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRnRIe2GtulCCLYjAj/z9PlZkisbK/i/55mSvREkj+o+41/jiO7vbs37VSknaiq9fqrOX95W1gQOuO8cJAlMiHgIjHB4eMheY2LctJ/S0bXIuHSLVhTI7M5D0YoSQn3FpgGZVgF+VY8gsXKktf2uNpUAnTkvGoAoMPe43ZM+lTOIt7XtorzVnkreR3YocifjS9ORRMVD7Tsq0eDLXH3eBQT4Ded/kAOqppVILmbliQhTxI2KbSSO4pKJZFQAhkSEqZXOEHbqYRleWFw2xcXIYZGDVacne45B8FCH8VYFA16rLTvhyk2srBvRPdaioQzyUTWe1ILaWT1Wewb+4Mm5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hf2SB1jpQtaH9w4/YAvPsC3A2tToyxAT3iL0d0a0bIA=;
 b=Gv6rs1HSOP7VaT9gmVvZqTHnuqrLZIN5yKwBtIN9FhQxiUoNS5YiBF97HOz1uX1bQ+JZoTIeyIASFNUtTrYE/UOovG3tyla0o6zPKzOt+ylazgZoVmKqPiL8j6SBBbgK6+GDytfUrZseMQ1dgJxVlcQf/dmoiDrml+TbywXybXgQgyzH6Q1iOx4ZyUHvoK6ALaHmTUS+h1EU4pLZQBnr04iOwqVkCY1eTLiD13yO+dIowaR489vRpgrSobGFaB14a5XtsftpdkHxwQyVbYraYdPCfMu2f8xmYz94hyYyQLOzjaVT1WWhC+/QkT1J38hBgbq23hx+b+p/akdgYteEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf2SB1jpQtaH9w4/YAvPsC3A2tToyxAT3iL0d0a0bIA=;
 b=ASR3XOsPRLq6WaUH56yHhSliRRMIWw7nErSQmAdQQkaR8grQWq8BlEeRZmT/ATe7ATsRcow62288sy6QyukqMVL7OWjsFfcHOL0kvPa/vtXx2M8lYulMTWGkwS5WIRrSzo7yD0LEPUOikIE9NweN58v10K0iZA/zDPfQ42Coc++UPOv5J8JHiBc7nPZvt0AS6SRRwvyIkqp9N/kLqVmvDnAZJ6IWWtXgZglJaDnAWyBXmPHF5PEcR5TpxrNw7J3VtjYc/TAvO08PcdHYxqNpeBH4mp/SqK8CzDNx5ZXuC1h7xjIYSclWNjYI49RBPi9nH06c66AK6yatU10QUsd8wA==
Received: from CH2PR14CA0006.namprd14.prod.outlook.com (2603:10b6:610:60::16)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:57:35 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::4f) by CH2PR14CA0006.outlook.office365.com
 (2603:10b6:610:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 2 Apr 2024 13:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:57:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:57:17 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:57:13 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 06/15] mlxsw: pci: Make style changes in mlxsw_pci_eq_tasklet()
Date: Tue, 2 Apr 2024 15:54:19 +0200
Message-ID: <2412d6c135b2a6aedb4484f5d8baab3aecd7b9ae.1712062203.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712062203.git.petrm@nvidia.com>
References: <cover.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f90a07-bca0-4d52-2b52-08dc531cd9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yQLu8eBQ7UF8OIMxx2Ujs8aUNisoN7jea7s8oGS45GHfNQzTviATETGWvkkYY23T0YBZhPXd1WeK4saBDkoQSazNxY7tgKeYKqf4vvF8Op138s0GLZPrPW0dJmMZOXwLumjZ8i5PyTU+oeewVFw1ROVMdczg3fhzlezJxp5GMhARfYi3d17JirC4XfWZZAc1659uTa97MBeQVt9PRqSptiGOBcapfYWn777FIqXAPphCFnFJ7/Zv5DKxTsyX1X0Om5PVphJjM155nQa4yYMRddHWZp8PmsBAL3jDyDNmVAUxG1FtLzlr1MhDyrEbq7FMfngrNIkVS9ABz+0AZFWQvRHbXWsk33M0J9K6qm9oeBZTi1evGILGW7ZMTdC+DvKrR6oc+9gMFeFMgXUGH6h9i4NrPrEN4KFs1dpHbKihfziRXzZIpbnCcVi+vDrmJZTjr5BqCRyWKCtDR9Zd6hSNnT+KeTHMGf+n+lrnoDTuWCyZOZlg3rA25qAfETn43lyITqhi3xvZZZ9wtn1EXkXdfQxgBBjpB5TUPpK5XIJMOosTubhBh2OAdMvGu1Y5cmHxel8bp7OkICSEc/WIsITk2Er081TLrtwWOOfQGQtqebrAoTB/zNtGAVmtPAlZ+M23mbEkohJeHI6reBho+pWWNj5A6c8ehJo523lr4bEeYwlhzDMJGSlVgdYgIgAk+/B6J7O4U2aH7SStK6X5SpqwyT7HrSK27WuiSmGUpf+xbS3cMhhw2WQSM3fESJ4ZMFor
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:57:35.5488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f90a07-bca0-4d52-2b52-08dc531cd9c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623

From: Amit Cohen <amcohen@nvidia.com>

This function will be used later only for EQ1. As preparation, reorder
variables to reverse xmas tree and return earlier when it is possible, to
simplify the code.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index f05137b85483..c9bd9a98cf1e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -783,15 +783,14 @@ static char *mlxsw_pci_eq_sw_eqe_get(struct mlxsw_pci_queue *q)
 
 static void mlxsw_pci_eq_tasklet(struct tasklet_struct *t)
 {
-	struct mlxsw_pci_queue *q = from_tasklet(q, t, tasklet);
-	struct mlxsw_pci *mlxsw_pci = q->pci;
-	u8 cq_count = mlxsw_pci_cq_count(mlxsw_pci);
 	unsigned long active_cqns[BITS_TO_LONGS(MLXSW_PCI_CQS_MAX)];
-	char *eqe;
-	u8 cqn;
+	struct mlxsw_pci_queue *q = from_tasklet(q, t, tasklet);
+	struct mlxsw_pci *mlxsw_pci = q->pci;
+	int credits = q->count >> 1;
 	bool cq_handle = false;
+	u8 cqn, cq_count;
 	int items = 0;
-	int credits = q->count >> 1;
+	char *eqe;
 
 	memset(&active_cqns, 0, sizeof(active_cqns));
 
@@ -816,13 +815,17 @@ static void mlxsw_pci_eq_tasklet(struct tasklet_struct *t)
 		if (++items == credits)
 			break;
 	}
-	if (items) {
-		mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
-		mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
-	}
+
+	if (!items)
+		return;
+
+	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
+	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 
 	if (!cq_handle)
 		return;
+
+	cq_count = mlxsw_pci_cq_count(mlxsw_pci);
 	for_each_set_bit(cqn, active_cqns, cq_count) {
 		q = mlxsw_pci_cq_get(mlxsw_pci, cqn);
 		mlxsw_pci_queue_tasklet_schedule(q);
-- 
2.43.0


