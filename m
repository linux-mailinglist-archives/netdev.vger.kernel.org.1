Return-Path: <netdev+bounces-50053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C897F4823
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A41A1C20B24
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2BE3C09B;
	Wed, 22 Nov 2023 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UpeDqHLM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B043DD45
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:49:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImVCLqCsac7tQrcUXvHRsv2nlEoQ5hmvncuPVAFvFO7dLA6PYt14KfzsdVOTJBgtupJvRbkleJlhu5A209qL3/LMH6c8zmEqRsk2hxaF7ouG/g9msiQsLaLJ2ysaRxjepqiFUihZqqBIccAxzc1/4rBqfYM6IdA4egj+dOYcCuCRYuCPBdSW/fl8lwl4i0sPLGyUb6Yonc5jzVMsvGQ0hpxy0xGalcEbizGhlwWOBwtR9RjSNv3VDHLhC84AH8WGB2bTTVY8F6Z1Qw2p4LpAAwvONpYm4axg/ekKqu/D91Kwh+Fz4ngUdqvbwqgj/tfVdqLi4xcNS5DLwWDsPOpkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbmT8M+jF/QiAf5flUmjJCnUp/2AHKQGYRmY6o5kWRk=;
 b=aEV9a3lzKCLBvOyeH+h49Gd9e/VtFCfj9rAUeLJ9NhqPa8GKFVk5tzzhqJ1joXnD7aVTrp0mByyZLV74ZQnpOlJF3o+zBxeNPncVyRPHlmvnXfw4bG/EtqdX0G9UAZH27RVQpFv7m0/pZlTuG+047rRWSAbEwQbqZ8Jn6g/jjYfE7KO2onC0ejkvqzOxSfXiG5fhygESvClViVcpfAaiKuV37M/rIU8l+Xq9ivDhCkzDysNKEtnthYyHSV8pJkKm/Fo+NN/vBSJBQk/dSLbkowqHMALgqENyp1g4IV0yjidQ6wT71BXZZOkGdh7JeBzNFr6nJ9jNAHzKEPu/zwd4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbmT8M+jF/QiAf5flUmjJCnUp/2AHKQGYRmY6o5kWRk=;
 b=UpeDqHLMjMWQnOAkB7GhA+0hFN5ccRJymL4yNMyO5h2QCHeax/UI15UZUEvMUDvaHFnXF7OAL99oP29LvzxkXRLMUojsjEoeUBW6TJ6XyW/3FOqbcup4jpRDGX2OjZuLo60GLBFDoUH7xo3j8V3i55UmXFwWQsWngY+BhkLAkH1ldKKe4jT93bSQfSF0A+861UYi2i6nEmUrJ1az3Zw3wPJi3aSIpmTpbgqQeBucNc6wcJn1mmNSz2s7lgGbNv1KtVPkXojYrYPuBjNcmJYhJwyXMTgv0QVn9pZG6ABrkn+qZRnPxuqv9cTRPyCFHphEWh4QfuoTHeVhhvWB36xotg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:49:05 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:49:05 +0000
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
	mgurtovoy@nvidia.com,
	brauner@kernel.org
