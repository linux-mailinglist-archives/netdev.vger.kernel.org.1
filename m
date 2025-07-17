Return-Path: <netdev+bounces-207793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2544AB0893B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2A17AA2EC
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE06289E2C;
	Thu, 17 Jul 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyQFBiFC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2164503B
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744318; cv=none; b=E1KIVk9Wi2jwNz9vWvZRBPbjO4ng1YCLtrBb1Rh7PV1ED23dUu7pnxvhWrysHlkwfsQK37LRdUIx0A1RkI0WyqtPpX2xbZTSqRxVXBH/H+sA2g3C/xLR3UEWoSQI21WEbNqXydHmPTvmmPs2lqo986hD53sOw0+s2if0C/Vltt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744318; c=relaxed/simple;
	bh=mUGblPwGliu3YzskON//m/UU7MFOS7s+Yue1Nej7KOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1XNyGizr1yfwSCCQSCfaRKJSXD1WzW17DVIlxVjz2T8WvSTPMy2Ocw+qQ/fnIGnRo8RXF+yp3MqhETfD4uBxhQdAR2Hsz7JQbvpossjc7gvRYwJVKGYnnQuVdOsUt3zV4qpfIutRyM1no339A8aiZK5EVIatOx4FNL/Pdp6ib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyQFBiFC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752744314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqpFHXx++3EMATXriFPKJGfUd3A8yDTgA5DIK5OX6Jk=;
	b=JyQFBiFCG6AKhZxI1NllSyGrD2xUa5GCmFdtalFgMxLYMMIxzkSNuvu22bUBWpsGaunNfZ
	zfIm0htoVm82xdsUaawD9AKLohJWOaPPbnLPX8TYxFfhhKS+h4nGtSIgxJFN2OR9Godm6S
	DFyM/KM9Ux1CvTCsgsXJCu6JyguLhuQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-FxS1mquZMX-csmRfsIBZag-1; Thu, 17 Jul 2025 05:25:13 -0400
X-MC-Unique: FxS1mquZMX-csmRfsIBZag-1
X-Mimecast-MFC-AGG-ID: FxS1mquZMX-csmRfsIBZag_1752744312
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e741f4a7585so1146195276.0
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 02:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752744312; x=1753349112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqpFHXx++3EMATXriFPKJGfUd3A8yDTgA5DIK5OX6Jk=;
        b=rLrEaWzsy8tQwqTCEaJYNxDT5eIjhtIwE7bk9+xcB085icSaLrCKN97ZJfupiEuBlW
         VIFCXFn7qG/wRFe10pSuX93a1iMtwE+DZZ3n4Z0eC4wPYuH3SgZdYc3eLpKvH/0mrw9T
         yPkyqdTeQAGpZlZgN8XFNS6T0YFxMhCr/2DH84D0X4bXThDP3MbqXIANgPAuNmfhxpJ4
         l+Y9Q2QaAgiys5k4tMZlvYs/n9P9fcz1MUJ/HSvwla6B0VRXsn9xiNbDhIBIYNy/NYO7
         drlHoJyYdDvAd5y8irU0ZgquJ3oKT1CBY1G78LD1u5ayDM58/EkKNX62bkSEceFuUUwX
         qtFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhkPyIV/H3e00IPo6jCwJwC+5tSE+CfOrRyrhYs3WvZQHVgt6IgCgyUaT/HeyND2Jmb3QjuuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVA2kvN9R/LpkijHUvC7EmZ+QDwCCFare6A6XPRF2wn+1fogu2
	EQlL5wQBbvvewK9CUX6HUfZz87rqH2NduyEzMXDiIKeV3B7euXZPqI3LLWWgGA1TqsUNuzUOaqz
	GC08v9NGrQ9rF6PlE7sCDXauGKBP2UpJ3IkjwhUHWjX/9+6k65ibv2qa+Qkzl6w7Ve/KynbJvZi
	vVdVGFeRjRutynEVBREmHah1KBBK9Mpd5e
X-Gm-Gg: ASbGncthsmliYWbgkEo1fasdHDPARuoEE+Us0FsN1pS4MBoGlbu6oe8f3F7KFmB5YVb
	YqwjM7EYkfldeS1jJ/HnD8zqX8ssvte4pJ57TmlxiQAMWKWixuJXrkQf+NEdSI6OSKFbhAKy4eh
	T0sJUfg2IyM6B2Q0peVCuh
X-Received: by 2002:a05:6902:2582:b0:e8b:d0e7:3ae4 with SMTP id 3f1490d57ef6-e8bd0e73bdcmr5202983276.22.1752744312274;
        Thu, 17 Jul 2025 02:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsfTvkw1PSMXKHBxuokKzY5S7apDyUaHwD6BT79131/X481c8450D90mHNBs58p1agihhTtDodQFLemqkkQdo=
X-Received: by 2002:a05:6902:2582:b0:e8b:d0e7:3ae4 with SMTP id
 3f1490d57ef6-e8bd0e73bdcmr5202940276.22.1752744311654; Thu, 17 Jul 2025
 02:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717090116.11987-1-will@kernel.org> <20250717090116.11987-2-will@kernel.org>
 <CACGkMEsoBj7aNXfCU7Zn=5yWnhvA7M8xhbucmt4fuPm31dQ1+w@mail.gmail.com>
In-Reply-To: <CACGkMEsoBj7aNXfCU7Zn=5yWnhvA7M8xhbucmt4fuPm31dQ1+w@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 17 Jul 2025 11:25:00 +0200
X-Gm-Features: Ac12FXz6ffoOmDUY3dLdGfR0fllZrD7uhyzojK2JMGGErWflZ9rAZkbEOw8MTDA
Message-ID: <CAGxU2F6jSBM-VKU6vaojvBF_4zTWndmaQ4rFvLxds6gOPjXpcA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
To: Jason Wang <jasowang@redhat.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Keir Fraser <keirf@google.com>, Steven Moreland <smoreland@google.com>, 
	Frederick Mayle <fmayle@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jul 2025 at 11:10, Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jul 17, 2025 at 5:01=E2=80=AFPM Will Deacon <will@kernel.org> wro=
te:
> >
> > vhost_vsock_alloc_skb() returns NULL for packets advertising a length
> > larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However=
,
> > this is only checked once the SKB has been allocated and, if the length
> > in the packet header is zero, the SKB may not be freed immediately.
>
> Can this be triggered from the guest? (I guess yes) Did we need to
> consider it as a security issue?

Yep, but then the packet would still be discarded later, and the
memory released, so it can only increase the pressure on allocation,
but the guest can still do so by sending packets for example on an
unopened port.

Stefano

>
> >
> > Hoist the size check before the SKB allocation so that an iovec larger
> > than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
> > outright. The subsequent check on the length field in the header can
> > then simply check that the allocated SKB is indeed large enough to hold
> > the packet.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_bu=
ff")
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  drivers/vhost/vsock.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 802153e23073..66a0f060770e 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> >
> >         len =3D iov_length(vq->iov, out);
> >
> > +       if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEAD=
ROOM)
> > +               return NULL;
> > +
> >         /* len contains both payload and hdr */
> >         skb =3D virtio_vsock_alloc_skb(len, GFP_KERNEL);
> >         if (!skb)
> > @@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> >                 return skb;
> >
> >         /* The pkt is too big or the length in the header is invalid */
> > -       if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
> > -           payload_len + sizeof(*hdr) > len) {
> > +       if (payload_len + sizeof(*hdr) > len) {
> >                 kfree_skb(skb);
> >                 return NULL;
> >         }
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
>
> Thanks
>


