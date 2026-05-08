Return-Path: <netdev+bounces-285648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPCKAkt4/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:44:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5935D4F2091
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 238EA3023533
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF32B373BEC;
	Fri,  8 May 2026 05:38:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2133.outbound.protection.partner.outlook.cn [139.219.17.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3578366575;
	Fri,  8 May 2026 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218673; cv=fail; b=R4m/o5k/WX3oYq/zfpTE5PgsFW0Oa6r/YU7/tY/wvT84yaer5Dv+ExbmNFAxV9KceEmmCdNBW5VMaNVZguft/rFCzLuoM/xGg/USXJa7OAYyOSYWR+nvB5xgi0GolDZGE/jgwQMHMqAgXZciaWT9sJaFEHGY3H83T5xpvFyhYuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218673; c=relaxed/simple;
	bh=NBLP2d54ftaOIPclAD6aZv79BPJxh/zDNLbEZMdxm4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+sJUjXyQGljLA92itTbmsa/+Nf8B7ExGdNlmwmoOg3OePQI8kMBHvct2qSh8si4XD1C+9/tX0jqk59RwagfpWNAwkGlRKLYwgWHfEYciOVbUZVC0KDBxTebjz1p99b+Zqbq7H5DxlCxyMhe7jRWmkCTLrj9fymOufYhjy3k3Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5lmnni+XoGbHG8Lp75E1NyQv4IKa9WxB/Vd40Kw6Hb5vW1VKlwoTqV7QoLgH+PSc+ozThaUBxWNNtR68KVrYwAnRns2F1na+XphKhH8krypPkga/mb9gTiocuqHRS4DIvqIljrwpHhVIb6zCVdMlhyPYunXK5dWnfU8WKpDc9qXLExcpDMjyzrvJWouZuVeYV/IGhmKF8VWPgHa0P0NcB6+jE9zpWpHUQnz9engU8fzfk+kK9VUpKQAQO9oZubKO6LY31WZgR+eiR9W36+RyTFH3YOlK/9Pk6JSzBFil2/7ztk6R4qxhgDU4jM0sVED4aBwq4IqsmyfNTExWAgxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nk70bbl7Fjco1ilnZMT18n7STmuSYpUDaMiLPN7Ft7E=;
 b=CZPrxavN4XlDaW1PQVdZaANTJAXZQjDldyVrAMBBYgg6NpYMr2OUJCc0BNOvpXEIXRMPMOB7BUY/b4AY2MMqsC/i7oAgmzQl+e8EMK2uuxhbwOHCL+Y8E+qYapdZtRKRSqiLa7RQLHzwBNyE1UQf+3tr409SNeEK47uYZFHx5xCopOIpE1e9RMZjHXHZOvn36mgrlCDRgt8GVaSLtKdCRK+Ezn/lSTc2cYlubYWHyHxtrCpSnLRumu83slKDwxhNNz2fR8t1JDMLckvMJcXdGgqnK7Sbbc2ncUHCy3QB7Z68L9BUPcGE6HZ14s79+I21cmEV9RDYt/tWfnLdsWe9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1236.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 05:36:57 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:36:57 +0000
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
Subject: [PATCH v2 09/22] dt-bindings: clock: Add StarFive JHB100 System-2 clock and reset generator
Date: Thu,  7 May 2026 22:36:19 -0700
Message-Id: <20260508053632.818548-10-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: da00f91c-8f02-4ce6-fb95-08deacc3d1dd
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020|22082099003|3023799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DNtUO8yrFfj/3TDrPAkK3hk0K0pP5Fu0Ls11QxOO73vf8dEP4QGLS2R5vOaBee/74kvS4f57XsobEEfEtPwgUDj/6EZrVJYBt6zHvyGWHfQdnfxetByGSALYIqm4yCbfpYS9WNIkKZQ/R15Bs+0933v2r4+p5HT/kPCEdEzzgswAvboNvoTvo4/brhxqkm63qsUwe8SCOC+8NwqSwGsJKeMJE3FfQhSfT5d2XV6yc3Mo40CTpn1lWmJSGsfM63nOtEaZEumQUZPvu3XY8FobndsA9lLHd/wJotYFBuBxgMtrE70Lu/HYv9uipiXV29PWts8WYGEvjxa2SirlXw054+B0jVYRx8sz/f/W3UUKbvL2V8f/TVsA9k2Hds/gqR82+QF0aXt8FaHYjId8wxafYf5Tazpf/M3uwK1Gy7bi+rPO/4CNenvDNl8hzJqXj3aVvg3QIpPsN7JyqxnuHyGkkfquJe6NMTJIp4l5Fyh++P4rbAvTwQZ7t+T8lS5Or4JYrcMWGIBZ8GBiBpCzwAZ1sWV18uw+pz4Pf1pqAPC3+Nb29qUOFMNqrptMwW4cjiUk0/Mw4jMZCaVrCxCjxESfVg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020)(22082099003)(3023799003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0gxYCnb5Drc2fBw6VMqclf/RVgmXGIidJhB+gzsCFgts926HShk3clSoXpU5?=
 =?us-ascii?Q?QTdSiH93vnBPi1wxJOL1dRLbyap3zsqOWkKi6hiYGfQk8ruxbmJLaJult7/i?=
 =?us-ascii?Q?4aaWkrpEmjLbh0X3y4910OtfGIHvNApncIoO1P8xe0OLxiWTjhvJNWhjqfiV?=
 =?us-ascii?Q?jtxC2/HM3x57kfD79g4hqnV7QsnGJIA/fZHdv+ovZUtRuD7fs72PnY4mHun9?=
 =?us-ascii?Q?P3JG2qBxQVEUA46hg0kEqG+yLx/Z9zngHiGVV0TyK89nfvRUrF4Sw++tzgEf?=
 =?us-ascii?Q?35Do22eUdev8eFTD8+gsz5eMNOHmqKGcdkVzQnOI0TYKiKj5M0Kmv/r7vDQt?=
 =?us-ascii?Q?8DEBhvtQ88jF9kkbAxIDB+Nikvtgg3VQLZ9NFWrgAobYV+Chd+JFjspMFLOn?=
 =?us-ascii?Q?XB4foMpcSSs4UfCx8KfmLwYJC6jhCH381Kp+HvMyr/sEPBQTSqMT9WSU9Dwf?=
 =?us-ascii?Q?w8qiNyh+5uYHI7jG4KWhwYQfFVniIlNdiL0Frf3iuzf5iWn0P1hwkjapEmhL?=
 =?us-ascii?Q?nCoUQkCFVgJLRagle2oqJv4A1F+lUc6leusShFxZG/IhYaKI3+1lgpJrQhBc?=
 =?us-ascii?Q?KSOP02SJoW6gLrMJqJkzWzY6/M/M2dIcaleCPwoytrmkXdatddRT06IoMc9X?=
 =?us-ascii?Q?crkaOecK0xfdrlazUe7ron9mwzsNVZanPMEVNCfLHtzSdSTQnQLoSHZvUnNM?=
 =?us-ascii?Q?hKTt0GFttmpeppRp6+8G7UxAS3cgYMNOttcgthN+ENU5ffEVqeOZaUb0g9qY?=
 =?us-ascii?Q?vtPKjc0Qz6kMyTBX7/vBqkr/8PrbNhbX1Gso+W7pGP34V0MIyQ7Uvf+9YjIW?=
 =?us-ascii?Q?U8i4s3f1pl8jxtLfbvpa9l1pPrDd8sUO2vKq5SQcB5wh7p8Gkh7rxP6G8mL0?=
 =?us-ascii?Q?wk8Jm9peqEbHG5kXgEK44k1LWohToANN06KRaiWu4mYr/ZJxwHc1D/fodvwj?=
 =?us-ascii?Q?zZtJdOIBJPwsKyG5OkkGackH5OMOtHqi7JOFx+wRohomH05UzC29ijOxZr7g?=
 =?us-ascii?Q?rVNEbXZUIMLSIIer3U04s1fo8r0LRD4Mxr9tLc7q489wfSvF+Zj+nctPxEMq?=
 =?us-ascii?Q?DgZ99nQWBMs+MF2Ktr8cRuWwcNwdUpumyvS24zGpkQ9+lTTl1ngdd9Kt+tN4?=
 =?us-ascii?Q?TxWmsdYr4VSvzHlEmzJzyxi9NxGltZhg+3wPThCKgsHgIQU3MTrhSrRT84eP?=
 =?us-ascii?Q?xytld/JpQVzyEPvEfdP7HxUCVkfE0A/X+tEWhL+UxPZyZ60BIvmOBA7+Ol0u?=
 =?us-ascii?Q?dWI8s+O8lg9koqc1sbgXVdFERA1+hHAcaW2baryA6Fyyk/fMEG7S/Ow3nxwW?=
 =?us-ascii?Q?TXKhPRCknHxgo8VGjq9DTtKNaOQuy2eItyYog7QaGGLYJklpt/FSBdLitTli?=
 =?us-ascii?Q?uIyMwS/UBiX4694nOqFRiehiY6Zsh+IEXexeVc3LdmoEgotXLSue0ukMzMua?=
 =?us-ascii?Q?gmkRuS2zMKWt9Ys0/hD7tFy7Zvbo4r4ndLqz3qKwFpROGt6gAVfTgjvTzD9D?=
 =?us-ascii?Q?v/BCnyelkoGlcL/jbSY1zr4NC8/DOl9eildmbgzU0TGKQu40I2Gbh4SkHfDV?=
 =?us-ascii?Q?r8BAQW3NB/QwJ07hjjiXIUJl+5bm3ce1rJ//DXa8jfoU14x81ilZPw0u2uV/?=
 =?us-ascii?Q?Umk97TaOnbGiN1XbAEeCAQ39Q06zutOufV/3NxWX9w64gszN3kCRhcwfrv84?=
 =?us-ascii?Q?H8aqnWFVm4M/0O7KHHC8LMOLb6M8JdN65aV3/aytrQO/8EmTWDV6Akh6sK05?=
 =?us-ascii?Q?FZXTDh9b97Cvu1hH99z/IhvOh6h9fUOqvSmZVLoy+LSNTJG7vShG?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da00f91c-8f02-4ce6-fb95-08deacc3d1dd
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:36:57.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8GUsBuPLiFXiZydNpaXDJncqn+FV1s+JuXhLBUVHVllSSFZFjK51OGrlK87zCOdRDNKrcLO9y/UD3Lzco9TULUX50u89AnQ64VjQXIXGuNVLfI2joflVhk0OvE6NnxM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1236
X-Rspamd-Queue-Id: 5935D4F2091
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
	TAGGED_FROM(0.00)[bounces-285648-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.829];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,starfivetech.com:email,starfivetech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.198.124.128:email]
