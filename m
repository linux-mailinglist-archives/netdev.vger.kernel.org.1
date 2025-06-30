Return-Path: <netdev+bounces-202431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F50AEDE89
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073E61888F94
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F3328B7E4;
	Mon, 30 Jun 2025 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGcmm3OG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E060B283FCE;
	Mon, 30 Jun 2025 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288818; cv=none; b=Fg6+XM9TAdEK8/Grkv9mJtztj2kDsxFBt7P0oeoc94vpNnX2akzqxzHwAJr0y3OEJgf/3QzfVxpfxO8RBeizlvBJfbZU5UrjzjJbcl2/4QG1f6t7X/bIEpSBejMeZSff/TSpWJ89hV30ZJa0CoT1UmfzED+tGfmf/eAOefa8mXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288818; c=relaxed/simple;
	bh=t/bQaJgksnkhC8SrnPoDlqGUAnUGdbY94CBRM7dU3Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuzY99jLzjdjw/TQzlRAQkBIv2xcdy8Zd61B75/BiD0Cb0PKDV1IcRoF0Cf/1WelQuJcGRQsICt9hjsIH+7N8ndDvVghx8GNEsMa3Qlz3trdK3BfyGaDIY8m1Qki/feNj1JejuHakKOtDt339Tql5XVQMV5dAgbjOGR7lu1Zeik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGcmm3OG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C19C4CEE3;
	Mon, 30 Jun 2025 13:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751288817;
	bh=t/bQaJgksnkhC8SrnPoDlqGUAnUGdbY94CBRM7dU3Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGcmm3OGEJP4Yegahnbv3NjUrCik9edY6saeXWrT5QlXJcZOMUEK9mVjc9+x7MrbP
	 PbiQfTknsEbxE5XKUuzQPvPPKPeTWdx/B+xB4dz8MKy1fPRWRxgVk14sR2imlX4XtO
	 VLPxH1/es3xeH94QWxdX2q9oBIEXeMfDvX7Q7d+QS6i5NEFGRzmsZ1z6rkAKDvYoYG
	 UY/iGIxccs9oAihs0V+I0SD4oT5ifYA4Xa+SEb+tILg9u3Sd2ZB2u1whrjebaPp/8h
	 IoOnKDnjcsTg8z9+DKezHzth8jQvdOAosJ6vHK8e+oPkMKns91lnK/4muSTO9qCbgb
	 lxIIo+dX9tgrQ==
Date: Mon, 30 Jun 2025 14:06:52 +0100
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
Subject: Re: [PATCH 2/5] vsock/virtio: Resize receive buffers so that each
 SKB fits in a page
Message-ID: <aGKL7F18knOCQVVS@willie-the-truck>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-3-will@kernel.org>
 <rl5x3fw5rgyrptof2h7qc2wgimxd4ldh4tp4yhm52n4utksjdm@zei2wzme65jj>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rl5x3fw5rgyrptof2h7qc2wgimxd4ldh4tp4yhm52n4utksjdm@zei2wzme65jj>

On Fri, Jun 27, 2025 at 12:41:48PM +0200, Stefano Garzarella wrote:
> On Wed, Jun 25, 2025 at 02:15:40PM +0100, Will Deacon wrote:
> > When allocating receive buffers for the vsock virtio RX virtqueue, an
> > SKB is allocated with a 4140 data payload (the 44-byte packet header +
> > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE). Even when factoring in the SKB
> > overhead, the resulting 8KiB allocation thanks to the rounding in
> > kmalloc_reserve() is wasteful (~3700 unusable bytes) and results in a
> > higher-order page allocation for the sake of a few hundred bytes of
> > packet data.
> > 
> > Limit the vsock virtio RX buffers to a page per SKB, resulting in much
> > better memory utilisation and removing the need to allocate higher-order
> > pages entirely.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> > include/linux/virtio_vsock.h | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index 36fb3edfa403..67ffb64325ef 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -111,7 +111,8 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
> > 	return (size_t)(skb_end_pointer(skb) - skb->head);
> > }
> > 
> > -#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
> > +#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(SKB_WITH_OVERHEAD(PAGE_SIZE) \
> > +						 - VIRTIO_VSOCK_SKB_HEADROOM)
> 
> This is only used in net/vmw_vsock/virtio_transport.c :
> 
> static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
> {
> 	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM;
> 
> 
> What about just remove VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE and use
> `SKB_WITH_OVERHEAD(PAGE_SIZE)` there? (maybe with a comment summarizing
> the issue we found).

Sure, works for me. That gets rid of the funny +- VIRTIO_VSOCK_SKB_HEADROOM
too.

Will

