Return-Path: <netdev+bounces-233965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE5AC1A84F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0186E188653A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB520325706;
	Wed, 29 Oct 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c9N0ESm+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400E325707;
	Wed, 29 Oct 2025 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741825; cv=none; b=pDZbDyU6+UBARPaNgc8iSYs3yG2OMR8wSwjau5qf0OR4cTa/7BrAwpBUFalu8tHyOO9hKwfH+WiBTEKev7biKTgCOgQwQsd7PB0mh3IzSLWMS9vZ7cOnxH4ZNoaxh5P06rtUXaYEdvkn0elB4UhVtUqaTenNzJqaQy9lGbgspKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741825; c=relaxed/simple;
	bh=xjTYlHSWXTWoCijJGLjK9QiJe5bufWepStum4iDnqh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpP7gEtD9vmhC6fExSJ2CVp6X7PvdQmwyFbGyidMl2Gkr+ek4DaHw2T5n+IsWRxWH4B9J2q5L4TlJx9ei+vxZyYZH3fKxypEO3b6rn26yoUYHiPvXL4vXITFe6bQEWEKAEnojQKJIWtNBtMBwrKWaYhaWIKF+wZFB+VY+twNzr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c9N0ESm+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VlAt1oZk8nm2vtQPIGdWXb+UoZtSzZo8u38Fv13CbRE=; b=c9N0ESm+76Fatt5yai+/2552dG
	BP1NG9QFVNEDsWdabe9uoX0LGUBig3WbZApaoqlcQajcGCy14/JLg7R1iD8jnSYxs1JOzpSyQUQjh
	HXeon1P8u/frEGf1nZDs17xKLRzPdRQIlVUOViUV2IzCOJzkdm1rulGMbgi4FgXL4QCw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vE5WW-00CP3n-G5; Wed, 29 Oct 2025 13:43:32 +0100
Date: Wed, 29 Oct 2025 13:43:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/4] net: mdio: implement optional PHY reset
 before MDIO access
Message-ID: <23c1bed1-3f95-48b9-8ff0-71696bdcd62b@lunn.ch>
References: <cover.1761732347.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761732347.git.buday.csaba@prolan.hu>

On Wed, Oct 29, 2025 at 11:23:40AM +0100, Buday Csaba wrote:
> Some Ethernet PHY devices require a hard reset before any MDIO access can
> be safely performed. This includes the auto-detection of the PHY ID, which
> is necessary to bind the correct driver to the device.

nitpicking a bit, but this last part is not strictly correct. You can
also bind the correct driver to the PHY using a compatible. So it is
not 'necessary'. It is maybe the preferred way to do it, although the
DT Maintainers my disagree and say compatible is the preferred way.

> The kernel currently does not provide a way to assert the reset before
> reading the ID, making these devices usable only when the ID is hardcoded
> in the Device Tree 'compatible' string.

Which is what you say here.

> (One notable exception is the FEC driver and its now deprecated
> `phy-reset-gpios` property).

> This patchset implements an optional reset before reading of the PHY ID
> register, allowing such PHYs to be used with auto-detected ID. The reset
> is only asserted when the current logic fails to detect the ID, ensuring
> compatibility with existing systems.

O.K, that is new.

One of the arguments raised against making this more complex is that
next somebody will want to add clock support. And should that be
enabled before or after the reset? And then regulators, and what order
should that be done in? The core cannot answer these questions, only
the driver can. The compatible should be used to get the driver loaded
and then it can enable these resources in the correct order.

I will look at the patches anyway.

  Andrew

