Return-Path: <netdev+bounces-47705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 923747EB00B
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6041F248D8
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9BA3E49A;
	Tue, 14 Nov 2023 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pBiRvQk8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462503FB0B
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:43:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A221189
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:43:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7rcG8b8GhC21LS+WFgWa0ICdtD4TntcjHTUAyRriTw8yEXKq5glFqkPNKxu8MYbFN1RB16VU9fc8EkLTPUXePXReXhEC3Iaqs0nAMOEnaa8oPoI+wR+IsOOLo1bnpMln3hBzOLui8iAbCYlCb8MKqy5GBpPvTtccPUvrn9uU4vJN1bVdw+EFd2HX5Bfe8SFEZKzan3EcJtCJrHnVRiwcjaBXaWF+4aCUt7XP1BZIa7Xpa7paZpJm2ERce8MKYwMNIYkerMwZc2nrRiWQQ/vPZQ9/HSe4YV/XQxUXZK+S/aCuAS5Adk3pQc+PAFR1l/NPltItjHlNE1fuhuL6RQ9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP79bCJ5iFSFVI9FC6bghzv9miwq/SRd4PrN1HDIejM=;
 b=NmjMirAzMQQ2fXiqfb0aWRsmBPZaB+wgAzHQVuKJjBLbwHm1TrM9MdGaTHGqE6ncf/d5GaN258JpkMWtjiBE2eYilmTIpShspOMygsV5Dcw+kBJpgGjDMOKAuucRxGPnt7aDX6ZQaOp1TUVV5+oFRy5gKwQg6Im5rglch7ld/JE3DB5Gq4cpJibAUYXaNi/WDje0xV3edWtmVzw+tiA9FaTbhzbPTdxnvrrUzK9tAQ9aSeqszQwDBSARB60JLshTwMFs+hBthuLnLUW027Hfs1wnw/n84nmh5UGd1LVj3ViOYoz4Hlf02LSDrHrS1R+qzBDAZc6hHYxASv+wDEUqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP79bCJ5iFSFVI9FC6bghzv9miwq/SRd4PrN1HDIejM=;
 b=pBiRvQk8uCsKQ3X2tiSqkABEfe5zP9mSAMnDBRjBsZS+1YMA9f2f3Bv8hTA9+/XoEw6P5BXR9eJiidTAQuvamub36tZ5/Xd9AnhDcv+luFNJ6P9WtevNxyTJIcGwZV8FPZoorBwlGRVP3wnWAKylE3gRbFXO7ps4gEPkxr2G2z4eDRlrJ1pPzcqsFvqgXWdhbf6WiTTJ7dbaYuvO/668p1hiWMeCEjReK9kFZPEVeXM3//v6O5kRMl2W72Iqc2aBxE8lDGQzs3mdpTlyrYCCOZK4Fe986xJkoo1qRl3YTBnZM0iuYMuBjgE3HGT4SqtnseISd9o6z1tAcBL/6b+/2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 12:43:43 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:43:43 +0000
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
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v19 07/20] nvme-tcp: RX DDGST offload
Date: Tue, 14 Nov 2023 12:42:41 +0000
Message-Id: <20231114124255.765473-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114124255.765473-1-aaptel@nvidia.com>
References: <20231114124255.765473-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::24) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 405d5dc3-df20-41c4-d209-08dbe50f561c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MxVuq4FW1XYvyGpMHDoQU4wHBF/EkZmTNYxkLOmkHwxDGJ3MdnzlOoPL4JGeu2nW/WfKaqMU2msy64CR5G21hy6XlMHaRt81haGlcMlpEZWLlLcOAx187GhxbKqODDFLbygqyIA56oMqmDDwGvbLOAa2YdSuQuPtb2rLz6KMQyC7z+XwEvTRVwOtElXI6Dzg9BXCEr+stqkSJOdo4qoGhJwPqsVsrljKfFNRNn1ABGakKArpOKkjyEo1x+BbXYm/bp5CHervMWlzHxWrtX49zxCgXO1FCZFw4xMYk0NLUc6sNdM8AHEl1bZTxJOmwKwgqGtRZgGmKguYitH3HNSVervqyAMNiWnMoykrwjjW4llE0Wp06oM3yZGxIaN9Cba53nZIKdrM8u9+qUk2wp+PsBs7vQN6enapT/ALfy0BBnCzznCCBrQ49c/kTe2ucne+tZ3Us7DmlfPPwfxy84f92SNVNyNc1tO22I5vDgaYzsbj5OmqhEY1MeHb3fm90bwoe/CfMV9mjQvoxKiYGOozpHppcCzKychGLduVDq8RQzsnjz0D2KqgFi4fUkhApOgM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(86362001)(1076003)(2616005)(2906002)(107886003)(6506007)(6512007)(83380400001)(8936002)(8676002)(4326008)(7416002)(41300700001)(5660300002)(6486002)(316002)(478600001)(66946007)(66476007)(66556008)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JP+2PICirT+zeyLLNsSpLq68Enz/bgt5Ug3nGgvB5hdFn1JbO5bhgmXDX4YT?=
 =?us-ascii?Q?IOmKGHdmTbWteVxSBSzzQ9QQPnz6QhRfzzhxNCELc5uTNWzo1g9Lnt7qR3Gv?=
 =?us-ascii?Q?2/Fc56aECFJO3+RVnWzF/JR65Qm8xkM6Z3BHaVgwd/YbKke8EREwjKeM7bi2?=
 =?us-ascii?Q?XRK8G5LZicX9xprsmjejip7Op2Go81WXkPVmH4Y1sIHIBB5iIlsgmMHOOXCw?=
 =?us-ascii?Q?7dkPk6z9E8cpgoStn9hjr1hzxPWobMVzKcDhE5Xkgz8kmRhGu/koKUiaobvp?=
 =?us-ascii?Q?XZ3uAZNtrKMwjDtIopfFRb/VXgz0D91wDdJwZuM4E+6lJ2YPvaTOvxeSJeoW?=
 =?us-ascii?Q?o6+1DsJp88yxVk+Z2kVr9HNy305ir1ZEAAi1skupDduGtQOLi6g6RduWjfET?=
 =?us-ascii?Q?TPKFQ8gb7PoOny43ILVNaP3ic9eBVlNdZM0ZC+kOI7DBoR3RXiMfeDIMfbhj?=
 =?us-ascii?Q?ey5rUOoi1TZiGShqU/I7m/WSdir4VrymRU7hOQq4Fa+LSgs0xRB6teRtKTpE?=
 =?us-ascii?Q?LQ8JaYe7BZgfcC1mcXEuRHuXECFUkQv7TaFTN+XNoONlo0bqEpNbCOhGN1n6?=
 =?us-ascii?Q?rv9Ssb4qf3mRve9pdmQRIO2ckY9v1V1GkiAQ498+BdgsF5phlRlj1Ju18zse?=
 =?us-ascii?Q?unwS4RzUY16jiDCh99ziJ8bfX2NQd0Jidda56QAXLT+huWtWwthBH+mrRqkI?=
 =?us-ascii?Q?6c9P3SRLWNtwqRrVyd+PgoyKDan3V7SJzXYgfiacdLHHzA84HyKK/0DzXQfA?=
 =?us-ascii?Q?Mnu4bxVuKxkL0VpA5b6Lwy4gxKAsoJntapkgb8CB+2DAx9/XM4NJ+BuFWGHO?=
 =?us-ascii?Q?91gzgEWdY43ceQJKNi1ZrMc+EQzrKlf5da7qZzJ773dA6I9jdQaUQpsNskvz?=
 =?us-ascii?Q?wgKmum2bl+uayG+B8m2grn+nCMcJFIsgfB0jS9gEzA8opEE9aT0qoKWU9M91?=
 =?us-ascii?Q?qUPXX/7/KuWcOeBP8TLTHkHQTj06rXRTss23WJbunXC0GB7DBF165pFKKvdw?=
 =?us-ascii?Q?Fz8n4ihkuibM5heqqHQBe9TFs79sP186OMSltcf259h9ctoQKe/Qxj5Do06R?=
 =?us-ascii?Q?X4z/9S1VXivI8Am/SbOY7Vy3R1YiaH3V7GTQFKTpW2kNsGcQdSxqV2Rii1iw?=
 =?us-ascii?Q?mxNQs21GoW7xxcxoBC2V5NyuzGGphJXmPtMM/y1cDSzOZsadqpP/EuOpvH3r?=
 =?us-ascii?Q?TgK/1DPlPR+M6YmESNy3V8kM4OfGBLLTiodgUCMSJ5n85rGm9TmtaMnfZXPN?=
 =?us-ascii?Q?FBHZ1dNsByTKZnaRLXNacZA83maI1PyrV4S5yoGwt1J0y0YtXQMuMGqQq4Fv?=
 =?us-ascii?Q?rJ7vOb1fb5/q8Kr7JS5H7fukSDN4yv4Ln7Imv07cM6VsJnzRTYE7KXdlHXsm?=
 =?us-ascii?Q?iSByKM6BiARGfSNwlYDzlmZyUvjubj6gken3vRWa38ia8cv0RdVY/JzKlN4i?=
 =?us-ascii?Q?FIbZa8nOdDWlCJfrcf6YilVsLn5+nXFs42QeLDjJO9b6+C1071qH3PyJ8J9s?=
 =?us-ascii?Q?7L7/Ivtv7VuRNlIluamogqT3Hnz4hDPKBmoweunhGA2PyLdoL+YDqkOk6Wf6?=
 =?us-ascii?Q?7SaBpuG1GoTsHOq3JMe+k07uJSA4D76ui6yEqN6J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405d5dc3-df20-41c4-d209-08dbe50f561c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:43:43.6381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2O1a0HN0F5VeNdFfWPY2Xo00QI6p76SCyzFSUrGuxHXixDym6t/i8hGtibY5fFMw1la1lcfzFV/BQQg3LHP7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476

