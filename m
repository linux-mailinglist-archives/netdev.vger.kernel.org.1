Return-Path: <netdev+bounces-150329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022779E9E17
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA8D281745
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F3815854F;
	Mon,  9 Dec 2024 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUlclw0P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340AB7080B
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769318; cv=none; b=tsuYWdFdw/3DK46oOTaqJCflgm5O1fiwYgJinRYz1NLK03/2jnwJFduLh404CHQLrkzPlbath7AIshS8QWwLravdd5YhCVv3raBuAbdswJfkWO9OX6tvB8aHRIwi9jL7iFHte0ez2lArbdtvQKuu2ZJGSnedLmeAKhFtbJxj0wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769318; c=relaxed/simple;
	bh=py/FUWNJBVLuNA6AwPU5vM0NehoU8END40d3m0aUxzk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9cDa/Z11C42s6VD9EcJNeu84KAh2B4HUNwxLu7UnaSNqKAWbtlQk/71h/hDWS8XvfloPbDfA04dOIBkSrMXZlCnru6/+nLYE8qJgAsC43OEFzYDp6EEojxapvsBkJaJq46bx4v2VQmymiLq1OpEE4ecDZ12YPru43Ep5JNi2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUlclw0P; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385dece873cso2244657f8f.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 10:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733769314; x=1734374114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K6N+dq3hKX8FcRToeisLIdUSzONgBmhzbPqdUM5lEOs=;
        b=JUlclw0PWow4TqcURXn0Lnh2Ln+fTRECCnFV0KA1oqumGAGHQexcu0lU0DQZ6LJuVM
         XKT5krHNv29lXaXkOMLTQjZJF4I31gi13ZaPnKVwKzruQsNLvtZZ4I1DMcunvnZHTqku
         9j0oYMcBYuXa9GkfQhpi97H4GTOjh+dxgfRxSHCzN5yFEaCEY7HrogSx3WObn/cNZPxC
         HT/J0qDpBNOfV2ZcixqRj3Fs24GdmD0m1pZ1ZQ8DXQhUhSGZFRFxnU42PHEdSThgmvuk
         4CxkI1CQ+nhxRxNxuDpmN7tRAhhJbEPEQcsm1JcfnoryjFoEILpgIBJEPN44dDcG5s7w
         0d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733769314; x=1734374114;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6N+dq3hKX8FcRToeisLIdUSzONgBmhzbPqdUM5lEOs=;
        b=ZkDHO0YLijdbKXyZLt552m7drzlAMVSv2JjnhQ1HmumRtNQrv14BfcRPNa05PEZOBt
         CJXqIpg0NMvgExVjqRB4Q4Fg4z4DLvtPzCcdAEi++iN2/ySjZwK26ga9xAmlYVmaGBs5
         xem5ySWm1Db7Y748N7gUhUdZaWyYBJ/fngBikJLhCPP9J7j8X8XfmKF400qLBPCjv2Mv
         fyWMudMYc5ERnbkg+jdPAqtbGYXVLefVJbffaiNA7E8CuRX7RBb7OenDYyG23WeQripO
         Z19+2H42/qAbo4Dn7FF/UOyyPApTWxGzQ1bT1ByRmtk4e74BivyPkabSEbO+8JDgAxfV
         iQnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsPC8ieLy8WPD9xZqGglan1afGwb3vzFR5NS/w1Hl/+CALTr/O6CTvawYPPvAZJ4o5JnrL5qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wtX5Sf77HGeSigFmIl3FsrzRGMN6/OypMOL8rfOCtXKRNgGP
	6E5X7uGeAJlBVxCIRPzDvq4eEl9XmvHTpzZ0SlGty5lgi3GShqLy
X-Gm-Gg: ASbGnctiYrsVC7lMgl30BVGASAjz8/HAR2+FnTR5AYlyTeerZnjxo03Xx6LskBvRtb5
	bBjp3z5zaEy+qMPegBy6zixXvOrR33Z0A9DwKp2g9hVChPDXllr9LrYV/ASsGsRDCgzWDtEZmZF
	x9usFIcYxVj/cZHbVNhdyeHtXGRY+a1EayVsSG+gQ5nAfHvKlVfPmBj3GdxRaKgIZT+0wl8at84
	Eeg5FjKRz0X21TKIOIYUIG9/+kxhAqHhm2WMQhX8GAvQgU/1pw5k/Z+EJGTMvzyY2lrT7P2cyJ1
	xKe/Ng==
