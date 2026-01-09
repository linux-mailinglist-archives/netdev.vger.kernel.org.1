Return-Path: <netdev+bounces-248414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C39D084DC
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 10:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79A2A30727D5
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541FA35971D;
	Fri,  9 Jan 2026 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V30gYlqB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA53590DB
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951836; cv=none; b=sCzZaxvaLTRp58h+wK4yTEyPKXGkOeaE5SsebeoQMRcVUWH6Pmj8DuXopnf8KuEktR0gFpzlfSrVN36rAKqu4mHeXYWEWg3TjE36jEgIqeuVqTL70rztTdp3B0VZ8YTP2R4Lo+8mssd+FaQ3NUhPnx2zUM6VInTZPVDuPk69WlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951836; c=relaxed/simple;
	bh=INV/4kD/7xyD2/WX2RKwsy0Cl5rOimmDaXOYl5DR3TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDb3nfbTSDqQ3LIxehbLpkp7cuEmDZRROKt4M8S/V0egx0IFiMoTp0VXIeFqG2mfPw3k+IgSDQpC4QynT4Ap5Ur6M9tjD+SpKZm0u4tYh5zmOWHsrbWL4rKhDsv1INsH2h6hMhK3hp8dIJvNuc6nGNF67JHvyy/Ej6R8K/qBunU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V30gYlqB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc544b09so2940071f8f.1
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 01:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767951833; x=1768556633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/L91nFgsulSyP6t9drAMWXjwG2dk7soHtj3DMm4Mmw=;
        b=V30gYlqB6LKK4iA7Pk5y473H9bpBOOM1msZchuRX43bEKdZqQxBGAbe0YrrihKoWOx
         +t7P3/T2ucxypiD1XfjUtSe+AOINRe2tfL25GKeRUM1ObKClLkw67nXGz9sPzxXnvdIz
         JLiStI6Wzh81TrXeyem/ZDDkpTJSnVqlxi8bEoszRjzxkDYqhmttH4NJuj+E5S9f6REZ
         scY83XuXW248SyCqfjqBaF0HN+Gjp1rJ5MBgI3GQwKvNoy8Hb7TSNqiLMNgjPARu/8UI
         OVyju/OOSQHMaVmwiQTD1ruYNmSxCgpCtyyYTcBUy+HSqCk5vRs0TxyZ1bnPS2ABwAYi
         aiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767951833; x=1768556633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/L91nFgsulSyP6t9drAMWXjwG2dk7soHtj3DMm4Mmw=;
        b=VQgMSjrAy8fhRXf6g9bbrgzO0r2ZFzj3KDsQvHbMJuQH2xXtsAE7cnrAUH2s9lr/3F
         inrPKoeliT2R3c4Rn/XkoUoaA2n8phHP+31ZGqaNnOPYaulxcSlXsbn1qlSsf8jdeTWC
         YfTtUxPmq4yTSGbaiynZpGYV06BFZAXXw1uSBpQQ9VSVDSmw15zPBMjtV6XMBHRgaA9d
         w2a3ujKsmWAuRvanRnm7Y0xeug4h1xWQBEXgDWqNvKbklSNlV/S1JI5slQm/Z3clKC/b
         0vCzQIAgyXY3jRSIOY1MARc2pF9kgiVZa08NmZUCV+jUC0qhC00h5SbMGJJo2r8gKaPp
         37VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuw1Gbzgo35/THMz2ba2drxDVCh1+hfmNkukLmtMYY29oDVLY8c0BI4sLA3vV2vxtfFgpbeoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2Ziix+X8+C4KH9Z9i3IdACEifFQKAXbv0BijUJKZdaWLrwRD
	97cehQp8XmPgNc85IgiGIN4NhDEvz4rqhI5QZzSwGsLYCsbrZL9LVr9d
X-Gm-Gg: AY/fxX6w6PQrtzjLE3+QO27/LeU8k2ZOZIrFPKFfJB4HWf5ljeoJBnG6pNZaQZNfz7O
	LmcxT+M57h2d5HQldXCJ9dVsGXsQOop2b9hvz7dKea9hZ6BjbQE2Uz8ZAa6kHFouSUz7KLr+10T
	eexAqPbXT2rTx6aTvMkgCvDmXoM3XwDFztmHJR66g6KQoIvBSVRf6Tm5RZCC4zuwS12F08FYuWs
	piWLC5+tWhKHBvX1cgTI4Jswp0j8FzFbuzd4er/RfR3a4po4m5T8fVPw7FUS7ZECANCsilrwl8t
	WCirCUo+cyMhUNxQ1flbLrUkGr1QnnXx5EuIrhxAC5Km/2ip1xMrB4zlRNUJDBtrJu6O8EZscb9
	56rucGuX4cLP1iD6A5Eas1gyBsXi5Kk99OZF1mCow3hNA2z5PpQtXaZ1fbcq8a7SBuI66uQb0RN
	fpr7Nkefins3aChrI=
