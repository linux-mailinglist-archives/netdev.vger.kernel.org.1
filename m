Return-Path: <netdev+bounces-126002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5160796F89C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 17:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE45A1F22E31
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45091D3193;
	Fri,  6 Sep 2024 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Po2zFaQV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A971D2F65;
	Fri,  6 Sep 2024 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637702; cv=none; b=P6lGoaDXAAq+/khCcBsXTJQ6DoGNOZxk7LUOxrfJy6KbGhFVv6dkWXsAzzBTqQOdb4ch8RPMgWITEPfGqwOEYoZqwN4RuNaGvMKxSOilw52QWPuLNKfFaUxySJTXEwloMqbd1wnMuRgEJOKDudDN736Z9qFdNSOYD3TDcTLhAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637702; c=relaxed/simple;
	bh=KmcM3UCxcc7R3t7reYXNQQgCkdkc8cBRJX7dLKQVRTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD5AjbdHUYGUAC7vCpin2w+VYH1+WYShotwDp/LH9SzdcJC3M3MLPAoQkeYh45cpqXtBxHVli7wCS4k1Qvk0Pr/kgvRN71YP6fqnx94oI0OFafp9zVJNyjAXbGK92UZhCWHd7OLM3hiNgWqqQWFYSz2tL9+bgxZRAzKXNH8y7DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Po2zFaQV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QnV59Anz5y/x5uuidyf42ziLN+anSmW8b4PnB5tiUmg=; b=Po2zFaQVmZezwNAoU3m9YQ0bGD
	WF8auzB1ZJ4+0AbVdTQqPDOVVLUoIYsdvX6qbYZlT2I9N2Af1azxdWZa8ZcFIqW2GwsSSxMvnGzjz
	d4B+5hOL004jbS1d8FD3QYAepS1wOUAL2fwNf8HYQ/kvCOGmURF6PJqZRYV2s8OYqazY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smbBw-006qC7-4j; Fri, 06 Sep 2024 17:48:08 +0200
Date: Fri, 6 Sep 2024 17:48:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ftgmac100: Fix potential NULL dereference
 in error handling
Message-ID: <6c60860b-dd3c-4d1c-945b-edb8ef6a8618@lunn.ch>
References: <3f196da5-2c1a-4f94-9ced-35d302c1a2b9@stanley.mountain>
 <SEYPR06MB51342F3EC5D457CC512937259D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB51342F3EC5D457CC512937259D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Fri, Sep 06, 2024 at 06:06:14AM +0000, Jacky Chou wrote:
> Hello,
> 
> > 
> > We might not have a phy so we need to check for NULL before calling
> > phy_stop(netdev->phydev) or it could lead to an Oops.
> > 
> > Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/net/ethernet/faraday/ftgmac100.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> > b/drivers/net/ethernet/faraday/ftgmac100.c
> > index f3cc14cc757d..0e873e6f60d6 100644
> > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > @@ -1565,7 +1565,8 @@ static int ftgmac100_open(struct net_device
> > *netdev)
> >  	return 0;
> > 
> >  err_ncsi:
> > -	phy_stop(netdev->phydev);
> > +	if (netdev->phydev)
> > +		phy_stop(netdev->phydev);
> When using " use-ncsi" property, the driver will register a fixed-link phy device and 
> bind to netdev at probe stage.
> 
> if (np && of_get_property(np, "use-ncsi", NULL)) {
> 
> 		......
> 
> 		phydev = fixed_phy_register(PHY_POLL, &ncsi_phy_status, NULL);
> 		err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
> 					 PHY_INTERFACE_MODE_MII);
> 		if (err) {
> 			dev_err(&pdev->dev, "Connecting PHY failed\n");
> 			goto err_phy_connect;
> 		}
> } else if (np && of_phy_is_fixed_link(np)) {
> 
> Therefore, it does not need to check if the point is NULL in this error handling.
> Thanks.

Are you actually saying:

        if (netdev->phydev) {
                /* If we have a PHY, start polling */
                phy_start(netdev->phydev);
        }

is wrong, it is guaranteed there is always a phydev?

	Andrew

