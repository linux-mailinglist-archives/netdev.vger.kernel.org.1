Return-Path: <netdev+bounces-259148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCdROnzZlGk6IQIAu9opvQ
	(envelope-from <netdev+bounces-259148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:11:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC0D150974
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ECE0302BB9E
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6AB379974;
	Tue, 17 Feb 2026 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NyGClZaW"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2D37A481
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362663; cv=fail; b=uXsaQrFYhuehMM1dahn/RPUS/gMaffrdvmwkhI+DlGK/nJWVRoQxS4B+c6oixDFQ7P0Sz2iz3MVghv3B0zSRZpGn0XpAVne8Y/mWaGkhFgJhYespsxRqYBpsOaCoUHZZJdSo6NXTA8n8nR0TOmwixaZQYLYr08e5TpsxDOOIg0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362663; c=relaxed/simple;
	bh=h7Kmnpz0FpDUMfcIzRhokAAZhSin5Y5x8vMu/qV3z0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubx2bUN+eVSlHl+ATU1l4a84IqR8l7enMyeQVR1kmpS0B4pvdbHeyovCAxoUcoHcu7uj+W7KfziQhkd2HCDN4G+XC266IcWAWFor2NNIukHEDpyNmiGKgxeV46iYlitfvr7hwKzL5HmgqwtinhPcEcnwn4w/a2qChPOewbxo4x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NyGClZaW; arc=fail smtp.client-ip=52.101.193.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RU8cdoyLqi7agFVUlZ68zacs+27B/l6Og5lKsxBeKKPV0imhjLKbG9nFOOyhBCSSCBXH1FDea8Myf0jn7qHSOhJGT0+JOwFqEPr5ThIVcKZeqpgCW+zP+ycNbby+pOZcsvxjT8s4ej3AK/7u9Mgo0I64gjXr53SMUFO604Cg7N5HHMgPcqMoVRuOz683MpldPCPJI/83Ny7DtmEvyCbenit9BBXs/d266uB7UdWa854MmY0z57iIcIuyrPZ+yf0ayoFLrRHUPtm3/vOrMwQy5RJ88efrCLNj2CGEOp7KSZooysw5jukYxvkXiJrYM2fNIJn3k8hO6Rl5drws3doCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NxkS05RCBGnth678DAu8aItjmA7tPT55AXxXsJl+Ps=;
 b=KWULLxOy/DRP56v3ipWpqAzEL48goULa/CkSkdaZ/zxr+ay23V4HlR+FtVPBbFK3v7do0jaOvp0ArwijjV5+FCMeM+cKCEFaguselWQmN2FPyxqc3MQBEhliSxxmuUQQoo5s/MVMTQIF1ZYZoVZM8C6Sf6qi7wTBEwTlsqmODWiIkkJBTu9hK/mecqv/SBxT/rTF6hor9NK/FYmnRMADRs8AAjYgsoYiuj09UYUbEbvQyTvOFHsQzIlNTZ2+ASZOKfql7U33QEk4IQLGebsAs6tcna91/xYlQWyCJJ/Abz4pMhz6JHZ0bobrojVYvcn+vV7OuIzlnqgMGP9xvgLHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NxkS05RCBGnth678DAu8aItjmA7tPT55AXxXsJl+Ps=;
 b=NyGClZaWYI6SK9FtYovIeir6CE/abmNaG0RX1pRvDyk9RClpVv5OYWoZr9YiyKJSHekZfe1sxYiX3T6ei2fBEDWBSlxu4vQ7bUtD5qMeEuuiKcWpKYhoF5nHw0sCR9/Heg5ChcYtGa2F68dVW8ZGhXBVdiZqATEuEapYdtWvgWA=
Received: from PH7P221CA0083.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::8)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 21:10:58 +0000
Received: from MW1PEPF0001615A.namprd21.prod.outlook.com
 (2603:10b6:510:328:cafe::7) by PH7P221CA0083.outlook.office365.com
 (2603:10b6:510:328::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 21:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615A.mail.protection.outlook.com (10.167.249.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 17 Feb 2026 21:10:57 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Feb
 2026 15:10:55 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: [PATCH net v4 1/2] xsk: Fix fragment node deletion to prevent buffer leak
Date: Tue, 17 Feb 2026 21:08:50 +0000
Message-ID: <20260217211019.48280-2-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615A:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff423af-ebd0-47fa-2c68-08de6e690bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FTZkNnWmtLGtID642/2wGqul8XcRVMRMqNHfdEW9fW5dvqb39lUYLYJ20C3V?=
 =?us-ascii?Q?/X7wEOizPKwS7Dv7zvf6D/0tmesCI1c96q3Vg3DJ0F3rCBgyB8qSyhsnbrGU?=
 =?us-ascii?Q?QKLop7KDd6cYhUB1SVwtMRmvYuMS+BB4ZXMwzFAbpLjlsCkc0CZhjHg4epFd?=
 =?us-ascii?Q?4/seXV1mh0x0NAGLYnR31USFojcU//pGgbJDulxPZkIm5G2jm6sijztzOLEH?=
 =?us-ascii?Q?wY3EsqC2cwfZmwbLpkJFQn1yri3yaB9beUtBdt5ey0PkKlyOfipjwJbx16yB?=
 =?us-ascii?Q?dCTBgb0/Zw0UC3bgSpxNVVIGagTpClQVXSDf8v5sYXraCRB/8nsRC/EjpA2S?=
 =?us-ascii?Q?s+aKxqnVGV7eyFBflN0VHd75et8NW7cnJBJY7ES9UL+FhU5WL5Ob+1Y1TVDB?=
 =?us-ascii?Q?dj36zH7/8lKPJkGe5hxHpiIPcT/twPRA7/Rg1lW++amh3lVgfbl7AAHhDLQG?=
 =?us-ascii?Q?voXQ24DeWWRUvc4p9qGSqp10VJwAqCAASoMf2Tu3G08eK2wRdVOgnWsUr7Rl?=
 =?us-ascii?Q?V/tZvGSw/6Brxa2P8Jcf5z5piPHDO9npeUKp5YqcMcVahkE1ZCknKe0xMyZ3?=
 =?us-ascii?Q?Pj+bdnr4FTOfLAG/4VtwdkNM23KTtyqZMLUnAT5EXxeKzLOfR3wf0bP98wPv?=
 =?us-ascii?Q?l0ggYjBnOr+ISCl2wDLmNHHgYSWlEWYmIRLjIN4n/x7TR6TFPnwWItKc1Hkj?=
 =?us-ascii?Q?m4jihkRSLiSm7JOmj3J/7wy6FAp1UWBDacie7FHTZi+hUKSp5WRTVJXbLUTX?=
 =?us-ascii?Q?g6KEqreYlMrbHsCgpQejq0aZSnMK3kFyhUrckIf7lXBNnWfhiCO4zGJC2ewx?=
 =?us-ascii?Q?xO3V1EZwzCOCg9UqpiAvfythVf0DnHIFsrOc0IdePL04J49zbHXxxARtxtFd?=
 =?us-ascii?Q?Taj/JlyPSqECwgcSBUnj/mBd3+omHCRdDdZSAljL9shJaEbwzJ+VPOd/2dqB?=
 =?us-ascii?Q?m1KWfk+CQwITr56R/EpbBuvjymDQd3At2LLK3QdOUZ5Js7O5xcMQOUex1jQo?=
 =?us-ascii?Q?hth/krWZmUWu3ls8XCc+s2AlJtNf5VfoBP2GwRCAaVO38nHbysJr60Rx2Wey?=
 =?us-ascii?Q?YkgeKKwJ3NnJWwAjZSI7Vule1zq+XlHk8hllvgdgl3ihgZ11J5e4+ZpUEVox?=
 =?us-ascii?Q?OxfmBPcKOgZo5FYjON2dsAuc1rhjPP3CX0NjUcUyFCQzGMD1y4+un2hR8vwS?=
 =?us-ascii?Q?bgLSYSk9SE8MLAu4sN9jpoUJgzWvbwQPfYu8gzaOvIYS8Eo3xK6k3cm5wsm4?=
 =?us-ascii?Q?7a6F2p5IdyV6v2N3b3Gehs1s89d6aHB+ujtehbiBeqmN1rZo2B4R7AaXqSs1?=
 =?us-ascii?Q?TjsBkIWADWSIp6tXhQskQIKWNqF0KT5keuzJT6SOocxZyowbxH3gF0/ggjAa?=
 =?us-ascii?Q?ItukDfCTlQHoVPE7XQVU7t9vKVofesZ79IlOJQ5F3/Ro/G6g2EbLYkLZYw0/?=
 =?us-ascii?Q?aW/RvkpyLsjLSees9CXfhJSwdvzSlAufl1zKYtUzIC+wasH690IuAf/VvHr3?=
 =?us-ascii?Q?NajBkZaF/+Mp1pSQ7JKOsMH/ENFFrE152xgtm05wYUkA3uT9Y5KoM8u37613?=
 =?us-ascii?Q?NV4/tmKqUD98+E8J84NlYSgZrig2BGyFNJQ0l4ejy+6Vv3ZfYcPtzw7RpaT7?=
 =?us-ascii?Q?/kO3ZRDYOnXTKMlYkPanavUTquy0eyTgbGu4zYVV0gI7YtH8aqHO7WDc1Abf?=
 =?us-ascii?Q?g3AkoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9mhQstvOV7HinlLmiloK6U1T702o8pu4NhdTBQ+wheAGB/OUG8jxZzA6bOwm0oIGHOD0ol0Zvrv/jco60fskJoSJs5S8ZwaWNQ3CMvAZr8c9jwqGRy5Z5dywhib75SDphMOdlF9+7Rff2lamCHAtv0Ai+6QtHkHws4Ql7BP1Nr0hUkkKVTElPJLjP2mwT8jImf42KQtuK0rRpC9xONgbr2mdsmI8sqiHQBM8iWXC8uLQjOGGttphB4/8iWXZ//8a6n3xfy5SkN8q2B/Vsw8RXnU1CYv0vavGkFUUPuUSFcBxjLKO74X/Qyv6FVQyv10kfYURd4KV3JF1MWxoiTHV2fyp/eenN3eDxgxxLqaCT2yeNDZj3xDKIidr0YAlm6C/gGbfRX4+K870t6NRNqDOJh6zvDF0EkaT+NiPcRbpd1KBM4uxXD/u1vP3D5CpZa3G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 21:10:57.9426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff423af-ebd0-47fa-2c68-08de6e690bbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875
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
	TAGGED_FROM(0.00)[bounces-259148-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 8BC0D150974
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


