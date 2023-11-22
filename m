Return-Path: <netdev+bounces-50055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14637F4825
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 333F1B20DD7
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E542D622;
	Wed, 22 Nov 2023 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W/nqjXUu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B8197
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:49:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaoOErEhivR4ZyCbVjD7fNhPG0//gHEhly9L6dixYcARmiOpMyVHX/pJ+p+ms9F86GPY4NrjQb1QUf3Vkhd5kXbchFVBmYO0T5o0uQ4tL6smm0jYUnkPPpEZgopxMTxPt4J9fFjmLwnUxkaSnfLeO/8ikbt02lGJfLDTp5+Kwgz74jPEUbPzBF6xgFdGtKRkcivq+iwqFpKIaN6hRDI7QQUhK1lYgPMOd6eJ3pMWITYg47UgMqOYZZyYtySkj7o+jFbcLfU9gAsPCJ2KN3HB8BYz1j2l1D5ZyzFXyb8x3jEzqsZOC2iU3UGfBjxpiS6sZhfvtog+rWUdwNVD9laQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+IKpMwkVbPAnm/9yADMRdHBqK7QWNwoQAuoHcHjFyo=;
 b=b6I5zUpzkAY+zleecM5NfETlbVm+K2QdI14gFEDokNEebT2aV4T67Ti0d281unwvfhzhKLLtAiM7JLrnYCeGtOnbMzuZRIIbqzY9m6bpQpqPlVIbrySYosIxXikVq0YrXfnsQ5xS8bGn0gyYZZ958n19J8Iuk+8SGoptjJ0LeB/ouSK6/WD8IxBaCpUw97g1+xe2J6Z9zQfunSuY/VA37LIFb6DsZ8pEAFPSIUDRbmJnhIvSCrT8TNrhxUze6i2WyE+WmLiparybGdaNlOVZUiTNnRqKpXqP0hdTVXRUmVxakxCBQA2fpQPzpwrA/R2xK2Z13ihlBEtpbxNjSmAEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+IKpMwkVbPAnm/9yADMRdHBqK7QWNwoQAuoHcHjFyo=;
 b=W/nqjXUuxTU5SGQuhKR9yGgyGVyd8e6413Z68H/I5wx1fuazvym8mhCUnVKFGcM9yPUbZP1Z1rV7j12MqYxN1NVdgBnHWyp4hGe85INLXAQqLu+jGTfDDsk1Z4o1upUJBRGwTivlp2R/Wpq+iQX8fExOdM/j7zt+As2s5VzKvJdCkbb5zVLl+NdbPn5EksGiJl9MNdFJrPo8jNgHwxPauO46V6JfPYfGEjXdhHsAu7kuv51uJsEc9Zgs5tPdZ0GecF/sN1hMewNvXVUeKBXvOHv6YCcu4zHRN8C/jwnuZObfck6ot5Yu1xTZcpR/7vZjFLFeWzkdhZbpH7qDK/hfVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:49:16 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:49:15 +0000
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
Subject: [PATCH v20 07/20] nvme-tcp: RX DDGST offload
Date: Wed, 22 Nov 2023 13:48:20 +0000
Message-Id: <20231122134833.20825-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122134833.20825-1-aaptel@nvidia.com>
References: <20231122134833.20825-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0494.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 955bd39a-0560-4673-bcbc-08dbeb61d0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NJi0t+8Tgy/l1j+ktYVEIl+WSELZEEc8uT1H5RauOOcgDvf8QFKnIYRuST/1CxdeNCWPNVyvQ8hgmPpXCSBxXZj2qgWsQ/P6uO7T8JW8HjF+vAoW+6ZYfMfdOzTHFeSWqCVE/oGX/rZ8HO39q4NtUqMQv3q7vkGcgn9tzFAw2Z/w0/7OiMMv0CxeRSJZ3zCLM79FRzPGfdXpEmXy93KV6xGDPHpZr5VlNyg1MRkRjEaOf6WRU3s+DrNBfH41UAeh2TsiEVyJx0S7d9+O7YaX7+KufJ86i+OPwDqS9soXfUceRckjg4NbrOm2bZrqt7dqGnG3v28UID0ESbRI38LZh+6dLvopB3BY3l0CRbjatgbUWzVmm9FQxzx0TshwmFSY5CwcVeyRrtnpwyHoityBtuVCWmgiY77lqhb8E/NSfnFvUKfuLhkBMq2HVCCTBONjUHf0htYGH4pldU/fWMFHldkbOP1+r3P1ANnTMppukZXbiK+DyEudiuFpWGTUWePvA0R9lGcSHiNtLf81+18qFk97JL7hvOawxlL1sdZTHbvAoGOIUaOjeSuwERaf7MmX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66556008)(66476007)(66946007)(2616005)(38100700002)(36756003)(86362001)(26005)(83380400001)(1076003)(6506007)(6512007)(107886003)(6666004)(7416002)(6486002)(478600001)(2906002)(316002)(5660300002)(8676002)(8936002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c0BqXJ46S1EhtGJwYnnfy6PB4XE+a/XEsEZFFUhXhQjFRgM+ew+kwoUP5Y5X?=
 =?us-ascii?Q?RD6AGgevx4OSLiD/RykaNgQlVfLEejOIj8U+raWncqfaU/PHEHHuAiNK0Hah?=
 =?us-ascii?Q?u0dpf0mefsiiTU5VpHP7JQJnSRwD2OcDGrkzZLHg58KsXk2jIBh4zcNKQV1v?=
 =?us-ascii?Q?75KHgyrZyKUOH/bdICrJdxqVvU5ohBuauMVhpkqNEtAC19nHGr1drAJ3M8WT?=
 =?us-ascii?Q?LhBPUKfIp6xLoCsqGTUfsnCLC29Zs/h/ckFSa4qo/3p7W30mBDJr/wrzphO0?=
 =?us-ascii?Q?BWMq8c0ihjGPMH8mUxvDbzhHWB4BqbjwpSvMrw3SkUnLAMl0Y5CH8qHpn5Bp?=
 =?us-ascii?Q?CDtAXtcvlPP0fv/6WtYm4cPB+4SUDAOCMLa4J2FJKc7uuu/c5abdqk29PJOm?=
 =?us-ascii?Q?Q5sv7ZGWSRWuDt7Zx4xE5c3LYmVPz7/FwUxGucRxzO32xLoQwglqYz5lJORH?=
 =?us-ascii?Q?fpZPR5J18dOxSeS7v6ZfEKAHnl10rhnN4NyrZ4F5LfrckRsv8TRaQS/kx1VW?=
 =?us-ascii?Q?bXZNijEIAHdto1/rIcWFnC+tO37WW6u9ciI+Sg2NYmSkeVIIHcROwud0Ygdi?=
 =?us-ascii?Q?gKmSpkBzmGresuHEHn+NXY3DLkKcnr9qqydvzIKhOZthBveI0NOa9wPHH0zi?=
 =?us-ascii?Q?YcGQG6dA3WFTMUxYQOe6xp1N2QF3XV5uzj4C598XXuecPiem89jlXCeNOr2M?=
 =?us-ascii?Q?alVc8c0AZ1b3ti11CRCGzP/Fak6W+6W91VTjTnU0E4dYRz99FkP2wbtCsNpt?=
 =?us-ascii?Q?z1OP2yhXyWNfnYY2HZREUjOuPu61k174NF40a/X0MWUm774pJ8TGKRLtamWx?=
 =?us-ascii?Q?vGLxI7O0scALWs0tTY60kNq3uf3DkUJYc2VOAWbZppH5D343Qnsk3jKP8nVn?=
 =?us-ascii?Q?bOYkg5i41B/tSjlUgNlvPVi08yJxXICGKn8huN5ksiJtvkTtoEae6MKvqp+0?=
 =?us-ascii?Q?/9BJ3WcVT+WII8ga1b2RCMEAr9UNGdx3AQOjGvhULUuqCOnj1humisZBTCei?=
 =?us-ascii?Q?t/opz4G4V6zWacNuiv3jcxUXsNdWUOvZ9w30EZ8f664yr0mTgjttrF8OCClw?=
 =?us-ascii?Q?HiBljmZ7BL6asHzimK7MzG9NRraL2blsCNLl6bOkq4GmGEORRYDc0W2msNYF?=
 =?us-ascii?Q?/rOd93ILB5IDFjkFDo4Zeb+c5ltybF/I3itVde90lCEZI7U9foc55oIdfrRu?=
 =?us-ascii?Q?ZIurzM27tqUyuD4GVEdf/hTYPL6NcG4YSfJV/nfIMhWlPqrr3Cp3GvSCV8vV?=
 =?us-ascii?Q?lVZCqOdBV81RLTeYYkXdogv79VQO7giGZnsFRpKEwmsemaZaxqojBtlzMp3C?=
 =?us-ascii?Q?pm+yQx5kJHdt05wNq4MjiJMcDLUpMhMqcWx5g3XLthPtvLL/GSpMPfoNEfd3?=
 =?us-ascii?Q?atikY67muG7MB6jn2dAzEUqX8iwH0yvPjbmU2p/AAZ/4DzpGiFzueDz9sY7q?=
 =?us-ascii?Q?K9tkVHrIeXY4d79qc2qk+bR6KbXRQahFHZ/lPx15k4mUFVtUZZKDYpTAUton?=
 =?us-ascii?Q?274iQkpwznv2vstTo1j4UqMyAn5X2xOdYTWGjS8YMLqeji6W5DsFLavRhYJ9?=
 =?us-ascii?Q?4PXFnJlxqzVGpmFcumEjOpLbq4l7xu+aeKzvx4Ps?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955bd39a-0560-4673-bcbc-08dbeb61d0b8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:49:15.0677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bZQopJMd4aQsTBO/9an9i6y1d3l1zNWij2rSYjrhqCORlaxUdPW8msz8P/gyp9ZUoDAqFxwbZXwa08weExAjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

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
index 680d909eb3fb..5537f04a62fd 100644
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


