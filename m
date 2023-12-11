Return-Path: <netdev+bounces-55898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930A280CBE2
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26191C21347
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDBC47A42;
	Mon, 11 Dec 2023 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1CQSVdej"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB23812E;
	Mon, 11 Dec 2023 05:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a5KlyULzT0peuZ0c1QWXDeAwyadS1a4REYYtErhjE+A=; b=1CQSVdejU3ZzLEn2q0Fn/CRiw6
	ofo935OiRRj+zg2q8PJUmbmZnLm7uOOeblonKXNxqHr5k0MFhQBvzz8igGt0VyYzA2MgtKyMPh2Mj
	w5tBE+e5kab9YD2PWkOtKPYKb8TCcABIttfQ/nrEv8dJ/k5yOH553EB21IQQVXSDOOfA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rCgkD-002cfT-2r; Mon, 11 Dec 2023 14:54:49 +0100
Date: Mon, 11 Dec 2023 14:54:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] net: microchip_t1s: additional phy support and
 collision detect handling
Message-ID: <e4e675be-bbef-4fff-8bc2-d07bc1981ae2@lunn.ch>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <d79803b5-60ec-425b-8c5c-3e96ff351e09@lunn.ch>
 <ZWS2GYBGGZg2MS0d@debian>
 <270f74c0-4a1d-4a82-a77c-0e8a8982e80f@lunn.ch>
 <ZXWqrPkaJD2i5g-d@builder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXWqrPkaJD2i5g-d@builder>

> ## with collision detection enabled
> 
> iperf3 normal
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  5.54 MBytes  4.65 Mbits/sec    0             sender
> [  5]   0.00-10.01  sec  5.40 MBytes  4.53 Mbits/sec                  receiver
> 
> iperf3 reverse
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec   929 KBytes   761 Kbits/sec  293             sender
> [  5]   0.00-10.00  sec   830 KBytes   680 Kbits/sec                  receiver
> 
> 
> ## with collision detection disabled
> 
> iperf3 normal
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  6.39 MBytes  5.36 Mbits/sec    0             sender
> [  5]   0.00-10.04  sec  6.19 MBytes  5.17 Mbits/sec                  receiver
> 
> iperf3 reverse
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.27  sec  1.10 MBytes   897 Kbits/sec  268             sender
> [  5]   0.00-10.00  sec  1.01 MBytes   843 Kbits/sec                  receiver
> 
> # Conclusions
> 
> The arm system running the lan865x macphy uses a not yet mainlined driver, see
> https://lore.kernel.org/all/20231023154649.45931-1-Parthiban.Veerasooran@microchip.com/
> 
> The lan865x driver crashed out every once in a while on reverse mode, there
> is definetly something biased in the driver for tx over rx.
>
> Then again it's not accepted yet.
> 
> Disabling collision detection seemes to have an positive effect.
> Slightly higher speeds and slightly fewer retransmissions.

I would want to first understand why there is such a big difference
with the direction. Is it TCP backing off because of the packet loss?
Or is there some other problem.

Maybe try with UDP streams, say with a bandwidth of 5Mbps. Do you
loose 4Mbps in one direction? Or a much smaller number of packets.

Are there any usable statistics? FCS errors?

    Andrew

