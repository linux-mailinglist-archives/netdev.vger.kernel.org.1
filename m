Return-Path: <netdev+bounces-202472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47141AEE08B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F95E189E0DE
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C4D28B4FD;
	Mon, 30 Jun 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRzhUCzi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669925E46A;
	Mon, 30 Jun 2025 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293263; cv=none; b=Kmp6wCUAUHpePce9X7izsd8INZ0niwyCi7TrtGiafh95CZjq80Et3+pdp3KCgYm94o4e96JbKfrTnRCqOwpTGpaEQje3ozNfJQsR4MsgN1PGb2RkTLmblDEk7aCLfJeIF6ZRyBURpsAmQW0xc+dXkSRixeFfdNGbK9wqiaA5tCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293263; c=relaxed/simple;
	bh=AGPZJVVdHZw0WSjLqpq3nXG49DDSI8HhtnKhoZB7T8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4ekPudybFNz7tCOhe6jovfJwUxnzy+N2T7RQ7pO4isVT1zz8J+Lgz/Mq4TfezQzV2JYm4ecFbECb5WMf2DXmRhw8EOKZKyKy0NYwyrZgFMleubL4dYF9yMB1xnw/eQllE+XmJX0xo19lvPolN2k/N+tMD2Q9OWPKpIIZx5Y6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRzhUCzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C326C4CEE3;
	Mon, 30 Jun 2025 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751293262;
	bh=AGPZJVVdHZw0WSjLqpq3nXG49DDSI8HhtnKhoZB7T8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRzhUCzidJonVITkVO0/FIulGBPiwsQJms96ktW5chl1KeCY7+mH6//d/Gf+UZ9df
	 t7HogmiSFj0cgypkMTkh0Zq21E/YdR2bemEn8nrzJNrFJVm3CTeuXEQ2TIfoiKdlD9
	 XacZk/QDfVXktPxRJO7X50uwO+svoWbWdMNP5ltNa/2zdy/AjXqmhKC/t3KaGrUXiX
	 VC6yaD8Qy6LzQ4e716zFPccK6TaB6gvxaTKcy66B6uha1lu/WCBeodXlGTMDzS7phB
	 fNkoslMzDnQYLsDaeyDUSBQX+lGGPbI3wfhW49dYkRXwMMZv90ntZoQM3X9S7Nqq62
	 MzLzBWrjDIrGw==
Date: Mon, 30 Jun 2025 15:20:57 +0100
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
Message-ID: <aGKdSVJTjg_vi-12@willie-the-truck>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-4-will@kernel.org>
 <orht2imwke5xhnmeewxrbey3xbn2ivjzujksqnrtfe3cjtgrg2@6ls6dyexnkvc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orht2imwke5xhnmeewxrbey3xbn2ivjzujksqnrtfe3cjtgrg2@6ls6dyexnkvc>

On Fri, Jun 27, 2025 at 12:45:45PM +0200, Stefano Garzarella wrote:
> On Wed, Jun 25, 2025 at 02:15:41PM +0100, Will Deacon wrote:
> > When receiving a packet from a guest, vhost_vsock_handle_tx_kick()
> > calls vhost_vsock_alloc_skb() to allocate and fill an SKB with the
> > receive data. Unfortunately, these are always linear allocations and can
> > therefore result in significant pressure on kmalloc() considering that
> > the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
> > VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
> > allocation for each packet.
> > 
> > Rework the vsock SKB allocation so that, for sizes with page order
> > greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
> > instead with the packet header in the SKB and the receive data in the
> > fragments.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> > drivers/vhost/vsock.c        | 15 +++++++++------
> > include/linux/virtio_vsock.h | 31 +++++++++++++++++++++++++------
> > 2 files changed, 34 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 66a0f060770e..cfa4e1bcf367 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -344,11 +344,16 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> > 
> > 	len = iov_length(vq->iov, out);
> > 
> > -	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
> > +	if (len < VIRTIO_VSOCK_SKB_HEADROOM ||
> 
> Why moving this check here?

I moved it here because virtio_vsock_alloc_skb_with_frags() does:

+       size -= VIRTIO_VSOCK_SKB_HEADROOM;
+       return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
+                                                  size, mask);

