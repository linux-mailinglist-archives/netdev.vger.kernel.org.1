Return-Path: <netdev+bounces-285652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGbXMW55/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:49:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 318594F2150
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09AEC30B55CC
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A57537A487;
	Fri,  8 May 2026 05:38:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2106.outbound.protection.partner.outlook.cn [139.219.146.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9CE35DA41;
	Fri,  8 May 2026 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218720; cv=fail; b=Nc3J2iq4uQqbn4yIEDjATauP0LI+nOplTGG7cWd/ACL008wPoBNh1WgSyVX/2lyXie0Kp8fOHocNT+QiipJLfExssW0Fjc5PuKrlTXG+zfbItXDyqLewI4BBWSb52fWQCWFj6IOFBqbQlS+SaACrTfdvpF0Ea/tEDBgaA4Ro9jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218720; c=relaxed/simple;
	bh=GSKk7TXlhDhqpcVd5Kl2XjV3unr+pdSAeipjKRQSRZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzgT8Pv+I6XHGZ9iS3w+5VpRL+euX3e8RtD5s6WDeUXgzmYaCu0c0LJp/Nv29DHAEVrY8Zl3YjGwoPM6vDAOvz7q1jjHMBa5FYZKm3vFuZwT5zvhsiJHt/5ZVLllQqnyQhNhHvlixDkqwPusn6B7LfNQTSby1zAtDYctIB57ZAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZdRjd42wEac6sUlxr8KFUkhyykwbwtNWKgjgOKxg3nSEFk4m06nPDZlE/cT53Ery4UI51aFSxoACyG5aviaHbLEvyQWyI4tfbhhbTnECbBJQu2o2MDvpC6QRL9alsUwUTcxVYP7DNQJIHs4XJtFa7Nfpb8IP5VFO/MauiJHO8kN3gNA0AApCw256NpUmEvgIi+HveozskHEWAL4aLI56Jykd4LN3XwDzNB/4BxtXHN+zrytoqeD4452zKsIUm3fUMdlUxkC9HpfQPT2YRP4mmK38CEHgWqd5LXFKfjUAB2hP5tJD2xvUaVCX08hSmPt/QaLHtL6YLitUmaoCwVH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcS6ak4afYHDpYl+qx5RhpRT11HpHGI3H+DR7u/Xolw=;
 b=g1y+2qJ6yv13G0vx60mNsLNdsAFH4CHa8eM/dpram33NsjYEEOzNzelkG4y+tCbTkeTCUC2786dLf8m6mUUNpjYdMApuJfoE5TWE+6sdjA1AzsbbAkVt2V06f/CZPso6vGar4rO1qDGk2qcO80ui9Zqc9hjig0zWgWHUIrfiSGF+l+NXhOayvQ6qrW+Wiher1u/O14azhp+ulWsGJ6fODXfvogHPVpz4qvaw6lEieVBy0VZDESEaK4PuxGSz4QWlFmjfiJR7KhZZAUjaEve67yte3rlZsDjXyFpRPteHlT7o80c7HpjGw/+Tnli9gT27VcLeofrYul0UxQBYB3LooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1252.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 05:37:18 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:37:18 +0000
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
Subject: [PATCH v2 21/22] reset: starfive: Add StarFive JHB100 reset driver
Date: Thu,  7 May 2026 22:36:31 -0700
Message-Id: <20260508053632.818548-22-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: a05e97e7-cce9-4c03-9a38-08deacc3de54
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fZiWpx2dl5vlzcaFsJ+6rZLuxcS6/EPS06bKSewqfqoDvhH4FID80eP+Qba4S8m+ZmlrlykL2rEfSmshMksFqUt9pOfVCsG1MEBxT57ggmfnajcmRrplQOGqy95PFBO9I+iYbESc+5jikJRmlz3mSSxta/KGZTKbmRWsWs6roy8BQ7D5NJq3NKpZ7d5v+HTuykbNjTv68bTqWkYzrJJ48ndzzhwM85IpPoRJ1xujz1j6pWFXmi/nUso0zYC1Bs2Cp/DqgczmqXxtag9owWdlMKHVl9wrZ3ERGnsg5Qqz5jduMDFUrIdFW/u1ZnZYQrPmYckrlD40N+Y60zkd4OVjJOems2UiCwOyucBTVtmQnQSIlNos5+osurr4/ViUtViiW/TdZAWdjMANpQJFWx7781lQnVDb4cEBcrrbC4l7P7/jFw0rvHQFeY8Tq+a4b3gIiGNSM4kfD7P7IWCAzyg/tm8sWUtX3856/pWHZiZJhTS3ScjSoAHQRvTEzwut7EAYyHTU/OEydvF+0Qa29pXJbDo+s3aXf/WrseiaXTJEm6IyaGLeTrd7zhCXoQXzmcc5l2qRiky9qMO40Iy5DLD1EQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WuX7doRflHvD+wXqgI018ns3na1m6wvBinwM5OfsDtjkWIzH4wCfnN/Bqmqc?=
 =?us-ascii?Q?KoSHT1DjdOdE34CNsQssrPnX02lJiGgLa9o+BT5dTdTroKI59S/47dKEb6Nn?=
 =?us-ascii?Q?JNgEvYH5LCXbpnz6MvMv6XeYpCy/HrJJHSwrpQMn0O0/sH0JtuRfXJ031glM?=
 =?us-ascii?Q?GWOiMLbqUxti8hVJS2GTqbL+S1FXi29uJ0h/wrh+vWH3Ow9adC1epEZH+Gnb?=
 =?us-ascii?Q?ArfKcP+AT9rskWIGU0hp5FobWutlZc3Kwf6HBNGH5uQaZm1Oza8p6fgFrhvC?=
 =?us-ascii?Q?URegh21fIgLK13kpt/ayRpaR/1cD7JN+0KviO0jt4xZxF7jt1rRIAcwRTxzf?=
 =?us-ascii?Q?TDO9YA8SZqpI7f3RwhFf96v7BXyRbtrAK69j1qMFBTTgR1MkhQfsb7/T6psS?=
 =?us-ascii?Q?DIdjfzUPkIrvRu7LAUvgj8kugDabOM2nxRH90NJTWk1eZlceDjicKBCRWo8o?=
 =?us-ascii?Q?a3k0it0l/rddVhAQdeM8DcLuuEN56XZxBZ0v8dKglaw/I+mD6DuExaFi9gW2?=
 =?us-ascii?Q?1Pr1owFkUCrE1L+yrj+vWZKDhul7nJasVOaUD03IaKj5CGHMl4g2VaNVFyuQ?=
 =?us-ascii?Q?VUH1E8gVnTpD+UKOYviL0AhS9dqmxDTMy+shO2S4n+e0FKrdIXgz2sF82GSm?=
 =?us-ascii?Q?3zNJNLIluNuBeTS8c4pch+qaXzwlcQskjpgDZ4M1rTNrrR3N71Q8fQ6VbExr?=
 =?us-ascii?Q?S+MFnqndFNwsNgZ+Ydr2s6n8M3YdugA6KKac30nobaCLrJHEpHBcLBD0mAL3?=
 =?us-ascii?Q?U+y3LhOCfWKJafhvxBUIeXQ3VWxNDg8tHHcpJbXl9TQrTJiZEwROBrchRugt?=
 =?us-ascii?Q?PyMa91NChNF+V745zNae3SsYRQXPpK2ehAmjDmjxIV6lpKtrudcOD4DqDgSg?=
 =?us-ascii?Q?mBBjzgAn/VjYiK05p1lfo1N5S0wnx+3ZL7cGEj89Hy0qWgcXJ7gYnoqAdbn+?=
 =?us-ascii?Q?49JHkK3UqqLmg0A7YpsDLRz8MUlGjx49+r3tlASB1QANEzUg1GU5gVkjKSiS?=
 =?us-ascii?Q?pGARqJiMDFK0eFbBbh1HKwtzCReFn39ZLWCG9JFXVwKR5dlUsnAzjLn9BFf9?=
 =?us-ascii?Q?aP7PwNyc7RuFG01+6ZFtOdjs0blb9cl/hsdRKEZ7YXXUoDDHk3v8O8/ma7KT?=
 =?us-ascii?Q?4tu2KFV7tLYjsvjV9YFPVU9HJekZAKvPs+JKRUVsICcULCma1bqxdD23YYrm?=
 =?us-ascii?Q?qgSk+ofhb83iGo0qmR2bBld78A2jGQ+GMd0BhCIP8Z1/YNWFNuNXw2jiDBLt?=
 =?us-ascii?Q?lrdni2tnDQdO2TaQJ3lG4HryBb6lltscgk3wrPX6jgE/7FBNBwNXJqVzbZb5?=
 =?us-ascii?Q?qot6VVzDew4yKrmpyksnEtst03jbCYC8bQE22I1GrvIs++CqE05XCbAaf/4Q?=
 =?us-ascii?Q?qg9YaZ6EMHPtLtOgRusRjo41wnmj6qCIBOJ1kPLsvAbz7KAsBQmkXQfTXdq4?=
 =?us-ascii?Q?ZjaCVRMVQjHiw5ARqzFH6M2PoVwA/jc3VlKJivxBEQ9+WebJ+/Cjf3BPWGFB?=
 =?us-ascii?Q?tCYKUeuTowOlAOzzwylD+0er38xe6HaKUGNwOR853xmbaNYsBgeY6bnJjadc?=
 =?us-ascii?Q?6rTMjdNsJFoHrmbamwo75xMLVodAzw+kBkkxrQUJAMsZhkGSt99dulQmJA0f?=
 =?us-ascii?Q?UOxPrB8Kr33iYdEV+DhThElP7Sq5NLx1OpG3q1KBFhzHYglLqFsmBgV1R39l?=
 =?us-ascii?Q?aqPWIrv1RVgTCU3sU3qZkyu6xuBOKRUl8exKlUXiiMCm1RZsLh5GQy5i5Fws?=
 =?us-ascii?Q?0WXe2OEuyPMhBV31Rz5j7aMztK9e2ReYxDiSTGbzmwudOOS618i4?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05e97e7-cce9-4c03-9a38-08deacc3de54
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:37:18.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsSuVvb/QTBRY/1DiMU3n5L6rgvALfzmZqlvZx/ItfunBBbLuEVYoimZ4cFRQfZcOPDxI4UjocEfJEIssa3fGYxjhxBj16YqPr3lment8DMf2ZgnWrTHIsO88xLtfj3U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1252
X-Rspamd-Queue-Id: 318594F2150
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
	TAGGED_FROM(0.00)[bounces-285652-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.850];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Action: no action

Add auxiliary reset driver to support StarFive JHB100 SoC.
The StarFive JHB100 SoC has discontiguous reset IDs. A new function
reset_starfive_register_with_info() is introduced to support both
contiguous and discontiguous hardware designs.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 MAINTAINERS                                   |   6 +
 drivers/reset/starfive/Kconfig                |   9 +
 drivers/reset/starfive/Makefile               |   1 +
 .../reset/starfive/reset-starfive-common.c    |  93 +++++-
 .../reset/starfive/reset-starfive-common.h    |  19 ++
 .../reset/starfive/reset-starfive-jhb100.c    | 300 ++++++++++++++++++
 6 files changed, 417 insertions(+), 11 deletions(-)
 create mode 100644 drivers/reset/starfive/reset-starfive-jhb100.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a35459a82bb6..47e4b368347f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25607,6 +25607,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/interrupt-controller/starfive,jhb100-intc.yaml
 F:	drivers/irqchip/irq-starfive-jhb100-intc.c
 
+STARFIVE JHB100 RESET CONTROLLER DRIVERS
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+S:	Maintained
+F:	drivers/reset/starfive/reset-starfive-jhb1*
+F:	include/dt-bindings/reset/starfive,jhb1*.h
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
index 29fbcf1a7d83..ce00495be6ad 100644
--- a/drivers/reset/starfive/Kconfig
+++ b/drivers/reset/starfive/Kconfig
@@ -19,3 +19,12 @@ config RESET_STARFIVE_JH7110
 	default ARCH_STARFIVE
 	help
 	  This enables the reset controller driver for the StarFive JH7110 SoC.
+
+config RESET_STARFIVE_JHB100
+	bool "StarFive JHB100 Reset Driver"
+	depends on CLK_STARFIVE_COMMON || COMPILE_TEST
+	select AUXILIARY_BUS
+	select RESET_STARFIVE_COMMON
+	default ARCH_STARFIVE
+	help
+	  This enables the reset controller driver for the StarFive JHB100 SoC.
diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
index 582e4c160bd4..217002302a9f 100644
--- a/drivers/reset/starfive/Makefile
+++ b/drivers/reset/starfive/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_RESET_STARFIVE_COMMON)		+= reset-starfive-common.o
 
 obj-$(CONFIG_RESET_STARFIVE_JH7100)		+= reset-starfive-jh7100.o
 obj-$(CONFIG_RESET_STARFIVE_JH7110)		+= reset-starfive-jh7110.o
