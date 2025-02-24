Return-Path: <netdev+bounces-168896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E375A415B2
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 07:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6923B1C57
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 06:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2A2207DF6;
	Mon, 24 Feb 2025 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bBuKW6PQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB27C8C7
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380017; cv=fail; b=du89wqSaM/HJnReEB0wviau5gbbREqIijBn/hMmnGA5XwNvylpFR9dEncEhn40EOnIwEpaNInqJPI1MTvC2Oakim/lATMnyPQJk5ZA3de/KydafMshscTySjgordNYjz+HmsHkjY5AbAt+ROB0HqM2E5VwF8RFCxgZnC3+ygnhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380017; c=relaxed/simple;
	bh=tly8zG4/k1WKSiKWycIet/C52NFzCNLUI5Zw9hukI9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NiNTpGuIcRljbxClGybujcsA/uMGARZqngAGoisguVOdnJ6NElPGJWsiHgrKCLB/HJ8+3YYU6yXwiB7QU/HDccHCtYctJjk1MLtfg31/7v4+vPkuiOpofwHj9ZVmOUyRnK3oALLxP5+obManS3lL8AIK9qWPQ5U6IKi3vWMXyls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bBuKW6PQ; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjrGh4AqQ2sPSuUbYs8dhW1LlhT1Vqo4YgzfyRnbyrlM0+Nv/Atff6sCQKIPMA0i6WqOWNWE1875EZsPihmhz8dl7hzMCrge7QjLnJ6CLdzGWS4VgP1hFc4G/Xs5ynlPLLiBbB+ZmEH/kUy4ERNMk6L2IzpDz7Sg+g+Kd/8hEEZpP811dD2Rs+36RcIplVWbskemvRj9pHQ/v2Fy/rK+vlROjvFxcikPvvqoB42v9eQspZqbBDBgR5z/k90LHSswYXZKJV9AY+buBK6C+c2GI2b8cX4XVwl2hcclBVaqmebpmQuqIhZ8JSarH8Pr52I/FhypJOvhbazL97CX2wW+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvkfJmuxTCIG06rZCADtd5h+Yhz6gSrhaYRvZLv7NSc=;
 b=HSnEt7c5MCbgCA/DPWuTxdWCH8F7rSFO43S7UPXGk3EI7xg4Wi/LULLWdujNSom3AhNFw0sDfcVsDF8JlP3/MJZcy3mvT1L9T1lnfxUZkY+/jyO5guylFZ5eHjRRfFhkM33Lq2zIEBNhD8Jn4tMatvohb01WE9jTrF5rwGTos9MI1UAu6oVvAAdsshT4PxnJrtrvM4Nogptmw5g6ly5a64mRuBCaA2S1bCZcFiF+/PcHWuXKGwqJK2ynXIDyst0HYnL/R0FQtnHN5oUEhAPuADfljb23jO6qXYTCUxNrafZT3meuNadT99UpA6k3tfTY6frnixefWwPXRbDF0ZZ0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvkfJmuxTCIG06rZCADtd5h+Yhz6gSrhaYRvZLv7NSc=;
 b=bBuKW6PQzF6d4x1I5J5yaQXMI5YMrdFrwU/N9g2gg84aB0pqloj+DjNijeTY+F6xRFqOkWgAC6bsNKhlnC4APZLQXWnYJoyy0zgivAPRqJiZmlsGHLlxEGXQKjxfjqeoBZFHkV1IGU+UGCG9rntm59FCCgmyxfIz1uO+sSfZLe22KnM6P/CrRdbgH2Gwyr6ddBJcwCo30hrGMxMOgx8Z1uo8X0119DFtFU5QnDh0JjYbEi7PvpXdYdg4ifv3bRgnJdsvly2wTVYb8iMiUFzTSD7KZ1Wx5sSErvGMp9jGzOJPe3JeMixYPWxi7bCSvR+tK0/d8fmaHGZpufj7Uk4UjQ==
Received: from BL6PEPF00016413.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:b) by CH2PR12MB4231.namprd12.prod.outlook.com
 (2603:10b6:610:7d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 06:53:27 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2a01:111:f403:c803::) by BL6PEPF00016413.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Mon,
 24 Feb 2025 06:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.0 via Frontend Transport; Mon, 24 Feb 2025 06:53:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 23 Feb
 2025 22:53:17 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 23 Feb
 2025 22:53:15 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, <dsahern@gmail.com>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 1/5] Sync uAPI headers
