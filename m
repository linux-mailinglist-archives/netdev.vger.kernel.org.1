Return-Path: <netdev+bounces-236780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A35AC401BD
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35EBA340092
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0202DEA90;
	Fri,  7 Nov 2025 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JDGaBgJ6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A612DCF5D
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522076; cv=none; b=pkyqDNXya5yKddiV2zH3KfO1fEoKUsu1CgY5OB48vRU1azllWpzvp3wwW4q3KbmBmBml/ugdt4sm15sl9bNJPYS7rDxLooydRvcCkWTOTF8Oiz/wOnsrH5lNdYRVnpNyhDx2Pc2kl5qpIbbB9zKRKsaS66Cw678kQnLB+J8wtZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522076; c=relaxed/simple;
	bh=+lXllR/lH6cWsBh/xUVh53yWUXkFMjiNDZKqzG2N6M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJB2zE7+aK+FmB71Sq0n9EWE5NQmNrNomNQ9EPU3Q/m2cJ87HeKmYKJphbLUOR+Cz2et8a0KEVevkUpVXqH7tIWrwu2axWxh9MfjC35/QgrZx9YV3mWJEJPBBj2I2UWxy54aPSGL2lKxT6ekkUTffLHAAcs5Fu4wmkrAOlR+K0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JDGaBgJ6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z0ZJ99bUPwXFpf6kM2KWJxcX8Ne5DvhnDrJxM8imNuc=; b=JDGaBgJ60BoWsuKnyXjObs6XfN
	5vNj81jxnBtZVzq8b7o2qWUZ/E0o4QUzK/6moIhnt1DtfRa1P8tqgxDU1puY6v3pog8LldmEE4YNE
	ZO+AbgwPwveTD+uu6x6butI4LFyzqrWiMHKm5snx30oipf9/7+DuTE+/Smjx2fc8iGMo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHMVN-00DEH1-Bw; Fri, 07 Nov 2025 14:27:53 +0100
Date: Fri, 7 Nov 2025 14:27:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v2 net-next 2/6] net: phy: realtek: eliminate
 priv->phycr2 variable
Message-ID: <3b57e68b-074d-4522-a9bd-6df513cb0286@lunn.ch>
References: <20251107110817.324389-1-vladimir.oltean@nxp.com>
 <20251107110817.324389-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107110817.324389-3-vladimir.oltean@nxp.com>

On Fri, Nov 07, 2025 at 01:08:13PM +0200, Vladimir Oltean wrote:
> The RTL8211F(D)(I)-VD-CG PHY also has support for disabling the CLKOUT,
> and we'd like to introduce the "realtek,clkout-disable" property for
> that.
> 
> But it isn't done through the PHYCR2 register, and it becomes awkward to
> have the driver pretend that it is. So just replace the machine-level
> "u16 phycr2" variable with a logical "bool disable_clk_out", which
> scales better to the other PHY as well.
> 
> The change is a complete functional equivalent. Before, if the device
> tree property was absent, priv->phycr2 would contain the RTL8211F_CLKOUT_EN
> bit as read from hardware. Now, we don't save priv->phycr2, but we just
> don't call phy_modify_paged() on it. Also, we can simply call
> phy_modify_paged() with the "set" argument to 0.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: rename rtl8211f_disable_clk_out() to rtl8211f_config_clk_out()

Thanks

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

