Return-Path: <netdev+bounces-50054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 431547F4824
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B5CFB20F7B
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166B74BAA3;
	Wed, 22 Nov 2023 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JEfWdhuv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1544BBC
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:49:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT7KUmz6KuGffWPVJSC7gM+F57vUZ0x2VrNAUyt0abP5s4HYBDQh6dstMU4czJypGHwU9FOOYH3QSCs3tSGQrLsiAKui5A2Md+B5KHPWimCJrJz/hXJ+uIP9NJNb7L9qZTmF5xG2BxJpch9/2Hh6PewUHAyCBlrEq59A1XGo1UjjhqI/3FHiu07aJdmgROErDb0oXzET+L5l0RZ39/bi2073YqAx7Ll6aQeZeyRUaaYq/rjDYuz1aT96YauG2lVA8rsCaW0P3/Uy+6lv5QyI1sakOCtIOyE88m/IlCvlhJ1fOakg9K4qYGavO9DIx+wE8pCwt0ZvDBASmq9I/B7q3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KC9UTfC3Fxhx3C+G0+AtHum2HRR7VQnEO5IQXJ59IM8=;
 b=HaFYXWp/kRR3rf+YKxOttkXkTUOu85gOORRGK2ryswk2vt9OfYT+wrv+HM0tnk/UwPHl6dp/SO4RJIZ4PUd9KcGif5cfOSXyKdwJ+ZG7opuiVMdsVAfjGWWewliqQnlrCJeJvy2wuATJ7Kr8RsjN4a7adi2TtP372kovXRYJrh6F6LRDsAQpUa/ThkgKbXelSohgh7JtR/naE8mAknI86U+fBnYQgg5iTTrb3aV72z4x+PiXGTHNgpwwMAYVuwhaUmYW+BD36i/TzzWVajKoMozgGxk3ZPIQEV1q96xi3WJiMfquyB6Gu5nlVlwZ10dPo7wJv/GL74HUHGEoV4vfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KC9UTfC3Fxhx3C+G0+AtHum2HRR7VQnEO5IQXJ59IM8=;
 b=JEfWdhuvTU+ZyXk1yYly1oDFHbM9B8mvlvOCpaAa61NS/qi0vVcDk8nhpAHY0+JjALe+nC93gPGGBsvyHXs4PnabNU6I76KMXacUzR9gDuzCjdiG7sRJ+15GjQreXG87BbRbi7xURJQnPuxXFpaKK/xLkGGs4FurYi1oEzHtO4giAoW1koMDISeNyfxG4NxMi+xG2SwK2L1baVtx735UMpkvZwknN/l2MlJ+qBoOXOxuhkCWgNavKjZrvWauaf16w08uOaiEFOFR7F3WafgMzwM+zjOA6BdZG3riqEUhcYF3BIRW3MuZmqOVmu3Yw7AAztK8k6JpN/JNwh8YxXNvUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:49:10 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:49:10 +0000
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
Subject: [PATCH v20 06/20] nvme-tcp: Add DDP data-path
Date: Wed, 22 Nov 2023 13:48:19 +0000
Message-Id: <20231122134833.20825-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122134833.20825-1-aaptel@nvidia.com>
References: <20231122134833.20825-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0185.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::10) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e51cb0-4024-40e9-54b0-08dbeb61cda8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N2T2IEtHp++/ZJPp9QjmEajJVi3B3eZi7sA0zHmr1d4WPQIGCQhn65lU2yeHitoBx3zJ/tq+7ybwnNVbcLxfGkg22v7KRXa4DLP/iyv5TIKyUpXiCiNPbSLJd6svyBT8+Y7ytXMMsS3790mEn9e32uRpJOhF1E1b3fYtOWYxX+zDPMOqmPkH43jgyCq1wY8gbk4a11Y/1DdF8dgmCImRiXRL8PQOe0SHI7yCSuLQncIMrYZwGMJsxyqZT6ftwQkVQ135iLiSU9ljJdAtQE7BrPC4qMWpg8YxN+wIpfBjYXYjx1TzpmrJamFuy1XMVueWSjSvH4oeJ65/CNGds+q2je3dG8QL+tU5I9QJKaDx72vSTzfRzKTTdC6f6hRSuJ/O26lrlnbjpH3p87RhZBHEuPJvTipmdLzwNZuFhzEgOImR+2+8iLIShUwuV53TH7iEIH4QDa2jsotyCHFnm6iUmLfYQVDX+zs1clO8TyApnKoXSZxj3GBapuE3BZV2MGnbUj9dDUYcl1P3NFJ4cEvkVbu9/JK9oxLI5RjlQCOEraHW2Y/8DWyhlr3gkM0zdCFH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(5660300002)(4326008)(86362001)(8676002)(38100700002)(8936002)(7416002)(41300700001)(36756003)(107886003)(6512007)(2616005)(1076003)(26005)(6506007)(83380400001)(478600001)(66556008)(66946007)(66476007)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z76VPA5FvZIpDrRp8iwCQFtPpMfX+MSPl6BHwVpqWfDKXbR6qEtdNy07DbEi?=
 =?us-ascii?Q?ffTqVWkfeRbpwlGLqMZm+glbo+Of7y33KY3Fo9NSVSRcxuFzLLATajqESL1f?=
 =?us-ascii?Q?QDCDUTkoiybrnf1V+R9E8WG8rOwaI+A1If9yGy8tefp+m/7NuYX/Ih/gJwge?=
 =?us-ascii?Q?mtretGbN+XZB+w/jOI9gOTGgJz0WhWg9fBYxSuPNACO/q3DBfpRGi+in5Si2?=
 =?us-ascii?Q?+4FP8nZNmsHdv+P6vxDT/R5tK79i/XKK0ufljflR3nciOUO0zv6X2AsrhYAP?=
 =?us-ascii?Q?9HBM2OpDsAmn9pGAVT1vb6L1wcWgiuf51e5jsvnCyMtMe50xDxp87WNB0KET?=
 =?us-ascii?Q?7C498HwjSy3r3Nsve88GhhX9yLs/SYnK5Ueh2GmemmxHGHxfQoDXcICe892r?=
 =?us-ascii?Q?BVXNgf0Zw2VYK/asKgtJppG6Dix4X/xBWh0xoidTs6kB0VtIJxW0QGycwwSc?=
 =?us-ascii?Q?hqOI5ZWLmd89VSuskGqUfp0vm0GQLC7lZlHxXScPqqrAN1NZc5nVDpcMnDAC?=
 =?us-ascii?Q?ptf1WoJ1p3t2diocQyA0kUbM1WTMvWpm4I2z3rF306MUE01g89WGh6iORhCI?=
 =?us-ascii?Q?zZDlTCChr3WVXh2obYosLVPjuArwoVAd1CX+W6izBH2QdcUa6e2B62vOPKs6?=
 =?us-ascii?Q?9ZrWR3AT390yrWWTTMfYOl/rjufjrajJ+tdt/Kb2fHv7SmeaU7/k9rBFXGfe?=
 =?us-ascii?Q?Dx1xDNabVaXq8CrsZWpeOa/KdMfTdOsVms1aiuc/lS9LTd9uY19iJfLgc8OP?=
 =?us-ascii?Q?gT8RcMUApAJ8jFvWGQ72Fmjl5MhzifvmUzi15+LdkKeX+JKeoeIynppqACpM?=
 =?us-ascii?Q?OhPcJkJC71ofEr9WJRfTpETod17SrH8iWEXzhSBb9MVxC4ppjXYOufMCV6Ih?=
 =?us-ascii?Q?doZETgicEkRulYoIYad4f30JQ+hF4MEvKuJtvf4fwiXYq6CjYnN0ckr1tBl8?=
 =?us-ascii?Q?VyuJdvNxlhRwJyVa4KYui4b7gP/S0pv5LA4ZJH67M+ji/BwRE2lJUtrrEJys?=
 =?us-ascii?Q?bc4cSowWwlUWxmKzHmkxLXY6jEjUJnQKt2I0DUx68WDtgrEMwt527Quc3I9K?=
 =?us-ascii?Q?yFY9ZgWSTv+3e/lgtMv/hP7F6Nnjp0jFGfM0BGnepx1573lt9VojTr/8AL3N?=
 =?us-ascii?Q?wfYmdP+iQETy4BEutFJQsrMtV/yAlPyBwxjshE+VA9EadjDgJ3vA1897taJT?=
 =?us-ascii?Q?01J5DIFIncqLnEysC7WqPsQSutqLnz30T3x+kMUrF6ocH/APc/OklzjfjnSd?=
 =?us-ascii?Q?wlGn4FzeHPdpQLs08TyZI1iLJEUiYahpBr5FZExJ0sNTWMr26NL1qtWJGDp2?=
 =?us-ascii?Q?fxacXgBaZB8GNqgCOFGNLkBqBlkvjakj5TgRxZxicuffXAuxq65EGWzwQMXA?=
 =?us-ascii?Q?GVrdvemQ+wRao2HmRVAmBTKveDfoZASGZ8B+HxDHKHDxL8yPbRe3O4zMvQR8?=
 =?us-ascii?Q?nT3TQ4bmAb56AUfHk2Kauks4EIerKJKEPxdQusj+6jt17m1VBViS1AYhUO0G?=
 =?us-ascii?Q?zBMvPuyuMWLR+JCE4BiLXjunayYEUpb+iolsHddmPjl0ZCE7i/KEqQwxZNfh?=
 =?us-ascii?Q?GZ74BGeNHj0bAKNKKhXw4bS8xCRSzBTtkmWWlHqx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e51cb0-4024-40e9-54b0-08dbeb61cda8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:49:09.9725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoGHPiTffEGy4ZD889P67KxRdlTGM9B8b5vpbde9ca/ADCcfkIXIRoi26Z+lbBDKoZiiB6C8MWWi1UxyW3RSeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

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
index 7ad6a4854fce..680d909eb3fb 100644
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
 
@@ -2724,6 +2822,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
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


