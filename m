Return-Path: <netdev+bounces-112492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E099397E9
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 03:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5EA11F221B9
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 01:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B62139587;
	Tue, 23 Jul 2024 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsGe2Ymp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686BE13699A
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 01:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698129; cv=none; b=q6RVPyQtN07Dzx7K0jGrVbUAxJaEhX4LqbmEsO4fryDkGhVYT65N3Y4dC/Gggr2HkcfOxqBYhSG9f+r8MxOPlWR156U7iO+FqM4EvKbrA6Hu1VzJ+xyv9CL9dBtvCNyNt91FomQmT+GNLzNqIOPnH4Uc9bNId7miAzlRDo1DzUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698129; c=relaxed/simple;
	bh=hmJv9NIRC+0TWcZWU6vysfnV1T9npK2Yd4rCz4I6KqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSwEPXRNqxRQqmhS4M85jMxBKFJlIPrhLJ4v5Dq5MsLUXr6tQ6gca9VdCoKjA1YeJ9TQIJ28JlKHmEnCfe3JaFFnX+5miTNxRbud87gR5CWhcoH/3GddAii3owLLpYw2oc91O/q5MgxOGv/czkmpRBGgHd4bky/CE7dIrsb+Ibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsGe2Ymp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721698126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2dPIatpVSHzVHBHYiz7SKefAqNEyf3yo6kuC1ZYdgc=;
	b=fsGe2YmpTjbbsDRHcW1iEfnJxHtROPSglJW8pSi/Lx+BEDpxBBzsIl8QWiO78D0eoXVs0W
	CuK25FiZC7OVFaugx4jWOn4JNMo5IP/yV8PNuVYyxfwxyVpeIwsMtPHM0/XJo/FUtIq/wN
	xGhllOqfVdw4gY6+40qvDH2sObGq/gc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-eVxnb8l5MGu3FQP_mXkSlw-1; Mon, 22 Jul 2024 21:28:42 -0400
X-MC-Unique: eVxnb8l5MGu3FQP_mXkSlw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb5594a9f3so3953093a91.1
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 18:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721698121; x=1722302921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2dPIatpVSHzVHBHYiz7SKefAqNEyf3yo6kuC1ZYdgc=;
        b=MipfeSdoOi5exh4T3TDekuKGv25RvWvp7R22GDYV4qBg+EiH4zw+ehMTZob/04Lct/
         1I+0fQjg+BRyb4dWfPe4ymm1ii1x8sa9ZzOXPOC1mrma9+Ij3/gUAdQovWmpBd5/ht+a
         22CEo73+U3zTAD4ohGbkgxwatwj0RlfXZQwj3FK/ZwbXMP4nhRhM6F39uqMjaoIKOQaz
         8cbnhhVBl1vss9Z1Rp3mWxXy5ZVnkmLmbWLD3+RQ2/FKWyWRK+hFCrs/yAVvfEaqM/ml
         9eXPHpBy+SeoHwXR+anHEaW9neEpzZeANJZkZ/atA2DJ1F5qDprEQH/vPZeVMX5Pkdys
         pKoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg8cg3tdUb7GWs6HfBQagPTPRer6qHvoDO+XEvazSgGErbaNlBnEbx1oOY4+FOy5rjXDHHeWYzYCSOo02oUAmxYg93AbVp
X-Gm-Message-State: AOJu0YwvvFCxu/s12EcoqhT8juL437ni0YS7TZakkN6xIGzcg1yQoRn+
	fHYR14iiXzptNN6Hzctb2f3o2YWRLzHGWiHqGVToP0QepyQy9WBBJjc1wDtkoQyvByCtwz1G+Ci
	/4oUgdFoJQ7emRo2556Ve8tYI1zTOsNNv4IhGnjpgMu8MoRJwE9BoV5+96bLFOe0zRCw8QHpjWh
	TfHQcetIQ6GHB576t2ZxTlXuEkKGtE
X-Received: by 2002:a17:90a:66cd:b0:2ca:a318:2729 with SMTP id 98e67ed59e1d1-2cd2751ca3cmr4555706a91.37.1721698121451;
        Mon, 22 Jul 2024 18:28:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm9l9yopQ8gKbnepufKwmhhZJViwYbJ+IaU9VHuP40/XlFCamg/GuB/7IU2kaDDEGgde0TY0jSAYiL6312qIo=