X-Rspamd-Action: no action

Add bindings for the System-2 clocks and reset generator (SYS2CRG) on
JHB100 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clock/starfive,jhb100-sys2crg.yaml        | 64 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 33 ++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 25 ++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml
new file mode 100644
index 000000000000..25ffb9d8dfcd
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
+      - description: GPU0 Non Coherent NOC Initiator
+      - description: GPU1 Non Coherent NOC Initiator
+
+  clock-names:
+    items:
+      - const: osc
+      - const: pll1
+      - const: gpu0_ncnoc_init
+      - const: gpu1_ncnoc_init
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
+      clock-names = "osc", "pll1", "gpu0_ncnoc_init",
+                    "gpu1_ncnoc_init";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index d7904b32bd51..d19618e2a846 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -73,4 +73,37 @@
 #define JHB100_SYS1CLK_BMCPER3_NCNOC_TARG		18
 #define JHB100_SYS1CLK_BMCPER3_CFG_125			19
 
+/* SYS2CRG clocks */
+#define JHB100_SYS2CLK_JTAGM0_HCLK			3
+#define JHB100_SYS2CLK_JTAGM1_HCLK			4
+#define JHB100_SYS2CLK_JTAGM0_ATPG			5
+#define JHB100_SYS2CLK_JTAGM1_ATPG			6
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
+#define JHB100_SYS2CLK_HOSTUSB_NCNOC_TARG		17
+#define JHB100_SYS2CLK_HOSTUSBCMN_CFG_500		18
+#define JHB100_SYS2CLK_BMCPER1_NCNOC_TARG		19
+#define JHB100_SYS2CLK_BMCPER1_CFG_250			20
+#define JHB100_SYS2CLK_BMCPER1_CFG_143_DFT		21
+#define JHB100_SYS2CLK_BMCPER1_CFG_143			22
+#define JHB100_SYS2CLK_BMCPER0_NCNOC_TARG		23
+#define JHB100_SYS2CLK_GPU0_NCNOC_TARG			24
+#define JHB100_SYS2CLK_GPU0_BUS_CLK			25
+#define JHB100_SYS2CLK_GPU0_APB_CLK			26
+#define JHB100_SYS2CLK_GPU0_OSC_CLK			27
+#define JHB100_SYS2CLK_GPU1_NCNOC_TARG			28
+#define JHB100_SYS2CLK_GPU1_BUS_CLK			29
+#define JHB100_SYS2CLK_GPU1_APB_CLK			30
+#define JHB100_SYS2CLK_GPU1_OSC_CLK			31
+#define JHB100_SYS2CLK_MAIN_ICG_EN_JTAG0		32
+#define JHB100_SYS2CLK_MAIN_ICG_EN_JTAG1		33
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index da1b51621172..fbc55f95e76c 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -36,4 +36,29 @@
 #define JHB100_SYS1RST_BMCPERIPH3_RSTN_CRG				7
 #define JHB100_SYS1RST_BMCPERIPH3_RSTN_BUS				8
 
