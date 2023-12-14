Return-Path: <netdev+bounces-57281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78219812BEF
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 10:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3FCFB211CD
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA5030FBB;
	Thu, 14 Dec 2023 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tr1Ht980"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26100124
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702547295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++odV11f1uA7j8XWT0jl3NVCsYv9GbrEXePPToqzLEI=;
	b=Tr1Ht9805JUGtQ5XxuWsfLlcWJ5Mu79OU7514kM3mHJ9tWB2BQXYq8VlWtmdRZqL6LR2OX
	vdqYtJDm2/NBSCo75U0Gkj8Gk3wbT9QvQu7496gu7Al7HS1A0uIW4jPVCTEd/+v0jcy8tj
	a/H/pXO4bk4D61U2jhQH+h85HrVH9aU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-6iuOaqoFPMaFcUmcTkSHpg-1; Thu, 14 Dec 2023 04:48:14 -0500
X-MC-Unique: 6iuOaqoFPMaFcUmcTkSHpg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c5e71c71aso3075525e9.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702547293; x=1703152093;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++odV11f1uA7j8XWT0jl3NVCsYv9GbrEXePPToqzLEI=;
        b=MagDvTJhumFUJBopDScqyP+BTeinzaI1dIKtc5pG63BEABAphT1dt0dIfoMV6q3OwG
         xxLtqQs3NmOaXB4T2f8kYaN1qXcvOCru7nG4D5rSjzyXEdBDlaFZLKT4+Ak5jcHnVJP9
         b9nQHCnYIxrZsza8pDSGnP6a4YXFJVytyclJn2rcXJEeNFXWFh9bl35ySBji7/02SHNO
         lkp1x52pY9yYsn47K5MBlVPj6zR1H36VWIfzrz5wJEl8NErYda3uqCnsR0/i6mOQvyLY
         F7blBMTLkxWAKocP+pODv2KN3bqUNscEE3Hj/jkqgK0sTm9DQyXHNZvpkpFXXS3FChMG
         Q3Uw==
X-Gm-Message-State: AOJu0YyVgwCmrRIImqY1WvFCFh8zdVtuVNyr0sOCCRQhwnww9wigQCwK
	0eaRrmmGlcLe1qXIvqtzbG0FN+OFxyywxkDxwd1jmrhDkRU/iSEtld/SMKiPZibq6Q+kDYfUBtw
	v6mcCDY8QezR2scWmTQd5YpNB
X-Received: by 2002:a05:600c:1913:b0:40c:287a:1bba with SMTP id j19-20020a05600c191300b0040c287a1bbamr11637520wmq.2.1702547293105;
        Thu, 14 Dec 2023 01:48:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZnX3on012huwBfuDmFyuJArwEtuDd9RXFfT1+YSOXww57+t9dzPTR+Pp2s8z0BZEOpdyQ2A==
X-Received: by 2002:a05:600c:1913:b0:40c:287a:1bba with SMTP id j19-20020a05600c191300b0040c287a1bbamr11637503wmq.2.1702547292773;
        Thu, 14 Dec 2023 01:48:12 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-36.dyn.eolo.it. [146.241.252.36])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0040c46ba7b66sm15074406wmn.48.2023.12.14.01.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:48:12 -0800 (PST)
Message-ID: <6dd8d8b62d6db979d6c2197a4091ebc768e6610a.camel@redhat.com>
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
From: Paolo Abeni <pabeni@redhat.com>
To: Daniel Golle <daniel@makrotopia.org>, "Russell King (Oracle)"
	 <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Dec 2023 10:48:10 +0100
In-Reply-To: <ZXn_id6-XWYr2Seo@makrotopia.org>
References: 
	<102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
	 <20231212153512.67a7a35b@device.home>
	 <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
	 <ZXnNYJer0JrJxOsl@shell.armlinux.org.uk> <ZXn_id6-XWYr2Seo@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-13 at 19:01 +0000, Daniel Golle wrote:
> On Wed, Dec 13, 2023 at 03:27:28PM +0000, Russell King (Oracle) wrote:
> > On Wed, Dec 13, 2023 at 10:08:25AM +0100, Andrew Lunn wrote:
> > > On Tue, Dec 12, 2023 at 03:35:12PM +0100, Maxime Chevallier wrote:
> > > > Hi Daniel
> > > >=20
> > > > On Tue, 12 Dec 2023 00:05:35 +0000
> > > > Daniel Golle <daniel@makrotopia.org> wrote:
> > > >=20
> > > > > Calling led_trigger_register() when attaching a PHY located on an=
 SFP
> > > > > module potentially (and practically) leads into a deadlock.
> > > > > Fix this by not calling led_trigger_register() for PHYs localted =
on SFP
> > > > > modules as such modules actually never got any LEDs.
> > > >=20
> > > > While I don't have a fix for this issue, I think your justification
> > > > isn't good. This isn't about having LEDs on the module or not, but
> > > > rather the PHY triggering LED events for LEDS that can be located
> > > > somewhere else on the system (like the front pannel of a switch).
> > >=20
> > > SFP LEDs are very unlikely to be on the front panel, since there is n=
o
> > > such pins on the SFP cage.
> > >=20
> > > Russell, in your collection of SFPs do you have any with LEDs?
> >=20
> > No, and we should _not_ mess around with the "LED" configuration on
> > PHYs on SFPs. It's possible that the LED output is wired to the LOS
> > pin on the module, and messing around with the configuration of that
> > would be asking for trouble.
> >=20
> > In any case, I thought we didn't drive the LED configuration on PHYs
> > where the LED configuration isn't described by firmware - and as the
> > PHY on SFP modules would never be described by firmware, hooking
> > such a PHY up to the LED framework sounds like a waste of resources
> > to me.
>=20
> This was exactly my line of thought when posting the patch, however,
> Maxime correctly pointed out that the issue with locking and also
> what the patch prevents is registration of LED *triggers* rather than
> the PHY-controlled LEDs themselves. And having the triggers available
> is desirable even beyond the hardware offloaded case (which is probably
> the aspect we both were dealing with the most recently and hence had in
> mind). It is common to control another system SoC GPIO driven LED(s)
> representing the link status and rx/tx traffic, for example.
>=20
> So better we get to the core of it and fix the locking issue
> (for example by registering LED trigger asynchronously using
> delayed_work)...

I understand you are looking for a different solution, so let me mark
this patch accordingly.

--
pw-bot: cr


