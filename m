Return-Path: <netdev+bounces-206453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F27B03308
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 23:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B3B3A58FF
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 21:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C731E5701;
	Sun, 13 Jul 2025 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej7CMUBY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4678F26;
	Sun, 13 Jul 2025 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752441996; cv=none; b=LAFlgFHqqJVusEZLTpscSEL4pmO3T6Ky0axHzeu9axjWhv+9srK15D/veZxJCJ2an8+0VQsVSWzpKlX/J+aWNWK0iZGxaFZwlcu3KxOFx9ggzFgAXVuXDVyh1r9owcLCLABT4fFzbDigWR55JgLOxMwUhpGZnm6h5rABcA7pH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752441996; c=relaxed/simple;
	bh=XwqiMXSPVH+Oe9ZcNWwJBhr5KK5qoTf07zqcJsTvdQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTxHeeubs8NXdkoJZIRuIReaPZcnn7CQx1Qrsnl77hnRT0wnC604eug3P+wb+n6UElkftHhXS/ZYMLLntunV08Mf9OM0Jou87l0IIhEJwFE9D9dPBuJ0Sa48BmlvRtBE7V1b6vXY//+1xWfmZ9aeEFDR+Bfj6UoRUticTiTstUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej7CMUBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BB3C4CEE3;
	Sun, 13 Jul 2025 21:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752441996;
	bh=XwqiMXSPVH+Oe9ZcNWwJBhr5KK5qoTf07zqcJsTvdQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ej7CMUBYSCGSbIQUyVlm1BoPbXWnozMRdDV48b2uy/Tw08lfvexzsDz8piwt/DhiJ
	 sN29lbLbAIedT3vGcT8/st4bPDEQU4GpWUGxclX3L6z+klsAwg5hTFCqkvkjkzXcsu
	 qTcihp8ivQ79is6uWn+8HdBZ4v0JDDgSj4caNc49LqkcBikU+lHEPQxdsetSQOl44E
	 6ZedoAzS6bR+QRig7hYH/4e3hcXZmUvFsO6+CMnvzFol0Umg8oqmgHoe/RBZcLfy3C
	 Ls3SLTF87i2YO9bA+26ut5UIcho9Qle1EV/N7FyDGqOq9/8+TcdFafLxp78jMy5Cr2
	 h+tLOkloHuBGQ==
Date: Sun, 13 Jul 2025 22:26:30 +0100
From: Will Deacon <will@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 4/8] vsock/virtio: Resize receive buffers so that each
 SKB fits in a page
Message-ID: <aHQkhuHI0yRPTfvV@willie-the-truck>
References: <20250701164507.14883-1-will@kernel.org>
 <20250701164507.14883-5-will@kernel.org>
 <20250701201400.52442b0e@pumpkin>
 <3s4lvbnzdj72dcvvh2nnx4s7skyco4pbpwuyycccqv3iudqhnn@5szfvvgxojkb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3s4lvbnzdj72dcvvh2nnx4s7skyco4pbpwuyycccqv3iudqhnn@5szfvvgxojkb>

On Wed, Jul 02, 2025 at 03:16:19PM +0200, Stefano Garzarella wrote:
> On Tue, Jul 01, 2025 at 08:14:00PM +0100, David Laight wrote:
> > On Tue,  1 Jul 2025 17:45:03 +0100
> > Will Deacon <will@kernel.org> wrote:
> > 
> > > When allocating receive buffers for the vsock virtio RX virtqueue, an
> > > SKB is allocated with a 4140 data payload (the 44-byte packet header +
> > > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE). Even when factoring in the SKB
> > > overhead, the resulting 8KiB allocation thanks to the rounding in
> > > kmalloc_reserve() is wasteful (~3700 unusable bytes) and results in a
> > > higher-order page allocation for the sake of a few hundred bytes of
> > > packet data.
> > > 
> > > Limit the vsock virtio RX buffers to a page per SKB, resulting in much
> > > better memory utilisation and removing the need to allocate higher-order
> > > pages entirely.
> > > 
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  include/linux/virtio_vsock.h     | 1 -
> > >  net/vmw_vsock/virtio_transport.c | 7 ++++++-
> > >  2 files changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > > index eb6980aa19fd..1b5731186095 100644
> > > --- a/include/linux/virtio_vsock.h
> > > +++ b/include/linux/virtio_vsock.h
> > > @@ -109,7 +109,6 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
> > >  	return (size_t)(skb_end_pointer(skb) - skb->head);
> > >  }
> > > 
> > > -#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
> > >  #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
> > >  #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > > index 488e6ddc6ffa..3daba06ed499 100644
> > > --- a/net/vmw_vsock/virtio_transport.c
> > > +++ b/net/vmw_vsock/virtio_transport.c
> > > @@ -307,7 +307,12 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
> > > 
> > >  static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
> > >  {
> > > -	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM;
> > > +	/* Dimension the SKB so that the entire thing fits exactly into
> > > +	 * a single page. This avoids wasting memory due to alloc_skb()
> > > +	 * rounding up to the next page order and also means that we
> > > +	 * don't leave higher-order pages sitting around in the RX queue.
> > > +	 */
> > > +	int total_len = SKB_WITH_OVERHEAD(PAGE_SIZE);
> > 
> > Should that be an explicit 4096?
> > Otherwise it is very wasteful of memory on systems with large pages.
> 
> This is a good point!
> 
> What about SKB_WITH_OVERHEAD(VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE) ?

Personally, I'd prefer to use PAGE_SIZE here as I think it's reasonable
that using a larger page size ends up with a proportionately higher
memory utilisation but potentially better performance. At least,
configuring the kernel with a larger page size and expecting no impact
on memory consumption is misguided. The 4KiB constant seems fairly
arbitrary (and has been there since day 1), so I can only assume that it
is acting as a proxy for PAGE_SIZE on architectures where that is fixed
to 4KiB.

However, I concede that the intention of this patch is to avoid the
allocation inefficiency described in the commit message, so I'll revert
to 4KiB as you suggest above but moving the SKB overhead calculation
into the definition:

#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE        SKB_WITH_OVERHEAD(1024 * 4)

That way, I can move the comment there as well and it should be clear
why we've ended up with what we have.

Will

