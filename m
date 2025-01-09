Return-Path: <netdev+bounces-156813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9908FA07E43
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E453A455A
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D77A1779AE;
	Thu,  9 Jan 2025 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBBk8lNa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F59273F9
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736442151; cv=none; b=ozKPmVA1b14fsazsHaoTzQZSYZegj80ZQQoz5k/2qq8Wvf7J1sOgjaU7Y2t3b6g2k6gHdBXuZ+VHoQCdtR6wFcPalZGXmWjDjcYXo7hCPJETB/aidVKMPd/4KYWyIvv1b+T2ubITp7uxshfwmTyyEBuiyes+5glY4VZB3FXzfvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736442151; c=relaxed/simple;
	bh=Fg3vYZyTO2Fw+Xxth4e/W3NjOlbC7sP2c8f+MJ5K2ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5ut4K/9Rbb1j7WRdienYH1UczzMVulj68rJDrWM5+z8b8I5H9hhgX9W+uqKbf6T+MhUYatHw+NDov+jgAtREp4lekE4FgfJNEJnZ4e4bBzZ/L1FdsRtM4hW5cv8oNGmecnINvfI4XIBbW9OIopFw+mNCz6uEG8G6j+TQClPph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBBk8lNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486B8C4CED2;
	Thu,  9 Jan 2025 17:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736442150;
	bh=Fg3vYZyTO2Fw+Xxth4e/W3NjOlbC7sP2c8f+MJ5K2ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBBk8lNaYerCF5M/6HUJQLFK2H9nv6ugX8pIQ6ULhnqMjYY5l0Hf6pGBJy8rTdnuc
	 1BL4mOfvX3nXoqhvpIrNBoH9Go1oDuuJo1BcKi4Ixl/rO0juAZFlWI4VL85zYV6hRy
	 1KOMj/ZB8WePQqQEdZ39UXHlvH5peHLFEYWxb9hSQovRvYAX04XdvZHKAeEOCr+8kF
	 5/4+5X6Bx2vHP4c85w7jb2FgadOGQTZQODLBHmk57Ju83dInKsMEOBSdvtNP6Ka4CZ
	 2kaF8OrF0NQo/SSUGcU47UcCex5CyYUF8oksXuetOpos5aAPdPuRfcNvQEBpMPBl0U
	 ZGbUvG8aumS4Q==
Date: Thu, 9 Jan 2025 17:02:22 +0000
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Golle <daniel@makrotopia.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>, kernel-team@meta.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: Re: [PATCH net-next 1/5] net: phylink: use pcs_neg_mode in
 phylink_mac_pcs_get_state()
Message-ID: <20250109170222.GM7706@kernel.org>
References: <Z3_n_5BXkxQR4zEG@shell.armlinux.org.uk>
 <E1tVuFh-000BXQ-D7@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tVuFh-000BXQ-D7@rmk-PC.armlinux.org.uk>

On Thu, Jan 09, 2025 at 03:15:17PM +0000, Russell King (Oracle) wrote:
> As in-band AN no longer just depends on MLO_AN_INBAND + Autoneg bit,
> we need to take account of the pcs_neg_mode when deciding how to
> initialise the speed, duplex and pause state members before calling
> into the .pcs_neg_mode() method. Add this.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phylink.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 31754d5fd659..d08cdbbbbc1e 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1492,12 +1492,24 @@ static int phylink_change_inband_advert(struct phylink *pl)
>  static void phylink_mac_pcs_get_state(struct phylink *pl,
>  				      struct phylink_link_state *state)
>  {
> +	struct phylink_pcs *pcs;
> +	bool autoneg;
> +
>  	linkmode_copy(state->advertising, pl->link_config.advertising);
>  	linkmode_zero(state->lp_advertising);
>  	state->interface = pl->link_config.interface;
>  	state->rate_matching = pl->link_config.rate_matching;
> -	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> -			      state->advertising)) {
> +	state->an_complete = 0;
> +	state->link = 1;
> +
> +	pcs = pl->pcs;
> +	if (pcs->neg_mode)
> +		autoneg = pl->pcs_neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED;
> +	else
> +		autoneg = linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> +					    state->advertising);
> +
> +	if (autoneg) {
>  		state->speed = SPEED_UNKNOWN;
>  		state->duplex = DUPLEX_UNKNOWN;
>  		state->pause = MLO_PAUSE_NONE;
> @@ -1506,11 +1518,9 @@ static void phylink_mac_pcs_get_state(struct phylink *pl,
>  		state->duplex = pl->link_config.duplex;
>  		state->pause = pl->link_config.pause;
>  	}
> -	state->an_complete = 0;
> -	state->link = 1;
>  
> -	if (pl->pcs)
> -		pl->pcs->ops->pcs_get_state(pl->pcs, state);
> +	if (pcs)
> +		pcs->ops->pcs_get_state(pcs, state);
>  	else
>  		state->link = 0;

Hi Russell,

Here it is assumed that pcs may be NULL.
But it is dereferenced unconditionally immediately
after it is assigned above.

This seems inconsistent.

Flagged by Smatch.

>  }
> -- 
> 2.30.2
> 
> 

