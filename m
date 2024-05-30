Return-Path: <netdev+bounces-99419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969488D4CF6
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328831F2327E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730CE17D8A0;
	Thu, 30 May 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AGaNDk5n"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E717C200;
	Thu, 30 May 2024 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076455; cv=none; b=QWMaeESRBlF12nQVPa4yGbcNWcV1fei8DK3YIZRiSZAJWPDboDheHOPKQ4gxRFGqTYjWznyRm16aOfv6jdZ4smVE3YdfXpHUh9Xz0KzU0dqc+Xt9Xr5p2Wd3z9e7eA2C1mi7tN1A6vF4LZbke3J+HUvXPysTA7My7wpQmIoyWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076455; c=relaxed/simple;
	bh=X4OHNBsHVoGtFA4w7g07P20hxNbyWOejP4Y+I4eynSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hgz1OsJMSJ03ifFv91E7BFpC0Q34HwzQOUW7R3G6KlRqYTgLbimmcZv+hT6ytEg0qrssghHzk4MotgHK2EqQzspTcyJ3/OVOZZ/Tu0ApHyYdcrswL8Zb7iku2JTpj1Rr30t9A9Cki8wBjBEvsU6XhSEfVMK9wCqcbzT4L3c7rxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AGaNDk5n; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mmi/oPyl5q1rKk3gHuGZWVFStdI6ds13q4SnwsFA8rY=; b=AGaNDk5nnmiuhsMqeP++v1QD9s
	yrdtM8myaqUjTgdkOh1hiupqCArcihHSLr6Rdf9QE030xY+9ACoxPvq8dLmgQDLJsLaOfTLwXQ6nD
	DuhYd5tENewAtUkJlQoj+n980k2QZN9Xk06IKRMLPX8G4D9qai9zZe4m8vVi7dtStGWs/vnVuzfh7
	osbQgnm4Qx/xYm/rITK5K9XhPSF6wh2wXznz6W0o+nGGGcrDgSx+PX1J5OFL47qGVEoTe9Kk8ROtO
	M4Xu/UocdMrcOqiwLzK//o4yB2PlfMIjoV4mlAwXK8IfGF6cKxvvzNOLhosG3frhCNvl+F4ybsTnn
	gOnwTUVQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33130)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCg1A-0007RJ-1z;
	Thu, 30 May 2024 14:40:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCg19-0005Bq-2P; Thu, 30 May 2024 14:40:31 +0100
Date: Thu, 30 May 2024 14:40:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Xiaolei Wang <xiaolei.wang@windriver.com>, Andrew Lunn <andrew@lunn.ch>,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net v2 PATCH] net: stmmac: Update CBS parameters when speed
 changes after linking up
Message-ID: <ZliBzo7eETml/+bl@shell.armlinux.org.uk>
References: <20240530061453.561708-1-xiaolei.wang@windriver.com>
 <f8b0843f-7900-4ad0-9e70-c16175e893d9@lunn.ch>
 <20240530132822.xv23at32wj73hzfj@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530132822.xv23at32wj73hzfj@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 30, 2024 at 04:28:22PM +0300, Vladimir Oltean wrote:
> On Thu, May 30, 2024 at 02:50:52PM +0200, Xiaolei Wang wrote:
> > When the port is relinked, if the speed changes, the CBS parameters
> > should be updated, so saving the user transmission parameters so
> > that idle_slope and send_slope can be recalculated after the speed
> > changes after linking up can help reconfigure CBS after the speed
> > changes.
> > 
> > Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
> > Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> > ---
> > v1 -> v2
> >  - Update CBS parameters when speed changes
> 
> May I ask what is the point of this patch? The bandwidth fraction, as
> IEEE 802.1Q defines it, it a function of idleSlope / portTransmitRate,
> the latter of which is a runtime variant. If the link speed changes at
> runtime, which is entirely possible, I see no alternative than to let
> user space figure out that this happened, and decide what to do. This is
> a consequence of the fact that the tc-cbs UAPI takes the raw idleSlope
> as direct input, rather than something more high level like the desired
> bandwidth for the stream itself, which could be dynamically computed by
> the kernel.

So what should be the behaviour here? Refuse setting CBS parameters if
the link is down, and clear the hardware configuration of the CBS
parameters each and every time there is a link-down event? Isn't that
going to make the driver's in-use settings inconsistent with what the
kernel thinks have been set? AFAIK, tc qdisc's don't vanish from the
kernel just because the link went down.

I think what you're proposing leads to the hardware being effectively
"de-programmed" for CBS while "tc qdisc show" will probably report
that CBS is active on the interface - which clearly would be absurd.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

