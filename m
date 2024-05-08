Return-Path: <netdev+bounces-94547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9C98BFD1D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E40283C9D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F06B182CC;
	Wed,  8 May 2024 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YsDzDW2A"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C069B8F40;
	Wed,  8 May 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171431; cv=none; b=RBuunDDeoToDdjsEi2uQ7qFPCe08SKfpR4gD2Z1zB6IqQzCnRX7St4PqghdedzBCKjqe4QQYNSniP26KOQ4hxmKsuYZ5VsFwHEPUkHehS3yc5TFmSMTHFDXUMpvfNOPn1az517okh2RxXS2iIVAbs2v8nwf+8Ebm0RPry/aH4IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171431; c=relaxed/simple;
	bh=n2zx+VkOi/JkKFYVmWoia6SLsAL7lL33lDj+4RPAed4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzDniAVO2SIR5uomY3CT0z70HhIfT0eKgl13Jpq/0h1+0ph6U4w3/kdIACOjYj3MUm0LRx8H4U9gopSbQz9BdYCN9VFG8UAfcbZxFciO+f8AP0HgRAoa7mQ0HrGRP8uTIurikYCKdi3O0yfW/FBZHLywBilH2HGzc56ZSaI+vSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YsDzDW2A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G0EgRcxHPYVYNFfngVUMS5fl9BPyKfiAOc6TK4fQlus=; b=YsDzDW2A+bVrOGPszxwm4oD4pi
	CO2xvST/CSj+z8fQ2InMekf0lKYl0rOLSNpPabRc0iChULUg45TXtjH4aLhJ3C5vaTqfcSX7QLZu/
	x0TCY9uWV/xoOOSP0i1ui1oqWWRzq/5YpNWtL3V2Qs0hHij8xb/AoLiJ32yXWcE6Vvf0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4gRB-00EwrQ-Dp; Wed, 08 May 2024 14:30:21 +0200
Date: Wed, 8 May 2024 14:30:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 3/3] net: phy: mediatek: add support for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <577176af-9f6c-45f9-824f-2b4ca762b2f7@lunn.ch>
References: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
 <20240425023325.15586-4-SkyLake.Huang@mediatek.com>
 <ZiocBmBWiNnbeyGq@shell.armlinux.org.uk>
 <4ccd437ee744382a8483ffe71d06cd495dacec71.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ccd437ee744382a8483ffe71d06cd495dacec71.camel@mediatek.com>

> > > +ret = request_firmware(&fw, MT7988_2P5GE_PMB, dev);
> > > +if (ret) {
> > > +dev_err(dev, "failed to load firmware: %s, ret: %d\n",
> > > +MT7988_2P5GE_PMB, ret);
> > > +return ret;
> > > +}
> > 
> > This will block for userspace while holding phydev->lock and the
> > RTNL.
> > That blocks much of the networking APIs, which is not a good idea. If
> > you have a number of these PHYs, then the RTNL will serialise the
> > loading of firmware.
> > 
> I'm not sure I really get this. MT7988's internal 2.5Gphy is built
> inside SoC. We won't have a number of these PHYs.

How long does firmware download take? If you are holding RTNL you are
blocking all other network configuration. How many Ethernets does this
device have? If it is just one, it is not too bad, but if there is a
built in switch, you cannot be configuring that switch at the same
time firmware download is happening...

     Andrew

