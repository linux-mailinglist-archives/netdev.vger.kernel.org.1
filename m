Return-Path: <netdev+bounces-236466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA31DC3C949
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C6824E8B93
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48152C3244;
	Thu,  6 Nov 2025 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2hzfVWN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6DF274650
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447716; cv=none; b=NPE0Ts6hfViNgAXsZsX0ZDvanCBgjvGz+o1eoqpAVPY4Vpi6FZijcLP5WgODz59vmqdajjh83wzmBBgbqdMR8n60dCrg8F8DlMCRIXzL+KwkHQ0KEsH2Hc3+qBcD7WpyNUxkdDXUtUBRD58MUYF1VvbKCCZfOJG/rp5gkIdqkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447716; c=relaxed/simple;
	bh=/4FiJ6f4TJaczdM9ytFvrqq6aZ2yS1FDznxDzKEei/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYGi8q479SQG4tjxiw6xtHVAF6nZSWL2dAOL0zkrgxWnSeIwg2YQ13FnCEc6iJfaLb5bq58gAgWVZGf/nj3RippQ8YB2U+lwisjm/74VLOTfp2buK8tqN7VQm9yqPnwwWInJcimysv95c0A2rQp6Z7r9Ux9WugAHyAKbNjNNwys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2hzfVWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE72C4CEF7;
	Thu,  6 Nov 2025 16:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762447716;
	bh=/4FiJ6f4TJaczdM9ytFvrqq6aZ2yS1FDznxDzKEei/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2hzfVWNCgssw0kO7ViuyxSePza4gd1TziiqxcEy+VihxmqregtZ0f2I5UyFVRe/l
	 BxMdDMmGR1KTotHicZSKkN2Q6DDslnC3ldcc6lRSN4fqNpmR1z3f/Fr6uQo+0By4Y5
	 oIxKVJv+w2iOmlA4fKLSBXK6J3cVeTJesy8dS+atlvbK4iKDqksmaXeywJ5H83jG4M
	 8q7gI5sFzH9BBXY0KGDF0Kh/+X1X8bt0cf1gPKAarT7qt1EG89aNSs7bWc1daJFQ0S
	 SVTrnil1nerWwq9TJ7F3N+6WbRXpRZKK2Iy3Yngbnvh2M0sjIgPAo3nH/WQGRML16L
	 3Vgtodby78kGg==
Date: Thu, 6 Nov 2025 16:48:31 +0000
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 11/11] net: stmmac: ingenic: use
 ->set_phy_intf_sel()
Message-ID: <aQzRX6qHy5Yo7T5x@horms.kernel.org>
References: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
 <E1vGvoo-0000000DWpK-47nP@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vGvoo-0000000DWpK-47nP@rmk-PC.armlinux.org.uk>

On Thu, Nov 06, 2025 at 08:58:10AM +0000, Russell King (Oracle) wrote:
> Rather than placing the phy_intf_sel() setup in the ->init() method,
> move it to the new ->set_phy_intf_sel() method.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 33 +++++++------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> index 41a2071262bc..957bc78d5a1e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> @@ -134,32 +134,21 @@ static int x2000_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
>  }
>  
> -static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
> +static int ingenic_set_phy_intf_sel(void *bsp_priv, u8 phy_intf_sel)
>  {
>  	struct ingenic_mac *mac = bsp_priv;
> -	phy_interface_t interface;
> -	int phy_intf_sel, ret;
> -
> -	if (mac->soc_info->set_mode) {
> -		interface = mac->plat_dat->phy_interface;
> -
> -		phy_intf_sel = stmmac_get_phy_intf_sel(interface);
> -		if (phy_intf_sel < 0 || phy_intf_sel >= BITS_PER_BYTE ||
> -		    ~mac->soc_info->valid_phy_intf_sel & BIT(phy_intf_sel)) {
> -			dev_err(mac->dev, "unsupported interface %s\n",
> -				phy_modes(interface));
> -			return phy_intf_sel < 0 ? phy_intf_sel : -EINVAL;
> -		}
>  
> -		dev_dbg(mac->dev, "MAC PHY control register: interface %s\n",
> -			phy_modes(interface));
> +	if (!mac->soc_info->set_mode)
> +		return 0;
>  
> -		ret = mac->soc_info->set_mode(mac, phy_intf_sel);
> -		if (ret)
> -			return ret;
> -	}
> +	if (phy_intf_sel >= BITS_PER_BYTE ||
> +	    ~mac->soc_info->valid_phy_intf_sel & BIT(phy_intf_sel))
> +		return phy_intf_sel < 0 ? phy_intf_sel : -EINVAL;

nit from Smatch: phy_intf_sel is unsigned and thus cannot be negative

> +
> +	dev_dbg(mac->dev, "MAC PHY control register: interface %s\n",
> +		phy_modes(mac->plat_dat->phy_interface));
>  
> -	return 0;
> +	return mac->soc_info->set_mode(mac, phy_intf_sel);
>  }

...

