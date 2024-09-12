Return-Path: <netdev+bounces-127809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 555C69769C2
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90902839F3
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E37B1A4E86;
	Thu, 12 Sep 2024 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HV0I+FFk"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FF1A4E80;
	Thu, 12 Sep 2024 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145799; cv=none; b=fcQWl6CnVrt/FHfvjljCciN8Qkf2C4YYkbsPWv4ctd/veG4+U62QKeExcU+TIi4HRghY6iUf3YiCidlmCP3wO7s+LV4E9cV5PKIbQ+cfmovi2VRZ+/Ki6KddxGFLOPdM68AAFLLejFVhrGFzeUyrMZNl5O3anblV2jKpelFm9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145799; c=relaxed/simple;
	bh=+T8vqUPYHi4UPws9hKtp37b8q9Q2oGjpxc1UMd5Uhlk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMAjOEzOJN5xzOztFE5JZNQMibrnXQaNlvY6J2gUxO2UbUzyAt9l6t901gprzDj/eQnzuK25o84mNbzqe742r68NwSuJYZegbCGHpyvpndVXpMGI1liGkiK/c9pha8G8/4P7IAYxgvt8CAxPJ2VraxMqh8mF31PV1c3yk8ry/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HV0I+FFk; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62150E000B;
	Thu, 12 Sep 2024 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726145794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nPPSSngTJXCHRTKLyRZ30S/cKB+a4H4xJtx4gRKmu8=;
	b=HV0I+FFk4bpF/eRlPaw6c7+2wnIDgdEFx+tTPRBWWDfWv9qptJHiDnuAZAjZUp7XgAcJ7J
	aWhKVQzqDWxBkIHch+d6ECNXtOyhAFkzH6AUzXkEMeSU8TCI8Z8Q6lKmVic2g3KqGAjUS/
	fRMDz83v33UQmmdC69kyX8ETFf+E+GvgYJStoWYi4O9J4xgLFaC8Y1ulqO7s9+/tqqU65b
	pcoyebevW+pUxzdSpq3L7mqx8NlqbwWOXOlZhXoGwGXdlAACouik+AVFwTGxJ1NVN/Mj4O
	maPt6Q1JaM19aEvEYDPHUatQuQ0wLtNIMW5eBUMNhXI5NJVRxdtrjIYvpQVTug==
Date: Thu, 12 Sep 2024 14:56:31 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?S8O2cnk=?=
 Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 3/7] net: phy: lxt: Mark LXT973 PHYs as having
 a broken isolate mode
Message-ID: <20240912145631.74c20406@fedora.home>
In-Reply-To: <20240912122451.GM572255@kernel.org>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
	<20240911212713.2178943-4-maxime.chevallier@bootlin.com>
	<20240912122451.GM572255@kernel.org>
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

Hello Simon,

On Thu, 12 Sep 2024 13:24:51 +0100
Simon Horman <horms@kernel.org> wrote:

> On Wed, Sep 11, 2024 at 11:27:07PM +0200, Maxime Chevallier wrote:
> > Testing showed that PHYs from the LXT973 family have a non-working
> > isolate mode, where the MII lines aren't set in high-impedance as would
> > be expected. Prevent isolating these PHYs.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> >  drivers/net/phy/lxt.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
> > index e3bf827b7959..55cf67391533 100644
> > --- a/drivers/net/phy/lxt.c
> > +++ b/drivers/net/phy/lxt.c
> > @@ -334,6 +334,7 @@ static struct phy_driver lxt97x_driver[] = {
> >  	.read_status	= lxt973a2_read_status,
> >  	.suspend	= genphy_suspend,
> >  	.resume		= genphy_resume,
> > +	.flags		= PHY_NO_ISOLATE,
> >  }, {
> >  	.phy_id		= 0x00137a10,
> >  	.name		= "LXT973",
> > @@ -344,6 +345,7 @@ static struct phy_driver lxt97x_driver[] = {
> >  	.config_aneg	= lxt973_config_aneg,
> >  	.suspend	= genphy_suspend,
> >  	.resume		= genphy_resume,
> > +	.flags		= PHY_NO_ISOLATE,
> >  } };  
> 
> Hi Maxime,
> 
> This duplicates setting .flags for each array member
> updated by this patch.

Arg yes you're correct... Don't know how I missed that...

Thanks !

Maxime

