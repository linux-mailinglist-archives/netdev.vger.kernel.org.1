Return-Path: <netdev+bounces-149648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3F39E69D5
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AA41881F08
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57251E1A17;
	Fri,  6 Dec 2024 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uttmbHWg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468961CCB4B;
	Fri,  6 Dec 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476313; cv=none; b=g8fm6vVEaGKQRxiP+MefdH1nVb7vvDMyc7rCaCe8klGHJ6D6Dr0zzObqbWPbkiWZREGoFKd+SYe06309JIywnX5hzTj5eD9jdWULVPpKCBcrrkfHvAskFqAKxOR4sfMrpf4bl4xcwWyyqSOjzTTogz1Rp+lfn0Sn3ngKVU2BHXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476313; c=relaxed/simple;
	bh=Km+/iroP6x0O/GI7SRyBBx9TS519M53lKmSVbaJu3OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIOGS0ufI3zulY4YMTWvfCb3rAS2LTn89CBVWCm3BqUzUSQPr2RqKi+qG//VfrJUpUGdh4nM77/ydT1y5xwK84P+kVsxQ+Rnni7qleCBuOpg6Sck/Ukhh96PpvrHnbKV4116+NOBUCynU+ALb8/o0nCSQbG6ROzWtCWdSSFGt2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uttmbHWg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PP3nhUU0UsYQYOH1O1rG0VM+WQ/KjlJcoa/tV21UMOE=; b=uttmbHWgy5S0PmVHAWR65M931x
	C9JX9hpjIM+drdw4zKGNLV2f3mmwt+kjNm7J7ycZWjROMzkHt0BGj5BXLOPJEzx/fXsISjviVgCca
	Jl8UxD84BN6uYXOkkjqT0U5DVx6lFHG3l3lREly8j6eA0g0YoGccukW23qGRlNn58vl1UCFZueZIW
	mLdBSybhx8MS8rHMQA4kGOxoR2GW34ybqYpMFlM+zLB2lGxfa000j9U661f+GWJe1A1e5jj+ajKh6
	39XucITAIVigO+bFIk/iNCwcMojxC2iFPOjCcf0x19WFnGxnCihOpk3FmreZJEUSJPIku6lakoA48
	8acEU7kA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46526)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJUN8-0005zZ-0r;
	Fri, 06 Dec 2024 09:11:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJUN3-0007R7-01;
	Fri, 06 Dec 2024 09:11:33 +0000
Date: Fri, 6 Dec 2024 09:11:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/7] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <Z1K_xI-0d3JINvlg@shell.armlinux.org.uk>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-2-o.rempel@pengutronix.de>
 <Z1GVLf0RaYCP060b@shell.armlinux.org.uk>
 <20241205171909.274715c2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205171909.274715c2@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 05, 2024 at 05:19:09PM -0800, Jakub Kicinski wrote:
> On Thu, 5 Dec 2024 11:57:33 +0000 Russell King (Oracle) wrote:
> > > +	 * The input structure is not zero-initialized and the implementation
> > > +	 * must only set statistics which are actually collected by the device.  
> > 
> > Eh what? This states to me that the structure is not initialised, but
> > drivers should not write to all members unless they support the
> > statistic.
> > 
> > Doesn't this mean we end up returning uninitialised data to userspace?
> > If the structure is not initialised, how does core code know which
> > statistics the driver has set to avoid returning uninitialised data?
> 
> It's not zero-initialized. Meaning it's initialized to a special magic
> value that the core then checks for to decide if the driver actually
> reported something.
> 
> Maybe this:
> 
>  * Drivers must not zero out statistics which they don't report.
>  * Core will initialize members to ETHTOOL_STAT_NOT_SET and check
>  * for this value to report to user space only the stats actually
>  * supported by the device.
> 
> IDK how to phrase this better..

Maybe:

 * The input structure is pre-initialised with ETHTOOL_STAT_NOT_SET and
 * the implementation must only change implemented statistics.

?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

