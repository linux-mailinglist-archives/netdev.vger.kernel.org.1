Return-Path: <netdev+bounces-29489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C749E783797
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 03:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC911C20A06
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 01:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C15E10FA;
	Tue, 22 Aug 2023 01:51:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E408010E9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 01:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932F5C433C8;
	Tue, 22 Aug 2023 01:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692669081;
	bh=hJ5Osl3ne+cxaIsn0E6XA5DP2UJT/9ZPXPOrv8ghqf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JbdmwJTsVT/dVpFxYqSNR+lZahZIs8FmjCV5F4W0P8zMVp80mfvZSWLrIb+quyqjY
	 U3OP1BnbKvdx4K/RpQ/EAeOOMwhZmHjJ3FyBjX9snqzllGMKu9nEx5055EtXYFBBqE
	 n6FCSA7VHEFzTMI1LyplcOeH9oAMjck0zEqWkVnKiKcmzoGg4MOm7V3OtqiQwk5eSZ
	 3na2loTtXONs6OVHft0Y1B/mqaJWlhm1eq78ozDXmf3JczCcGJCKJQ1EpYypXfU0/O
	 LZcPImCunVyoLJO8jghRmwmeRRw0arkX/rbsJJvZ/nKFB4frM2ePCwK9Hp8BuRgzxQ
	 757Z5e7n0wo1Q==
Date: Mon, 21 Aug 2023 18:51:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 sdf@google.com, Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang
 <kaiyuanz@google.com>
Subject: Re: [RFC PATCH v2 02/11] netdev: implement netlink api to bind
 dma-buf to netdevice
Message-ID: <20230821185119.41ccc8a5@kernel.org>
In-Reply-To: <CAF=yD-J5RR9w6=DzxaGT=CeKBWZEiiR3ehAkuNeJvOe3DvMH2g@mail.gmail.com>
References: <20230810015751.3297321-1-almasrymina@google.com>
	<20230810015751.3297321-3-almasrymina@google.com>
	<7dd4f5b0-0edf-391b-c8b4-3fa82046ab7c@kernel.org>
	<20230815171638.4c057dcd@kernel.org>
	<64dcf5834c4c8_23f1f8294fa@willemb.c.googlers.com.notmuch>
	<c47219db-abf9-8a5c-9b26-61f65ae4dd26@kernel.org>
	<20230817190957.571ab350@kernel.org>
	<CAHS8izN26snAvM5DsGj+bhCUDjtAxCA7anAkO7Gm6JQf=w-CjA@mail.gmail.com>
	<7cac1a2d-6184-7cd6-116c-e2d80c502db5@kernel.org>
	<20230818190653.78ca6e5a@kernel.org>
	<38a06656-b6bf-e6b7-48a1-c489d2d76db8@kernel.org>
	<CAF=yD-KgNDzv3-MhOMOTe2bTw4T73t-M7D65MpeG6vDBqHzrtA@mail.gmail.com>
	<20230821141659.5f0b71f7@kernel.org>
	<CAF=yD-J5RR9w6=DzxaGT=CeKBWZEiiR3ehAkuNeJvOe3DvMH2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Aug 2023 20:38:09 -0400 Willem de Bruijn wrote:
> > Are you talking about HW devices, or virt? I thought most HW made
> > in the last 10 years should be able to take down individual queues :o  
> 
> That's great. This is currently mostly encapsulated device-wide behind
> ndo_close, with code looping over all rx rings, say.
> 
> Taking a look at one driver, bnxt, it indeed has a per-ring
> communication exchange with the device, in hwrm_ring_free_send_msg
> ("/* Flush rings and disable interrupts */"), which is called before
> the other normal steps: napi disable, dma unmap, posted mem free,
> irq_release, napi delete and ring mem free.
> 
> This is what you meant? The issue I was unsure of was quiescing the
> device immediately, i.e., that hwrm_ring_free_send_msg.

Yes, and I recall we had similar APIs at Netronome for the NFP.
I haven't see it in MS specs myself but I wouldn't be surprised if 
they required it..

There's a bit of an unknown in how well all of this actually works,
as the FW/HW paths were not exercised outside of RDMA and potentially
other proprietary stuff.

> I guess this means that this could all be structured on a per-queue
> basis rather than from ndo_close. Would be a significant change to
> many drivers, I'd imagine.

Yes, it definitely is. The question is how much of it do we require
from Mina before merging the mem provider work. I'd really like to
avoid the "delegate all the work to the driver" approach that AF_XDP
has taken, which is what I'm afraid we'll end up with if we push too
hard for a full set of APIs from the start.

