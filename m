Return-Path: <netdev+bounces-274521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCK/Gy5izmmXnQYAu9opvQ
	(envelope-from <netdev+bounces-274521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:33:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3D2389198
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FBD8307F3BE
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5E33E3DB9;
	Thu,  2 Apr 2026 12:30:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2091.outbound.protection.partner.outlook.cn [139.219.17.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63769361DA8;
	Thu,  2 Apr 2026 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775133036; cv=fail; b=bJZD35kfGB1/z6RK0g3M1ReppK6DDfQLpar2ue0o/0itjIFn2rrLRjwu88SgS7mZFWQhUCfjobsC3uEBpG5p0Wr6AD/2NJUB4HAPFaRj6utSMD0wPi0879VGza2671hK+T/kDa2KqEOFimXeFSaUpcsX3KVmKj+OEu7qRmpdCYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775133036; c=relaxed/simple;
	bh=9zLZIeisCSiF9RxRipeAE5KGCtcA2iWTPIic+7TmhpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KyuyBVIBYmxN6kyFathJjvENS27V04mQHRfgqgh6chN90XopMJB1GtVcJPHIJlSkYCelEfCoIj/OwAlzXqOIopThXceXcqRvNYcpEU05+9zgRVzG94muEqF6iydOL9zBQVurBNLhBchjrt1/0zKK+lQka3fra4m8mFUPaLWONMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRs9x+FjjByTxCO7nA3JUU1swHnqPvk1kMkVO1dJEgIDH5kjiJdV/S/OIofmXa9q/PVNBhr5JswEpYYQ0rIJg6aVG32ws2hPmWCboAzydIOxESQzR2nWlMFTPz+QYGJmqCAgVCnU8nuQ8EEOS9gW1zhlBcNRmNal0AW95CKSJuE9jhLDe5iObcgimYOnrK5tbMMfNzwr4+VquaPD8pTA/F4qZDB4lPw4IVqLQIdjbnYMkHgC1++CoVE+uey/QzFxTDrcFluaVyr4JV3y9VW24YXGxqadPN26Tgo3WEhv8tWwhVo45VhrpPgypxV99T8wdh+rnO8dfBq9bW8K6XEwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/Jk/X13q2HcALSV8ddZHvuqxLTYd3pfaLbtb1YlmmQ=;
 b=mtid973kADEuQNOJZT3bTjQFbrZH5qKmKDGflBg800UYQB7PlgXbMqJKcPAUI4gZM6T5QVOHzp8+FukJVmhIoUhPiz2JYBh7YGyo4CBatihXbjW15P3bXMYjoMHpKmV9XD71yyDzZOOuK7a88y4kmwYpeNdJzuvRV4cOumk0jrtcfcUK5sY6xBk+1fDUsMd0SiMhd69NdhfcZPu+Qc3vk+UbzdXONP0Vvc9XOyroDQNK51032q3k1/jVZ519VYlR0VUFxEdhHVfr9W3PnBjStpoJlAqRQrg60cEXzkO4C6BJOKEkRNgQT0Vk27P+TL8mK4TMu4bA2p2/yJtKziKkaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:56:18 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:56:18 +0000
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
Subject: [PATCH v1 19/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-3 clock and reset generator
Date: Thu,  2 Apr 2026 03:55:20 -0700
Message-Id: <20260402105523.447523-20-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1208:EE_|ZQ0PR01MB1048:EE_
X-MS-Office365-Filtering-Correlation-Id: f382fb28-063c-4622-8101-08de90a67815
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vr7mlmDV2FNuHEGd/DohFjm1aEmLujgfo3albBZLhJGvbwvFNuOecPJ1QVy15UrH/jegkClqqo/N6qWdr4RXBAQWgm4tjRxTLq5l3nf2UeMT+xKQKXmh9mX9wrM+8ApBf9vpFlHYWrDkz7X9lnrLsoNLqNGLrXZwEX21Arx852XgDl4bE/5TKE5UU11ejE57l+/WJamaOP39gMOp9N6k0iZa0IAx3Hhe7Ycp07x+dZj/4gB166jpn243jt0VK/e0f6ULQdtF19Jskx771IPc00HlVMhBPOnv+eE+hseiIre0x0a1GG5ThcJ7anpZL2eVmMPaR7qzNO+YYafjWW3Nrb8AsJ5CHXP4Z3vi5ym7Ch3Qr+XlYMXaHW7UpTomiRCDrXuYqhT+Gq4+YfRbMPL9UzGRpmH+LcWhm3BUON1UyAhpDh+Y+5ZY9x6zftVp3RTWbFUB7I2KrqD4bR0h1y3WWOwk+I/ZXqKNk3wW++KCB32O61t/LIuYKVFzomR9UCrBry5dhDTtrHP0W8Cd0PoeKWxvMjFVmpszVQePEhKIi+1aDS4jT2SPmdxYBZdfeb7bjVbIRPbTslTC4duBk8tHAzc8yMh7CH0EjfhL22r16h4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lx1KjlPsmlLNKRCqz7zCHT4C5M4qDrbx0h4dvVoNIsoavtMOQKD31/fjwj86?=
 =?us-ascii?Q?7KRpEUgsmcZZ2HuY5vjY8LexARy+kaiTL5BVfBFjGg8LSFa3Y3DRATvxMPVI?=
 =?us-ascii?Q?vDIfR6BNLbZ7iM6Zud+2LEMRvKOYYhyoJjiIJw91dr188v9bXFiIYtmrWXxs?=
 =?us-ascii?Q?xDgND3wEX8ag3kpGM9rs+M2L02IsTxFrpi5xSKnyQsD5djXdpn+vyoT9hhWE?=
 =?us-ascii?Q?Q+HJbEzRzKyQteY1jDxdWxOXMuxgYKeC7QEcx5I7zFLOimo2GD+D50sDWZTm?=
 =?us-ascii?Q?IO17InlTodMwGDgFOL4STWaPwPT2OCGh3mru6hyvb6P9Yt6RiM8VNAwkwjJw?=
 =?us-ascii?Q?k64dKaKzM6lWIai5YXcsRuzSLV6qMDu83tQRpTKn0BNejnmJIy9YaiZVvTVN?=
 =?us-ascii?Q?Y4v4WLdP9j38MROxlu+UldGvu0skhHIJ2h7mgUWAQMdpAnrxWnmbUD3L3/u8?=
 =?us-ascii?Q?k2GezL77dZ5V3lYQ7Xv/AIlWK7ircwEo0Vivlgj0pF7UM8u8FvtUtOXLa7Ff?=
 =?us-ascii?Q?j/7CUv48h4Y+CqypRvlmolD8cOt0ZUc5mRKIcNIOtY+FOHuIevtySCNEjWKt?=
 =?us-ascii?Q?6H3lW1t/QrHqY/+ExGQhF9QJJ6c47cDINpqtX/mis9DLnOUyyZyc471bPFvj?=
 =?us-ascii?Q?8+ImJ8AjB+vnQBrPBQLUmVLFCD2kkMjNj6Fyaw0MEajNAUAZX7BXZGG0Mj7D?=
 =?us-ascii?Q?vpYwG7whdU4vyyf6RTmKraHJoHP776+kqa45vYUuQz/SULDboZxLjpf5g8M9?=
 =?us-ascii?Q?6xPseVqd3yOskoHWXpX+XfdmJG9a1qyM/vTVyyozKbmk5QJtvmzKy0NL+Pzy?=
 =?us-ascii?Q?gNBH3a9LauAwGzivq+P+IdWbd9cX3nFwNRzUWXYVQlEvMSHv24s7nVEpeBHR?=
 =?us-ascii?Q?OQjvl8gx/MQjjsRWrrxjmpXzkf/yNLsYvX0jzvSMwHg4C2WiYwfy0g3ueGMz?=
 =?us-ascii?Q?mme3vFeJ2U+DkOcauAg2+XOQkzAZys5UghvGjdOjCuAI5r4S9Cca0Hv7DD0K?=
 =?us-ascii?Q?yMC76Na0lsbb5rK3bbWPIQjYMBsvWx20h9WEenQDEGj37YaHYbUP7FI19+a9?=
 =?us-ascii?Q?t5+PkfrrEXoafAxgIWzvIsRMXUvK3ER4/F/t7qj2l/h+zneXsJutiH27AQAl?=
 =?us-ascii?Q?JPlHpDCM5+wYtlq1wV9jV4YZk0jKQ6Wirk9HRSkfdwpirRlZRXKYII4EElcn?=
 =?us-ascii?Q?CQrTqwUww6p+LuxfK2c1qxhDOfH4322BR8cqCvgK8MeMWtNQkPRJGc4coJYj?=
 =?us-ascii?Q?gpwWFGfVBySVwn2jgk7KFrFKSdxFBNUt0eQubluIWq+SNyk98x6d1dukDBMl?=
 =?us-ascii?Q?Xvmrljt+z53gxRBzzTBMwc3M264vrjYnVsGDzx5Y9L4bulMh2VfjzgGHJCjw?=
 =?us-ascii?Q?+r2TTln60ntATV6OUX/CjsXvW/T17kl/nOkxNJOz85pu3z4p3u5LKU+6dnBo?=
 =?us-ascii?Q?L6JDGvBrbuC7kF4U0AQEBpGewDQDoBSNr5NUNohexcKRG2WIk3Z2RIq2TZLg?=
 =?us-ascii?Q?yM/geLtt8rvIUhTi5Ze7v05WaxOrdkHjy5ileHupN+bxR55HkN76SCOPqIh/?=
 =?us-ascii?Q?UQciI6p9o0pvdeP2Ualpudoc3kVX72sr/RW/7PnguIQe4nRmrdsxSe63cA7B?=
 =?us-ascii?Q?lOQWKFkFYZGaUpY4y3QZha1Gqq1iSfH4Y7+aUYaQ+0T/wQsAwJT+dMjm0lG4?=
 =?us-ascii?Q?yz0i+UMOmi4RcymuclC4ircUhxr1xPA44GY2o67ais84Zv9nA6ja49517z0c?=
 =?us-ascii?Q?1chxMxl8JKF6lPPNTgK+GAZo1lmmLHKHwD1uab9o/ZLIb8dJRaOn?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f382fb28-063c-4622-8101-08de90a67815
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:56:18.8474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lf+68vTWrTnchQ3Ii8cJXRs5cvki8di+tUN+DybJ5EgkcNBN2/4/RArKME6SHAnqd2PAlYgTUqU/ytySUiC50GrMLdkXZizUbjWPcupQLo0qM/gHo7wG7IM7I5mMlMd3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1048
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
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274521-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.621];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,starfivetech.com:email,starfivetech.com:mid,11c40000:email]
X-Rspamd-Queue-Id: DC3D2389198
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings for the Peripheral-3 clock and reset generator (PER3CRG)
on the JHB100 RISC-V SoC by StarFive Ltd.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clock/starfive,jhb100-per3crg.yaml        | 78 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 35 +++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   |  9 +++
 3 files changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml
new file mode 100644
index 000000000000..5043e97d2f28
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-per3crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 Peripheral-3 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-per3crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral-3 600MHz
+      - description: Peripheral-3 100MHz
+      - description: Peripheral-3 125MHz
+      - description: Peripheral-3 GMAC0 RMII Reference clock
+      - description: Peripheral-3 GMAC1 SGMII TX
+      - description: Peripheral-3 GMAC1 SGMII RX
+      - description: Main Oscillator (25 MHz)
+
+  clock-names:
+    items:
+      - const: per3_600
+      - const: per3_100
+      - const: per3_125
+      - const: per3_gmac0_rmii_rclki
+      - const: per3_gmac1_sgmii_tx
+      - const: per3_gmac1_sgmii_rx
+      - const: osc
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
+    clock-controller@11c40000 {
+      compatible = "starfive,jhb100-per3crg";
+      reg = <0x11c40000 0x1000>;
+      clocks = <&sys0crg 65>,
+               <&sys1crg 18>,
+               <&sys1crg 19>,
+               <&per3_gmac0_rmii_rclki>,
+               <&per3_gmac1_sgmii_tx>,
+               <&per3_gmac1_sgmii_rx>,
+               <&osc>;
+      clock-names = "per3_600", "per3_100", "per3_125",
+                    "per3_gmac0_rmii_rclki",
+                    "per3_gmac1_sgmii_tx",
+                    "per3_gmac1_sgmii_rx",
+                    "osc";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index 2ab505437118..6b7d53a0391a 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -504,4 +504,39 @@
 #define JHB100_PER2CLK_MAIN_ICG_EN_GMAC2		69
 #define JHB100_PER2CLK_MAIN_ICG_EN_GMAC3		70
 
+/* PER3CRG clocks */
+#define JHB100_PER3CLK_300				0
+#define JHB100_PER3CLK_200				1
+#define JHB100_PER3CLK_GMAC1_PTP_REF			2
+#define JHB100_PER3CLK_GMAC1_TX_125_MUX			3
+#define JHB100_PER3CLK_GMAC1_TX				4
+#define JHB100_PER3CLK_GMAC1_RX_125_MUX			5
+#define JHB100_PER3CLK_GMAC1_RX				6
+#define JHB100_PER3CLK_GMAC0_PTP_REF			7
+#define JHB100_PER3CLK_GMAC0_RMII_PLL			8
+#define JHB100_PER3CLK_GMAC0_RMII_MUX			9
+#define JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2		10
+
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_TX_I		17
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_RX_I		18
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_PTP_REF_I	19
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_RMII_I		20
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_CSR_I		21
+#define JHB100_PER3CLK_ETHER0_RMII_ACLK_I		22
+#define JHB100_PER3CLK_GMAC0_RMII_RCLKO			23
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_TX_I		24
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_RX_I		25
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_TX_125_I	26
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_RX_125_I	27
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_PTP_REF_I	28
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_REF_25_I	29
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_CSR_I		30
+#define JHB100_PER3CLK_ETHER0_SGMII_ACLK_I		31
+#define JHB100_PER3CLK_ETHER0_SGMII_PHY_PCLK_I		32
+#define JHB100_PER3CLK_MAIN_ICG_EN_SENSORS_PERIPH3	33
+#define JHB100_PER3CLK_MAIN_ICG_EN_PECI0		34
+#define JHB100_PER3CLK_MAIN_ICG_EN_PECI1		35
+#define JHB100_PER3CLK_MAIN_ICG_EN_GMAC0		36
+#define JHB100_PER3CLK_MAIN_ICG_EN_GMAC1		37
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index 102af1042903..4b15e348e92f 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -181,4 +181,13 @@
 #define JHB100_PER2RST_ADC1_IOMUX_PRESETN				14
 #define JHB100_PER2RST_MAIN_RSTN_PERIPH2_SENSORS			15
 
+/* PER3CRG resets */
+#define JHB100_PER3RST_SYSREG_RSTN					0
+#define JHB100_PER3RST_MAIN_RSTN_GMAC0					1
+#define JHB100_PER3RST_MAIN_RSTN_GMAC1					2
+#define JHB100_PER3RST_MAIN_RSTN_PECI0					3
+#define JHB100_PER3RST_MAIN_RSTN_PECI1					4
+#define JHB100_PER3RST_MAIN_RSTN_PERIPH3_SENSORS			5
+#define JHB100_PER3RST_IOMUX_PRESETN					6
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1


