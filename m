Return-Path: <netdev+bounces-84856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E52898802
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE7228B96A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F715129E9F;
	Thu,  4 Apr 2024 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GkE/X/zr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2092.outbound.protection.outlook.com [40.107.93.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3A129A90
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234276; cv=fail; b=fEJUazAMiskQkrLSXxRiquE2BWmNZ0aRpoPn4mxWW6Okt/iP3Ez8vGRuBie+VapcIbgl/En8XYKKGbTcPbAMka3IwVXmDtj0izm/NhXRZzjf9qi+/XQXO7CJP8EQiVchpve9LRbMd0Hr4qdPsiWrmr/68AzzPpsNq1M1bfLqC/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234276; c=relaxed/simple;
	bh=n1Q+8CedQrNjvec/pMMw+3Dhc0zsHEIBveXKV+D6XF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=izRZVTvu9ga6jCw8qTRxxMKphfze6JgpNf1Jsu+QJehswLKPzRyTZKGdlZ7YAACQ6DkkdwtwVHeqiybSr+4A2bmMKc3blPaZbnevzPPrpJyKHvh+CEjM7TZ+XLfiKgT4oraJ7RptcblNvpHokwhaZ0apFViqbZ6TaZAWKvV9uA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GkE/X/zr; arc=fail smtp.client-ip=40.107.93.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEa4en5GmFMSYLnKSHSHCFU0dWdqzPTcxfrSNZ8ttNEaohHWVnAJPgAatyGR2sPf5mTUKjNknHM+xexnqGx2q71NL9u/o4LSWkAgBwZszjLoXpUH9QsmF0xc2zfbQ+vvVmDEexTpbe7sVu3Mk5fVpoN6ifGI7XkahQmyVfxR4ag9Mloj5qVqZtQdLhiV/ykvpkub3nInlaN2Ic5Ne1+8nVnYdFE/8l7CzgoLfc7+pEf0LlccjbMoqLUWm4MCD8Z4WozdC70pnwpIwMja8LAsGBG05ZIogZk9DXgHj6k3HpDPclWaZwqoSFOsT6gqzGXb0b58r3kDvOnEBPY74vjuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEoHXaSees6kb4Jj7UDp0CoMBCxDuP7lBt4Cr9jtHTw=;
 b=OfLe0JHnGhWwWOkOKCtlTQnSNX+fTMWKnXnS7R7ur3EwPkl+eeAdw1857ZykZPQma6aQtWKDifB0CDjS6dM+JtQZKOpoK/iFnRieoG08n2xy1R/PR52r+2in8QUpkfCJcjBI4l66bE81DikDYLLDOXSdTsIgKMTKHaV+8UIurekwK3r9RnNbXNsBo2ImpNJU+q6IJILWvSOgtft6BIbePqDzno12GRjj0pgdcm0R+LHiWTrJuAx+VdupCOBdqly6upIK6wN1Q+UfiGg38Kh4OqzZhAWRFKig5+wG7IQ84z+t2s+dsWp2izTiRSFk969oD5aNvfAWkIN8XScViApfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEoHXaSees6kb4Jj7UDp0CoMBCxDuP7lBt4Cr9jtHTw=;
 b=GkE/X/zrtW53pGtQYMRf0lkdICoC5qLwZHSSRrjm+t5qRwjoXbM2UXb28Fbq4DzmTGTzUc7CGu+qO/kRpBIrife7dEyd7JVRcAEM5if+/Pqd8vE846/Cb/b7FZXoITFHpjjpvk6QewI+jmlEHGaiEulJSove+VeOhARGnV7aCyMr+VoYLx9tTaK68S3KOo9NbEC/LKU2YGKp6/23hHhkIMU1BWPufQOOLrNLCODDnzM8F2OD9fczuyZZHKVNJZWkGUaGwgBfKgyrD2q57N7PbXxjGsN7iLl94a8QeTGGguRcXzfk2MkaTbdI902ntqcZdigzkTFImp0q3IS4l0DxTQ==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:37:51 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:37:51 +0000
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
Subject: [PATCH v24 05/20] nvme-tcp: Add DDP offload control path
Date: Thu,  4 Apr 2024 12:37:02 +0000
Message-Id: <20240404123717.11857-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
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
	Us4vGSOxakInXIRAEKx/gpDUfBd6URstBHF3hP4YGgwmVDyr84AuBac6h+8FfIhRsidLQG3MQMH1f6sln7/gbPq1pTL9Bdp9tY+cxODdh3gsCkHemGkxlmKbr2ZtRKZDKoCpAhHRhnYtfisWp3K59VuHcPIPb5NOtb2GotFFUs/+b34Cb5dK68fCONChXp/G0jRh3sZU0cidy9Cbx1+f+IMBY8sNcNMpbytQ9Ug17TN0R8fuQFlMicvuZR44O6jdUT86P7+zSyyNiLi9uMCnFHWyskrHQETGt2oeNdTa16354QTNBAKRckAuyydXrX/9ZnHguTBD128UvW5sWmmXFkXPtPbbVgAuvQBioyYTHamj/82UFiB7nR+EtxPpBOpev5N/T2bqawAtqHCZKu7vGa/M48a+o10uCHrlkpPvGa5LTaU8j3bz6aGGnHapb/xFhdjZXJrT1WCRYg4IDH1h1tPCTsWVq8/zNmV6oQ93ofveYP0k+Fvf9kQ+5gghTRZFQVezLwxT9FRoAExvs9TSTqXtQGTCFx07hCh4PoCBGpo3fWYwiQ18Th0kaclbXuGUgYfLLvmERaIiFagM7EiF8rrmHXEbpf5mhYCsCOJn6UFgu5QBFnHDmDqHUfopL4w/74k1qlo6wPqqqVOhz2s7lCHxANqvz8FEzXqIe9DFGJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YeXTtmAzRYlzliQsKYAw+5k41Yf4tlmL/1gKXs3CiwIgJAWAMOu3seWAwBxo?=
 =?us-ascii?Q?Mz1+PVgborfZHlMwV2zxkLNDvPbSbgB2LgMj9t/HJCdAjjFItBIm7xAVdWvs?=
 =?us-ascii?Q?FBm06m92mRJQNpByJOvwTHnIh8mfmOAw5YkXQ8dbgXZZON7fNxQe9QTCgQar?=
 =?us-ascii?Q?YRuozkAo7GqKPJ1qTCd3u1HpomFZpfDJ5EQn69KOP5iLAcQWcjqb4xz8YPv0?=
 =?us-ascii?Q?s45Dm5LskLac7zI8kIvuP6tfcUY21cGvFi2ds8FHxMrCFWKBPM54ldXqtGKy?=
 =?us-ascii?Q?RjQOO6IH5HaAofljopReD4RzWfHkUZ5jcttQXAEflc+AANgjcNNwGU27F7h5?=
 =?us-ascii?Q?y9LqvQAFry+nSLZ5uwAzDuoSB4z99T6J3hBcWSySNKuzu1Do0hLIwMmAakBs?=
 =?us-ascii?Q?8VHWJwWKDpnKPVeJTaSb9GXXZf/dvTVKyl+Z4jvmfuA7D4TcxbQJ1e2NoKVt?=
 =?us-ascii?Q?OIp1jmOeOpQQ1bTsVPpWc6u9WB+eKMHlPs6j14bN2Kbr+06HUmedkAk9rBOk?=
 =?us-ascii?Q?udTRlJ1GcRXE9gyUX8suVqJuxph39sPBf9AvyYL7dAqJfw6rzFTKWAEccwwW?=
 =?us-ascii?Q?6d6TDzINVnK+h+9l0lpf3nto8IVWbKuNKDXBFF4HtBfvp3oX2wLRvFC84u+y?=
 =?us-ascii?Q?z59JSjnPjQtfpx0MEs3ZMSYiBKUDn8Dsd3thqTV3O2iWscfp+I4Jzh8KV187?=
 =?us-ascii?Q?n+jM4EhVt879S5Z/irSUGh22jxpV/udkS4TC1SEEUFY1X9WuA6ElQMmT9mCW?=
 =?us-ascii?Q?ppatkSR99JcKk0kgvb9IBevC8AlD4sz1Iz25FWfZzCw1K6eE/14kNSDByDrg?=
 =?us-ascii?Q?jtP9CsCfnov2yELbkKCH4qP2+h1MeDOy6uVBlbSbLK1brKEeAxOmVDsuYzEF?=
 =?us-ascii?Q?7fB092XNUMdEnf7z7ByvoHGHF4Utsvs1R70tr4cMaWnEuS1f19MmBQVfcf+Q?=
 =?us-ascii?Q?a/zf+P2EynZrSaZGfNYg8+5fF99PaMGRq1wVHZ8Gu3yW7EXTzNx8c2SsXnGE?=
 =?us-ascii?Q?qJ07tRB+AGkIpbtM5M7catUmoaOFuf5J1j/azULcxZVdZdr6WJdz2lhQebg3?=
 =?us-ascii?Q?1RhXsVMH91HjI4RQCPOvtlLBwhLmw2aOoL1PCknpqLyJ4vid1rF9Cgj9ksQp?=
 =?us-ascii?Q?w3mvrhkwQMnh0CV2Af1C4zT2VRUSySdWjbXzUIehNLzO+yF09ALmsyFkEn0V?=
 =?us-ascii?Q?qncGHt1m0pdUoD44WGluvtkCspuIcB6sTy/49hsbIyeBOs5waiJ9sAgguSMw?=
 =?us-ascii?Q?C4Hn+PXtJJyi5Wc4cZggPwtT3mwH9TDjAxB2yjrK+uGau4cp40PB/rocFv5C?=
 =?us-ascii?Q?J1v8bxf1H//lIIiZYxhPzFCKRpyZJsNgooXo0IAH7cQqfSyocRdRoaJSpSKt?=
 =?us-ascii?Q?NEkWM/s0roaW/sZPLiGiljxkHVhiFVdYY8ssrbLCdoo2Qe/ls+4rsQYNu8PV?=
 =?us-ascii?Q?ULvAIZc6TeEIjAH8GFLi49m3Gxe5Tn74aS9iby2PJM4z0Ab3L6hOF7v5boiY?=
 =?us-ascii?Q?fGS+lp4h6sDX+PffWWRrc6CEJBe2vk7egD5yoYlDq++jyGvT8P0zkXmvDB9S?=
 =?us-ascii?Q?53rI9RlSODuJf3/qIySsxVqgB1VhyEADJz6Y8qw2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37db97e9-ec13-4806-812b-08dc54a40a8d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:37:51.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vjUMxisrPXeazngKfWUS3y8gRlN9jYOPv+/X5/NND1EYIP5w8MkJNZ8pvEED/lCIQ1eILEw4+UvrLErKK0dOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

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
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/tcp.c | 264 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 251 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fdbcdcedcee9..529eee4b8f98 100644
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
 
@@ -54,6 +58,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
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
@@ -127,6 +141,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_OFF_DDP	= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -154,6 +169,18 @@ struct nvme_tcp_queue {
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
 
@@ -194,6 +221,13 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	struct net_device	*ddp_netdev;
+	netdevice_tracker	netdev_tracker;
+	u32			ddp_threshold;
+#ifdef CONFIG_ULP_DDP
+	struct ulp_ddp_limits	ddp_limits;
+#endif
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -305,6 +339,170 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#ifdef CONFIG_ULP_DDP
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	struct net_device *netdev;
+	int ret;
+
+	if (!ddp_offload)
+		return NULL;
+
+	/* netdev ref is put in nvme_tcp_stop_admin_queue() */
+	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk, &ctrl->netdev_tracker, GFP_KERNEL);
+	if (!netdev) {
+		dev_dbg(ctrl->ctrl.device, "netdev not found\n");
+		return NULL;
+	}
+
+	if (!ulp_ddp_is_cap_active(netdev, ULP_DDP_CAP_NVME_TCP))
+		goto err;
+
+	ret = ulp_ddp_get_limits(netdev, &ctrl->ddp_limits, ULP_DDP_NVME);
+	if (ret)
+		goto err;
+
+	if (ctrl->ctrl.opts->tls && !ctrl->ddp_limits.tls)
+		goto err;
+
+	return netdev;
+err:
+	netdev_put(netdev, &ctrl->netdev_tracker);
+	return NULL;
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
+		ctrl->ddp_limits.max_ddp_sgl_len << (NVME_CTRL_PAGE_SHIFT - SECTOR_SHIFT);
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
@@ -747,6 +945,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, skb, *offset);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1810,6 +2011,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_unoffload_socket(queue);
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -1826,6 +2029,20 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
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
+	netdev_put(ctrl->ddp_netdev, &ctrl->netdev_tracker);
+	ctrl->ddp_netdev = NULL;
+}
+
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
 {
 	write_lock_bh(&queue->sock->sk->sk_callback_lock);
@@ -1852,19 +2069,37 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
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
 
@@ -2075,7 +2310,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 {
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	if (remove)
 		nvme_remove_admin_tag_set(ctrl);
 	nvme_tcp_free_admin_queue(ctrl);
@@ -2118,7 +2353,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 out_stop_queue:
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 out_cleanup_tagset:
 	if (new)
@@ -2133,7 +2368,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 	if (remove)
 		nvme_unquiesce_admin_queue(ctrl);
@@ -2425,7 +2660,10 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
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


