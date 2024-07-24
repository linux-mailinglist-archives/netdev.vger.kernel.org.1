Return-Path: <netdev+bounces-112711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B5B93AAF5
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 04:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F762B223F6
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 02:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93B171BB;
	Wed, 24 Jul 2024 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2zUzfv5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6317758
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787203; cv=none; b=YJ8OReDSdBKkbcedFrtnwmi0eKKR7dDlSJx2HGsNN8dIHw6ZXhONIH+pGdZSHKBZsybuVX4cCz7Ojsi2iLLUJRx+lMVoQOQ0fdMAzMHjtJEjyBmIWd6aXGymGUcZCvojDDhqDTllUQzcRA8Rm5V4bEWFxfFbKIm7zls4Vq0nOSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787203; c=relaxed/simple;
	bh=aY2W229IPrwJpsVdE9grFLsD722tHQKjq+jC7vW2vuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThHJcUNdnYAGNV9VNGV37HMtu5j+3uFKY0ZaxRF9QMfKBJTcR1ro97H6raKzUv209vJChqhSBa3gr9KKD9dx7VshH6a4QyNxOj3tN39G+ij7qKcCdqKdmp5x0vbPkOo/zUk/7muxUeUmYDcjNtl10vfHH8lFVe+CJay+xDwUXwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2zUzfv5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721787201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpQmKrcQvwUzPm1WYMAhk6x806GQpIo0dxtm+FS0LQ4=;
	b=P2zUzfv53SvI+Ro6EfO9kHKN6bE/f2MGSdWAvwAj3Lopb0MZPrVv7cPQp1fFkhHT1bRQHm
	mwCEWegz8PFIZpAED/dnb7RXlHYAwriu+UhpynnHjeMFBsqshVGsFQkYNLuqcEesG8S/WL
	uPKb90PICxFwskfCRkZusDxpAiKE3Wo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-jpyf0iWQP0SANoZblzh3cw-1; Tue, 23 Jul 2024 22:13:18 -0400
X-MC-Unique: jpyf0iWQP0SANoZblzh3cw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f01bd7ad5eso20014251fa.2
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 19:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721787196; x=1722391996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpQmKrcQvwUzPm1WYMAhk6x806GQpIo0dxtm+FS0LQ4=;
        b=A+OuUXbNh5x+73PhJ2kokcV5zgVX8xS90HGwdXwf+moA0Zr8bd/xCzjztTK5UPvupr
         noWbKsSW1tVXZKWNfXw99+7JORV4AIA7h7wmkoGb02gyfkNn5PAriVeWm9AhBadqvTmo
         8Q31JfR90U/P+pQu3JgjpsA49Rxi4jOh8DPDOxu67VQTyQiycTZuApkI+4+QEs59XCsw
         P1CCixsW3nthkz/w4imQwUhRsQ97IqMkOmyHNuVzuJmJGTyJyOYCHJ+MQXi/KlhP9Thk
         E5UNNLFckuQeiPSwInN0NZbbsIWIneSDPimqdk7/1Xx0Ch4GKOwD3FG3zxCQoTB6CLm4
         SeWg==
X-Forwarded-Encrypted: i=1; AJvYcCVZSTx5tR1bc4cXvg87PNXeTqTRGB59Mtp6qJb0ZHEOnyDh7jbBSa3pmZgPtTfYoSZLdeXIZidXWqqekhFWDtwBplpSa90K
X-Gm-Message-State: AOJu0Yz4vYRpDzqqht0WdrNpkfWyIx9EHy5sBIbXhd0UYLVwTrp+dYpA
	vbAE7POkgYhvblI+rG8lxq+Msy/9c6Cp8/3VLdY8f/o8LogSRpldZKVi40Bz9cMQsWIhXl7rueA
	Kpax78O9O35UOu1hjnK97FJQEqQV42fylGXufvTHMzv0xzMB4ALM4tjpxSVm/gyMqRvaMT5WqqD
	NFKsQ6yBHjvX6AOfmkBfi9khn221Tx
X-Received: by 2002:a2e:7012:0:b0:2ef:284e:1d07 with SMTP id 38308e7fff4ca-2ef284e20edmr67226851fa.13.1721787196496;
        Tue, 23 Jul 2024 19:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfe+PSFOuw1GOx0ba6wih32b5Q24TWF2YXgMjSQkS2m3HAbcXqAiQFID2J6XbwaqHY0X71rjwNpHYBoZFbDPg=
X-Received: by 2002:a2e:7012:0:b0:2ef:284e:1d07 with SMTP id
 38308e7fff4ca-2ef284e20edmr67226751fa.13.1721787196155; Tue, 23 Jul 2024
 19:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <20240723054047.1059994-4-lulu@redhat.com>
 <d8031e518cf47c57c31b903cb9613692bbff7d0d.camel@nvidia.com> <20240723072712-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240723072712-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 24 Jul 2024 10:12:39 +0800
Message-ID: <CACLfguV53JA9Lk_sTr+ug_x+JDxTr3S3rOcjVQVDy7tkL_B--A@mail.gmail.com>
Subject: Re: [PATH v5 3/3] vdpa/mlx5: Add the support of set mac address
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	"sgarzare@redhat.com" <sgarzare@redhat.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jul 2024 at 19:29, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jul 23, 2024 at 07:49:44AM +0000, Dragos Tatulea wrote:
> > On Tue, 2024-07-23 at 13:39 +0800, Cindy Lu wrote:
> > > Add the function to support setting the MAC address.
> > > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > > to set the mac address
> > >
> > > Tested in ConnectX-6 Dx device
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/ne=
t/mlx5_vnet.c
> > > index ecfc16151d61..7fce952d650f 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -3785,10 +3785,38 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgm=
t_dev *v_mdev, struct vdpa_device *
> > >     destroy_workqueue(wq);
> > >     mgtdev->ndev =3D NULL;
> > >  }
> > > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > > +                         struct vdpa_device *dev,
> > > +                         const struct vdpa_dev_set_config *add_confi=
g)
> > > +{
> > > +   struct virtio_net_config *config;
> > > +   struct mlx5_core_dev *pfmdev;
> > > +   struct mlx5_vdpa_dev *mvdev;
> > > +   struct mlx5_vdpa_net *ndev;
> > > +   struct mlx5_core_dev *mdev;
> > > +   int err =3D -EINVAL;
> > > +
> > > +   mvdev =3D to_mvdev(dev);
> > > +   ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > > +   mdev =3D mvdev->mdev;
> > > +   config =3D &ndev->config;
> > > +
> > > +   down_write(&ndev->reslock);
> > > +   if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > > +           pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > > +           err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > > +           if (0 =3D=3D err)
> > if (!err) would be nicer. Not a deal breaker though.
>
>         yes, no yodda style please. It, I can not stand.
>
sure=EF=BC=8C Will fix this
Thanks
cindy
>
> > Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> >
> > > +                   memcpy(config->mac, add_config->net.mac, ETH_ALEN=
);
> > > +   }
> > > +
> > > +   up_write(&ndev->reslock);
> > > +   return err;
> > > +}
> > >
> > >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> > >     .dev_add =3D mlx5_vdpa_dev_add,
> > >     .dev_del =3D mlx5_vdpa_dev_del,
> > > +   .dev_set_attr =3D mlx5_vdpa_set_attr,
> > >  };
> > >
> > >  static struct virtio_device_id id_table[] =3D {
> >
>


