Return-Path: <netdev+bounces-257976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAYGODonimlKHwAAu9opvQ
	(envelope-from <netdev+bounces-257976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 19:28:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7474611389D
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 19:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 323153013D72
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38E230F54A;
	Mon,  9 Feb 2026 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KNjODF5C"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C072FC000
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661644; cv=fail; b=XitlBmirjbNTLkFIwffxWD7yI2KqnT64e9XBjCZdFmoPXYNFSK23lPqr3a1+4PmJun73g5beJu8VSxb7GYugQjjQLD0LLcu7zp32R9LMGTc/wbkWDC7WVkBGDf4dQwYoPifZMGivuvF35EY/eS55JDxHQdfOkNQdgcDbEyo3l1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661644; c=relaxed/simple;
	bh=wFdFbjCl323W0P06n06lxE2hXfqCOv0oAjc/jEvxA5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuF8rQF8gwzMdTrqQFkdaFkqTxqJMtITnOjuF5dXjqmRTHwrO/NLh361jqcXI7WRnYLvNracce6dsp/sosYoDyGTUm8BBSEj7freQFzzkfQ+Z8KfRL9d6VSVmoZSMDRna8n4rqttte2bwKebMCAm1HNxfLpeYbtEKq+GgSnakLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KNjODF5C; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHOCW0/DtGcg8eJq4QVDO8hR1OegmBqzSDur5Lxn+wk+Lle/DmpQynJD98BnXZStZlRwPQTMzkm58K94icwsYkJPoqR4+o64rDst2teA6S1AF7EWdwTlSxtiYusBM4ZBntfEoqymVraXXkX5i6tqcVYnYFtNegV52Nk1HLVvoojJksnQfRLGGDhZ241yt/d4aBC8brV3r8MFbgoKRkbAhkPIJsQDeVUFyiqLnZM+myJw0PE4u2WTsB8fTmHI2Z5o90CHOS2OuhubxEbpBwEcjtx5FY+uDCKFJySIhhTDOBJmGD9UrZcSvENPmlF6WZ9DcTzmaPVOlFaUfeVYay5s3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z96r7xmjqsGfeJakJT1R8qes+EMORiV+lg0mL7ea+e0=;
 b=DlSTG0cLt2WtgkLZ8nuHUyV7E/4Gud3p1UDYZ/CLulb9gwGKrJcxMO3745WOxq/qQRHyUWpHjdFfxFcSngxAyEk4/w3b9DHQdFcsvztmtFA4rwEfyNykdTYGSTqRmgPOKJPUo3d62VOFhnkFFC1bW1KecOxyNKSFVCE09P7FJi6haRDqXQhPYF08vJi+MSKaam9bjUVDkRiZQhY8m/n0/uTHVMKkOXiMZCHj8PjwdjXMc05HmrTqA4OK+/jS0jdbFG15e0cCXAhhn21GU0EIgrK/6UPoSqBJr0fzOWcOuUZ+XhRe9vizhXkUwqdQQvqrmo025jS+KUZMcPnXZf3XhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z96r7xmjqsGfeJakJT1R8qes+EMORiV+lg0mL7ea+e0=;
 b=KNjODF5CmEx3QoF2QLlcG4Jn4uYDUrlSlv0upLqkdoXGwZWfLS/OPj1+dSLWooiQb8Swmr8M5MTQDRYyvaSv6v6R9p8TZsvG2TC1Zmz0coL+/xdjbv9F0jmPe4YdxUa90BxeI1L8zbe01xyf9zdjmX6vUBDmCIS+iGTcgpTS+Ss=
Received: from BN9PR03CA0976.namprd03.prod.outlook.com (2603:10b6:408:109::21)
 by CH1PPF8423FDA82.namprd12.prod.outlook.com (2603:10b6:61f:fc00::617) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 18:27:17 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::e6) by BN9PR03CA0976.outlook.office365.com
 (2603:10b6:408:109::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 18:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 18:27:17 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 12:27:15 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: [PATCH net v2 1/2] xsk: Fix fragment node deletion to prevent buffer leak
Date: Mon, 9 Feb 2026 18:24:50 +0000
Message-ID: <20260209182642.237904-2-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209182642.237904-1-nikhil.rao@amd.com>
References: <20260209182642.237904-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|CH1PPF8423FDA82:EE_
X-MS-Office365-Filtering-Correlation-Id: e667b20e-8eaf-4dc5-b018-08de6808dae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xpqwgi7xrKBAihVB1Ycck2fs8OVZt0yFxxjzGfI3qGq/z52UBwp5yaKedlBB?=
 =?us-ascii?Q?Yzzy7g7TRHwIvOEriYWr/6MiD5mL/vdxip0Ebo5JY45ywT9sW8juuZNaETAJ?=
 =?us-ascii?Q?fBiHG8viJoiXttK+vYrd6ntIYmJuag/6T+Uhe4yxJU1ExTyd4o72FAl8tIdq?=
 =?us-ascii?Q?ID55B392qP1ovEqJ4lFAc5F6/TBELCn5PBGJQmkrxMM/xqYQd7YlqEvXRa1s?=
 =?us-ascii?Q?/OzSERk4kmZlbn1T/x4Zip1c5VT9+RfRdfzk/1kaYb/Www3RN++W7eZg/RYY?=
 =?us-ascii?Q?xTspPHkbjJM/RrmWwc54uF5X3Fo1YJmA5ZU/SvHRyBQ1a4e7+s7m85yVA9IE?=
 =?us-ascii?Q?VzS8dcyU9RnEDFNHqNYYkH4A3Zye31tQ0hjoSkdtIdl9VyFcA3D12P3iErTh?=
 =?us-ascii?Q?1Wi/ADC0ZTW64IZTHz7JonW85MiEAp+vXhInpQ4Mq5V+ypxdlppoZ0Rob1ah?=
 =?us-ascii?Q?lloNq3elj8SEARky5Q5QqxvjdCMuTaPy1dco368zqrr00ksjunGz/P+UFFoa?=
 =?us-ascii?Q?dQQJy/3q7gBlddWBnAGbrhwGmFl4FE0tFn9lYB7fnY4zxEezVbxbvbjDEOkj?=
 =?us-ascii?Q?b3IRZS61WjZ+uJMPkGxmjXpM/2xh1002viMmjolM7V5tGG7vw82SeY00oE6O?=
 =?us-ascii?Q?bumv65Xj+wk5fzk/jIPskQylTGURN3zVfERq0mEU/1oRXKvcQrSOJttlokha?=
 =?us-ascii?Q?tHqUhFZ/u0QJYhdaCzis7Yeiurqb7FNxhny9bN6UR4N7sKHYTBGRz3BN/930?=
 =?us-ascii?Q?EiLh856UEIC+TDzjuDkRX1Mw2NzhPGJ0LMO3khprhmXK+gzB66xRX01OcF79?=
 =?us-ascii?Q?yyNaMIagm3NEUZMRpGmPFxlmAH99/yWqABxTNw4aUTph0tCcLW0nlrLz74Dx?=
 =?us-ascii?Q?aOyW4JEvxJ+own/fjsb5Dh1XqE2vO2phoM/XyE+BKmIR7Kh7kHplabU6Ypxw?=
 =?us-ascii?Q?l/TBkNUInKR3uZxvgSs9RS6ISOMrTMGt1gTlJpZS6ctTgUUd46Ju1/6VAl6+?=
 =?us-ascii?Q?x87KWvY+23IDXRgxZIyVwgezS/hlgI98DjuItdVg2L+VysCMOHhpGOKxvLcl?=
 =?us-ascii?Q?RntoOs716ebS1LS3xFxhmj2wyQrVfMy93UCUmPzjcEmAO5uCHwjeYsczqSOc?=
 =?us-ascii?Q?0jElsCJwu8R2uJ1g/AJmUZaQGRc2aQqPGTZOR72zsKKmGtuv/y9Pq9V2nQdg?=
 =?us-ascii?Q?HbYIs0Em1wXi4x0kLm/wK8rSiam28U7mpWrjIAGepfTjRC2hj+sBusHKE9+O?=
 =?us-ascii?Q?GfqvyldVqHA6RQu2kX7e02k9LJpZbcei4rwRunS3tordBb4sQbFlcmygA9CM?=
 =?us-ascii?Q?3COiYso1D6mgxsHFebI5dVCyA72xMW2y0q5iDZMfWzHkUnWhMhSq11JYYej7?=
 =?us-ascii?Q?pRg1oGOKUZvkkHT5N0uf27Ss0KXf6N12q+hK4zz+BqMDLE8iQkBMC4xVhhtz?=
 =?us-ascii?Q?H6JBHH+EGhbL1gxCBojU5v4O5Z1T2lD4tRdWbe/0OgaQtex/Qt5UqNhWGf4w?=
 =?us-ascii?Q?cAQo/mdf4Vt+mIil+98PCDvyYMJK5kp7ayz6QJxV1JmXVmOLAIMFsdXo35wZ?=
 =?us-ascii?Q?VXN2ZwZpqbTGp1vhrsPZbbR4kL5lZihWMgdsmXl4gn95MlDx4HD5RoDrco33?=
 =?us-ascii?Q?bGNzLnkfhDbTTjzsPQE9dADXC2/I3GH13l3cJ6fjcnHVRobbFE3aK4q1HFrr?=
 =?us-ascii?Q?pZc7YA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J1zECpBkDCiyMlsXA/sOOqOpJjOdn3TAtBaiuBTaKHMY9vFRF66rfYX4iAtTPN/bdPtCG3EW0/Jlg3pYJV6PswVvuI7jLQseKCC1/obwv26Z/UpmY6nSEsLgvF3oCr85EwtsUQtT4P8NSZFQZEYdA8qJsmzqTkQ7gfs4vGqm5OV1gO1TKaRByIxSnz1Y6eUWTqEaHlrEwhdjPFIezBFyCvgpd/WEVerjdgy40ZMX/72xruc19vGz+zTSUVBfI7iYWxEBAxwg8XH6oDpe7X3tDL1pAbZzLscUvdHIVsSmKT6TscCNKAW7gIhnp5K7GjxDPMxlMuloykLyMAP6vtcp0eqQLfhmtgYD4frkI4zAEx3ovEFm2PXQ4fYD4IPoxIszfSWBNb+JPY61K0ice7Le+RoHGbae4jh3DsvF0WBOMNyZSaBUY1QcANhYbmzJ7gME
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:27:17.4450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e667b20e-8eaf-4dc5-b018-08de6808dae8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF8423FDA82
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
	FREEMAIL_CC(0.00)[amd.com,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257976-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7474611389D
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


