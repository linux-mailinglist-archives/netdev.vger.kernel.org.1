Return-Path: <netdev+bounces-224805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 845E9B8AB03
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5172A1CC4AA7
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA831FEE7;
	Fri, 19 Sep 2025 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N1o0LxE6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06032128F
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301490; cv=none; b=X8j/gG95lLwZlSSPsJ/sHJE7u3ALY67zwQCYV2tM0xtf2zus5x6ofywfCAKsUmrQhNGq75QfkoU9Qs7wgkTqRC6mbjjONa/JhwElE7gZM4/ybRNheMZsCjsuIsa/0vYFFxhuUKHp/7AF0+3CmlZKfsiB9NI9QRJBZxjTzHJ3k/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301490; c=relaxed/simple;
	bh=8OmEWYZTi4jDWLgfKMOdNsN3wxOgV8wr86mfuRCSY6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ka3Ozu9/ywacea0u+pbwYjjIkDZ3de4Hn07QAIPL2sAhUifZ8aq6bYR7vAmgx3716W2WN6bImElJ8FUvrwSLKDJPJU+mDOvaqcmQzunNU1aZKNHKn+t4X1beCaGbo7KFoDYVTauHBSrOnhJD7hFTyh+vwFvqKwUZ5gjHSHcGhGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N1o0LxE6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zaqMjDJofCJJH2ktZK/cQCvAkOOUUrLLpjn6yYpJHXU=; b=N1o0LxE6MQPJS5t4XXd3E4871z
	Xria/m92e5VlWFVz3j4M77gjw6ypsSkCrJd4pEnfsFH9P3NlEDpktWcbeZ/V0zIESxD1+WQYlS651
	nw9NYS1Y/sJckI3r8rfg6g/yP1NRbW9rgnf8etdNuMNW+1HNyFACnSxiF3xri3QaSpLM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzeXN-008xXb-P6; Fri, 19 Sep 2025 19:04:45 +0200
Date: Fri, 19 Sep 2025 19:04:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
Message-ID: <cbc4a620-36d3-409b-a248-a2b4add0016a@lunn.ch>
References: <971aaa4c-ee1d-4ca1-ba38-d65db776d869@kabelmail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <971aaa4c-ee1d-4ca1-ba38-d65db776d869@kabelmail.de>

On Fri, Sep 19, 2025 at 03:52:55PM +0200, Janpieter Sollie wrote:
> Hello everyone,

Please ensure you Cc: the correct Maintainers.

./scripts/get_maintainer.pl drivers/net/phy/sfp.c 
Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE SUPPORT)
Andrew Lunn <andrew@lunn.ch> (maintainer:ETHERNET PHY LIBRARY)
Heiner Kallweit <hkallweit1@gmail.com> (maintainer:ETHERNET PHY LIBRARY)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
netdev@vger.kernel.org (open list:SFF/SFP/SFP+ MODULE SUPPORT)
linux-kernel@vger.kernel.org (open list)

> I tested a SFP module where the i2c bus is "unstable" at best.

Please tell us more about the hardware.

Also, what speed do you have the I2C bus running at? Have you tried
different clock-frequency values to slow down the I2C bus? Have you
checked the pull-up resistors? I2C problems are sometimes due to too
strong pull-ups.

> A good question may be: is this approach sufficient to close the gap between
> "high performance" equipment having a stable i2c bus and they do not want to wait,
> and embedded equipment (the device I tested on was a BPI-R4) where every milliwatt counts?

Does your board actually confirm to the standards? I2C busses should
be able to run at 100KHz, as defined by the standard. Also, the SFP
standards define modules should work at 100KHz. And counting every
milliwatt makes no sense when you are supposed to be able to deliver
3.3V at 300mA, i.e. 1 Watt, to the module.

> Should this be fixed at another point in the initialization process (eg: not
> probing ridiculously all phy ids)?

Unfortunately, MDIO over I2C is not standardised. So we have no idea
what address the PHY will be using, so we need to look at them all. If
you have an SFF, not an SFP, it might be possible to do some
optimisation.

	Andrew

