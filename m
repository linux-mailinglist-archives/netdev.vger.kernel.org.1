Return-Path: <netdev+bounces-285646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGaEF8d3/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:42:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0954F202B
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5688430022B0
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3FE36EAAD;
	Fri,  8 May 2026 05:37:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2133.outbound.protection.partner.outlook.cn [139.219.17.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D13451B5;
	Fri,  8 May 2026 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218661; cv=fail; b=ZGckAgUjhihi1FKZBLGXd0YDWmle5igmleFBjK38MtR1TDHZi19vi2Dr/U9unHoxmalNn6Y0RryPfGtNHMoccUPEq6hUnK3a7CsopjeLEvP23vqpK1T3KUM76GgOA++mP4foLHIAOnSHBi/EniI8dDQ+XbnTHobBNp7Ob2l+/Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218661; c=relaxed/simple;
	bh=+gUDoE8zNSmH9fK3wyIAuueZCp7lP51Th2cwzes0lZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gBfp2TOtoIiwZPmgIE903njpFQnqHuR0HBBjhtrTuHrQ0F8WyQJs1lvrwPN+mvwbsI6ULQHcxoEN19Iz31Q7DO2gTd03h6pyZJRJDhJ0doY+FLsi4hzwRT5bGWG8Dsf/nzAo45Uc2YmMjH/24ZMFrh0dinQSXe1/Ppq0uW9dwnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VipLu74FnyxhoJhoBK9JBfP7fj9hK0jAhyQwLyrpcm9lo4x7CCMTWcg57OYpguFQlAeWZAmjRcIIJvgqLCMIE2bJnC3htxZqeVUJQFiUyprvo148CVvQdW2VHIGna72r0Q/sAY6VygDmMmAzlgoX6rYoYfIxVkpNv5zW7+SCztjUdFPbpiI1wdMv+Hg99WqLrj1ithF8ATw1fIHkS/PpJIEJXccLY90rXkIXTcZ8m71806QnnwFMor8TzwlsR40eoSWY8fik4j1yJSWVUv/NjhR9/Lli/lZAp1yDOYAnGCr+3Pk2JFlFY3Qj75sShs43im65BIZmPyC6MlwzHRm6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yLHPkq7o6xMMz89ItBRqerWlfMkuzjfZxKPRA7GcVQ=;
 b=IzzPiO3Kk9Dzrci06Grloqug3A6aWsyP2lePhA+YnGZfPqLuVivYoOKqlcMNXVFNcB0IpL6yTO0aiGhEHLRmlLhg1yWKfdTaZ139+85uDVCRLvRupbRY4A0eUokYBAyVsAHX948UVJ/M4WLQ3+xo1H3qpfO2zZ7/OyirGAT8k/RA8kMqAP/bjXlmBDqQz7/Hu1VpH7ccLONIk7WcO/51ANDW9SDnzt4RgQDfqf8859JAtWMm1/UM2aLm5qk49CzbQOpZnl403uaqBf3IhLDhVEdiCa+FwEJw0VX7RzyZRz12X9b+yzrfoHnAR8Q0PGescrdu5plqeDHhON+pAWEc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1236.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 05:36:53 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:36:53 +0000
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
Subject: [PATCH v2 07/22] dt-bindings: clock: Add StarFive JHB100 System-1 clock and reset generator
Date: Thu,  7 May 2026 22:36:17 -0700
Message-Id: <20260508053632.818548-8-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1236:EE_
X-MS-Office365-Filtering-Correlation-Id: f251297b-c3cd-4b42-2302-08deacc3cf9e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020|22082099003|3023799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tvYXoFIZW3hgLRXCgySB1l9gDFSv4rPXqIO+CHnrm0sg1QdN0AnQWfhMROyI6VZlJ1zIw0U0M8OhFI/EQmujpJP8OPzCQMH2K+YBHkrhWhWx8eBbeCrEmMzARANzTQlkT9PdQc6UTsqGm//zN1GCYRjhYJJxLr/jW2ohBhREbfGJAKwtLBARb3NSb6IaFH8txH2JkZhiX+/YAj1FgBlEu5roz8XUrqWflby7KtVPVCTYV6LPgEOzZEhjBGM5PuN/l7ioHIdNrVsAKcZgve0RQh7DmLrZHd9iYV+ryZSFbTPAUFb6Yd8ylOVwcmuE8/v3cfROX/uk+S1ipw9jANJOsKBaYjVIbcnZpO/cFovUqLG0Cm3Yn+npj9eG20wgr0hzagtxU9oYy9RDdJ4LSSRSiu5RVk5QRDyhsntwG//F51LKv/4gAJDS1K7+odSfXSZp2tL+rJGW9LYBkcrRblUGv+9Tx5DD4y3x5oEQvNirXmRR3zJlKzyZ03aIxgES6c6aOFul1gkNFfL8y6ccbn7NZr8HT3Mn24rebSfTJ5YKa2tNJ5VSGOHkzO3/sTGAtgkS0GjdjPNtN8y/xAbpmf54dQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020)(22082099003)(3023799003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SmbVrZeq6Ih+MWS8lj00G8tdtt/heobcuSbIS7hkvsXBlRU/ISLegVgunKIM?=
 =?us-ascii?Q?Oq6WQ78YnQiojprwnEBxjxwL5qZ/ddwJnfdNAH+98TcpK4zharj90PeoY9Vy?=
 =?us-ascii?Q?ECAwVzHuaKLyNStWQMYSlfgtw5qWX4krX8lvtnx2JSYoTxzJVtk+fOr6tYWu?=
 =?us-ascii?Q?yCeOEA4JGzEr/h8U9xhoRxxApE1FpQ66e7K0bRJXURDDbUK1YScZT7MqK/k2?=
 =?us-ascii?Q?zORjld3fKOlx5Ln/V3Qd2NcKVjqcACjS/HowS1jSsG2EO67MqSa5dOHHb6jh?=
 =?us-ascii?Q?7wXel3yK/uhU4mllFHyFz8nOTwmjx10cojMeNGvyEVeWKTFf8mSLQRCt+pMf?=
 =?us-ascii?Q?kmMNC23uI4340cNjrNYjWQw783BcNAJD1Rd0itRUe8+tB8iX0QoohtnJptZB?=
 =?us-ascii?Q?bYEh4V1jUsrtOyV9Vv6ojJzOR9htXwbZmmV1YLgwtrCHqCOslNpu+5iSazh4?=
 =?us-ascii?Q?ZVpANQKmLG/+YmB5ApPlP34Moetbh7T+vwtbbs6dMFUsWGN8szYriVtWZrvJ?=
 =?us-ascii?Q?WX7Cej1+qccVS7KE031Ih3cnP6gX3xfPQwZYa9ovBEvkP5XlYA6Ps5Cth2cs?=
 =?us-ascii?Q?1xJkXjsH9iB7D0ZGPXwytDJz/j5qbec3y5VzfevN1WaAdtQ9DPKiAXbsD92p?=
 =?us-ascii?Q?l/+Qx9H2R2zqGWHzgnBkyc6tbT+/KGynfExe7SCGydxHqMg/Xs5MqL+svZ3T?=
 =?us-ascii?Q?WTeDNPRzT8o6/HCQI4qMKT6fqyVrvRtyRUl9HusgOC6VFVpSerajVKhE8fhN?=
 =?us-ascii?Q?SCHnySra+KwCkzzhz/XPQtFj5sBuvdv2JWe1hQSCm+RxF+LLj6Zf3+IY5bfN?=
 =?us-ascii?Q?lcwvPphrimp5PhNYG1MBAOfO1GwdajWBXdUVbqbPUXI+p7u+ofgE1hlEJLNG?=
 =?us-ascii?Q?HyzoSxSvy8YZ3NYI2+FwNQdDyH8ht2UcsHkuzzCLe64ZpDpvPxU56vcvJANb?=
 =?us-ascii?Q?oe6KdCmc7FU5MMlvRhKw/KnLWWlB2gzby9kk6qRlZV15+oLmUI7YNRezzHIk?=
 =?us-ascii?Q?Hesgnm84JI5ZhD7MiqU+4s9M9aGKF3CRwHedjKHFeOTILP+TtA0reumP6eC4?=
 =?us-ascii?Q?1fTIJoLP/pLAc+w+6tPL0OkOh9xsJEANzdJ6p6Sy+azF5GDjtuZJmn/71scc?=
 =?us-ascii?Q?aifgRXo1+dVF1Oz3M9l+lF+LX/El59sps/vQdlzkczVxNyzLOdsfqY/usPgA?=
 =?us-ascii?Q?JJ9OxuakhQyAvcM9uK6QGp1/d4YgIkf2vaCdatQQ+q+IyD9ZzgbD2Gk/ke5E?=
 =?us-ascii?Q?a7+5p9+l8xfo42YIg9c/Z4r2fcWExHQoSBeTssxwjLMyTc1O1kkMhfavViWx?=
 =?us-ascii?Q?KbNWHIDT2tbHIcsKthjVWFqLSJP3SMoRHD+WP4ajCV9bnXG4yuu3HdzgHy/w?=
 =?us-ascii?Q?dAmoDNpJ7heBK669atSBww2Mq8mf8iNyck2s/xkMkuW6Tqc5IoiDAWxlReTh?=
 =?us-ascii?Q?ezkdwTAB1IrKsCWa5FLbsy2LGKa6WK8ifY3xm3RjYBctcjHfGLNv3odw0FyH?=
 =?us-ascii?Q?H7Oj6STT55lj52/TIQYWNDUT84EEyyP6kGKhXPSWYcyNRigLom0Er4tQtyP5?=
 =?us-ascii?Q?kQQKWbAqKYFqwZOHs89iQc846AGXcQsiN8zGlx6AQU9oKrvOQmqmnZQKfaSM?=
 =?us-ascii?Q?qOmqZ+a6Epc6+ePWofAMEH7/5zPWQrNwDgw8yHWG/kRsWB1OakTFoR79fHTF?=
 =?us-ascii?Q?eiYUTDtK0ffaUXw3ilSiQjEAqOS0jbzN10fttY5QI2lflx2fUUhmI1Vzjy8y?=
 =?us-ascii?Q?81mGOT+k0ihj8Sg7ZP5HCU+/hURYzqZORTyiRkD7KAXrmH3lVGYk?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f251297b-c3cd-4b42-2302-08deacc3cf9e
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:36:53.6500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuryTl/yfDFA2W4CNaRLtNJF4ebV8auIlbPwRaUd6gxypxcTi2DZDj0EBr7GMXfMCg0Iv+Xfr/TjmoIrf+Z4/JjKgprJSm6KKFzbckByKXqipaZn9gS6AS5QDd446SPu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1236
X-Rspamd-Queue-Id: AE0954F202B
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
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285646-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.710];
	DBL_PROHIBIT(0.00)[0.198.108.224:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:email,starfivetech.com:mid,devicetree.org:url]
