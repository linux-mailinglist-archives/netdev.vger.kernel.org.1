Return-Path: <netdev+bounces-122740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBB9962642
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC8C284889
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82A3172BA9;
	Wed, 28 Aug 2024 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HcBGrfRj"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA08D1741EF;
	Wed, 28 Aug 2024 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845475; cv=none; b=OUk5WadX4jKT6MdHVLSqng7KaXFnIjcm5N5jUBIBpmg/ysHTyjE+lklaPFZSUJSwJec3c0FheDmERSAfLlur9Zq0u2XC3XDPucka44R2o3xzKcscfT7xSMDGhHGknlOQnjmcMH7siD34eiEap2d5u0mlMvTNXOGxuIq6UFOmo0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845475; c=relaxed/simple;
	bh=/6ItpGSgxfSMvfCzneEzzc/mwZlXms4u9zN1lgB+VIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYsy+UEhBNVwHw/+ZxjIlOELdNLc22/78BhGDTEdFmABkxa8sjf1G/Q3irYlfIQmvBZRz/lruES24JF4M4X+1r3SBJgryBjvFXZJ0AnKeOy7tDqvcD+OOpMu4LPR0y3Tadq9ZgJ+7bDx4iTe/yYdX2U/FXrD/80hP3KrGmSGJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HcBGrfRj; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 84C0E60008;
	Wed, 28 Aug 2024 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724845464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdD46+xqETLLnoGEn/pP5MsKWihrd270ooLz0K2h75c=;
	b=HcBGrfRjAhBd30Zf6fNvkjki3tNGiz2EvkSsWYMAVN+lDUNQg5RZaypgzQ3B6udHdt8I6E
	2hfJT1I3x68NPMT4n+WAT+RpE71//VsJ0rrSGSrEtzXTcd1Vq/txPkGVg2AGzFfPIDxYeD
	SuUSb5cndSYqRV235OkubKvxp5DJyCsDmmve5t5n6SLPCOeYeD8aS41dJ0WjF6eC8FDENz
	PcLIhN++hlledYtERjnVkQGqrxvE4XQrIBqrHTv+heMzxXBdnaTxOEgv/4Ar5PAi+eg9We
	1yX7cqFx/5m1zitXg6JPsSEy6gIFOXVSlLDWUhRK08RY9JbsUzZdTLWq9aMATQ==
Date: Wed, 28 Aug 2024 13:44:13 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 6/6] net: ethernet: fs_enet: phylink conversion
Message-ID: <20240828134413.3da6f336@device-28.home>
In-Reply-To: <Zs7+J5JWpfvSQ8/T@shell.armlinux.org.uk>
References: <20240828095103.132625-1-maxime.chevallier@bootlin.com>
	<20240828095103.132625-7-maxime.chevallier@bootlin.com>
	<Zs7+J5JWpfvSQ8/T@shell.armlinux.org.uk>
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

Hi Russell,

On Wed, 28 Aug 2024 11:38:31 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Aug 28, 2024 at 11:51:02AM +0200, Maxime Chevallier wrote:
> > +static int fs_eth_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> > +{
> > +	struct fs_enet_private *fep = netdev_priv(dev);
> > +
> > +	if (!netif_running(dev))
> > +		return -EINVAL;  
> 
> Why do you need this check?
> 

I included it as the original ioctl was phy_do_ioctl_running(), which
includes that check.

Is this check irrelevant with phylink ? I could only find macb and
xilinx_axienet that do the same check in their ioctl.

I can't tell you why that check is there in the first place in that
driver, a quick grep search leads back from a major driver rework in
2011, at which point the check was already there...

Regards,

Maxime

