Return-Path: <netdev+bounces-43853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899E17D5062
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7DB28184A
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E5E273E3;
	Tue, 24 Oct 2023 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EdeYK2+a"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD07273D7
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:55:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339BAD7D
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 05:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOZJZoCNyn5PTPD3kvURP1SeFUkFh1FIFWbe69sGOnFwMjLieyhYh/RPEgH+q/ETjOKSynIh8/tpxD9deRv/8z8vGBC23I+GcEk+61jf79kI5yQkl8ISmqlMj5TgysQ19R5zVlH9SvOmYcFBt7cD8tNsBEcQ6WJOtPJ6Uv6ZQcgpGXVYOR7/ptwgZkPjC00xhtvpnoP9VsPnvqBDfT8qT2AIPj+9K2LaLHJJI+WYoOFPdkabSYw2rWr0RrEmZdDbmpB7jVLbuThHPJGt72oqLGJJ5DxXQLSJn8WmgHEfAFQOrtrwKtvQBfuyl2cxwtldwAcTaxvNzJ3Cb/zry4cOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqd+46m3+OBn80HQl+bydQ47cYi/3DZQRXFTS1+5KKE=;
 b=HgYduSZS70P+xad5FzRC9y/6Z1HO6XXD7YdWR+tzfbfBhehnXt8Y4IWEAfgD0qw1BmH7RkOJV8U5iWLr2SyTlJNvCyoCRNEoAqpZgxsPuXcwKhsyMBVwwa33iAebqI7PIzbfSCEfR/fKnMTnSALqIMKUdgaat86D8SQ01hHL+fzb4rKSc5zyllLwCBRczAsHLR1pfNplBqHqK4inci2129F7+dAvEN3+8F2n+mRvEzFQRPAdFIf4kLSh7L6uMIfUXYxDVzwDUoe77MTZl/ZBGsYgYCjRV/jdDv5UEPexdvudmDqMSej5NoNkUDxLPrTncOUQ3ygDND9MASfT+GZGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqd+46m3+OBn80HQl+bydQ47cYi/3DZQRXFTS1+5KKE=;
 b=EdeYK2+aQdu7vgGiN1nB0q1oe50aHEq+Tkyh6gR35i8VHwTXmTgT9650loRXVwVw8Qo2T5M55Q+m1WszBoErBFXs2g4CtaRnA2k8hCv9B6Vh/Xb1hchZV3K9EBrqp1F/IYyszaETPBgeg0jGjMqoIf1qD7FEWFzl5jFUUfdbY/bLNgG3KHSquZQgvQ4EuYhLr/jBKq6tzRrdexkHTPemI0bbRiQU6wIVpGf2e48BusreGau/9uRykelCliYRyoOyV+v+AmjfyRYzIjCk86YFKb19WxT0lQYCll3zZ3ctz2qnJB7yT71iFXuMZBeIGwF/9jLmKKgKVyCJQZaKoBq6SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 12:55:26 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 12:55:26 +0000
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
Subject: [PATCH v17 05/20] nvme-tcp: Add DDP offload control path
Date: Tue, 24 Oct 2023 12:54:30 +0000
Message-Id: <20231024125445.2632-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024125445.2632-1-aaptel@nvidia.com>
References: <20231024125445.2632-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0191.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::35) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0d0eb2-1674-4998-b5b6-08dbd4907e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u9lzCbwzPbhuDB7KHjKMpoaxe9Pr/73UNDgslZp/oF0hBMy6Ghe+PRzpyt2HXFzjiNf0erDeDCIDQqeJyyhItMlJfSr3jtdTsEgw4OH8vifpt+IXKbsfBKo7S8w+/FWu6F2JCExAaAblz177ooCNLWBUtHs41ocb3otmocXOb/O9s2mSw+nkbk3QhHz735TaOZOGtw27lVri2j9kZLYZeHAR19h2DJYYfBfAv+4hwJ5SXOyw7nO0RiUe2R8g+KzIP5MJnFOIMmwphO6fBudjJuNCn/SFCawYVkadetD0t087OncW+AVfReaRvQl9LmLFZ4dIf57+NfZvPucE4RvXmg4w1fnP07v48495im42ioXU+XU8B3L4gkU5j81UbhK+JbKxhN05wGj1QAzbu/AVw+mHu1lHHlBKWxb0qZJ2IGyzh5jc5yyWleyaJeOQtxJXvWGbfZ1HA6yYDgkgHRBMySdAsDGUx55MdnMKp1QRYUvihNuDSS4SPsDClVk4II0sr3ArMajwB0WgI2qtN9ILxA9oonZDkW2zyCQDL0de5ZVEF5zF/0m0dsd2tbMPsA4Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(36756003)(66946007)(316002)(66556008)(66476007)(86362001)(38100700002)(83380400001)(1076003)(6506007)(2616005)(30864003)(6512007)(6666004)(8936002)(2906002)(478600001)(6486002)(8676002)(41300700001)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6WbtZRazsd6bYRfYYLAvn+4FvjrGMISTqoZrlLYgQCnDe82iuMqHG3bOaWMj?=
 =?us-ascii?Q?X7/1SrxUGRDlIxk45+g6hvx91NN9qlkAZZAg/FuBtMDyUwP5a0Gh2lNSMyqC?=
 =?us-ascii?Q?sd96iYDLXFvkbmvb1qOVI134Tnc6sQRpekujQ+gOb9MWu33/TBOgvlmicqSW?=
 =?us-ascii?Q?19613+VGw1D5HwbgB72WYm25XmEoVe1yfurdPSU+cOcDoXcjT8n+bYKHHGRM?=
 =?us-ascii?Q?kpjh6xARlPBhowvjs/0uMtCfE2kM4v58Kc2MdGIgaqsaFpO2+sdR2wtxtvzC?=
 =?us-ascii?Q?PYtF+Xu30zV9IFsxqfCuA/cdu+V8K/RuePyL2krrWwGlHtC6+NA1kkG8tUbY?=
 =?us-ascii?Q?Tcf033jaxBR/maBcmhPo4ToSAL6DFe3A85GZS1ivfLrqFCdYih2+GcPNuI9u?=
 =?us-ascii?Q?rpgpP6gBEJ6WjgkXM5phvYuWcl5WeOWSkonnoUWtpthk94HphwA2Vew07ECs?=
 =?us-ascii?Q?+gGo1DECIfTjTqPdgDNdBWSYatCWjAzvKc09oijOyc4DD/EFl3jTTkuOjQJ7?=
 =?us-ascii?Q?z+13yaN7Jey2xLaPIpbWet4uRxrdpxCYwxXeE5grRcF94W9KMVlmt2JyRTAI?=
 =?us-ascii?Q?rzxK7vppndyi6dIlwoyyqSFPOMKcTsLjPF+3cDtKQCaj0VbowA4zI0L9/CMU?=
 =?us-ascii?Q?S/+/WCL35SUPUd6nKtuef2jd9thzo1qCpRF0RExx22i38AJu9oqk4fjlgTiS?=
 =?us-ascii?Q?dGzMB8+PR6HpKqUFj5l/bGYMYRkU3Hn2TtTgduBLF77i/Qe9+yCl0S60uvMT?=
 =?us-ascii?Q?1gdbpxL0JYyBq672qaR0HAm5kyCrn2lSTzWj8jFKokUSA1r4AY62YTboLxHj?=
 =?us-ascii?Q?gxPVfggTE2dy94IGrxYBJ5ImZEJwr8zf9zYzt+Llfl2Hstassvp7UhsQTv7h?=
 =?us-ascii?Q?ByNta6Ov8o7WpYadznmgy8jO9vLNJNSNtWZqxBKLKIY5fxeNTXP5/pQx4e7E?=
 =?us-ascii?Q?EABTFjuULw4RB6bMxJajMMvKlV8QgNa4gGbxX6eQE7oDHWxvzWgihK64kczI?=
 =?us-ascii?Q?+xBNPatkTjG3YTUuI2aEmvMLdA458K4HmGh18EAgCpQhJjjnAsmticZo3C8H?=
 =?us-ascii?Q?JDk6ehAOyRJqc3fE0ivvmW9hTYBcZGb8unpl26J9zkZF/z1NDZUw1tvfpQYx?=
 =?us-ascii?Q?V1OTKwv/Bqo23VYQW3bKWBqGQYMI8I/IvINZjU574a2S9IVVnP6XkUbr7bgz?=
 =?us-ascii?Q?Qcc7pH2ckMQ27RqsnKrrfuWrMX6ENaYttSR1dCbCkDI1++iuw1DDiXbNDXgw?=
 =?us-ascii?Q?VU54LdVt3l5xtX0Sii8PxR7AXioTLLE15qocLz5DIOc21ukIKIoQ3k+ZBkTr?=
 =?us-ascii?Q?OL9F3qBmcli93Ran/ixxe67y1Bf8a/dKTa3i3HL60sep9VJEdUEdrIv5HM1A?=
 =?us-ascii?Q?qb7pzDlrXK+T4ESEHLmf9NI7QnMJS/Rm9uyXteGvz/R7FW0pfNlyQ6qubLqS?=
 =?us-ascii?Q?6d0LPD3nmT0NqN1qVwBNpxbwbvVUGcMywtkHzrLPIyiAxFYNE9qVcL7ohWKQ?=
 =?us-ascii?Q?MHv7Z6n9NA7GC5dP68dJsDkMTakseRNIIB928crUdbFs3zfyF3sZx8WijWK4?=
 =?us-ascii?Q?e89BVDMBpeFsR//zvgx/wNpdYtKsnfxX3a1GH3WW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0d0eb2-1674-4998-b5b6-08dbd4907e26
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:55:26.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNhk0HKuxjRIrFNEJpcminLGrd5+8n3s3FBSGv2Lz7OrffrxnIpisrnRjSlSECMuUnFvLVuhfDKzGBAkhkOceQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

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
 drivers/nvme/host/tcp.c | 261 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 247 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5b332d9f87fc..387093cb0ca6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -16,6 +16,10 @@
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
 
