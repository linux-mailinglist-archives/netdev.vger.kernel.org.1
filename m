Return-Path: <netdev+bounces-174736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC7DA6016C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1048188D065
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F06C1F1305;
	Thu, 13 Mar 2025 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vckNOv8+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCF417E;
	Thu, 13 Mar 2025 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894816; cv=none; b=gPB6acOhtiWee2R6Ny8pmFa/vkFwK1VEldAHnN2LT5cAsVsV0XrgpyimSfOhK1nDaoIJ68ckXyjSzomA+nAnrlxUBqsgH58/MvauRxCP+gsXqtZ71Pext76w6yNulAOkRdz+XwKufZ/WDwA+w8l19Jc2pb3aXXwdzqVgEGcFMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894816; c=relaxed/simple;
	bh=MxnMpBHlU5qSu1Hw5ANyvJ4rrYrWYTVkrc5mFvbVK6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQS7f/1mzbnKR39+1ptsJu5VzUfOp8MdSEzMFZWCjJqGV1F9cIlshrm/kDAmn2SrHJL4poKaoUUshSkI4J71wSQ3iRmz/XHuludMc5dHBdpJsMrnjk0Wcbe1lxPlqQIiTTXWNCvhnQJNhTHtlMsZd0UaXVwV2CvquIn5bsAX4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vckNOv8+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9naFZnNjfAr4VFxA6DXzomBgdIv+Y9yUqhztcRXhoo4=; b=vckNOv8+pcWjuTykQnmDcnPQZS
	mzzt1MGc6Q6W8aKmz9/rdPsKq/DBGGBbXIVYG0Nm0Cu47iVGjsSx555zxXW2jtJeIEjMMx0SsYS0t
	yDQnoH89NmjldiJPse3NtUw4EsntwDXICAX2cgUdckkAJ9b4ZampTrTK0rFZfuq4UmgM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsoPM-0055Vu-Ck; Thu, 13 Mar 2025 20:39:56 +0100
Date: Thu, 13 Mar 2025 20:39:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Klein <michael@fossekall.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: realtek: Add support for PHY LEDs on
 RTL8211E
Message-ID: <e3a36d27-5f7b-4c86-a6b9-2b37d3d16ee8@lunn.ch>
References: <20250312193629.85417-1-michael@fossekall.de>
 <e62af3a7-c228-4523-a1fb-330f4f96f28c@lunn.ch>
 <Z9Mp86eWYw3hgt0x@a98shuttle.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9Mp86eWYw3hgt0x@a98shuttle.de>

> > > +static int rtl8211e_led_hw_control_get(struct phy_device *phydev, u8 index,
> > > +				       unsigned long *rules)
> > > +{
> > > +	int oldpage, ret;
> > > +	u16 cr1, cr2;
> > > +
> > > +	if (index >= RTL8211x_LED_COUNT)
> > > +		return -EINVAL;
> > > +
> > > +	oldpage = phy_select_page(phydev, 0x7);
> > > +	if (oldpage < 0)
> > > +		goto err_restore_page;
> > > +
> > > +	ret = __phy_write(phydev, RTL821x_EXT_PAGE_SELECT, 0x2c);
> > > +	if (ret)
> > > +		goto err_restore_page;
> > 
> > What is happening here? You select page 0x7, and then use
> > RTL821x_EXT_PAGE_SELECT to select 0x2c? Does this hardware have pages
> > within pages?
> 
> Kind of; this is from the datasheet:
> 
> 	6.9.5.  Access to Extension Page (ExtPage)
> 	
> 	Set MDIO commands as shown below to switch to the Extension Page (ExtPage) 0xXY (in Hex).
> 	1. Set Register 31 Data=0x0007 (set to Extension Page)
> 	2. Set Register 30 Data=0x00XY (Extension Page XY)
> 	3. Set the target Register Data
> 	4. Set Register 31 Data=0x0000 (switch to Page 0)
> 
> Register 30 is RTL821x_EXT_PAGE_SELECT, LED config registers are on
> extension page 0x2c

O.K. So it would be good to turn this into a patch series doing some
cleanup and then add LED support at the end.

Please add a #define for 0x07 page number. It is used in a few places,
and it would be good to replace the magic number with some sort of
name taken from the datasheet. Add other #defines as you need them, if
the datasheet gives them a name.

Add a helper something like:

rtl8211e_modify_ext_page(struct phy_device *phydev, u16 ext_page, u32 regnum,
                         u16 mask, u16 set)

and use it in rtl8211e_config_init()

Add helpers

rtl8211e_read_ext_page(struct phy_device *phydev, u16 ext_page, u32 regnum)
rtl8211e_write_ext_page(struct phy_device *phydev, u16 ext_page, u32 regnum, u16 val)

and then add LED support using these helpers. That should help
separate the LED code itself from this odd page in page code.

    Andrew

---
pw-bot: cr

