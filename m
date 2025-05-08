Return-Path: <netdev+bounces-189009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70236AAFD8D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BE81C252F6
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4FC27510C;
	Thu,  8 May 2025 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vQjUPnLr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9322B8C6;
	Thu,  8 May 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715505; cv=none; b=ZMQhW0OgkVpaDEZRPgh4zMnqvrrlRIumE0jP5FUl6yxI0UQfhB1+qpyubyOv7Zf2PK5q2Ct9pjTGlU1FxjybOd5WMTFaC14b/mJez4M2U9RVVHD6WRW9vvmnEt5680Jjy8WOa8E9Y3BlfnM6oK75amhkhkq0dJGj1pY4aUyVBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715505; c=relaxed/simple;
	bh=/sNPvG0ENQUQrEvkPZLj6ZDKgSFmQlNMnwiU+PmgcWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWenOgQ4NynWMF0hUaTvFTwQFL0h8KWwXXp3e7650ddi7UIF/Jp2MKXwYG3JY09iBsuSPKXydXfQycDtnMcc2gRGdPI+LQdhtqXz3yGpAyF8ru21diRhlt3nSNpjwYsLpSZSKlCOSTwhSL4Z9zlhUJEjncO0yGHbhujrwuz7vJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vQjUPnLr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=noe/tboawxIfBQOQyfOAvbZSyUFlieRMvf5FVsNbb6A=; b=vQjUPnLrdrqweZTaS5lPqgwbNx
	3Bxbh8AeHZPUZX7l2xTIkQfNggEf09H6MFZCeZBpgA5eBMF9aplKMQWDlGTHx6+XL/gdb+6jAoifC
	b2D2CCCDDMXbzYck547DqwA/9wE6F1SyXTseCfwQgNKEpK1MKZ2owuRfea6bQYJs6/Q0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uD2UZ-00C0yU-7M; Thu, 08 May 2025 16:44:55 +0200
Date: Thu, 8 May 2025 16:44:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Thompson <davthompson@nvidia.com>
Subject: Re: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO
 degradation bug
Message-ID: <6e3435a0-b04e-44cc-9e9d-981a8e9c3165@lunn.ch>
References: <20241122224829.457786-1-asmaa@nvidia.com>
 <7c7e94dc-a87f-425b-b833-32e618497cf8@lunn.ch>
 <CH3PR12MB7738C758D2A87A9263414AFBD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7738C758D2A87A9263414AFBD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>

> > My reading of this is that you can stop the clock when it is not needed. Maybe
> > tie into the Linux runtime power management framework. It can keep track of
> > how long a device has been idle, and if a timer is exceeded, make a callback to
> > power it down.
> > 
> > If you have an MDIO bus with one PHY on it, the access pattern is likely to be a
> > small bunch of reads followed by about one second of idle time. I would of
> > thought that stopping the clock increases the life expectancy of you hardware
> > more than just slowing it down.
> 
> Hi Andrew, 
> 

> Thank you for your answer and apologies for the very late
> response. My concern with completely stopping the clock is the case
> we are using the PHY polling mode for the link status? We would need
> MDIO to always be operational for polling to work, wouldn't we?

You should look at how power management work. For example, in the FEC
driver:

https://elixir.bootlin.com/linux/v6.14.5/source/drivers/net/ethernet/freescale/fec_main.c#L2180

static int fec_enet_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
{
	struct fec_enet_private *fep = bus->priv;
	struct device *dev = &fep->pdev->dev;
	int ret = 0, frame_start, frame_addr, frame_op;

	ret = pm_runtime_resume_and_get(dev);
	if (ret < 0)
		return ret;

This will use runtime PM to get the clocks ticking.


	/* C22 read */
	frame_op = FEC_MMFR_OP_READ;
	frame_start = FEC_MMFR_ST;
	frame_addr = regnum;

	/* start a read op */
	writel(frame_start | frame_op |
	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
	       FEC_MMFR_TA, fep->hwp + FEC_MII_DATA);

	/* wait for end of transfer */
	ret = fec_enet_mdio_wait(fep);
	if (ret) {
		netdev_err(fep->netdev, "MDIO read timeout\n");
		goto out;
	}

	ret = FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));

This all does the MDIO bus transaction

out:
	pm_runtime_mark_last_busy(dev);
	pm_runtime_put_autosuspend(dev);

And then tell PM that we are done. In this case, i _think_ it starts a
timer, and if there is no more MDIO activity for a while, the clocks
get disabled.

The same is done for write. 

PHY polling happens once per second, using these methods, nothing
special. So the clock will get enabled on the first read, polling can
need to read a few registers, so due to the timer, the clock is left
ticking between these reads, and then after a while the clock is
disabled.

My guess is, you can have the clock disabled 80% of the time, which is
probably going to be a better way to stop the magic smoke escaping
from your hardware than slowing down the clock.

	Andrew

