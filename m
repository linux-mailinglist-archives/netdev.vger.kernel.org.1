Return-Path: <netdev+bounces-112493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D13FE9397EE
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 03:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027531C219DF
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 01:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780BD137C2A;
	Tue, 23 Jul 2024 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoH7dSlJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4D13699A
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698174; cv=none; b=liOCVftCUbKOIHC1eUKthE5RiJUieUpj4LfcvceA3x38OE67dZ5vy48ujf3tXd03wyz6zyHTwRYGAwOVGDLblm7QVxEksyQpCu8i3ClaKwkidGgNjBt+VsbYMroUaxo7lXdsAa1pqYe1uWPVIgwxt1afAAFvK+ajw+4RrQs0Wok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698174; c=relaxed/simple;
	bh=z01xefXmU21HnDqSgEy5UiGT7ZHsEuOE+v7BLx6SREE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COcdv+xk65+kfTBrcG4oy9uuGNaeAQhGZmo9yZiT2wkINftv49QLk6qS8hFW58EY60dzVukmijqQITDhV8dtjqYOy6rRykqvKKrf0W2CtEr6oIKE74jvosOd+ZfyJo5d6kcCtFP2mbPjZjbXDfSYVnoGPcAvzsLOx671SoXQj4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OoH7dSlJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721698170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lh6sglBXn9HCqi6Mc4WjFaiCiVqNGjLIvCUBib2S+h8=;
	b=OoH7dSlJEID6CNkz6P1AtSZ1uZp/761O3W/CumvXGUvB5cmx5VVLroPYIfnWYCd2udFZRg
	mONFdPCLk3kfmWd8xUsh+64IbXoBKFa747CRvBZ1dAKt1u7x0CJBMv0tmy0mA52zTw29Zi
	Ta4JsVlhNj+Hr1+kLb7MqXTW54XjDd8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-ZifIc2FMOZq398E4gGLTUw-1; Mon, 22 Jul 2024 21:29:28 -0400
X-MC-Unique: ZifIc2FMOZq398E4gGLTUw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7a732cdd03fso209169a12.0
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 18:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721698168; x=1722302968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lh6sglBXn9HCqi6Mc4WjFaiCiVqNGjLIvCUBib2S+h8=;
        b=RIWHz5muxu+E7+TXHywgm2YHWhOFsHVloeliV3fgeCZGjkSdiEHEpbV3qBIQxRZnJz
         qQNBY29FviPWOt54xxpBYDOnViLWMHWMJZpSf9spq9NrHuIDuqWVxDJm0Xu7MveeMpJQ
         aRcoZzQfsmm90y7BALzxkdqyoSkENGtiSjwZ94KzltdQgrb5/qeum/GAx1jOHA4ntk6B
         nompswLUVU4zV5KR53k58iBTFmD/2IYv51NKbDaOTjf9ntlbSjcOzutIjSEMVNsdYl4i
         4sUsd0sRfj5/1kHwAff68ZO0jBIhupLDsi2/VVTR1RS3UXSEi3AYX1SHdcnb9JwpBFXb
         5P6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWit9jk8ccYet7psO8JI0KO9AWYmSeaT6bXSx3ZmzILDDFeYHMMTEXZc/v9TGoMLV2jUjNW9LSxIOK3XmkwC2pdKmczPYXO
X-Gm-Message-State: AOJu0Yzzea2B1UFMosm7CxcUkrjkYshET3ztbCsQC5ZDpHqTiUZfI859
	WzSt5goB1gCgTZPbkM1WZLVS27F3M8Y6wDO1Ql1JzyBbBvFoSDmxBDDuI49yjwiDbx++ZHlEYXt
	9efgd9G5Q1BBNIG5Uvr6qumL6TG64drZhrr/rEPsOIDxewOlXBp4tt0nrciCl+4KHeg1Mzl4wH9
	iKGs/m8Z9+o3qOtIVk4u+6vwNf1XsB
X-Received: by 2002:a05:6a20:7f97:b0:1c0:dfd1:6241 with SMTP id adf61e73a8af0-1c4226a023cmr8274039637.0.1721698167711;
        Mon, 22 Jul 2024 18:29:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5IfbwOBSOpkfL3d6zcDK7Q0LvB8LaHpYB3LJRihZEpyUp565h+SR9bQCjzMm8fiSqhOa8eYhpRsfcxyz/XrY=
X-Received: by 2002:a05:6a20:7f97:b0:1c0:dfd1:6241 with SMTP id
 adf61e73a8af0-1c4226a023cmr8274018637.0.1721698167163; Mon, 22 Jul 2024
 18:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
 <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com> <7a4d99e0f16cbe91000c3c780334a4c866904182.camel@nvidia.com>
In-Reply-To: <7a4d99e0f16cbe91000c3c780334a4c866904182.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Jul 2024 09:29:15 +0800
Message-ID: <CACGkMEt6S7MCJCbyfaDRj+FPfV0uUYDTbeVzgnyqkOR2YPtt1w@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "lulu@redhat.com" <lulu@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 5:45=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Mon, 2024-07-22 at 15:48 +0800, Jason Wang wrote:
> > On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > Add the function to support setting the MAC address.
> > > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > > to set the mac address
> > >
> > > Tested in ConnectX-6 Dx device
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/ne=
t/mlx5_vnet.c
> > > index ecfc16151d61..415b527a9c72 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgm=
t_dev *v_mdev, struct vdpa_device *
> > >         destroy_workqueue(wq);
> > >         mgtdev->ndev =3D NULL;
> > >  }
> > > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > > +                             struct vdpa_device *dev,
> > > +                             const struct vdpa_dev_set_config *add_c=
onfig)
> > > +{
> > > +       struct mlx5_vdpa_dev *mvdev;
> > > +       struct mlx5_vdpa_net *ndev;
> > > +       struct mlx5_core_dev *mdev;
> > > +       struct virtio_net_config *config;
> > > +       struct mlx5_core_dev *pfmdev;
> Reverse xmas tree?
>
> > > +       int err =3D -EOPNOTSUPP;
> > > +
> > > +       mvdev =3D to_mvdev(dev);
> > > +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > > +       mdev =3D mvdev->mdev;
> > > +       config =3D &ndev->config;
> > > +
> You still need to take the ndev->reslock.
>
> > > +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) =
{
> > > +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > > +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > > +               if (!err)
> > > +                       memcpy(config->mac, add_config->net.mac, ETH_=
ALEN);
> What is the expected behaviour when the device is in use?

Should be a fault of the mgmt layer, so I think we probably don't need
to worry about that.

Thanks

>
> > > +       }
> > > +       return err;
> >
> > Similar to net simulator, how could be serialize the modification to
> > mac address:
> >
> > 1) from vdpa tool
> > 2) via control virtqueue
> >
> > Thanks
> >
> > > +}
> > >
> > >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> > >         .dev_add =3D mlx5_vdpa_dev_add,
> > >         .dev_del =3D mlx5_vdpa_dev_del,
> > > +       .dev_set_attr =3D mlx5_vdpa_set_attr,
> > >  };
> > >
> > >  static struct virtio_device_id id_table[] =3D {
> > > --
> > > 2.45.0
> > >
> >
> Thanks,
> Dragos


