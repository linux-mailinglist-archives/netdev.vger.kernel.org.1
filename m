Return-Path: <netdev+bounces-234509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 026E5C226C1
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 22:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AAD1896470
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 21:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153AE2D9496;
	Thu, 30 Oct 2025 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FQ5exwrp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F019309E;
	Thu, 30 Oct 2025 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761859976; cv=none; b=VnskQeE9xoTbOPBLnbUdKEuajbNP7HJngZQtlF0fAQvSx+dza3csYFLVqQRF1xNTa5MJymC/+dsbBovuLqSPs/4wGcHlKuFnjcNEgE5vRDRBkdehtewoEmRyNAs9UPD2er3G9ao3gjc54TfcYnDeYIQqpiH0C7gQpUqslnvxAK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761859976; c=relaxed/simple;
	bh=6iFZg16Z00OIQdSxKMvbQN1oC0YEeu711Oa6UefUkcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wbpvr+kSAR1omxkwBGuYzqzds6YK3nF1lUqQtG2e8qz5Y/hw+q3fi5xFYSzEM8Gl2dyU0S9+KW7wJm89JrDnTZGFwiPJnVEMQsalSABxU9VupWph4OC2DAH4N0iOnL/30IZ4mDB7lkJJXEhKjx8tFqWgrj6NOW+BUgrG2dwIlUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FQ5exwrp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vbEdMMd/alv82EZhs0oPuJJdyvSbCwrjtSlWnhwOMUI=; b=FQ5exwrph/BeEvhhVCtUCO2pqe
	iAck5hK/q3oIAN8VUYIHc1IpVEvI5rcN6QeW0NJyzn9xlrny4h8KQKJ3SRxHGKpwLqbjiK/9FIR9Y
	1rPE9XUw8D+fbci2VhjaEMDJP2sVgazYxVN92Z6/zI+S69Wzc3qOd+GFcDFkqSy9tRSg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEaFs-00CY1x-9Y; Thu, 30 Oct 2025 22:32:24 +0100
Date: Thu, 30 Oct 2025 22:32:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@gentoo.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: spacemit: Implement emac_set_pauseparam properly
Message-ID: <2eb5f9fc-d173-4b9e-89a3-87ad17ddd163@lunn.ch>
References: <20251030-k1-ethernet-fix-autoneg-v1-1-baa572607ccc@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-k1-ethernet-fix-autoneg-v1-1-baa572607ccc@iscas.ac.cn>

On Thu, Oct 30, 2025 at 10:31:44PM +0800, Vivian Wang wrote:
> emac_set_pauseparam (the set_pauseparam callback) didn't properly update
> phydev->advertising. Fix it by changing it to call phy_set_asym_pause.

This patch is doing a lot more than that.

Please break this patch up into smaller parts.

One obvious part you can break out is emac_get_pauseparam() reading
from hardware rather that state variables.

>  static int emac_set_pauseparam(struct net_device *dev,
>  			       struct ethtool_pauseparam *pause)
>  {
>  	struct emac_priv *priv = netdev_priv(dev);
> -	u8 fc = 0;
> +	struct phy_device *phydev = dev->phydev;
>  
> -	priv->flow_control_autoneg = pause->autoneg;
> +	if (!phydev)
> +		return -ENODEV;

I'm not sure that is the correct condition. emac_up() will fail if it
cannot find the PHY. What you need to be testing here is if the
interface is admin down, and so is not connected to the PHY. If so,
-ENETDOWN would be more appropriate.

> -	if (pause->autoneg) {
> -		emac_set_fc_autoneg(priv);
> -	} else {
> -		if (pause->tx_pause)
> -			fc |= FLOW_CTRL_TX;
> +	if (!phy_validate_pause(phydev, pause))
> +		return -EINVAL;
>  
> -		if (pause->rx_pause)
> -			fc |= FLOW_CTRL_RX;
> +	priv->flow_control_autoneg = pause->autoneg;
>  
> -		emac_set_fc(priv, fc);
> -	}
> +	phy_set_asym_pause(dev->phydev, pause->rx_pause, pause->tx_pause);

It is hard to read what this patch is doing, but there are 3 use cases.

1) general autoneg for link speed etc, and pause autoneg
2) general autoneg for link speed etc, and forced pause
3) forced link speed etc, and forced pause.

I don't see all these being handled. It gets much easier to get this
right if you make use of phylink, since phylink handles all the
business logic for you.

	Andrew

