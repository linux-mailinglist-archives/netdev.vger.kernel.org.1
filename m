Return-Path: <netdev+bounces-167773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D8AA3C35E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83BB17018B
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8B315CD52;
	Wed, 19 Feb 2025 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bIAHbkQx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6AA1E885;
	Wed, 19 Feb 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978210; cv=none; b=TnCGQ2/3KFj215GixL13NwxjjTNcN2WZFeURRZ0LNP40TzRh/kipTYIwAhT709Ow8lL6zFzOI1Ypl5AmN84yiHhZdGnydssdQkHw0dLSdL8QbLFbEKESkoDr42zPfOkrqjC7ZHC9KvbQ+BvcTDcSDtrI8u6Sn3nhAym2HkXgbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978210; c=relaxed/simple;
	bh=ZykFC8bnHwpmxrkNc+2ymmxT1VsaK/Ltu2/oL3ISzDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2LW1Xjf1gQ/r0CbIDb/v+CNrqPdO3ozW3pUUI8wTu7zv+/8rS2CUQlutl3SNpMMtu9PLH1+qztLyAyBRo2WxKUbpVILY33sOGPkS05fJk+9nJMPMk7bcC60fn3Z+YiWpIS4+rZCrTVo2L/Z4AEz98q21LCGRnK5yh2JraXInyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bIAHbkQx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7XNjSxYshEtTvXChmY5fi80Lo+W2gHUxjNLerZH4GJI=; b=bIAHbkQx/aLzCkOW+Qx6j602+6
	jT/V4PkuU1d6zs7eKtMXRUOb6gdGaIfV4qRrQ5epDKETwTLsmhoBmmt0T1wLlJwdRdKqSm7taSVl1
	1sB4TukoM31nqxr6hwYyLyzN/QCjb1U9zXw7AF+WAxbee+3SBON7Z9x9bRjOXT171Yw8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkloO-00FfIt-1k; Wed, 19 Feb 2025 16:16:32 +0100
Date: Wed, 19 Feb 2025 16:16:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Sky Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v2 3/3] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Message-ID: <87318b5f-e67d-417d-8149-e1d918b23568@lunn.ch>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
 <20250219083910.2255981-4-SkyLake.Huang@mediatek.com>
 <Z7WleP9v6Igx2MjC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7WleP9v6Igx2MjC@shell.armlinux.org.uk>

On Wed, Feb 19, 2025 at 09:33:44AM +0000, Russell King (Oracle) wrote:
> On Wed, Feb 19, 2025 at 04:39:10PM +0800, Sky Huang wrote:
> > +static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
> > +{
> > +	struct pinctrl *pinctrl;
> > +	int ret;
> > +
> > +	/* Check if PHY interface type is compatible */
> > +	if (phydev->interface != PHY_INTERFACE_MODE_INTERNAL)
> > +		return -ENODEV;
> > +
> > +	ret = mt798x_2p5ge_phy_load_fw(phydev);
> > +	if (ret < 0)
> > +		return ret;
> 
> Firmware should not be loaded in the .config_init method. The above
> call will block while holding the RTNL which will prevent all other
> network configuration until the firmware has been loaded or the load
> fails.

The aquantia and qt2025 drivers are good examples to copy.

	Andrew

