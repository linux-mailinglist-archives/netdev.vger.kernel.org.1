Return-Path: <netdev+bounces-285643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLmLJWZ3/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:40:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B30F4F1FFD
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8F21301D324
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89747363095;
	Fri,  8 May 2026 05:37:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2133.outbound.protection.partner.outlook.cn [139.219.17.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10F34F275;
	Fri,  8 May 2026 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218642; cv=fail; b=VosUfv+Z8PJ91kyRYFmm4vzkXOi6E/9I0VoniTpFU+bUuEnAKa6IDHGLjax9vAZugLdZ5Gy3VVpgIU0aLKxzooFZaHVMFLHEu5BYHnHGZ+t5BoYi15SxsebCqA+kvVQZw7kgUIHs7umleCIlQBAsZeW7piL+Z7C3zk7x8aacrsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218642; c=relaxed/simple;
	bh=sgazUNdwEnnUM3cz4lqOtOKlY6RRo+fHXdGc8/fI68c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JJXA+F4NRC2RjPTOoi6vDoT+X4P5eyzAIfLZIVosUYh6MaUDnAN7QMjqOwGjaNGZRH4oqhTa/ifULSLELk74gR67AY0DWoNDbPUMFh9+Ot77ng70VQtFYPRp008IFxX/hF2RoZI5jWtefC/5ytsvgKRv4pJRDlmayeklrbdBFv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsBMOokKmcxHqeVVuJypbeJ4GQP7iBbdEoEEdujDWShJqZ4ADRp1cyEfQt5vymKUIzDA4avnXOVOz5IBa00zPd5qR8jiGgQJcreEjTTj9x6HHGNDoMeyxRIXUHUIabKW1ApWidmMgZNxGwxi7OztoCzhqQ5jr2R95R45TlEfl3l4qKyl6t4hCQdHRvzYiDI19hcB39os8nPKCivHySGpFWXq3xPxSRgej7H9kwV42vP8y++S6CPNIIP5PdNerjjhhUZ9za8TQUrXLRIqblm1F5n6edI6/efwr5TI6BM9kQaKndkV00J2MjOClQ3K+mCb9Rl4UW1KdJWpGnAXtJcEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3N4y4Hwh9v+qsEdsqbZ2wT60ktcUBiiMr3bOYv/2jDQ=;
 b=f2XixJKdnL8qH81AkXcYXXOJtHq17kjOaaxCHgUlko1pk6/8kv6VA7DOGDL+axer7DOF/sI612Cb9719KBkAdFUSCRYfyGO3KZ8lmc94t+arkul1G8ES2wSsKXHGXcjxHThn/SZaiS2savEEHz6y4wV1uRjOfxBClX4GpvsaMCcefpyW7lIrJI8YT9TkdwEDjtlboNj4CfOQdsWL2Bqd/jX61hRyqIoGccx5CDZIomT+AiXFYtrg2IiNTYGW7It//wpiex2jC8Hwl8yssCpS9lL7Y0RnsXs/GteoVfgn7qBjHbPjewbX2q2GeB1/p2HjnqmR98f0ccnNwUMglClywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1236.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 05:36:49 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:36:49 +0000
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
Subject: [PATCH v2 05/22] dt-bindings: clock: Add StarFive JHB100 System-0 clock and reset generator
Date: Thu,  7 May 2026 22:36:15 -0700
Message-Id: <20260508053632.818548-6-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: caf99e25-5d78-4d30-1880-08deacc3cd4f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020|22082099003|3023799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Yw/PAjTh+01xt4VDufssqA/GmNq2mQTbaqkefwqFiIKW5WoJITuu1/T0r1e+BsIYtJ5wPIXDwyNrLQ8SsDiEHD3e2BzC/GcITMGcU1naY5G9RCI6pZyzaxHcmitDhihx0YDGmjsdAxWwp4du1mSzn95wXmyJ+5p4xxwkyxSIku1x5PpG+VEZarzbWHNR1hD+WRs9xKKZiRrxlxPaDOdgE+CP+6QDl15d0otCjjD/vreBB3jc48wYnkXNKB5eO8CFau3P9gt4r0KSLuaXnhZqqqn+IStUUgbU1u02GOClJDKSG99hCv20cTn4HhdxVIpBZbDeC6cjuUaNy/vXaN649NZ/+SnFDCOGA25+N7uDfgan8ub6QILWfjilKLXqyzoAUbVrlwCM667aWlNsofFi5tZra30m0Hxa6/JmeWwCU+VAmgHo+l8G8WA0DpTExfYbtmanp8Ehiup8bntUsfC92rg/GlPMVB1+3hXB0bPzYcbL2BJFoU4lAYqmxuQD5WIdly2uSAtrvwH6AMXqRaWiqSSrNG/jQX9dFurROg8J/HaKHjVNs9/GqnH1YrmaCQTr9E8lTwgpCkMBsusk5LQhlA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020)(22082099003)(3023799003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UONU2EF3wc5CXYVLrwUvpOIpmoC2GyN1BQjUAH6JfZbF+LzE/7nDgYh6Zl90?=
 =?us-ascii?Q?BO3Nwj9vMkipBR2uMkbZjkgU3s29wVZQBC3nCGJVYx4EBiwhq8YIfM/0Oky6?=
 =?us-ascii?Q?DIyNkBHcEsPKBZ4o30crBR0O3Xq9J1KTyNDM0CiG6dvHiIVRkP9Mq+nRVwWp?=
 =?us-ascii?Q?f9NmEnCHfNXfU+qqOA99rN/z+D1niBciCDSb8xZ08iXis9uwP0xL1fiecYBh?=
 =?us-ascii?Q?+cDN3KPITsiirZODqKhYopkEiJ0cr17WcMY4D9Mx6IXl4zI0GaiCY5YmKvHX?=
 =?us-ascii?Q?pW4keXsk0V8lKFkq1v1tPIhMrn+/xZ5WhloTfIF/0VO+Xt6G6vK3VswJ6KFJ?=
 =?us-ascii?Q?30jJyJh7zQON5i2R01iZoMybGkHgn1gbGCOQjTs3RMtIYIT0zN2Hi5uoeU7e?=
 =?us-ascii?Q?pagBkVG1H3WxZtb8W5k46WvfV7G1Zvb3LF/h91zdvK7mtc97SQpgUCW6jSjQ?=
 =?us-ascii?Q?XclOxHlutmdNYAwYXGF4DZzVYiXVhrC5jiZMYplA9iJ8GzXsbLOCQKEhlFMP?=
 =?us-ascii?Q?BPQfAFxZythKJjkeLeO5MYWHHsui4S5yM9TUcqPa91a1otUiWBVJvyB/QshL?=
 =?us-ascii?Q?iTCR/iN9DpLSl1AsE45SEArpumtl1Nt7W3sBIV+TNNCRlhSn8Pwi/DBlwXNA?=
 =?us-ascii?Q?eJtfyteYOq2Oaq+HyvF393I82rJfORcHmq4DeecGy0pREXvpy3yMElSws+rj?=
 =?us-ascii?Q?KITUIxmlRgXJ8nL3WZ3g4ov5tXmnt98A4kDKk7bztTM3N4s1C43Dm0bcyUqv?=
 =?us-ascii?Q?nXU82UKnRfisLJp2bFkcuN5+siTOBhnwKRE1FGoteZlW790LdFeeaeusMsvT?=
 =?us-ascii?Q?mY1W93/AyPnnbWqW3C/Cj1LNJkAdvsX0HenJCYNxmaboWVpViaGts5GF4S18?=
 =?us-ascii?Q?jSJWg2YHFwDJx+fQHtUovfRGfvwFxFUgAULmW+8sQ9GADXnVTRMUe1+2D93v?=
 =?us-ascii?Q?1mjxaOlYAEbDFrO3GMiUXqryqRJYsglxEK8K0WQ+7EMeLEenQFlBXfUELamf?=
 =?us-ascii?Q?xhPEhl6pSgGjvJQP9wJEDijwjFMSuDqrW6jv4pm5HKQLuT3Fstm6YeXIboMf?=
 =?us-ascii?Q?KQKhqMIQCXJxLfRsEm2C45FTyM7CntM135nE8hdJkoojTqsQtS6fBi8AJQzX?=
 =?us-ascii?Q?YQT2fEdIUTbLzT5tlBU8+Jp/ui/JyV805qjqyhvpsifmPtc4Y6jQWGSLO9/i?=
 =?us-ascii?Q?0CY2yCk4d4/KVPguK/OoVvYgo6oG8iqumwJVmc4qkZmw/lFp1bQZWY4Jrets?=
 =?us-ascii?Q?nBEgwb0/FBVohr18hE9uvhDQjnGXi9vwSEIcwAXX/8wGMJ42htQM2FUVunO6?=
 =?us-ascii?Q?ZPj0Vt8DF1t0cg7yENItQ6eaK+Vc170sV4uMDWyDMs1WKE7vCPSGXb/5ACBk?=
 =?us-ascii?Q?j/AXOWv8us9UIPaeIs13yTDq1vezuf2P6Ok7opeEQsWj4cEna1DumtCWAjff?=
 =?us-ascii?Q?7janDg46ejmeBBKpL2dbmeeJ5IFszFpJJsmkZfiBycGCKbmwypABsu8I3Yx3?=
 =?us-ascii?Q?LeMrCvCvfV+iXfGz6wQhVdrpYE9R33NhKvfVHjiyeCkg757frl2E6zd3aPSY?=
 =?us-ascii?Q?gS6Rq4A2I6KnioQTsi2JOtiJ+5JPlAfsLvVhG/4D0vuJkWRXLh4yA6aa/GJS?=
 =?us-ascii?Q?YgQrKfhqpfXM67BYQVYZ2CM26opxd+HcSFrzmUI6/Vz7nD/C20LnumFXHDpR?=
 =?us-ascii?Q?SjxXnE1XApkeQoDjorHTVpEdl7bh5hyCtolRC07fsIgH1fPGaVv4aiG+JTZq?=
 =?us-ascii?Q?W8YuhimAcRrOU2t+IRgWW9/84dyhrBKDMAb3xmsRVe0e/c1FMU/8?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf99e25-5d78-4d30-1880-08deacc3cd4f
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:36:49.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2injlVFWP9xN7XYv6Ui+Lzs6rhopSYUnAKXFR224zRucmvBkItMnUbALg5Hhboiksl8MRmkO0BDS1RZcfNS1OUA5RtL7q0NN3JXtfSW2YDkiwVFClyv7GXS8SwCTvufv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1236
X-Rspamd-Queue-Id: 0B30F4F1FFD
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
	TAGGED_FROM(0.00)[bounces-285643-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.817];
	DBL_PROHIBIT(0.00)[0.198.93.64:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:email,starfivetech.com:mid,devicetree.org:url]
X-Rspamd-Action: no action

Add bindings for the System-0 clocks and reset generator (SYS0CRG) on
JHB100 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clock/starfive,jhb100-sys0crg.yaml        | 63 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 56 +++++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 28 +++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml
 create mode 100644 include/dt-bindings/clock/starfive,jhb100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jhb100-crg.h

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml
new file mode 100644
index 000000000000..08016a61992c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-sys0crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 System-0 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-sys0crg
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
+
+  clock-names:
+    items:
+      - const: osc
+      - const: pll0
+      - const: pll1
+      - const: pll2
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
+    clock-controller@13000000 {
+      compatible = "starfive,jhb100-sys0crg";
+      reg = <0x13000000 0x4000>;
+      clocks = <&osc>, <&pll0>, <&pll1>,
+               <&syspll 0>;
+      clock-names = "osc", "pll0", "pll1", "pll2";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
new file mode 100644
index 000000000000..24ef2663f05a
--- /dev/null
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__
+#define __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__
+
+/* SYS0CRG clocks */
+#define JHB100_SYS0CLK_BMCPCIERP_NCNOC_MAIN		17
+#define JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG		18
+
+#define JHB100_SYS0CLK_PCIE_REF_CML			20
+#define JHB100_SYS0CLK_BMCPCIERP_NCNOC_DATA_INIT	21
+#define JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG_INIT		22
+#define JHB100_SYS0CLK_BMCPCIERP_NCNOC_TARG		23
+
+#define JHB100_SYS0CLK_BMCPCIERP_PCU			26
+#define JHB100_SYS0CLK_HOSTSS0_NCNOC_CFG		27
+#define JHB100_SYS0CLK_HOSTSS0_NCNOC_DATA		28
+#define JHB100_SYS0CLK_HOSTSS0_PHY_SCAN_400		29
+#define JHB100_SYS0CLK_GPIO_ESPI0_EXT			30
+
+#define JHB100_SYS0CLK_BMCUSB_NCNOC_INIT		34
+#define JHB100_SYS0CLK_BMCUSB_NCNOC_TARG		35
+#define JHB100_SYS0CLK_BMCUSB_SCANCLK			36
+#define JHB100_SYS0CLK_BMCUSB_480M_SCANCLK		37
+
+#define JHB100_SYS0CLK_VCE_NCNOC_INIT			50
+#define JHB100_SYS0CLK_VCE_NCNOC_TARG			51
+#define JHB100_SYS0CLK_BMCPER2_NCNOC_INIT		52
+#define JHB100_SYS0CLK_BMCPER2_NCNOC_TARG		53
+#define JHB100_SYS0CLK_BMCPER2_CFG_400			54
+#define JHB100_SYS0CLK_BMCPER2_CFG_125			55
+
+#define JHB100_SYS0CLK_HOSTSS1_NCNOC_DATA		58
+#define JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400		59
+#define JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400_ICG_BUF	60
+#define JHB100_SYS0CLK_NPU_NCNOC_INIT			61
+#define JHB100_SYS0CLK_VOUT_NCNOC_INIT			62
+#define JHB100_SYS0CLK_VOUT_AUX				63
+
+#define JHB100_SYS0CLK_BMCPER3_NCNOC_INIT		65
+#define JHB100_SYS0CLK_HOSTUSB_NCNOC_INIT		66
+#define JHB100_SYS0CLK_HOSTUSBCMN_CFG_480		67
+#define JHB100_SYS0CLK_BMCPER1_NCNOC_INIT		68
+#define JHB100_SYS0CLK_BMCPER1_CFG_800			69
+#define JHB100_SYS0CLK_BMCPER0_NCNOC_INIT		70
+#define JHB100_SYS0CLK_BMCPER0_CFG_400			71
+#define JHB100_SYS0CLK_BMCPER0_CFG_800			72
+#define JHB100_SYS0CLK_GPU0_NCNOC_INIT			73
+#define JHB100_SYS0CLK_GPU1_NCNOC_INIT			74
+
+#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
new file mode 100644
index 000000000000..5c7b00afda73
--- /dev/null
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__
+#define __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__
+
+/* SYS0CRG resets */
+#define JHB100_SYS0RST_RESOURCE_ARB					0
+#define JHB100_SYS0RST_SYS0_IOMUX_PRESETN				1
+#define JHB100_SYS0RST_SYS0H_IOMUX_PRESETN				2
+#define JHB100_SYS0RST_RST_ADAPTOR_TIMEOUT_RSTN				3
+#define JHB100_SYS0RST_BMCPCIERP_RSTN_BUS				4
+#define JHB100_SYS0RST_BMCPCIERP_RSTN_CRG				5
+#define JHB100_SYS0RST_HOSTSS0_RSTN_BUS_ESPI				6
+#define JHB100_SYS0RST_HOSTSS0_RSTN_BUS_PCIE				7
+#define JHB100_SYS0RST_HOSTSS0_RSTN_CRG					8
+#define JHB100_SYS0RST_BMCPERIPH2_RSTN_CRG				9
+#define JHB100_SYS0RST_BMCPERIPH2_RSTN_BUS				10
+#define JHB100_SYS0RST_VCE_RSTN_CRG					11
+#define JHB100_SYS0RST_VCE_RSTN_BUS					12
+#define JHB100_SYS0RST_BMCUSB_RSTN_BUS					13
+#define JHB100_SYS0RST_BMCUSB_RSTN_CRG					14
+
+#endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1


