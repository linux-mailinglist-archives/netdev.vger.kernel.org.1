Return-Path: <netdev+bounces-206337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0394B02AF0
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 15:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4754A524C
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5E9222574;
	Sat, 12 Jul 2025 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY3UQa3S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D431D52B;
	Sat, 12 Jul 2025 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752326333; cv=none; b=Wxg5rIPOz1/xhJDYzpYj6Zhg1+WempPze45E6kFR4g46QdWcz+5xx1pkxH5GaQg3Byv4xxmACWZUXseiQUiARTzbUCZaLcmq/+aj0wqjemG/ygfhg8r+FxDQzLGUjjlsTHUpdh4+Pa96ZLwmPjVbI+5zwEweBSI2F1AKUFBkCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752326333; c=relaxed/simple;
	bh=mKTHm1hQRN4ZvXxHa3xaWZ+l39orS72rx0zHnePaZ/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkgwLyedlQomWdLdzJbS0gTS10c0Jc/i10N+WENjtdjOSgMaos3TEMRxm3ohEwv8sNMsIK9LjVdYmDFnsTakkXvY7TMtaUgRWNuyYUKYbfxVl9MrvR+JbDQXgM61LBw9oJ9l6MAa1qLbSXqcjK0Hl5oVlrUBfdYIWA0H3L6bWys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY3UQa3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1552DC4CEEF;
	Sat, 12 Jul 2025 13:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752326332;
	bh=mKTHm1hQRN4ZvXxHa3xaWZ+l39orS72rx0zHnePaZ/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DY3UQa3Sr2IDRJNj9FWRGhtrxbNV05QQrFGoSgw/ECpGDscPTqL2mtUrmpEbN0pHN
	 n2CKgL+jAZrpgC7XASOPWFIRHsINBWew7OmoMTX5TdVUzF8Kz+HyC0BtArtvutOcW1
	 DZ/iWJatebxUZHARd00CP7NGLvPAk1Q24nW4xvnANdyMfIJdJ6DPnmx0tpNsnZXV2p
	 ePeejOU9JK6BUNdE9W2N8f6Xy8Ie+kaAARs9sg4tCPl4oHSC6Zm7lOe4Qbz5ZYwetj
	 aUDOGxgbWYBKibc3KXDN0n8FUllR/HNibAoy7TTEE43u0jhRzCfAhd4mCVpMDyTY4n
	 6zuvpuJf2JhEA==
Date: Sat, 12 Jul 2025 14:18:48 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH net v3 2/3] net: phy: allow drivers to disable polling
 via get_next_update_time()
Message-ID: <20250712131848.GA721198@horms.kernel.org>
References: <20250711094909.1086417-1-o.rempel@pengutronix.de>
 <20250711094909.1086417-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711094909.1086417-3-o.rempel@pengutronix.de>

On Fri, Jul 11, 2025 at 11:49:08AM +0200, Oleksij Rempel wrote:

...

> @@ -1575,16 +1573,31 @@ static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
>  	phy_process_state_change(phydev, old_state);
>  
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
> +		if (next_time == PHY_STATE_IRQ) {
> +			/* A driver requesting IRQ mode while also needing
> +			 * polling for stats has a conflicting configuration.
> +			 * Warn about this buggy driver and fall back to
> +			 * polling to ensure stats are updated.
> +			 */
> +			if (phydev->drv->update_stats) {
> +				WARN_ONCE("phy: %s: driver requested IRQ mode but needs polling for stats\n",
> +					  phydev_name(phydev));

The first argument to WARN_ONCE() should be a condition, not a format string.

Flagged by GCC and Clang builds with KCFLAGS=-Wformat-security

> +				phy_queue_state_machine(phydev, PHY_STATE_TIME);
> +			}
> +		} else {
> +			phy_queue_state_machine(phydev, next_time);
> +		}
> +	}
>  
>  	return state_work;
>  }

...

-- 
pw-bot: changes-requested

