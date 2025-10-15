Return-Path: <netdev+bounces-229661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A6BBDF8AA
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5E994E7EBA
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D622BDC13;
	Wed, 15 Oct 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6kMa/ay"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C2186E40;
	Wed, 15 Oct 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544317; cv=none; b=h7XHvhUbNksCZxZHLFfuUgUCBPJ0SjKbj/I2kq6nzt1F/dvZMcYLOz0Hf3EH35/a3FBjQCMx1jK2E1+rKo3qWx+P+5fHHe8at5Thr7GXv4YJBuc14J64/r/SHC99Xhaunh5yG3uhg7wJGIRTbYkOO78UBXgU4gEyDjF+ZXU8C9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544317; c=relaxed/simple;
	bh=Gsi0Fb9yJJuxxwo7bA+daxNM2dy6o/NwoPi7kEACJ2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFrnIKbP185j14vFmQ91Fr5Su7DvelkNtP+fKQeCMzRkpTYjt/8FFSAE/IaPTafNS4U6ROSMEH3nY9RZfSXZ/5ARvSkV1z+x0gyFg47jVfbNXME0alI1um/8PZoIR4ajKHbi2WqDvoq069qbwpm3hFNuv3W0QE+sNbs9aeElhz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6kMa/ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6BBC4CEF8;
	Wed, 15 Oct 2025 16:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544317;
	bh=Gsi0Fb9yJJuxxwo7bA+daxNM2dy6o/NwoPi7kEACJ2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6kMa/ayePxi1R4uhvRso+pLhDsSDr7/y+656DaWuAAcdzjq+77FB/unoNtlJVmHQ
	 8wrtyDoKeyyuXFgZ/mXhpgxqpRH1Jpa9MWK4k25urSaOA71bO+7Lm6Qk312TrprH8Z
	 6W8wJUA9GoIpCa9QY5A0FPn/q4VTsJyfGq4ST+11/NaftwpZA1lyWV2eJ8WTdy67jk
	 r73KZ/f7EA3uzNhojBetEkCg6mIq/K0e/uqVQc+LbEQmDhgAgo04/i3VHoLzn++4fJ
	 IS/RupSu/bj2YhAnh88z1bAWooGetsSA4ffktLsFXYoWAcyfpRxTUcFT3zide8xuZI
	 yA2udmQwI/PYA==
Date: Wed, 15 Oct 2025 17:05:12 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] net: airoha: Refactor src port
 configuration in airhoha_set_gdm2_loopback
Message-ID: <aO_GOE0jPMlcP-VR@horms.kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
 <20251015-an7583-eth-support-v1-11-064855f05923@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-an7583-eth-support-v1-11-064855f05923@kernel.org>

On Wed, Oct 15, 2025 at 09:15:11AM +0200, Lorenzo Bianconi wrote:
> AN7583 chipset relies on different definitions for source-port
> identifier used for hw offloading. In order to support hw offloading
> in AN7583 controller, refactor src port configuration in
> airhoha_set_gdm2_loopback routine and introduce get_src_port_id
> callback.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c  | 75 +++++++++++++++++++++----------
>  drivers/net/ethernet/airoha/airoha_eth.h  | 11 +++--
>  drivers/net/ethernet/airoha/airoha_regs.h |  5 +--
>  3 files changed, 60 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 5f6b5ab52e0265f7bb56b008ca653d64e04ff2d2..76c82750b3ae89a9fa81c64d3b7c3578b369480c 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1682,11 +1682,14 @@ static int airoha_dev_set_macaddr(struct net_device *dev, void *p)
>  	return 0;
>  }
>  
> -static void airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
> +static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
>  {
>  	u32 pse_port = port->id == 3 ? FE_PSE_PORT_GDM3 : FE_PSE_PORT_GDM4;
>  	struct airoha_eth *eth = port->qdma->eth;
>  	u32 chan = port->id == 3 ? 4 : 0;
> +	/* XXX: handle XSI_USB_PORT and XSI_PCE1_PORT */
> +	u32 nbq = port->id == 3 ? 4 : 0;
> +	int src_port;

I think this code could benefit for names (defines) for port ids.
It's a bit clearer in airoha_en7581_get_src_port_id(). But the
numbers seem kind of magic in this function.

>  
>  	/* Forward the traffic to the proper GDM port */
>  	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(2), pse_port);
> @@ -1709,29 +1712,23 @@ static void airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
>  	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(2));
>  	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(2));
>  
> -	if (port->id == 3) {
> -		/* FIXME: handle XSI_PCE1_PORT */
> -		airoha_fe_rmw(eth, REG_FE_WAN_PORT,
> -			      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
> -			      FIELD_PREP(WAN0_MASK, HSGMII_LAN_PCIE0_SRCPORT));
> -		airoha_fe_rmw(eth,
> -			      REG_SP_DFT_CPORT(HSGMII_LAN_PCIE0_SRCPORT >> 3),
> -			      SP_CPORT_PCIE0_MASK,
> -			      FIELD_PREP(SP_CPORT_PCIE0_MASK,
> -					 FE_PSE_PORT_CDM2));
> -	} else {
> -		/* FIXME: handle XSI_USB_PORT */
> +	src_port = eth->soc->ops.get_src_port_id(port, nbq);
> +	if (src_port < 0)
> +		return src_port;
> +
> +	airoha_fe_rmw(eth, REG_FE_WAN_PORT,
> +		      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
> +		      FIELD_PREP(WAN0_MASK, src_port));
> +	airoha_fe_rmw(eth, REG_SP_DFT_CPORT(src_port >> 3),
> +		      SP_CPORT_MASK(src_port & 0x7),
> +		      FE_PSE_PORT_CDM2 << __ffs(SP_CPORT_MASK(src_port & 0x7)));

Likewise, 3 and 0x7 a bit magical here.

> +
> +	if (port->id != 3)
>  		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6,
>  			      FC_ID_OF_SRC_PORT24_MASK,
>  			      FIELD_PREP(FC_ID_OF_SRC_PORT24_MASK, 2));

... and 2 here.

> -		airoha_fe_rmw(eth, REG_FE_WAN_PORT,
> -			      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
> -			      FIELD_PREP(WAN0_MASK, HSGMII_LAN_ETH_SRCPORT));
> -		airoha_fe_rmw(eth,
> -			      REG_SP_DFT_CPORT(HSGMII_LAN_ETH_SRCPORT >> 3),
> -			      SP_CPORT_ETH_MASK,
> -			      FIELD_PREP(SP_CPORT_ETH_MASK, FE_PSE_PORT_CDM2));
> -	}
> +
> +	return 0;
>  }

...

> @@ -3055,11 +3057,38 @@ static const char * const en7581_xsi_rsts_names[] = {
>  	"xfp-mac",
>  };
>  
> +static int airoha_en7581_get_src_port_id(struct airoha_gdm_port *port, int nbq)
> +{
> +	switch (port->id) {
> +	case 3:
> +		/* 7581 SoC supports PCIe serdes on GDM3 port */
> +		if (nbq == 4)
> +			return HSGMII_LAN_7581_PCIE0_SRCPORT;
> +		if (nbq == 5)
> +			return HSGMII_LAN_7581_PCIE1_SRCPORT;
> +		break;
> +	case 4:
> +		/* 7581 SoC supports eth and usb serdes on GDM4 port */
> +		if (!nbq)
> +			return HSGMII_LAN_7581_ETH_SRCPORT;
> +		if (nbq == 1)
> +			return HSGMII_LAN_7581_USB_SRCPORT;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}

...

