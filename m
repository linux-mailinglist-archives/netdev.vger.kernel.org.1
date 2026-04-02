Return-Path: <netdev+bounces-274485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BLaBvBQzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:20:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 686F13883AF
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29DFE311F5E2
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E69339B94B;
	Thu,  2 Apr 2026 11:14:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D1F3C454B;
	Thu,  2 Apr 2026 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128478; cv=fail; b=k9CtruVoJxIjmizVu9V9fvsP6+0DapnSMV6XGMOw/ngmL+iGCiSThCIwCPqchhQP2uhiLprYGLSB48YcW7aYROK8Bt6+ExEVP9McKC6QGeiifECIZKQKxyfaXgiShtZl9QV/86BAlz6J5kUdpPYrTstFc4JRp06ixd3g3Pm37So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128478; c=relaxed/simple;
	bh=S/5bi06YFB0cynLDeSONLZSRaerAbDE8Xqn/BM4tmyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qsd3mXf8V6qS43VcT+ND4dGsmAUDTBAnSTLwwwYfSATGsFwcfJE3NZMtbmG0kJ3nVwh6KhF31FTzSu5dUGE06//okwzQng+JWRqz3cGhYnj2tkpAS3iFgRG/Ed6/3D/S6lCzdkV3FyEStlDL2PCekMcY+PXCckAo/G1mvTQOs1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7MPgLEiMq8LDgPjebjgdYxX63rzkiDcfQTUNgPtmlBpaRFdzgjb6oDnI+Ny/xVlUYIdYEJkGMpGJmbIaQHWETA50BgvmQ8gKyCDeX+eZjvu7RURsI10otXqNZ6o92nEbLc+Cg0VH3kXIzvYq/SaiatxkMLqQFM2QINKmntIthSyauhOp/bku5za0i5Cpvnq8ybkvc1I8nmFHcD5Hnd/JGXKB10R7ACsvuVm0hAXf3INUxGzdxmn1pyy1KQND4e0zjPzenheVUR/czcNStV1Z0Wno+/vlFcwF0qUdnSennOQlFAdKk3DEDZJCpak73nfp90DVRwRx5YxVIAPUygZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY1sJOGTMdvYw4PqLPqWzjcDEj8TnmGzISpKgnHvgx4=;
 b=Ww4u57UB63MtJ++ZCCOiz4rhSfjauatOJiwDej3m8d3xUji94i7L7954cJaZkC5rFX4hyLVEzek/iJ0wqPyhHofUWe5Wmjt9U8gf+BzFvLL1Z4Zm6lDMMthmmRWO8FhxIQxl6Hz8S9fLqXWMDfZvdfigDP9O6d4qtE4XhpbqxSH6QMYy/enZ0i9M/2lHNugbWyy6Ed3arssTebvMaJFR76/aP+TAvj+Vy43s1QPlB3lhKGYKi2oz5JARt26ZJcThSx8FlQJY8qAhr8n+rk2cD1nkJ0Ezg/cgwm0YSP9nafsVa5TYnVbQzoUEaPhz4Rl0x+CT+YXsDClZUGpsqAYLAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:56:17 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:56:17 +0000
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
Subject: [PATCH v1 18/22] clk: starfive: Add StarFive JHB100 Peripheral-2 clock driver
Date: Thu,  2 Apr 2026 03:55:19 -0700
Message-Id: <20260402105523.447523-19-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1eacaf5c-849c-4c6f-6e63-08de90a67745
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yPJPkK3YvQjKdcNf0XAXaEeeJ6jOxevC6pxNSNNm9t9FRwrXvh2Y69ciDnpa5ae6Rtqnl1F0insdRB8kmnaHIQOAbakyKdf5pqtu6B/4xdzukGW+u2/kBEFOhSKzuU8Cxjeu3VmcabKkSLOz+YuF1AB271VggiIARpYnVfhvWwUlim8raji7Buh0M1igGRKLK2QmQLbbwLnjmBgfMQhqfZbsnFnaSAjxMZCw3XJs1kkCOGQKSTe5b9EDZKKcZhfljU1xmZmAep+heR6LpK9/ubwd6UgF1M5Xm+DR2KtzcsQYBTAunHgEeRvQiYTtlBPprrW2Je6FkC4p6uPCwzoBRJwtToj3w3D7fLKoGVA6efeCDKIOH54nYDtOKNPNihTsuknJHhqlnivydTvX2bRJDtDo4HILbK1kIVAoFIEBzYaKFEc0Rp4WWpvV2r38/PENXeopjlT9+9+xC3D1wS2uZGNIUxUaGDuPq8qNDMGm2SLhmg5EkN0oUHOgg75dnkMwpn14EyP6vvMVHPDfiDLhvrBOUz41NRtxSDopDxXP0nA3Zt/tlYVHyeT8EdIqo+WqhDZwVVFC62a9How8YpxVdWt0bvlGzI9CjVhOGClvMZ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yhGgVpCEY2ilfSZ+E1Y1DkkaijQvUQiv9JEEN1k7lCYvKAS8tY87y4hK5hmv?=
 =?us-ascii?Q?j4TActzA7lfAZJKLLRY7+cPsn9dkN+GLjMblRJ1Ba9MujrwMe9PkPPB4ymkI?=
 =?us-ascii?Q?IO9v5UK3Xg3ADWPJ+Q6KR3NK4ydZ2PZWqEmrFHch6h6l7hS7H7l+LPeJVwJ7?=
 =?us-ascii?Q?doYZSU22czE+WOfelXjzMpO3R0jJV1N3VGHdpHul/YpVCTMwVqAP1IE5N8Bn?=
 =?us-ascii?Q?0n7i5/dU3ZEHnhrF6uLkge0WasWWhHpBMS2MceHmKj3CxGLzIeg4oEnUQRux?=
 =?us-ascii?Q?Z26/YXQ8v+EYWuhODOnb9q8s6diObPkafA6BqEMfYVAnIUD03ovTFY2F3WpC?=
 =?us-ascii?Q?18kUP9zhttcAzHRvo2X2AAlvjBPMaxfPbv+ZGfjNVVrPQLuQTe669BU2SBL9?=
 =?us-ascii?Q?Bd17VRRCmO+SE/MQrUEmShNfTv4oUzewaHENV3QiWfZ006xIqOY2MT9Kffpy?=
 =?us-ascii?Q?Dvwjlr+jgLahNx4Z2mRtvMilD2CLY90/PvDKpGdI2HBAxOoNtjVoKV//6hJ6?=
 =?us-ascii?Q?L9Rzz/AmhG2G+llbrvcudwl8JWUL7itZbcPaNWdclEKYH2WoBWipiXN1pZPZ?=
 =?us-ascii?Q?mxhSr1Nw7hhJY5xDByLHUkABY9Ojc1hEtj8Rw4Mld2gAoeYtknxRtyZcstCt?=
 =?us-ascii?Q?utOagde1LYrlxsJpUOQEUDsD9LUR7m6Z2JiBV/ILSwKkI7QJirEhKzaJH/HV?=
 =?us-ascii?Q?YGtTMzlj0fJ8X2kdAiDcPyZLo3HQM4Yv+l0RWaW7bYuqouKSz+O+t+WW80Re?=
 =?us-ascii?Q?cK2N6vTcaaGeSqWlwO4VX92F5DJg7LeSxGxhdOQb5Whri46OJUsqlk95rCsf?=
 =?us-ascii?Q?HbM0RlbqX0p346EZ6yy5zFMTfVgvjC/zHeLu8OImE0oS84ASEiy7Mj11AHXh?=
 =?us-ascii?Q?jdLEO8fRIFLSWTNZkiIDtYzleq1Gfb+nKJpK2QbVeNO73vKOONfftpRhlVsF?=
 =?us-ascii?Q?W7miZLwda/WILVcUPhohCV/s/KZkvuqmBw4Kf1eTDI/N21uV/Zadl5Nbjc91?=
 =?us-ascii?Q?Zpz8zb2QCSUlUWXclmpJokh76tlY4i7oRdkx8E3seIwKKSdhP9i2b4wePhE+?=
 =?us-ascii?Q?yIZMb8h3dUN4Sscpye/kcfu69EX2/yJvYuJr9l0TygkluVWA8/VJ+KdhvzTs?=
 =?us-ascii?Q?Um7o3dJ7i89qtaN8Owdl1D6Ji5P0G0teEOUyJY4Yqp+hxRqfhljRvb32d1Su?=
 =?us-ascii?Q?PFTSgr4NPwx2MD97NZWNqGZELYi+8EHCASPZicX+/q5Cdvm67OVqKB6y9QvG?=
 =?us-ascii?Q?a5xq4k8M8FOG+q7mP8k2ftComdp+429dkrmTR7K+40hDVM9BcV/u1TR0ZH66?=
 =?us-ascii?Q?lrdo/ooDsrFMP9pe8tSsF2fWoNtiPM9bdYvukjEME+qXHxd1v1W2uYBk5pPE?=
 =?us-ascii?Q?O0hqFqEVpa+bHYmCE88/33zWg8rqJ8XxTaezz6jcFerb50ZUYB0XM4igAC3O?=
 =?us-ascii?Q?gpg/GSawi+098oFlp6TD1UBQKFMRuc/1CwIC3vD6hTqk+FcIm5rxSa5x8xbA?=
 =?us-ascii?Q?7TvHNYN4hB++vPUK3nykJlNWPbDGPPHC7LHwRFa2FxQ+6TbXqToSAuCfoE/7?=
 =?us-ascii?Q?fbbsa8MLLirtcdSxlgv0FZd73QB4J/5qkF9KKoeJEjLeUFW+pR2kNIjy0Lg0?=
 =?us-ascii?Q?86ie5mvcun0q+RQUmETcPUXDutKKjZINzbiYM5zpph45GsFEoqkBc5cL+66p?=
 =?us-ascii?Q?lKxX6bTHa3JZNMj0CM4ffnh3/kGbX5UtO/tYEREMZ0+6HNggAMbBaitKDXWj?=
 =?us-ascii?Q?IX4HqqQ3EVQqsC8OFjEPSUyFtVtIzmfNqtSf4aSImRTWGq1tP8fO?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eacaf5c-849c-4c6f-6e63-08de90a67745
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:56:17.4629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kgFsAHt3V2Hs+ze1povXqVghF6SpdC08KO61GA+H536v2S6u7lHDYSsJS0BNh22U9IzLCJFZMNPQKnQnO77dVhkk8RbDMIt2p19HKWlnYJEnZuM2HHoVOpH54ZS0m9d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1048
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274485-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.902];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 686F13883AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add driver for the StarFive JHB100 Peripheral-2 clock controller.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   8 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-per2.c   | 232 ++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per2.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 72cf314c6cfc..01d6d325dcd0 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -89,6 +89,14 @@ config CLK_STARFIVE_JHB100_PER1
 	  Say yes here to support the peripheral-1 clock controller
 	  on the StarFive JHB100 SoC.
 
