Return-Path: <netdev+bounces-219217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B56DDB4088F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 17:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4A31B26971
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B152F31A041;
	Tue,  2 Sep 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eI4ZNklj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D930FC33;
	Tue,  2 Sep 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825731; cv=none; b=rjLy/01xjs7QJ3HZ578PQxfMSz2wqr3W7Mc+MNbxUwN5U/5ca0Kinysh+twxYj3PBJI2KAjQYvDyajY1IQVJkPlhdbRxOkLIP0JSUctz4IFlHkHifeMWnpQb6nBlGAa5OeftNQnH1kZQ25tNbP0eymtJ06rwZN1AtXCtfxvNK6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825731; c=relaxed/simple;
	bh=syzP2MUe5ExWuloTy6E/G8+SoQFwyWf7K7Kj8XNTXeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBj1ZiwIzD3bRSDmID602yuZhrPUs6k3irKFyjAXaWSrKmxmNrm6eLiAz+RfZjH9LtBBuIYujxDKHi6L6uFVhxqrboI3JlD7hdfAHB00x8Gaprb58EgqG6RInOsyIcOoyH5z0mdusKwezC96ow3yHUMWvGQfvbdIBwsf7yIHQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eI4ZNklj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZLCJGtUs4SCQmM6ssgLmBMJmoimwe4GV67RpLL10wto=; b=eI4ZNkljF4ruOV7r/5melwfRgq
	JAqx41wIIYcEsIM5w3WGvpVD/+9czvbnOchkcWsWvagj1w4HpWZJP2K+1QvMXIEVtohrZYvSsRuru
	Hxu6I1pvlj0UBJAwO29pxeF3BuPOKgQThFEyqc9F4LnXKnkDOUmZOIC5RMGyNGziOzAk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utSch-006uCE-6U; Tue, 02 Sep 2025 17:08:39 +0200
Date: Tue, 2 Sep 2025 17:08:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next] net: phy: marvell: Fix 88e1510 downshift
 counter errata
Message-ID: <4b3e4339-93d5-4d14-b53f-43c5d379d2fa@lunn.ch>
References: <20250902-marvell_fix-v1-1-9fba7a6147dd@altera.com>
 <aLbyju1nKm5LXDDX@shell.armlinux.org.uk>
 <7b799cb3-ba9f-464e-a0a6-cad151742aab@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b799cb3-ba9f-464e-a0a6-cad151742aab@altera.com>

> > Also, what is a "link power down/up" ? Are you referring to setting
> > BMCR_PDOWN and then clearing it? (please update the commit description
> > and repost after 24 hours, thanks.)
> > 
> 
> Yes, I'm referring to setting and the clearing BMCR_PDOWN. Will update
> the commit description in the next version.

So it could be the bootloader left the PHY in powered down state, when
booting.

There is some not so nice logic in phy_attach_direct() which calls
phy_resume() when the MAC attaches to the PHY. So this case is covered
by that. But it would be good to comment in the commit message, and
maybe the resume function, that you are relying on this behaviour.

I do wounder if it should be more explicit, m88e1510_config_init()
also calls the workaround? You would then not need the comment.

	Andrew

