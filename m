Return-Path: <netdev+bounces-285640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFlrCIGA/WnSfAAAu9opvQ
	(envelope-from <netdev+bounces-285640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:19:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6502E4F264D
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBB3D3035AAD
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB06F344D91;
	Fri,  8 May 2026 05:37:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2133.outbound.protection.partner.outlook.cn [139.219.17.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B8833FE36;
	Fri,  8 May 2026 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218619; cv=fail; b=VOTCiIF9U+f6hVlmaruCzZC4JRm0U2cxFKWVmxbp0ufZtv43GDemGKg2yEC95T3LxJa1ct1APOYOMwBvlAwBfWysA3nEump1TO4HrAVD4B9dNpt9O6qqXHJguCjGUtwIOlbt33i1FHXGEu+4kG4zSjzHgeQhNIiC0DkYC+nSqng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218619; c=relaxed/simple;
	bh=/qmedbzTky67P2DCvwZl4RLwHNRF7Mp4xT9YXSilbzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jfJCbOtcRh5UKhwMLVTsrxSOp9h/NsqWQLsgaOJxIPZbaZ87lWWNX2q7wjtLHxckfZ623sRIldowiNHtMFEPYto3G7YJHW+UxnQc4hyVX+sKtrotfUBWsf0O9+7msnHCI9epGNDxw8wTEXML7Nmpu96Z6vDALnMe6UxfmVFuoKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFFlz9tn5xHwSUSQrwyAznsQXkq4cQC80C4GPpafPybnKlvb1Kyv+ssAxBBDbodOvG10ySoNsP2Yoru+7gIYtktLSIMmV6voaMl6flJtcK+HHNa2QWNwahFvmx0cCBVHv8I05YfM2zedrzt/2YQjOqfF8DC4GqC7PsbyPU85jeg0uCWaSVu6lq8CTnHYr0DlXJySiOIopvEJuk9ifhyVGFtjR3Nnk78xLhfblR37VCuoxFfAIsHRwbJj1ylxAfm0C8effpciR26o0FdSWF1XMHTwMKnm8KsZynGkN7Mb3KEt72QCSWhM0ESD/WP8Xj4WuO9kRy03w1szpuFuav0Yow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldJnOt8Pray8903U8AAHb6dWZCq/yam0DJ/QQEdohz8=;
 b=NPJtEWX1BmIqjr5eXMOVm2TsAtln9FjoBEoaFQJMZb9rfYRwoWiyuRCliz20PzEmdTI1BVV0YFmxsAThiSJMuA1BcYQJsMb+xb7PjACAFjXiUAcipjFjaem1K/BXt3D3VpC0lm29T4NiOVmrS6nXtW/zJsNWGB2gw7f5036JTmnXlhMRxjfsYBbHyLK9br25QJelpYvtMsYlz3ELP/BKtHE4ss+CRa1CtozZdcdpjeM+PGQePOm7Zp+yJPBN+HmkDwOC2k2b7uBgmaIY/sx6xQL4nIkMcR24L7BUNqva9m8CKSmzWm4y9ezPOtFR4k4xyf4uvcXV/lRJXCXDaG0ZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1236.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 05:36:46 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:36:46 +0000
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
Subject: [PATCH v2 03/22] clk: starfive: Rename file name "jh71x0" to "common"
Date: Thu,  7 May 2026 22:36:13 -0700
Message-Id: <20260508053632.818548-4-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 16c8c1b3-7283-4a10-96a5-08deacc3cb05
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Is6JLyWakoKuI2T3Kp1eiNUVgofZmORYeXMI/qslGrEVk1ZXRJIjJlHn/OYFOx0Gp8cogl4Ozy5w4soFGfhYYwnS/CQcqozY7lTIMDL3e3lRbkZN/xXdknEd83CY9pxb0lUuzK6hq5P0SWHwQMFixGAGL2wcZtVnOoQeWmTLXiWOACO9HKHPa6XVh2OZXMwT8sNGkJRi9dwZVSUO1RKMc/aqZpOtnZgbnjfIQZIFDY4oDmi59b3VVzo3z3rDPJs6uLmVowbz2VCaJwfvkRUVEcfYo6yDu/LWdpyFr9xOj4TLVdTfKF5aKMDm7/GKi2pZG7HhOq9xb71siAnEnaNu0vOqCOSP9+wvK9NAh60foFeTcCb1rAqN+2RLZOemQanU7MP+Ypmxg9oVsCdUbZ4bZy++H4gAC4Tk1k3BrvNRzI/kLm9QKmST3D/xgTXLMz2tksWUH8mJneO5DxYtdd5bDqNlE5xVoP9V8dIRK/u6/xPLeXKnNH7OoDy05k9mam0V2NiRo2CTugsnzry3mC4xYrYCKRA8Dh7ixL3GeMYxJ8uW+nFz0Pp6DPIOpyMf2e/7K+atZpOSn9pVakeFQ+wbVw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6HqMnJ/RTk5hTB7SUs39a2sq+NnY6o2BVtPjy8XmwNiauE1stlMkaM2FmkD/?=
 =?us-ascii?Q?ZfECe0+8ZYF697TjcdyLafJl6tCC5BBUjzq+U48RJEfEAtPWQz8Wa0x5fl01?=
 =?us-ascii?Q?xuHD9Ywh3fYiCidtMXG9h7lSY2mPKsoos9CcQNuwk4KTEulCCsSvZF8gCsZF?=
 =?us-ascii?Q?3QFKsk2Myo65nqqQszFMNcT7yxbXPMwB+bcoWEr1Ro6hKaG8QNH5GOD4dnVk?=
 =?us-ascii?Q?yrkSsGxGMH5A0dtmjlOmlEOKYUW8zdHo1niI+BPd6Jf3s0B+bRqJZ8NxKAsb?=
 =?us-ascii?Q?UUwvdzGO504KrDPDoopT6tDeeYr6ILsNUz8Q01FY9Ejki6gdAYkGtuw7r95B?=
 =?us-ascii?Q?K+Y4/RtPGjQ7ZcwHQx9xEWmAEa26uAPEEpH2HGdXOpAyw7893jYUEU5isOkP?=
 =?us-ascii?Q?cir00yqTJsUS3JPB68EgPFbknDg5TcZqnZwU4P9PKi4FlnMCCBIFJKvqFnfh?=
 =?us-ascii?Q?hUo9PkGiTQkxjjUMJ+QrcvBRQR88slbuUlqAy0QQc3Z47GlAzggAu4iz6xDW?=
 =?us-ascii?Q?cNFbyMhE1bHZm+C9DuG5CyEdOehDsr+Pvb7QaG0X6dzJdRg7W3dnWHy5Q1xY?=
 =?us-ascii?Q?+fJWFZgcxqe11d1gIxLuVxHcLzZ7EeNVXsmX3SqG0wM+/5AT+iJyJ+AIRubE?=
 =?us-ascii?Q?3rBFa4FeRHYOOIHw33rBGr+2Ob4D6cCfT/qAmN8y88oKBhiZZwWhYmOagXHo?=
 =?us-ascii?Q?EsvVPJovqTJ0Fd6SYyNnDemdmR6ab35l7XJDMroHMl6+HCo4j3tiBsA46dsp?=
 =?us-ascii?Q?ZHvF4ASMifTH6kaoJMJXAR7w71trf3uE/aLBW8UdTLrI7pf9+78ihH5RwyXU?=
 =?us-ascii?Q?IZ3B9w0Io283it+8TRt1F0WGyNQusUISIDuGf6Hu6P6XxdemwUMdb+OMxy3D?=
 =?us-ascii?Q?oGTvRQ32GnFVPpPRPiQM6LfHni3+FoRCzC3HHP8mnXqq9YtkueQFvDC57OjK?=
 =?us-ascii?Q?rh/hY2vFEaEyLvDicWZmLbDRytyXATAyHowtmgHilEMaD1dx4lrdj95VOtCz?=
 =?us-ascii?Q?5ORTEoSu4DgSghMvhdX2GuWIg5OQalvVQexvsYOSWe4qExffCdGMGX26dDTS?=
 =?us-ascii?Q?DJasXJOAx+KznJoAo8ZnP5icAotLtT1nQJDTr4Ur1U9VdkqnMIgOwXSnq1dY?=
 =?us-ascii?Q?T3hDzZqtKOmVo/x/vZvJ+WKmHRA0sVjmUnv62pyMqr3nbOZ4JUuO/p8zSsN9?=
 =?us-ascii?Q?ReIg+wmHltid3j5yqf0Ah8tNTHHnymVjjh185ho1VR/9mNHlTJ7Roa3H3dm3?=
 =?us-ascii?Q?VeYVw6tbhGlRc4ak2lQ60ZFS7jHpQ682bvjqnMbiXzRFHGGzghyPAjM7gUWf?=
 =?us-ascii?Q?IAuetnxiq2tM6MMGZLOOOYgWUy7evCQ2GdeErR5YfDMkmWHYg7bMPWTz5ZhA?=
 =?us-ascii?Q?pmhg9nYzb7V57wzxIMMHXpN9KzrrlChV1fNVhNyKvTzYCjIYPRCIEQpTlm09?=
 =?us-ascii?Q?nrbk6npXrinowXaTtojmI8Rv6S7JjmMRgPTT6/0DcgNIC3LJX9OUWvmt34FY?=
 =?us-ascii?Q?If6xVHBDMmI2mWVITmcOA24tiu88IV1iRGKurPF1qOGSFMHsz83mH0MyLMDq?=
 =?us-ascii?Q?xpLn/2VDqRXCQnZpJ9/AsYsyiQp6avY5UgRV+00NApF+W/rvXolF8Uvq01cI?=
 =?us-ascii?Q?e+6DPM7EXhYWB0mfg5SsrBGL3T6Nh4dmkNmcBJdoYVEGQz50wQiKRYtefxq2?=
 =?us-ascii?Q?xZoq2OA2zQyv1/r8FBHvNFAWNPALfyzJ9ZoLxs/pZ5CyNyw7/cnK2kE8lOGT?=
 =?us-ascii?Q?hBfkLl3wz3C02unCTd1L3jQy/qediLRFlVVtWvvqHyAhmGM4PJLl?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c8c1b3-7283-4a10-96a5-08deacc3cb05
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:36:45.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvm2UWI445xb5l7+02gTFof3k/E/5ovrB67Zoi3+sUhgdHRXYeD8GqLSgoqEfWX+dFiOLTAu8kVfuueYn6lp6s1JxMNQ4cOr4C6vxmw5940egbQYqYFNbkWeOvwUoTNC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1236
X-Rspamd-Queue-Id: 6502E4F264D
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
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285640-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.766];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,starfivetech.com:email,starfivetech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,esmil.dk:email]
X-Rspamd-Action: no action

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

