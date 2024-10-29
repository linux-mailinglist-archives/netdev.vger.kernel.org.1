Return-Path: <netdev+bounces-139920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1F79B49D5
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A6D1F237D0
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC6A1DE3B7;
	Tue, 29 Oct 2024 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jEdd1JSm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5381E480
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205445; cv=none; b=FSlVgVJBdP+atWbtacFtyjBbvNjMimmoORR9S2R+g2QdkRuxJf+QK7lZbrQMd0V21qDjOgikLGylVIH/jTzo91hFXb/a60hqSylRkwJGVpChYC9NTCnwbbUvTKzSlE5OtFb/KOBsB6CEWN7yWh+sbnEuugSHzgqJxpGoxexdIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205445; c=relaxed/simple;
	bh=26JU792tMZ+DTd+tUSfIStqVRyYegJXJtrqmGK2k0C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ko6E3y8WMqAOfsFux4EgaBeMAE2NGqK5wDqZaTIanT2bnSX6KcgXcUplTrXBDDE7T6V6IkLEu0mkmfxwaTCCCkXcm+R/K/OkzsaIA5akaWkRrstQWH0MbYGbcvcRAWlPhviSsFUemBCiP0UzAwf/01iXQJImdkr8MXUn+JZgLWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jEdd1JSm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XjYoVT8+zzqVkAo2JwyXg7lAboyC1q+Ar2CIR/LJWLY=; b=jEdd1JSmhzBaCiAwq54HzYX8xP
	cu2PskUuWaCfA4RFMGiIsUEj9HH159fMOjFBYfwGwLBH6bnDatdruqWTSKlO7W8AsKvvAaFZfIdXO
	YoWpt7x+JQX0D4DUYQ3/Fc4Okn6l5KUUdpzyrM92a++7/erJWDTWl8Mb7fn6rMaPIaxU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5lT9-00BZd3-2A; Tue, 29 Oct 2024 13:37:07 +0100
Date: Tue, 29 Oct 2024 13:37:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Jacky Chou <jacky_chou@aspeedtech.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: ethernet: ftgmac100: prevent use after free
 on unregister when using NCSI
Message-ID: <29efcfe2-852d-4df2-9b9c-a06b4fd2deed@lunn.ch>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
 <20241028-ftgmac-fixes-v1-1-b334a507be6c@codeconstruct.com.au>
 <fe5630d4-1502-45eb-a6fb-6b5bc33506a9@lunn.ch>
 <0123d308bb8577e7ccb5d99c504cec389ba8fe15.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0123d308bb8577e7ccb5d99c504cec389ba8fe15.camel@codeconstruct.com.au>

On Tue, Oct 29, 2024 at 12:32:53PM +0800, Jeremy Kerr wrote:
> Hi Andrew,
> 
> > ftgmac100_remove() should be a mirror of ftgmac100_probe() which does
> > not register the ncsi device....
> 
> Sure it does:
> 
>     static int ftgmac100_probe(struct platform_device *pdev)
>     {
> 
>         /* ... */
> 
>         if (np && of_get_property(np, "use-ncsi", NULL)) {
>                 if (!IS_ENABLED(CONFIG_NET_NCSI)) {
>                         dev_err(&pdev->dev, "NCSI stack not enabled\n");
>                         err = -EINVAL;
>                         goto err_phy_connect;
>                 }
> 
>                 dev_info(&pdev->dev, "Using NCSI interface\n");
>                 priv->use_ncsi = true;
>  =>             priv->ndev = ncsi_register_dev(netdev, ftgmac100_ncsi_handler);
>                 if (!priv->ndev) {
>                         err = -EINVAL;
>                         goto err_phy_connect;
>                 }

Ah, OK, i missed that.

However, _open and _stop are not mirrors.

For ftgmac100_open():

        if (netdev->phydev) {
                /* If we have a PHY, start polling */
                phy_start(netdev->phydev);
        }
        if (priv->use_ncsi) {
                /* If using NC-SI, set our carrier on and start the stack */
                netif_carrier_on(netdev);

                /* Start the NCSI device */
                err = ncsi_start_dev(priv->ndev);
                if (err)
                        goto err_ncsi;
        }


ftgmac100_stop

        if (netdev->phydev)
                phy_stop(netdev->phydev);
        if (priv->use_ncsi)
                ncsi_stop_dev(priv->ndev);

The order should be reversed, you undo in the opposite order to what
you do. This is probably not the issue you are having, but it does
show this driver has ordering issues. If you solve the ordering
issues, i expect your problem goes away.

	Andrew

