Return-Path: <netdev+bounces-137397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC839A601C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FDEEB28F95
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF001E283D;
	Mon, 21 Oct 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TkGTYQCA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF11E376B
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503145; cv=none; b=UGRjREc26kx+SZP0gjwU/KmI8cTztcixUcbseBYS6xYrvu6M3OYzuqnR2j0N8dmoER1JaF2vAlr7UxsvrQcmiANCcgsKpLowBVO6iGszsydnIPqanTi3AGbg7NyD8TgWt5Bi96rUmeLDFb7FiT3zbtuWJgOvgihwGqFzBSwNxEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503145; c=relaxed/simple;
	bh=bHBnj7aalHoMpR9kA+VKgi+0Z5JXwcrHUySWI+hUFA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgktBVIxxkQ9oWkh16BLBbhPE3iezvdnps55NiWbPUHkGFb/B34ow06eGhNtXQIsO7A7kM3teEHzD6MzCB/jEPqH+mpcOHRT9UoUi9MsMEdVwn0GxqOIYgTjnWuS0ABEMrWw8pT2gr/GZw1LxNSW0Ya9dPplJRyQ+PrGjghPuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TkGTYQCA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e2KtIWZwoHWCmTSFbig/OZ/NTIZfLZGMEI1bMNZEUZk=; b=TkGTYQCA+UZmqCOZR1JF4Qfbly
	v3XOILld5vEHYr7KxT7Ep/yazSha/UjtnegV0rTVdQy6tO+eZCITIrGnImOoEYEUsJqbrdqpClAPQ
	Qq9YkU4SgSiP8q5pfKPCCX8EtBXwG7v6ssXItO3dY00XmlMuNIyUGNv9BVUhU56hq0QN0hX2yHfqd
	S1MdYIva2r0GxOyHcg3+CDlrxQvDJVBBjsfibdfJVfYWAPkYFFpGH5k1AIvGaWaFwm+0aNavwmgBN
	J4BtQi3jxTKEtS/baRRI40zIQ89CoLZOS6Q0S4X32uxtAIhAhacGFcASpWxHVEW3UCq5Nh8337wYK
	8LiyspaQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33768)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t2olp-00036U-1s;
	Mon, 21 Oct 2024 10:32:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t2olm-0001ct-2b;
	Mon, 21 Oct 2024 10:32:10 +0100
Date: Mon, 21 Oct 2024 10:32:10 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <horms@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	kernel@quicinc.com
Subject: Re: [PATCH net v1] net: stmmac: Disable PCS Link and AN interrupt
 when PCS AN is disabled
Message-ID: <ZxYfmtPYd0yL51C5@shell.armlinux.org.uk>
References: <20241018222407.1139697-1-quic_abchauha@quicinc.com>
 <60119fa1-e7b1-4074-94ee-7e6100390444@lunn.ch>
 <ZxYc2I9vgVL8i4Dz@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxYc2I9vgVL8i4Dz@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Oct 21, 2024 at 10:20:24AM +0100, Russell King (Oracle) wrote:
> On Sat, Oct 19, 2024 at 04:45:16AM +0200, Andrew Lunn wrote:
> > On Fri, Oct 18, 2024 at 03:24:07PM -0700, Abhishek Chauhan wrote:
> > > Currently we disable PCS ANE when the link speed is 2.5Gbps.
> > > mac_link_up callback internally calls the fix_mac_speed which internally
> > > calls stmmac_pcs_ctrl_ane to disable the ANE for 2.5Gbps.
> > > 
> > > We observed that the CPU utilization is pretty high. That is because
> > > we saw that the PCS interrupt status line for Link and AN always remain
> > > asserted. Since we are disabling the PCS ANE for 2.5Gbps it makes sense
> > > to also disable the PCS link status and AN complete in the interrupt
> > > enable register.
> > > 
> > > Interrupt storm Issue:-
> > > [   25.465754][    C2] stmmac_pcs: Link Down
> > > [   25.469888][    C2] stmmac_pcs: Link Down
> > > [   25.474030][    C2] stmmac_pcs: Link Down
> > > [   25.478164][    C2] stmmac_pcs: Link Down
> > > [   25.482305][    C2] stmmac_pcs: Link Down
> > 
> > I don't know this code, so i cannot really comment if not enabling the
> > interrupt is the correct fix or not. But generally an interrupt storm
> > like this is cause because you are not acknowledging the interrupt
> > correctly to clear its status. So rather than not enabling it, maybe
> > you should check what is the correct way to clear the interrupt once
> > it happens?
> 
> stmmac PCS support is total crap and shouldn't be used, or stmmac
> should not be using phylink. It's one or the other. Blame Serge for
> this mess.

Seriously, we could've had this fixed had the patch set I was working
on that fixed stmmac's _bad_ _conversion_ to phylink progressed to the
point of being merged.

The whole stmmac PCS support is broken, bypassing phylink.

This series also contained bug fixes for stuff like this interrupt
storm after Serge tested it. However, Serge wanted to turn my series
into his maze of indirect function pointers approach that I disagreed
with, and he wouldn't change his mind on that, so I deleted the series.

As I keep saying - either stmmac uses phylink *properly* and gets its
PCS hacks sorted out, or it does not use phylink *at* *all*. It's one
or the other.

I am not going to patch stmmac for any future phylink changes, and if
it breaks, then I'll just say "oh that's a shame, not my problem."
Blame Serge for that. I've had it with the pile of crap that is
stmmac.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

