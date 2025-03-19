Return-Path: <netdev+bounces-176150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD539A691E7
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771ED1748C4
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B181D54F4;
	Wed, 19 Mar 2025 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HQU8tube"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37B1D5162;
	Wed, 19 Mar 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395432; cv=none; b=P6O4I0q2cssiLPlidtYlIH+vaNlvI63bwrs/zxqBbOS7/X4jvZeqyQAukHwn0A1JpCQrrXyudyWGYOdRYIaRQvSkFtZVxOWVQkvXwhkokbqdDJetjwung9lOwdlPsKQDxRAhsLABgprNorj0rs0A6MkgvKA0cPZ2Gt33P2pUofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395432; c=relaxed/simple;
	bh=j9XTjl+jqvNrL8fVZWv1CJYz4khY3GkCOXjsIKGJIn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubRERaN6LoAonaF5y//JGHR5X+JO2L1cITX1rrcDS154DYYgV2Ld9VyqlxmqZ3v/IjZSHTdACQxTY8hFDG12Eu7BZfQ++9aZusWgMo0+c3J2I0iHKmd6je1qsY00cqa5FMShey9r1xdwDwpLlvjEJTLwhMZoEwOMO4R1jp1Ggnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HQU8tube; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cCTR3yBOo8DufyGe6KI+cLaIObKiL0GBW9IcQX8jRiQ=; b=HQU8tube2JRzAxkO9GSGOZ/XGz
	1TJD+1oZTe6ICwyO7L8IzdhA8/Su4wCBkV/Wx7hghOLNoEkalfQtq6JFWGG+5Ros1duRxknq9yCHx
	W+CzDCDhcG7AkYNDQQmbMylQKnGjWqS0qlMMxCMBO3N0BHX930cq9zZ9op/BNAvvDmeKhQPambPke
	xnqPQ2UJ9drAjb0bPBEKtc/IZko1qDC6uu9CrbKwXBzNWWgkOWQQUn37tCxR6MpeNnLi5QOnoLmI9
	ttEWwdqKXMaWAEyJhabIa6guvBXPKqfwf+i6mZu/NqQGkj0bbygVxyg1azoQ+Gy0slGeF49bq/rNk
	IztI3VpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37630)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuue0-0006XK-1H;
	Wed, 19 Mar 2025 14:43:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuudw-0005gb-3D;
	Wed, 19 Mar 2025 14:43:41 +0000
Date: Wed, 19 Mar 2025 14:43:40 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net v2 2/2] net: usb: asix: ax88772: Increase phy_name
 size
Message-ID: <Z9rYHDL3dNbaK9jZ@shell.armlinux.org.uk>
References: <20250319105813.3102076-1-andriy.shevchenko@linux.intel.com>
 <20250319105813.3102076-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250319105813.3102076-3-andriy.shevchenko@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 19, 2025 at 12:54:34PM +0200, Andy Shevchenko wrote:
> GCC compiler (Debian 14.2.0-17) is not happy about printing
> into a short buffer (when build with `make W=1`):
> 
>  drivers/net/usb/ax88172a.c: In function ‘ax88172a_reset’:
>  include/linux/phy.h:312:20: error: ‘%s’ directive output may be truncated writing up to 60 bytes into a region of size 20 [-Werror=format-truncation=]

GCC reckons this can be up to 60 bytes...

>  struct ax88172a_private {
>  	struct mii_bus *mdio;
>  	struct phy_device *phydev;
> -	char phy_name[20];
> +	char phy_name[MII_BUS_ID_SIZE + 3];

MII_BUS_ID_SIZE is sized to 61, and is what is used in struct
mii_bus::id. Why there a +3 here, which seems like a random constant to
make it 64-bit aligned in size. If we have need to increase
MII_BUS_ID_SIZE in the future, this kind of alignment then goes
wrong...

If the intention is to align it to 64-bit then there's surely a better
and future-proof ways to do that.

I'm also surprised that the +3 randomness wasn't described in the
commit message.

> @@ -210,7 +210,10 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
>  	ret = asix_read_phy_addr(dev, priv->use_embdphy);
>  	if (ret < 0)
>  		goto free;
> -
> +	if (ret >= PHY_MAX_ADDR) {
> +		netdev_err(dev->net, "Invalid PHY ID %x\n", ret);

An address is not a "PHY ID". "Invalid PHY address %d\n" probably makes
more sense, but if you want to keep the hex, then it really should be
%#x or 0x%x to make it clear that e.g. "20" is hex and not decimal.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

