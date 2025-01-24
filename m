Return-Path: <netdev+bounces-160771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5DBA1B4EF
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 12:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FAA1887141
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 11:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A442021A449;
	Fri, 24 Jan 2025 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oXR7rgeb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AC1E495;
	Fri, 24 Jan 2025 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737719059; cv=none; b=lDz2YW193YGC+JXqN3KuEIadnpbtFLFWyAA52+hgj4jgeP7JuVNOjpzph3ugPfYOLk2P0TTaQuD153nvUrTkmT5OGXWtO3UZgAUKgmBLic2NsLMpF8HEQ/iAwTEMFqE3b55C+wO7T9g2mxTgtZcQtiWNmSWKA+UoxAUiO6c/9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737719059; c=relaxed/simple;
	bh=HC0TaNVTHVmVlxclmU2K3SeJExGiqKFs43uhxqkZQZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr3RK/isLvGRyOcq9Dx38/4OQpICSiRP7SOwphjJLgVXIoRW/ANUud407yljPQBJyuvi4vpDAqhmwalEvAi8TxvNka+KFdlFYaJMH2yZR+txP3kC87K326V12zkViDY7R6OzK1O6g7Mkn265u49IMIRLSlbFNFiSOwtgxAC3KQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oXR7rgeb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OAHsYp0wTYQL8fVZ0uN4jN6ow3whTO1/nezsaF3KvFc=; b=oXR7rgebpgu4935TEydF3xSBqU
	tOJgSufLYMloBGJudXro0+qzpU4a22q0X6J0VWnmiijdjrqvktvME4ln8Nj6jv9vcMfpfb7Puae+q
	6FvU3rdisyaQ8DlOYvUh37GxC0dd2N9y8u4kPmmeU/kLNWkmL8bGe2gn6DPvexi3449IrU1wlDYQ1
	NMg35p4aL3Det4ddXikM+kwDhXCHsnpW5cQZdzzo82ZujEKfIQWHn5bHVaCPMoHGtFB1FhKLVP/Ou
	yfcGhcSrevWz7X5GVaU8ur0XMFRYzNOjq3Gw19ngbItequbBQ7e8eBnSvkeATsTA6MWxoj8JPDd0e
	6F1SPPKA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46824)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tbI6S-0002Dr-2j;
	Fri, 24 Jan 2025 11:44:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tbI6N-0006wr-0y;
	Fri, 24 Jan 2025 11:43:55 +0000
Date: Fri, 24 Jan 2025 11:43:55 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Yanteng Si <si.yanteng@linux.dev>, Furong Xu <0x1207@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] net: stmmac: Limit the number of MTL queues
 to hardware capability
Message-ID: <Z5N8-2XVAFBn1BCY@shell.armlinux.org.uk>
References: <20250124101359.2926906-1-hayashi.kunihiko@socionext.com>
 <20250124101359.2926906-2-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124101359.2926906-2-hayashi.kunihiko@socionext.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 24, 2025 at 07:13:57PM +0900, Kunihiko Hayashi wrote:
> The number of MTL queues to use is specified by the parameter
> "snps,{tx,rx}-queues-to-use" from stmmac_platform layer.
> 
> However, the maximum numbers of queues are constrained by upper limits
> determined by the capability of each hardware feature. It's appropriate
> to limit the values not to exceed the upper limit values and display
> a warning message.
> 
> This only works if the hardware capability has the upper limit values.
> 
> Fixes: d976a525c371 ("net: stmmac: multiple queues dt configuration")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7bf275f127c9..be1e6fa6d557 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7232,6 +7232,21 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>  	if (priv->dma_cap.tsoen)
>  		dev_info(priv->device, "TSO supported\n");
>  
> +	if (priv->dma_cap.number_rx_queues &&
> +	    priv->dma_cap.number_rx_queues < priv->plat->rx_queues_to_use) {

While this looks "nicer", which of these two do you think reads better
and is easier to understand:

"If priv->dma_cap.number_rx_queues is set, and
 priv->dma_cap.number_rx_queues is less than
 priv->plat->rx_queues_to_use then print a message about
 priv->plat->rx_queues_to_use exceeding priv->dma_cap.number_rx_queues"

"If priv->dma_cap.number_rx_queues is set, and
 priv->plat->rx_queues_to_use is greater than
 priv->dma_cap.number_rx_queues, then print a message about
 priv->plat->rx_queues_to_use exceeding priv->dma_cap.number_rx_queues"

With the former one has to mentally flip the test around in the if
statement to check that it does indeed match the warning that is
printed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

