Return-Path: <netdev+bounces-176181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA62A69431
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B7467A278F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012DE1D7999;
	Wed, 19 Mar 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KiLpgID4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450F542048;
	Wed, 19 Mar 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399910; cv=none; b=AlDv9FE2GGTk418gpcxlQs0EoIRax9w8WYzeTAy5hespVae9rtA7VaWMeRN5E8urKQa5OUkIfF/1gueMzoTBNGzAGSP+GQ5b7ldjr9yVhU3EO164BvVpQOCd0hS7W4vSlH9A/8Pqf3lCqpvRgFBnoUfeEOjnMU99oM9xK6xRWQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399910; c=relaxed/simple;
	bh=gHPpYtCLpFpzgI6lWlHYyKI4j6MciQKQyMXmkFGAFpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBmMPlTfOYYxd758ftXG1fS0cYw9VfgYToIf0uLTZxYEISmzBSL36yHOT3Dtg7mvue8aNZhJDKqYsoaPt5PLR6k6SDfT6KWYNkp/B5Q50oYOSFUjmgmkFPy66FoS6FdnkwPnGTp+TeGnQXX1JGJDLss4/siDuHWI5l5vzbke/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KiLpgID4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Np/nX4RQYl76B3DOF+lcwAiFuD7qauib8soLH9wPPWM=; b=KiLpgID4bAWzCDTTHLQy5DyOFx
	e9YZhVFbbCNPHk9Y+K7iv5Ba8sALmIR+fnXAyMCo+Z2Y/QwP8w5Zpl7GwHQsikQoreFDMBD0vPg5X
	WKJhkazKbQD/2Gmc0kZ+tPcCJdtyKPEh1Dp0TpBmBgtpT27xLZApYWOlvB7vBcz7TpI1BGtg3L/4V
	OEHcGNTtT+rOc98PsJjN/r8qYbSBlKbFaM3iYqX1Bg2zaQkAawe3uyhI5ugBnyeV3cdwZzJhbYNKB
	xMfm7SES+tpphE/JcM3KEvV7a3fPfnaTK5e+nf5nHGliLSo2JpS10W0yxf2UgAzSCtAbe02eQ8PgK
	XZxG9nHw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33446)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuvo9-0006dc-20;
	Wed, 19 Mar 2025 15:58:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuvo6-0005jc-0l;
	Wed, 19 Mar 2025 15:58:14 +0000
Date: Wed, 19 Mar 2025 15:58:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 3/6] net: phylink: Correctly handle PCS probe
 defer from PCS provider
Message-ID: <Z9rplhTelXb-oZdC@shell.armlinux.org.uk>
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318235850.6411-4-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 19, 2025 at 12:58:39AM +0100, Christian Marangi wrote:
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 7f71547e89fe..c6d9e4efed13 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1395,6 +1395,15 @@ static void phylink_major_config(struct phylink *pl, bool restart,
>  	if (pl->mac_ops->mac_select_pcs) {
>  		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
>  		if (IS_ERR(pcs)) {
> +			/* PCS can be removed unexpectedly and not available
> +			 * anymore.
> +			 * PCS provider will return probe defer as the PCS
> +			 * can't be found in the global provider list.
> +			 * In such case, return -ENOENT as a more symbolic name
> +			 * for the error message.
> +			 */
> +			if (PTR_ERR(pcs) == -EPROBE_DEFER)
> +				pcs = ERR_PTR(-ENOENT);

I don't particularly like the idea of returning -EPROBE_DEFER from
mac_select_pcs()... there is no way *ever* that such an error code
could be handled.

>  	linkmode_fill(pl->supported);
>  	linkmode_copy(pl->link_config.advertising, pl->supported);
> -	phylink_validate(pl, pl->supported, &pl->link_config);
> +	ret = phylink_validate(pl, pl->supported, &pl->link_config);
> +	/* The PCS might not available at the time phylink_create
> +	 * is called. Check this and communicate to the MAC driver
> +	 * that probe should be retried later.
> +	 *
> +	 * Notice that this can only happen in probe stage and PCS
> +	 * is expected to be avaialble in phylink_major_config.
> +	 */
> +	if (ret == -EPROBE_DEFER) {
> +		kfree(pl);
> +		return ERR_PTR(ret);
> +	}

This does not solve the problem - what if the interface mode is
currently not one that requires a PCS that may not yet be probed?

I don't like the idea that mac_select_pcs() might be doing a complex
lookup - that could make scanning the interface modes (as
phylink_validate_mask() does) quite slow and unreliable, and phylink
currently assumes that a PCS that is validated as present will remain
present.

If it goes away by the time phylink_major_config() is called, then we
leave the phylink state no longer reflecting how the hardware is
programmed, but we still continue to call mac_link_up() - which should
probably be fixed.

Given that netdev is severely backlogged, I'm not inclined to add to
the netdev maintainers workloads by trying to fix this until after
the merge window - it looks like they're at least one week behind.
Consequently, I'm expecting that most patches that have been
submitted during this week will be dropped from patchwork, which
means submitting patches this week is likely not useful.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

