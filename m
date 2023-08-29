Return-Path: <netdev+bounces-31284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2700578C7B9
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 16:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A3E2811C5
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 14:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1D1156CC;
	Tue, 29 Aug 2023 14:37:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3F028E7
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 14:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D021C433C8;
	Tue, 29 Aug 2023 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693319852;
	bh=rTSIxQMHFIy3XOybx3rqIfTL3JgKGorkUs59BDDy9Lk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=euEcJtLzrjz9gEDX6McZvjuTtyyZy3zyo+XcjoSv7Bz/sHCU7ozOO8HPDTowhhq5j
	 Ohz7v+FlVajIszSGPL1MaEDpYY3B6qQk0LsdFHqZjk6HF8bIePktXmyITqc3/gEnz1
	 gHzD9p5g/CStYeJu+1X3IitGlrCc5NRo9UW2b2GTy8Ft4H//13SzDr0Ec3rj0ZvUW8
	 pFU48LkmzzyXOtlhPT8jkwZxKlspfXYXAqG7w7Yjz0SIlXvkInb5F1J8DrWNpVrLax
	 q7l1yFpLBE5Tka39n/af8wdwrwAJ/ubq/GKrmaWYd97T4zR39+XoAWQnePYGTP/8kg
	 QhopqY4N3Lh7g==
Message-ID: <d7d3e320-9b2c-fbc4-7d2d-866741b10cf7@kernel.org>
Date: Tue, 29 Aug 2023 16:37:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: hawk@kernel.org, pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
 lorenzo@kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 mtahhan@redhat.com, huangjie.albert@bytedance.com,
 Yunsheng Lin <linyunsheng@huawei.com>, edumazet@google.com,
 Liang Chen <liangchen.linux@gmail.com>
Subject: Re: [PATCH net-next RFC v1 2/4] veth: use generic-XDP functions when
 dealing with SKBs
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org
References: <169272709850.1975370.16698220879817216294.stgit@firesoul>
 <169272715407.1975370.3989385869434330916.stgit@firesoul>
 <87msyg91gl.fsf@toke.dk>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87msyg91gl.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/08/2023 12.30, Toke Høiland-Jørgensen wrote:
> Jesper Dangaard Brouer <hawk@kernel.org> writes:
> 
>> The root-cause the realloc issue is that veth_xdp_rcv_skb() code path (that
>> handles SKBs like generic-XDP) is calling a native-XDP function
>> xdp_do_redirect(), instead of simply using xdp_do_generic_redirect() that can
>> handle SKBs.
>>
>> The existing code tries to steal the packet-data from the SKB (and frees the SKB
>> itself). This cause issues as SKBs can have different memory models that are
>> incompatible with native-XDP call xdp_do_redirect(). For this reason the checks
>> in veth_convert_skb_to_xdp_buff() becomes more strict. This in turn makes this a
>> bad approach. Simply leveraging generic-XDP helpers e.g. generic_xdp_tx() and
>> xdp_do_generic_redirect() as this resolves the issue given netstack can handle
>> these different SKB memory models.
> 
> While this does solve the memory issue, it's also a subtle change of
> semantics. For one thing, generic_xdp_tx() has this comment above it:
> 
> /* When doing generic XDP we have to bypass the qdisc layer and the
>   * network taps in order to match in-driver-XDP behavior. This also means
>   * that XDP packets are able to starve other packets going through a qdisc,
>   * and DDOS attacks will be more effective. In-driver-XDP use dedicated TX
>   * queues, so they do not have this starvation issue.
>   */
> 
> Also, more generally, this means that if you have a setup with
> XDP_REDIRECT-based forwarding in on a host with a mix of physical and
> veth devices, all the traffic originating from the veth devices will go
> on different TXQs than that originating from a physical NIC. Or if a
> veth device has a mix of xdp_frame-backed packets and skb-backed
> packets, those will also go on different queues, potentially leading to
> reordering.
> 

Mixing xdp_frame-backed packets and skb-backed packet (towards veth)
will naturally come from two different data paths, and the BPF-developer
that redirected the xdp_frame (into veth) will have taken this choice,
including the chance of reordering (given the two data/code paths).

I will claim that (for SKBs) current code cause reordering on TXQs (as
you explain), and my code changes actually fix this problem.

Consider a userspace app (inside namespace) sending packets out (to veth
peer).  Routing (or bridging) will make netstack send out device A
(maybe a physical device).  On veth peer we have XDP-prog running, that
will XDP-redirect every 2nd packet to device A.  With current code TXQ
reordering will occur, as calling "native" xdp_do_redirect() will select
TXQ based on current-running CPU, while normal SKBs will use
netdev_core_pick_tx().  After my change, using
xdp_do_generic_redirect(), the code end-up using generic_xdp_tx() which
(looking at the code) also use netdev_core_pick_tx() to select the TXQ.
Thus, I will claim it is more correct (even-though XDP in general
doesn't give this guarantee).

> I'm not sure exactly how much of an issue this is in practice, but at
> least from a conceptual PoV it's a change in behaviour that I don't
> think we should be making lightly. WDYT?

As desc above, I think this patchset is an improvement.  It might even
fix/address the concern that was raised.


[Outside the scope of this patchset]

The single XDP BPF-prog getting attached to (RX-side) on a veth device,
actually needs to handle *both* xdp_frame-backed packets and SKB-backed
packets, and it cannot tell them apart. (Easy fix: implement a kfunc
RX-metadata hint to expose this?).

For the use-case[1] of implementing NFV (Network Function Virt) chaining
via veth device, where each veth-pairs XDP BPF-prog implement a network
"function" and redirect/chain to the next veth/container NFV.  For this
use-case, I would like the ability to either skip SKB-backed packet or
turn off BPF-prog seeing any SKB-backed packets. There is a huge
performance advantage when XDP-redirecting an xdp_frame into veth
devices in this way, approx 6Mpps for traversing 4 veth devices as
benchmarked in [1]. (p.s. I was going to improve this performance
further, but I got distracted by other work).

  [1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/core/xdp_frame03_overhead.org

The veth-NFV like use-cases are hampered by the SKB-based XDP code-path
causing a significant slowdown for normal netstack packets.  Plus, it
need to parse-and-filter those SKB-based packets too.  This, patchset
"just" significantly reduce the overhead of the SKB-based XDP code path,
which IMHO is a good first step.  Then we can discuss if should have a
switch to turn off the SKB-based XDP code-path in veth, afterwards.

--Jesper


