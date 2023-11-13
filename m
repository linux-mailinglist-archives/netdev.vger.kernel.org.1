Return-Path: <netdev+bounces-47434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA097EA2E1
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 19:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7499C280EB6
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F22E22309;
	Mon, 13 Nov 2023 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TE2vtf70"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724AC23742
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 18:33:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7313FD7A
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 10:33:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbBALOZby78kAs+/eWqll/kUYaVq8hl24zOzmbpV7NfklDLigeLYxgMjZogDfqJJb7aXFBOu9XG10DsZlApjTE7mG1rmQcPRwdWBNaRNiT7e3/fWd9+b61c4M/bMUIkKW2sYISKpk2GQlyB6uUY99iEAdpaSutoU1hqG1miNibtXoQK0d6UrNH5wrCmJYRBv7wP6MzIrjXPchNvJ85OtBurcqJMFKYip2697kdL0a1ea0OvklfSWqEO1vJBOHjhOiqdfnca+wPvX+NlqQH23Heco6ZQFxULIkcN32EL4qpGfKuEtgBdRwLe5ie2H4E4hjJb5xfjlLwinEpDfhA+WNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siJN03VjBvUeVUSWopRt64zlUU0COldedgmVcZTdruU=;
 b=cfa2QKDVjL0+S8NUSNIqxnS7SieWbyJEqz/sRUdyyERdzFonTvW/yJpWVQr7UmQO3/amTWrdRKJrODR1QXZV3pMhktSxShQh9Woy7fW4gwv25jpJljQ3CggdIgj97hsOHLI91kzDKxeBu8anVS0+qUYbp8wWu05mHIhM8GOKJabHyGODfwibQZAar8tu2A3rwxMyZTUF2r1/i5XGiC0AES3YRw21t3D2u3gBNCMI/rSxIGD8GNkiR8g5KsKOV50IYin0YZv9c3mGeNiadXLH6cLVmbIzlLQH+4gVLiVqRPzggdsDQLw2FZBTpEcUNkhWDaiz/djnhkMCnPEmO5r8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siJN03VjBvUeVUSWopRt64zlUU0COldedgmVcZTdruU=;
 b=TE2vtf70zpNoPqPJx9tAPC7w6y74N5NtI66eMDTXiwgY8AJAnaPoIFT0LLcp8gAl/w724qXDI2rWQw2+00ePK2gFKKRWgMb0q+cfDnImGjg6GG0ZuLhJEBzqogExYEoY/OTa9OX3b3TFGReMMQXFePDiSuoFXcTXyPjGMMmGcqE=
Received: from CH0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:610:119::29)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 18:33:24 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:610:119:cafe::12) by CH0PR03CA0386.outlook.office365.com
 (2603:10b6:610:119::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Mon, 13 Nov 2023 18:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Mon, 13 Nov 2023 18:33:23 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 12:33:21 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <drivers@pensando.io>, <joao.m.martins@oracle.com>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net v2 1/2] pds_core: use correct index to mask irq
