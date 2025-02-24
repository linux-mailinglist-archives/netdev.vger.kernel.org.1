Return-Path: <netdev+bounces-169005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DFAA41F9C
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7307A27E5
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 12:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A025219302;
	Mon, 24 Feb 2025 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="crk26qRa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A312571B6;
	Mon, 24 Feb 2025 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401393; cv=none; b=eHb0q/quEAtpzxyFbcYcLiCLjefNs32LLuujx7eV54DoKb9CEVS7eKPPxOJpm5W+PNKLxCtFrUFBvGyXx8jyMQm84tIk8SnwyJkPDfxPDJBv5QyByaQk/LhvKmwySYOcIIk42vEcGs+ByAbUt5WqPA+rpnLHXUbFpdNlnDUe85w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401393; c=relaxed/simple;
	bh=artm3sYYZO++B9Dib2JcPiWfNmKPwS/KGkd1oxsTrP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDCJQ/pURbC+Yujw/W+kDfvFevdDl0QeAWjbYIB9nnmoJ/90Cto5st9QCxkJY1F03cxYkWfe+d7yT6mHk0G+bNK7EjkG8UbxdTMExD1vz9IxQlBuKOlcypQMHpHyjrIpX4PedY6+TDCAzmdxLWdHqKzpKhfbp8KF0BBJD4HUld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=crk26qRa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hJylRD8fzAq3eOuue35FX0OJEQQRNNr5WEQuWoBz8dI=; b=crk26qRaBe6Jax9eNVfq+d5M7I
	fKReB9gELCq0M7QRT2mRtHODhnfaFYp/cX54b/LqnCx59ypdK1/fw8AQuGKJtMFNN4eblc14CRGOQ
	F66q9y6ombCeIYf5Afbo4kAcx/qkGpgeDLyjPMwjFAmmMFeC4AZn71rmEvdYEbVH+gQ4nCK6GosD2
	/f5dPE8zzIO+8zCIw97f983HpA9OQ6dR0ZldLedO+oGJjRJF6dUnGcrKI+PUIduNFWu7KA0ObtaOK
	6Vfe3QB14s9F89+J9pyy7f9E3Q3Uf4bMqmwItzrcNyR6tQ21Sdi6zIQAF4LXXarVu4R3dTxno9+jX
	d6R80/Dg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49744)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmXtn-0006Gq-2H;
	Mon, 24 Feb 2025 12:49:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmXtf-00050L-1T;
	Mon, 24 Feb 2025 12:49:19 +0000
Date: Mon, 24 Feb 2025 12:49:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/12] net: pse-pd: pd692x0: Add support for
 controller and manager power supplies
Message-ID: <Z7xqz-Z5UhqBQXnc@shell.armlinux.org.uk>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
 <20250218-feature_poe_port_prio-v5-9-3da486e5fd64@bootlin.com>
 <20250224134222.358b28d8@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224134222.358b28d8@fedora>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 24, 2025 at 01:42:22PM +0100, Maxime Chevallier wrote:
> On Tue, 18 Feb 2025 17:19:13 +0100
> Kory Maincent <kory.maincent@bootlin.com> wrote:
> > diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
> > index 44ded2aa6fca..c9fa60b314ce 100644
> > --- a/drivers/net/pse-pd/pd692x0.c
> > +++ b/drivers/net/pse-pd/pd692x0.c
> > @@ -976,8 +976,10 @@ pd692x0_register_managers_regulator(struct pd692x0_priv *priv,
> >  	reg_name_len = strlen(dev_name(dev)) + 23;
> >  
> >  	for (i = 0; i < nmanagers; i++) {
> > +		static const char * const regulators[] = { "vaux5", "vaux3p3" };
> 
> Looks like the 'static' is not needed here :)

Have you checked the compiler output before saying that?

I've seen plenty of instances where "static" should be there but isn't,
leading to the compiler generating inline code to create the
array/struct on the stack.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

