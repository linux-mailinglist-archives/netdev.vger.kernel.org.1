Return-Path: <netdev+bounces-285649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPYfOaR4/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:46:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0AE4F20EB
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7652A3089A3A
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F823750DC;
	Fri,  8 May 2026 05:38:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2106.outbound.protection.partner.outlook.cn [139.219.146.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437136D51D;
	Fri,  8 May 2026 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218676; cv=fail; b=JGssX5JTKaDjGXcioWNIYMWLa1JImSJQxJzS189jJ8IDqXNxxyLfhiJyKbotz1DiUE987FSc6CWP6VYWqX3kXNRS5sSXx/ssmXH6W5Tyvji68GbbvJeX6bLNNAdRralSFp5sv8NdFWm0P0wDrSH6SWMEuaZ6XHdfevn5PzqVRrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218676; c=relaxed/simple;
	bh=hkoXDNq+f1DW9ZwakjIqEB/3wARug1SkLniVIJIIfPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=INqMq3wUYCCoJwoXRmncdjIemzp03IeyJXdrIBrDMZRBxyjfkzdo8p8a79GKaKUFp5mH06LU3dJTpU6magtey72sx3wkzuRYcnArZDxs1rlGYRt/lxvVF40Oj7EwsYIEbknNYyVNRiVox+VU51CmgMulsrTznk/mE88Cd2s8GEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcWUhi3qEgFEHNPA5g23CY/fet+7kwnMUZJtgs+9vxeBLgHwNidYn3D3FGTA0l6cE7vJekuzKXGTWJ9nm2dyqQoUZkc+UGVtpXfnV7qXw0zln/F7WwwP+ctU9P2VnpkmDXnPFxOR5vdVBj4JztkIoE7uIf4rFtBtKeaRRzky9IqqFzf+LHtvbYjHQCiS9t8O9WiDQqWmMmw9GfD+tGb8NHWTzfnHJKmO1hewuLjC3mpbZbRPMix18Tu+T0NlfRHwExTsHiWAMDSc4742W8KMiBAmqVQR30PGS7nBpORYM0xasxMJvmrCNuDOq37O3Onu0f9rC6Zm7Uut2FP9DOiCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCXZH0retUinc5KBiQ3fQFC0XeQCWBuZNAsJT7CDPLE=;
 b=mT1xmyRFSPehHOlITQZtCP5ZqGpy8nZBFzFBv9uALn6EEwLsHOo4/2C313Nm5gKEW+g3OzKPzs4mOrZkW6uajPQ9vpY8tcG8StBa1SgE0hpSEWYQVgfqdFoCAjhpFnATKBaMrjnvgI1GAydxOjI3AY6tX6KhCVQhFFXvF98J4EiRqjyKGnizryMcWvcVuVNzJlxmESuP1leNpAgdr0ZF9mL122QFxOjNMpl1fk3LM7YQG5hVHG1ucmZONTgxRxyYejZRCVt2/ll4i3GY4D7ssHwT7llxvdBGwq5Y+uc1/pIMQR8LxEjiT8hWwrppdE7M9DMElMkqogEt0d4Ld+RytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1252.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 05:37:14 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:37:14 +0000
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
Subject: [PATCH v2 19/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-3 clock and reset generator
Date: Thu,  7 May 2026 22:36:29 -0700
Message-Id: <20260508053632.818548-20-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1252:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d151928-e26a-41b9-02c1-08deacc3dc30
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XKeuqXMymxmJ8iCAXiMrpJ3jYXgoqESDKh9cNAOjSxYkbcfBoKSS6Ur2G/cSdGmgNBrQKL4ObEEzJQFEcgzfiHXD0/tLoWESVpRZWrzKCHz3Gvm/mDcY4R9z2KlWRPlYlKGPg5qeZbl2svkDZQgddbTtZBx5uHpkY/z1aUAOGOI29/u9Tvzyqibg0D+KCBvMEz6ZZYNeGGpLEVOMMJ8iHmbi2AZ78OHtZxF9oHaozznLlRsk1qZyD1IKg+Hdw0vsUiu8sJ3SYsVmWlIVJxQJgo56CoW0SL6QIVBRg9FQUwO1HpYuG3lWJGGz4/omHlPlEWjDpMxM7Xk1NRr5xJY+KMamaMk/iUXXYqJkXEow8zp66AvssDppia7u6p86yqSEbmFGKd8VDwGYCl52sPGkMbSrCkJN6SYRpxVKpY15CusCu0vih8kyXuq91rkw76JkQ0hyEH6oSPgExkWfYql2r+rY0CWkKAn2g96a7Vnikg72ectl0dUjnjQp2qudoDNjohx5lsxg11dNnmI/klbKBXO7fR4q041wq07sH/JyaRpXguzevg/z96ZeGmDMB2mKV4yl/TDPA4DBb4gWmV5gfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q5dnRLAy3LmV+CDPlW4J4CmMkcDleaC+z29G25D0qZFbT9f6G/y2z37HuU5w?=
 =?us-ascii?Q?/dwI8EibYdSRiaBrGovSnh9jlWgsF1gNTl92Ufz0naELyrqkLFotprZszmPB?=
 =?us-ascii?Q?Es6+Mf4rmqgGIIFtE94i+XT+9GkXRSXuHTm/q4Ld8LldzY71eOwgrAvBRZ4v?=
 =?us-ascii?Q?n7zkwK4srbP+82fRXZGQy42ZgUEqfn+jSgFb/5AGBfiaId84w43YsTAMyVoA?=
 =?us-ascii?Q?e5Pzo7yXCSQnptBM2GOFkdpQVQGqWF+lZqoekg7EGEuJv/IS0NUUt41TJo7J?=
 =?us-ascii?Q?QD2liz+goYE8xjr/bGGOok2ySbEqK+Fu89GA4dprhu6H7mGZ4yGXIbqBhvfe?=
 =?us-ascii?Q?zYCnFuPNDbdvFSKcXfY8D4fAI323u+kETl2Y0vqEX52JQ3bU4cRe6un7Yvpj?=
 =?us-ascii?Q?o4Rjb3QmhSbxa4aD7zFGALY1du7LtGBeFbTAf7YPpqYfFH3qt5kg/CzjrlMz?=
 =?us-ascii?Q?YwJdVl3EKLa5CHVoSIAn9bb7ixP40avuRuz+/4HMeGAe9qNuHwkqCgxgzQGA?=
 =?us-ascii?Q?IMc9cT31fLaTFo5ckgTYPTleKZQudEsha6FGR9iiS1zqr0jSZDKfDUb6Bs+4?=
 =?us-ascii?Q?TRiTXXh0B6eDR5EMs6Dc9EesvwhiM+EDKyCRG8ymLtlK8PfzASZ8XpbUysw4?=
 =?us-ascii?Q?6GVTOpeA5pujI9zfvnUbP+DtSVYmGIGD3jwUkDT+9Iq4DjStSY8iQ/4rYaAL?=
 =?us-ascii?Q?KkWUkP2Ckh9uQIUUVNCLgbK6hINMsrVXfxLdWf0gviK88QOhnEdSbOMuYYE+?=
 =?us-ascii?Q?qCOgTz10X2+R7+8MPfoj38B+q8eFdAtLkh9RSp/bYnPfjWNG5qwK19QSRDwk?=
 =?us-ascii?Q?FBG+grUzQO/6kfhOkSr+X0nrxIMW+pe1d8ooHR2auQ5MkcRdI6G6UiCH+pBK?=
 =?us-ascii?Q?hZc8ByFPHzROw0RyTS3jb5qzZWEY6tsfeE0SbosWWNlhB/plCvJxziYnCLlF?=
 =?us-ascii?Q?+G2FXkl+u5lEwoJbQ9h0PVJrmgFmwJpqDYinCRLCqSePpYmdhNLNz8Mwchku?=
 =?us-ascii?Q?xQ09Cu3fW/xU5LZuVhlbK1hksDTzb7MqyDgcBUixRd4YPVHIHSpIEwNjJmhf?=
 =?us-ascii?Q?IHCTdOv09ZGyKHFlvjmWcO/tsgRJb0igL6Pp9R3QCu+M61w8eCd/immDlfYA?=
 =?us-ascii?Q?xCPNJ26Lezv1fJFSc5eJURi9DFynh8YBOCBI+TnH1472qSU4zD1zap146/A7?=
 =?us-ascii?Q?bkcHkfWUYUxJQc2z85y+Zk5EiLEn+fLb84/klNGcpdvYALY6ZdsgxcdpFcbO?=
 =?us-ascii?Q?JdzVRnNMGyCNEyNIjdjMJTYqHBoXENjGAtw4V9PyfBYdx4NknpFHOKylVqTA?=
 =?us-ascii?Q?HT8e7aeH89TJpWfsY/OAadZPpR5fOqn1SL/QAk9VtVWH/u0S7InuZ3LeoMEq?=
 =?us-ascii?Q?mqq2537E08eGszAA5ujstjmh1TY1NM50RIhgeg1w2iCfW3dnIxklmy8tnbeA?=
 =?us-ascii?Q?gwDy+GOCYyXeHfTVJxIZ4Xe+KwiJmAfF0p5fXFAcwvcymYjtn/UaGY+d+T78?=
 =?us-ascii?Q?VqwDD5Bu81wasi/bChbQtJnWoqvr/9VdUKthkp8KDE7x3DFIV5Mu4oCu9vx6?=
 =?us-ascii?Q?rAZHurRUdhCpjBP4rSUfBIPtL3OnNDKvKGZWQ1R5zkHlIeb5tZ9JWHK0c4YG?=
 =?us-ascii?Q?RVadUGOtT0F0jO7nkNWG4Z/Rq9sbu2+mvUZ4lVgp5PzPA9UFOaE2MR7PyX0d?=
 =?us-ascii?Q?sdUPQZsfkvnK/Xj6/XNBjBnZPjgsQZ/rlNbwlminKHgh17ozbtCS1fkelNdc?=
 =?us-ascii?Q?yy7btWkPgmoTTVdhdeaLCXOztT38f9L0k/2P4UKzlPu/0rFHLrFb?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d151928-e26a-41b9-02c1-08deacc3dc30
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:37:14.7437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Stn2HKASKcI7U+w+FsjnjEx+eB2mx0l2y42ikzUK1+Ub42CejyOY2xy1F1ov9m4W7Ed5IccOM1pfvc43S6FcS5uXOUZU4rOwtGunT6VL07HES7z8GVBX4IKpsd2gRYA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1252
X-Rspamd-Queue-Id: 4A0AE4F20EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285649-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.739];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,11c40000:email,starfivetech.com:email,starfivetech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add bindings for the Peripheral-3 clock and reset generator (PER3CRG)
on the JHB100 RISC-V SoC by StarFive Ltd.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clock/starfive,jhb100-per3crg.yaml        | 76 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 35 +++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   |  9 +++
 3 files changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml
new file mode 100644
index 000000000000..996993ca0666
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml
@@ -0,0 +1,76 @@
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
+      - description: Non Coherent NOC Initiator
+      - description: Non Coherent NOC Target
+      - description: Configure 125MHz
+      - description: GMAC0 RMII Reference clock
+      - description: GMAC1 SGMII TX
+      - description: GMAC1 SGMII RX
+      - description: Main Oscillator (25 MHz)
+
+  clock-names:
+    items:
+      - const: ncnoc_init
+      - const: ncnoc_targ
+      - const: cfg_125
+      - const: gmac0_rmii_rclki
+      - const: gmac1_sgmii_tx
+      - const: gmac1_sgmii_rx
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
+      clock-names = "ncnoc_init", "ncnoc_targ", "cfg_125",
+                    "gmac0_rmii_rclki", "gmac1_sgmii_tx",
+                    "gmac1_sgmii_rx", "osc";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index 2b2e148ce5ce..bdf7d628b381 100644
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
index 0965f3798397..872a4dd25beb 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -174,4 +174,13 @@
 #define JHB100_PER2RST_ADC1_IOMUX_PRESETN				13
 #define JHB100_PER2RST_MAIN_RSTN_PERIPH2_SENSORS			14
 
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


