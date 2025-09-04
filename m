Return-Path: <netdev+bounces-219791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C56B42FFC
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 04:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C801B21C99
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34B01C7017;
	Thu,  4 Sep 2025 02:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIQNRML0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BCE3C01
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954069; cv=none; b=hX+8h1KdMai858XrMPboG/7HiC0Jci7G4CmkXFAF/bteK5W4fJ36HGtl0+nawiRosUB6SyKbS17HwEVZYJOaWCWG/55gNFG0GlMBcPmcqJY6TkctKuitGBBgXwXRVkXScRzVgW/fG/PgWZF9EbSsK/g8JpM3J275rBO4nzk5DDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954069; c=relaxed/simple;
	bh=Jq8qiDws42tS3DgBZxRymrwfYw1lrOAh8NEvTO9bXLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5/54JeinNNZwPG2RWN1MMkmiQtsFXP6UOL0okIqINrCrKqEXWTqR4ubmfYGKyJ8+kTlrEhlLR5ydvRBoYsmkTUXXisAMSkOZgUNGdljhgD/LZ5t8PYm161uknuuTjxF9OGdBgp0f2Cu9+ELhn8HiI3O07GWchEe3MAcLEqyJSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIQNRML0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756954066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPuBzO5sFF7pz/Em0FpS2T39kkMf6PUBGHFAt6g8pC0=;
	b=DIQNRML0K4gJ5c5RrfgMXMceuXevmT50ufiGAmwbWB7ZxN75uiDzpGKruszlbtcjFNQqJc
	YlGSlPGNrb3lUK9HaV3fxtwNUMvHCMHS9gfKcMHGByBBhde77eqUz8YLqSGHjfy6VbqKQd
	NlOauNhC9OE91v7sEhYJ1jnW/pxQqTE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-N86LtqJSP7m0cVVvOlxdUw-1; Wed, 03 Sep 2025 22:47:45 -0400
X-MC-Unique: N86LtqJSP7m0cVVvOlxdUw-1
X-Mimecast-MFC-AGG-ID: N86LtqJSP7m0cVVvOlxdUw_1756954065
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-324e41e946eso799009a91.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 19:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756954065; x=1757558865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPuBzO5sFF7pz/Em0FpS2T39kkMf6PUBGHFAt6g8pC0=;
        b=r2OXpen3IZAr856K1tJORkmXfYGOolkNyfGTW1qv4xpdpV9rqjK5L9cs28dV5ZNwOc
         aWSCFk1MZywEADsWFSLCNLxgakr9NtzCm6Dx6Y5G5iLF2Y9fHj81TmaEO/Srnb8SvAgX
         eiu7sxrNzh1H4Ta7AbK3gWPUZtrnCbANHARHnDWDwMsp3E/6usOsoxVtrDFB6DwjOpN9
         ADJKnpC6T5yDx+0D6dN874b6rg4NnRFhZWR1irgOkXpYgq0u4NTyvtFRSj7oHMjSWwl+
         BdEhychiv6ZzhcHvV9wXqpeLKVJLAPcbhtSkfZaN9kJ510RogYE5XVur45Kx3Vcu6h0k
         hZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW40d0vJh+ZxCjVL5hw+qqf1AeZ0VZS7/EpV0rwq55OxzNRm4nFZoa1GLyLdCHOBakevV5MAi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Mbzu+Qb55xBs4he83C38DmYGipwvw2081L191NtA5L+s92WF
	FCNgZkvBSSJAeF0tWFOxQsOLAAfTqSsElC+tF2wfIueho94pr4MXhzIUnioZL78djm6DLmC9O0H
	QISfhQmAfS6bkbbzD7aqu2jvHtUrJZqzBoTjaRsZJqL9QykAHx6SRx5FA3YgHRGe14ZCDMSt0+j
	+ZSueGkXR1U5ojerUQ7DNMHfbKgOwDh5sD
X-Gm-Gg: ASbGncsRZDxXYfNm4yxL0t519zqihiE8HSPLG2lUDszHnICll2C5F1BqHEceYjUa0P3
	d8xIzQr92Za0O0sDpLQwslSkEQess7XYAkbh3dIL0ulhMSSYuCyZisdFsPqnFamDjQz6gtaKZ20
	lmCCX+UFGwVABWiF6GVxI=
X-Received: by 2002:a17:90b:2ecc:b0:329:e3dc:db6c with SMTP id 98e67ed59e1d1-329e3dcdc0bmr10993115a91.23.1756954064577;
        Wed, 03 Sep 2025 19:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkDHqgDH/M72TzEiUNO4/wpezo4wquRaQJWXdohPpca0lZdT3tIFYzQxV00AK8Pp2pJZe1TcsVp6WvFKCncjI=
X-Received: by 2002:a17:90b:2ecc:b0:329:e3dc:db6c with SMTP id
 98e67ed59e1d1-329e3dcdc0bmr10993085a91.23.1756954064125; Wed, 03 Sep 2025
 19:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
 <20250902080957.47265-5-simon.schippers@tu-dortmund.de> <willemdebruijn.kernel.251eacee11eca@gmail.com>
 <CACGkMEshZGJfh+Og_xrPeZYoWkBAcvqW8e93_DCr7ix4oOaP8Q@mail.gmail.com> <willemdebruijn.kernel.372e97487ad8b@gmail.com>
