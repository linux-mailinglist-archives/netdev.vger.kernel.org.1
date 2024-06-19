Return-Path: <netdev+bounces-105066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12C290F86D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 23:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C851F21454
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7078C7C6EB;
	Wed, 19 Jun 2024 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XR4XT2UN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1878C6D
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718832052; cv=fail; b=ChVs5+YTGsgugg9fCmxAkHLvVBYi6bm8e1ZhpoDBSQAalem31BehP0/zmfWmjD+T5u8AD29Z7qsRkFD3RASLKKHAjO9+EPiaJriAA+WOAQmSOqHXlvCdg3vi+GKgGpjrCnvRs4JSw07oss7hV6QORgaFACowAFaSSTV0/yfOkv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718832052; c=relaxed/simple;
	bh=03d5jCYguzpX2JP8bfkBnNsNL+YJkUNsuDg+DRoj1IA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2U6xr0RoNi0azbVaRsFtwjuvYoCz1ORhRYOMXqJqDQn1OGTLNQZ9Bc3rAZZgyRqvN7y0cy6JlpxnMwUlIKwUwICVIo0isW1oEmJ5HVuwahypT27lzcJKDxQm+bcjnRn2dGzkQdi5J6i2nycPfyeuwr9PX/m6zMANQju+3YKdKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XR4XT2UN; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRKC7AywXrJCop4lUzVXliTXQtS00ePB6myj2P2m05tOZVNoHBlT8JExcXsjqs0UJZCKKNF2jLftOY/74lM7SQMjGqxEq+UT3eFnSwpJt72ZNdC1/q+j3+w17G/h6e4heduQ/S0OaEQDGxWAUeS0cTM2HFEV+xC9ggE1zZPSTe3ozC/QHmspwHec+BAMRZQegsLubGGoXayJo6D+Oi5nqlaBbutH+cfsdl/9dvAKEaPjSTT2isq4vVnCBLNDWJncfclKd1mLSpLmP2Wt17h9lrc/21woKeap+WEDsfBuDNcSEiJPO9By9Lyo1pRPjHd6kad8VnRj+pKzzrvAOa/3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n58ajkskROlZPY5nwFUkj4W3o59acMgxPngUDQV49Wc=;
 b=GD+EJpS00hnf9lTO9PMGGsgPmFTvEDFwjjHNX0/EkmrknViAbQRjlcFkyjABtSPgdX6dFqAQI2b1pAOcdDx3KaG5DSEAyEBtTB1z6/SQlHKLVcj+D/gLzwelQoFA8I1WwrHNa5hOMzys7KCdzl7BC35OGx3mlPgre5KUuKn6AyZOx2kyNo0Pdsk8WURjwodRX2R1jytBN6MVOLf8IEPj5x3Hifq2/yF9oYp1fYg2jzajYupIr3p5ttPugLGgyfHwRadYUHMuTWJtB/p9To5dfL4xv5Db+6SInkNOrXlqM5hUGb8MuA08o3qJL1yIynPxiQrGZeFXKFq70oks1699/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n58ajkskROlZPY5nwFUkj4W3o59acMgxPngUDQV49Wc=;
 b=XR4XT2UN8SI/8CLOlp1FEBqg4Frit6i2i+9hMTcmF+Klj221TMnogytYwyuBHQwzXCnfIGgQ4sGEB4VHtTS9r4ruLGgWYPxROmy8kTsIJbmhnxpPGNNbE6DUmVrK7+P/shXuas0xuABvafwm5ACMKpBt4MhiwDX3JZce6BZpAjk=
Received: from CH2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:610:50::29)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Wed, 19 Jun
 2024 21:20:43 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::eb) by CH2PR16CA0019.outlook.office365.com
 (2603:10b6:610:50::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 21:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 21:20:43 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 16:20:41 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net] ionic: use dev_consume_skb_any outside of napi
