Return-Path: <netdev+bounces-206457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94816B03316
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 23:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3BE178599
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 21:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9151EF39E;
	Sun, 13 Jul 2025 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwBpgnAU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD31E7C23;
	Sun, 13 Jul 2025 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752442641; cv=none; b=C39MSm8uWwJliV0lKEUaJdphF1dF2ShOnItgYyA0Ch/Mz1bVGnw4zTyV7AcY2tugl6s9ioUJWWvwy3P6ZrTCYq16kYEv4t0N3XicrpOcsk8eBwxj03KfX/rwUNngpRcJJ4Uy6NncNLHFUyW7W937hW/RXSy8Uof4Am/EYquQ1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752442641; c=relaxed/simple;
	bh=MFUp8+aRSU/ZJo2PvM4MpIpNHzUHIKwfJThmtEe5PB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv5F8Am4TZ5zNctNXwK/qmRzrm7vk/8pgGeaIr/Ee0z+PdGP+CW1WC8PefC3+GamkQmWADa4nwk2sXDrfj6V8sFxuysjsaFwXx2zQWkl4M1QC/SbQ2lKfrRnjr08WN3qdS/MeuVxdgsdcbkOdhl5Qt0yeBhTHadGGunoSlKmnCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwBpgnAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA6EC4CEE3;
	Sun, 13 Jul 2025 21:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752442640;
	bh=MFUp8+aRSU/ZJo2PvM4MpIpNHzUHIKwfJThmtEe5PB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwBpgnAUY2T11I5/CTLjt4bOjqT1ovpj/OYDqJNThqft/ckP7Ls8Qn6SxE0JTmRDT
	 yURAN5HVgTZE8tq5emXYuiQZZB76Moex26g3pVNb2r/9qitUp9MQS6SUmA8j+dis9Q
	 j1h9GY5VhUTGtiekbseNgqtY2jKNUAbXjfD7nwfUQpk1F2Y4Sz1FsopctGkg5vQz+G
	 WI95AeIL0qNLKidRwlMxu/Z3+slE31rI62+BrF4CQZGhgt6mVscQpoKiN8SbT/eLLW
	 vCcUbD2znewnL7RUn4jHlz8xez7liWuXAReLzmLldZFevqoPqd5EVQxG0NZRlvevP2
	 efRcECWpxx1+w==
Date: Sun, 13 Jul 2025 22:37:15 +0100
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
Subject: Re: [PATCH v2 6/8] vhost/vsock: Allocate nonlinear SKBs for handling
 large receive buffers
Message-ID: <aHQnC-K4jn73I0Yb@willie-the-truck>
References: <20250701164507.14883-1-will@kernel.org>
 <20250701164507.14883-7-will@kernel.org>
 <bborsmywroqnwopuadqovhjvdt2fexhwjy2h3higczb7rwojnf@mg5xrk4mgnwx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bborsmywroqnwopuadqovhjvdt2fexhwjy2h3higczb7rwojnf@mg5xrk4mgnwx>

On Wed, Jul 02, 2025 at 06:50:59PM +0200, Stefano Garzarella wrote:
> On Tue, Jul 01, 2025 at 05:45:05PM +0100, Will Deacon wrote:
> > -static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
> > +static inline struct sk_buff *
> > +__virtio_vsock_alloc_skb_with_frags(unsigned int header_len,
> > +				    unsigned int data_len,
> > +				    gfp_t mask)
> > {
> > 	struct sk_buff *skb;
> > +	int err;
> > 
> > -	if (size < VIRTIO_VSOCK_SKB_HEADROOM)
> > -		return NULL;
> 
> I would have made this change in a separate patch, but IIUC the only other
> caller is virtio_transport_alloc_skb() where this condition is implied,
> right?

At this point in the series, virtio_vsock_alloc_skb() only has a single
caller (vhost_vsock_alloc_skb()) which already has a partial bounds check
and so this patch extends it to cover the lower bound.

Later (in "vsock/virtio: Allocate nonlinear SKBs for handling large
transmit buffers"), virtio_transport_alloc_skb() gets converted over
and that's fine because it never allocates less than
VIRTIO_VSOCK_SKB_HEADROOM.

> I don't know, maybe we could have one patch where you touch this and
> virtio_vsock_skb_rx_put(), and another where you introduce nonlinear
> allocation for vhost/vsock.  What do you think? (not a strong opinion, just
> worried about doing 2 things in a single patch)

I can spin a separate patch for the bounds check.

Will