X-Rspamd-Action: no action

Add bindings for the System-1 clocks and reset generator (SYS1CRG) on
JHB100 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clock/starfive,jhb100-sys1crg.yaml        | 71 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 20 ++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 11 +++
 3 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml
new file mode 100644
index 000000000000..627dfb8593a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-sys1crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 System-1 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-sys1crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (25 MHz)
+      - description: PLL0
+      - description: PLL1
+      - description: PLL2
+      - description: PLL4
+      - description: PLL5
+      - description: NPU Non Coherent NOC Initiator
+
+  clock-names:
+    items:
+      - const: osc
+      - const: pll0
+      - const: pll1
+      - const: pll2
+      - const: pll4
+      - const: pll5
+      - const: npu_ncnoc_init
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
+    clock-controller@13004000 {
+      compatible = "starfive,jhb100-sys1crg";
+      reg = <0x13004000 0x4000>;
+      clocks = <&osc>, <&pll0>, <&pll1>,
+               <&syspll 0>, <&syspll 2>,
+               <&syspll 3>, <&sys0crg 61>;
+      clock-names = "osc", "pll0", "pll1", "pll2",
+                    "pll4", "pll5", "npu_ncnoc_init";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index 24ef2663f05a..d7904b32bd51 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -53,4 +53,24 @@
 #define JHB100_SYS0CLK_GPU0_NCNOC_INIT			73
 #define JHB100_SYS0CLK_GPU1_NCNOC_INIT			74
 
+/* SYS1CRG clocks */
+#define JHB100_SYS1CLK_APB_MAIN_SYS1			0
+#define JHB100_SYS1CLK_APB_SENSOR_ICG_BUF		1
+
+#define JHB100_SYS1CLK_GPIO_ESPI1_EXT			5
+
+#define JHB100_SYS1CLK_HOSTSS1_NCNOC_CFG		7
+#define JHB100_SYS1CLK_HOSTSS1_PHY_SCAN_1000_ICG_BUF	8
+#define JHB100_SYS1CLK_NPU_NCNOC_CFG			9
+#define JHB100_SYS1CLK_NPU_CORE_DIV			10
+#define JHB100_SYS1CLK_DOM_NPU_CORE_CLK			11
+#define JHB100_SYS1CLK_DOM_NPU_BUS_CLK			12
+#define JHB100_SYS1CLK_DOM_NPU_INIT_CLK			13
+#define JHB100_SYS1CLK_DOM_NPU_OSC_CLK			14
+#define JHB100_SYS1CLK_VOUT_NCNOC_TARG			15
+#define JHB100_SYS1CLK_VOUT_PIX0			16
+#define JHB100_SYS1CLK_VOUT_PIX1			17
+#define JHB100_SYS1CLK_BMCPER3_NCNOC_TARG		18
+#define JHB100_SYS1CLK_BMCPER3_CFG_125			19
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index 5c7b00afda73..da1b51621172 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -25,4 +25,15 @@
 #define JHB100_SYS0RST_BMCUSB_RSTN_BUS					13
 #define JHB100_SYS0RST_BMCUSB_RSTN_CRG					14
 
+/* SYS1CRG resets */
+#define JHB100_SYS1RST_SYS1_IOMUX_PRESETN				0
+#define JHB100_SYS1RST_MAIN_RSTN_CHIPTOP_SENSOR				1
+#define JHB100_SYS1RST_VOUT_RSTN_HOST0					2
+#define JHB100_SYS1RST_VOUT_RSTN_HOST1					3
+#define JHB100_SYS1RST_HOSTSS1_RSTN_BUS_ESPI				4
+#define JHB100_SYS1RST_HOSTSS1_RSTN_BUS_PCIE				5
+#define JHB100_SYS1RST_HOSTSS1_RSTN_CRG					6
+#define JHB100_SYS1RST_BMCPERIPH3_RSTN_CRG				7
+#define JHB100_SYS1RST_BMCPERIPH3_RSTN_BUS				8
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1