+obj-$(CONFIG_RESET_STARFIVE_JHB100)		+= reset-starfive-jhb100.o
diff --git a/drivers/reset/starfive/reset-starfive-common.c b/drivers/reset/starfive/reset-starfive-common.c
index 772bdf6763d1..8ea142ecbd15 100644
--- a/drivers/reset/starfive/reset-starfive-common.c
+++ b/drivers/reset/starfive/reset-starfive-common.c
@@ -21,6 +21,11 @@ struct starfive_reset {
 	void __iomem *assert;
 	void __iomem *status;
 	const u32 *asserted;
+
+	/* Only exists in reset controllers that use the
+	 * reset_starfive_register_with_info helper.
+	 */
+	struct starfive_reset_info *info;
 };
 
 static inline struct starfive_reset *
@@ -29,19 +34,40 @@ starfive_reset_from(struct reset_controller_dev *rcdev)
 	return container_of(rcdev, struct starfive_reset, rcdev);
 }
 
+static unsigned long
+starfive_reset_id_to_hw_id(struct starfive_reset_map *map, unsigned int nr_resets,
+			   unsigned long reset_id)
+{
+	if (!map)
+		return reset_id;
+
+	for (u32 i = 0; i < nr_resets; i++) {
+		if (map[i].reset_id == reset_id)
+			return map[i].hw_id;
+	}
+
+	return reset_id;
+}
+
 static int starfive_reset_update(struct reset_controller_dev *rcdev,
 				 unsigned long id, bool assert)
 {
 	struct starfive_reset *data = starfive_reset_from(rcdev);
-	unsigned long offset = id / 32;
-	u32 mask = BIT(id % 32);
-	void __iomem *reg_assert = data->assert + offset * sizeof(u32);
-	void __iomem *reg_status = data->status + offset * sizeof(u32);
-	u32 done = data->asserted ? data->asserted[offset] & mask : 0;
-	u32 value;
-	unsigned long flags;
+	unsigned long offset, flags;
+	void __iomem *reg_assert;
+	void __iomem *reg_status;
+	u32 mask, done, value;
 	int ret;
 
+	if (data->info && data->info->discontigous)
+		id = starfive_reset_id_to_hw_id(data->info->map, data->info->nr_resets, id);
+
+	offset = id / 32;
+	mask = BIT(id % 32);
+	reg_assert = data->assert + offset * sizeof(u32);
+	reg_status = data->status + offset * sizeof(u32);
+	done = data->asserted ? data->asserted[offset] & mask : 0;
+
 	if (!assert)
 		done ^= mask;
 
@@ -89,10 +115,17 @@ static int starfive_reset_status(struct reset_controller_dev *rcdev,
 				 unsigned long id)
 {
 	struct starfive_reset *data = starfive_reset_from(rcdev);
-	unsigned long offset = id / 32;
-	u32 mask = BIT(id % 32);
-	void __iomem *reg_status = data->status + offset * sizeof(u32);
-	u32 value = readl(reg_status);
+	void __iomem *reg_status;
+	unsigned long offset;
+	u32 mask, value;
+
+	if (data->info && data->info->discontigous)
+		id = starfive_reset_id_to_hw_id(data->info->map, data->info->nr_resets, id);
+
+	offset = id / 32;
+	mask = BIT(id % 32);
+	reg_status = data->status + offset * sizeof(u32);
+	value = readl(reg_status);
 
 	if (!data->asserted)
 		return !(value & mask);
@@ -132,3 +165,41 @@ int reset_starfive_register(struct device *dev, struct device_node *of_node,
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
 EXPORT_SYMBOL_GPL(reset_starfive_register);
+
+int reset_starfive_register_with_info(struct device *dev, struct device_node *of_node,
+				      void __iomem *assert, void __iomem *status,
+				      const u32 *asserted,
+				      struct starfive_reset_info *info,
+				      struct module *owner)
+{
+	struct starfive_reset *data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->rcdev.ops = &starfive_reset_ops;
+	data->rcdev.owner = owner;
+	data->rcdev.nr_resets = info->nr_resets;
+	data->rcdev.dev = dev;
+	data->rcdev.of_node = of_node;
+
+	spin_lock_init(&data->lock);
+	data->assert = assert;
+	data->status = status;
+	data->asserted = asserted;
+	data->info = info;
+
+	if (data->info && data->info->discontigous)
+		WARN_ON(!data->info->map);
+
+	ret = devm_reset_controller_register(dev, &data->rcdev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register reset controller");
+
+	dev_info(dev, "Registered %u resets", data->rcdev.nr_resets);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(reset_starfive_register_with_info);
diff --git a/drivers/reset/starfive/reset-starfive-common.h b/drivers/reset/starfive/reset-starfive-common.h
index 83461b22ee55..ee457d9b90a3 100644
--- a/drivers/reset/starfive/reset-starfive-common.h
+++ b/drivers/reset/starfive/reset-starfive-common.h
@@ -6,9 +6,28 @@
 #ifndef __RESET_STARFIVE_COMMON_H
 #define __RESET_STARFIVE_COMMON_H
 
+struct starfive_reset_map {
+	unsigned long reset_id;
+	unsigned long hw_id;
+};
+
+struct starfive_reset_info {
+	unsigned int nr_resets;
+	unsigned int assert_offset;
+	unsigned int status_offset;
+	bool discontigous;
+	struct starfive_reset_map *map;
+};
+
 int reset_starfive_register(struct device *dev, struct device_node *of_node,
 			    void __iomem *assert, void __iomem *status,
 			    const u32 *asserted, unsigned int nr_resets,
 			    struct module *owner);
 
+int reset_starfive_register_with_info(struct device *dev, struct device_node *of_node,
+				      void __iomem *assert, void __iomem *status,
+				      const u32 *asserted,
+				      struct starfive_reset_info *info,
+				      struct module *owner);
+
 #endif /* __RESET_STARFIVE_COMMON_H */
diff --git a/drivers/reset/starfive/reset-starfive-jhb100.c b/drivers/reset/starfive/reset-starfive-jhb100.c
new file mode 100644
index 000000000000..871bee75192e
--- /dev/null
+++ b/drivers/reset/starfive/reset-starfive-jhb100.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Reset driver for the StarFive JHB110 SoC
+ *
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ */
+
+#include <dt-bindings/reset/starfive,jhb100-crg.h>
+#include <linux/auxiliary_bus.h>
+#include <soc/starfive/reset-starfive-common.h>
+
+#include "reset-starfive-common.h"
+
+#define NUM_RESETS(x)		((x) + 1)
+
+struct starfive_reset_map jhb100_sys0_map[] = {
+	{ JHB100_SYS0RST_RESOURCE_ARB, 0 },
+	{ JHB100_SYS0RST_SYS0_IOMUX_PRESETN, 3 },
+	{ JHB100_SYS0RST_SYS0H_IOMUX_PRESETN, 4 },
+	{ JHB100_SYS0RST_RST_ADAPTOR_TIMEOUT_RSTN, 5 },
+	{ JHB100_SYS0RST_BMCPCIERP_RSTN_BUS, 14 },
+	{ JHB100_SYS0RST_BMCPCIERP_RSTN_CRG, 15 },
+	{ JHB100_SYS0RST_HOSTSS0_RSTN_BUS_ESPI, 16 },
+	{ JHB100_SYS0RST_HOSTSS0_RSTN_BUS_PCIE, 17 },
+	{ JHB100_SYS0RST_HOSTSS0_RSTN_CRG, 18 },
+	{ JHB100_SYS0RST_BMCPERIPH2_RSTN_CRG, 19 },
+	{ JHB100_SYS0RST_BMCPERIPH2_RSTN_BUS, 20 },
+	{ JHB100_SYS0RST_VCE_RSTN_CRG, 21 },
+	{ JHB100_SYS0RST_VCE_RSTN_BUS, 22 },
+	{ JHB100_SYS0RST_BMCUSB_RSTN_BUS, 23 },
+	{ JHB100_SYS0RST_BMCUSB_RSTN_CRG, 24 },
+};
+
+static const struct starfive_reset_info jhb100_sys0_info = {
+	.nr_resets = NUM_RESETS(JHB100_SYS0RST_BMCUSB_RSTN_CRG),
+	.assert_offset = 0x12c,
+	.status_offset = 0x130,
+	.discontigous = true,
+	.map = jhb100_sys0_map,
+};
+
+struct starfive_reset_map jhb100_sys1_map[] = {
+	{ JHB100_SYS1RST_SYS1_IOMUX_PRESETN, 1 },
+	{ JHB100_SYS1RST_MAIN_RSTN_CHIPTOP_SENSOR, 5 },
+	{ JHB100_SYS1RST_VOUT_RSTN_HOST0, 8 },
+	{ JHB100_SYS1RST_VOUT_RSTN_HOST1, 9 },
+	{ JHB100_SYS1RST_HOSTSS1_RSTN_BUS_ESPI, 10 },
+	{ JHB100_SYS1RST_HOSTSS1_RSTN_BUS_PCIE, 11 },
+	{ JHB100_SYS1RST_HOSTSS1_RSTN_CRG, 12 },
+	{ JHB100_SYS1RST_BMCPERIPH3_RSTN_CRG, 13 },
+	{ JHB100_SYS1RST_BMCPERIPH3_RSTN_BUS, 14 },
+};
+
+static const struct starfive_reset_info jhb100_sys1_info = {
+	.nr_resets = NUM_RESETS(JHB100_SYS1RST_BMCPERIPH3_RSTN_BUS),
+	.assert_offset = 0x54,
+	.status_offset = 0x58,
+	.discontigous = true,
+	.map = jhb100_sys1_map,
+};
+
+struct starfive_reset_map jhb100_sys2_map[] = {
+	{ JHB100_SYS2RST_JTAG0_MST_WRAP_HRESETN, 2 },
+	{ JHB100_SYS2RST_JTAG0_MST_WRAP_APB_PRESETN, 3 },
+	{ JHB100_SYS2RST_JTAG1_MST_WRAP_HRESETN, 4 },
+	{ JHB100_SYS2RST_JTAG1_MST_WRAP_APB_PRESETN, 5 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTCMN_RSTN_BUS_NCNOC_INIT, 8 },
+	{ JHB100_SYS2RST_HUSBCMN_RSTN_HOSTCMN_CRG, 9 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTUSB0_RSTN_BUS_NCNOC_BMC_TARG, 10 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTUSB0_RSTN_BUS_NCNOC_HOST_TARG, 11 },
+	{ JHB100_SYS2RST_HUSBCMN_RSTN_BMC_CRG, 12 },
+	{ JHB100_SYS2RST_HUSBCMN_RSTN_HOSTUSB0_CRG, 13 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTUSB1_RSTN_BUS_NCNOC_BMC_TARG, 14 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTUSB1_RSTN_BUS_NCNOC_HOST_TARG, 15 },
+	{ JHB100_SYS2RST_HUSBCMN_RSTN_HOSTUSB1_CRG, 16 },
+	{ JHB100_SYS2RST_BMCPERIPH1_RSTN_CRG, 17 },
+	{ JHB100_SYS2RST_BMCPERIPH1_RSTN_BUS, 18 },
+	{ JHB100_SYS2RST_BMCPERIPH0_RSTN_CRG, 19 },
+	{ JHB100_SYS2RST_BMCPERIPH0_RSTN_BUS, 20 },
+	{ JHB100_SYS2RST_GPU0_RSTN_CRG, 21 },
+	{ JHB100_SYS2RST_GPU0_RSTN_BUS, 22 },
+	{ JHB100_SYS2RST_GPU0_HOST_PCIE_RST_N, 23 },
+	{ JHB100_SYS2RST_GPU1_RSTN_CRG, 24 },
+	{ JHB100_SYS2RST_GPU1_RSTN_BUS, 25 },
+	{ JHB100_SYS2RST_GPU1_HOST_PCIE_RST_N, 26 },
+};
+
+static const struct starfive_reset_info jhb100_sys2_info = {
+	.nr_resets = NUM_RESETS(JHB100_SYS2RST_GPU1_HOST_PCIE_RST_N),
+	.assert_offset = 0x88,
+	.status_offset = 0x8c,
+	.discontigous = true,
+	.map = jhb100_sys2_map,
+};
+
+struct starfive_reset_map jhb100_per0_map[] = {
+	{ JHB100_PER0RST_MAIN_RSTN_UART4, 1 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART5, 2 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART6, 3 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART7, 4 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART8, 5 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART9, 6 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART10, 7 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART11, 8 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART12, 9 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART13, 10 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART14, 11 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C0, 12 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C1, 13 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C2, 14 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C3, 15 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C4, 16 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C5, 17 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C6, 18 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C7, 19 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C8, 20 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C9, 21 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C10, 22 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C11, 23 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C12, 24 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C13, 25 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C14, 26 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C15, 27 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C0, 28 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C1, 29 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C2, 30 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C3, 31 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C4, 32 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C5, 33 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C6, 34 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C7, 35 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C8, 36 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C9, 37 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C10, 38 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C11, 39 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C12, 40 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C13, 41 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C14, 42 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C15, 43 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT0, 44 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT1, 45 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT2, 46 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT3, 47 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT4, 48 },
+	{ JHB100_PER0RST_MAIN_RSTN_DUALTIMER0, 49 },
+	{ JHB100_PER0RST_MAIN_RSTN_DUALTIMER1, 50 },
+	{ JHB100_PER0RST_MAIN_RSTN_DUALTIMER2, 51 },
+	{ JHB100_PER0RST_MAIN_RSTN_TRNG, 52 },
+	{ JHB100_PER0RST_MAIN_RSTN_DMAC0, 53 },
+	{ JHB100_PER0RST_MAIN_RSTN_DMAC1, 54 },
+	{ JHB100_PER0RST_MAIN_RSTN_DMAC2, 55 },
+	{ JHB100_PER0RST_MAIN_RSTN_LTPI0, 56 },
+	{ JHB100_PER0RST_MAIN_RSTN_LTPI1, 57 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL4, 58 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL5, 59 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL6, 60 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL7, 61 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL8, 62 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL9, 63 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL10, 64 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL11, 65 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL12, 66 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL13, 67 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL14, 68 },
+	{ JHB100_PER0RST_MAIN_RSTN_LDO0, 69 },
+	{ JHB100_PER0RST_MAIN_RSTN_LDO1, 70 },
+	{ JHB100_PER0RST_MAIN_RSTN_PERIPH0_SENSORS, 71 },
+	{ JHB100_PER0RST_MAIN_RSTN_DMAC0_SENSORS, 72 },
+	{ JHB100_PER0RST_SYSCON_PRESETN, 73 },
+	{ JHB100_PER0RST_GPIO_IOMUX_PRESETN, 74 },
+	{ JHB100_PER0RST_UART_MUX_REG_WRAP, 75 },
+};
+
+static const struct starfive_reset_info jhb100_per0_info = {
+	.nr_resets = NUM_RESETS(JHB100_PER0RST_UART_MUX_REG_WRAP),
+	.assert_offset = 0x554,
+	.status_offset = 0x560,
+	.discontigous = true,
+	.map = jhb100_per0_map,
+};
+
+struct starfive_reset_map jhb100_per1_map[] = {
+	{ JHB100_PER1RST_IOMUX_PRESETN, 0 },
+	{ JHB100_PER1RST_SYSCON_PRESETN, 1 },
+	{ JHB100_PER1RST_MAIN_RSTN_SFC0, 2 },
+	{ JHB100_PER1RST_MAIN_RSTN_SFC1, 3 },
+	{ JHB100_PER1RST_MAIN_RSTN_SFC2, 4 },
+	{ JHB100_PER1RST_MAIN_RSTN_SPI0, 5 },
+	{ JHB100_PER1RST_MAIN_RSTN_PERIPH1_SENSORS, 6 },
+	{ JHB100_PER1RST_MAIN_RSTN_SGPIO0, 7 },
+	{ JHB100_PER1RST_MAIN_RSTN_SGPIO1, 8 },
+	{ JHB100_PER1RST_MAIN_RSTN_EMMC0, 9 },
+	{ JHB100_PER1RST_MAIN_RSTN_UFS, 11 },
+	{ JHB100_PER1RST_MAIN_RSTN_UFS_PHY, 12 },
+	{ JHB100_PER1RST_MAIN_RSTN_DMAC_SFC0, 13 },
+	{ JHB100_PER1RST_MAIN_RSTN_DMAC_SFC1, 14 },
+	{ JHB100_PER1RST_MAIN_RSTN_DMAC_SFC2, 15 },
+	{ JHB100_PER1RST_MAIN_RSTN_DMAC_SPI0, 16 },
+	{ JHB100_PER1RST_MAIN_RSTN_PERIPH1_RAS, 17 },
+};
+
+static const struct starfive_reset_info jhb100_per1_info = {
+	.nr_resets = NUM_RESETS(JHB100_PER1RST_MAIN_RSTN_PERIPH1_RAS),
+	.assert_offset = 0x134,
+	.status_offset = 0x138,
+	.discontigous = true,
+	.map = jhb100_per1_map,
+};
+
+struct starfive_reset_map jhb100_per2_map[] = {
+	{ JHB100_PER2RST_IOMUX_PRESETN, 0 },
+	{ JHB100_PER2RST_POK_IOMUX_PRESETN, 1 },
+	{ JHB100_PER2RST_SYSREG_RSTN, 2 },
+	{ JHB100_PER2RST_MAIN_RSTN_CAN0, 3 },
+	{ JHB100_PER2RST_MAIN_RSTN_CAN1, 4 },
+	{ JHB100_PER2RST_FAN_TACH_PRESETN, 5 },
+	{ JHB100_PER2RST_MAIN_RSTN_GMAC2, 7 },
+	{ JHB100_PER2RST_MAIN_RSTN_GMAC3, 8 },
+	{ JHB100_PER2RST_MAIN_RSTN_DMAC_8CH, 9 },
+	{ JHB100_PER2RST_MAIN_RSTN_RTC, 10 },
+	{ JHB100_PER2RST_ADC0_PRESETN, 11 },
+	{ JHB100_PER2RST_ADC0_IOMUX_PRESETN, 12 },
+	{ JHB100_PER2RST_ADC1_PRESETN, 13 },
+	{ JHB100_PER2RST_ADC1_IOMUX_PRESETN, 14 },
+	{ JHB100_PER2RST_MAIN_RSTN_PERIPH2_SENSORS, 15 },
+};
+
+static const struct starfive_reset_info jhb100_per2_info = {
+	.nr_resets = NUM_RESETS(JHB100_PER2RST_MAIN_RSTN_PERIPH2_SENSORS),
+	.assert_offset = 0x11c,
+	.status_offset = 0x120,
+	.discontigous = true,
+	.map = jhb100_per2_map,
+};
+
+static const struct starfive_reset_info jhb100_per3_info = {
+	.nr_resets = NUM_RESETS(JHB100_PER3RST_IOMUX_PRESETN),
+	.assert_offset = 0x98,
+	.status_offset = 0x9c,
+	.discontigous = false,
+};
+
+static int jhb100_reset_probe(struct auxiliary_device *adev,
+			      const struct auxiliary_device_id *id)
+{
+	struct starfive_reset_info *info = (struct starfive_reset_info *)(id->driver_data);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
+	void __iomem *base = rdev->base;
+
+	if (!info || !base)
+		return -ENODEV;
+
+	return reset_starfive_register_with_info(&adev->dev, adev->dev.parent->of_node,
+						 base + info->assert_offset,
+						 base + info->status_offset,
+						 NULL, info, NULL);
+}
+
+static const struct auxiliary_device_id jhb100_reset_ids[] = {
+	{
+		.name = "clk_starfive_common.jhb100-r-sys0",
+		.driver_data = (kernel_ulong_t)&jhb100_sys0_info,
+	},
+	{
+		.name = "clk_starfive_common.jhb100-r-sys1",
+		.driver_data = (kernel_ulong_t)&jhb100_sys1_info,
+	},
+	{
+		.name = "clk_starfive_common.jhb100-r-sys2",
+		.driver_data = (kernel_ulong_t)&jhb100_sys2_info,
+	},
+	{
+		.name = "clk_starfive_common.jhb100-r-per0",
+		.driver_data = (kernel_ulong_t)&jhb100_per0_info,
+	},
+	{
+		.name = "clk_starfive_common.jhb100-r-per1",
+		.driver_data = (kernel_ulong_t)&jhb100_per1_info,
+	},
+	{
+		.name = "clk_starfive_common.jhb100-r-per2",
+		.driver_data = (kernel_ulong_t)&jhb100_per2_info,
+	},
+	{
+		.name = "clk_starfive_common.jhb100-r-per3",
+		.driver_data = (kernel_ulong_t)&jhb100_per3_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(auxiliary, jhb100_reset_ids);
+
+static struct auxiliary_driver jhb100_reset_driver = {
+	.probe		= jhb100_reset_probe,
+	.id_table	= jhb100_reset_ids,
+};
+module_auxiliary_driver(jhb100_reset_driver);
+
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JHB100 reset driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


