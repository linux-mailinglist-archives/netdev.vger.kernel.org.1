Return-Path: <netdev+bounces-103238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDE69073B6
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE6D1F219AA
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACDD143C6C;
	Thu, 13 Jun 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gn58lC0F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F0144D07
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285387; cv=none; b=poUEgwoyGiuxNlmqXdIijzEMbKhpZiDr+lY0PQu8dkNQYqwI/320BWBU7YDR1X1lYb43JWepbG0wwerU4hq3cQGV/I9HIkqTzfmhw5n6PR99ef8KYnY9LIsAvxXm+Edku2i0GGqucSD7v64PnbW2DJgYkXMeuYfbi1+DZVq0cSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285387; c=relaxed/simple;
	bh=EwDYV86apdp1y3FgvqhXoUdcP6ZAutdGUFD8nB4Rupc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/bwsozwXH5I7oWSZDAJnLwUiM+5sukSrQrtJiJT2Zhdx795MqEPBRLKV+LYCYfJoqdvfV2X9aLVADTxSPjN7ZC/3zfMuIN102XS23mPeFu3d5/h8dXd2nl8TeVEnoroEDZMHu0AcRkXJNiRZTiyhj9LTGFF2GQk8Xea+H/AF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gn58lC0F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718285385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9evobZ56tePgOcIz6BoUUANwCX8e2L9RTd9imGKDRo=;
	b=gn58lC0F7YRH1Ed+QnaEAiKC4OtiMuUVk+4wo2SmvW5BETV+97QmQnD89nVSDLcDgnlTDL
	W6in+YzPTT17GVDZn/Zi8lWp7OyMyK6A/TwNYOCVTbpZOUhzCtKVeWZNCULac1+pB46fr6
	TURmVhP8g8/kB78o/Y2ezjd/uOIzcHA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-9wr4bjBNM82csORyUp7Z6Q-1; Thu, 13 Jun 2024 09:29:43 -0400
X-MC-Unique: 9wr4bjBNM82csORyUp7Z6Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6f0f7d6eaaso231263866b.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 06:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718285382; x=1718890182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9evobZ56tePgOcIz6BoUUANwCX8e2L9RTd9imGKDRo=;
        b=fgwkbeGxf1UoiSljJc+i/9aaqAPVH9TwGsTezVZOjrrnRWUtokph7hE84S0/iur2Hc
         0BrKThKqw0U8g0XlldNtjjikXfE4uvbeoIuirJjN1lKnhyVOK/EsOv/fJDO1C979kss8
         +Og4Zh4P5tngcUTHBV09N3OzoiiY5UFxjPhu1JfbJuzvMau0eeQJmnqIVwm1Efmgd12j
         zTSPBY93RzR27QdLQ+5/1ohi6qOxMG0pUkadGS/XTEvymw5T7YeOiBml9ZPXGBRTsOC+
         chnjb3926VY7f06+PzH8xlhudCC34Y2JXEGMe5oGCnj5Pbh3hpu73r1Wahb90YsB2Inq
         svEg==
X-Forwarded-Encrypted: i=1; AJvYcCUt0sdrjZHoTwDrXdrj1NbGBfwK2Hgm7atz/ipPCXDYcIOfR9R4H35R54eX0AfsecTCXeTSe28Tpzq9+XYzUuNzrGz6Svkz
X-Gm-Message-State: AOJu0YzbjrLrRu4fT0MW3YjpJtfZemLUvASsvgSJschr+5XgGkmObv6J
	roRgbStwTbA3aUz5xbyKE7v9Ky7VDm7gP+3zbI9dsBe/OxPV/INWnrkgGG946jOfWjlg4SmIe/I
	hPWslLiKDQrt01e7HbDHroxwBAXjiRpOsR83ZzgTZpdZZyBCvK59qoiww6aaklhRkJpCHYLARl/
	GUtdiCLXfJ2AcqB/gmlEDxGHaH/WMG
X-Received: by 2002:a17:906:f2cf:b0:a6f:1c0e:6776 with SMTP id a640c23a62f3a-a6f5240f021mr181403466b.16.1718285382607;
        Thu, 13 Jun 2024 06:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUeOJDpHV2LdwavarsbYi5bPL2vRysrQ5fKaLl/dCD/lbPcIEg1tjiBX4sLf6XM7kiJX4bP1FfUh1UTOsXPLI=
X-Received: by 2002:a17:906:f2cf:b0:a6f:1c0e:6776 with SMTP id
 a640c23a62f3a-a6f5240f021mr181401766b.16.1718285382121; Thu, 13 Jun 2024
 06:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611053239.516996-1-lulu@redhat.com> <20240613025548-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240613025548-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 13 Jun 2024 21:29:04 +0800
