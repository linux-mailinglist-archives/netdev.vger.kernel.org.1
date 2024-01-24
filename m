Return-Path: <netdev+bounces-65489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9D83AC97
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 15:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0391F20FC1
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C756415BE;
	Wed, 24 Jan 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDWWmtGD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F1A15B1
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108315; cv=none; b=Dlbsk9ZquGaaf0aF2AMvvIMGI5Z0OYprDiOB+eYSRqe6BgPzo8qLb55ZjCkLwjmut4DRKx9iBrrQbl2GFYR0Ovqp47G024jsPm0KbV7m+4dcWnkDkbIBnUtv4TMi9YkHinQxG7/jDVObxMoaahl5YHWAs/HR11E1tLaizWkGsb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108315; c=relaxed/simple;
	bh=tT9TDYJ1jprE+BuZNsdzqbaEupw/mitvBL5w2cy7GLs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+NoEXlcSAf5pHn37g3TljfzBQq1AMCIwO6+b7AldbGZbx3ED0LRP033dx3JZYpKSmi6SrSFiuneqKuNXeL5sY1HH2+MPVVqWhN4PJSeO9wg9uhuDgom29ehKZdz3JcSh/w8TvY0VUC6KDu53Ka9gHoOQaoYJz7rgkxJPzOowQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDWWmtGD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e9ef9853bso32094845e9.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 06:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706108312; x=1706713112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NZOeOUIN4NciIol3NU+jL8OzMgugi8rA3IyWUeisHao=;
        b=VDWWmtGDkMxHwWbbqXuQFiGADQ5U/uSabKn+/stDRmZMa/xvJy7jbLq6onWvpqffET
         kQAF9gIDwd02h+qqI7GGtr2haLgTJCjPdmW3TQBMAw9OGUDvgsFcOWkuFxWfWIEOjae1
         YFAkuYCuARZptdrdbx11MUnOlOLWC53Su04X9tZg/9jLOorcFZ2l6Gvmqx+220NR3n/R
         SQNV8rymZ2LNZJNXc5alidugZp6yAx0UioIGC2dfdUkXsnqYD1CwD6rE1krqz1tqLw2B
         XJ6KZnppUiLf6G8JHMJkIgnpraNKZc8OCD8pJ02yJmkHTdZU6Pr736cCDgiFSYD53xIv
         OlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706108312; x=1706713112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZOeOUIN4NciIol3NU+jL8OzMgugi8rA3IyWUeisHao=;
        b=Hm0oYmHaI5gdFmJdM3fZHDI4y3YUZmkbgoO4u7F/WumoY7piibfuIwOx6urPLE9h9n
         F6EjvdnLfhkzEk649bI3MKcagiuKa4/V6C340okrUzlqaQ9hr8YAZnhbKconh8CMt2ez
         sE+vfWx1NA+NO6skM/M1sDu4ChwwV2jFAGxtfG4XYbo51oeSSR3PENfDIL+0yfhE1qd/
         25/sDZoQMhlXB9lXovSnInChNOcXrOFdP2vSwvywA7FnJOcPoy2QKM9pKS8F8IAgTl5U
         uhsLPLaPvedx+fxrfs/RA8A2juS0wdthI3XV/Ajs1eYUiz9k30n8pJGfBjV4/8MEqHKC
         6zxw==
X-Gm-Message-State: AOJu0YxqbEF0k+fzPGcdyQHmanhNo+8DxkSA5lgdFGKBSzYmodccy8jC
	N1NCqJkEu+YITjGHTvHK923Osd4YQkp5wZzD60sRuQQgV5NyoVbi
X-Google-Smtp-Source: AGHT+IGI/QKnh09EfvR94KPxbt4TaWwtOmsPwRBM69ces8w/bGqmVL4Ds/PZgBBDS3s5FWPmqBt99A==
X-Received: by 2002:a05:600c:3b15:b0:40e:8112:3f88 with SMTP id m21-20020a05600c3b1500b0040e81123f88mr791349wms.181.1706108311817;
        Wed, 24 Jan 2024 06:58:31 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040e47dc2e8fsm45887779wmq.6.2024.01.24.06.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:58:31 -0800 (PST)
Message-ID: <65b12597.050a0220.66e91.7b3b@mx.google.com>
X-Google-Original-Message-ID: <ZbEllMSCBLxoMC-f@Ansuel-xps.>
Date: Wed, 24 Jan 2024 15:58:28 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Network Development <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: Race in PHY subsystem? Attaching to PHY devices before they get
 probed
