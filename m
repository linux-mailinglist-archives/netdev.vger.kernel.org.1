Return-Path: <netdev+bounces-268957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPAaAuF6ummTWwIAu9opvQ
	(envelope-from <netdev+bounces-268957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:13:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 896B62B9B44
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20F64308B989
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF8B37D11D;
	Wed, 18 Mar 2026 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Poyx31f8"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073223B9601;
	Wed, 18 Mar 2026 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828626; cv=fail; b=mvO6sT8FUxdGZwS0akZFLZgcnMS1AzWjObvQw1Oi7FVCjgpEDG8vz9sjEQQGpuIkU1M8PR48SrlyuWQIRaJALjNaEyQPru5Sl3iFoxaBH3k7botk3vvG71hgg+Mbj8hSTu17VMg74jRhGYmzWDW/mwD3KXCTSn2EYuRlfxxT7iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828626; c=relaxed/simple;
	bh=bJvFzKVQQgPcM2vXp70E4zyMK93uHeL8zpRTW2WIQOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qXQ+jIJBxPWOZoBP3CA6D346i4p7Z20KYuL2wwtiFHfaSzNaWREGosor1ftoPjs5Oc9YyfFt0plWdRaSwWuh0lgadinwrFk1aTPgYi0fcKsO7Cim5/bR4uJk4dTsdG+4igxm/DA81IrQAJ2atLZOHWD2NsDzQmg9FaDY2LmTr5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Poyx31f8; arc=fail smtp.client-ip=40.107.159.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyAJ+FILoTJtYjQX15yAikGBOd1UdtUH7hj2jIL10U7nekyVKNKJ90vTIqgBMnCjMa1g7E0MVZiLRGnb8zsSkFqq2Skxscb0kuH0J6nYLMqaeomFXs8uEEAr5bnbYC3AwkTrqg6QTUTR+awyhLhLfRHeFUYw3t1oV1H8hGcniyOOTvq9y4WEkZGz/6jY4NgRA+W/3XpoBQIh9gt0NyQz7TI4AzBZjxcSx4xrxAe1lcIP3UAZJ5oGp4EOklMnD7N3Ddfj1OQwBxzPDxpel/44BrjnHCEnW68MX511LNC/t9fZOC0IRaZzlI7c8FCxr5QjZT5HSxu6MZU9oRH9caf0AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G64ycl13AzrK8l13BLZONXEtQTgslcSH+KSFmvSN7LE=;
 b=EX66qvTnXc7StiepXmU3L4JvoUCjnQNoOtgUig18HKr0oEqMqJ7PRo3DuL7SfLJMgBotkv1Bc0YolMac36N29F9KZoZPXR54jgqbtHicVme7qavTrfathgTrshWUvfBR0dAyOTCKZ1x8nsZ30d/Eu4FDcisR3lttpHiVuidiauQu9gu39P5Az5B3Ent5LLJt+wFUy5+JG7kfb+tXsnOoVFZboMGhRudzZwPPprIlmARazvZfFx8F+Ym16TaG9ZuwTMK9IWdjHwSpHipG/rOmykBGQzypoQnKSLC9c6+KR29fGIE/Uku5TUIsDnJNMe9HLfDiNZAMRh0NpZ2jxGkuqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G64ycl13AzrK8l13BLZONXEtQTgslcSH+KSFmvSN7LE=;
 b=Poyx31f8H3xlMurcoaItLRum81nDkhHQgAoYQHbTrq/QY4Nnjl0YNj4b22ga57Xb7Xksm9CG7MavSMz0rLsjUuI7VBmC3cLcx+D7huerCoFIF52Vn9IG1rWSi1c3tyNnT6j7LunrBeqQhP2Xk84Rt8ipFUpTAAu4m2E5J9pkTL+qNHU2tp3EDbeug2jKc7vi51XW3+pbsjgK72LKHl1PvvtpVmJgOMNhpf2Gc33WcqlXU3fTHGRYUPtUpDNd0UAukcLRo1VI/2IPh9SeIuLoUAj86TCHdhEMh3hWxN0mDSWvejC23719cw+Mlmm0Mn0zTxmNGBijqKAalkvim46d+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AMBPR04MB11744.eurprd04.prod.outlook.com (2603:10a6:20b:6f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Wed, 18 Mar
 2026 10:09:45 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 10:10:13 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/3] net: dpaa2-mac: retrieve MAC statistics in one firmware command
Date: Wed, 18 Mar 2026 12:10:04 +0200
Message-Id: <20260318101005.2088897-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318101005.2088897-1-ioana.ciornei@nxp.com>
References: <20260318101005.2088897-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0031.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::24) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AMBPR04MB11744:EE_
X-MS-Office365-Filtering-Correlation-Id: 32935d27-eca1-45ed-8e3a-08de84d68bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tmkbepgBOav18UZNztW1RwQEQ0u5CA6vES3Uo4BMDMpw7FN6GjngBTWnNs5a1wIfgJYyaXSBPeb+6yGhWIxiUHZvzLyUFZtC9qpVnyh+ZaX48+7xnB0AtD37klopPgAEwaQ/NYn+5Lt/asRmdIjFuPCbQpSA2Xugv84av3pkFNyyok+9yOTd1Ph4MFpNO+dYfP/qx1wslfy9Sdx124VbgPpsGlAZw/lz7OzZExdjRcjh78ONL6eRPOtZJPsutClCO11ygYRPMMrWGakjxNLqrTZ2IyGQmczT+b9gnxaig4lWm5WYFE278ArAjl8BX5ofAswVzi3nkgDYLecWv6ZaUC1eGeASmHXpxgrXPXOAKU09C1JuNe1K0fApR0iiu4E63i+GBnsdLQe9Gulbs3H9/ZZLaKgqwwWrST9oeXWcKqlrOeI7TQ2B4iiYH7mwtdsYVyXRnzqX0Mr6+TKqwfRfwQ0FnvkvnZv0MUeqISjlolXqj65NA8AOM0vP2B7bwUlwDEYogtiOvo+WrJRfJtlQr+j7ALI4BVXsjp6IYgmcpfgbPEBoXGr97+uCQBtzASyLzTsSRrdeVeb/FOIPqjmX8Mm18AgG06oR9dpiODM22MIzupACsiQc2cyHohUDMKaRHzlbPny67DC7pj65JV+CKcUT685ZlyH8mr1ejIwvtYNeEKUA4EXJkIVZ4+dTq6j8xHQDaxZ6oGYKJGyFCxxABIwTUK/9HYEbSvkSb+jtbNo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Efppoq1YiLP3ND4BGEAFBaXxse30Dr3BsCSS9t+AOlBIRy89vt5vO7ycJ8v/?=
 =?us-ascii?Q?n4QSHDsX+HUczhvBg7b2GOYT4vcqlC1yQjgm8+1HceAOlPmhXtgLoFHKPWib?=
 =?us-ascii?Q?KPSZs0KlHbnEgBhxcW2N3PriSjVzFi5auEcikmJQEZuc/Iu/ghCBdefoFVPd?=
 =?us-ascii?Q?O9XFh5vGeU/w7RMepS8emgk04b5uk0AJpnnCk1Z0V5XxWkw5OX3PWOyGrecn?=
 =?us-ascii?Q?18aEPSt0UOZW2BEQYBhqmVNreJf2juU6Hf+Op355yKnBuW/B2WtT/qnvw1Ww?=
 =?us-ascii?Q?FOBE2Q49ZDOoT0sPZqFC0b2vOW5npoSqK6TKCn65JD6y1seNNj/l3bsTsVix?=
 =?us-ascii?Q?UlqmWmwOiUNadDXxMcFAuXCwWFm9qa3n3y8pMUKffEjbxvh/JJ7urpQIiUeu?=
 =?us-ascii?Q?KY4X3ERLBJkF5vkiJNyt2sNFkVuW2ro750EN4qPSOp60xgHHLMUkSEuvxY39?=
 =?us-ascii?Q?mBr34dBW0//dXsZkQEmScNfsNPtW1+Vu8iZ31tIEfC9bPaRW+lRQqtnGK6Mw?=
 =?us-ascii?Q?DNA7CVSVhyV10AjGxuk+K6tcCTqDICjPE2afHSU63EH9LkHRsQHr9m+TGZvW?=
 =?us-ascii?Q?0h0GxUE2YMtf50YQjKmatrJ0KW3n6RZh3X5yonkKrpa1iH7EiiwAarM7E+9l?=
 =?us-ascii?Q?Xvvo5icnjVo1lt7oyHHmjocKe4XvDo9+S9z1fB3QvvZFYgZ5pD9UcLHKnvIZ?=
 =?us-ascii?Q?dbB0LsoIq70OBHG5hNcWuTY8nl7pNrDgrpEfGN5qZg5JY1j8RRxHf5Z1XYWp?=
 =?us-ascii?Q?cLJsXzz0OU3xpQqxMxXrrk7hCj+Y7VLINnG/fNdvCniJ1TLeDGI6YVDTAUZB?=
 =?us-ascii?Q?iosYnRClmG8Kb/jXTLV7WTdZzjByCXuDzDgwxgd7Nn+/V2KtLIQwbXA4jthM?=
 =?us-ascii?Q?hcSoA9IKGyZZ/+hmzjY6oXclKnDfOQ0jafq4FSp179sz7a460CErKyJ9m/sj?=
 =?us-ascii?Q?mCg7jBl58vOSUbwut0CkMCHlNR1xYuiHY1aQQS7jPOxAICKiDQQOY/tsVxWo?=
 =?us-ascii?Q?dCwF8Mz/z0o3///2KilfTihUyl4yoB7wZeghZIQKq6meNfqKY9+XzydHV5uw?=
 =?us-ascii?Q?bxPCf9wYfVNB7We52eUq5Fv3Xg2KakmdNYIhHEK84Tiq7fxs3LLL/n4kF+m5?=
 =?us-ascii?Q?Gb+VcK5F5tMw0EjDmDRyyRj7dURAStUjyTCENSHd8K8HRusXYS/Yvhs32tCC?=
 =?us-ascii?Q?HSzZlkkwxOh8KtgG4XFXZ/DePa9sAu5sB8JYA5DQRv8vm5R/dBtqcN5eurqt?=
 =?us-ascii?Q?hFDk0SDG02Aj+ShahbNa/awfHFPnr1WQx8ENpm57fOxYM2ibRbEu6cQYxixk?=
 =?us-ascii?Q?WSHQVrIBNHwkpoTrYvOf2H31p7M0BL4QxXT7QKVoTBBF7jCj569ygcUabPVy?=
 =?us-ascii?Q?12b6vXMReNq2V41bQzb1OlqsQoPOhr+uekMgjpIUPiuwwpz3SArP28RZgq09?=
 =?us-ascii?Q?/cwS2aVYA/BLGcNqBX0xX54PRkw74dnp3aT3/0OzIGAI/9jXjMf9igJttNmb?=
 =?us-ascii?Q?7wXPvBbe+b4zjIE9OOXIP3QclfMLtOQzzvI0iB0ZmWaZzanHpefoSwXv6zbt?=
 =?us-ascii?Q?VBR24Y02LLdjgGDWg+tNd3qIgvSS2BLZE+IhpZOKdKh04rqLpOpd/DneDszS?=
 =?us-ascii?Q?RBl3tfXGK7crq1s92G/434UWXYe5ROmt7DUYRZXl4W5/j/Rk1+gDy6B8T+bv?=
 =?us-ascii?Q?T4VtC2iz0ySbys1yYA+vPa8f6K9+05h9O20Ml3opEsRXFDbW9axnpy1Suq8X?=
 =?us-ascii?Q?38IlF0G13w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32935d27-eca1-45ed-8e3a-08de84d68bab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:10:13.5448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAe3wqh/rgw11xQaYJHjeFHiEdyg1gofmIocac8ruOpWH5bYK6LOYz9UawOAZv4CaUr5ysykFJ/UrsGnrxAalw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11744
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268957-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 896B62B9B44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The latest MC firmware version added a new command to retrieve all DPMAC
counters in a single firmware call. Use this new command, when possible,
in dpaa2-mac as well.

