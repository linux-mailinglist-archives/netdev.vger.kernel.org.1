Return-Path: <netdev+bounces-168286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08993A3E652
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 22:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4EA189894F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 21:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8982641E3;
	Thu, 20 Feb 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NU+mw5hw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67D61DF735;
	Thu, 20 Feb 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085544; cv=none; b=nQ5lpPulUHU7/1ilGzfKR43xTDx+NrCKHmKdQmraH+aC1tgAX4EGRSOVFfN6yCchuiCgd52jbAf8QhpYXmL1HOjGj3FZZ2dqKSpFV5qH7PR6frL+rjr7hcnhxJUBO2l2LH2YRhFnvocBMwhuA6Bm6JfM5zeaAuTfvyRwU6dHYoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085544; c=relaxed/simple;
	bh=qxUcrvbM/dFytLqxNyj4DOyCxFG8tMFm5cdMjTmoUU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQgrDHtoTSVG0Ef3U2kuIHdja8bCm8OeQFJUgihOEJ52HD76zgqbXFhURmFvADC/e4VhLTAc042jAhQXt1x4APs5cOg6bqBTiNID+ntbdlHmfzRnJQHwyLntwzbWzmN829PtFbf/9Z2aZWHzY3ZTcxyQwvygfhXiMod1Mrf0KBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NU+mw5hw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaeec07b705so223542266b.2;
        Thu, 20 Feb 2025 13:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740085541; x=1740690341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXLZcMFLzxHY6o5f90FwW1xMIIMedT3qYeWoorn0dt0=;
        b=NU+mw5hw9TKg8Q1w4OMNtdQKwr9BiSWBwHqt+S7XWdjLCNA2Lc9r1h2MwgrtFKXjbl
         yawcPXSpaMcCdIE2qHLLIlx/hLTPIKy13kjakJXot0LnuaQuncmueqZlEwsO87e3Cquc
         oeHf5EBmf5iAYjix0CsrmwkqOSu8TEweEke66Op5feILSWqjk4O2/h6c9r58N8TUpRqR
         wlHlULk+7uHKB1oisflN04clqQK0+qzGugMIkQgfmIzzyGTcg6AT9QLvBt0jAIWpNTtd
         yCf+NffGTKQpdUBfWyj0cNegx5aE4MX+4KM2O6VPeO50azY1Pw6AhKcOrxSiCzR4P27b
         Z34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740085541; x=1740690341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXLZcMFLzxHY6o5f90FwW1xMIIMedT3qYeWoorn0dt0=;
        b=CXdHhU1hOADff1Z52kO5ipZzVhG8NhGO8+0ajv4oGg2b9KFsmWksH6ZHAQXTs7wmFu
         Zicz9iOF2/fk2hEz+vuBVTpDaXr9TDSZeCyJcDMZ52NzE6X9see5S65NyiRojGOZFinZ
         xL0oZet4BT979Bjt7gLt5k+9Mo/szjTuIl9HxfDApzpMiWRH7xlIyDSmrC/pMvE8KZip
         24dhD0fRsAqn3ATskb3Zt86hOYvQ36tfun++a6yp98UnkzQnMGYTUhEpCI86NLd9mrKM
         tbLgCUhPByvgc/297JAvd4itZ0sxs1RAvNNP4Ap72/i5iCsV3DpO/QKUVXb5F7hZGX88
         sHrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV28rarxmvvyRyk9Mk/Mhmfk5bOH2T8CHRJviAqm9X957fHUXweVAti96wnx8KdKyDk6mgLijZXXdE9K9A=@vger.kernel.org, AJvYcCXKbDz+xcugovZ1kXA9V7LmTrzFdVfeqdtU+rDHZcecaBqUbWpdB/ve0o/9NY4DUVAgedUH871K@vger.kernel.org
X-Gm-Message-State: AOJu0YxEqHSwNn9pWYINpu138ctt+7fnIWU1JSY/f7M6D73w4aQoG3zD
	32jnSzsebdHw1g5Yu2n3i7ukpBu4i2Fcg0M4UMBn+IXOpxFTjh57