and so having the check in __virtio_vsock_alloc_skb_with_frags() looks
strange as, by then, it really only applies to the linear case. It also
feels weird to me to have the upper-bound of the length checked by the
caller but the lower-bound checked in the callee. I certainly find it
easier to reason about if they're in the same place.

Additionally, the lower-bound check is only needed by the vhost receive
code, as the transmit path uses virtio_vsock_alloc_skb(), which never
passes a size smaller than VIRTIO_VSOCK_SKB_HEADROOM.

Given all that, moving it to the one place that needs it seemed like the
best option. What do you think?

> > +	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
> > 		return NULL;
> > 
> > 	/* len contains both payload and hdr */
> > -	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
> > +	if (len > SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
> > +		skb = virtio_vsock_alloc_skb_with_frags(len, GFP_KERNEL);
> > +	else
> > +		skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
> 
> Can we do this directly in virtio_vsock_alloc_skb() so we don't need
> to duplicate code on virtio/vhost code?

We can, but then I think we should do something different for the
rx_fill() path -- it feels fragile to rely on that using small-enough
buffers to guarantee linear allocations. How about I:

 1. Add virtio_vsock_alloc_linear_skb(), which always performs a linear
    allocation.

 2. Change virtio_vsock_alloc_skb() to use nonlinear SKBs for sizes
    greater than SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)

 3. Use virtio_vsock_alloc_linear_skb() to fill the guest RX buffers

 4. Use virtio_vsock_alloc_skb() for everything else

If you like the idea, I'll rework the series along those lines.
Diff below... (see end of mail)

> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index 67ffb64325ef..8f9fa1cab32a 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -51,27 +51,46 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
> > {
> > 	u32 len;
> > 
> > +	DEBUG_NET_WARN_ON_ONCE(skb->len);
> 
> Should we mention in the commit message?

Sure, I'll add something. The non-linear handling doesn't accumulate len,
so it's a debug check to ensure that len hasn't been messed with between
allocation and here.

> > 	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
> > 
> > -	if (len > 0)
> 
> Why removing this check?

I think it's redundant: len is a u32, so we're basically just checking
to see if it's non-zero. All the callers have already checked for this
but, even if they didn't, skb_put(skb, 0) is harmless afaict.

Will

--->8

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 3799c0aeeec5..a6cd72a32f63 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -349,11 +349,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return NULL;
 
 	/* len contains both payload and hdr */
-	if (len > SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
-		skb = virtio_vsock_alloc_skb_with_frags(len, GFP_KERNEL);
-	else
-		skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
-
+	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0e265921be03..ed5eab46e3dc 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -79,16 +79,19 @@ __virtio_vsock_alloc_skb_with_frags(unsigned int header_len,
 }
 
 static inline struct sk_buff *
-virtio_vsock_alloc_skb_with_frags(unsigned int size, gfp_t mask)
+virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
 {
-	size -= VIRTIO_VSOCK_SKB_HEADROOM;
-	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
-						   size, mask);
+	return __virtio_vsock_alloc_skb_with_frags(size, 0, mask);
 }
 
 static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
 {
-	return __virtio_vsock_alloc_skb_with_frags(size, 0, mask);
+	if (size <= SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
+		return virtio_vsock_alloc_linear_skb(size, mask);
+
+	size -= VIRTIO_VSOCK_SKB_HEADROOM;
+	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
+						   size, mask);
 }
 
 static inline void
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4ae714397ca3..8c9ca0cb0d4e 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -321,7 +321,7 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 	vq = vsock->vqs[VSOCK_VQ_RX];
 
 	do {
-		skb = virtio_vsock_alloc_skb(total_len, GFP_KERNEL);
+		skb = virtio_vsock_alloc_linear_skb(total_len, GFP_KERNEL);
 		if (!skb)
 			break;
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 424eb69e84f9..f74677c3511e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -262,11 +262,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 	if (!zcopy)
 		skb_len += payload_len;
 
-	if (skb_len > SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
-		skb = virtio_vsock_alloc_skb_with_frags(skb_len, GFP_KERNEL);
-	else
-		skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
-
+	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 


