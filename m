Return-Path: <netdev+bounces-132230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0ED9910B0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B271C22C85
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EC9231CB3;
	Fri,  4 Oct 2024 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2TDrwIBa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18261231CA4;
	Fri,  4 Oct 2024 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074142; cv=none; b=Rh78xMnSxEOGodvwgIFfujpGO1ZdmCYggxiGIdlC8d/nkCyi3Uq/2HkyH0MCmHz1tTbS1S6NE6F1A0YRhmwIIqESZWWv+pRAYd6RjjsEwCXrZurb3OtZcOTtnmQup3leM6G9o1Ok51mNsnqL6OkgNZKPiOn4IpzbUHhwrsAPLxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074142; c=relaxed/simple;
	bh=zGyBiRvoI71SsyL4uRGBiOT0mitVvV1IyrXM1hDl5YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPPmabiuPhVRalhkGAE1YGspG/Io1WWDD/bbdMQTlUkpR1GfEPzBmSl1025wL5NhOd28S1zQd8G7S0bPpnLoCyAQgupKttfUtnmGyYRrTXFRiB4kZ2YSEOrG+4f5Tm+O0gjcXhrFf2Xp9F6C6NpIAgSZXcMyRcaXeX2CJ9pE89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2TDrwIBa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v8Uq0AZE02RUmMAFTffegI1kLGdXyVjcV3kRxhMmnGg=; b=2TDrwIBa2YLQZYrPOTJA/oi8lN
	f6qx2+vkOOG+NZ+yt1LHb6IbMpzYmxZjyN7MCiz1HVrgHPvzXLoURZhDYckfIuSFUSeoxjIp/2EIf
	euSMfs1we5b7rO6/t9pVNYmJX+0TuAZaRikuD8EVP7RYWltHkqFU8NRQFGRzj/Iv6gDE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swp1K-0095gj-7V; Fri, 04 Oct 2024 22:35:26 +0200
Date: Fri, 4 Oct 2024 22:35:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: dsa: mv88e6xxx: Support LED control
Message-ID: <54922259-818f-425f-af47-cfa594a288e3@lunn.ch>
References: <20241001-mv88e6xxx-leds-v4-1-cc11c4f49b18@linaro.org>
 <20241004095403.1ce4e3b3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004095403.1ce4e3b3@kernel.org>

On Fri, Oct 04, 2024 at 09:54:03AM -0700, Jakub Kicinski wrote:
> On Tue, 01 Oct 2024 11:27:21 +0200 Linus Walleij wrote:
> > This adds control over the hardware LEDs in the Marvell
> > MV88E6xxx DSA switch and enables it for MV88E6352.
> 
> Hi Andrew, looks good now?

Sorry, drowning in patches. I just purged pretty much everything from
Rosen Penev.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

