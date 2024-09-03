Return-Path: <netdev+bounces-124337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419819690D0
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 03:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6341F22C88
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 01:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E981A2C08;
	Tue,  3 Sep 2024 01:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpK3oMhi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B744198A05;
	Tue,  3 Sep 2024 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725325343; cv=none; b=Ee3qOCtG42AsB9efsnjS4/8ahzSdW3pLIUMbO44Fb6Yf4IGJJ8rpeSUbI5MKTfRoQR6EaFTaKn6NTsTUDEq4XkDM5kWk+PcwuDBlyVabLTimmQMTsc2MWBjDvebkux+9WL7InXCCz3lIONafRqSB4WVHM3gMd+Pas0j2BCwtD0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725325343; c=relaxed/simple;
	bh=tTvhyPtBceiZsBxdTifHd5e8Cxsmwvra7TbSzPLtJsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mM9Pe7Q0+natFk9lctYihqoPZmIxj7cpTNXyLQW23+DP03xZrgl3GGYtXW/3GaKwcO/ATeYr+YE7x2BAPeajXTcZ632ef38f+duf6vf5k4dtrOFhl5VdahYeth68FtRJKmLneMu02Sf16BwfBJcnbVAuJ7UesaTr1QhXo0RX6xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpK3oMhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BF8C4CEC2;
	Tue,  3 Sep 2024 01:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725325342;
	bh=tTvhyPtBceiZsBxdTifHd5e8Cxsmwvra7TbSzPLtJsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RpK3oMhitV5+9evjmNDFL6FR9aEeVctNmocuzCgNciJav/ZlkcuPauUGldHD3hina
	 MGN07F9CiuPK7oSr2qAEoLpeklw2j0XoTfELDzachiSHIBJ+LQe9HbiXXkn5ISa6BH
	 xZVetIfITuRhk+mnpFvW5N1FuxjGyxhOdZ1yyTsnZOSKpFFKHUvEXuoEYjYULNTh5K
	 CidCoJ9bL1DssSDUjsqmGzw9/eNmwM3R/7LalgCVvGoDO3Mn5gC3sMRzvPiFHNDdLd
	 Zj4ShOqAjIsfnhnRkCUMzbPqrS064chyBst14FOuyya9UM1SBmmgM4ZXlTtkicn9JC
	 bHpqKwjSbfPIg==
Date: Mon, 2 Sep 2024 18:02:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
 hch@infradead.org, willy@infradead.org, willemdebruijn.kernel@gmail.com,
 skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Jurgens <danielj@nvidia.com>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <20240902180220.312518bc@kernel.org>
In-Reply-To: <ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station>
References: <20240829131214.169977-1-jdamato@fastly.com>
	<20240829131214.169977-6-jdamato@fastly.com>
	<20240829153105.6b813c98@kernel.org>
	<ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
	<20240830142235.352dbad5@kernel.org>
	<ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 18:56:07 +0200 Joe Damato wrote:
> > How do you feel about making this configuration opt-in / require driver
> > changes? What I'm thinking is that having the new "netif_napi_add()"
> > variant (or perhaps extending netif_napi_set_irq()) to take an extra
> > "index" parameter would make the whole thing much simpler.  
> 
> What about extending netif_queue_set_napi instead? That function
> takes a napi and a queue index.

This may become problematic, since there may be more queues than NAPIs.
Either with multiple combined queues mapped to a single NAPI, or having
separate Rx/Tx NAPIs.

No strong preference on which function we modify (netif_napi_add vs the
IRQ setting helper) but I think we need to take the index as an
explicit param, rather than try to guess it based on another ID. 
The queue ID will match 95% of the time, today. But Intel was
interested in "remapping" queues. And we all think about a queue API...
So using queue ID is going to cause problems down the road.

> Locally I kinda of hacked up something simple that:
>   - Allocates napi_storage in net_device in alloc_netdev_mqs
>   - Modifies netif_queue_set_napi to:
>      if (napi)
>        napi->storage = dev->napi_storage[queue_index];
> 
> I think I'm still missing the bit about the
> max(rx_queues,tx_queues), though :(

You mean whether it's enough to do

	napi_cnt = max(txqs, rxqs)

? Or some other question?

AFAIU mlx5 can only have as many NAPIs as it has IRQs (256?).
Look at ip -d link to see how many queues it has.
We could do txqs + rxqs to be safe, if you prefer, but it will 
waste a bit of memory.

> > Index would basically be an integer 0..n, where n is the number of
> > IRQs configured for the driver. The index of a NAPI instance would
> > likely match the queue ID of the queue the NAPI serves.  
> 
> Hmmm. I'm hesitant about the "number of IRQs" part. What if there
> are NAPIs for which no IRQ is allocated ~someday~ ?

A device NAPI without an IRQ? Whoever does something of such silliness
will have to deal with consequences. I think it's unlikely.

> It seems like (I could totally be wrong) that netif_queue_set_napi
> can be called and work and create the association even without an
> IRQ allocated.
> 
> I guess the issue is mostly the queue index question above: combined
> rx/tx vs drivers having different numbers of rx and tx queues.

Yes, and in the future the ability to allocate more queues than NAPIs.
netif_queue_set_napi() was expected to cover such cases.

> > We can then allocate an array of "napi_configs" in net_device -
> > like we allocate queues, the array size would be max(num_rx_queue,
> > num_tx_queues). We just need to store a couple of ints so it will
> > be tiny compared to queue structs, anyway.
> > 
> > The NAPI_SET netlink op can then work based on NAPI index rather 
> > than the ephemeral NAPI ID. It can apply the config to all live
> > NAPI instances with that index (of which there really should only 
> > be one, unless driver is mid-reconfiguration somehow but even that
> > won't cause issues, we can give multiple instances the same settings)
> > and also store the user config in the array in net_device.
> > 
> > When new NAPI instance is associate with a NAPI index it should get
> > all the config associated with that index applied.
> > 
> > Thoughts? Does that makes sense, and if so do you think it's an
> > over-complication?  
> 
> I think what you are proposing seems fine; I'm just working out the
> implementation details and making sure I understand before sending
> another revision.

If you get stuck feel free to send a link to a GH or post RFC.
I'm adding extra asks so whether form of review helps.. :)

