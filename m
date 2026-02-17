Return-Path: <netdev+bounces-258967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MNPLETDk2lV8QEAu9opvQ
	(envelope-from <netdev+bounces-258967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 02:24:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A08A14865E
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 02:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 509DB300A33C
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 01:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089AF2356C6;
	Tue, 17 Feb 2026 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qKFsDY9d"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013026.outbound.protection.outlook.com [40.93.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65620E023
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771291453; cv=fail; b=ZFwUfLHSfeGUPSp/5M1/UkzC/U+XGIGPu01MByUoaQ2XQQCwFmr3Ym+kUbM3lu1rIP941uo7CIGx0e0+PPKGDyWEOkMpYfqYOBVuFe1jcFUsZRlmbEIse5hwpLcgFa1ElqYXGBz5zOnHZmbpCx97UQNw1zAwZp/VLULfkwsQ6H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771291453; c=relaxed/simple;
	bh=h7Kmnpz0FpDUMfcIzRhokAAZhSin5Y5x8vMu/qV3z0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bR34RTC1wdvljsKAtkP4REKdJ7lIir760zzGPFm9WZcyqdSPWKQKZNziGE4nMMf54yRIWHhITKk8Dm65LX8NattBdMmXKzWUyoFJmv6nNlSCqjqdl2aS7UTZ7/kkvFFF7S2NDCx/iyMCZy6SFpfiAKw71f3ZptwkSMVlsuGIqtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qKFsDY9d; arc=fail smtp.client-ip=40.93.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eB6AyVEBMWxpUwfmdjYEVzGNPT9pbOlAVW3P/UCNnQM47hbeEkJyxoIuxYQbnkeFGtsc3i2P4lqC0eHDKGwvEefDYlymBTmMMBM3VhqxZrc23vtIRWLL54SOrFAWew7c4pfAb3Ck6vpNaioOfDAvYKo/mhmUvD6HkGtRWp/GMqJfiVeZcww/nqZKbo5yiAHd+0R7l1/FHoHNnAiXtfXoiVfK48BvJmY+6WA72kVcjMJa4LyxPHkQooXcaWgBMJTdirk2Ya/i7cbxaAJHj0WwsiTx7cx8XQvZiyfhyP3iTCgi/sGvFc97K7ql0dQuB5pasYerTASs13QcVHYBJ8bNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NxkS05RCBGnth678DAu8aItjmA7tPT55AXxXsJl+Ps=;
 b=UsUdoowKJz+jLJ26QUbaRRoqqPqmyrgdGN+hPuI8QbiwWJ6hScgyL6ylXGlxDw3wk+mU+9NJ0UoczKXwN8OUaJauNuP9kMom1dsCgKU3l+MTMDPGjiZFcY5cB+fevEUPkhZHw2+08H/vBwY9uxUj/4P8vktzUZQnXozcbSFJ1qFBaCWUILi7NWfxznVr097K2ROArub2s+H3eX5GIf8zUiskiPJKy/Vwxe4niFeCjQIgBUt3qULEo1nZjMWFw9Z55QNXKpQYYKu0h26eJXAIuTolS8C3rJH+bRZpUTQ7KwyEz+PeMyLdOOLQvgF6gySf/Fr7I43GejSVV91vZCnGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NxkS05RCBGnth678DAu8aItjmA7tPT55AXxXsJl+Ps=;
 b=qKFsDY9dAixJxLrosZ1E/4OQ8zjtDtC7W6yscFda4T7cpj1QHt2t8OzIw4G0WPFMzjEzz6AxHLVgnDTVOpY6r++47iiwN3vEnitZvUGd7dXEXKSTD+5JkskAXJVWARH/U1PeKp/oryEOKp1nbqFf8FMMUlNRnA1dVCIKhaipyg0=
Received: from PH7P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::22)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 01:24:08 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::fb) by PH7P221CA0005.outlook.office365.com
 (2603:10b6:510:32a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Tue,
 17 Feb 2026 01:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 01:24:07 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 19:24:06 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: [PATCH net v3 1/2] xsk: Fix fragment node deletion to prevent buffer leak
Date: Tue, 17 Feb 2026 01:22:13 +0000
Message-ID: <20260217012346.22468-2-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217012346.22468-1-nikhil.rao@amd.com>
References: <20260217012346.22468-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7fb83d-8297-4797-dbba-08de6dc33f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?18grcPjIcxbdn+XYpR4GRVCg6KjylIoIAINQGILn6+4LDzgntFc0q9oHSxtI?=
 =?us-ascii?Q?qrSJjq7wM0NHmLu8mPGcSyId/h8m4n0dWAynC6v2WK83aehiWKfkP91tkBnZ?=
 =?us-ascii?Q?ahFyNBN2INHw9D0u305BNoyJEY/MADHHnqJAo8IhqZRq7G81Z937R9O+hyeb?=
 =?us-ascii?Q?t0v9r/8bqKGTnSCfDd/na808sPjt4IxIB8E0eYQH0q4mUH3UcBbk5SGvs6bx?=
 =?us-ascii?Q?bVTjornPKtWe6SgSx3GLRVrHTj8g6y31XlouOfcNIbe0GBI2ZZ26oDF0Ryyt?=
 =?us-ascii?Q?U34q1QMC+woI7EPwg/z2qlGDWK/tuzVVem7c4U0sCdFfBbm/nRStHA9+3Bmk?=
 =?us-ascii?Q?J/7UAnnEA3l58PZXUb1E+Bdswa8gdElAVoXdwiwG9LQ60cXRBbnRU/+8CRuC?=
 =?us-ascii?Q?YKlErvX8/bDarnVjwslzMG4k3J3BtM9URqs488JJWDig/gw7NKpTrGTdctdP?=
 =?us-ascii?Q?F/PIhCz+4ffGTi3pOCccz50xAt5wmU0Yzifk3HU7GkYIQ/7DZd3KaOdmv0fN?=
 =?us-ascii?Q?aMk029MqmOEaLfs3342r4wxXe1XJKYbNDQAkiHE4P7khpraJb8aBpeAxNgpQ?=
 =?us-ascii?Q?Hm7ea6Mhoaao7tUPGD8JJuU/s0jKhbJvBQEt389FSrTHxxc1iJOu7DQSOdor?=
 =?us-ascii?Q?OFqsLwIxHPGG7fCjdo5LkP3SbjjM1gCivL3HBEzUZrW90gxDqTfqr0n8SIcz?=
 =?us-ascii?Q?1HENHXpNtGzR8q0cXC5VMIY8k/d2hVpEB9dMWG57YUqn17NHb25OYr6Cg8ND?=
 =?us-ascii?Q?siJNe/8ZnQtAIYb55ch49RKOhNAkFH3BTFGgWHWOeCKnLoUKbBVAwbJTBBtX?=
 =?us-ascii?Q?ZX6siqgdGJw3MlHmEFub1CaXShZj2QGJw9d9+BnkHPo3KwR2v4G5uNmmlC0h?=
 =?us-ascii?Q?kTf291FR+awltR0FXctfxFB2a7Uho4FseRGoYmzUU9GB3SMuVV9scC26Kt+b?=
 =?us-ascii?Q?iF/cHmI1iLL/MhnHfrAomy8V2WyFRqtLAACznmTIiXm+8vKRQPtz2KQW6yH1?=
 =?us-ascii?Q?Fa9++u9QrWl6FCg3sw5zY/zt1ui1S506vnMnsRPUR+4p4ktjuBwXNZpINHWw?=
 =?us-ascii?Q?4TRaoPaw/+DUYoviDNIu8oVri4d2lH+6MDCBs48lrLP7VI3hSP4SJmLCGQfn?=
 =?us-ascii?Q?uv72icGXEteS8VOtlYQOlijtPS8crR93AwbGbaEEhe+21oc2r+LMUVX9dUy7?=
 =?us-ascii?Q?WyB9LbNnqyZTGtyi7r5N0OBHxhxC5DeWU2t1whgII2h/rG3Im6Hz0H8Ji0Yj?=
 =?us-ascii?Q?3s8h/5zWTxhHL9x2e4zjUxYb9qtI4/bJ/lvZk0BKpWvbjL+Yp+6JH/Pthh8a?=
 =?us-ascii?Q?RsI0kVkN7/0uKGlQUwqj59Sm65P6+/TaP4FsNT2ljX7ZKw5rf++9OZ9BQOFk?=
 =?us-ascii?Q?0uFBJcOSRwzKVIfCzcXZlBR9Q5glcKWV0zuIRVNXOyDZBeZeb+bxU5ruXYIl?=
 =?us-ascii?Q?iK2XMBvg3OdAJ2hS06hLuMHfvucj0TjMsecIjSujelQaZqLegcwwi9juPeL0?=
 =?us-ascii?Q?9eJlEOc3baCxZzEnmBS5VNTMen28oxeJtlK3YfjTNziELl9pV0xTqPDt2zWV?=
 =?us-ascii?Q?UsuHTP1jojLAl0mP3NHULS8lnM++I4rxlSpdU9T+QvSshXlCMLdxKkjDBo6i?=
 =?us-ascii?Q?gXavoemw+PXtKI2//nQhE30+6O8RWhhLBqJ63Bd213pQDfGIocq8/EFIinBA?=
 =?us-ascii?Q?mGByyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KpwWTfdjTq0UJjXZRZyffAPR+1B5wOHXjoH4ONE8fIsOp3G/bRT8wnZa15dSWfgSlhEiLtBZfvpfOry4iI0c7t5jHfL7HY/KJD6LAvf12TRKIkUDNFG0p9ykb//lZwWn/7l1cmKTYa3e12HhDCupBgdDLav/SMEFIxpfFt87Af/3qz8fBWOLCERDvbQ0R0UqlzHKpzDoCDowhPIAtnH1NhjRaOFLLsqUaH0VWkVwgJVG2fdltuQLn6/xgpMEGpOVmWBXQ1KBP8hmTq4mnFaegszeDaR+hCNxz774Y9DzBIKtycABPCmE8qdLmw9BhPjfIs5kZ5iI+/YYREpkEJve5BlQAzjxjlzjqkBvra74GdwwqB1ZP2CNsHbNjePsTziv4qUX87fDfX1GwA9gFXVZ9Pn3cgzjLEetvjZdoh8d7PiiLu54tTm8RuJ940TWbKZJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 01:24:07.6690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7fb83d-8297-4797-dbba-08de6dc33f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:mid,amd.com:dkim,amd.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258967-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2A08A14865E
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


