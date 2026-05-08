Return-Path: <netdev+bounces-285651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP1xHsl7/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:59:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C0B4F22F3
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2971C30B7A1E
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6616534F275;
	Fri,  8 May 2026 05:38:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2123.outbound.protection.partner.outlook.cn [139.219.146.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA25D3563F6;
	Fri,  8 May 2026 05:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218720; cv=fail; b=jHisqr8Kyi0ErQC+ACIZ7+GIKqeVn291twOM0SRxIweFyRqr6+3dFXDhBA0Hb/tja8qqkMgDLRkaRJcv7qDWkXxTPa1GfpVmf1vcC5UDECD4m2AH/h4cvJh0+JjYhxWuKVRv9wgAF3oQEqGRA3fypFA83Cl/qVIxsvEL3pyYxew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218720; c=relaxed/simple;
	bh=VDHw1yuptuTvuG+lgw7aWTZra4WdM5zpn+sblfJCvlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GwTbszYnT30NLAl4kCn4+JBilElDQcWmpX+MsKUDIUPcrDy09lO5ed+mofY68kLxIxZ7+rj7kqlA5nxJB1JWiO6b0kJ5iaZFi3wKDXOsNmW8fptK4kvNc6eOgUgtKJz8WKFmTR+9XLM125FjdVyT7FR6LmxwjV5fK5L88CjRydw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5lk5j/ROwc4W+9HyUPzNOODYpFoxt1rh55GQVqGCx5ijsDQUrQDfI+vZVk6IeRLCUtfdRqL7s0WBQByrqAyImMbAoFsSRviQB0mvJ+kscR+BKJ+zbIJQ5fTCDynIU3T1me1Iy8JUb6dFEAsL5ugXgPof47fy6JFAPJEvH5RQAQhB4CDyZO3t0IeoaSWGIREn3nV8Aj1ka79SHU9zKwyVHC4EvAIgPWrFeItEebtwodTQ32X0cV0qRAWdpqFi96ljv8p5Y7dqDVeacKr5doKVfl64GofMihwU+VJPAthT1LqPak2Irrxp+KQZYKIByN4jhSsAhDsctYc0TKP3IcdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KobOeeTAwSKzXJAAxaij6p1R7/C3MyE0PAfEJ79AusQ=;
 b=gX6Y0+R4z9KrFRnjq5PjELRu5We2KcDJaj0TkBjkUR76MwbzIDB7GJ0SbwJgQ7PUvOWfxxOpTWlzEuYi9z/vkIn3DnID8nF3j0oLTdO6r7iye9ZQYHSW4AkJAikf4pt5Dp0jRaQZxPZjvlxG62ETPC7sEOm2yMN43pCTMvovgKq30t6NixTEK59bGljTF1Ml/s/WXstmPJLSz1NbKsLgH0y0ZYMsqGI4e/HlDCX7M3iWJhtkw6Aj0RAXq1gF5m0lkY2xiEj2xXriM2ivlvrQNL5oUoOdfl/3FpaWwRsbLeJzFdnfLanvOcvWCWapgKC3pB1NsRCRJ39UYp9Q6GQJhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 05:37:07 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:37:07 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 15/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-1 clock and reset generator
Date: Thu,  7 May 2026 22:36:25 -0700
Message-Id: <20260508053632.818548-16-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
References: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::12) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1267:EE_
X-MS-Office365-Filtering-Correlation-Id: 23cbb43a-bf49-4faf-65a9-08deacc3d802
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|56012099003|38350700014|921020|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3b9WW4zwstUSPFCRfGU4kBVKymNsGONt6qjqJtXKNJ3koP8hs1U48nPez4isLsh7opjvuzUGvuiAsrAazDeFdwJmrKqOe9qweQUJAZIeVBCo2WXEtm6SeRNw2FNVOdGMMsIFKBqQPRcpcAEAEERYkV2bgwumKJJhssuir/zbGYq6+V1ityjeqaguEzS+FcoT0rihvO+urA9kgDqxDYWNIcn9gG5VUe4a0UT3tUxxS1sXmzZl6l5I+gKKqvVc9RgxVbD1j1jxnw9c5IYdfa9zE3ndqbmTj1YCYL9hJJHGdRu702Yfha4/9a8ErN2ZVCeJS9CzN+zImVKL1ujemooLvSS7+51j/z1+CdheL3UuhDp7aKFsh0jjE7bmWQ3ZRVnwUVpJmp0AeZRydAXozEmqltWIrikYnA5Jl5vaYo/cIiN1B+2WFy/NGcyoe+cKaLnx1g6bPwABOctiUVEraqt6ZgZ8UVQV2pMxsAlIKAD+IRrjks377KZoYPhP+WA80ibn3YyeytNU2gW0lCBtbwlhRTYzEwMTEkH4DBhqD5TJW972eMH1N+/w4tkTlxwjPQNgAlXBHDGswnhVWzbWFr6tQg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(56012099003)(38350700014)(921020)(3023799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VxYrPdM9IMn6vcVjMKnLBrB2H2bjQSEvcQilt3IZaBxOB66r6xukq2yhG2Ym?=
 =?us-ascii?Q?udizbOHWFyHxPtHbhwxMN2kqYmlqCj9xUM520Y11WB1OAt+kPiqs0bnT4jMQ?=
 =?us-ascii?Q?csp6EiALgyk5YpLlpNpvFyPfGR8uhWKh0hZH4iJaIAqh5I0sojePMBTSbzna?=
 =?us-ascii?Q?/y6bTAmqJkbdnrCWVJuI+0+0MKKCFeTjfOARy2y2I2Z0PPV2gKXyUWA7cNpK?=
 =?us-ascii?Q?aTPqIbGfntZNso5fPqTxaEYtSfafozfsF4kWO55r8NMlCqhM9odXkR1nR3i3?=
 =?us-ascii?Q?o67iJHZMFnztZWEWaAbDxOrW8t6EM6EUgS8yPNc1xjfW75zeMQRngLwmd+BM?=
 =?us-ascii?Q?gepltI8Blj5H/cL2D49krYxHj3aphLwWX4txQg6d+Zzm00ZzC9v9d9CuZEvG?=
 =?us-ascii?Q?T9B3NoEGoWShDGZLyUXS/hflFB/j+BG5T4bXj2s/YySzuSW4yHZR6iPTArsw?=
 =?us-ascii?Q?v6JQ2l9nItIIwUQJwhokwkT/SVQEZw/xKqX/qKe3FSUQbQFYqr4M8LjHYAox?=
 =?us-ascii?Q?BtJJHlHaFkKWnhmHaX1Lf5ILxMQRDvTZaAi7CQQyobCQ5QoNjfjEiUyiEDZJ?=
 =?us-ascii?Q?NNqnKqC3qjTfVrn+KaqVP5W0WDjFOnFnCUlymDBt3nN/5uMC5uDDMUP44FRL?=
 =?us-ascii?Q?j5aXvHy27Glu00pP/jNfVyXKj4KWh7IrNUMGl8dG8AI6ow9K0WGl0XAC5Owi?=
 =?us-ascii?Q?l+H/lUBzEvOq7Xr7bsSK1UP9GYF8lYKLsY5XWqpmYnySzTb2XZWfSaHTCUeV?=
 =?us-ascii?Q?PrThHm4YAUjl960wtzbPNrPxhmYqeoWzj7c9v5V1pJIwwNIscS+wKG0hUyPm?=
 =?us-ascii?Q?Yr4DY9KZkPtU+rVzXInDVGDwFlARYpKveyJ3QTgI/X/NewgWwDDXwgsEuur6?=
 =?us-ascii?Q?faV/t3aN0uWNSdKs1eQ77yKadXKnjTdjxizD/2ddZJa/PSY7G/llkG2MSS32?=
 =?us-ascii?Q?TW8V3hsSs99Lm7+4eXx6ecOwRKH4IPN741nRL0ucEQ23LLzJjyQe4pxZX8/S?=
 =?us-ascii?Q?+EB5tzd78RYjPL/6wMfwzyulJQO5qIygZizlWbdO/kVt8jfopU/l5HRwqfIc?=
 =?us-ascii?Q?JSmSoWeYGUdBWzePw66weKmUg+Y/ixuC0biKg026wliwojQ5rGWK0yxivqls?=
 =?us-ascii?Q?uju9o0IFF3Dwt27IIzGkiwAsiLos+sGbcfL0WNM6/1zLwq+jbDGsCOPHsics?=
 =?us-ascii?Q?0/BZalWMF5+F70H6w3CraQ3w8xQ1rJR3InPi7X8kdNulZ/hDBiACEPENdPWK?=
 =?us-ascii?Q?/ZHIPuW0XT3FJi+62QgWXC5cg2iGXqy4RkGmzO/IHwygWhZXp/8SaGvGnh7X?=
 =?us-ascii?Q?2yTiF005lGbhPbqiLNTBGhTLxfnw60K8SY+aUODGy7c8AQlfZAlWuCbujCcu?=
 =?us-ascii?Q?xp642HKGy8U+7la1MgyIrzG5mw7x/SRLxcuv5hfNOA9dzzt/WmdT2aotsPcl?=
 =?us-ascii?Q?Gg7KqqQUlnp1oBDHXywkk/rlXrV4guWApp3zHUgsxKj06OQ4zaayihVSc3G2?=
 =?us-ascii?Q?YxnK8gq2FVJD7VjugPwbIZaHc/btDc9BTzq7ZJxNowKqMrN1w8cj+YxF3XPR?=
 =?us-ascii?Q?5GMcvX9fDVv6AGXhibAiy4a81kK0mY1wzJT+zL6tXuMiXVFA1VHm+kh/a18H?=
 =?us-ascii?Q?45kVJXXtGuGKPIbqi1FZjqs17jzXb75RrCxpOrs/8St+sWW0H1Eji6a5CrNr?=
 =?us-ascii?Q?NiTfVNph73Yfg1zWaHajSuGHXfFSxjCl97ziEXJnb9xunJ2L4I92AfACfiDV?=
 =?us-ascii?Q?xTpEHwlvFBsavwtX8CJx2vUOm1jwfw0ooGa+TGQFCdNNYc7qEc4o?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cbb43a-bf49-4faf-65a9-08deacc3d802
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:37:07.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCKV1OirG6vCB3Ki0uPCogVvXfyCfIrsyFKFUbeU0Uhv6bDXYmkF/p1eQ4UKQBX9OYZmM7Gq5UYmEs1KAoVQ4M6BP/7vDxEjHxqFVrMlioA5FSdmtZnI6B9PsKRMxLwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267
X-Rspamd-Queue-Id: F3C0B4F22F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285651-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.781];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,11b40000:email]
X-Rspamd-Action: no action

