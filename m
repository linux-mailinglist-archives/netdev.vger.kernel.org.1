Return-Path: <netdev+bounces-162042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FD8A25715
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 11:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A581669F9
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB73201011;
	Mon,  3 Feb 2025 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nCpBsD3E"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EB638F83;
	Mon,  3 Feb 2025 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738579112; cv=none; b=C4ZaPA3MbiQ08c4abNUMURjfgH/jTirJaMSZ14+QaHJt3giw33aQ3DoW2XsGjTmYPbyfR0UC7wA5yiSaVHbPuj/Tfkhs1S/30GOGfM8u8964l73POEHbiL7+0HQlRjnLKwfqVvwZrAKdCEBpq9shGU5MTj+8MLzvEmWsJvlGxVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738579112; c=relaxed/simple;
	bh=82Y0gWeSsPmrX/KOG4kzjHv2W9GEd84plT7fpWS8mRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+jH8ZpnkvnhIToGT80JaRcb13eYC9dlSD6Qi++ovlXZHpi6I2Azcfl+U5VLG/UOvMtkxhXSbS8CxbzJBpY5UGGqiap4h/q5B5Z3JR1SYG5qGwvqYXfdE4XpeNcdfh/41NSD5KWlmfqoPjTEWbgPphaaTcIQ8kubjKZh8W2KRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nCpBsD3E; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j7v8B5fuLOyvPnE4F8xYonpHQmsOiXgCq2SRnIU+w8s=; b=nCpBsD3EHXJbS6gCHh0n8jBA+V
	bVSEjDPTWHFg73BKqz+RvYvf+t2x9qjPE6p6EKUZFYgCQRGAFBViMN4eN8btr5AcYZbB9hcdEqgtT
	T0vmFCauZEeXs2NPccXqd7q0JGLDj3PScZlXKOUSJFhS+WZn8XgaKh+fb/sXuRDKi+tC1sDRNTlZ8
	hiauULcVJ9BtyaIlBfdrW9kYBY1v2goRLxjIVksrxiOEWdqAmUfF/IbF3H+fF4JXCN1Kn3T9vUQnq
	lDqHKadfnhJ1oqX1QwCFm7s11WAofC8USnw00wQZWnHCmt6ifAkCo5oe3RlhWxHehqWKN/ugV+Kts
	pNIYkEvg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33290)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tetqI-0008Fh-2Y;
	Mon, 03 Feb 2025 10:38:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tetqC-0000IW-15;
	Mon, 03 Feb 2025 10:38:08 +0000
Date: Mon, 3 Feb 2025 10:38:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Steven Price <steven.price@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Furong Xu <0x1207@gmail.com>, Petr Tesarik <petr@tesarici.cz>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yanteng Si <si.yanteng@linux.dev>, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH] net: stmmac: Allow zero for [tr]x_fifo_size
Message-ID: <Z6CckJtOo-vMrGWy@shell.armlinux.org.uk>
References: <20250203093419.25804-1-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203093419.25804-1-steven.price@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 03, 2025 at 09:34:18AM +0000, Steven Price wrote:
> Commit 8865d22656b4 ("net: stmmac: Specify hardware capability value
> when FIFO size isn't specified") modified the behaviour to bail out if
> both the FIFO size and the hardware capability were both set to zero.
> However devices where has_gmac4 and has_xgmac are both false don't use
> the fifo size and that commit breaks platforms for which these values
> were zero.
> 
> Only warn and error out when (has_gmac4 || has_xgmac) where the values
> are used and zero would cause problems, otherwise continue with the zero
> values.
> 
> Fixes: 8865d22656b4 ("net: stmmac: Specify hardware capability value when FIFO size isn't specified")
> Tested-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Steven Price <steven.price@arm.com>

I'm still of the opinion that the original patch set was wrong, and
I was thinking at the time that it should _not_ have been submitted
for the "net" tree (it wasn't fixing a bug afaics, and was a risky
change.)

Yes, we had multiple places where we have code like:

        int rxfifosz = priv->plat->rx_fifo_size;
        int txfifosz = priv->plat->tx_fifo_size;

        if (rxfifosz == 0)
                rxfifosz = priv->dma_cap.rx_fifo_size;
        if (txfifosz == 0)
                txfifosz = priv->dma_cap.tx_fifo_size;

        /* Split up the shared Tx/Rx FIFO memory on DW QoS Eth and DW XGMAC */
        if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
                rxfifosz /= rx_channels_count;
                txfifosz /= tx_channels_count;
        }

and this is passed to stmmac_dma_rx_mode() and stmmac_dma_tx_mode().

We also have it in the stmmac_change_mtu() path for the transmit side,
which ensures that the MTU value is not larger than the transmit FIFO
size (which is going to fail as it's always done before or after the
original patch set, and whether or not your patch is applied.)

Now, as for the stmmac_dma_[tr]x_mode(), these are method functions
calling into the DMA code. dwmac4, dwmac1000, dwxgmac2, dwmac100 and
sun8i implement methods for this.

Of these, dwmac4, dwxgmac2 makes use of the value passed into
stmmac_dma_[tr]x_mode() - both of which initialise dma.[tr]x_fifo_size.
dwmac1000, dwmac100 and sun8i do not make use of it.

So, going back to the original patch series, I still question the value
of the changes there - and with your patch, it makes their value even
less because the justification seemed to be to ensure that
priv->plat->[tr]x_fifo_size contained a sensible value. With your patch
we're going back to a situation where we allow these to effectively be
"unset" or zero.

I'll ask the question straight out - with your patch applied, what is
the value of the original four patch series that caused the breakage?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