X-Received: by 2002:a17:90a:66cd:b0:2ca:a318:2729 with SMTP id
 98e67ed59e1d1-2cd2751ca3cmr4555689a91.37.1721698120961; Mon, 22 Jul 2024
 18:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
 <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
 <7a4d99e0f16cbe91000c3c780334a4c866904182.camel@nvidia.com>
 <CACLfguUR_hdJGDcjnmYY=qOXFiSnsBsXD5evTDZQi=K0RM4gZQ@mail.gmail.com> <CACLfguUWCY6MJkv+GuJ0W0t0Q0iX3fna+EjWxV5E=au9Oa5-aw@mail.gmail.com>
In-Reply-To: <CACLfguUWCY6MJkv+GuJ0W0t0Q0iX3fna+EjWxV5E=au9Oa5-aw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Jul 2024 09:28:28 +0800
Message-ID: <CACGkMEsapSx4Hk+2PcsenGzaBbJ2OKXde_onEb+8gZG9AMAX6A@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 10:48=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, 22 Jul 2024 at 20:55, Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Mon, 22 Jul 2024 at 17:45, Dragos Tatulea <dtatulea@nvidia.com> wrot=
e:
> > >
> > > On Mon, 2024-07-22 at 15:48 +0800, Jason Wang wrote:
> > > > On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> =
wrote:
> > > > >
> > > > > Add the function to support setting the MAC address.
> > > > > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > > > > to set the mac address
> > > > >
> > > > > Tested in ConnectX-6 Dx device
> > > > >
> > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > ---
> > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
> > > > >  1 file changed, 25 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx=
5/net/mlx5_vnet.c
> > > > > index ecfc16151d61..415b527a9c72 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa=
_mgmt_dev *v_mdev, struct vdpa_device *
> > > > >         destroy_workqueue(wq);
> > > > >         mgtdev->ndev =3D NULL;
> > > > >  }
> > > > > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > > > > +                             struct vdpa_device *dev,
> > > > > +                             const struct vdpa_dev_set_config *a=
dd_config)
> > > > > +{
> > > > > +       struct mlx5_vdpa_dev *mvdev;
> > > > > +       struct mlx5_vdpa_net *ndev;
> > > > > +       struct mlx5_core_dev *mdev;
> > > > > +       struct virtio_net_config *config;
> > > > > +       struct mlx5_core_dev *pfmdev;
> > > Reverse xmas tree?
> > >
> > will fix this
> > > > > +       int err =3D -EOPNOTSUPP;
> > > > > +
> > > > > +       mvdev =3D to_mvdev(dev);
> > > > > +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > > > > +       mdev =3D mvdev->mdev;
> > > > > +       config =3D &ndev->config;
> > > > > +
> > > You still need to take the ndev->reslock.
> > >
> > sure, will do
> > > > > +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADD=
R)) {
> > > > > +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev)=
);
> > > > > +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > > > > +               if (!err)
> > > > > +                       memcpy(config->mac, add_config->net.mac, =
ETH_ALEN);
> > > What is the expected behaviour when the device is in use?
> > >
> > if the err is 0 then copy the Mac address to config
> > will change this code to make it more clear
> > Thanks
> > Cindy
> sorry for the misunderstanding. The VDPA tool does not support
> changing the MAC address after the guest is loaded. I think I can add
> a check for VIRTIO_CONFIG_S_DRIVER_OK here?

Still racy, and I think we probably don't worry about that case. It's
the fault of the mgmt layer not us.

Thanks

> Thanks
> cindy
> > > > > +       }
> > > > > +       return err;
> > > >
> > > > Similar to net simulator, how could be serialize the modification t=
o
> > > > mac address:
> > > >
> > > > 1) from vdpa tool
> > > > 2) via control virtqueue
> > > >
> > > > Thanks
> > > >
> > > > > +}
> > > > >
> > > > >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> > > > >         .dev_add =3D mlx5_vdpa_dev_add,
> > > > >         .dev_del =3D mlx5_vdpa_dev_del,
> > > > > +       .dev_set_attr =3D mlx5_vdpa_set_attr,
> > > > >  };
> > > > >
> > > > >  static struct virtio_device_id id_table[] =3D {
> > > > > --
> > > > > 2.45.0
> > > > >
> > > >
> > > Thanks,
> > > Dragos
>


