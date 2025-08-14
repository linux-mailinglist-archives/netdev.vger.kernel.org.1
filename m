Return-Path: <netdev+bounces-213668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401AB262C3
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4298116ACA7
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B682D2F83C2;
	Thu, 14 Aug 2025 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GS8eNQKP"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013053.outbound.protection.outlook.com [52.101.127.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D32F39AA;
	Thu, 14 Aug 2025 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166905; cv=fail; b=pFhp/VYXuKV5XSKtbR7v0vvpdVOzCM9AgeMcflgo79ZjlAAnFNjYTp32Jac5R28WgcvQL10s67QvEK2GS5Fw34wf9fzsRGhkMn0U9rZOfDfpRJdCLJuroIks4nR+1wm0gryzrLA3XavHi8e2uxG378RZUulu4SeGjL60jbGa6iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166905; c=relaxed/simple;
	bh=eVxOEkg9lfl7ATxz7HRoV2PjUFpae2ySe+6Gv+M1kwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JupV/O+jJ/2SWCzOmtt6W6/zpZO66hBObY5381oWmUPg5KWdwqWgA3qzbzcVuHWYNdirYSeIt1w1LZrGo6CBKBHLV8aDRzFYtjDaMuBETyt6PPKPhUlnjRCOgTEwLMRb1QYzQQ9VFU4IzJY4imbj8oFVKXL7c0Z/wcrHHfBlugU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GS8eNQKP; arc=fail smtp.client-ip=52.101.127.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UehKnP6646PrzyOZPdnbafQhJKJTGDrZiTJ6SNLm8RsBsXPaJs3fNL+UuPGkLtY5spd77yiYJKDQLaf89qcWXWBBV9iqKBpjM801x9v2kZYcHfGHMc/P88oGBqz5FzYp7jhUK5cwgGS8fKXhnwitktM5O1lFgSE0OVsrDRf8uXnyK5VujYfXa7seTU9wMRcjVIUeJZkV4nx1aFs7+yd/Iw3TmLNMSMrcsHMGWFopQSs2NlfxgPsZwgUGiZo+de/yorsNzqHZKOUe3IaWW+LfFi9tFO8dbOUiLjp6tPKCOS27K6l8DIstIhBPajvkE7z7bwFcQltcvJvVKRz8RL+b2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdD+wzuD0Idfl9bscud9UmAvoAbM+0WpbkZAng01vPc=;
 b=bFduoVHJYIrvkithiUGQYspLjQC42BWa+ijzrYRZ4qz9XWRmTUaHUNl5y0RedHk868ZJSzfR40wDW3ls9TeQMicjVDxEub+gHrI/YMMdrwEUlNx1y2oRuItSC7pG86ZCCmAzdChp0l2x7B89ic88AtbWlzJYYYIPwMLODgKfLwOsvfcgifsz8l1R0QkV0bCU9bZqPivoN8LMrxvM6OZ29brfzum2Xo0Rl2zVrKkv6GCqz+ZAvo7C+updCSlO6vMRU/Lay2+y0o4O4AdrqCU00ikJfa1jFtY5kZjskccVOzf+pO6H4XEdEl326NasGBpH7qh+HkqVi1AlaYR8OPNs0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdD+wzuD0Idfl9bscud9UmAvoAbM+0WpbkZAng01vPc=;
 b=GS8eNQKPJxWY4r1IlFhulI/Wpi/0XXD+f7MzZGJDzVWZEdciE/J1vRWAI0TlMAQHh1hI4uj1oSI9kcOeUkqnA9kB9wzUrh8zlm/ffDn/YY85AtyRb9+1y9ratrQrmbFYJe0nPABuiqwR9HNe17AKAs+mR2Nuteh453FgNajR9WKenI1wxn4D+00D3KgEjjWes812nhiS1mdpAJaDmGgMcUFaAmaeSzDi0rJD7HVLfctio/6jBgm9/TnVMXHSTwj1rw2nc5H0wqDPGEZsCsXdDRFzw+dCCBswKXanqIs76ZIspFBBPL1te1LkdonubvbpGJD6GuAQY7Ow8M9Ft7Rx1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6699.apcprd06.prod.outlook.com (2603:1096:400:45b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Thu, 14 Aug 2025 10:21:39 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 10:21:39 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	oss-drivers@corigine.com (open list:NETRONOME ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2 2/3] nfp: flower: use vmalloc_array() to simplify code
Date: Thu, 14 Aug 2025 18:20:54 +0800
Message-Id: <20250814102100.151942-3-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814102100.151942-1-rongqianfeng@vivo.com>
References: <20250814102100.151942-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0149.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::17) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 74796698-8749-4b9a-02ca-08dddb1c5b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rnsmBXs4zg/O0xz5qdvbTHh/jJeb/6EsyTzT3koEk/nr7sJIeA961Tq0t/Wi?=
 =?us-ascii?Q?RcgG9DuGLzsPjfIdJY3SwCkNl4Yb6Rp7e2jsfQZTh9eLYowrGGlMMydMPh9Q?=
 =?us-ascii?Q?7b4IaUbNBL7h3zR+hjKevElZy7k+oEyMNxYDFnD8iGBAi8whhVew6vD62I4v?=
 =?us-ascii?Q?HZ7j9zxQjeeSevCe3f+SJ/NalPk1ksj5Zg6err7k4Oy41wkLZmmErAiHBqmR?=
 =?us-ascii?Q?5kGE/LcrbaOHZmTLwMXvYUcscHutyLiET048RQl66uwDd3ASZP/p2f8vFs9R?=
 =?us-ascii?Q?cp0STE2eozAfJ/3WlEVIdROjXWbDK9gEWIzHHc16sCO8PsPdN4d1A0njbSnp?=
 =?us-ascii?Q?HHJR/5Sh8mKWj7D7D2kAxVg5WpyMDRG4HTzSKwMXwl1fwDqsJB3jpOhVeeTN?=
 =?us-ascii?Q?LayvDwlRHJAqDczth1ZNBtAOg038nA2yCMjmUvGP69YFL//SRhPz+l7ySvQl?=
 =?us-ascii?Q?BuSByApxAzkplEEVxPFhAY5zQT4N48FuAFBJR//89EvF0PfdVRRZZpDiIs28?=
 =?us-ascii?Q?lLIE0CTNzGck2AOT1cO1N2c2lfb4PH46XvhndFy80DTJCHJ+ItDDyvt86AP3?=
 =?us-ascii?Q?M+RDI/3KwB0H1MOCqvrbm0x+Pj6guD90QkUu8LYUN9rGM9jeMKkSTRtbTQtJ?=
 =?us-ascii?Q?JcK/+V3C9yBK8ufAGGvfN6IhsN8xJx4XHOzfuDC/w3ea+vKAeXEyrPt25RXo?=
 =?us-ascii?Q?Rqrmutb5nLVEbufKFOrF0kKzeGIUH2SQSo81XdpnbanvYAjQOM+P0gWWhLFH?=
 =?us-ascii?Q?TtFgOIAnAedy37YzQjXM2zvL+/2lGZ6Y5nSfzWZo66bmI1yXAF5FIlucR11Y?=
 =?us-ascii?Q?XvyKHVhv3FunQZqu4R6HFxQsxgZ3LMNJjLzmbtKbOifZNJ590mSnax9TCBsz?=
 =?us-ascii?Q?hHkv01xNIS9HnreoAMM2E8vGVM1O/awPxDEB+wATavpz+kneVAg5nZ/mdYqn?=
 =?us-ascii?Q?KoYJK9KEEeRxeYeNfCEM930gRcaUjXo4mGzk2Zo5O3ejKUiHYBzqnnbFcF1n?=
 =?us-ascii?Q?jaKpwyEYZH0CS6xozFcliRF09AwkESzL5XqcIzZh9AbH4uwRVhGk2sdGl27x?=
 =?us-ascii?Q?LgjPrfZkoEDfdxVBHLa68L57eiIN5OvMzPslVkziKKcaQFcaahnMB2Ev+BaK?=
 =?us-ascii?Q?5ObsnvGMFKnbOjsTwxACnIIpOK2flPJHR59oi2lBiNTrAzWjonTicsWFFUDx?=
 =?us-ascii?Q?kxZZBDEyIcGkv601rHXze7IlLsSBn8N40tn2Ou/keQ9bmX7va2W/qBX/1Eq0?=
 =?us-ascii?Q?eVK0Ay8n79TqKzhyO9FSvqnUaU5+5iUhBlYMJ1LbhaWmwWlZS6HIcn+VwsGr?=
 =?us-ascii?Q?/n1u59i5Ii5+Q4KQvYcsRXkHcSmRIEGiqV25YnF7t2qvHp4VitjXmO0TQVVj?=
 =?us-ascii?Q?OXIWVE7rSIBna629dJjhKmDCuHoFtCfRO1mUtIwtBqvWiSL5msXAjkH879iH?=
 =?us-ascii?Q?lbMoqlymLEfg3zTvJZwD7+mxWH3GnZRpX5pgXe04l0qWhyHtQUhS9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f38yo/7zcLynHJYxta+v6otR5boJ3Y2yG0e5TFNyrl17c9Jbf34wMcu5VyL2?=
 =?us-ascii?Q?pLHddlcELrO3C7T44FhdnZ+Yw9b+Z3O9B600yymYKWRtER/JI/VZCGihgVHr?=
 =?us-ascii?Q?wRyuwGmXi7g3E+JIXiw+zBLeAJh9w32OQGzvUbx0nKP9oNfZAfxRmH3W3CWc?=
 =?us-ascii?Q?u5sr58EEUUk7M0DxFAYmxRQsxRcJlYxR4NcCM0ZEz8hSZ0Y55EsMCD59bIsH?=
 =?us-ascii?Q?hnx83eEnvZGPfnZww+JEtvKkPwMUiIAyEXgwFc24BMJNagz+yyB2AruAApVA?=
 =?us-ascii?Q?JyWtVuN2hejou8RiRID2bYVs2LYYvBWARcOmWrlFUdEEltvShezAb5kD4nP6?=
 =?us-ascii?Q?Haqg5RZgOkPEudpia4iLgvcEOkd5RZXGC9JpcRAi1hi2OwlRaZbMCR2pFDnZ?=
 =?us-ascii?Q?L6lHiNvh/mOlLwZavjoTd4Jms93z02VDOjodyiDJNY/S/R8WLsu6Yu8pZZKy?=
 =?us-ascii?Q?qbIlxtiLBMRbttKjsna+hvbuSx41wj7qIUhPTT3I/7GC1dBwPbZlc2ypdiC4?=
 =?us-ascii?Q?akxKQbQjkM4wcD/9pAxstvx81zdFMUt5WEHSK484n7AFwfQLR0SNP1mjW7Jl?=
 =?us-ascii?Q?SI6Mt0NjBJ1RvtDoWqHexPK/6roDiv36z4exILkwLYbyjLwDbPbCiM2wQAkQ?=
 =?us-ascii?Q?s4R1vnJxMZKe8acafOfg1weiedrbLUO7YeoPtdVMk9Nwn00BWTDbLyNnKXrJ?=
 =?us-ascii?Q?3QWDB8O3YEC8n/85bVM3JU6T78lTv3kvHPb6FmpdU7ZmJNX/TrYqX1w25EwE?=
 =?us-ascii?Q?uydlTONTS7H0LMYv/BSEt8SuVh4RK13bOhKbvYiJmq+GjEFC/oiWfb+2OhjO?=
 =?us-ascii?Q?YYz1BE8TX40Ixj1lx74gz3RULC/3p52lknkUHanp7e5KRbSRqZ2f+7eTmpfc?=
 =?us-ascii?Q?bkY6ZLFOShrmUeJQw1cg9SWd7tro5nN9MhCHB2hoT47BFN0C7HibHX90A8M6?=
 =?us-ascii?Q?gs0vYtvCuZjpdqAR/0IYD7QV8DlGrjNu9RGUc3ze0+Fjsl196G4oHlC61Mq5?=
 =?us-ascii?Q?SLGaLaf/Jbw7ZBwYt2zzT7Bx16LaZGWWssNHFhnV0RvAbFQZqE59oTv1pTI6?=
 =?us-ascii?Q?0HmlMT4jAsAJ9F/wwDwQhwV2+I+XEd5xLSWaYQljbuUC+Bez0SwjKlMkYTP9?=
 =?us-ascii?Q?9t+QP9Wcka7kzPzRqM9c5qw3aY+huI8px4RJK6NycSI3lXbk3FuQY/hvAoFg?=
 =?us-ascii?Q?jjdx7xs3fhZz7OIIOMVTVE4u4elto65VsD1liAP754kQ4ezR2uKmOmdMuRFP?=
 =?us-ascii?Q?lY+0YNg1liDGG6t0nsM3eHC3GfssXqKaD0p0jks+ciH9JJvEaRf83KSPuGD8?=
 =?us-ascii?Q?DJ4P2MH1NMkZt5F5nzo1+qOKm9KIfgSh04ybPCuq1TaS7KbdlsyilWLdgzUn?=
 =?us-ascii?Q?z5q9ecLpoB9UApSz9E/jTRxHNRQAw7LWfTJoAASNKQoo/84hpP3QcDQtT/kI?=
 =?us-ascii?Q?VKBRElmXRILfQO1rtTYkatWT2Jk+9XlBZLO29S+0d1lNKoYpR8IEUuEnu6CE?=
 =?us-ascii?Q?hdmhR24tPBU7iWcEWuuIpEgy3NEKoVm35ory/m3Lq08rf8k9mGoCarAx0Onv?=
 =?us-ascii?Q?qC7ijrfXZt8nu98Qjf48mIqVNl6b8jInrnBog22v?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74796698-8749-4b9a-02ca-08dddb1c5b36
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 10:21:39.4425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yNo92T0ICb5nVXxIoxN+jhpy95DyqKwG2i3nP9o/wf3pP370Dshn64hmcwXXB5Qgu8HrA4T5Lb6BauYfr0G2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6699

Remove array_size() calls and replace vmalloc() with vmalloc_array() in
nfp_flower_metadata_init().

vmalloc_array() is also optimized better, resulting in less instructions
being used.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ethernet/netronome/nfp/flower/metadata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/metadata.c b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
index 80e4675582bf..137e526e2584 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/metadata.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
@@ -564,8 +564,8 @@ int nfp_flower_metadata_init(struct nfp_app *app, u64 host_ctx_count,
 
 	/* Init ring buffer and unallocated stats_ids. */
 	priv->stats_ids.free_list.buf =
-		vmalloc(array_size(NFP_FL_STATS_ELEM_RS,
-				   priv->stats_ring_size));
+		vmalloc_array(NFP_FL_STATS_ELEM_RS,
+			      priv->stats_ring_size);
 	if (!priv->stats_ids.free_list.buf)
 		goto err_free_last_used;
 
-- 
2.34.1


