Return-Path: <netdev+bounces-109741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD537929CFC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5F628164F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 07:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2B18EB1;
	Mon,  8 Jul 2024 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRilljeW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C14C224E8
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423154; cv=none; b=aigLdyaigR4XCyToovuQ/94ezsaYballOInZHBzDOQL3ZY6M529C0MuDmBbVKkBy+eqvhaVdaNV5P2B4QjYx83Kla8AM/c2A37ob3YvNK6Wj0vdWGvdpcWZn5DCiMaEsOM+UT+EYgvNIhGw1MPnQaGxb10VYXs1ynAo9F0zkq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423154; c=relaxed/simple;
	bh=BCpNb63WRewgJB37gIEoqo5egyIJUDlpbkKJgwO8OHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtrqbRAR5vgjhlRCGgNXTWfaoZVoefjjDWlUpiNL4SygqBOS/66bZeA7rWZYUIeEuiIK4P2LLyg+xDoYLHud/eTyiunoKpFLn1c289YaWOGcha78R+chjuBIKB6X56hgUI36RCuL+cdtMIOdgtXL8nY/V9u26NzoxCg9Dfg3jKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRilljeW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720423151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jqM73JSLXU66f0uRVT9WU+gkf5AyrsxUM3dUDMhxBT4=;
	b=MRilljeWXPZxeqBhAcYW+XPuVMcvo9jjJ/nufLr8Vc/WmxGsPpEfEVfB5tvyM4CK6grd9q
	BNgmLxSqPxZBpEVFZu7XkBja50dz/2L9VBmlNM+lWDx+uooH9CDblGQBleLGzJwnV/Y3tZ
	CK6g48/14a6OXv0Li8GtkpPz/z1GEvc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-oiJTgphRP_-FJBaEKVPWbw-1; Mon, 08 Jul 2024 03:19:09 -0400
X-MC-Unique: oiJTgphRP_-FJBaEKVPWbw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a77dbdc2cf6so152036366b.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 00:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720423148; x=1721027948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqM73JSLXU66f0uRVT9WU+gkf5AyrsxUM3dUDMhxBT4=;
        b=BRWkJ4PNjBrmdJhYReiXeyfYcxrPk2sTsPi6wbse2BUViN3SGoOJFwO7GI9HC6xF4M
         Sc4RHkqR98P5AAjiFuUhQrzXJTvKj27pNU7xJd5ZBsG/Nus/sCHOcstsoG9/Y1pUAlRL
         7dEbZhdB9lOcgC+Xe24hXOqCJDHkXEK9ySMwAC/2nhruyyoZX5g+FUU/8jBc3Iw9pGLb
         Q3+K6dQx01vGr29U4KivwK2J5Oj9G1zeNMarcwii+nrG0i0wBXFuZmfZIuC65Rn2+ZN2
         8ZrM/K+KunqsoKFmTfwgAZmyM+QJKWCgiheOgRDnm5n8zbrEXvSNqiXDXVjLPq5cX1vj
         ustg==
X-Forwarded-Encrypted: i=1; AJvYcCW87u6CuQdA20wAPYfxsiDDDKUtz7LZ/Owhzwv1LI3vylm3AqHnqEClzWK2C12Nz2lhFLb4towdRyINJTdxOIwUxqOsWzMm
X-Gm-Message-State: AOJu0YzH5vNp2G0/6h1X7asTlQZ8hHWq/hC88HhqH8w70XYV60P0rsIY
	s3SOK2yM7LAxZrXqBpoYbzKiOQRZGIw7gpc6IfzdSTiKf0oBEDcI+7SuNq+YaMENNxoiW5Q3Vex
	FkxnY4S9lrL56q+yfHKSRKgaow1f2Q+SybnOqT2zBoLzUoR9da9fSnmD3p03UrYhF4P1pEaDtDm
	GUk2yJsMFj6IU/oNy63ID/cuhojU6H
X-Received: by 2002:a17:906:175b:b0:a77:a630:cf89 with SMTP id a640c23a62f3a-a77b9dee79dmr706514866b.0.1720423148321;
        Mon, 08 Jul 2024 00:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGUu1W6MyDpHHXhXDXEq+4hte1tFdv4eIOo7asqiTd/PZmPPhD5t+yUjE3Q9R2KpY/v0HSjx6vJ4Xu91Rb1yY=
X-Received: by 2002:a17:906:175b:b0:a77:a630:cf89 with SMTP id
 a640c23a62f3a-a77b9dee79dmr706512466b.0.1720423147970; Mon, 08 Jul 2024
 00:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <20240708064820.88955-3-lulu@redhat.com>
 <CACGkMEum7Ufgkez9p4-o9tfYBqfvPUA+BPrxZD8gF7PmWVhE2g@mail.gmail.com>
In-Reply-To: <CACGkMEum7Ufgkez9p4-o9tfYBqfvPUA+BPrxZD8gF7PmWVhE2g@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 8 Jul 2024 15:18:31 +0800
Message-ID: <CACLfguXdL_FvdvReQrzvKvzJrHnE9gcTv+rLYsCNB0HtvXC74w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vdpa_sim_net: Add the support of set mac address
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024 at 15:06, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Jul 8, 2024 at 2:48=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the function to support setting the MAC address.
> > For vdpa_sim_net, the driver will write the MAC address
> > to the config space, and other devices can implement
> > their own functions to support this.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_s=
im/vdpa_sim_net.c
> > index cfe962911804..a472c3c43bfd 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -414,6 +414,22 @@ static void vdpasim_net_get_config(struct vdpasim =
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
> > +
> > +       struct virtio_net_config *vio_config =3D vdpasim->config;
> > +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +               if (!is_zero_ether_addr(config->net.mac)) {
> > +                       memcpy(vio_config->mac, config->net.mac, ETH_AL=
EN);
> > +                       return 0;
> > +               }
> > +       }
> > +       return -EINVAL;
>
> I think in the previous version, we agreed to have a lock to
> synchronize the writing here?
>
> Thanks
>
Hi Jason
I have moved the down_write(&vdev->cf_lock) and
up_write(&vdev->cf_lock) to the function vdpa_dev_net_device_attr_set
in vdpa/vdpa.c. Then the device itself doesn't need to call it again.
Do you think this is ok?
Thanks
Cindy
> > +}
> > +
> >  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
> >                                      const struct vdpa_dev_set_config *=
config)
> >  {
> > @@ -510,7 +526,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_de=
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


