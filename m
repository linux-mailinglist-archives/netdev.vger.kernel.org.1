Return-Path: <netdev+bounces-202473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156E5AEE08E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1726C3B19CC
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7067728C027;
	Mon, 30 Jun 2025 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0RJ2bbt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8F244688;
	Mon, 30 Jun 2025 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293295; cv=none; b=KQ4HfidTGEescWmpejOHCJdOAUCHKyNDrWdqC/ZOyxetlQ/FxtQNbOBWQGoL2YmJdCKDaRHkiLQ67g26zkIWzQx/0HcRCnnlmb0sDw1y/yMNdG/kEQAS7uWIp5TfVIroAZ/Cu0DH7VvxU3uKRNaDuf6BNaYjYFD8Y6EtYjXYM8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293295; c=relaxed/simple;
	bh=V9TfuuiZ4q/Le7XiKFng/PtZN3ZlbZa4Vm3P4ayPSvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1PdLjcxt+PtdWf1barrTgCqwVeu4hdYjoxZhXEo/v5mbAlX5zwK+xUnaYz+HOZpUQEEVQURSA25bEFuGtkuPs/bjFiH6RzdTcKKG6qz2QbCW63KVrnLNZ1g0I7kb8DlrUs21BFmQC6f2Np+0sVpqcljI+a7v3ZdJk7HVe+fA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0RJ2bbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD003C4CEE3;
	Mon, 30 Jun 2025 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751293294;
	bh=V9TfuuiZ4q/Le7XiKFng/PtZN3ZlbZa4Vm3P4ayPSvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0RJ2bbtkGszCeK5c0FHngKD6P0fQYiv24FvjYSD1XrXAQFUp43rlaiBMYi9qpP7D
	 R6cLvIvU5RiSa7d/TVYDnqBG12epdvMZVATGqZ77KW9/e4cL39uk8/wROXJOzprxWI
	 HqPlmz9VdBpgBesE6Jl0yjaqAfkUXSqKNH76vajhknnkvt8utr2QJGZDZGzbO0lMyF
	 kN/ISpQQ8gY6F4zjBqNYXhiXdX/y0Q5pllOPUhEM+RKsV5/lvLIvhNCGsdFK88Kwqb
	 rzh5YYPK1WvVYBi6wilerG4B1YdFZ6pxYCfP6xx754qkqnk2UgAu2QnZo8PcIcKtnK
	 MLNhaT8ykn+2A==
Date: Mon, 30 Jun 2025 15:21:29 +0100
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
Subject: Re: [PATCH 5/5] vhost/vsock: Allocate nonlinear SKBs for handling
 large transmit buffers
Message-ID: <aGKdaZp0zpEimAgn@willie-the-truck>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-6-will@kernel.org>
 <cuqzmhjjakvmbwvcyub75vvjxorjkmzxkuvwvwowhec6wuaghj@uyq6glnhxp5n>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cuqzmhjjakvmbwvcyub75vvjxorjkmzxkuvwvwowhec6wuaghj@uyq6glnhxp5n>

On Fri, Jun 27, 2025 at 12:50:27PM +0200, Stefano Garzarella wrote:
> nit: I'd use `vsock/virtio: ` prefix since we are touching the virtio
> transport common code. Maybe we can mention that this will affect both
> virtio and vhost transports.

Sure, I'll do that.

> On Wed, Jun 25, 2025 at 02:15:43PM +0100, Will Deacon wrote:
> > When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
> > virtio_transport_alloc_skb() to allocate and fill SKBs with the transmit
> > data. Unfortunately, these are always linear allocations and can
> > therefore result in significant pressure on kmalloc() considering that
> > the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
> > VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
> > allocation for each packet.
> > 
> > Rework the vsock SKB allocation so that, for sizes with page order
> > greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
> > instead with the packet header in the SKB and the transmit data in the
> > fragments.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> > net/vmw_vsock/virtio_transport_common.c | 9 +++++++--
> > 1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index 1b5d9896edae..424eb69e84f9 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -109,7 +109,8 @@ static int virtio_transport_fill_skb(struct sk_buff *skb,
> > 		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
> > 					       &info->msg->msg_iter, len, NULL);
> > 
> > -	return memcpy_from_msg(skb_put(skb, len), info->msg, len);
> > +	virtio_vsock_skb_put(skb);
> > +	return skb_copy_datagram_from_iter(skb, 0, &info->msg->msg_iter, len);
> > }
> > 
> > static void virtio_transport_init_hdr(struct sk_buff *skb,
> > @@ -261,7 +262,11 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> > 	if (!zcopy)
> > 		skb_len += payload_len;
> > 
> > -	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
> > +	if (skb_len > SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
> > +		skb = virtio_vsock_alloc_skb_with_frags(skb_len, GFP_KERNEL);
> > +	else
> > +		skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
> > +
> 
> As I mentioned in the other patch, we may avoid this code duplication hiding
> this in virtio_vsock_alloc_skb() or adding a new function that
> we can use when we want to allocate frags or not.

That would be good. I had a crack at it in the diff I sent in reply to
the earlier patch, so please take a look.

Will

