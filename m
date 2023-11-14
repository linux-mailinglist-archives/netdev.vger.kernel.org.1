Return-Path: <netdev+bounces-47704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DB17EB00A
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C16B20AE9
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C40F3AC26;
	Tue, 14 Nov 2023 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rmpMzqKy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763503FB24
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:43:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E06E198
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:43:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEb9Cl66pk3YID7szM5dNcwfvD8aEyWRWefJrK7hUrOrq5DHHXNANgQ4vaTcO10HYvhX7i2EWkyxxZIhYX7PCmlPM0UX2MxXwKiJlYoXWuseDwktNJM5SGwSJbIiF75QqbpJ33iUDiPenZvNlf2P9agXVAmRIg3/QcKQKu3hkIt4dWBy1W4ltJs+vpuC3U3Wfx/PsBstpF4TXPi0XVhDOL6TmRI8x6v5D2Yo+TWsPtQzwNtpLeI+1RV2VhLCKGCU9aK6QqJ0V4yF2ooLpxyblCmuwCgJjgAhDIzU6n5WQj7rNBzpp6TuPrt5ACyOMJEHGLexlCibiqTUkrX2JIvCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRzZ4xolCUxmfoquIwnMhGP7MU+AAgBSkC5wvDWLJNA=;
 b=FLUvnbDzJTCEWh4la14Z8l88NbGV4KMWVn/FNjLSBpMPaHC2mVhfR8OOUWSe7p92nmQLY0Kmzo9ZmAs9gIMH+79bw+qzjN1OTau0cVxWD16vxF0tjBontO1YeOt5Ez7x/Q5z32J1UQweL3Vl4T4vrEC75MkVEgZ3VHzm1FQtE+dWGMzWNYvBXYbK4bVwGcFcAZek9qON6Yd+B69/7xoFdmIBFt7gzN9t4p0dQcWNYkP2ybO/ZdxrvTzUb8rRW4/67WbkZL5+nO+qZwbbPji+Kl9F/gaEohN+LPthdi+VFzWsuc2Qgl/lKrvPdq4Lnsvployc5Uo+RKrBnJ3gpGQwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRzZ4xolCUxmfoquIwnMhGP7MU+AAgBSkC5wvDWLJNA=;
 b=rmpMzqKyqUkzZGE2yjPz/jj9/9SO+aBVf3Y/xsI2fGva7iWxZFb8GipW37eg1Xrqs5A8kFdfrU5eoqF1IGq5fSKQkSvQgxAIfFr7c9o4s0BZX5WjbS0HWzMLXOAUhEfDWBJw727gpx8G9RbalKdzrzDHrv2WmYfU2dJfqik4RfMj7UE/mz2vad1ZBMr1IDX49hPDZ6UFc4cnsI0/8B0u5YFU2BTuW2sYgnyGtmo2gx/JZAgQ5qey6wTXm8tHnrIx2Egy0ZP2HCug7/FiywL2TLo9bXTqKEewN3Kegm8oEMxd62zlOTa1vQGtT6gkfYXnd8LCwUgSsJSGVlTVzsyBqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 12:43:39 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:43:39 +0000
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
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v19 06/20] nvme-tcp: Add DDP data-path
Date: Tue, 14 Nov 2023 12:42:40 +0000
Message-Id: <20231114124255.765473-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114124255.765473-1-aaptel@nvidia.com>
References: <20231114124255.765473-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0426.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::17) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3cc487-b5d6-4b8d-c9ac-08dbe50f534c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JMxiCBeiYgigx249FdDXHuxSZPgjcHuq/xaJ5hasiysRXvv4P9znEmJOUKyZwD+/rBcxOkn/vX7YXVYlNdBzDHKpJKsjRLAlODCn2QubaF9k1Mcowss7lWLTYxYkcRMYKmmu+53LBH8kXCHFukJlw6hhrWvtgADXkkrI4/J5Hq2aI405A2FsZunowCnWFxN09G/N+SaqiLS7Cxtxi3lsdgo6bxy83tHYQniTkFBBM9ISHkqsbUHsabSqYZH+liropJ4ptF9N/rIeqcqqHJnQWkwb/jfC4GmcoCs8cU81P14+Wp5eXGQwF8AMMqgH6aclZIzqhvlvoRqaw1+DcuWBxI1Lab/jHwwXLKB4CgBUl5rdlGgYfEjtuCEt+mGI72WAza6r8Cae/y5JHUT8flAYQ5X2EMKITfgCu51Z5tZNhimHYr+pRHmMXBo5rVo0ywWywR8JNwtjcFGDYGBzGNWrBpan1ffX40HH6hmgbpT270nq2Uoc8ytYL6VWbdF8qfhgx54eJzZlfqFidyBwm9kh8TiWz/iCMCMgjS+7cMu4kX3pi0zG4izO1xFhDqnwJ2ia
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(86362001)(1076003)(2616005)(2906002)(107886003)(6506007)(6666004)(6512007)(83380400001)(8936002)(8676002)(4326008)(7416002)(41300700001)(5660300002)(6486002)(316002)(478600001)(66946007)(66476007)(66556008)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+CjKCWAH/Kb7KITKkAS2RE3WjJlOPOdT9tjtWiJe0jM4ZnNwnIs0mttk+Qvj?=
 =?us-ascii?Q?WRYO1Jx13dGzspFHpyWmT1HzO6VPjMcmQT4EPT/3iQajInrklof+4yVRzMJ5?=
 =?us-ascii?Q?NsHbnpv3TQY4YTefMWF2OSxRhWO/hyKhwvVedjAHqnCgajSIvY7Ts7NTJcJi?=
 =?us-ascii?Q?CzwLqOsPiHGgh3cZr/OUL2eZUS6giXg6VDBa7q6w3scUl7rdl/yHobCa+y8g?=
 =?us-ascii?Q?VGKhpQHtPbI0aeg0bgKIJM8e5pqOVbcQMBnoQkFSi+Naj99PT2XTQ/+34Gil?=
 =?us-ascii?Q?gPjRHwln6szT5sX5MN/07Ege7BWaReAcytLjTB63QjAeVMTfnzawN6dwUD4x?=
 =?us-ascii?Q?EHhicFqPpRrTcYg9ltHT3/uuaWHin1foPCqCgodyQQESdr+XI9GEarPaf28F?=
 =?us-ascii?Q?kItDZo+YnVdDFMtPVas/AmNN1+qtmmceD6Gea5DmwnaQHWjQw/pNfbIozhHB?=
 =?us-ascii?Q?RsrBF6RIwZPwn17qNz3tLnXBAogjxNa4CD+sH9WPi7qQfpTFdRi+G0ROyh8K?=
 =?us-ascii?Q?ZaKg/E/g1lZn4602BT/5RS5hO+8AO8M6yohvbJzHJ3Ce4ifJDx4zTcW99/fV?=
 =?us-ascii?Q?KLMOuWSoIxW1UsotWeItms6ZTL91+vDrBU5MqNJib+ryYGOVqqCH4G+WXRfl?=
 =?us-ascii?Q?4cgnxjHm5oVRw5CB26ixcQrnyQDJlws/xc5TgFiKKhvlVMr89oCMz9O7wK/b?=
 =?us-ascii?Q?KnYZR8GtHsweS4Hs1Q5I4kxjL10C67LeTKg6DyeTwApk+9zFFJvyrRuGiC50?=
 =?us-ascii?Q?I5hElNeB4CxIY9zKreuNTUFJBt1aTLAVi39pE/coquZA0RRGoJ0dJYW0rhUr?=
 =?us-ascii?Q?r1Po44bQEXcKEg9r4AEDHJTGNOFvUoOXeerTL5bsgV8I12bzEXcJ2owCtMCC?=
 =?us-ascii?Q?ego6d+gU+CJCNyW2ENNBNnTDO1IfmR5E/PbUfbI3yH5NddqSTugISexuc+mo?=
 =?us-ascii?Q?RzM7doGbwl0jMmsztR064pVa2FWD05ptn8r1HSFdHtB8UWxqnLj7hhI6hvvn?=
 =?us-ascii?Q?4RFXnegfG6JYXZT7CUn3bC6PI+hP7GjeHLdDyj5CqfuTqC4CMV1B8STdEsyB?=
 =?us-ascii?Q?+Ufeer/phlsG8JclVMcJsAeiurbHj1OQKBHWeXUtoSf1YDpabFo/M/6DKscI?=
 =?us-ascii?Q?Ymo9ivSXbv61CI7E5UBi9C6kFwF520Y3+N3T5GxAkbOPXEMKPedvZQ8A/UJo?=
 =?us-ascii?Q?V8AeNFsFBgm8AlD8fejnZPouMCXKgqlyuHpkQnugM0mXur/8WcqlT17i3UCj?=
 =?us-ascii?Q?u66Kkmk2fGsgGSPsID0Uuuq7lLOsRU5/Bsnk4eUrHLyge5mZVR1d0aZagguW?=
 =?us-ascii?Q?ISGrGVUQdCRSS/7coWTQvjPQKWefEHTd7+RQxVu3+K8vGCNXOoZ7YjbomFmf?=
 =?us-ascii?Q?pwtxQdlT4/ckBWms6QtiFdatszMhVTyFbVi0YZeCZZjqlV/mB7kry2vXjT5y?=
 =?us-ascii?Q?7OuC31XtOIZAbGH4Wh+PS+sZ+tGvEVno/SkVRtDdpLDivHgxUlwgQ6ugXmO/?=
 =?us-ascii?Q?mX2YN41W+cO0wbHbVjdxLNPqiOn+nTyRxTn2WeZEkTvPN6uRQrhCmxHd7XjO?=
 =?us-ascii?Q?FbfW25CLNwPSZo9P5OyhikfLFMe5x8ZFgOeNqGAF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3cc487-b5d6-4b8d-c9ac-08dbe50f534c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:43:38.9491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +82QlTWMzYahDC/tiiJNwnR2aZgUdza+PbtQO83q5WDvhiudNgTnyKwDVibgM8tep4yUU0QBZwN+Np53K/vQ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476

