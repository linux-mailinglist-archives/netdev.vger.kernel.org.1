Return-Path: <netdev+bounces-183277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343ABA8B903
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776FF18916EC
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936E424889F;
	Wed, 16 Apr 2025 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="glWcQhDU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878812472B0;
	Wed, 16 Apr 2025 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806471; cv=none; b=qZBlT0oNGyGPiXNljfDMLal2mQwfhFQbs2kumjGFQ0pK8LWsTrUpgR660xe8Jkrll57wdVADIAyEUZl65oZVaRuc5m+syPbyRhdrF8N+EBRYGqFhfbE/XU659cacB37cx8eB2dcoAzr86zJ+OU0LrNagAInV0/A51vDUVcL9Dr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806471; c=relaxed/simple;
	bh=2Z9dMh3cUftNywdxpqLdiZhzIykbnecaYABQWReuukc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpSSYJ+jFqLB6EE1QdOzOgboez8k5eggUDsFGGGKt9hECi6trLjespJ7nJUkJ5LdiwI1QGIcdqo2Zx7PLBoMrZ0RIaptV91VxLPd+IEGvimzjkELAMvhZgTCrvXo2FMKtOYsC/ezoDNqa/1CXqJnUw3kOn/cae3ddJvn9IC82EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=glWcQhDU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=M6LZ4xvneSkqTz22l3dMKDkqWPVz423Fwa7KsioWGuA=; b=glWcQhDU7brC7S3hO/V50YBI06
	VnjiupGMv6jbZ+aQIKjz2lzfyyldKifS+Dohd+2omPCSVsilyPi0iHjFgp/qCIXeqg4Z57ONQ1u0v
	bcRxmL2mht1t1baiQinA8cC1MwRbseAE5DxgbA6Tp14Aelkj4ugbrgOkPYsAWhON1S28=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u51rc-009cKD-AE; Wed, 16 Apr 2025 14:27:36 +0200
Date: Wed, 16 Apr 2025 14:27:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-list@raspberrypi.com
Subject: Re: [PATCH net v2] net: phy: microchip: force IRQ polling mode for
 lan88xx
Message-ID: <89826aa3-adc6-4278-a85a-b72ba8132add@lunn.ch>
References: <20250416102413.30654-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416102413.30654-1-fiona.klute@gmx.de>

On Wed, Apr 16, 2025 at 12:24:13PM +0200, Fiona Klute wrote:
> With lan88xx based devices the lan78xx driver can get stuck in an
> interrupt loop while bringing the device up, flooding the kernel log
> with messages like the following:
> 
> lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
> 
> Removing interrupt support from the lan88xx PHY driver forces the
> driver to use polling instead, which avoids the problem.
> 
> The issue has been observed with Raspberry Pi devices at least since
> 4.14 (see [1], bug report for their downstream kernel), as well as
> with Nvidia devices [2] in 2020, where disabling polling was the
> vendor-suggested workaround (together with the claim that phylib
> changes in 4.9 made the interrupt handling in lan78xx incompatible).
> 
> Iperf reports well over 900Mbits/sec per direction with client in
> --dualtest mode, so there does not seem to be a significant impact on
> throughput (lan88xx device connected via switch to the peer).
> 
> [1] https://github.com/raspberrypi/linux/issues/2447
> [2] https://forums.developer.nvidia.com/t/jetson-xavier-and-lan7800-problem/142134/11
> 
> Link: https://lore.kernel.org/0901d90d-3f20-4a10-b680-9c978e04ddda@lunn.ch
> Fixes: 792aec47d59d ("add microchip LAN88xx phy driver")
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> Cc: kernel-list@raspberrypi.com
> Cc: stable@vger.kernel.org

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

