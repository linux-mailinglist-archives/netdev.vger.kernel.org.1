Return-Path: <netdev+bounces-211082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9926CB167F7
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 23:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1887A59AC
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59471E5B7C;
	Wed, 30 Jul 2025 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WofFqB/E"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D7A5383;
	Wed, 30 Jul 2025 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753909300; cv=none; b=LmppZjrhmfJk9pyvzmj5OvfFt4z+s0YZTZZTzrEDs0KCIBbLhL7m6nOrwqopWTfPkvOjQKgQTmcAmZPZP9JOnt/jwIy/UHD+eAZsiL3W/5IeU6CVYrGB3/U7YyFKkMgiblyai8a8bST4k7FCzSIc+OgUDASajrmxWwMoNfMls7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753909300; c=relaxed/simple;
	bh=WdmYyOz2vjppl/JGoxryP4exnKkO1/6p3lMfJNB8kzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHLXbY98S0SVpkE6WT2FmzKzzJouZc472CdSSQWDA+qVBl5IWlfQSALFvohTkY5A7t3RjULY752bEYsS2ySOBzJg6A0XUqQ4wC+oGGBe6dtEzAzZ1XuqdZoVsoPJ1fA34bsIB12LF+3NVwm+Snhm5mdjVWCgalQ9fWqdHaOC70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WofFqB/E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jQvZXAY5j6t+0AlMgBZ6O4fJCOUzsqOY4Dlw1aQ+FFI=; b=WofFqB/EQlzKfJlegDpUjlmGfD
	t7AUzR77OPZ2/iBzz5W/2n9gmyQp0JYfYHntDuPFum2Uk66E4lC0Uc6u4NPlS82BNAulC7LWaaR/W
	4bxRiqZ+Y/tPDUPJaVSkRZTjqp6K/zKC+6pwgJQY164oU8WuhA91jP+9yhJsFSkDjvg0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uhDvE-003JMG-RS; Wed, 30 Jul 2025 23:01:12 +0200
Date: Wed, 30 Jul 2025 23:01:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: mdio: mdio-bcm-unimac: Correct rate fallback
 logic
Message-ID: <dd34ec38-44fc-455f-8ba9-b2fbcc54aa38@lunn.ch>
References: <20250730202533.3463529-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730202533.3463529-1-florian.fainelli@broadcom.com>

On Wed, Jul 30, 2025 at 01:25:33PM -0700, Florian Fainelli wrote:
> When the parent clock is a gated clock which has multiple parents, the
> clock provider (clk-scmi typically) might return a rate of 0 since there
> is not one of those particular parent clocks that should be chosen for
> returning a rate. Prior to ee975351cf0c ("net: mdio: mdio-bcm-unimac:
> Manage clock around I/O accesses"), we would not always be passing a
> clock reference depending upon how mdio-bcm-unimac was instantiated. In
> that case, we would take the fallback path where the rate is hard coded
> to 250MHz.
> 
> Make sure that we still fallback to using a fixed rate for the divider
> calculation, otherwise we simply ignore the desired MDIO bus clock
> frequency which can prevent us from interfacing with Ethernet PHYs
> properly.
> 
> Fixes: ee975351cf0c ("net: mdio: mdio-bcm-unimac: Manage clock around I/O accesses")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

