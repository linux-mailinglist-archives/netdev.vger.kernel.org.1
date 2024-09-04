Return-Path: <netdev+bounces-124895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A5D96B542
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2B228AA3A
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8511CB313;
	Wed,  4 Sep 2024 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cf/+eqqw"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49561CCB59;
	Wed,  4 Sep 2024 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439209; cv=none; b=Dn9y7LfhLqcjLiB1XKHPrCtgW5D3Bl+n8BwqMk/YJqHAwDjVTwmU0rx3HwRPBtmeB81mz5Q7BNevvlT3xwnbxhIA4dACfwBOn4SKn4gPd9qxhvFqrFtAeYXBA+/6s6ktAi2BDbQPAkO7OrWcxzxk8/mcVwUpByb4EELxbS4WiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439209; c=relaxed/simple;
	bh=v00CV/Izqm2vDJnjz1L9tutf+pvkFbjaJhWGfY682nY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7P50NhIjIr39BFyRP0krrjEK9lREp6xrQKzt9++bFstdsJEXaz2b/NnEIlZHu1ZAATWmq/QfUiqs4jmIgVv8qVGBwML3JyBIe9MIdAA3ppu+cEn3Wf1U6VgPLpld+MKKWWdkaTEg3BOpv5vB/8Clh1ORo3XTTuUWfMQEMc2404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cf/+eqqw; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 0AE92C0542;
	Wed,  4 Sep 2024 08:27:16 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 841AC240007;
	Wed,  4 Sep 2024 08:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725438434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06yNZMAas3qa1wzVuxc7+kvtibUzV5sjLz3xzS89tAQ=;
	b=cf/+eqqweQOsre9lGOCoZlwQB82NF5KgHhFDxEBJ3kea7y34PrJG2YOJ8EcobMrFLr2VtP
	PduHnq68WowKQv/152sHG1bFevwnhehvSy+prbdWCMgvutCVdHy6hQwqymN53Ly4ReT3ci
	Xcg6OLN+ofMHeZMOiiaJm9bpIcnJ/DfrtNKktx+PmV97fK8zPgvUESZ/c5jtRVPK81gWig
	Ek2BhzUzPCPPxBIRAxCtXPCcjioKU0i93L1tNkykdVwX8sYRqAU6crvov4Ut1Prsd8bxmm
	BYi9PlhKUHygMWuQP5kQjUDu9udhOX87jyNXpoKNl/OupRx+dU7PponFQ9axLA==
Date: Wed, 4 Sep 2024 10:27:11 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 Simon Horman <horms@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 3/7] net: ethernet: fs_enet: drop the
 .adjust_link custom fs_ops
Message-ID: <20240904102711.1accc8ce@fedora.home>
In-Reply-To: <480a16fd-a1eb-4ea0-b859-5d874ecc3b15@lunn.ch>
References: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
	<20240829161531.610874-4-maxime.chevallier@bootlin.com>
	<480a16fd-a1eb-4ea0-b859-5d874ecc3b15@lunn.ch>
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

Hi Andrew,

On Fri, 30 Aug 2024 23:06:08 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> > @@ -649,12 +649,7 @@ static void fs_adjust_link(struct net_device *dev)
> >  	unsigned long flags;
> >  
> >  	spin_lock_irqsave(&fep->lock, flags);
> > -
> > -	if (fep->ops->adjust_link)
> > -		fep->ops->adjust_link(dev);
> > -	else
> > -		generic_adjust_link(dev);
> > -
> > +	generic_adjust_link(dev);
> >  	spin_unlock_irqrestore(&fep->lock, flags);  
> 
> Holding a spinlock is pretty unusual. We are in thread context, and
> the phydev mutex is held. Looking at generic_adjust_link, do any of
> the fep->foo variables actually need protecting, particularly from
> changes in interrupts context?

Yes there are, the interrupt mask/event registers are being accessed
from the interrupt handler and the ->restart() hook. I can try to
rework this a bit for a cleaner interrupt handling, but I don't have
means to test this on all mac flavors (fec/fcc/scc) :(

Thanks for reviewing this,

Maxime


