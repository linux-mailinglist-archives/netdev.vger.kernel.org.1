Return-Path: <netdev+bounces-175260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B43CA64A1E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 11:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5754E1889EED
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51710229B28;
	Mon, 17 Mar 2025 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uYtgYwGn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E54B2236FD
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207566; cv=fail; b=S2ciWD0X5jmjM6DXy7QETu6MIAJucJJ2xu1cDNn1nhepbFVLM5lX9KqEjk2BAE+pFeWY3yLUTHrinjC3s0o8HyjRQqReH1P16BpkUUSb0Se+lF44ZsBfkhShkHQG/XKzh976eXQW1bRqNGoatTrZUr+kP04eHB7v6mLfE/cko0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207566; c=relaxed/simple;
	bh=RW9iPk5edhdq92g3atHg/eKEYT3BRxLSZty3FARslPE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rvuKgZoJYrMn5TAbk4Zao489qfxTSGnU+Gx/u2pTq9w3uLieYIxdPyyga9pTonBL3NCmVFv+T4yrUkkPeHnIWMxIt7j4mGQ/AItnWc4F7VU83Fp4bM9TZflD+4W6/6NqWa/WfO7UBZ8Vf2bld1joO5407LEVpS1WRmj+pGJ3M2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uYtgYwGn; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVXgN5POCagrkEtirZle7RjgN1D7/2ZJsd1w/l6pLCOqR7+rC6KogXqeX7ZnZBSpjxLXWPuOjqtfadrOlwViFdnnDGb7BsEuWLW7WXwKiYEyvOo2rPAOWu660r+0Qj1mfevO2tJ7Q9o8AypW35SxNGIspaWmtik9TAwRhFS2VfsHokcv5qNK889wHJTsboK77pI15DRHnrcRZR+DWUePtYTNkYYX2dkXogXQZaUjA/LI5wadyFs2y2SRqQ/hI8FSA0TDpZSQlNBYxvcI6GMdm5CB1G9bY+JvljwKEDZSoXHpxf9EXPZFIVf9vvrIpf8hOhDH+bmM1nAylRVe+m1IGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+RuRlVtQ507E1RP9JuodkyMbiI0eGsRnxS40AgaACM=;
 b=kKeJrn6HdJSIcsmVoJ/5htzR0f5S0oR3ayMW77MvcLUjScUn7SLdjIqpCrOQQTlVAgZ5Acuh13wIODrIyKvi34COFiY/Cd9GCfb195AxeN6iP5PwjYauS5oBO3dhD/7sFtP8jlkhe+sQJ1KMN9TG5AIQscUcWMD7fI5o2TaXJbJdIRQ+kaCepdpeRxrX0In4QP5iLc5yNhFoLXQLdJGRMs/xiFgPeq92vcYtjbvNxq2BxCGusMQJJoi0XJreFYhNHU0qlaD6xu7m3kxkkK9taXsJyDsmk3yrXFyTJ+r7eZqObdrxeN72ZNV3P+srtmtXdybysgDlihjXs3qWhX7bew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=secunet.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+RuRlVtQ507E1RP9JuodkyMbiI0eGsRnxS40AgaACM=;
 b=uYtgYwGnbWZTPFsFfZyHCHzNEicYmbBsq4itAW9NMKJtYD6lnTm327zDnB21BgzmicnpImhKm0/jkZlUJ9pj6sn73KQ/l4VVOmtM4D0On2hkuZ23mfKPYlV0g4d0u78/tfA6W2nM+3rI5EebT91vlWaQm/bv9yB95M1deGJe3mKzTS+rPntr0l0zizPlO6dElXYwSC8JlluSTPAr22l6LEH2JJ8doppRAGrftXwAtfb9EGCWPcOUA5DbGs6qKpECRtePTImH/3Ax943J8wSxKsrAsi7yX9ByH8Ud/knDBzi1mbstI2Cm0+xSyqjoSzPNyc44u7iicwoKxflrGITh4g==
