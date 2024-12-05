Return-Path: <netdev+bounces-149481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 386119E5BFD
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90ED61887983
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4487722F393;
	Thu,  5 Dec 2024 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k2bEv9n0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376221C173;
	Thu,  5 Dec 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417015; cv=none; b=YrD+1M+4Dqjd6n81Om40LpQlYU053kxUqY+LBm396BwQ78B+16C64iwzqz94JC+SpzVpi9BghcGLB95oZ++ngONmsRiukbvwqHGURkp/1ihsL+LNZuqbgDEj4oiZ6rJ36NrGB+aLxM1X3Os01IEB240XDS9VhOmWmffXl4ntges=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417015; c=relaxed/simple;
	bh=oo5sW+MW4nkHExsWS/lMBTBrFs2o2QlXjU+7m1FUQTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCyiozfE5Q/9Kj9nLeKAsJiC8TDhRkmi03xEzwUWZLSLLbAHV9GFSCEcx5sUtNU/LtG0JazsXikTo9H9yzm6fsf2+1G6rySrTTjm/02JX/cXW92xWzV8Aw7ACPlkzLdIaAr6w1j4Ft+FLECbfFMjhEt9BwXGzEL1p7nAhUehsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=k2bEv9n0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CmjyrvnpPNwpDiDIROM0xyv/tcPaPUlc2In2NJ5co5A=; b=k2bEv9n0wBPLIU78/F7g50Cx7r
	DBz85Y5fCgDKwAyLK6vSnWPRCpXkoUpGyUaHcL6LuL8xzRyRfuVpK4N/+sKHFjSKqk6qWQCNXljoR
	2xsIEf/Jzc1FH3pCakKQNs73Qe6AQfrN4rBJgMaotnItza+9NFH0JAjMj6IJ/oMsP8icEuDya8scq
	f8mFp/C97A3LReoe4eKXw+cZndWAYVcF+YlNj/WTbRGApvrSReVBcgzgsM1O1jg871QjfBQNy67lh
	TGLLlEZsmkX/OdfpGATOOW6UEfH/a9yU/OnV14nJ1F98mR/DUPmX8XAfFZMv6iEFkx+lpr08V20tz
	M2+MPcwQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59112)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJEwo-00059f-1H;
	Thu, 05 Dec 2024 16:43:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJEwk-0006hf-2W;
	Thu, 05 Dec 2024 16:43:22 +0000
Date: Thu, 5 Dec 2024 16:43:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unaligned DMA unmap for
 non-paged SKB data
Message-ID: <Z1HYKh9eCwkYGlrA@shell.armlinux.org.uk>
References: <20241205091830.3719609-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205091830.3719609-1-0x1207@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

I'm slightly disappointed to have my patch turned into a commit under
someone else's authorship before I've had a chance to do that myself.
Next time I won't send a patch out until I've done that.

On Thu, Dec 05, 2024 at 05:18:30PM +0800, Furong Xu wrote:
> Commit 66600fac7a98 ("net: stmmac: TSO: Fix unbalanced DMA map/unmap for
> non-paged SKB data") assigns a wrong DMA buffer address that is added an
> offset of proto_hdr_len to tx_q->tx_skbuff_dma[entry].buf on a certain
> platform that the DMA AXI address width is configured to 40-bit/48-bit,
> stmmac_tx_clean() will try to unmap this illegal DMA buffer address
> and many crashes are reported: [1] [2].

This should mention that the DMA mapping API requires the cookie that is
returned from dma_map_single() be passed in unaltered to
dma_unmap_single(), and this driver does not do that when the DMA
address width is greater than 32-bit.

> 
> This patch guarantees that DMA address is passed to stmmac_tx_clean()
> unmodified and without offset.
> 
> [1] https://lore.kernel.org/all/d8112193-0386-4e14-b516-37c2d838171a@nvidia.com/
> [2] https://lore.kernel.org/all/klkzp5yn5kq5efgtrow6wbvnc46bcqfxs65nz3qy77ujr5turc@bwwhelz2l4dw/
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>

Please use rmk+kernel@armlinux.org.uk there.

> Fixes: 66600fac7a98 ("net: stmmac: TSO: Fix unbalanced DMA map/unmap for non-paged SKB data")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9b262cdad60b..7227f8428b5e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4192,8 +4192,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct stmmac_txq_stats *txq_stats;
>  	struct stmmac_tx_queue *tx_q;
>  	u32 pay_len, mss, queue;
> +	dma_addr_t tso_hdr, des;
>  	u8 proto_hdr_len, hdr;
> -	dma_addr_t des;
>  	bool set_ic;
>  	int i;
>  
> @@ -4279,6 +4279,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  			     DMA_TO_DEVICE);
>  	if (dma_mapping_error(priv->device, des))
>  		goto dma_map_err;
> +	tso_hdr = des;
>  
>  	if (priv->dma_cap.addr64 <= 32) {
>  		first->des0 = cpu_to_le32(des);
> @@ -4310,7 +4311,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  	 * this DMA buffer right after the DMA engine completely finishes the
>  	 * full buffer transmission.
>  	 */
> -	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
> +	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = tso_hdr;
>  	tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_headlen(skb);
>  	tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
>  	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
> -- 
> 2.34.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

