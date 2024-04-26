Return-Path: <netdev+bounces-91689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB4A8B3763
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 14:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBDD1F21E0C
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 12:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEAD3715E;
	Fri, 26 Apr 2024 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U+MUs2GA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F139B144D3E
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135515; cv=fail; b=JTbUTio4fHz1gdHeGKtW9XO7NNjUKStNQAWiTPIu/b3pF7/TlJtjrY5aJ1OXJNLqpCMAo3KwposZaeJzwCtS0NNIF24lxVVRSaVZDy76kuPGjzowpYT9TnGsqwl4ze+bD3bihwrb21JnxKM3MgOUPJzfmTOV9rjNPVF9qRilyZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135515; c=relaxed/simple;
	bh=c92LoBSTAG/0oIwjQHG/KRD/CJ82kg+UiutQGmRDkPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2s+QxbUcVUieYrUgujo/clPDev08DaeRHt1zvLDqAOwpcCJhvaHPxQRdM6kYiSZaIDm+YvCT9bmtvF+tObVGPIRp4wPzVG2kvgRlLgcE1QHiOJuxWHJr4dkt35+fOsAqYgSjn6L3mvihu/GGmpQg4poQFhC32kGof69WcMyLgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U+MUs2GA; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3JIrmmooZQG3125tHIE8xWRK+OP5oXLD8wOzNMa2LU6HbDSMickRYxNbKtElx6dHHA1ByA73eSOgs5DnouSNCH2vkZKqTSpT8YJYOPDlsh3QZchxGtMoRJuBIM+VjNsjHFBI8upYF1ZUDKP2WcOcU6ctW0JUr++BZZjnkkTIRW73ZEkDjFxHJlW5vaMWR4dXF0++fK6q04fOKiWXrTkixSmp7FakMoXBh4dXTRaaFBLiIhYkxTH93CPcctitw7MW8YcUTR+VzSzA1L+mMNi4ix3jzen2icug8lHEeaVAKs8wF41Yo9WvXpJLwxOc4pUgwlJtCdaiLAP9VI2yeZN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zhux23mQ3KaoT+53+k/UNnUETv/sjcc2yeYXR2EUi+Q=;
 b=cujig0b/psPAlGNKG5gwi5pHGAqSdQXu90ofm3UI0Jq4VGbcSDWHlMcIOVkVgBSsrAStwFpeXuqXDupQBDWf9OYMX1KkAK8+ZyMuZEP+HoTpbJkC9QLWWIMKD+yfTlSpU+IaxESxcbmqNMntxP+lz/7KE4Jt8TMTU2LZGQXvtzpKbutrOI9vv56kPU5BYMbOwHLzlwlxYrTwdhJXgUTrLpRHw3yMr32w7gAGx+repniMoo8i9tPNOM0Y0wAa7Irf2iE/6w/w5YGIixEvU+HY66PWXK23d8Dhu5fEPq+PNysu7hh4Gw4M0vp2YiIetpMEZ5TmtEaxTE1g6WGwF/gGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zhux23mQ3KaoT+53+k/UNnUETv/sjcc2yeYXR2EUi+Q=;
 b=U+MUs2GAl8ynLHpPLaEKqM5WohCecGGMTXnTu9pzLw05+HPe/bcM6vCkpE9fvxbRVOrQVhwcyu1ig50Bsvkk5yx25f06aCOeWYkU2sW0QvIysT1f6Tq5eJzGE1Uz0khnWT93ay6jnuOyHEE3hr/TRQ18PHZpgRu67JOikSOhQLONGI4eA7dWIBh72WMGnItDt/JCdF/zbbstk869f7/3xrv7PBABUaeu2mHDknZkJQmvEnl37tr/OLJ3ByHt82MN2owwmeLWD0vjPbMTlFK9NgFOzxU5dnXQDHLZ4SNeg+Q9dkMWLsoH/BA33ZX44i2u9VxFD+gpMAUwNHHCrVQ1/A==