References: <bdffa33c-e3eb-4c3b-adf3-99a02bc7d205@gmail.com>
 <a9e79494-b94a-40f7-9c28-22b6220db5c2@lunn.ch>
 <Za6eMg0y2QxogfmD@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Za6eMg0y2QxogfmD@shell.armlinux.org.uk>

On Mon, Jan 22, 2024 at 04:56:18PM +0000, Russell King (Oracle) wrote:
> On Mon, Jan 22, 2024 at 03:12:42PM +0100, Andrew Lunn wrote:
> > On Mon, Jan 22, 2024 at 08:09:58AM +0100, Rafał Miłecki wrote:
> > > Hi!
> > > 
> > > I have MT7988 SoC board with following problem:
> > > [   26.887979] Aquantia AQR113C mdio-bus:08: aqr107_wait_reset_complete failed: -110
> > > 
> > > This issue is known to occur when PHY's firmware is not running. After
> > > some debugging I discovered that .config_init() CB gets called while
> > > .probe() CB is still being executed.
> > > 
> > > It turns out mtk_soc_eth.c calls phylink_of_phy_connect() before my PHY
> > > gets fully probed and it seems there is nothing in PHY subsystem
> > > verifying that. Please note this PHY takes quite some time to probe as
> > > it involves sending firmware to hardware.
> > > 
> > > Is that a possible race in PHY subsystem?
> > 
> > Seems like it.
> > 
> > There is a patch "net: phylib: get rid of unnecessary locking" which
> > removed locks from probe, which might of helped, but the patch also
> > says:
> > 
> >     The locking in phy_probe() and phy_remove() does very little to prevent
> >     any races with e.g. phy_attach_direct(),
> > 
> > suggesting it probably did not help.
> 
> The reason for that statement is because phy_attach_direct() doesn't
> take phydev->lock _at all_, so taking the lock in phy_probe() has no
> effect on any race with phy_attach_direct().
> 
> > I think the traditional way problems like this are avoided is that the
> > device should not be visible to the rest of the system until probe has
> > completed.
> 
> However, we have the problem of the generic driver fallback - which
> phy_attach_direct() does.
> 
> The probe vs phy_attach_direct() has been racy for quite a long time,
> and the poking about that's done in that function such as assigning
> struct device's driver member, calling device_bind_driver() etc is
> all hellishly racy if the phy_device _could_ be bound simultaneously.
> 
> Also note this... we call device_bind_driver() from phy_attach_direct(),
> and the documentation for this function states:
> 
>  * This function must be called with the device lock held.
> 
> which we don't do. So we're already violating the locking requirements
> for the driver model.
> 
> So, I would suggest that the solution is to make use of device_lock()
> which will also only return once a probe has succeeded.
> 
> However, that's still not ideal - because the fact we have a race here
> means that what could happen is that phy_attach_direct() is called
> a little earlier than the probe begins, and the phy device ends up
> being bound to the generic PHY driver rather than its specific driver.
> 
> I think what this comes down to are the following points:
> 
> 1) not using the required device model locking
> 2) the mere existence of the default driver makes for a race between
>    the PHY being attached and its driver being probed.
> 
> No amount of locking saves us from (2) - the only solutions that I can
> see to this are:
> 1) to put up with there being such a race
> 2) get rid of the default drivers altogether and insist that we have
>    specific PHY drivers for _all_ PHYs
> 3) have some kind of retry mechanism
> 
> A further problem is... we can't simply return -EPROBE_DEFER from
> phy_attach_direct() because this function may not be called from
> probe functions - it may be called from the .ndo_open method which
> has no idea how to handle a probe deferal. Moreover, returning an
> error to userspace will just cause it to fail (because all errors
> from trying to bring a netdev up are considered to be fatal.)
> 
> So, it's a really yucky problem, and I don't see any nice and simple
> solution.
>

Well if we start having more and more PHY that require loading a FW then
this will become a big problem...

I wasted some good time on this and if the MDIO is slow enough loading
the FW can take even 100s resulting in probe still having to finish and
config_init called later.

Since the FW has not been loaded config_init returns bad data and fails
to configure. (and after a while probe is complete)

I don't know if it would be ok as a solution but I think moving the
fw_load call in the config_init seems to "handle" this problem but IMHO
it's still and hack for a fragile implementation.

-- 
	Ansuel

