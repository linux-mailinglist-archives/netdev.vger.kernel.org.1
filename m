Return-Path: <netdev+bounces-119801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C59A95702C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF07B1C23008
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A74175548;
	Mon, 19 Aug 2024 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eA/sQj3L"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EDE1741F8
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084749; cv=none; b=Cka6vH4ql91J2FaHpvCQZOsjwjsi/BACUTJggA+LY3kU/ybHdo5ssZ3IHO3Zm+EtSGWGlExC5hc5JYr41ZdhVt2UgrnUxU4WMp5Q62F6mIKojZTQagb4y/E3zmQslVmqCqreRZHyciLhmpupUSHCW6LFtljnA3XR1tZ0y4F2B/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084749; c=relaxed/simple;
	bh=6XxkigOfuCbJlQQVAQiT2aYyWek7LFQ5hykiafNBtmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ciofi5gxzrx1bOaWdSwi392GJNMcM1SfNqsKWyGj++OVhldd71Wf6L4dyrmeFz5qT+2T7W3tYyx0d95U5pAmNXxD/MlW1cT3r32zneLy4EUwDrmePv/J4JBssEjVjsq9OxGu8jIwZDrTti6dfoVXeKLLo4ievFkREBodcL6BmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eA/sQj3L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b6YXkPOTUa3JYX7NS6++iAqKi6WZLW33mJcAC68c/aQ=; b=eA/sQj3L4dx61TeWW+1Ieam7UM
	iiFyzVTVPpDBMBN7ion/8snl2iZoZb6HhydAdXd6FIk6w2X7Cm3P2vvzIz2oOhgLZNR36hpCipNvN
	nV3yt4VlrQFwTv3FAyeiTt9y6xtdOFH6nZyZMoQqxnuBfUOW9C32AJTlREswBdcX4c8A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sg5CN-0058KP-LY; Mon, 19 Aug 2024 18:25:39 +0200
Date: Mon, 19 Aug 2024 18:25:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shane Francis <bigbeeshane@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [BUG] net: stmmac: crash within stmmac_rx()
Message-ID: <1233c766-0260-497d-8700-87f0f76d2bcd@lunn.ch>
References: <CABnpCuCLN6VNgmoWHwc4_8AT34xqmQnEoUHLncvE2yLqYZBaKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABnpCuCLN6VNgmoWHwc4_8AT34xqmQnEoUHLncvE2yLqYZBaKg@mail.gmail.com>

On Mon, Aug 19, 2024 at 01:26:37PM +0100, Shane Francis wrote:
> Summary of the problem:
> ===================
> Crash observed within stmmac_rx when under high RX demand
> 
> Hardware : Rockchip RK3588 platform with an RTL8211F NIC
> 
> the issue seems identical to the one described here :
> https://lore.kernel.org/netdev/20210514214927.GC1969@qmqm.qmqm.pl/T/
> 
> Full description of the problem/report:
> =============================
> I have observed that when under high upload scenarios the stmmac
> driver will crash due to what I think is an overflow error, after some
> debugging I found that stmmac_rx_buf2_len() is returning an
> unexpectedly high value and assigning to buf2_len here
> https://github.com/torvalds/linux/blob/v6.6/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c#L5466
> 
> an example value set that i have observed to causes the crash :
>     buf1_len = 0
>     buf2_len = 4294966330
> 
> from within the stmmac_rx_buf2_len function
>     plen = 2106
>     len = 3072
> 
> the return value would be plen-len or -966 (4294966330 as a uint32
> that matches the buf2_len)
> 
> I am unsure on how to debug this further, would clamping
> stmmac_rx_buf2_len function to return the dma_buf_sz if the return
> value would have otherwise exceeded it ?

Clamping will just paper over the problem, not fix it. You need to
keep debugging to really understand what the issue is.

Clearly len > plen is a problem, so you could add a BUG_ON(len > plen)
which will give you a stack trace. But i doubt that is very
interesting. You probably want to get into stmmac_get_rx_frame_len()
and see how it calculates plan. stmmac obfustication makes it hard to
say which of:

dwmac4_descs.c:	.get_rx_frame_len = dwmac4_wrback_get_rx_frame_len,
dwxgmac2_descs.c:	.get_rx_frame_len = dwxgmac2_get_rx_frame_len,
enh_desc.c:	.get_rx_frame_len = enh_desc_get_rx_frame_len,
norm_desc.c:	.get_rx_frame_len = ndesc_get_rx_frame_len,

is being used. But they all look pretty similar.

What i find interesting is that both are greater than 1512, a typical
ethernet frame size. Are you using jumbo packets? Is the hardware
doing some sort of GRO?

      Andrew