Received: from PH8PR05CA0024.namprd05.prod.outlook.com (2603:10b6:510:2cc::12)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 12:45:09 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::74) by PH8PR05CA0024.outlook.office365.com
 (2603:10b6:510:2cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.18 via Frontend
 Transport; Fri, 26 Apr 2024 12:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 12:45:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 05:44:57 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 05:44:53 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/5] mlxsw: pci: Ring RDQ and CQ doorbells once per several completions
Date: Fri, 26 Apr 2024 14:42:23 +0200
Message-ID: <82bebf03f3b33a50ea9f5a81048f29ddea5247af.1714134205.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714134205.git.petrm@nvidia.com>
References: <cover.1714134205.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: a2269321-4c4b-445a-36f3-08dc65eeb46b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SHizurUsytgdYWZbhZj+VlqTT/EYNYuSeTjEP5D5fZue7DnbKu9abU+7zcNn?=
 =?us-ascii?Q?JX5Z2IF1gkumYsBykyA+agU7x1L9GsidT2UM+7Di9Vmx0p2W55tVNyHs/D59?=
 =?us-ascii?Q?gXkDjxkWEBbsWjpSa31wc8nkTn6dqGzlcPRFhL/83q8nvOAbVbgadjuEu8lZ?=
 =?us-ascii?Q?V2VYebGYWBWUhSQDCuxg8bRj67d1/W7RkspMIfUKLPURMNYjoQxN9Tgd5aQ/?=
 =?us-ascii?Q?5AyCy7XnBAjHl9czOMsS3E/YnXbl0U6mIPp7kCu+OAy+f0Mck3jwM0aO7VyM?=
 =?us-ascii?Q?g6wBtteOT2F2BDupMd1l0L4SjG3mPW3LIEF7Q5mB0gb6quqoU+3/xAfuEFOQ?=
 =?us-ascii?Q?KCOLFvxhOrW6CK54BPNlfutozVflW6WpDYmBIi2YA3xPpXP6wOun52O3xx5a?=
 =?us-ascii?Q?w7ZYvp/P/6EIjacvmxbtrMskZLoAV/9fdBuFyjnDnS9UDed65c9FkzG7RZ0c?=
 =?us-ascii?Q?uuyelbwXp4hqltZTy55fXsw7cROL8K/i/a2p2izKZAkbvrWOrcNBfQQvQthA?=
 =?us-ascii?Q?1E3RJr48vEq9wX/A/X2leqxU+Pqb1SSKmiCNA7lxfZTk8a7lff7YVZEm1z66?=
 =?us-ascii?Q?vQjo4VCxBEvsv2bnMVvvCOMcwQCNWVQ9nvR5Ztx/+UxH7ydoyAEefX6Mw98k?=
 =?us-ascii?Q?ysHd8dvADEPkGQrvWd5+vBqce3yWpkAwoeE4lHF72CdV9SYUVraI6+KHnN60?=
 =?us-ascii?Q?ClFYMR1Xay+XU79mPB7XOjWVLRzGhvtQaV02P23iwGRPnCp5UfsY3J63C51O?=
 =?us-ascii?Q?VwGSuGuCVfLwK3ePOcvEZBVqCrcGDp6IfHhle6o+1qnQSq7BfytzUwNQi2RE?=
 =?us-ascii?Q?YEZ5sinDExQi/Rro7tAHdpuTJgpLeYeXWZ0nCp/AlAv99prm2FLqGR54Fs/I?=
 =?us-ascii?Q?ofFc8fcEG3nQZ+Csi60j9JSsWs5qlqTfAdvdBdKfETFd3V2xOXjHkJ8RKI3R?=
 =?us-ascii?Q?10LyRlCmF1DSeWRTrbMAaSq1P90rFOD66c6dFARFyqF2mRlQs8bJrcE5MCzp?=
 =?us-ascii?Q?xonqgB6Y6tEC6ZzvjGgjS/TjgR2qYpOrYvpr0H9RIVQi7GcyxjJX8AMzJp7f?=
 =?us-ascii?Q?dQsLgeOcEl9bA1jX1l0Z7uZk2bEerffPqGw4JGuPTQMbFwTSit3k+dxv4Rsc?=
 =?us-ascii?Q?8PzlXTbW1whGYxWElVQA5st1qsQ0K5pgyHOCKdTH1g2R0NK/HntmnZULb2js?=
 =?us-ascii?Q?64WASk0Th7yVVdJtzP4MFKd/Y1+yq1sG6mXTuxb7L/bhTPZRonn077RK27TC?=
 =?us-ascii?Q?Z7HTbynBqtCoCn8g+S5Bf9GWbNF4Zp0W6jSGsnaQS2Q++A+MMB5LI3hFf07h?=
 =?us-ascii?Q?499VSptORaTz9GdqgpY0MXoUW8dssRUPZ8NEqFLLEPBkUHCD+N/i1ixG0S4J?=
 =?us-ascii?Q?CUcsN9v/9KoAewn4tBK0WIrKBETd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 12:45:08.1908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2269321-4c4b-445a-36f3-08dc65eeb46b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624

