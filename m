Return-Path: <netdev+bounces-112375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6F2938A9F
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 10:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143BB1F21A9D
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 08:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B70B166318;
	Mon, 22 Jul 2024 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ib4PgTkW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF81282FE
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721635272; cv=none; b=ih9KgiAje8Kh5jq9AM/iGakVUpeIyy3wutcRgaOhr+fAqTHyKmVSw6tLWN9ginnB1mp+s/BxljPucHwqGJ9tu2FZUTRKxfTuuHq/bfx6efVxgTuh3owlgL219uupkMUecD+ds8rsQZEMs5VSgnAps5PYv+uJ2hXA9xFiixX9Lck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721635272; c=relaxed/simple;
	bh=cv/eDdj7rZ/lIOc0x55LCidh/0YmyV8Os80FAWnpRw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHMuW95/WraXqpDHPjezJ0dE3PE0Lah3r7EZxlvG/Q24IkkYPPouLKbFhGA7MOPLP4axEq96hfqveAF4Yxb6e9yLW6vrO2RDPiqG5kbPF1Zg/di50rKeNXYgu2R94rydQ99FOIOK0dFAqso/SAdZIXy6/wuy3KrUT+St7MUf3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ib4PgTkW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721635269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QUfD1YmeCwI0P0HIWL0IY21aE8P6LAnbhy1oMHSUJ0=;
	b=ib4PgTkWpjlGGCdi8R/w0jyC8Y70JTtsZ4rdj6XQL85pckD/gFtxgj8/3LbFwG7q8p1Iw5
	zogo06o/Qj4HbIGRVYH12h91L8RPIz4CcCn1Xy+n7VMxWe7GJo7qYK6vESZh8zBe0LCKOU
	EE7bWjUB34Xben0//zfBqdkY70tR+r8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-xuzA389BN2-qS0VZrE23hQ-1; Mon, 22 Jul 2024 04:01:05 -0400
X-MC-Unique: xuzA389BN2-qS0VZrE23hQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb656e4d97so4672063a91.2
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 01:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721635264; x=1722240064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QUfD1YmeCwI0P0HIWL0IY21aE8P6LAnbhy1oMHSUJ0=;
        b=ftNweokMKkl4w9SG7ONMeZqGyjMDBZ1ac7kgqyt1Gtuf95yTnsVQTgu+gAHb9AE9aJ
         PN9dAatVYZrtTPQGJQUAQ/qwyy3/M66E8n1SCSOhAWgFWmqgtcxrDJddq/v74Nj7CEgP
         ULRjVrMVCkyMCctwNBuwKDUsm5J9oIh+vmqWy9b6NHpuMbHc9ZpDudKW5ATAnxVLZ5g8
         fsEBOYiM+JbryJxu1IjYlhpiI3O+8c6TZEYAWp+fcc7GFQm+pOT0SgLpbjWu/xHIWquO
         GEPq6auNoMFV3MfOoQRBMumiQUUiBBXWz+Du2zu6XwqQEoAF0bCTyI3AQCKsU/N0sUwb
         bWRw==
X-Forwarded-Encrypted: i=1; AJvYcCWw4c02Exvb83O6gUeQSoXqVluzfJT1aRcjMaSUAHdF7ooqdF9BQiqXhHTqQ2tOIYGwGmTDzpeLgEfa7IlCjqEkuFR3Sg9u
X-Gm-Message-State: AOJu0Yyc3wTUxGgoHj4LCAd4Ubbi+DhPEFqZRnhuPN4COIabWpuRnMXq
	mD6I9urhxvIjQt1ubhlxhjv4XVU6XXeaLqmw4+DaJMuMexI3UEWtUufjXZxV6mNxdczam0nbg3e
	GtmQVdsrrIwnR70PDtEJj6X439Xgh+vy16W25+/Yk/AElIZzNmS9UyLCdv/HVYHT+Oo//kaLpvF
	Vmnm/xw9H1z2g+2jyEkxwmc/ANOeVy