In order to use the dpmac_get_statistics() API, two DMA memory areas are
used: one to transmit what counters the driver is requesting and one to
receive the values of those counters. These memory areas are allocated
and DMA mapped at probe time so that we don't waste time at runtime.

And since we are planning to add rmon, eth-ctrl and other standard
statistics using the same infrastructure, make the setup and cleanup
processes as generic as possibile through the dpaa2_mac_setup_stats()
and dpaa2_mac_clear_stats() functions.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- use dma_alloc_noncoherent() instead of kcalloc + dma_map_single
- reduce the number of lines that have more than 80 chars
Changes in v2:
- fix fallback usecase by using dpaa2_mac_ethtool_stats[i].id
- use the __le32/__le64 types for cnt_idx, cnt_values etc

 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 199 ++++++++++++++----
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  10 +-
 2 files changed, 169 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index 422ce13a7c94..2ac023d54531 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2019 NXP */
+/* Copyright 2019, 2024-2026 NXP */
 
 #include <linux/acpi.h>
 #include <linux/pcs-lynx.h>
@@ -15,7 +15,119 @@
 #define DPMAC_PROTOCOL_CHANGE_VER_MAJOR		4
 #define DPMAC_PROTOCOL_CHANGE_VER_MINOR		8
 
+#define DPMAC_STATS_BUNDLE_VER_MAJOR		4
+#define DPMAC_STATS_BUNDLE_VER_MINOR		10
+
 #define DPAA2_MAC_FEATURE_PROTOCOL_CHANGE	BIT(0)
