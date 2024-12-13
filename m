Return-Path: <netdev+bounces-151869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66219F16C0
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7756228800F
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12D118C018;
	Fri, 13 Dec 2024 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cz/DjlHr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225FE18E351;
	Fri, 13 Dec 2024 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119356; cv=none; b=ivfXh7ed3uyyHZ3wuNgpiZ3Gc8OG7oWrbb9RLHJr4Jw7qwMn9GwAjomGhh9QrMYuFwYiWnxB+d6QThdAvNbEtddwChnFGzX3/LX9nC4/dW9DM/VuA4du2K4buWEesOdZq+ngtjaeQ4ZPrE7eJsRQZK2IG9MfRFQIog9X+qg6vUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119356; c=relaxed/simple;
	bh=XYPKXjceJoiDJNyMAmtuX6dCMkX1Hng+avTbh+C1S8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esG0A9OrksRrctjKBHV2Kngnk125jwZEmucbAPQQlmIh3ZUTFO/NETKA/TQJXUgrFICXpOg81EPgnhYxmc4awHvwV+dwRnKG9e/TbMQdnM1+2HggTEHqx3M5k7vwyo7WlBmHp3CS+9d2yznDF09GdmoF+TYLhOX2flPz/hZAwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cz/DjlHr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5bQC/f+ngK7vY3gU8HjH2GhzMwPXvxLIwJFxXKAK+bs=; b=cz/DjlHrD9RTa7cCUxkRhWc2nY
	Lo9TtOlrd+CFq/Mpp6bbCjaH+TjXXnH4CxrzWK3JcN5txeQt5rhp+BdH9g6OqtZ04g3NfvEpu9G4m
	S0w7wmw219AvKvke1HZ6PS/pvq9LuGZpDXaPI1s4dnBv5UoPxAlYWX6dzS4uMa8F8HnhOD7W134u9
	bhtcSDXD36xo4Khf+PRPip+aHzuJI1nhbekvdshp6yulVg/Dc6T6gxmieQb4KCyfKh50VIaC9L7yV
	aYIO7Sb24mKsWE/oOCRTa1U2wNqOjCa57JEZBXpYIctIxfLARqW3iscilWSLccBrjg9l+Hintxo1T
	e0uRDsvg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54006)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tMBen-0007GK-0O;
	Fri, 13 Dec 2024 19:49:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tMBel-0006Z0-1j;
	Fri, 13 Dec 2024 19:48:59 +0000
Date: Fri, 13 Dec 2024 19:48:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	jacob.e.keller@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robert.marko@sartura.hr
Subject: Re: [PATCH net-next v4 6/9] net: sparx5: verify RGMII speeds
Message-ID: <Z1yPq6OEziTNjWHK@shell.armlinux.org.uk>
References: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
 <20241213-sparx5-lan969x-switch-driver-4-v4-6-d1a72c9c4714@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-sparx5-lan969x-switch-driver-4-v4-6-d1a72c9c4714@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 13, 2024 at 02:41:05PM +0100, Daniel Machon wrote:
> When doing a port config, we verify the port speed against the PHY mode
> and supported speeds of that PHY mode. Add checks for the four RGMII phy
> modes: RGMII, RGMII_ID, RGMII_TXID and RGMII_RXID.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

You do realise that phylink knows what speeds each interface supports
(see phylink_get_capabilities()) and restricts the media advertisement
to ensure that ethtool link modes that can't be supported by the MAC
capabilities and set of interfaces that would be used are not
advertised.

This should mean none of your verification ever triggers. If it does,
then I'd like to know about it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

