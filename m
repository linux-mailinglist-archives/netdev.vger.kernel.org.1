Return-Path: <netdev+bounces-112373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E62C938A8A
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 09:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8681C20F1F
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 07:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED41607B2;
	Mon, 22 Jul 2024 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjg/kFvT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0A1607B3
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721635042; cv=none; b=gJk8t3L1gimEd+7jLdn+KTNuDEn/u+Nr3zJcqesByTnil+9QVyrwORzS9srDN8xgSKLKC8xHcTM9QxPAmwXEF592gO2Di/5GWQU8ax40eWj7/XdbdRXgMAwNp0mkdtE+UyX/oTqyk35SslDdIj3fTD5UTjQBOi9XvYRG4YM5B7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721635042; c=relaxed/simple;
	bh=HWNPQ/1vUrq7iKlpWAUp1cUMrSt4KvhLV953piOX8g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SooXmjpRrS4zw9BJcIvgkyzbVwnxedqFfB0OF97qNIB18jD2m+3fjSDnSBRiCNgEcEv51mfS5suRNK0I/954XnJJ0WJ7OS/u1r9MwMNM1bLsCJ+Lzxt0KzkQoCWGboWFGr9TepFMUm3GHsWBbUppNoMAkklWcamMw9iUW3cJxS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjg/kFvT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721635038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQEopZwHga4C7qzVJPruzVlevn1Kn/ATvarPGUPiBhY=;
	b=gjg/kFvTrkQVmSalBfgCMjsw1Z628iwt+5gl/V9lMmyMu2L68mNFYKEvDcvg3MYw//be9l
	svCu7LWRcMGnvVd5H56ipgVwnUvX2tffBNwW8FS5c8t9E7xAU+U4EQghM9EegfzTbikCoo
	731QFpOfj40P1CVxdN4Kw1LvwPENiSI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-We9YOSvhP0WQzJlxXdW1WA-1; Mon, 22 Jul 2024 03:57:16 -0400
X-MC-Unique: We9YOSvhP0WQzJlxXdW1WA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef311ad4bcso4975471fa.0
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 00:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721635035; x=1722239835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQEopZwHga4C7qzVJPruzVlevn1Kn/ATvarPGUPiBhY=;
        b=XzcM0Y4drbuHRHLAnNTHn4OqXJjXD/Pjv7iFDH+CiZj180IssA/cAJSa8C/xmtbkXY
         rHBAT9M9fNyBUpPyBooDcZ0nqI0GDJ4b3LHCDJMySYhXOXyn4cVwCWAY/7poiYmcLUEq
         FOv3dFD7b33K3GUx9RmdDmQb7CA95LL0JzVKUaXOiBBAIUUFos4fqRlMIGlCwe1amJ+p
         Xu6RgHNm28WHS66H1m4YDaNImOXQVGj+ZH0UQK/CNM7fXPjLo8NWYDwgdxMoYVzaXhIG
         JT9TetIA/oifOBywjcLHblQMYKheqpDYn7b6V3edAxcmEAS908tsf7rpZ0j1KHjfQaPr
         jraQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPIPfOivjvFYoy+ZvjFGKKhUPd8ra5eBBPnZ/NRZh2NsdyLjgoPV2rUymtZ0X+Uyic1hqWZMQm5Y+kwj5AjtFZLipMCH2M
X-Gm-Message-State: AOJu0Yz+YuYj83o2NgHpZPKjWVamo6zJNHHSxaPZbHsfUqYI1hEuvFW9
	rozw6VLui+5RfXiZzQfv+UMZGwCJ7CG4UVVveNY48LyOR/wgurSbBqmK+LE0nBqo1T/sp6FOwDk
	i9lHDym2QY7udV95h2tmwBjMFsQOZLaSjLs3SBr7KdjeyJ+uhlCRpB10PdJKThyM0Qf2MThvvcx
	WjwnCq20P09o8VxjlP2+67kAhj/iIl
X-Received: by 2002:a05:651c:50d:b0:2ef:17ee:62b0 with SMTP id 38308e7fff4ca-2ef17ee6747mr44078061fa.2.1721635035151;
        Mon, 22 Jul 2024 00:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYfWrHNz6DUflgtw/ZcTjXibd8jwa6+RV9ykMQ9YOOIBFKj5ChXg/RudR/hIBIlgmdHIluX8YxfscwNFeCP2U=
X-Received: by 2002:a05:651c:50d:b0:2ef:17ee:62b0 with SMTP id
 38308e7fff4ca-2ef17ee6747mr44077821fa.2.1721635034786; Mon, 22 Jul 2024
 00:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-3-lulu@redhat.com>
 <CACGkMEtq=2yO=4te+qQxwSzi4G-4E_kdq=tCQq_N94Pk8Ro3Zw@mail.gmail.com>
In-Reply-To: <CACGkMEtq=2yO=4te+qQxwSzi4G-4E_kdq=tCQq_N94Pk8Ro3Zw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 22 Jul 2024 15:56:38 +0800
Message-ID: <CACLfguUaDo3seJZT_yQNp_fa4bELHwwAb8OTbXGwBLw2fGdj+w@mail.gmail.com>
Subject: Re: [PATH v4 2/3] vdpa_sim_net: Add the support of set mac address
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2024 at 15:48, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the function to support setting the MAC address.
> > For vdpa_sim_net, the driver will write the MAC address
> > to the config space, and other devices can implement
> > their own functions to support this.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_s=
im/vdpa_sim_net.c
> > index cfe962911804..936e33e5021a 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -414,6 +414,25 @@ static void vdpasim_net_get_config(struct vdpasim =
*vdpasim, void *config)
> >         net_config->status =3D cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_L=
INK_UP);
> >  }
> >
> > +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
> > +                               struct vdpa_device *dev,
> > +                               const struct vdpa_dev_set_config *confi=
g)
> > +{
> > +       struct vdpasim *vdpasim =3D container_of(dev, struct vdpasim, v=
dpa);
> > +       struct virtio_net_config *vio_config =3D vdpasim->config;
> > +
> > +       mutex_lock(&vdpasim->mutex);
> > +
> > +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +               memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
> > +               mutex_unlock(&vdpasim->mutex);
> > +               return 0;
> > +       }
> > +
> > +       mutex_unlock(&vdpasim->mutex);
>
> Do we need to protect:
>
>         case VIRTIO_NET_CTRL_MAC_ADDR_SET:
> read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov,
>                                              vio_config->mac, ETH_ALEN);
>                 if (read =3D=3D ETH_ALEN)
>                         status =3D VIRTIO_NET_OK;
>                 break;
>
> As both are modifying vio_config?
>
> Thanks
>
i have added a lock for this; CVQ also needs to take this lock to
change the MAC address.I thinks maybe this can protect?
Do you mean I need to compare the mac address from the vdpa_tool and
mac address in vio_config?
this vdpa tool should not be used after the guest load, if this is
different this is also acceptable
thanks
Cindy

> > +       return -EINVAL;
> > +}
> > +
> >  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
> >                                      const struct vdpa_dev_set_config *=
config)
> >  {
> > @@ -510,7 +529,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_de=
v *mdev,
> >
> >  static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops =3D {
> >         .dev_add =3D vdpasim_net_dev_add,
> > -       .dev_del =3D vdpasim_net_dev_del
> > +       .dev_del =3D vdpasim_net_dev_del,
> > +       .dev_set_attr =3D vdpasim_net_set_attr
> >  };
> >
> >  static struct virtio_device_id id_table[] =3D {
> > --
> > 2.45.0
> >
>


