Return-Path: <netdev+bounces-274526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHm0J6ZmzmmXnQYAu9opvQ
	(envelope-from <netdev+bounces-274526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:52:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1659538943B
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8749F3098429
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB093E3C5F;
	Thu,  2 Apr 2026 12:34:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2105.outbound.protection.partner.outlook.cn [139.219.146.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7A33E3C53;
	Thu,  2 Apr 2026 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775133290; cv=fail; b=rnVzt/yr60A+LOgMFL+yL/O6SJAmlN8Cyhxf/bUZJ/EeiPM0lMEP9eODdbEclEy6UrSHZ0unTeFHRdvOf5Je2kwDYy5cHvc9SLfMo9AXgU9Ux0yH3A8QRe1p4eLjr9SdeNDaHsUG08UpAlay0faA47CbxLqJC5JryYsOii2aSnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775133290; c=relaxed/simple;
	bh=5c+zTGUj5hqcxnIzbTwOqoe6tsP+yTZwB9V9b0DZofU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gi0VjqMHbSHYXbGSAl5vSY+SHmQIHUMPLOas2BYHNkLpGHkgTh3QannH6+pKhuyTQ7Kgw6OsE/8tIdeLNntSGUGjyJtL+Gj4i4ZBFfqwkGOJA9ZIb+YLTE13qnhNjy/i9as3K8l1jlQ7PZwcdRRB0Kuhs3FNugzf+2QgQMj2oEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUBGZ6qPbrwy/udwfFuK0jqs94AjHXdKhAdo5ImiYoFpYAj5nFG/W252/3ewiKad1c9Yd3bPKmchdnFO+GqZ1Il2fg5wu4TCfx6Xfcru0phoR71SKsJmzBGzKBoQfCp6GRS1mNixOSFcTD9C5cHKECJBYImEzBgpOlT+3//ld9BgkJCxjOxDeReeBQYYrMCmTr9WvNoviXhF8lkslGlQE3tsi8SFa/4b4hiMKnP6iA/XTq3tXQWE82vH8zXnCHcQMSloEaZxuTQ8DL1+PTg09ZjbZ5UeJchrFyr3P8QhdIY3Uyt3TL6LtKbGSVak2ZT4Kl9pwVlN1P19GTPa55VHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeDPbLO3rXhL2r/iNO95UIbEDcWNB+lvh8qtNlbBnEA=;
 b=mYTJxTGCDeQ0/5hgrypSjWZn4DV38y+WCkl6ETrQVMMT5V4Mghiq/npGlhj8Q8UVH5/vgSd1bQwA1O1KJJYhEVKSrvjgXULUGY8sM+lbrnqqs7MwAKxd+BfT1bcxLEqQcz8T4RO2+1G6p8BwZAgwK2ckFpbCtb9ki5Lhlk5NdWq22gLX3En38W8ra79ZrhxPl6K8svv8zWPtrza7Oe7Eq/fLUfmeH6y8JHprdMsdcXK/2MAYclRqFhyrqSBPk32Xk7JLI7TK4H3S+rIF32Feyl3ySYgQFD60Vwc5rRS4Qkl9exm6cjsPouV65fJtsymS7++qhnAhx6KI3BQ+MUAF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1096.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:56:01 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:56:01 +0000
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
Subject: [PATCH v1 09/22] dt-bindings: clock: Add StarFive JHB100 System-2 clock and reset generator
Date: Thu,  2 Apr 2026 03:55:10 -0700
Message-Id: <20260402105523.447523-10-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0028.CHNPR01.prod.partner.outlook.cn (10.2.0.210)
 To ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn (10.2.3.165)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1208:EE_|ZQ0PR01MB1096:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ac9e62-7848-4aaf-d3fe-08de90a66c5c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BiDDErzJY1hm88NkO1bn9vEtsI3i1VgwCrvh8uKz3QggqyfOpUU/h2JUTe535KbSOLRTOhZtLrBPyZHfqMxcVvE1BK9le1mwIyhu0FsWxefVkWVxf6MyzG+qifnyeVQWmNcQGoMqBd+US6IIBgfs/G7bjHMKp9wa5/lAKwCqPfVEW65ZjwbKor7puxlScgviDfMkVK1rRlJtkqeygzcI70O853F0yKfQJcMaer5sf2B4niCYxzYoMKbaTy24bsNV+qq/DNqK5hkSy6j4cIX59HDjtJcA4/y6EahKDksvTQpT65vPyFzG2pZmq5NMvKimT7Mc4Wr+uJimVGtohwfU5pGTW+q/BNLwiEc7Kr1lGWf+jf03/ZY4IdNqeuZ70rNihamFRWtcVThukVHIjUUDKoQERj7rocTtYQpGhzvh6YWATPP0s7kkgp8C/wA7tXhO891KuWgCCzdqtCLFuIqReq7S+oWXgVn0IxaiO0c1P32AEuN3+Fi6ywBxFIDoVWYyTqN7CIfO3Hyxyfpf93hXtPMP8AjHdRdF+tmrdRin4iVnY7X4KAB6ro3rsRS40YtmQ7gIKNX10x7zKh8l3X82jQwrCmEQMvqcnO7KKKXFOIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f6uarxj9U14qtJvSOW71IqIy+zXgvDg9WEPXA7t9i0M2+FZzCAGlSfh9yjkH?=
 =?us-ascii?Q?9AdtveP0Q0DQxSsOyKxwcy6weJA5W0S75gltC13Zqfp4fxddt0KJKIWto1JM?=
 =?us-ascii?Q?buIJvO9CoKgiQRUIfb3q1Is72tr3Ei+kEyoliaTJ6vIQGKfFn+EKwsupbw8z?=
 =?us-ascii?Q?hnQY3IW5SXJmlE2zgvFKmJ2qKwDWlhyeIf3W+HiZiVESG+jf558ogAsVgDC7?=
 =?us-ascii?Q?DJtyjaGkknSAZjhHbFThUsFsfB2KO0oU9c3iHYLyTqN/8bB2uXf0M5J5216i?=
 =?us-ascii?Q?3joPHg1w5PtqJ24U1XMbkNAgX25UMVgbdec3o2Qxek9TlYlRfySWesnsKLZq?=
 =?us-ascii?Q?jGwEf4iD0xcAHwNoyeOb8HBil5ffGKF6gd4tf/fn4vek9wrvNnDZUDlRzzHz?=
 =?us-ascii?Q?a0fGaMvgoo6fHrdFXsEoDPIKw5RL7rmGjaj6COm5bCwCilqqpEKzWXUu8rSa?=
 =?us-ascii?Q?L/TQlwl/0U/UZBCYSBLakEmAJlmJlzQBJeM6rMxbGynDakgMNmtscFhhpxWY?=
 =?us-ascii?Q?FDiu7RJSzHus5zDNQCR1uu0vxPJkZi2p7HjbB/e0HpcnCK9FoRCf4vcNIef9?=
 =?us-ascii?Q?7wBF+goXmWYpbQHwzsbjpIhyEUZW4+lek1zTt2TmL2zzKCYmYWIzDARIsxQ9?=
 =?us-ascii?Q?/49ZaugDWyy100XGGwElTAwzztkfimkjf6yE/4WUVhucuBozCEE85atqijjK?=
 =?us-ascii?Q?E5/kmkfLw1a7ivTUN3/mXFAy97oN6FBbMT09Jplz5GFRWJdvXSMnkMGLoc2e?=
 =?us-ascii?Q?si60HQTQuoPj9B6VTWkjSNSwemaC0Zjeo9o2ul4OY4OHhndXFYOExRGGMgDr?=
 =?us-ascii?Q?dHYI4H+oEo4q5YoGxqnTK55htUko6xczBRapVzXHVfuKVrPJPGiOsDbNX6j7?=
 =?us-ascii?Q?T7JdiHQso7iTXrPMi631WTWuqmTwkRAxF5ACMp0wTsE7ifpFdJ5I9Rv3yzee?=
 =?us-ascii?Q?jGtCpGKzqSIZAUuScQpvH8Th48gSyxO145IB9b3gPXHSDiedxBTPIsX69i0u?=
 =?us-ascii?Q?Dm4kYcRYtCpTLdM+XXatknB2BFZk8UhjZxHiyEeiu8i6Rr7qAwIgwJV+3GcI?=
 =?us-ascii?Q?XpQZDUY5MJY1uF/wspbwcFE9W5sgKcauE3Or90cL7zjoJcdlBqLAE9GifImi?=
 =?us-ascii?Q?b/ogcUEc97Pze0kv+fvSCOVtclhE7TR/1yWhoWQE1sG/FMxRcIJcObIw5DEY?=
 =?us-ascii?Q?unStU08d0JxwCUDH2GD4sobhHU/+iAU1BrzgeT/ZqqiQM9zYO83z0GN5kEqB?=
 =?us-ascii?Q?6xnj/DlwltzD2fyRhLxDzXkhAqJnCKRTcUVE1aRqgDh9fgU35agNhwWnYZWf?=
 =?us-ascii?Q?36seTdjTdyzQSL4fULH6GiGs/6emAyFCQQvDWXWdF1BYcqJF/CO+ZPeAd4JW?=
 =?us-ascii?Q?iv65Swrm5/jjJlNTD7xQ7Hk8ipEQu7FZa/JUTv/moIOu+/TlgDU2IwaxYLlZ?=
 =?us-ascii?Q?Ek9qMeGeaB12K+msysJbV6tc+CIu118EhcLNG2dOrCICVFqyuUr2YEyWByXy?=
 =?us-ascii?Q?Tbtf6DT50/Cv1W4BRmX/0bi1cuQo4dbFp5I91k/We9geXkZptCQ82HScgGPb?=
 =?us-ascii?Q?ytsUPfk01oEmUJH5MsbWUhT2VRlpZG96c65gVh86nuxbky0rwgUX1DE8N1wK?=
 =?us-ascii?Q?UrD/qe1LgY7XR9b3KbrlJtc0vdG00aWkxl6v/tWkzJAv7egR2DaIjLwqfkTy?=
 =?us-ascii?Q?WtXaFP5rp9F+4dg54TM2POA9PKlRx+FxabpUyV2Z+cliQLEEK1Isd7yLJ9Bd?=
 =?us-ascii?Q?D/qNJtBO1w5JJSJuwIJDLdVwZhsZHnI0r++ci+1aBrhX2p6yKQ9C?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ac9e62-7848-4aaf-d3fe-08de90a66c5c
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:56:01.1824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /prO2+86wmtqMrmfxEm+DfxwJbTemLyJVyTiWrrflNmEzM18F6r2jFN7vvTHBXg35X27AWCGfpXLIn5nnm2OTvrkz/7MQu0B6Eo4mZ6sZxwFIVdUfoZ7avF2d7nf8YHR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1096
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274526-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.623];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,devicetree.org:url,0.198.124.128:email]
X-Rspamd-Queue-Id: 1659538943B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings for the System-2 clocks and reset generator (SYS2CRG) on
JHB100 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clock/starfive,jhb100-sys2crg.yaml        | 64 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 33 ++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 26 ++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml
new file mode 100644
index 000000000000..5f71e761be23
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-sys2crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 System-2 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-sys2crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (25 MHz)
+      - description: PLL1
+      - description: System-2 GPU0 600MHz
+      - description: System-2 GPU1 600MHz
+
+  clock-names:
+    items:
+      - const: osc
+      - const: pll1
+      - const: sys2_gpu0_600
+      - const: sys2_gpu1_600
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
+    clock-controller@13008000 {
+      compatible = "starfive,jhb100-sys2crg";
+      reg = <0x13008000 0x4000>;
+      clocks = <&osc>, <&pll1>, <&sys0crg 73>,
+               <&sys0crg 74>;
+      clock-names = "osc", "pll1", "sys2_gpu0_600",
+              "sys2_gpu1_600";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index 510a5c6fa89a..34e4498fc1c8 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -73,4 +73,37 @@
 #define JHB100_SYS1CLK_BMCPER3_100			18
 #define JHB100_SYS1CLK_BMCPER3_125			19
 
+/* SYS2CRG clocks */
+#define JHB100_SYS2CLK_JTAGM0_200			3
+#define JHB100_SYS2CLK_JTAGM1_200			4
+#define JHB100_SYS2CLK_JTAGM0_100			5
+#define JHB100_SYS2CLK_JTAGM1_100			6
+#define JHB100_SYS2CLK_JTAGM0_ATPG_TCLOCK		7
+#define JHB100_SYS2CLK_JTAGM1_ATPG_TCLOCK		8
+#define JHB100_SYS2CLK_JTAG0_MST_WRAP_HCLK		9
+#define JHB100_SYS2CLK_JTAG0_MST_WRAP_CLK_JTAG		10
+#define JHB100_SYS2CLK_JTAG0_MST_WRAP_APB_PCLK		11
+#define JHB100_SYS2CLK_JTAG0_MST_WRAP_ATPG_TCLOCK	12
+#define JHB100_SYS2CLK_JTAG1_MST_WRAP_HCLK		13
+#define JHB100_SYS2CLK_JTAG1_MST_WRAP_CLK_JTAG		14
+#define JHB100_SYS2CLK_JTAG1_MST_WRAP_APB_PCLK		15
+#define JHB100_SYS2CLK_JTAG1_MST_WRAP_ATPG_TCLOCK	16
+#define JHB100_SYS2CLK_HOSTUSB_100			17
+#define JHB100_SYS2CLK_HOSTUSBCMN_500			18
+#define JHB100_SYS2CLK_BMCPER1_200			19
+#define JHB100_SYS2CLK_BMCPER1_250			20
+#define JHB100_SYS2CLK_BMCPER1_143_DFT			21
+#define JHB100_SYS2CLK_BMCPER1_143			22
+#define JHB100_SYS2CLK_BMCPER0_200			23
+#define JHB100_SYS2CLK_GPU0_100				24
+#define JHB100_SYS2CLK_GPU0_BUS_CLK			25
+#define JHB100_SYS2CLK_GPU0_APB_CLK			26
+#define JHB100_SYS2CLK_GPU0_OSC_CLK			27
+#define JHB100_SYS2CLK_GPU1_100				28
+#define JHB100_SYS2CLK_GPU1_BUS_CLK			29
+#define JHB100_SYS2CLK_GPU1_APB_CLK			30
+#define JHB100_SYS2CLK_GPU1_OSC_CLK			31
+#define JHB100_SYS2CLK_MAIN_ICG_EN_JTAG0		32
+#define JHB100_SYS2CLK_MAIN_ICG_EN_JTAG1		33
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index 9a0ab64abafa..d92bc4c6d830 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -40,4 +40,30 @@
 #define JHB100_SYS1RST_BMCPERIPH3_RSTN_CRG				13
 #define JHB100_SYS1RST_BMCPERIPH3_RSTN_BUS				14
 
+/* SYS2CRG resets */
+#define JHB100_SYS2RST_JTAG0_MST_WRAP_HRESETN				2
+#define JHB100_SYS2RST_JTAG0_MST_WRAP_APB_PRESETN			3
+#define JHB100_SYS2RST_JTAG1_MST_WRAP_HRESETN				4
+#define JHB100_SYS2RST_JTAG1_MST_WRAP_APB_PRESETN			5
+
+#define JHB100_SYS2RST_HUSBCMN_HOSTCMN_RSTN_BUS_NCNOC_INIT		8
+#define JHB100_SYS2RST_HUSBCMN_RSTN_HOSTCMN_CRG				9
+#define JHB100_SYS2RST_HUSBCMN_HOSTUSB0_RSTN_BUS_NCNOC_BMC_TARG		10
+#define JHB100_SYS2RST_HUSBCMN_HOSTUSB0_RSTN_BUS_NCNOC_HOST_TARG	11
+#define JHB100_SYS2RST_HUSBCMN_RSTN_BMC_CRG				12
+#define JHB100_SYS2RST_HUSBCMN_RSTN_HOSTUSB0_CRG			13
+#define JHB100_SYS2RST_HUSBCMN_HOSTUSB1_RSTN_BUS_NCNOC_BMC_TARG		14
+#define JHB100_SYS2RST_HUSBCMN_HOSTUSB1_RSTN_BUS_NCNOC_HOST_TARG	15
+#define JHB100_SYS2RST_HUSBCMN_RSTN_HOSTUSB1_CRG			16
+#define JHB100_SYS2RST_BMCPERIPH1_RSTN_CRG				17
+#define JHB100_SYS2RST_BMCPERIPH1_RSTN_BUS				18
+#define JHB100_SYS2RST_BMCPERIPH0_RSTN_CRG				19
+#define JHB100_SYS2RST_BMCPERIPH0_RSTN_BUS				20
+#define JHB100_SYS2RST_GPU0_RSTN_CRG					21
+#define JHB100_SYS2RST_GPU0_RSTN_BUS					22
+#define JHB100_SYS2RST_GPU0_HOST_PCIE_RST_N				23
+#define JHB100_SYS2RST_GPU1_RSTN_CRG					24
+#define JHB100_SYS2RST_GPU1_RSTN_BUS					25
+#define JHB100_SYS2RST_GPU1_HOST_PCIE_RST_N				26
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1


