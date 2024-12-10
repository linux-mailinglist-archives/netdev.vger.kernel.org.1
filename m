Return-Path: <netdev+bounces-150596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5DC9EAD5C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8D6285B81
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9CB23DE8E;
	Tue, 10 Dec 2024 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iR+XkCRS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71223DE80
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824729; cv=none; b=EfPPOaBWDw5zXLDrTqIq+ve+gb63QGlogQYmCc5/s1kdvYSE9hDfEoqJ30Y1vAEzrVw50xRqNw9vL5xTLA3B5rUxa/UPgbj8FmFHAaOj+pV8HNxyaWpuxdEl8SnCHYOdheFR5rUECAHPdHqxCSFP/umrjcR+H3IWWW3E9PuBhf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824729; c=relaxed/simple;
	bh=rkrQTBCxPJXML5gKVUFymSfiqM6TYJ3wvjo8DKsj2fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gscgcw23W/08BUoy66R9VJk9AJwPonz4LjPRUvZhBqNYMKQdWYMDHyRSHWQ9bXq2vWxWle1famOLWJdAcQPeA2FswiW+5LDs77lE57m1xWiWY1LAkNFwEWXUTT311zi5xbFBLh5+ThzFb9C4ZQEZQKcvN1v+p1yzlV41jZGQPho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iR+XkCRS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Su63dy4fd1DaEn5KZcb5bHlp+IGfP7I6fk/9Lsw5iaY=; b=iR+XkCRSMmNPuuYtVe5pSpc9V7
	t7yoO6cz7AEe7zaCNv3Ob/DCfE1xTiginHSLZNgefIK1rGwu4dqA4xTMBmq4x3xinqqAX801cscGt
	4AmNR6YNB5hOYqs/CCGuccyGUzXbQ9OfwMD3FO2ovWRP4gLZHZSyze7AS6Ax93sWDPbAhLhMx6fVq
	9mLUZ7Ww5aeOZvnM5YScZPOmWLqOvpmC/aUfwiEJf2CXm2iRKnuOGiyTWVO3uqXR+lBVG6DuwE++w
	SPilAQf3qQkPzvnU7mmSTNa2bcqoqo629Vx8qImjnq19UUnCKlaZrACbSLG9unENOkzgDezoMcsxt
	pptx72MQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59466)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tKx0r-00027H-1X;
	Tue, 10 Dec 2024 09:58:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tKx0q-0002rY-1Q;
	Tue, 10 Dec 2024 09:58:40 +0000
Date: Tue, 10 Dec 2024 09:58:40 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 06/10] net: phylink: allow MAC driver to
 validate eee params
Message-ID: <Z1gQ0O8dbUl26JTc@shell.armlinux.org.uk>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefn-006SMv-Lg@rmk-PC.armlinux.org.uk>
 <a72db39a-ca78-43bc-a15b-5f1ab39af661@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a72db39a-ca78-43bc-a15b-5f1ab39af661@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 10, 2024 at 04:21:51AM +0100, Andrew Lunn wrote:
> > +/**
> > + * mac_validate_tx_lpi() - validate the LPI parameters in EEE
> > + * @config: a pointer to a &struct phylink_config.
> > + * @e: EEE configuration to be validated.
> > + *
> > + * Validate the LPI configuration parameters in @e, returning an appropriate
> > + * error. This will be called prior to any changes being made, and must not
> > + * make any changes to existing configuration. Returns zero on success.
> 
> Maybe suggest -EOPNOTSUPP? We might then get more uniform error codes
> from MAC drivers?

-EOPNOTSUPP would be appropriate if the driver doesn't support EEE at
all. Other errors are more appropriate when validating the value of
the parameters (e.g. tx_lpi_timer.)

However, we probably need to have a discussion about the best way to
handle tx_lpi_timer values that the hardware can't deal with. Should we
handle it with a hrtimer? If so, we probably need mac_enable_tx_lpi() to
return an error code, so that the core knows that the hardware can't
cope with the value at a particular speed, and needs to switch to a
software timer (I'm not currently sure how complex that would be to
implement, but I think stmmac takes this approach.)

That could make mac_validate_tx_lpi() redundant, but then I have a
stack of DSA patches that could use this callback to indicate that
EEE is not supported.

I don't have all the answers for this, so I was hoping to kick off a
discussion in the RFC patchset before submitting something that could
be merged, but that didn't happen.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

