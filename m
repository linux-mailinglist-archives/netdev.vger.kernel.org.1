Return-Path: <netdev+bounces-269463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KaVArkJvGkArgIAu9opvQ
	(envelope-from <netdev+bounces-269463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:35:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F327C2CCEE7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93755306146C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81E2372B40;
	Thu, 19 Mar 2026 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XdhS+zMv"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0336F42C;
	Thu, 19 Mar 2026 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930247; cv=fail; b=PF3OvlY806nJ/tH6TCG8jpvOUTl8NXIjqntno76HI2fTMMh0EkYseRDjlMHP934tOIANmbSh2aul2RT2iZpOmzy9NPOt3XCSiw4mVYVsWnagdaawrGgvqINshkj4dmjzwMYohzUvSlBwql8eANKIpAmRpNU5lPmJvqQzCNkWMtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930247; c=relaxed/simple;
	bh=zzQTkG4ZDrI3COThC/yNxhtrLnTXvtFfWKvOg4AmUQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qNo4MhYl4KOqawg0BAd9nyEJo49C2Lmt+Lxt76ha+TojNPISryuevdQ6JSvCq34MHh7C4J9rEX0UJPR44Y+S1XEqyP0jVmotnlL2W0sPtUhFUpNYTNw9BiIP03V8T5dWO0cd+qAitFiXas7lNb3xcM/fTp5MIEgsBQ4CTrIzfKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XdhS+zMv; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLM3/hZbuvQI8IHBTnQqzSkrCeGZKfhnsWCKjRlZrBJgTtmHjR59ic6MAy/d8N7r5Fm73YiZgGiQAYaaeUZ/V9xuRZJkKQ7MHsuHxKQOVCNpDIYBm9BIPLGGBiyHi3et9KJltwhNVYqpzchRRlNuXJx6KI2TISBWYQfpJREJYL3DzU8xTn7IRwd/0P2I81csnQAgjdbPh+oqCv9qq9LKp98bYK/0BvUsTux0VPt4OE9soFcb1EJ2/7y23MLwJeC3sc4xvHyjBT3OEtpey61gR6P8582/mXSzOhyA3sVhgKNkE/CgQev5lquMuh88PFbM4uutKU+0lIJlD0N40j42lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHmeoXhjS9DZf8fzlBt7aPtU87+0qyl/+n3XnZiS4yc=;
 b=BeE08UZ0t4llRIzDMPHWiGV6qUD5+rqmkkh+pRiJYs0lnHKcbndUvUs2iGuEVVvlJxDgz3d2ihYcjf6jKlBtJdk5B9N/2zSsjWNa0mz599CuLPUO1Vo9y9Qdf078kOT3v9uXUbBfXs7VtTqQsxW7sTSPIWIxej+61usX70xzKzIRu0DDX87vkj7MrlmYZA2oDA/mwylHUd7sAaEQRH3AbdBWX0pPTmb1vXg2f5DuVo17cmpqkhi1NQtIJgHFCRjcv/BtkVT4HiRAxSApJtMcwiXrjPnEZ/LTdvZGsh17pXsVoyEGHaCBBiLRb8KS7lsR4K9o0Ek1+qy0gj+M2KZv8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHmeoXhjS9DZf8fzlBt7aPtU87+0qyl/+n3XnZiS4yc=;
 b=XdhS+zMv8CgGsaJyUtbu0Kpc2WDr3dwJRQQNJZLY9T868vENljO9K1da4Ine/SaGybVH7Eua4D+Q/mSpYk54JnHQKQFPyQSLBS0vaI0OhsNF1lu6T3c8S8KKt9Y3fWiWSdZcph9ZGHVjR4kTAV8DID4pL3SYG8kqpRc+qSYMHyIA0oIquQwvSkmN27Ead/W1ObmqRtD2MRBIwU4ADVUF43lnTVoetXWUVVV8Q7omgCi0i6b12ZuinJRECAcLnphcJeg2ELdFX3WQ3DH4O46iQ3kdfDM+3hP+TWrWJcNw77ebzXwytcA4KhLZ85EBTw/Ah0QM9elOFwit+eNQQP1JQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PR3PR04MB7449.eurprd04.prod.outlook.com (2603:10a6:102:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 14:23:53 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 14:23:59 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/3] net: dpaa2-mac: retrieve MAC statistics in one firmware command
Date: Thu, 19 Mar 2026 16:23:45 +0200
Message-Id: <20260319142346.2483232-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319142346.2483232-1-ioana.ciornei@nxp.com>
References: <20260319142346.2483232-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::30) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PR3PR04MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: fad67470-17da-44e8-ff86-08de85c3295c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	S1Co1Jcpu4ngss6YNVX4JZSn7m+2g6IYq5ahao+x/7Tz2t9+kfaIAucUYgOIqhFL3gCj12XT6R5+T+++QGU0GvHKjjWMtGlEUopOvYPiJYVHTe7KLIsB7aDgwlMgTbjb5RrK8m5RxvYi85xufOde/iL990ZuWShxKd3mBUo67G5R3Ef4HZSV7QUmW3AXSg0AEaL1rniFupet5rVTwzUj09JfQCg6lj8m/0fmBip5UQV8ZMdGbdcqSJRiux+ksZpWD/fjwfz5KWSFF48RlXNsP4/S9A6JyZCDQVkcRIzoMcSB19ALkNjU0ce5Q3WiB5MRSNbQ8nbnDN25FaHKMltD+ilyniBIL7UTe8sntexaQn7bgL1lDJmf8g/tATLvocDt0JlLnm80UNcFK19ey2tp1RB6MBVVceIIW+MCUulFlBDC+pJiWdwTI+jPIwrRXYlyYYU1L2+LofOtY5L6H+A4oGTrL3roh2iV20yknmGHm5iQO9jgU/0VI5BJ7WGsd9ozBv1vBFO4E47G93RJWxRFuSAskbnJKg2IzprytLvnt1Vh6CLvVTkuSYyBketr3YA8jy93AvpSgwZ4g8ly9aL3TMizDKhLcyrnI+NONXyco0F0WzX3GiYJObT9gH771VsSJqaaXUErWjNXRu0u1xXZqboidD4CWr/MfkZ8IBmNHs6jc9QL70tclDxZBJh6KcfrkFTUBeWgmR5uXibA+VZxed6TQE8FE6aW+AhmER1tRls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m8+F9tQ5cSSFASRXJ6jdZcFAeM6K6DUHWiMpIr7+dYvCaD8IMB53kHpj/uai?=
 =?us-ascii?Q?LhlvJZDEtpbpsyb/aHh889Dkcae+ASskvOWsaVJvqbdyw9YgzfmWLRUyaOkn?=
 =?us-ascii?Q?Vc8xuJCLKybK2mCAKqSsmS6Lov8hMBiUckmiL57X9F8OsUvuRw+YrTE0qocw?=
 =?us-ascii?Q?2xsf7oAcg8i0ZjOD4sa2Zp3pOC53Gj9Pwxp/hjvXZ0Hqa0ufQ4sRz6BtV+Nq?=
 =?us-ascii?Q?xh8+yxJSJTvRLhOWAFc8fEmrFn+2n2YVJSzltk8uRgdhSobYdzab5TlrcTcv?=
 =?us-ascii?Q?+L8Erl7Gi9JOC8qsQyAVpuVRFvXGaQrl5K9G27nZenkcAsWIn9S1VESyV6N+?=
 =?us-ascii?Q?C0Q/4IGGIHypZCZVOSXpodYdkJ9VtB87LCT7lNGU9pn2aEJbbsEsr9naljFL?=
 =?us-ascii?Q?36wyuHE8pb/K9tcWCVClZr+Smn+Ilxqna6pM1cAaGx+jVEBXxKeHuhIqC9dJ?=
 =?us-ascii?Q?sVpVMLKOf6Guh0se6Y/XrfXXLRgcKAEsfd3o5Wuyc3FYfI7Ed6AuHNAvYIYO?=
 =?us-ascii?Q?CYlO/bMCxp0TJibxUF72imnTd9woD+ubCa9fzzWlYjzDKox3anaMWbILq850?=
 =?us-ascii?Q?/9PdPQEpEMtt5BOQS/39kRotk3CE2ury8jkWUyU9jrF6xrBc5aP+OFDPF5yW?=
 =?us-ascii?Q?UBUbUu08VpvLoTHMZEcMCtl3VPpmKy0uzTtUVtIu1T5mC9+d13Kluu81012Q?=
 =?us-ascii?Q?kp1XFc7IHtWSmpp+PFfNAXptNc3w/21FD3Dri0f7myxbPN7rXN6yZ1x48K4i?=
 =?us-ascii?Q?rb6pSacRwXw0G5f4501BtwO43OT27jXjDH+9yKksnIpPu5a82Q+xhCENEi3W?=
 =?us-ascii?Q?Ef9EtiEKneikyyZwEE5a3Vy3vSoCMJ3fKSpJfhFoU+tI5EJqOT/zXG8qpDa/?=
 =?us-ascii?Q?AhuioXuQeMbY83keSEDD0dyQi4omJeYgsnBOl6dBsMazyKvZ7/s1AFXNLBdW?=
 =?us-ascii?Q?OtpbV+jhGJBvPIccufD38PQTDVuIa01XsZAYNsz8SmKAHkY7HCpstLCjXcuy?=
 =?us-ascii?Q?oZAx532fqAk1sXObOIamp4V81OtF2XaJkFfhlanzFJ+HjmrXcIWTupaCTkW7?=
 =?us-ascii?Q?eHKfMOD6ty5mLgmE3wpcesOzt8pMRoXD19b1YhwNqrltVUnvps3PgcDOfgQB?=
 =?us-ascii?Q?+weha47XbtPKV1j8p2hw9rfpzqZT9Vv3uHOCDB03sC30GQTp+uS9I0gp74oq?=
 =?us-ascii?Q?9/rgg2C2rTTdI8B4rbC9B5izVtRpag9DoZPShNqGvqV8BtyrXcgijBUYOSJ8?=
 =?us-ascii?Q?u5gKXaN3516Qalggo2tjCKE7vh+ZwsHNB186k6CEarS0X0S9lBJwO9cQxIEz?=
 =?us-ascii?Q?ssoCVUrJT2xFi2Su+12n7wQsKIBJtED2GSOIgHiWAXguPk4OW4VZrXQD8OS0?=
 =?us-ascii?Q?6W3CGChPSYDifwEhWJuvs+tKsAR6h3kxPNWiUsA0Psy+lcoSVTnpVVT3BLHF?=
 =?us-ascii?Q?8No/hY5tgJe0nq+9sA1X7zCGKQ5a63DvvXY+CoaXnsAZwjiz4NxGjqd9M8sO?=
 =?us-ascii?Q?FcDt5gm1jLhgNn3LpFcvgrAehK6GTSV12RZTrRcFdEo2QEYHXY51cGna3tIQ?=
 =?us-ascii?Q?QjCy6r323bzmtJyClDPBov+byi2jXg5UEQ7uk51zhqMmrlBXjCmsW+k5kzdW?=
 =?us-ascii?Q?1AH5/AecSBmalY5YfsufyIRJFjUXN0MZeadk/JEBUOkGg8mRxRW6lc8KE7lD?=
 =?us-ascii?Q?qzIjxqafYXealdtTV2u4GGUKeY/uqfm4RIyy/o/h9tPY3zbnKsdqpEqEVOM3?=
 =?us-ascii?Q?AJoL49Cy/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad67470-17da-44e8-ff86-08de85c3295c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 14:23:59.3421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAcaIcDDWN4y8gCBoqEtTYd9VSbwfs3fQ/xGllZ+jPJPcWg5H7B/RulA7AgvuujwvrZyNALH1J2R/4WRFanR+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7449
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269463-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.965];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F327C2CCEE7
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
Changes in v4:
- fix dma_sync call and memory leak in the cleanup
Changes in v3:
- use dma_alloc_noncoherent() instead of kcalloc + dma_map_single
- reduce the number of lines that have more than 80 chars
Changes in v2:
- fix fallback usecase by using dpaa2_mac_ethtool_stats[i].id
- use the __le32/__le64 types for cnt_idx, cnt_values etc

 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 201 ++++++++++++++----
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  10 +-
 2 files changed, 171 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index 422ce13a7c94..5a7fda6a2012 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2019 NXP */