Subject: [PATCH v20 05/20] nvme-tcp: Add DDP offload control path
Date: Wed, 22 Nov 2023 13:48:18 +0000
Message-Id: <20231122134833.20825-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122134833.20825-1-aaptel@nvidia.com>
References: <20231122134833.20825-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::20) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f5b696-d145-4438-993f-08dbeb61cb05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nnw7hsdWTvXD2WddgQCjh22zcCMFbLtXSw09OIjO1etMC8uVCecGMUeCJ0/ORotrumtpNcTvs5OfmoZEyF7Y7ONkWBzkbJAqUuOnzrsKNWLwbf3CsvbNpDhBtfnc0jQP+CEr4kRjLnbKv/ZCyJo9SyVs2/pdSoWqn/dvym4IhwcniFi69qaeS1D2lE402nFhvNL/MYaGKMkgi9otOjPFhQk6+2bf/U22rsv5DDNcytrwlxyK7YEt42C9rCRmJEAcgt58YuQFpOp0uJdUYhxvbbcIGTRokBJ+FZLUQMwD8dBU6B3/Rbluy2cRZmjGyOMOAiUp7B1KRwMdJSh196lVjoztBB8pMktUlcbnh+nf9cTYLYzXMVmiO212K3W2GDroUGFBxTUlPinp5aGqbMrQPBNMjg077U4orwIhhdDVNRPGXSovtCvPFWxmVD44AR/ZvEOHYJUr+0s4b2xFwkBD9bGCz9pm7CyAhOblzbfs6IYsxPK8D+tuW0ld2V40QIOSpcfZ+9byx+uHDbKbwS4bpnZFuv88ShrkeqENRkkYWq1h61qkYxkXXbyMo0nphUzc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(30864003)(2906002)(5660300002)(4326008)(86362001)(8676002)(38100700002)(8936002)(7416002)(41300700001)(36756003)(6512007)(2616005)(1076003)(26005)(6666004)(6506007)(83380400001)(478600001)(66556008)(66946007)(66476007)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nyFB+0unRPGUuIUvCf+chxrPMFahz2lXdMaYl9zql7KOwIzyOHsarsGJTnxa?=
 =?us-ascii?Q?bbM8qtquZzH5H+uwVOYfeOGrIjwsGW+lE+BhqNMfYPDda/Q9qt32ARwhP/mQ?=
 =?us-ascii?Q?HrLCHLrLe6n5HicJs6auV7hzxcTv+4DTcXoLMTnMXRJAwfKCV9pIcalKIkOJ?=
 =?us-ascii?Q?5KfmD5xNq2zGVQQhdsnEXeQXuhbgQaoIAxd6qMILjPv/XZSCbU7WWT44Jgz7?=
 =?us-ascii?Q?w0ucyLX3w+tRpeU1aGwImMmiTUOIBoHPex20ZlLdc1YaVtNUOiJ2MKTIpSIc?=
 =?us-ascii?Q?UQybq/XZXu9X3S5O6JiGXbaWwAwv95KL+W3N0jbuHCfabpFPjmlnHEq5WZRn?=
 =?us-ascii?Q?pDLXwpQd7PH0seAoYdVzg5zSGS9kZuYskmOc5ZUk53f0wHK//gOcGf4Ox95Q?=
 =?us-ascii?Q?Z6J3SQVddaG7E4+CEbz7lM+NKR5zaejeuObmHkzgNA5xuRcC77MAdomLhI71?=
 =?us-ascii?Q?oaZvI/CQbowdogkoafEuRexum/e/MdecSq+99ziNb05dMbS2r4Z8zbSQzUEI?=
 =?us-ascii?Q?UE+9Y0fYgfjf/lc6PjYJvmRWFYVlNNVGXhcdTzx8pO26tEbx1+TQksJK3Whs?=
 =?us-ascii?Q?CwWPEzTdFLbFzOYQ+EWZ/DZd9u/B5BavQbjkPMA+2mOY6XyyRNNhC5F0R5at?=
 =?us-ascii?Q?GO3/GP2ROw7qbj2GYDDc9VQYrVL9RVJ6gw225Vr9OfLWIarr07FdG29FNOkW?=
 =?us-ascii?Q?82ixDqfzolngdqhHFx3dfkNBauqZ6+qhkaVXzI8JP+ERyxEpcaNrtetltXeG?=
 =?us-ascii?Q?9fDIJ5xo7nvbhGwEF5KDlfYvFu281vYV4fsXct8BckPVIC5g23cDvO1cRj+m?=
 =?us-ascii?Q?N78eIRT65RJewzGJ/CR7IIrzi88xtBcAwpZp76tmAOXfBRhJMY4KWPi0qeLY?=
 =?us-ascii?Q?ZbfH7FXcv1XaN/YCJiNIu20JWx3iZS0X0m5puPWQSTDUQgWpfSCZ8/sZbkRJ?=
 =?us-ascii?Q?/vCzsx4WItvLwR3eAXD8Rs1PrbdImf1pd41gdgz256CyzO7keKFWsZsCGWyP?=
 =?us-ascii?Q?WxW1ile1UTXtpgGzfl3AwZ7E4/RC37/+evndQrE5vWHSe8djKRrLJoH5pIQ0?=
 =?us-ascii?Q?QH5/ZrCTBkgl/fAHrAXlpyD5vQ+g2bnLGPdtQnnQX/P5TvqeR54PqkRr5u2G?=
 =?us-ascii?Q?CqmFgC1v4a3zDXcmv6IXEv/RA8a0ylPu08FAxXxmtLkhU0p7KplalvfU25Bi?=
 =?us-ascii?Q?In26dFNmQg/9C/M9KaauuzyDlF0S4v1xUGVtZLEahNEWrcKih8+oukdrXdTw?=
 =?us-ascii?Q?T8iRD0yJQoeZgB1wgIHfNkvva11kmIxqv3WwFHLC1vyRYmKlNyM6ha2N39PL?=
 =?us-ascii?Q?CweAg8dTxIwkQW+meUIyNIXAsj7fwnocv3GGGumnOExODN4MBipZbQaTspqW?=
 =?us-ascii?Q?0F/CVDXnS3nD25wOi+qLtYpl+u690U/49ml75qE05Ywvs+KJ1XIAxjVTmbNy?=
 =?us-ascii?Q?tzOLC+Va7hX4C4kWVSJgLK+G9grow9N65/QJYNcIP+CYtl5e4YqJQnW9HEjM?=
 =?us-ascii?Q?j9KpdF6wmvefsZ09l70wyo0KyaG4gOcZHScTIcr4wK6KMwO71uIEzr/T0H4K?=
 =?us-ascii?Q?3uXf9GqQO0ygr4O8Q2fqUMqzcp/Z8dd0EtvHVQZM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f5b696-d145-4438-993f-08dbeb61cb05
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:49:05.5770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/YAeKq1mJgMTS2uSS9DqHGTewxny8f8NEEROF34h3IifA4eBKsRzlLcCO/BGwOmWYp7jisI0FZPpi3YDebSYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement offload to NVME
TCP. There is a context per queue, which is established after the
handshake using the sk_add/del NDOs.