Add bindings for the Peripheral-1 clock and reset generator (PER1CRG)
on the JHB100 RISC-V SoC by StarFive Ltd.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clock/starfive,jhb100-per1crg.yaml        | 70 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 60 ++++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 19 +++++
 3 files changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml
new file mode 100644
index 000000000000..3b3f7264e709
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-per1crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 Peripheral-1 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-per1crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PLL7
+      - description: Non Coherent NOC Initiator
+      - description: Configure 800MHz
+      - description: Non Coherent NOC Target
+      - description: Configure 143MHz
+
+  clock-names:
+    items:
+      - const: pll7
+      - const: ncnoc_init
+      - const: cfg_800
+      - const: ncnoc_targ
+      - const: cfg_143
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jhb100-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive-jhb100-crg.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@11b40000 {
+      compatible = "starfive,jhb100-per1crg";
+      reg = <0x11b40000 0x1000>;
+      clocks = <&pll7>,
+               <&sys0crg 68>,
+               <&sys0crg 69>,
+               <&sys2crg 19>,
+               <&sys2crg 22>;
+      clock-names = "pll7", "ncnoc_init",
+                    "cfg_800", "ncnoc_targ",
+                    "cfg_143";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index add2cd093dbd..7f508574177c 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -387,4 +387,64 @@
 #define JHB100_PER0CLK_MAIN_ICG_EN_SENSORS_DMAC		339
 #define JHB100_PER0CLK_MAIN_ICG_EN_TRNG			340
 
+/* PER1CRG clocks */
+#define JHB100_PER1CLK_100				0
+#define JHB100_PER1CLK_1				1
+#define JHB100_PER1CLK_200_DIVN0			2
+#define JHB100_PER1CLK_200_DIVN1			3
+#define JHB100_PER1CLK_200_DIVN2			4
+#define JHB100_PER1CLK_200_DIVN3			5
+#define JHB100_PER1CLK_200_CCLK_DIV			6
+
+#define JHB100_PER1CLK_SGPIO0_PCLK			15
+#define JHB100_PER1CLK_SGPIO0_DCLK			16
+#define JHB100_PER1CLK_SGPIO1_PCLK			17
+#define JHB100_PER1CLK_SGPIO1_DCLK			18
+
+#define JHB100_PER1CLK_EMMC0_BCLK			22
+
+#define JHB100_PER1CLK_EMMC0_CCLK			25
+
+#define JHB100_PER1CLK_DMAC1_1CH_CORE			29
+
+#define JHB100_PER1CLK_DMAC1_1CH_ACLK			31
+
+#define JHB100_PER1CLK_DMAC2_1CH_CORE			33
+
+#define JHB100_PER1CLK_DMAC2_1CH_ACLK			35
+
+#define JHB100_PER1CLK_DMAC3_1CH_CORE			37
+
+#define JHB100_PER1CLK_DMAC3_1CH_ACLK			39
+
+#define JHB100_PER1CLK_DMAC0_2CH_CORE			41
+
+#define JHB100_PER1CLK_DMAC0_2CH_ACLK			43
+
+#define JHB100_PER1CLK_UFS_REF				45
+#define JHB100_PER1CLK_UFS_300				46
+#define JHB100_PER1CLK_UFS_150				47
+#define JHB100_PER1CLK_UFS_400				48
+#define JHB100_PER1CLK_UFS_75				49
+#define JHB100_PER1CLK_UFS_37_5				50
+#define JHB100_PER1CLK_UFS_7_5				51
+#define JHB100_PER1CLK_UFS_1_875			52
+#define JHB100_PER1CLK_UFS_7_143			53
+#define JHB100_PER1CLK_UFS_3_5715			54
+
+#define JHB100_PER1CLK_MAIN_ICG_EN_SFC0			63
+#define JHB100_PER1CLK_MAIN_ICG_EN_SFC1			64
+#define JHB100_PER1CLK_MAIN_ICG_EN_SFC2			65
+#define JHB100_PER1CLK_MAIN_ICG_EN_SPI0			66
+#define JHB100_PER1CLK_MAIN_ICG_EN_SGPIO0		67
+#define JHB100_PER1CLK_MAIN_ICG_EN_SGPIO1		68
+#define JHB100_PER1CLK_MAIN_ICG_EN_SENSORS_PERIPH1	69
+#define JHB100_PER1CLK_MAIN_ICG_EN_EMMC0		70
+#define JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC0		71
+#define JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC1		72
+#define JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC2		73
+#define JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SPI0		74
+#define JHB100_PER1CLK_MAIN_ICG_EN_RAS			75
+#define JHB100_PER1CLK_MAIN_ICG_EN_UFS			76
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index ccfb7616e1a7..cf933a1befbb 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -138,4 +138,23 @@
 #define JHB100_PER0RST_GPIO_IOMUX_PRESETN				73
 #define JHB100_PER0RST_UART_MUX_REG_WRAP				74
 
+/* PER1CRG resets */
+#define JHB100_PER1RST_IOMUX_PRESETN					0
+#define JHB100_PER1RST_SYSCON_PRESETN					1
+#define JHB100_PER1RST_MAIN_RSTN_SFC0					2
+#define JHB100_PER1RST_MAIN_RSTN_SFC1					3
+#define JHB100_PER1RST_MAIN_RSTN_SFC2					4
+#define JHB100_PER1RST_MAIN_RSTN_SPI0					5
+#define JHB100_PER1RST_MAIN_RSTN_PERIPH1_SENSORS			6
+#define JHB100_PER1RST_MAIN_RSTN_SGPIO0					7
+#define JHB100_PER1RST_MAIN_RSTN_SGPIO1					8
+#define JHB100_PER1RST_MAIN_RSTN_EMMC0					9
+#define JHB100_PER1RST_MAIN_RSTN_UFS					10
+#define JHB100_PER1RST_MAIN_RSTN_UFS_PHY				11
+#define JHB100_PER1RST_MAIN_RSTN_DMAC_SFC0				12
+#define JHB100_PER1RST_MAIN_RSTN_DMAC_SFC1				13
+#define JHB100_PER1RST_MAIN_RSTN_DMAC_SFC2				14
+#define JHB100_PER1RST_MAIN_RSTN_DMAC_SPI0				15
+#define JHB100_PER1RST_MAIN_RSTN_PERIPH1_RAS				16
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1


