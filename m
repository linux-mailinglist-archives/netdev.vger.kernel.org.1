Return-Path: <netdev+bounces-155902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FF3A0444A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85ED83A6762
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AF61F37B1;
	Tue,  7 Jan 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jo2HXdS6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD61F3D26
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263584; cv=none; b=hEFOP7kf5dIaAX+7wIb4AwbDxRlgpLPy+Y0xC3m1Ga1A+lbhwRpD7u7bJyhxpt5CCHFEXMsNXz/2USvJh0JEFjraBNm9dZeejmQxrl9uWaIBHUEDg3gT97o3OJmh7toJ98RLG9iKbuKLbG4yVog+jmpENJW2MVKbKoMk1IVr1Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263584; c=relaxed/simple;
	bh=ZzcFSl/HjSvcj5OpdtF/e0uZ4SSBPNOhoH+ioSgr5Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFma4GWXtqXU/KQySetHgqkThJSeL0y/iQV9FjAFSzX4b2CkX9cZtKptDGN34mh33xq7TFjqW5YIz4NyQZK2sIFl2Hm6qLQk0eHG3ELrTzytXoGW9z50ORWFuvCFBeBBA+Z7mhlzzdZ0pjBpEkFqbpptRffUNGKUsTowluaiJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jo2HXdS6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N/6XPJ85Rq8WiLNIrO3Lx2eRBJVsdpBUiKmI2/RgmY4=; b=jo2HXdS6rkT3QNwp/AyDHIzAPL
	akHlZDBZ1qktngD1Uxnj16POZ34pApA//rO/1ank552xVpXGqmZwy6oneJNcR/doSCoJdBm5laHJc
	rMxxuCWyvylF68mokRcNbgfOWSFH67fpyGZZTc41RcYF3B9JjxQkX3sN4ZnI48qaMGfv/wWPJsCK/
	EqYOohemm6k2EU3qfSA/R6ukZJTVvzrkBq+YU/gPIWXc1A4I0+L5DQ/qgMFTjtDkk37ySGQnwNdjy
	gywclq5XLFX7WwGxO5dsCQlDN5KwPyBIj6BPyZTeosUGcG8v1jNRsWAZH80CMy+h4iX1D1dBSon0l
	Z7iSK0Xg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58202)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tVBT7-0007gS-0d;
	Tue, 07 Jan 2025 15:26:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tVBT4-0005Ob-0f;
	Tue, 07 Jan 2025 15:26:06 +0000
Date: Tue, 7 Jan 2025 15:26:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 03/17] net: stmmac: use correct type for
 tx_lpi_timer
Message-ID: <Z31Hjlp_3jIeSpWH@shell.armlinux.org.uk>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmAE-007VWv-UW@rmk-PC.armlinux.org.uk>
 <20250107112851.GE33144@kernel.org>
 <Z30WmPpMp_BRgrOI@shell.armlinux.org.uk>
 <20250107144103.GB5872@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107144103.GB5872@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 07, 2025 at 02:41:03PM +0000, Simon Horman wrote:
> On Tue, Jan 07, 2025 at 11:57:12AM +0000, Russell King (Oracle) wrote:
> > On Tue, Jan 07, 2025 at 11:28:51AM +0000, Simon Horman wrote:
> > > On Mon, Jan 06, 2025 at 12:24:58PM +0000, Russell King (Oracle) wrote:
> > > > The ethtool interface uses u32 for tx_lpi_timer, and so does phylib.
> > > > Use u32 to store this internally within stmmac rather than "int"
> > > > which could misinterpret large values.
> > > > 
> > > > Since eee_timer is used to initialise priv->tx_lpi_timer, this also
> > > > should be unsigned to avoid a negative number being interpreted as a
> > > > very large positive number.
> > > > 
> > > > Also correct "value" in dwmac4_set_eee_lpi_entry_timer() to use u32
> > > > rather than int, which is derived from tx_lpi_timer, even though
> > > > masking with STMMAC_ET_MAX will truncate the sign bits. u32 is the
> > > > value argument type for writel().
> > > > 
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > 
> > > ...
> > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > index 9a9169ca7cd2..b0ef439b715b 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > @@ -111,8 +111,8 @@ static const u32 default_msg_level = (NETIF_MSG_DRV | NETIF_MSG_PROBE |
> > > >  				      NETIF_MSG_IFDOWN | NETIF_MSG_TIMER);
> > > >  
> > > >  #define STMMAC_DEFAULT_LPI_TIMER	1000
> > > > -static int eee_timer = STMMAC_DEFAULT_LPI_TIMER;
> > > > -module_param(eee_timer, int, 0644);
> > > > +static unsigned int eee_timer = STMMAC_DEFAULT_LPI_TIMER;
> > > > +module_param(eee_timer, uint, 0644);
> > > >  MODULE_PARM_DESC(eee_timer, "LPI tx expiration time in msec");
> > > >  #define STMMAC_LPI_T(x) (jiffies + usecs_to_jiffies(x))
> > > >  
> > > 
> > > Hi Russell,
> > > 
> > > now that eee_timer is unsigned the following check in stmmac_verify_args()
> > > can never be true. I guess it should be removed.
> > > 
> > >         if (eee_timer < 0)
> > >                 eee_timer = STMMAC_DEFAULT_LPI_TIMER;
> > > 
> > 
> > Thanks for finding that. The parameter description doesn't seem to
> > detail whether this is intentional behaviour or not, or whether it is
> > "because someone used int and we shouldn't have negative values here".
> > 
> > I can't see why someone would pass a negative number for eee_timer
> > given that it already defaults to STMMAC_DEFAULT_LPI_TIMER.
> > 
> > So, I'm tempted to remove this.
> 
> I'm not sure either. It did cross my mind that the check could be changed,
> to disallow illegal values (if the range of legal values is not all
> possible unsigned integer values). But it was just an idea without any
> inspection of the code or thought about it's practicality. And my first
> instinct was the same as yours: remove the check.

My reasoning is as follows:

In the existing code with the module paramter is a signed int, then it
take a value up to INT_MAX. Provided sizeof(int) == sizeof(u32), then
this can be reported through the ethtool API. However, ethtool can set
the timer to U32_MAX which can exceed INT_MAX in this case. The driver
doesn't stop this, and uses a software based timer for any delay greater
than the capabilities of the hardware timer (if any.)

So, through ethtool one can set the LPI delay to anything between 0 and
U32_MAX, whereas through the module parameter it's between 0 and
INT_MAX. values between INT_MIN and -1 inclusive result in the default
being used.

It is, of course, absurd to have a negative delay, or even a delay
anywhere near INT_MAX or U32_MAX.

I'll separate out the change to eee_timer so if necessary, that can be
reverted without reverting the entire patch. Oh goodo, an extra patch
for a patchset which already exceeds netdev's 15 patches...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

