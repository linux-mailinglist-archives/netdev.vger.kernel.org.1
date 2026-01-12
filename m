Return-Path: <netdev+bounces-249073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B54DD13A93
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9676A30022EA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA692E7185;
	Mon, 12 Jan 2026 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljI1jKTN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06627602C;
	Mon, 12 Jan 2026 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231390; cv=none; b=ktFcqs2UY3aQ4XJJcmBcXk59Yua9OYOIZrsLWCzG7Zj4sIIB9wrs5KesK0pFjnynaIAmVLqkszM/PDPohf1ld3mBv+NCDOUVGx6RtJdokoXJPO37Ww+FOfwsToUj+AO9sMOnGkmS4Z43fF36sKHZjRD0FTWIkcoiP9LLovWg79c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231390; c=relaxed/simple;
	bh=UWx7yPFkkQmM09w3EAQe8LZDF7F0YySqGqrHHQJMuaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmiHacHkY01p7FHBin9JZrkJ+fasTz2emkcPQqCvEMC3MHJDk3mW1+qjuxOOinzKLburCaRHfHHaIwlUhDokKEvOOPaSA8awBAo8cc586AEIx36GU5cwivPY5ggnR+Cs05q2OBcHtu3hZqLQ1slAjgAQcr+rjj3FOf/9BVa4E84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljI1jKTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ABDC19422;
	Mon, 12 Jan 2026 15:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768231390;
	bh=UWx7yPFkkQmM09w3EAQe8LZDF7F0YySqGqrHHQJMuaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljI1jKTNt6e7G6yhmtu/piIwtEEg5YQN0Jc6qpEYcFAtSqy/1RSWmO7SSLiqLzEbr
	 6xcpW144b6CmYHQ3qdoJ0+2GnCv0ujWvH8JaTkTYHCElpCd/9YJ4Hq3j4nuA4lHc+d
	 94g6QHhl7aIIloRiQzHC9AfKzoQ8YAmFLhA9q9fc75lRSXLOBMrvWoo/y6KZl7tkZm
	 kuMW3TZzxltfTQ8HJGkShbUdhCa6OJl3UoHwqpqspM1qY6qHIiSwvNJVjKWATurJZs
	 PG0SIYt4XU0C7LEtiO/tOl2LFpaKk4pAapr5AaHMQt56/Jg8EW/qgTWRr/fn5k+hYX
	 RxsWVZPm6siAw==
Date: Mon, 12 Jan 2026 15:22:59 +0000
From: Will Deacon <will@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 4/9] vsock/virtio: Resize receive buffers so that each
 SKB fits in a 4K page
Message-ID: <aWUR00JlpXo1Dyl5@willie-the-truck>
References: <20250717090116.11987-1-will@kernel.org>
 <20250717090116.11987-5-will@kernel.org>
 <fa3cd687961e63dd2b79780eb84c243c8d35532a.camel@infradead.org>
 <aWUFnZTkdOrZAest@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWUFnZTkdOrZAest@sgarzare-redhat>

On Mon, Jan 12, 2026 at 03:48:11PM +0100, Stefano Garzarella wrote:
> On Thu, Jan 08, 2026 at 05:33:42PM +0100, David Woodhouse wrote:
> > On Thu, 2025-07-17 at 10:01 +0100, Will Deacon wrote:
> > > 
> > > -#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
> > > +/* Dimension the RX SKB so that the entire thing fits exactly into
> > > + * a single 4KiB page. This avoids wasting memory due to alloc_skb()
> > > + * rounding up to the next page order and also means that we
> > > + * don't leave higher-order pages sitting around in the RX queue.
> > > + */
> > > +#define
> > > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	SKB_WITH_OVERHEAD(1024 * 4)
> > 
> > Should this be SKB_WITH_OVERHEAD()?
> 
> ehm, is what the patch is doing, no?
> 
> > 
> > Or should it subtract VIRTIO_VSOCK_SKB_HEADROOM instead?
> 
> Why?
> 
> IIRC the goal of the patch was to have an SKB that fit entirely on one page,
> to avoid wasting memory, so yes, we are reducing the payload a little bit
> (4K vs 4K - VIRTIO_VSOCK_SKB_HEADROOM - SKB_OVERHEAD), but we are also
> reducing segmentation.
> 
> > 
> > (And also, I have use cases where I want to expand this to 64KiB. Can I
> > make it controllable with a sockopt? module param?)

What page size are you using? At some point I had this as PAGE_SIZE but
it wasn't popular:

https://lore.kernel.org/all/20250701201400.52442b0e@pumpkin/

> I'm not sure about sockopt, because this is really device specific and can't
> be linked to a specific socket, since the device will pre-fill the queue
> with buffers that can be assigned to different sockets.
> 
> But yeah, perhaps a module parameter would suffice, provided that it can
> only be modified at load time, otherwise we would have to do something
> similar to NIC and ethtool, but I feel that would be too complicated for
> this use case.

FWIW, we carried something similar in Android for a while on the
transmit side and it was a bit of a pain to maintain; we ended up in
situations where the guest and the host had to be configured similarly
for things to work, although the non-linear support should solve those
issues now. I'm not against the idea, I just wouldn't wish that pain on
anybody else!

Anyway, if we wanted to support something similar upstream for the rx
buffers, I'd suggest specifying it as a page-order for the entire
SKB allocation and clamping it to PAGE_ALLOC_COSTLY_ORDER.

Will

