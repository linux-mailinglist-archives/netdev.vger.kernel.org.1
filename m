Return-Path: <netdev+bounces-142996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101F29C0DA5
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DDA1C245D6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C19721642A;
	Thu,  7 Nov 2024 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pGQCKrzF"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37F188A3B;
	Thu,  7 Nov 2024 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003382; cv=none; b=ZqiF/ePPeRtFX8PkGKMnBkUqRUIafhM582OmgNB3Ay/Dzs9Bq3XKGSv8yRYOFaOywqPeQYF/0AU9Eu9VfxEFFni7P+cJWSlIiAMS4MQ+MK9t2EB1yH138f2sBFUJ2v6dXO4iCd3c8TFYVu6lbJk+cyqQt8xb7eIkAqOHzk4GKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003382; c=relaxed/simple;
	bh=tFHO/BZcxZoVyiqklKE/cJRqRtT8jk9I2aIRLc+QAd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQgesZxYWKiF0yzN7MEIgE7CRkpm1GWPZKWLauPpu4rBXrSpP7oA6BHvs3avg543eVb4lcTqgmW4NCHkxVPVpf41RAmnaFmZhyIFaOrpUGOu0qc2JNiwa2rOTnJfmNvfHQclLcg7EIGVPaVBUdVJYWWXF9YE9xyIi33lnDK6150=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pGQCKrzF; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9DFC20005;
	Thu,  7 Nov 2024 18:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731003378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aH+YamaB5+L+7dV8UCOYyw7UnZu/8epHdr5FqD/+g8=;
	b=pGQCKrzFC4Tjz/QbNUrWfas+lfJ3l8p0TO7a+cS3Gul4L9PmHWkojBPeePUxqTIJ/5vZAn
	OI2nE0iQF6m/GX8JOHjO7uJ6l+5pYUD8TBv1t9X9Tnu/HZIE8u1AvZlLADNHO8LL52BYkz
	PPliKyEPVRFd5ozDa+i4qYFJDKcw4OPHMVfL3HmBe/sk1Dcbb1BoIDoUZ9cwpfq4yhlGRL
	AQ8o8YKibuEqD18udqEyR1c37RkMjKGSvtmy5NLSMb5Jo/AYJB0B+kHBynMUCqszF1FW9r
	9Wz+STl+q0eTekgOIUwiIzhK+IoDBfD/Cj5CYOSer3yqGJIcUBmnEPQlkvSQjQ==
Date: Thu, 7 Nov 2024 19:16:17 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Herve Codina
 <herve.codina@bootlin.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 4/7] net: freescale: ucc_geth: Fix WOL
 configuration
Message-ID: <20241107191617.00e0584a@fedora.home>
In-Reply-To: <83151aa4-62e9-4be9-ae64-a728be004dae@lunn.ch>
References: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
	<20241107170255.1058124-5-maxime.chevallier@bootlin.com>
	<83151aa4-62e9-4be9-ae64-a728be004dae@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Andrew,

On Thu, 7 Nov 2024 18:49:00 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +	if (phydev)
> > +		phy_ethtool_get_wol(phydev, wol);
> > +
> >  	if (qe_alive_during_sleep())
> >  		wol->supported |= WAKE_MAGIC;  
> 
> So get WoL will return whatever methods the PHY supports, plus
> WAKE_MAGIC is added because i assume the MAC can do that. So depending
> on the PHY, it could be the full list:

> > +	if (wol->wolopts & WAKE_PHY)
> > +		ret = phy_ethtool_set_wol(phydev, wol);  
> 
> Here, the code only calls into the PHY for WAKE_PHY, when in fact the
> PHY could be handling WAKE_UCAST, WAKE_MCAST, WAKE_ARP etc.
> 
> So these conditions are wrong. It could we be that X years ago when
> this code was added only WAKE_PHY and WAKE_MAGIC existed?

Ah that's right indeed. So yeah my changes aren't enough, I'll go over
that patch again.

Thanks for spotting this,

Maxime