From: Boris Pismenny <borisp@nvidia.com>

Introduce the NVMe-TCP DDP data-path offload.
Using this interface, the NIC hardware will scatter TCP payload directly
to the BIO pages according to the command_id in the PDU.
To maintain the correctness of the network stack, the driver is expected
to construct SKBs that point to the BIO pages.

The data-path interface contains two routines: setup/teardown.
The setup provides the mapping from command_id to the request buffers,
while the teardown removes this mapping.

For efficiency, we introduce an asynchronous nvme completion, which is
split between NVMe-TCP and the NIC driver as follows:
NVMe-TCP performs the specific completion, while NIC driver performs the
generic mq_blk completion.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/tcp.c | 111 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1ee87bfa4533..1b4f4c2299af 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -127,6 +127,13 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+
+#ifdef CONFIG_ULP_DDP
+	bool			offloaded;
+	struct ulp_ddp_io	ddp;
+	__le16			ddp_status;
+	union nvme_result	result;
+#endif
 };
 
 enum nvme_tcp_queue_flags {
@@ -354,10 +361,72 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 }
 
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
 	.resync_request		= nvme_tcp_resync_request,
+	.ddp_teardown_done	= nvme_tcp_ddp_teardown_done,
 };
 
+static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				  struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	ulp_ddp_teardown(netdev, queue->sock->sk, &req->ddp, rq);
+	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+}
+
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
+{
+	struct request *rq = ddp_ctx;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (!nvme_try_complete_req(rq, req->ddp_status, req->result))
+		nvme_complete_rq(rq);
+}
+
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	int ret;
+
+	if (rq_data_dir(rq) != READ ||
+	    queue->ctrl->ddp_threshold > blk_rq_payload_bytes(rq))
+		return;
+
+	/*
+	 * DDP offload is best-effort, errors are ignored.
+	 */
+
+	req->ddp.command_id = nvme_cid(rq);
+	req->ddp.sg_table.sgl = req->ddp.first_sgl;
+	ret = sg_alloc_table_chained(&req->ddp.sg_table,
+				     blk_rq_nr_phys_segments(rq),
+				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
+	if (ret)
+		goto err;
+	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
+
+	ret = ulp_ddp_setup(netdev, queue->sock->sk, &req->ddp);
+	if (ret) {
+		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+		goto err;
+	}
+
+	/* if successful, sg table is freed in nvme_tcp_teardown_ddp() */
+	req->offloaded = true;
+
+	return;
+err:
+	WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
+		  nvme_tcp_queue_id(queue),
+		  nvme_cid(rq),
+		  ret);
+}
+
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
@@ -478,6 +547,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {}
 
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{}
+
 static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
