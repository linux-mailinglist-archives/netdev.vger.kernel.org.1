Return-Path: <netdev+bounces-285664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAN+Edl6/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:55:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E204F2267
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A65D53070389
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68652378819;
	Fri,  8 May 2026 05:53:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EFC344030;
	Fri,  8 May 2026 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778219598; cv=fail; b=Evj8VBivRXjCB26kVLcRnc1rsn263p5GoDlQxZDdESA5BL4O8Ewbf0NRDX7IaNqiaoHrV1r8SlfiYVMTD1HuJpMLtkxeJZO0xXyHxgyqxZlr6m8r+UE3fOQKs7qGplsOkVAKrGT2sUq+3ryG29dhqmM3OZCnu2PiUSTmV+9kPD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778219598; c=relaxed/simple;
	bh=zE/erFujjRJW8mVzl6vHOAhl6eGazzJaIUIaMl8ghfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okeG0yU2fA51vOHowafEgyFteMbKEbjrtqF6L9k5PFbJzs8dpStBCdsBjw//mpL0RTsy2yMpLKfPDDw2WtNm6Jw6qFZ0Yd9bbIApibmtJUcyPh9XxlxqexeXr76oN5MZhVmpUp0pEF4n+MjLMbyMCR+Qo2OxzGxbc1nlh7Y1Erw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbg8xle38pOIt5whHAWA/+CyKwkTxlhrcRJV/NKP6aCvRzCKLz9kxQtS89tY3PvUuVDxGO2Ou+0y7WfaxwSTQ/P9186oYXllIp9Qwn40kIvb4B/+0/lG5IlpUsRpll6ptkffsqIdzPr0m/nN5C6K6qtOgq1hn5JNJj1QbbrTLJggLX7Wlej2eZUo2KG2vJI77uoovs3tM7pUL6Re801cqG+hP50syOPCqbTn7DK+YE/wik57dGu0tLWRYDuTlXuAEUryS2ICkGHGaMEAL04+Ea9wFw2K0KW4O9ZS36+v08dz1/gE5l1CFRtt8ggtXqgreUSGG2rlEKEbTyZGPPNsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WH+cdqqAflMd1Trcg4/C9kwiQ0Ge4oC3OwYsttytqi8=;
 b=Y6x/0OSjq7HFnVD7v8ZYokpzteMXe8BtcwqbxA9QI7nHK5unp/GKJ3cbmwbZTADC4qLpDRwb9DYZHmvspqQRdJa4forqF/QXyi3fNdRzl5FGQD6PwCdA4W/uj+5ayiVzBOoB/cHMH8UiaNRgd147JDKUCq8vYZOsz0W1VXNdImmHl8KPFtS2LttEXl44g4/5lz1jZVE/WdbhUk6rRxs7bSiNLbnP3TQdlkEY7ZozmJq2CwL06yhemoAyls9IZWjWopY9BRdpWdo2XRrOPFv28JFolSvZaSo5Oa4nFbc5GwC5OObvZCfVHY+Ww0oPqQElfvvje+f1IV7Wi+51GRCQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 05:36:59 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:36:59 +0000
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
Subject: [PATCH v2 10/22] clk: starfive: Add JHB100 System-2 clock generator driver
Date: Thu,  7 May 2026 22:36:20 -0700
Message-Id: <20260508053632.818548-11-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9a78d615-4db8-4bf3-06ca-08deacc3d2e3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|56012099003|38350700014|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qeGNPCK6FTKUwsUk81LDYzUNU7qL/1Ml0Hm6iaLidup6nQgrNKbroTo6wuFkYVl2mMEw0KRGVGn4VroBmebqWFVIBoSlwAYpR/3mizdBSMM8orAUWWMcLGwvFYCvSF4IV96Oo6evAlWllcrHxD/oDPuv7LIEqTD+3q9Et7qZYaDDZFpvMfdybjlZbVuv6mEOxbz5f2CoomJdMGj8KKDgS4HreBxyAJhfuCazlJlbZ4kSmQc54IfYFMbEaz7PB+ArmH2STf+90VBfqIiEOsAeTALSce7rR/IEqYXpQypENi4OM1spyaWRou2NFw1KwqLE8/GhgHuVsBsJCAqvO+qPm0NQdcNh2iGgAYIdNj2d4uB1mdMHSAZLeDdQIPWgYGt+GP2u+0rD+o79CVkqIsA0gaCXL+yQgP52Zwcj98iNFK0Gv2Ozovr+H4MatHTYtBpmVlJHIud83IYbXXRksyRzB8MLV6ZMQLQEH5Km1zij2kgmfWFYYnnRfG4fwn/MMFNfpB09Mu6j8upRsaD8KWMSt463B7xxiLapDiBIQ8AMKAbpOIVg/GWU2/Zy5TgyMjaAHgYCHsancq0VwwI+nXkcJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(56012099003)(38350700014)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gE3HS7Ps5KcvzGVgFr1T+cUIngMhQOT6iACknDSU4EqESOS6V/x6x5zpH127?=
 =?us-ascii?Q?frfXzgC8x+oqTxR15qJvEfd092nhZuRgZrvUXXuNMi1hLFkinGtWK/lvNzGi?=
 =?us-ascii?Q?DY5gQ48PEZaEtcNmWM9iVN8KxCHekrlbZiX3giozLiw0QO7Ml3JO58KLRkaO?=
 =?us-ascii?Q?WsFpVwOYZShTGfX2u8nRiJj3DLKszDWlFgIMv+ypUIfg1YXlkh1cJiddOJLr?=
 =?us-ascii?Q?3yT1xIX2ZRSYGh4iEJEL1PJzpqlGPOIG94Vhve03ztzg8Ea6hbcAfu/LNGC7?=
 =?us-ascii?Q?azt9S+NDRYWPlG8aE7rHQfhV4Fzp5Y+xgVfrBuimKq7fM7SqbQuuw3RJ3GXD?=
 =?us-ascii?Q?ym0x5S7QsDzDuSQanIHYLeW1B2eqgiiRsWOxYSB/C4tC18ew/Y7k0QDU5y++?=
 =?us-ascii?Q?zthoYRr55WqioJ6cv69ttuDuw7X8x0DM7CE7UWuC9DjZ8KXq5HLuYIiCWeCT?=
 =?us-ascii?Q?urV5nn5ri2mL2yIq8PyAflChPUkAPVsVBdJoMWfg7LGMRjQw7kn96D0pn8Yt?=
 =?us-ascii?Q?a1L7y4njcdmS9LdXQ1lSDft51RUWTJesJOTynQjhuAQCLUB/2UYFA+cZFDFg?=
 =?us-ascii?Q?PJ+4jlh0jiivf14J3lHRWFVG1eG1q3i2Dk4iK2MpxnyLHVcNAyKlLJjXgQoA?=
 =?us-ascii?Q?/Z4FrFGZs/xTqed4VNuqKBrpW/A8dJpTM0OsYU3VU2+lMMmntpJPX2vcvekS?=
 =?us-ascii?Q?1p3wEkgr4Cfqrf6MieJMZqKoU/9owB9qlsOSl8SPXk8GzzShUoiH/DL1vOvd?=
 =?us-ascii?Q?QZMUaBwMkYe+zfkkIrxK0evpEFkgelQL2ADQOoiBlkh3RSOyZZE7yJ5Rj2Zv?=
 =?us-ascii?Q?kKVnUeYoLo/vMjsw5pXUSx49cjMaD5BO5U7zKCNSfE7YkCMzYdLIeYf01J7V?=
 =?us-ascii?Q?ZyAjU148qvsL3/lABPqIA8HmVNfljbhjIZpctxIsZPGqQqyXiO/W7x9oa6yz?=
 =?us-ascii?Q?gB5MykD5eqLF0GqGmhr8vEDjH/xPdu+DcbeQ004jV2ru6DzTqsYfOaVe5msK?=
 =?us-ascii?Q?P+xBsE+UAVgaMfFu4iRLtXecRdWDyWgwDhO6FDuGMgU/x5F6FYy/Sa4URuxB?=
 =?us-ascii?Q?qhIqad1IJCzvfGPcbuY/4YuOOgYuE30qXf/iJ5W7zi6NSIRjqOAKiJB700UA?=
 =?us-ascii?Q?ycnmLl8xJhE2olCm1tHe5G12BAdpOb8w0lDiv0b6nuQB1Q9WIQzBFY7QjDYU?=
 =?us-ascii?Q?pCeQ7qDXchYJPA2Y+enb5ZrMqIiipd5ylLDEjJt0gXAflllrFDzKx3NbBuFq?=
 =?us-ascii?Q?/hkhdsoyuxlYC3kPiLOwmv0VveZR+L52keUQcdhcgcaJpp3EJLdGpcjU3j/J?=
 =?us-ascii?Q?3IZHhwfmZcXzdX+wJf7BOde6N7Ecc2E4mdNE+nud7FtXbOMsXygI4wkIm93L?=
 =?us-ascii?Q?nvQDSj8LkzdisUNElOxwHmdJl2W3Ku8td/QOhL9UCZLMw0IUp3Tzh2RYtNmd?=
 =?us-ascii?Q?TepLbMaw5GFuO1nlDhZdP6pX703PQvyJsrth7nMP7fAa901/oxXR0NPXWOVo?=
 =?us-ascii?Q?y/swC1SpqfrYj2VXWNJP7quWWl86R0QmGDXWsNZVd2rebdRc87atvC0LfOfz?=
 =?us-ascii?Q?3ceX4wLTgg8up9/lfa2mYERgYFUQwYpMb6x8LvGyzG4O5vOar2DpyaSy6C2f?=
 =?us-ascii?Q?LIlfPVwZ7/TxvBzKBZ/bRBE/gkLyi2pJA9JcVqPA/ArvCkxSJPsblw5oizwj?=
 =?us-ascii?Q?tERRYwdi+mGfo5U8W3/TqumpK0BNcJKR0t/2Vz2w1umdfy6OXgPBQJyUSBo1?=
 =?us-ascii?Q?4+Yy8X11zLdW6g2P2mJGCNTIgDYP+VSw3IxgxlG9OxppT7uRxnhy?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a78d615-4db8-4bf3-06ca-08deacc3d2e3
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:36:59.0731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbz/9c48Slf2NiAQK9oL8wMa9zhMLrRQnE+KVxRi8dTpOaYZKPSNnBh2UVcO1BrgF9s6SAHflJ0v647gSSJoRm9tQqflqdOh3MQxiYPj2A2cywpchK9ahpm/1wQY0pp/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267
X-Rspamd-Queue-Id: B1E204F2267
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
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285664-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.891];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add support for JHB100 System-2 clock generator (SYS2CRG).

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   8 ++
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-sys2.c   | 128 ++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys2.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index b6042bcb5992..729bdfce7b8a 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -91,3 +91,11 @@ config CLK_STARFIVE_JHB100_SYS1
 	help
 	  Say yes here to support the system-1 clock controller on the
 	  StarFive JHB100 SoC.
