Return-Path: <netdev+bounces-103530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C16908733
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A65286204
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4F9190680;
	Fri, 14 Jun 2024 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fZkJ3EAP"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F827E574;
	Fri, 14 Jun 2024 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356849; cv=none; b=dHvlOsPA1sxr3zrIgd3zb4+KgC7oJCACzmnX58HrHt0WVLhHBej9kEZdLUvtQ7mn5oUOphXsTk2bR6w2RCplJb3ajSwIofgh7dkMtmvCRL/1lV7VLHMh8THrakE+8tZO4XNi5ADRKCp0kIsmUAGGEY5WalH1lI/5sLcqeRq2bLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356849; c=relaxed/simple;
	bh=HshnEux44yjCDxWGvCAW64D2WirZpynJCuI3AZAPo6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/p8wB2l4QDaYKDtpfBsLBtZjQ25S1NoPE9h3l0kBhxFMcCB453w105rsPnj8nSEAXz/u++o9IeiQsktwBde+yxqjALUwXHsgzrF6zsFy042OaB6D7j7mzFkf73rE3PSvEcI+IL+o3mcrYrzwzjXfy1Xcm3qqp7Go2UJKyiaWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fZkJ3EAP; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8344FF808;
	Fri, 14 Jun 2024 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718356845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIukM7uEAP6PimUjtjH6s1SAkBrtqNLDUxaSMzE1W20=;
	b=fZkJ3EAPxMmd6VJBQSst59XRrdpqTPoXVtEfgrOB/Hbhs4Pa5aHMkv3FCG/dlRRpyyVyE3
	yBWhcNpUVkbXz74M07qluyKfTa8cLBR8kzpYn9DgK/X9kPMk5j519Q2M7rozX6l+qaWLnr
	9tJF938iWHWchRetO9g3rhLYtQvaQcUAAGJpcXvH5NLW/JRSNXQj7fUFlQ5gvL9+FttmLo
	xLYF37w/2V5ndaRDjeS4indP59/QEW3OiHyBQ8sGuy4jWZkLmCeLpqAhgAjLjSrsFLh2xI
	yQj4APgy3CQq7G3dekYTGO7p4RVP9xlUjFCDkXBap71WMOWduyaR+FobTL95+g==
Date: Fri, 14 Jun 2024 11:20:41 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [PATCH net-next v13 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20240614112041.3560ebe2@fedora.home>
In-Reply-To: <20240613175819.035a1e8e@kernel.org>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
	<20240607071836.911403-2-maxime.chevallier@bootlin.com>
	<20240613175819.035a1e8e@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Jakub,

On Thu, 13 Jun 2024 17:58:19 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri,  7 Jun 2024 09:18:14 +0200 Maxime Chevallier wrote:
> > +static inline struct phy_device
> > +*phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)  
> 
> nit: * on the previous line

I'll address that, thanks for reviewing !

Maxime

