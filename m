Return-Path: <netdev+bounces-189237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699EFAB136C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE933AFD72
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B33F290DAE;
	Fri,  9 May 2025 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SYQKkljQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771E128ECEF;
	Fri,  9 May 2025 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746793878; cv=none; b=XD3kp9aPjaP4ErJhR2b9rhz3Fjc5sW0NRCe3xoJlkFBg0a8kB45WgfZxk8RX5mNsPJmqpQ515PfqnMaTMjYgrGKvvC4+E0hL7xPnre3dscvZ7/4t9qhcfQXxsRlX6FSzEWD8+rwXFAqgcTqZTZGaA6pLaZMWJ1RePPEua2sWHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746793878; c=relaxed/simple;
	bh=JoF6YrLrptR6OSMKdIf3o4Fo9pPrScNdNl9AV6MjYP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNHy3v/xA2/VyALGWUFABIu++eoRlmxIasvndstRxtI/Gmyjkfi34tWaE9ejW67S+PNHgotT15kH7uYM+vdDPjhoT20pI6Yt/FmO6VcjSEQ8Y5fAxM8ztkExwmThnkM9Q5McOneUfThz9PqpU2YZkPdtxaPM9p88XkHaCsivedc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SYQKkljQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YdoNmHUxjZnTmMzliQNATPMV+jIfhdQyI5B/8F0nKfY=; b=SYQKkljQwKbuZytfsG/eMkKU8q
	2an+LhOYR9Kpx+je1D2+ZpbQAXS+WtaUFOLHk2rSQwukr1hmhir16Ud3YzZRRx9pFlWqOsL0UiZcw
	7jjGfZfnhuikVy15gbwVtz4QvQ4Pjpe6lAyCXkLIyCRJEz6YNMhA2KfHZ+2T1HGq59IE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uDMsW-00C6oZ-T9; Fri, 09 May 2025 14:31:00 +0200
Date: Fri, 9 May 2025 14:31:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, quentin.schulz@cherry.de,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	George McCollister <george.mccollister@gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: linearize skb for tail-tagging
 switches
Message-ID: <e76f230c-a513-4185-ae3f-72c033aeeb1e@lunn.ch>
References: <20250509071820.4100022-1-jakob.unterwurzacher@cherry.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509071820.4100022-1-jakob.unterwurzacher@cherry.de>

On Fri, May 09, 2025 at 09:18:19AM +0200, Jakob Unterwurzacher wrote:
> The pointer arithmentic for accessing the tail tag does not
> seem to handle nonlinear skbs.
> 
> For nonlinear skbs, it reads uninitialized memory inside the
> skb headroom, essentially randomizing the tag, breaking user
> traffic.

Both tag_rtl8_4.c & tag_trailer.c also linearize, so i would say this
is correct.

What is interesting is that both xrs700x_rcv() and
sja1110_rcv_inband_control_extension() also don't call
skb_linearize().

Vladimir? George?

> Tested on v6.12.19 and today's master (d76bb1ebb5587f66b).

Please read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

This patch should be for net, and you need a Fixes: tag.

    Andrew

---
pw-bot: cr