Additionally, a resynchronization routine is used to assist
hardware recovery from TCP OOO, and continue the offload.
Resynchronization operates as follows:

1. TCP OOO causes the NIC HW to stop the offload

2. NIC HW identifies a PDU header at some TCP sequence number,
and asks NVMe-TCP to confirm it.
This request is delivered from the NIC driver to NVMe-TCP by first
finding the socket for the packet that triggered the request, and
then finding the nvme_tcp_queue that is used by this routine.
Finally, the request is recorded in the nvme_tcp_queue.

3. When NVMe-TCP observes the requested TCP sequence, it will compare
it with the PDU header TCP sequence, and report the result to the
NIC driver (resync), which will update the HW, and resume offload
when all is successful.

Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
for queue of size N) where the linux nvme driver uses part of the 16
bit CCID for generation counter. To address that, we use the existing
quirk in the nvme layer when the HW driver advertises if the device is
not supports the full 16 bit CCID range.

Furthermore, we let the offloading driver advertise what is the max hw
sectors/segments via ulp_ddp_limits.

A follow-up patch introduces the data-path changes required for this
offload.

Socket operations need a netdev reference. This reference is
dropped on NETDEV_GOING_DOWN events to allow the device to go down in
a follow-up patch.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/tcp.c | 259 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 246 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 89661a9cf850..7ad6a4854fce 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -21,6 +21,10 @@
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
 
+#ifdef CONFIG_ULP_DDP
+#include <net/ulp_ddp.h>
+#endif
+
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -46,6 +50,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
 
