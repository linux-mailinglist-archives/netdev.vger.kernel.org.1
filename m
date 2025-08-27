Return-Path: <netdev+bounces-217265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8A7B381F9
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE19170418
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8E92F6577;
	Wed, 27 Aug 2025 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fzXuaiPu"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013067.outbound.protection.outlook.com [52.101.127.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FAA79F2;
	Wed, 27 Aug 2025 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296671; cv=fail; b=IdzTs0VWxWYgUt3FjVfmWLsJmKbo/VyAlFrr5eIHPfUqNwCk4/mz6tRaJ26noDPD4VLbtqtjFMMef3JNf8PJRxMwuoh3LY+u976wIlcK7SfYDsFwWbasnaPFj4S/4kQqC+YHHpTTqFjtdpQZOBK7ujKUTBnIPMAT45xzPkG91VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296671; c=relaxed/simple;
	bh=cwpBAgCxkXh2vb8hGtcI3NOG9ksiqPgnzYtNTg5cEp4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XzE2WwI084G5OMAa+YlO/TjIRmH0b/TiympJjwdq8hCRAE0b+UuOE1V5kwkw68dweeaJaraHfRpW6DyNnr+kLHPG4/bzKHOXBk6Jc3Z94XX5dNZ8uC5ayZS4vmq0heUBMzsl6MAuw+PIbdq8VUot2cycjCsbK3Grpu332GRba4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fzXuaiPu; arc=fail smtp.client-ip=52.101.127.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSa3cRNwgoHBDjNeWDICFpk1JtbApQJG5ro3Ak2crfCvKO459ZQVRWJqEE96vO+meM3o+Dk8tMphH35sTZYVeMHead0sGr208HtHkOihEdLQO4JmZDHiuAb6M7TEgLJJRrv2A1SzMnbo1x7sN/qQZWX6b/DNAhDv18bnSYyXgNeMUvlxi2QgwdC46ipSoCCr2G0aCMDh6hADz4ryS4luOQeNi8WCarWRXTHLXhQlSLEROxoqeMkqxj+7MMpGcRzq3kNHnhEbu7ttMGCuC+2OwhBdIhXA2jrQjrlUTpabjnLMcm8ZrgaRsngi7rMx7UWbqWlTtUGuFMb7EoNJglJ3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPkyVoM7v5TjiQQokZH1WiLzF0Qm3aqq+qmREciXvKE=;
 b=oCwZhJyVExUKfON0JBEAuo8W4oFfrtGedkdSEWbUmwKgr5mSY4C104DuIC4QQrcYwF9vtEamzaUpt73+xI7ciWGQYXWtZF6yG3CWLqKdESrgpwIGCXJPCKjAjMsVx8h1OMSND6+BIZgjI3P4vJm1sluGDqj7KhrKKXlFfvPMpvCQK1HkQz7aoa6yoit9n0cmGNGgm68x5AusCqCU4UivlNqbqn9RE7kkpD/kh85x52r9BosDlseSxWoz9Jq+6OHB3Ow7AJNtoEfw/CJvERbr386fjzN1sx3xBJYnIv4hVvL2oKhSDnTwDEXWMXf22suoyGaLi3S9fQK1NYooyQbLJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPkyVoM7v5TjiQQokZH1WiLzF0Qm3aqq+qmREciXvKE=;
 b=fzXuaiPualkeCVesKdyx5Js1WwjgBTwLyhTVBWon1R/bgmmlLIqtBHqjoBR1UPcN52fumTr4Dt4YBNe1391kwbdr5dhJBR1Mz3oNFL2Dt/hMWMG3AG+qwMRTuudhXnZutsiNQ6vMbH7uIkdHSD94oFRasbIkse4D2SD1t978YLoERdkFOTkFlm2td5XrCVRTQm9cT1+QfIarE8gQbYTj+l/z+Xw/l61X8qyEPIz1Lc/r9cx7BwY7n1RZ/+M/qSKxpjYHr9Fivwo+jt26CY6p5DvEjc47qu/CR8qucxBQz84aHgX7RZIydIF6XG/8bGL5FSILw2O9owTbBzYgQjVh4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB6618.apcprd06.prod.outlook.com (2603:1096:400:462::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 12:11:07 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 12:11:07 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Joshua Washington <joshwash@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	netdev@vger.kernel.org (open list:GOOGLE ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH net-next] gve: remove redundant ternary operators
Date: Wed, 27 Aug 2025 20:10:41 +0800
Message-Id: <20250827121043.492620-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 47bf2450-574e-4338-f141-08dde562cd17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8H/GwQuMmjKMMH5AeLplB1hI93bnCk/hurRBPgMn24F9YJciF1JilKq7H9rT?=
 =?us-ascii?Q?iVZww+WC64eeQW4DUlKXLiIWWT1O9kKtz9mB0bhEZfX/jV1A1ZX+rOwj5FRu?=
 =?us-ascii?Q?pBvAY8YhxSZUsCmwWjSRALMEShLY18kagY2KLf8nHD6N21RdVfFpx5P9G4vX?=
 =?us-ascii?Q?7v6RK/j3dUP6RWQqoAnHISOk3HFIZ3LPmwiyo5vxCx2um1n3cVaIw8cFgu+P?=
 =?us-ascii?Q?jEKVF8jZ03OgKt1tZ4yVxtQ+DYqrDthuy347H1SbWToPMOTFLzWK/azToJSu?=
 =?us-ascii?Q?y2cCIDgIwkQU7hTJFcKwOeU7s0txB5ld8wqiUzDXm79cXnxfQ8uk9pq3CG1S?=
 =?us-ascii?Q?p2+TYYo5VHP3+FP9VmzCjfDpzUJhvkcLevCOXD+mzLeOLappgnKRV5vc4J+l?=
 =?us-ascii?Q?kaO1YHcsNI4a70/JdPaEFYIvZaj09CmkTVVG5yCu1Sxhq1NfD3hKgBfDO9e+?=
 =?us-ascii?Q?sinG014DIjjeI0ZJl4jAjPVR9oa0h5tdBhWtzaMFxrSZ7HqHGKBlJDaJOtAM?=
 =?us-ascii?Q?6Q6JQ2oaJBiJqAy0jCTYnvneXICAEUa3OFHJhYPEFwRnar9aq/Xwdf/5ho6I?=
 =?us-ascii?Q?Lx0rZRfobKwIx5apunLHJZrfK3bAxRseYrEAYleK5ZEEtx+Re0zyy+Dm38DS?=
 =?us-ascii?Q?+m5jEHzsFQ/QC+04f32IzrarH1uI7rATKCM1vENbgc2/AFax0L61gh4BeNo1?=
 =?us-ascii?Q?0WcHC4FG1BX9wdVpZlCq8gt+okhLNDD+zKE7mGyDlkmEmgt+hhK3uTs2MMXe?=
 =?us-ascii?Q?EKz/qlxVpOBNQMBctzO6nwLkaopd3R4ZzMZBVJovFhJCGTyFRaI0NG7O5oVm?=
 =?us-ascii?Q?HysfzhB5XhvIkaccrAefxnGL08c9Q+MNJ1xrFsZvGvwXy8Lp3a1Klf6mthLL?=
 =?us-ascii?Q?MXOq3o0F+zJK0/OmM8wX/1RZxSjv8/wbGo9kwWHyLv1BfSxl8TgtC13LOsdX?=
 =?us-ascii?Q?aE32ke6UkDmXvVcOIn6Ktg9WO0wfxuvX9Yl2aTSk2pYdOFQumlQC0tlKr25O?=
 =?us-ascii?Q?q/6mbbobv7f6OBQ6tWEGyHjc9eeI5J+G9Iv0XDanqZDSPqo+ed2crCxHcvFs?=
 =?us-ascii?Q?6KnepsMHDcYLFn+rf3hEzUWHjvhCyKzienPPRULJ9CLPZV0HWgRQVg96iVtc?=
 =?us-ascii?Q?afjQua6wqqD40feUCYKeD/TYhxsrjJYYUFz8Tz6g9KjAim0drBU54S7XyZTd?=
 =?us-ascii?Q?IOh1IkWPd1Su8S2xYPtVWmctRLWs6lLwG/k3rBRtHVk/0/PJX6qOlmVGb3YP?=
 =?us-ascii?Q?LKq8fi0PBB9IuU4BstTmKKC8z3jGmOJb77KAFRU7O5xEs/ktnpERhLY6MKuZ?=
 =?us-ascii?Q?KNBayNkD5Sm+gflemFKBa0IHY4uVt81uucdez28dPWuVeAxFt3P2ZcsD0QAp?=
 =?us-ascii?Q?v6hwE2rlYBQ9qcQzNasRFdUIR6PQXMFltR4sm8GJCrGNC5BLDJdFMiMzDG8X?=
 =?us-ascii?Q?oIdB4sI9Hhtgan1f190puvhWSi071uguH1GzNo90Lk+glr8lZK+fHOI0XfqM?=
 =?us-ascii?Q?qq3KEnQZ7KYN2Fs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4dNi4OkdRJkI8VuV9C1dXqgL/BVm2drTxNJ9LLV92YzvqKGS3lNp5C+C+2+K?=
 =?us-ascii?Q?W0Esk5D+Y2WpIqkxmISPbqoMnNSuDZAhufz9oDQZZQ5Juw7GAHehGrnmBx0V?=
 =?us-ascii?Q?UzFXhO3FKkRN9qW9PF5fb38D6S2JurFdm/BJ7kZNtzScoh+9M/9MOQTSYPpC?=
 =?us-ascii?Q?aEBpBE85pPQ5s1FCqwUgIQBfk4VjM3UWylSJ54vQ0wSVqurwSPvFn/O7P9cu?=
 =?us-ascii?Q?K94i56Tb7nwJOO26NWMSZrVf0jvOk7ytz8cz6M9Xyu040hhC3uUh+O1MhdsJ?=
 =?us-ascii?Q?AEUZSSHXhxHasOwZ8sE6zmQUYmAFwJ4BwVXc674uTm2ZVTR/YjQ69sFZIiIZ?=
 =?us-ascii?Q?VVPsoqgpX7rHZuAXyOSGBvoXenBc7DzVS5hfWUt07LEbMHxwnAYGShlNxOy1?=
 =?us-ascii?Q?eLyGjeIXUc77iNaCflvOgD+lVON3R+qp6t24Rrvtv6mh0+vIhqz4rgVLSp4l?=
 =?us-ascii?Q?F2fUgUmTwa7mXJgj1s2eJZ9t7dkACE5d/eMJuXKuo7TLwGRyeDJilhBqj/b9?=
 =?us-ascii?Q?7j703HbHbNbF3LvktpT47IRbbp3KrAjvuSdpRVeKGGDIKGCKIrGePdcXmkwS?=
 =?us-ascii?Q?J4keYo3WGWdQXjymiUvWAcgxiA6rUJUMI3WP39OXwxrr5nNJkWoRerb0GpW9?=
 =?us-ascii?Q?9DByGGJnGrkxTj6nin/BfU8jHGyuvQZBMbskNQoyZioffKNlgRWKogKfTHtc?=
 =?us-ascii?Q?F0QLLZVQdimMyCw0C9tZ5+ZO6hE7I9ygZZLjCpzYugszRqyNhtZjcWRX6BHg?=
 =?us-ascii?Q?6/46e65BZ7FyOeN2qBb/l7mS75NqKh6LmHjy/mPAeMhnmA2ODKa7df3zYoXC?=
 =?us-ascii?Q?DEct3XTzHeDbvtZ5culZe5PYnHq5g2DFxk3Et0dpm3MBqpkXYz31gDqt3Rqv?=
 =?us-ascii?Q?VAbEPqeD5z12FOHdNQqmSHoZ/BrBWWN8eRQ4JIpd68yhUaAQmM/FzPkZAi6F?=
 =?us-ascii?Q?df5kxyyCWnMuS12fIwBcdqGq3sJKmnX0Ns6fhDLoTirZeKQ+4YEzJl6Vf/HG?=
 =?us-ascii?Q?SmrEDuHWDtz5Yvea/cc6Y171KzEbf19VXJBwApq5LPKfCeWa8qnmrSaTsIvU?=
 =?us-ascii?Q?d6eSc2ErpBJu2+4LpC7u6RzbJ3VzlW8XZ57kMASgM3/dn0T/B3F98ZASsr93?=
 =?us-ascii?Q?V/Be0euwUd/ryk2KCkFdVQMLTDo7s72TWf7udjRNg5YFruirz/krKDzSZmzq?=
 =?us-ascii?Q?fp2PeFHd7eojPBtZadIi/mauBFmGnbOoPQF9y2XVnnvTv3Jzgr5BN/bzZMdl?=
 =?us-ascii?Q?HYmgMHehHl99GBxNqfY2exCFy+O0JA8WzALRNzDe6MFk2CNrjLcBU6Q0Bny1?=
 =?us-ascii?Q?QSCavQtgISlb+SB27TJcQkfbX6gab64KRpLTRZSDCfjzd9I/rDgXZaSTa3O1?=
 =?us-ascii?Q?Dym/CX2snEXrXLxlyz953Xb0cF2gEzSgvqVrJ/IfvXdb1wJoJnLgTLegiW8f?=
 =?us-ascii?Q?4QF9WL0C0EX1bHLzeOwTB8TjzPnHUBswfqhffrS+tIHvw3fYRdnt/DNA8NGq?=
 =?us-ascii?Q?8NSirDbmwvDOB0zTGwEckC2ZVtOMYW8WDZM2UqW0jJ/AnxnFwIjudDB/d0Mp?=
 =?us-ascii?Q?JLUgNKSBeG/6ISwmLTrl3LZUNIFlLhpUDhQmX7lE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47bf2450-574e-4338-f141-08dde562cd17
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 12:11:06.9626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrMT5Wm8Bwxayi9pRRdr+bt4JWrBj2M9CY40r49mF5o8J6mrfxOyiwUNm0qJQg9JElkKgw0LAqi7CU9OxrZArQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6618

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/ethernet/google/gve/gve_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index c6ff0968929d..a859a2308ae0 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -68,7 +68,7 @@ static int gve_tx_fifo_pad_alloc_one_frag(struct gve_tx_fifo *fifo,
 
 static bool gve_tx_fifo_can_alloc(struct gve_tx_fifo *fifo, size_t bytes)
 {
-	return (atomic_read(&fifo->available) <= bytes) ? false : true;
+	return atomic_read(&fifo->available) > bytes;
 }
 
 /* gve_tx_alloc_fifo - Allocate fragment(s) from Tx FIFO
-- 
2.34.1


