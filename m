Return-Path: <netdev+bounces-173022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F2A56F03
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159A03A8AB5
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60912405EC;
	Fri,  7 Mar 2025 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="gqKE0pc7"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2071.outbound.protection.outlook.com [40.107.103.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C441223FC55
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368534; cv=fail; b=KRVUfifF0vR52ab/SdEmfRabUxx7l4MoltrFDJJ5qoWsixOjsEllao5O5xzID9Hdr6qgMTSBFOJsGYGDhBmx7FvIwtdPuTxDb+schOkJqC9y0A4L7YBjsypOuXIlHC92lWvwsT9u54iN5N6cG7MZgpq98MS1VOpqWEZt8LsWaAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368534; c=relaxed/simple;
	bh=iP/STF8ok1+98e5rPJHqDAipkAHspJ1AcUq4q3Y7PQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSbwZZLUlxXLxSNujEjwIJohtNXr+DriUtZiUMk+q4hmn7qDSuZF9B2tYtUSSdwJv4nmyp6DCfiCQfDjTFqVo9n6bjdMvJqylQvSvln8N4GDW/98FvKwS2E0Lm2cb8HjR89I/R8Elu0f+qCfboMr8uD77XUvd4BlHpUnDcNePcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=gqKE0pc7; arc=fail smtp.client-ip=40.107.103.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDcG5NsAam7MZJCK1Y3sPW9RxC8GF7NFS1ULepAJ2onciAdLjMOACjHGbcurKwp16zL9X/g29wa8n3bi9FMLz7KLlkiJPlmfWm+Mlm4GWJi5ip0cVDanuBpvx2no3FnDDlHLRmGsDDDRuRCQRvqAkGdkp6QfqYxQqt0Rr4JPK07wrIyGKBSsogT8WbeHW2DUaS4bfwLhjcRh0KzvWAQmIwz8b5dPJxSeYRcVCICUArM9s9TLIKik3wVEq7l9cAgTud/i7PnOZmBKF2Gusdkvvd6qqcGdNd84tMYvXpDau6MS0CExON516Z5Hzeixluar/svhKmvoj47Svh7krHfOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4pHs4D7ubMwdVZrWBYe1fIwLx9MFoNG/E1FF+/pNTU=;
 b=iqMeME5+C33ThpxrUO66HRAUKvTUwGdfgqMlP5E32G5vNMtAeXOFbUSm9NvBDGtcTbnDtGHpY4RMvwUELIuVfxGONEFGwy9jI3rTY/ke/nQqJW7DRTE44ZTvqTKdAfiVNlh3yyOdfRk7+C8gjeA3QJWBpIVR8qKKGypm7aYCIKbzDaiPt1K/Wx8RyU/PVKX6PKPfVs/ZtyCZv67M5YMrJU3u/Ekg7yBBcBiYb+zwXdh4IH47q7hg03cbTj0pqoyR/gFvAJQ97ab0XyrurD/n2Y5VjhliXy75mKP7zFRoUtg+m7oc4iusoY/G19LpvEl6BsHldxowBWbnDLUM/Dhn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4pHs4D7ubMwdVZrWBYe1fIwLx9MFoNG/E1FF+/pNTU=;
 b=gqKE0pc7437DjKM/5ldkkq1sAMTFm9L4XKOqTSs1EvlrPqKTwnb2gqGey4I5GxFxy2ZApDkBnKU0k6Nf2WzNx9SNL+iflvzRg/j5dCFieW0Gqr1G7WbQYWPGu9iIxl9n42BmGJx7HFbv7in7LylWIpVTyinZ/kWc4OLkvtKXi2Ue81UVdzHtxU9/OLyk8AG1cp4TVMpGw5fYe0LP91zts7Vkr9Nku2Njgpn328LyB0JnNpKoQ1tWmdTvUNu//rbtILv+5Y4PBA9uIURBZbpgb+uYR6uN3NtfbLEeRKdGslUg2WOYhbTYR9ELRYfmO3WPabtoxun3hQTYMQRIvjAeSw==
Received: from AM0PR03CA0102.eurprd03.prod.outlook.com (2603:10a6:208:69::43)
 by AM9PR07MB7140.eurprd07.prod.outlook.com (2603:10a6:20b:2ce::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 17:28:48 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:208:69:cafe::a9) by AM0PR03CA0102.outlook.office365.com
 (2603:10a6:208:69::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.22 via Frontend Transport; Fri,
 7 Mar 2025 17:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8558.0
 via Frontend Transport; Fri, 7 Mar 2025 17:28:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id C5D8B20130;
	Fri,  7 Mar 2025 19:28:46 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v7 net-next 1/3] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Fri,  7 Mar 2025 18:28:31 +0100
Message-Id: <20250307172833.97732-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307172833.97732-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250307172833.97732-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|AM9PR07MB7140:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bf49a810-0897-4372-810a-08dd5d9d852a
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?9NavMCbFjl5wXCXznee/XP/ONjuFsD4c+rToiG7evJOtMv41m/Ok/0XTCYJg?=
 =?us-ascii?Q?4E7kB2pJTadnp7r4SnlUiHf7eZNFNGZkM4qx/gHkWnhjeDyq6YNefxd5CJaP?=
 =?us-ascii?Q?Jl+6UGKGZOso1FM7tCoJem+UGKXab5vegJWrw24q7yX/jIT4/Nw/M+TV0bw4?=
 =?us-ascii?Q?Ic0xb1aqR+VQy6LaeEhMDpM4UvxRVIEw6RXYW+Oh6vqu7G3DNmkeTWYJNZZL?=
 =?us-ascii?Q?2ttdd89Qk8wWExMTl6glSVo/Or4QkXFuRtxFleTPrX01YzXTNfXsyrB0EX5P?=
 =?us-ascii?Q?8QntMnj3/iAklLjs58YajsnpTYMhOChn/LAD5pxgNTeheYHz/HKQQQ0T6vWk?=
 =?us-ascii?Q?ynUVhPlX7mEpH3fF4z4XDSlnmF8nNnTyEvRgDbDl9XXExltOZAOFupTOyqkk?=
 =?us-ascii?Q?a04IMNHZDEOavMISBWZ/5tVds1+hITfHoZ+PWxkDFlWrBQjmjjmXbhwb+X0B?=
 =?us-ascii?Q?CFr9MzL3p+bKd7iA/1Dv03FeyNpszwoqonhg0h03QTYdfcJW+72WS2fT1Th9?=
 =?us-ascii?Q?+trq56qXKcs8u7NqeS+y+jxezlzTffY5pj/aLvpef6sgw1d212KbjJpwdO3a?=
 =?us-ascii?Q?a5aX9YqukwgaWrN9mDyc6jxPnrpDMFzDdrgj5sxWhjoQsmbLcXpctMdK7z2Y?=
 =?us-ascii?Q?8nTFdFaczjXBxeMUPGgR/ajX5TEuzN0widoqSZR8CxGglpzZVqc8xIyuYCia?=
 =?us-ascii?Q?1N++ewxr628RxeuTMj5bMnUPmZXWqR7F1x8NaCU+4pWBdaeCplpk3Of5kNQJ?=
 =?us-ascii?Q?rEuBF7ZgiG9NGxPgYTzc8i4qPOGdzR9ckUZDqo99qVsMb1rSd7pxdJjzg6TB?=
 =?us-ascii?Q?p3fWYAaTtCEcPO6RIQcHEXv84so+u34XUp6CXQH8SSYfgDmIGns5gTxX32kk?=
 =?us-ascii?Q?rxb4LOiCKgFgltsw+l6XoarBGVQ8VtJICAmsxPlvmPLiOSNa++KEu7PQA3Kt?=
 =?us-ascii?Q?U+/ZivWVI80zcHJvOXIzn4FDYEA6u9nCfg6SUUpPcfVeVYm5tg7dZH651luj?=
 =?us-ascii?Q?ETsNU3Vl0YsOK83ZlaLjAzKH4KOJCoRcpJLAwuA7FGkI2dj70/WXcRXBTd9k?=
 =?us-ascii?Q?K/GB20aqsegaht60qvO/5Esr1rIWLLVp/qNQ7Fsqfd4B1+6dHhznVJi1/qwe?=
 =?us-ascii?Q?kwQ65dVnisllX1zNiY5WWo0Gu1ckiCS0JbxAdFwz7X0kjTubwWm05heREOBh?=
 =?us-ascii?Q?VBu3VH4bP7JSNdh5H8QJKuwuTY1FeRuALqy38cBBSmGoq+XRHdeLwbV3rHUE?=
 =?us-ascii?Q?zpTjfm79SA9gk+mqbj1qezspef8OCvO95GN7AodHEZdU4Jq54yjHiOAT9je0?=
 =?us-ascii?Q?w8ab1sATZCsxrHwFhWp7XTas7GKGdz1aGq89eAN1PhK3zax6S9c5jtX50X/4?=
 =?us-ascii?Q?h1P1clMyvVUn8mXxV07BhbYRNsG69jcKSrMs7Bnu1zENjdKJ0S+vnv3L9UG3?=
 =?us-ascii?Q?Hhw7UoYXAfPdmvB3jL7paHg5pxFarne5yeWB384x6YF+T30xET4CLvBcRjhz?=
 =?us-ascii?Q?q2NVhIyLnrVhH8mp2vc0xvZsw8UpJ7w/oSm8?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:28:48.0944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf49a810-0897-4372-810a-08dd5d9d852a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7140

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Describe the specification of tc qdisc DualPI2 stats and attributes,
which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
(https://datatracker.ietf.org/doc/html/rfc9332) to provide two queues
called low latency and classic.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 Documentation/netlink/specs/tc.yaml | 140 ++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index aacccea5dfe4..43678c3bad4a 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -816,6 +816,58 @@ definitions:
       -
         name: drop-overmemory
         type: u32
+  -
+    name: tc-dualpi2-xstats
+    type: struct
+    members:
+      -
+        name: prob
+        type: u32
+        doc: Current probability
+      -
+        name: delay_c
+        type: u32
+        doc: Current C-queue delay in microseconds
+      -
+        name: delay_l
+        type: u32
+        doc: Current L-queue delay in microseconds
+      -
+        name: pkts_in_c
+        type: u32
+        doc: Number of packets enqueued in the C-queue
+      -
+        name: pkts_in_l
+        type: u32
+        doc: Number of packets enqueued in the L-queue
+      -
+        name: maxq
+        type: u32
+        doc: Maximum number of packets seen by the DualPI2
+      -
+        name: ecn_mark
+        type: u32
+        doc: All packets marked with ecn
+      -
+        name: step_mark
+        type: u32
+        doc: Only packets marked with ecn due to L-queue step AQM
+      -
+        name: credit
+        type: s32
+        doc: Current credit value for WRR
+      -
+        name: memory_used
+        type: u32
+        doc: Memory used in bytes by the DualPI2
+      -
+        name: max_memory_used
+        type: u32
+        doc: Maximum memory used in bytes by the DualPI2
+      -
+        name: memory_limit
+        type: u32
+        doc: Memory limit in bytes
   -
     name: tc-fq-pie-xstats
     type: struct
@@ -2299,6 +2351,88 @@ attribute-sets:
       -
         name: quantum
         type: u32
+  -
+    name: tc-dualpi2-attrs
+    attributes:
+      -
+        name: limit
+        type: u32
+        doc: Limit of total number of packets in queue
+      -
+        name: memlimit
+        type: u32
+        doc: Memory limit of total number of packets in queue
+      -
+        name: target
+        type: u32
+        doc: Classic target delay in microseconds
+      -
+        name: tupdate
+        type: u32
+        doc: Drop probability update interval time in microseconds
+      -
+        name: alpha
+        type: u32
+        doc: Integral gain factor in Hz for PI controller
+      -
+        name: beta
+        type: u32
+        doc: Proportional gain factor in Hz for PI controller
+      -
+        name: step_thresh
+        type: u32
+        doc: L4S step marking threshold in microseconds or in packet (see step_packets)
+      -
+        name: step_packets
+        type: flags
+        doc: L4S Step marking threshold unit
+        entries:
+        - microseconds
+        - packets
+      -
+        name: coupling_factor
+        type: u8
+        doc: Probability coupling factor between Classic and L4S (2 is recommended)
+      -
+        name: drop_overload
+        type: flags
+        doc: Control the overload strategy (drop to preserve latency or let the queue overflow)
+        entries:
+        - drop_on_overload
+        - overflow
+      -
+        name: drop_early
+        type: flags
+        doc: Decide where the Classic packets are PI-based dropped or marked
+        entries:
+        - drop_enqueue
+        - drop_dequeue
+      -
+        name: classic_protection
+        type: u8
+        doc:  Classic WRR weight in percentage (from 0 to 100)
+      -
+        name: ecn_mask
+        type: flags
+        doc: Configure the L-queue ECN classifier
+        entries:
+        - l4s_ect
+        - any_ect
+      -
+        name: gso_split
+        type: flags
+        doc: Split aggregated skb or not
+        entries:
+        - split_gso
+        - no_split_gso
+      -
+        name: max_rtt
+        type: u32
+        doc: The maximum expected RTT of the traffic that is controlled by DualPI2 in usec
+      -
+        name: typical_rtt
+        type: u32
+        doc: The typical base RTT of the traffic that is controlled by DualPI2 in usec
   -
     name: tc-ematch-attrs
     attributes:
@@ -3679,6 +3813,9 @@ sub-messages:
       -
         value: drr
         attribute-set: tc-drr-attrs
+      -
+        value: dualpi2
+        attribute-set: tc-dualpi2-attrs
       -
         value: etf
         attribute-set: tc-etf-attrs
@@ -3846,6 +3983,9 @@ sub-messages:
       -
         value: codel
         fixed-header: tc-codel-xstats
+      -
+        value: dualpi2
+        fixed-header: tc-dualpi2-xstats
       -
         value: fq
         fixed-header: tc-fq-qd-stats
-- 
2.34.1


