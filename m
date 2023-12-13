Return-Path: <netdev+bounces-56793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C64810DDD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543521F21179
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89D322314;
	Wed, 13 Dec 2023 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZOxkW6T/"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EDDA7;
	Wed, 13 Dec 2023 02:06:26 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9EFC1C0007;
	Wed, 13 Dec 2023 10:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702461985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Vs/12xGUPJSfdWRakvw+41gON0/vxkSbuDwoub7QLg=;
	b=ZOxkW6T/ELZrsNiwkrU6xsQkgx1LcKuMCRHv61QxMzNGi0jWd3xgscZOFXvyUe2BTy6sel
	Bj2sjLZctVjWhC1Oz5MdvSTAj62j/7PZv3CNRjg/qqHalD54Lw9LLBzQGPIgaoj/R2hxTW
	CyG4NYjlS4W0H4X+0x/NeWIj9WBX9qr8OSyLPgCOCb4seW0G0fm2dwvpe0N/curKpsYiug
	TByedK/NZGHq5wV4s+UTbRrOs2CqXuAiYs3zO8B1jTk2TzLbPzd4Ye7SU9QuN5a7EmFsUy
	ivMjRqhfp0Wpu/cvJgH+Q4sDgVJ8uWnC8uRH4mjNjm9sh/+NrGU1Wdu5LIG5eQ==
Date: Wed, 13 Dec 2023 11:06:22 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <20231213110622.29f53391@device.home>
In-Reply-To: <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
	<20231212153512.67a7a35b@device.home>
	<ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
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

On Wed, 13 Dec 2023 10:08:25 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Dec 12, 2023 at 03:35:12PM +0100, Maxime Chevallier wrote:
> > Hi Daniel
> > 
> > On Tue, 12 Dec 2023 00:05:35 +0000
> > Daniel Golle <daniel@makrotopia.org> wrote:
> >   
> > > Calling led_trigger_register() when attaching a PHY located on an SFP
> > > module potentially (and practically) leads into a deadlock.
> > > Fix this by not calling led_trigger_register() for PHYs localted on SFP
> > > modules as such modules actually never got any LEDs.  
> > 
> > While I don't have a fix for this issue, I think your justification
> > isn't good. This isn't about having LEDs on the module or not, but
> > rather the PHY triggering LED events for LEDS that can be located
> > somewhere else on the system (like the front pannel of a switch).  
> 
> SFP LEDs are very unlikely to be on the front panel, since there is no
> such pins on the SFP cage.
> 
> Russell, in your collection of SFPs do you have any with LEDs?

I mean, aren't the led triggers generic so that it can trigger any
other LED to blink, and it's up to the user to decide ?

I do however see one good thing with this patch is that it makes the
behaviour coherent regarding triggers regardless if we have a
media-converter or not.

If we have a SFP bus with phylink as its upstream (SFP bus directly
connected to the MAC), then the phy is going to be attached through
phy_attach_direct(), and before this patch, led triggers will be
registered.

If we have an intermediate PHY acting as a media-converter and
connected to the SFP bus, then the phy isn't attached to the net_device,
and the triggers aren't registered.

So if in the end it doesn't make sense to register led triggers for
PHY in modules, it might be more coherent not registering them at all
as this patch does. What do you think ?

Thanks,

Maxime

