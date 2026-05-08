Return-Path: <netdev+bounces-285644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFVRCK1//WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:16:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 700024F2522
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23E3E3056FC5
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ABE36C588;
	Fri,  8 May 2026 05:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2101.outbound.protection.partner.outlook.cn [139.219.17.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933533D6C1;
	Fri,  8 May 2026 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218650; cv=fail; b=G5HXYoSMGAGfQrVLeWcORpXl/Gxv+5/x7wddGL2yKs9oE3YvZJpyXssEHMefWt8mvWt1JEIApVMCqScMqhr/QnQFQIdw0/4BTla4vL5M1RER6rzXJ2Z3D9iaa0C2kUhp2xT5z2eWvO3PnwpKr06AVrLiADicVeKOqOvR2jmQI0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218650; c=relaxed/simple;
	bh=Vuu341R8k1RMmLIMmITuHhhUua0KqRu+qP/YbMPMPYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sEgSmWm8Kh5XNEgJIEdT/JpNGUfqsYVl2xWpEUAmd9EuMbKE1/PW33bWhP2FGGndTM/NwpVaKvRrWHCFkA9p19x9k6Mhgt+8hHAo5ZHaO9N0GI+ZEFHaBCARToNPD6qYtS3VxRWKaEmE8/ngrUJXyYI7irZA1tlVqfkC4y4SF58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMTp1TQ22UCqYcEB7lH8WK46QaSa/3JRDH1zrCW60p0OijwGhwwY6rUCRiPd0yQSHCe2TJhWZ75izHwiXUgFL7TQkKtm0quxDQWwMwGjfWPp3o6/JXm1K3sGvWKB4AKac9jbGLbPJkm96vPXGAA0m3g0et3qlnGZzMU8fdUcVHy/XYWLCkYicwDX/VXf9h2Ebd/404xuqP5b7jKm6X2T4duF+k/Zy4M0RjNJdHh3e2qfWGdAQhGNfmz7tSoTmk69NCu/WQeeXz0AFc/9EpskvzFuycWsU/PaQ7qorc4Dgf1gXyH8fAjDmq7EsaRm+mta+NDWtTuMuAKUgf4SkYzKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdOxwLriT7phEfOhW8g9mqDyFYrsK8gumZtKCKFI4VI=;
 b=Z1u1CTAX65PTqKtRK89zxmjWtmQnSlUGXIYLQlnIU28NnG1HvbNAdSFkUwQxz1Z3ET/8trVn8bTN5qiHg4KL6eeSBJrNwZgX5rQ7l14EBs3ky/m11gyCYtfLUFe1GR4f+iAXlTf898TM6ludUXVQtG6BR8Gn/pCXCSQ8X4HQLOCyPk5s6as0VjjzZkg+tYMzwRVWvWooH3ghZ2DkuPRuGpjri/t95GvFMHQFUxSql6JSB2FKESmlcPFadWci30331r+uCxnPOwvjkQ30wjfHkOTQv35R33VlGcleg9ESOECYkdrUpHFMUKaRqA2MLFm5F/5iz33XWKD7+5AFa/VBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1236.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 05:36:51 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:36:51 +0000
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
Subject: [PATCH v2 06/22] clk: starfive: Add JHB100 System-0 clock generator driver
Date: Thu,  7 May 2026 22:36:16 -0700
Message-Id: <20260508053632.818548-7-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7b720abf-33a4-45ff-760b-08deacc3ce6e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020|22082099003|3023799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UL4jZblZfs8IASfpexfeZfDAykz6nhsqEQKvkr+yqYiyO52xb9AFTseux3HNNfvYG6o/w6Q1OnONv7IOfWXZGZeAW34wPY3IDksUnTw6bPwtJeV+2k0XwO8qCga3yg/BiERAgjB8ZCtKmuMvxF/ZMm+AB2TKY/ujKXILYovahUJ8C0Xj7J7rPhOUJbyAQhPsgrSh65rggIPGXMq5j/lmha5f0M/MZbtaNd6uPVFe/+dkq7DzUEnP5XINrid+vdlSJiJiExMQIfYCfYeqD3EY62F1cvYy0AU9fSHYva4bMcFyCGKo2ENyrJMcDHTYxGJA1XY4XjerZMEnjXOadiopiN2tCvhAMhzvIaJa7Nhr+2jT/BJWnG/lo+klfZygF4fhPwSoq26fMyZJJ94wTQ/PXh2hTf44ZghIBUl6IBA8R60nyaFHHyQyqtDHi58NJK93KkqOgU9ZOCU2ECUZgt6nDgZgKtFutjr+0Wrr1+Kc6DhWecXD2Go+inqphecqpCf9wW6uIZfIghdTs0Pde1hwuHhgTtIQhsYs69EyQjcxeiB0g9KcOuOz2QhS3bzrTiQoOnA1s7xozJqFwsKObVq1sA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020)(22082099003)(3023799003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tR6Y8l/4RQek7jB534Hr8Wp0ApNnT/SsU+BuJVuA185Dio93l+FYMJaJLB30?=
 =?us-ascii?Q?Bsjqptv/zGiZeW9l3humfDJX8L6VpcR90mtrq0GRuoC61JiqviJyIEYBkcq/?=
 =?us-ascii?Q?0XL4Cizi6edGJq2zHwUOFyKtOinTOPg5edUsGZYkzFUyQY3h4kCHErCRHPG0?=
 =?us-ascii?Q?rlWJ1G3C2/uktL0hHRQRTxZjFvCsTq6rtpdKDrxWHWigwanyoTzLlgvGYGII?=
 =?us-ascii?Q?u1XeQO5ohro8itzcteDbuW3SQMbFyBP0oGpcc1MpPiDSuY24lIhLjRSG4lsy?=
 =?us-ascii?Q?o5CsHVaZNysjgxMcqOwX5KLcj/8LArv/TdlKtEV4c8fmcQNJ7FLPZx8vso6o?=
 =?us-ascii?Q?r0jHrTW8/gtqzB/e/gOI/F4E8f5h1zMxV8WWHBd8qzjVWQJELjxrz/pfIU93?=
 =?us-ascii?Q?mHAZ1mqBEFS1z6toQz/5dkodByYeXQf6pWZapyRF3R+2cIkMuEI0JSkF4d6s?=
 =?us-ascii?Q?59QDnlmT1AbaLk/rpSVT7BYu96efahIRCMXW6+0PlIus2MRsXNAa9JNKp5D1?=
 =?us-ascii?Q?AOYQRmflvCwX6l0cTzZ2XWy4nWP6sOfOMcRQq68yc9K1hSIhiiCp9uZM88jv?=
 =?us-ascii?Q?plRtra5TnIiHpNQZcsvOEREHPXmeMBrfrdBAxNMcrvoSq07CohTA1lvhqFsx?=
 =?us-ascii?Q?8Ka+oO1pQ1M4yLKCFHsabHPuCoE6eboAHA7F6XcxVfIxTOiel8R8lUZWpLuZ?=
 =?us-ascii?Q?Fhr8VBNG8fg9hBBEXY36/AMYgWzw+GiadBcxNzfhUs1nEbdwDuJDASRO/4xs?=
 =?us-ascii?Q?qywrSr2Mkjn3bxNZz2ldDhQAhcN3iQrxaT7ZjOh7IMyBZFyep3K0cL8Y0bAt?=
 =?us-ascii?Q?+jf3LLkR7mSP/hYIRdu3oMGlKjfLSv9ZCdslb/DFN+Zc8E6MtcYI7PhuHijx?=
 =?us-ascii?Q?ZRlQhIxpFEZRHBOVHwsALaygu04brft26WVx7/a3q5z/Dtn/UDW0hUwUIHcV?=
 =?us-ascii?Q?xSvgGYG3WiTwO/Z2ZYoOQj9flGKuRO66UuTkDCdaf4bzYnixaPTkvd+yOPk5?=
 =?us-ascii?Q?e37VFkgRUGBdo3dtt9DzDqj0tQ3xz8p4ESXgtvYShsPix4sXStf9J0G3qqo/?=
 =?us-ascii?Q?jGtx364odguramtRMmC2j6/pnHdZx606keAomjYzfeaN3nDTD+hGIIP/kO0e?=
 =?us-ascii?Q?sLzf70/Q8WbmsP4ju1bolo1KEzgIQWLyBh1B4UbQJtvCDopDdG0iCAWxQxwb?=
 =?us-ascii?Q?w0j51/RPZoikhtXqsfTyj+/bdxWT/7Nvkp0hwKTCmfy5QnP/ut6JfWdCBst7?=
 =?us-ascii?Q?ho9BX42c9IeHBeIESKXJ8X7pzy1FfaZ04DlON5yQLUOMXPh0Mfyh0UzMBV5C?=
 =?us-ascii?Q?avVJDtNTVVHMuRUii0LzoL+rYKbiGA6/NAnL3JqHzES8TyL2MLomiTDabAWP?=
 =?us-ascii?Q?gyuzbECo4Ikiz9hfo+x1VF36dQZK+8l90zezUOLlPOOFLKGdUdnlDR4qoD99?=
 =?us-ascii?Q?RGa6wqtnIH03/74b6iv+t0f0IqIxS0mfh8jww5R1B21iq+Ph2zOp9rjkCURU?=
 =?us-ascii?Q?IYk4W4hkrKV0aZCcNVqlhnoT110NwMiAfSWBDma7uVuZRAFi/0Xj9UO8z/iw?=
 =?us-ascii?Q?ReIco8hVq4hXidlCO7pMdIx5mOzyGeiZ86IudNsQJKzlhZnyX0H6ukw2QTiw?=
 =?us-ascii?Q?8vmFNtyWotindeTnil1EXY7o/sgrT4pHMb2OFrOMI0KrzGmwDEVJ1G2LBVsi?=
 =?us-ascii?Q?4VAHKFHnG5wNuPeR/VGwtdTSnmbHZr80xXr4AbbV9IYHS7T4P52zwp00HIgN?=
 =?us-ascii?Q?DTCurl4oYT0n5XR3nvfZ0FpV6pBbmN7/hKiaqtswElQ50YSjzZHA?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b720abf-33a4-45ff-760b-08deacc3ce6e
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:36:51.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYtbAoZu4Zb9/oKFH+Vu9b8Au9XHovYGqFxDxJc7WQk7qDg6+v1VDw1uQ4j+qWTmXiuAWD28GJw+D4Reb4tIQ0X2xF2k5cI0zKtPuoTBAEORR3sVHv7325gFFjDaAfVZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1236
X-Rspamd-Queue-Id: 700024F2522
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
	TAGGED_FROM(0.00)[bounces-285644-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.810];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Action: add header
X-Spam: Yes

Add support for JHB100 System-0 clock generator (SYS0CRG).

The StarFive JHB100 SoC has multiple CRGs with similar probe flows, so
a generic starfive_crg_probe() function is introduced to facilitate the
registration process of other CRGs in the future.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 MAINTAINERS                                   |   7 +
 drivers/clk/starfive/Kconfig                  |  11 ++
 drivers/clk/starfive/Makefile                 |   2 +
 drivers/clk/starfive/clk-starfive-common.c    | 125 +++++++++++++++
 drivers/clk/starfive/clk-starfive-common.h    |  11 ++
 .../clk/starfive/clk-starfive-jhb100-sys0.c   | 149 ++++++++++++++++++
 6 files changed, 305 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys0.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 22e34d2ad696..a35459a82bb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25588,6 +25588,13 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
 F:	drivers/phy/starfive/phy-jh7110-pcie.c
 F:	drivers/phy/starfive/phy-jh7110-usb.c
 
+STARFIVE JHB100 CLOCK DRIVERS
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/starfive,jhb1*.yaml
+F:	drivers/clk/starfive/clk-starfive-jhb1*
+F:	include/dt-bindings/clock/starfive,jhb1*.h
+
 STARFIVE JHB100 DEVICETREES
 M:	Changhuang Liang <changhuang.liang@starfivetech.com>
 L:	linux-riscv@lists.infradead.org
diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index ff8eace36e64..7926e02ccd7d 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -72,3 +72,14 @@ config CLK_STARFIVE_JH7110_VOUT
 	help
 	  Say yes here to support the Video-Output clock controller
 	  on the StarFive JH7110 SoC.
+
+config CLK_STARFIVE_JHB100_SYS0
+	bool "StarFive JHB100 system-0 clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select AUXILIARY_BUS
+	select CLK_STARFIVE_COMMON
+	select RESET_STARFIVE_JHB100 if RESET_CONTROLLER
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the system-0 clock controller on the
+	  StarFive JHB100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 012f7ee83f8e..2c5e66d1d44e 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)	+= clk-starfive-jh7110-aon.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_STG)	+= clk-starfive-jh7110-stg.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
+
+obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
diff --git a/drivers/clk/starfive/clk-starfive-common.c b/drivers/clk/starfive/clk-starfive-common.c
index 9c0eb7a50d1e..ece0464741a5 100644
--- a/drivers/clk/starfive/clk-starfive-common.c
+++ b/drivers/clk/starfive/clk-starfive-common.c
@@ -9,6 +9,8 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <soc/starfive/reset-starfive-common.h>
 
 #include "clk-starfive-common.h"
 