+/* SYS2CRG resets */
+#define JHB100_SYS2RST_JTAG0_MST_WRAP_HRESETN				0
+#define JHB100_SYS2RST_JTAG0_MST_WRAP_APB_PRESETN			1
+#define JHB100_SYS2RST_JTAG1_MST_WRAP_HRESETN				2
+#define JHB100_SYS2RST_JTAG1_MST_WRAP_APB_PRESETN			3
+#define JHB100_SYS2RST_HUSBCMN_HOSTCMN_RSTN_BUS_NCNOC_INIT		4
+#define JHB100_SYS2RST_HUSBCMN_RSTN_HOSTCMN_CRG				5
+#define JHB100_SYS2RST_HUSBCMN_HOSTUSB0_RSTN_BUS_NCNOC_BMC_TARG		6
+#define JHB100_SYS2RST_HUSBCMN_HOSTUSB0_RSTN_BUS_NCNOC_HOST_TARG	7
+#define JHB100_SYS2RST_HUSBCMN_RSTN_BMC_CRG				8
+#define JHB100_SYS2RST_HUSBCMN_RSTN_HOSTUSB0_CRG			9
+#define JHB100_SYS2RST_HUSBCMN_HOSTUSB1_RSTN_BUS_NCNOC_BMC_TARG		10
+#define JHB100_SYS2RST_HUSBCMN_HOSTUSB1_RSTN_BUS_NCNOC_HOST_TARG	11
+#define JHB100_SYS2RST_HUSBCMN_RSTN_HOSTUSB1_CRG			12
+#define JHB100_SYS2RST_BMCPERIPH1_RSTN_CRG				13
+#define JHB100_SYS2RST_BMCPERIPH1_RSTN_BUS				14
+#define JHB100_SYS2RST_BMCPERIPH0_RSTN_CRG				15
+#define JHB100_SYS2RST_BMCPERIPH0_RSTN_BUS				16
+#define JHB100_SYS2RST_GPU0_RSTN_CRG					17
+#define JHB100_SYS2RST_GPU0_RSTN_BUS					18
+#define JHB100_SYS2RST_GPU0_HOST_PCIE_RST_N				19
+#define JHB100_SYS2RST_GPU1_RSTN_CRG					20
+#define JHB100_SYS2RST_GPU1_RSTN_BUS					21
+#define JHB100_SYS2RST_GPU1_HOST_PCIE_RST_N				22
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1


