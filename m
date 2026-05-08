Return-Path: <netdev+bounces-285654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Mj1Hfp5/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:51:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C29094F21BD
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F37730D8ACF
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB74F34E744;
	Fri,  8 May 2026 05:38:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2106.outbound.protection.partner.outlook.cn [139.219.146.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038E37997E;
	Fri,  8 May 2026 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218734; cv=fail; b=f1xWbs6L599EaLzvCaajgBko94C40RaBTPleRLHuNiklhTvhMCZCb6W99ooq/3F5Z5B8+8kYcRFnRyY/lpza/3HZmK5b+s0O5xAtjK8b0MefGH5iGnE38iKPPX02XZMHuIN2N7rfm35vGR/bgv01SaLRwBVq/SKeUckoFvMKoM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218734; c=relaxed/simple;
	bh=1V6JDjk9nECfKrPNjH+lkE9wT2UGFHjfPbnNDSyW0jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RSNa32jGBq+iq2jsT/3jtpJx9WwBLlK/hLGExpVhP+HB7nTtbedxfBhTVuWwrB/RdzPYys9VA964v2ycPHRQ8uQQfPpkOCYcW7kpqzvtSHEJr4BzkhmJ9YzRNEJHUoZvHjXbPyUs/+/BIoo+uxQ/pZXqvud8tMEvZHJPKPOetfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGSfkxyPXjinacNFz6L2z+wAciO+I9GZHnc4GVVLevWKbOPG2Vi/8cbM1iTvQ3ayvfScUNBZH7eutDvXA+BfbXDctDFK7SdUDgF8G25s/50gndfywEzvA+2Ec4TDekrJAS3Fgn6QX2QzFWnpzx4L/lv9gWvXXozjznOVFteQChYOzK/BusAjEx2xLpdH60cen7m4oot0Jp7f/lIqN5VBUtw++aKcstOJI6jhI8FEe8Sh5/grO4no6Zp2Y6BY6YS7QfNVGZwoPPOk9ZF1WsoDvZHJaj1sNNQxbedcaoMdbcir/o9VO6AfsrbDDpnVNA8qutAa3rpkciH1KGXzSRzwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+bKDYtB+SmyXym/8JCpu1CHeAVyY584B0GSnkCqO9w=;
 b=GQxJBbic3EbNmAbyExWp9dGqIS1LCqTMj9qEdmNmRp+IQB937p3Ni3A7pr5dW3kVOqcb5zrMV+QP46p0bxJ3RAaAUX2/Z0G1wi7d0/HI/x06KbP3pYygO4WTzpOLRAvjAn9iOLqAgXxHQKahlqgZYOV6/GRjw3jHNpcVZvRxslvw+jSGJq2cNrIzrR+xRhN+dBhtSpTk7z1mTBPRNvhrURaBQUwKoGbtTp+cDvVMJIW7V3VaZRFeypNkN7cW3rEEsGkaWmI5gooxNNOpDeg3SZC9IWr3PQ+WLIcpQnsTL1suZau5F/NqBdHAfFWANdNi0DRSIEqzTJCUdxQtJ4NQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1252.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 05:37:20 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:37:20 +0000
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
Subject: [PATCH v2 22/22] riscv: dts: starfive: jhb100: Add clocks and resets nodes
Date: Thu,  7 May 2026 22:36:32 -0700
Message-Id: <20260508053632.818548-23-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: f30d72f8-0904-4f5d-6f2f-08deacc3df64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kcvL5AcPtHSx47YqBrPuF2idbKyuVwUe3odCJdQ51povAtXx9hoRaGIUFonv1Ez/M9ryzHV/7BlX98i/4+QpC0MJ12en9PENxMQQbraWUdTdvYWz5BDpovSv9ZEbepAP/N0kIHn+va7+nahSLa6t2QnlRdUcGWzFOKWnwn0DPVK6er22kgbKqbqO1cl8RBO+jLtCpuEYCbsyAVBhnzTlok0Hagjv3qzWA0jsOPZnffc89HojtTHbjsDiDno3hNFdQyv9z5sUCq4cLvM9V3okAVswA5GYgPWZN1k+o6paryNqGJgcAPtcf9ySNZz0EuBtW6hwaNjoL4SwF9chpzkfcKBd4toJ1XrLB+ieqqhGNEdmcou6zbvWxgfN4KyjS9EXsIyO8Gze2dOh369nQ2Ag2bRTi0o8p1Rc6aD3sgmE4BPqqjtAuw8m7IiN5fi0TuwJPld6COuhfguv3HHyjmJMNY4njMth5+/oSxAJboXN8LGrY/3qrhA7dp9iPjgrDALVLWGuzOIn4KrXWhHJSCnY+EPuCypH/tYCM0OjYmHqIRsCtoZBGLdgnDDTtaxDSfarTBmVK1PV3rb5hz4orxvLzA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FkvQs5pnqV1REXmQB/80zFIhywlawBtwwiuCdqHVqqr3BYh4viS4sMJjpo2s?=
 =?us-ascii?Q?zP8kiJ1+aYDreB8/gpaeFTxjPUF0XkMwylOS2Iv8ivDHHjPVcfgMV76C281b?=
 =?us-ascii?Q?B/t8AXyAEjZyMeTqeJ2wIyGzD0l1Wx2Rb7Hi55nJ/f4ewB66T+LaZQd6rnRf?=
 =?us-ascii?Q?GdvHNyUzElxlh9Upz0CcnA5qYLsHVh2iqCzK/SQVOglotOA1uNisf/ICRVpk?=
 =?us-ascii?Q?MDF9N9cjjal4AJp3ww8ABo3J8nTXQk5ly/ecjPXnKDxOV+qioNXYcSI6dhN7?=
 =?us-ascii?Q?MILVXvAuk5V+tAYbRiVqWfP2V4pryGzq36bkgoJcaVcQS+b6VuvcisDRhLWD?=
 =?us-ascii?Q?prs6amYLQRVW4oPm36NhrTANta6OD47+7d3TSOO24Lbymr5LHZ/JOWQjmQ34?=
 =?us-ascii?Q?Pyc2z8rahI32aK381H0Y0KxgHeYXTKKthH+qTNo7YUiuqwg7i7X9CQiwrIF2?=
 =?us-ascii?Q?4OkYvtTNrJfzjHuMCHKQchnMa/1IxvdBr1qCxIYsaKQvt2VC+IbSz4KPKKyf?=
 =?us-ascii?Q?sufqivevdQgcAXm8FYUfCdugzBNOmHkKr01++h5ahnueNUq+gpMviZeScL0o?=
 =?us-ascii?Q?2oVD9Mp+vy2nJP10Wqwyqdr52tgIolYEW0ZmKQ7DOVn456TvC8rUZe9QTcEg?=
 =?us-ascii?Q?c/BCZYOlCclhCucl/BK/YK9S2ZtH2yyNzp61t5DsaQkkXLxhaFZA6M6hz4Rc?=
 =?us-ascii?Q?KVre8cAu7fCbwBN75ZoPm0kVv8Mx62YALCUUjU9ZE5RasVu/B5YWz/2bifOW?=
 =?us-ascii?Q?2It5IA+xiC9hMk3Yhlt0ImUp2+PcnLYYCramo8NlMheWM+nbfvSTUrz7QjHJ?=
 =?us-ascii?Q?/21hI/Do2N+kNJ3X6bfZNpWMzs53h8QWyg7I/iwsMHmu03WyT7teBTANbEVZ?=
 =?us-ascii?Q?DC8wXe6cyeOlSzDIzhyJdUGwbLIvPq9w2BZey3iBBelOsfYq5mFXGeuc6jql?=
 =?us-ascii?Q?N8z/wM+oAmP3zIjsPYD9l1E6l8tGRUylV/S8B2xl3eTiz/8godI/Y3FFWZyb?=
 =?us-ascii?Q?HaXP6nKkXfWIPB79DboeD3Cz0FvksST7YzrT+CLrufFIVFcZbqc8XwzswJ8O?=
 =?us-ascii?Q?bmjC/n21h8RNdAXUYt+FcoPfCWMCr5j4pWQscMwOZhYDVO4AkUKoI9SLezNp?=
 =?us-ascii?Q?qPSw4SHT0dJx0iFmf3VMOAM9QiSY55REapTqA3enxfqdEVBjSSPYXEIBQ2qC?=
 =?us-ascii?Q?SGvVDSVWs/CSFfRosJ+jYFvt6EnI4gSj4rnFxaYWuAPDMAHLkPNKmCT4hlUS?=
 =?us-ascii?Q?6xIrNX1XzHuCsRBB8SCJYb5wlpd6ADkj3x5IPrGxaiL5bUQdAyjXpgsVi9Mc?=
 =?us-ascii?Q?S0+Lenu6gljLI5nkv74sy5PuPx2OAKl9vOsiHlaWG9q5w1khJIe89axUR6VU?=
 =?us-ascii?Q?44vGq5KHQtBm7JsxyMkJYVbNcbPgf28xGwDKkdFpL5UvSfjhtxLG/TRHZpB7?=
 =?us-ascii?Q?dUOeou3umxkmE6XSxRALrlgKgQlKtm/dJH4CtsuKMw71+znwM0AfvlgX98bC?=
 =?us-ascii?Q?GxMw9rwTkAFwHgp63cqm9Dpa29PKkg78wasEouaXRaR6xHXVSynK+cxkKWGL?=
 =?us-ascii?Q?mj3c24ME9N5tloojaZEPRbIoA4KzoY7c+0vHPBYkDHCDgqqS+43lMA+GThjd?=
 =?us-ascii?Q?x1HgoHcObGtqlsGxkWS/d6/KdBMAHfSQJmpxlBdMvtsNOANC5ROFQ6NF4oNl?=
 =?us-ascii?Q?ZSwXFGWeLrOK3B5XFrtpInd3v0o03LZgDAhPa+xpXFmUUL1s2d553AHiqEYn?=
 =?us-ascii?Q?0kC4hXSaklMQ6tumGG2oqcRPXpfMYqIPH5+ERz439MaSjY/ttnBa?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30d72f8-0904-4f5d-6f2f-08deacc3df64
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:37:20.0535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqjWKUb/7NvixPfWUTzPahERS1E2j86waagYYz8BJru0ZNcSSPvTC4XwA9qCuP8n4G1k+B9dVifxvus+eoUpBDDptPbPKe4gNWjDWyNSvgIgJePdDmbx54Ci0paCsqLF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1252
X-Rspamd-Queue-Id: C29094F21BD
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
	TAGGED_FROM(0.00)[bounces-285654-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.700];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.198.124.128:email,11bc0000:email,11c40000:email,starfivetech.com:email,starfivetech.com:mid,0.182.212.176:email,0.198.108.224:email,0.201.184.160:email,11a08000:email,0.198.93.64:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add clocks and resets nodes for JHB100 RISC-V BMC SoC. They contain
sys0crg/sys1crg/sys2crg/per0crg/per1crg/per2crg/per3crg.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jhb100.dtsi | 198 ++++++++++++++++++++++-
 1 file changed, 195 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jhb100.dtsi b/arch/riscv/boot/dts/starfive/jhb100.dtsi
index 4133ba1f45b4..943324b3b2fd 100644
--- a/arch/riscv/boot/dts/starfive/jhb100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jhb100.dtsi
@@ -4,6 +4,8 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/clock/starfive,jhb100-crg.h>
+#include <dt-bindings/reset/starfive,jhb100-crg.h>
 
 / {
 	compatible = "starfive,jhb100";
@@ -268,12 +270,96 @@ pmu {
 			<0x00 0x22 0xFFFFFFFF 0xFFFFFF22 0x00007FF8>;	/* Event ID 34 */
 	};
 
-	clk_uart: clock-25000000 {
-		compatible = "fixed-clock"; /* Initial clock handler for UART */
+	osc: clock-osc {
+		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
 
+	pll0: clock-pll0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <2400000000>;
+	};
+
+	pll1: clock-pll1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1000000000>;
+	};
+
+	pll2: clock-pll2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <903168000>;
+	};
+
+	pll4: clock-pll4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100700000>;
+	};
+
+	pll5: clock-pll5 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100700000>;
+	};
+
+	pll6: clock-pll6 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <2400000000>;
+	};
+
+	pll7: clock-pll7 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1950000000>;
+	};
+
+	per2_gmac2_rgmii_rx: clock-per2-gmac2-rgmii-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	per2_gmac2_rmii_ref: clock-per2-gmac2-rmii-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	per2_gmac3_sgmii_tx: clock-per2-gmac3-sgmii-tx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	per2_gmac3_sgmii_rx: clock-per2-gmac3-sgmii-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	per3_gmac0_rmii_rclki: clock-per3-gmac0-rmii-rclki {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	per3_gmac1_sgmii_tx: clock-per3-gmac1-sgmii-tx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	per3_gmac1_sgmii_rx: clock-per3-gmac1-sgmii-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -316,8 +402,10 @@ bus_nioc: bus_nioc {
 			uart6: serial@11982000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x0 0x11982000 0x0 0x400>;
-				clocks = <&clk_uart>, <&clk_uart>;
+				clocks = <&per0crg JHB100_PER0CLK_SCLK_UART6>,
+					 <&per0crg JHB100_PER0CLK_APB_UART6>;
 				clock-names = "baudclk", "apb_pclk";
+				resets = <&per0crg JHB100_PER0RST_MAIN_RSTN_UART6>;
 				interrupt-parent = <&intc>;
 				interrupts = <26>;
 				reg-io-width = <4>;
@@ -325,6 +413,110 @@ uart6: serial@11982000 {
 				status = "disabled";
 			};
 
+			per0crg: clock-controller@11a08000 {
+				compatible = "starfive,jhb100-per0crg";
+				reg = <0x0 0x11a08000 0x0 0x1000>;
+				clocks = <&osc>, <&pll6>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER0_CFG_400>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER0_CFG_800>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER0_NCNOC_INIT>,
+					 <&sys2crg JHB100_SYS2CLK_BMCPER0_NCNOC_TARG>;
+				clock-names = "osc", "pll6", "cfg_400",
+					      "cfg_800", "ncnoc_init",
+					      "ncnoc_targ";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			per1crg: clock-controller@11b40000 {
+				compatible = "starfive,jhb100-per1crg";
+				reg = <0x0 0x11b40000 0x0 0x1000>;
+				clocks = <&pll7>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER1_NCNOC_INIT>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER1_CFG_800>,
+					 <&sys2crg JHB100_SYS2CLK_BMCPER1_NCNOC_TARG>,
+					 <&sys2crg JHB100_SYS2CLK_BMCPER1_CFG_143>;
+				clock-names = "pll7", "ncnoc_init",
+					      "cfg_800", "ncnoc_targ",
+					      "cfg_143";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			per2crg: clock-controller@11bc0000 {
+				compatible = "starfive,jhb100-per2crg";
+				reg = <0x0 0x11bc0000 0x0 0x1000>;
+				clocks = <&sys0crg JHB100_SYS0CLK_BMCPER2_NCNOC_INIT>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER2_CFG_400>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER2_CFG_125>,
+					 <&per2_gmac2_rgmii_rx>,
+					 <&per2_gmac2_rmii_ref>,
+					 <&per2_gmac3_sgmii_tx>,
+					 <&per2_gmac3_sgmii_rx>,
+					 <&osc>;
+				clock-names = "ncnoc_init", "cfg_400", "cfg_125",
+					      "gmac2_rgmii_rx",
+					      "gmac2_rmii_ref",
+					      "gmac3_sgmii_tx",
+					      "gmac3_sgmii_rx",
+					      "osc";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			per3crg: clock-controller@11c40000 {
+				compatible = "starfive,jhb100-per3crg";
+				reg = <0x0 0x11c40000 0x0 0x1000>;
+				clocks = <&sys0crg JHB100_SYS0CLK_BMCPER3_NCNOC_INIT>,
+					 <&sys1crg JHB100_SYS1CLK_BMCPER3_NCNOC_TARG>,
+					 <&sys1crg JHB100_SYS1CLK_BMCPER3_CFG_125>,
+					 <&per3_gmac0_rmii_rclki>,
+					 <&per3_gmac1_sgmii_tx>,
+					 <&per3_gmac1_sgmii_rx>,
+					 <&osc>;
+				clock-names = "ncnoc_init", "ncnoc_targ", "cfg_125",
+					      "gmac0_rmii_rclki",
+					      "gmac1_sgmii_tx",
+					      "gmac1_sgmii_rx",
+					      "osc";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			sys0crg: clock-controller@13000000 {
+				compatible = "starfive,jhb100-sys0crg";
+				reg = <0x0 0x13000000 0x0 0x4000>;
+				clocks = <&osc>, <&pll0>, <&pll1>,
+					 <&pll2>;
+				clock-names = "osc", "pll0", "pll1", "pll2";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			sys1crg: clock-controller@13004000 {
+				compatible = "starfive,jhb100-sys1crg";
+				reg = <0x0 0x13004000 0x0 0x4000>;
+				clocks = <&osc>, <&pll0>, <&pll1>,
+					 <&pll2>, <&pll4>, <&pll5>,
+					 <&sys0crg JHB100_SYS0CLK_NPU_NCNOC_INIT>;
+				clock-names = "osc", "pll0", "pll1", "pll2",
+					      "pll4", "pll5", "npu_ncnoc_init";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			sys2crg: clock-controller@13008000 {
+				compatible = "starfive,jhb100-sys2crg";
+				reg = <0x0 0x13008000 0x0 0x4000>;
+				clocks = <&osc>, <&pll1>,
+					 <&sys0crg JHB100_SYS0CLK_GPU0_NCNOC_INIT>,
+					 <&sys0crg JHB100_SYS0CLK_GPU1_NCNOC_INIT>;
+				clock-names = "osc", "pll1", "gpu0_ncnoc_init",
+					      "gpu1_ncnoc_init";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
 			intc: interrupt-controller@13220000 {
 				compatible = "starfive,jhb100-intc";
 				reg = <0x0 0x13220000 0x0 0x80>;
-- 
2.25.1