+config CLK_STARFIVE_JHB100_PER2
+	bool "StarFive JHB100 peripheral-2 clock support"
+	depends on CLK_STARFIVE_JHB100_SYS0
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the peripheral-2 clock controller
+	  on the StarFive JHB100 SoC.
+
 config CLK_STARFIVE_JHB100_SYS0
 	bool "StarFive JHB100 system-0 clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 51511086a727..044e1942ccfa 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER0)		+= clk-starfive-jhb100-per0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER1)		+= clk-starfive-jhb100-per1.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_PER2)		+= clk-starfive-jhb100-per2.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS2)		+= clk-starfive-jhb100-sys2.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-per2.c b/drivers/clk/starfive/clk-starfive-jhb100-per2.c
new file mode 100644
index 000000000000..42b9dbd11618
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-per2.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 Peripheral-2 Clock Driver
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
+#define JHB100_PER2CLK_NUM_CLKS			(JHB100_PER2CLK_MAIN_ICG_EN_GMAC3 + 1)
+
+/* external clocks */
+#define JHB100_PER2CLK_600			(JHB100_PER2CLK_NUM_CLKS + 0)
+#define JHB100_PER2CLK_400			(JHB100_PER2CLK_NUM_CLKS + 1)
+#define JHB100_PER2CLK_125			(JHB100_PER2CLK_NUM_CLKS + 2)
+#define JHB100_PER2CLK_GMAC2_RGMII_RX		(JHB100_PER2CLK_NUM_CLKS + 3)
+#define JHB100_PER2CLK_GMAC2_RMII_REF		(JHB100_PER2CLK_NUM_CLKS + 4)
+#define JHB100_PER2CLK_OSC			(JHB100_PER2CLK_NUM_CLKS + 5)
+#define JHB100_PER2CLK_GMAC3_SGMII_TX		(JHB100_PER2CLK_NUM_CLKS + 6)
+#define JHB100_PER2CLK_GMAC3_SGMII_RX		(JHB100_PER2CLK_NUM_CLKS + 7)
+
+static const struct starfive_clk_data jhb100_per2crg_clk_data[] = {
+	STARFIVE__DIV(JHB100_PER2CLK_300, "per2_300", 2,
+		      JHB100_PER2CLK_600),
+	STARFIVE__DIV(JHB100_PER2CLK_100, "per2_100", 4,
+		      JHB100_PER2CLK_400),
+	STARFIVE__DIV(JHB100_PER2CLK_50, "per2_50", 2,
+		      JHB100_PER2CLK_100),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC2_RMII_50, "gmac2_rmii_50", 2,
+		      JHB100_PER2CLK_100),
+	STARFIVE__DIV(JHB100_PER2CLK_CAN0_CORE_DIV, "can0_core_div", 20,
+		      JHB100_PER2CLK_400),
+	STARFIVE__DIV(JHB100_PER2CLK_CAN1_CORE_DIV, "can1_core_div", 20,
+		      JHB100_PER2CLK_400),
+	STARFIVE__DIV(JHB100_PER2CLK_CAN0_TIMER, "can0_timer", 100,
+		      JHB100_PER2CLK_100),
+	STARFIVE__DIV(JHB100_PER2CLK_CAN1_TIMER, "can1_timer", 100,
+		      JHB100_PER2CLK_100),
+	STARFIVE__DIV(JHB100_PER2CLK_RTC_CORE_DIV, "rtc_core_div", 763,
+		      JHB100_PER2CLK_OSC),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_RMII_MUX_DLY, "gmac2_rmii_mux_dly", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RMII_REF,
+		      JHB100_PER2CLK_GMAC2_RMII_50),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC2_RMII_DIV, "gmac2_rmii_div", 20,
+		      JHB100_PER2CLK_GMAC2_RMII_MUX_DLY),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_RGMII_125_MUX, "gmac2_rgmii_125_mux", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RGMII_RX,
+		      JHB100_PER2CLK_125),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC2_RGMII_DIV, "gmac2_rgmii_div", 50,
+		      JHB100_PER2CLK_125),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_TX_MUX, "gmac2_tx_mux", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RMII_DIV,
+		      JHB100_PER2CLK_GMAC2_RGMII_DIV),
+	STARFIVE__INV(JHB100_PER2CLK_GMAC2_TX_180_BUF, "gmac2_tx_180_buf",
+		      JHB100_PER2CLK_GMAC2_TX_MUX),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_RX_MUX_DLY, "gmac2_rx_mux_dly", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RMII_DIV,
+		      JHB100_PER2CLK_GMAC2_RGMII_125_MUX),
+	STARFIVE__INV(JHB100_PER2CLK_GMAC2_RX_180_BUF, "gmac2_rx_180_buf",
+		      JHB100_PER2CLK_GMAC2_RX_MUX_DLY),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_TXCK_MUX_DLY, "gmac2_txck_mux_dly", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RMII_50,
+		      JHB100_PER2CLK_GMAC2_TX_MUX),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC3_TX_125_MUX, "gmac3_tx_125_mux", 0, 2,
+		      JHB100_PER2CLK_GMAC3_SGMII_TX,
+		      JHB100_PER2CLK_125),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC3_RX_125_MUX, "gmac3_rx_125_mux", 0, 2,
+		      JHB100_PER2CLK_GMAC3_SGMII_RX,
+		      JHB100_PER2CLK_125),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC3_TX_DIV, "gmac3_tx_div", 50,
+		      JHB100_PER2CLK_GMAC3_TX_125_MUX),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC3_RX_DIV, "gmac3_rx_div", 50,
+		      JHB100_PER2CLK_GMAC3_RX_125_MUX),
+	STARFIVE_GATE(JHB100_PER2CLK_SENSORS_PERIPH2, "sensors_periph2", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_FAN_TACH_PCLK, "fan_tach_pclk", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_TX_I, "ether0_rmiiandrgmii_tx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_TX_MUX),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RX_I, "ether0_rmiiandrgmii_rx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_RX_MUX_DLY),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_TX_180_I, "ether0_rmiiandrgmii_tx_180_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_TX_180_BUF),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RX_180_I, "ether0_rmiiandrgmii_rx_180_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_RX_180_BUF),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_PTP_REF_I, "ether0_rmiiandrgmii_ptp_ref_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_50),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RMII_I, "ether0_rmiiandrgmii_rmii_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_RMII_MUX_DLY),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_CSR_I, "ether0_rmiiandrgmii_csr_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_ACLK_I, "ether0_rmiiandrgmii_aclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_300),
+	STARFIVE_GATE(JHB100_PER2CLK_RMIIANDRGMII_IOMUX_GMAC2_TXCK, "rmiiandrgmii_iomux_gmac2_txck",
+		      CLK_IS_CRITICAL, JHB100_PER2CLK_GMAC2_TXCK_MUX_DLY),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_TX_I, "ether1_sgmii_tx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_TX_DIV),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_RX_I, "ether1_sgmii_rx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_RX_DIV),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_TX_125_I, "ether1_sgmii_tx_125_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_TX_125_MUX),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_RX_125_I, "ether1_sgmii_rx_125_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_RX_125_MUX),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_PTP_REF_I, "ether1_sgmii_ptp_ref_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_50),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_CSR_I, "ether1_sgmii_csr_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_ACLK_I, "ether1_sgmii_aclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_300),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_PHY_PCLK_I, "ether1_sgmii_phy_pclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_REF_25_I, "ether1_sgmii_ref_25_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_OSC),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_CAN0, "main_icg_en_can0", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_CAN1, "main_icg_en_can1", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_DMAC_8CH, "main_icg_en_dmac_8ch", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_RTC_SCAN, "main_icg_en_rtc_scan", CLK_IS_CRITICAL,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_ADC0, "main_icg_en_adc0", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_ADC1, "main_icg_en_adc1", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_GMAC2, "main_icg_en_gmac2", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_GMAC3, "main_icg_en_gmac3", 0,
+		      JHB100_PER2CLK_100),
+};
+
+static int jhb100_per2crg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JHB100_PER2CLK_NUM_CLKS),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->num_reg = JHB100_PER2CLK_NUM_CLKS;
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	for (idx = 0; idx < JHB100_PER2CLK_NUM_CLKS; idx++) {
+		u32 max = jhb100_per2crg_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jhb100_per2crg_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jhb100_per2crg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		if (!init.name)
+			continue;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jhb100_per2crg_clk_data[idx].parents[i];
+
+			if (pidx < JHB100_PER2CLK_NUM_CLKS)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == JHB100_PER2CLK_600)
+				parents[i].fw_name = "per2_600";
+			else if (pidx == JHB100_PER2CLK_400)
+				parents[i].fw_name = "per2_400";
+			else if (pidx == JHB100_PER2CLK_125)
+				parents[i].fw_name = "per2_125";
+			else if (pidx == JHB100_PER2CLK_GMAC2_RGMII_RX)
+				parents[i].fw_name = "per2_gmac2_rgmii_rx";
+			else if (pidx == JHB100_PER2CLK_GMAC2_RMII_REF)
+				parents[i].fw_name = "per2_gmac2_rmii_ref";
+			else if (pidx == JHB100_PER2CLK_GMAC3_SGMII_TX)
+				parents[i].fw_name = "per2_gmac3_sgmii_tx";
+			else if (pidx == JHB100_PER2CLK_GMAC3_SGMII_RX)
+				parents[i].fw_name = "per2_gmac3_sgmii_rx";
+			else if (pidx == JHB100_PER2CLK_OSC)
+				parents[i].fw_name = "osc";
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
+	return jhb100_reset_controller_register(priv, "r-per2", 0);
+}
+
+static const struct of_device_id jhb100_per2crg_match[] = {
+	{ .compatible = "starfive,jhb100-per2crg" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jhb100_per2crg_match);
+
+static struct platform_driver jhb100_per2crg_driver = {
+	.probe = jhb100_per2crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-per2",
+		.of_match_table = jhb100_per2crg_match,
+	},
+};
+module_platform_driver(jhb100_per2crg_driver);
+
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JHB100 Peripheral-2 Clock Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