+#define DPAA2_MAC_FEATURE_STATS_BUNDLE		BIT(1)
+
+struct dpmac_counter {
+	enum dpmac_counter_id id;
+	const char *name;
+};
+
+#define DPMAC_UNSTRUCTURED_COUNTER(counter_id, counter_name)	\
+	{							\
+		.id = counter_id,				\
+		.name = counter_name,				\
+	}
+
+static const struct dpmac_counter dpaa2_mac_ethtool_stats[] = {
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ALL_FRAME,  "[mac] rx all frames"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_GOOD_FRAME,  "[mac] rx frames ok"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ERR_FRAME, "[mac] rx frame errors"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_DISCARD, "[mac] rx frame discards"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_UCAST_FRAME, "[mac] rx u-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_BCAST_FRAME, "[mac] rx b-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_MCAST_FRAME, "[mac] rx m-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_64, "[mac] rx 64 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_127, "[mac] rx 65-127 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_255, "[mac] rx 128-255 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_511, "[mac] rx 256-511 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1023, "[mac] rx 512-1023 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1518, "[mac] rx 1024-1518 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1519_MAX, "[mac] rx 1519-max bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAG, "[mac] rx frags"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_JABBER, "[mac] rx jabber"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ALIGN_ERR, "[mac] rx align errors"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_OVERSIZED, "[mac] rx oversized"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_VALID_PAUSE_FRAME, "[mac] rx pause"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_BYTE, "[mac] rx bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_GOOD_FRAME, "[mac] tx frames ok"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_UCAST_FRAME, "[mac] tx u-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_MCAST_FRAME, "[mac] tx m-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_BCAST_FRAME, "[mac] tx b-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_ERR_FRAME, "[mac] tx frame errors"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_UNDERSIZED, "[mac] tx undersized"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_VALID_PAUSE_FRAME, "[mac] tx b-pause"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_BYTE, "[mac] tx bytes"),
+};
+
+#define DPAA2_MAC_NUM_ETHTOOL_STATS	ARRAY_SIZE(dpaa2_mac_ethtool_stats)
+
+static void dpaa2_mac_setup_stats(struct dpaa2_mac *mac,
+				  struct dpaa2_mac_stats *stats,
+				  size_t num_stats,
+				  const struct dpmac_counter *counters)
+{
+	struct device *dev = mac->net_dev->dev.parent;
+	size_t size_idx, size_values;
+	__le32 *cnt_idx;
+
+	size_idx = num_stats * sizeof(__le32);
+	stats->idx_dma_mem = dma_alloc_noncoherent(dev, size_idx,
+						   &stats->idx_iova,
+						   DMA_TO_DEVICE,
+						   GFP_KERNEL);
+	if (!stats->idx_dma_mem)
+		goto out;
+
+	size_values = num_stats * sizeof(__le64);
+	stats->values_dma_mem = dma_alloc_noncoherent(dev, size_values,
+						      &stats->values_iova,
+						      DMA_FROM_DEVICE,
+						      GFP_KERNEL);
+	if (!stats->values_dma_mem)
+		goto err_alloc_values;
+
+	cnt_idx = stats->idx_dma_mem;
+	for (size_t i = 0; i < num_stats; i++)
+		*cnt_idx++ = cpu_to_le32((u32)(counters[i].id));
+
+	dma_sync_single_for_cpu(dev, stats->idx_iova,
+				num_stats * sizeof(__le32),
+				DMA_TO_DEVICE);
+
+	return;
+
+err_alloc_values:
+	dma_free_noncoherent(dev, num_stats * sizeof(u32), stats->idx_dma_mem,
+			     stats->idx_iova, DMA_TO_DEVICE);
+out:
+	stats->idx_dma_mem = NULL;
+	stats->values_dma_mem = NULL;
+}
+
+static void dpaa2_mac_clear_stats(struct dpaa2_mac *mac,
+				  struct dpaa2_mac_stats *stats,
+				  size_t num_stats)
+{
+	struct device *dev = mac->net_dev->dev.parent;
+
+	if (stats->idx_dma_mem) {
+		dma_free_noncoherent(dev, num_stats * sizeof(u32),
+				     stats->idx_dma_mem,
+				     stats->idx_iova, DMA_TO_DEVICE);
+		stats->idx_dma_mem = NULL;
+	}
+
+	if (stats->values_dma_mem) {
+		dma_free_noncoherent(dev, num_stats * sizeof(u32),
+				     stats->values_dma_mem,
+				     stats->values_iova, DMA_FROM_DEVICE);
+		stats->values_dma_mem = NULL;
+	}
+}
 
 static int dpaa2_mac_cmp_ver(struct dpaa2_mac *mac,
 			     u16 ver_major, u16 ver_minor)