+/* Copyright 2019, 2024-2026 NXP */
 
 #include <linux/acpi.h>
 #include <linux/pcs-lynx.h>
@@ -15,7 +15,118 @@
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
+	size_idx = num_stats * sizeof(u32);
+	stats->idx_dma_mem = dma_alloc_noncoherent(dev, size_idx,
+						   &stats->idx_iova,
+						   DMA_TO_DEVICE,
+						   GFP_KERNEL);
+	if (!stats->idx_dma_mem)
+		goto out;
+
+	size_values = num_stats * sizeof(u64);
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
+	dma_sync_single_for_device(dev, stats->idx_iova, size_idx,
+				   DMA_TO_DEVICE);
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
+		dma_free_noncoherent(dev, num_stats * sizeof(u64),
+				     stats->values_dma_mem,
+				     stats->values_iova, DMA_FROM_DEVICE);
+		stats->values_dma_mem = NULL;
+	}
+}
 
 static int dpaa2_mac_cmp_ver(struct dpaa2_mac *mac,
 			     u16 ver_major, u16 ver_minor)
@@ -32,6 +143,10 @@ static void dpaa2_mac_detect_features(struct dpaa2_mac *mac)
 	if (dpaa2_mac_cmp_ver(mac, DPMAC_PROTOCOL_CHANGE_VER_MAJOR,
 			      DPMAC_PROTOCOL_CHANGE_VER_MINOR) >= 0)
 		mac->features |= DPAA2_MAC_FEATURE_PROTOCOL_CHANGE;
