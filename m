Return-Path: <netdev+bounces-224008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0A1B7E7F0
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 475337AA3A5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0AC328980;
	Wed, 17 Sep 2025 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KceaBF6m"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A165328961;
	Wed, 17 Sep 2025 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113340; cv=none; b=a0VjU0TNJcNlnPSKtNt/FQ2crQ7sLLFwb5FPbkovdOBf+QXTftGXW+HPycYkQPmsCFQz0xuTOJepAzA+9HW4v5EfEF75Y9aiw8Spf8U4nn/VRcuNUxjjvKKD+NZTTR48LlYTQEsUe/2am7KsFjWL4oP1P6JiW4oc0VPbTmWK+jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113340; c=relaxed/simple;
	bh=ADmR+aPfHjpVZO3BA49YtyZimWD6R7PE5QT6qe7EHJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0LK7RuEBpot6gI0eNEEDaNWo62L7Ouq3eNl7sZrAFDRahprkxPVU5lIyokJDDqLh5rs9cV/IUwvQx+jk4jvnvconRJonJ3XSMxXX7z7qa3/fx3GU6DnTvOOlGYaILkmvMuaGIh5Mlx1GwGkxMtRA4GhUBH1LfaiXWchChKvWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KceaBF6m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UNiqIgqTHqtWorxCijoRmB/2GW+PC8xy7/Vgf/Voxfg=; b=KceaBF6m7ZHSj6uGefHo1nkZsn
	1lgFjKlCMx4yL/2/1Pc2DzV9Ja9oY9VJsSJm1Bz84Wu5SijT5408UKQxnMqwqGwo0CTAbGFefNoO5
	ZLhfyxXl2aZ1sqht/FwZPfnrgH3Yj/CPNPvrUGnOxcl8WJ+6AUay7yin70HXyWhrW8nk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyrac-008gNI-Pv; Wed, 17 Sep 2025 14:48:50 +0200
Date: Wed, 17 Sep 2025 14:48:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v3 1/1] net: phy: clear link parameters on admin
 link down
Message-ID: <78900f88-e0a9-470b-8cf9-778612b30a91@lunn.ch>
References: <20250917094751.2101285-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917094751.2101285-1-o.rempel@pengutronix.de>

On Wed, Sep 17, 2025 at 11:47:51AM +0200, Oleksij Rempel wrote:
> When a PHY is halted (e.g. `ip link set dev lan2 down`), several
> fields in struct phy_device may still reflect the last active
> connection. This leads to ethtool showing stale values even though
> the link is down.
> 
> Reset selected fields in _phy_state_machine() when transitioning
> to PHY_HALTED and the link was previously up:
> 
> - speed/duplex -> UNKNOWN, but only in autoneg mode (in forced mode
>   these fields carry configuration, not status)
> - master_slave_state -> UNKNOWN if previously supported
> - mdix -> INVALID (state only, same meaning as "unknown")
> - lp_advertising -> always cleared
> 
> The cleanup is skipped if the PHY is in PHY_ERROR state, so the
> last values remain available for diagnostics.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

