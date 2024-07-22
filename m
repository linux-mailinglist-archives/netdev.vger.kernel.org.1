Return-Path: <netdev+bounces-112431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CB29390F0
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 16:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFF028202F
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 14:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3746516D9D7;
	Mon, 22 Jul 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrHBdpOs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F59216B74D
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659722; cv=none; b=IkVX64ptVzp49++BZOcXaYDm2Rt3B/TJ6xD6YOWBlUU0FKJd8FG5ZnjaJOE45e4UI45wYkv9+p2gSO6rWIUV3hZKHozKhJfU6z/nUiijLIE8dXfgCG/C5hSK5lxZLdmrn/Xelar1LAp8EodqaywfUZxW9HBAyxVdhPl0sFd0rZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659722; c=relaxed/simple;
	bh=SRMrkfOnPx+rdqmniL6jFNVCQL1r+Ntj8w9xuWb9BDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTyW7Q68UUadl8rKHkUkrrj53LTxRaJTwS5mpQihfUWTLZQLcLVnvzysmfWITsIXDE2q7Ra+xD9PQ6Cmx25+P6gtHDxTr7zgskuK03xVUqdq/lCb7/CmNuMMDULyTR0/demcRQM8sv2uHKwSHGEz0BlZ/N6VKo3n2smuCW980yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NrHBdpOs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721659719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nL1b6Ct+0A4PYkkgWT+fmhmustvbQO/NjEYepCrpRbI=;
	b=NrHBdpOsU5QhrADlgiCf8ru+RlLaV+yUzPGIaRl+SINZLb8upeyoWQ80azpyKHl3Ew5rVQ
	l1Y16LVFTNv4TBKnOaNpU4pT0StI2n9LWmt6K/PqGhrzIxTUV6yjxRA9nKKSb45TuM42vD
	sJ1xTo0vA+atNIG7GUZVfTRvTLYtJLQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-OcjH3_KmNrOqZ7lI3I2bYg-1; Mon, 22 Jul 2024 10:48:37 -0400
X-MC-Unique: OcjH3_KmNrOqZ7lI3I2bYg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7a8a38a4bcso47766b.0
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 07:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721659717; x=1722264517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL1b6Ct+0A4PYkkgWT+fmhmustvbQO/NjEYepCrpRbI=;
        b=GVs5QmIv8iT2rP1EKnlPCE57E7Z8v0LgsgLNL19h8gAjLM8iv/CQ4UYxzmXmICSgvT
         0OL2624VK7hZpoBMuFyK4940p8Xb2LUly7uZwEI+aS6HDcdRpmVqmIonn4aWOFi9VU3U
         0lLHt0G23yGk6Z4M6XoLSeAHQucNKPzhWtD4XYg4mPUgQkD8HeE80TG8CP/kDc+cfzNW
         KzZquYYV2Ts/r+pTtLeckLygfEfeBb2NdmpF7TOibLwbnd0VRqhzP5gJ7tvRPlyF/igd
         uIPH3XLsWJ3mpFpa0GwnWe8IMX8dC+gmEKUkYDUP1s81z0QbgmtESpXAMh+zewMNoLw1
         dCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMS2uwwPCW6zVpwFid4N1ZRkxJbkiIh0SpPqR2NjUI1+0HX6eCIR4UbF1NL02mbhqSTpNWM2yP4niGW8QLzCRJPE9JEt6r
X-Gm-Message-State: AOJu0YwKFbe7DvQZ43R4huEP1ErCByG7EknqQ5cuWLKCc9pYi1hQlr8t
	P3M1S6vBfjyjmXYz0XdiIKN24fHqhMUvuo3fJydvZ+nbGnG9R1D5mVHbNEwc/9MYWPLtiNy8i5c
	00uGYCo9KUse5taqz+I8v4Mgb6e6ILxDDeZmajye9cemqEt8KDeEx15JgJfFifCaJUouLxIgbxJ
	ZkF++qSiLmbhyoYeBMN39IWC1C4rwL