StarFive JHB100 shares a similar clock and reset design with JH7110.
To facilitate the reuse of the file and its functionalities, files
containing the "jh71x0" naming convention are renamed to use the
"common" wording.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                              | 8 ++++----
 drivers/clk/starfive/Makefile                             | 2 +-
 .../{clk-starfive-jh71x0.c => clk-starfive-common.c}      | 4 ++--
 .../{clk-starfive-jh71x0.h => clk-starfive-common.h}      | 4 ++--
 drivers/clk/starfive/clk-starfive-jh7100-audio.c          | 2 +-
 drivers/clk/starfive/clk-starfive-jh7100.c                | 2 +-
 drivers/clk/starfive/clk-starfive-jh7110.h                | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)
 rename drivers/clk/starfive/{clk-starfive-jh71x0.c => clk-starfive-common.c} (99%)
 rename drivers/clk/starfive/{clk-starfive-jh71x0.h => clk-starfive-common.h} (98%)

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index bd29358ffeec..ff8eace36e64 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config CLK_STARFIVE_JH71X0
+config CLK_STARFIVE_COMMON
 	bool
 
 config CLK_STARFIVE_JH7100
 	bool "StarFive JH7100 clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
-	select CLK_STARFIVE_JH71X0
+	select CLK_STARFIVE_COMMON
 	default ARCH_STARFIVE
 	help
 	  Say yes here to support the clock controller on the StarFive JH7100