@@ -753,6 +826,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+static void nvme_tcp_complete_request(struct request *rq,
+				      __le16 status,
+				      union nvme_result result,
+				      __u16 command_id)
+{
+#ifdef CONFIG_ULP_DDP
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (req->offloaded) {
+		req->ddp_status = status;
+		req->result = result;
+		nvme_tcp_teardown_ddp(req->queue, rq);
+		return;
+	}
+#endif
+
+	if (!nvme_try_complete_req(rq, status, result))
+		nvme_complete_rq(rq);
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -772,10 +865,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
 		req->status = cqe->status;
 
-	if (!nvme_try_complete_req(rq, req->status, cqe->result))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, req->status, cqe->result,
+				  cqe->command_id);
 	queue->nr_cqe++;
-
 	return 0;
 }
 
@@ -973,10 +1065,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
 static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 {
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_queue *queue = req->queue;
+	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	union nvme_result res = {};
 
-	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, cpu_to_le16(status << 1), res,
+				  pdu->command_id);
 }
 
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
@@ -1283,6 +1378,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	else
 		msg.msg_flags |= MSG_EOR;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, blk_mq_rq_from_pdu(req));
+
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
@@ -2727,6 +2825,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_ULP_DDP
+	req->offloaded = false;
+#endif
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
-- 
2.34.1


