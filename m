Return-Path: <netdev+bounces-284248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB2RNkyk+WnR+QIAu9opvQ
	(envelope-from <netdev+bounces-284248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:03:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7EA4C869C
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4C0E3007209
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C1B3D5642;
	Tue,  5 May 2026 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="mLL6AedQ"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49ED37B03F;
	Tue,  5 May 2026 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968199; cv=fail; b=uOy+MCxQXuyD1xXhE0Kcos8H/PYL8wVFWV1AUsRAT+TXMD8ZW8ccNh203oR1Z4GyDfrpctm6TMQfYZDIn/3fKDE0pcyvLd+5BeuGs/Jon4/yEPfO3zRKalwV9DHo/VggVdEY/ZcOAvFnR7IOehwB1/CPstWtu7bMQuuXFwdNeiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968199; c=relaxed/simple;
	bh=LpdoSzQUUDrmsSskZ9qVH0wIrDBcEDmmDQlpKrzYJso=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PZ/2X6lYKLJr1986G3N5IRxIoqJJY3NT2UHnMQ/l1EXagkpONz25jy43iLJX/kAwkQYmIhgXky+zkLgNd3xCsA4qLplIlsmBWwc3j3F6Yki1u+HeM9ByFgI0JZ6RjP1CcTblcSo+qXB7SdSm0iJVQt+psdxld+IIeREpP/6gJqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=mLL6AedQ; arc=fail smtp.client-ip=40.107.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezr0EtqZ6KM62zfJ2Bs+8+vppg+9TGn4/wrHzr0b75ZVumZaZ16y37pbHSA5HuuZy1b6+bvkBQTABECheuR6FC6+jkpdlZzMyc9KuTM99jHoOpYYXvnvqVhyK/9210fw+ZZs64CAdogWn5ZrizJ5lUNO1+2EUD2VJB4a6988YrD/glEsRp/9Fyu6+dtnz9fGW40NYNAkzSmdXVICB30vI4DmZkZiWjg5dfG9hozwWdJguJyh6PHQFrFd9Xcyr7USQNC/Yb/8jBeaRFvZq+qVUw6S52sFPsPWOTx5C9LKjoKw6efnEXm/TfaG70gJLdRuQMPpCt4snm9/2YDmr5Hr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENBpMZ/LO3UJGPBRdjrkAIvmCql8CfLCjQSDnsFk2o4=;
 b=fIc1k176X9cW6ZbfynMgddpR2cgEbefjplb5BqErnExamT6DsWd7mRuXDr4yOrpQfXNYjg7xhZ7uxFIxK4MDKhs2BeASddFBbhMC77sRDH7d6arsHVHZaQLXknoTAuVltRKzdgj0tk2L/NeAhXVEfNgIN4v5iy1s0kHbiDA00KSBwYLNwaHpOZU6g3XsXxIGWTB35zpaReWb5kh5ZqDPeRdS4J0BSM/NtSHyAIRu/AdYIYbHXPYzSZtZRrUM0CqgHd6ly7tPYqBn7kNdlKoxviStPv79jTZrsX6h+yHTxPMrT75wTJsWTzWPeImfBB0NEc4oO1/30UCS4PTnrl97wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENBpMZ/LO3UJGPBRdjrkAIvmCql8CfLCjQSDnsFk2o4=;
 b=mLL6AedQlp1r6kGUThPx3TgIvPqn8Onhsqc8jXNt+8v3aHFddsWfYI2Zmz+vg28vmOLPWiUvOkvxPce/87g0Bn6Xxiupt0LyzxuHZeNI8L9BSHhrVzPpCuyhS254oBhqPfaD640cV5UsHMvl1bFcmL2R3uxfEQuGhXwsXogQVcQsi8hndBWrI8fBc+dH20O59la8xct1G0z8RZe1ZZD9C4gCt7KCzfjqYIxTJCuyTKVUHRibARQZ+BvBeAg0ngkEXcd+1/0XxQANJ+iNIf96yHGf0Hx13o4AuntQdxeyii7JQCB0u3I5xGQs5a8tHcn/u9wzFKmUXYXR8FfoGULN8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by MW4PR03MB6585.namprd03.prod.outlook.com (2603:10b6:303:128::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:03:13 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:03:13 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: stmmac: Use interrupt mode INTM=1 for per channel irq
Date: Tue,  5 May 2026 01:03:11 -0700
Message-ID: <20260505080311.17405-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::46) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|MW4PR03MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d753908-b6e4-4172-ccec-08deaa7cc155
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JJNiuwaP+rxGHCIwgFZxNJ9SSOLu8KjWr9QQ2+9LtewOkOMl0nJ+n/D0mYD6JfNqf72iVAYpUQRsXASil+dsG0jvv5FPYvh+BYwMTwd4bn9/IiypwsF8uvgzovKQ6N0bTHBa8BHQrVseTZPDEQ2ocDGHycasyzbIt3T8I+I31e8bmAkrqmA/lOWpCQiR0WYdlRi2FXWNuNhKbFBhR17D57Eocpn5TKrPmFs1sukhX9lSm+mB74MbMBzFwFrWB59C4U+iHY4C2xKKYZzgar+3+2yxjg1vXxgtNBUzO/xyZgzeI739VL1mnu8W13+elKC2TXnA28rAv4MgORcecWE1Gq+rllrbuqIUr4UgtZm8addXv/XuKM42rjUIuZJLotg+dBDaFnlYNLwY9G5jJzWMIC8y18mAKAdV9eDUeZ6ZcCsdi43VoJmLtJ91iA39Xfn7FqW4loV5ra+YfFC5sFhWtBskPHauW5ouiLuIheIDZCrfnsQEv+9RsmznTEeOA5VUNwn3+dJKfBliI7thwzIDy5YcAqPLQxvrrTzf6M+YfEz+j6Lwr/ukcz3gJ8nQizKabxxHppdMVTxacuw8f1MCdQITMbBgr2okZnVP857jG6nYDYH0SrNw+8GZK88Je61rYosgCR5oeBKi4vCs5GlSMnH2mKadL4q55bsOMm8qmlkLLI81M6LRg12vSqHuf9or
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fy9Ut3IXEP8Vs5LhNvnPCLsuT5a6qY2N5D9tA/dQJfFvM7C2Xd4c1H3mttdm?=
 =?us-ascii?Q?ckLH8f3/306bScHq369tZwGjGNdN2TKz6VoqfcP98DN3u9Kq1AiMnlRko3ps?=
 =?us-ascii?Q?9iPznO6VlpoM1eRUH7DrCELmWYUTzvYynum7aGCV8vozyhi0+CrLj36wGemk?=
 =?us-ascii?Q?0dPcxNQBGovruu39Z+fzuJeDlTMKET7mV2FvvCb4JXQUCAdqYCWTrx2nz5Cm?=
 =?us-ascii?Q?gYWNdlasDqjStbSNDFQ5+1Qa1Glh0caxM31yVigtOkWuPEWpgfzxaJybEwQ6?=
 =?us-ascii?Q?GsL5N9gVK7wov5ujRh96ag0n3oZ7LFiBfawaxtogE9vgOKRgb1nnfJfCgqfa?=
 =?us-ascii?Q?xZ77CCKMS/UFlp9ARZ4/ypgavmt6m2x/4pdl1dfpioaE9U19hP7PhxL1Hv76?=
 =?us-ascii?Q?O1/NefsRZYTZtgFNK/WfwgTScV5AAQOXM/bEvFM3ay/H5pHVFkzGpJa5me3M?=
 =?us-ascii?Q?5Vw9xgaGyH7CnbOPeNba+ZQpM1bPl4wWUvZzHnjsc+zEjpgt1gavYBYr/B/q?=
 =?us-ascii?Q?sS0/VUATV3L/4Vp2nfI0Q1OPWcWRV6Ac+F5MmGqI3nesVw24z9EkLvbyZ2s2?=
 =?us-ascii?Q?uiF6+0MAYGJXqoNekc/IvkVRDsvYGRjeMrA6jK0V1CwbWYwJw8d1JDK9ZyPf?=
 =?us-ascii?Q?DZz0KcuIxmSir2Rwyy/U3G6MkWbwyqGKrOP7QcEaRUV53Y7xdTdFRRDylRoG?=
 =?us-ascii?Q?OBzyw1zTbV18lGCLHsP1JdLvKejJQKHgzPM1BCdOzHH87N7+8+AJs+Wy4SNi?=
 =?us-ascii?Q?Hl7osH5BhUnl+FWjoK/vxUebwUTRhljlrJU3JocmqieYwzmoSZQFMTFE8t/z?=
 =?us-ascii?Q?A2yp3GjMpMhFtE/xFMutYBqRP2DbwHINOMC3tEvThsGFHS4hlb0MSCndfhSt?=
 =?us-ascii?Q?Uz0WEyuHP1GuNSXrd5TanjHGv0pw+M70/s8zJhcqc3jMHC2bUKmAjEya0oFQ?=
 =?us-ascii?Q?Ba5Ozc2/5u1+URDOQn3P/frdKuPjJU+bhCaJ4eS+1L90PAXvtcYaomIpyIst?=
 =?us-ascii?Q?uI1INyczw1cOuNADPLa9NnKxCt++STxRzftH1kyLtOkR/N6rTo7jTypObH9R?=
 =?us-ascii?Q?Bcf6RMOHONeZg8IlxNEsVNqigwJ+qZq+BovT52se+yq1TgPVv0PvNQ0qppc5?=
 =?us-ascii?Q?fqyB9qzYS8mce1jOQ511J4au1W0KLsIpXJmX3KtnMlCO7ckdq99fjYRR7+Eq?=
 =?us-ascii?Q?Grk8ymWTH1OBcUxsoo5HLkq6rqRBj7R10n9xS5J8OCczwcoXOMnwlck+MK6H?=
 =?us-ascii?Q?Iv0eNl+s+Xp2XG2Ht8cS9fEhVQwoPI1FYl1jqpotwhSDDWO5Yhi/ETTOg9AN?=
 =?us-ascii?Q?Yqe2Darg2BU2r5LAFg/YtXNp8ohhW3kdPIJyk6w6kZ/lLt4dACXp0Kpv4rvl?=
 =?us-ascii?Q?I8T2bkRbjZcVS6KrcI6xUZRxoT89FT0QYVdBGhhKx7b/2HhWAdYZokoF5q05?=
 =?us-ascii?Q?B2nROw09H62gba0H06BNobC1ZIVBe8ZvUHzIBeMHBbTLFKjhEjoRWDzG+tpB?=
 =?us-ascii?Q?xo+MkjrS1T3EEK0tx+ETPHqLiMZZDu2nOyvNW0N3h3TqHJEFXXWM7Vqi7yIP?=
 =?us-ascii?Q?wQASy9+JhEw6xpzKga4gyt6Q1V0JbLh9uC2arNizuhbHTyaJ/vi0uO1iU0Z2?=
 =?us-ascii?Q?M3iJRP46pYftsJzcPaHQ0s+puOEdaiV38jQOfZIWJjnQJSP6PyPM/H5KK4BI?=
 =?us-ascii?Q?IqJbgU+Z2t88zyeCYjZE8cY2rTz/+J0MGkLVcMSsI49AC/3GaKZpob5dUgGu?=
 =?us-ascii?Q?q4CKClHPG0bbGNz4j4Xxc/PAcAVSm0Z4eR9R+NaFIsn0afgG5cJCyNu+hKhh?=
X-MS-Exchange-AntiSpam-MessageData-1: 5itDhtE9UiLxsA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d753908-b6e4-4172-ccec-08deaa7cc155
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:03:13.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQH2UAVHpQra64mPrGu8/y7r4f43wA186zrjGm6rcHG59dVi2jDggYV9711He3SetBBU5j8XL7+7ME+IKU2XRNDVLFWl+uJUF4AV4Y+26+13sD1Q3YltMZq9EkvURdcaE+1zmW2JcDbzR+D14H84Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6585
X-Rspamd-Queue-Id: BA7EA4C869C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284248-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

commit 6ccf12ae111e ("net: stmmac: use interrupt mode INTM=1 for
multi-MSI") introduced INTM=1 interrupt mode for platforms using MSI.

Apply a similar approach to enable per-channel interrupts using shared
peripheral interrupt (SPI), so that only per-channel TX and RX
interrupts (TI/RI) are handled by the TX/RX ISR without invoking the
common interrupt ISR.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
Changes in v2:
- Rename macros to use XGMAC_ prefix to match dwxgmac2.h convention.
- Drop DMA_MODE_INTM_SHIFT and use FIELD_PREP() instead.
- Wire up multi_irq_en via STMMAC_FLAG_MULTI_IRQ_EN in stmmac_main.c
  so the feature is reachable by platform drivers.
- Drop unused plat_stmmacenet_data fields (ext_snapshot_num,
  int_snapshot_en, ext_snapshot_en, multi_msi_en, multi_irq_en)
  which duplicate existing flags bits.
- Remove misleading commit message paragraph about ISR decoupling
  (dwxgmac2_dma_interrupt() already handles TI/RI independently of NIS).
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     | 2 ++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 9 +++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 2 ++
 include/linux/stmmac.h                             | 2 ++
 4 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a2b0..544541e0e2a5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -320,6 +320,8 @@
 /* DMA Registers */
 #define XGMAC_DMA_MODE			0x00003000
 #define XGMAC_SWR			BIT(0)
+#define XGMAC_DMA_MODE_INTM_MASK	GENMASK(13, 12)
+#define XGMAC_DMA_MODE_INTM_MODE1	0x1
 #define XGMAC_DMA_SYSBUS_MODE		0x00003004
 #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
 #define XGMAC_RD_OSR_LMT		GENMASK(21, 16)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 03437f1cf3df..59fe488933d3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -4,6 +4,7 @@
  * stmmac XGMAC support.
  */
 
+#include <linux/bitfield.h>
 #include <linux/iopoll.h>
 #include "stmmac.h"
 #include "dwxgmac2.h"
@@ -31,6 +32,14 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
 		value |= XGMAC_EAME;
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	if (dma_cfg->multi_irq_en) {
+		value = readl(ioaddr + XGMAC_DMA_MODE);
+		value &= ~XGMAC_DMA_MODE_INTM_MASK;
+		value |= FIELD_PREP(XGMAC_DMA_MODE_INTM_MASK,
+				    XGMAC_DMA_MODE_INTM_MODE1);
+		writel(value, ioaddr + XGMAC_DMA_MODE);
+	}
 }
 
 static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ca68248dbc78..ac258641f5a1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7831,6 +7831,8 @@ static int __stmmac_dvr_probe(struct device *device,
 	priv->dev->base_addr = (unsigned long)res->addr;
 	priv->plat->dma_cfg->multi_msi_en =
 		(priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN);
+	priv->plat->dma_cfg->multi_irq_en =
+		(priv->plat->flags & STMMAC_FLAG_MULTI_IRQ_EN);
 
 	priv->dev->irq = res->irq;
 	priv->wol_irq = res->wol_irq;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 4430b967abde..2823ac3cb7a4 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -122,6 +122,7 @@ struct stmmac_dma_cfg {
 	bool eame;
 	/* multi_msi_en: stmmac core internal */
 	bool multi_msi_en;
+	bool multi_irq_en;
 	/* atds: stmmac core internal */
 	bool atds;
 };
@@ -202,6 +203,7 @@ enum dwmac_core_type {
 #define STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP	BIT(5)
 #define STMMAC_FLAG_VLAN_FAIL_Q_EN		BIT(6)
 #define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
+#define STMMAC_FLAG_MULTI_IRQ_EN		BIT(17)
 #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
 #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
 #define STMMAC_FLAG_EEE_DISABLE			BIT(10)
-- 
2.43.7


