Return-Path: <netdev+bounces-238855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D980C603EB
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 12:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DB53B99C8
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 11:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B783298CB2;
	Sat, 15 Nov 2025 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iRWn5056"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD9281525;
	Sat, 15 Nov 2025 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763206094; cv=none; b=lu5+hi8u4C5jy+NHHkpj09A12WWveS0X4JxWIEugeCjvVVlfJO8ksgtcT2mryJNKx22dUpLx1nJMjgECph4zrmT63EXEsAwAKJJmmW2kW3ZRjt1gLNVl5CQC58v4tkeXHu3n0gRt8wULcczbm20vMzNB4uWq2w8DkWSSU0wEnIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763206094; c=relaxed/simple;
	bh=6FE7o4fZSPImKiZ6+hneRp/AXn7+F8UcEbvtaG/oDbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dh0RjmmjS2XqggH5JK2GXLH3+CFM5JytORo7mcV2O/ej0LibUlViFi2yVbTHxvNO4TNBJfSqOCKnP4bI4XdqRC5ujOVqUwnmd13B3otXs8ZtYS0QLv/SkbXAgBWeLl2Bjr4ZlcOpaj6x+JQ0KMekNCb6nzo+j9kV9x3aebAYYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iRWn5056; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D64CB2600C;
	Sat, 15 Nov 2025 12:28:08 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LBMiVMmPGxcS; Sat, 15 Nov 2025 12:28:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763206087; bh=6FE7o4fZSPImKiZ6+hneRp/AXn7+F8UcEbvtaG/oDbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iRWn5056qE4GV8BNvGhrGY+aESjcwACAf9IBAerJwOXrsxgUCcegb27vllHhQ2fpg
	 pNkImb0Tg2WMaROHMz02oDkZzgFiuuL6SZMuyifbWpPRM+b+HmEddy8bFU85rLbffa
	 nVdPvRifp0h5atlKzhQVcVBqHVFVXcOlt+GUAi0InpRy6OslLRUCKIn7afHw3zfEOL
	 2B8uA+0S605k8FY7l2mPmIjB4xgK6I134Hz1vo9qPp7YR/l5pXCH4kLZjNH0h9vnWs
	 KkwX7dH70LuHwBsqtUfAXcAMAZGfW9QI3cEjU5c9b8sanPAYN+dWdldXasv/te0U29
	 s3Mxd8RZf18xA==
Date: Sat, 15 Nov 2025 11:27:48 +0000
From: Yao Zi <ziyao@disroot.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Runhua He <hua@aosc.io>, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH net-next v2 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
Message-ID: <aRhjtPbO0ElkBM26@pie>
References: <20251111105252.53487-1-ziyao@disroot.org>
 <20251111105252.53487-3-ziyao@disroot.org>
 <aRMY7GyocIJkgzZ2@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRMY7GyocIJkgzZ2@shell.armlinux.org.uk>

On Tue, Nov 11, 2025 at 11:07:24AM +0000, Russell King (Oracle) wrote:
> On Tue, Nov 11, 2025 at 10:52:51AM +0000, Yao Zi wrote:
> > +	plat->bus_id		= pci_dev_id(pdev);
> > +	plat->phy_addr		= -1;
> > +	plat->phy_interface	= PHY_INTERFACE_MODE_GMII;
> > +	plat->clk_csr		= STMMAC_CSR_20_35M;
> > +	plat->tx_coe		= 1;
> > +	plat->rx_coe		= 1;
> > +	plat->maxmtu		= JUMBO_LEN;
> > +	plat->rx_queues_to_use	= 1;
> > +	plat->tx_queues_to_use	= 1;
> > +	plat->clk_ref_rate	= 125000000;
> > +	plat->core_type		= DWMAC_CORE_GMAC4;
> > +	plat->suspend		= stmmac_pci_plat_suspend;
> > +	plat->resume		= motorcomm_resume;
> > +	plat->flags		= STMMAC_FLAG_TSO_EN;
> 
> Can you also set STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP here, so if EEE
> is used, we can shut down the transmit clock to the PHY if the PHY
> supports that? I would like all new glue drivers to set this where
> possible please.

Yes, the flag could be set and I'll do it in v3.

Regards,
Yao Zi

> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