@@ -32,6 +144,10 @@ static void dpaa2_mac_detect_features(struct dpaa2_mac *mac)
 	if (dpaa2_mac_cmp_ver(mac, DPMAC_PROTOCOL_CHANGE_VER_MAJOR,
 			      DPMAC_PROTOCOL_CHANGE_VER_MINOR) >= 0)
 		mac->features |= DPAA2_MAC_FEATURE_PROTOCOL_CHANGE;
+
+	if (dpaa2_mac_cmp_ver(mac, DPMAC_STATS_BUNDLE_VER_MAJOR,
+			      DPMAC_STATS_BUNDLE_VER_MINOR) >= 0)
+		mac->features |= DPAA2_MAC_FEATURE_STATS_BUNDLE;
 }
 
 static int phy_mode(enum dpmac_eth_if eth_if, phy_interface_t *if_mode)
@@ -504,6 +620,11 @@ int dpaa2_mac_open(struct dpaa2_mac *mac)
 	mac->fw_node = fw_node;
 	net_dev->dev.of_node = to_of_node(mac->fw_node);
 
+	if (mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE)
+		dpaa2_mac_setup_stats(mac, &mac->ethtool_stats,
+				      DPAA2_MAC_NUM_ETHTOOL_STATS,
+				      dpaa2_mac_ethtool_stats);
+
 	return 0;
 
 err_close_dpmac:
