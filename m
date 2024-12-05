Return-Path: <netdev+bounces-149442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 947DF9E5A12
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A75328579E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048BA22256D;
	Thu,  5 Dec 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mKS14bcP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAD721C9FD
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413459; cv=fail; b=Ugz6RLyureHXjtaMrssLfKh+i7X/y9lgqS743YHUCUq6zASm9FGskm/5EpOcrsC9rs7cxOakmuG0okLQtuWKpV+loWysMRXETVD6q9Ti++SXDKqxjchFR58Cj64fmTRNSeE04/lW0zWkgjDnJuXbB7yxtuotLVTnrnYdiFieOdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413459; c=relaxed/simple;
	bh=KEyyWmR+1MTMjYgeQVD0qDDfb0uiTkQ6HLxpywT0aDQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0m6WeSGPgczpIsvbvb6v/i3R9+IBTAmuWZyWCHTlj7ypjNunm6JXzRVDTMpruSBaBKGZlO7Pn0Arm3CsaRWzixXohhDuMsr842vy3tEHiOrX+yNNqtfgREkqBZKS7t94lQ1qkCjO8a2oHDqvAA4rkLmoeCa6x+OIoPS3LS+mCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mKS14bcP; arc=fail smtp.client-ip=40.107.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sInuwL17wSz5tW+8zUyEwkYh9L3wZWJ70wJZ0pVOkl/zB0AiuoI0qaYgzSeW9LoFVOY0IcVHIlVg7Clb+PEOq88WBNuMqEwRoj5ywm5VC6AFT2kky81+u9KuWvjow9gVte8nI8/NfH4Xqt187xfnNGGmi6KzuXGlP2mRoOWY+tAoWNsbQUKvaGMo5qytMG9svwGTzAo5eX7M2oWj54Q682Pqg34MWNFSMLCjsQ5rJEQSM8DXBEM9+9bgqijmKdQjypYdki1Vd4qraTKmNudD2IzjxBa3Y2cBqGNVgXoWoI/K2JKw001QpHNZDPnWdPcDo0TrmDtAUXL0Xu7cpRN1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3zCt9csEe3DSeoIpLsQVQK746Hs85nFnxWJlwlD7m0=;
 b=cJzahSH9VtyIrVAdOA5Ggx64pHwR8D0p0Y4VApUsacTpRGM+3j+8qj+djmxOHmo0goTkwe2Nk5uwEyBcKAyazryMFnci2mXlqNLeioZ/NRGUpz1QtBfJ6KCGYFtHW975DA9z6qjl8e2o/OB2iw7AtnJ0vcabUf+YAKKBmklRCYvXR0b2/orPw6+J5wehPG4Ow+1VjSLlngJ6mCEUOAibc6xhKSY9Yt6reoETLick4TjZBE9f8JYh1dLtBzGL9Kf/llgEGUVQB1HASAR2Cmc+JyVbLMKnNgRr2bqrhhT38dVI9O+lQ1YLy19Pjq9SKzgW6iOtDLTS74haE3a91vczZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3zCt9csEe3DSeoIpLsQVQK746Hs85nFnxWJlwlD7m0=;
 b=mKS14bcPNHdk2MWeXHbpwCoJ36R/0nmnwKFzgcRfWfaKQsYVcrIrKN0RghvBk2UClAA4tcgPq6hnWQp5j2F23l71pJPegHOWqKIpOCDXggMUSH9xhiBOoeQj3ohEq90ObXAX74weJNoKfKJz9XGlBEzk3CwIo+erLy9ny2i+byA6FV9lHjPDKn7SkFILKkkhgoh8AJc2p2aDyF8uXcR0LM7rWDH62o/60x++tl6Va6ZdJD0snJ8nnf/OH9bcYHA8Gw+lpcOBgetMR+BzsJC4+I8jnvjZzXdi9LhO30qgtdiRx3N8hZsb1qdNwDkELi5Cw0uvMKuOnr+o4AKtSLEElQ==
Received: from DS7PR05CA0054.namprd05.prod.outlook.com (2603:10b6:8:2f::28) by
 PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Thu, 5 Dec
 2024 15:44:12 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::9d) by DS7PR05CA0054.outlook.office365.com
 (2603:10b6:8:2f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Thu, 5
 Dec 2024 15:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 15:44:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:44:00 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:43:53 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 06/11] vxlan: Bump error counters for header mismatches
