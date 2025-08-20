Return-Path: <netdev+bounces-215126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7E9B2D240
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB0E624F81
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D04A218AAB;
	Wed, 20 Aug 2025 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x1BkXOIm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3DC2C859;
	Wed, 20 Aug 2025 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659016; cv=none; b=n/VpTOLiscgO/ZpcKnsNlhowYYmi6owrLI/PtfE6S/FSycjyxRnoF0Q6Y4ebQ7n1fA/84iHng1r2lyAj1cGS7q+ECEZtmJlAP0eJl9k22a095m2DJzMPMmZIAbWesbR7YBXcZXt565rD/Z7uP4QsmZLWvv3d97y9zDpurPXhZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659016; c=relaxed/simple;
	bh=pwG7+up/AaR3CHTWrmgAoo7R1642PpG4lENEDoKEt94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEjb+Sv7skcm4L1OK4boxGm1tFPLNxL63AOa46+LcXqrWjUjbeqKDTmuoUhaT/dQ8M2yNmhJTlbjS5AayKSC0bAnCtCe+6BvVZv28lL9nljGdHyILPQV4l1IpAwAkfqqGjbcmwnvWvLt2jBtH91NeXE2tivbQV/IBz2KtPHuueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x1BkXOIm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T8l7eksCnZgf3owz6oDBmv8SoF3MjbglvYRg9j+ht9A=; b=x1BkXOImnRYA4i7tLz8JrCRgKC
	kQWymUFMvYEMPrzzhlio2BlNKYqr9nPG6KVXcmxMtL2D1zYEkolO9WFabFiMJY2HJolkWWmBQn418
	M9ZvZWNsBXvX3cLYhQl0Ej93hUqXYWt1me7Ynq4Kv6GqFgMRMCDkdRicm3dQpHq92Zw0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uoZ6Y-005GlX-N7; Wed, 20 Aug 2025 05:03:14 +0200
Date: Wed, 20 Aug 2025 05:03:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nishanth Menon <nm@ti.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk <roan@protonic.nl>
Subject: Re: [PATCH net-next v2 1/5] ethtool: introduce core UAPI and driver
 API for PHY MSE diagnostics
Message-ID: <489b2959-3374-4766-a982-9e7c26077899@lunn.ch>
References: <20250815063509.743796-1-o.rempel@pengutronix.de>
 <20250815063509.743796-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815063509.743796-2-o.rempel@pengutronix.de>

> Channel-to-pair mapping is normally straightforward, but in some cases
> (e.g. 100BASE-TX with MDI-X resolution unknown) the mapping is ambiguous.
> If hardware does not expose MDI-X status, the exact pair cannot be
> determined. To avoid returning misleading per-channel data in this case,
> a LINK selector is defined for aggregate MSE measurements.

This is the same with cable test. The API just labels the pairs using

        ETHTOOL_A_CABLE_PAIR_A,
        ETHTOOL_A_CABLE_PAIR_B,
        ETHTOOL_A_CABLE_PAIR_C,
        ETHTOOL_A_CABLE_PAIR_D,

It does not take into account MDI-X or anything.

> @@ -1174,6 +1246,60 @@ struct phy_driver {
>  	/** @get_sqi_max: Get the maximum signal quality indication */
>  	int (*get_sqi_max)(struct phy_device *dev);
>  
> +	/**
> +	 * get_mse_config - Get configuration and scale of MSE measurement
> +	 * @dev:    PHY device
> +	 * @config: Output (filled on success)
> +	 *
> +	 * Fill @config with the PHY's MSE configuration for the current
> +	 * link mode: scale limits (max_average_mse, max_peak_mse), update
> +	 * interval (refresh_rate_ps), sample length (num_symbols) and the
> +	 * capability bitmask (supported_caps).
> +	 *
> +	 * Implementations may defer configuration until hardware has
> +	 * converged; in that case they should return -EAGAIN and allow the
> +	 * caller to retry later.
> +	 *
> +	 * Return:
> +	 *  * 0              - success, @config is valid
> +	 *  * -EOPNOTSUPP    - MSE configuration not implemented by the PHY
> +	 *		       or not supported in the current link mode
> +	 *  * -ENETDOWN      - link is down and configuration is not
> +	 *		       available in that state

This seems a bit odd. phylib knows the state of the link. If it is
down, why would it even ask? 

	Andrew

