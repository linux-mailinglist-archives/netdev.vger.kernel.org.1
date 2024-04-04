Return-Path: <netdev+bounces-84862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B14089881E
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C72AB26101
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D18186246;
	Thu,  4 Apr 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ib3PHebX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2109.outbound.protection.outlook.com [40.107.93.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8108480C09
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234311; cv=fail; b=VVgh1k1ZovZlwBwhlRsiT9EHdGS+hbvouBG4ROV7L1yIhw4wJdxECrKmxOrGBnc+F9Qg+mtf+jCIDnktsBWiD3PWh+MJZHWK+rzk+KHtdp+2ZRjpGULQYt+1HFsb5iqgEYogEnwIbaXuRTIvbCt3tA+iFIJcrMlkjmK1SQHHNi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234311; c=relaxed/simple;
	bh=AGZszco9eUb/uA+q0qjlljgmswE+uMI/IpTRp87sVDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oL5B2BKMmvN3AmaVSdynOHaPtD39kMWHCgJv2iWD7wHcp54A1dJGw+rDGujDiAd8HvtKtLIBpE61vPhAXB/pLSU74djOwCjkRYY1jXBk75t/ZdJqf81Vuod+2mG5o+gMVb6lt+lkOZDk2YrgqaBS/T1FXzvxMyMOOUciTbUxNQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ib3PHebX; arc=fail smtp.client-ip=40.107.93.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iuh0XOAOwb/nfXo5xFIqBtbKIH43XmKMqdcxBNNk4j1joROLUJHf396Z/3GBSsSpLDjA4j7JLSByhP+9tDWRYmHt+YlxTUf1aYORK3dUJa/dJZLgvwSbOqKARP06MHu+NCwnpAYBDxrAEIhxdpTwMmKA9BajY6px3dJNWa146Mh1DHiM4epMQ+FcA8EaeKyGDnoVQLuPnGYf7jzIoQxsfvfJNF69vb6fA/jl9bffZ0AD8yP+F0uOaNreCLhpTaoqX0qpmn51fkDi/GgaNiG+DAC3yq83ofoTCwnWhCunEsaB8I8VgOQ7V49Tg86GV/GVZDwBKOeVW/p+6a6kjxH7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2e7JpZa3tOKJTlJqb7+Hu+C07gfMG4HZFDfPv/DO0o=;
 b=UwcErFF34JcMhRf/1ciIKkhNvBmLcjGpfIog/Ayr32nM9GEXr2qQo7VMwnDoivEfJFn1VcT7vVfP9yhZOmmXdxYQwgJT5LIpYxxBrrN7En6D2/qBeZxs/xYzMBXqDBqJ5ZjMqTGx8LP+eNopUD0rFGhRCsUCvA29pMe2GIsAEn/6ctZz61maBYAiIgqvkDw/MDI8QoDXCd5DZgON0CeuueIfdUm3jAMe9MM2oHYMUI121WhanBQLG2gCypMnGdVSu+NEIQP1RzwmuSSM2CerXlYmISCHR9BKfKk9m/bCumHvZykK35GllapYUOqdBDWYXj4NBbNG24mVmo+1Iww6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2e7JpZa3tOKJTlJqb7+Hu+C07gfMG4HZFDfPv/DO0o=;
 b=ib3PHebXTQ+zZwvJN97cv/1wSdgNYjxs+cYDd5FCnS3PArEaqyq55KlVdmd+pl6mc3Li/LV/yxkhlcVxZdb1sME+/qScQV3vAikWX/5qRYaC79TuE3XTKfFSEooPQoeanGZnCfCVOAm1dRtqp0TqJUfryyCrkomm23132yK60VonrwirWj2KMOT32rffdUGH1nrbuBl/dtsk/ELa58pc3RuNtQbqL8z5aHTgU6pbIOLC15ocExHsdoD4YvoVZiRDaAfe/gdTMaFFFRgZoK72KLfwSCPHvGd5xQfVGwkEXo5SHZkOTHkP5kBu6Qey0/1mYyssua5QIrO7n9WCMKTcoQ==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:38:26 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:38:26 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v24 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Thu,  4 Apr 2024 12:37:08 +0000
Message-Id: <20240404123717.11857-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::10) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB7104:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k8WuNmRhiRKlXGEXU47EJEN7gjW8l4nNihx9TXM4CHlj7yQZWVGxrLKl8gEoC80dwrUM8dkIgSWe5S/u7VoMNut0WRJbJACCUjIWxeYVlLcDgDCJXRc33kiCHtBS7d3q3UtGWnD2y+rdmVSyiQP2VDRCTaMFXCGQmRelyefwjS6AL33z2i9BshCFVLPwEl6aItjMdh4SLKeQQKFP5zl6GdkPsEMExz7COQK3HNZMkdWMSfxGj0ZbeksEnsRksTsJUO1DsfYp47tr6W17TGznWrAWKSwa517VTdOsKaa36vBj/JQZ+/Llwz1J8cm5KzwTAUbLwe9vhJ7jdYLb2AXGKaHs0CtDYnBb+prgupOt5bOBoDb2QWjO1Wz3fFm6bSpzGGeYzGMf4TzJLRP8CHpZ3p39ajsz96rFIrZ2hUPJl51M2lqeEW75u58dgvGRPZyCrA7WDnSo4I5w6DsrB/kefSv4V26K2xuVyDHrGqpjbOESMf0meayK6Z/8Lmd20b86Xmtn6yzzr4lYxbBy1stw1D7CiBWJOm6YbrDG6erKavDQOkh5jqd5+SV//MzdGz2+B27bIzLWpq5ggwqTTfptkbSxWd+nMAwO/0pjounziPiGfCSpgmVZpWmsdaCSMZYog/zdz4M29/vPIzHpoUzvE0vadGsK3qIUvxv99BhlSP0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VVgtVbdfDD2II+35shvCGwNm3CCfqp+xxhHUjzkoxSihrakiJDZyPz03RSw+?=
 =?us-ascii?Q?AxPTfWU4kEofXtvLl4v8zulZWLE2DaWRwa1Z6rKu5hi0Q+glSsCeDxbSuDHk?=
 =?us-ascii?Q?YywsK5mT5n4ZafqWX70MMDqmW6gIugE8S0XN5ELi5SGoJh/S+lDA43ertexe?=
 =?us-ascii?Q?G4pDY6BScjzuhyiWkWbh5rBBjDnfggA25qsmZCRG3lUAlwD02zKfGFMcu5EZ?=
 =?us-ascii?Q?YhXdRJw5D0G7rw2zeq7jgbseuo4+83QapRRBW2kCFPw/TUjyxmtXQs4kdcRo?=
 =?us-ascii?Q?33/5wlnckAb22KSmKDpQqUpGAI5EpJF85WykIhOxHHkjJnnQLQtu5m+BfcPT?=
 =?us-ascii?Q?8l+DrHf1H2FZMutL10P/VgoqJ11my6hiIGCJFSzB6v3hBNWMS9B94d8Z0BHy?=
 =?us-ascii?Q?ILMZ2MGn2yQslI5P+UsYrR47csM8tuWaoEYi3KNT9GknXgmsHhIABktBLugX?=
 =?us-ascii?Q?hjodLBXN9CbICBolpmTsd53d5u+IlIYPwanVv3rtR/wYOnH5OsZHJPV5mad6?=
 =?us-ascii?Q?9hDV+KU2PB6hn09BVsjcnJ8N+axKl1ym3j8tyyGW0nNVNlV5HNUn2VfVrZo/?=
 =?us-ascii?Q?YUKzdSzg9E53he34BySQzL6A764eSgMpPVkkxy8ZvGyWAMsTvrAWSA0F9i5O?=
 =?us-ascii?Q?n07BoxqLfxK/VI85NUvukzS/jJgigzHUuA26fclRK70qicF4HYcAgmqVGcpY?=
 =?us-ascii?Q?+0kXnr/gB95XsEBOF1mRemxf73ZHqV91i7SnjKwX3HTuYTKXPZINc9EEuocr?=
 =?us-ascii?Q?EyAfdMDz27XFBUnlcpaSDtqY5DTTnPsQ9TvB03BYAcwBjcV69Ef8RuUUUFat?=
 =?us-ascii?Q?V0FylWrAUocb7phnAEROMiWJSAywks2hj+M3y6cPlcFkeMpghyVnR8nCcR2s?=
 =?us-ascii?Q?hL6M29P9O3mZTmLFU3TXDJR7O9LKQSZJiDdjiHlUQ5AMfhh4UhAWTbcFgVtj?=
 =?us-ascii?Q?cJUyM7RUJ9NAasaM1lPq/Ml1hLLJ65mbycDktRo7BCZv/x7io0c6Mj+jJmdw?=
 =?us-ascii?Q?C+UIrCEygwf8S03qYGlB657vuyjosCd+CL4s66lzTbN6aOjVc4lcIdFH6xZv?=
 =?us-ascii?Q?ieCtdd5Y/y1VBN2aenMYtNK7nZo0I8v/XfUWrpsEhUbh2EdnkZCiVeeQTb9r?=
 =?us-ascii?Q?N3yioi3tHA/bT1geSBt7o5sPd0rvSBJYC4ord02XKJvMVNv4Tu1dWZDfH5Ir?=
 =?us-ascii?Q?fs5JgaO39/vpIbAFG7fdUF4X6wEZ4Y/f9Xg2qW/TCN/f7oXdOe9R8HmIxMA0?=
 =?us-ascii?Q?T4EcCqHTlU+l9XINKRw5S/ikJhgHjzLD5OLNb5F7UMoozJUsMAL2wKNqtL0U?=
 =?us-ascii?Q?n3CoARB4MPiiQjLji0prE5HPnf5OXLMyWXA4U2TNPoFSQV09Xq4r3hMI5uYL?=
 =?us-ascii?Q?uU/budsOPxvNP2bmi/7LJcwU3+Xp4PQ1cUBxdcNIdNdbaC753DsUkpqCTxzw?=
 =?us-ascii?Q?Bj6g45gFMR6QeJv2NooLM87KyBFm/zQcHcupDCOIS/l7GojMubIpvNWWWF++?=
 =?us-ascii?Q?z5TdhAxEErktr309YLgRZXrPrvnm202x4sVKEnRwZNiT9b9FQZgy4QfNrEB5?=
 =?us-ascii?Q?vtNJuS7kAGREfj2b04yoljjaJHbwjrNnn2hN8TVm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404bc7d3-74f5-469f-decc-08dc54a41f8b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:38:26.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGUWcn3W21KHRww8QKss3PYAv1ihpHWXMj1dNidgffKD+xymg3ntkNAL6N+WoZzOsp2RfGUOnkYKEh1mjIACTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