From: Yoray Zack <yorayz@nvidia.com>

Enable rx side of DDGST offload when supported.

At the end of the capsule, check if all the skb bits are on, and if not
recalculate the DDGST in SW and check it.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/tcp.c | 84 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1b4f4c2299af..867d5fac3925 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -141,6 +141,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_OFF_DDP	= 3,
+	NVME_TCP_Q_OFF_DDGST_RX = 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -178,6 +179,7 @@ struct nvme_tcp_queue {
 	 *   is pending (ULP_DDP_RESYNC_PENDING).
 	 */
 	atomic64_t		resync_tcp_seq;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -360,6 +362,33 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 	return netdev;
 }
 
+static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return queue->ddp_ddgst_valid;
+}
+
+static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+					     struct sk_buff *skb)
+{
+	if (queue->ddp_ddgst_valid)
+		queue->ddp_ddgst_valid = skb_is_ulp_crc(skb);
+}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{
+	struct nvme_tcp_request *req;
+
+	if (!rq)
+		return;
+
+	req = blk_mq_rq_to_pdu(rq);
+	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
+				req->data_len);
+	crypto_ahash_digest(hash);
+}
+
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
 static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
@@ -430,6 +459,8 @@ static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
+	bool offload_ddgst_rx = ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
+						      ULP_DDP_CAP_NVME_TCP_DDGST_RX);
 	int ret;
 
 	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
