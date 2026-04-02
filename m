Return-Path: <netdev+bounces-274484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHe0Ej5SzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:25:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6D538846A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E635307C41A
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220913C870F;
	Thu,  2 Apr 2026 11:14:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7393BFE52;
	Thu,  2 Apr 2026 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128470; cv=fail; b=A2Da13MQCtD2IUNKb0bYiHWwj04KQ+50vQv53dYQ5UhSL+orzV6QTD109ZblnWmOtTXm8oEd4oFD8JvAhfh7jDt+mlQCMKA2XlMv5ZeeRUeZdnwbkd+VbcXjclUl9XxQbPgGN46PX2qKwD3z1r0tJ0z6yUGvBJ1ooaV9hbb4vJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128470; c=relaxed/simple;
	bh=YFPd13uMZp7ZD2iiJENTavDR2saL2ydGEryS//Qc//w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gT6N74BstbNZaedFOKqE8+nDjLAn+4fO4psq3wi1QlUsNAUO+pkS3RhD/mYklcSCyrve03IUEOAroRoWbMkjOBkuB6zYRNDkOf2fmZZyjfCUzXT8db1jp6IV6+rTLZWGFhwo9BfGnrpJkWw3rqKyXO3vrvQLsSkq6OdPET/HiM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgjLru4S+no4jXI7AYJ8JMaG7vcFdJQR7jHaejaRf59EoHI2nwBf+NlSfmcLwfnd/AM8Us4ilKfIvFNo638hmuoUX0yEZXjDNxnfHa8V+LtdlVjGuIoFKMSRgVYMIuSl57pCR4jjQ6hLBxZTmHJiYYHM/+alebJVI76faRqfiCLxWxC31JdpHRe6bv0meTXhEKwztgTVhOxcKAvTOYm/0XT098JtnsjJEX66zGc+23xUVY7+0Jq9RdEobLt0KCGVFXrlf5Aqhr/4lBwQOByS+AX+K/a/XZcPaDkgM49AhsUUpDqpiAkf8bJJD5m9pxTENOVC+59YAD3P5BpTeSUIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMqtM0HpSWrdld0GnuXMt8Ev7iG+gr5xUE6zoN4LPMQ=;
 b=JdlA06+pJ08xt2uH4WgGuCYWJLc6knULJnSudZoDMvyZtbOf9l7tgOgY4kH+BQroZINr1UXjFu9PuKuw4i2uV23tb6G2UNnBZnRIWE1yMN4Gf1CInQazhdKEk+IVHGNg5SYzPboO81BTtwmEKuHVS1Jzb+Sk6H/9DPiEHkymzfiSZgOCbZI2+A1Is+Ah11Yakwl1OWKcWUfJclLJAawdsgtjLdyJ25Ta5+rjmHi6GYY68YvNpwNJGIFkDeD4kCXafir73Hpj93fRET88q/kP77vHtke5SjssvvQ9FdVHBgmp3ejS1GauK0xkgA9NdIxenILYbLNyDx56uvPX8tDTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:56:14 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:56:14 +0000
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
Subject: [PATCH v1 16/22] clk: starfive: Add StarFive JHB100 Peripheral-1 clock driver
Date: Thu,  2 Apr 2026 03:55:17 -0700
Message-Id: <20260402105523.447523-17-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 37b356d5-1362-42c5-1ccc-08de90a67586
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JD77bW/aZcCI4psb6Uu6wzWVcT8fkKaK2IOM0TV8v4DGV7XRZfL363aX/Z9qWfBZet+b1MkzWkE08MhvcklP03Qic2kv4AIrWwGbbbYD5csE0WJGLd5o+kbAtU/phUrJi0fWvl1jT/fC2HbDlxsCzuaDRc82ODrGfrIcsZht12P9HjSOUpH8oyumhtdoA+wJMSazPwV3P/Us8d9CYJSqUiZW55NWq+o1YqATucc/BffYvt0WXdFXWJMIQsWqtiWjPUBJCmPNmoJlybXYjQdw746hpoor7NTZDOOV4FLmaiKx/KIjtinm4tXcvukNqvprlxor7CNN5RH/N1wjGvWAsIm4micENmAnJ5EGPOr+xhHXm35vRKUzVziHmTYKXBkVBmda+sXirPMj/Fhil95kdCCN4iTE8XxG4XsB7wCZRopXuALmSA8ZVDPAtIeIAQ3+dBbQJmBgNxHavTJX/exseaaf1mGVe8VXhK3ENwe6tM/A2uK2wkbot6uB+iikWgxXHyt5uTSKJMzHfn7zYfqKZukMFpJ74FxxPm5ilOf0aQxwe90JAia5ZsGDoXHN7U06sMzzmkz1EXlEtGRH4IoCDLhwxiXrQGlsGnTegodHOdE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lEau1fJ2o+/a++j3sM6XMAl8nu/6fIYg12dmFeCHWORKNt8dZvNKmlO5xO9o?=
 =?us-ascii?Q?JdxxFtXyGSK9iUuRc0+/kWS2OiQMmciorwSgtkm0HP7juI+0/0A1tKY6tr88?=
 =?us-ascii?Q?oR8VTj9T4ROwthvzbl2D0lj+Xm269mksxu8PrftVWblr9vomXlVBrofhqpet?=
 =?us-ascii?Q?qXMO62hzRm7BJMvzYlIKZtxhUnX5ZmvqUQOvibi75uO5K4Nwai6SPvl4pYdf?=
 =?us-ascii?Q?aOQUprXOE79d2pbsUsxAFZbEEPulo5wHKBDKtePd3R3jg5AlAc3cmNLYRFB8?=
 =?us-ascii?Q?yvSwk7/wOPXzNgrnNZIdil3fxEvn/wbR5180OrScW5u7UX4iY6pz55WUTzdF?=
 =?us-ascii?Q?XOmmvbCzUZkdwGLX4jFs/gL4+jX5jBu0wX1pHTbPPldSXA+cRBKv2d1RK2X2?=
 =?us-ascii?Q?7g7ZlhEQwRmNyccvAkcfU1/OkWNf/3wgHwZ962p0vjwO+1gpGr4W1oeY10YL?=
 =?us-ascii?Q?t+ssw3ktg3fSXuAJOA6QL+VjTS+F9cV3a70fQhWecZy0Xi+dqBNye/NPenTW?=
 =?us-ascii?Q?R8s6eLDDx3fTsg3IT3FkbHIJtBoj/eiEb9fXJK3PCZbTfb/X/RcgBSba4PLE?=
 =?us-ascii?Q?v2rCCMj/i4LyioEgo1dm1DkgYHZstkT6e2AcckdXWwrt7ODgTewtu/9hfwUv?=
 =?us-ascii?Q?YmQL1BH03klZbgYpHar7WmDHSdv9/XJ+8bl6iMYX7hd3bu5kvY2hPgkOeZa2?=
 =?us-ascii?Q?nkfGc412rW2s01tiGVOeI/K+IFb36OoF3TDnVXRndgelQg3iAMuenb2n8GR8?=
 =?us-ascii?Q?KfTMie748hKEmjG0LmmNREUjw9kmwIyjm5IgGfayZ11N80BEIcfdzcmFUxV+?=
 =?us-ascii?Q?GTMT/AF8Y0Uzwbr89ifBmY/Qkpgps7JPBRfoYS7mS2u+fYHkxGXata0IuHNf?=
 =?us-ascii?Q?/GminZ3n2LO99UULt0t9aI5z6XJuWiMVIIo935+zPT4TeW5YBP/MxKPQ4rzF?=
 =?us-ascii?Q?o8gqPAY+t+No3gEjwHftQ5zdk+sFL8Eg83GyARLfIajkPDmwHnUNkOrIGHwp?=
 =?us-ascii?Q?PRSxlktVYX12TMItxZwC5T92pM2LeSEayBdoq3f9cAmslL+65ExCBJF7aLwi?=
 =?us-ascii?Q?+3cZ15cDJXhuaB1X5s/eBGBng1yPhVSg9wL8RP8otR1MJGBjEs2HhmxB4FCS?=
 =?us-ascii?Q?qPCEIeSvTR403K9LmQVb06Iy1LtGLkK6s+5NcIfy4w9ZppdO23rSOJKLTLjs?=
 =?us-ascii?Q?gJksVYnD4nokqgpPq9qeWE0GEbBP5pLejuaK8uDvyVByYSQx01Oze+GXs99a?=
 =?us-ascii?Q?ANH5MIDNQn8fopKqLLI0iIt26VI9h7AaVzIM+bJLpwoKadulXqFJAnwjT6H6?=
 =?us-ascii?Q?DVCp20cJl35+fCDToKgYEGmhmDZM+bsyCSLqOyedbc3KqJLgjKRyNRixStaQ?=
 =?us-ascii?Q?GsqvZo41F6zaxibHlk+/QABENRP49xQxy9Zi82Noq30W21u8xe9QUHIWu2Ru?=
 =?us-ascii?Q?aTChOMCF1BYc3KMrjFFYOnqlyYLGUwk8znsGWD7M32if2qKJOU2skJ1mLGD5?=
 =?us-ascii?Q?JII8tEKXPBRZqBE+XWiR65Ohi+NsqSM6d2GSJia1jmA2dECMgijheRtzc1YP?=
 =?us-ascii?Q?Hz/iJPVpL36CMDxtmZIEWu1Zej8jYkvmhiKpS1nPsJ2tjPd2TukvOESH7R15?=
 =?us-ascii?Q?/yCnT4B1ge+WvCjATurv7N/Ye5LO6LUCr1K0d/kZ1NQpZ6kXX8Fs8p5rw4zJ?=
 =?us-ascii?Q?DtKqhZVtIdriiz8DvXcPJ7Knq3BmoHW5ibyCoAuxXCLApKBr+LubRVMT+AqL?=
 =?us-ascii?Q?1bsOMwrDVY+0/94gSf1bYB/isI0mw3OOm1WX21WY7JO2TRWb761E?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b356d5-1362-42c5-1ccc-08de90a67586
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:56:14.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUSz9lo5bevsptYbXkpK6NL5qfXI/DMGjnXu02KY0jXiiThRckrlbRVbQOJmfBvPj4FX0EivNLBi7QfRKZwOG+EkTAI2Ixl79s+L2XTma7kpwu1EhUIJq+783t+LnEe7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1048
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274484-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.907];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA6D538846A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add driver for the StarFive JHB100 Peripheral-1 clock controller.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   8 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-per1.c   | 204 ++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per1.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index adf97444f460..72cf314c6cfc 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -81,6 +81,14 @@ config CLK_STARFIVE_JHB100_PER0
 	  Say yes here to support the peripheral-0 clock controller
 	  on the StarFive JHB100 SoC.
 
