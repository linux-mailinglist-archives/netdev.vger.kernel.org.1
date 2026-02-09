Return-Path: <netdev+bounces-257977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAXXK0wnimlKHwAAu9opvQ
	(envelope-from <netdev+bounces-257977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 19:28:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 302421138B9
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 19:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B26E301AD02
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 18:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA192FE07D;
	Mon,  9 Feb 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GJYko6g5"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA85D2F6907
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661648; cv=fail; b=Czbtb3viHmfslXDcTBhWUzwOUceHOdIEzmOJ3c8bTw7y1Q/asM3mGfQco/vnyFV5IFrR1EyxSgPZEfKfvra9tD2swVSS8ULSIFWz8fVsOpcpb3FJgAOc6U+5waBlS3noDQiJSE1gNaQZu7THbvjyGkkgMxsGGYLWQ5y1+RcHJKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661648; c=relaxed/simple;
	bh=gzldYJsG21oev5QFyhHmHEafSIvjvcwSdxtjgeTwrrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgxpTv3uH5/Z6Ztg+1c8yVMJAeIanNnGsbm9iRGCfXMdzuwcn3SQIZm9I27QIlct9DIrFza6MPprg+uEG3Z47XanFsMjU8SkkhEU4FdYc1t2Vj7JTHuqBYNe3VqZAzavLnqd/7anTAmfCwAaVoqg52/rJn3ZF/LUewdquU3a/CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GJYko6g5; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRYg8dO9RE7KZl0vKZWuLCH8JluoJbk9ujqi3ZY1hhItaCwvIPDYbLkzAPI78YBIacRUCD4EPW7JNR+vy0Ax7P6Os8yCNHu+YyEYJMeA2M3D5v9Ns1HxjXZWa5OprpHAt+EW2B0zFfcASYEGAmcUeXDARwjFN5EY0QXboWzLgO4vkgpIxyBiS7f82K2gnRtpSKIXQFVzP3aTIs6TlzSBt0cRIdXefvaJJm6T4a9Vb2YyrViQoVU/FdhZarrjCAbfiKiyuWXnAT2cuybdvPaWQtYdk1NXTG03GwW8++ANCfZlaLMol9bV3HGMqoxV/JaEL+sC6U5p5v/Jmwi/dinwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdp8ARgSsplAQChgS5YWJ2zyI2wsQy9MDa5xizluO/0=;
 b=o5XHlbXrh5SvOwEHuci+Vc9iAwQvn4YNeApLwXiVBrmSyOWjTjWNYgNzDUmu07tOUpOsriqokvkFDmYb2fAy+gpo3nhp1UP99UNGYC/vz53ETIR2l1SMSc0FqT6A6YxKz+AzIVeDdWDUT8+AEBKEs6Qg56mFmFI/nxJBdtTZC/OHlmYDdIlPQCkoBwwwQqscHj14+qKQXZ2YpBrrBh9DiQRaETkXzu4u6DAbO96a/r1NHNgNclSkZNYKQxJWkwL/avFP57X0ZmSiKkjWmj2T0h/6o0YoVJzAkr6AGOdn6LCyO8B8c5mOa+fCA+JXGRgZ76J9jFiSHv+/T5mWNlxOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdp8ARgSsplAQChgS5YWJ2zyI2wsQy9MDa5xizluO/0=;
 b=GJYko6g5oHrpQACRUhIoPzu55z4TUGdIq5gyfM/nknUD4I18hBgtlFOGUAFWBtO4mNjgOY8bmMklba18qduRWaL5J5TvwHnAvhYc+WGNO0AuFxa4uCA1/OsY8+Qn/nRdjpinp1TQ83sL2ZYbKeHGBm5PfaIArsv2jnGpMiccLvU=
Received: from BN9PR03CA0977.namprd03.prod.outlook.com (2603:10b6:408:109::22)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 18:27:24 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::aa) by BN9PR03CA0977.outlook.office365.com
 (2603:10b6:408:109::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 18:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 18:27:23 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 12:27:20 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: [PATCH net v2 2/2] xsk: Fix zero-copy AF_XDP fragment drop
Date: Mon, 9 Feb 2026 18:24:51 +0000
Message-ID: <20260209182642.237904-3-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: f6079987-4666-490f-8886-08de6808de9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ONsd4xh7vvn6udos6J+d7istgP6+wSd0DTp1S7uGkc02wIPK7ylQOi33iuSb?=
 =?us-ascii?Q?YMrGFPrhBLuXPMa/ZEO0PzRH5wLVR6tYwOdXfhZIQzj6ImUX3zyPYDb4CNHW?=
 =?us-ascii?Q?PluDs8MwGyr3a2OJ5vW23Y2+IJflWZcqRJ/oOiSilKh6HqL6igdy7rjl7p/4?=
 =?us-ascii?Q?KEyxaMQg3h/IJZOh7Y8ZNgo2nuw2CKqRHVMtOuPFi/RmfiabfFniP+dEXHvM?=
 =?us-ascii?Q?OfxVBUQiL/mYl70s25D+gHgoW/usauDr5EO4x1zvQR7Bhr4c8EQg8IJXqcmF?=
 =?us-ascii?Q?ITDcgPhI4oAfpowP2L6ohPFiE0Tuxc9yRjy1iWmlLCAaj3IHcTDiXp4mjyzd?=
 =?us-ascii?Q?mspvgRQifydYQ4KMvbUzbz71ITqTj8T8ugBjJBoBQzwB0gThVVhMvHZQEevV?=
 =?us-ascii?Q?NBDFiaR3cgdDlU8Qx95zmnSxTu264bMFGK3yuAi0skpW1/JubGWf5l6SvEqy?=
 =?us-ascii?Q?4AVotBa/asFzrm75+xJuHmXK+CgS1qzUyyQTJ8wEWIBSseIrWphFSxh0r3eL?=
 =?us-ascii?Q?W4BEgO5Y4uSKF5biu+aGWhyngQKH0UaWFw2Nb9DFF4EONbVZPgIMjbKss1vs?=
 =?us-ascii?Q?hlPXSc1xHTZJJhKaSGrnuqjtA5oprhjn2C9zUIkslTUxOck4o0Cm1tChJqtS?=
 =?us-ascii?Q?pKr8qCvGBU7LxSPf+8cnjDbPSMsao81ksrSc6OwgO+KVksOxLOacEiGdIgu/?=
 =?us-ascii?Q?SFzLeQ79408MIfaq8+oY7kTpYXRPOW+QqpZbVTmBsnLy3EVXuzyLaHgS4SqW?=
 =?us-ascii?Q?nBx5AnEcLQ+kvfOFHQ5CLZ8DhHgvZHi/Ys9jILTtWeP0XHEf2hcDsRkglhqC?=
 =?us-ascii?Q?wmYWJDcXBJ/keKQxS4HD/toZzU6NVgH/TzNY/+VLrZk19W+5oR8BiDCVYDRP?=
 =?us-ascii?Q?aV75RpE3nsXx5W6/vP09YlA6j+sPyPjpX0IfZRfCIC/j+kGc0izATQ3GwqXG?=
 =?us-ascii?Q?ii3PU61W1IHgjIe1DWovpeNeg9TuBJeZ5MnZJtWYkqtp0UQ4IfQ1ZQfF/AqV?=
 =?us-ascii?Q?KgNkXBawwz1JGlJM9v4jlFCGu+YX8AKhxoQUqcxanOXU4FyT65lwW6sSLVou?=
 =?us-ascii?Q?yfSI7WG4dcNT6TS2/o6dOy3i4yVXqvpgCiuCOdQkXQAp7Er4tZTyEAUZl6Uo?=
 =?us-ascii?Q?sP0EVTEoJ9xF6SqLdgujRXbvEXnToEyjbTi/5YkXCgYSxA5L+OZdAXyk9wLx?=
 =?us-ascii?Q?0bBT4iuX6HmAxWInN+nF4yVE6FzT6bVmNe2nNqIBvB26CzOiLbKIrJFbJ6Wo?=
 =?us-ascii?Q?I4+ELy4D43DzCenXryRKCepyjeQnk+OpgdsQRguFxHN//H8Ejx3h1sq1CE9T?=
 =?us-ascii?Q?91zidFKL6PVOkIHoGeSvgN4nFgf3x1xlHOjqWBhbbGW4ZnlcrEKXUN2T5Y1+?=
 =?us-ascii?Q?KVqLEwBuSBLrWKfWZaPPCsGNKA8L79dlAvV58U6JLIsEv2Ok8uczoPhaxaAD?=
 =?us-ascii?Q?BBFHA6sYO2soDxdfprf17mnlay2K3dNrtgWsQM0vppdI3XR2HHKVpjj51ewj?=
 =?us-ascii?Q?c7ME8h18sciHlzLTYCOZ/OndJTW8+axyuxCXw/fC2ZRAEfp7U1ePFfV8M19g?=
 =?us-ascii?Q?ACCKrjtFTqjlkTqAbKBNa8hqp8TPpGS6tXCHy8HnwkhF/3RKLGj2K1eG6Rrq?=
 =?us-ascii?Q?f8l15XT8CGHYOusXLFfFmoPLlQCL1ItUmDLihrxnfW3SoKBNKFWOZtAj+IaS?=
 =?us-ascii?Q?ttxEBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nHqaNYR6Wq6k0W9vGcd28ItGwyjy5xWEhj7LFYRgIHcNyb3YtpQTyO1p+IzwfTdUT6y0j8rQ8W1bzoHBvJ3bUbDDxeOb4EXkn5dUJVAM8BM8pLLamJgys/vWMgK7J+7YHSdjMXiPcQxoDL6d5/fCvmzbqGOgE/dAlCG/ZRegNf0oA27uCwIc+bSjbK6VMetc+0XR/awL6udVEkavOj6/w3fsSUnHT3VVlgUXApTUNaMEPc+LvK3wT7KX4uAliJaQnbyG7/CTz4lmYjIuh7M0xQMfQByUv16MiQxtGYA1jiK8p6jYdJLd/wFQPG4ybZ1ECWA/19+PXlgtxb2pAloQITF4xkCASQ2Awyz5m+rCmjidswQMb+LhZCnZPix9cUDJZyADm0DErOYllkaQGsvpyy0yrRIA8JJy4sl+C6/McRpKyIsUYmLrY/A+H/fNjTyW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:27:23.6802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6079987-4666-490f-8886-08de6808de9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916
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
	TAGGED_FROM(0.00)[bounces-257977-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 302421138B9
X-Rspamd-Action: no action

AF_XDP should ensure that only a complete packet is sent to application.
In the zero-copy case, if the Rx queue gets full as fragments are being
enqueued, the remaining fragments are dropped.

Add a check to ensure that the Rx queue has enough space for all
fragments of a packet before starting to enqueue them.

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 net/xdp/xsk.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f2ec4f78bbb6..b65be95abcdc 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -166,15 +166,20 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	u32 frags = xdp_buff_has_frags(xdp);
 	struct xdp_buff_xsk *pos, *tmp;
 	struct list_head *xskb_list;
+	u32 num_desc = 1;
 	u32 contd = 0;
-	int err;
 
-	if (frags)
+	if (frags) {
+		num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
 		contd = XDP_PKT_CONTD;
+	}
 
-	err = __xsk_rcv_zc(xs, xskb, len, contd);
-	if (err)
-		goto err;
+	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
+		xs->rx_queue_full++;
+		return -ENOBUFS;
+	}
+
+	__xsk_rcv_zc(xs, xskb, len, contd);
 	if (likely(!frags))
 		return 0;
 
@@ -183,16 +188,11 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		if (list_is_singular(xskb_list))
 			contd = 0;
 		len = pos->xdp.data_end - pos->xdp.data;
-		err = __xsk_rcv_zc(xs, pos, len, contd);
-		if (err)
-			goto err;
+		__xsk_rcv_zc(xs, pos, len, contd);
 		list_del_init(&pos->list_node);
 	}
 
 	return 0;
-err:
-	xsk_buff_free(xdp);
-	return err;
 }
 
 static void *xsk_copy_xdp_start(struct xdp_buff *from)
-- 
2.43.0


