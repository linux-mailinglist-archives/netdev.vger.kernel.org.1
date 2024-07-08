Return-Path: <netdev+bounces-109758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A74929DD8
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F134283F16
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66122086;
	Mon,  8 Jul 2024 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDtPNDkS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F292F2E
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425698; cv=none; b=Xzkg2AG++Sh5JeNOl3aM53IXozP/Ba0Y6g1rODnOGV4zF4aCcQ4kJYbMZjAQhsnEV+a8UnWT51hnobdBSjYzGa6KMOrRwjA+oGgzS0XMC/pyRF9QbJ5HFm1gphYNHsb9fxKVTrvFEdWx17YBIH7LxRHoPiKpWdUKZTIKJfN+Ae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425698; c=relaxed/simple;
	bh=nlLhLflDa5bMvjhaApP9IsLVRkmOHEF5QWS4D2zNHw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkpE8zsrcCmD0nYh4zql5zbWS8byiTWt1ePsNKVZjrLhn4Pskdt1ksgTSO8pucVfUjRPGSaxnppMWZ1ANQk1ZSV7QSMU0tl/1b7gbgy6yj9TGi0m0KXSJhVnzyqgurjrK3Kr50YqUewRtvav15V/GO4pSydatc5Zw9tyk3UiemM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDtPNDkS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720425695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27lMaNCb81p4YFFh+LEEn0k8qDHH12ozaV7hZRSJBCA=;
	b=dDtPNDkSpFBXAOsahGv2A6+E+UzHPHBmRw+ePCPycWK7fhDBxO0dNqvHYHgolm467xzAIv
	aGluUS1a78rD1TsoSA1IWreijvklyTzenKdy0leRxxAepuyvjvZfxnQBJMGiW1Z0xtHK/N
	xI8SAntMlRwEOWt4BgMEqpy5VoEOT4w=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-HNuYIf41OR6iPLlj3SN4NA-1; Mon, 08 Jul 2024 04:01:34 -0400
X-MC-Unique: HNuYIf41OR6iPLlj3SN4NA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fba2bb1ad5so2134795ad.3
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 01:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425693; x=1721030493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27lMaNCb81p4YFFh+LEEn0k8qDHH12ozaV7hZRSJBCA=;
        b=FZv2mXUSipLG92IqcrubBfEYCPqHGxvvyNVdMdDG0GPFjRfgRrWM1j6UPdXYxa9pmO
         QWchSchLuHO6xhqZStaLB0TLVVZpdG5KGARfbWKVIYP7iMbfATPJz+ESEu05XBe8aI28
         XQRl7mj7sqbYgUPGZVKzq3ewxzw+K3SVyVNd8VETldl+1uT8ntnVn57gSP0qyPGDrAWc
         uJC8gK5rK0ESAVcdm+pbyX4fLatth3tEugmLU2DjwLUlLo8/0vvsUTiJUMABOFkfI+Qx
         5kmqkm7FYn1UxuVbvkQaCN81DdNLAEWkxI5vvXTiFu1uArRhZvGg3Jhhw+wuf8B+zO/u
         WqSw==
X-Forwarded-Encrypted: i=1; AJvYcCUxnSR9hPx8tKrlkVIHgXV+ntfbscbcjDpRQIf4Jme0/8Itj3c3UaQGNYwS0cbewszdZTne5vw8rAybOWjMwISb4bSZEJxh
X-Gm-Message-State: AOJu0YzeI6HObDbvx9meiYZpYO1PYWyA6sXbIP6ac1rdSXh/cfuRFnFy
	/4R0/H2vpKP5UZwM2cZgHia3gxeEvrRpimNJx4IfI3qpkJJczcAUgjAVPNss13ie2BFL9sP4rQi
	+Bri1CC7tvNDfkbHE4QykyuHYEaBIixD4X/uRdjyBQPNp1WKtKXtt1u4CIncqNT4jqBTuJ1UN9q
	edOBxRNE66xA5rLEjZ7bOUxoZJ8XdU
X-Received: by 2002:a17:903:1252:b0:1fb:a1c6:db75 with SMTP id d9443c01a7336-1fba1c6de04mr6881615ad.6.1720425693348;
        Mon, 08 Jul 2024 01:01:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7tEwJUQ3jL/FURLCL1Fmxt7rfHgT6zXgifTSPRjjPgC0FTxqJiDiptLT5gVxmpCf9aR+PWLt24EtwHzQHJqA=
X-Received: by 2002:a17:903:1252:b0:1fb:a1c6:db75 with SMTP id
 d9443c01a7336-1fba1c6de04mr6881415ad.6.1720425692886; Mon, 08 Jul 2024
 01:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <20240708064820.88955-3-lulu@redhat.com>
 <CACGkMEum7Ufgkez9p4-o9tfYBqfvPUA+BPrxZD8gF7PmWVhE2g@mail.gmail.com> <CACLfguXdL_FvdvReQrzvKvzJrHnE9gcTv+rLYsCNB0HtvXC74w@mail.gmail.com>
In-Reply-To: <CACLfguXdL_FvdvReQrzvKvzJrHnE9gcTv+rLYsCNB0HtvXC74w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 16:01:21 +0800
Message-ID: <CACGkMEuOz_fsBnX8BNnbUHMdNo48S8cEUT4M6O0_oBsSKRJmLQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:19=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, 8 Jul 2024 at 15:06, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Jul 8, 2024 at 2:48=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> > >
> > > Add the function to support setting the MAC address.
> > > For vdpa_sim_net, the driver will write the MAC address
> > > to the config space, and other devices can implement
> > > their own functions to support this.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++++++++++++++-
> > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa=
_sim/vdpa_sim_net.c
> > > index cfe962911804..a472c3c43bfd 100644
> > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > @@ -414,6 +414,22 @@ static void vdpasim_net_get_config(struct vdpasi=
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
> > > +
> > > +       struct virtio_net_config *vio_config =3D vdpasim->config;
> > > +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > > +               if (!is_zero_ether_addr(config->net.mac)) {
> > > +                       memcpy(vio_config->mac, config->net.mac, ETH_=
ALEN);
> > > +                       return 0;
> > > +               }
> > > +       }
> > > +       return -EINVAL;
> >
> > I think in the previous version, we agreed to have a lock to
> > synchronize the writing here?
> >
> > Thanks
> >
> Hi Jason
> I have moved the down_write(&vdev->cf_lock) and
> up_write(&vdev->cf_lock) to the function vdpa_dev_net_device_attr_set
> in vdpa/vdpa.c. Then the device itself doesn't need to call it again.
> Do you think this is ok?

I meant we have another path to modify the mac:

static virtio_net_ctrl_ack vdpasim_handle_ctrl_mac(struct vdpasim *vdpasim,
                                                   u8 cmd)
{
        struct virtio_net_config *vio_config =3D vdpasim->config;
        struct vdpasim_virtqueue *cvq =3D &vdpasim->vqs[2];
        virtio_net_ctrl_ack status =3D VIRTIO_NET_ERR;
        size_t read;

        switch (cmd) {
case VIRTIO_NET_CTRL_MAC_ADDR_SET:
                read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov,
                                             vio_config->mac, ETH_ALEN);
                if (read =3D=3D ETH_ALEN)
            status =3D VIRTIO_NET_OK;
        break;
        default:
                break;
        }

        return status;
}

We need to serialize between them.

Thanks

> Thanks
> Cindy
> > > +}
> > > +
> > >  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
> > >                                      const struct vdpa_dev_set_config=
 *config)
> > >  {
> > > @@ -510,7 +526,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_=
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


