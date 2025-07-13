Return-Path: <netdev+bounces-206454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC99B0330D
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 23:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6EF3B622C
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 21:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD161E5701;
	Sun, 13 Jul 2025 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEAvRgpu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97321E5219;
	Sun, 13 Jul 2025 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752442018; cv=none; b=YN600cthSZn0DZfU22TTW0Rj7UfsyrJ5T7HSXGju7nR60RFqMw6X2YQGvLZ2S7I4gcP1WzIIk3wJCDg5m3+EAc6ozDNoQI0XEZlSJdaWSzZmLuxKZtEctD5YdIB8hMnS55ot+m9RDU/AbsvpsOJUT+HenA38timbpTnoRF18r4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752442018; c=relaxed/simple;
	bh=2IqAuxz+IPa4xiM1NY8zt2c40MTiKvCy6XTSygq7E/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyZR5NlwTK/bBGqFEu3V0tgjxVYKW1PrlGVi5xEipB36zlf0CvJrNGMSChMVWuBrVOulzFo6QDofVVDLSg9X6Q7kSK871Eslwt5bbdMAy1E/ExPAU2kYPrgqE+808sdLJOjrpftYd3A2GjBAQHRq16yOM36gdkwzBsPUHD9WiHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEAvRgpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F04C4CEE3;
	Sun, 13 Jul 2025 21:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752442017;
	bh=2IqAuxz+IPa4xiM1NY8zt2c40MTiKvCy6XTSygq7E/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kEAvRgpu7gQZaR+8UBG/ZaHc0OfCYkxTtjdKPz40JrSZu9/U7I5XnsPzeOOBcBGe+
	 2dxCz6NcwVv3gWL7siRvElbjsVL7tqlyUES3uP2nMkbO67L4nRFwkXT1juqKZX6Fzl
	 RddNLh2e8+m7CzpOg41xWmW/nMuk5KuAVzBuZZENXMWt1EeWN0mOjj3YKAkTcjIpjd
	 3CgnoCGVEumQANoZnS+Ofs5gZUIG1JvK3dstE8Uv/c4wt/ngERmG83DOHSo9O/gFvB
	 jFEeie9M+TTpsa+utCq58A0oW+X47nGO3qxxcEb+syDtDRmRn/ENUq6Qy6AA34ACD8
	 Wrxb80CI0AP7Q==
Date: Sun, 13 Jul 2025 22:26:53 +0100
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
Subject: Re: [PATCH v2 5/8] vsock/virtio: Add vsock helper for linear SKB
 allocation
Message-ID: <aHQknfAARvHXXWyi@willie-the-truck>
References: <20250701164507.14883-1-will@kernel.org>
 <20250701164507.14883-6-will@kernel.org>
 <vaq3g5wtt657w532itcpdwsvf742cglvuckiqcyueg7y72wtko@yg7swar2xnwh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vaq3g5wtt657w532itcpdwsvf742cglvuckiqcyueg7y72wtko@yg7swar2xnwh>

On Wed, Jul 02, 2025 at 06:40:17PM +0200, Stefano Garzarella wrote:
> On Tue, Jul 01, 2025 at 05:45:04PM +0100, Will Deacon wrote:
> > In preparation for nonlinear allocations for large SKBs, introduce a
> > new virtio_vsock_alloc_linear_skb() helper to return linear SKBs
> > unconditionally and switch all callers over to this new interface for
> > now.
> > 
> > No functional change.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> > drivers/vhost/vsock.c                   | 2 +-
> > include/linux/virtio_vsock.h            | 6 ++++++
> > net/vmw_vsock/virtio_transport.c        | 2 +-
> > net/vmw_vsock/virtio_transport_common.c | 2 +-
> > 4 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 66a0f060770e..b13f6be452ba 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -348,7 +348,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> > 		return NULL;
> > 
> > 	/* len contains both payload and hdr */
> > -	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
> > +	skb = virtio_vsock_alloc_linear_skb(len, GFP_KERNEL);
> > 	if (!skb)
> > 		return NULL;
> > 
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index 1b5731186095..6d4a933c895a 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -70,6 +70,12 @@ static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t ma
> > 	return skb;
> > }
> > 
> > +static inline struct sk_buff *
> > +virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
> > +{
> > +	return virtio_vsock_alloc_skb(size, mask);
> 
> Why not just renaming virtio_vsock_alloc_skb in this patch?
> 
> In that way we are sure when building this patch we don't leave any "old"
> virtio_vsock_alloc_skb() around.

We'll be bringing virtio_vsock_alloc_skb() back almost immediately, but
I can do that if you like.

Will

