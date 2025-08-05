Return-Path: <netdev+bounces-211787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE3B1BB99
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED057A2C4B
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02672288CB;
	Tue,  5 Aug 2025 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cuTvHbcc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D502812E7F;
	Tue,  5 Aug 2025 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754427870; cv=none; b=j63Zq3fI4kqsfLu7eZFqTRBKVfzgHlXDjvaowXMRECEL+c5Ou9BaS6DIBY16pXJ/J26kMon/UNHu4hvgQLm1F37PB3wm1GhyEFuKHsBfW243/ibtUoO+wtSN0KGChPUrdgr+zZq98ct80allb4/oAMEr6/Uo4FIxih7BnDGQTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754427870; c=relaxed/simple;
	bh=cgwuGOhpWfu0apN7esBs5cph/S74lHc+3lfT2BxkLok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHnPr6OGzrgJ+EvfEQv4Ov2Hm4xbTczwjMiRiK5LHlr/7/yxdq8lVylISgFMbOb4TSO7XolcKnL2Mri35U4AQjtPh8BnIP0qx99fi/n74jW44spy0CVk0pUBu9smKhFTTpaH+hTWzUgl8vRfolF/TGgw27pYqCsru96AkF7Eris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cuTvHbcc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H8qKwlV/hGv5lXljo6J7UpddwhWoZfFMWWWFX7P5heg=; b=cuTvHbccrdF6uQOVkpI9+6yMTm
	c2jJLLpXWFVZ4/z3K6/6omlILczdzxF/Gh1fFX9GmKtoxu2P57NfoX7PutyO8kwQuJ0DMwlh9WD73
	ErW8ZeQUOlW9PgY6X8YS+4YG+8p2XkbqBAdbF3JFEXbAD1TGOQhRog5WPyQa9H8smwOs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujOpa-003pIO-6B; Tue, 05 Aug 2025 23:04:22 +0200
Date: Tue, 5 Aug 2025 23:04:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net-next v4 2/7] net: axienet: Use ioread32/iowrite32
 directly
Message-ID: <972847fe-53a2-49a6-9e87-31c5ac845289@lunn.ch>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
 <20250805153456.1313661-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805153456.1313661-3-sean.anderson@linux.dev>

> -	return readx_poll_timeout(axinet_ior_read_mcr, lp,
> +	return readx_poll_timeout(ioread32, lp->regs + XAE_MDIO_MCR_OFFSET,
>  				  val, val & XAE_MDIO_MCR_READY_MASK,
>  				  1, 20000);

I think this change makes axinet_ior_read_mcr() redundant? So it would
be good to remove it.

   Andrew

