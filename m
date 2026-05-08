Return-Path: <netdev+bounces-285656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULr3IEJ8/WkffAAAu9opvQ
	(envelope-from <netdev+bounces-285656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:01:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 077B64F2329
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FA54306B3A9
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6724A35F60F;
	Fri,  8 May 2026 05:39:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2111.outbound.protection.partner.outlook.cn [139.219.17.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07FE37AA95;
	Fri,  8 May 2026 05:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218744; cv=fail; b=QgGnPFhU5iLGrNigdyFFfEzv43/QDm2iHpbBDyhOIkcg9SnQyCMCdOhXt3qLsDePq2RUoLXDb3LRQY054m7MOeeZgXRLCIGT3OW2iRIfW5F63z7KakxPmnfvoqY2DQ4KyFzDAqSjJXAjOGn6QnkbNUG/A2VH1Y+qgDGTNYAgYQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218744; c=relaxed/simple;
	bh=7TAmFCuW/i4x72pHsLyhgitCYSD/0QxrzyaqU0xTjR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L3NgYDLgBcsT4NLrI3QYqVBVKc2qWIuMQ+4dorpl8fErmm4x/OaVEAT8n0XL3g+XNCAIb53L+F4GlpQCyl0ac4UJ9T8VdkOonVaffUUXkgHKjETOXpjWYPk6NTOvIZeK+XPNMXcyA8ZJ5pPhL5HVGSJDvP+tO1btO6H1Gy8A8FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/k4EsPM2pW45WCrLJeG9w3+08ozGjyyeA1rCQdIjMPbhUJA+DITLOc3ZnQqJx2FJQS6rTI7Mxk9AfLemc2wQBm1euFzym58EQE9AlwQe+i1n1dKd63xND8Wu/z/LfvfZe8LgXd3oETXH/+vCADfmznOAJw999jU6uwKesr3cr0Ks/XJ53lSiz9BHSZcAi0+BMDBzuzJdPmTF9gPXBVLFH/Gf4/MXkkN76zSrTtK5BwDrvZ4p0ibZmvZKLkLLowisMvW+E24YZ2HoKNgJmVa5z/nR0D/4VMf7OK5wrxqT6kmM3MJKhMPlbkd6j1wA5bZc6vBJasfdB6iiyL1b8+53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xziQxHHZq/dNvuQTYDV4/ieY8RhgbTmlJ2VvDlvJ3o=;
 b=LMC8F7BGcQON/myt4quM4d99RMH7GlOInr4n9RYLmNuBhIWZJqFUivZPj/gsYMXtMRXEfJS4Ic8Nyq/gh1p6ZlQCQnLAIfG8VEL7wZGXdAKs6llZBG/g6o/wcblDfjU+QP400xXokI47q4nB4KgycNdt9wGKzhUcRH4Vwkp8hQS1T8cyJePERQ/oSRu3UIoRF6hD8DB2wqiGrIVOtRC1Y+8JTRQz33ch8rRMpnhzSOzmPXpIx6D5TPBLrCVpc3ttg+AAr8sEFl8nGSHDoLdIFB9Fe8GV3pvowzMNQFiM+iYLYdOoi4rBA7cDjNTHzPXDHHKhEPcnjvCJaFlDemzHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 05:37:02 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:37:02 +0000
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
Subject: [PATCH v2 12/22] clk: starfive: Introduce inverter and divider
Date: Thu,  7 May 2026 22:36:22 -0700
Message-Id: <20260508053632.818548-13-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 84a76c84-69ba-4863-033e-08deacc3d4f5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|56012099003|38350700014|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Uw/p6Wtgi8+k3CTbiKY53yFUx1Q0jgT1y8XgfieqKlDI2Yblh5MsfIuwgKVGZD1QADK32ZCv+iZVe3u8a4HQH1q/0nj6ZG1t+A6huYD9wAZqcqEB6UgGWe8iZdcwM7Txj4yDRW1tE/aJ3diwF63nLyphkiWO+BtIeuyJDzRgH+t5b+9Tmw2hxQ8DwsiN8HNWJfB1K6FPBB38HWAraXEbNVyAN6e3cWOAy7eV2Tf96s5EmWZCqc2WHH+yJqIT565VVSDV6oTavvyA/ZKV6Hw68bjdFB/DL1MrzNrBI1S0rmnM65UZYES6PhN+GIyMAWDycDesDxx8U3W3/aGZJxhG92pTEOKoaekTofTpc4Wg0UmNkvb9DNAK8I3wdLxx39aLZamdg+4gc+w9pifMc9w6Tz5s7jUhOOwfsG5/S8gpw3QCVhMhegF40K6WF6zcK0IveIvBYlFpoFNMi8R8dIclxyQJgz4ZlK6tiJwe4MPv5dbg6K1Y6HkeZcGgszOjlqwrTI2LcN2UQKCeO/qgyQPdxObOwIdtf8OJ3THvhtV+Y5wDWwGCARBWR0PFhr6J5wY09aFkRHuB6sQtEOZU3P3keA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(56012099003)(38350700014)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lbpcwOzbcfftanX9oMgqpTDk1HSGSuE9t3ZAwKzwzbALKEf7ih3OyNDpItg8?=
 =?us-ascii?Q?pQwZl5XRj+ri7NbTzKxddlz8hDcrjU1ifXQ4mAA3i/w4yvxhzRQ8UmAvioYd?=
 =?us-ascii?Q?uygA8l07pkQ5BCXPds5kN3vc7ZkWlkGw8QEoWprs9IuTxwOWHrUYXZaWHhVq?=
 =?us-ascii?Q?kWo3kbrXlUHTZrygFN4hLsWTMjOSH0lvEDgnv/SMqQbneQZGSGwW1brisOcF?=
 =?us-ascii?Q?CXlHPwPV1zOQX+erjrrVwywLXQm6kfTcT/NA1sFlnB15qCEgOtpRw+4yoEYg?=
 =?us-ascii?Q?+Lsb8RmH1OYf9h9iOe6+cgAGWNGLRQ4FRqdyNLnJkFO9Jsztf1x6ZnGlSCHh?=
 =?us-ascii?Q?7Fah79e+J3FSnnDXDpLH/GT+paJxfNhlhuj8mTNJeQo1LKsaeO7LJBeBttQI?=
 =?us-ascii?Q?voWMUgc97amRLgZznB8UhGL69lPfzbZcwqPZv1c61T6RKJvFS4+lUZnR1asU?=
 =?us-ascii?Q?z1TFbtZWRvhvSEiQBhbM4QcNti/QqXW4XtWrIFWlNX4TspwzuxPTnjzLB7sZ?=
 =?us-ascii?Q?4X0Xct6ouWM2olM9znFjJdV828p2j1AAi7BUOuv2qbl8bmif8jqub7AKdOmx?=
 =?us-ascii?Q?v4wNqtTR66bWnQHfJTR+4OvpLyKTjKuwP52u/dh/8YaxvTT6Ab9FtkwohrUz?=
 =?us-ascii?Q?gEtoLScPovGfwMNyXSqySM0TXCXhAdJ/7w1L8J+DFJ6QRZUNlV8ci6ECXPi/?=
 =?us-ascii?Q?NwF3nc+MiIWpzVm4KJjUiOW7lwkhnRdA6xwBNaQu9PpueCL4WnVwTitOSnx1?=
 =?us-ascii?Q?tw64p9oHezm6jrQzQYZtT7zxX3nxnbQcvfS2gKYbD9P0DVszQHcUbk565AuE?=
 =?us-ascii?Q?xRQ2h0JGTemKzW66HCMlLCrC9s7sPXId4Obo2+G2jmr/q5VNyrw+QGBNpDDz?=
 =?us-ascii?Q?8DD6BdTbz9xwv59VA8AFHsajj9Nu0Q/imr3bkUzcqFWPiumbM07JdC1ojCFf?=
 =?us-ascii?Q?rkJsS93P2mlSS63elf0yYybWnD7heEa3ninWIQM/cfT5jLZdGlldSZ01IjxT?=
 =?us-ascii?Q?D3/m+Zv2jm/snUwE+TbmJynSU6z4KX/F2qtYQvvbHK0EC6Wosardc2nGH54G?=
 =?us-ascii?Q?AkmPHa/jbrWlX0A48vQaSsK3Ji62mwLGf83wbdHvgEf2kVxjda24rBoc9l/V?=
 =?us-ascii?Q?Ww6SYnPGKr0cpF0UL4TSIZftVq/CEdSWrSG1PeIRUDUEAT5clIL//NAyeq6T?=
 =?us-ascii?Q?+vBNcfHcb071NfTWn961Kk70kVahFMzatZKtxcIrz2dni+XsR7ILDWUPs+qb?=
 =?us-ascii?Q?5FrAdLk9vCiOMiagrLy1a9H6K9oT6xQFB4bYA0miFuXBZT5pzz3aPsOBCnCb?=
 =?us-ascii?Q?0CI/UvNK6xPseJQC0xa3LU6k8EA94/fkkaXHcq6kR1/4E/SEAw7CkDZbUreH?=
 =?us-ascii?Q?4wpsxRfjLNC2ameExf7xFZmj5j/ypmWsleyL2FvDpShvNJHGIYglVkFUe3wb?=
 =?us-ascii?Q?oMvpyyNTn+oKc2WWoMywVkVAo8IhbmX0hJPBIaF7bfyb5q8dxp64CRRIUkYN?=
 =?us-ascii?Q?LrBy1GIsYs6XpXNnHcxUykHW/jBLB+CcDY8T9GL7pZpdgARoe2GSVoGqWad5?=
 =?us-ascii?Q?wHcezQzMkg6xJ0zlrml1N/64YP+O6QFI0HA/eeiab2WNrCIhlmFSnvrIFQnp?=
 =?us-ascii?Q?12LyeM05bpGqL4XvsgVRe+D/jg/t3cy9gDquE3tXkVgeZcgESYUDxb2bwMzc?=
 =?us-ascii?Q?BgJsxmVA9y6+QlQ4Ceuel7mA/qUEHIMzTQ4t5zs5WTasXii/Dd0OD5FvDO2O?=
 =?us-ascii?Q?PVAf0df5Wxup0zQD2I5VbwgKEc/cpFSGMJ0UmJkoek5FMJTJNiU0?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a76c84-69ba-4863-033e-08deacc3d4f5
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:37:02.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHIPDFXhAgzk524UpAjFV/35dttIZ0PqMRXbZVcpV2Cdylbva137Z1iEDnQsEHY2Yeb4yIaQBd3QpNlxvmXMR9DZluSSREVgFgM+Bu6iNzdkqdu7uSXjNkflflUdjPq3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267
X-Rspamd-Queue-Id: 077B64F2329
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
	TAGGED_FROM(0.00)[bounces-285656-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.713];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:email,starfivetech.com:mid]
X-Rspamd-Action: no action

Introduce inverter and divider for starfive clocks.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-common.c | 12 ++++++++++++
 drivers/clk/starfive/clk-starfive-common.h |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/clk/starfive/clk-starfive-common.c b/drivers/clk/starfive/clk-starfive-common.c
index ece0464741a5..108ed2a45c3b 100644
--- a/drivers/clk/starfive/clk-starfive-common.c
+++ b/drivers/clk/starfive/clk-starfive-common.c
@@ -300,6 +300,15 @@ static const struct clk_ops starfive_clk_inv_ops = {
 	.debug_init = starfive_clk_debug_init,
 };
 
+static const struct clk_ops starfive_clk_idiv_ops = {
+	.get_phase = starfive_clk_get_phase,
+	.set_phase = starfive_clk_set_phase,
+	.recalc_rate = starfive_clk_recalc_rate,
+	.determine_rate = starfive_clk_determine_rate,
+	.set_rate = starfive_clk_set_rate,
+	.debug_init = starfive_clk_debug_init,
+};
+
 const struct clk_ops *starfive_clk_ops(u32 max)
 {
 	if (max & STARFIVE_CLK_DIV_MASK) {
@@ -310,6 +319,9 @@ const struct clk_ops *starfive_clk_ops(u32 max)
 		}
 		if (max & STARFIVE_CLK_ENABLE)
 			return &starfive_clk_gdiv_ops;
+		else if (max & STARFIVE_CLK_INVERT)
+			return &starfive_clk_idiv_ops;
+
 		if (max == STARFIVE_CLK_FRAC_MAX)
 			return &starfive_clk_fdiv_ops;
 		return &starfive_clk_div_ops;
diff --git a/drivers/clk/starfive/clk-starfive-common.h b/drivers/clk/starfive/clk-starfive-common.h
index 70eb7b7492e6..05352dbb6b87 100644
--- a/drivers/clk/starfive/clk-starfive-common.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -104,6 +104,14 @@ struct starfive_clk_data {
 	.parents = { [0] = _parent },						\
 }
 
+#define STARFIVE_IDIV(_idx, _name, _flags, _max, _parent)			\
+[_idx] = {									\
+	.name = _name,								\
+	.flags = _flags,							\
+	.max = STARFIVE_CLK_INVERT | (_max),					\
+	.parents = { [0] = _parent },						\
+}
+
 struct starfive_clk {
 	struct clk_hw hw;
 	unsigned int idx;
-- 
2.25.1


