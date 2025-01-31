Return-Path: <netdev+bounces-161761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758EDA23B94
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 10:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039ED18886B7
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795D015F330;
	Fri, 31 Jan 2025 09:46:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2574158875;
	Fri, 31 Jan 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738316810; cv=none; b=p62JpmBQqESLLS7XDDk/S1Iz3TAOsGFZArmNU8Njt3/xZYrYwm5o6CIL+2oqk7FnyVBbDtRxpHehpA6wO0BwU2LgDcxrGwu6Ye89vv4t/D/cQ4utm2KZF7jpYidDZt0YfnqHo1lCzK0eLtai0ef01crvJRSo2DgfoGTi8fV7FP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738316810; c=relaxed/simple;
	bh=KJ9DJfWDQBx2TCh//yHLOcGwjJxbAZfpoAGmSkC7bhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGGoylz2+i27Yk3vbi6Ng0GbBteMjDlm4Y+/WYPyF5aRxnII0Zq2j4pkYMUyJTHZhDMGWib4qT/30rLiTa6PToFFwimp+MaaC5id+TeSFdm4TV75+IkX0ShxI9GpGgAIRGgzI/Pn6CgIv4kvD+dd+F1ko4kztNS3BSaW2nci/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C8B8497;
	Fri, 31 Jan 2025 01:47:12 -0800 (PST)
Received: from [10.1.32.52] (e122027.cambridge.arm.com [10.1.32.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C4253F63F;
	Fri, 31 Jan 2025 01:46:43 -0800 (PST)
Message-ID: <07af1102-0fa7-45ad-bcbc-aef0295ceb63@arm.com>
Date: Fri, 31 Jan 2025 09:46:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/3] net: stmmac: Specify hardware capability value
 when FIFO size isn't specified
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Yanteng Si <si.yanteng@linux.dev>,
 Furong Xu <0x1207@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/01/2025 01:38, Kunihiko Hayashi wrote:
> When Tx/Rx FIFO size is not specified in advance, the driver checks if
> the value is zero and sets the hardware capability value in functions
> where that value is used.
> 
> Consolidate the check and settings into function stmmac_hw_init() and
> remove redundant other statements.
> 
> If FIFO size is zero and the hardware capability also doesn't have upper
> limit values, return with an error message.

This patch breaks my Firefly RK3288 board. It appears that all of the 
following are true:

 * priv->plat->rx_fifo_size == 0
 * priv->dma_cap.rx_fifo_size == 0
 * priv->plat->tx_fifo_size == 0
 * priv->dma_cap.tx_fifo_size == 0

Simply removing the "return -ENODEV" lines gets this platform working 
again (and AFAICT matches the behaviour before this patch was applied).
I'm not sure whether this points to another bug causing these to 
all be zero or if this is just an oversight. The below patch gets my 
board working:

-----8<-----
From 5097d29181f320875d29da8fc24e6d3ae44db581 Mon Sep 17 00:00:00 2001
From: Steven Price <steven.price@arm.com>
Date: Fri, 31 Jan 2025 09:32:17 +0000
Subject: [PATCH] net: stmmac: Allow zero for [tr]x_fifo_size

Commit 8865d22656b4 ("net: stmmac: Specify hardware capability value
when FIFO size isn't specified") modified the behaviour to bail out if
both the FIFO size and the hardware capability were both set to zero.
However there are platforms out there (e.g. RK3288) where this is the
case which this breaks.

Remove the error return and use the dma_cap value as is.

Fixes: 8865d22656b4 ("net: stmmac: Specify hardware capability value when FIFO size isn't specified")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d04543e5697b..41c837c91811 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7220,12 +7220,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	}
 
 	if (!priv->plat->rx_fifo_size) {
-		if (priv->dma_cap.rx_fifo_size) {
-			priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
-		} else {
-			dev_err(priv->device, "Can't specify Rx FIFO size\n");
-			return -ENODEV;
-		}
+		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
 	} else if (priv->dma_cap.rx_fifo_size &&
 		   priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
 		dev_warn(priv->device,
@@ -7234,12 +7229,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
 	}
 	if (!priv->plat->tx_fifo_size) {
-		if (priv->dma_cap.tx_fifo_size) {
-			priv->plat->tx_fifo_size = priv->dma_cap.tx_fifo_size;
-		} else {
-			dev_err(priv->device, "Can't specify Tx FIFO size\n");
-			return -ENODEV;
-		}
+		priv->plat->tx_fifo_size = priv->dma_cap.tx_fifo_size;
 	} else if (priv->dma_cap.tx_fifo_size &&
 		   priv->plat->tx_fifo_size > priv->dma_cap.tx_fifo_size) {
 		dev_warn(priv->device,
-- 
2.39.5



