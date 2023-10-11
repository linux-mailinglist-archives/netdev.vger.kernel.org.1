Return-Path: <netdev+bounces-40026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D4E7C5725
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A422823A8
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1E6211A;
	Wed, 11 Oct 2023 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HOdFTq3f"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994C20302
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:39:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A22A4
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 07:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTyOQKgUxSIZo2zTw6/SNLElAgsIw9mXEqu3UIJogQd1U/Vnc6a2Wg7oWS1rMoSf6djbps0RlWV0/nWj/cjLs6dJcKvInzvmLTAGZx+gVE2ZjuKk+2639mZZWqgyoLzqbOdrfkJOu9G4DsgCMCR4fhqWm5jfdYWgfcttpZXLU1n6wTmeqR3vpOqXMlOyERMk349CpkJeO5JjX9FER4KxTzFn6QUdPXJE8SjoLVc/qootmMwpmKnPZxdIiJp+GKziqEwwPRhg924NCYUS89PnTvhrhnFDse8MScfUOiyOO541bgwvzCgIduwXbx7z5yb5LoYQI1ZsjX9tZqlRRezHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ji/hVwIrpaf45j4EXim+eTS4Vkwso8lXtt8F/dZ0CcE=;
 b=DhZzPSTdNA7VtgNiRPlt+EzuqGZSnjTI6p0xML24AM8Dty+QmOTfVPD/X6ls9G/jRnwvD3MtFFaoReC7wvEDxcDx19pLjkEAQFlblqRalsYCdXGVIVfII62VN7Rq4yRwDNVkPQam+TX7Oo4Bw+C0e5BkmbpGwVskDqJjniEmlQ4qo7XJ5voriGy9UwIYo9VjS1DEw1xWupiZ8nXA1fVU0ipykF64EmVvYkD73L8oO8zfqDMYc/q+KFgQEV63x+pPynW3/YISTX0363FtIa98JfBppEdtZgbsYH2y114esK54ZEri5N8aGm8A8hW2qYwgBAsmtkUd1n5VM1RTWfPESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji/hVwIrpaf45j4EXim+eTS4Vkwso8lXtt8F/dZ0CcE=;
 b=HOdFTq3fTmO3YVwXzqxySPUHMUHb9uUolNOqWcjYCMO5B3Y6U2lvUQL4BcyDNUiS4B5yz74+wjxrEccP6zPHi7j6hE+StD7WpNt00OtJjmf0ebDGoNm5brpo6XpCoHNu1xWBNsPL8sMTxm/UosQHZfOGfAurN4tkk+VWjUKiX7rjk3hTX/BrD/kg5AmQnB3GcA+z0EWcNVE0H6najt3L99ifDtJ7RdRWYkxra/EKmmP8iF5S7I0lZIRNH7Ys3uocLd/Y7NTwFLdRMmY2BrK+IUfj6GHyBGc031dj3rhtKrfYbRjJ9R66ZD0QreWmt2rbJM0Q1f5DKjTOoaNtvQDquQ==
Received: from CH0P221CA0046.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::19)
 by SJ0PR12MB5424.namprd12.prod.outlook.com (2603:10b6:a03:300::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 14:39:44 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::22) by CH0P221CA0046.outlook.office365.com
 (2603:10b6:610:11d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44 via Frontend
 Transport; Wed, 11 Oct 2023 14:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 14:39:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 07:39:30 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 11 Oct 2023 07:39:28 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next] mlxsw: pci: Allocate skbs using GFP_KERNEL during initialization
