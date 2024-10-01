Return-Path: <netdev+bounces-131072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774C998C7F4
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7CF4B20CD5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AD719D095;
	Tue,  1 Oct 2024 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zGfzcXIe"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506BD18754F
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727820099; cv=none; b=U8d+oNu4/gGhwR/2iXXiSIeIwwJ9ZKloQhmFlIJMUZr+3Lg1QJbeKAtxSiAgd0pJqu2EWR7plf3iNwODIu3dD8X59vkutyX56639ACPAGpLOhgxLU9AIPUkG+YIIE5QzkTl8BmRoyE7Y3rU6J/bTss9PTcZqK26DtfUrcHtgE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727820099; c=relaxed/simple;
	bh=A9Uj7plS4pQniwRsndoo4BtW9vcA3xXM4F93Xs2s2sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEtMDlnZcKtXFwynEaX+KDKdhysEaBXdLi+2Q0ZLsGM2oXn/pLpJIk+TE/rWPFAw5egt1uXQJ5tV70MgZBNTx0JL0LjKZzn5/oyblHkVGYDZPSaD1xDh6MmT6CzmH+hlfqOaT6JvOyIpcwsEZSAkK/WaR2IC/QvBcsdx7XRbT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zGfzcXIe; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FKpbw9Uxxm1/Gc6q+N6cP4psHIAMvgo0/79kAYtDZEo=; b=zGfzcXIeFaQbqg1H88SF9RtM5B
	JHDgjGCz1hTEnC3lHayUYI8/Gs2ymaiucTdosDvKGhAONKSyykv1Jqvuc9ngJ0C0eHJp+GouRsVvw
	fZtc7tURnQ7AWy2OVFteGBUwHCQymjY1/9v3eXn13KXxXdPEOD7X5QxpGlTRIXW9ORCURawGBUNJl
	pZX5VgTJiNxmSHHXzR5jKHuPSzS9Wle3CaGghill9/rIiDs+qPQt4SFQLl7cpKbKo2aA5a5lo7j03
	hA9jWXSQM7d5Tk/Ml7DgG7CI4+M7r9hZdobzBpZKVHrr4440liC5TuGNeAmP5KVQfScfCcmv43QiT
	Y8HW2JVg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56570)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1svkvj-0006Ub-2L;
	Tue, 01 Oct 2024 23:01:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1svkvd-0005HK-0b;
	Tue, 01 Oct 2024 23:01:09 +0100
Date: Tue, 1 Oct 2024 23:01:09 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 01/10] net: pcs: xpcs: move PCS reset to
 .pcs_pre_config()
Message-ID: <ZvxxJWCTD4PgoMwb@shell.armlinux.org.uk>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
 <E1svfMA-005ZI3-Va@rmk-PC.armlinux.org.uk>
 <fp2h6mc2346egjtcshek4jvykzklu55cbzly3sj3zxhy6sfblj@waakp6lr6u5t>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fp2h6mc2346egjtcshek4jvykzklu55cbzly3sj3zxhy6sfblj@waakp6lr6u5t>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 01, 2024 at 11:34:42PM +0300, Serge Semin wrote:
> Hi Russell
> 
> On Tue, Oct 01, 2024 at 05:04:10PM GMT, Russell King (Oracle) wrote:
> > Move the PCS reset to .pcs_pre_config() rather than at creation time,
> > which means we call the reset function with the interface that we're
> > actually going to be using to talk to the downstream device.
> > 
> > Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # sja1105
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Continuing the RFC discussion. As I mentioned here:
> https://lore.kernel.org/netdev/mykeabksgikgk6otbub2i3ksfettbozuhqy3gt5vyezmemvttg@cpjn5bcfiwei/
> The PCS-reset procedure actually can be converted to being independent
> from the PHY-interface. Thus you won't need to move the PCS resetting
> to the pre_config() method, and get rid from the pointer to
> dw_xpcs_compat utilization each time the reset is required.
> 
> So why not to merge in my patch to your series as a pre-requisite
> change and then this patch can be converted to just dropping the
> xpcs_find_compat() method call from the xpcs_init_iface() function?
> Alternatively the dropping can be just incorporated into my patch.

I'm wondering why we seem to be having a communication issue here.

I'm not sure which part of "keeping the functional changes to a
minimum for a cleanup series" you're not understanding. This is
one of the basics for kernel development... and given that you're
effectively maintaining stmmac, it's something you _should_ know.

So no, I'm going to outright refuse to merge your patch in to this
series, because as I see it, it would be wrong to do so. This is
a _cleanup_ series, not a functional change series, and what you're
proposing _changes_ the _way_ reset happens in this driver beyond
the minimum that is required for this cleanup. It's introducing a
completely _new_ way of writing to the devices registers to do
the reset that's different.

The more differences there are, the more chances there are of
regressions.

So, again, no..

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

