Return-Path: <netdev+bounces-158452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA787A11EE0
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871A5188E20F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39CB2419F8;
	Wed, 15 Jan 2025 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utKsiDnp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA15C2419F2;
	Wed, 15 Jan 2025 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935462; cv=none; b=So9CveQaU/7yLvBKn9ap4iLnlU9fF4pfVjJfcQNZPH/N08uSAP0dPJuSKec31NfzrqgsYazotDAveTLoJuKf2IYyMlH/yWSNJNzoDz8njtNo08nO1HigNgbdm+abCTgcD4LlFkF8eapTTisJwIVlMwCcvyaissa8OGbtCGHr3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935462; c=relaxed/simple;
	bh=l5K1+6MX4+1I0AzQ9JSMUBIwyktKaJGh7IQj7QRRbu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNzY0+UegFxKNOKbF14G7LTVRi50xnDwD6E4juyW+5I9QRWTDUVwcz38P6LF5U5D5wBy1JzRppCNLzqd40Ko6px2zxebmn/Jrjg7xJKMWV3iCVE7whA20hsdqYU9JNi1L1g2wHRpYnCLJ8s2NSvxNmaNYNve/zWlwBvK7/wSZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utKsiDnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA45C4CEE8;
	Wed, 15 Jan 2025 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736935462;
	bh=l5K1+6MX4+1I0AzQ9JSMUBIwyktKaJGh7IQj7QRRbu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=utKsiDnpGZ/s/TmKp/OPQN5wV5Alm98n7DTUk0UeCLsbZCvFluBlTsjDtaT61xHM4
	 bMQYwp/Dc+BNrRsi5Se2Bgr3tzul6W3XHpAnD/hO9mH8O32HPKjK9uf0mfNYTr78aC
	 q1suoZahyZyVvow8sWObC/AB8F+wjfna8uBRG6pNmEGI1PlXO94MWiGqjGv22WUPA2
	 AWw9apq1UkIJ9UAOdJKede27R+Jlh9WUvNM68abw5XZ++6NMeCYODNb7DxNXt9xXot
	 mP2eX1UPjwVBppUG77KAJ2dqcMr7t4hECP3N1ceuVUrT8GAA/CS+AT3YKKOptd+6Ez
	 tGPsuL4hjR1FA==
Message-ID: <8776a109-22c3-4c1e-a6a1-7bb0a4c70b06@kernel.org>
Date: Wed, 15 Jan 2025 12:04:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: fix freeing IRQ in
 am65_cpsw_nuss_remove_tx_chns()
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>, srk@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org>
 <gygqjjyso3p4qgam4fpjdkqidj2lhxldkmaopqg32bw3g4ktpj@43tmtsdexkqv>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <gygqjjyso3p4qgam4fpjdkqidj2lhxldkmaopqg32bw3g4ktpj@43tmtsdexkqv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Siddharth,

On 15/01/2025 07:18, Siddharth Vadapalli wrote:
> On Tue, Jan 14, 2025 at 06:44:02PM +0200, Roger Quadros wrote:
> 
> Hello Roger,
> 
>> When getting the IRQ we use k3_udma_glue_rx_get_irq() which returns
> 
> You probably meant "k3_udma_glue_tx_get_irq()" instead? It is used to
> assign tx_chn->irq within am65_cpsw_nuss_init_tx_chns() as follows:

Yes I meant tx instead of rx.

> 
> 		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
> 
> Additionally, following the above section we have:
> 
> 		if (tx_chn->irq < 0) {
> 			dev_err(dev, "Failed to get tx dma irq %d\n",
> 				tx_chn->irq);
> 			ret = tx_chn->irq;
> 			goto err;
> 		}
> 
> Could you please provide details on the code-path which will lead to a
> negative "tx_chn->irq" within "am65_cpsw_nuss_remove_tx_chns()"?
> 
> There seem to be two callers of am65_cpsw_nuss_remove_tx_chns(), namely:
> 1. am65_cpsw_nuss_update_tx_rx_chns()
> 2. am65_cpsw_nuss_suspend()
> Since both of them seem to invoke am65_cpsw_nuss_remove_tx_chns() only
> in the case where am65_cpsw_nuss_init_tx_chns() *did not* error out, it
> appears to me that "tx_chn->irq" will never be negative within
> am65_cpsw_nuss_remove_tx_chns()
> 
> Please let me know if I have overlooked something.

The issue is with am65_cpsw_nuss_update_tx_rx_chns(). It can be called
repeatedly (by user changing number of TX queues) even if previous call
to am65_cpsw_nuss_init_tx_chns() failed.

Please try the below patch to simulate the error condition.

Then do the following
- bring down all network interfaces
- change num TX queues to 2. IRQ for 2nd channel fails.
- change num TX queues to 3. Now we try to free an invalid IRQ and we see warning.

Also I think it is good practice to code for set value than to code
for existing code paths as they can change in the future.

--test patch starts--

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 36c29d3db329..c22cadaaf3d3 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -155,7 +155,7 @@
 			 NETIF_MSG_IFUP	| NETIF_MSG_PROBE | NETIF_MSG_IFDOWN | \
 			 NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
 
-#define AM65_CPSW_DEFAULT_TX_CHNS	8
+#define AM65_CPSW_DEFAULT_TX_CHNS	1
 #define AM65_CPSW_DEFAULT_RX_CHN_FLOWS	1
 
 /* CPPI streaming packet interface */
@@ -2346,7 +2348,10 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
 		tx_chn->dsize_log2 = __fls(hdesc_size_out);
 		WARN_ON(hdesc_size_out != (1 << tx_chn->dsize_log2));
 
-		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
+		if (i == 1)
+			tx_chn->irq = -ENODEV;
+		else
+			tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
 		if (tx_chn->irq < 0) {
 			dev_err(dev, "Failed to get tx dma irq %d\n",
 				tx_chn->irq);

--
cheers,
-roger

