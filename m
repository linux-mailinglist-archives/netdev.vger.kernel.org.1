Return-Path: <netdev+bounces-166838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2819A377F6
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 23:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63E316723E
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D85155C8C;
	Sun, 16 Feb 2025 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GKRCC0LC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B77C189B91
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739743746; cv=none; b=ZEHmtnmm6b5mLfLySaPUKpBMYhvvT4ITUTG39hhTTVWIkDkwrf4JOIEE3hyVXBHaZ+77oONDB76RNcBcGfyLu6i9koyBC81bfjuABO7ASouOnmY3qT4kiuy4d0SFmZa3TjTfdQ6A705QWPz4SZE/Zaz28ssv4UA6btHpnH5vAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739743746; c=relaxed/simple;
	bh=35Q854j8B9uCgvTjFxsKVYt5VjoUO4apOnK0kdH5oN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Chy9IQKfqWsOrbmWTygz0W504k6P4uJjOKM42tQS2z7FcZYZLrRuXUVKvo2urXRy9lR1bfaR5HOc4kKJV8V7NiXysi0iBIBU/n6jKEWntVOQ87eqYu52XLz1B/DBOsgCONT0FM0dlME5EaOLIWMjIE3NB+poXECpkH8CBSIHY94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GKRCC0LC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8CLTZFb22EkN9/FPaL4WCljGvkwJUb0DuyHS9vgvKck=; b=GKRCC0LCinvz6niePr3OQhKJc2
	Q8uGeVIn8VwedQfN1EHnLdjBVmrIarp6jqb2tTjDZGi9n+jWA8QKFMn30/MBDSbLj5G0S09zY62Ah
	EtyGC7PKB5tc7bmJoK7Nk1k/HNznDgx53lu6lF4wei9w6K88j2D/YguQPX4UA4Mpu2qo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjmoq-00Eljf-Lh; Sun, 16 Feb 2025 23:08:56 +0100
Date: Sun, 16 Feb 2025 23:08:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 5/6] net: phy: c45: use cached EEE advertisement
 in genphy_c45_ethtool_get_eee
Message-ID: <dfc2f4af-35d5-44a4-9b65-353415d0dc54@lunn.ch>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
 <e57ed3d4-d0bc-4f91-83f6-8f48dfb6d7d7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e57ed3d4-d0bc-4f91-83f6-8f48dfb6d7d7@gmail.com>

On Sun, Feb 16, 2025 at 10:19:23PM +0100, Heiner Kallweit wrote:
> Now that disabled EEE modes are considered when populating
> advertising_eee, we can use this bitmap here instead of reading
> the PHY register.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

