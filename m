Return-Path: <netdev+bounces-173026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2784A56F10
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D277A21C9
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968C923FC68;
	Fri,  7 Mar 2025 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="nLJukT73"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012061.outbound.protection.outlook.com [52.101.71.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFC023F267
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368763; cv=fail; b=HUh1E/KR2MGHoxDRPPHiiN8q44OTW/K/vvxbTek+sS2vrUmHMGPF39T7D3wurOEkLorlcOxk5D4ScOhMMiPir17O9nmuGtiLabQn2mbrBKaYSPBvbsb44151+Nldj0Si8Jjh2edQA3wEtnfvOoED+MUsCQZiaZSoyEvhmvlGYGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368763; c=relaxed/simple;
	bh=iP/STF8ok1+98e5rPJHqDAipkAHspJ1AcUq4q3Y7PQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHUE32yK9vCnNxNL/Y+tI9mSYclqJZ6mFACMR1Q0tZYjyEaP1iV6wO5qLvLbz3cAey7GcsN7ViyIndrM8UjflsUhZFljJK8V5F0cmlLQtf8qa6qcOYowVtEMYlS2Ge/pEuz0EVRMSyPX+YPticRISlz4iQ9jJrOIJJBkvF71jFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=nLJukT73; arc=fail smtp.client-ip=52.101.71.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m43I+Jo+pBajbMqCQLusvUNi6zkobNSiLx6n8BCfbJpkbwFC5CKTG2hdmPkhOnVtO4gDDG5LXB/CHoMIZCikLn5IHwllydw39Uy5FiV7+eEPfHXA0HSOcyFCQirKAJFy/pdGWjjDx6eEZfRU6Uh+hPCCD4wDEGV0z8cvg8FQ0KeBwLb6PaPCWwgSOagMPu6C9o7fpyyeu8nMM9G1C8D8ZCj59rKicgwMgGcum0Hou6u3zZR0bjhgp1JJKpqSDP20hWaiyVGKf2LghZAZK31EH38bTlGshGCdhbp9viHN81RN+fnEaYXS98A0M14Bz8meHKtbjf86PMC6lr93EJAX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4pHs4D7ubMwdVZrWBYe1fIwLx9MFoNG/E1FF+/pNTU=;
 b=eN5AAVDYZSEgisNo7UewsTT0axp0NAp9Z+O7LhYDaxrzh9wbYvb8H3dvcjsUnGFdauqbcRURioyhOqiYjpI13lPViprmu8gJZnjTM3Mg40NFq+mBCnMwRADbWI+Lt7Yimy8k89y+nPKUZnWYcU+SZdLU1o3v66zX0sdJY5IpLoPk6oIeF198zsv9NfprB2DeSInWvA8mPc3XBGcER4vMQsYs8LDnxhiRmMi6UDq5B7bt+G44Qr01dDw4tszLNmySXzu34NNkgSrRLh3m9SLAPWvizgnpi8I66NXwWiCUc6EnZYKtfItxB0ch25We10HAruEqP/KnUITO0PWachs/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4pHs4D7ubMwdVZrWBYe1fIwLx9MFoNG/E1FF+/pNTU=;
 b=nLJukT73XS4hk7X8KXsLwjLzA+cPaPF4KOQdzkwn5Pt8RcMWoOc/PCiioLq7gLD6vMeKENOz7Val5brKL+2YSQtQYctc7LpOAsEBOXcOuNn4blp5hrAHn75/heeCFO0dF7DNrjUeq0EmZL5fegkilupw3zq7rQm9k7MsGwIEBzhvjvvbuYK+EOf+OB4dVvoW9v3oz4hFhShm4P4bs8y/PYpL5p0XQAlY9kPTKqCet8ZK9UR5NmZR+shVP94JwL+h6jbU6s/j3F2n0eV2tuBLlNT5QiN77ERy/ZpcP0FDnXT4QRMdtThcYfHQCSDgw1JHe5ua8d4esS62jHGYWvQ4+A==
Received: from DU7P195CA0027.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::20)
 by VI1PR07MB9897.eurprd07.prod.outlook.com (2603:10a6:800:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 17:32:37 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::a2) by DU7P195CA0027.outlook.office365.com
 (2603:10a6:10:54d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Fri,
 7 Mar 2025 17:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Fri, 7 Mar 2025 17:32:36 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 10E19219B1;
	Fri,  7 Mar 2025 19:25:18 +0200 (EET)
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
Date: Fri,  7 Mar 2025 18:24:49 +0100
Message-Id: <20250307172451.97457-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307172451.97457-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250307172451.97457-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8D:EE_|VI1PR07MB9897:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eec914fe-6433-4394-6337-08dd5d9e0d76
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?5TLC9VJ0u4qcuZsmsezx/N1etSImK0h8G7s7ZL6J+ttEVI0Q2AKqWZ6QnxnQ?=
 =?us-ascii?Q?MEgnQwVrtU98ZVBYL7G5vBNvPLT4/EWP+aARdRfeCQtdSkq84F2i8VgPTBSe?=
 =?us-ascii?Q?gRoFBIvQwEjoZas5lDopD3Lo/Br4rtV1hu9U0+24ijJS69w1z9uPqThLgsyG?=
 =?us-ascii?Q?D2dCAOyI9OshkC3fHKIIzaywaBDDqeVd2aTeHS/A/70hSO5+bWXcTPzqeGzt?=
 =?us-ascii?Q?ISfNr7Q3ZwBSeCFZ6TSrFi27ECJSwoByxCa2Ra4PW2VJULxeqymDyDElt1R4?=
 =?us-ascii?Q?s0Ai/J3sM74Wh/207X3RnAMuE9QuzPkphIJmuL+Dg+S/k/FqoMHOsLXKW7FO?=
 =?us-ascii?Q?EOK/R6PYP8KR8OR7AMrxyEmVR7w82o+xZL3uAkUBtzn0mjrOBUjzqd9UF4M/?=
 =?us-ascii?Q?qaNkFtkZW8Ko7IjjO2IIFaFpkMmgZOyX61U9bfw/p+sRUIroB+AIw261H/Fz?=
 =?us-ascii?Q?+W7GFthRxeFFu3EQT4/jewrTV2KkbXCfgUK1U61U+FW48Lvfv0JX3IDAeToW?=
 =?us-ascii?Q?HokvlbW3rZWbYZhty8IiISvbPfJhx7hTakyM2ao9j8N757esJV+vGg0vEoxh?=
 =?us-ascii?Q?+qNUc7vpXzk9WeWIgFJPRJ9+m5XDSX7Sil4lhsOKvUrwiQG7Rdm3paPJwbyR?=
 =?us-ascii?Q?BZZbUiYN78xhk5ZqqDkxAXz25Z7Mu2srJlaeSDiGBksnAaaQ0hqc7pOtn2EK?=
 =?us-ascii?Q?F19Lb0KXsg9AW1u+cRUsMkMsEgOKUXhokrBP9ACb07MdlNyddxItkS2FT9YX?=
 =?us-ascii?Q?P4/ubG0vCarMnOqmQPzixpmpW5Ehm43iVLQJM6te4LwkbN2ON9IVjl6YmLI+?=
 =?us-ascii?Q?MVk9eXyCF4BCm5IgyfXd4odeGZocYXKXBlEgfBFTXdta3+gN5p2XeBPz/s86?=
 =?us-ascii?Q?dCtwgAMhBybFfnI6HIFf3y5fpctyLZvMgKuHbWNzlyvZjruZlARsP2tUvuit?=
 =?us-ascii?Q?IFokNbHuZzAgP+ZXvTVPH6LJQYmM8JtpoZrNPCmnu0OvrgQ2NNoxmDOjm2jy?=
 =?us-ascii?Q?yxyFUndrZebpQs+w84owoxhipkgAgIaX2asIdpEPj1vfXiYBaeS3cnla7BD6?=
 =?us-ascii?Q?uNRs29l3XEmUdp1ih7SOA1lWxE3VnAcDK+q7EL9/vdpoSALZqUEbcCyurxdu?=
 =?us-ascii?Q?d51dJa5zV49RxgTEgOIv9nCOp9tO3/UTmQqGCtjQxCvRE9z7klGAdEkiUDbX?=
 =?us-ascii?Q?QMdTgexSdVrbCGzv7pdDeIS+xuthYHLTbbawnaOywQ8pnFn4Twg/kzAKH0VN?=
 =?us-ascii?Q?/m72iL6WLfm8ZpQXh0pBioLcUHF/cskNPjzkTHbNrdmVje/VaT0kF9HUU5wm?=
 =?us-ascii?Q?2o6xrcHfoGwyUuf9KOQuYhnUl2OHy9RKccWpLk+ky4bD8XL2QgIGs1g1jpUk?=
 =?us-ascii?Q?Rl98V/56cCTw94Rge6I4QBWldBOBGsu0xdcKUtz4lFXYdWzW8xK8Py7rL881?=
 =?us-ascii?Q?GVT9KVxydpck4Q711lHBaIK2/ipmjxfOqjTtHELzMjZfL0qpuYhJMNWphHaA?=
 =?us-ascii?Q?+aJEJAXfAn4RSYEPV+Z+xaFYrDWKD9CUg4cR?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:32:36.7463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eec914fe-6433-4394-6337-08dd5d9e0d76
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9897

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


