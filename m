Return-Path: <netdev+bounces-95581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF1B8C2B14
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501DF2856F2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 20:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3F850286;
	Fri, 10 May 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lcqda0Tr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3753A4D9EA
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372414; cv=fail; b=MsfzQ2EZVNfvmu787NHqSDknDgX5qMXUrL64kdwpmgXnXHI7qxerz14G7/dEz6dY4bTyZwQfc13OL1EeJ7H83N185Ds4ls6Jld0I1g71kNl+j8AdXFj8RuQOXQkpY8TNxOKe2JwcEXurBipILVYT2q5yTTuYGxeeFTGnpnkh/vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372414; c=relaxed/simple;
	bh=LExsIF09fYECiGChUExPQStEbHuCJkvZVeAvgcGh3dY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/SNh3e7UmYljeaz9wv0Tr1RD7r480Iu9P4gB2+rRCWnhmgCyu+JNRPqH94wUkPblfqKdG1H0MxDP6hvXqE5lNFD9MDh9iuzEaWT6JUWILxJMnd6AZVjia/dmxRpf13iP6BunTPDuXEpYADXWStMeZstKIszsEHwnfJXtl9kwpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lcqda0Tr; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgCcdAkEcDKa6Uu0ToAKUNmY03bXtHyPjlrWIJ1KjkxAJAPHz7xcgRr9mUsvF+k2A5AHSzvyOkrUCsKbxu4WU75aKmn2Pk1ylqWb0MLy6TX/H2//9NfvdyVeK2tohOlkUvYVeBxcrBT0hMPUi7LByZdMc+RROqFIBQo3o8hiS64xTfdCi6JRr0GWODx2TmadmfBXjYpfusecOK9u54l+u+R7WEI/q2v7tQioqURGOSf+eNARbYeayICH8rwgkQ+n1Jp47HDD9Ccwc6ZHiQkCa61+CImTVdcfltVneATrqasUQYYn4Mn0dlcPeGgvQhmfyKCcYT3r4K2dI/cYPNELNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzU/RTGSlpJlzeO17sccM3INT6bEJZPrxtGViow6rJ4=;
 b=NDD1cqE02t1UBFPKC7scD9boRuMCgj3W5LXF1VtV5+ukuZ7pJbZSJ8lQ7jFKw7dy7wt/b+MDVOmbVJJxRgkoy007YrwGd5UOa1U9k1mdr678Z/POc9xSBFcWAPCkSaUaEtNHMyqfLpcKuIXwyOLuhJU5lgz8FNrGIhojGXSxJ12pPtmKFsFXVLL5jVQNiUNzDS6V7lZHLPadfPyb5M3WWVuk2s8IcWqdDiCCEzTF8Z6zTpHK8irU/VPSC+Xgek1iE/XCQSQjMmf1DDpXJWx+QqRiJgCmpMBEvcigk9wQdHIEanKts95SReuPARvINogvFSIZueXS6W0OsjYIQNNMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzU/RTGSlpJlzeO17sccM3INT6bEJZPrxtGViow6rJ4=;
 b=lcqda0Tr9d89N+5se7Js0JtVBvxlVcWZtY1dkCCXNjJNbFuI81yM60K3iBGVVIpXvvoVjYD+OvhtPAafDDGgEfZ30qAH5ajsbrbAKWy1UJ+pJj7rWagN64fGVzZoWhaHu8RAvp7bgGK/Sum3A/2F+0+7GwN240TfE6pCzGfcYqrhKykFkBlvLYST7zelLZYWZMM/hET2Rtah2Bar+Zu6wu8NRCLR8anST/ThWDeqfSv1vAF2FdJ/xWYFMRnOI8mNoXi1ZigGYaSfvjf5vvPKRqs/ZUpKt+M09hvrACQgtgnastV6LvN3rALgkaG/ZwkjGehM8SyAMZcUKVG3jTlweQ==
