Return-Path: <netdev+bounces-244269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E50CCB3694
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 17:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F08C33031317
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E0F304BD4;
	Wed, 10 Dec 2025 16:03:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49A53043B9;
	Wed, 10 Dec 2025 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765382625; cv=none; b=lS9qQfcyjsBI4/fbX4n2YwEIsXL+E+L5meNCcLhwTeiUmn38EUw4pV8xo7orUqWrKa2QYeDtK3QWt73GR2A5/Kas64vujCGlB7575bXOAfGaHGBEaow2XMY03NP7m6QneExO0AaCMOsavh5haj8bmUtJNX6iu8W5mn36lwtt6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765382625; c=relaxed/simple;
	bh=EuDvc8RbWbc7YsMJvwP+GEpbdfTHYr8YfIogmdCWGUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dC1Hsmu99ehqKhhAdzLU/+1MEqn9T5yuo3HgF7FmuG5xdzndcneV3+Ru1UhdCedxlE0WF/ztCtt3/uoxjRBALwwgcIIWfx0XQDwCzcD0S28DllOhQ5se6T2/N4dzhR3MrDM0MDms8tDJSJogwva0PQpvPMZkotlFz0vUWkWrktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vTMf9-000000005RX-22St;
	Wed, 10 Dec 2025 16:03:35 +0000
Date: Wed, 10 Dec 2025 16:03:30 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net v4 4/4] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <aTmZynWdLAG__mH2@makrotopia.org>
References: <cover.1765241054.git.daniel@makrotopia.org>
 <cover.1765241054.git.daniel@makrotopia.org>
 <76745fceb5a3f53088110fb7a96acf88434088ca.1765241054.git.daniel@makrotopia.org>
 <76745fceb5a3f53088110fb7a96acf88434088ca.1765241054.git.daniel@makrotopia.org>
 <20251210155249.bpjm2hkvujstxt4i@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210155249.bpjm2hkvujstxt4i@skbuf>

On Wed, Dec 10, 2025 at 05:52:49PM +0200, Vladimir Oltean wrote:
> On Tue, Dec 09, 2025 at 01:29:34AM +0000, Daniel Golle wrote:
> > [...]
> > @@ -665,6 +694,9 @@ static void gsw1xx_shutdown(struct mdio_device *mdiodev)
> >  	dsa_switch_shutdown(priv->ds);
> >  
> >  	dev_set_drvdata(&mdiodev->dev, NULL);
> > +
> > +	gsw1xx_priv = container_of(priv, struct gsw1xx_priv, gswip);
> > +	cancel_delayed_work_sync(&gsw1xx_priv->clear_raneg);
> 
> Nitpick: why did you place this after dev_set_drvdata(dev, NULL) and not before?
> The work item doesn't call dev_get_drvdata(), true, but it's one more refactoring
> step that needs to be taken care of if it should.

As the order of those two doesn't matter I thought the best would be
to do cancel_delayed_work_sync() as the last thing because it is
obviously correct. Eventhough even doing that at all doesn't matter
much in the shutdown() path anyway...

