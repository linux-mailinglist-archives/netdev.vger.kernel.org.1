Return-Path: <netdev+bounces-224611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF29DB86EA3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2DC1BC253C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6B32EACF3;
	Thu, 18 Sep 2025 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mfU0A6Fn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FDB2D63E4
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227615; cv=none; b=pL4KhfHjv+00gjvlo/ceMgBXpJ2CmM0Mfalh5zV/cCDe//SnmtUty0V8wMc8n9CP53+82axGsoMN7Yes+fct8LalHMXn9ZWN3mJ/Iom2fUt9i49rNlQrvYct+nDTxdQEYx21A4nQGX1krkqSvOWypjuK2iOpq8d8vBb1CQWZtvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227615; c=relaxed/simple;
	bh=nLYn6PL0mHXKcvdGMKCiFs8JnrZRHrwFk+5bwFVPUjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYdcmXLwuKWEa67cBrhyOJIqRggnz0rLL0+83w2mT8htdcHmzVqvMzImd9CqpPK4pT/KrWlmuXu19vbI+EikQiY3nh20aZxLvqIFqfZJszpzMq5HDoXSCyzwNI6qn1XCE0NGPPLhrLxYxD8q+HcZRjSfbMe3238DEIbtkWgvBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mfU0A6Fn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wK57dgWVpMmulX+ZOs5o8wOp1BZEg0cFaZiFXUtxZng=; b=mfU0A6Fn8dSYv9axll2oxSQKol
	sbc+Bdnsfgc9SUkyuvRKMaDVkZU/NkCnnNzaOMDSh44BcfQRqnZrD8TSLv5FhVBTlHhOkMOvoZ0Qt
	22mmmaXY7c6dfVi+GBdslImPAUmJzLlDnJSNGoywNr1NR1TVMZGbWVU7sRaafKjBOGdZ+E+biaS/I
	DEbC+ep77yhZ5Sxz3GpU/uAjZApWCEcc1GIInbHBO08kjLZGYw06olDl1C9ZlO86qtgQONZcn+QrR
	eesqfTFuqR0fK61bGJV5G1bZpF923+0XVyi8E9Rd7MD3/s9BSy6/JGBA0HgUqpuk3EZgyWcG8WO8k
	jVAh5lUQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33094)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uzLJq-0000000028w-0xfm;
	Thu, 18 Sep 2025 21:33:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uzLJo-000000001Ur-02kq;
	Thu, 18 Sep 2025 21:33:28 +0100
Date: Thu, 18 Sep 2025 21:33:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 03/20] net: phy: marvell: add PHY PTP support
Message-ID: <aMxsl4v-Aio6R20R@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
 <E1uzIb5-00000006mzK-0aob@rmk-PC.armlinux.org.uk>
 <299f61cc-b5a7-48a6-b16d-f1f5d639af85@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <299f61cc-b5a7-48a6-b16d-f1f5d639af85@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 18, 2025 at 10:12:02PM +0200, Andrew Lunn wrote:
> > +static u64 marvell_phy_tai_clock_read(struct device *dev,
> > +				      struct ptp_system_timestamp *sts)
> > +{
> > +	struct phy_device *phydev = to_phy_device(dev);
> > +	int err, oldpage, lo, hi;
> > +
> > +	oldpage = phy_select_page(phydev, MARVELL_PAGE_PTP_GLOBAL);
> > +	if (oldpage >= 0) {
> > +		/* 88e151x says to write 0x8e0e */
> > +		ptp_read_system_prets(sts);
> > +		err = __phy_write(phydev, PTPG_READPLUS_COMMAND, 0x8e0e);
> > +		ptp_read_system_postts(sts);
> > +		lo = __phy_read(phydev, PTPG_READPLUS_DATA);
> > +		hi = __phy_read(phydev, PTPG_READPLUS_DATA);
> > +	}
> > +	err = phy_restore_page(phydev, oldpage, err);
> > +
> > +	if (err || lo < 0 || hi < 0)
> > +		return 0;
> > +
> > +	return lo | hi << 16;
> 
> What happens when hi is >= 0x8000? Doesn't that result in undefined
> behaviour for 32 bit machines? The u64 result we are trying to return
> is big enough to hold the value. Does the hi need promoting to u64
> before doing the shift?

Good point - looking at the generated code, it gets sign-extended
to a 64 bit value. So, hi=0x8000 results in 0xffffffff8000XXXX
being returned.

Does it matter? There are two functions that call the cyclecounter
->read() method. timecounter_init() sets ->cycle_last from the
value, and timecounter_read_delta() does this:

	cycle_delta = (cycle_now - tc->cycle_last) & tc->cc->mask;

before updating ->cycle_last with the returned value. As the
mask is initialised thusly:

	tai->cyclecounter.mask = CYCLECOUNTER_MASK(32);

this masks off the sign-extended high 32-bits, giving us back
a value of 0x8000XXXX.

So, while the sign extension is undesirable, it has no effect on
the operation. Is it worth throwing casts in the code? I suspect
that's a matter of personal opinion.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

