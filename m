Return-Path: <netdev+bounces-50523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8C67F605F
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9691C2100D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4B925101;
	Thu, 23 Nov 2023 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EtcX4T8V"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C8DC1;
	Thu, 23 Nov 2023 05:35:08 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD7DD1C0007;
	Thu, 23 Nov 2023 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700746505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mI4znOI0zE5PCCzZTTeLMyK+ZXMtNz24QJhN8KXDmLA=;
	b=EtcX4T8VhqjpHCjMpiAz1lTycXWcOjenC90NFWYOwNIhxgMZCuHf2pxZbLcclEXAXOE63P
	2hu19ZFS7LgZITw3sRvmmVQkCWWbuy/9qOUihaTgl1p28zlnSIiHRoHYd/IZ+kTOQEB/1s
	jWV9pfUI8PxVdlKHpKUXh7WyYu160a0hFynJxTEcxbETVLmPIB7x2foY8DaUjh6UB44ST8
	hZjDRtQ/QaTMSacxb5rjNOlDvwncJKdnY4Qzs89ZlZ9yeYFikgaKK2vTxgDN3xGLD527tT
	Tevhxp97kPmtXnkFhTKio9ZFgG2aARv8x8AJzeIXQRToNSXG+FM9ZY0OAQOCbQ==
Date: Thu, 23 Nov 2023 14:35:02 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next v2 04/10] net: sfp: Add helper to return
 the SFP bus name
Message-ID: <20231123143502.3a9a9047@device.home>
In-Reply-To: <ZVyEe0zH8Zo1NLFO@shell.armlinux.org.uk>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
	<20231117162323.626979-5-maxime.chevallier@bootlin.com>
	<00d26b50-56f1-4eac-a37f-36cf321bd46a@lunn.ch>
	<ZVyEe0zH8Zo1NLFO@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Andrew, Russell,

On Tue, 21 Nov 2023 10:20:43 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Nov 21, 2023 at 02:00:58AM +0100, Andrew Lunn wrote:
> > > +const char *sfp_get_name(struct sfp_bus *bus)
> > > +{
> > > +	if (bus->sfp_dev)
> > > +		return dev_name(bus->sfp_dev);
> > > +
> > > +	return NULL;
> > > +}  
> > 
> > Locking? Do you assume rtnl? Does this function need to take rtnl?  
> 
> Yes, rtnl needs to be held to safely access bus->sfp_dev, and that
> either needs to happen in this function, or be documented as being
> requried (and ASSERT_RTNL() added here.)
> 
> The reason is that sfp_dev is the SFP socket device which can be
> unbound via sfp_unregister_socket(), which will set bus->sfp_dev to
> NULL. This could race with the above.
> 

That's right, I'll add an assert and document it, thanks for spotting
this.

Maxime

