Return-Path: <netdev+bounces-112420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D322938F75
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 14:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF291F21FE6
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C4016D9CA;
	Mon, 22 Jul 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/V1nAuE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5849A16D9C8
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652965; cv=none; b=XHffE3AP4KvpezFtbQu4+G6y0yiMOQNoPn0nVXdu9m64bcBKKH8O0dvFEyMvhEg7zIF9eOqqgcEeA5b7534Ker8w/mup4ClPkrW8x3X7chZor2gmTiynQViRU8/F8QsTZC6EQJXvRHphqi1UhtYm4uNcQiF+6e+1dTL/StZTDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652965; c=relaxed/simple;
	bh=JZLYf0wsystlScoz0eEY4VxzQQcKUBE/9MHVicMM8II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5tOhznpxDg+NVXQscV6S3iZJJvcmuBXksC3gM+BoMXPN3iCDEFbwu5xqLa3YyF0at/Et6CedQ/O78xOd/2+Eccbt8UMenWQvRD2zGKELCeY7l1/A04XjN1a2e0SsxHub0PjI7lROJHnt1XW9GZLkpsTf9iWTqLbpL3YFhlnSD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/V1nAuE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721652962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJVNq97qnVdAr/18tmluAm4AREjAa0bHQTkX1v3BnY0=;
	b=N/V1nAuEDFpTTVmp4L4pfx5WRBx35ziS0OoDbyxLaLoZTv3UnAsnYnTVwoFZisOPyh/ARM
	/Sc3I1dpiqH1x+DDn0tCjZ5D3de8p3jUTLq68rDBBRx5m9wyNtN+j3/f1Jg9hWo5GguBgR
	Ezix3D7yLACrcFXFqpP0cbypMzxql/w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-zpxu17FxPr211zQLXmWsmg-1; Mon, 22 Jul 2024 08:56:01 -0400
X-MC-Unique: zpxu17FxPr211zQLXmWsmg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5a3fa8b9151so1744682a12.2
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 05:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721652959; x=1722257759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJVNq97qnVdAr/18tmluAm4AREjAa0bHQTkX1v3BnY0=;
        b=PmVSi1vmIpGNvrWaoW1Goly8udOlhlsPWKdWS2bTSJC0RhqlfHvCaGWO7OT3jhIcia
         drW2xDcxfFhj0O+t1a+QtINOrwU0mVwX8JzwobAR7zNTjO8byqjo/JEAniPFqNhB1k9z
         5ehYiP8vAjVPNnB0e9Om6T+DiyKb0iJPBG7izpsaSFWUPZLLODuTUsBe9W0TayfNEwql
         vxJ5t0zuYZevDR1XyAOdFaK2mQw9LqPhSQYtru35uFbNhhUOjxglv8MLxWoKcyNS6zQA
         scSDvNHgPzzV182J8Von+syM2o3/4epjQA0xB2PfvgyHXFsFdg7+xZnhFzcYOBp6ubYh
         NfMA==
X-Forwarded-Encrypted: i=1; AJvYcCUByuD3ewvTmEd+5SVQjJUOc5giyD5+NENtdNt3ykqeVUYIcJ5bfw1Isgm7bkMkZkJWdmmNUYOw7ebV2zgRQPnuj4+xwhi0
X-Gm-Message-State: AOJu0Yya7HIHXDOsUU6IKS/ETKn6DMDbkuQbp6Yn9ufDPOXVh5mCN95K
	HfwshT/75cRNWbBfETu8/C27nkH7STdEhyGRQBEwHA2EYWzeEb93T3BZ5CCDBNUNnE9bMDRWS/k
	I3sF5c9zQ4jE+W0XLeEEkSfx6ps4hj6iXBc8EcIuOJz6b70tLJTu8ILKyqAe3bpYg1y1P8DGPw+
	18l8ExmicLxdw74ecBFyIiYsdZlhy+
X-Received: by 2002:a05:6402:2710:b0:5a2:69f9:1fe7 with SMTP id 4fb4d7f45d1cf-5a47b5c0b38mr4441759a12.35.1721652959414;
        Mon, 22 Jul 2024 05:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoczppy1uFSf8Ce5bOr4QQLzSZiqqNznaHB9kc0dNoTPng5nEUdTnupdY6jWQpNPwWvx5HiWx06BR6DpqS8NE=
X-Received: by 2002:a05:6402:2710:b0:5a2:69f9:1fe7 with SMTP id
 4fb4d7f45d1cf-5a47b5c0b38mr4441749a12.35.1721652959078; Mon, 22 Jul 2024
 05:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
 <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com> <7a4d99e0f16cbe91000c3c780334a4c866904182.camel@nvidia.com>
In-Reply-To: <7a4d99e0f16cbe91000c3c780334a4c866904182.camel@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 22 Jul 2024 20:55:22 +0800
Message-ID: <CACLfguUR_hdJGDcjnmYY=qOXFiSnsBsXD5evTDZQi=K0RM4gZQ@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2024 at 17:45, Dragos Tatulea <dtatulea@nvidia.com> wrote:
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
will fix this
> > > +       int err =3D -EOPNOTSUPP;
> > > +
> > > +       mvdev =3D to_mvdev(dev);
> > > +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > > +       mdev =3D mvdev->mdev;
> > > +       config =3D &ndev->config;
> > > +
> You still need to take the ndev->reslock.
>
sure, will do
> > > +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) =
{
> > > +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > > +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > > +               if (!err)
> > > +                       memcpy(config->mac, add_config->net.mac, ETH_=
ALEN);
> What is the expected behaviour when the device is in use?
>
if the err is 0 then copy the Mac address to config
will change this code to make it more clear
Thanks
Cindy
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