+#ifdef CONFIG_ULP_DDP
+/* NVMeTCP direct data placement and data digest offload will not
+ * happen if this parameter false (default), regardless of what the
+ * underlying netdev capabilities are.
+ */
+static bool ddp_offload;
+module_param(ddp_offload, bool, 0644);
+MODULE_PARM_DESC(ddp_offload, "Enable or disable NVMeTCP direct data placement support");
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -119,6 +133,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_OFF_DDP	= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -146,6 +161,18 @@ struct nvme_tcp_queue {
 	size_t			ddgst_remaining;
 	unsigned int		nr_cqe;
 
+#ifdef CONFIG_ULP_DDP
+	/*
+	 * resync_tcp_seq is a speculative PDU header tcp seq number (with
+	 * an additional flag in the lower 32 bits) that the HW send to
+	 * the SW, for the SW to verify.
+	 * - The 32 high bits store the seq number
+	 * - The 32 low bits are used as a flag to know if a request
+	 *   is pending (ULP_DDP_RESYNC_PENDING).
+	 */
+	atomic64_t		resync_tcp_seq;
+#endif
+
 	/* send state */
 	struct nvme_tcp_request *request;
 
@@ -188,6 +215,12 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	struct net_device	*ddp_netdev;
+	u32			ddp_threshold;
+#ifdef CONFIG_ULP_DDP
+	struct ulp_ddp_limits	ddp_limits;
+#endif
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -291,6 +324,166 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#ifdef CONFIG_ULP_DDP
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	struct net_device *netdev;
+	bool ok;
+
+	if (!ddp_offload)
+		return NULL;
+
+	/* netdev ref is put in nvme_tcp_stop_admin_queue() */
+	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk);
+	if (!netdev) {
+		dev_dbg(ctrl->ctrl.device, "netdev not found\n");
+		return NULL;
+	}
+
+	ok = ulp_ddp_query_limits(netdev, &ctrl->ddp_limits,
+				  ULP_DDP_NVME, ULP_DDP_CAP_NVME_TCP,
+				  ctrl->ctrl.opts->tls);
+	if (!ok) {
+		dev_put(netdev);
+		return NULL;
+	}
+
+	return netdev;
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
+	.resync_request		= nvme_tcp_resync_request,
+};
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
+	int ret;
+
+	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
+	config.nvmeotcp.cpda = 0;
+	config.nvmeotcp.dgst =
+		queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
+	config.nvmeotcp.dgst |=
+		queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
+	config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
+	config.nvmeotcp.queue_id = nvme_tcp_queue_id(queue);
+
+	ret = ulp_ddp_sk_add(queue->ctrl->ddp_netdev,
+			     queue->sock->sk,
+			     &config,
+			     &nvme_tcp_ddp_ulp_ops);
+	if (ret)
+		return ret;
+
+	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{
+	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	ctrl->ctrl.max_segments = ctrl->ddp_limits.max_ddp_sgl_len;
+	ctrl->ctrl.max_hw_sectors =
+		ctrl->ddp_limits.max_ddp_sgl_len << (ilog2(SZ_4K) - SECTOR_SHIFT);
+	ctrl->ddp_threshold = ctrl->ddp_limits.io_threshold;
+
+	/* offloading HW doesn't support full ccid range, apply the quirk */
+	ctrl->ctrl.quirks |=
+		ctrl->ddp_limits.nvmeotcp.full_ccid_range ? 0 : NVME_QUIRK_SKIP_CID_GEN;
+}
+
+/* In presence of packet drops or network packet reordering, the device may lose
+ * synchronization between the TCP stream and the L5P framing, and require a
+ * resync with the kernel's TCP stack.
+ *
+ * - NIC HW identifies a PDU header at some TCP sequence number,
+ *   and asks NVMe-TCP to confirm it.
+ * - When NVMe-TCP observes the requested TCP sequence, it will compare
+ *   it with the PDU header TCP sequence, and report the result to the
+ *   NIC driver
+ */
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{
+	u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	u64 pdu_val = (pdu_seq << 32) | ULP_DDP_RESYNC_PENDING;
+	u64 resync_val;
+	u32 resync_seq;
+
+	resync_val = atomic64_read(&queue->resync_tcp_seq);
+	/* Lower 32 bit flags. Check validity of the request */
+	if ((resync_val & ULP_DDP_RESYNC_PENDING) == 0)
+		return;
+
+	/*
+	 * Obtain and check requested sequence number: is this PDU header
+	 * before the request?
+	 */
+	resync_seq = resync_val >> 32;
+	if (before(pdu_seq, resync_seq))
+		return;
+
+	/*
+	 * The atomic operation guarantees that we don't miss any NIC driver
+	 * resync requests submitted after the above checks.
+	 */
+	if (atomic64_cmpxchg(&queue->resync_tcp_seq, pdu_val,
+			     pdu_val & ~ULP_DDP_RESYNC_PENDING) !=
+			     atomic64_read(&queue->resync_tcp_seq))
+		ulp_ddp_resync(netdev, queue->sock->sk, pdu_seq);
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
+{
+	struct nvme_tcp_queue *queue = sk->sk_user_data;
+
+	/*
+	 * "seq" (TCP seq number) is what the HW assumes is the
+	 * beginning of a PDU.  The nvme-tcp layer needs to store the
+	 * number along with the "flags" (ULP_DDP_RESYNC_PENDING) to
+	 * indicate that a request is pending.
+	 */
+	atomic64_set(&queue->resync_tcp_seq, (((uint64_t)seq << 32) | flags));
+
+	return true;
+}
+
+#else
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	return NULL;
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{}
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{}
+
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{}
+
+#endif
+
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 		unsigned int dir)
 {
@@ -733,6 +926,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, skb, *offset);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1807,6 +2003,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_unoffload_socket(queue);
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -1823,6 +2021,20 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_unlock(&queue->queue_lock);
 }
 
