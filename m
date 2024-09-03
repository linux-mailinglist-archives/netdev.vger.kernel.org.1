Return-Path: <netdev+bounces-124535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B43969E68
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B071C23460
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A281CA6BB;
	Tue,  3 Sep 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LCp1jyR+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A449A1CA6BA;
	Tue,  3 Sep 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368034; cv=none; b=LfeWgaTcX2hs0+KlmxcJR+vk+I+PdvOWhcdD4e1W6mH1UjnRAGCcuLXwbpRjJog6Geq2S6V6hEHL31nkZSyGFxr/4MsQut3/JnroexUT8IIeAhxrpvhmIa2bE8bVLZukfwfm1mi2EZwGzzGrUn233dZ1HulwerAtsApPPnYhsRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368034; c=relaxed/simple;
	bh=RpfTj4cLn7W36k5murVGOj34MGnuyTIV+vel5+SvHHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dO8yH2i5LOwbLOFwc/q6jwb0vx6Xwr9iOVIPw4DbTv4GdrAjukJEP0NIQt2QIpqdqZHReywEII0Dcae4x71VV3MLnIpQMTTPcTUbdEuE9UO2WU49OJnZqOS2n9dRnW9/5l7bWIqy//Sb89SPDcqZS/MJjTGqgyKAEZIuJ5QFCeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LCp1jyR+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Y/PFMegEDd62ur1zarCVrWPBLzIeJ3N20ZfW4Ez4TaM=; b=LCp1jyR+IICHAWThuJ0aN9V9P0
	++GbqJunHyY4Bpw0sGSkcx92JlhyKeXjKtxZ8zdYlqu8j2GEWS1EHM9lpp2e+jQk5i8iyxMxMI2Cg
	m0wuS+PDEbExhY5LRl9kPBtUfYMV6UO9SzN7B+ZZ7o2HA9iKGiD6MttFcddJf6RrcxC0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slT2B-006QUP-VC; Tue, 03 Sep 2024 14:53:23 +0200
Date: Tue, 3 Sep 2024 14:53:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, woojung.huh@microchip.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linus.walleij@linaro.org,
	alsi@bang-olufsen.dk, justin.chen@broadcom.com,
	sebastian.hesselbarth@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, wens@csie.org,
	jernej.skrabec@gmail.com, samuel@sholland.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com, krzk@kernel.org,
	jic23@kernel.org
Subject: Re: [PATCH net-next v4 5/8] net: mdio: mux-mmioreg: Simplified with
 dev_err_probe()
Message-ID: <38a3c576-a342-4644-8509-53a6a7f45576@lunn.ch>
References: <20240830031325.2406672-1-ruanjinjie@huawei.com>
 <20240830031325.2406672-6-ruanjinjie@huawei.com>
 <27a0d076-ed61-486b-b961-8a0982e7b96d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a0d076-ed61-486b-b961-8a0982e7b96d@gmail.com>

> > @@ -109,30 +109,25 @@ static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
> >   		return -ENOMEM;
> >   	ret = of_address_to_resource(np, 0, &res);
> > -	if (ret) {
> > -		dev_err(&pdev->dev, "could not obtain memory map for node %pOF\n",
> > -			np);
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "could not obtain memory map for node %pOF\n", np);
> 
> Besides that one, which I don't think is even a candidate for resource
> deferral in the first place given the OF platform implementation, it does
> not seem to help that much to switch to dev_err_probe() other than just
> combining the error message and return code in a single statement. So it's
> fewer lines of codes, but it is not exactly what dev_err_probe() was
> originally intended for IMHO.

Agreed. Rather than abuse dev_err_probe(), maybe a dev_err_error()
would be added with the same prototype, does the same formatting, and
skips all the PROBE_DEFFER logic. The problem would be, it would
encourage more of this churn.

	Andrew

