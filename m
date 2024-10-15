Return-Path: <netdev+bounces-135632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D36A99E9EE
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB151C211FF
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D6322738F;
	Tue, 15 Oct 2024 12:34:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2103.outbound.protection.partner.outlook.cn [139.219.17.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEF91CEADB;
	Tue, 15 Oct 2024 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995661; cv=fail; b=lkI/EK6xIz1InjYGJJiZe+lXTaZeQdaaSGgaEXYxcKKj+U+egLNNuAMjy3Cp83L/q9kbyVBScNyk80y6b6PdOWPTbaBIxCtJcLPeIswERBiJG7Vivh8fi3GCkKeI3YhuCSKg0GmqCbZ4WsLvaKvHxdqaZdg9QeIzIjBpLKSUAq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995661; c=relaxed/simple;
	bh=iT2wgr2wM31RkT8f26iqfj2jdsdUVNCwTxf0kvAlRLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GtgQR88t77YLehDmVAp+eMtNhinmvyK2s4uwQKW+iER1ADriSp9jjDrNq6+3+ogiffai5jItOrsbPUsFkpQQfKgFLcrPcbKEjxbTBgI8MDnuuve/ZZ527i0hlwMQ4BgRlBSkDbf19cQfqc55bZtO5bUw79Vk6jKRPpuN8/Ya378=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UK43JSzZzdhYTdNvvIrIEqFcJdMyYRDiK62oNYXH2uTLr5gjhYdntzmXLNVBvm6DNKBajaKzUCBiDHLfkTrEwYRbyTSVYqqREpTAUfH0SyOo6WMYUx2n+VUVOBdcjwET0zyrkQKaD9+f/9ac9H84WBGShf0kNBLdjaI1x7RyyC3CYIimAXGxhJQc3/p7XMrYU01VOXDkm0dSbdYz6T4BEamrEZpnC4CbVU6RinR/gvrCMF1NTAmbWrrVtIsnDRhfMrmBgkvSMoXloy5ZJjDFjoEbrLfR/Z3J8ItEPMhk6Pf3FbmRjd8tlc9Dr0Xbi49HfiF2tAlFA7DsLMPPDXI0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H21ENuAQ3xhhwqJ2Csk3hLYVtlxsl1QHD1/8Vp4Qjww=;
 b=T1SdBtCQQB1+3RyU+woKxl7WPmu5JFjM2wvOXF+ZRFgGFo3+snoo7SYhTgaNu6rTnKUr0DRzBuOSJ7hypCGZYbMtCMdSMG3MYHzSHeKtzaENorIZInXRODbyXMKab2XLBzMyjzHxAzi2/SJgz8/bqsQEWD8LwPsk4vUfNc9uo/jA1s45Hw+OFm1MNCQ/m9ZSEBixgSY1iutNf+/ZtzjpKkVwF6Y+ZFQ44D/kJjFozxVtnJHIC+sg8z4tdQ+CxMfpXhU3H0zXBgq3vp4sIzPW1X6bb7k0BcWib9/7EKPW5wSeC3/0DlRU2i9BcvY3xklQLnSebr/MUOYkOKGQpnbPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1105.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Tue, 15 Oct
 2024 06:57:39 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8048.013; Tue, 15 Oct 2024 06:57:39 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmai.com
Subject: [PATCH net-next 2/4] net: stmmac: dwmac4: Fix the MTL_OP_MODE_*_MASK operation
Date: Tue, 15 Oct 2024 14:57:06 +0800
Message-ID: <20241015065708.3465151-3-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241015065708.3465151-1-leyfoon.tan@starfivetech.com>
References: <20241015065708.3465151-1-leyfoon.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB1105:EE_
X-MS-Office365-Filtering-Correlation-Id: 169e70cd-f86a-4f41-45da-08dcece6a84b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	8hCt93Dzn0qARH+yZMf1xFVPEZQfzdSB4/je7g5znUq9voyY7tFHQSF+u1rdhsQONktH8hcLqJmNfNA/gcZJbKuWwRsT8KpbPFNun4+GppHNBmSjNDueZpdSb62pVb2WF3yOOhqWsOQCGz12hYddgQk/Owx9WazLYVVTxb19qMpkAelmguIdaZ7ccOtdk6JTiFfwn9xWzJkjyA/wFC6NGKrk+f9+zkCNX5XiK/8mATyjoS7r0HNoLHvqQ/YS6KwpF8+c61InZa5WSVu9mVJnqlpfi8WVn5j6w+Dt5HWOAB+mbukd9hWFGoQWAtu4XtiT6MCsDkhaIHFUG9cPvkJLyBe7Ov6iVDOoa2Ba57Gs9vAbmr9t2YsVzUooWzRuFlJNWWbMtTU45UB70bR6jAbblX1RB7L/dsYM1ewvkaOoHS7k9VblqpZbGu47ZSbFFbKnDiIOVjQ+8p8Zc3WJeSd58kf4fpAMSkKa3JcbO/wxEOqKgldCPVt4Lqy44jpElqPcAjN7YONO3hYEZJnNHEab/ggO4zy2XAvDSMbLRVwqKtDy5dojnG8FgAryoquIeg95SKUmT2N9iEG/3V0JD/TUqbZJWcILGKaUIZoxNgyT5h2xJPWvwS2xA/2A5QrJGoNf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CQe9MP9CKByiZbEMu6KUJmGmXnONGjE1nBaFjMqYayy7LiHsTWjRXLWN+Ngm?=
 =?us-ascii?Q?MPI/sebm8ugplg5szNdP/GFTNVh2rv1TiFsxJCODXe/1/SyCmrF3eiaXL3Ye?=
 =?us-ascii?Q?SE0p2B+f0wGUqU9f7iT8A8aEQmvpyCgoHPldWfGQ+mxhcR6IZdKf4MplsSLc?=
 =?us-ascii?Q?CGifkp3IX+6S+d6LY92+s8JO8X7ca1yeL1m/mL9pmWmNPzJeXJ1BF1j7O7zB?=
 =?us-ascii?Q?1F+30uc3m81+kQ2oKC93V3xSqpcnHuw+aanZvCOZ835acJ20G777WYnefhaI?=
 =?us-ascii?Q?YLbJKR74iUDT0Mnxi4t8W0yEm2q7+e7Uek8KYRqGmWAfHyTdBCP7BkrTHFAu?=
 =?us-ascii?Q?Waln6EqM8IXNUxK6YUD1HdtF2h+8QdGHHuZpNfrhrImeXdHu08tMaybHciO4?=
 =?us-ascii?Q?qgyolkveI32YxTdhSkypLOT2j8d4ax/kZ3DnOqbbopJqpCUqQ58SWbul9VM5?=
 =?us-ascii?Q?40Vm7dwUZjkf4Drb6+MaFIN1vlpiJVTbQtRX4osqGhRTkCuj1mYhnxUfQTYU?=
 =?us-ascii?Q?e9xrzxqta/cMtuK23JhoEkcmfZekXua4NZTL7+110P3oXUN2r0jjqn+S+BXa?=
 =?us-ascii?Q?358ljOlcs+94DwZpqtyXMnrinQuvEFh1AfOuPpyNk8xeVFJQUjUAFd164rE3?=
 =?us-ascii?Q?4xEkF8H7tdiYd+J3+yDxnUGZ1BCho3A/qNiTUdgFocCUjKikLUfA/BrcEs7y?=
 =?us-ascii?Q?LUOPV9d8Yd4o+Zgc8DmdB1Hk48aF0tswCikwxAjlT18BN1VgIJ0KmZmYVpwG?=
 =?us-ascii?Q?20qcyK7mbNJUnTVHX7/4/8WOubBFFePDJR6e16yyXIa6gz0dYa32RUsqp7Yi?=
 =?us-ascii?Q?Ov0iLWE1IaU4f/cpKaj97xU8vhNH0Pb4OAXmZbdDhobtA4+zK+WC9CsS57ji?=
 =?us-ascii?Q?o+zgqo62GYM0mUPdLK67YU3RNBGD5A7Cp3e3b9PtP/iOdUQQMXAIC5Yol3zY?=
 =?us-ascii?Q?8kxMEn1C5PGpy9r2xbnyBD0ubjoUAL/Ewo0QrlgWirBNN7iLb7FmeDsF6ltZ?=
 =?us-ascii?Q?KWS9JlA8V0DsQO7zpatoyBuc7X9AklPLItGzrMsMragnwiEy++pxMllTCiXL?=
 =?us-ascii?Q?WSAYcTYadEWkwxKv1EomULsr12aUySrgQ9Jfd5He0tO+vhK7oGqBysZ25Dc9?=
 =?us-ascii?Q?mNDQCJ+BLaO8FT3+Hh40AB440Vr4DNUfF3GNlZ67hLtXXh9uwlprh3YhRWeC?=
 =?us-ascii?Q?h5aX+19JFmFTVQTos6ylnGcovYUws6WObuHi3bSGoxdupDyt0dSHNK668vLH?=
 =?us-ascii?Q?/ttAlCncl7lvl+eoG8IsvXF0NJHUJO4dVYl+eBONkhEeqhpGxmuIltgnDg4Y?=
 =?us-ascii?Q?xGJuS5mpD62B7gbCSNOyNn3J7PhkHBWkqrMi0Q8JDRQbnqPbL5sZwI5bn185?=
 =?us-ascii?Q?0F/Fic7h5zrKvbwSdk7rMVx6SK5vlupqpv+v3WZcT5I6QZwXCuKbGGtVYHkr?=
 =?us-ascii?Q?R7WedpBB2DtgsBCZiCMja7Tm5j/ZqT7ZTlDjIjItWEkkzcKnGhIIR+Pi4cJr?=
 =?us-ascii?Q?OyhYbuNY7qmBi0tgC8uDSdrPYry9LBqCdT5bdUhf2LCSQc6qK0KNBzL2Ibko?=
 =?us-ascii?Q?54vTGW24GpNdNgqtC4xu+C/TZM8xzMUHRNYYGzqA1hbJLLVcV/If12Ez3+Sl?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169e70cd-f86a-4f41-45da-08dcece6a84b
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 06:57:39.1528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7RkyocCLzikBozWyB9GN9xrqvUyJrMwFRSMo3/2glVLgR19RqVr3rX3ubupoIFvbkRkycxgG0So4SPQ5pXPISgC/gk9IktDTuVbCwwEics=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1105

In order to mask off the bits, we need to use the '~' operator to invert
all the bits of _MASK and clear them.

Fixes: 48863ce5940f ("stmmac: add DMA support for GMAC 4.xx")

Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index e0165358c4ac..4e1b1bd98f68 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -266,7 +266,7 @@ static void dwmac4_dma_rx_chan_op_mode(struct stmmac_priv *priv,
 	} else {
 		pr_debug("GMAC: disable RX SF mode (threshold %d)\n", mode);
 		mtl_rx_op &= ~MTL_OP_MODE_RSF;
-		mtl_rx_op &= MTL_OP_MODE_RTC_MASK;
+		mtl_rx_op &= ~MTL_OP_MODE_RTC_MASK;
 		if (mode <= 32)
 			mtl_rx_op |= MTL_OP_MODE_RTC_32;
 		else if (mode <= 64)
@@ -335,7 +335,7 @@ static void dwmac4_dma_tx_chan_op_mode(struct stmmac_priv *priv,
 	} else {
 		pr_debug("GMAC: disabling TX SF (threshold %d)\n", mode);
 		mtl_tx_op &= ~MTL_OP_MODE_TSF;
-		mtl_tx_op &= MTL_OP_MODE_TTC_MASK;
+		mtl_tx_op &= ~MTL_OP_MODE_TTC_MASK;
 		/* Set the transmit threshold */
 		if (mode <= 32)
 			mtl_tx_op |= MTL_OP_MODE_TTC_32;
-- 
2.34.1


