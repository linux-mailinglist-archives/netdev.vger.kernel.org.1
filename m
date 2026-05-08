Return-Path: <netdev+bounces-285647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNlFGS54/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:44:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2B14F2071
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 159BD302D5CB
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A72372EC5;
	Fri,  8 May 2026 05:37:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2101.outbound.protection.partner.outlook.cn [139.219.17.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F0366045;
	Fri,  8 May 2026 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218667; cv=fail; b=ia2w20EIyDSMKQEthVF++Cy6CfYlm9z/l87+Jx5WDakElNxTlD4BxzW8Fec5r52N9osmg0pkAE+k89jPFo6lp5sU2hdH8VFQv4fxhdP04I7/tAJrw8s7gDR4WdWc7aFMTdw4KfR1Ng/ttm8YLZoJB1vH/UjUo+ezSPdA0VWEibY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218667; c=relaxed/simple;
	bh=BtGDAiCWTD2OzmUQKlPrFkJJG0vyieGKq2CalA/RR4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D3L7HDiI2iUVo7t9J1SJn0wIYA9ykTd1oryalWyAnORkwyDU9caUyXel8D+zcWrAymswZVyuYTcVu8+yrOlNDEPm33fiD/hr7m/dNeiodCEtQZJikx1iCO3nTbYeuwBkbmgGq4AjTH0WVziKaALesn8uZLSS+oRBi++FcStE3w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQTTqD96Dpa5lDXu3uyoXdKoVJxVWNZpm3GcSQhq//Ue7LYDA5Q39Fn61jB4k+FGLIcSr0nNZcR0epjMrOXe0CXfpCS05+N/fWSjS9w6xKeRspVPUYi4LmjPTREj8CRD5LRqshNQTEUYSOu9jHkFMK5CVgN2KcqkyS1l7rlbQn7Bp98TFHUYRZUIOKAZihmlLm5apd0+hmD04/dnq2Q+Bml3oOTRxqJgkn5/T8pg3zN4iZOmQ9RfgX3Nd1CjM+93HxSx2hRCtNPSuxv1Hi6yvNdnluKlAiJIe79ecBEFb0f5X4kB91Y+mOJ/y9IXRM39uHNYQsVzJGNp2dceeIMTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O7GJZDL6POhZ6R/ouHkAUr7Lnai4C4vhFjhtZbuxxY=;
 b=MdUCLP90ubNCUb41R9crVQ9PF4QVwY/rrq/8QK5DEPzU1xZ0B6HibW5RGjLB4jYmNV/NEqA6RnXd7kCY8R4SPGi/8hqLXPY/NCMwfNcQzqSuugb4greWLG+qPHxGVFq4dJ0yg78a6XC+UUfi/66GtrjtWQs8l+CRBbhh5HmjywDParQ0i30EBH9x18bZRYsUjKDHZ4KhgLK3VFifnYkLTOcdgfRyD5stNWce9TzQNxZak6yAL0EYwxg84+YEOSjOMZ/wksv+QsdfvsLrwX0Z8IfBZg/HJApstYowTKKSwvPG9jrkd5jV37zNn5A+VzFprs8TeKJpc2F6zZMXPrSYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1236.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 05:36:55 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:36:55 +0000
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
Subject: [PATCH v2 08/22] clk: starfive: Add JHB100 System-1 clock generator driver
Date: Thu,  7 May 2026 22:36:18 -0700
Message-Id: <20260508053632.818548-9-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4535aeaa-e23e-478c-2703-08deacc3d0b4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5gXWE6wiem4ODjBY+oNtoUECtDRhcfmkdvz/+DVmq09ZSrPppHCJjzpMsjzUr0VwBSL27wIylp6rpg2iGRThmH2eNg4TjkCZ96vZk9OwharZKu33B0MPiRvP/AzzU8vhN+J32UrxodRXYY49vd1ExXgH3ADOd3hsqkacuvHJQ7UG7EHB+T0ISOhjsy6uvg3Q5ZmKBhPpV7Xdim/mHFe/qeEzKbpmdy3E/iNlJqxKOu9cC+QXgVTwvBhZMAMV3nYScuU/8bVp7LtGHxgrJnMF9Jr53eUrmAdbT7lSDVQTY1sUmn9ARlwWl0iAw3/+3Fs+dV86F2B/MuMjxEc01DU2n6efvmESTRr86OR9FsIkx8cw+3DDXJ1tEwDYsB6+L/439yLyBuKtM8w4oZDvl2G1mwpzIwnYdsKrZQOi3GTLZphRIJcJMpfMwlErcKgonW8iaLHyS4Q7QZ4mS0gDYSortYi3wsuEPJBtx7ZoKFbcKGs0Xp0KEnFlBAFnYFnNppMj1YnZaPp7wgP3dQNaSB2+zi7+YFSMK11ATTOPrWoIMmw2rP7yrVa6xCDIBUpRr2pp0RO9viikD41B9iiWrbCtdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iZVh4WqpkSQWkBE3QijV8NLFGVCYb80YHYBwdaom+ahSUL4yqukdNdd5tvbC?=
 =?us-ascii?Q?5o/qoVwxlIjEatZTV97LWSSy+4aVVntb0GttTLUR0FUECMY/NEQTSvSosY+C?=
 =?us-ascii?Q?VBRIJELT8jpGQOQ1FwAkLQ4vRMxlAPI4yqm7v3cKK3ZsMg0cO/8Tyxx8Pg6s?=
 =?us-ascii?Q?HTg6bWQXufv7lByMlL+oOGkylG5CRVOlOef8dCcvpid0Q04aU+2A6mmF7muO?=
 =?us-ascii?Q?DS8W8oYeEtHzEHgmJ5RXZ7n0tREi7T4lc/4hliED6+s5/fNodyJN19s7gtnB?=
 =?us-ascii?Q?YVimN4AKlYEydo44KrtNKzdSWa6rieRdOTABGO0u2fVZX9XnMJACsuYWktEx?=
 =?us-ascii?Q?AJpqhBJPDrOKAcm+EQ/FMjeEWxwBjh/14Axg7z5TmhMT6q4m+UFzTNtWTX5K?=
 =?us-ascii?Q?yu7wvVPJo6/md7Q44z3zQeXfCF1+X8WYBZWMUoWpr3uHiOM5WQNa41OieVmk?=
 =?us-ascii?Q?v1muw3VBlADjuBz9rntZZm1lBQNBL3pJjkXYtlBsIZxuWJmwNo5gIEtQPqjy?=
 =?us-ascii?Q?uwrYJT7Sr+5i+gZIOy7A1RBTRaRswLIgRjIfVUrSvu/OAnFlja1QXicSytnq?=
 =?us-ascii?Q?s0iN8IfgWa6LloS3yl24sb3alx9z4MhcLB9tWRwPamb4dwafzM88/8mryspP?=
 =?us-ascii?Q?pjDEIwLpmx5cWBfqlPmc2etMU2AHSTFFS2CJeSk/r0yaZ34ulFYeXnBqOP9N?=
 =?us-ascii?Q?URebwpT+Aa0fDDWIsB5o///6nxYAzJMWMHNn4A+UE1JCcE3trfLsa3Z+Cf4T?=
 =?us-ascii?Q?UsL7xh+l1au0uXg6yI5VFDyX2RveOA9vPL25RolzpPQmKwf6frQlJ9OqWGJo?=
 =?us-ascii?Q?SOXi78zH9WGRL5KLRozeSr3+D8WXOPMfZOtEQ6oCkUy8vS7CjRvqaCAtiLEP?=
 =?us-ascii?Q?TzO5ewbR2zCb0DvoVmG/qE81E5kNLjcqAcOy10HW4M35nCrlSXibfAPkU17F?=
 =?us-ascii?Q?CAam8ZGfR8Ne2B6JvvE+bEoHwgpt87ku1zLi1i/SQO2eb11KKazBs30KRknI?=
 =?us-ascii?Q?cJbUPEGfI8sr1ehH16Nky2jPtJHFQosJvLOHiB5opkD8EiQIbJXsMj9LsLvE?=
 =?us-ascii?Q?HwYOH/97dpZMH6OFujkGWCHihnRWXsdohjK3MXHVS05ueorjTiEnG9txJXrF?=
 =?us-ascii?Q?ZWo6bwi72Nh/08G66ulOtEV56Mmu55VYYaqrgk/HQlY4RVYws7SH7X+PnUwl?=
 =?us-ascii?Q?G7UoY+e6auCK9sUs9jNEMsiWlyFwSaZfG2ZBXJqKpB13G+ECAJDN2kYPHcDs?=
 =?us-ascii?Q?grtJbkKMHGKbGdwEe3RiGda2ISrO+Z1bVg/crmuUkImfaeRJIhx95xlagZGt?=
 =?us-ascii?Q?WU/hz0ZkopVxpM3rWxCdbOwByxJy5Xsa96lwUxgnm44wgmgWWgZl7HayKgOg?=
 =?us-ascii?Q?VsmsProGclO5sQDcR/DeLRYplaUh4/ySRQqxwW4wenTirVoyQ1kncZRgsl9G?=
 =?us-ascii?Q?DzfPLRawAj0ljmnBUX6hXXAMETKeD6htVrfMuiqXmSWnbUGCCmEKg2nkKL1h?=
 =?us-ascii?Q?Ty5li00u+H8Vsfl/hkdWPF6PNtozD2KD0JHYt7Vph4ppvXaHkbMvjNixikfM?=
 =?us-ascii?Q?CDCzU0dmvi6QlgU6Z/buHCcqawpwaRjk6Az5mn9bgNWXpP9hEl9FbpPHr6IN?=
 =?us-ascii?Q?UNABDLNOuHMSiXny3wK8PJGL0WjA5mnMnUmiSoL4Km4Enwu0Wu/JKMj4WbC/?=
 =?us-ascii?Q?eFflDFe4i34r+Yd3jeaAO5MNfpZvAvkPOUQcmXeqG2Q2gpiKBR+zniuWiJv3?=
 =?us-ascii?Q?dk4jAfVxMcZFeLFZkRdF2KhP/tWhBXpolPqci3HLu99pA3dVo2Ra?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4535aeaa-e23e-478c-2703-08deacc3d0b4
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:36:55.4043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6SW8yfVpJ05jfm2AEKWggd5a8MiEmRnsnL5aH0AFcQQpQ7XGAkyJaGNX7QgDEV7Aw7bNds1U23kAbr68EzsDzBoXUphZAADpi32ZU9rm28qj1KOe/Y4p23ZsxJ5zqIC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1236
X-Rspamd-Queue-Id: EE2B14F2071
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.34 / 15.00];
	RECEIVED_BLOCKLISTDE(3.00)[139.219.17.101:received];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285647-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.858];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: add header
