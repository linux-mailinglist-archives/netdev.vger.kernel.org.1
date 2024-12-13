Return-Path: <netdev+bounces-151668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E39F0802
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F8F188B084
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C171B0F2F;
	Fri, 13 Dec 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqboJ/ZB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728981B0F0A
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082634; cv=none; b=WNqaRKChReN858yiYz00TiNfZd6eGZ1BMsHGEVljPsROhqpS/F2KFzqubevpoNVv1h6CIdOZ4abzupcfZtqSIUzzGF1w1EpqY/e7OjauuVsLzjHBNrGO+MNHXYAvt8O9zMRcse8ozFniy8on4+RY700X5Oiu7C7/XV+jBkOHmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082634; c=relaxed/simple;
	bh=suog/5WfaAxLoFXNWByaz3kVZ15gj6qgFqKHJFoAc7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBjrap9d88os8lelCxkd6Lq9pAcWozhuVn49hnmwKk0+oogHwxTWTuz+U7KsdyF/OeOuCSJb9HRD86529uOwUtui344IWPVUINnip/2ereljxNxdrslFD7wQWoBH3N52jWVW4IZB2GHSm6aFyjcjnPKmEnHMxwowOBmMT0h8e6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqboJ/ZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07755C4CED0;
	Fri, 13 Dec 2024 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734082634;
	bh=suog/5WfaAxLoFXNWByaz3kVZ15gj6qgFqKHJFoAc7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqboJ/ZBWL6HPe4RnV1bDmAy5xBQaFCRefc+JLtVF0FPwCdg+tqXkO7Dgg60dILfS
	 sXAePBpksZ+Twny82vKaHI9Hq8SHY86rw0vD8Sn0v4fyxsSj60oLE2nfjRFghCJKv+
	 zyOJ3E+1u2jfj/eUfGwhwIdMIvccJiOVKGi5p8QeFuZxMZLuhfZRwXI3tcYTp7my85
	 FfryiOWjkq0gDDw8kkY2pASGyv4gMEBFevtOQSnipGr2kMHhe9mctrL5m4VqtGx06l
	 4XzQaVghWjkRMsB1MA7sLae7HjjPGBwQDqTaGY6ib2LiVX0QR6vyVHhfHfXzi0j0jW
	 dAG7n4wMos49g==
Date: Fri, 13 Dec 2024 09:37:09 +0000
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
Subject: Re: [PATCH net-next 05/10] net: phylink: add EEE management
Message-ID: <20241213093709.GE2110@kernel.org>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefi-006SMp-Hw@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKefi-006SMp-Hw@rmk-PC.armlinux.org.uk>

On Mon, Dec 09, 2024 at 02:23:38PM +0000, Russell King (Oracle) wrote:
> Add EEE management to phylink, making use of the phylib implementation.
> This will only be used where a MAC driver populates the methods and
> capabilities bitfield, otherwise we keep our old behaviour.
> 
> Phylink will keep track of the EEE configuration, including the clock
> stop abilities at each end of the MAC to PHY link, programming the PHY
> appropriately and preserving the EEE configuration should the PHY go
> away.
> 
> It will also call into the MAC driver when LPI needs to be enabled or
> disabled, with the expectation that the MAC have LPI disabled during
> probe.
> 
> Support for phylink managed EEE is enabled by populating both tx_lpi
> MAC operations method pointers.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

...

> diff --git a/include/linux/phylink.h b/include/linux/phylink.h

...

> @@ -143,11 +145,17 @@ enum phylink_op_type {
>   *                    possible and avoid stopping it during suspend events.
>   * @default_an_inband: if true, defaults to MLO_AN_INBAND rather than
>   *		       MLO_AN_PHY. A fixed-link specification will override.
> + * @eee_rx_clk_stop_enable: if true, PHY can stop the receive clock during LPI
>   * @get_fixed_state: callback to execute to determine the fixed link state,
>   *		     if MAC link is at %MLO_AN_FIXED mode.
>   * @supported_interfaces: bitmap describing which PHY_INTERFACE_MODE_xxx
>   *                        are supported by the MAC/PCS.
> + * @lpi_interfaces: bitmap describing which PHY interface modes can support
> + *		    LPI signalling.
>   * @mac_capabilities: MAC pause/speed/duplex capabilities.
> + * @lpi_capabilities: MAC speeds which can support LPI signalling
> + * @eee: default EEE configuration.
> + * @lpi_timer_limit_us: Maximum (inclusive) value of the EEE LPI timer.
>   */
>  struct phylink_config {
>  	struct device *dev;
> @@ -156,10 +164,16 @@ struct phylink_config {
>  	bool mac_managed_pm;
>  	bool mac_requires_rxc;
>  	bool default_an_inband;
> +	bool eee_rx_clk_stop_enable;
>  	void (*get_fixed_state)(struct phylink_config *config,
>  				struct phylink_link_state *state);
>  	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
> +	DECLARE_PHY_INTERFACE_MASK(lpi_interfaces);
>  	unsigned long mac_capabilities;
> +	unsigned long lpi_capabilities;
> +	u32 lpi_timer_limit_us;
> +	u32 lpi_timer_default;
> +	bool eee_enabled_default;
>  };

Hi Russell,

A minor nit from my side.

The Kernel doc updates don't correspond entirely to the structure updates:
- @eee is documented but not present in the structure
- Conversely, @lpi_timer_default and @ee_enabled_default are
  present in the structure but not documented.

...

