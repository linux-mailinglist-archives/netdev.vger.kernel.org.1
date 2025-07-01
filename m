Return-Path: <netdev+bounces-202923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235F8AEFB31
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0237B1D94
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7202750FA;
	Tue,  1 Jul 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOG8dPmW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCD226FA52;
	Tue,  1 Jul 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377985; cv=none; b=DcN/ZVYgW6Ba9HMpYRZhP2b6Q1o+oy3AH3qYBGAOuAjdQCA4Z4MZzpYS6HMnFwLxekEtPh80ctP9z7Qyo/iXkkJoUxmXpvyPNIz/thu4lwpOLopPTe+fiRKrr47//A8rwFG0w639HY+sJKHE15rVtIRVEu79pngft2K1TutpfqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377985; c=relaxed/simple;
	bh=m7sesd7WZao4ANfBHtgTBNHJfjxLhDp8nQ60oP0kpq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYKyDNGnTfHteFQw35NTd9NifG2WMuxVgSVJs+pFB05Xs7kDWISMA3HbjKlsIVSWMcex25KAmCw9cqdpWi5z8w9EYbYoIR5tXfNkvK165x6aLV3cZ9NHGNVNHwRr9gXPxcckiA/pNxMz5Ktk7kTrvQQrxhpzRPNNM4TsB84a0Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOG8dPmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F998C4CEEB;
	Tue,  1 Jul 2025 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751377985;
	bh=m7sesd7WZao4ANfBHtgTBNHJfjxLhDp8nQ60oP0kpq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOG8dPmWELlnis88AUsjh/9Qi7u/M2FxtzjhEivb5869aRtLzxsdNF4LQ7vIIjNBd
	 rBKnJp0sBUF0ftRUHeOPtUvzx7q8ZX3LEWy3pCIfweUbuM84E9Ayl4IU7B5Fg4HliE
	 IjEVNDOKbrhaSPYifsGvMWiwZdTxBCn1Tg/53BYbT6LwRovUzuGNjksh8zSuXXxhB5
	 ANKeDach72GtI3WEYIJGfS4bzKL7Jc/TeTBD6vHNqd/OSu1VEr/+2F2dVwMT/qTyb5
	 wMYasPDV+rZBZfPCo9g5ys9I6cLy2ilJJBfso181Xv9us7JPcsHhP56W4/M7zeoQnl
	 lzdQfOmu4K1WQ==
Date: Tue, 1 Jul 2025 14:52:59 +0100
From: Will Deacon <will@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 3/5] vhost/vsock: Allocate nonlinear SKBs for handling
 large receive buffers
Message-ID: <aGPoO4G75ZGuxjlM@willie-the-truck>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-4-will@kernel.org>
 <orht2imwke5xhnmeewxrbey3xbn2ivjzujksqnrtfe3cjtgrg2@6ls6dyexnkvc>
 <aGKdSVJTjg_vi-12@willie-the-truck>
 <6shb4fowdw43df7pod5kstmtynhrqigd3wdcyrqnni4svgfor2@dgiqw3t2zhfx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6shb4fowdw43df7pod5kstmtynhrqigd3wdcyrqnni4svgfor2@dgiqw3t2zhfx>

On Tue, Jul 01, 2025 at 12:44:58PM +0200, Stefano Garzarella wrote:
> On Mon, Jun 30, 2025 at 03:20:57PM +0100, Will Deacon wrote:
> > On Fri, Jun 27, 2025 at 12:45:45PM +0200, Stefano Garzarella wrote:
> > > On Wed, Jun 25, 2025 at 02:15:41PM +0100, Will Deacon wrote:
> > > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > > index 66a0f060770e..cfa4e1bcf367 100644
> > > > --- a/drivers/vhost/vsock.c
> > > > +++ b/drivers/vhost/vsock.c
> > > > @@ -344,11 +344,16 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> > > >
> > > > 	len = iov_length(vq->iov, out);
> > > >
> > > > -	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
> > > > +	if (len < VIRTIO_VSOCK_SKB_HEADROOM ||
> > > 
> > > Why moving this check here?
> > 
> > I moved it here because virtio_vsock_alloc_skb_with_frags() does:
> > 
> > +       size -= VIRTIO_VSOCK_SKB_HEADROOM;
> > +       return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
> > +                                                  size, mask);
> > 
> > and so having the check in __virtio_vsock_alloc_skb_with_frags() looks
> > strange as, by then, it really only applies to the linear case. It also
> > feels weird to me to have the upper-bound of the length checked by the
> > caller but the lower-bound checked in the callee. I certainly find it
> > easier to reason about if they're in the same place.
> > 
> > Additionally, the lower-bound check is only needed by the vhost receive
> > code, as the transmit path uses virtio_vsock_alloc_skb(), which never
> > passes a size smaller than VIRTIO_VSOCK_SKB_HEADROOM.
> > 
> > Given all that, moving it to the one place that needs it seemed like the
> > best option. What do you think?
> 
> Okay, I see now. Yep, it's fine, but please mention in the commit
> description.

Great, I'll do that.

> > > > 	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
> > > >
> > > > -	if (len > 0)
> > > 
> > > Why removing this check?
> > 
> > I think it's redundant: len is a u32, so we're basically just checking
> > to see if it's non-zero. All the callers have already checked for this
> > but, even if they didn't, skb_put(skb, 0) is harmless afaict.
> 
> Yep, I see, but now I don't remember why we have it, could it be more
> expensive to call `skb_put(skb, 0)`, instead of just having the if for
> control packets with no payload?

That sounds like a questionable optimisation, but I can preserve it in
the only caller that doesn't already check for a non-zero size
(virtio_transport_rx_work()). I mistakenly thought that it was already
checking it, but on closer inspection it only checks the size of the
virtqueue buffer and doesn't look at the packet header at all.

In fact, that is itself a bug because nothing prevents an SKB overflow
on the put path...

I'll add an extra fix for that in v2 so that it can be backported
independently.

Will

