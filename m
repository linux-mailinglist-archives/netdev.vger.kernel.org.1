Return-Path: <netdev+bounces-223067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E3DB57D05
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C94206E0B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AE931283E;
	Mon, 15 Sep 2025 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="po8d4Ck/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3E31326A;
	Mon, 15 Sep 2025 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942842; cv=none; b=jEyZBhK9dlYgjxtr/pGPmsY3hd3XybcHz10D9dVKJ6w8JnPwykVa4RHYpWPw1jK5BXE5Y/6NATis3rDT6ccFjvofoqTHikimVB89qRfcnEzmkPxNzYDW+W6tTHK/qS+UtZ7W0lyF7N6h8oU+UdG/SXVwjI6uUAkBTQldT8JNQss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942842; c=relaxed/simple;
	bh=WoitGEBgztBQqdBlF8NbmsMB72jwUQYoCMs0G593t8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3sS0veFJVCtX5QOOEC6+wh41vrsrmHKFTS0aUDLg/pUy69UDPddQXW/yhnFUOBPuavV219CUuw1lS+9O4AfGiEgy3RAKOSfkW3Ke4GehtVU/I09s0P0U3ObHPW9g4hY6AY8OcnATdVVKEjNJP9lszBOQhlCCRtihfuKhJD3+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=po8d4Ck/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KhH9JaGVt0xFjtd/9rZ5yVxJfdJ34L81tAHOgcP5jSo=; b=po8d4Ck/ekluVdIKKV3oF89FUy
	qSKah+nVRZ32EyZEbNKZA0Qal3el2ogguyvp1PeAEvOxZ67I2Q/hJ7Q3i9LlXSOOM6l33MYX3c/d3
	D+xCPI+seAxPR+070ZFpatBtYHvUilCPhAzUwK2HdNpJiMHLeKZCsbE//i2geE962wtU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uy9EN-008Rcq-4T; Mon, 15 Sep 2025 15:26:55 +0200
Date: Mon, 15 Sep 2025 15:26:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zhang Jian <zhangjian.3032@bytedance.com>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>, netdev@vger.kernel.org,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	guoheyi@linux.alibaba.com, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH 1/1] Revert "drivers/net/ftgmac100: fix
 DHCP potential failure with systemd"
Message-ID: <fdeb3a11-416a-4043-9eb4-fff225e448d9@lunn.ch>
References: <20250912034538.1406132-1-zhangjian.3032@bytedance.com>
 <4a639a86-37e2-4b3d-b870-f85f2c86cb81@lunn.ch>
 <CA+J-oUvsnovtMGKVAWnw-eG6SZvNZLEOsf-8zp6BEwzq4_wvhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+J-oUvsnovtMGKVAWnw-eG6SZvNZLEOsf-8zp6BEwzq4_wvhw@mail.gmail.com>

> > > This reverts commit 1baf2e50e48f10f0ea07d53e13381fd0da1546d2.

    DHCP failures were observed with systemd 247.6. The issue could be
    reproduced by rebooting Aspeed 2600 and then running ifconfig ethX
    down/up.
    
    It is caused by below procedures in the driver:
    
    1. ftgmac100_open() enables net interface and call phy_start()
    2. When PHY is link up, it calls netif_carrier_on() and then
    adjust_link callback
    3. ftgmac100_adjust_link() will schedule the reset task
    4. ftgmac100_reset_task() will then reset the MAC in another schedule
    
    After step 2, systemd will be notified to send DHCP discover packet,
    while the packet might be corrupted by MAC reset operation in step 4.

We might be able to solve this issue in a different way.

> > > * the PHY state_queue is triggered and calls ftgmac100_adjust_link
> > > -     /* Release phy lock to allow ftgmac100_reset to acquire it, keeping lock
> > > -      * order consistent to prevent dead lock.
> > > -      */
> > > -     if (netdev->phydev)
> > > -             mutex_unlock(&netdev->phydev->lock);
> > > -
> > > -     ftgmac100_reset(priv);
> > > -
> > > -     if (netdev->phydev)
> > > -             mutex_lock(&netdev->phydev->lock);
> > > -
> > > +     /* Reset the adapter asynchronously */
> > > +     schedule_work(&priv->reset_task);

Before scheduling the work, call netif_carrier_off().  At the end of
ftgmac100_reset(), turn the carrier back on again.

That carrier off/on will probably trigger systemd to restart the dhcp
client. Not great, but better than nothing.

I think the real fix however is to minimise ftgmac100_reset() to just
what is needed, and see if rtnl is really needed. It is the race with
unlocking phydev, and then relocking it after taking rtnl which is the
problem.

	Andrew

