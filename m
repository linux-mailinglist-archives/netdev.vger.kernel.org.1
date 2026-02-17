Return-Path: <netdev+bounces-259147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFy3NHXZlGk6IQIAu9opvQ
	(envelope-from <netdev+bounces-259147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:11:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C4115096C
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D42BE30226B9
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9138537A487;
	Tue, 17 Feb 2026 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g/FC2feW"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E21B379998
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362663; cv=fail; b=lJV7cskCTqZq/4f0XxAnKbVIGoPXU3s1uQadSkz+slqF/SI6PpNCfnPoavext2qHqoilnhO35nZntJ7Bz158V0/Kz7/jMnwEpdFmhfuyukuhslPfHo0CclrAKoqQZPDy+U8/u4kg8fUL2lbOwkdktyujlDrrVmFA70K1/TeDFSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362663; c=relaxed/simple;
	bh=sYkY1Qo1dh8QmSsLBUyqydCNKgP4s0QEJ/PwOVceD0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETg9F1ECNX/yLomVoFpGwJHGwSHKFzOE44fmrGz8SNioLsQp+B4jL2fKECiIr2JDPURG/6TeFtNIN2rtqLVOUhHJ8dj3wFL5fEH1sOmr3pJj0UggXR2CLPMbwRg552ZUoOnq/G17CfWj0vC3IW/HzDESdS4K+GKxlK8IoV6YcAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g/FC2feW; arc=fail smtp.client-ip=52.101.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XR6z7PrVsO43zOQ7UCiS1t2XbtbN4Kbs73ZNMe+wGgUsgz/rjUiTFt15zlKsJxki5ZKoD2sGc1RPFNaFnBz3EWueAMot2jVxDs9yeq/7ozNAaulTEOhpF+JfiE5HLV+Dl/AMS/Wf629OJGoIQpKLpD4jzlkaTZNZnfuXRCmdNYVRC49XeJC1w9pkSznjxrIdrrgW4WmekIIqt1UM2QaXoV0N6LpuKmxM/3h5unjJ7z9bppoapMjCCFSNyzcg9uookud3RLQWALpPotS+wal0Q3HhZLf4xw40xynE7z44bYQJ3N8XMtqB7ZQaG2d9IOU1caxnuXyEHOLe2ZyHunr52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8jyynSd+OGwU/oIx8ApKq/0K2oBFE7c9d3A8xWYhPM=;
 b=taZ+T/xucJksj+rtxLoD2tuIKuHld8tjOWOqT+orbZEfbM/jMQQIJsq2CirDI0Ae3qyN6RqCaoG3eZxZc9hPQwbCbBeSRo6FFY+XxK5G4w6/6BUgFAX5/nLpz2J4VvSJV1UdzUYSwiM0Q7GN8Fcn0Lvff083U5C/09Gk86yibdNtFUPIoP73zQgq1oWHP/FnVSWz1TgqFBfArC0kgTvY9LdxKbPEbb0JSsQSn/E/87FP46R0TcQu9215CmLK3PxDPKyPLklTMRHLdqx6Ec4v42hyOesC1Gs3GXZgGPKaoeB7pDk4kK5ivrw5CPlO3flu5vCWmjSFpVwdo3mo/LKt3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8jyynSd+OGwU/oIx8ApKq/0K2oBFE7c9d3A8xWYhPM=;
 b=g/FC2feW2ZkUCBnI30jei/b0pNb2KU2Zev4totSy/r++brLK9+K3XbibhifBrXoPEopsjEzlQchyCNHfSM3+ffShbhhp8AsOGi2LAFXLeqmx4QDov16uUpAQ79Xbce8A/oiZJ96pBS9xJp0RNRxmsFnmtxGeu/Sdogmy4+mLyDQ=
Received: from PH8PR22CA0022.namprd22.prod.outlook.com (2603:10b6:510:2d1::17)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 21:10:58 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:2d1:cafe::d5) by PH8PR22CA0022.outlook.office365.com
 (2603:10b6:510:2d1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 21:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 17 Feb 2026 21:10:58 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Feb
 2026 15:10:56 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: [PATCH net v4 2/2] xsk: Fix zero-copy AF_XDP fragment drop
Date: Tue, 17 Feb 2026 21:08:51 +0000
Message-ID: <20260217211019.48280-3-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217211019.48280-1-nikhil.rao@amd.com>
References: <20260217211019.48280-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 78170468-5266-4c4c-6436-08de6e690c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D5u8LIPBfOnz5meItmAP91WiesWq0txf9+ih5Ai9YqugLw7r6F6TO2myF4sp?=
 =?us-ascii?Q?0hegKh8Xgjc+dhU18qXimcqkHbo/kuvkKDeTKuYi1nSK+HcMNDJytMj6f7lX?=
 =?us-ascii?Q?uOfWBLuhkh1YWqzdoTMpBqUJHAR43LJqFa4lFNoO+Z+0PwnCsUTQXD+ftASE?=
 =?us-ascii?Q?tNEX5G905wHjDEpHwx6JXwJuKWhww/vf9bUbkCzCpH0mxu4JMpBsMdfz3Ish?=
 =?us-ascii?Q?U+K4nM9T/jO+fAyh1xXw10rSvejvjBv6C9N087uXWW+9Sf8Cx3KKQ94NHjgp?=
 =?us-ascii?Q?Citwinho80DzLz8wpySzYgcS9Zsz6O1f8cUFx7ff4N4Ha/mga+tHr1r6OXBg?=
 =?us-ascii?Q?k7t+QgTwp2T6vNosbClZH6WL6HG3KYBIie0uesNdgBsGJZSvT30avOEVSqWT?=
 =?us-ascii?Q?57CfKZrs4aoQkwiCIjeTur+wstP0fLcix2Qrr90UArau1yPLJd8np2G/2lnO?=
 =?us-ascii?Q?K89niP6bqlMOodxjxm10QFKF4BtpHM2Z3iICeufp4CmVUFEGO80YHk55CKSm?=
 =?us-ascii?Q?2Aik7BU6yALvhk1d9kJq5A4kXfpSU76kLUl9ssu2JnqmHv44oTbBxCYnLguX?=
 =?us-ascii?Q?+/tbGVuv4CV1snt9sRFuk1/JSCgR3Hwxnncief080RP7bZZL+gn6XXaeDsQU?=
 =?us-ascii?Q?LL6avzxprNmSiht5Ur0B6oT3zCFuJMf78KvJc3+pkbwQRdyV47m+HRlC5ur2?=
 =?us-ascii?Q?/2Fd4Q57Jwii4GoBTIvfCzecu5p8ImltD6WL2geDfDHHba0NJID2N9QGt2H1?=
 =?us-ascii?Q?M3d/EMYMw86aq4ielztQEJsDULZUsF4yX3CZr0AMyjt6BKnJLWuehjhHlO3z?=
 =?us-ascii?Q?bhcBafE++qYLbSEyZBkHd0uJSM0S3GT6fUKicwFNWcLWG3k0f2oPetm4YOSQ?=
 =?us-ascii?Q?kaZH33vgyC9dO/UsN1cyl9Oyy3YOIHvKT+ou91U6I7SJ2p8uK8QEKS9wapFx?=
 =?us-ascii?Q?CJ9+Yxg51CJ/PSuAokPOGCL2OpUoeCEeq6uzel5c9wV6STNVNpP1lxeUsOgS?=
 =?us-ascii?Q?6y/8vYbDXKnMX08pXYA4g7ba+HxbhUnZw/lX0LkxVc9JwFTkOVE/RrPvzjnH?=
 =?us-ascii?Q?Mq1bmNKdbeZJK0vaesdi1kDhT/xIwjvs6EmQof2FUUwpiLHMUgFl4DQ6KIuT?=
 =?us-ascii?Q?EC+tL6UCzxjFcVD7DOYZUvgOJOxvS1eb6QPSt9LtfdiatJRg2HVT2kcaTXSx?=
 =?us-ascii?Q?XTYvltY0B+qS5DcUCMDIbQWfczcX527rJh6i6P9psVm08Ztv8eIRdxwsuU2M?=
 =?us-ascii?Q?Q6N7VbtplQXO01jSBLZRR4R9QT5PCNbw5fyMCFhdPEqga+Wcetgp2EzkxmA1?=
 =?us-ascii?Q?W5gcitgfb/FUGSYs6meAof3NHR8PlVBd6kLo+tUu773ja8TG9rbEPd5JPMxk?=
 =?us-ascii?Q?ZvTfuSQ1pTMe/kJMUgPMSJ6UOvCFxJ+MkaBfev3OZQfwqCXX5I7KlJFrSibK?=
 =?us-ascii?Q?vtoHJNvCPkYmwqzj02bwcqK21mgvx9nL2YwJK9IQbVOrMzDMRMmUXGXAP7rv?=
 =?us-ascii?Q?+LQdQEFTnRnKhvhG53TyrO/bgZy4gLm1jX7Kz5WZGWdyf2Ytz/4uY1UW5kRA?=
 =?us-ascii?Q?3RlrOiKUZS5zEzSqpllU9XAc7Lg7Wp0pM/4z/0WhjLXiN/QccO4Ohbz2Z3Hg?=
 =?us-ascii?Q?Ux4FhLjYsZGDBwhPK4iv5eRnfoUHNW49lSeZYJiNaenA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z/zfrEUWmZdpLYbIgTs5VmPmpY3SLX0jVRNi9sZqa9P44F1hJV+/LtRXbX51q7eql4vc20WAr8HqtvN9QEHwdgKdkjvY4ZTQXAnK9nFdrOWERz21B13mpg90NSggMfHW5NRaOnTohN9bKcIH70dEwCI2ZmswUZkdw5w30zfQNnujlIonMoy9H3OJ4ZDMURD6lzn+Ykt6pKFbaox5wC1wez3h2ezoJNTjIXJfgpntXJrUfAW50WEelu/K24JKHf+lwscJn2Evg+1IeqjoOSR7gXYXBFYIUvgvYXWn+kGeEoDqfpele9CY2ykCfnjml70u98KaVoLquTHQkrjwaUGRUt+AJXu48qWz1YG10J+CmxtQ8rqTWwn9G1qtDIkKmt7wySRn5kAKBYydJYU1w3vLqro84K23w+fkHufB1TbY8M3QSsdCduWWwMPve5M7H2nX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 21:10:58.3806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78170468-5266-4c4c-6436-08de6e690c00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259147-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 30C4115096C
X-Rspamd-Action: no action

AF_XDP should ensure that only a complete packet is sent to application.
In the zero-copy case, if the Rx queue gets full as fragments are being
enqueued, the remaining fragments are dropped.

For the multi-buffer case, add a check to ensure that the Rx queue has
enough space for all fragments of a packet before starting to enqueue
them.

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 net/xdp/xsk.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f2ec4f78bbb6..f7f816a5cb80 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -167,25 +167,32 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	struct xdp_buff_xsk *pos, *tmp;
 	struct list_head *xskb_list;
 	u32 contd = 0;
+	u32 num_desc;
 	int err;
 
-	if (frags)
+	if (frags) {
+		num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
 		contd = XDP_PKT_CONTD;
+	} else {
+		err = __xsk_rcv_zc(xs, xskb, len, contd);
+		if (err)
+			goto err;
+		return 0;
+	}
 
-	err = __xsk_rcv_zc(xs, xskb, len, contd);
-	if (err)
+	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
+		xs->rx_queue_full++;
+		err = -ENOBUFS;
 		goto err;
-	if (likely(!frags))
-		return 0;
+	}
 
+	__xsk_rcv_zc(xs, xskb, len, contd);
 	xskb_list = &xskb->pool->xskb_list;
 	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
 		if (list_is_singular(xskb_list))
 			contd = 0;
 		len = pos->xdp.data_end - pos->xdp.data;
-		err = __xsk_rcv_zc(xs, pos, len, contd);
-		if (err)
-			goto err;
+		__xsk_rcv_zc(xs, pos, len, contd);
 		list_del_init(&pos->list_node);
 	}
 
-- 
2.43.0