Received: from MW4PR04CA0080.namprd04.prod.outlook.com (2603:10b6:303:6b::25)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Mon, 17 Mar
 2025 10:32:41 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::e3) by MW4PR04CA0080.outlook.office365.com
 (2603:10b6:303:6b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.31 via Frontend Transport; Mon,
 17 Mar 2025 10:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.3 via Frontend Transport; Mon, 17 Mar 2025 10:32:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 03:32:32 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 03:32:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 17 Mar 2025 03:32:29 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Christian Hopps <chopps@labn.net>, Cosmin Ratiu <cratiu@nvidia.com>, "Yael
 Chemla" <ychemla@nvidia.com>, wangfe <wangfe@google.com>, Xin Long
	<lucien.xin@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>
Subject: [PATCH net] xfrm: Force software GSO only in tunnel mode
Date: Mon, 17 Mar 2025 12:32:05 +0200
Message-ID: <20250317103205.573927-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da56473-bee8-4359-4611-08dd653f0b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W+vOhaAY3NIVvpgQHcjGlDRqnUBm8fiSTn1r18jCzJmyg/D6VeW6e4dsFMRy?=
 =?us-ascii?Q?pX0KoudSSBJ4+5M/mZdYDS1oIyV8rFStvE0sX5Fl2oWqeiUYe0ljcXF2ivJU?=
 =?us-ascii?Q?hJUg+A0QRzveVrnoyPUK8ZG2XGqbEEMOH4ulvn3ApTXyUSSUzab6lF7xyBuC?=
 =?us-ascii?Q?qydCjNgfRx68DcS9c/xQ7gvF+mdemSwDr0SnfktfqKCQzauDxNhRhx0+iv0M?=
 =?us-ascii?Q?l9lHM6e6RFwgqIJ9xWjzFPgSWXrTOQ03nI5HxnMT7RxrZ5GbKLM+L1RxBfNH?=
 =?us-ascii?Q?4csL+1OGI/8Xrpnah/2WGqUiZ+af3istpcW+MviDfCyi+/S8WF0EnFNzYVoZ?=
 =?us-ascii?Q?J3kXxNIq6RQ2RSHC6K/9lxuqVy7cIS7oNt06Q9fu/ubgw33Pr4ScLgt4ZNWR?=
 =?us-ascii?Q?N61vW1uiNOymUG6BkhBvlc2UNH89PAuqfPLsNVKAkdT4HbjpFSD+r5wr9/Y4?=
 =?us-ascii?Q?D9/1tkgjzNb08lEXFb6+QqD2sfEbMcLr1pxwzCQ8zzq88QxFvzSEK0nKVrp5?=
 =?us-ascii?Q?8Q02bFsW28bEjJDxSU9gVKRDoQSxkPP5I9Gld6HpQuT7zif50vmig57zr6u7?=
 =?us-ascii?Q?YjzBs6VsQeCRFMz5ZaysarhzYNxIvKyKJ4M8Z9oYF6anz5/oBBrKUaYndtar?=
 =?us-ascii?Q?RKuMq+91WyBSzMhzxJZpMlWP+g2xgvt4veTRbdU7zIhyZEaO4tB2hSrUHKW6?=
 =?us-ascii?Q?X9LfRT4i30GvVcgAwDxgpjRVrmMHXxOePT3iOMj0Xetv54XdWX/HBPQ3GAT0?=
 =?us-ascii?Q?KXkJZImKDJQ7fZ/58YsB/uAEr2/SjYbNSxwgoGxsHxA94NEtAcLy/b+KTypV?=
 =?us-ascii?Q?uhXqXLfDuYqxwBtTRdsr2yCoRvO0dv1UglBpNJKk9bpgaymalruiasFd8m8f?=
 =?us-ascii?Q?4qsXuU2cRagqtzQo4B1jjNz8x14JOropmX5PAKxyYuNL5zvrTvdBO7H2TpKu?=
 =?us-ascii?Q?aqk1wPbwBK+ZYm97/X3qBkeyAIe8kAzuctblq6EW6vjjj8vSWrm3DejM5Gva?=
 =?us-ascii?Q?az1qIn/igQ+76iNZz3VwnFyXVyjx3adiKE+whwzblqd5xkB8fYYYGPcn22YA?=
 =?us-ascii?Q?zKXgaZsdbtELGCFjhl5hvL2nBOPflAF9Ji42EFUs5gbxN1EIVBHI933IYZBR?=
 =?us-ascii?Q?oNykibDoG/BYLPNnBu07rIsWO6s1Jbb873sMXIe0B1F0gCMeDYaaxbhEbQEi?=
 =?us-ascii?Q?WxwyuZy75WGywBucrkiGW5n1YHFl20dt1MtppASNPWhe+kHi97R0AlV0SIZ2?=
 =?us-ascii?Q?9RksURWt9YQ4sZ+TjhBFpfudsukoS9ZLxTqTlcitHSpONc1glKU2cu5eg4vu?=
 =?us-ascii?Q?wwnmasEAd/FSgCFn2JxEdsEfAsRasAgJsr/jLzywtMRhNj6O3ROqWruPgKbU?=
 =?us-ascii?Q?99SiVsuBnnL+bov+lrmDNlEMHrfHJN927r6Pl2jzTwbuvvaN9RLXYVpt259t?=
 =?us-ascii?Q?EZr549zaNG6QVf4iBGi0CF3ppeiIhj0M+nAOuyzMZcKcWi21MIpSz6XV6Jih?=
 =?us-ascii?Q?Rz3Gjs3/zn+KUzE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 10:32:40.2524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da56473-bee8-4359-4611-08dd653f0b4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057

From: Cosmin Ratiu <cratiu@nvidia.com>

The cited commit fixed a software GSO bug with VXLAN + IPSec in tunnel
mode. Unfortunately, it is slightly broader than necessary, as it also
severely affects performance for Geneve + IPSec transport mode over a
device capable of both HW GSO and IPSec crypto offload. In this case,
xfrm_output unnecessarily triggers software GSO instead of letting the
HW do it. In simple iperf3 tests over Geneve + IPSec transport mode over
a back-2-back pair of NICs with MTU 1500, the performance was observed
to be up to 6x worse when doing software GSO compared to leaving it to
the hardware.

This commit makes xfrm_output only trigger software GSO in crypto
offload cases for already encapsulated packets in tunnel mode, as not
doing so would then cause the inner tunnel skb->inner_networking_header
to be overwritten and break software GSO for that packet later if the
device turns out to not be capable of HW GSO.

Taking a closer look at the conditions for the original bug, to better
understand the reasons for this change:
- vxlan_build_skb -> iptunnel_handle_offloads sets inner_protocol and
  inner network header.
- then, udp_tunnel_xmit_skb -> ip_tunnel_xmit adds outer transport and
  network headers.
- later in the xmit path, xfrm_output -> xfrm_outer_mode_output ->
  xfrm4_prepare_output -> xfrm4_tunnel_encap_add overwrites the inner
  network header with the one set in ip_tunnel_xmit before adding the
  second outer header.
- __dev_queue_xmit -> validate_xmit_skb checks whether GSO segmentation
  needs to happen based on dev features. In the original bug, the hw
  couldn't segment the packets, so skb_gso_segment was invoked.
- deep in the .gso_segment callback machinery, __skb_udp_tunnel_segment
  tries to use the wrong inner network header, expecting the one set in
  iptunnel_handle_offloads but getting the one set by xfrm instead.
- a bit later, ipv6_gso_segment accesses the wrong memory based on that
  wrong inner network header.

With the new change, the original bug (or similar ones) cannot happen
again, as xfrm will now trigger software GSO before applying a tunnel.
This concern doesn't exist in packet offload mode, when the HW adds
encapsulation headers. For the non-offloaded packets (crypto in SW),
software GSO is still done unconditionally in the else branch.

Fixes: a204aef9fd77 ("xfrm: call xfrm_output_gso when inner_protocol is set in xfrm_output")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 net/xfrm/xfrm_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index f7abd42c077d..42f1ca513879 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -758,7 +758,7 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 		skb->encapsulation = 1;
 
 		if (skb_is_gso(skb)) {
-			if (skb->inner_protocol)
+			if (skb->inner_protocol && x->props.mode == XFRM_MODE_TUNNEL)
 				return xfrm_output_gso(net, sk, skb);
 
 			skb_shinfo(skb)->gso_type |= SKB_GSO_ESP;
-- 
2.34.1


