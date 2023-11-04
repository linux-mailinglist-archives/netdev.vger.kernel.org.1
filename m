Return-Path: <netdev+bounces-46040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8D77E0FF3
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 15:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E667B1C20949
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 14:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920DE15AE1;
	Sat,  4 Nov 2023 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K2szq9Va"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129B17D5
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 14:46:20 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E531BF;
	Sat,  4 Nov 2023 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Vglbr5OscBwmzXeDr7ryPvhrzWRRWsVXpMVy/3stZxs=; b=K2szq9Vaf0baMpHPaet72S7gAX
	NY7TsMRGmHSDRdpMRbHdpzKIEMm4nvW4upJD6DHOvaCpqxKDD25G6CkzSIfaSE6E/MjpM8+6jv91S
	WSW9qQpbvErgsQ9dBQ5vCNXnnRsLVQm0nsXJsXVtc/COKRYLrabAJ03zKJ4bqwE8pZ6g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qzHub-000sOR-PD; Sat, 04 Nov 2023 15:46:09 +0100
Date: Sat, 4 Nov 2023 15:46:09 +0100
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
Subject: Re: [PATCH net 3/4] net: ethernet: cortina: Protect against
 oversized frames
Message-ID: <39debb25-bf30-4ede-99b1-d9f6091a039c@lunn.ch>
References: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
 <20231104-gemini-largeframe-fix-v1-3-9c5513f22f33@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104-gemini-largeframe-fix-v1-3-9c5513f22f33@linaro.org>

On Sat, Nov 04, 2023 at 01:43:50PM +0100, Linus Walleij wrote:
> The max size of a transfer no matter the MTU is 64KB-1 so immediately
> bail out if the skb exceeds that.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index fd08f098850b..23723c9c0f93 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1156,6 +1156,12 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
>  		mtu = MTU_SIZE_BIT_MASK;
>  	}
>  
> +	if (skb->len > 65535) {
> +		/* The field for length is only 16 bits */
> +		netdev_err(netdev, "%s: frame too big, max size 65535 bytes\n", __func__);
> +		return -EINVAL;
> +	}
> +

The caller of gmac_map_tx_bufs() is a but funky:

	if (gmac_map_tx_bufs(netdev, skb, txq, &w)) {
		if (skb_linearize(skb))
			goto out_drop;

		u64_stats_update_begin(&port->tx_stats_syncp);
		port->tx_frags_linearized++;
		u64_stats_update_end(&port->tx_stats_syncp);

		if (gmac_map_tx_bufs(netdev, skb, txq, &w))
			goto out_drop_free;
	}

So return -EINVAL is going to cause the skb to be linearised, and then
re-tried. Maybe you want to check the error code here, and go straight
to out_drop?

   Andrew