X-Received: by 2002:a50:9553:0:b0:5a2:8f7d:aff4 with SMTP id 4fb4d7f45d1cf-5a479b729b2mr5750880a12.20.1721659716748;
        Mon, 22 Jul 2024 07:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEujzFQkDOMoSemOi9mGgKDIm+sW5uf5B+Pv1IsMJHgXi5lCcdZ5DbGYJL+6Dv+saxv4yTrO0gB7p3Li0CuUg=
X-Received: by 2002:a50:9553:0:b0:5a2:8f7d:aff4 with SMTP id
 4fb4d7f45d1cf-5a479b729b2mr5750863a12.20.1721659716425; Mon, 22 Jul 2024
 07:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
 <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
 <7a4d99e0f16cbe91000c3c780334a4c866904182.camel@nvidia.com> <CACLfguUR_hdJGDcjnmYY=qOXFiSnsBsXD5evTDZQi=K0RM4gZQ@mail.gmail.com>
In-Reply-To: <CACLfguUR_hdJGDcjnmYY=qOXFiSnsBsXD5evTDZQi=K0RM4gZQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 22 Jul 2024 22:47:57 +0800
Message-ID: <CACLfguUWCY6MJkv+GuJ0W0t0Q0iX3fna+EjWxV5E=au9Oa5-aw@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2024 at 20:55, Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, 22 Jul 2024 at 17:45, Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> > On Mon, 2024-07-22 at 15:48 +0800, Jason Wang wrote:
> > > On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wr=
ote:
> > > >
> > > > Add the function to support setting the MAC address.
> > > > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > > > to set the mac address
> > > >
> > > > Tested in ConnectX-6 Dx device
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > ---
> > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
> > > >  1 file changed, 25 insertions(+)
> > > >
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/=
net/mlx5_vnet.c
> > > > index ecfc16151d61..415b527a9c72 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa_m=
gmt_dev *v_mdev, struct vdpa_device *
> > > >         destroy_workqueue(wq);
> > > >         mgtdev->ndev =3D NULL;
> > > >  }
> > > > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > > > +                             struct vdpa_device *dev,
> > > > +                             const struct vdpa_dev_set_config *add=
_config)
> > > > +{
> > > > +       struct mlx5_vdpa_dev *mvdev;
> > > > +       struct mlx5_vdpa_net *ndev;
> > > > +       struct mlx5_core_dev *mdev;
> > > > +       struct virtio_net_config *config;
> > > > +       struct mlx5_core_dev *pfmdev;
> > Reverse xmas tree?
> >
> will fix this
> > > > +       int err =3D -EOPNOTSUPP;
> > > > +
> > > > +       mvdev =3D to_mvdev(dev);
> > > > +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > > > +       mdev =3D mvdev->mdev;
> > > > +       config =3D &ndev->config;
> > > > +
> > You still need to take the ndev->reslock.
> >
> sure, will do
> > > > +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)=
) {
> > > > +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > > > +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > > > +               if (!err)
> > > > +                       memcpy(config->mac, add_config->net.mac, ET=
H_ALEN);
> > What is the expected behaviour when the device is in use?
> >
> if the err is 0 then copy the Mac address to config
> will change this code to make it more clear
> Thanks
> Cindy
sorry for the misunderstanding. The VDPA tool does not support
changing the MAC address after the guest is loaded. I think I can add
a check for VIRTIO_CONFIG_S_DRIVER_OK here?
Thanks
cindy
> > > > +       }
> > > > +       return err;
> > >
> > > Similar to net simulator, how could be serialize the modification to
> > > mac address:
> > >
> > > 1) from vdpa tool
> > > 2) via control virtqueue
> > >
> > > Thanks
> > >
> > > > +}
> > > >
> > > >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> > > >         .dev_add =3D mlx5_vdpa_dev_add,
> > > >         .dev_del =3D mlx5_vdpa_dev_del,
> > > > +       .dev_set_attr =3D mlx5_vdpa_set_attr,
> > > >  };
> > > >
> > > >  static struct virtio_device_id id_table[] =3D {
> > > > --
> > > > 2.45.0
> > > >
> > >
> > Thanks,
> > Dragos


