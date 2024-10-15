Return-Path: <netdev+bounces-135442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0904999DF4C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D901C20FEF
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F9C18BC13;
	Tue, 15 Oct 2024 07:30:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB369474;
	Tue, 15 Oct 2024 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728977399; cv=fail; b=U5eDc9aag5gZo8GXRKDKvFGrl6ppedNd0YFal2BbP41q9p80v5SNrqngZ1tpio/ufrDUGQL2i2QCz5Ag7mPoKhrH54vn4Od9ul9drsMUqLFlxxPzLOXeQlh04rozV/Nd1GWyRQTZiXDIL+S2XCgl8Fbsysham5h1evni8z+v/rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728977399; c=relaxed/simple;
	bh=XCLPmR0Le7fiiSbIqWvfFshIc15qkSSlQhSOMR74F4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PHYbk13BkXW8Zf+gEOkxSo35jMPjxHlekrZY4DKwObBjTlkhT0je+DZ1jzSg4eYAqy5fcwKLr1TKXDhcR+ae754CA3MRmEhENXtbQXRmTqWLyuXqjdKU5yCjY6e4KQXAIL6gbVGJ6sBZDmGlQt5YDarDmk5sPsxtAN7f5dErzkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMzZ4zfJoUmjI1WA39IFKga8wwOUGw7pE5gyJxVGDfFWqBE5+1mavK7mAinqpH8LB6XN1VwJ5XvVhpJaq/3mELUxF2vh9pczNppy2YfZvIVjynZSNxOZUdCfIl1nxj6qNwT3l9sxzu2P/zNDeQeYRaCTKEcSY8mXBPgY7uvS8amt6BeQFvRQCbC9euMq+LwkPobMs4vso55r8Yjil/Cbx6R/MeQUFgrhfpEJgazpNSVzYmWkxX59xeYPb0FDPRvWmukQkCK8dA0YJ3Pbivcl7rMqbIJ4w2ExByav3e2VUvGXDlDmqd8oK0L5AFuHdJC3Bfrfnuc6Pc2pl8dgDbbomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iu4UJegdTlMh3TpMhAjavI1nxDebeKR67mjS+Twfsb8=;
 b=BQUmdV+tk++ipUyj4ylLzWMKn3j5W6g9x1AuUUNuEoZsQ+/DDELPZKKqF61gKpripi1qXlYhNZpeasJncwkyAIozY3W04VwUM/TCPfRm4njjsStTUHK9qSTIxHWUfQqLM8fOKn/CJyMYjAigR9psJbgZazRcD2qxnhBuEJ6Ltm6u+GZ5i02yiu/t5nITWQHONBQAZwcYYMUIHOMu+bzZwVBRQuBY4fAybfbPUjMmQbM8pDLNI/CLVwbZVbVIVYJ2x2qtERTl2f+6KvLZEAV+9QnHddNu5z/Ko4jR+s313bMN7xhqwN08cqsaQxyGyUDQ+dKv8krgX34Wf1aXEwrfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1105.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Tue, 15 Oct
 2024 06:57:40 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8048.013; Tue, 15 Oct 2024 06:57:40 +0000
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
Subject: [PATCH net-next 3/4] net: stmmac: dwmac4: Receive Watchdog Timeout is not in abnormal interrupt summary
Date: Tue, 15 Oct 2024 14:57:07 +0800
Message-ID: <20241015065708.3465151-4-leyfoon.tan@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: f3daca27-bfe6-4589-dd2f-08dcece6a94b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	xIMPSviKF9HNbxbamtLmJSRt9jsa2U2uOW/sK62vMkIjhdbeqtxYS7PzxQGc1Vv4bCW2jYJIXKdeCjq3D3XspjVLW8jz+NcatI8bPZQkovSJ54GGpYw4k/13hF2SciOkSarotJy3EZOxiY0Egyvi6FnqmZQvWpGiVkbph6HTAkwn5Vh4zSBm+fXM8W4Z+swDDGVC/Z9zvS3A36kch8O1la5KGvYgRAjZyNFOUt3Y8+llKXkKmSSswLKyJJxYlbKq9tB6ZgX8bdftnbVSCpucdbyaWt0z1ysyri/u75KEjxoKwb5f9MVJVzZYga/AdKIJJ04UprNaNlfubDFuKrwyGe3a/r4OADZ7Eig10M2BA0iaDaquCrmbpVLtQmD8d3zqEs269VCYNSjTIDPGxwI4e/oDnTXt9bbrWYdBNSrXqNQlK/Ne2oyChOwBmtP957Ee1UqRJHsDPYdZxUB/gZhrNyLytdQZOvKY6qFzB7ccHhvIog7CiotjRyEqTdpbenx56QR8A5YXmcoGkIB/+TPVgm0GhlQ2uaal6/CRPyGjo6QSMNhvJQEC1FpmvSGdwlHf9MQtWjon7jJL1fJ+0INPjbC4Rh/fszjIbdpLDB7/BsElPMaBLmB5wpgHXAZXWdQ7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eo/qWIIChfDkyDxwUwUUM83xnzj8qlcVaZ8s5mLNlD0UeeA4vMBrJqlfd71/?=
 =?us-ascii?Q?JUajw+zUgVJWTVD+ncCbQZvXyC2+gke14dGlCAFlIEOi0ro1hBOINK/sifz8?=
 =?us-ascii?Q?HLeLmVlJ0b/e5dNtllD/Nd1L7dM0KkMfWEOeAhTe9CycqJWpEQvNjdPKxeJL?=
 =?us-ascii?Q?FCNFpcGA0ZBsOeoO+shmINcPw6yJhezPPiAYsTrRQbEnUsRkRCn3btf5/0Eh?=
 =?us-ascii?Q?/9eP2ViSoZ6MZeHDB7f1nQdNwfPwJzIPiFGMg4UrT9N7Nnj/RpdX9/JT2QV0?=
 =?us-ascii?Q?ZJ9GMaiAh0h198iDS7viSWW0D5reIi9lkmMOa/PnNd+Ux3kzmCRW06mz5gr0?=
 =?us-ascii?Q?wzVYO8GdX6wSgx5v76j88gv2ZypaviwFeKAZgVDvR1JXuyXlOZ60dMqK8L8B?=
 =?us-ascii?Q?UWt1sv+koK5mMuZKdXhih5PnOW0g/DXRcE2SxJltXWMVAzSOufoM4iIfMk1y?=
 =?us-ascii?Q?m3cD0hM7/IjOOtatSYGaorpOl+YgR3h6ImhkP8Eks9M7OUuRqnWuaz9/2XIa?=
 =?us-ascii?Q?ywfdKAPBb9P4v7edJ2LPGpLgYG8kJquMkIpk7ss90YVq3Uws0dXJG2EnBarp?=
 =?us-ascii?Q?Un4mPkAYBN+oUEoHjXvxbmFE+qXniSx/RVp5BNkUrgR4LDrm8b6lgv7E+H+z?=
 =?us-ascii?Q?B6QFrNEpZKdkMqtSx63HmoFyonSpwqEzVIZMmxSHm5e4LNDM3o53pwOGfyn5?=
 =?us-ascii?Q?3gcP1ywtJ/UHGb9ZFsNAX4rtGad7sPMwvLh/5bfcKJMsc4NZTPtRFN8GilOb?=
 =?us-ascii?Q?PdPdYHoXHGxmrD/63PiStZ7GvIBD6yJTogN+BpPu8Rv/qLoeMd8jkQQ0mDDA?=
 =?us-ascii?Q?A4tQzsyaiK1Ark7c6gEeh63ZUj15xl3lKVBTcZ94/Qx6Ix9CLdTkTbCDPa99?=
 =?us-ascii?Q?50mvzm/yfHGszRIngUAR4iJ9YV209FOQ2A+p+MDse1HNtkvaPOGT1GGfRSgr?=
 =?us-ascii?Q?6xhMVeR7Kw7bWcybEoVfHnPBKqDXlpMa1WOWpzKy7CGCDFP1PyXhz1kQzAP/?=
 =?us-ascii?Q?oAMSPIOnljGxlC1Km69BbQyASux0J6zYMce9Rg1gBfVLMsPjoiezqo5cS2g2?=
 =?us-ascii?Q?d6Oii6/IYrFJJO/yejo3ExqR5VQy1fkTSe/qyTg0PzRggf4n91hG6DQhbrI3?=
 =?us-ascii?Q?kQVaUQXoZAGJdCEhXFBaaEa06QtTjdCt5Y8s8wB9xDw+UqWTUW705iC7li+1?=
 =?us-ascii?Q?XpVCMn/5bEQVCVp9+05u5A5Gyux2oj7GLvaG1UwUxQW7saGD5hxqEgNHLmzN?=
 =?us-ascii?Q?niNSjaGxqgFMsc8p1zbNgZbWZvVM/k6tlYgH7POqiDvUTlbWWuccG2eu0Sqp?=
 =?us-ascii?Q?8x4OIPvNTmsg/PTj36p4J0/nwy/lAQev/D7ZSyOfcVQG8BQjVVyvrza/W4+/?=
 =?us-ascii?Q?fSkmfXoNfd2dJrAfDvTK1+R7wrYQ+m8zDnf+rrpE5WHacHSTFZhtzijz8cC5?=
 =?us-ascii?Q?TVdLSp2Feba6dAgnKH7qNmKWukV2M6PsYMei/wJt1a6o96Y+Ncz3FqV4NQvF?=
 =?us-ascii?Q?CGGv2YZaQ6HHphEjMlFkDP/u2cC2VHFxjzI5rg0dczaa/+GXo6SkE0e/ieQr?=
 =?us-ascii?Q?uLAgDfQe8CYf0an8oTlJHIqd9ozir2NkJZdgiW8JAtBS/ZM0SkH8THlIl/zo?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3daca27-bfe6-4589-dd2f-08dcece6a94b
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 06:57:40.8337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnfijXcxy+QyJ9YzrA+MmFdt0H5ZJY8lTOY2epTd9Pi1G9KV3mGDXB4c3aIPhOPCzmTmQZb59nTaYx6TLEjbDQNKZgU9k4uLa05cu/52LSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1105

