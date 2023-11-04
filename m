Return-Path: <netdev+bounces-46041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8310E7E0FFA
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 15:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24D11C208E1
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47BC13FEB;
	Sat,  4 Nov 2023 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PF8ho379"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850252F58
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 14:57:11 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD371BC;
	Sat,  4 Nov 2023 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ex9cofny33QV6p/OTbMgVfmXHo630/2h/gGAekdBznw=; b=PF8ho379sX1yb4AoefxLHRgiv8
	9nAWf4huNuAoVrBmmhwl6I01NiL2OSnND2u7PEKmzIZODKciOSrbWJ81s5ZCC9ssZ5ONayEcU+Zl3
	GMFT4QUvI3jkZXQWhSDJOupianQdWzYG4lkOz9FPQrdpkcIlEpfXsuScP7dHy/nDWk7I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qzI55-000sS0-KO; Sat, 04 Nov 2023 15:56:59 +0100
Date: Sat, 4 Nov 2023 15:56:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 4/4] net: ethernet: cortina: Handle large frames
Message-ID: <036b481e-ac5b-4e77-b93a-4badaf19e185@lunn.ch>
References: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
 <20231104-gemini-largeframe-fix-v1-4-9c5513f22f33@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104-gemini-largeframe-fix-v1-4-9c5513f22f33@linaro.org>

> @@ -1170,7 +1171,14 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
>  		word3 |= mtu;
>  	}
>  
> -	if (skb->ip_summed != CHECKSUM_NONE) {
> +	if (skb->len >= ETH_FRAME_LEN) {
> +		/* Hardware offloaded checksumming isn't working on frames
> +		 * bigger than 1514 bytes. Perhaps the buffer is only 1518
> +		 * bytes fitting mach a normal frame and a checksum?

mach ?

> +		 * Just bypass on bigger frames.
> +		 */
> +		word1 |= TSS_BYPASS_BIT;
> +	} else if (skb->ip_summed != CHECKSUM_NONE) {

I've never looked at how the network stack does checksums. But looking
at this patch, it made me wounder, how do you tell the stack it needs
to do a software checksum because the hardware cannot? Or for this
driver, is it always calculating a checksum, which is then ignored?
Maybe you can improve performance a little but disabling software
checksum when it is not needed?

	 Andrew

