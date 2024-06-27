Return-Path: <netdev+bounces-107239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A5391A64A
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD28285498
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F33D14F9E6;
	Thu, 27 Jun 2024 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FxvThsrZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4404149009;
	Thu, 27 Jun 2024 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490200; cv=none; b=pJ6kbzR8+pW4IcbvzAfXAYxmtOpTc8gQPC0vJyojnFEJvk6l3n6aiIwsqsJhW9GS5YlYGIjcS21Ngx6FnbVTt5p+ZBiohCKZj4uVUZ7eGvq2zVfR9+Ni8r5EvETiiClB2/XJy+3OaN0RVm7OIgb7IUyb4Z5aRvPgy+Me8PqiGbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490200; c=relaxed/simple;
	bh=s2RXi2Wn/fsc5xTb8gf/y6rPuZY9xxBC4vuDPx9pl1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tqo1F1U+On4bmELwM4c/V0nTaHYE/rLErE+JrFGzthq857TXDUp8ldjOjfMSVKjE4KuufPhc5CMwcKZa/kQ4Nmm9zJcC9LWBT+/h3JlHjU5qp84h7PzzPguvviebwB2bEzW6EHMKlKcG2WtB/6naijy0g/pJdAviGPpLAfaY6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FxvThsrZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cS9YRx9D9ZEknDhk/xkWRG74Vu8GBOHelkWrVqvmHLU=; b=FxvThsrZ/L6Pos2ngvhwn/lf8W
	vL1FpSiQaYYt9QX+Vf5JRqwAcChs6KSXhfkfBxHEuoY1xU8Acsn6hRn9q1JRvhPlzbYIOcXOKNo6l
	TEKT0OzRpTlkmjpcCs9frtqTo2vppvx3H73wYBicQq76C0t+bAXUmv+uQACznoBQM7GPjSUqmHfxj
	ZRrf70xGJhO98vbCVu4FRAOmNid2fMTiu0vdiKCtVASdB8cE/Fdf4xiwWmScDOxGEfJbk3cBiZpdD
	oLsQKctvCTIa0Babg8p7/KP7GeRXQNC8j54sT/w9Me/1S2mypFpU+IH3ITC7m+h2ONDYtm7OS9ICe
	apOLwvnQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56636)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sMnwY-0004Pv-0a;
	Thu, 27 Jun 2024 13:09:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sMnwY-0005a8-W3; Thu, 27 Jun 2024 13:09:39 +0100
Date: Thu, 27 Jun 2024 13:09:38 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 net-next 3/3] net: phy: aquantia: add support for
 aqr115c
Message-ID: <Zn1WgpC58nbYfLVF@shell.armlinux.org.uk>
References: <20240627113018.25083-1-brgl@bgdev.pl>
 <20240627113018.25083-4-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627113018.25083-4-brgl@bgdev.pl>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 27, 2024 at 01:30:17PM +0200, Bartosz Golaszewski wrote:
> +static int aqr115c_config_init(struct phy_device *phydev)
> +{
> +	/* Check that the PHY interface type is compatible */
> +	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
> +	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX)
> +		return -ENODEV;
> +
> +	phy_set_max_speed(phydev, SPEED_2500);

Please can you explain why this is necessary? Does the PHY report that
it incorrectly supports faster speeds than 2500base-X ?

If phylib is incorrectly detecting the PHYs features, then this should
be corrected via the .get_features method, not in the .config_init
method.

(The same should be true of the other Aquantia PHYs.)

Note that phy_set_max_speed() is documented as:

 * The PHY might be more capable than the MAC. For example a Fast Ethernet
 * is connected to a 1G PHY. This function allows the MAC to indicate its
 * maximum speed, and so limit what the PHY will advertise.

Aquantia seems to be the only PHY driver that calls this function.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