+config CLK_STARFIVE_JHB100_PER1
+	bool "StarFive JHB100 peripheral-1 clock support"
+	depends on CLK_STARFIVE_JHB100_SYS2
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the peripheral-1 clock controller
+	  on the StarFive JHB100 SoC.
+
 config CLK_STARFIVE_JHB100_SYS0
 	bool "StarFive JHB100 system-0 clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 2f605d0fd6da..51511086a727 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER0)		+= clk-starfive-jhb100-per0.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_PER1)		+= clk-starfive-jhb100-per1.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS2)		+= clk-starfive-jhb100-sys2.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-per1.c b/drivers/clk/starfive/clk-starfive-jhb100-per1.c
new file mode 100644
index 000000000000..c5c1cff5d9a8
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-per1.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 Peripheral-1 Clock Driver
+ *
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ *
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+
+#include <dt-bindings/clock/starfive,jhb100-crg.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include "clk-starfive-jhb100.h"
+
+#define JHB100_PER1CLK_NUM_CLKS			(JHB100_PER1CLK_MAIN_ICG_EN_UFS + 1)
+
+/* external clocks */
+#define JHB100_PER1CLK_143			(JHB100_PER1CLK_NUM_CLKS + 0)
+#define JHB100_PER1CLK_200			(JHB100_PER1CLK_NUM_CLKS + 1)
+#define JHB100_PER1CLK_600			(JHB100_PER1CLK_NUM_CLKS + 2)
+#define JHB100_PER1CLK_800			(JHB100_PER1CLK_NUM_CLKS + 3)
+#define JHB100_PER1CLK_PLL7			(JHB100_PER1CLK_NUM_CLKS + 4)
+
+static const struct starfive_clk_data jhb100_per1crg_clk_data[] = {
+	STARFIVE__DIV(JHB100_PER1CLK_100, "per1_100", 8, JHB100_PER1CLK_600),
+	STARFIVE__DIV(JHB100_PER1CLK_1, "per1_1", 100, JHB100_PER1CLK_100),
+	STARFIVE__DIV(JHB100_PER1CLK_200_DIVN0, "200_divn0", 256,
+		      JHB100_PER1CLK_800),
+	STARFIVE__DIV(JHB100_PER1CLK_200_DIVN1, "200_divn1", 256,
+		      JHB100_PER1CLK_800),
+	STARFIVE__DIV(JHB100_PER1CLK_200_DIVN2, "200_divn2", 256,
+		      JHB100_PER1CLK_800),
+	STARFIVE__DIV(JHB100_PER1CLK_200_DIVN3, "200_divn3", 256,
+		      JHB100_PER1CLK_800),
+	STARFIVE__DIV(JHB100_PER1CLK_200_CCLK_DIV, "200_cclk_div", 2046,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_SGPIO0_PCLK, "sgpio0_pclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_SGPIO0_DCLK, "sgpio0_dclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_SGPIO1_PCLK, "sgpio1_pclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_SGPIO1_DCLK, "sgpio1_dclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_EMMC0_BCLK, "emmc0_bclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_EMMC0_CCLK, "emmc0_cclk", 0,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC1_1CH_CORE, "dmac1_1ch_core", 0,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC1_1CH_ACLK, "dmac1_1ch_aclk", 0,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC2_1CH_CORE, "dmac2_1ch_core", 0,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC2_1CH_ACLK, "dmac2_1ch_aclk", 0,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC3_1CH_CORE, "dmac3_1ch_core", 0,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC3_1CH_ACLK, "dmac3_1ch_aclk", 0,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC0_2CH_CORE, "dmac0_2ch_core", 0,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC0_2CH_ACLK, "dmac0_2ch_aclk", 0,
+		      JHB100_PER1CLK_200),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_REF, "ufs_ref", 75,
+		      JHB100_PER1CLK_PLL7),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_300, "ufs_300", 2,
+		      JHB100_PER1CLK_600),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_150, "ufs_150", 12,
+		      JHB100_PER1CLK_600),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_400, "ufs_400", 2,
+		      JHB100_PER1CLK_800),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_75, "ufs_75", 2,
+		      JHB100_PER1CLK_UFS_150),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_37_5, "ufs_37_5", 2,
+		      JHB100_PER1CLK_UFS_75),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_7_5, "ufs_7_5", 10,
+		      JHB100_PER1CLK_UFS_75),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_1_875, "ufs_1_875", 4,
+		      JHB100_PER1CLK_UFS_7_5),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_7_143, "ufs_7_143", 20,
+		      JHB100_PER1CLK_143),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_3_5715, "ufs_3_5715", 2,
+		      JHB100_PER1CLK_UFS_7_143),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SFC0, "main_icg_en_sfc0", CLK_IS_CRITICAL,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SFC1, "main_icg_en_sfc1", CLK_IS_CRITICAL,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SFC2, "main_icg_en_sfc2", CLK_IS_CRITICAL,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SPI0, "main_icg_en_spi0", 0,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_EMMC0, "main_icg_en_emmc0", 0,
+		      JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SGPIO0, "main_icg_en_sgpio0", 0,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SGPIO1, "main_icg_en_sgpio1", 0,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SENSORS_PERIPH1, "main_icg_en_sensors_periph1", 0,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC0, "main_icg_en_dmac_sfc0",
+		      CLK_IS_CRITICAL, JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC1, "main_icg_en_dmac_sfc1",
+		      CLK_IS_CRITICAL, JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC2, "main_icg_en_dmac_sfc2",
+		      CLK_IS_CRITICAL, JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SPI0, "main_icg_en_dmac_spi0",
+		      CLK_IS_CRITICAL, JHB100_PER1CLK_200),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_RAS, "main_icg_en_ras", 0,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_UFS, "main_icg_en_ufs", 0,
+		      JHB100_PER1CLK_100),
+};
+
+static int jhb100_per1crg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JHB100_PER1CLK_NUM_CLKS),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->num_reg = JHB100_PER1CLK_NUM_CLKS;
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	for (idx = 0; idx < JHB100_PER1CLK_NUM_CLKS; idx++) {
+		u32 max = jhb100_per1crg_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jhb100_per1crg_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jhb100_per1crg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		if (!init.name)
+			continue;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jhb100_per1crg_clk_data[idx].parents[i];
+
+			if (pidx < JHB100_PER1CLK_NUM_CLKS)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == JHB100_PER1CLK_600)
+				parents[i].fw_name = "per1_600";
+			else if (pidx == JHB100_PER1CLK_200)
+				parents[i].fw_name = "per1_200";
+			else if (pidx == JHB100_PER1CLK_800)
+				parents[i].fw_name = "per1_800";
+			else if (pidx == JHB100_PER1CLK_143)
+				parents[i].fw_name = "per1_143";
+			else if (pidx == JHB100_PER1CLK_PLL7)
+				parents[i].fw_name = "pll7";
+		}
+
+		clk->hw.init = &init;
+		clk->idx = idx;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
+
+		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, starfive_clk_get, priv);
+	if (ret)
+		return ret;
+
+	return jhb100_reset_controller_register(priv, "r-per1", 0);
+}
+
+static const struct of_device_id jhb100_per1crg_match[] = {
+	{ .compatible = "starfive,jhb100-per1crg" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jhb100_per1crg_match);
+
+static struct platform_driver jhb100_per1crg_driver = {
+	.probe = jhb100_per1crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-per1",
+		.of_match_table = jhb100_per1crg_match,
+	},
+};
+module_platform_driver(jhb100_per1crg_driver);
+
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JHB100 Peripheral-1 Clock Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