X-Google-Smtp-Source: AGHT+IHTgvXww5OoXd2i5J33KpEIWZPrlxP2cPLcr/9fcDCjaoD4KPfXiQFbVmKRgpFOwWLmzoTB7w==
X-Received: by 2002:a05:6000:402c:b0:385:fc97:9c71 with SMTP id ffacd0b85a97d-3862b33f007mr8513282f8f.12.1733769314132;
        Mon, 09 Dec 2024 10:35:14 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f5506766sm59078995e9.5.2024.12.09.10.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 10:35:13 -0800 (PST)
Message-ID: <67573861.050a0220.bef7c.e26e@mx.google.com>
X-Google-Original-Message-ID: <Z1c4X5_J5CRVhYHa@Ansuel-XPS.>
Date: Mon, 9 Dec 2024 19:35:11 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 00/10] net: add phylink managed EEE support
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>

On Mon, Dec 09, 2024 at 02:22:31PM +0000, Russell King (Oracle) wrote:
> Hi,
> 
> Adding managed EEE support to phylink has been on the cards ever since
> the idea in phylib was mooted. This overly large series attempts to do
> so. I've included all the patches as it's important to get the driver
> patches out there.
> 
> Patch 1 adds a definition for the clock stop capable bit in the PCS
> MMD status register.
> 
> Patch 2 adds a phylib API to query whether the PHY allows the transmit
> xMII clock to be stopped while in LPI mode. This capability is for MAC
> drivers to save power when LPI is active, to allow them to stop their
> transmit clock.
> 
> Patch 3 adds another phylib API to configure whether the receive xMII
> clock may be disabled by the PHY. We do have an existing API,
> phy_init_eee(), but... it only allows the control bit to be set which
> is weird - what if a boot firmware or previous kernel has set this bit
> and we want it clear?
> 
> Patch 4 starts on the phylink parts of this, extracting from
> phylink_resolve() the detection of link-up. (Yes, okay, I could've
> dropped this patch, but with 23 patches, it's not going to make that
> much difference.)
> 
> Patch 5 adds phylink managed EEE support. Two new MAC APIs are added,
> to enable and disable LPI. The enable method is passed the LPI timer
> setting which it is expected to program into the hardware, and also a
> flag ehther the transmit clock should be stopped.
> 
>  *** There are open questions here. Eagle eyed reviewers will notice
>    pl->config->lpi_interfaces. There are MACs out there which only
>    support LPI signalling on a subset of their interface types. Phylib
>    doesn't understand this. I'm handling this at the moment by simply
>    not activating LPI at the MAC, but that leads to ethtool --show-eee
>    suggesting that EEE is active when it isn't.
>  *** Should we pass the phy_interface_t to these functions?

Maybe only to validate?

>  *** Should mac_enable_tx_lpi() be allowed to fail if the MAC doesn't
>    support the interface mode?

I'm a bit confused by this... Following principle with other OPs
shouldn't this never happen? Supported interface are validated by
capabilities hence mac_enable_tx_lpi() should never be reached (if not
supported). Or I'm missing something by this idea?

> 
> The above questions remain unanswered from the RFC posting of this
> series.
> 
> A change that has been included over the RFC version is the addition
> of the mac_validate_tx_lpi() method, which allows MAC drivers to
> validate the parameters to the ethtool set_eee() method. Implementations
> of this are in mvneta and mvpp2.
> 
> An example of a MAC that this is the case are the Marvell ones - both
> NETA and PP2 only support LPI signalling when connected via SGMII,
> which makes being connected to a PHY which changes its link mode
> problematical.
> 
> The remainder of the patches address the driver sides, which are
> necessary to actually test phylink managed EEE.
> 
>  drivers/net/ethernet/marvell/mvneta.c            | 127 +++++++++++--------
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h       |   5 +
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c  |  98 +++++++++++++++
>  drivers/net/ethernet/microchip/lan743x_ethtool.c |  21 ----
>  drivers/net/ethernet/microchip/lan743x_main.c    |  39 ++++--
>  drivers/net/ethernet/microchip/lan743x_main.h    |   1 -
>  drivers/net/phy/phy.c                            |  47 ++++++-
>  drivers/net/phy/phylink.c                        | 150 +++++++++++++++++++++--
>  include/linux/phy.h                              |   2 +
>  include/linux/phylink.h                          |  59 +++++++++
>  include/uapi/linux/mdio.h                        |   1 +
>  11 files changed, 458 insertions(+), 92 deletions(-)
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
	Ansuel