@@ -449,6 +480,8 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest && offload_ddgst_rx)
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -456,6 +489,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
 }
 
@@ -555,6 +589,20 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
 
+static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return false;
+}
+
+static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+					     struct sk_buff *skb)
+{}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{}
+
 #endif
 
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
@@ -815,6 +863,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1082,6 +1133,10 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (queue->data_digest &&
+	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1110,7 +1165,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 				&req->iter, recv_len, queue->rcv_hash);
 		else
@@ -1152,8 +1208,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	char *ddgst = (char *)&queue->recv_ddgst;
 	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
 	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
+	struct request *rq;
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
 	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
 	if (unlikely(ret))
 		return ret;
@@ -1164,9 +1223,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	if (queue->ddgst_remaining)
 		return 0;
 
+	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+			    pdu->command_id);
+
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags)) {
+		/*
+		 * If HW successfully offloaded the digest
+		 * verification, we can skip it
+		 */
+		if (nvme_tcp_ddp_ddgst_ok(queue))
+			goto out;
+		/*
+		 * Otherwise we have to recalculate and verify the
+		 * digest with the software-fallback
+		 */
+		nvme_tcp_ddp_ddgst_recalc(queue->rcv_hash, rq,
+					  &queue->exp_ddgst);
+	}
+
 	if (queue->recv_ddgst != queue->exp_ddgst) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
@@ -1177,9 +1252,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 			le32_to_cpu(queue->exp_ddgst));
 	}
 
+out:
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
-- 
2.34.1


