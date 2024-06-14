Return-Path: <netdev+bounces-103627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54397908D3C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6975B27D9C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E9EAFA;
	Fri, 14 Jun 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="k3e6TuBa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2BF26AF2;
	Fri, 14 Jun 2024 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374662; cv=none; b=r6z2aAyHUOBKAcL/NsDz0U8lSKq/qJRJI6HKD/rLTVlyQC0MPmm5VY+/A2vD6IPt/ekoeJxg5VQmYOilFL/WkI7oLLH4ypZoMoBaUuARzivv7clW++t4JQKyJBx48K4+XsuKH5XOSiwy6WltXU1XR29C12+NgIG71VczPGZOf50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374662; c=relaxed/simple;
	bh=Nt/2DTMzSujJpPW/B1zBUuD6ETOJ5+VA2K8dNsUozys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoY7AgMai4pA0cGqBofRPPmYRdbyUAVXOCcBwWGJhuQFwIkxwkfcq1UyLc/bJYIgx3xEPNBI7oe5r1Ha3O3Si3qR4ynkQHSn6+wpLVT9QvEIZJM9ZWMA9K5pirXMzkx4B0bDpvNgVZRDJGCNWpsHQu6flQYndHppBQbdZwGgFe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=k3e6TuBa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C7X7EahV4cIPLf5JVH6Zebq6D2DVt1vf+WoErTJKBv8=; b=k3e6TuBaegJEL92ko01jo5FeIh
	KB5XKUUMI+9bhtbE9Q6awoncdpLei6S9buValvVNHb0V0puWuVtTOMgLbGexlq+FitcAAmh1KjEN4
	eTfDGcg9dYCXBskYLQEa12dl7vGlOz91liwcvrop6yOu1Uy4+cjyfM5KA634OWjHnIUM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sI7kA-0004Iu-87; Fri, 14 Jun 2024 16:17:30 +0200
Date: Fri, 14 Jun 2024 16:17:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
	bryan.whitehead@microchip.com, sbauer@blackbox.su,
	hmehrtens@maxlinear.com, lxu@maxlinear.com, hkallweit1@gmail.com,
	edumazet@google.com, pabeni@redhat.com, wojciech.drewek@intel.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V4 1/3] net: lan743x: disable WOL upon resume to
 restore full data path operation
Message-ID: <052f32e1-0a6b-4eae-a4d8-727a0d933d7e@lunn.ch>
References: <20240612172539.28565-1-Raju.Lakkaraju@microchip.com>
 <20240612172539.28565-2-Raju.Lakkaraju@microchip.com>
 <ZmqjYEs0G9pGQTog@shell.armlinux.org.uk>
 <ZmvHgg5SDYlrO9yB@HYD-DK-UNGSW21.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmvHgg5SDYlrO9yB@HYD-DK-UNGSW21.microchip.com>

On Fri, Jun 14, 2024 at 10:00:58AM +0530, Raju Lakkaraju wrote:
> Hi Russell King,
> 
> The 06/13/2024 08:44, Russell King (Oracle) wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Wed, Jun 12, 2024 at 10:55:37PM +0530, Raju Lakkaraju wrote:
> > > @@ -3728,6 +3729,30 @@ static int lan743x_pm_resume(struct device *dev)
> > >               return ret;
> > >       }
> > >
> > > +     ret = lan743x_csr_read(adapter, MAC_WK_SRC);
> > > +     netif_info(adapter, drv, adapter->netdev,
> > > +                "Wakeup source : 0x%08X\n", ret);
> > 
> > Does this need to be printed at info level, or is it a debug message?
> 
> Print at info level helps the tester/sqa team to identify the root cause of
> the wake and confirm the test cases.
> In general, tester does not enable debug level messages for testing.
> 
> Still, if we need to change from info to debug, i can change.
> Please let me know.

We are not really writing a kernel for the tester/SQA team, but the
end users. Do the end users find this log message useful? Can they
decode some hex value into something meaningful?

I'm surprised the test case cares what caused the wakeup. So long as
it does wake up, does it really matter what the source was?

	Andrew