Message-ID: <CACLfguWwkkfFA143uOavS0jDkW1Q0XEd5JZDdriOz-yywDkYng@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 2:59=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jun 11, 2024 at 01:32:32PM +0800, Cindy Lu wrote:
> > Add new UAPI to support the mac address from vdpa tool
> > Function vdpa_nl_cmd_dev_config_set_doit() will get the
> > MAC address from the vdpa tool and then set it to the device.
> >
> > The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >
> > Here is sample:
> > root@L1# vdpa -jp dev config show vdpa0
> > {
> >     "config": {
> >         "vdpa0": {
> >             "mac": "82:4d:e9:5d:d7:e6",
> >             "link ": "up",
> >             "link_announce ": false,
> >             "mtu": 1500
> >         }
> >     }
> > }
> >
> > root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55
> >
> > root@L1# vdpa -jp dev config show vdpa0
> > {
> >     "config": {
> >         "vdpa0": {
> >             "mac": "00:11:22:33:44:55",
> >             "link ": "up",
> >             "link_announce ": false,
> >             "mtu": 1500
> >         }
> >     }
> > }
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
>
>
> I think actually the idea of allowing provisioning
> by specifying config of the device is actually valid.
> However
> - the name SET_CONFIG makes people think this allows
>   writing even when e.g. device is assigned to guest
> - having the internal api be mac specific is weird
>
> Shouldn't config be an attribute maybe, not a new command?
>
Got it. Thanks, Michael. I will change this.
Thanks
Cindy
>
> > ---
> >  drivers/vdpa/vdpa.c       | 71 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/vdpa.h      |  2 ++
> >  include/uapi/linux/vdpa.h |  1 +
> >  3 files changed, 74 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index a7612e0783b3..347ae6e7749d 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -1149,6 +1149,72 @@ static int vdpa_nl_cmd_dev_config_get_doit(struc=
t sk_buff *skb, struct genl_info
> >       return err;
> >  }
> >
> > +static int vdpa_nl_cmd_dev_config_set_doit(struct sk_buff *skb,
> > +                                        struct genl_info *info)
> > +{
> > +     struct vdpa_dev_set_config set_config =3D {};
> > +     struct nlattr **nl_attrs =3D info->attrs;
> > +     struct vdpa_mgmt_dev *mdev;
> > +     const u8 *macaddr;
> > +     const char *name;
> > +     int err =3D 0;
> > +     struct device *dev;
> > +     struct vdpa_device *vdev;
> > +
> > +     if (!info->attrs[VDPA_ATTR_DEV_NAME])
> > +             return -EINVAL;
> > +
> > +     name =3D nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> > +
> > +     down_write(&vdpa_dev_lock);
> > +     dev =3D bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
> > +     if (!dev) {
> > +             NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> > +             err =3D -ENODEV;
> > +             goto dev_err;
> > +     }
> > +     vdev =3D container_of(dev, struct vdpa_device, dev);
> > +     if (!vdev->mdev) {
> > +             NL_SET_ERR_MSG_MOD(
> > +                     info->extack,
> > +                     "Fail to find the specified management device");
> > +             err =3D -EINVAL;
> > +             goto mdev_err;
> > +     }
> > +     mdev =3D vdev->mdev;
> > +     if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > +             if (!(mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC=
))) {
> > +                     NL_SET_ERR_MSG_FMT_MOD(
> > +                             info->extack,
> > +                             "Missing features 0x%llx for provided att=
ributes",
> > +                             BIT_ULL(VIRTIO_NET_F_MAC));
> > +                     err =3D -EINVAL;
> > +                     goto mdev_err;
> > +             }
> > +             macaddr =3D nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACAD=
DR]);
> > +             memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> > +             set_config.mask |=3D BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADD=
R);
> > +             if (mdev->ops->set_mac) {
> > +                     err =3D mdev->ops->set_mac(mdev, vdev, &set_confi=
g);
> > +             } else {
> > +                     NL_SET_ERR_MSG_FMT_MOD(
> > +                             info->extack,
> > +                             "%s device not support set mac address ",=
 name);
> > +             }
> > +
> > +     } else {
> > +             NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                    "%s device not support this config=
 ",
> > +                                    name);
> > +     }
> > +
> > +mdev_err:
> > +     put_device(dev);
> > +dev_err:
> > +     up_write(&vdpa_dev_lock);
> > +     return err;
> > +}
> > +
> >  static int vdpa_dev_config_dump(struct device *dev, void *data)
> >  {
> >       struct vdpa_device *vdev =3D container_of(dev, struct vdpa_device=
, dev);
> > @@ -1285,6 +1351,11 @@ static const struct genl_ops vdpa_nl_ops[] =3D {
> >               .doit =3D vdpa_nl_cmd_dev_stats_get_doit,
> >               .flags =3D GENL_ADMIN_PERM,
> >       },
> > +     {
> > +             .cmd =3D VDPA_CMD_DEV_CONFIG_SET,
> > +             .doit =3D vdpa_nl_cmd_dev_config_set_doit,
> > +             .flags =3D GENL_ADMIN_PERM,
> > +     },
> >  };
> >
> >  static struct genl_family vdpa_nl_family __ro_after_init =3D {
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index db15ac07f8a6..c97f4f1da753 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -581,6 +581,8 @@ struct vdpa_mgmtdev_ops {
> >       int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
> >                      const struct vdpa_dev_set_config *config);
> >       void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *d=
ev);
> > +     int (*set_mac)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *de=
v,
> > +                    const struct vdpa_dev_set_config *config);
> >  };
> >
> >  /**
> > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > index 54b649ab0f22..53f249fb26bc 100644
> > --- a/include/uapi/linux/vdpa.h
> > +++ b/include/uapi/linux/vdpa.h
> > @@ -19,6 +19,7 @@ enum vdpa_command {
> >       VDPA_CMD_DEV_GET,               /* can dump */
> >       VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
> >       VDPA_CMD_DEV_VSTATS_GET,
> > +     VDPA_CMD_DEV_CONFIG_SET,
> >  };
> >
> >  enum vdpa_attr {
> > --
> > 2.45.0
>


