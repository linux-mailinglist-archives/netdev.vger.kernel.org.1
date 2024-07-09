Return-Path: <netdev+bounces-110139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4AD92B14D
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A736E2823FC
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2888614B97B;
	Tue,  9 Jul 2024 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FE05boOJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880EF149C76
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510653; cv=none; b=YcglelOeoOIYyPghsMuOJ1tfyyKbQBocoWrPQkaYXCQtRMx5IzSM/3U2ttz26gB228IiH5MOs5ZDS+1ipHhbYcbutKP08IYAkTKfES3Ra1UGBKuMy1E0JFU+CNYlGLBnInNm5sqKur7fM2mrEmbrOwNO/foAVFWnPrkOHt4PEPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510653; c=relaxed/simple;
	bh=R6uhElAMm4FTpUU4vkd99nDcZrma70iZDg9k9g3ocDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jY4es1jBNHdJFYKquTeeUJTb3lmDH3iIhczObIzOj/YI3U6eN3Zavw9BdVfwjLnUeaCmQHmAbyjqelgEhhoSZqgek5lHE3Z49A0IVDpwmLnagtbRDiXXSGwBlcupAXrgP27k8HOu4jpZYE5e750wfNx1Q1FPn8P+ElldMNuXWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FE05boOJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720510649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A49qXoXkEsMzgDh5I6lFSA4XYzFZMk+NCFiOV4UimaA=;
	b=FE05boOJX/W6NVlx6Ba2TZp/l1l44trpUiLIMVTLY80MRDQPyA4wiTb8lYSyP1A2JRaUdS
	V52DtDDJICmY3/MiDm2Mkx9LLOioC+kfC22UfoczJFHsfwPij8cYresJdS/VIPhxMkvxei
	XO291EiXPTnDtoMVaecYPVm56EVlC80=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-KNVxhx3UPbCuonW9Wi3TDA-1; Tue, 09 Jul 2024 03:37:27 -0400
X-MC-Unique: KNVxhx3UPbCuonW9Wi3TDA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58c7800d03eso2330467a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 00:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510646; x=1721115446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A49qXoXkEsMzgDh5I6lFSA4XYzFZMk+NCFiOV4UimaA=;
        b=iovp01RSlIC2TYtRM8rHOIjfgAee66HkA8tCLDSpgM+397vwZnZA44t/2t5W61Ovk4
         vZGnuW1uLsnkSFrC3B5yaaqGVYwleR/12PQa9ydT1fgP4d+NaHaH7p9npMK4uGVMWb9+
         En13RbcOOmdaM2EbTsSG/tDTsnUL47NLda9Tr5OervRJOEq8fbx1MW8gyVbVUCJm/7xk
         LHA6fTtEN/TGYRIsdO2OEDuZlI8IHnsilPfYQDqqyYQRYYhnUOFVbXzB+pZHdJum6jEC
         zzIy6mXahAHP7YFjIFRE7gP7dl/2/JZX0DsFeRgzakH1PsmC05Y37xKMCOCKbdN6D64O
         YPpA==
X-Forwarded-Encrypted: i=1; AJvYcCWnT27WKpl49n3iwJB05kU+MVL3DfW4FkoLILxL3EC7XBQuxrJaIVhFOu3QF+ub7b1uE7A3ji3HNHDl9e1G8AogvVi85iE3
X-Gm-Message-State: AOJu0YzN5p6fDDpjrqeEVo2eMh2ZA6P9435FT3RsS4ew1QeK5qJMG2ad
	X1dacCffLeirfbtTSRBT4pgPCR8f91AZT/eM1MaIwN8KyHGgdYum7VuxcBqllfzb3SaGMIQVVZv
	/R0FAWBtupj9U0Pbnu6orQqlREHVSFnWb77CwSwt5ViR57WZTJY/OxCAI02FIDuN7/rzwmEk5uU
	CDAZFjSmmSRCrjY08Y0I0cF0m/QQpF
X-Received: by 2002:a05:6402:430b:b0:58c:3252:3ab8 with SMTP id 4fb4d7f45d1cf-594bcba83fcmr1671348a12.37.1720510645969;
        Tue, 09 Jul 2024 00:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvA5gcFgFWqNy3DfNk26q33q8PtgffuDdwkGspZQpCkB6LI+Z1lBCXYRy9/d//O/OXiMfXxo5/urdnIEt4WlE=
X-Received: by 2002:a05:6402:430b:b0:58c:3252:3ab8 with SMTP id
 4fb4d7f45d1cf-594bcba83fcmr1671317a12.37.1720510645548; Tue, 09 Jul 2024
 00:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708065549.89422-1-lulu@redhat.com> <34818d378285d011d0e7d73d497ef8d710861adc.camel@nvidia.com>
In-Reply-To: <34818d378285d011d0e7d73d497ef8d710861adc.camel@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jul 2024 15:36:48 +0800
Message-ID: <CACLfguV5CXMs9AdWrN9a=st5PjUnT4B1bt2Uua=AYjuC0NwfNg@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Add the support of set mac address
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024 at 15:27, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>
> On Mon, 2024-07-08 at 14:55 +0800, Cindy Lu wrote:
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> >
> > Tested in ConnectX-6 Dx device
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 26ba7da6b410..f78701386690 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3616,10 +3616,33 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_=
dev *v_mdev, struct vdpa_device *
> >       destroy_workqueue(wq);
> >       mgtdev->ndev =3D NULL;
> >  }
> > +static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
> > +                               struct vdpa_device *dev,
> > +                               const struct vdpa_dev_set_config *add_c=
onfig)
> > +{
> > +     struct mlx5_vdpa_dev *mvdev =3D to_mvdev(dev);
> > +     struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > +     struct mlx5_core_dev *mdev =3D mvdev->mdev;
> > +     struct virtio_net_config *config =3D &ndev->config;
> > +     int err;
> > +     struct mlx5_core_dev *pfmdev;
> > +
> You need to take the ndev->reslock.
>
thanks will change this
> > +     if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +             if (!is_zero_ether_addr(add_config->net.mac)) {
> > +                     memcpy(config->mac, add_config->net.mac, ETH_ALEN=
);
> I would do the memcpy after mlx5_mpfs_add_mac() was called successfully. =
This
> way the config gets changed only on success.
>
thanks Dragos=EF=BC=8C Will fix this
thanks
cindy
> > +                     pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev)=
);
> > +                     err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +                     if (err)
> > +                             return -1;
> > +             }
> > +     }
> > +     return 0;
> > +}
> >
> >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> >       .dev_add =3D mlx5_vdpa_dev_add,
> >       .dev_del =3D mlx5_vdpa_dev_del,
> > +     .dev_set_attr =3D mlx5_vdpa_set_attr_mac,
> >  };
> >
> >  static struct virtio_device_id id_table[] =3D {
>
> Thanks,
> Dragos
>


