Return-Path: <netdev+bounces-44747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FAC7D9820
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49FE282428
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726E51F958;
	Fri, 27 Oct 2023 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CXN8c5Bf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05361EB2E
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:28:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D373E192
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpS2DdDiHXXbDfCNV1aFfgpjrqHaML1Ykdf7vRJZj+owq9G35DvA/eE6/EXrTQdphrtuXDi8lW/yRYcFEpoE6mbtJ3mR9H3JDjI5vCE8fcJrmAE6hXraHPSOJb12K+i2LnVFeyjUF7OZUqgRiFgGEBPH5aYOD9XFBp2OgjXmIdtnQjO44u7lh1+IBCOjgB/nDSDqf/dBAYBz+cuRV4felh9y778VR7/GQ198dvJ15Vto651O0Qdz/3FMIHnsObSrbB+WpSxYxQhYBAdLh0T98DcW5vVFNHgpWfUvSiRn+P+0NbHJ05G4uCi+LiX0T4XsDfu3NJ+fptkRmseltXzYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD47YIeR/wBRwNEzHzW9CX3Rv+TfLq4/zfBGLJySeLU=;
 b=GCGsnvkzbxs1xDjKv9tmqWeAQKxsr8A6Uq8AKBpdynsF4eNnde105diPg24U6ZVW56nAFG4KRbGfQDH03JZHPwm3d3t+R/soiGDZnjAhB+vZxFR2hAJ4Q3VN6hMALPXVXvpniu9xk4JTEsL/aoz6oMoH6coM6/ALETB9HekZXzUgXsreZrt8p+YBgE/uy5wa0tHzaLJ7eMAHF89FFugXZ9ikHph3d3s5I76VFoIVPCdRRcYs8aeSo9YPkZptv3RwceDR0uBs2mOSBkwwPbpIDIQKlmR08USUPyzzNQyjEAx+cLc22IlJ2OYVxAsXTwniw/jJP65oKpHPCJHvE8/VEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD47YIeR/wBRwNEzHzW9CX3Rv+TfLq4/zfBGLJySeLU=;
 b=CXN8c5BfRdsQY2qlNAB6oYDa7Z+F3Pr5B3+g9X4NK97I/3ZrF3lm5tmuIWv3/AFuUqBmERBaolEfy8uAYNPZKSO5U9LRhv8kN2YCko/B0Y+tEZ371xhMqJ8V+L2usy8z2rsO9zbdhG3pBHemNrQnAd+AivIuGBasd0v+q2We2jRRxoQ5jA6v+29gqQkpslRoIPnqRx+QePocrKmDLbsCakKaGueN6iKB30pAy6cGJHDZdmYk4eOLNZHF2TOUOrN+kiKfyangE49yiH3Bn2oNPV4eOKjs8jVKfB37Y7I9ze39qXm7ygfEshXrMTMGndefPNcufj25ak1/USwG2cSIMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 12:28:29 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:28:29 +0000
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
Subject: [PATCH v18 06/20] nvme-tcp: Add DDP data-path
Date: Fri, 27 Oct 2023 12:27:41 +0000
Message-Id: <20231027122755.205334-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027122755.205334-1-aaptel@nvidia.com>
References: <20231027122755.205334-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0050.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::14) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 406f0b98-230e-44e2-1017-08dbd6e83a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WLyrBFdwRUM3+A8rS98c6YEneGXs7Da9at19KMDFyfu+e8sxF7F/qW3pYCEMbMlopp2yDrDsniS8TeT7QKPS+j2y0rkxlIj1dDEQKanu7eMrU5X0HQb0mfwt6lF0CyNg3RPIE9p9/mleKQ0qjuNE6U5e/cPz3ywEBWVOIiQBhwniD9p9Zv3YpTMvU9ApKfjppbq8YSZ5ahqAcpuKa06NBRDPI51AAIJEAjPjIY7KtVJXHmQ2HaafEF2f5Y35hAR5SS3vWC2OiFd96DPhNDXsFUhyHbxqbTWRgNMOWxuh2juBK32YWspLEQpRb/VCxV+JaP2FpS7INSoqEjo7U9NNsgpI3PhMoLkZuViDvnPdUclohVXRj6q3P0i8rxOd9x6/t118qtk66hxavfxWqGP+x/qNUeod5+wAkbu6Il+i4EIbW1em7euL/nkgmyjiKlPANBwI+onohhszJVV5QLIxfmNFrmf7PUd0lhIEeNXzSmQINTUWMNYxjySZqBCYMOsk6Z48whQf00FLfD88klZylIe9JwWWOZzgiym/R5yyE5gU4DzYPjO7F1D8xugOxcBL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(1076003)(83380400001)(26005)(2616005)(6512007)(6506007)(6666004)(107886003)(38100700002)(478600001)(2906002)(7416002)(6486002)(4326008)(41300700001)(8676002)(8936002)(66556008)(66946007)(316002)(66476007)(36756003)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0P6AAxH8joaZQtpLbBoZA1jsuhx0GeGEhfdCpyvM60Ezpbh+TWLOOx5dk11v?=
 =?us-ascii?Q?/h/SQS5HEPeojym5onfN8VblSlXkli4gV9mN+ww8Oa79C1D1aMnRSj2+J1kc?=
 =?us-ascii?Q?cfNAQmCE9YAUA+x2m+ef+7R85TZu7eSf0Q5y9fBrqqeGo2T1pLliTIkFguaB?=
 =?us-ascii?Q?SitxlGQaqkGt3nz3geUsD5RoydLmJ0kEsq/jRKq2Xw92Aj3l2NIgF2vr5maN?=
 =?us-ascii?Q?YtNXwZNI7Zn6O/tiAtjy2n5G5vfovt1KO/qWcBbpYOjGp/2FwjaWCZ7FxDQb?=
 =?us-ascii?Q?qPSqWvPX1bSbfdpDZEJaCRyeDuUdCSajn3L/1RV6S1sBTDx3olba4xhS48b3?=
 =?us-ascii?Q?FPJNpGjU1mnnyJh2Q3s1nZoxyVmkf9K0f0yxPDS4nBpVX0fLkVPWBO4rCtZC?=
 =?us-ascii?Q?i2/oglM4cfH+Aq1R+qHF/w5F1NEKonie+VL+V+lmmsdu6mLTPa+UjKWLicIw?=
 =?us-ascii?Q?lVztdj+wPOdJUJm9XOUxhhFb8/iSr8YnrediKjsTjaDqNGnqHofhuIxe2GUE?=
 =?us-ascii?Q?8alEH0p4UcjxdM9f+yZSHugRykAC8rEv0UUa6vNyd1wHq57R1UemZ0NhJMr7?=
 =?us-ascii?Q?vOBfxhKNr1C9yctpi2m59UYuIaomJl1ih6ykB3dNfhlXR8jksf57pEWsj3gF?=
 =?us-ascii?Q?C+IYSuTiUXZ17L4ZTgxqbJRsXAXfNq0cvCAPKoHg+V1nv0D4SMDtlI5Am/SC?=
 =?us-ascii?Q?XdECOPQcMTBW9n3ieYDf161g7Cn8LZWeCpHLmNcoTczRptsbyrf6nhld0M5e?=
 =?us-ascii?Q?eBo/tKsXTmH9BputBMdearYPviJlN3lIzWy5nx1zIJh3yg81CzGbTWubiCgX?=
 =?us-ascii?Q?KPS3vUCQqsBderUxFJWBZ4VLYr8/JUGIFh+Mq1fJ7ojPKYFEjLrCwSZwPPf9?=
 =?us-ascii?Q?PXtvZ59i3CvUqTPV8WChrJjHYdjDjoT9Io5XggkDYb8CkY9mV67pn1Rq27yc?=
 =?us-ascii?Q?HH9s4eOs+W8fS6Ld0a+oFGtrWzD0hSIn6/v4FLaFzPs1CT55IW3XleE7+Ft+?=
 =?us-ascii?Q?6SeGudq41trMX+PFt3U/gC1fwMhZCS0NhkJzBoa0lv8rwrIwTon2a5WM/puf?=
 =?us-ascii?Q?kwVscoMhv0pu67Frm7ZrZzq+W0tdDU/wKHkRk4HooWwYO2yMcISsyvu1RHhH?=
 =?us-ascii?Q?fGRcOrLK8vEHZFOqbkaJJHNdZ/0MVXqcnVrBF6eUXFsecLyX6H/1c4pyF/Ms?=
 =?us-ascii?Q?JoN/KK+BwhE5Bda+zWEfP9drAkSIg0Y0G5NZhiVv1W8XrZ0nAJRfy/hcmxes?=
 =?us-ascii?Q?deMSSKFV1J7sQcVvshtpmT+7ntAPN+cITuJO5u0G+AH5gjY3GGyCRtzpVV6p?=
 =?us-ascii?Q?Vf0gzMxzSzFYavBPsC0grhXcO6cjlBjr7iVrKrPZHBDDCJa3BtHtXmB80DKa?=
 =?us-ascii?Q?6pXect+48doNmZ2+M6mDmNW4s1yFg7cqfvmOjEmmq9PPo05lrX5tO+aHK4a4?=
 =?us-ascii?Q?I1CilCi3sy7qclw1Iw+xNsbYtXVxq1s64q/rown2NsfOs0lRg4Si3DrqseJx?=
 =?us-ascii?Q?JbU0Avo864ZJYoO0JylmeCjxhox3GBoQzhTBZvO6+XjPzBjC7gTs2NzL75bZ?=
 =?us-ascii?Q?dOxTUc6GnbmIwiUD8mnx6igSywyOMtIaMWccYbUe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406f0b98-230e-44e2-1017-08dbd6e83a09
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:28:29.8728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PHaioyqO9ayAwACdH0pRGXNwQhH1Gk+YXuafOeNJySRRW4Y0Q366YuFPj7aD2xTrZMhhqP5cyJ5xIbpjL7zyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378

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
index 43cd7621f8d4..5c80ee089ee1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -112,6 +112,13 @@ struct nvme_tcp_request {
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
@@ -336,10 +343,72 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
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
@@ -460,6 +529,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {}
 
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{}
+
 static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
@@ -735,6 +808,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
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
@@ -754,10 +847,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
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
 
@@ -955,10 +1047,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
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
@@ -1265,6 +1360,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	else
 		msg.msg_flags |= MSG_EOR;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, blk_mq_rq_from_pdu(req));
+
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
@@ -2566,6 +2664,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
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