From: Amit Cohen <amcohen@nvidia.com>

Currently, for each CQE in CQ, we ring CQ doorbell, then handle RDQ and
ring RDQ doorbell. Finally we ring CQ arm doorbell - once per CQ tasklet.

The idea of ringing CQ doorbell before RDQ doorbell, is to be sure that
when we post new WQE (after RDQ is handled), there is an available CQE.
This was done because of a hardware bug as part of
commit c9ebea04cb1b ("mlxsw: pci: Ring CQ's doorbell before RDQ's").

There is no real reason to ring RDQ and CQ doorbells for each completion,
it is better to handle several completions and reduce number of ringings,
as access to hardware is expensive (time wise) and might take time because
of memory barriers.

A previous patch changed CQ tasklet to handle up to 64 Rx packets. With
this limitation, we can ring CQ and RDQ doorbells once per CQ tasklet.
The counters of the doorbells are increased by the amount of packets
that we handled, then the device will know for which completion to send
an additional event.

To avoid reordering CQ and RDQ doorbells' ring, let the tasklet to ring
also RDQ doorbell, mlxsw_pci_cqe_rdq_handle() handles the counter but
does not ring the doorbell.

Note that with this change there is no need to copy the CQE, as we ring CQ
doorbell only after Rx packet processing (which uses the CQE) is done.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 8668947400ab..2094b802d8d5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -630,9 +630,7 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 	mlxsw_core_skb_receive(mlxsw_pci->core, skb, &rx_info);
 
 out:
-	/* Everything is set up, ring doorbell to pass elem to HW */
 	q->producer_counter++;
-	mlxsw_pci_queue_doorbell_producer_ring(mlxsw_pci, q);
 	return;
 }
 
@@ -666,7 +664,6 @@ static void mlxsw_pci_cq_rx_tasklet(struct tasklet_struct *t)
 		u16 wqe_counter = mlxsw_pci_cqe_wqe_counter_get(cqe);
 		u8 sendq = mlxsw_pci_cqe_sr_get(q->cq.v, cqe);
 		u8 dqn = mlxsw_pci_cqe_dqn_get(q->cq.v, cqe);
-		char ncqe[MLXSW_PCI_CQE_SIZE_MAX];
 
 		if (unlikely(sendq)) {
 			WARN_ON_ONCE(1);
@@ -678,16 +675,15 @@ static void mlxsw_pci_cq_rx_tasklet(struct tasklet_struct *t)
 			continue;
 		}
 
-		memcpy(ncqe, cqe, q->elem_size);
-		mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
-
 		mlxsw_pci_cqe_rdq_handle(mlxsw_pci, rdq,
-					 wqe_counter, q->cq.v, ncqe);
+					 wqe_counter, q->cq.v, cqe);
 
 		if (++items == MLXSW_PCI_CQ_MAX_HANDLE)
 			break;
 	}
 
+	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
+	mlxsw_pci_queue_doorbell_producer_ring(mlxsw_pci, rdq);
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 }
 
-- 
2.43.0


