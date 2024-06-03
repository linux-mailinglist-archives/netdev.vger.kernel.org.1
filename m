Return-Path: <netdev+bounces-100226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99668D83A8
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7182B2874EC
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C29112CD89;
	Mon,  3 Jun 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YmqAThia"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8612D1F4
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420423; cv=none; b=okUwG8IDu9XHciXOktlTVJk3j9SrwWKJMP5j4K8ObNq9nfxHCPiMnk5dUGGCvwFNUS2kyrT0w0rDbn3cuIL1iYsG4N561FPO57YHv6TokmBorH053h0KA75MzTSN3EgX04Z6TgjXpcBi3f/Gxe9ONchFtGXxDkaCx6mm2BdvBqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420423; c=relaxed/simple;
	bh=8RbAxDD5eAPkDv4e6g2pnM/T2LBNM60OJrlfUb0BYec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIQQiq3KczI5PoKE/yl1D6QLJp9fWjpwiHx7c55CHtGgUvrTSa4YHl/feWD+U8M98rWBtnA/oTwdjntK/ZJWCxX4lOQU9k4rcNLmlzTGRvPm+az0Ch1sFyvP1l9ZLfJEX075DA4Rwai3ZHjLXSBYlj0eHbpksUYaWZJjd4nXeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YmqAThia; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9k5llSw7uV7E0dFYFpqr6kc0EeSdoCS15icfjfG2pGc=; b=YmqAThiaqjOZLeBsrUE1xiBcCj
	elN48mdxMGwWWmXVDj4kbvlO8vKOnrJ3MkS3RdRtfsWitzqKeTSOI6QYsbONzmbLUMFofNHrToeoy
	jveoHzy/DqvJQu5weyfhz0YB0/ozAUOkebRHmtbaG+IS0W5AFqV8XcNQczpKEfGpYlyxL5l/yZHW4
	JgvCTrOFtRDRmZl487l5jaoPuLDEKpo9+4dLm96+CMowg4VFwZA2VHUTOfaug8E9m/57AUj0dCELY
	xhJv7l6DqjHE16qaH7k/cmmdH5olh/DC8TLqcHxMKo5GTa4eYnKa2mYgIP9Ofb7vzuWAqzkdkWinG
	7vTe8ttw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50492)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sE7VG-0002ll-33;
	Mon, 03 Jun 2024 14:13:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sE7VI-0000So-6f; Mon, 03 Jun 2024 14:13:36 +0100
Date: Mon, 3 Jun 2024 14:13:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
	kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
	hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v8 6/6] net: tn40xx: add phylink support
Message-ID: <Zl3BgH3sSd1YyomC@shell.armlinux.org.uk>
References: <20240603064955.58327-1-fujita.tomonori@gmail.com>
 <20240603064955.58327-7-fujita.tomonori@gmail.com>
 <Zl2LSfGqvPUvUoRT@shell.armlinux.org.uk>
 <20240603.205455.1265693633847576919.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603.205455.1265693633847576919.fujita.tomonori@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 03, 2024 at 08:54:55PM +0900, FUJITA Tomonori wrote:
> On Mon, 3 Jun 2024 10:22:17 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Mon, Jun 03, 2024 at 03:49:55PM +0900, FUJITA Tomonori wrote:
> >> @@ -1374,6 +1375,10 @@ static void tn40_stop(struct tn40_priv *priv)
> >>  static int tn40_close(struct net_device *ndev)
> >>  {
> >>  	struct tn40_priv *priv = netdev_priv(ndev);
> >> +
> >> +	phylink_stop(priv->phylink);
> >> +	phylink_disconnect_phy(priv->phylink);
> > 
> > There is no need to pair both of these together - you can disconnect
> > from the PHY later if it's more convenient.
> 
> I see. Seems that there is no reason to call phylink_disconnect_phy()
> later so I leave this alone.
> 
> >> +
> >>  	napi_disable(&priv->napi);
> >>  	netif_napi_del(&priv->napi);
> >>  	tn40_stop(priv);
> >> @@ -1392,6 +1397,14 @@ static int tn40_open(struct net_device *dev)
> >>  		return ret;
> >>  	}
> >>  	napi_enable(&priv->napi);
> >> +	ret = phylink_connect_phy(priv->phylink, priv->phydev);
> >> +	if (ret) {
> >> +		napi_disable(&priv->napi);
> >> +		tn40_stop(priv);
> >> +		netdev_err(dev, "failed to connect to phy %d\n", ret);
> >> +		return ret;
> >> +	}
> > 
> > Again, no need to pair phylink_connect_phy() close to phylink_start()
> > if there's somewhere more convenient to place it. Operation with the
> > PHY doesn't begin until phylink_start() is called.
> > 
> > My review comment last time was purely about where phylink_start()
> > and phylink_stop() were being called. It's the placement of these
> > two functions that are key.
> 
> Understood. Calling phylink_connect_phy() first in this function looks
> simpler. I modified the code in the following way:
> 
> @@ -1385,13 +1390,20 @@ static int tn40_open(struct net_device *dev)
>  	struct tn40_priv *priv = netdev_priv(dev);
>  	int ret;
>  
> +	ret = phylink_connect_phy(priv->phylink, priv->phydev);
> +	if (ret) {
> +		netdev_err(dev, "failed to connect to phy %d\n", ret);
> +		return ret;
> +	}
>  	tn40_sw_reset(priv);
>  	ret = tn40_start(priv);
>  	if (ret) {
> +		phylink_disconnect_phy(priv->phylink);
>  		netdev_err(dev, "failed to start %d\n", ret);
>  		return ret;
>  	}
>  	napi_enable(&priv->napi);
> +	phylink_start(priv->phylink);
>  	netif_start_queue(priv->ndev);
>  	return 0;
>  }

LGTM, thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

