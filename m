Return-Path: <netdev+bounces-138191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861BE9AC8B2
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284681F222D7
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857371A08C1;
	Wed, 23 Oct 2024 11:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dLSc4tuX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D419E97B
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729682261; cv=none; b=RcqgkNB4HrP8TPjfI4seoG1Ul4P9v3jYMZbq5GI/kxNMxSs7jZSK41xR//n70eAkFYC2t52c7kkZ08RsDOiMDSCrJ8vY8Zygd9xchOZmaWtOMbCes6bnHrKk720RtkpOscJvwbTIgm0qAfsdAFsgIR14g6+MvyV53+gVvWG0UbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729682261; c=relaxed/simple;
	bh=+MP4jLA2DqO2Bq2qIdGFwZQnclxze01MD2GtPbDYI88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTg0syHd4LTjzv8DViofuzZvR2dtO5YwQdN+lrokelyu9utfGK5YEA7Pg9lnnabHk6njgG+UUgyiWRAT+YcgrDSnEiIBvj7ZtoEgt3FC3Bilpk8bE93cHLUSlqMlG4Bdp9znJRtKrWiuL3i8DIxX5zColDUvJP07jFKWjNLd7ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dLSc4tuX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wqyty9su7Rtv84nH+R81CWyK9nELD2bBVHkgoAcA2fA=; b=dLSc4tuXhTHCzcc6kV+nMsjpf6
	OKPcvvp5ZUY2vR5x+Qpd4Jxege2b187oY+v+oOq8iegeQc6qInSyeUaK1m9D3xKoe7wWiBwf5ob8j
	qFEdrE4/0OZCF+K+0guylh3MgG/syliHk48sjqxVym2EBvMrXYWmogO4RItS/lvsEBNcy6s3bgcjW
	8KKGSn2mRy74rnCq3E32KGxMQ7OK2YNb3AaHiFijhTwPhVGefftDO5cezCzUCGK181CZOTCKl+KlT
	5uVGfz4Ix/DK5BJPD/M+9nQPU3lVA4fpD/T3gzwaPcHJbObwizZ9Na6/wY5ghkis0Y8VDHDn9RiRd
	4pYnnciQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48396)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t3ZMg-0006K4-1I;
	Wed, 23 Oct 2024 12:17:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t3ZMc-0003eH-2T;
	Wed, 23 Oct 2024 12:17:18 +0100
Date: Wed, 23 Oct 2024 12:17:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] net: pcs: xpcs: yet more cleanups
Message-ID: <ZxjbPkQEOr0FBTc6@shell.armlinux.org.uk>
References: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 17, 2024 at 12:52:17PM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> I've found yet more potential for cleanups in the XPCS driver.
> 
> The first patch switches to using generic register definitions.
> 
> Next, there's an overly complex bit of code in xpcs_link_up_1000basex()
> which can be simplified down to a simple if() statement.
> 
> Then, rearrange xpcs_link_up_1000basex() to separate out the warnings
> from the functional bit.
> 
> Next, realising that the functional bit is just the helper function we
> already have and are using in the SGMII version of this function,
> switch over to that.
> 
> We can now see that xpcs_link_up_1000basex() and xpcs_link_up_sgmii()
> are basically functionally identical except for the warnings, so merge
> the two functions.
> 
> Next, xpcs_config_usxgmii() seems misnamed, so rename it to follow the
> established pattern.
> 
> Lastly, "return foo();" where foo is a void function and the function
> being returned from is also void is a weird programming pattern.
> Replace this with something more conventional.
> 
> With these changes, we see yet another reduction in the amount of
> code in this driver.
> 
>  drivers/net/pcs/pcs-xpcs.c | 134 ++++++++++++++++++++++-----------------------
>  drivers/net/pcs/pcs-xpcs.h |  12 ----
>  2 files changed, 65 insertions(+), 81 deletions(-)

It's been almost a week, and this series has not been applied. First,
Jakub's NIPA bot failed to spot the cover message that patchwork picked
up - not my problem.

Now, I find that patchwork says "changes requested". What changes? No
one has replied asking for any changes to this series. Serge did
reply saying he would test it, and he has now done so, and replied
with his tested-by.

So, marking this series as "changes requested" is entirely incorrect.

If you think changes are required, please say what they are, or if no
changes are required, please apply this series.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

