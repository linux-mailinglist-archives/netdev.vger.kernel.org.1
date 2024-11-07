Return-Path: <netdev+bounces-142662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC069BFE8F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 07:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C389284420
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 06:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C101B197A9F;
	Thu,  7 Nov 2024 06:37:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2125.outbound.protection.partner.outlook.cn [139.219.146.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0D6195B37;
	Thu,  7 Nov 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961425; cv=fail; b=noIfzzrUN8ZS2I/WcsCSTmj/bYij+vhVJ4OWt5f40Exv/MBZkBW+V7xBZsvAIz9koeAtYLr+MZfgjwRCisnzoUEDKzT7Kv9NLROZ3IvRn9Pp4k4KsDKgNk2sMwmqnFD4R/GhQbNoBsNhdb3U6xYXIWeYIdDsfu4LHtUPdVgt7+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961425; c=relaxed/simple;
	bh=TiX/6hfIvI5Rz8xzUEHjrzY+6xSXKBO6/werOAN2m9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JVi8GMO3F/2EflD/6mk6Hj1+DOmcwjWziHK3AXgYW6m3PUC91smi/XeAFbPwSYDaz3UIq2oHMCtEgzQG+KOha7QwbJpB500kzu9COTMyuiqZTY/Lx4SZjmlbCKUL3fCQKtv4L/J7FKEfhD1c1GkB7jEIuLMLMCveuAyjchZAPjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUFdKuYu2Lxa8Seu94K3B3chbnKh0reIKC6p2rtJe6Rnvtuu+jcuJH3WvWB1mn5xWnOchRDvkzyK+QCe+r4kzUGgDqf6mgfMI401Ip49YdSG9lac2eOlxgr899yuXozb5tLk8a0Pq/c50uSqrbtLHC5kk48m0JANm3Q7wP1KoRyOKB8Y4oGVZWKHxe4oKyvNyVLKafO7BEmFBxDDbi/AA1/nzmwGfbruhcsCp+dp8DJcAmNbaSqzYhuso7+kOYNrA4dAZL0PgDzeZFybjdkfqeldJdNS86/5xNYikJJNbsrEX2XjT2HicQS4CuZE9FlxuIoGg/clKueuBgAID5aRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7q650lvcqo1SL87Anl6PkbcWcCrWtX06HNbpAIc0c4I=;
 b=c1RFuZuD4iRXfINB88ATm+uEYflGhqIGQhuufaouN4b8g9OLi8P7M4uJ1r2/+XOEp25GIxkz++ADD+FwXH1YxBIwGkcvczKHG1epO3Hqda+1cAVGVpUm5Df8iy0O4hW0rMHQmKDAnxzOqaUaPRzTt0fkfFmLzRTXoPkHAoOrWzVMF/XZEcHjs1gPY6NL5wQS4ZjphdG18zBKNRd4ye2qN4+DPqL5AeSRiUTBGiOUOnPxkcrJ+NlfpPR1PzbJ6hN4Jp6FOS99oOddkk6dr6kPDsliD31JNdsIgu6+rV4lKdr2cEp4hZQS3OZyo50sVMyx0Hh+HvJyVxZ0l5ymPvtHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB0963.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Thu, 7 Nov
 2024 06:37:07 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%5])
 with mapi id 15.20.8114.023; Thu, 7 Nov 2024 06:37:07 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmail.com,
	leyfoon.tan@starfivetech.com