Date: Wed, 19 Jun 2024 14:20:22 -0700
Message-ID: <20240619212022.30700-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: d2501aa2-ed2c-4ee3-4517-08dc90a5ad64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|36860700010|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YTXcBT+yTWO6KCQCPoIl9UnM+ht+qaXh6RE2QKXE857hGO7EZuy8Vjqz/nSg?=
 =?us-ascii?Q?9H8Igv1tSxKjkS33MPlEbUGM0mYQPetBJbGeljFzH4r6PYeyJ7gPb6zjkDqV?=
 =?us-ascii?Q?SVleOz8GqfsRBzm6jt5kxTVYKFBzevO1GaWMCzsW1PbOfiGpDNUKbjTklu4i?=
 =?us-ascii?Q?5R9W2nooSnxT2vJZw/j7XL0nQ5ihXnc7KGVQP+Ot+dCUNFA5oYaxP8IN8g0X?=
 =?us-ascii?Q?RCCL2kX8S5BsNLvdmzz4+UPif6UWs4C1LY51yTz497fNKdWhwstJHFLd+4qB?=
 =?us-ascii?Q?o0bKlvGt9/rVfG03yNJoL5gne4v61ldZCx1h7X+gCSQK/w38gwYRFmLsQjjz?=
 =?us-ascii?Q?HO3uA1QzCwlU05iVRJ/vmHoSolHoU3//r210/DELCMlPhZcTqrOuUA0MIqRc?=
 =?us-ascii?Q?xuA2F+bIjPvnt5QTmX+eaeot/37nwzAcEO2ALbDxZotwMd/VNPJf7mO4FSTY?=
 =?us-ascii?Q?KyqCOzL0aRaPJjhYyS4BMkqKszkLl+SuHqPB+Lyg6aToY4a6ICovxTvsieYV?=
 =?us-ascii?Q?SPehv/ruUtuiUAShKhKcn2ZtvtMFXIZrrRDJSOrSlbjA7DS2wgW+t0N5Agch?=
 =?us-ascii?Q?eYEUpUR8v9469goi42fS+cNud5MsgdBADMOT/PrOO72KrrJaa/52treXvOwr?=
 =?us-ascii?Q?5qkkEZMcSUBGEA/JsCBYEgPWJoqcj1/oE29v7iEIZZTKDmoeO61RjXHoh6jg?=
 =?us-ascii?Q?ZM8iKeUtlgRiF+ZfXtV1Fsha7AolyejqQP5GIGR73Hg4mBx6GU9s9BNrf725?=
 =?us-ascii?Q?Fhu/nEMJKKgsEAsDN6+nFLxbR3Rv5tn59CGgSZBnq/mbkSTAkyQyN5+obsse?=
 =?us-ascii?Q?LfH9CjACBW/yYESw7bu1lOqxYHLu0oPWUIsbnyWGo3PkIePUY8U2RSjl6Ufg?=
 =?us-ascii?Q?1eJV+9HUoco3ZtvEejXUtMRunLZb2tODbjaR/SYKeP7ZnsKajb0r7Pn7zVgt?=
 =?us-ascii?Q?oKOMkaJ7fqQOXxNd/4t2INYU7WVbNL/7qli/taHHnS6mUiu9Y7G/rS0WyjLL?=
 =?us-ascii?Q?DvUT/ziKtuNqzNuZxK8qwurDNYyzRlw3fpo5F0l1ReuZR6kRy0Ljx2A5cfGe?=
 =?us-ascii?Q?m3WAL50fXlTEBwpULQ7UtqFPrudUeY/tld9x9qaFPzjk2WidubQ1Tzn4nWLD?=
 =?us-ascii?Q?AfZAFtO9ylQJaAyQ9k1OrfX8J/QrbRfLLPf83Nnuu9KzPRyR6e7dn82M20CG?=
 =?us-ascii?Q?8hbHH1PV19xPH146Hgkau7u0nX2mzgmx4XOt2LQM2uyf0imcIb4L5E1JXMqT?=
 =?us-ascii?Q?1ewW8mSL1s0qEsNujaOne94Z7Wg8HNU8FMUPFGEY9MaIQ4DmMrNrRqSm2JzV?=
 =?us-ascii?Q?y5nW9RvDqyIVsE5InIgiRJr+y5cKwl8FoPukiUJtp4ckol3kLCVTh5HhocLh?=
 =?us-ascii?Q?R+HZtiRyzOK2dQYdawbycnRxXxFlrXdYpt/F3WAit7kS0iC8jw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(36860700010)(376011)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 21:20:43.1863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2501aa2-ed2c-4ee3-4517-08dc90a5ad64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005

If we're not in a NAPI softirq context, we need to be careful
about how we call napi_consume_skb(), specifically we need to
call it with budget==0 to signal to it that we're not in a
safe context.

This was found while running some configuration stress testing
of traffic and a change queue config loop running, and this
curious note popped out:

[ 4371.402645] BUG: using smp_processor_id() in preemptible [00000000] code: ethtool/20545
[ 4371.402897] caller is napi_skb_cache_put+0x16/0x80
[ 4371.403120] CPU: 25 PID: 20545 Comm: ethtool Kdump: loaded Tainted: G           OE      6.10.0-rc3-netnext+ #8
[ 4371.403302] Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 01/23/2021
[ 4371.403460] Call Trace:
[ 4371.403613]  <TASK>
[ 4371.403758]  dump_stack_lvl+0x4f/0x70
[ 4371.403904]  check_preemption_disabled+0xc1/0xe0
[ 4371.404051]  napi_skb_cache_put+0x16/0x80
[ 4371.404199]  ionic_tx_clean+0x18a/0x240 [ionic]
[ 4371.404354]  ionic_tx_cq_service+0xc4/0x200 [ionic]
[ 4371.404505]  ionic_tx_flush+0x15/0x70 [ionic]
[ 4371.404653]  ? ionic_lif_qcq_deinit.isra.23+0x5b/0x70 [ionic]
[ 4371.404805]  ionic_txrx_deinit+0x71/0x190 [ionic]
[ 4371.404956]  ionic_reconfigure_queues+0x5f5/0xff0 [ionic]
[ 4371.405111]  ionic_set_ringparam+0x2e8/0x3e0 [ionic]
[ 4371.405265]  ethnl_set_rings+0x1f1/0x300
[ 4371.405418]  ethnl_default_set_doit+0xbb/0x160
[ 4371.405571]  genl_family_rcv_msg_doit+0xff/0x130
	[...]

I found that ionic_tx_clean() calls napi_consume_skb() which calls
napi_skb_cache_put(), but before that last call is the note
    /* Zero budget indicate non-NAPI context called us, like netpoll */
and
    DEBUG_NET_WARN_ON_ONCE(!in_softirq());

Those are pretty big hints that we're doing it wrong.  So, let's pass a 0
when we know we're not in a napi context.

Fixes: 386e69865311 ("ionic: Make use napi_consume_skb")
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 2427610f4306..7fbea9c346eb 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -1204,7 +1204,7 @@ static void ionic_tx_clean(struct ionic_queue *q,
 	desc_info->bytes = skb->len;
 	stats->clean++;
 
-	napi_consume_skb(skb, 1);
+	napi_consume_skb(skb, likely(softirq_count()) ? 1 : 0);
 }
 
 static bool ionic_tx_service(struct ionic_cq *cq,
-- 
2.17.1