+
+config CLK_STARFIVE_JHB100_SYS2
+	bool "StarFive JHB100 system-2 clock support"
+	depends on CLK_STARFIVE_JHB100_SYS0
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the system-2 clock controller on the
+	  StarFive JHB100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index b3571e2f0555..90b6390296bd 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS2)		+= clk-starfive-jhb100-sys2.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-sys2.c b/drivers/clk/starfive/clk-starfive-jhb100-sys2.c
new file mode 100644
index 000000000000..20ea5acf31ca
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-sys2.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 System-2 Clock Driver
+ *
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ *
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+
+#include <dt-bindings/clock/starfive,jhb100-crg.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include "clk-starfive-common.h"
+
+#define JHB100_SYS2CLK_NUM_CLKS			(JHB100_SYS2CLK_MAIN_ICG_EN_JTAG1 + 1)
+
+/* external clocks */
+#define JHB100_SYS2CLK_OSC			(JHB100_SYS2CLK_NUM_CLKS + 0)
+#define JHB100_SYS2CLK_PLL1			(JHB100_SYS2CLK_NUM_CLKS + 1)
+#define JHB100_SYS2CLK_GPU0_NCNOC_INIT		(JHB100_SYS2CLK_NUM_CLKS + 2)
+#define JHB100_SYS2CLK_GPU1_NCNOC_INIT		(JHB100_SYS2CLK_NUM_CLKS + 3)
+
+char *jhb100_sys2_ext_clk[] = {
+	"osc",
+	"pll1",
+	"gpu0_ncnoc_init",
+	"gpu1_ncnoc_init",
+};
+
+static const struct starfive_clk_data jhb100_sys2crg_clk_data[] __initconst = {
+	/* jtag mst*/
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM0_HCLK, "jtagm0_hclk", 6,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM1_HCLK, "jtagm1_hclk", 6,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM0_ATPG, "jtagm0_ATPG", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM1_ATPG, "jtagm1_ATPG", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM0_ATPG_TCLOCK, "jtagm0_atpg_tclock", 2,
+		      JHB100_SYS2CLK_JTAGM0_ATPG),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM1_ATPG_TCLOCK, "jtagm1_atpg_tclock", 2,
+		      JHB100_SYS2CLK_JTAGM1_ATPG),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_HCLK, "jtag0_mst_wrap_hclk",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_HCLK),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_CLK_JTAG, "jtag0_mst_wrap_clk_jtag",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_HCLK),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_APB_PCLK, "jtag0_mst_wrap_apb_pclk",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_ATPG),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_ATPG_TCLOCK, "jtag0_mst_wrap_atpg_tclock",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_ATPG),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_HCLK, "jtag1_mst_wrap_hclk",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_HCLK),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_CLK_JTAG, "jtag1_mst_wrap_clk_jtag",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_HCLK),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_APB_PCLK, "jtag1_mst_wrap_apb_pclk",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_ATPG),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_ATPG_TCLOCK, "jtag1_mst_wrap_atpg_tclock",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_ATPG),
+	/* hostusbcmn */
+	STARFIVE__DIV(JHB100_SYS2CLK_HOSTUSB_NCNOC_TARG, "hostusb_ncnoc_targ", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_HOSTUSBCMN_CFG_500, "hostusbcmn_cfg_500", 4,
+		      JHB100_SYS2CLK_PLL1),
+	/* bmcperiph1 */
+	STARFIVE__DIV(JHB100_SYS2CLK_BMCPER1_NCNOC_TARG, "bmcper1_ncnoc_targ", 6,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_BMCPER1_CFG_250, "bmcper1_cfg_250", 5,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_BMCPER1_CFG_143_DFT, "bmcper1_cfg_143_dft", 8,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE_GATE(JHB100_SYS2CLK_BMCPER1_CFG_143, "bmcper1_cfg_143", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_BMCPER1_CFG_143_DFT),
+	/* bmcperiph0 */
+	STARFIVE__DIV(JHB100_SYS2CLK_BMCPER0_NCNOC_TARG, "bmcper0_ncnoc_targ", 6,
+		      JHB100_SYS2CLK_PLL1),
+	/* gpu0 */
+	STARFIVE__DIV(JHB100_SYS2CLK_GPU0_NCNOC_TARG, "gpu0_ncnoc_targ", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU0_BUS_CLK, "gpu0_bus_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_GPU0_NCNOC_INIT),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU0_APB_CLK, "gpu0_apb_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_GPU0_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU0_OSC_CLK, "gpu0_osc_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_OSC),
+	/* gpu1 */
+	STARFIVE__DIV(JHB100_SYS2CLK_GPU1_NCNOC_TARG, "gpu1_ncnoc_targ", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU1_BUS_CLK, "gpu1_bus_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_GPU1_NCNOC_INIT),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU1_APB_CLK, "gpu1_apb_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_GPU1_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU1_OSC_CLK, "gpu1_osc_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_OSC),
+	/* main icg */
+	STARFIVE_GATE(JHB100_SYS2CLK_MAIN_ICG_EN_JTAG0, "main_icg_en_jtag0", 0,
+		      JHB100_SYS2CLK_JTAGM0_HCLK),
+	STARFIVE_GATE(JHB100_SYS2CLK_MAIN_ICG_EN_JTAG1, "main_icg_en_jtag1", 0,
+		      JHB100_SYS2CLK_JTAGM1_HCLK),
+};
+
+const struct jhb100_crg_domain_info jhb100_sys2crg_info = {
+	.clk_data	= jhb100_sys2crg_clk_data,
+	.num_clk	= ARRAY_SIZE(jhb100_sys2crg_clk_data),
+	.ext_clk	= jhb100_sys2_ext_clk,
+	.num_ext_clk	= ARRAY_SIZE(jhb100_sys2_ext_clk),
+	.rst_name	= "jhb100-r-sys2",
+	.power_domain	= false,
+};
+
+static const struct of_device_id jhb100_sys2crg_match[] = {
+	{
+		.compatible = "starfive,jhb100-sys2crg",
+		.data = &jhb100_sys2crg_info,
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jhb100_sys2crg_driver = {
+	.driver = {
+		.name = "clk-starfive-jhb100-sys2",
+		.of_match_table = jhb100_sys2crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jhb100_sys2crg_driver, starfive_crg_probe);
-- 
2.25.1