The Receive Watchdog Timeout (RWT, bit[9]) is not part of Abnormal
Interrupt Summary (AIS). Move the RWT handling out of the AIS
condition statement.

From databook, the AIS is the logical OR of the following interrupt bits:

- Bit 1: Transmit Process Stopped
- Bit 7: Receive Buffer Unavailable
- Bit 8: Receive Process Stopped
- Bit 10: Early Transmit Interrupt
- Bit 12: Fatal Bus Error
- Bit 13: Context Descriptor Error

Fixes: 48863ce5940f ("stmmac: add DMA support for GMAC 4.xx")

Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 0d185e54eb7e..57c03d491774 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -185,8 +185,6 @@ int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			x->rx_buf_unav_irq++;
 		if (unlikely(intr_status & DMA_CHAN_STATUS_RPS))
 			x->rx_process_stopped_irq++;
-		if (unlikely(intr_status & DMA_CHAN_STATUS_RWT))
-			x->rx_watchdog_irq++;
 		if (unlikely(intr_status & DMA_CHAN_STATUS_ETI))
 			x->tx_early_irq++;
 		if (unlikely(intr_status & DMA_CHAN_STATUS_TPS)) {
@@ -198,6 +196,10 @@ int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			ret = tx_hard_error;
 		}
 	}
+
+	if (unlikely(intr_status & DMA_CHAN_STATUS_RWT))
+		x->rx_watchdog_irq++;
+
 	/* TX/RX NORMAL interrupts */
 	if (likely(intr_status & DMA_CHAN_STATUS_RI)) {
 		u64_stats_update_begin(&stats->syncp);
-- 
2.34.1


