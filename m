Return-Path: <netdev+bounces-274519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KEHMjFkzmmXnQYAu9opvQ
	(envelope-from <netdev+bounces-274519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:42:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAE83892D6
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56EB13015890
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0638E3CD8C0;
	Thu,  2 Apr 2026 12:30:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2136.outbound.protection.partner.outlook.cn [139.219.17.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCCB3E3C7F;
	Thu,  2 Apr 2026 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775133004; cv=fail; b=Wmqsl+OzbE5fH0W+Gp3DjwRhsylxc1DC3fuw/rtCKyf41EwAFsegUnn35BXJu7rAJGjS38NVQpUPxJvEHzouqhtLJpNPHT7PIZ4Y4aCseVb7m1sP2XNGOrrMrdfjGMCjPCbue+od/Au+Eqz/USmZOwcOQ2yv/WQwUbRZKfHHiIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775133004; c=relaxed/simple;
	bh=nn43pLUZgRflgMS+qbkcbGnRKpWa5BoLNI2fEE4NsAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qvMunZmDa3W1JUFd8nXgmnAG/L+GIGc82kji7YB2a1A5D6UY3gOOy8AzDnqePf3naPVSdhAjfrThI0YWiXx9HmOyeBr2ZnfXP8yTmA2MWCSxYO6UnNZR/qrEsA4OBjjystyoc8w10u6owZvwag0Ho/MXUxzdLYS9eb3AHW9nJgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAj8RvmzSwRlQI+RVA2X/yAonLHb13gqlWtCHY0Rpn0rUNJaK1I4xuds2gsJvsU8cn7mIHTvHuwa+j1gBfB8Z9xMA4DoZ3nzzRlUtlN47CMW2jwTLIYFay/IZ18L6tfAGCyVv1GJp3JKPtVwHZ5qmfaoIgAJ866HU4l1nh3Ob3TtFyVarZu9ooyvFCi1MFkKreolUAsrM8vKjnBUatPror8iD7EORjx+XQVtnZbM9Q0cXC6f/iZYvXhU4a1+t34vJzZE+P047fcFiPd3kWrqJLIdm2iMdoBbJ/RtuEHx68jVi7BpA20TFg3OlP14ndVeYW0mY3SPl8rErJsRYO+Zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iv3Oce3IEiHEWW4hmxc2M16DMb4QPKjLSsqZzA+Q03Y=;
 b=ma61pYjkxHLSmpNPUlXKbnPTyaRODknS2MOr4gRzY+erC39p/6FhrIgj2Tj8E5maKP7h54nht0u+MF8V0t1H/KmDqAcGBgvr5FTzIqKIYXdAJ6r+bMO6fgcVuXVytZ1mQ0lTGVe27E/B3ZwGtW7WkQX6v6Cn15GF+7txzI0eITgrXGSKkSx1wTUku9+kC2YnInlhpwflmuT1WAknPydtOnAsKSnbDgOfTTg+NevK/ZflU3RIAzQO0HbUkyyTUlJ+8/+uXgC7w+nhc2pGofdeisSN3XsRy2zDkbVbCqfkWp06OcYYwWjY8kbgRvkaaaMgIhaQSnj3Dbb8fWI5HpaDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:56:05 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:56:05 +0000
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
Subject: [PATCH v1 11/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-0 clock and reset generator
Date: Thu,  2 Apr 2026 03:55:12 -0700
Message-Id: <20260402105523.447523-12-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c958ccd-61b5-44e6-ae7d-08de90a6704b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vsryvGK/WGmgAbbGn1p4Mol1wn9v/zHM225/eEyWqJ6aKxJEe05fDiypAi4fUsaLjnfESPIdfwL43aO2jcRmCRMFKj/zQix9xUh8t79ZVR/s78TaVyPX+RV/EH29YDzmjCIYugnSkNR9cLXyaWXY3EvpYL/I0oRybGRm0cJbkpi3LrHIZEw6zLnTw96z+cb52hh3T4yENTPRTnjjjt5Uce9sFktC5blG1qxZV3emGZGaWKNd4TJ/FhwrwQ74+O0TgqU3t17FZc2pm6Jkbnr2KxxRZE9ZPbunNXvkcc4JISzG0Ow5V4vcSDNqCc3ZxAQ2QhgrHO//ZKk9mYiwiaG2HwW6xL7ALTaZG2nHk3et9HYCifdTkW4XAEoBsS/xR0yXDnYJotBjyVO2E4aXGo3fZ3ioosowbhQffiX6NRu3Zyqr8Lo48EjqcjD40xznlDv3hihIwpmEET9YdkvRDWgBGLY+tUdV6tC+F9Igad+KZJEjJc9dH9G4iOenf+bqyDUgCT23MifPlDVUtzn34CzKKqaK/QGUufWdhFRyPfBFUXA2xmSoMjS2xJMpoDLx+scsO3ysh9tRMzQiQIQFF5cf8BNcvMIgbLZQDPWKs2zaKT4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eCQW9yP7qB7h8H59eplRbDCDrr/h1Do4e7r5N7baRB84tClI4sH4KhIlT1sC?=
 =?us-ascii?Q?3r/JRQ/glaqs5iGq65StaYF2/B9NwrU+ZLh+QU/RT9aUvH2Xg1XGG+HbXyi7?=
 =?us-ascii?Q?cR7KvFcaMdqEIpiDQuR54GvtwS6ZE14k3bntvpoPvN2h2ytSZvkkyrGTBAUs?=
 =?us-ascii?Q?h85s204oIhdlJBjiRUf2qvl3cqQM6MKUndVblAf/fB9vYonvmPFEKgXA6Tuf?=
 =?us-ascii?Q?DpdColIzrX62TpRM94phTo1HOaijPBIqyK7pg+K+1qBTYR2bscGF42R1QdjR?=
 =?us-ascii?Q?IuzpclVArEG14OkX/5lGbzsgNsMLBkoTjvXc/pjr2KR4VdImpUnnslg6j4Mt?=
 =?us-ascii?Q?K+6Ln/kCd8mZnFOE/pDnAcUCRoKrWvCWMBbZog8IovskLlz0hSuZiU3prs/z?=
 =?us-ascii?Q?X9c3lvbTQ/weT39KMf/EI64uqf/43bimQP+bkZMf2sK1Us32tivLGaBU8bTS?=
 =?us-ascii?Q?fkinkW3vUHWsKZrBKVkwJ4EXeXJ2rM367oEPpewCdiBT1ED23zgcojw/GKzQ?=
 =?us-ascii?Q?eMequTlGxWdeAP4UWOAzbg0CSiu3BrNR8alsGo8RF27jLJoi2RGoDlhiP/dJ?=
 =?us-ascii?Q?Ea7Jr8jBNSIpJbbdTM8BszGxGllwSJHVTPiZ4kObCYeuMXuM3tSAMxCIAMmz?=
 =?us-ascii?Q?5ZqMPt38AMDFGD3JEfJfmuPZmCoeuPE4qP6qf+tFr/MsEZUKTLbJEgbmZqnA?=
 =?us-ascii?Q?G89i552Ck4nB120nIw08nTP5CcbKv6nq+ecjxhG2UAkB37ZWtz7bV3tUX2//?=
 =?us-ascii?Q?JrNohD2ICwp3SUXkNzGnkNDm1l0Oc8Uw0cnGNO+yhaEvPoWFLmIamfBUgdOM?=
 =?us-ascii?Q?dVcg9vAcfKPIUtPzsi5GG7UAYJ6HodsfMilct2AXFuXiuD+MUppPHIoywPUn?=
 =?us-ascii?Q?KWFewQhBYLWMFLOper4w1tbFsO/sgm/tb2AjnM0EN++H8roMPAYY8YraJoZ0?=
 =?us-ascii?Q?5/5PBRtMzGiXjTV3AVEwKd5D/WcLxbxMfAau36c+VeJB0s+I7PX5CdE8VXkV?=
 =?us-ascii?Q?Q0ehEnNHQzHo7VTqyLb3geXYXOhCqGwtZgFHrSBtH31ztgwtBkfv73FEWIv3?=
 =?us-ascii?Q?p6BJFrURsRVapDaUAWrIIMH+EAuY6r4b7v9cTyE2BHBYkWzc0wjcprDYU4G5?=
 =?us-ascii?Q?ZLG66wwOinTFn5WS1EX8fzhDRVtTuAXwBRv/QsMNUh3JXk1GUMWet79bLrsF?=
 =?us-ascii?Q?dRNrqwhtDd/bNlk9I35P/xKOHqVEvjpY48Lkdw5q5wUIIVxv67x1y82W1SAX?=
 =?us-ascii?Q?lk9or9sz+NerO1w0Q5zoAqFIlvHs9XGOwtVBhYxWXg+bZmra7uCsNG1E4WHk?=
 =?us-ascii?Q?uVhyfHYmPxy/pKavuUWVj6PoW/IBCCXZA0vNaY8BN3XKIAlcz44zRQ95P3h7?=
 =?us-ascii?Q?PFOrO43CG2BwNnb6FLTWvx/B2MBmJctJPHYUmSRNWRysFAtgy3cGd2NEml9I?=
 =?us-ascii?Q?CvnL0JwyhUQW3C3wwv90WDqMccLxEaw/pMAyMnxwF1Dq0Fgpwtqa4XsH1N/G?=
 =?us-ascii?Q?qj+9jWcDivYApktYLpAomTjeqlZxWE+x5oKT/cLaIuu2hleKNibE1oHE7/ma?=
 =?us-ascii?Q?q4/JpNdDBLjlFU/xf4hhlOjp46BHW0q/1rXm9zczc13TmOW0gJI3oKnYbYlD?=
 =?us-ascii?Q?0BI4aD9KqrzpTmjczmMCr9MBFI7Fym3Epd7Crc19XBt2nx0dmTiuTgJ8k2Wp?=
 =?us-ascii?Q?T6ZA7pnZlxYLNPynaerSYInAktJtV2oPgSdlCgdG2Ke9QCCRrmvIFCnnrN4N?=
 =?us-ascii?Q?1rZLLijEWxNQcUWzEPn499rbqPB4nydzAb+9gUCkjnsQoOL2TYKS?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c958ccd-61b5-44e6-ae7d-08de90a6704b
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:56:05.7587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBQlbKdTucKGLRRY8wRoidW/CyG2TQ+VxhngUiy+pu3mupc5Hc+oldhGbGx+hCfM/Pbok3p4DfHGTBcQYVssjWA+E8uDOregWoTUN3T61ReFGbXtx/+mwzb/zs5BMaoJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1048
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274519-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.628];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devicetree.org:url,starfivetech.com:email,starfivetech.com:mid]
X-Rspamd-Queue-Id: 5CAE83892D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 000000000000..fde1666bd250
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
+      - description: Peripheral-0 400MHz
+      - description: Peripheral-0 800MHZ
+      - description: Peripheral-0 600MHZ
+      - description: Peripheral-0 200MHz Initiator
+
+  clock-names:
+    items:
+      - const: osc
+      - const: pll6
+      - const: per0_400
+      - const: per0_800
+      - const: per0_600
+      - const: per0_200_init
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
+      clock-names = "osc", "pll6", "per0_400",
+                    "per0_800", "per0_600",
+                    "per0_200_init";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index 34e4498fc1c8..104f302b7103 100644
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
index d92bc4c6d830..bb5238cb02f6 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -66,4 +66,81 @@
 #define JHB100_SYS2RST_GPU1_RSTN_BUS					25
 #define JHB100_SYS2RST_GPU1_HOST_PCIE_RST_N				26
 
+/* PER0CRG resets */
+#define JHB100_PER0RST_MAIN_RSTN_UART4					1
+#define JHB100_PER0RST_MAIN_RSTN_UART5					2
+#define JHB100_PER0RST_MAIN_RSTN_UART6					3
+#define JHB100_PER0RST_MAIN_RSTN_UART7					4
+#define JHB100_PER0RST_MAIN_RSTN_UART8					5
+#define JHB100_PER0RST_MAIN_RSTN_UART9					6
+#define JHB100_PER0RST_MAIN_RSTN_UART10					7
+#define JHB100_PER0RST_MAIN_RSTN_UART11					8
+#define JHB100_PER0RST_MAIN_RSTN_UART12					9
+#define JHB100_PER0RST_MAIN_RSTN_UART13					10
+#define JHB100_PER0RST_MAIN_RSTN_UART14					11
+#define JHB100_PER0RST_MAIN_RSTN_I2C0					12
+#define JHB100_PER0RST_MAIN_RSTN_I2C1					13
+#define JHB100_PER0RST_MAIN_RSTN_I2C2					14
+#define JHB100_PER0RST_MAIN_RSTN_I2C3					15
+#define JHB100_PER0RST_MAIN_RSTN_I2C4					16
+#define JHB100_PER0RST_MAIN_RSTN_I2C5					17
+#define JHB100_PER0RST_MAIN_RSTN_I2C6					18
+#define JHB100_PER0RST_MAIN_RSTN_I2C7					19
+#define JHB100_PER0RST_MAIN_RSTN_I2C8					20
+#define JHB100_PER0RST_MAIN_RSTN_I2C9					21
+#define JHB100_PER0RST_MAIN_RSTN_I2C10					22
+#define JHB100_PER0RST_MAIN_RSTN_I2C11					23
+#define JHB100_PER0RST_MAIN_RSTN_I2C12					24
+#define JHB100_PER0RST_MAIN_RSTN_I2C13					25
+#define JHB100_PER0RST_MAIN_RSTN_I2C14					26
+#define JHB100_PER0RST_MAIN_RSTN_I2C15					27
+#define JHB100_PER0RST_MAIN_RSTN_I3C0					28
+#define JHB100_PER0RST_MAIN_RSTN_I3C1					29
+#define JHB100_PER0RST_MAIN_RSTN_I3C2					30
+#define JHB100_PER0RST_MAIN_RSTN_I3C3					31
+#define JHB100_PER0RST_MAIN_RSTN_I3C4					32
+#define JHB100_PER0RST_MAIN_RSTN_I3C5					33
+#define JHB100_PER0RST_MAIN_RSTN_I3C6					34
+#define JHB100_PER0RST_MAIN_RSTN_I3C7					35
+#define JHB100_PER0RST_MAIN_RSTN_I3C8					36
+#define JHB100_PER0RST_MAIN_RSTN_I3C9					37
+#define JHB100_PER0RST_MAIN_RSTN_I3C10					38
+#define JHB100_PER0RST_MAIN_RSTN_I3C11					39
+#define JHB100_PER0RST_MAIN_RSTN_I3C12					40
+#define JHB100_PER0RST_MAIN_RSTN_I3C13					41
+#define JHB100_PER0RST_MAIN_RSTN_I3C14					42
+#define JHB100_PER0RST_MAIN_RSTN_I3C15					43
+#define JHB100_PER0RST_MAIN_RSTN_WDT0					44
+#define JHB100_PER0RST_MAIN_RSTN_WDT1					45
+#define JHB100_PER0RST_MAIN_RSTN_WDT2					46
+#define JHB100_PER0RST_MAIN_RSTN_WDT3					47
+#define JHB100_PER0RST_MAIN_RSTN_WDT4					48
+#define JHB100_PER0RST_MAIN_RSTN_DUALTIMER0				49
+#define JHB100_PER0RST_MAIN_RSTN_DUALTIMER1				50
+#define JHB100_PER0RST_MAIN_RSTN_DUALTIMER2				51
+#define JHB100_PER0RST_MAIN_RSTN_TRNG					52
+#define JHB100_PER0RST_MAIN_RSTN_DMAC0					53
+#define JHB100_PER0RST_MAIN_RSTN_DMAC1					54
+#define JHB100_PER0RST_MAIN_RSTN_DMAC2					55
+#define JHB100_PER0RST_MAIN_RSTN_LTPI0					56
+#define JHB100_PER0RST_MAIN_RSTN_LTPI1					57
+#define JHB100_PER0RST_MAIN_RSTN_SOL4					58
+#define JHB100_PER0RST_MAIN_RSTN_SOL5					59
+#define JHB100_PER0RST_MAIN_RSTN_SOL6					60
+#define JHB100_PER0RST_MAIN_RSTN_SOL7					61
+#define JHB100_PER0RST_MAIN_RSTN_SOL8					62
+#define JHB100_PER0RST_MAIN_RSTN_SOL9					63
+#define JHB100_PER0RST_MAIN_RSTN_SOL10					64
+#define JHB100_PER0RST_MAIN_RSTN_SOL11					65
+#define JHB100_PER0RST_MAIN_RSTN_SOL12					66
+#define JHB100_PER0RST_MAIN_RSTN_SOL13					67
+#define JHB100_PER0RST_MAIN_RSTN_SOL14					68
+#define JHB100_PER0RST_MAIN_RSTN_LDO0					69
+#define JHB100_PER0RST_MAIN_RSTN_LDO1					70
+#define JHB100_PER0RST_MAIN_RSTN_PERIPH0_SENSORS			71
+#define JHB100_PER0RST_MAIN_RSTN_DMAC0_SENSORS				72
+#define JHB100_PER0RST_SYSCON_PRESETN					73
+#define JHB100_PER0RST_GPIO_IOMUX_PRESETN				74
+#define JHB100_PER0RST_UART_MUX_REG_WRAP				75
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1


