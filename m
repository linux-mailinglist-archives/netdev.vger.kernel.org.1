Return-Path: <netdev+bounces-206452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6940B03305
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 23:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30011894733
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 21:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C9E1E22E6;
	Sun, 13 Jul 2025 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK3hjQdu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244F69D2B;
	Sun, 13 Jul 2025 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752441974; cv=none; b=uMSo8AGvAlFaohARI6M/qqZZbN9l1HQD/lDMNKnUChmEjV1c6QJsMTB2L9jQIIn50UW7xz/CNUCHenkeUmKD4kn7rw00wGa49VAvDede7PF76HrTP89nWPkaJvOZOdFJd0mzrz/QILInY3MHsLfsuPBn/phTwaCGe9q4gRWKQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752441974; c=relaxed/simple;
	bh=DUf5G+GEAuuhATewQdhh9QQLQTnqgEAR2HH06ANZ3Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe5X/qxxU0+RmbrjMw/0eLvKbaAUlWvWKIfTtVz+I1HCy2B+193Bmzxn04IVM4i+75vKBtO3NVXm9jEDLJyA5lrTiDIrDfAJ81iQl3SB/GxwI3u3qcpWqqb4shMe+/RFX/kZZQJfVeVnYBEL6CQ758xvMv949mpGhmbWkIt+3u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK3hjQdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DC9C4CEE3;
	Sun, 13 Jul 2025 21:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752441974;
	bh=DUf5G+GEAuuhATewQdhh9QQLQTnqgEAR2HH06ANZ3Vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JK3hjQdu6ULKf9UE+7yxxof9iM0/uZ4p7hu4Aza4QLYsbvYIGYXAJJSGOufNhoxe+
	 85X89vo+y9hhw8zjNmb7vJYwiIu7IvRkaJeSVAZEgoFguFrphIfh8SuwRbXH/Ta7HY
	 +5JfBeHy/o+ZJ/3v/gO79vtPdwQuCqYIPtRxShx4C2F8fXBww7JN89IJsfa4zirYi1
	 5IXCs0x3GYWxVbYtMAzRkiT3cbtJJXeq8xu/A2bJNH0USvwEpqDGZRwBJLWsla81ZQ
	 1/vvYGmubh/MfBvjN5NGkouS/+xxSOBfYuwMbGeL4rigQ6qYPYNcOiJifKMctbcBhR
	 Wb9VRbLv5bgGg==
Date: Sun, 13 Jul 2025 22:26:08 +0100
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
Subject: Re: [PATCH v2 3/8] vsock/virtio: Move length check to callers of
 virtio_vsock_skb_rx_put()
Message-ID: <aHQkcBiO_1Xg33Bo@willie-the-truck>
References: <20250701164507.14883-1-will@kernel.org>
 <20250701164507.14883-4-will@kernel.org>
 <g3h6k6vqfxwqsvojptaqy63qsn2vwo7i45segjgwjgmotysmwr@dmgbwacytag7>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g3h6k6vqfxwqsvojptaqy63qsn2vwo7i45segjgwjgmotysmwr@dmgbwacytag7>

On Wed, Jul 02, 2025 at 06:28:37PM +0200, Stefano Garzarella wrote:
> On Tue, Jul 01, 2025 at 05:45:02PM +0100, Will Deacon wrote:
> > virtio_vsock_skb_rx_put() only calls skb_put() if the length in the
> > packet header is not zero even though skb_put() handles this case
> > gracefully.
> > 
> > Remove the functionally redundant check from virtio_vsock_skb_rx_put()
> > and, on the assumption that this is a worthwhile optimisation for
> > handling credit messages, augment the existing length checks in
> > virtio_transport_rx_work() to elide the call for zero-length payloads.
> > Note that the vhost code already has similar logic in
> > vhost_vsock_alloc_skb().
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> > include/linux/virtio_vsock.h     | 4 +---
> > net/vmw_vsock/virtio_transport.c | 4 +++-
> > 2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index 36fb3edfa403..eb6980aa19fd 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -52,9 +52,7 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
> > 	u32 len;
> > 
> > 	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
> > -
> > -	if (len > 0)
> > -		skb_put(skb, len);
> > +	skb_put(skb, len);
> 
> Since the caller is supposed to check the len, can we just pass it as
> parameter?
> 
> So we can avoid the `le32_to_cpu(virtio_vsock_hdr(skb)->len)` here.

Sure, I'll do that. It means that virtio_vsock_skb_rx_put() will briefly
be a simple wrapper around skb_put() but once the non-linear handling
comes in then it becomes useful again.

Will

