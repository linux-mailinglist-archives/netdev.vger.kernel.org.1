Return-Path: <netdev+bounces-272771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNNROnjmx2kYegUAu9opvQ
	(envelope-from <netdev+bounces-272771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:32:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 460A334EAD8
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D439E301014D
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA60F32FA29;
	Sat, 28 Mar 2026 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eaKtklGa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABD7311956
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774708286; cv=none; b=BUCLmD6fqnSgftvdgrLP06WVAF8kOK0mjU7eEGEmZIc0UwX73BbDSAeM/Ar/VNOdSIE7OvJWyn5LorAUnxRHihoq5ZLWg54IV/i9FU1pkhUQ231rzbg/+8/oVVvUadeTmMzpj+gGOE4TRymTtr+8GMFLdvFBjeb7k6Bc0Mel8fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774708286; c=relaxed/simple;
	bh=i2Ey4/jLZ5NSjIyVJ/PSk/CB7TQv7bWX6PUTNtBOub4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5Gq0rDe8CuQ/523r3Y8D2dZbHCRUQCiXFrIJX3XPJo9y3h4ooxkCrZPjux6+XsRhM9ec3aeiQxHLO5OJnjuzWGt0NhMpBYoIzaifqIVxXxbpq89SCOXPKiKEuXpKwzwVKltujv1o3GRVatIbjRVLWWmsj+WGO/c3ifd7mrMRbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eaKtklGa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NSROk3734XDPppz40eLzs51hYXYidQqyUgpjnsybh28=; b=eaKtklGaOKgM8IhO3ti5fSlYNS
	ozMJN3VWTKTiQct1BssysV9aXDYXu8kDv4e48QOyhNPrVYOZlF3cVoAR3RgyYylbwiky9lRHu5H+I
	y0o+K9xMNJeADQ/R6Gx3rwZBGQnLpucxM533+13XDSU1MSbcrwPNbupOjhNtyBARd2es=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w6Uh4-00Dn7n-BV; Sat, 28 Mar 2026 15:31:18 +0100
Date: Sat, 28 Mar 2026 15:31:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Liu Xiang <liu.xiang@zlingsmart.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2] net: stmmac: avoid repeated devm_gpiod_get_optional
 in mdio
Message-ID: <35b72404-4abf-4e03-91f2-8345cccdbe31@lunn.ch>
References: <20260328032520.7866-1-liu.xiang@zlingsmart.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328032520.7866-1-liu.xiang@zlingsmart.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272771-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 460A334EAD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 11:25:20AM +0800, Liu Xiang wrote:
> During system resume, stmmac_resume() calls stmmac_mdio_reset().
> This results in repeated calls to devm_gpiod_get_optional() for the same
> GPIO. The second invocation returns an error since the GPIO descriptor has
> already been obtained.

How is this different to v1?

> @@ -386,15 +386,15 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>  
>  #ifdef CONFIG_OF
>  	if (priv->device->of_node) {
> -		struct gpio_desc *reset_gpio;
>  		u32 delays[3] = { 0, 0, 0 };
>  
> -		reset_gpio = devm_gpiod_get_optional(priv->device,
> -						     "snps,reset",
> -						     GPIOD_OUT_LOW);
> -		if (IS_ERR(reset_gpio))
> -			return PTR_ERR(reset_gpio);
> -
> +		if (IS_ERR_OR_NULL(priv->reset_gpio)) {
> +			priv->reset_gpio = devm_gpiod_get_optional(priv->device,
> +								   "snps,reset",
> +								 GPIOD_OUT_LOW);
> +			if (IS_ERR(priv->reset_gpio))
> +				return PTR_ERR(priv->reset_gpio);
> +		}

In general, a driver should get the resources it needs in probe, since
probe can only be successful once. So i suggest moving this into
stmmac_mdio_register() which is the equivalent of probe. To keep the
behaviour the same, pass GPIOD_ASIS, and then here in _reset set it
low.

	Andrew

