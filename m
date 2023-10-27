Return-Path: <netdev+bounces-44746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFD67D981E
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74182824AC
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B971DDE1;
	Fri, 27 Oct 2023 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JfAlGzMG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED69E1EB2D
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:28:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BFF186
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRjeOg1vGchB0UQP2FzVwDY7/gRM+wJCUI88TqCrCprnqj/g3b1l1sU8wZmShrhVMW1XoQpJ97EecfJRJtW1zroqC1wz9cieCSOK+fkQjC6hKSiZPGzVLM++3Zvy/RY2M6MPFFgPTUKQufxWNl9GX4L2GIRRqfBcDIQsdAALFlsE+5eRm0+gfckeJDe/HNuWZkFemCHDuWD3y8SQyYbx/imtDXg2OJU0EDYbgjtdSUYYJW/A9GmRThCCvsPULtkVQA3c5NybWRPJNFvYFzM67n1Qe0XxXrLkZf/qgRX4pTWHN4hfcjBwasPlapFTJcTHrjSiUsy1zqFmpqQxUqa4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWCclywvGX3fDGHUEVvobvVymGxasnVXKi0qfFVOhRM=;
 b=J0dIFzf4iy5B1w0kci0kzRbs+0He2SWIQLTVBB8D0g3VVOhmfI4bAcDI2Hv93cYwx7kv+8+NNC0Ntyip5OMGGvauXeOuL55rF3OqAoJ26UzLW4nhsqToTYQd2pmlDI+B8Q/6m4dN9kutBVZEIWB0Njo8I5AKgkzRQ5AJX6nXPw1dyR2w5vZ5IrxGwEaqNP0IpfWJiapiMzMZIGhYAMY8nf0ss4BxKWqbKk3zBrpTLxPXfv3TFNy6zNQ0rJ1PWF62rBVDy6d2Bl9qZdGIzfm63ivsnwP1pjpfSd64A0jLvyQUeNgh4Pq2K7v8lCAfh3LjsnhzLHS6kVT80g4ItS7tUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWCclywvGX3fDGHUEVvobvVymGxasnVXKi0qfFVOhRM=;
 b=JfAlGzMGWtta81nv+2loZW6LkpMuFnrVXzVpP6TkrLvhpphDTBx6dl9hAo2EA7z1tw81dwKEbxU2tYyVWkkOjWfwXegTQps5J+OBza6m/Hlmqzh2hDlH69KQS4Bqg8ZiW+LJrv6AYh9S1kahEr+GQN+9KGrVG2ZzWBgBeRsbMiL1d46Yu9N0r+Z/Vqqfa8g0ruEFwTEj1BMvWb0nuxEHm5VvV46Uh+RtY/+RkcUeP4jGlAmNEURPs7eOUR3O3s5yFnp0OXs2S6w/uC/RAtdFBs4UyQhanKbMnp7Yx7Gq/EJ/Iu2d/1MXwk8WBuQvcqH+Uiojw6IkppJ0RW2ssYYKHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 12:28:25 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:28:25 +0000
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
Subject: [PATCH v18 05/20] nvme-tcp: Add DDP offload control path
Date: Fri, 27 Oct 2023 12:27:40 +0000
Message-Id: <20231027122755.205334-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027122755.205334-1-aaptel@nvidia.com>
References: <20231027122755.205334-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0416.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::19) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 58859284-228a-47dd-073e-08dbd6e83758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m/FjvdzbMiRWjnQjn8Yck9tMRZlY088Zn0SjdSGikjFDsT+4BXfQpurcsVl/iJ48iTkJWxIjScKRwaouldBCO9qTWpVOw8v1FTO6aw22nnKXFc6IWXZBsX0dr6S7R5ZK4PEJAzB0ulAs8s8YOCqnrUpGWRl0kaktYbDTHP1gYoRe8LLoDvmFvuxi63eZiuxRkwO/HugKcJGhqBxeLQdkYhBvMQXpCzXJ+ig/J4PMOnH95hgkpZ+9ayhLRAPPGDQJpV9r40VJYkYZqrnIVouaf3lZtknr9wIkyn5ToLcAbkQ3lNj2zXbOmpNdXIQMJNcYlrCmwYtC0xS91ITrBVjc6NRjV20MsOWHLdwwCuyV6oMZ8NJGsEkk7k2oCxTFT/5+vqX8B8bMvtn0U6dEXwaDb2b7ALc699oPeKJPGrHqHy4OteQFHUHEsYwB89v2LIIuCztS/+4hOTQd2heCK3xGYtBg7XqKHl8pmczYZt12QRa0tDXi1Ku6u4ujQ5GnLc+hV7nWOSiWSh2TdZrsoORBHPepXzVy5OzBoiDj46x3yKfCv6eVuGm+yQsrWMytRYcC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(1076003)(83380400001)(26005)(2616005)(6512007)(6506007)(6666004)(38100700002)(478600001)(2906002)(30864003)(7416002)(6486002)(4326008)(41300700001)(8676002)(8936002)(66556008)(66946007)(316002)(66476007)(36756003)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xKqqERjbans5oFzccbzKgUCXjMsf4CsSIySMJG3sHFm/IlJz2UUbzgsGYJf5?=
 =?us-ascii?Q?Zxrtsrr4UUukHJ4UKkl2I36lOCiUgqRaSHrq6Rle0GWmhm5DSOUA30xclvKN?=
 =?us-ascii?Q?qv1i1e5+IC2t4fOcZ3y3vt4woKPZHP8CsiIbENIROAuxUcLwXUWx5C6axaL1?=
 =?us-ascii?Q?2t5+cmsEShcqEktertDhLMFu2DnKjC+NsrldxDUWSpdLXqG5DvdHNe1MhYMJ?=
 =?us-ascii?Q?5FOtR/1mymh5hrZyD4xrl97JGOzlghEJ33ygvXYb8MP+wgk8C/NY/iPG40pV?=
 =?us-ascii?Q?VRI4H/jkRpV1UPrT+Sez2G38Ytnib0Ll8qEwJdG5SzdUAttmfrFYWOCcdgU7?=
 =?us-ascii?Q?uKp1cOriaDoU6uq3nwpO+mhTthRpn0zWI1OF+Nc5IEsgUsP6GoOwL/nSM+Qk?=
 =?us-ascii?Q?7ZsH24r5ki7ExX55Ah7wdDhF8jv6n8m8If6AJNiQiCosIWLmGgowoIQiBzoX?=
 =?us-ascii?Q?iGJPSMGojYLP2Ts70hYkGQkL02yfKxpMg7J/rwqvT+ve+7juPwOkcC4gOo3s?=
 =?us-ascii?Q?984tNhYGJOEoziMN4/vCG3rHiM9Qb3vvJz4mwyRSqfZGugM6H33GKIrJ2O6p?=
 =?us-ascii?Q?Hwt/bUtejU4MwffqqhTpyqcOhOj/SejGNJ77WR1jZGkpncS//ZnjLegLqfeV?=
 =?us-ascii?Q?4EOC4318+vbQVOGYPdUk71xWEMWGFehBG2OyzkVGsZBLVASJKn/qtFyK2Kdu?=
 =?us-ascii?Q?9IcjMmLGnvu20kSV7IazJ3cRjKix6bKIijtrPQDUaIbxjaV8dN9GVEboCMYv?=
 =?us-ascii?Q?u4CqPOerJDf7YHOPbaWgJiUUyfQcdSi5qCwMHV0jhDlDAlEnCtxGwVAmHPcW?=
 =?us-ascii?Q?4UvgDLqESNY6cE4eNsmMRZRWMcxtSYhpBDj8NpcuRRGfDJxwgaxQIfMmO7GO?=
 =?us-ascii?Q?J6Wl6SR4WM/MTCaSjkaqJKQm8HsJu7930U/dr4YYIrJoYJ9xzElyYgKlItDH?=
 =?us-ascii?Q?7qt15PADPk+to4cP+r2XhA/PBuwRw37Jn+//1QWfj3h/JP84TB4CTXIPYeMJ?=
 =?us-ascii?Q?KUIgWyBdpXH6xdgPoaacs2Fr86gof6GGJap2GjcRBw0HReJAj0y/3iSt94v6?=
 =?us-ascii?Q?n2RiEVa55WwC02XnpmMUEmgExNX1ZqlzbioJyASEcc8w9+liQOW67sLlWm0n?=
 =?us-ascii?Q?mWcHql0J4VZ87KA3F1pJMkB/ePJUbRXXrWGOTsxUlbEOXtzqmM10rSkxtdis?=
 =?us-ascii?Q?3yD67glstChcgiP1QYcs8VaF5iHpucpSErNgR/BXA5hYE2EJZZmnWtegvta3?=
 =?us-ascii?Q?RvOj6zfLJy9iDg9bbYjm/M2XLtc+Qj9h7YoWQRFFJGZuP+ra9OfthzhgcrCw?=
 =?us-ascii?Q?V6fJJ9JpOOszkMNnyks2CHNdTqVAGW6wcwY+ADxeHbsOjptzQCatHE54s/YT?=
 =?us-ascii?Q?dpQOCLC9okAC+uB2y6zjGbI5vPdXmew3yYNuhC1digyfzREpDdwqZYJSpMSQ?=
 =?us-ascii?Q?iBqEkoD65r3Y2UnrSxOndFSZvgpFyYmRQkSUiK6YQRR2ih+KQpfc1Z6O4hOv?=
 =?us-ascii?Q?4+eGyx8uBVZoB9xo/zMZoDltBGxY0hpZLqn8hwHJMs/ZO8FmsN5MAifPp0uq?=
 =?us-ascii?Q?ly7IJeWc2jeFYGuSbmV93M7TMYtOdLqaO4Ma6zLL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58859284-228a-47dd-073e-08dbd6e83758
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:28:25.3546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJOA1/lgc6rRmWG3zAkXHntcmyKmuqsL/+FQWfKBoa0MoPye2to0u0/NKjS6skH1IyQvniGGcyW3p5cBD338OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378

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
index 5b332d9f87fc..43cd7621f8d4 100644
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
+				  ULP_DDP_NVME, ULP_DDP_CAP_NVME_TCP,
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