X-Spam: Yes

Add support for JHB100 System-1 clock generator (SYS1CRG).

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   8 ++
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-sys1.c   | 105 ++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys1.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 7926e02ccd7d..b6042bcb5992 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -83,3 +83,11 @@ config CLK_STARFIVE_JHB100_SYS0
 	help
 	  Say yes here to support the system-0 clock controller on the
 	  StarFive JHB100 SoC.
+
+config CLK_STARFIVE_JHB100_SYS1
+	bool "StarFive JHB100 system-1 clock support"
+	depends on CLK_STARFIVE_JHB100_SYS0
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the system-1 clock controller on the
+	  StarFive JHB100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 2c5e66d1d44e..b3571e2f0555 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-sys1.c b/drivers/clk/starfive/clk-starfive-jhb100-sys1.c
new file mode 100644
index 000000000000..46ef9cc63f9d
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-sys1.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 System-1 Clock Driver
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
+#define JHB100_SYS1CLK_NUM_CLKS			(JHB100_SYS1CLK_BMCPER3_CFG_125 + 1)
+
+/* external clocks */
+#define JHB100_SYS1CLK_OSC			(JHB100_SYS1CLK_NUM_CLKS + 0)
+#define JHB100_SYS1CLK_PLL0			(JHB100_SYS1CLK_NUM_CLKS + 1)
+#define JHB100_SYS1CLK_PLL1			(JHB100_SYS1CLK_NUM_CLKS + 2)
+#define JHB100_SYS1CLK_PLL2			(JHB100_SYS1CLK_NUM_CLKS + 3)
+#define JHB100_SYS1CLK_PLL4			(JHB100_SYS1CLK_NUM_CLKS + 4)
+#define JHB100_SYS1CLK_PLL5			(JHB100_SYS1CLK_NUM_CLKS + 5)
+#define JHB100_SYS1CLK_NPU_NCNOC_INIT		(JHB100_SYS1CLK_NUM_CLKS + 6)
+
+char *jhb100_sys1_ext_clk[] = {
+	"osc",
+	"pll0",
+	"pll1",
+	"pll2",
+	"pll4",
+	"pll5",
+	"npu_ncnoc_init",
+};
+
+static const struct starfive_clk_data jhb100_sys1crg_clk_data[] __initconst = {
+	/* root */
+	STARFIVE__DIV(JHB100_SYS1CLK_APB_MAIN_SYS1, "apb_main_sys1", 12,
+		      JHB100_SYS1CLK_PLL1),
+	/* sensor */
+	STARFIVE_GATE(JHB100_SYS1CLK_APB_SENSOR_ICG_BUF, "apb_sensor_icg_buf",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_APB_MAIN_SYS1),
+	/* hostss1 */
+	STARFIVE__DIV(JHB100_SYS1CLK_GPIO_ESPI1_EXT, "gpio_espi1_ext", 14,
+		      JHB100_SYS1CLK_PLL2),
+	STARFIVE__DIV(JHB100_SYS1CLK_HOSTSS1_NCNOC_CFG, "hostss1_ncnoc_cfg", 12,
+		      JHB100_SYS1CLK_PLL1),
+	STARFIVE_GATE(JHB100_SYS1CLK_HOSTSS1_PHY_SCAN_1000_ICG_BUF,
+		      "hostss1_phy_scan_1000_icg_buf", CLK_IS_CRITICAL,
+		      JHB100_SYS1CLK_PLL1),
+	/* npu */
+	STARFIVE__DIV(JHB100_SYS1CLK_NPU_NCNOC_CFG, "npu_ncnoc_cfg", 6,
+		      JHB100_SYS1CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS1CLK_NPU_CORE_DIV, "npu_core_div", 10,
+		      JHB100_SYS1CLK_PLL0),
+	STARFIVE_GATE(JHB100_SYS1CLK_DOM_NPU_CORE_CLK, "dom_npu_core_clk",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_NPU_CORE_DIV),
+	STARFIVE_GATE(JHB100_SYS1CLK_DOM_NPU_BUS_CLK, "dom_npu_bus_clk",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_NPU_NCNOC_INIT),
+	STARFIVE_GATE(JHB100_SYS1CLK_DOM_NPU_INIT_CLK, "dom_npu_init_clk",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_NPU_NCNOC_CFG),
+	STARFIVE_GATE(JHB100_SYS1CLK_DOM_NPU_OSC_CLK, "dom_npu_osc_clk",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_OSC),
+	/* vout */
+	STARFIVE__DIV(JHB100_SYS1CLK_VOUT_NCNOC_TARG, "vout_ncnoc_targ", 12,
+		      JHB100_SYS1CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS1CLK_VOUT_PIX0, "vout_pix0", 4,
+		      JHB100_SYS1CLK_PLL4),
+	STARFIVE__DIV(JHB100_SYS1CLK_VOUT_PIX1, "vout_pix1", 4,
+		      JHB100_SYS1CLK_PLL5),
+	/* bmcperiph3 */
+	STARFIVE__DIV(JHB100_SYS1CLK_BMCPER3_NCNOC_TARG, "bmcper3_ncnoc_targ", 12,
+		      JHB100_SYS1CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS1CLK_BMCPER3_CFG_125, "bmcper3_cfg_125", 10,
+		      JHB100_SYS1CLK_PLL1),
+
+};
+
+const struct jhb100_crg_domain_info jhb100_sys1crg_info = {
+	.clk_data	= jhb100_sys1crg_clk_data,
+	.num_clk	= ARRAY_SIZE(jhb100_sys1crg_clk_data),
+	.ext_clk	= jhb100_sys1_ext_clk,
+	.num_ext_clk	= ARRAY_SIZE(jhb100_sys1_ext_clk),
+	.rst_name	= "jhb100-r-sys1",
+	.power_domain	= false,
+};
+
+static const struct of_device_id jhb100_sys1crg_match[] = {
+	{
+		.compatible = "starfive,jhb100-sys1crg",
+		.data = &jhb100_sys1crg_info,
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jhb100_sys1crg_driver = {
+	.driver = {
+		.name = "clk-starfive-jhb100-sys1",
+		.of_match_table = jhb100_sys1crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jhb100_sys1crg_driver, starfive_crg_probe);
-- 
2.25.1


