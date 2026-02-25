Return-Path: <netdev+bounces-260684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOVOGQ89nmkrUQQAu9opvQ
	(envelope-from <netdev+bounces-260684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:06:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA02818E499
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C46D3058B82
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109691D6AA;
	Wed, 25 Feb 2026 00:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jNgC7tTT"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F503EBF24
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977953; cv=fail; b=mHlJLvUciCYhUWxKCfEsLjJbcgOuXf484wSykEn9JqsB++MkGYnwlUbhlNyxuKA2qKRkc1798vQikGlJ8zmzKBn/uKm8IwSiMil5YxY+5xs45dS4XlvN4W0hdnYF9S41Oro7MGCbRZdgMzFmUgZHRMQ6EuTb8JZkwc+hcpZGFiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977953; c=relaxed/simple;
	bh=h7Kmnpz0FpDUMfcIzRhokAAZhSin5Y5x8vMu/qV3z0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhY7XSxEdImX4msKihInIUsTlNJGoAYOc8N7zrpu+53jgno7vPPF5olQ5TsotPkP0210xWn0JhwNvz8ROPUu9nlt76jJGXodNi9sVm1S4jzzO3MnIgVvQaV9U6v919k/mHArDrUZq2uV638GgVlRUdG0opbkIlse9+ErJEmN4OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jNgC7tTT; arc=fail smtp.client-ip=40.107.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2PyAOMzMB/ljk7cPUh04BxcGcSwcQH56JSjrMkoZdIOVKsVt+FXH1ijSKENMnfu1aOLoLO9mv/4vbb8XY7sIy7AOs1LAoVV8Uh+9uBu3ul/wR0BQDWrqW6jQP4II+12sZOY4QClZy3GweXQZbfpebHgxX8kqKt48n5DG24DxUykw2xk/EajCPKY59IyBlxg+FSrScEuQ3psFO2fDC+Ud13TQutoqh61trmD/ev/IArFQsSJD8rr27S1opRWTFcGGWfARL64u60Z3A/0g2IzBs97GPfI6llysvPu+S3ud+l+vTIsIPKk9amzISv1MhSNr7/dTAniYmYk0xbLidJg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NxkS05RCBGnth678DAu8aItjmA7tPT55AXxXsJl+Ps=;
 b=SZfAfmnRCN4CCqRg8a/47TbfZOM56Q8cQHDpQGMMKfJfUD4W5dCKNWvTnwocBhwUjjWJDfH3+uKhzv3uJV0WQWGa1IoUo1+1DuBpXnPlAvhBSIVy7QcqCz8caB+d69JkBKrQpTQpfJI+uBt+pydJsRRpnRlBm0f/gX7EgHria9PqVPf9IyYiZP/OM2I8FtuinuOUQIaVbPtMq0WNjZGyUHgclzv4Yw92TlAcb4a2lE7jW+g+LLPfUmJhDbYOKkVTlip08P6CYkef5S9mp1AX0EWynMGeQ2+Y1vrO0mOJizgXHFIzTR36aL00FuF/aqsUmPmc+rZPga2cDz5QfI+E5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NxkS05RCBGnth678DAu8aItjmA7tPT55AXxXsJl+Ps=;
 b=jNgC7tTTNedDwYsIb9I/3Lj9XaORd2BAKG14pHBCfrnGgqV5qyxsOaiaH6eRcMPCBSPC8GmVIMZfmalk7vANf92R85PjYJJGHkzA9mhWEF79ShI6zhNVcFevZuldMPFnd8ZCQ9/KnmOx8Flb/Jt5LZb86QJ7qVfVxNSivTuz+H4=
Received: from SA1PR03CA0023.namprd03.prod.outlook.com (2603:10b6:806:2d3::28)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 00:05:46 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::7c) by SA1PR03CA0023.outlook.office365.com
 (2603:10b6:806:2d3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 00:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 00:05:45 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 18:05:42 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: [PATCH net v5 1/2] xsk: Fix fragment node deletion to prevent buffer leak
Date: Wed, 25 Feb 2026 00:00:26 +0000
Message-ID: <20260225000456.107806-2-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225000456.107806-1-nikhil.rao@amd.com>
References: <20260225000456.107806-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8e0f38-52be-4bd8-abb8-08de74019fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mJhI1TCf9trT52L7UR4xqZ+WlO10DLmdlu1/D47fQ36Yj86XayMhf4ieMbU8?=
 =?us-ascii?Q?x2AtG9NGiIiUO+aOCpkeHFvqx1s0q4DXsgzU01k0HDYvLL7+PFjR5/Fztnij?=
 =?us-ascii?Q?cQwxUg+KyZxI9jqJUMl50uDVz1gVYrL8yWI75BW/r6oZjWfr0dBA3LM6iFJ5?=
 =?us-ascii?Q?rl23gnH1aO1c5KMYFv+WEz1Mq/4ywf1IpvnlLYacr5ag6wA6FSzxEnTHIMPJ?=
 =?us-ascii?Q?Qz9Z+KBzi/JDGnSeLxQGHuRangz6S+hFBAh06f6fkKtMVZaWhTeDd4UQiXoN?=
 =?us-ascii?Q?T4oVnKEjFBTVUrWdtp0qdHJxsbLAeetMBRwTtK/Gp1MBZpLygRAQug6KZ9cY?=
 =?us-ascii?Q?rB2MCTfqRq/SrM8p5bMLbmBke/v54Wwf+KDdZKKFkvIrJaMEhQGd/qnoe7VA?=
 =?us-ascii?Q?i1ZEEKs03bQBY5mKaj7xzMaclzf/ItevWCBbmkkqNHoYY3B4XhmZcuKYl4wb?=
 =?us-ascii?Q?Dw/syBB4oGsw23k6Uv8JQiVyz08S9byg0kM99MmDK/6vLd7LQoEh76cIMww1?=
 =?us-ascii?Q?3XR5ZNcKcPlDV+0Bofd0aezTX6LLNM6w52uZl6OguSpQZoBb+doK3oYHHKMC?=
 =?us-ascii?Q?EfI1ikUQ4bsj1PwMotc1UIzKQkTJgZ00KnTYf7W76IqlVNvJe/MZbLqEi3rk?=
 =?us-ascii?Q?16dclWii+97q4bP1tmLgoEeCSKZDaedC1OUWVgwEAClAaT09NdxMxO4F6RzK?=
 =?us-ascii?Q?Fg8rL0Baihl7pjqPgyVYY2MdD8QCNizlvPd6g92FDDV1z1LVfNSm8Abg87Z4?=
 =?us-ascii?Q?nppP3RK/LN/W0ss9ye67yuSvmUICQjOvMjPL1JPGp/N1NQ9zoOysdPsbLg+D?=
 =?us-ascii?Q?ShopMx35XjDHBmUbnWRq1M+ITxyNoQ4Sw0d8jMo1eheopwKNh9GQwSAzgvTO?=
 =?us-ascii?Q?3yzXdmGmff7AuqCVVjJ/A5ZBxOnjlTJN1970K7pmS0hL0fX3/Bv7ArTOin7g?=
 =?us-ascii?Q?UtfEtUr3gfuZvNXfez18/33DMDDJIhaYRuLjylwplkHvRGTerkmuYQAlk9pV?=
 =?us-ascii?Q?f4EPVVF//T6LBFw3rAei0/YQWeeC+Pi2rXn2lYaF+KUuR94oZsqgXKiIXTwD?=
 =?us-ascii?Q?+V+v7QyTiEDk0xJrmN3zJd6lelgI/xeaiooK1pl+jb0kSTLI/FFPLdZI66+2?=
 =?us-ascii?Q?gQmeuo9ke/kSEpRVlJo7zJNz3VDegYAWwEkYSekcHZFXdF0ViXhFSrMYVhWx?=
 =?us-ascii?Q?/1W5JQYQ8MiyYi/mQ0EUTrV+EgmA2ZnTqW51mGD0mkfUKyHFjtrIVxAXd1Ri?=
 =?us-ascii?Q?pUg/ZPFdrICP5Jx5ecRDISEibWz3hkHq+Md2uE4F7+aUYcukQIP5s9AawdLw?=
 =?us-ascii?Q?iqdGjxyiiJkrW6/OUff4l03DNVpOocC6qyBR8wUsu0sJ9ITmErWoDAxD+NBb?=
 =?us-ascii?Q?NjmjVrwR7DDCCrumVO1AO9XoPAfALx37JTfhW8/P5C3bx8D7GSIj82bHpyQg?=
 =?us-ascii?Q?YFvqJYyCrdF8tAGzg1i+0P9UJboE7FjnQChFg6ZHwuO8etMoYxoHHYceVBL0?=
 =?us-ascii?Q?lIWWkkW5GaWqqNe5lbM5KRbYpiDNSHv7HY9kcVnA7aeKkt9www8ToOLK/asY?=
 =?us-ascii?Q?2Fq//ep2HJgPU6xC84Gs1yk6ExwnkC/RV/wifJ9PFY8SXP0NpXN+1oEckQFO?=
 =?us-ascii?Q?/TkZ2PZ3DLGWfZCRTiPg6LlE4HDRqndjlnSCddh6XeQEvq/XsVrYKwjfA6pK?=
 =?us-ascii?Q?eICLgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZJH7SdzuvkUq34IEUPGf+ZNCIaKraixcQrVOc/dTDlgIOTC8zpJuRxpDtSnIODHp9shVNZ2g9n6i+6tfGWXvb0HTlv0+GEfx5UZr9VgxTTAiPrGOkf6KhmPf3T6P8a9r1c/rZq3P8A4ZICDo4E9252xSIn7iq9jlla4wZgtbSwpuRl7zZGLtzngrP2yd0XBHmbP+ScjnGn9Q0eihFjgGNBt3yMKHx0rp4c0yuPthfEzOY3hGPZtKIyCueTk4TGRg/IavkgO2IN87JSSptn2BePmuD0NKtzATzqI5dbrwe3sAKzeGDLcYPtRGshU1JxhxM/H997sn2U7pjNMXpKaQXcOk9jjawysLJo+7GgBbvR7e5hpsWJ4g1R5swgfHHy9rPbrF8b+WUMa7KQaw7u2VJOcKGnDRuCD7nQKkZCVwHfoHyIuijEzm448YKuZ1dMdE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:05:45.8816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8e0f38-52be-4bd8-abb8-08de74019fe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260684-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DA02818E499
X-Rspamd-Action: no action

After commit b692bf9a7543 ("xsk: Get rid of xdp_buff_xsk::xskb_list_node"),
the list_node field is reused for both the xskb pool list and the buffer
free list, this causes a buffer leak as described below.

xp_free() checks if a buffer is already on the free list using
list_empty(&xskb->list_node). When list_del() is used to remove a node
from the xskb pool list, it doesn't reinitialize the node pointers.
This means list_empty() will return false even after the node has been
removed, causing xp_free() to incorrectly skip adding the buffer to the
free list.

Fix this by using list_del_init() instead of list_del() in all fragment
handling paths, this ensures the list node is reinitialized after removal,
allowing the list_empty() to work correctly.

Fixes: b692bf9a7543 ("xsk: Get rid of xdp_buff_xsk::xskb_list_node")
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 include/net/xdp_sock_drv.h | 6 +++---
 net/xdp/xsk.c              | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 242e34f771cc..aefc368449d5 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -122,7 +122,7 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
 		goto out;
 
 	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
-		list_del(&pos->list_node);
+		list_del_init(&pos->list_node);
 		xp_free(pos);
 	}
 
@@ -157,7 +157,7 @@ static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
 	frag = list_first_entry_or_null(&xskb->pool->xskb_list,
 					struct xdp_buff_xsk, list_node);
 	if (frag) {
-		list_del(&frag->list_node);
+		list_del_init(&frag->list_node);
 		ret = &frag->xdp;
 	}
 
@@ -168,7 +168,7 @@ static inline void xsk_buff_del_frag(struct xdp_buff *xdp)
 {
 	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
 
-	list_del(&xskb->list_node);
+	list_del_init(&xskb->list_node);
 }
 
 static inline struct xdp_buff *xsk_buff_get_head(struct xdp_buff *first)
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..f2ec4f78bbb6 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -186,7 +186,7 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		err = __xsk_rcv_zc(xs, pos, len, contd);
 		if (err)
 			goto err;
-		list_del(&pos->list_node);
+		list_del_init(&pos->list_node);
 	}
 
 	return 0;
-- 
2.43.0