@@ -15,7 +15,7 @@ config CLK_STARFIVE_JH7100
 config CLK_STARFIVE_JH7100_AUDIO
 	tristate "StarFive JH7100 audio clock support"
 	depends on CLK_STARFIVE_JH7100
-	select CLK_STARFIVE_JH71X0
+	select CLK_STARFIVE_COMMON
 	default m if ARCH_STARFIVE
 	help
 	  Say Y or M here to support the audio clocks on the StarFive JH7100
@@ -33,7 +33,7 @@ config CLK_STARFIVE_JH7110_SYS
 	bool "StarFive JH7110 system clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
 	select AUXILIARY_BUS
-	select CLK_STARFIVE_JH71X0
+	select CLK_STARFIVE_COMMON
 	select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
 	select CLK_STARFIVE_JH7110_PLL
 	default ARCH_STARFIVE
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 199ac0f37a2f..012f7ee83f8e 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CLK_STARFIVE_JH71X0)	+= clk-starfive-jh71x0.o
+obj-$(CONFIG_CLK_STARFIVE_COMMON)	+= clk-starfive-common.o
 
 obj-$(CONFIG_CLK_STARFIVE_JH7100)	+= clk-starfive-jh7100.o
 obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+= clk-starfive-jh7100-audio.o
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-common.c
similarity index 99%
rename from drivers/clk/starfive/clk-starfive-jh71x0.c
rename to drivers/clk/starfive/clk-starfive-common.c
index 80e9157347eb..4aecb65e9fd7 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.c
+++ b/drivers/clk/starfive/clk-starfive-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * StarFive JH71X0 Clock Generator Driver
+ * StarFive Clock Generator Driver
  *
  * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>
  */
