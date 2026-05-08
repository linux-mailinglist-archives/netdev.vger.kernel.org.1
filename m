Return-Path: <netdev+bounces-285663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mANSIft5/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:51:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 650C74F21CC
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4541301480D
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B74B36EAB9;
	Fri,  8 May 2026 05:51:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2091.outbound.protection.partner.outlook.cn [139.219.17.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7233624A8;
	Fri,  8 May 2026 05:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778219510; cv=fail; b=qJWTSJY27c1NMJHFZyjY9GJSDt5TNoigU57r3EsjA2v7ulpwKBqWMwVnCGV/uZTIfloMxt9HF11Hv+cKGemsfFoNeCZWvxx16sAfRMjBaHrFrIy/lXnDuw9PuM24T4LDjAKRHz8OwCb8h+hBQfoMTpPmpbU0nweP2afxeEy74FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778219510; c=relaxed/simple;
	bh=GhzMed63HIQc4xbb/xwzA3zmMnvAZ+NugsS9zmfPXbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iljmKLqKU/P34tMXTWWMXqpUvbcaVdUaU8BL8BCOxMJgMQJ8OEvN6HzkHuaN6oqLnDdXc+x3YoUkLX5S/B3Dy8x1cyvyYfV9o8+5Tsk8VDk2tN/6XEscSPfy5J6q1SW2HlUG3FyYRy/h2uqm5OY1vk4mtPjsf3VzPQ9JMTqAg6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahz7aHGZ77qmNn57F9WWwaK8/jN5iOAHjk7N7Jsx6gOLm2WVHLq78gV0666pZH2TD5Kk5cl41zPsXl1QWpcm2Hq/jhbsGGRRNXRnnUgmhfsgBen4OsN8uazLklfK94QjIcswr+umBQJR5lvwFedjs4SJL8Po8sMHlV+h7r/DaTJhfhIT8v6FWlGWsU5S5TBZfQxjCfbeNleqpN1U/siuAa7zmpFZKR+qSjW8MsN/Dca5IyeTBB3NfrlGa8fQWxHJh+rq5YKjerm24+jgeD0g/5jWUYATuJe8bGP0TW628E5k/m1vQHM4UHMtGgLQIu5/WaNI/4uUtflVkVzOI/09ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eamcrScjtDdh97V8cls91FnCf1KfhJ91T8QW7dIri9s=;
 b=FHyKmqnZDmrvgU1KGkZYfCP1qBcu7avlXWw/r1gnaysI8uvR3jGOXz9zIcaeu4ux4OYuChrlsRkuFYg0e49W0KFMZQh4GjlKX+5LajtjLw/PT71PGnjbP20yPAILN2pHvZrs5KujjEl+VM3HM/8C60iY+7dyPiheemL5/Z4jZbkiMIvzuiYe3pz+A80JEvuLzYI848CPahzUzOaKhWAz6IgeqBGvNnWyZO1Bkn9blWa9ciaablkEA9BH9OkT7OG9O9OulDDGNTCl4OMfk8ZHD2a3/vTSzXrHJjKyKbK472Nwv+IT8nunQ6HDbLZ6YWWpjR6amASpjvT/kXDAcJ/VQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 05:37:01 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:37:00 +0000
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
Subject: [PATCH v2 11/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-0 clock and reset generator
Date: Thu,  7 May 2026 22:36:21 -0700
Message-Id: <20260508053632.818548-12-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: d12eda47-e774-4673-9d0b-08deacc3d3eb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|56012099003|38350700014|921020|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	j41VBCBnntBfdq03wKRtZsmXOa5TwVHkZmJWdaLdY0WG79fwiB7jbum9CvsmZmyjjqkiOcmQjebAhqK2aLeuVWvhVkBV2vjNuyTGFTe7kwGvL3VAZogCtA4bavcsbOf4I/tD0Xxge1+/7my1r20RVV5/D8/8p2jz6kxATtSiDKpu/t1kxykoJKjAhTq9HHspIdnd0lIdpZrAKUs3kI0PqSysejDMoLRp/3OUJ7sj1fVjgySjPh1qPSEW7xRGlJK9P8LRig7ahcEsbR0JZSvrzs94FwAuAGNA31pTZk52OdVWzo9nYY1Tp5ZB+6CN+NSAPWRifgwEyanYT5SJO4hIA0WJzYkSspEjH6qVj5an8offf8nCmsUpWLRaBeL0jfNVRIH7IUZeVB2f92PLeEzrnW/4OwGgbfZ+nXu8QBotqQnRUi935l2Uk+cd6RqfEr4Web4lkIUVNiaBF0hojrdILcdmFKtF9ri3iFhYPKB0mpzUVF49J1/n8/Fxr1I7NcyxkmsVf5OPCG7ujJfclDIUqX4LUO+9j9viUhqKgb8yDtJHjL7PWpTk5n0HDnXXrSpAJbO8cjwgvAA+zPnyg3mkYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(56012099003)(38350700014)(921020)(3023799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O8FPHu/XyV61P3d8NUcTqszt3zVvluAtcp7OPmWmUY0G9o/UekL5W6117jpw?=
 =?us-ascii?Q?s37rby3tApDl9NtxuD62W3YhXzNN/mnxu5Yz5rEvOi5noFohoOhmnD/ft+nI?=
 =?us-ascii?Q?Ab0q+v/hGkoPOor3WoQAAUrvJAi4iDq/zhI6nrZPEPW4yhNwnBypx18xXNdX?=
 =?us-ascii?Q?0QUF6dhud9crduQ8ZeVR+OiCiEuF4Dc3PWzoB0CDbeNbC7T09osCwgnZcJVi?=
 =?us-ascii?Q?YDSS8fyXizUBde+mmbtEY0tSrwp2bf05OyKOv5XTb06O7cZiaL4kuCVeGmHH?=
 =?us-ascii?Q?MDW6rIVT5rNFqjrDOG1FTGZ9/f9WYSi9Co3zl0O6kqVRAkrJNjeCUzOQrz52?=
 =?us-ascii?Q?f/LKpvFAHepWiO2ZLIKiciLlauVmUm8JUs5qr13TGsRvtgbU31cZPhStDc+Q?=
 =?us-ascii?Q?5wxWuJRK1XkahPrYzRkSUdaamPQ9gFoY6jEpK8pg6RfzD2WlV6rWbOu7ggGW?=
 =?us-ascii?Q?Pg58uarerodTeaLd6HgaJv0cskQk10f7yKUVJUbDZAsXzq6NSRerjVIpX1Ze?=
 =?us-ascii?Q?Z7hwx3195UYNcBjRLZLxk248WvlSZHxJZrsZHi7XcL10bhmIuQAwY3IwCtQu?=
 =?us-ascii?Q?JZgyZ3tP7ZMI09XvHDcTKqUoTfq5CJvtUIkmP+CcWNjUEVkvj04fJzLhPYZY?=
 =?us-ascii?Q?FHBqwr5rmhmJ8PQe5BO706pHzFFR1ev2CyTqm93OrKGdaKJXgMFi5PEUGxjt?=
 =?us-ascii?Q?kOi+oqcH1eSKKutKSYojZyPJQIg7eoixsc1ikM62YWmhxi3IbtkdXZfrFTQl?=
 =?us-ascii?Q?ZRi3z7pLlh2BpV8T53KBHGySshND/IuqYlGrNlBLCuiQ88SeLNyRx+GDDQp9?=
 =?us-ascii?Q?5f1ZRF3bBEeM2WSx/sG5LPnrqvpwAexLKRL9/bBwdGcgcknzEhrV85x2batU?=
 =?us-ascii?Q?cFQPmmASNxjymXHh4staVPZPqC8G6YRw+alI5hcTbybMhR2IU7gSOu1xdv6N?=
 =?us-ascii?Q?oCNq48/h9H6kgK7qLqWxY6sZb8iNmtCNAguUj//fRcCvDGsFMXGmx6YmdN/L?=
 =?us-ascii?Q?BPLOzPvXEYFAISVcQQDkbZUVsEEOvDuW3+Hsv/5fyCZ0KUh3qGMnZVEafh2+?=
 =?us-ascii?Q?h396caf/nGDYu65Lq7KmDxJ1rqUZzNYvU3wdAWPZ+YRN6aatX/PciYc4hHbo?=
 =?us-ascii?Q?NrcqvOwohgbPc8t8BwYfLQrwYfL86t2lXvkDC1nyjEyfbJh/dEKTq6BD0WAS?=
 =?us-ascii?Q?WoS2jGX6oRuqFwErxuHxsoz6yNSD3sz/qRGHPEp3tt+KPjtUAJxy/kiVhi/K?=
 =?us-ascii?Q?J7Y40xYdXwhmTJWugJlnQPDrko/T5K6LyBVVo/fMVKjLXnffp4yGP0MBMiW7?=
 =?us-ascii?Q?eYxP5Nn61PoUKGKGFFIxlHt7lUbflc2Af4EAAJ1cLa+UE+mz9SvW20V9nba7?=
 =?us-ascii?Q?jUTCJ3mtA4MMLoUI27Lq40u6wqYOm3gnqRWUwsKJnRqJE/8EEfjH6OXeF6gK?=
 =?us-ascii?Q?xKklVhnRqgg1edr4hJhRPQKdNkGCt5XCMoQxGLgKAhSFdsUccnhTO60R3/UT?=
 =?us-ascii?Q?Wg/Wlg4YKFaiXvg/FbeA9ReRnL3Fv4Y5wmf+SAS4zQ1WWGiwhNrd1iUfao6N?=
 =?us-ascii?Q?StdNfRrSIOT3FWBGSAT5bTle/SDE+oSghrcokJfABzGdZdhscbbzn0EuJxAm?=
 =?us-ascii?Q?n0mxdF1JWTUFwTh4EuOIFZDuJoz+elJiQKe+7BuN4RMB4r9XphOslLMIcegs?=
 =?us-ascii?Q?oCrduvF6/qHmnpet0fiotOhCc/0SgPiWivNwEw5DCJQc/P2asnOmZ9y+XeEY?=
 =?us-ascii?Q?sqEkN8hatSolP4so/f6mAXik56tgXDiK+aDlvUb1Pf1giCHa72o9?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12eda47-e774-4673-9d0b-08deacc3d3eb
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:37:00.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNANC7XsSbfid1V7kbsgEEoiDIrRm1+FJljl5yLYtFlS2RAuNW1aKYeHIbPvrC8JsjkE4VJDd3CbbRVB0IKzJ3UGTBi8ZNRCsD6t+RIotCOgf41zlREibtHa5O1DRGn7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267
X-Rspamd-Queue-Id: 650C74F21CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285663-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.881];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[11a08000:email,devicetree.org:url,starfivetech.com:email,starfivetech.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add bindings for the Peripheral-0 clock and reset generator (PER0CRG)
on the JHB100 RISC-V SoC by StarFive Ltd.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clock/starfive,jhb100-per0crg.yaml        |  70 +++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 281 ++++++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   |  77 +++++
 3 files changed, 428 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml
new file mode 100644
index 000000000000..d3d426a741cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-per0crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 Peripheral-0 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-per0crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (25 MHz)
+      - description: PLL6
+      - description: Configure 400MHz
+      - description: Configure 800MHZ
+      - description: Non Coherent NOC Initiator
+      - description: Non Coherent NOC Target
+
+  clock-names:
+    items:
+      - const: osc
+      - const: pll6
+      - const: cfg_400
+      - const: cfg_800
+      - const: ncnoc_init
+      - const: ncnoc_targ
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
+    clock-controller@11a08000 {
+      compatible = "starfive,jhb100-per0crg";
+      reg = <0x11a08000 0x1000>;
+      clocks = <&osc>, <&pll6>, <&sys0crg 71>,
+               <&sys0crg 72>, <&sys0crg 70>,
+               <&sys2crg 23>;
+      clock-names = "osc", "pll6", "cfg_400",
+                    "cfg_800", "ncnoc_init",
+                    "ncnoc_targ";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index d19618e2a846..add2cd093dbd 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -106,4 +106,285 @@
 #define JHB100_SYS2CLK_MAIN_ICG_EN_JTAG0		32
 #define JHB100_SYS2CLK_MAIN_ICG_EN_JTAG1		33
 
+/* PER0CRG clocks */
+#define JHB100_PER0CLK_CDR_I3C0				0
+#define JHB100_PER0CLK_CDR_I3C1				1
+#define JHB100_PER0CLK_CDR_I3C2				2
+#define JHB100_PER0CLK_CDR_I3C3				3
+#define JHB100_PER0CLK_CDR_I3C4				4
+#define JHB100_PER0CLK_CDR_I3C5				5
+#define JHB100_PER0CLK_CDR_I3C6				6
+#define JHB100_PER0CLK_CDR_I3C7				7
+#define JHB100_PER0CLK_CDR_I3C8				8
+#define JHB100_PER0CLK_CDR_I3C9				9
+#define JHB100_PER0CLK_CDR_I3C10			10
+#define JHB100_PER0CLK_CDR_I3C11			11
+#define JHB100_PER0CLK_CDR_I3C12			12
+#define JHB100_PER0CLK_CDR_I3C13			13
+#define JHB100_PER0CLK_CDR_I3C14			14
+#define JHB100_PER0CLK_CDR_I3C15			15
+#define JHB100_PER0CLK_200				16
+#define JHB100_PER0CLK_600_DIV6				17
+#define JHB100_PER0CLK_600_DIV6_DIV5			18
+#define JHB100_PER0CLK_TIMER0_DUALTIMER0		19
+#define JHB100_PER0CLK_TIMER1_DUALTIMER0		20
+#define JHB100_PER0CLK_TIMER0_DUALTIMER1		21
+#define JHB100_PER0CLK_TIMER1_DUALTIMER1		22
+#define JHB100_PER0CLK_TIMER0_DUALTIMER2		23
+#define JHB100_PER0CLK_TIMER1_DUALTIMER2		24
+#define JHB100_PER0CLK_1200_PH0_LVDS0			25
+#define JHB100_PER0CLK_1200_PH0_LVDS1			26
+#define JHB100_PER0CLK_1200_CORE0			27
+#define JHB100_PER0CLK_1200_CORE1			28
+#define JHB100_PER0CLK_1200_SHIFT90_LVDS0		29
+#define JHB100_PER0CLK_1200_SHIFT90_LVDS1		30
+#define JHB100_PER0CLK_1200_DIV5_CORE0			31
+#define JHB100_PER0CLK_1200_DIV5_CORE1			32
+#define JHB100_PER0CLK_PH0_LTPI0			33
+
+#define JHB100_PER0CLK_PH0_LTPI1			35
+
+#define JHB100_PER0CLK_PH90_LTPI0			37
+
+#define JHB100_PER0CLK_PH90_LTPI1			39
+
+#define JHB100_PER0CLK_240_CORE_LTPI0			41
+
+#define JHB100_PER0CLK_240_CORE_LTPI1			43
+
+#define JHB100_PER0CLK_AXI_DMA_I2C_INIT			45
+#define JHB100_PER0CLK_AXI_DMA_I3C_INIT			46
+#define JHB100_PER0CLK_AXI_DMA_UART_INIT		47
+#define JHB100_PER0CLK_CORE_DMAC0			48
+#define JHB100_PER0CLK_CORE_DMAC1			49
+#define JHB100_PER0CLK_CORE_DMAC2			50
+
+#define JHB100_PER0CLK_HDR_TX_I3C0			78
+#define JHB100_PER0CLK_HDR_TX_I3C1			79
+#define JHB100_PER0CLK_HDR_TX_I3C2			80
+#define JHB100_PER0CLK_HDR_TX_I3C3			81
+#define JHB100_PER0CLK_HDR_TX_I3C4			82
+#define JHB100_PER0CLK_HDR_TX_I3C5			83
+#define JHB100_PER0CLK_HDR_TX_I3C6			84
+#define JHB100_PER0CLK_HDR_TX_I3C7			85
+#define JHB100_PER0CLK_HDR_TX_I3C8			86
+#define JHB100_PER0CLK_HDR_TX_I3C9			87
+#define JHB100_PER0CLK_HDR_TX_I3C10			88
+#define JHB100_PER0CLK_HDR_TX_I3C11			89
+#define JHB100_PER0CLK_HDR_TX_I3C12			90
+#define JHB100_PER0CLK_HDR_TX_I3C13			91
+#define JHB100_PER0CLK_HDR_TX_I3C14			92
+#define JHB100_PER0CLK_HDR_TX_I3C15			93
+#define JHB100_PER0CLK_CORE_I2C0			94
+#define JHB100_PER0CLK_CORE_I2C1			95
+#define JHB100_PER0CLK_CORE_I2C2			96
+#define JHB100_PER0CLK_CORE_I2C3			97
+#define JHB100_PER0CLK_CORE_I2C4			98
+#define JHB100_PER0CLK_CORE_I2C5			99
+#define JHB100_PER0CLK_CORE_I2C6			100
+#define JHB100_PER0CLK_CORE_I2C7			101
+#define JHB100_PER0CLK_CORE_I2C8			102
+#define JHB100_PER0CLK_CORE_I2C9			103
+#define JHB100_PER0CLK_CORE_I2C10			104
+#define JHB100_PER0CLK_CORE_I2C11			105
+#define JHB100_PER0CLK_CORE_I2C12			106
+#define JHB100_PER0CLK_CORE_I2C13			107
+#define JHB100_PER0CLK_CORE_I2C14			108
+#define JHB100_PER0CLK_CORE_I2C15			109
+
+#define JHB100_PER0CLK_WDOGCLK_WDT0			126
+#define JHB100_PER0CLK_WDOGCLK_WDT1			127
+#define JHB100_PER0CLK_WDOGCLK_WDT2			128
+#define JHB100_PER0CLK_WDOGCLK_WDT3			129
+#define JHB100_PER0CLK_WDOGCLK_WDT_EXTERNAL		130
+#define JHB100_PER0CLK_SCLK_UART4			131
+#define JHB100_PER0CLK_SCLK_UART5			132
+#define JHB100_PER0CLK_SCLK_UART6			133
+#define JHB100_PER0CLK_SCLK_UART7			134
+#define JHB100_PER0CLK_SCLK_UART8			135
+#define JHB100_PER0CLK_SCLK_UART9			136
+#define JHB100_PER0CLK_SCLK_UART10			137
+#define JHB100_PER0CLK_SCLK_UART11			138
+#define JHB100_PER0CLK_SCLK_UART12			139
+#define JHB100_PER0CLK_SCLK_UART13			140
+#define JHB100_PER0CLK_SCLK_UART14			141
+
+#define JHB100_PER0CLK_PCLK_DMA_UART_CFG		148
+#define JHB100_PER0CLK_PCLK_DMA_I2C_CFG			149
+#define JHB100_PER0CLK_PCLK_DMA_I3C_CFG			150
+#define JHB100_PER0CLK_PCLK_DUALTIMER0			151
+#define JHB100_PER0CLK_PCLK_DUALTIMER1			152
+#define JHB100_PER0CLK_PCLK_DUALTIMER2			153
+
+#define JHB100_PER0CLK_HCLK_TRNG			156
+#define JHB100_PER0CLK_APB_I2C0				157
+#define JHB100_PER0CLK_APB_I2C1				158
+#define JHB100_PER0CLK_APB_I2C2				159
+#define JHB100_PER0CLK_APB_I2C3				160
+#define JHB100_PER0CLK_APB_I2C4				161
+#define JHB100_PER0CLK_APB_I2C5				162
+#define JHB100_PER0CLK_APB_I2C6				163
+#define JHB100_PER0CLK_APB_I2C7				164
+#define JHB100_PER0CLK_APB_I2C8				165
+#define JHB100_PER0CLK_APB_I2C9				166
+#define JHB100_PER0CLK_APB_I2C10			167
+#define JHB100_PER0CLK_APB_I2C11			168
+#define JHB100_PER0CLK_APB_I2C12			169
+#define JHB100_PER0CLK_APB_I2C13			170
+#define JHB100_PER0CLK_APB_I2C14			171
+#define JHB100_PER0CLK_APB_I2C15			172
+#define JHB100_PER0CLK_APB_I2CF0			173
+#define JHB100_PER0CLK_APB_I2CF1			174
+#define JHB100_PER0CLK_APB_I2CF2			175
+#define JHB100_PER0CLK_APB_I2CF3			176
+#define JHB100_PER0CLK_APB_I2CF4			177
+#define JHB100_PER0CLK_APB_I2CF5			178
+#define JHB100_PER0CLK_APB_I2CF6			179
+#define JHB100_PER0CLK_APB_I2CF7			180
+#define JHB100_PER0CLK_APB_I2CF8			181
+#define JHB100_PER0CLK_APB_I2CF9			182
+#define JHB100_PER0CLK_APB_I2CF10			183
+#define JHB100_PER0CLK_APB_I2CF11			184
+#define JHB100_PER0CLK_APB_I2CF12			185
+#define JHB100_PER0CLK_APB_I2CF13			186
+#define JHB100_PER0CLK_APB_I2CF14			187
+#define JHB100_PER0CLK_APB_I2CF15			188
+#define JHB100_PER0CLK_APB_I3C0				189
+#define JHB100_PER0CLK_APB_I3C1				190
+#define JHB100_PER0CLK_APB_I3C2				191
+#define JHB100_PER0CLK_APB_I3C3				192
+#define JHB100_PER0CLK_APB_I3C4				193
+#define JHB100_PER0CLK_APB_I3C5				194
+#define JHB100_PER0CLK_APB_I3C6				195
+#define JHB100_PER0CLK_APB_I3C7				196
+#define JHB100_PER0CLK_APB_I3C8				197
+#define JHB100_PER0CLK_APB_I3C9				198
+#define JHB100_PER0CLK_APB_I3C10			199
+#define JHB100_PER0CLK_APB_I3C11			200
+#define JHB100_PER0CLK_APB_I3C12			201
+#define JHB100_PER0CLK_APB_I3C13			202
+#define JHB100_PER0CLK_APB_I3C14			203
+#define JHB100_PER0CLK_APB_I3C15			204
+#define JHB100_PER0CLK_APB_UART0			205
+#define JHB100_PER0CLK_APB_UART1			206
+#define JHB100_PER0CLK_APB_UART2			207
+#define JHB100_PER0CLK_APB_UART3			208
+#define JHB100_PER0CLK_APB_UART4			209
+#define JHB100_PER0CLK_APB_UART5			210
+#define JHB100_PER0CLK_APB_UART6			211
+#define JHB100_PER0CLK_APB_UART7			212
+#define JHB100_PER0CLK_APB_UART8			213
+#define JHB100_PER0CLK_APB_UART9			214
+#define JHB100_PER0CLK_APB_UART10			215
+#define JHB100_PER0CLK_APB_UART11			216
+#define JHB100_PER0CLK_APB_UART12			217
+#define JHB100_PER0CLK_APB_UART13			218
+#define JHB100_PER0CLK_APB_UART14			219
+#define JHB100_PER0CLK_DMA_I3C0				220
+#define JHB100_PER0CLK_DMA_I3C1				221
+#define JHB100_PER0CLK_DMA_I3C2				222
+#define JHB100_PER0CLK_DMA_I3C3				223
+#define JHB100_PER0CLK_DMA_I3C4				224
+#define JHB100_PER0CLK_DMA_I3C5				225
+#define JHB100_PER0CLK_DMA_I3C6				226
+#define JHB100_PER0CLK_DMA_I3C7				227
+#define JHB100_PER0CLK_DMA_I3C8				228
+#define JHB100_PER0CLK_DMA_I3C9				229
+#define JHB100_PER0CLK_DMA_I3C10			230
+#define JHB100_PER0CLK_DMA_I3C11			231
+#define JHB100_PER0CLK_DMA_I3C12			232
+#define JHB100_PER0CLK_DMA_I3C13			233
+#define JHB100_PER0CLK_DMA_I3C14			234
+#define JHB100_PER0CLK_DMA_I3C15			235
+#define JHB100_PER0CLK_CORE_I3C0			236
+#define JHB100_PER0CLK_CORE_I3C1			237
+#define JHB100_PER0CLK_CORE_I3C2			238
+#define JHB100_PER0CLK_CORE_I3C3			239
+#define JHB100_PER0CLK_CORE_I3C4			240
+#define JHB100_PER0CLK_CORE_I3C5			241
+#define JHB100_PER0CLK_CORE_I3C6			242
+#define JHB100_PER0CLK_CORE_I3C7			243
+#define JHB100_PER0CLK_CORE_I3C8			244
+#define JHB100_PER0CLK_CORE_I3C9			245
+#define JHB100_PER0CLK_CORE_I3C10			246
+#define JHB100_PER0CLK_CORE_I3C11			247
+#define JHB100_PER0CLK_CORE_I3C12			248
+#define JHB100_PER0CLK_CORE_I3C13			249
+#define JHB100_PER0CLK_CORE_I3C14			250
+#define JHB100_PER0CLK_CORE_I3C15			251
+#define JHB100_PER0CLK_DMAC_AXI_PERIPH0_HS_CLK_I2C	252
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C0			253
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C1			254
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C2			255
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C3			256
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C4			257
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C5			258
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C6			259
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C7			260
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C8			261
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C9			262
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C10		263
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C11		264
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C12		265
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C13		266
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C14		267
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C15		268
+#define JHB100_PER0CLK_MAIN_ICG_EN_DUALTIMER0		269
+#define JHB100_PER0CLK_MAIN_ICG_EN_DUALTIMER1		270
+#define JHB100_PER0CLK_MAIN_ICG_EN_DUALTIMER2		271
+#define JHB100_PER0CLK_MAIN_ICG_EN_LTPI0		272
+#define JHB100_PER0CLK_MAIN_ICG_EN_LTPI1		273
+#define JHB100_PER0CLK_MAIN_ICG_EN_DMAC_I2C		274
+#define JHB100_PER0CLK_MAIN_ICG_EN_DMAC_I3C		275
+#define JHB100_PER0CLK_MAIN_ICG_EN_DMAC_UART		276
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL4			277
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL5			278
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL6			279
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL7			280
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL8			281
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL9			282
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL10		283
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL11		284
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL12		285
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL13		286
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL14		287
+
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C0			304
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C1			305
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C2			306
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C3			307
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C4			308
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C5			309
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C6			310
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C7			311
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C8			312
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C9			313
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C10		314
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C11		315
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C12		316
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C13		317
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C14		318
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C15		319
+#define JHB100_PER0CLK_MAIN_ICG_EN_WDT0			320
+#define JHB100_PER0CLK_MAIN_ICG_EN_WDT1			321
+#define JHB100_PER0CLK_MAIN_ICG_EN_WDT2			322
+#define JHB100_PER0CLK_MAIN_ICG_EN_WDT3			323
+#define JHB100_PER0CLK_MAIN_ICG_EN_WDT_EXTERNAL		324
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART4		325
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART5		326
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART6		327
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART7		328
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART8		329
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART9		330
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART10		331
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART11		332
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART12		333
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART13		334
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART14		335
+#define JHB100_PER0CLK_MAIN_ICG_EN_LDO0			336
+#define JHB100_PER0CLK_MAIN_ICG_EN_LDO1			337
+#define JHB100_PER0CLK_MAIN_ICG_EN_SENSORS_PERIPH0	338
+#define JHB100_PER0CLK_MAIN_ICG_EN_SENSORS_DMAC		339
+#define JHB100_PER0CLK_MAIN_ICG_EN_TRNG			340
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index fbc55f95e76c..ccfb7616e1a7 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -61,4 +61,81 @@
 #define JHB100_SYS2RST_GPU1_RSTN_BUS					21
 #define JHB100_SYS2RST_GPU1_HOST_PCIE_RST_N				22
 
+/* PER0CRG resets */
+#define JHB100_PER0RST_MAIN_RSTN_UART4					0
+#define JHB100_PER0RST_MAIN_RSTN_UART5					1
+#define JHB100_PER0RST_MAIN_RSTN_UART6					2
+#define JHB100_PER0RST_MAIN_RSTN_UART7					3
+#define JHB100_PER0RST_MAIN_RSTN_UART8					4
+#define JHB100_PER0RST_MAIN_RSTN_UART9					5
+#define JHB100_PER0RST_MAIN_RSTN_UART10					6
+#define JHB100_PER0RST_MAIN_RSTN_UART11					7
+#define JHB100_PER0RST_MAIN_RSTN_UART12					8
+#define JHB100_PER0RST_MAIN_RSTN_UART13					9
+#define JHB100_PER0RST_MAIN_RSTN_UART14					10
+#define JHB100_PER0RST_MAIN_RSTN_I2C0					11
+#define JHB100_PER0RST_MAIN_RSTN_I2C1					12
+#define JHB100_PER0RST_MAIN_RSTN_I2C2					13
+#define JHB100_PER0RST_MAIN_RSTN_I2C3					14
+#define JHB100_PER0RST_MAIN_RSTN_I2C4					15
+#define JHB100_PER0RST_MAIN_RSTN_I2C5					16
+#define JHB100_PER0RST_MAIN_RSTN_I2C6					17
+#define JHB100_PER0RST_MAIN_RSTN_I2C7					18
+#define JHB100_PER0RST_MAIN_RSTN_I2C8					19
+#define JHB100_PER0RST_MAIN_RSTN_I2C9					20
+#define JHB100_PER0RST_MAIN_RSTN_I2C10					21
+#define JHB100_PER0RST_MAIN_RSTN_I2C11					22
+#define JHB100_PER0RST_MAIN_RSTN_I2C12					23
+#define JHB100_PER0RST_MAIN_RSTN_I2C13					24
+#define JHB100_PER0RST_MAIN_RSTN_I2C14					25
+#define JHB100_PER0RST_MAIN_RSTN_I2C15					26
+#define JHB100_PER0RST_MAIN_RSTN_I3C0					27
+#define JHB100_PER0RST_MAIN_RSTN_I3C1					28
+#define JHB100_PER0RST_MAIN_RSTN_I3C2					29
+#define JHB100_PER0RST_MAIN_RSTN_I3C3					30
+#define JHB100_PER0RST_MAIN_RSTN_I3C4					31
+#define JHB100_PER0RST_MAIN_RSTN_I3C5					32
+#define JHB100_PER0RST_MAIN_RSTN_I3C6					33
+#define JHB100_PER0RST_MAIN_RSTN_I3C7					34
+#define JHB100_PER0RST_MAIN_RSTN_I3C8					35
+#define JHB100_PER0RST_MAIN_RSTN_I3C9					36
+#define JHB100_PER0RST_MAIN_RSTN_I3C10					37
+#define JHB100_PER0RST_MAIN_RSTN_I3C11					38
+#define JHB100_PER0RST_MAIN_RSTN_I3C12					39
+#define JHB100_PER0RST_MAIN_RSTN_I3C13					40
+#define JHB100_PER0RST_MAIN_RSTN_I3C14					41
+#define JHB100_PER0RST_MAIN_RSTN_I3C15					42
+#define JHB100_PER0RST_MAIN_RSTN_WDT0					43
+#define JHB100_PER0RST_MAIN_RSTN_WDT1					44
+#define JHB100_PER0RST_MAIN_RSTN_WDT2					45
+#define JHB100_PER0RST_MAIN_RSTN_WDT3					46
+#define JHB100_PER0RST_MAIN_RSTN_WDT4					47
+#define JHB100_PER0RST_MAIN_RSTN_DUALTIMER0				48
+#define JHB100_PER0RST_MAIN_RSTN_DUALTIMER1				49
+#define JHB100_PER0RST_MAIN_RSTN_DUALTIMER2				50
+#define JHB100_PER0RST_MAIN_RSTN_TRNG					51
+#define JHB100_PER0RST_MAIN_RSTN_DMAC0					52
+#define JHB100_PER0RST_MAIN_RSTN_DMAC1					53
+#define JHB100_PER0RST_MAIN_RSTN_DMAC2					54
+#define JHB100_PER0RST_MAIN_RSTN_LTPI0					55
+#define JHB100_PER0RST_MAIN_RSTN_LTPI1					56
+#define JHB100_PER0RST_MAIN_RSTN_SOL4					57
+#define JHB100_PER0RST_MAIN_RSTN_SOL5					58
+#define JHB100_PER0RST_MAIN_RSTN_SOL6					59
+#define JHB100_PER0RST_MAIN_RSTN_SOL7					60
+#define JHB100_PER0RST_MAIN_RSTN_SOL8					61
+#define JHB100_PER0RST_MAIN_RSTN_SOL9					62
+#define JHB100_PER0RST_MAIN_RSTN_SOL10					63
+#define JHB100_PER0RST_MAIN_RSTN_SOL11					64
+#define JHB100_PER0RST_MAIN_RSTN_SOL12					65
+#define JHB100_PER0RST_MAIN_RSTN_SOL13					66
+#define JHB100_PER0RST_MAIN_RSTN_SOL14					67
+#define JHB100_PER0RST_MAIN_RSTN_LDO0					68
+#define JHB100_PER0RST_MAIN_RSTN_LDO1					69
+#define JHB100_PER0RST_MAIN_RSTN_PERIPH0_SENSORS			70
+#define JHB100_PER0RST_MAIN_RSTN_DMAC0_SENSORS				71
+#define JHB100_PER0RST_SYSCON_PRESETN					72
+#define JHB100_PER0RST_GPIO_IOMUX_PRESETN				73
+#define JHB100_PER0RST_UART_MUX_REG_WRAP				74
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1


