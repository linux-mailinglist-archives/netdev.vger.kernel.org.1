Return-Path: <netdev+bounces-77522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CED5872167
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9811C22102
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 14:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB128663A;
	Tue,  5 Mar 2024 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HI2trvi5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E986122;
	Tue,  5 Mar 2024 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648691; cv=none; b=O+LpnM6GdxMvS863UfWRckA8x1PAD5A6D9EngsA1UY8ppQtKAp2dngE5VSZcHPn9B91rmBu+R93V6i6sEFoOfI30BjPbOrGgkt+CcK13ttGRKPP+EAHPkAIARu5QSi/ePn8GDpSgdNKVch34c9sHOsiOzTkUsGQq7ZxCiLa7IpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648691; c=relaxed/simple;
	bh=rby9JLSGTuoBcffipBf7GVYQGkuEynZiB9jSo67ZdOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEpORZPFBvaQ/7a0aTmg/owZTiuBmSMDqL6tvCfk1Iz2nAZYdSejSJqXvGhOWH0W1WRBLk7gcrS5meIoyTHNuEuvdOCKHtAy7TaKpttlqGVO9e9Jipl3F7lIxWhulAInZEJPXlaCluYycZwoWjo/SxSVGyo0UJJmbeRvj2nU0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HI2trvi5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y3qXUxkn6l40Cq+JpjQmhgzABt2ICxynEDg3FWDSFiE=; b=HI2trvi5YJDYdp7rbWYsNTKIEd
	Fjjchumq/iplIylqDntUbdiA54UtAqwAA8B1KzW0BZIOzp7aLCKv9zujlB6Cms/IgwOlIOOXUdqpm
	7oVP9SjTiOIr/USfxZb+6doIxIrFUcyA/wpUk8JfIoVEUksbizeHhvU7nTx1RKKnKnYgLaR1WU7s4
	tO+J2hBKvHtnxlGb13jXVoJg2Fir5GzdeTJn45QRjqClf6gcWrtRtBOT6Q2z7qkfTTSTVZIv87w1f
	csm0G+z4yyw7AJI6lbIBrwV8/1AmDEPveUm9oEfZVm9RY0We7sHdxE0/tq0lyHYETzn6GJKYhUC5d
	4v2JM9fA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46290)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rhVia-0007F7-1z;
	Tue, 05 Mar 2024 14:24:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rhViT-0005TU-7H; Tue, 05 Mar 2024 14:24:25 +0000
Date: Tue, 5 Mar 2024 14:24:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <ZecrGTsBZ9VgsGZ+@shell.armlinux.org.uk>
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <e056b4ac-fffb-41d9-a357-898e35e6d451@lunn.ch>
 <aeb9f17c-ea94-4362-aeda-7d94c5845462@gmail.com>
 <Zebf5UvqWjVyunFU@shell.armlinux.org.uk>
 <0184291e-a3c7-4e54-8c75-5b8654d582b4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0184291e-a3c7-4e54-8c75-5b8654d582b4@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 05, 2024 at 03:06:45PM +0100, Andrew Lunn wrote:
> > The only way I can see around this problem would be to look up the
> > PHY in order to get a pointer to the struct phy_device in the network
> > device's probe function, and attach the PHY there _before_ you register
> > the network device. You can then return EPROBE_DEFER and, because you
> > are returning it in a .probe function, the probe will be retried once
> > other probes in the system (such as your PHY driver) have finished.
> > This also means that userspace doesn't see the appearance of the
> > non-functional network device until it's ready, and thus can use
> > normal hotplug mechanisms to notice the network device.
> 
> What i'm thinking is we add another op to phy_driver dedicated to
> firmware download. We let probe run as is, so the PHY is registered
> and available. But if the firmware op is set, we start a thread and
> call the op in it. Once the op exits, we signal a completion event.
> phy_attach_direct() would then wait on the completion.

That's really not good, because phy_attach_direct() can be called
from .ndo_open, which will result in the rtnl lock being held while
we wait - so this is not much better than having the firmware load
in .config_init.

If we drop the lock, then we need to audit what the effect of that
would be - for example, if the nic is being opened, it may mean
that another attempt to open the nic could be started. Or it may
mean that an attempt to configure the nic down could be started.
Then the original open proceeds and state is now messed up.

I do get the feeling that trying to work around "I don't want the
firmware in the initramfs" is creating more problems and pain than
it's worth.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