@@ -10,7 +10,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 static struct jh71x0_clk *jh71x0_clk_from(struct clk_hw *hw)
 {
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-common.h
similarity index 98%
rename from drivers/clk/starfive/clk-starfive-jh71x0.h
rename to drivers/clk/starfive/clk-starfive-common.h
index 9d5dec1d5cd1..f634c62c196a 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __CLK_STARFIVE_JH71X0_H
-#define __CLK_STARFIVE_JH71X0_H
+#ifndef __CLK_STARFIVE_COMMON_H
+#define __CLK_STARFIVE_COMMON_H
 
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
index 7de23f6749aa..4505d309f664 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
@@ -15,7 +15,7 @@
 
 #include <dt-bindings/clock/starfive-jh7100-audio.h>
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 /* external clocks */
 #define JH7100_AUDCLK_AUDIO_SRC			(JH7100_AUDCLK_END + 0)
diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index 03f6f26a15d8..bf82190b9c57 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -15,7 +15,7 @@
 
 #include <dt-bindings/clock/starfive-jh7100.h>
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 /* external clocks */
 #define JH7100_CLK_OSC_SYS		(JH7100_CLK_END + 0)
diff --git a/drivers/clk/starfive/clk-starfive-jh7110.h b/drivers/clk/starfive/clk-starfive-jh7110.h
index 0659adae4d76..6b1bdf860f00 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110.h
+++ b/drivers/clk/starfive/clk-starfive-jh7110.h
@@ -2,7 +2,7 @@
 #ifndef __CLK_STARFIVE_JH7110_H
 #define __CLK_STARFIVE_JH7110_H
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 /* top clocks of ISP/VOUT domain from JH7110 SYSCRG */
 struct jh7110_top_sysclk {
-- 
2.25.1