+
+	if (dpaa2_mac_cmp_ver(mac, DPMAC_STATS_BUNDLE_VER_MAJOR,
+			      DPMAC_STATS_BUNDLE_VER_MINOR) >= 0)
+		mac->features |= DPAA2_MAC_FEATURE_STATS_BUNDLE;
 }
 
 static int phy_mode(enum dpmac_eth_if eth_if, phy_interface_t *if_mode)
@@ -504,6 +619,11 @@ int dpaa2_mac_open(struct dpaa2_mac *mac)
 	mac->fw_node = fw_node;
 	net_dev->dev.of_node = to_of_node(mac->fw_node);
 
+	if (mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE)
+		dpaa2_mac_setup_stats(mac, &mac->ethtool_stats,
+				      DPAA2_MAC_NUM_ETHTOOL_STATS,
+				      dpaa2_mac_ethtool_stats);
+
 	return 0;
 
 err_close_dpmac:
@@ -515,66 +635,69 @@ void dpaa2_mac_close(struct dpaa2_mac *mac)
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
+	size_t values_size = DPAA2_MAC_NUM_ETHTOOL_STATS * sizeof(u64);
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
+	dma_sync_single_for_device(dev, mac->ethtool_stats.values_iova,
+				   values_size, DMA_FROM_DEVICE);
+
+	err = dpmac_get_statistics(mac->mc_io, 0, dpmac_dev->mc_handle,
+				   mac->ethtool_stats.idx_iova,
+				   mac->ethtool_stats.values_iova,
+				   DPAA2_MAC_NUM_ETHTOOL_STATS);
+	if (err)
+		goto fallback;
+
+	dma_sync_single_for_cpu(dev, mac->ethtool_stats.values_iova,
+				values_size, DMA_FROM_DEVICE);
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


