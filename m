Return-Path: <netdev+bounces-185569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647DEA9AEAB
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB39417E6CB
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFD127BF61;
	Thu, 24 Apr 2025 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nPCDSV/n"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0527A93E;
	Thu, 24 Apr 2025 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500454; cv=none; b=Oh0RLCuWpWZTi27iqjrdft31gzWr88WULZZM5zQ99jvX13vmEvU/ZPd1Ck0aYvNt0nrvgJLoR5CV9ZSltXvC4yCNS+kwBwdu0eZbJJnn3u9/1dgv3WxsTBb2ojzZsAigBp0b/69IAYDDpnk3qW2ipVuZS04MJvTybshQCuuAiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500454; c=relaxed/simple;
	bh=cGlygv+YERnD49JPhi43+3PtfQcqix31cI6JJ2LWA6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+fvZOkxUJfdlQfG7jIE4RdwDrEWJOPoxwvWQyBHkQ52hMcfP8jFFGX4UcfJLTpTQmUgOcUhh6I0rhJs55e62MFlJ8Ab1Oofc7rtfadzvEgCJ4P0YAbgS7knCDE2zYBW0mAog1WPAzZZ8+WZOQdSrkEVk13I9GvggdahUHtk8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nPCDSV/n; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=62FmLrGiUz0HmPxa87/yvkkDLwJdZM5dEYe4emvLTJc=; b=nPCDSV/nGHiKDsE8YzGqa+nfuh
	7zI4/TI5DWrjakPQ6fvv+fdQARzrTsoS4zwjtxWoIW4ullKK5BhoNLWkhBKNsJqcAWvyBf7FNObw9
	FMpOKbnqENeA5UAy3+2S9ZO7HB9xePJX9lSSG076IDhzDZ8nBZM4eAfEUZSR1pSjRYH9apawz69vT
	7l9EDBJx8ByhS8ZZGZgtD9D79A8ZlPZxgcS0AmwcTEuuQ0PnCmeh17UCx9TcYftU8pGnvJXEXMYwc
	6OwyYL6Kqfhbnphx4FOsqKU+311gDF+5yx2lHxSIOOQowE3+pIBy7deULz9E1Dz2QuxPmLeASs2Th
	KGZlkYgg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47578)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7wOz-0007Q6-35;
	Thu, 24 Apr 2025 14:14:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7wOy-00017o-2M;
	Thu, 24 Apr 2025 14:14:04 +0100
Date: Thu, 24 Apr 2025 14:14:04 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v1 3/4] net: phy: Don't report advertised EEE
 modes if EEE is disabled
Message-ID: <aAo5HDLbpRhNIrn6@shell.armlinux.org.uk>
References: <20250424130222.3959457-1-o.rempel@pengutronix.de>
 <20250424130222.3959457-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424130222.3959457-4-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 24, 2025 at 03:02:21PM +0200, Oleksij Rempel wrote:
> Currently, `ethtool --show-eee` reports "Advertised EEE link modes" even when
> EEE is disabled, which can be misleading. For example:
> 
>   EEE settings for lan1:
>           EEE status: disabled
>           Tx LPI: disabled
>           Supported EEE link modes:  100baseT/Full
>                                      1000baseT/Full
>           Advertised EEE link modes:  100baseT/Full
>                                       1000baseT/Full
>           Link partner advertised EEE link modes:  Not reported
> 
> This may lead to confusion for users who aren't familiar with kernel internals
> but understand that EEE functionality depends on proper advertisement during
> link negotiation. Seeing advertised EEE modes in this case might incorrectly
> suggest that EEE is still being advertised.
> 
> After this change, if EEE is disabled, the output becomes:
> 
>   EEE settings for lan1:
>           EEE status: disabled
>           Tx LPI: disabled
>           Supported EEE link modes:  100baseT/Full
>                                      1000baseT/Full
>           Advertised EEE link modes:  Not reported
>           Link partner advertised EEE link modes:  Not reported
> 
> This better reflects the actual EEE configuration. The fix ensures
> advertised EEE modes are only reported when eee_cfg.eee_enabled is true.

No, this is a backwards step.

Tools like ethtool read-modify-write the settings. First they get, then
modify, then set.

This will have the effect that:

ethtool --set-eee eee off
ethtool --set-eee eee on

will clear the advertised link modes, which is not what one would
expect.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