From: Or Gerlitz <ogerlitz@nvidia.com>

The mlx5e driver uses ICO SQs for internal control operations which
are not visible to the network stack, such as UMR mapping for striding
RQ (MPWQ) and etc more cases.

The upcoming nvmeotcp offload uses ico sq for umr mapping as part of the
offload. As a pre-step for nvmeotcp ico sqs which have their own napi and
need to comply with budget, add the budget as parameter to the polling of
cqs related to ico sqs.

The polling already stops after a limit is reached, so just have the
caller to provide this limit as the budget.

Additionnaly, we move the mdev pointer directly on the icosq structure.
This provides better separation between channels to ICO SQs for use-cases
where they are not tightly coupled (such as the upcoming nvmeotcp code).

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h             | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h        | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        | 5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c        | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 84db05fb9389..e3471c442c8b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -557,6 +557,7 @@ struct mlx5e_icosq {
 	/* control path */
 	struct mlx5_wq_ctrl        wq_ctrl;
 	struct mlx5e_channel      *channel;
+	struct mlx5_core_dev      *mdev;
 
 	struct work_struct         recover_work;
 } ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index 25d751eba99b..b45497e6ab1a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -46,7 +46,7 @@ static int mlx5e_query_rq_state(struct mlx5_core_dev *dev, u32 rqn, u8 *state)
 
 static int mlx5e_wait_for_icosq_flush(struct mlx5e_icosq *icosq)
 {
-	struct mlx5_core_dev *dev = icosq->channel->mdev;
+	struct mlx5_core_dev *dev = icosq->mdev;
 	unsigned long exp_time;
 
 	exp_time = jiffies + msecs_to_jiffies(mlx5_tout_ms(dev, FLUSH_ON_ERROR));
@@ -91,7 +91,7 @@ static int mlx5e_rx_reporter_err_icosq_cqe_recover(void *ctx)
 	rq = &icosq->channel->rq;
 	if (test_bit(MLX5E_RQ_STATE_ENABLED, &icosq->channel->xskrq.state))
 		xskrq = &icosq->channel->xskrq;
-	mdev = icosq->channel->mdev;
+	mdev = icosq->mdev;
 	dev = icosq->channel->netdev;
 	err = mlx5_core_query_sq_state(mdev, icosq->sqn, &state);
 	if (err) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 879d698b6119..cdd7fbf218ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -62,7 +62,7 @@ void mlx5e_trigger_irq(struct mlx5e_icosq *sq);
 void mlx5e_completion_event(struct mlx5_core_cq *mcq, struct mlx5_eqe *eqe);
 void mlx5e_cq_error_event(struct mlx5_core_cq *mcq, enum mlx5_event event);
 int mlx5e_napi_poll(struct napi_struct *napi, int budget);
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq);
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget);
 
 /* RX */
 INDIRECT_CALLABLE_DECLARE(bool mlx5e_post_rx_wqes(struct mlx5e_rq *rq));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 81e1c1e401f9..a467a011c599 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1514,6 +1514,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1914,11 +1915,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
 static void mlx5e_close_icosq(struct mlx5e_icosq *sq)
 {
-	struct mlx5e_channel *c = sq->channel;
-
 	if (sq->ktls_resync)
 		mlx5e_ktls_rx_resync_destroy_resp_list(sq->ktls_resync);
-	mlx5e_destroy_sq(c->mdev, sq->sqn);
+	mlx5e_destroy_sq(sq->mdev, sq->sqn);
 	mlx5e_free_icosq_descs(sq);
 	mlx5e_free_icosq(sq);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index d601b5faaed5..780902f63823 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -993,7 +993,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	shampo->ci = (shampo->ci + umr.len) & (shampo->hd_per_wq - 1);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -1068,7 +1068,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 						 wi->wqe_type);
 			}
 		} while (!last_wqe);
-	} while ((++i < MLX5E_TX_CQ_POLL_BUDGET) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
+	} while ((++i < budget) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
 	sq->cc = sqcc;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index a7d9b7cb4297..fd52311aada9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -178,8 +178,8 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 
 	busy |= work_done == budget;
 
-	mlx5e_poll_ico_cq(&c->icosq.cq);
-	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
+	mlx5e_poll_ico_cq(&c->icosq.cq, MLX5E_TX_CQ_POLL_BUDGET);
+	if (mlx5e_poll_ico_cq(&c->async_icosq.cq, MLX5E_TX_CQ_POLL_BUDGET))
 		/* Don't clear the flag if nothing was polled to prevent
 		 * queueing more WQEs and overflowing the async ICOSQ.
 		 */
-- 
2.34.1