@@ -337,3 +339,126 @@ struct clk_hw *starfive_clk_get(struct of_phandle_args *clkspec, void *data)
 	return ERR_PTR(-EINVAL);
 }
 EXPORT_SYMBOL_GPL(starfive_clk_get);
+
+static void starfive_reset_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void starfive_reset_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
+
+	kfree(rdev);
+}
+
+static int starfive_reset_controller_register(struct starfive_clk_priv *priv,
+					      const char *adev_name,
+					      u32 adev_id)
+{
+	struct starfive_reset_adev *rdev;
+	struct auxiliary_device *adev;
+	int ret;
+
+	rdev = kzalloc_obj(*rdev);
+	if (!rdev)
+		return -ENOMEM;
+
+	rdev->base = priv->base;
+
+	adev = &rdev->adev;
+	adev->name = adev_name;
+	adev->dev.parent = priv->dev;
+	adev->dev.release = starfive_reset_adev_release;
+	adev->id = adev_id;
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(priv->dev,
+					starfive_reset_unregister_adev, adev);
+}
+
+int starfive_crg_probe(struct platform_device *pdev)
+{
+	const struct jhb100_crg_domain_info *info;
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	info = of_device_get_match_data(&pdev->dev);
+	if (!info)
+		return -ENODEV;
+
+	priv = devm_kzalloc(&pdev->dev, struct_size(priv, reg, info->num_clk),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->num_reg = info->num_clk;
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	if (info->power_domain)
+		devm_pm_runtime_enable(priv->dev);
+
+	for (idx = 0; idx < info->num_clk; idx++) {
+		u32 max = info->clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = info->clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = info->clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		if (!init.name)
+			continue;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = info->clk_data[idx].parents[i];
+
+			if (pidx < info->num_clk) {
+				parents[i].hw = &priv->reg[pidx].hw;
+			} else {
+				if (pidx - info->num_clk >= info->num_ext_clk)
+					return -EINVAL;
+
+				parents[i].fw_name = info->ext_clk[pidx - info->num_clk];
+			}
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
+	return starfive_reset_controller_register(priv, info->rst_name, 0);
+}
+EXPORT_SYMBOL_GPL(starfive_crg_probe);
diff --git a/drivers/clk/starfive/clk-starfive-common.h b/drivers/clk/starfive/clk-starfive-common.h
index a03824e9e75f..70eb7b7492e6 100644
--- a/drivers/clk/starfive/clk-starfive-common.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -5,6 +5,7 @@
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/spinlock.h>
 
 /* register fields */
@@ -121,7 +122,17 @@ struct starfive_clk_priv {
 	struct starfive_clk reg[] __counted_by(num_reg);
 };
 
+struct jhb100_crg_domain_info {
+	const struct starfive_clk_data *clk_data;
+	unsigned int num_clk;
+	char **ext_clk;
+	unsigned int num_ext_clk;
+	char *rst_name;
+	bool power_domain;
+};
+
 const struct clk_ops *starfive_clk_ops(u32 max);
 struct clk_hw *starfive_clk_get(struct of_phandle_args *clkspec, void *data);
+int starfive_crg_probe(struct platform_device *pdev);
 
 #endif
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-sys0.c b/drivers/clk/starfive/clk-starfive-jhb100-sys0.c
new file mode 100644
index 000000000000..ed92179145fb
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-sys0.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 System-0 Clock Driver
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
+#define JHB100_SYS0CLK_NUM_CLKS			(JHB100_SYS0CLK_GPU1_NCNOC_INIT + 1)
+
+/* external clocks */
+#define JHB100_SYS0CLK_OSC			(JHB100_SYS0CLK_NUM_CLKS + 0)
+#define JHB100_SYS0CLK_PLL0			(JHB100_SYS0CLK_NUM_CLKS + 1)
+#define JHB100_SYS0CLK_PLL1			(JHB100_SYS0CLK_NUM_CLKS + 2)
+#define JHB100_SYS0CLK_PLL2			(JHB100_SYS0CLK_NUM_CLKS + 3)
+
+char *jhb100_sys0_ext_clk[] = {
+	"osc",
+	"pll0",
+	"pll1",
+	"pll2",
+};
+
+static const struct starfive_clk_data jhb100_sys0crg_clk_data[] __initconst = {
+	/* bmcpcierp */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPCIERP_NCNOC_MAIN, "bmcpcierp_ncnoc_main", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG, "bmcpcierp_ncnoc_cfg", 12,
+		      JHB100_SYS0CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS0CLK_PCIE_REF_CML, "pcie_ref_cml", 24,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCPCIERP_NCNOC_DATA_INIT, "bmcpcierp_ncnoc_data_init",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCPCIERP_NCNOC_MAIN),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG_INIT, "bmcpcierp_ncnoc_cfg_init",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCPCIERP_NCNOC_TARG, "bmcpcierp_ncnoc_targ",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCPCIERP_NCNOC_MAIN),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCPCIERP_PCU, "bmcpcierp_pcu",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_OSC),
+	/* hostss0 */
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS0_NCNOC_CFG, "hostss0_ncnoc_cfg", 12,
+		      JHB100_SYS0CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS0_NCNOC_DATA, "hostss0_ncnoc_data", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS0_PHY_SCAN_400, "hostss0_phy_scan_400", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_GPIO_ESPI0_EXT, "gpio_espi0_ext", 14,
+		      JHB100_SYS0CLK_PLL2),
+	/* bmcusb */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCUSB_NCNOC_INIT, "bmcusb_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCUSB_NCNOC_TARG, "bmcusb_ncnoc_targ", 6,
+		      JHB100_SYS0CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCUSB_SCANCLK, "bmcusb_scanclk", 5,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCUSB_480M_SCANCLK, "bmcusb_480m_scanclk",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCUSB_SCANCLK),
+	/* vce */
+	STARFIVE__DIV(JHB100_SYS0CLK_VCE_NCNOC_INIT, "vce_ncnoc_init", 10,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_VCE_NCNOC_TARG, "vce_ncnoc_targ", 12,
+		      JHB100_SYS0CLK_PLL1),
+	/* bmcperiph2 */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER2_NCNOC_INIT, "bmcper2_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER2_NCNOC_TARG, "bmcper2_ncnoc_targ", 12,
+		      JHB100_SYS0CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER2_CFG_400, "bmcper2_cfg_400", 8,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER2_CFG_125, "bmcper2_cfg_125", 10,
+		      JHB100_SYS0CLK_PLL1),
+	/* hostss1 */
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS1_NCNOC_DATA, "hostss1_ncnoc_data", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400, "hostss1_phy_scan_400", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE_GATE(JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400_ICG_BUF,
+		      "hostss1_phy_scan_400_icg_buf", CLK_IS_CRITICAL,
+		      JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400),
+	/* npu */
+	STARFIVE__DIV(JHB100_SYS0CLK_NPU_NCNOC_INIT, "npu_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	/* vout */
+	STARFIVE__DIV(JHB100_SYS0CLK_VOUT_NCNOC_INIT, "vout_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_VOUT_AUX, "vout_aux", 150,
+		      JHB100_SYS0CLK_PLL0),
+	/* bmcperiph3 */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER3_NCNOC_INIT, "bmcper3_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	/* hostusb */
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTUSB_NCNOC_INIT, "hostusb_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	/* hostusbcmn */
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTUSBCMN_CFG_480, "hostusbcmn_cfg_480", 5,
+		      JHB100_SYS0CLK_PLL0),
+	/* bmcperiph1 */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER1_NCNOC_INIT, "bmcper1_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER1_CFG_800, "bmcper1_cfg_800", 4,
+		      JHB100_SYS0CLK_PLL0),
+	/* bmcperiph0 */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER0_NCNOC_INIT, "bmcper0_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER0_CFG_400, "bmcper0_cfg_400", 8,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER0_CFG_800, "bmcper0_cfg_800", 8,
+		      JHB100_SYS0CLK_PLL0),
+	/* gpu0 */
+	STARFIVE__DIV(JHB100_SYS0CLK_GPU0_NCNOC_INIT, "gpu0_ncnoc_init", 10,
+		      JHB100_SYS0CLK_PLL0),
+	/* gpu1 */
+	STARFIVE__DIV(JHB100_SYS0CLK_GPU1_NCNOC_INIT, "gpu1_ncnoc_init", 10,
+		      JHB100_SYS0CLK_PLL0),
+};
+
+const struct jhb100_crg_domain_info jhb100_sys0crg_info = {
+	.clk_data	= jhb100_sys0crg_clk_data,
+	.num_clk	= ARRAY_SIZE(jhb100_sys0crg_clk_data),
+	.ext_clk	= jhb100_sys0_ext_clk,
+	.num_ext_clk	= ARRAY_SIZE(jhb100_sys0_ext_clk),
+	.rst_name	= "jhb100-r-sys0",
+	.power_domain	= false,
+};
+
+static const struct of_device_id jhb100_sys0crg_match[] = {
+	{
+		.compatible = "starfive,jhb100-sys0crg",
+		.data = &jhb100_sys0crg_info,
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jhb100_sys0crg_driver = {
+	.driver = {
+		.name = "clk-starfive-jhb100-sys0",
+		.of_match_table = jhb100_sys0crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jhb100_sys0crg_driver, starfive_crg_probe);
-- 
2.25.1


