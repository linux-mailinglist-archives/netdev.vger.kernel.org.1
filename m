Return-Path: <netdev+bounces-107500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E41591B342
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 02:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4AB282DF0
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 00:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADABA15CE;
	Fri, 28 Jun 2024 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ox1cTSR9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA80037B;
	Fri, 28 Jun 2024 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719533942; cv=none; b=Uw3XpssERQwOgj63kZEA7CF2gtChaxCiLb2MUwpLrfGtY+KK4o/pA0w3Mmo1g8S1dhDrqLXJHSaV+pdxW3F7/Gezf4vl+mxTTcE1QsYUFjqvpdlcwndtH4hixzRUmenmU6VdcCO31+wo2hXbur6+XGUbzO3MP12SxxZh4aanmtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719533942; c=relaxed/simple;
	bh=rPX38+Ity8fK7DN4OSCz8/N8q21zqUJ/qt3eFGqWfGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyMbeH2JSyDg927yRKo5qmVFYMVWlYbpUiHj/frZIl8ncjGNT+qExHdEjWhu/gntiGL4t40FuBh0Dex9ajtGpd2f61q/oXf4/mi3fuHnP7XNKM2h3u0Ebg1NH9tbOyJPg3ePFOdSGptb5q7qP9/oJs2Sl62NrHVyGCWxKBsur/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ox1cTSR9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NOars6xQgRS8s48rhpVjllpjJ7HsZP9qcOz0PZGctM8=; b=ox1cTSR9gvsqJuHYlZucsoHSsB
	UAk+BOne8++Jpzfis4oAiqm/JIgEH44KP/p/svBijrZAoTYEL25XNuQiYwL2itgcRYx0Uftv4AJEG
	PaWc6ny4avEdHb8yDXOVe8ELsVFC0j8kaQUmCm+5AGYPUyrFUgpolvfASyfonKxTCaP4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMzK9-001Dw2-5k; Fri, 28 Jun 2024 02:18:45 +0200
Date: Fri, 28 Jun 2024 02:18:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 net-next 3/3] net: phy: aquantia: add support for
 aqr115c
Message-ID: <d227011a-b4bf-427f-85c2-5db61ad0086c@lunn.ch>
References: <20240627113018.25083-1-brgl@bgdev.pl>
 <20240627113018.25083-4-brgl@bgdev.pl>
 <Zn3q5f5yWznMjAXd@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn3q5f5yWznMjAXd@makrotopia.org>

On Thu, Jun 27, 2024 at 11:42:45PM +0100, Daniel Golle wrote:
> Hi Bartosz,
> 
> On Thu, Jun 27, 2024 at 01:30:17PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > Add support for a new model to the Aquantia driver. This PHY supports
> > Overlocked SGMII mode with 2.5G speeds.
> 
> I don't think that there is such a thing as "Overclocked SGMII mode with
> 2.5G speed".

Unfortunately, there is. A number of vendors say they do this, without
saying quite what they actually do.  As you point out, symbol
replication does not work, and in-band signalling also makes no
sense. So they throw all that away. Leaving just the higher clock
rate, single speed, and no in-band signalling.

In the end, that looks very similar to 2500BaseX with broken inband
signalling.

> Hence I assume that what you meant to say here is that the PHY uses
> 2500Base-X as interface mode and performs rate-adaptation for speeds
> less than 2500M (or half-duplex) using pause frames.

Not all systems assume rate adaptation. Some are known to use SGMII
for 10/100/1G with inband signalling, and then swap to 2500BaseX
without inband-signalling for 2.5G operation!

2.5G is a mess.

    Andrew