Date: Mon, 24 Feb 2025 08:52:36 +0200
Message-ID: <20250224065241.236141-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224065241.236141-1-idosch@nvidia.com>
References: <20250224065241.236141-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: a573b351-2430-4c6c-b1da-08dd549ff0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bbnYo3d3Ashr6wHXqy1gE+SnLgY/y/shB1S3GHOdBpIDt5v+YSL3lt75ulAH?=
 =?us-ascii?Q?3HjJk9M6WcKbR/3ZfNYR5vROxJ+UipZ0PFN0FkuYfE3p+ZgFCEZSSlFuUnNf?=
 =?us-ascii?Q?ssGxyw7TaiO+8erEPEh0L/vPesJ/B6FtOepA/Q2XTGeqg+FPWFXLCHQSHd/o?=
 =?us-ascii?Q?HthjmRnh2qMm65OSir6YQeqN1j7UP4DapjpMQMs3f7tyPsole62/IrKrzq4+?=
 =?us-ascii?Q?wxNL2Ol78R3lUhCayamZ1ljY2ahCY3rTdCH6xna3s+psW8fnJl5paPZvBk4V?=
 =?us-ascii?Q?epFCmY1DNvVPcjwiN7f2UNP759+YyFWYe0k4XERS+3fDduixQ2YkGmYXo/Yo?=
 =?us-ascii?Q?YqLBncV9OQhFYRdBYmFGayqEO+WpMlaxNf08o2y6L1IJCNdF6PgEozKVKogd?=
 =?us-ascii?Q?bLfLUGA9THB9aZ+kCcVaT+Poi7f5Kfgha5hhGHyr1l3+wbS6oMv+jMLu84/n?=
 =?us-ascii?Q?PoziNDnhq7ChzhsWTZqaX4id9HJ4Dx0q4drCUqV8gwUQ3Heux4Sz+n9YpFR3?=
 =?us-ascii?Q?lIt3sdRZ6gCU7nIZSxc99o7OZhiHYR3QVqfAfp5GRVUuWxf3MHgWR6+CPQaZ?=
 =?us-ascii?Q?op1viBpDYcaWdGmhKBLNvddQQiIKU/iR2oJofxiL6CjjDbWyTCs0/f9n55cV?=
 =?us-ascii?Q?6XSHy6jy+zoyEQqEsirEJsorOa68JWB9BifXWK2Flvzdwujur/w58+JW4ZgJ?=
 =?us-ascii?Q?YedQm2maWK/29Aklvt3S/JIimBIfR3NXIqd86pDYIsXVL8r8N3Qb+W2TTsNU?=
 =?us-ascii?Q?HT+Abxah935/7xRgdCMoOXQI7jRxkuZT1w7ix8nxpFPaXqvI4va2Dhwsw2X8?=
 =?us-ascii?Q?WDVSioPLJNtLMnzdraTRVwknQvUMe3k4DFDwvL0t5pCODrswxpbJNVWVDi+Q?=
 =?us-ascii?Q?Y+zme1co+/DB1WqwFTsJ1JRZtsOD1lE4QeaBp0OSzn3SIUnVGy5nJsSEMAX9?=
 =?us-ascii?Q?QrtEuwILry6JSYnGnMTyvGhVqS/8ArOcEqG3DqMSeIVx5YdkkLyGFM5jljaM?=
 =?us-ascii?Q?trU3nRWLBluX2/bmZfrPw3XsBKvtHpZ8IWs46Uct1wZCWjbL7ZZBP8u/BQu/?=
 =?us-ascii?Q?fcpzP04JQRLcLBIl674t4c9E19QdeGN+3YeECRhAZgezMgUi02ncRArsnl5R?=
 =?us-ascii?Q?Eyfip73G+JOcG4kheu0OyF04i19E7aSoVsfD03Poqt1xWIYwohaUN62+il53?=
 =?us-ascii?Q?ZkdRVJx2CyocqZG2n5YeMt/3wUgmK05mzYGrQ+sx/6jDkD/er3ms+jOc7oxl?=
 =?us-ascii?Q?ZyTXnIuTgtzBreiguheOHGezOKApEHG0mMX6tqXljgPd0gPDkajHA2G/vmDF?=
 =?us-ascii?Q?0/FrmYGLpn9QdtcCYcqoRYaSMWHqNl90kgMYbE+pTEyHeKNkVwLYPgQ1N8Wa?=
 =?us-ascii?Q?br2QYOAL86zsPkE4I2Ukoq/BFMhY16XjyOkB2UGzKGUxVaBj7bQWz44XhDBU?=
 =?us-ascii?Q?FTqwudqHLaTAj80afNCcNIY3BBp917Mrg1xckO9MslrLife1fJef3z2LGh4j?=
 =?us-ascii?Q?1p884aH/0Pxde0c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:53:26.8567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a573b351-2430-4c6c-b1da-08dd549ff0a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/fib_rules.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/fib_rules.h b/include/uapi/linux/fib_rules.h
index 00e9890ca3c0..2df6e4035d50 100644
--- a/include/uapi/linux/fib_rules.h
+++ b/include/uapi/linux/fib_rules.h
@@ -70,6 +70,9 @@ enum {
 	FRA_DSCP,	/* dscp */
 	FRA_FLOWLABEL,	/* flowlabel */
 	FRA_FLOWLABEL_MASK,	/* flowlabel mask */
+	FRA_SPORT_MASK,	/* sport mask */
+	FRA_DPORT_MASK,	/* dport mask */
+	FRA_DSCP_MASK,	/* dscp mask */
 	__FRA_MAX
 };
 
-- 
2.48.1


