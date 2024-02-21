Return-Path: <netdev+bounces-73727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA5985E0B0
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18B31C21E2A
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD41A7FBC8;
	Wed, 21 Feb 2024 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npwKnKWw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964B7BB10
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528358; cv=none; b=tHd2VxMYchQdPheFB0Q5/1GIgJPnzlQ+t+wJsjIOfH/VW1RdVbzJvsNXTIJSnx6+2BaBuzOQ+aW6I7AwKTyONXzbbag11lfuj7JhKQfaw7Hr44bvOQaVULawiW23vD8+RwMuSntoe7kz0nhuK6m0K6f0HPba99CcRv4LPCBwM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528358; c=relaxed/simple;
	bh=TurS9elRInFmzV749W25UWwE5TG1K0gljLIxURsNYT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVlbfWQUbZuGQmxo2ZekQ0/YrqdyvuIs40R95TQZC773q0L7u8fAfTNnaKWv3F7CqjaLHHwVGXnZwuZa7y1g7rTQUEdo2KakBB062ppG7OOH2FA3N/BSlks4Y9/sB5NHSPkEcd+nC04+JEcX2QG2ehnOLyq464Oz1cGpGiKi+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npwKnKWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5360AC433F1;
	Wed, 21 Feb 2024 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708528358;
	bh=TurS9elRInFmzV749W25UWwE5TG1K0gljLIxURsNYT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npwKnKWwHd43xMxB46q12xS7o0STS38bB9rXuxFTYzy9Rc/xEKOQun+BMqR+TBWun
	 dQEXlo1ITTGGO7K7Ps+7Tpbm1NnRI6rEu5QQPwAxmTnBiFPYVRXwfbqCZyGR+byUqs
	 YzNNHyhPJVsRYNGXFLgrGIBIk76bkIhmnUiOvTlFVMyDHJ+VK0HGpynwvxIQn+2ZWP
	 hEsAowr/348ZiYUnJB2p5pF4JO7kCc5yQtYSr7BLsfEGWMXNyNn39kuP4x7QgN4obM
	 wkKwzqCTJmViaPnQ3nIrMVCqWF83xbVKVmuwUyhy+MQ+rscZ+mXp5i7wo3MvPQrsoK
	 cqYcXWZetx2fA==
Date: Wed, 21 Feb 2024 15:12:35 +0000
From: Simon Horman <horms@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org,
	syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: ip_tunnel: prevent perpetual headroom growth
Message-ID: <20240221151235.GB722610@kernel.org>
References: <20240220135606.4939-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220135606.4939-1-fw@strlen.de>

On Tue, Feb 20, 2024 at 02:56:02PM +0100, Florian Westphal wrote:
> syzkaller triggered following kasan splat:
> BUG: KASAN: use-after-free in __skb_flow_dissect+0x19d1/0x7a50 net/core/flow_dissector.c:1170
> Read of size 1 at addr ffff88812fb4000e by task syz-executor183/5191
> [..]
>  kasan_report+0xda/0x110 mm/kasan/report.c:588
>  __skb_flow_dissect+0x19d1/0x7a50 net/core/flow_dissector.c:1170
>  skb_flow_dissect_flow_keys include/linux/skbuff.h:1514 [inline]
>  ___skb_get_hash net/core/flow_dissector.c:1791 [inline]
>  __skb_get_hash+0xc7/0x540 net/core/flow_dissector.c:1856
>  skb_get_hash include/linux/skbuff.h:1556 [inline]
>  ip_tunnel_xmit+0x1855/0x33c0 net/ipv4/ip_tunnel.c:748
>  ipip_tunnel_xmit+0x3cc/0x4e0 net/ipv4/ipip.c:308
>  __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4954 [inline]
>  xmit_one net/core/dev.c:3548 [inline]
>  dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3564
>  __dev_queue_xmit+0x7c1/0x3d60 net/core/dev.c:4349
>  dev_queue_xmit include/linux/netdevice.h:3134 [inline]
>  neigh_connected_output+0x42c/0x5d0 net/core/neighbour.c:1592
>  ...
>  ip_finish_output2+0x833/0x2550 net/ipv4/ip_output.c:235
>  ip_finish_output+0x31/0x310 net/ipv4/ip_output.c:323
>  ..
>  iptunnel_xmit+0x5b4/0x9b0 net/ipv4/ip_tunnel_core.c:82
>  ip_tunnel_xmit+0x1dbc/0x33c0 net/ipv4/ip_tunnel.c:831
>  ipgre_xmit+0x4a1/0x980 net/ipv4/ip_gre.c:665
>  __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4954 [inline]
>  xmit_one net/core/dev.c:3548 [inline]
>  dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3564
>  ...
> 
> The splat occurs because skb->data points past skb->head allocated area.
> This is because neigh layer does:
>   __skb_pull(skb, skb_network_offset(skb));
> 
> ... but skb_network_offset() returns a negative offset and __skb_pull()
> arg is unsigned.  IOW, we skb->data gets "adjusted" by a huge value.
> 
> The negative value is returned because skb->head and skb->data distance is
> more than 64k and skb->network_header (u16) has wrapped around.
> 
> The bug is in the ip_tunnel infrastructure, which can cause
> dev->needed_headroom to increment ad infinitum.
> 
> The syzkaller reproducer consists of packets getting routed via a gre
> tunnel, and route of gre encapsulated packets pointing at another (ipip)
> tunnel.  The ipip encapsulation finds gre0 as next output device.
> 
> This results in the following pattern:
> 
> 1). First packet is to be sent out via gre0.
> Route lookup found an output device, ipip0.
> 
> 2).
> ip_tunnel_xmit for gre0 bumps gre0->needed_headroom based on the future
> output device, rt.dev->needed_headroom (ipip0).
> 
> 3).
> ip output / start_xmit moves skb on to ipip0. which runs the same
> code path again (xmit recursion).
> 
> 4).
> Routing step for the post-gre0-encap packet finds gre0 as output device
> to use for ipip0 encapsulated packet.
> 
> tunl0->needed_headroom is then incremented based on the (already bumped)
> gre0 device headroom.
> 
> This repeats for every future packet:
> 
> gre0->needed_headroom gets inflated because previous packets' ipip0 step
> incremented rt->dev (gre0) headroom, and ipip0 incremented because gre0
> needed_headroom was increased.
> 
> For each subsequent packet, gre/ipip0->needed_headroom grows until
> post-expand-head reallocations result in a skb->head/data distance of
> more than 64k.
> 
> Once that happens, skb->network_header (u16) wraps around when
> pskb_expand_head tries to make sure that skb_network_offset() is unchanged
> after the headroom expansion/reallocation.
> 
> After this skb_network_offset(skb) returns a different (and negative)
> result post headroom expansion.
> 
> The next trip to neigh layer (or anything else that would __skb_pull the
> network header) makes skb->data point to a memory location outside
> skb->head area.
> 
> v2: Cap the needed_headroom update to an arbitarily chosen upperlimit to
> prevent perpetual increase instead of dropping the headroom increment
> completely.
> 
> Reported-and-tested-by: syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com
> Closes: https://groups.google.com/g/syzkaller-bugs/c/fL9G6GtWskY/m/VKk_PR5FBAAJ
> Fixes: 243aad830e8a ("ip_gre: include route header_len in max_headroom calculation")
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Simon Horman <horms@kernel.org>