+static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl)
+{
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+
+	nvme_tcp_stop_queue(nctrl, 0);
+
+	/*
+	 * We are called twice by nvme_tcp_teardown_admin_queue()
+	 * Set ddp_netdev to NULL to avoid putting it twice
+	 */
+	dev_put(ctrl->ddp_netdev);
+	ctrl->ddp_netdev = NULL;
+}
+
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
 {
 	write_lock_bh(&queue->sock->sk->sk_callback_lock);
@@ -1849,19 +2061,37 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	nvme_tcp_init_recv_ctx(queue);
 	nvme_tcp_setup_sock_ops(queue);
 
-	if (idx)
+	if (idx) {
 		ret = nvmf_connect_io_queue(nctrl, idx);
-	else
+		if (ret)
+			goto err;
+
+		if (ctrl->ddp_netdev) {
+			ret = nvme_tcp_offload_socket(queue);
+			if (ret) {
+				dev_info(nctrl->device,
+					 "failed to setup offload on queue %d ret=%d\n",
+					 idx, ret);
+			}
+		}
+	} else {
 		ret = nvmf_connect_admin_queue(nctrl);
+		if (ret)
+			goto err;
+
+		ctrl->ddp_netdev = nvme_tcp_get_ddp_netdev_with_limits(ctrl);
+		if (ctrl->ddp_netdev)
+			nvme_tcp_ddp_apply_limits(ctrl);
 
-	if (!ret) {
-		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
-	} else {
-		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
-			__nvme_tcp_stop_queue(queue);
-		dev_err(nctrl->device,
-			"failed to connect queue: %d ret=%d\n", idx, ret);
 	}
+
+	set_bit(NVME_TCP_Q_LIVE, &queue->flags);
+	return 0;
+err:
+	if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+		__nvme_tcp_stop_queue(queue);
+	dev_err(nctrl->device,
+		"failed to connect queue: %d ret=%d\n", idx, ret);
 	return ret;
 }
 
@@ -2073,7 +2303,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 {
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	if (remove)
 		nvme_remove_admin_tag_set(ctrl);
 	nvme_tcp_free_admin_queue(ctrl);
@@ -2116,7 +2346,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 out_stop_queue:
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 out_cleanup_tagset:
 	if (new)
@@ -2131,7 +2361,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 	if (remove)
 		nvme_unquiesce_admin_queue(ctrl);
@@ -2415,7 +2645,10 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 
-	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
+	if (nvme_tcp_admin_queue(req->queue))
+		nvme_tcp_stop_admin_queue(ctrl);
+	else
+		nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
 	nvmf_complete_timed_out_request(rq);
 }
 
-- 
2.34.1


