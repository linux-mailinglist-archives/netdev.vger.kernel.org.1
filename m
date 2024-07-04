Return-Path: <netdev+bounces-109083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537C8926D67
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0668B2840F2
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7553411CBD;
	Thu,  4 Jul 2024 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bod6Hphp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72610A35
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 02:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720059865; cv=none; b=sTolScGhBa6XL4rCGR4fnJlbTbefkeE76HQvkUPOyvT3YrsObntrhVROPJkactwJN4nWj8SZMjleByTC5YHwZerHEZwbsJYuH+dCgeCEE/CF4YmGYaEL59oTUPghd5WDB2/Xtq8UUU7h3aVSWBxNfXpmWxWQG4eCVp2Qrmw6vHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720059865; c=relaxed/simple;
	bh=VBHDCAFcR1IRKETUWcEtgz1lkrYMRBTCV6BiA5CjvnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3b2n2CB2eoGvgiDWb3iudyCsD2JvP0fzDAL4PlYPI5jyolS5PIFnOCKtTD+ZM3z+sDzHw0cN5JZ6SmgXeCtgzQ/F4YN1Cd6IS2pwrno82TF+5Yt3HXibmiRsQsZJ5Qu/C/5h7BytPjKRpMGQZqFhGvlLARt5ucU625m79R6zjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bod6Hphp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720059862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WX4fsqP0aG9eMrxLN/jzQustmIWit5xwY4/kD0UV6u8=;
	b=Bod6Hphpn9/Dxa2Dp4ypM/8PXtKkfFPkPfCwrvKG8Z2fy6Gt1awmApiwXDmkDCRtnmaU3x
	r40/2qx4Y04uQZgNxz1xkkjkgpRyH+AxgBC87o3hAi/goovemYMhlmIBDQCBTWX9sVD/EC
	VeSmgrBW8CyEgpGpJiP//vOWQJ3pNjw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-YjDPyvslOvG_wRiA7zDMgw-1; Wed, 03 Jul 2024 22:24:20 -0400
X-MC-Unique: YjDPyvslOvG_wRiA7zDMgw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a751edc86bdso11170266b.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 19:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720059859; x=1720664659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WX4fsqP0aG9eMrxLN/jzQustmIWit5xwY4/kD0UV6u8=;
        b=xO/YZ73A6GxoUEFgfLy60sBbP1LSLXwwoXu/3YsJ0ZBoQaus6BVkYL/gOiaT1amhuG
         UfhL6lb0k8u+hHJWve+v5dfb01qwlZylmo+WzIcGu35DmjFZT9lblVuM6l6sAaPGgzqF
         QeuBbpGYD+9lQbG2AMvVbBvt32TDNyaY2EZupBzyh5GvDpTnZ08pCLdbT7/VZLyvgZXM
         n32dby2UNFbuGZbzUsTb0FWQNE51d02EoEcUfcGfmqr1s82Na+By/qg/HMaQ8S1zF6xy
         ff33npm7rpSp0jnU87gGfwMzcaoK0PPMp9wxvQFgMliXvQV60FpLwVxDwfNtAuW7ndUF
         GZXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/GcGvfHYvyKu6tS/l02VHKWhNe3qfmwrzCqMuKsgDf/pvnA/LsgA+bmix1P2YbKiUhgTsDFEwGDR47KdX44gtIjH/TcWU
X-Gm-Message-State: AOJu0YwMrQClVo/m9+2qJtqO5rFCEVPTRZJ/8Z0zHeytvzsI477ou0D0
	t3iW5dExkDDwQmqngcS4fnLyqZKT1eUIl4CB4yTqkMQRJaJ7OIV+oxnDZEqWrHXuliNVBzd/e9J
	VORBIJ0dE8zLVlavMTRVY/AA+qyo7wKsoA9kMXNsViut7ap+GVh2i1xLNZ1YQaQtjX1Qwgcnn3h
	H981w9KkpBOHtiBb5K1RHkjA486Vj9
X-Received: by 2002:a17:906:a295:b0:a6f:2ee7:b21a with SMTP id a640c23a62f3a-a77ba727bf5mr14402466b.65.1720059859682;
        Wed, 03 Jul 2024 19:24:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWRJbDkysic3UcaBmVYc2LiWNM9CIigaz2JCXSiNVFZCS7cdh/bDKW6zeuJEPWEToyWjDiCtpfMEbXuKgeOW0=
X-Received: by 2002:a17:906:a295:b0:a6f:2ee7:b21a with SMTP id
 a640c23a62f3a-a77ba727bf5mr14400866b.65.1720059859262; Wed, 03 Jul 2024
 19:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701051239.112447-1-lulu@redhat.com> <20240701051239.112447-3-lulu@redhat.com>
 <CACGkMEu4dxQ=KUJUwMt6WN31Y9hCZSYTPLabZghruzuJWdpGQQ@mail.gmail.com>
In-Reply-To: <CACGkMEu4dxQ=KUJUwMt6WN31Y9hCZSYTPLabZghruzuJWdpGQQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 4 Jul 2024 10:23:42 +0800
Message-ID: <CACLfguUwcOpbS+p5O7PH-FyrbY+PUTE8+zC0Hs6o=EFUu9rf4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa_sim_net: Add the support of set mac address
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Jul 2024 at 15:27, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Jul 1, 2024 at 1:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the function to support setting the MAC address.
> > For vdpa_sim_net, the driver will write the MAC address
> > to the config space, and other devices can implement
> > their own functions to support this.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_s=
im/vdpa_sim_net.c
> > index cfe962911804..e1e545d6490e 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -414,6 +414,21 @@ static void vdpasim_net_get_config(struct vdpasim =
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
> > +
> > +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +               memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
> > +               return 0;
> > +       }
>
> We should synchronize this with the mac set from the guest.
>
> Thanks
>
sure, Will fix this
thanks
cindy
> > +       return -EINVAL;
> > +}
> > +
> >  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
> >                                      const struct vdpa_dev_set_config *=
config)
> >  {
> > @@ -510,7 +525,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_de=
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


