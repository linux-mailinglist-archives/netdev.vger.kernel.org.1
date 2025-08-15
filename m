Return-Path: <netdev+bounces-214128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB66B28532
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA057BA1F0
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC9E3176F1;
	Fri, 15 Aug 2025 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bwiPfBJU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18D3176E9;
	Fri, 15 Aug 2025 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279260; cv=none; b=PC++XTs3EYx/gvO1UejS05stM/YQqBMnQw1YT8pd2Ru05xP0wG8epRRRu9K6d6sreZ1CkwzJfpc8E+iJevxvwTvfYrr4WTjyKUsEI6XGDwJWC3u0TfK43bJ35EABSOX8tE3dz5fZUi6/EhzaQBRgFXENcCIAWCp8ZBZ58IURXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279260; c=relaxed/simple;
	bh=sr53SJkyqch1Ju+uifr+0aoIZJvubSgUF3UAqYysxsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9l5WC8ECiZigVyd6ut8UyH2mMPA6JE3e+dMrLhySiaAQCY3cFopOrRjsa4Uy4njsvRlrX/opILBkcHRognlgmlAvBFtCHpwWcNG7GUrivDIPy8eB4LXjp93PGLx0X6xY0C8mhNwQGGRgA5CYvxvIVhvtbV2pm9a8WcJtzO5yDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bwiPfBJU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=krnMUBqiW0s0OeRjQHpn11RJzlyVt3RQboGA85av57o=; b=bwiPfBJUZNbr2ZVv4DIE80GVi2
	LAdbkiHXLeGWoeJYf1P1y7ZjbomJ1ejv/d2P+EgSMp83ixoE3PT7UKfOqcTqp1f3A+FSKrVqNtk/3
	pn4/kBO7NauBrgdlqR0ETQgZki6fRbXqax6GNbykbJxWXFSeUBofkpzLxJtnaNTPa/zM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umyJZ-004qSG-ET; Fri, 15 Aug 2025 19:34:05 +0200
Date: Fri, 15 Aug 2025 19:34:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: mxl-86110: add basic support for
 MxL86111 PHY
Message-ID: <b8075cfa-599d-4648-8e33-68062b1a855f@lunn.ch>
References: <aJ9hZ6kan3Wlhxkt@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ9hZ6kan3Wlhxkt@pidgin.makrotopia.org>

> +	/* For fiber forced mode, power down/up to re-aneg */
> +	if (modes != LINK_INBAND_DISABLE) {
> +		__phy_modify(phydev, MII_BMCR, 0, BMCR_PDOWN);
> +		usleep_range(1000, 1050);
> +		__phy_modify(phydev, MII_BMCR, BMCR_PDOWN, 0);
> +	}

Is a full power down required? To restart autoneg all you normally
need to do it set BMCR_ANRESTART. See genphy_restart_aneg().

> @@ -648,8 +928,24 @@ static struct phy_driver mxl_phy_drvs[] = {
>  		.set_wol		= mxl86110_set_wol,
>  		.led_brightness_set	= mxl86110_led_brightness_set,
>  		.led_hw_is_supported	= mxl86110_led_hw_is_supported,
> -		.led_hw_control_get     = mxl86110_led_hw_control_get,
> -		.led_hw_control_set     = mxl86110_led_hw_control_set,
> +		.led_hw_control_get	= mxl86110_led_hw_control_get,
> +		.led_hw_control_set	= mxl86110_led_hw_control_set,

That should really be in a different patch.

	Andrew