Date: Thu, 5 Dec 2024 16:40:55 +0100
Message-ID: <d096084167d56706d620afe5136cf37a2d34d1b9.1733412063.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733412063.git.petrm@nvidia.com>
References: <cover.1733412063.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a784ac8-7330-4dc8-55ec-08dd1543aa1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oz8M9Lb4Lli+gIWTwP1oFZ/AJhASNy7mU0D3rSWZi9M/j5x8W/kOP9gNVAGJ?=
 =?us-ascii?Q?RELMXXdeTGtg0YpA3qQp+CnF4TBjjtiWlTc5FwbHn2/+9ySZ+xkptl85fIcI?=
 =?us-ascii?Q?ayWPHBjODmW2YfFb57wl0BI5KKahLXXbubZGoSZQQwtU7EBwz/CKIZSYOvz4?=
 =?us-ascii?Q?kHK4+TmwvBccCuRaisPWHmxMaH89eYWJnCZDHeF7LFEtjpYdCKq+NUV+Az25?=
 =?us-ascii?Q?pJeu2UNX7SxZtgXpa7z21NHoPT18BjcT/mNtKKcsxE6+SlGS0j2VUjKkIOx6?=
 =?us-ascii?Q?fof6J/4GwM3modNDxIp4bY0qvygNhtwxHDnyYJrEftmg5vmXD0d5JwqQKgL/?=
 =?us-ascii?Q?kRUGiJenOCrf30fVrPOwqRq5TZs7xHgF36aENeMNg5ruQsuwAnlU0KNgrJXC?=
 =?us-ascii?Q?tZP6swcyeu3B1ynPu90kuZUOiA8vnXeZs2sybc/wWG3H6k/al9HaHExVfiNX?=
 =?us-ascii?Q?QTdR/x/4HH5nBEO0ahd/tlO+sRAWJyhRos698zC2n0IjXSTaMarhS6sQHFJT?=
 =?us-ascii?Q?fesouQDxYvMH4IEpaNmJSxp7bBNIrzj6kPKXPqwMBqnCNzFuvipnZADLI9U+?=
 =?us-ascii?Q?P03k0+3EQoPWSjlhhBLDJG/8YTfVE/A5WDCh97t9IMnN7xUbqPhMyGB7ekcf?=
 =?us-ascii?Q?QcLf7FkpvR1OFnkC80VQBvPOuQOlhaOJCS3K1+Mf0Ni5tSUgQRNkZ1YOUGKS?=
 =?us-ascii?Q?RqVnQDOPT1nOwscNUndzYMq6CEk4oRe4c1Q/lv6QXHk4QfOxZX2y9SMWh6G7?=
 =?us-ascii?Q?bIt2nNAyMnSlInMd4LYq73kZSlco9Q7D7E9dBuS0DijrjCcAu9UW7zn2A3qH?=
 =?us-ascii?Q?mfEcrF6pevj1W1aTTFxnCNUKUS6+CwLUHPwXvBoziwGoyIVIq6bNZvhvqY0t?=
 =?us-ascii?Q?LMziO1t7LG8c8kWC8QIRqKxuuNwm8pT95rlGRRcudXFIFi6EbVnqsvPL/BaZ?=
 =?us-ascii?Q?EKnvfwOMI+JSxzNcpr1M1lZSg48KL/RpA2a+CSYcVaWo1ic8EvdxNvzoairZ?=
 =?us-ascii?Q?lEnBKk+Wr+/8nOcgxR8KkpuyqirW5AkwCLezzCvtiP0aorb7sX37FUZ2sb4t?=
 =?us-ascii?Q?L6rnGGndLRcb5SahYgv8P6p78LQtSQfzKUa8h+oNBu0B9ceY2eR4Fcy/rR30?=
 =?us-ascii?Q?5FE5jS3n3xVKTKAnJaOZS9r/Xosp6ltUl7+g5DPMimJ7RvSAahcoehbwlTze?=
 =?us-ascii?Q?lqup1QuGsCIgITVrk8XJCshTGgwvMPXLZnR+ws3QCwdEteJ3j3MleJ0cjYhs?=
 =?us-ascii?Q?b71L/uqJW4GR1qHudF3lTcliMNeU8Wqn8v+eC2ijiV/FxJpo92arFJaRtu6j?=
 =?us-ascii?Q?BL1gNGjWIh1XEEEFowZktgex8J6ABMAKxKREY4y6ccKq6N9RsEa03JaKCLko?=
 =?us-ascii?Q?2fFVOx3X0OfGI7+fji+q8YLnKgI1Wlp/ZzI/fHNHv6LhtQszO7LM3CDuMLp3?=
 =?us-ascii?Q?ilzf1/jwzOWhPGOlnlFiyZeROMZJ/lyR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 15:44:11.5760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a784ac8-7330-4dc8-55ec-08dd1543aa1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188

The VXLAN driver so far has not increased the error counters for packets
that set reserved bits. It does so for other packet errors, so do it for
this case as well.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index f6118de81b8a..b8afdcbdf235 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1721,6 +1721,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		 * little more security in adding extensions to VXLAN.
 		 */
 		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
+		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
+		DEV_STATS_INC(vxlan->dev, rx_errors);
+		vxlan_vnifilter_count(vxlan, vni, vninode,
+				      VXLAN_VNI_STATS_RX_ERRORS, 0);
 		goto drop;
 	}
 
-- 
2.47.0


