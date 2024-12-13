Return-Path: <netdev+bounces-151678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4533F9F0906
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0638A2831F0
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AE91ADFFB;
	Fri, 13 Dec 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP7W7/Jo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7C1420A8
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734084260; cv=none; b=VQICaIhB1gThlWpDVsrn8Rj+1iVlaxtJegN+g+L+UDfvBTZkfxPhf+6Qc0zjqKdD9tGYtkjs24Y+kN7CaNe3E7REhNWB1GRQ+Tzjzu9fFURndw9ZhV8OtJQqYEBPT9XLMItQr2pS7hRlj1dDi3p3nA2mtHqeCcqmKFo5bmIn5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734084260; c=relaxed/simple;
	bh=Y0skDPJ1ZlCP2BH0lnu8m48vD9FGe3eWAVO8gdY0mVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Brmo7IJbtkEo6l8AIQmhlHpLGSH5C+2q/VV74vyCI5X5av5/UkR6Kzm5KqhiBOP1C7wxPsvyEdhUmO+jF6y7NexHBM7XT7OxCWCJfg6s/wFIrWGhJCaoZDj+Q2k5okpnQmNmZchlsitzLrdj9aF7dGAxuDyw//Cc4NiPIUyYp5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP7W7/Jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3C7C4CED0;
	Fri, 13 Dec 2024 10:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734084260;
	bh=Y0skDPJ1ZlCP2BH0lnu8m48vD9FGe3eWAVO8gdY0mVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PP7W7/JoSSH5CrEqI6MgPCqZ9h0QyWPn6xaOt2KVSsMvx32CKxqP6bMVMS+8C2mAS
	 sINK2t8c9TedEdluC4uL0U4pw9mrxAZTAgbs3OJQ1ytZHMlwiKvhOTJvxt0MWPEwQU
	 FO98XToIc0URdwUNXgvHnPiNkmkvxq5blNq+TcHI0N99gABbWqVI+M95B5K9fyLW/4
	 7TX6O2yB25yCm5SQqcgRoN1y5eEHi9s7SEhQnpXX+nSQR7Iue0RS9tCOYZP2M7bc1z
	 w6fYv6kL7AHVeOxUxMIcL8jFTL5xMZLxW7nyUHWwzD5tf6JpxH7DoyQHPPAKDUdstl
	 TNcymQkVSNBSA==
Date: Fri, 13 Dec 2024 10:04:15 +0000
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 07/10] net: mvneta: convert to phylink EEE
 implementation
Message-ID: <20241213100415.GF2110@kernel.org>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefs-006SN1-PG@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKefs-006SN1-PG@rmk-PC.armlinux.org.uk>

On Mon, Dec 09, 2024 at 02:23:48PM +0000, Russell King (Oracle) wrote:
> Convert mvneta to use phylink's EEE implementation, which means we just
> need to implement the two methods for LPI control, and adding the
> initial configuration.
> 
> Disabling LPI requires clearing a single bit. Enabling LPI needs a full
> configuration of several values, as the timer values are dependent on
> the MAC operating speed.
> 
> As Armada 388 states that EEE is only supported in "SGMII" modes, mark
> this in lpi_interfaces. Testing with RGMII on the Clearfog platform
> indicates that the receive path fails to detect LPI over RGMII.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 127 ++++++++++++++++----------
>  1 file changed, 79 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c

...

> +static void mvneta_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
> +				     bool tx_clk_stop)
> +{
> +	struct mvneta_port *pp = netdev_priv(to_net_dev(config->dev));
> +	u32 ts, tw, lpi0, lpi1, status;
> +
> +	status = mvreg_read(pp, MVNETA_GMAC_STATUS);
> +	if (status & MVNETA_GMAC_SPEED_1000) {
> +		/* At 1G speeds, the timer resolution are 1us, and
> +		 * 802.3 says tw is 16.5us. Round up to 17us.
> +		 */
> +		tw = 17;
> +		ts = timer;
> +	} else {
> +		/* At 100M speeds, the timer resolutions are 10us, and
> +		 * 802.3 says tw is 30us.
> +		 */
> +		tw = 3;
> +		ts = DIV_ROUND_UP(timer, 10);
>  	}
> +
> +	if (ts > 255)
> +		ts = 255;
> +
> +	/* Configure ts */
> +	lpi0 = mvreg_read(pp, MVNETA_LPI_CTRL_0);
> +	lpi0 = u32_replace_bits(lpi0, MVNETA_LPI_CTRL_0_TS, ts);

Hi Russell,

I think that the val and field arguments to u32_replace_bits() are
inverted here and this should be:

	lpi0 = u32_replace_bits(lpi0, ts, MVNETA_LPI_CTRL_0_TS);

> +	mvreg_write(pp, MVNETA_LPI_CTRL_0, lpi0);
> +
> +	/* Configure tw and enable LPI generation */
> +	lpi1 = mvreg_read(pp, MVNETA_LPI_CTRL_1);
> +	lpi1 = u32_replace_bits(lpi1, MVNETA_LPI_CTRL_1_TW, tw);

Ditto.

> +	lpi1 |= MVNETA_LPI_CTRL_1_REQUEST_ENABLE;
> +	mvreg_write(pp, MVNETA_LPI_CTRL_1, lpi1);
>  }
>  
>  static const struct phylink_mac_ops mvneta_phylink_ops = {

Flagged by clang-19 and gcc-14 W=1 builds.

...

