Return-Path: <netdev+bounces-112417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F86938F63
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 14:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B8CCB20ADB
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 12:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE6916CD24;
	Mon, 22 Jul 2024 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQrhZL7d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07116A399
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652817; cv=none; b=Qiu1soAM4euIQnWIeFjYycGxPmBZn1JP44CelrXTZHtvuvRgs0czTYvtvnWGyOd4NXHra5NZdSyMEGUt/7mIQNWTq1LcPJPKuGurxn+2/iMZayklStJu/nIOKIyfqHgDWjVNAhYJO8EQ+/uX8KMjzheQCFsSHuTk7Jw/ff7Rzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652817; c=relaxed/simple;
	bh=Hb2vlo6jvMfawcIP5+hm/LNCX6XVc0VQ/rbcyfyg/Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ct8PTMCo2Z2FRIz8KVgMtEDByssp54nTPZ6fIqJ4QFEhsSwAHZBAvV25hgbscFvJzHatWET+HIwvR1KvX6J6TPXvzWPqh6QeHK6FF93RNThWSWxWpbuR+7tP5nTz1Ws7zx6S53DSweYoI5f07eTw/3r2L44chqWZ3itlwhEljk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQrhZL7d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721652814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eU/D7g+qP7HfNmpAQB1UFGkewZKa63OdmYLP+myK2LI=;
	b=QQrhZL7ddMknMmVeclfDiQ9BxaBaY6kT7pE+2jxVbTNvP2RK59P5qLSgMNpkPOc1AdNpvq
	xaH+sYc5ZxSx7QebWtLe3ypZ/kfirtVm+DH0pRuk/IqYjud+Bv38kC4zxaMkkXbM3Cf1p+
	jdb1KPag9ImGHbM9qPjqs8Oe23Dq0pk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-AMtbniRJMpaSKd0_PqjtmQ-1; Mon, 22 Jul 2024 08:53:32 -0400
X-MC-Unique: AMtbniRJMpaSKd0_PqjtmQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52efd4afebeso1825454e87.2
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 05:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721652810; x=1722257610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eU/D7g+qP7HfNmpAQB1UFGkewZKa63OdmYLP+myK2LI=;
        b=IWErfGi0DjGbDK1McHiY7A8MbNa3TKdOcZ7yp3Kysw3uQRvHmPeRvw4rvcOFvQmmYG
         +AcK5m368xSXUDl/Pf+JxiDVGxu5/7vmfVplF3hKlRpvmAbDXu1AoGvIDcS80unHCD6A
         3V0DcfwJMpUHxxDs4XB4o1T8H5Q4k8W0REYVjPF+Y3Q2wW7r70vWv/WV9Di1m18AYHhy
         biKqwsHdREOntSD6RvJpAxC7XOyyj7R+uxG/ohYz9ftuJBDp99jmyPRKwzJsL6oV/zT8
         qutJXLSYzEsQZA6ITlyPJGOsNtGRMarBZ3J9l7VnVCkwe2fdgCKqcId9dwIQgTTTnr6w
         DODQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3KhUBnOzgRpj2SZ/B4yl/pRXefpxA48MfO9kd6HaFtOUCEtE5hNcy7Dg1uU+FaC8GFSvQs1qnNVDkY8tEbQusYNybsoe6
X-Gm-Message-State: AOJu0YzMKPnKlRRC9LY3pNSAcc2OJ9UgfvFRieIbSqwpv3h38liqUZxZ
	wTIwwdwcNWkjwbFwU6+LtuJdS3v37KF+4eYMUDcWqXgLI0hwQWdp9LEHdBvzechixDzMdzmOaOf
	Kcej62S/h81lr31wUPcUSbk7g1X7hOm+QQMKf5K3sY/lq1wOBIXGo5nhcEeqDDKo3I6AjKtV3Wc
	6c1AIxH6mJIQP2pIHCBLUTo9xXnYmi
X-Received: by 2002:a05:6512:b93:b0:52c:da18:618c with SMTP id 2adb3069b0e04-52efb7c81e5mr4946310e87.45.1721652810674;
        Mon, 22 Jul 2024 05:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1mNcBQlFjEipVBmIhBwOyNuYK7PE8pk7ocN9FHW1CRN8mmKIK/bPZP3oGT+TMvN+d/t1tuhOEjNRdYMGH2b0=
X-Received: by 2002:a05:6512:b93:b0:52c:da18:618c with SMTP id
 2adb3069b0e04-52efb7c81e5mr4946290e87.45.1721652810311; Mon, 22 Jul 2024
 05:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
 <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
In-Reply-To: <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 22 Jul 2024 20:52:51 +0800
Message-ID: <CACLfguV27KGZE9z5OKuse44tpsF2u8DALhGNxu+g8==qV50CYQ@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2024 at 15:49, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> >
> > Tested in ConnectX-6 Dx device
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index ecfc16151d61..415b527a9c72 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_=
dev *v_mdev, struct vdpa_device *
> >         destroy_workqueue(wq);
> >         mgtdev->ndev =3D NULL;
> >  }
> > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > +                             struct vdpa_device *dev,
> > +                             const struct vdpa_dev_set_config *add_con=
fig)
> > +{
> > +       struct mlx5_vdpa_dev *mvdev;
> > +       struct mlx5_vdpa_net *ndev;
> > +       struct mlx5_core_dev *mdev;
> > +       struct virtio_net_config *config;
> > +       struct mlx5_core_dev *pfmdev;
> > +       int err =3D -EOPNOTSUPP;
> > +
> > +       mvdev =3D to_mvdev(dev);
> > +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > +       mdev =3D mvdev->mdev;
> > +       config =3D &ndev->config;
> > +
> > +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +               if (!err)
> > +                       memcpy(config->mac, add_config->net.mac, ETH_AL=
EN);
> > +       }
> > +       return err;
>
> Similar to net simulator, how could be serialize the modification to
> mac address:
>
> 1) from vdpa tool
> 2) via control virtqueue
>
> Thanks
>
sure. Wiil do
thanks
cindy
> > +}
> >
> >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> >         .dev_add =3D mlx5_vdpa_dev_add,
> >         .dev_del =3D mlx5_vdpa_dev_del,
> > +       .dev_set_attr =3D mlx5_vdpa_set_attr,
> >  };
> >
> >  static struct virtio_device_id id_table[] =3D {
> > --
> > 2.45.0
> >
>