In-Reply-To: <willemdebruijn.kernel.372e97487ad8b@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Sep 2025 10:47:30 +0800
X-Gm-Features: Ac12FXxK8G6F5K9kP9hZAbVWxKTcqMiuodU5d2Yu_6h48rhPlNy4xjY3e_hnfFc
Message-ID: <CACGkMEtv+TKu+yBc_+WQsUj3UKqrRPvOVMGFDr7mB3zPHsW=wQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] netdev queue flow control for vhost_net
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, mst@redhat.com, eperezma@redhat.com, 
	stephen@networkplumber.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, Tim Gebauer <tim.gebauer@tu-dortmund.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 9:52=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Wang wrote:
> > On Wed, Sep 3, 2025 at 5:31=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Simon Schippers wrote:
> > > > Stopping the queue is done in tun_net_xmit.
> > > >
> > > > Waking the queue is done by calling one of the helpers,
> > > > tun_wake_netdev_queue and tap_wake_netdev_queue. For that, in
> > > > get_wake_netdev_queue, the correct method is determined and saved i=
n the
> > > > function pointer wake_netdev_queue of the vhost_net_virtqueue. Then=
, each
> > > > time after consuming a batch in vhost_net_buf_produce, wake_netdev_=
queue
> > > > is called.
> > > >
> > > > Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > > > Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > > > Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > > > ---
> > > >  drivers/net/tap.c      |  6 ++++++
> > > >  drivers/net/tun.c      |  6 ++++++
> > > >  drivers/vhost/net.c    | 34 ++++++++++++++++++++++++++++------
> > > >  include/linux/if_tap.h |  2 ++
> > > >  include/linux/if_tun.h |  3 +++
> > > >  5 files changed, 45 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > > > index 4d874672bcd7..0bad9e3d59af 100644
> > > > --- a/drivers/net/tap.c
> > > > +++ b/drivers/net/tap.c
> > > > @@ -1198,6 +1198,12 @@ struct socket *tap_get_socket(struct file *f=
ile)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(tap_get_socket);
> > > >
> > > > +void tap_wake_netdev_queue(struct file *file)
> > > > +{
> > > > +     wake_netdev_queue(file->private_data);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(tap_wake_netdev_queue);
> > > > +
> > > >  struct ptr_ring *tap_get_ptr_ring(struct file *file)
> > > >  {
> > > >       struct tap_queue *q;
> > > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > > index 735498e221d8..e85589b596ac 100644
> > > > --- a/drivers/net/tun.c
> > > > +++ b/drivers/net/tun.c
> > > > @@ -3739,6 +3739,12 @@ struct socket *tun_get_socket(struct file *f=
ile)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(tun_get_socket);
> > > >
> > > > +void tun_wake_netdev_queue(struct file *file)
> > > > +{
> > > > +     wake_netdev_queue(file->private_data);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(tun_wake_netdev_queue);
> > >
> > > Having multiple functions with the same name is tad annoying from a
> > > cscape PoV, better to call the internal functions
> > > __tun_wake_netdev_queue, etc.
> > >
> > > > +
> > > >  struct ptr_ring *tun_get_tx_ring(struct file *file)
> > > >  {
> > > >       struct tun_file *tfile;
> > > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > > index 6edac0c1ba9b..e837d3a334f1 100644
> > > > --- a/drivers/vhost/net.c
> > > > +++ b/drivers/vhost/net.c
> > > > @@ -130,6 +130,7 @@ struct vhost_net_virtqueue {
> > > >       struct vhost_net_buf rxq;
> > > >       /* Batched XDP buffs */
> > > >       struct xdp_buff *xdp;
> > > > +     void (*wake_netdev_queue)(struct file *f);
> > >
> > > Indirect function calls are expensive post spectre. Probably
> > > preferable to just have a branch.
> > >
> > > A branch in `file->f_op !=3D &tun_fops` would be expensive still as i=
t
> > > may touch a cold cacheline.
> > >
> > > How about adding a bit in struct ptr_ring itself. Pahole shows plenty
> > > of holes. Jason, WDYT?
> > >
> >
> > I'm not sure I get the idea, did you mean a bit for classifying TUN
> > and TAP? If this is, I'm not sure it's a good idea as ptr_ring should
> > have no knowledge of its user.
>
> That is what I meant.
>
> > Consider there were still indirect calls to sock->ops, maybe we can
> > start from the branch.
>
> What do you mean?
>
> Tangential: if indirect calls really are needed in a hot path, e.g.,
> to maintain this isolation of ptr_ring from its users, then
> INDIRECT_CALL wrappers can be used to avoid the cost.
>
> That too effectively breaks the isolation between caller and callee.
> But only for the most important N callers that are listed in the
> INDIRECT_CALL_? wrapper.

Yes, I mean we can try to store the flag for example vhost_virtqueue struct=
.

Thanks

>


