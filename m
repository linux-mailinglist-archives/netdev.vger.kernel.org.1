Return-Path: <netdev+bounces-99099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDA58D3BA8
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEEE285465
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA96B18410D;
	Wed, 29 May 2024 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XsBrKi1S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B811836E2
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998504; cv=fail; b=JLnOq/PrUA27FDhAxpK6Yl7eGOO74ArXZhad8qrwBqJMpBXEsg17Ti1YLUmik8JENvXVq3sWgBwXd8BKgAAcDi/ar5bOmlgs99hwGRQTof0mRCDqR+snzrNSvPoMkvwsFU0jnHHzcqkJeJ1IkIhrO41WuRgfVi/hxvKqEJW8Rmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998504; c=relaxed/simple;
	bh=beCNpZJmgBSH8aal9ha0K1W69D/rgbStqSm+rHeuOkQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fPzSAlmd0ElAq2xXUhuFjJTxYZBZPbTd5/sXJH/QEpzG8kI/Yi1ApgcLUVbuMRWuhHLGQbcOuPmbFhNuxjxzDebxMYP7Bn/LQ8olbE7urOAT1RtZ8xfxdzbaudiaMUN66BgAbU9jUIviZXW3qGTRvSlleZBtLvk/cUc1sdxf8Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XsBrKi1S; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejY69vUzeSwEmNzIMJa8VSXFHePGwu6T/iadsu2ZGV1En3kMePZoOKXVTmo9EGLL4mDk0fI/BdYVHfB52aGn+WXxTf8BNNG/qUzXSRNL4FFDld7zGOTrsogz+pyZYY+avx7v4kkKYdgNZ6JOsfbOnAMIGn6/91X2KFEw1F0zlwXkaa7aUgJrISPDwjHor/XqjhMTS5l5z6HIUJ5JNaMjIzIs+Bnk1ME5FtPNsAaLFJvoCGPEdfNmYZdd4e+2L/awk6GzNpeYUxDReHW2axBqAP/yo5P6IIeCzBRWfx7ecfSVKvwQzIplpMgsk++sX7/Hop0CjEvA2jkzGhF9v2Gmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83fUmPLRwqk6tqllTCetUeTcDVsvsOcVPHF62J6ejGU=;
 b=Qei0uVYuqdxazhKbjjl0BDyC71p0F9pftiTbOo8C5qI8KLYkDln5JkDn1rBGPOZYSWWAnmF/exGx6NSV6qANoiPME+OU/1kGuNqiHHJLs/AORH2zJNylL1hIsWtvoJKQzImI001u7QqoCL16V0AlRxEaQqgSB1zf3J9IFH0dNtVg0FVH9Duhp1nWq6Tfc0lkOZpO2veUrLm6aOkdZG+e2G60kp1GOItd/T4Twz8c3UowSkshcE/WHykKiougzvP2gAakT1beyr+QYkxzWbks9VP/lB7sY+3guoic1615dizIuLlOuQ4hElLrvgFNOLxXBmUoSGaJcyrsRqSdGvQrTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83fUmPLRwqk6tqllTCetUeTcDVsvsOcVPHF62J6ejGU=;
 b=XsBrKi1SqcFqqxtU548byjXVXinHdqG5noZIVSIAMTRJINd6TAPPi2q7GcPRLaL0dKlRVYn3S8DyGzNZFFXyuxzbDiKDRnYZLEbkfUXx2XKU1ctzxYg9ShVBXBSY00mbcIkIHA8L5xt2fMqFT1rqcq6PwNesPlAFLoorEKRsFJNrNMRqYsO8Owf/vgf7xXxf83BckBN3Yo5PpU6RP+Hn+Y65LxK9h7tqM3fDOWbpXlK5BFD3dskniPoMAFsTHc90Jwmtx7k02+KLF68NFsoT0so4sqFHaWvEeh9GcxzqEy9W/o7jRN/FlHsC+mTparoKZA6QKYhIMYgk82COw1JV+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:01:37 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:01:37 +0000
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
Subject: [PATCH v25 07/20] nvme-tcp: RX DDGST offload
Date: Wed, 29 May 2024 16:00:40 +0000
Message-Id: <20240529160053.111531-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: c374c4a8-973b-482e-1d58-08dc7ff89f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WPP48EAsO5aMbW1+tHMKdU0DZJ6MtC4VDOCLUSbm2eDIRzwmYF2D6umHpALL?=
 =?us-ascii?Q?uVQvfZIfY5+DxtWwIy19aWcZVqDV0xL50GSQR0lBJEvLtGN0V22ueU6oLppS?=
 =?us-ascii?Q?YfGd+Osk8vhWtjG55BPvQ5GSaSM2w3nL7ZSFvglJ+IC2POoVZrbC1fBv7j2u?=
 =?us-ascii?Q?TPjFfBfqwXSzJo6vLwruX+tb7HnFoA9vTGQ81o254Yvo7QW8dwOyb6V01kjK?=
 =?us-ascii?Q?oHkhqf0/TCyTfMSB7ggouMgN4Z16jsaGWV6AZ0ixICi7Jlhv5I5vkgXtqgqF?=
 =?us-ascii?Q?nYVbkbSGR1k1UlrjRCLJ9NFWNOSqspZ/R/DjJ/jfSn6x66/a6bhveWgokQKU?=
 =?us-ascii?Q?1AbMXilM0dAbJt1g52SK0a2bL9XmqcU1mNurViD3TvkiMrNmY9T+WtW00No/?=
 =?us-ascii?Q?/YGAlIVEX+cXxvrWkkvQG9VlnaFfZbiBoSQO4HV2xDxZ4R1419VliQQ6Vt3K?=
 =?us-ascii?Q?zlVs5gVrAqiuSv1C1Vyhqo1ohUjxvZl5Pq6A9FovX0LIBhgOuqFEHhSGc7me?=
 =?us-ascii?Q?DyH6wunddo1tanrn0eTzk9IE7GbT7kVOtOT+wqezuyaV+fi+p6KU/QOD1iqH?=
 =?us-ascii?Q?S/bp0wJd+XVZMgZj1/amdjyGdRm6iH0a97Adpd1gffqR26E+GjPVSe/v/VLY?=
 =?us-ascii?Q?RW0g1Zquvh7BcsmId7OIzcZIv4WejINpAWicpk5AzZ3mPm/DnXUD/Q08H1vi?=
 =?us-ascii?Q?9GysjOezm9rU8+XFSkrB0oAjWcJXVej8YQjNYXmcyoUE3joestOjvaQX0Udd?=
 =?us-ascii?Q?DaeJG/WVnZt7MP8cBT9h8ZECyEyxPe0mJlZmuDxZKg4GpLjUxMcGLjO+rptq?=
 =?us-ascii?Q?unr0J4oSNsTxBU5jOmUDX8fvAY8OYT+hIYM9i5EKH0u41ZdiULShStnWHgoh?=
 =?us-ascii?Q?swE5yU6m8Gy1lz+OSaW3BwU7iCa7dQU5YA3/XgMjMmvt1vRE/9R8C1iOYrTV?=
 =?us-ascii?Q?dnGIBO9Sei72SF86c/ctIfvGGulrO/3cJwTFSMGkU5MeG9eQqxpOL1akTWiH?=
 =?us-ascii?Q?tbhMEpXE0lqnr2h+FR6ad8Lne8fiCzYEdUJHtS9RGyfeVyip8/8b/ZJIcfIy?=
 =?us-ascii?Q?Z5q9VZaETT9iobzfeoAtBwtdOKegdx8hyT9oUsl4JcUBKlGtN6cYsgihQRsM?=
 =?us-ascii?Q?GIajssbGeZ8+Q52PYZuLCeSN2KunaYb76S0+6+0H9HSnAr1rZifpsr6KpGfE?=
 =?us-ascii?Q?t+sgYFsGsA2YUF65Et9PziiC/ACYkRh4HIscEXbZYkK1d1eWkbXE9t709qnt?=
 =?us-ascii?Q?IZ/J89QN3UmOTREZ2/hQLok00pMFYLqLm1lYTxw1jA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HNH8Ay5ygllLSUxXSx/XSJy5kZoyRrW2UV4W8mIFh6d1SjAeyB2J1DnobmcR?=
 =?us-ascii?Q?wFy+vMFZ/8+5U6KD3zm1mjPmPMSzwqsv905J+xmy4U3R9syIJ47aV9ZPtr8i?=
 =?us-ascii?Q?+L/kbvgOP23FEENROtn8jSIYx9RvAOvbB102iFBf94jPmPTv/mfIPxca57WY?=
 =?us-ascii?Q?59DfxkLuRTUiuwn7YKeb3AYqDKP+q5FrqA4i7dtlZNAjJaXjA466Y7SGwV90?=
 =?us-ascii?Q?MBE6F/SWdWdtJjj/6Jmdkoh9nlWDSfZtT9TA9jcctZv4OfK/3ZPYiO6UTKzj?=
 =?us-ascii?Q?uv2XqUaNK4bTa/RZrYxACKV40MziU2xS1yuuRwE1bS+NWBVvwTUz91Z06k/H?=
 =?us-ascii?Q?1CjQSciwI8ySTAI+9iyT5QR80mpxrH4nGsSK1idpWc9SBFPUXpd/jV2FVsAW?=
 =?us-ascii?Q?vxdyj+N5RWZqDacVRJdaiOpBAVEy4l5R2RIZzPnYDX1vv2xQUxNVL0r5sw8P?=
 =?us-ascii?Q?alU8KwUEMng/iPWfmFgf/OHhLd1ete2TdM8mzouH854WwpPpkgPYYKe6pcYn?=
 =?us-ascii?Q?gYXBkQE+n4h0qAh21Gagz3XBg/ezXsd2e4ms4CPWIssB7Otp7TjWgIIG8SGE?=
 =?us-ascii?Q?C2pSz9H/3bWIGTkOdvAJe48mOAvtnyIownBE5R1nRToTLq3QfCVu6FR3mZGi?=
 =?us-ascii?Q?1vnVianH9AWTuHRCyJjAdHd3+n6bQrSrIEfGrVxjeu6Vki+2ZgMyY/HJCMnq?=
 =?us-ascii?Q?gEStoRP2gdLB/NTFtvy0+iHiQ/402ybXSz8nMf1pug8PKGEq37ZI3Z4K5e1n?=
 =?us-ascii?Q?eZ4bdD1tuauFNNpmP9R6+NGh7GOB/LR+03YCJ2Cgl7mLrOy2stdXjn8zC0sC?=
 =?us-ascii?Q?AEaGQB/dNjA/BeieKYoG2850aHcA+lScHr4N9Zx+kEkgdtA4eD87sDv5ExUv?=
 =?us-ascii?Q?wDAEeVE+KIfOIVkMatdpx151FREpm6YxAGa/uNfG38RMWgKSWnB+YtBNNJNP?=
 =?us-ascii?Q?0dM5qDXq8nbkBFMNj0aGKiCaVbUkSqSu7vz5lz3eDy5CwTrLF0sMRU1g6kca?=
 =?us-ascii?Q?q8Ch5QHMK4FmMCV2IB06XLg3RndpzGDwRd5D77KtN2JbOP6ylo2H9jMh2jqE?=
 =?us-ascii?Q?tUdBNknrsk82ijSrdZXhnk8dzo67m5qJWhXXBB3U9wTKTAepGc+lTtu5p2AK?=
 =?us-ascii?Q?+UIrGuZSxEKuhvtG9NehVB+Uq3PyCEU1wSPpJI6m7G5hcb+UXpoJ3h3ltZbp?=
 =?us-ascii?Q?5VBZ+Jf7QKoisePejCt8RZ2AGl6ZWmt0dA3++ip6Vj51a0yzOfBG+Dwt76L6?=
 =?us-ascii?Q?dQ4hCFgnaIBuAc+bkCcXJTWChSJoKHP1JFV8Mnv3gyqCl9qnoRw2dqu68ZHh?=
 =?us-ascii?Q?L+IuXoaR940A7YjUwrf+3YVsxKnKcHJQyK6NieI3U7EHTj4ybI+4+aupYEbh?=
 =?us-ascii?Q?XZJt83VE2YDPa2If8MO6tytMsfk4smSsrBuEbDinCHUWo8e5J0pipFhva1V/?=
 =?us-ascii?Q?HAHYKgK3jWS6fSHUVILOmm6PR0yZt4rFRVIvXg0moiPoCqQS5coaPFl+TbpV?=
 =?us-ascii?Q?LEQvXQLYgy2nwRr1IGYL7yl328tEqJ2wrz+E5TLiXrD2+Xc7hAUwrVl+fUjV?=
 =?us-ascii?Q?lh9Pzi0DFQRgfqkzCy9tq4HaWj58HDnsOfCiFJLr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c374c4a8-973b-482e-1d58-08dc7ff89f0d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:01:37.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mz5ibM+96v9X0+y6GtTHV2YDP6+PP9b7WN9DKuShhh4sznMftmy8OOOTDNR9/d7Xqs1KdzQnfY4HJxOQ9jgsKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

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
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 96 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2f5baeae01b9..a8c2653608de 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -150,6 +150,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_OFF_DDP	= 3,
+	NVME_TCP_Q_OFF_DDGST_RX = 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -187,6 +188,7 @@ struct nvme_tcp_queue {
 	 *   is pending (ULP_DDP_RESYNC_PENDING).
 	 */
 	atomic64_t		resync_tcp_seq;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -402,6 +404,46 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 	return NULL;
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
+	req = blk_mq_rq_to_pdu(rq);
+	if (!req->offloaded) {
+		/* if we have DDGST_RX offload but DDP was skipped
+		 * because it's under the min IO threshold then the
+		 * request won't have an SGL, so we need to make it
+		 * here
+		 */
+		if (nvme_tcp_ddp_alloc_sgl(req, rq))
+			return;
+	}
+
+	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
+				req->data_len);
+	crypto_ahash_digest(hash);
+	if (!req->offloaded) {
+		/* without DDP, ddp_teardown() won't be called, so
+		 * free the table here
+		 */
+		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+	}
+}
+
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
 static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
@@ -488,6 +530,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest &&
+	    ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
+				  ULP_DDP_CAP_NVME_TCP_DDGST_RX))
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -495,6 +541,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
 }
 
@@ -603,6 +650,20 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
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
@@ -869,6 +930,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1136,6 +1200,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1164,7 +1231,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 				&req->iter, recv_len, queue->rcv_hash);
 		else
@@ -1206,8 +1274,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
@@ -1218,9 +1289,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
+			goto ddgst_valid;
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
@@ -1231,9 +1318,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 			le32_to_cpu(queue->exp_ddgst));
 	}
 
+ddgst_valid:
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
-- 
2.34.1