X-Gm-Gg: ASbGnctaErVOvxCVEo/9NxRYm+Sh9Hn6UqkSk8oOUVOsWInbU5npalfWXnZZ73e2z5d
	TmdKGgPKLCDueT0mp1BZg+my/OE+NG+5LeFf6pTQqz0FGmbJex0xGHkrBOIe+NMHXQ/711sX6tv
	D1WjTNmIZbJCgz42pgc36LgIoYsMcx1fY/QUhtsP6OxudmmFXD0rYqKzVzr3k8DEmcKKdxjJpm2
	Yh7woSceJwyNUh2CjjOhwrMKJNXAPdc+Fg3lETc4fa0qrmbSW3o8aNRejReBj6YWCC3qhekX/ya
	TdVsn1ZXAp6G
X-Google-Smtp-Source: AGHT+IFO56aTGAWz4FxSuopUBhKeANVgqvRNWyrSZYpRv5N8W0G8Cwf+1O//muv4eCM29hYiV3R2aA==
X-Received: by 2002:a17:906:318b:b0:abb:b322:2b37 with SMTP id a640c23a62f3a-abc0d9888eemr23864466b.7.1740085540729;
        Thu, 20 Feb 2025 13:05:40 -0800 (PST)
Received: from debian ([2a00:79c0:604:ea00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532802a1sm1522398266b.76.2025.02.20.13.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:05:40 -0800 (PST)
Date: Thu, 20 Feb 2025 22:05:37 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: marvell-88q2xxx: Prevent hwmon
 access with asserted reset
Message-ID: <20250220210537.GA3469@debian>
References: <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com>
 <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-2-78b2838a62da@gmail.com>
 <Z7b3sU0w2daShkBH@shell.armlinux.org.uk>
 <20250220152214.GA40326@debian>
 <Z7dKRrXIUCaVeRfH@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dKRrXIUCaVeRfH@shell.armlinux.org.uk>

Am Thu, Feb 20, 2025 at 03:29:10PM +0000 schrieb Russell King (Oracle):
> On Thu, Feb 20, 2025 at 04:22:14PM +0100, Dimitri Fedrau wrote:
> > Hi Russell,
> > 
> > Am Thu, Feb 20, 2025 at 09:36:49AM +0000 schrieb Russell King (Oracle):
> > > On Thu, Feb 20, 2025 at 09:11:12AM +0100, Dimitri Fedrau wrote:
> > > > If the PHYs reset is asserted it returns 0xffff for any read operation.
> > > > This might happen if the user admins down the interface and wants to read
> > > > the temperature. Prevent reading the temperature in this case and return
> > > > with an network is down error. Write operations are ignored by the device
> > > > when reset is asserted, still return a network is down error in this
> > > > case to make the user aware of the operation gone wrong.
> > > 
> > > If we look at where mdio_device_reset() is called from:
> > > 
> > > 1. mdio_device_register() -> mdiobus_register_device() asserts reset
> > >    before adding the device to the device layer (which will then
> > >    cause the driver to be searched for and bound.)
> > > 
> > > 2. mdio_probe(), deasserts the reset signal before calling the MDIO
> > >    driver's ->probe method, which will be phy_probe().
> > > 
> > > 3. after a probe failure to re-assert the reset signal.
> > > 
> > > 4. after ->remove has been called.
> > > 
> > 
> > There is also phy_device_reset that calls mdio_device_reset.
> 
> Ok, thanks for pointing that out.
> 
> > > That is the sum total. So, while the driver is bound to the device,
> > > phydev->mdio.reset_state is guaranteed to be zero.
> > > 
> > > Therefore, is this patch fixing a real observed problem with the
> > > current driver?
> > >
> > Yes, when I admin up and afterwards down the network device then the PHYs
> > reset is asserted. In this case phy_detach is called which calls
> > phy_device_reset(phydev, 1), ...
> 
> I'm still concerned that this solution is basically racy - the
> netdev can come up/down while hwmon is accessing the device. I'm
> also unconvinced that ENETDOWN is a good idea here.
>
Yes it is racy. A solution would be to set a flag or whatever in
mdio_device_reset right before changes to the reset line happens and
clear the flag right after the changes have been done. Add a function
that return the state of the flag.
Better go back to EIO ? At first I thought it was a good idea because
the user gets at least a hint what the cause of the error is...

> While I get the "describe the hardware" is there a real benefit to
> describing this?
> 
I can't follow.

> What I'm wondering is whether manipulating the reset signal in this
> case provides more pain than gain.
>
It seems so. I wasn't really aware of it :-)

Best regards,
Dimitri Fedrau