Subject: [PATCH net-next v3 2/3] net: stmmac: dwmac4: Fix the MTL_OP_MODE_*_MASK operation
Date: Thu,  7 Nov 2024 14:36:35 +0800
Message-ID: <20241107063637.2122726-3-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241107063637.2122726-1-leyfoon.tan@starfivetech.com>
References: <20241107063637.2122726-1-leyfoon.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::11) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB0963:EE_
X-MS-Office365-Filtering-Correlation-Id: cab00481-3834-4e65-9e54-08dcfef699a6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	sgWTqHD+t4TlvqQ94iRZlO7NILTUGTyABjWEPsLCBgKdhDUPqpgc99rNu1uGJ5ooNZEDuOKKPZXbY2JG2L7fFQLw5H1nxDq/cnWJktFK6tHU8M8hqMa9WdEvBkyC+ndHGfE/UWkyuUJkgjkC7NvwXKiIIbTIoj0Dy7C5UL/WynzvtjF19Nj6DXZlch5iQ7vlipa1jVWtEtwJR8EJw/fqssyD1PHczWO5Ls235SwALmdS4WTSwOYX5JDjuYLgiSM2RsxObs0ttL7GDRbGkF08jsl1hzGI3hbeB8hTqdYGh4PN6MH5CAh+9nFnHxfCmyJE5vJoSGQ5KmaLgEDCtLjxi5aKa7MLOmqrewzVj15/LiriNLYY8gRlz6MeUYgwEJ/lVmcC/Pyik8lny0SNmwA9aQAtl7LYT6Up5WLYDBvcmUo+e7NFsrvSF8zmPvgmC9ZQWp+vaLr3TupgpWJJB0q67eNGQIhjEpipViFrKQeO1GPwF1+GViSBkkAqk6ZTuU1g+c9Gd+RhRBNHFlVvNtFZxOcNY+p5q9x4ya/6YPwVypQWJYEutVmSvo27/rJ1SiBwGR+OwNkxKsK3ujY0ojoECicGkezjdFLnv0/3/IVXGqHgwIBTYSn6qu1w4yfGmRZy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QiS/QCRbOAA1gbwtcY8gKZkuqeEB0Z/8xzyQA48DDgj5NcOKGqgifkTzoC62?=
 =?us-ascii?Q?uFuYKBWG6/mubo+fRHMgWSMgAR6TiWYthTcwIRX1VWpvPHTS9FoQZ5Wp7OO8?=
 =?us-ascii?Q?GL/O7FGZCpJAqE9WXQbl5ZY0Q95Isv94QQimxbvfvwALuKvsX5ibont513Qu?=
 =?us-ascii?Q?v5voVRuTnS2WT9+CqVwZz6urmCSN4Itg9Rh2VFrWZ27jHPMJbluCVI11jqxc?=
 =?us-ascii?Q?Y03x7IOLH0doiQLVB8QU49PbfgE3/D5Eh5uShg+RY3C6gNvqXt3Erug411V+?=
 =?us-ascii?Q?rdzJ7o0YJt3X5MnTRj/LfS47BuggsaubdQMVWYmR9QtgOzTZqGmb8ZGzhj7/?=
 =?us-ascii?Q?wdr4G5z8xqv43PA6C0CMtKN19PD/qNRhiIHdJ77Kgd7PNm7hvPgYXi0YUxuX?=
 =?us-ascii?Q?iTlrNmuXRiOZZSevsy0K/IeGGhI6cmDch1diQELQwBdI2aWpNpkfakKiGiw5?=
 =?us-ascii?Q?0Ou1IuY5kvso8N+xESsOSVy8pzdLMOyK4YegDPh7plxrJL449ljlH9+gC3GG?=
 =?us-ascii?Q?OVy5FYm7AIlXlKlLX+dneQrumkhUwsR11xetnLhCH++WKvyD7EIzAB22u4WM?=
 =?us-ascii?Q?ofAXWuAWmn9zcBclD3QrFGKn384Eakx3VaAZtN7cYBe9TDfMtnw+Wn/BfkNF?=
 =?us-ascii?Q?YRdz7+bSCUeQfIOngRhIlbE8XPC5YTgVcUSCP9Uecka8808dF4PlElmDB63H?=
 =?us-ascii?Q?f/KukDzlRH9OAdYJC+++61bHp2YlA1lNHnHkE2GqVgcNUDpT5lpAyY/YAj2m?=
 =?us-ascii?Q?vKt9xNFmRC6GXCWSkfZqJRTQy1AldmFkObOKG2+HiJZdjRHmGjJr65lCNC6r?=
 =?us-ascii?Q?KONA/LUWCJyVjBiIsiTj+PnzqgIYTlKXZoNw/1RbXmIGoLkB68dGjm5o3qNl?=
 =?us-ascii?Q?t3M+noto0IOZHkG2Doza5FETVH2NFqzH1gpHumgMbTL5n85DVFZz1TpR5xTZ?=
 =?us-ascii?Q?88KaD6WHYnqv3yQkQc1KflfkTXTLMm0NcWbGByNZheC2DB23voZ4jyQf09Xn?=
 =?us-ascii?Q?sb/UeJX3E0H/Jn1CireQcZD8CZcfnIOjIz5qHdoj/w26HYzSKkHhbV0+LayH?=
 =?us-ascii?Q?vNSlfHJkSn5LjLhjXvaLRXOvukwywbpMRzsnut83CX2xZ8OGfTcO2EjKHyH0?=
 =?us-ascii?Q?4O9gOYPtbF2Ro5FHQQ1Ow5CKcIkV1FdTqx6ZOfTWujX4qXZS8Jj0IRJcjwIJ?=
 =?us-ascii?Q?IXQZvJIdzcAE2XUNpixBUNiGk0OUGk/9x2Y5crb8WPK/R/dKpicRq5hU2Kou?=
 =?us-ascii?Q?XIr+A3fr2Hi90Mq8iXb4zUjCO7UrV056R2zBHsLtHuyc7wIDmmudol0eVWrv?=
 =?us-ascii?Q?kwDR26kPSdXUhQuqN2shwbbfWK1/w9T4xGsbPNvaHyBwejX24a4roQVRfeeu?=
 =?us-ascii?Q?A9gFuWd+V778xPE47sMUD0lfmwPJuvCcMESw6AMpFmjcc7zlXfILk1fqnryS?=
 =?us-ascii?Q?4kDoWBabgbx5KghqxYqQmyGKz9ug4GCm8ThQWay+vQ+c7Day9E66Z+lmCn4z?=
 =?us-ascii?Q?libQDMDNDu0gybuCcsTk30LuXtj6UefTxLir96wTXaJyYoqoXnP2HuaN8tca?=
 =?us-ascii?Q?pCpO0OhHhjqvmy/Wk12lP90DtRx0t4O98EvNSPR5xPvF1NDCyjkalgM5g/QK?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab00481-3834-4e65-9e54-08dcfef699a6
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:37:07.4658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcOr+uxw/chWEsMVJ+iONrXTjz/U8k1TmEXv1SzbtFRaGC35p37FN0mdGaQxPXyokpOrdovHWsGlepwrCP7DcoI4CLQG1Wk8oJqwZnkEYHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB0963

In order to mask off the bits, we need to use the '~' operator to invert
all the bits of _MASK and clear them.

Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 22a044d93e17..0cb84a0041a4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -274,7 +274,7 @@ static void dwmac4_dma_rx_chan_op_mode(struct stmmac_priv *priv,
 	} else {
 		pr_debug("GMAC: disable RX SF mode (threshold %d)\n", mode);
 		mtl_rx_op &= ~MTL_OP_MODE_RSF;
-		mtl_rx_op &= MTL_OP_MODE_RTC_MASK;
+		mtl_rx_op &= ~MTL_OP_MODE_RTC_MASK;
 		if (mode <= 32)
 			mtl_rx_op |= MTL_OP_MODE_RTC_32;
 		else if (mode <= 64)
@@ -343,7 +343,7 @@ static void dwmac4_dma_tx_chan_op_mode(struct stmmac_priv *priv,
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