@@ -515,66 +636,66 @@ void dpaa2_mac_close(struct dpaa2_mac *mac)
 {
 	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
 
+	if (mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE)
+		dpaa2_mac_clear_stats(mac, &mac->ethtool_stats,
+				      DPAA2_MAC_NUM_ETHTOOL_STATS);
+
 	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
 	if (mac->fw_node)
 		fwnode_handle_put(mac->fw_node);
 }
 
-static char dpaa2_mac_ethtool_stats[][ETH_GSTRING_LEN] = {
-	[DPMAC_CNT_ING_ALL_FRAME]		= "[mac] rx all frames",
-	[DPMAC_CNT_ING_GOOD_FRAME]		= "[mac] rx frames ok",
-	[DPMAC_CNT_ING_ERR_FRAME]		= "[mac] rx frame errors",
-	[DPMAC_CNT_ING_FRAME_DISCARD]		= "[mac] rx frame discards",
-	[DPMAC_CNT_ING_UCAST_FRAME]		= "[mac] rx u-cast",
-	[DPMAC_CNT_ING_BCAST_FRAME]		= "[mac] rx b-cast",
-	[DPMAC_CNT_ING_MCAST_FRAME]		= "[mac] rx m-cast",
-	[DPMAC_CNT_ING_FRAME_64]		= "[mac] rx 64 bytes",
-	[DPMAC_CNT_ING_FRAME_127]		= "[mac] rx 65-127 bytes",
-	[DPMAC_CNT_ING_FRAME_255]		= "[mac] rx 128-255 bytes",
-	[DPMAC_CNT_ING_FRAME_511]		= "[mac] rx 256-511 bytes",
-	[DPMAC_CNT_ING_FRAME_1023]		= "[mac] rx 512-1023 bytes",
-	[DPMAC_CNT_ING_FRAME_1518]		= "[mac] rx 1024-1518 bytes",
-	[DPMAC_CNT_ING_FRAME_1519_MAX]		= "[mac] rx 1519-max bytes",
-	[DPMAC_CNT_ING_FRAG]			= "[mac] rx frags",
-	[DPMAC_CNT_ING_JABBER]			= "[mac] rx jabber",
-	[DPMAC_CNT_ING_ALIGN_ERR]		= "[mac] rx align errors",
-	[DPMAC_CNT_ING_OVERSIZED]		= "[mac] rx oversized",
-	[DPMAC_CNT_ING_VALID_PAUSE_FRAME]	= "[mac] rx pause",
-	[DPMAC_CNT_ING_BYTE]			= "[mac] rx bytes",
-	[DPMAC_CNT_EGR_GOOD_FRAME]		= "[mac] tx frames ok",
-	[DPMAC_CNT_EGR_UCAST_FRAME]		= "[mac] tx u-cast",
-	[DPMAC_CNT_EGR_MCAST_FRAME]		= "[mac] tx m-cast",
-	[DPMAC_CNT_EGR_BCAST_FRAME]		= "[mac] tx b-cast",
-	[DPMAC_CNT_EGR_ERR_FRAME]		= "[mac] tx frame errors",
-	[DPMAC_CNT_EGR_UNDERSIZED]		= "[mac] tx undersized",
-	[DPMAC_CNT_EGR_VALID_PAUSE_FRAME]	= "[mac] tx b-pause",
-	[DPMAC_CNT_EGR_BYTE]			= "[mac] tx bytes",
-};
-
-#define DPAA2_MAC_NUM_STATS	ARRAY_SIZE(dpaa2_mac_ethtool_stats)
-
 int dpaa2_mac_get_sset_count(void)
 {
-	return DPAA2_MAC_NUM_STATS;
+	return DPAA2_MAC_NUM_ETHTOOL_STATS;
 }
 
 void dpaa2_mac_get_strings(u8 **data)
 {
 	int i;
 
-	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++)
-		ethtool_puts(data, dpaa2_mac_ethtool_stats[i]);
+	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++)
+		ethtool_puts(data, dpaa2_mac_ethtool_stats[i].name);
 }
 
 void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
 {
+	struct device *dev = mac->net_dev->dev.parent;
 	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
+	__le64 *cnt_values;
 	int i, err;
 	u64 value;
 
-	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++) {
+	if (!(mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE))
+		goto fallback;
+
+	if (!mac->ethtool_stats.idx_dma_mem ||
+	    !mac->ethtool_stats.values_dma_mem)
+		goto fallback;
+
+	err = dpmac_get_statistics(mac->mc_io, 0, dpmac_dev->mc_handle,
+				   mac->ethtool_stats.idx_iova,
+				   mac->ethtool_stats.values_iova,
+				   DPAA2_MAC_NUM_ETHTOOL_STATS);
+	if (err)
+		goto fallback;
+
+	dma_sync_single_for_cpu(dev, mac->ethtool_stats.values_iova,
+				DPAA2_MAC_NUM_ETHTOOL_STATS * sizeof(u64),
+				DMA_FROM_DEVICE);
+
+	cnt_values = mac->ethtool_stats.values_dma_mem;
+	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++)
+		*(data + i) = le64_to_cpu(*cnt_values++);
+
+	return;
+
+fallback:
+
+	/* Fallback and retrieve each counter one by one */
+	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++) {
 		err = dpmac_get_counter(mac->mc_io, 0, dpmac_dev->mc_handle,
-					i, &value);
+					dpaa2_mac_ethtool_stats[i].id, &value);
 		if (err) {
 			netdev_err_once(mac->net_dev,
 					"dpmac_get_counter error %d\n", err);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
index 53f8d106d11e..6f4981627961 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2019 NXP */
+/* Copyright 2019, 2024-2026 NXP */
 #ifndef DPAA2_MAC_H
 #define DPAA2_MAC_H
 
@@ -11,6 +11,12 @@
 #include "dpmac.h"
 #include "dpmac-cmd.h"
 
+struct dpaa2_mac_stats {
+	__le32 *idx_dma_mem;
+	__le64 *values_dma_mem;
+	dma_addr_t idx_iova, values_iova;
+};
+
 struct dpaa2_mac {
 	struct fsl_mc_device *mc_dev;
 	struct dpmac_link_state state;
@@ -28,6 +34,8 @@ struct dpaa2_mac {
 	struct fwnode_handle *fw_node;
 
 	struct phy *serdes_phy;
+
+	struct dpaa2_mac_stats ethtool_stats;
 };
 
 static inline bool dpaa2_mac_is_type_phy(struct dpaa2_mac *mac)
-- 
2.25.1


