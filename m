Return-Path: <netdev+bounces-148753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922679E30FF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571AC283F89
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 01:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E1B17BCA;
	Wed,  4 Dec 2024 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Pky3cQsb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ADE175AB;
	Wed,  4 Dec 2024 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277544; cv=none; b=hUUMbLerMaIS3GEiIFZK/AMAhepghLWFGcvXvfUEORdpvfFCK8+LID2T/RLZAVaiULEMlEZeRMDLe9JvJiyKRe28StHYm857TmuYLxslqBqa2+UTWD+6YSiQJMoBGaxoA5f6B0NEzfh5VYZ0Ni6HW1v5IF6fvKtKBQzTQ3u2cgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277544; c=relaxed/simple;
	bh=a4OZ1LAsIhpvqDIbwxI6lO+bUIIMhMLh2jh+/n5Pwik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQqgJkyot1E6FuRxhBMXA/G644nstPaZfCS7XBmSlY+RaFlienRW8MJ/cqETID6VyR0HATxpAId9iSHjNhO2MgAj5rCyoFwka/x0nQ74S1CvoR2U+uGNQ3G0SuMwlZdw5CqupGKN+/NVQHqtG0VCsoGnHAEaz8dl6N5oUQBjI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Pky3cQsb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4Gc5eRUdt6i47eRmmyZftOhvRJWmkHfc+4Lk40uszfU=; b=Pky3cQsb6N0D7N39MRKMYgnan4
	3qv32+LdLkRz/XAqE7Tp4Dn5PrGFpqxAa2Y998SJZi8w8KRRZmTWUhB2zn8YaSThwkDuYggvSowof
	CooDXXCavKYEBYa2KLUqx4Gj8ZNnq3VFPwrPL2uw1THrWl9EYMs+ICT5t1xyuU1Aehu4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIefG-00F9bS-8D; Wed, 04 Dec 2024 02:58:54 +0100
Date: Wed, 4 Dec 2024 02:58:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 04/10] net: freescale: ucc_geth: Fix WOL
 configuration
Message-ID: <179742dc-2df2-4d69-99ac-4951dc36aa71@lunn.ch>
References: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
 <20241203124323.155866-5-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203124323.155866-5-maxime.chevallier@bootlin.com>

On Tue, Dec 03, 2024 at 01:43:15PM +0100, Maxime Chevallier wrote:
> The get/set_wol ethtool ops rely on querying the PHY for its WoL
> capabilities, checking for the presence of a PHY and a PHY interrupts
> isn't enough. Address that by cleaning up the WoL configuration
> sequence.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

This at least looks sensible.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

I don't think we are going to get a perfect implementation until we
move most of the logic into phylink. We need the MAC to declare a
bitmap of what WoL options it supports. And we need the PHY to declare
the same. And the core can then figure out which of the enabled WoL
options the PHY should do, which the MAC should do, if the MAC can be
powered off, etc.

But i doubt that will get implemented any time soon.

	Andrew