Received: from CH2PR07CA0037.namprd07.prod.outlook.com (2603:10b6:610:5b::11)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.52; Fri, 10 May
 2024 20:20:07 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::2a) by CH2PR07CA0037.outlook.office365.com
 (2603:10b6:610:5b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Fri, 10 May 2024 20:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 10 May 2024 20:20:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 13:19:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 13:19:47 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 10 May
 2024 13:19:46 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v2 1/2] netdev: Add queue stats for TX stop and wake
Date: Fri, 10 May 2024 23:19:26 +0300
Message-ID: <20240510201927.1821109-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240510201927.1821109-1-danielj@nvidia.com>
References: <20240510201927.1821109-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: e7650a5d-bb98-4fd8-9064-08dc712e956e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RfBsEBbosR1DOjdpZoqCQEJ9p9iZBluz2yWuoKPRE2EChi7ncJug/reEzUd4?=
 =?us-ascii?Q?9Dc/cYfrupDQbFWkoqRStOTngZWNlIfcJhrbl2AXEz99CazL1IiPyta9hvUm?=
 =?us-ascii?Q?iDy36D6akX6KUXLN8PoPeeXZ0WALAURKHMUSWi7UwazSPCLND6/qljAlTUso?=
 =?us-ascii?Q?ASQkxLDxUtXgilnWgb2LWUTRAW3f1nutubjS2b9/XGdKdqBgTO5Gi0abJN1D?=
 =?us-ascii?Q?WYfU7ZfH2EdEx1b/SORx6Fucaa30RzL2iieTLgq0uY3kHwuLqMx6PjInU9R4?=
 =?us-ascii?Q?mCN0Yv+yepmCQGGetmMbYedFCS4t8b+UDQ8erNwYhjjw0Ya2P4sntXQ9wwQI?=
 =?us-ascii?Q?ix8Zfe1L1vUGRaDmtbNq88cLRs6ywWUMEJ68gPDmqx7wrYA7JzXt7CaL9l2N?=
 =?us-ascii?Q?jlrUcG9IOCEmUoWbypAzpsxUefeB2tqPDc/RyTLcw4L0u5lhMxBMixN/Knzl?=
 =?us-ascii?Q?X7eSwoj4PI6RwJru5IKqWs4xioxQJ5oG5w4vovkjjwRu3nkfq6T7FmkB3TeF?=
 =?us-ascii?Q?IyP3qPLXL67Xvn2B3aXnGp4tq7OlBJhxcvcWWdwu85+x9E9jP5oH/MM9nXAr?=
 =?us-ascii?Q?+p5MUA9rCF3hs4Ljk+wD634X7PKlp14omJU3T48CL3UWflqMndVZeE5eZDNJ?=
 =?us-ascii?Q?lWSv/04cd3Na1D7HeCre7Zq0udqXR23bf4vzsS9B7C8FzH2X2M2XgvJx9qzO?=
 =?us-ascii?Q?T5dxqZXafhkgLdwlBtdyJW13TO5bG0+QcgOiRIf0RZpI5Y8tNpsHPtXX+hnX?=
 =?us-ascii?Q?bSTSpaoQJcAcI6oettxIwhw6E4cwdOeGO9tFwuRjRIl7mScTe4g+CYDyxgVp?=
 =?us-ascii?Q?KZJ57ZLS+RwJvTY7RFPZpqnX5mw8fZSgFzWA1EIiQicbiJQhGc8oxhGitSNr?=
 =?us-ascii?Q?RGlxwf7BVlJ7vsMqdT3TxWaAZcqlbWKK9YGeSKjUZPBToha3vL9NTHRVGFpt?=
 =?us-ascii?Q?DKLCzyzUn7VQq0AGXbUfkNEUwTYYWHZB8YOWSXisWfX4ttNBHdaL/NQwusnG?=
 =?us-ascii?Q?XNtsdUW6SheOk9DPUlYlkUTE1vU7mSElEgvdBjdtxNaL+pRNLbVZQ4hwZ1AF?=
 =?us-ascii?Q?kDnOBKnhD+JqItyA1pCYMriIsrKvh4mWWY8vFrEHnxkRtrUzef6mhrFF1a2k?=
 =?us-ascii?Q?XLiDV3u0vEBuoC7myJuH4KBVRFwgM+sx75eElNQacL/exyn4ZmxiL3j79bxl?=
 =?us-ascii?Q?uRNj5F2pw2n9xENV/sZyYwHhFAKh/mOgxGRVOSzjiYVCOv98henP/F/UuYDI?=
 =?us-ascii?Q?Hgs3NMVXVcNEF8U0j6j0D8hv6dIQQpNK706hvJ15SfHv4ynr8c6+WM3Htheh?=
 =?us-ascii?Q?iJ8ArxE8yEIapP3cmze3Kj2ht7dSxbiLHIJC7O8hU/TXg8z4Xh+RFqTdt21o?=
 =?us-ascii?Q?t2UwN7x5Zeb05LIKTPKmwN2zb8Ww?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 20:20:06.7534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7650a5d-bb98-4fd8-9064-08dc712e956e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118