X-Google-Smtp-Source: AGHT+IE8jzQS+zQve1FyW9SgxRm9cZLGcsSz5W+qJ4GN//3QtffOoIk45fLW8Mt5AKqvjU9NLQVPqg==
X-Received: by 2002:a05:6000:144f:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-432c37d2e34mr11185230f8f.43.1767951833137;
        Fri, 09 Jan 2026 01:43:53 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e175csm21237322f8f.14.2026.01.09.01.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:43:52 -0800 (PST)
Date: Fri, 9 Jan 2026 09:43:50 +0000
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: add PHY driver for
 RTL8127ATF
Message-ID: <aWDN1m3vI5YUiOee@google.com>
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
 <492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>
 <aWA2DswjBcFWi8eA@makrotopia.org>
 <fa9657f8-ec42-4476-bf4c-37db7b58ecac@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa9657f8-ec42-4476-bf4c-37db7b58ecac@gmail.com>

On Fri, Jan 09, 2026 at 08:36:10AM +0100, Heiner Kallweit wrote:
> On 1/8/2026 11:56 PM, Daniel Golle wrote:
> > On Thu, Jan 08, 2026 at 09:27:06PM +0100, Heiner Kallweit wrote:
> >> RTL8127ATF supports a SFP+ port for fiber modules (10GBASE-SR/LR/ER/ZR and
> >> DAC). The list of supported modes was provided by Realtek. According to the
> >> r8127 vendor driver also 1G modules are supported, but this needs some more
> >> complexity in the driver, and only 10G mode has been tested so far.
> >> Therefore mainline support will be limited to 10G for now.
> >> The SFP port signals are hidden in the chip IP and driven by firmware.
> >> Therefore mainline SFP support can't be used here.
> >> This PHY driver is used by the RTL8127ATF support in r8169.
> >> RTL8127ATF reports the same PHY ID as the TP version. Therefore use a dummy
> >> PHY ID.  This PHY driver is used by the RTL8127ATF support in r8169.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  MAINTAINERS                            |  1 +
> >>  drivers/net/phy/realtek/realtek_main.c | 54 ++++++++++++++++++++++++++
> >>  include/linux/realtek_phy.h            |  7 ++++
> >>  3 files changed, 62 insertions(+)
> >>  create mode 100644 include/linux/realtek_phy.h
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 765ad2daa21..6ede656b009 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -9416,6 +9416,7 @@ F:	include/linux/phy_link_topology.h
> >>  F:	include/linux/phylib_stubs.h
> >>  F:	include/linux/platform_data/mdio-bcm-unimac.h
> >>  F:	include/linux/platform_data/mdio-gpio.h
> >> +F:	include/linux/realtek_phy.h
> >>  F:	include/trace/events/mdio.h
> >>  F:	include/uapi/linux/mdio.h
> >>  F:	include/uapi/linux/mii.h
> >> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> >> index eb5b540ada0..b57ef0ce15a 100644
> >> --- a/drivers/net/phy/realtek/realtek_main.c
> >> +++ b/drivers/net/phy/realtek/realtek_main.c
> >> @@ -16,6 +16,7 @@
> >>  #include <linux/module.h>
> >>  #include <linux/delay.h>
> >>  #include <linux/clk.h>
> >> +#include <linux/realtek_phy.h>
> >>  #include <linux/string_choices.h>
> >>  
> >>  #include "../phylib.h"
> >> @@ -2100,6 +2101,45 @@ static irqreturn_t rtl8221b_handle_interrupt(struct phy_device *phydev)
> >>  	return IRQ_HANDLED;
> >>  }
> >>  
> >> +static int rtlgen_sfp_get_features(struct phy_device *phydev)
> >> +{
> >> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> >> +			 phydev->supported);
> >> +
> >> +	/* set default mode */
> >> +	phydev->speed = SPEED_10000;
> >> +	phydev->duplex = DUPLEX_FULL;
> >> +
> >> +	phydev->port = PORT_FIBRE;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int rtlgen_sfp_read_status(struct phy_device *phydev)
> >> +{
> >> +	int val, err;
> >> +
> >> +	err = genphy_update_link(phydev);
> >> +	if (err)
> >> +		return err;
> >> +
> >> +	if (!phydev->link)
> >> +		return 0;
> >> +
> >> +	val = rtlgen_read_vend2(phydev, RTL_VND2_PHYSR);
> > 
> > This should be the same as
> > phy_read(phydev, MII_RESV2); /* on page 0 */
> > Please try.
> > 
> 
> In case of an integrated PHY a phy_read() effectively is translated
> into a rtlgen_read_vend2(). So technically there's no benefit.
> 
> I don't have hw with RTL8127ATF, but maybe Fabio can test.

Yeah I tried it right away, just replaced the call and then added both
and logged the values, turned the interface down and up, they seem to be
returning the same value. Let me know if you want me to test some
condition in particular.

