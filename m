Return-Path: <netdev+bounces-155815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAAAA03E51
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9225D1885350
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43691DF73A;
	Tue,  7 Jan 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KqBecdSB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262351D5CE0
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251062; cv=none; b=XKxJzvs01L5vjTFBePDhoMIN4hXA8LUvlbosiI4EwEUtRcLgBPcxsFUnVUjWOwO11olXtTsAkR9X2s4bY3fxkgWqZTlHq/yQEvRb4TTm5Ezg0MufAttnVQws6HeB1oefuY6nv+j0Ul9HXKe+nO+/Ey2XmQMDu6SNGaPwZqaHEmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251062; c=relaxed/simple;
	bh=9vi7RkuYwgQze9d/w7Y2U0rMgHeaEMXwd9ZBDWyh4Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JN1NE8/LuGuS01F/MiSrlS7AzNHzYqcSkIGSMdWau5YuXAG9sYa+w42McH2ijG5l2z9UEfIUqpmKy5Q0siFDgUTyfw+WPZVZuNWbi749SMmV8R5rlU2ZnuWgpKv34nWdcbSrWJFcgUwdUgASoD624ng+us13JQOShty63ZDSBg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KqBecdSB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Rt0/m2Ur3xOciFGnYgCU4bKBYglBzbBymgd9Uo9+dy8=; b=KqBecdSB8IPGU3TLqYufcE250X
	L8FjFnrCvCmlwFzsHJsSPeLZnFEyAjY/CqcY/tdqZcI5BDjHtx0Sfcqd8rRNpx++b6wLAeYLCobcz
	ga/vcKx/Td9Tk2Wz6kFF4+X7NOXMmhXtxdDVX7yHEC4QAXgIOry3SWOXLskF8m+47nQBiR8GNfetZ
	b/+3k5DjNDNdfV+iX/C80SZEa8OLqnwTE9QHUKGebd1RFADCNBKxv+7GSKNRWiDM08F3aj1IPvA/8
	RkAQ53VOxwGg14bEjWtHv0T0cVe9fR6RyUmOBZLoFJObCvivZ+VCeFojq9z4rRPnehF7qjiORvNDC
	7dsLtgew==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33040)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tV8Cy-0007Li-2x;
	Tue, 07 Jan 2025 11:57:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tV8Cu-0005G3-0o;
	Tue, 07 Jan 2025 11:57:12 +0000
Date: Tue, 7 Jan 2025 11:57:12 +0000
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
Message-ID: <Z30WmPpMp_BRgrOI@shell.armlinux.org.uk>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmAE-007VWv-UW@rmk-PC.armlinux.org.uk>
 <20250107112851.GE33144@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107112851.GE33144@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 07, 2025 at 11:28:51AM +0000, Simon Horman wrote:
> On Mon, Jan 06, 2025 at 12:24:58PM +0000, Russell King (Oracle) wrote:
> > The ethtool interface uses u32 for tx_lpi_timer, and so does phylib.
> > Use u32 to store this internally within stmmac rather than "int"
> > which could misinterpret large values.
> > 
> > Since eee_timer is used to initialise priv->tx_lpi_timer, this also
> > should be unsigned to avoid a negative number being interpreted as a
> > very large positive number.
> > 
> > Also correct "value" in dwmac4_set_eee_lpi_entry_timer() to use u32
> > rather than int, which is derived from tx_lpi_timer, even though
> > masking with STMMAC_ET_MAX will truncate the sign bits. u32 is the
> > value argument type for writel().
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 9a9169ca7cd2..b0ef439b715b 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -111,8 +111,8 @@ static const u32 default_msg_level = (NETIF_MSG_DRV | NETIF_MSG_PROBE |
> >  				      NETIF_MSG_IFDOWN | NETIF_MSG_TIMER);
> >  
> >  #define STMMAC_DEFAULT_LPI_TIMER	1000
> > -static int eee_timer = STMMAC_DEFAULT_LPI_TIMER;
> > -module_param(eee_timer, int, 0644);
> > +static unsigned int eee_timer = STMMAC_DEFAULT_LPI_TIMER;
> > +module_param(eee_timer, uint, 0644);
> >  MODULE_PARM_DESC(eee_timer, "LPI tx expiration time in msec");
> >  #define STMMAC_LPI_T(x) (jiffies + usecs_to_jiffies(x))
> >  
> 
> Hi Russell,
> 
> now that eee_timer is unsigned the following check in stmmac_verify_args()
> can never be true. I guess it should be removed.
> 
>         if (eee_timer < 0)
>                 eee_timer = STMMAC_DEFAULT_LPI_TIMER;
> 

Thanks for finding that. The parameter description doesn't seem to
detail whether this is intentional behaviour or not, or whether it is
"because someone used int and we shouldn't have negative values here".

I can't see why someone would pass a negative number for eee_timer
given that it already defaults to STMMAC_DEFAULT_LPI_TIMER.

So, I'm tempted to remove this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