TX queue stop and wake are counted by some drivers.
Support reporting these via netdev-genl queue stats.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/netdev.yaml | 14 ++++++++++++++
 include/net/netdev_queues.h             |  3 +++
 include/uapi/linux/netdev.h             |  2 ++
 net/core/netdev-genl.c                  |  4 +++-
 tools/include/uapi/linux/netdev.h       |  2 ++
 5 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 2be4b3714d17..11a32373365a 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -439,6 +439,20 @@ attribute-sets:
           Number of the packets dropped by the device due to the transmit
           packets bitrate exceeding the device rate limit.
         type: uint
+      -
+        name: tx-stop
+        doc: |
+          Number of times driver paused accepting new tx packets
+          from the stack to this queue, because the queue was full.
+          Note that if BQL is supported and enabled on the device
+          the networking stack will avoid queuing a lot of data at once.
+        type: uint
+      -
+        name: tx-wake
+        doc: |
+          Number of times driver re-started accepting send
+          requests to this queue from the stack.
+        type: uint
 
 operations:
   list:
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index e7b84f018cee..a8a7e48dfa6c 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -41,6 +41,9 @@ struct netdev_queue_stats_tx {
 	u64 hw_gso_wire_bytes;
 
 	u64 hw_drop_ratelimits;
+
+	u64 stop;
+	u64 wake;
 };
 
 /**
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index cf24f1d9adf8..a8188202413e 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -165,6 +165,8 @@ enum {
 	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
 	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
 	NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,
+	NETDEV_A_QSTATS_TX_STOP,
+	NETDEV_A_QSTATS_TX_WAKE,
 
 	__NETDEV_A_QSTATS_MAX,
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 4b5054087309..1f6ae6379e0f 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -517,7 +517,9 @@ netdev_nl_stats_write_tx(struct sk_buff *rsp, struct netdev_queue_stats_tx *tx)
 	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_BYTES, tx->hw_gso_bytes) ||
 	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS, tx->hw_gso_wire_packets) ||
 	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES, tx->hw_gso_wire_bytes) ||
-	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS, tx->hw_drop_ratelimits))
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS, tx->hw_drop_ratelimits) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_STOP, tx->stop) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_WAKE, tx->wake))
 		return -EMSGSIZE;
 	return 0;
 }
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index cf24f1d9adf8..a8188202413e 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -165,6 +165,8 @@ enum {
 	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
 	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
 	NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,
+	NETDEV_A_QSTATS_TX_STOP,
+	NETDEV_A_QSTATS_TX_WAKE,
 
 	__NETDEV_A_QSTATS_MAX,
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
-- 
2.45.0


