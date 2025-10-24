Return-Path: <netdev+bounces-232420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 833D6C05A91
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2ED8B3592D8
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112E53115A2;
	Fri, 24 Oct 2025 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0RI7a9/r"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D5266B46
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302940; cv=none; b=HP+L/9iQJcdDHmy8TZxH4yCP9GHXfwsil26ugjwAvEnMbRN5v9nOHiNf1HPaDa7Nwm02u2pHIuvuWmc7S1S2JCcdnKgw4kCsH8mE0OmlLDcEcfh9nQE6NtUl1xXWIm4xFUs1rbyK9PL974rWlcFcXmd/BlIJZRbBw1ya4UW/Xzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302940; c=relaxed/simple;
	bh=PdEdUzCsrUG6TmLAVMWeZKL/jG6UW4FB+Um2k85O/iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3Gp5PWJsCuyKKnEeJ4CWTV1hMDmimZKY8QMNhAOlTb+QhgtzzsbmcBtqdt8IeSYpHq7HThw8noxSzDWr2ZxZFZR5mA4zQ6bUS505w4WPpEdmTlJcbz3boJNxgl3KJZZu/omR0FfbEkZJmo1wZpPDl7Tv2o1APHMQNN+6V8uUjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0RI7a9/r; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=St90YPnsStMZ+8WdvRz0HPPenligqgpjDzaMg+CNa44=; b=0RI7a9/r0zJ+F/hwqE74pmKjfc
	HybwQpD3cclhhl9ZA6zhGD/G7u5/Uj29NVHdGAPqYUtoWC9Az8sjpbvM9NK7nROw3vTU7ttqLtXrB
	Lg4Ykv78Mjp81NuN3j9s5itvmdCVFlxsSYgEPSE8StTB/UNHIO+saNGpYwm94Oq7jR52u9sk49y1R
	1EJ1pgip2mnwmtUI9OLG0QS7bnBGAm+tJxIF2Hb/Pw5dynnSt7/gQ73Ikn5jKzEVHWK9qdQIaEwjA
	ErLm79mHxFQWnTsmDl2wQhlqLWReETrFaraFxHxY6gnqIQdhzKAqQenFfc8KiMO0QtQvfYdbvlf7L
	9WBBTNOQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43764)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCFLd-000000007RV-2TKn;
	Fri, 24 Oct 2025 11:48:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCFLX-000000002dR-44CK;
	Fri, 24 Oct 2025 11:48:35 +0100
Date: Fri, 24 Oct 2025 11:48:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 0/8] net: stmmac: hwif.c cleanups
Message-ID: <aPtZg_v3H53hiQXo@shell.armlinux.org.uk>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
 <28d91eca-28dd-4e5b-ae60-021e777ee064@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28d91eca-28dd-4e5b-ae60-021e777ee064@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 24, 2025 at 08:44:07AM +0200, Maxime Chevallier wrote:
> Hello Russell,
> 
> On 23/10/2025 11:36, Russell King (Oracle) wrote:
> > Hi,
> > 
> > This series cleans up hwif.c:
> > 
> > - move the reading of the version information out of stmmac_hwif_init()
> >   into its own function, stmmac_get_version(), storing the result in a
> >   new struct.
> > 
> > - simplify stmmac_get_version().
> > 
> > - read the version register once, passing it to stmmac_get_id() and
> >   stmmac_get_dev_id().
> > 
> > - move stmmac_get_id() and stmmac_get_dev_id() into
> >   stmmac_get_version()
> > 
> > - define version register fields and use FIELD_GET() to decode
> > 
> > - start tackling the big loop in stmmac_hwif_init() - provide a
> >   function, stmmac_hwif_find(), which looks up the hwif entry, thus
> >   making a much smaller loop, which improves readability of this code.
> > 
> > - change the use of '^' to '!=' when comparing the dev_id, which is
> >   what is really meant here.
> > 
> > - reorganise the test after calling stmmac_hwif_init() so that we
> >   handle the error case in the indented code, and the success case
> >   with no indent, which is the classical arrangement.
> > 
> >  drivers/net/ethernet/stmicro/stmmac/common.h |   3 +
> >  drivers/net/ethernet/stmicro/stmmac/hwif.c   | 166 +++++++++++++++------------
> >  2 files changed, 98 insertions(+), 71 deletions(-)
> 
> I didn't have the bandwidth to do a full review, however I ran tests
> with this series on dwmac-socfpga and dwmac-stm32, no regressions found.
> 
> For the series,
> 
> Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks, it's good to have someone else testing. I do need to post v2
with some tweaks to patches 2, 3 and 4 due to a typo that gets
eliminated in later patches. "verison*" -> "version*" in one instance.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

