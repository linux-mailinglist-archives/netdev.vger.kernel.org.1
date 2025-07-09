Return-Path: <netdev+bounces-205444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B148AFEB8F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC0A565DE9
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DD02E7183;
	Wed,  9 Jul 2025 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qWX5KHiX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E0E290092;
	Wed,  9 Jul 2025 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070259; cv=none; b=lKAC73NLIQv36pXijpT88JafQmG4Jr6wwr5sZixm7Aj2pwL13WMaoAwH5xiGYugT3oHV5DADI65yXwICztxab2H14uu+wjE15NQf5C8bdMONvS9pqTet4+CUlc0e7oBwzk/usXzxWyBX8k5Fs/v/D4NVjW/3JymOQ2szh4PderU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070259; c=relaxed/simple;
	bh=+EexfIvgNZ+SVSR5duijOb51awN3SmpaycjndmOrpLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ixb51LBizR9jKxn3bmapMwM4X458NalRLEiVu74PiEh4YMsUdIH2rqKgVqheU++jasg3PvJQNoGtZafNuF8UxOOq0b8LEOA4xQCo6PFBGMaK8pZdiVT5zxhZ6i3QQ9GwIGQt1YhcnhHup1qapajQkZlsTLb0cRAMyf8qBQylEFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qWX5KHiX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DQqwHHKBZrRtmb4tOj3kH60Q18wJibg93eVRqot5J8w=; b=qWX5KHiXuay3OsOuQ27rw7rUJo
	hRGFMn6hYvbJrXuoah8GPpYwFdO7TRaJGTOH60vBLXnCmAfoWjXDXRs4DiFepQd/MwFIEHD7KKrAX
	XHFULLBunpBIpAXcQe9/90hzKftKFA5vS8V6z6wglVdSoCArBvNM/w67zU1T93Dx/h/I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZVVY-000wvo-EL; Wed, 09 Jul 2025 16:10:48 +0200
Date: Wed, 9 Jul 2025 16:10:48 +0200
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
Subject: Re: [PATCH net v2 2/3] net: phy: allow drivers to disable polling
 via get_next_update_time()
Message-ID: <e0b00f28-051e-4af6-afcb-7cdb5dc76549@lunn.ch>
References: <20250709104210.3807203-1-o.rempel@pengutronix.de>
 <20250709104210.3807203-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709104210.3807203-3-o.rempel@pengutronix.de>

>  	/* Only re-schedule a PHY state machine change if we are polling the
> -	 * PHY, if PHY_MAC_INTERRUPT is set, then we will be moving
> -	 * between states from phy_mac_interrupt().
> +	 * PHY. If PHY_MAC_INTERRUPT is set or get_next_update_time() returns
> +	 * PHY_STATE_IRQ, then we rely on interrupts for state changes.
>  	 *
>  	 * In state PHY_HALTED the PHY gets suspended, so rescheduling the
>  	 * state machine would be pointless and possibly error prone when
>  	 * called from phy_disconnect() synchronously.
>  	 */
> -	if (phy_polling_mode(phydev) && phy_is_started(phydev))
> -		phy_queue_state_machine(phydev,
> -					phy_get_next_update_time(phydev));
> +	if (phy_polling_mode(phydev) && phy_is_started(phydev)) {
> +		unsigned int next_time = phy_get_next_update_time(phydev);
> +
> +		/* Drivers returning PHY_STATE_IRQ opt out of polling.
> +		 * Use IRQ-only mode by not re-queuing the state machine.
> +		 */
> +		if (next_time != PHY_STATE_IRQ)
> +			phy_queue_state_machine(phydev, next_time);
> +	}

How does this interact with update_stats()?

phy_polling_mode() returns true because the update_stats() op is
implemented. phy_get_next_update_time() returns PHY_STATE_IRQ, because
the PHY is in a state where interrupts works, and then the statistics
overflow.

It seems like this code needs to be somehow made part of
phy_polling_mode(), so that it has the full picture of why polling is
being used.

    Andrew

---
pw-bot: cr