+#ifdef CONFIG_ULP_DDP
+#include <net/ulp_ddp.h>
+#endif
+
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -31,6 +35,16 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
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
@@ -104,6 +118,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_OFF_DDP	= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -131,6 +146,18 @@ struct nvme_tcp_queue {
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
 
@@ -170,6 +197,12 @@ struct nvme_tcp_ctrl {
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
@@ -273,6 +306,166 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
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
+				  ULP_DDP_NVME, ULP_DDP_C_NVME_TCP_BIT,
+				  false /* tls */);
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
@@ -715,6 +908,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, skb, *offset);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1665,6 +1861,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_unoffload_socket(queue);
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -1681,6 +1879,20 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
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
@@ -1707,19 +1919,37 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
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
 
@@ -1911,7 +2141,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 {
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	if (remove)
 		nvme_remove_admin_tag_set(ctrl);
 	nvme_tcp_free_admin_queue(ctrl);
@@ -1954,7 +2184,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 out_stop_queue:
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 out_cleanup_tagset:
 	if (new)
@@ -1969,7 +2199,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 	if (remove)
 		nvme_unquiesce_admin_queue(ctrl);
@@ -2077,7 +2307,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 destroy_admin:
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 	nvme_tcp_destroy_admin_queue(ctrl, new);
 	return ret;
@@ -2257,7 +2487,10 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
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


