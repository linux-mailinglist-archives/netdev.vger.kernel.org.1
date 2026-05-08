Return-Path: <netdev+bounces-285658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL0ADPN6/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:56:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6AD4F226F
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8B14307728B
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5179A3806B5;
	Fri,  8 May 2026 05:39:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2111.outbound.protection.partner.outlook.cn [139.219.17.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6237D130;
	Fri,  8 May 2026 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218755; cv=fail; b=oSpBO6a5xob5jy18vTpJJSX5HHN0t83JuwIe9CLIY0LqLA0VZ/qGnMVTQCn4ZnBGxuqOdJftJq9BykywJwFAt/Oo8LkYKJfI90HtpfkKIkEm790GaVSeMSwJmB1wqIeWvN7TmetO+7OVS4SVpzEBcwmFVCVwEOzFQ8HXC833QAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218755; c=relaxed/simple;
	bh=Rmj7MV6xVQ6Tbqa6jhhvG0O9WvCAIW/QgFDo3mcCEvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GThJLUWKFLBtzgLiU1Y/fxb+htU5z1r9ZBU3M5nNm/TaXM8PZWENfY6IVm2MzJbNz6gIbLsn0laTSDIh8uNf9GBlU+Z0++LFFfNIn+vLSLp2pFKjLVP6OR4RDCx/RpMnYxVEm2VIvJG18DlHqR1lRrlUKhAjxf/wKVYPu/PquZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJe7KTbBqstqm6Z0h57haOrF+aQvNNyDco0RDixcSFDsuacSLfgbzCoBR93vYSlmltCESC8rL00SMx08UaX+l2gu0K9AlyGiLkM1lJEtATAXv90V/f9dtVgfgs70U++Z5w8zOAcTsLUoxJg4qabXYzL1Y5IvYDsFo/uMX5dO3Zn1RpZ6LXh7Al0Kfhq8JHvMDVvooc9GIzf0hywrXGCFo69jJXQyRjqROS+T9QCjVYzEUd6dJCjBkBq6By10tqSpZE0QDTFtZsMC2nSKPmlYtq1CFMndhO/1vY+VJO4CfvpUHOgcABVMICOxtmAvlaMPVpHztYY8ENYLyTLeFDpCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6Mue/dFGjhr326XqYj0JqyqIVepAROfd+rxOWK5R6k=;
 b=YZ6iGyyT10mavF8ZDC7woBYla9lMrmVkdysSWaDP4QZ8iJJKssb+IX2Tm1TNntPyEF2ta0ZwqgmPBifglhk9O6i5iYOkJR85m2oZu2YPCVs2boUFgB08OQeIIuKaRVqdYuHyHPV3DkiiYvSp8BFPrzxyuce/Pqiwx2iuxbN7XzZTyHIsMPgpHn5IZloaxdp+vO1wcrRqy4WulX5Z1wxxatYIBaHQVwbcaV9bxueTnTmfnxBwmWOwg3RmcdBOZsHJYAZ0WRa/jxjhNZZNG1/4eYfS6/N+CCUyY+673z0GZ/qeps+eXumSzgsxJHhQ4loIXj/JordZeD5RqGUjaKjP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 05:37:11 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:37:11 +0000
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
Subject: [PATCH v2 17/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-2 clock and reset generator
Date: Thu,  7 May 2026 22:36:27 -0700
Message-Id: <20260508053632.818548-18-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: c425ec08-39b1-40aa-12b6-08deacc3da23
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|56012099003|38350700014|921020|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5bGNklAvVxw10bxvk7eHpje+B8bD0+yUfAzLrq/0om0DKVT2HM0Vub2yE0gmnD2Ire8yI2AN2J1X2JdNhH/kxVgh8RlVx3jtlST1Ne3zEkByfDL+nixSg11iShbIVTqzisNybXBswBvUzPIIlF6Vv2R6NFVXvAnXz/3LH9LdygG7cySDHywFuOWX3OO9Z6+AIcTnf35PD7yG4d3DMkOETKQ2030P9rhlftL0kVASVDZ842Fg1MEnrypYvFKwyYMbaDeEIoJPraGXmx5j1CoT1uAgyjnypkTugOqu8z0DlShq3sQRITgFzE3Km2fE9wNKTAq6Bfkfs/fJTuLzBU7TlqngCdX4cuNQEMXMtI8Um+L85qh5Ulp0jo8FA1LWMMd3mahWXVTJh0A9LJzhZxvTh5vCZ6nH4hlH50BWb03ZU/U+RfaXa+0aBaC1aGyKlkuYZrapu4E6p0jXl+8Qbc4JU4uLSJBEUIaXlLNKxs7VUJXpY/UJPwBuWgarOedYHfNSfx+XBv0gEj7ys7vm2WtY5CIu1aTHZ92WsQz/ZbMiMs6Gh+a4Ld6qFXPrW9an/OQJZu+0JJ+mJJSVCcX7KzWyJQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(56012099003)(38350700014)(921020)(3023799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5HieLeNITNtoXfV+TdcQw6xjVMb2KD4b1S6wz9J4ru/zpBlitYHBwm/Zmlep?=
 =?us-ascii?Q?bI/U18zjSRr2Q3On+XL6fRVcwlEDFbfq7fUyBg0v6m9ItcgiXTRsMHEEG8V3?=
 =?us-ascii?Q?fUdsk5eIxTc+0oOUZnG34jMhcpovmEh26amzNV0+vM49BsBB7v3ZV0HSm/zQ?=
 =?us-ascii?Q?A2vEjgAOw7Q9h3kW0k8bBgmSASGMDKiF2+t/K8hRRCM8DFw57OEUf0j249kR?=
 =?us-ascii?Q?NmQtmV3JefIUg3WYZ4vWvbvGBVRLIvCmg6cvlbnCJY8vIFYMHmMTxkVt9ptf?=
 =?us-ascii?Q?+W/9xEnTudDhn0tfrkHADnKH5wZXEgpOt57dzroQ4IIr1Giin0CsJtKh1MsK?=
 =?us-ascii?Q?dDUo11J3auM+ys6+fv9r1AqlG8qQ69g9LtpprRV1Tqgr6Z7JFNTVu1ErF+MY?=
 =?us-ascii?Q?o9eqD2PjepVLXdGDCfzf2H2P+yua3U7cRC+59gHKngXK4WiZAYlGjLg1qom3?=
 =?us-ascii?Q?lYKkeO5NbfVI6Np0afbIKT7kb4iv3e9ylDlRrtCciVyCI8txlh92k0VbF1fc?=
 =?us-ascii?Q?7U3hMXTHpsJPQ3ZsonnYoFID+FOfh8cEpWVTOluCkKPR0OjoAycysO3L2nEi?=
 =?us-ascii?Q?te9E6OwW/qWD2RyARKx024Nhij2cQEodJdZ8d9S7Xrn5bugRLscqHSKIVAqz?=
 =?us-ascii?Q?jpgcyflKZrimaYDVPcU/bHiRQSN/tBZgOLwOnos6BXI3G3eul59UsvNZZ8w6?=
 =?us-ascii?Q?tBYuQ0In6TSLBdFupSi4UU3s9UWOxs4RMIUgn4IjfJruqC3l+chChGlU9Ttf?=
 =?us-ascii?Q?xBGXMwoGW0ozwxb7iaSBEPBoHkauVOh3k1kk1s+Q6UfFXtA7gsM5Jr2B0WOs?=
 =?us-ascii?Q?sMc3tbVkitBXTnz7xdY6ddD/z3lEkaFFess8XGabC36YQgjRUtsUNP90ROzZ?=
 =?us-ascii?Q?ZHrg9qaPBKiqzXUiTDz8LwAIPr0G6w2eROlNU4lOcVLsWLfTwxGfoEBkKvlJ?=
 =?us-ascii?Q?UsWh8/uPHNzTO1IaoTuXPAtIrPy4lVyY3Kzsur/KByLO8fTR7uNmAeixtvAv?=
 =?us-ascii?Q?elOtOx3pYmt4jslZqmOdt5ikEkpLCPQDRqXLD+Vx9rbqtAAQK2xb6uSxX2Fg?=
 =?us-ascii?Q?lXXDHdgVQlY+A3KD7tZgmmCotDFJZ7Ofo4f0twuPYMwTtA6rgJdsRSluqoRv?=
 =?us-ascii?Q?hM0ojGUOhTXeAEKHxj/j/LtfsNvxKqxT95Nuvp2fZADiWH8XVBtP20BIMGcm?=
 =?us-ascii?Q?yc7nKcjKL/DnQQ1qzxkz2kzkebx8I2y1WyQImmJqhZomCFn7a039H5Xe9Q40?=
 =?us-ascii?Q?oHqBNHvorbSvA6n6HzT+hRetFPYa5QwLwhaFX4qsayf9HZDKQWUC/wGMKmTo?=
 =?us-ascii?Q?+NLGPe5QjwHDSmiwpAgeRubIzb1RuDv53VNbISrz05FIL2oDQeLWuDz6wXtJ?=
 =?us-ascii?Q?8zt11sgFtsT+pMBzvpMPbbrcuIZAriKYCIfQInSUIohMCmi2F+x1xAUSjqNh?=
 =?us-ascii?Q?3aVsztD2PTtWcUpkBwfFgCC2lRWvYJDFSjHwpqeHQCYTFMhFwW69naEFpuYh?=
 =?us-ascii?Q?aLLjyiFQzOdrrwkYoZ510gLopMNLamR7Ljs2E+2UkWv4MC8TsEzOeSFtBkJp?=
 =?us-ascii?Q?7nwJnstB/o3M0+eNN8lcrHj3NKlOlzOpmm04m+VK8/4cXs9OtqFOzCeh8QSd?=
 =?us-ascii?Q?R8uWXNNrdNVZWYbvHj8jzB9vPd31nkM87jkR5AcMyKEUsh46SuP/Flc8AdGQ?=
 =?us-ascii?Q?7CVSeLhRuDxtCe6pQpGhpzqPvHDPQ74wyrIb7xpawWT5ZmRVkFxa4QY75msJ?=
 =?us-ascii?Q?vSA5aOftfD8FlX02oQCq0Of+Dpe6gcLVHQQvCWzj2jehc//lcWen?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c425ec08-39b1-40aa-12b6-08deacc3da23
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:37:11.2318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p688Eu2PhTGt7iV11dhGWdxQ/g2n8Mjzzp6o+yIFD+NUVTlS8EWbJ3STwPqPPrqUvvBvUMkerRQTutOnMWlc4fxumuJmoWd7UgUSVgXBRLcZRCRY0Q7w5lh82bpvaNBg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267
X-Rspamd-Queue-Id: AC6AD4F226F
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-285658-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.797];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devicetree.org:url,11bc0000:email,starfivetech.com:email,starfivetech.com:mid]
X-Rspamd-Action: no action

Add bindings for the Peripheral-2 clock and reset generator (PER2CRG)
on the JHB100 RISC-V SoC by StarFive Ltd.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clock/starfive,jhb100-per2crg.yaml        | 76 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 57 ++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 17 +++++
 3 files changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml
new file mode 100644
index 000000000000..3c266bc2eac2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-per2crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 Peripheral-2 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-per2crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Non Coherent NOC Initiator
+      - description: Configure 400MHz
+      - description: Configure 125MHz
+      - description: GMAC2 RGMII RX
+      - description: GMAC2 RMII Reference
+      - description: GMAC3 SGMII TX
+      - description: GMAC3 SGMII RX
+      - description: Main Oscillator (25 MHz)
+
+  clock-names:
+    items:
+      - const: ncnoc_init
+      - const: cfg_400
+      - const: cfg_125
+      - const: gmac2_rgmii_rx
+      - const: gmac2_rmii_ref
+      - const: gmac3_sgmii_tx
+      - const: gmac3_sgmii_rx
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
+    clock-controller@11bc0000 {
+      compatible = "starfive,jhb100-per2crg";
+      reg = <0x11bc0000 0x1000>;
+      clocks = <&sys0crg 52>, <&sys0crg 54>, <&sys0crg 55>,
+               <&per2_gmac2_rgmii_rx>, <&per2_gmac2_rmii_ref>,
+               <&per2_gmac3_sgmii_tx>, <&per2_gmac3_sgmii_rx>,
+               <&osc>;
+      clock-names = "ncnoc_init", "cfg_400", "cfg_125",
+                    "gmac2_rgmii_rx", "gmac2_rmii_ref",
+                    "gmac3_sgmii_tx", "gmac3_sgmii_rx",
+                    "osc";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index 7f508574177c..2b2e148ce5ce 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -447,4 +447,61 @@
 #define JHB100_PER1CLK_MAIN_ICG_EN_RAS			75
 #define JHB100_PER1CLK_MAIN_ICG_EN_UFS			76
 
+/* PER2CRG clocks */
+#define JHB100_PER2CLK_300				0
+#define JHB100_PER2CLK_100				1
+#define JHB100_PER2CLK_50				2
+#define JHB100_PER2CLK_GMAC2_RMII_50			3
+#define JHB100_PER2CLK_CAN0_CORE_DIV			4
+#define JHB100_PER2CLK_CAN1_CORE_DIV			5
+#define JHB100_PER2CLK_CAN0_TIMER			6
+#define JHB100_PER2CLK_CAN1_TIMER			7
+
+#define JHB100_PER2CLK_RTC_CORE_DIV			11
+#define JHB100_PER2CLK_GMAC2_RMII_MUX_DLY		12
+#define JHB100_PER2CLK_GMAC2_RMII_DIV			13
+
+#define JHB100_PER2CLK_GMAC2_RGMII_125_MUX		15
+#define JHB100_PER2CLK_GMAC2_RGMII_DIV			16
+#define JHB100_PER2CLK_GMAC2_TX_MUX			17
+#define JHB100_PER2CLK_GMAC2_TX_180_BUF			18
+#define JHB100_PER2CLK_GMAC2_RX_MUX_DLY			19
+#define JHB100_PER2CLK_GMAC2_RX_180_BUF			20
+#define JHB100_PER2CLK_GMAC2_TXCK_MUX_DLY		21
+#define JHB100_PER2CLK_GMAC3_TX_125_MUX			22
+#define JHB100_PER2CLK_GMAC3_RX_125_MUX			23
+#define JHB100_PER2CLK_GMAC3_TX_DIV			24
+#define JHB100_PER2CLK_GMAC3_RX_DIV			25
+#define JHB100_PER2CLK_SENSORS_PERIPH2			26
+
+#define JHB100_PER2CLK_FAN_TACH_PCLK			33
+
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_TX_I		44
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RX_I		45
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_TX_180_I	46
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RX_180_I	47
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_PTP_REF_I	48
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RMII_I	49
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_CSR_I	50
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_ACLK_I	51
+#define JHB100_PER2CLK_RMIIANDRGMII_IOMUX_GMAC2_TXCK	52
+#define JHB100_PER2CLK_ETHER1_SGMII_TX_I		53
+#define JHB100_PER2CLK_ETHER1_SGMII_RX_I		54
+#define JHB100_PER2CLK_ETHER1_SGMII_TX_125_I		55
+#define JHB100_PER2CLK_ETHER1_SGMII_RX_125_I		56
+#define JHB100_PER2CLK_ETHER1_SGMII_PTP_REF_I		57
+#define JHB100_PER2CLK_ETHER1_SGMII_CSR_I		58
+#define JHB100_PER2CLK_ETHER1_SGMII_ACLK_I		59
+#define JHB100_PER2CLK_ETHER1_SGMII_PHY_PCLK_I		60
+#define JHB100_PER2CLK_ETHER1_SGMII_REF_25_I		61
+#define JHB100_PER2CLK_MAIN_ICG_EN_CAN0			62
+#define JHB100_PER2CLK_MAIN_ICG_EN_CAN1			63
+
+#define JHB100_PER2CLK_MAIN_ICG_EN_DMAC_8CH		65
+#define JHB100_PER2CLK_MAIN_ICG_EN_RTC_SCAN		66
+#define JHB100_PER2CLK_MAIN_ICG_EN_ADC0			67
+#define JHB100_PER2CLK_MAIN_ICG_EN_ADC1			68
+#define JHB100_PER2CLK_MAIN_ICG_EN_GMAC2		69
+#define JHB100_PER2CLK_MAIN_ICG_EN_GMAC3		70
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index cf933a1befbb..0965f3798397 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -157,4 +157,21 @@
 #define JHB100_PER1RST_MAIN_RSTN_DMAC_SPI0				15
 #define JHB100_PER1RST_MAIN_RSTN_PERIPH1_RAS				16
 
+/* PER2CRG resets */
+#define JHB100_PER2RST_IOMUX_PRESETN					0
+#define JHB100_PER2RST_POK_IOMUX_PRESETN				1
+#define JHB100_PER2RST_SYSREG_RSTN					2
+#define JHB100_PER2RST_MAIN_RSTN_CAN0					3
+#define JHB100_PER2RST_MAIN_RSTN_CAN1					4
+#define JHB100_PER2RST_FAN_TACH_PRESETN					5
+#define JHB100_PER2RST_MAIN_RSTN_GMAC2					6
+#define JHB100_PER2RST_MAIN_RSTN_GMAC3					7
+#define JHB100_PER2RST_MAIN_RSTN_DMAC_8CH				8
+#define JHB100_PER2RST_MAIN_RSTN_RTC					9
+#define JHB100_PER2RST_ADC0_PRESETN					10
+#define JHB100_PER2RST_ADC0_IOMUX_PRESETN				11
+#define JHB100_PER2RST_ADC1_PRESETN					12
+#define JHB100_PER2RST_ADC1_IOMUX_PRESETN				13
+#define JHB100_PER2RST_MAIN_RSTN_PERIPH2_SENSORS			14
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1


