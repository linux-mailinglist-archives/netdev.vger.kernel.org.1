Return-Path: <netdev+bounces-205442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 831B2AFEB71
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B435C15A4
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B395290092;
	Wed,  9 Jul 2025 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s5dPV0vC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8A2E8896;
	Wed,  9 Jul 2025 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069815; cv=none; b=KD3w55F/PZa9qw37Un0Ot0Odq0ZGt3iA7t8fnsLeXUMbmf3MCCTpsl/nLahuuW3PV2DiGD4IZHuDcY04ztTlNTN3ZkS648Y5C7p0oLgIRT6oZrqd8R+MbthiSbNQPWUnUWf2PNJ9M1R7PuoLPlUpD6UBjicXPI6ZgHkJk6wVSnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069815; c=relaxed/simple;
	bh=xDIQZTmb2XeV6ShfW/l3uwIpfb/tWjU1GnripoW4LzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVBkJEhHkbro1m0V5IURsqRx3uLipi8mrBNlMtUOdNTIgIvn2talVFwdmPSq14ESlqxQD7bdS883VpcinD8YOD9vccqdsbLHcUdU6wYU5Ku7HLD8ayvZex5bJlOXjWsvtoP9H1P81dmipN3a+N8FtOktFyNh/m9RA+0mTyqmvaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s5dPV0vC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9Aw3J6cFGMs3YmA/HP2Vdm7P6MLIxMuJEQ+kELQ2gFI=; b=s5dPV0vCOsOqvDaWV2YJ8O8O3e
	g5ubEgVUv+2v0ZFupAvJZzfJvdUJ6tq1AzTp13iwyb4ZnSVULP+Xe36YVDj9S2VuzpVv1JAWbfUwc
	x01COoWCK16iIJGwfHgJgLoJx7CiQ0OORtrJnwobcjmCQeDf1IP1iIIJEgLww+AqMq9Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZVOD-000wu3-QG; Wed, 09 Jul 2025 16:03:13 +0200
Date: Wed, 9 Jul 2025 16:03:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH net v2 1/3] net: phy: enable polling when driver
 implements get_next_update_time
Message-ID: <248bbbcf-ec7a-4ae4-a502-8f2575c18bbb@lunn.ch>
References: <20250709104210.3807203-1-o.rempel@pengutronix.de>
 <20250709104210.3807203-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709104210.3807203-2-o.rempel@pengutronix.de>

On Wed, Jul 09, 2025 at 12:42:08PM +0200, Oleksij Rempel wrote:
> Currently, phy_polling_mode() enables polling only if:
> - the PHY is in interrupt-less mode, or
> - the driver provides an update_stats() callback.
> 
> This excludes drivers that implement get_next_update_time()
> to support adaptive polling but do not provide update_stats().
> As a result, the state machine timer will not run, and the
> get_next_update_time() callback is never used.
> 
> This patch extends the polling condition to include drivers that
> implement get_next_update_time(). This change is required to support
> adaptive polling in the SMSC LAN9512/LAN8700 PHY family, which cannot
> reliably use interrupts.
> 
> No in-tree drivers rely on this mechanism yet, so existing behavior is
> unchanged. If any out-of-tree driver incorrectly implements
> get_next_update_time(), enabling polling is still the correct behavior.
> 
> Fixes: 8bf47e4d7b87 ("net: phy: Add support for driver-specific next update time")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