X-Received: by 2002:a17:90a:7307:b0:2c9:81fd:4c27 with SMTP id 98e67ed59e1d1-2cd27415a88mr4770844a91.14.1721635264306;
        Mon, 22 Jul 2024 01:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnOmbWFvxTc12Z/fU+czmUDIC3h6M95FI8NXEVLeHz/NV5eKtoYowMl6E64RVLXQ+V70jH1p++bYnSZzFW3MI=
X-Received: by 2002:a17:90a:7307:b0:2c9:81fd:4c27 with SMTP id
 98e67ed59e1d1-2cd27415a88mr4770811a91.14.1721635263773; Mon, 22 Jul 2024
 01:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-3-lulu@redhat.com>
 <CACGkMEtq=2yO=4te+qQxwSzi4G-4E_kdq=tCQq_N94Pk8Ro3Zw@mail.gmail.com> <CACLfguUaDo3seJZT_yQNp_fa4bELHwwAb8OTbXGwBLw2fGdj+w@mail.gmail.com>
In-Reply-To: <CACLfguUaDo3seJZT_yQNp_fa4bELHwwAb8OTbXGwBLw2fGdj+w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 16:00:52 +0800
Message-ID: <CACGkMEvT-j3GNq0C8nx_oy0KoqgAGhMwJwXbAXPjomkouNxEgg@mail.gmail.com>
Subject: Re: [PATH v4 2/3] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 3:57=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, 22 Jul 2024 at 15:48, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > Add the function to support setting the MAC address.
> > > For vdpa_sim_net, the driver will write the MAC address
> > > to the config space, and other devices can implement
> > > their own functions to support this.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++++++++++++++++-
> > >  1 file changed, 21 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa=
_sim/vdpa_sim_net.c
> > > index cfe962911804..936e33e5021a 100644
> > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > @@ -414,6 +414,25 @@ static void vdpasim_net_get_config(struct vdpasi=
m *vdpasim, void *config)
> > >         net_config->status =3D cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S=
_LINK_UP);
> > >  }
> > >
> > > +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
> > > +                               struct vdpa_device *dev,
> > > +                               const struct vdpa_dev_set_config *con=
fig)
> > > +{
> > > +       struct vdpasim *vdpasim =3D container_of(dev, struct vdpasim,=
 vdpa);
> > > +       struct virtio_net_config *vio_config =3D vdpasim->config;
> > > +
> > > +       mutex_lock(&vdpasim->mutex);
> > > +
> > > +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > > +               memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
> > > +               mutex_unlock(&vdpasim->mutex);
> > > +               return 0;
> > > +       }
> > > +
> > > +       mutex_unlock(&vdpasim->mutex);
> >
> > Do we need to protect:
> >
> >         case VIRTIO_NET_CTRL_MAC_ADDR_SET:
> > read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov,
> >                                              vio_config->mac, ETH_ALEN)=
;
> >                 if (read =3D=3D ETH_ALEN)
> >                         status =3D VIRTIO_NET_OK;
> >                 break;
> >
> > As both are modifying vio_config?
> >
> > Thanks
> >
> i have added a lock for this; CVQ also needs to take this lock to
> change the MAC address.I thinks maybe this can protect?

Right, I miss that it is done in the vdpasim_net_work().

> Do you mean I need to compare the mac address from the vdpa_tool and
> mac address in vio_config?
> this vdpa tool should not be used after the guest load, if this is
> different this is also acceptable
> thanks

The patch looks good then.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> Cindy
>
> > > +       return -EINVAL;
> > > +}
> > > +
> > >  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
> > >                                      const struct vdpa_dev_set_config=
 *config)
> > >  {
> > > @@ -510,7 +529,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_=
dev *mdev,
> > >
> > >  static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops =3D {
> > >         .dev_add =3D vdpasim_net_dev_add,
> > > -       .dev_del =3D vdpasim_net_dev_del
> > > +       .dev_del =3D vdpasim_net_dev_del,
> > > +       .dev_set_attr =3D vdpasim_net_set_attr
> > >  };
> > >
> > >  static struct virtio_device_id id_table[] =3D {
> > > --
> > > 2.45.0
> > >
> >
>


