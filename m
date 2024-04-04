Return-Path: <netdev+bounces-84857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE916898808
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6221FB292EA
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A86612AAC7;
	Thu,  4 Apr 2024 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OTVak2Tu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2124.outbound.protection.outlook.com [40.107.93.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A787A129E85
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234281; cv=fail; b=munDEwXU6DFQ/wx3rxtmQDSHcSeB4Uo0J12MGjmFVOzzWFskBw1+erlElaU7WLb0SsSbu7nU67GpTK5+7OFAXNX0oc+4uLFT7+Keo4KcJBGkUsOuf9HbBVEwWPR2/LDvX8AT0bNe6w99buaKv8MfLVWPMQP8/1Ivnr421wmYH0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234281; c=relaxed/simple;
	bh=Y9YDts2rqbsWba3zAZ8mUxGzDuNtTg3h8cQ5PiOubsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ABytCkhqKDAkGX2D+AwhXteXdSi0oE9efvEkx7jqwqOnod5IkUck0IrAYsobdO/MI0tGhg9QeTKkPMIWl05OiUhPLMHi+kJ0T3Kbr8E3Ye3k8hzdVmpxJrvY1Poip1v4NHQymg/mMZRFlUxVRYVQnQ8jnCAp9MVNauFeqWTAlNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OTVak2Tu; arc=fail smtp.client-ip=40.107.93.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMe6Ko14gRybTuOXfqMB0XCAp10L+C2lBq7BD7/QMKHXsUwIuCs+Jpuk4Vc93A1TqucKkitZH346O0jBWMJVfddXRqOrhBWL0FJWERonu5h/oBZhsx+V9vzlf269sN05sEd2O2CNAlRGCmCWBhWZ3uPDWIiNXWbaYmKMRYh0ZrjAHfy9weROU4XMKnB/wnVH2e2xXf9ihEQ1KxL8qYLQeJRQ3EXIqAqnzZRJCULMobGCVaG+Pf2/VuL8+qRj8bEfCLXdtQPkJzkoaCTuEL9eH+yII+44btRVcur0yKcnOSwl7DujcbFQYo5GXoznEI4Lm8KYqi8WWmTGlv+YJPqBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiTbEuzQCc9zbl4bxG2gcVdbpaphHnP4hg48REX6ohY=;
 b=JITCQHXX1F4BGwRgavBYo8NyT3fAo533IkANGZwLTUPWN6XDrUDcrQlcniB/mYh8f9p3DDxHsKNxy6pZ2bjfj+2W4vVwFF+tFAMjOw1rBnUS10x4HrnzVCA1EY06EVhVEUKOkL2LdUwkLuvAmAy7v11GOG42wnBRuMlqelCx7KNyQ/ercsCoRFdhJoZZ3cuTSIq6pnG0RUrsIVcoQhCav0tNmqh9ZGLYefBLHLIXZHrkK6u594dkZ7l6Xc4ikOKkEqzXXGk4j1xDq5mq/jTAewQ+AeoLjILc5T+27ddezZ/vLxTj7L9L0TncD3sVM18c84IU8/pDrEBligfpvvNTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiTbEuzQCc9zbl4bxG2gcVdbpaphHnP4hg48REX6ohY=;
 b=OTVak2TurKTBezeBLxyPRwIpYFmmJopriJKhCQ2Ej2+ALjbYEVqVdpMUzP28sWJqja8jfkrTsAZPeMiDf4ou3vKVtFK88ZHZBEsZgY+KKMiuBtK/bWPOdKTTHEKOPnsA5Rl8wQVzcwXCN5Wle3jVnRyNDnm9XHKacB9IDYnGyAA+dlWav9zxyjjyBMA3m+P/UIKPHPFqS3TwNM84ocv9FHfkDQvBzrCOBL/qHOOea5KcmOW+pnO8yY5NaGMcR734KzZBKPUIHu4W13+qdmEPxpLZypE2j5p7NrXsl5hoyu2Tpg+b1CKN5l4ZGtN/SySaaJEolZPjlTPhaSvyfqPc9A==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:37:56 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:37:56 +0000
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
Subject: [PATCH v24 06/20] nvme-tcp: Add DDP data-path
Date: Thu,  4 Apr 2024 12:37:03 +0000
Message-Id: <20240404123717.11857-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
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
	KZHMlTRfMlRZbGLyRH1kPn/g/FbhfTogMK4YNusuOIfxfpmpwVAS43ylI33QgDc+Nh/IF+hlvTVjasSBVD8v/G2+GGa1ApKNiVgRp4VJj9lRsLsf3QsAC7ASREXOt4U55f0Ksu0+DP0Twtvon+OLcb/K/QXYVF8YD3BEEZV7CqvnYbIN3luJk7XgPEIqYLwK1tdxOYRUpl75ckFehveYNGhBYmwBp/BNUNOE5QGTkguYB/0EW1s84WtKp7mNqEKD15/C6ZtWoDqDFgYwCP0RnSFLkmVu9iozIIID57+iXbv3DlNUvEbXbDKwmH+a7Pxz6jEI5eoCD3AzH+PHSwmO/JvKezqjvANC9Bti8xFXavkfsCXnGP30Ag22KhQYsj5yWWUIo/tZOvLtSo1/q/irYH+3v4n9Bl2ZRJ8loObp5eqv9/ran4E04/O5PC1QjzxqddS08p1Fj//aNdIEQ3velMxydkNXk2hO5UlP66pe3wwR2L8Ft6RDbt6aYzrlvXTRMXWg5dLj5ITuNc6FWnlpDPShwmLljoXp0Ruvlb9bynx0mvxXafQyM9mfy5PM6/q4yuhEEQBU43wyS7xme3c/ssQHcW6adKyI8kUrWMXwxNt3yzW9irAnBOuTSHaUSwELanSbqMq07ELHT3Sd2bkcDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J0chn3CypqD1f6WUveFEJZr/v73OYRoboGi2bk/M0I2eHbHfvXEqPULtYHD3?=
 =?us-ascii?Q?FaCXrtYIzm2hlGD5AZYuk3iLrx4UJmca1S969BNp3mcMj+543g/I8GL+1V6v?=
 =?us-ascii?Q?7yaVlEfBYk5sMpPaHIhsjRJ1x+jJ3G00vDA0HEhXBJtUzWsH2Hi2bD89xxM0?=
 =?us-ascii?Q?dpA5FiluG3/rn9u89JBmrA7p6eTlu4w2Gsnmp2VqJFiJve2KSj+bH/IdZHyj?=
 =?us-ascii?Q?2s3mlzZlvgCoiRtRFti7nuSVqX6WzEWmpVlweXxkG4sHhMAZuHaHJ459bQMB?=
 =?us-ascii?Q?WeuMevPY45hbe/Uw0lf+QnakPtDdlAPH7XOwjY0Vyl/RIP0YKWXw5dKv0Nb5?=
 =?us-ascii?Q?kstXNS9ANimv5pf9MdYU3frBpEAQ7UO7BcTYQHk3zYBKwXoYvCAsT2t9tx8n?=
 =?us-ascii?Q?bhiM4EIy0EDuB2ivGhP9STKjpbUbdYsue3JJNfyRSS6+C8Ldf8zaV6nJ4aA9?=
 =?us-ascii?Q?c6C8p9OKoWy456h/wESAes/CwqwlAm/WNjIXZxRwhyRo5Y5NbyH7rItnC4+C?=
 =?us-ascii?Q?EV+3RI4qUlDhlUlkdGchwNEZgGYJ7Bur6MmSMlakwrrvznySHhSugAztttCp?=
 =?us-ascii?Q?yVkL4Q2TsdJadfTSTzfXzqsJkcklnSwNN/Mor9w5xL0Kydc1o2TvDwc98ACb?=
 =?us-ascii?Q?wjVqu5VBOIqtro73OTQ1WCERjdGMO5Z41RQH0MvSqQ59Lum3H42TfEM+j5uq?=
 =?us-ascii?Q?nJvjVpLHF4Cq63d0HmLREO80Vd6uqDW8WshNir/MeMLrusG/bBw3y8Ipe/pF?=
 =?us-ascii?Q?sbTBOtc9Q4fQw+43FuWEanjRhRPQ9AeaGX0dJS28/YuLk3vslL/lAsZgCHBM?=
 =?us-ascii?Q?k0sYgCuWNmvUqNbqkUCUKH4YLVUx1iwerQV5Kqicwy86A6URO8FI5M3u6ITo?=
 =?us-ascii?Q?D9KimKsaT3cRYJ80yfTHfr8BuPXBIhOqCOeB+w2ZmxqjExShrU+XWd6XnSQd?=
 =?us-ascii?Q?LGfTjQXjXNFuiQSewzSCXDTdogHXqmI7EajX4jac+4N4I7kGqz2AYR5OC5P8?=
 =?us-ascii?Q?Gj4u4SPXnO4fKJoFH2S9+QYuL78NOiwu+f7Wce5ILwQWp/uPew+/yfgcIpH3?=
 =?us-ascii?Q?HtmR0lxZ2XE1ACG0OOuga5sTVIKmWBo1hNmFUOgNAP1Q3GE2g7nQswbv8Nfy?=
 =?us-ascii?Q?yDEOMfoaJM+20VxKALQ7dkcXdM3AowPh5BThrkv6gEQ2kWzRJ9Sm3S1e3WpB?=
 =?us-ascii?Q?LHw7QdcAtO6xnBaR/Grfut++iuueQ1jHoKeUU3Xh0ZhtLwibnZ4LPGpXUSv6?=
 =?us-ascii?Q?LryHDfTk3Zy5XYpnuV2bIZPzc7Wc40rtCsXz3I5uZYFnnPk6iiyMQbQuC9P/?=
 =?us-ascii?Q?19OcO1Aqm1fS/wAUMl1DP/q8yPcBE2uOH2q/MEmSuK297nIIwtG18BsUOQx7?=
 =?us-ascii?Q?QiVG+x4BzDsyTwEn1roczSqFjXTVvwd9kPH42jKbwgP4OQEhrk1DKnnrluLa?=
 =?us-ascii?Q?vtQeOq2mlxiwVcp59Eo+XHOdPaNxhOOH7rpghjkR0uH9gVellhh8EnzJxzpW?=
 =?us-ascii?Q?k7fpqUpExNgZn1H0gc0SeTrfYB9Ln6KHbtfSFTLsX2C5kjSvPs3u3Og70nkg?=
 =?us-ascii?Q?7iXFcuEmyjByvgH2gQ+W+KZPcwMtHfv0LA1oQNxx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdbb728-27cd-4a11-0079-08dc54a40dc1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:37:56.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YP9tQsyRBF4DVlx+XElK2RMrtYz8kN0AFPHGwPTjb0mPTCufwjS1nl1AGihMxIsB6aSsGhtrvI55HfVb5ZYBrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

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
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/tcp.c | 136 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 131 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 529eee4b8f98..345c7885c476 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -128,6 +128,9 @@ struct nvme_tcp_request {
 	struct llist_node	lentry;
 	__le32			ddgst;
 
+	/* ddp async completion */
+	union nvme_result	result;
+
 	struct bio		*curr_bio;
 	struct iov_iter		iter;
 
@@ -135,6 +138,11 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+
+#ifdef CONFIG_ULP_DDP
+	bool			offloaded;
+	struct ulp_ddp_io	ddp;
+#endif
 };
 
 enum nvme_tcp_queue_flags {
@@ -341,6 +349,25 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 
 #ifdef CONFIG_ULP_DDP
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return req->offloaded;
+}
+
+static int nvme_tcp_ddp_alloc_sgl(struct nvme_tcp_request *req, struct request *rq)
+{
+	int ret;
+
+	req->ddp.sg_table.sgl = req->ddp.first_sgl;
+	ret = sg_alloc_table_chained(&req->ddp.sg_table,
+				     blk_rq_nr_phys_segments(rq),
+				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
+	if (ret)
+		return -ENOMEM;
+	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
+	return 0;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -374,10 +401,68 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
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
+	if (!nvme_try_complete_req(rq, req->status, req->result))
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
+	ret = nvme_tcp_ddp_alloc_sgl(req, rq);
+	if (ret)
+		goto err;
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
@@ -480,6 +565,11 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return false;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -497,6 +587,14 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {}
 
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{}
+
+static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				  struct request *rq)
+{}
+
 static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
@@ -772,6 +870,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+static void nvme_tcp_complete_request(struct request *rq,
+				      __le16 status,
+				      union nvme_result result,
+				      __u16 command_id)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	req->status = status;
+	req->result = result;
+
+	if (nvme_tcp_is_ddp_offloaded(req)) {
+		/* complete when teardown is confirmed to be done */
+		nvme_tcp_teardown_ddp(req->queue, rq);
+		return;
+	}
+
+	if (!nvme_try_complete_req(rq, status, result))
+		nvme_complete_rq(rq);
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -791,10 +909,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
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
 
@@ -992,10 +1109,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
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
@@ -2739,6 +2859,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_ULP_DDP
+	req->offloaded = false;
+#endif
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2777,6 +2900,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		return ret;
 	}
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, rq);
+
 	return 0;
 }
 
-- 
2.34.1


