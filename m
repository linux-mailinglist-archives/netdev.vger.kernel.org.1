Return-Path: <netdev+bounces-100112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690798D7E6B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EAF2831C3
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB6A7E110;
	Mon,  3 Jun 2024 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jzQdBJbd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D886BFA7
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406548; cv=none; b=N3snyR5dVLNEXBnKtOXO/lcKc+dFTUbPynRCPyH29TXDhNfa7jOeNLWLbx54BO8dWgLPxgCJ514NAp/6L2yLab+slJpKr4EAGUZiEr8NSSrjvrNyPzbJQcETA3lhUv4njQF6QOm8VYuO7tXWKl4jGjVrNV/J2LzD8ODdA/pKZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406548; c=relaxed/simple;
	bh=CA7QhH8JCNHYO57Ao/KgDtAWzPycb4G4WIUu2c23j7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih6fx6+8O6cURi/oV0pL68ViAyKOl+ayj6pnMFleAQa+TQ07eTXjDf9J0DDYwCbwsK4QC2wbGAcPDaRbY1QWkhue8aqe2lSz7gC+xt+3WzR0QvHUCwHwYfICXZrzQV6Jj9iyaXtYicd43sK5fIhuYCDzhV7pnsbfTQNceWMVhsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jzQdBJbd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Rpg+gKZj8eQLCVGWgrEmxuzQNnpAd05t5v6kkUyzuQY=; b=jzQdBJbdJKKb/mGa9x5+qhH9zD
	7nhKQnxLlCiP1RHonk+JDPqPeQJQ24VntKfSFVY4TwMLBeROIjB6pBJQRc8srZ+YTiRQpLGQRhykH
	qKJ+V34AEWbkGIDOd5YP2WSPU5+uc7QRULScsXlk0ypFkqMyJW27zTW+AxKrFcxPWMBGOltej4AGc
	+Mwa3Kg8jqHWxj2g6jgf5rXvmYK6vS0A2RXYICOhwEfTSb+577OFd03R347PMVsA43v1tbyLkhfg2
	Pl9/otP7bzLCIuqLh12JRkda7qRGAF2+rGpaSczorSwYDvJYXTtTqkeQ+RlWPlS8ZPqj5aiobZik9
	2d9Va3qQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59558)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sE3tR-0002VG-1j;
	Mon, 03 Jun 2024 10:22:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sE3tR-0000Jb-EZ; Mon, 03 Jun 2024 10:22:17 +0100
Date: Mon, 3 Jun 2024 10:22:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
	kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
	hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v8 6/6] net: tn40xx: add phylink support
Message-ID: <Zl2LSfGqvPUvUoRT@shell.armlinux.org.uk>
References: <20240603064955.58327-1-fujita.tomonori@gmail.com>
 <20240603064955.58327-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603064955.58327-7-fujita.tomonori@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 03, 2024 at 03:49:55PM +0900, FUJITA Tomonori wrote:
> @@ -1374,6 +1375,10 @@ static void tn40_stop(struct tn40_priv *priv)
>  static int tn40_close(struct net_device *ndev)
>  {
>  	struct tn40_priv *priv = netdev_priv(ndev);
> +
> +	phylink_stop(priv->phylink);
> +	phylink_disconnect_phy(priv->phylink);

There is no need to pair both of these together - you can disconnect
from the PHY later if it's more convenient.

> +
>  	napi_disable(&priv->napi);
>  	netif_napi_del(&priv->napi);
>  	tn40_stop(priv);
> @@ -1392,6 +1397,14 @@ static int tn40_open(struct net_device *dev)
>  		return ret;
>  	}
>  	napi_enable(&priv->napi);
> +	ret = phylink_connect_phy(priv->phylink, priv->phydev);
> +	if (ret) {
> +		napi_disable(&priv->napi);
> +		tn40_stop(priv);
> +		netdev_err(dev, "failed to connect to phy %d\n", ret);
> +		return ret;
> +	}

Again, no need to pair phylink_connect_phy() close to phylink_start()
if there's somewhere more convenient to place it. Operation with the
PHY doesn't begin until phylink_start() is called.

My review comment last time was purely about where phylink_start()
and phylink_stop() were being called. It's the placement of these
two functions that are key.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