Date: Mon, 13 Nov 2023 10:32:56 -0800
Message-ID: <20231113183257.71110-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231113183257.71110-1-shannon.nelson@amd.com>
References: <20231113183257.71110-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: da571441-9e8e-4661-b1b3-08dbe47704ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qFEi97VBVi9tCTZsbrzHOacl7dwiudChrGuWbUaqWw6gyLBtX/d3XYLqqpG/cKB+nTgvKM7dsuS9TFVXqPR592wyTMuh38eEvtmaT9O7Loh6oLMefBKDxNXi9vfPdLWh4bs2T6JQ4qMkKiVSa23xnXx+44ps/MSq1VkSMquFnSSqfNthNQDVDV59q1GMM6bT83vWwDzP9au8ac36btEI9CdtTdm//vDS4swNC/yRIx75DVamJUQKTO+8WAQZwLyIu4MEYp14CBmYA1C77OAS/AwHFUE6ERMrwNkjm2nWMou95LrUCZhitCsLI4vWNSXjVD9xZLmIBhhPg3HoYFWvvQsZ1mwQ4Vqfh4MkIx7lVzuaf/F9ng2d2O/OUmAj30IkW0EizvzE5rhIvw18TnDaj2Og6ufa0mQUi9M7hj636lzHBqp7xbkUG5KgB1rvjU593gwhcD68c87BofKh9j8HIBcIrhn50u7bYc8zuJTFuE/uh/+qDiOl6l4GHtF8Lb45rPRF8ZUAgzV0NZdRunkAou7l9pykd2qdWB/emlyV/T+vISbGre5q7KcRsLZj0wWG8moIwsfBEVwZyloNnGq3d+Ur5EsqLG/ZF8D0xO1NGhh4jURnXX36IDiMwshcnmaxqpIbXq/ffYKCyIfjU/ZMQ6K6wx0wT8dglKS+l70NxhLajQOF8G2SAERU0+1nj7jn3XJPy6nEn4Cme9kOVH+UOFKM04j2T4hvSDsslyvlZ1We2pw6CI+6QcpV4mcegHhvIXjpLSe5GOXOHsdspob99w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(4326008)(8676002)(8936002)(316002)(70206006)(70586007)(54906003)(110136005)(2906002)(41300700001)(44832011)(86362001)(5660300002)(83380400001)(81166007)(47076005)(356005)(2616005)(82740400003)(426003)(336012)(16526019)(1076003)(26005)(36860700001)(478600001)(36756003)(6666004)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 18:33:23.5459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da571441-9e8e-4661-b1b3-08dbe47704ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125

Use the qcq's interrupt index, not the irq number, to mask
the interrupt.  Since the irq number can be out of range from
the number of possible interrupts, we can end up accessing
and potentially scribbling on out-of-range and/or unmapped
memory, making the kernel angry.

    [ 3116.039364] BUG: unable to handle page fault for address: ffffbeea1c3edf84
    [ 3116.047059] #PF: supervisor write access in kernel mode
    [ 3116.052895] #PF: error_code(0x0002) - not-present page
    [ 3116.058636] PGD 100000067 P4D 100000067 PUD 1001f2067 PMD 10f82e067 PTE 0
    [ 3116.066221] Oops: 0002 [#1] SMP NOPTI
    [ 3116.092948] RIP: 0010:iowrite32+0x9/0x76
    [ 3116.190452] Call Trace:
    [ 3116.193185]  <IRQ>
    [ 3116.195430]  ? show_trace_log_lvl+0x1d6/0x2f9
    [ 3116.200298]  ? show_trace_log_lvl+0x1d6/0x2f9
    [ 3116.205166]  ? pdsc_adminq_isr+0x43/0x55 [pds_core]
    [ 3116.210618]  ? __die_body.cold+0x8/0xa
    [ 3116.214806]  ? page_fault_oops+0x16d/0x1ac
    [ 3116.219382]  ? exc_page_fault+0xbe/0x13b
    [ 3116.223764]  ? asm_exc_page_fault+0x22/0x27
    [ 3116.228440]  ? iowrite32+0x9/0x76
    [ 3116.232143]  pdsc_adminq_isr+0x43/0x55 [pds_core]
    [ 3116.237627]  __handle_irq_event_percpu+0x3a/0x184
    [ 3116.243088]  handle_irq_event+0x57/0xb0
    [ 3116.247575]  handle_edge_irq+0x87/0x225
    [ 3116.252062]  __common_interrupt+0x3e/0xbc
    [ 3116.256740]  common_interrupt+0x7b/0x98
    [ 3116.261216]  </IRQ>
    [ 3116.263745]  <TASK>
    [ 3116.266268]  asm_common_interrupt+0x22/0x27

Reported-by: Joao Martins <joao.m.martins@oracle.com>
Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index 045fe133f6ee..5beadabc2136 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -146,7 +146,7 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 	}
 
 	queue_work(pdsc->wq, &qcq->work);
-	pds_core_intr_mask(&pdsc->intr_ctrl[irq], PDS_CORE_INTR_MASK_CLEAR);
+	pds_core_intr_mask(&pdsc->intr_ctrl[qcq->intx], PDS_CORE_INTR_MASK_CLEAR);
 
 	return IRQ_HANDLED;
 }
-- 
2.17.1


