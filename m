Return-Path: <netdev+bounces-274481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FgYGUFSzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:25:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F326E388472
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5561B301B790
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B8E3BD655;
	Thu,  2 Apr 2026 11:14:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2127.outbound.protection.partner.outlook.cn [139.219.146.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B05432F740;
	Thu,  2 Apr 2026 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128451; cv=fail; b=QEVdNqjlftDtUezcyEKUECUylIlNaWXpT8WC3wzWVz0jFCKQsHxCiPkR2kqluBQLyEEA84JQVLW6wx12Jc0cv5hr4wbGtIxEBB9aRo0okCMr2usBHWoCOmTZ4X51YYDBxu0yYUJfoXGvRnP5VLU6j+oLG4EuDMCUGmtlgH9mNYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128451; c=relaxed/simple;
	bh=Zxkh7UsKhFjzAzHJdOyUP//Pq/5FJtbmH8w4ytj/AFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vFPutNL3KXHWA8Ynt9pJm1/wFSdQckuDfJQxSJkbN73rmGP0J1+gjes4jvf/3evMVR+Ihf2OVKoTiGRHPnRkP+Gk/EKolqzC7jZb3E47dM42QgDKt6uHbp/VumIFvIk+olGWtjZSWqbbTW9ESHuXJZyAy0lXJ/5zhItyVN7s40o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHB7dE1vku1AqGVylKseLknLWaTYc90wm86GgyECSla3bw38URB9THbzD/X/RFwjAhk8vdEpvkXtCz0EGTeGIgvHU2GgBrlYea4kYi81kjRcQJb3OdghQY4PUUm0+ytUWMTIe6u0BQPdDWRght/+cR6d7cSkmFg5jDQs9rZwiS+ggPV4l0KUcQ109m8Zx9UNx9Xb1b9n4veak4A+dGoQLikRlnRCUqg+1R1xTAMhjIW64DF15L20Zipk3O2nTXhr7EDDjjMXIYybIPoYWGDHYYXiCm0SIdjhrgpT7Tl990NgnYTr7D0TZY2fwDDJEVTduMldyNx7c/Ho9XJT6SMWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4bmIkU/eUKFfYRQwumYi5JkV+4ilPlgPd2Jw1Wybho=;
 b=EHkaWTqYSFEHZ3hpDSeCXKvsUBlnrahNWtcRIdB+LKg5rWGr94PrJ2JxI/pTJZVRScLI4qJDwzgJTyjhfMLpfreBG5eS3fjUTWmuKy469nX5Iz0ZqSQKBweLPqEZPU1S1IiEKEuIZoVKVyLQnoLD6d/vdh5Wq+shqGaRG9t8jXEus+vagnvR4YVFIpvqNWbCtDovGL7ghWw/HVQcXbz/jJZvl4jFiJZwTFbIHU7+f+sQkCyE/J/K1jh0idVddLJQcaLfPVoOVtxfE0T30gcD5fhPutnAozV8+EUOUqRfBSDIMgp9A1P5Qzj/av3ei72TcC2ha4jBV5AajsxzmrC31w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB1096.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:55:54 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:55:54 +0000
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
Subject: [PATCH v1 06/22] clk: starfive: Add JHB100 System-0 clock generator driver
Date: Thu,  2 Apr 2026 03:55:07 -0700
Message-Id: <20260402105523.447523-7-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1208:EE_|ZQ0PR01MB1096:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f18799d-b2f7-4838-a4dc-08de90a6695c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mvVSTR1fuQa3k8VPZputSRTxsEpt5CPPheWANZQzOCaNzlOTGhL5Tv0NcLQEz1E41qpLvh0F09JVIrsEFcYKC7n6Lsm1tQMW3RiTb5ZESdqiwde/r46o3+MqsQwZ/DcAPd3CtaHd2AHUmEdkhSnaurU5KHx8Mg4lK/lOwmUGoiAfanut5vBjOaWbazOavUwnDmgjD4qexxW2+C4lNiz5xVEw4XgsApL5RJZkVA3tpYc3XxS+fB/IOgRpXUucHOPMkKpU4Nf+Ws2kIyJ6UhOE1xnY8NIxHsCQ9p32Ky/SOCsG2WSR6vsJRGOJWsJMsLRqSsQHbnzufoVUl80dv1NCli29S34Mk4ec3d0X6+qojK84LujD9e50aigjkD7zK0othZE99cD/zaP11anWwQ+oWrN+8ZdgGkVrKmiQ8BNnrMzuiz5sF7wdQozMpXVJPKucrlq4VL4Qji2Yi0DbjD8WJaVvW9XJPOpEiZdT1ykOU+CLCRRA+6rDKuFmliY0crryR+AAHLLw6FUfYJ9ARrzK8cStMsfkqyRUYLFVZT1bXKpL8fjTTQtTWyoy+a6+uQHi7iUS/N167XWlCRKAAW2JKj1Vvntdp5BPXZXTM/h5OzI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HOW3ToQTVxJr/rScbr+nXMEsv3oyJmdS1Chkj+Gpyfst2+mfNKNryPPA5a/b?=
 =?us-ascii?Q?oGkKovlpdiU2BhNGEQtjaki/UiA6s7NkMYn1OAxn3AZ11xsjF1eg6Q4i3zHu?=
 =?us-ascii?Q?lwsO9xA0rehNwIVOTn59S0H6+w4SrQo0UwL+bYtglSD6wybjVVfzWZDFUTrj?=
 =?us-ascii?Q?3koR2poCv3yf1SGIlsgsCEXvn2d+vO98MdnqRZFu7h74zEAUY0yQ10WSCitC?=
 =?us-ascii?Q?HW46iaZTVNG3e1EDdJ1GN8p6ZMeh+COTtafZwfZhaDPJCKfK0wVtHpSmSVE4?=
 =?us-ascii?Q?tsS24pgBpDCOrol6H0JUFDEPWEB6Cfq+uxW8Eq7fi/sKK+Flyv741+kqG7cO?=
 =?us-ascii?Q?EhsPxQA90LJ93JpHIfYJPgmMw0FFgQUIaLQ7avTz57/wEBMltZcOZGJoP1EP?=
 =?us-ascii?Q?KSeKm/rcaplMYot3T3Dfp8YZq3aS+7DA4puSKVMfcCecHr+XeCf1CsoFYFLq?=
 =?us-ascii?Q?urjhZAZ62YKmcvH/ss45/VbPuEKGrfT0L7m/njfNh3uXa1qiJ43aXYSMa11k?=
 =?us-ascii?Q?uphBDDg/jgHvhSyWGt2oMHOnLdet8I3F3Ek00s3Ub0gFVSCUjCa05WymE1Xr?=
 =?us-ascii?Q?KgveovPQIxodtiCulspiQAIdANm/VOahs84KOwY1tZfR2kYD6o2gTvH8pkgb?=
 =?us-ascii?Q?OxO7FqggXfpD8TSaap1njWbVG70g9n5IGQEtHDhm/4cXVYDUED0DAXoLp8N1?=
 =?us-ascii?Q?KW3eksGRoVpyKguYYySQ4cGjcJ41PvR3qISu473yEZubBgJnUfyAsImjv/b8?=
 =?us-ascii?Q?SRt2sRqAsviCi4TUv8BuZdmeQku89mg17BV6z4vYdoTFFZ5EL9Acg11gml7M?=
 =?us-ascii?Q?e8Faj0iECKrfKgrgatOLQ4elB8d1IZUuMD/DzD5vbwTPDVrOTJ8q78m3ZWPC?=
 =?us-ascii?Q?jBIerKPuH9KBus/93NUvE7FGm42Evo8wJcEn/yUixQ2aNvkPBq9k4iwfMP2P?=
 =?us-ascii?Q?msxPbuL3uuG295ioi+b2tZYdgjh8rDclYy3+U6ppd+Yxp1JUbJz2uMon7c//?=
 =?us-ascii?Q?na38psA+dm9VV1IkznhkMEnocwM0hcAgy+T57WWBMVLKAZhMfkoGQXzs8Vz0?=
 =?us-ascii?Q?gOaefZFJoS2bSzUauwK9735Dpa4b2p1dw2q8hl2AjJ3MMe8cDxOrcnDYHZWI?=
 =?us-ascii?Q?V13dTP7XlnSwpRatNhAVGp7YxcUS7QisFFuBQMyEaGXIP2aHYD5N6NwNgKZI?=
 =?us-ascii?Q?72cCeZJMxcyLv/s5Ck16IS926ms0dD0uPkR0m/I51cvLeqprlBxgwdhnpMD3?=
 =?us-ascii?Q?BazJJ3F67/YA84etahuvL9zmnX2NvlQMAQfELL53F9IBhbN1RpxxUGZKEdEQ?=
 =?us-ascii?Q?ueln9QJi34i0SsT3ziPXGvlzERi/2vs1EHp4zKS2QaH7agi78eddGXPTMSgx?=
 =?us-ascii?Q?rq/kEJwe8z/b++aVdOpWW3qUs6dxEFF1r9LqB+9WDi2W9At2NDSEo+Qp5su7?=
 =?us-ascii?Q?GtwIwnkhZRQr56slkxGfxocmvZO1pd3eg7IKf/xdx6wdQUAewiJsmP4vGGh0?=
 =?us-ascii?Q?c++Yy3YK7ftHHo64RdfGOnPKuZmxzuZccksib3n8lRduGZlvzfFvE0eOTxQJ?=
 =?us-ascii?Q?nnl1v7UyS5L0e3ESZ9zx4oiXr+2NXSBLTNegtiHQOHUqtVRZtsjcvnya9Cx3?=
 =?us-ascii?Q?crJ4ndgBlMmYWEJc1fGHgKfNB98ifeeFtG3kWo7xaNrMmhDbMJ2O2377CPB8?=
 =?us-ascii?Q?KS6Nb6gVT+d8aSUKrODJKN+scnh5L9QPHWKus87knBPcm/Q1zzAwtEysO7st?=
 =?us-ascii?Q?BI0mmuj3J1UnMh62pQxxKBH8W+LG4wEgh/81K8wDiy2vg8DPG/is?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f18799d-b2f7-4838-a4dc-08de90a6695c
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:55:54.4205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brjyCjEKY9Hz4hZNEktwZ/xNIQSEBQ0WE7miniSSNC2OiejtUafYhxZbLV+AE+KTULvsy4vQoZa8mroOyVozBYcVaDuZwVV3Zn1qA53lagVpUhyZ9XrvoX0Hu0XK//qK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1096
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274481-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.905];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: F326E388472
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for JHB100 System-0 clock generator (SYS0CRG).

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 MAINTAINERS                                   |   7 +
 drivers/clk/starfive/Kconfig                  |  11 +
 drivers/clk/starfive/Makefile                 |   2 +
 .../clk/starfive/clk-starfive-jhb100-sys0.c   | 253 ++++++++++++++++++
 drivers/clk/starfive/clk-starfive-jhb100.h    |  11 +
 5 files changed, 284 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys0.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b1892a480c31..3af9d79b7daf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25306,6 +25306,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml
 F:	drivers/irqchip/irq-starfive-jh8100-intc.c
 
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
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-sys0.c b/drivers/clk/starfive/clk-starfive-jhb100-sys0.c
new file mode 100644
index 000000000000..00299b161e2b
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-sys0.c
@@ -0,0 +1,253 @@
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
+#include <linux/auxiliary_bus.h>
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <soc/starfive/reset-starfive-common.h>
+
+#include "clk-starfive-jhb100.h"
+
+#define JHB100_SYS0CLK_NUM_CLKS			(JHB100_SYS0CLK_GPU1_600 + 1)
+
+/* external clocks */
+#define JHB100_SYS0CLK_OSC			(JHB100_SYS0CLK_NUM_CLKS + 0)
+#define JHB100_SYS0CLK_PLL0			(JHB100_SYS0CLK_NUM_CLKS + 1)
+#define JHB100_SYS0CLK_PLL1			(JHB100_SYS0CLK_NUM_CLKS + 2)
+#define JHB100_SYS0CLK_PLL2			(JHB100_SYS0CLK_NUM_CLKS + 3)
+
+static const struct starfive_clk_data jhb100_sys0crg_clk_data[] __initconst = {
+	/* bmcpcierp */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPCIERP_600, "bmcpcierp_600", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPCIERP_100, "bmcpcierp_100", 12,
+		      JHB100_SYS0CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS0CLK_PCIE_REF_CML, "pcie_ref_cml", 24,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCPCIERP_NCNOC_DATA_INIT, "bmcpcierp_ncnoc_data_init",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCPCIERP_600),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG_INIT, "bmcpcierp_ncnoc_cfg_init",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCPCIERP_100),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCPCIERP_NCNOC_TARG, "bmcpcierp_ncnoc_targ",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCPCIERP_600),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCPCIERP_PCU, "bmcpcierp_pcu",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_OSC),
+	/* hostss0 */
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS0_100, "hostss0_100", 12,
+		      JHB100_SYS0CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS0_600, "hostss0_600", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS0_PHY_SCAN_400, "hostss0_phy_scan_400", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_GPIO_ESPI0_66, "gpio_espi0_66", 14,
+		      JHB100_SYS0CLK_PLL2),
+	/* bmcusb */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCUSB_600, "bmcusb_600", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCUSB_200, "bmcusb_200", 6,
+		      JHB100_SYS0CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCUSB_SCANCLK, "bmcusb_scanclk", 5,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCUSB_480M_SCANCLK, "bmcusb_480m_scanclk",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCUSB_SCANCLK),
+	/* vce */
+	STARFIVE__DIV(JHB100_SYS0CLK_VCE_600, "vce_600", 10,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_VCE_100, "vce_100", 12,
+		      JHB100_SYS0CLK_PLL1),
+	/* bmcperiph2 */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER2_600, "bmcper2_600", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER2_100, "bmcper2_100", 12,
+		      JHB100_SYS0CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER2_400, "bmcper2_400", 8,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER2_125, "bmcper2_125", 10,
+		      JHB100_SYS0CLK_PLL1),
+	/* hostss1 */
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS1_600, "hostss1_600", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400, "hostss1_phy_scan_400", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE_GATE(JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400_ICG_BUF,
+		      "hostss1_phy_scan_400_icg_buf", CLK_IS_CRITICAL,
+		      JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400),
+	/* npu */
+	STARFIVE__DIV(JHB100_SYS0CLK_NPU_600, "npu_600", 6,
+		      JHB100_SYS0CLK_PLL0),
+	/* vout */
+	STARFIVE__DIV(JHB100_SYS0CLK_VOUT_600, "vout_600", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_VOUT_AUX, "vout_aux", 150,
+		      JHB100_SYS0CLK_PLL0),
+	/* bmcperiph3 */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER3_600, "bmcper3_600", 6,
+		      JHB100_SYS0CLK_PLL0),
+	/* hostusb */
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTUSB_600, "hostusb_600", 6,
+		      JHB100_SYS0CLK_PLL0),
+	/* hostusbcmn */
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTUSBCMN_480, "hostusbcmn_480", 5,
+		      JHB100_SYS0CLK_PLL0),
+	/* bmcperiph1 */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER1_600, "bmcper1_600", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER1_800, "bmcper1_800", 4,
+		      JHB100_SYS0CLK_PLL0),
+	/* bmcperiph0 */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER0_600, "bmcper0_600", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER0_400, "bmcper0_400", 8,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER0_800, "bmcper0_800", 8,
+		      JHB100_SYS0CLK_PLL0),
+	/* gpu0 */
+	STARFIVE__DIV(JHB100_SYS0CLK_GPU0_600, "gpu0_600", 10,
+		      JHB100_SYS0CLK_PLL0),
+	/* gpu1 */
+	STARFIVE__DIV(JHB100_SYS0CLK_GPU1_600, "gpu1_600", 10,
+		      JHB100_SYS0CLK_PLL0),
+};
+
+static void jhb100_reset_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void jhb100_reset_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
+
+	kfree(rdev);
+}
+
+int jhb100_reset_controller_register(struct starfive_clk_priv *priv,
+				     const char *adev_name,
+				     u32 adev_id)
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
+	adev->dev.release = jhb100_reset_adev_release;
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
+					jhb100_reset_unregister_adev, adev);
+}
+EXPORT_SYMBOL_GPL(jhb100_reset_controller_register);
+
+static int __init jhb100_sys0crg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JHB100_SYS0CLK_NUM_CLKS),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->num_reg = JHB100_SYS0CLK_NUM_CLKS;
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	for (idx = 0; idx < JHB100_SYS0CLK_NUM_CLKS; idx++) {
+		u32 max = jhb100_sys0crg_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jhb100_sys0crg_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jhb100_sys0crg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		if (!init.name)
+			continue;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jhb100_sys0crg_clk_data[idx].parents[i];
+
+			if (pidx < JHB100_SYS0CLK_NUM_CLKS)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == JHB100_SYS0CLK_OSC)
+				parents[i].fw_name = "osc";
+			else if (pidx == JHB100_SYS0CLK_PLL0)
+				parents[i].fw_name = "pll0";
+			else if (pidx == JHB100_SYS0CLK_PLL1)
+				parents[i].fw_name = "pll1";
+			else
+				parents[i].fw_name = "pll2";
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
+	return jhb100_reset_controller_register(priv, "r-sys0", 0);
+}
+
+static const struct of_device_id jhb100_sys0crg_match[] = {
+	{ .compatible = "starfive,jhb100-sys0crg" },
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
+builtin_platform_driver_probe(jhb100_sys0crg_driver, jhb100_sys0crg_probe);
diff --git a/drivers/clk/starfive/clk-starfive-jhb100.h b/drivers/clk/starfive/clk-starfive-jhb100.h
new file mode 100644
index 000000000000..6c5cb3e9c610
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CLK_STARFIVE_JHB100_H
+#define __CLK_STARFIVE_JHB100_H
+
+#include "clk-starfive-common.h"
+
+int jhb100_reset_controller_register(struct starfive_clk_priv *priv,
+				     const char *adev_name,
+				     u32 adev_id);
+
+#endif
-- 
2.25.1


