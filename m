Return-Path: <netdev+bounces-256888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KHqL1Lig2kxvQMAu9opvQ
	(envelope-from <netdev+bounces-256888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 01:20:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F599ED697
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 01:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 733993019515
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 00:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B454219D07E;
	Thu,  5 Feb 2026 00:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fPsrt1fY"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012025.outbound.protection.outlook.com [40.93.195.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694021624C0
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 00:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770250803; cv=fail; b=WebxZOrU7ZGM+NDV3bENQMuoFygOZEgVTq7U323sgN0Oybsl/BD0jeZU6UukBbyrbulaKVx6Id4GbHNIF04+O8ALddoSwZNPMwJof3nbi9NotF2sCJYYbkQLstUYaxumtwDvckvpIxG5dOInvxanWSp1VemMvnhSESyMXS0a2P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770250803; c=relaxed/simple;
	bh=wFdFbjCl323W0P06n06lxE2hXfqCOv0oAjc/jEvxA5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fArSWYv+P31aBPeWS/LFYiRTPRuNlhP0Kak7vdamX1pxOW1MRcvSb47DroUQLih1Z78+xwbAoOOoBb0EDhOkO6POHVEqD6Mhx4W0ZjmQLIWFomQTBz1MYW73YMGKebodyevtQu0ziuzix1QwiWC0p+bxyyzEsMLTywbGL+pw5yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fPsrt1fY; arc=fail smtp.client-ip=40.93.195.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvDI44iJzksCBOyWFzk7icAk1Hh4tFiXyYULUs4SL+dZl393UtZtll8ZJYAGq1RpOsB4bD9+LyW6jBWGzKXEpshydKEJ6+20W1AFJ778aDwJAeRXHDgWXBJdaEc3AAS6TWBf1fzc6WZdROz6BoUyWmwWQBphF22hmhtiqgt48xD/3Qv8vFhq2mRqQV9awBEKx28gStrbbviVJlZC8T8x9jxZf1k5jjc9RzsUbs4Qbv4bRrP+2Wxor1A14J67XL6FLTZV8K74qOOdd/CiY/ZJUXHwcxgaDAoinpvCUILFHDKi/ziny1pJQewRgBRXu37Ru/bZ58dXjnZZJYk2C9XSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z96r7xmjqsGfeJakJT1R8qes+EMORiV+lg0mL7ea+e0=;
 b=m+pM5eWX9ENJW0xH6d9z2mSOy4UqnmJZKBvZLMKi4wqNqcccBIp4Yx70pbJCJaXx8MfFWguA44JLsCtq30asc3P+KvQoxVKWMFcyVQOEqZVVMT+Y6hnpsn+zUNXx122LDBKWQLzRFKXFZzi40+f6ghmATPjmrvOWat61kywfEdCQ/OEsT3XkeE6tFRtJpgs8g5e4TdOKzxp9BZldr53iZvE0i4ak+E5A/XbTTiN9MR+5/Y34H53njrK6//SD9Lk/7CSCFiPVoDTP5iyNgsXJE5M1KSVCnUOupBZj3rjAn9MWb4QFdhdvvGtbUnSzLtSxILC98JQfzwlSNxNp4D1cZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z96r7xmjqsGfeJakJT1R8qes+EMORiV+lg0mL7ea+e0=;
 b=fPsrt1fYUEnSBC6a8NAt9wgAOWmikb2ujvy0K5T+SCK4BZjy8RWt88RmgbeuwxF2l5388yimPpiH3LdjqXCKL39Vu1278/E/A6049neXEB+IJjJf4UW665lZ2mcI82gKJVjVOVwcAMJiLWnPSIwlEalPIrZz5nMHXK+tDUNSKbY=
Received: from SN7PR04CA0074.namprd04.prod.outlook.com (2603:10b6:806:121::19)
 by PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 00:19:55 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::92) by SN7PR04CA0074.outlook.office365.com
 (2603:10b6:806:121::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Thu,
 5 Feb 2026 00:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 00:19:55 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 18:19:54 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
Subject: [PATCH net 1/2] xsk: Fix fragment node deletion to prevent buffer leak
Date: Thu, 5 Feb 2026 00:18:14 +0000
Message-ID: <20260205001935.11562-2-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205001935.11562-1-nikhil.rao@amd.com>
References: <20260205001935.11562-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7b2e2b-3add-4f5c-e6f6-08de644c4a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yrwVysRLHA6vVmaG7CRa28mjNX8XEIobawPEYbqmF1nOaYA1wawOk2Ikv0dj?=
 =?us-ascii?Q?7axgUmsI1C7NzHfGV12zscWKGL5S85OLu/QpRsUTLKVgDLnDsYJ/33/Bp9iV?=
 =?us-ascii?Q?CziLgAmoXUELWTmTOBOBd8ihZaDbFEXm3vezuNRy3Z4O7jEN1bN0o3Y+OTa4?=
 =?us-ascii?Q?zV5AxA9kTWt3gI5v/U5CPM7/dz6kp9zSbUQEstkCGTMMysZ7Kmv5wvABAYiE?=
 =?us-ascii?Q?yVgrKdzBhQKIxC2vmfyGo326ewe2W3EiawH3QDCMgOuopUM+m9+uJ1r22hoP?=
 =?us-ascii?Q?lL5EA5xDem/K0WdZrtHZi0XcmgQy1jrBxKlnjlLhTH1EJ4Oiu/SMc332eFna?=
 =?us-ascii?Q?l4VR1dBO6YF+lwGnCA5SIZFJtIryCTQy6hYRjnX2md4uDAYM8DxKc0yKgO6I?=
 =?us-ascii?Q?36brPGNSfm/FICTWvmOkcez3s/XeLFm2pBG1KkVJyF8d3hfksSt83Ugf+YvK?=
 =?us-ascii?Q?Yzu+ht7YPb23uy2KuVlnOJnunOG8m2pfnPwUFBNN0YlkoZuMBI3KOviCS5t+?=
 =?us-ascii?Q?Jexogk4qMNc8X5m/j/R3tskiyrSOiEOnKC9+QDNFTCNvq11jEO9J8ZZgLqb7?=
 =?us-ascii?Q?PQIvQNNGS+p7mggzQBnB6RTuqgxd1gu5laRas22ahHDEKB5trFOVLTHpZDfr?=
 =?us-ascii?Q?2KAEf91geQPwT9cdlw5BpTCfg3RgSFKhp4CKZzjN+Ojen4hv3Kwr7DAMGIAc?=
 =?us-ascii?Q?FvfbEF0f3QxXib06IWx4TsbP1aG2UWo68nxpPxJdxKMFds1LDWoGY9xoH0rE?=
 =?us-ascii?Q?YB8uICDrBvZCRiopdNn0WSiGxhFGn0bVzoQnCf9wjKG2/JH4RlXA92R7PmBz?=
 =?us-ascii?Q?6/maU8N6Giej0JT+05mtGSU63xWQEkTzx8ht4wcaWWRbqpBD1OVwaZg36l0y?=
 =?us-ascii?Q?uQ1icbKu2dXyGBdPTXXoaArLm8iK2RU4bhRlXfCKykNu9myltB33dUApXYGt?=
 =?us-ascii?Q?1oghBwXKAnURB7sld5Flz3HC+e+gx5KYkZGFLJZYx2wR4IOZc8/+ewEzuP4E?=
 =?us-ascii?Q?baeFfIC/D7A2ANzlK8LuchLSvbME8B6epoguKBbcLvi79QC1yrAplTnd+Q4J?=
 =?us-ascii?Q?6QqajVOMy1scWXDjBXZfJRD+8AOlCatvXxCMTBStek252Q5z98BQ4PeUz3al?=
 =?us-ascii?Q?iHPr2anN3Fie1skdF2fqZs/RjKaxgJYIspsCNkk1s54O2EKa2fBEfJBkfask?=
 =?us-ascii?Q?RtdxKdmus/FKhdsVA8VpnXlL5SBp2qX1wNqJArlQ/qeb0FkbVTkuBvRN+o1b?=
 =?us-ascii?Q?p+dTO9ywxOXFKqLqLCneov2BGlRFKJIw39tIFvM9jhKMiLCvmNPB27GwKp19?=
 =?us-ascii?Q?T0ZbhYgKwd0M/hU/80DKRyB1QL0RRTABawnIcSSxw5BC402018PhzbTBlPMV?=
 =?us-ascii?Q?NywnsU+ZnWwf9W4yIE/tV39vjAJl4FoRh3wrvq+yGwfbkZW+m6gFIxWeI/3i?=
 =?us-ascii?Q?hqTbgBqOi7P0eZH7Jk79JHTxIwD3Uqvv9iyC3cuhsQnTdvHfQsNTcfCC7+e4?=
 =?us-ascii?Q?6H3VjbvPaSKZCSBAuA3Q2mgFakHVDIOd5jZWYGqZZ/Pqe4G6wlWgZCgQ5OMl?=
 =?us-ascii?Q?wRZTHK3QAJC9ws6UB1iKuFC7xfSQ6KXkLqigoVuXJqYkUFPOhrpLn+1ts3bG?=
 =?us-ascii?Q?1r1iYnNWNDfCjdooQVlodPIY9BxteflSqdPdasL9Mtb2VeTR9VlZNn6BshBw?=
 =?us-ascii?Q?9v3axA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6PxBToioTdzzfef5vBCJk3wPcyJrwQdXaucFHOA00+ueBInW4JOGr2pc4OdLCphcNZVuDSXG10rFFCs5L1dtIQLGWhnu1qROAMBMmLWRM70h20s3kR38FK9Ym1WYskRYIwiAME03MtvqE2OAA2FWYaMoshmtVu03fKJUyGVOUlfGMpAM8EZFvJjXAPmZ+XuePHJ3r6elOSqxmeA8d+coVe7kMwo1qJ24vxyJVVBcOLOt1gDe9laBBYMnDPC3mby8Iad+MWOkaE+gO2swubK9/NHq/Vc/uaNuKm3vJWsKNNU0LgJSHobCoHX3t0KKGFoI5UmT7mBvJOFDH29QKxCCAe27fVDEUaNClqxfgxol8p6uWbNY4+ChavOi5ejs2kQ8ClWMhihXdbDPL/IEpSu2oxennbwbgMfTjneq/AX3aUtaoE4IsJ+KCf6ZZ1w2/2Do
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 00:19:55.8588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7b2e2b-3add-4f5c-e6f6-08de644c4a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-256888-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3F599ED697
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


