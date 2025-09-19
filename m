Return-Path: <netdev+bounces-224660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF298B87A2E
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 03:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43981C2455C
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 01:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F112309B9;
	Fri, 19 Sep 2025 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q5BYpI2e"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC47E0E8
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758246486; cv=none; b=pTUmpPM3wUMWFQ2rTBP4h049F1ErnKiF3D0677YxalInxXzYW2oa09K92prVgVNbHIekgC8wB6meH8IoSd4w36Iwow7iyF2Log5s+I1EWDxOo4RHwYPVTwuRJo2nqhnb+yVtLmauuSrpN7v6hF39gi+2K66JPQdtsXJy6soGoqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758246486; c=relaxed/simple;
	bh=ds22ARy3uyRqu7PZvmoQoXuSUNg0vdWhnMMRyOdNfzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0oTH08r0zAmxSXS92g/mKax1sIH/kkei2IRNiwBulJyXfG6uErNv+vnuXUMkdJExQ93XZsRu+YQTEWd1QjAiXo46kGEH14rT2GwehGLJHUdrN/a1IPIA2dmpP8/ezoJwMEMNSsYiZnny+115Cbemd5g3dJRmc1e/Hd28l8+iEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q5BYpI2e; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sqC1rj8snhkg/JVn891BD7odaY900ySqHfjbkr8siEw=; b=q5BYpI2eO4qivudttSrcwYIg2z
	Zb3pKsAIhPTlvWe/lyRy7gjtf5erRlWkeVNp9iFs6nwrfuwmcsjDBJxsoNtUTlB3JMqc9WXdyEouN
	7PhuYkYbreBosXAUMQIS7Lkea6BOm2l9Od3tPFlPjXgzUiX0MrRyCnr5aEA3DiZvxFHc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzQEB-008tRU-Q7; Fri, 19 Sep 2025 03:47:59 +0200
Date: Fri, 19 Sep 2025 03:47:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 03/20] net: phy: marvell: add PHY PTP support
Message-ID: <5132d023-2308-490b-a867-07445ae4ddbe@lunn.ch>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
 <E1uzIb5-00000006mzK-0aob@rmk-PC.armlinux.org.uk>
 <299f61cc-b5a7-48a6-b16d-f1f5d639af85@lunn.ch>
 <aMxsl4v-Aio6R20R@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMxsl4v-Aio6R20R@shell.armlinux.org.uk>

On Thu, Sep 18, 2025 at 09:33:27PM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 18, 2025 at 10:12:02PM +0200, Andrew Lunn wrote:
> > > +static u64 marvell_phy_tai_clock_read(struct device *dev,
> > > +				      struct ptp_system_timestamp *sts)
> > > +{
> > > +	struct phy_device *phydev = to_phy_device(dev);
> > > +	int err, oldpage, lo, hi;
> > > +
> > > +	oldpage = phy_select_page(phydev, MARVELL_PAGE_PTP_GLOBAL);
> > > +	if (oldpage >= 0) {
> > > +		/* 88e151x says to write 0x8e0e */
> > > +		ptp_read_system_prets(sts);
> > > +		err = __phy_write(phydev, PTPG_READPLUS_COMMAND, 0x8e0e);
> > > +		ptp_read_system_postts(sts);
> > > +		lo = __phy_read(phydev, PTPG_READPLUS_DATA);
> > > +		hi = __phy_read(phydev, PTPG_READPLUS_DATA);
> > > +	}
> > > +	err = phy_restore_page(phydev, oldpage, err);
> > > +
> > > +	if (err || lo < 0 || hi < 0)
> > > +		return 0;
> > > +
> > > +	return lo | hi << 16;
> > 
> > What happens when hi is >= 0x8000? Doesn't that result in undefined
> > behaviour for 32 bit machines? The u64 result we are trying to return
> > is big enough to hold the value. Does the hi need promoting to u64
> > before doing the shift?
> 
> Good point - looking at the generated code, it gets sign-extended
> to a 64 bit value. So, hi=0x8000 results in 0xffffffff8000XXXX
> being returned.
> 
> Does it matter? There are two functions that call the cyclecounter
> ->read() method. timecounter_init() sets ->cycle_last from the
> value, and timecounter_read_delta() does this:
> 
> 	cycle_delta = (cycle_now - tc->cycle_last) & tc->cc->mask;
> 
> before updating ->cycle_last with the returned value. As the
> mask is initialised thusly:
> 
> 	tai->cyclecounter.mask = CYCLECOUNTER_MASK(32);
> 
> this masks off the sign-extended high 32-bits, giving us back
> a value of 0x8000XXXX.
> 
> So, while the sign extension is undesirable, it has no effect on
> the operation. Is it worth throwing casts in the code? I suspect
> that's a matter of personal opinion.

I doubt the static analysers can do such a detailed analysis. So at
some point we are going to get patches adding a cast. You could maybe
change hi to a signed 64. That would avoid adding a cast, while still
being O.K. to hold a negative error code from __phy_read().

	Andrew

