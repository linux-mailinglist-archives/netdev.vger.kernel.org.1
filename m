Return-Path: <netdev+bounces-103121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC979065B7
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37861F2691D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72BB13C90B;
	Thu, 13 Jun 2024 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J6hNF/eB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9D13C8E8;
	Thu, 13 Jun 2024 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265301; cv=none; b=MpsdkSgVnukQWvkhIUAMEPWr8FcIIjVrob+Dg/X+rtcytfIFLcW+o88VfedUiinnZ/D4dsKZtZboadUhAsn36ncucCkAcTJeMwNmWjKuWWr7mkMkg0b59KfWmQbP6sk+sfvrRNSzdUghHulw22+ymjk6edQxd0h0ozUNHKSOl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265301; c=relaxed/simple;
	bh=IlUPSgkK7p1HuO+/td3WBezslkq7GVsamNMvlKZWO84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOsu18TW0SB8JsTr6aJlu6WIVZx/u/hG57G8OxD6nFBM0TrTiAqFucMYKf/JHPvAJ3LTfruE4F3yT6YmdfoAXa8OkM9MSLftROVPBMStqSqENHhAIlpM/b5jAR0fzZ98SvZNqhvH9CRD3Cp0C4bgMBXkHZ/xGUJAtq9OG9seE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J6hNF/eB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B3aRTXsDCKGjz5H0M1vcgLuL/l8L7HFeO7Ru892md5A=; b=J6hNF/eBSwlcxxvuHLCJgTtrpY
	VE86/JVsrj51j2BA9f3Q4uaN/XWazpq8ZzELbOdqz2ygRpj3LrrxuVbaNBkHw45JuXSqSeh07BIHO
	vBCANAwXYGDM7oGTkeEIpBiRRHLvusdB3X78kVNEswRnJNgbDQvp+3A1KaG5/WZhf0VgR5j2QnsnN
	NyU7NTDBhbjeE+96uTGuxwErtdGC7BLkjMC5LyNIjqqQvIitc5evuimHOShtJVec4Zuw7dvcYaTAY
	P4jgm7Ii9BGBxtoXpHTOz0tVPqVo3TlC4YuvqUujJeMECXwZn924osFQ/hccOOO98q+iQWvjUP9T7
	Vq58hLGQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50602)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sHfI8-0005jK-18;
	Thu, 13 Jun 2024 08:54:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sHfI7-000145-31; Thu, 13 Jun 2024 08:54:39 +0100
Date: Thu, 13 Jun 2024 08:54:38 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	corbet@lwn.net, vladimir.oltean@nxp.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: introduce core support for
 phy-mode = "10g-qxgmii"
Message-ID: <Zmqlvn2gOlxoy5Gm@shell.armlinux.org.uk>
References: <20240612095317.1261855-1-quic_luoj@quicinc.com>
 <20240612095317.1261855-2-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612095317.1261855-2-quic_luoj@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 12, 2024 at 05:53:16PM +0800, Luo Jie wrote:
> @@ -1865,7 +1872,8 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
>  	if (phy->is_c45 && state->rate_matching == RATE_MATCH_NONE &&
>  	    state->interface != PHY_INTERFACE_MODE_RXAUI &&
>  	    state->interface != PHY_INTERFACE_MODE_XAUI &&
> -	    state->interface != PHY_INTERFACE_MODE_USXGMII)
> +	    state->interface != PHY_INTERFACE_MODE_USXGMII &&
> +	    state->interface != PHY_INTERFACE_MODE_10G_QXGMII)
>  		state->interface = PHY_INTERFACE_MODE_NA;

It would be better, rather than extending this workaround, instead to
have the PHY driver set phy->possible_interfaces in its .config_init
method. phy->possible_interfaces should be the set of interfaces that
the PHY _will_ use given its configuration for the different media
speeds. I think that means just PHY_INTERFACE_MODE_10G_QXGMII for
your configuration.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