Date: Wed, 11 Oct 2023 16:39:12 +0200
Message-ID: <dfa6ed0926e045fe7c14f0894cc0c37fee81bf9d.1697034729.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SJ0PR12MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a90ae29-0f11-4589-eeab-08dbca67e898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pg4NQLiR8sgyfpDl3rl1aLCabakOMwStRp8yj+m7GvcW2CPcJPQ/ywiuCroNGaR3jrh617nbybiac262ieO9ZIYh4Z7nRfdqtPjNeYvNHK+uGkcJCBPAm0vqOMf2+YFFPgOJeMQg+YEbznOLkK6HUeYYOuHG+eN/ikcCeB0JobXszfDRhrd9D5vXE59i8H+eZ3xZNjsl6sKweVzpCghhFTNlEZ+wa4mLQ4CKxZOcbE6tzgdMqFhz/45Bwje2gLIDvLwsyXC/cnTyGP2x2gULNl6HDZPlvLEHjDkx4zj7Lz3tFr9IEKnKq3Uez5HaIZ9a7y0Maqx5Mi5DBIoLxp5hjB8Myg0ySaLACHgQIHlIcwos4W6EctzklJvS1af8hUrslU7BPWoxEZPtUXEfVWtiHCafgcOEhZpG2+dfkDu19dnZZdz+xMzVt1myYtk+Xfew69E+9J+ErTDTM6RvvjKxsOvFsYmITxHlG5ZppjUpy+ddZa1sdKUhsSLpWn1tiYvgBV6E+7lybC7qJd6gj9vO3M0kFKA8Is6iM+zSTdjSGfdI1p9cNc7zGRwrkeulr0OQRrEfdOMYB6rgNb8jmI+6ZiI+L7oGJdRwREqUUgRzERHFYl8VLSnWV8v6QATtYnuKgUNYIIJd5R7x559Z8QShO2xSTrjEEdVx7A/oUp3PZgo1zgn34PlX8kn/G1ADp/k5qU23FRrka24UlkzSuUToVtCWuPSjgseoegrxT7Se9luBCKnd7YIMaT/BLun+x+1W
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799009)(46966006)(40470700004)(36840700001)(40460700003)(82740400003)(5660300002)(8936002)(41300700001)(8676002)(7636003)(4326008)(356005)(86362001)(2906002)(40480700001)(47076005)(7696005)(478600001)(36860700001)(107886003)(83380400001)(36756003)(6666004)(426003)(26005)(2616005)(336012)(16526019)(70586007)(110136005)(316002)(70206006)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 14:39:43.4273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a90ae29-0f11-4589-eeab-08dbca67e898
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

The driver allocates skbs during initialization and during Rx
processing. Take advantage of the fact that the former happens in
process context and allocate the skbs using GFP_KERNEL to decrease the
probability of allocation failure.

Tested with CONFIG_DEBUG_ATOMIC_SLEEP=y.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 51eea1f0529c..7fae963b2608 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -352,14 +352,15 @@ static void mlxsw_pci_wqe_frag_unmap(struct mlxsw_pci *mlxsw_pci, char *wqe,
 }
 
 static int mlxsw_pci_rdq_skb_alloc(struct mlxsw_pci *mlxsw_pci,
-				   struct mlxsw_pci_queue_elem_info *elem_info)
+				   struct mlxsw_pci_queue_elem_info *elem_info,
+				   gfp_t gfp)
 {
 	size_t buf_len = MLXSW_PORT_MAX_MTU;
 	char *wqe = elem_info->elem;
 	struct sk_buff *skb;
 	int err;
 
-	skb = netdev_alloc_skb_ip_align(NULL, buf_len);
+	skb = __netdev_alloc_skb_ip_align(NULL, buf_len, gfp);
 	if (!skb)
 		return -ENOMEM;
 
@@ -420,7 +421,7 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	for (i = 0; i < q->count; i++) {
 		elem_info = mlxsw_pci_queue_elem_info_producer_get(q);
 		BUG_ON(!elem_info);
-		err = mlxsw_pci_rdq_skb_alloc(mlxsw_pci, elem_info);
+		err = mlxsw_pci_rdq_skb_alloc(mlxsw_pci, elem_info, GFP_KERNEL);
 		if (err)
 			goto rollback;
 		/* Everything is set up, ring doorbell to pass elem to HW */
@@ -640,7 +641,7 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 	if (q->consumer_counter++ != consumer_counter_limit)
 		dev_dbg_ratelimited(&pdev->dev, "Consumer counter does not match limit in RDQ\n");
 
-	err = mlxsw_pci_rdq_skb_alloc(mlxsw_pci, elem_info);
+	err = mlxsw_pci_rdq_skb_alloc(mlxsw_pci, elem_info, GFP_ATOMIC);
 	if (err) {
 		dev_err_ratelimited(&pdev->dev, "Failed to alloc skb for RDQ\n");
 		goto out;
-- 
2.41.0


