Return-Path: <netdev+bounces-112502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36435939983
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 08:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B291C21210
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 06:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AE613C838;
	Tue, 23 Jul 2024 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioGRNccu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92EB28E8
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714492; cv=none; b=ZAAphZzxp17j5/9dkJByXhfP584BellhJc3XH+Pga45eyhM1wU+3GlfPsiEmZmJ4YNImkRcgegTYqEU6/zdNq3tUGMPxJdRL/4DI64kYYK2isvlbdSJ7zJTxIrvaMMsfN/n0ihoto0LK1M8qVS5Bj1NlqHG0wMeZ66di69KxVfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714492; c=relaxed/simple;
	bh=0QhUiB9QPy0L3gVOVOqvoBO7aidT3a89V+Jj6mDtr2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuB9sCKaZDjCr6p24rz1VBZWsDafBkFWuVJAYE6687MEDZGKun5F3oqizbeAuRhr4lNigngJQWMlBpCcrXq6WdRZDnaeFOPVHwOqLZPVxhfbuSDzaZQQ7GbVretz6Z+FvyougI5Xr+PFR5EkA0GGIysLnRlQ9yKvbedrKMTOPrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioGRNccu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721714488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFUGGCd0Ti7ajjqk9V9q2SgIV68PyjzZBB05K4vzgXI=;
	b=ioGRNccuhYOta9SC92rabQcPbfTcqH8o8bWQJEJNBBM4e8xCuhZDILXSUwzYIUUco75WPd
	Tbekmnrkn1X9qN+sgjvzQOOVpXeoElLuy69qzUaVD4Xvm7AhRM5w+50jgpreWJxgFYrna4
	I4rHVv0WDAfQ8mfe7HBkIYxs5bX6f4E=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-Uu1y-QOfNxKZo5qfKPtUnw-1; Tue, 23 Jul 2024 02:01:27 -0400
X-MC-Unique: Uu1y-QOfNxKZo5qfKPtUnw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70d34fa1726so1165280b3a.1
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 23:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714486; x=1722319286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFUGGCd0Ti7ajjqk9V9q2SgIV68PyjzZBB05K4vzgXI=;
        b=AYFHeH8TOjPhO8e8N3uVPNhgzvkq2f94rmFbmpzZ3M5a8mlirEzDFa3HmX5IhgIJuL
         pfOyIG1Q50g/TH6AYSSV+Gty7wS76quBo6imgaBcm6VCR0NWxt+W9ZTiLJVFuOieAcJ0
         /x4tg4ZDVYYwk794MwiHtwiVua6uLVQQOjoU18nZdWz6I+oraZllcgMo1FP01x45WhKH
         fBY4enom2bJ/GHExj6ncH8Fid4c6x2wIQP9XZ4qsaA6SBKH/9vabyOigbaFHUJ8r/4bI
         Iq0XRnzGV/YUmvczOtJMD7VuqcqLJbYGwjrgzPAWXu4HIKXJ39qUGsddehbV8HTgBC2h
         Yx5w==
X-Forwarded-Encrypted: i=1; AJvYcCXRNct72SHKzeygKMuJ8c1enRgb0XLumLAbjNdLsXj3+u7uiCPdDZnnRvxE1MwERZI+oQ5wdmO8Fx2mZ/C0ZdedwaKhE8Ug
X-Gm-Message-State: AOJu0YyS96M3lu6bZc8NTjx9GdiQquVpgYliJfQVZRj5KGCZ85A8M5hk
	G6m5Pqy5ngzhl+nRXjmlfRZGgJfMmukV/w+7q45Magt8gF8FLShvVmRGAIbotVylV8iB8lqG+jk
	VFImMBRrDjW28OFwSuERscQKEcR335THsju2/xROYq89TVGtDGjZ6ZMzaCJH2OCsIwIMJv32yn/
	1iQ246IJI4NQ7Z5LK7Pptrr0B8NItv
X-Received: by 2002:a05:6a20:748c:b0:1c2:74b4:a05d with SMTP id adf61e73a8af0-1c4228c17c9mr14693856637.23.1721714485933;
        Mon, 22 Jul 2024 23:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbYKlnLDWuDPqyKiWo0elei3K5WRnvIvnuckGXshR2QiKbTbh3jj82vCLFGmScBe6bfH0HlrebBeiWK/cbDmo=
X-Received: by 2002:a05:6a20:748c:b0:1c2:74b4:a05d with SMTP id
 adf61e73a8af0-1c4228c17c9mr14693817637.23.1721714485296; Mon, 22 Jul 2024
 23:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <20240723054047.1059994-2-lulu@redhat.com>
In-Reply-To: <20240723054047.1059994-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Jul 2024 14:01:13 +0800
Message-ID: <CACGkMEuoYAkAxhZrZfyWpMV__eimDvNCWYogidC6qMpOVBh0aw@mail.gmail.com>
Subject: Re: [PATH v5 1/3] vdpa: support set mac address from vdpa tool
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add new UAPI to support the mac address from vdpa tool
> Function vdpa_nl_cmd_dev_attr_set_doit() will get the
> new MAC address from the vdpa tool and then set it to the device.
>
> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>
> Here is example:
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "82:4d:e9:5d:d7:e6",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
>
> root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55
>
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "00:11:22:33:44:55",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa.c       | 84 +++++++++++++++++++++++++++++++++++++++
>  include/linux/vdpa.h      |  9 +++++
>  include/uapi/linux/vdpa.h |  1 +
>  3 files changed, 94 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 8d391947eb8d..07d61ee62839 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1361,6 +1361,85 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct =
sk_buff *skb, struct genl_info
>         return err;
>  }
>
> +static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
> +                                       struct genl_info *info)
> +{
> +       struct vdpa_dev_set_config set_config =3D {};
> +       const u8 *macaddr;
> +       struct vdpa_mgmt_dev *mdev =3D vdev->mdev;
> +       struct nlattr **nl_attrs =3D info->attrs;
> +       int err =3D -EINVAL;
> +
> +       if (!vdev->mdev)
> +               return -EINVAL;

It looks like the caller has already done this check?

> +
> +       down_write(&vdev->cf_lock);
> +       if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC)) &&

This is not a virtio feature, so I don't get why we need to check
VIRTIO_NET_F_MAC.

> +           nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> +               set_config.mask |=3D BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADD=
R);
> +               macaddr =3D nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACAD=
DR]);
> +
> +               if (is_valid_ether_addr(macaddr)) {
> +                       memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> +                       if (mdev->ops->dev_set_attr) {
> +                               err =3D mdev->ops->dev_set_attr(mdev, vde=
v,
> +                                                             &set_config=
);
> +                       } else {
> +                               NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +                                                      "device not suppor=
ted");

"Device does not support setting mac address" ?

> +                       }
> +               } else {
> +                       NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +                                              "Invalid MAC address");
> +               }
> +       }
> +       up_write(&vdev->cf_lock);
> +       return err;
> +}
> +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> +                                        struct genl_info *info)
> +{
> +       const char *name;
> +       int err =3D 0;
> +       struct device *dev;
> +       struct vdpa_device *vdev;
> +       u64 classes;
> +
> +       if (!info->attrs[VDPA_ATTR_DEV_NAME])
> +               return -EINVAL;
> +
> +       name =3D nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> +
> +       down_write(&vdpa_dev_lock);
> +       dev =3D bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
> +       if (!dev) {
> +               NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> +               err =3D -ENODEV;
> +               goto dev_err;
> +       }
> +       vdev =3D container_of(dev, struct vdpa_device, dev);
> +       if (!vdev->mdev) {
> +               NL_SET_ERR_MSG_MOD(
> +                       info->extack,
> +                       "Fail to find the specified management device");
> +               err =3D -EINVAL;
> +               goto mdev_err;
> +       }
> +       classes =3D vdpa_mgmtdev_get_classes(vdev->mdev, NULL);
> +       if (classes & BIT_ULL(VIRTIO_ID_NET)) {
> +               err =3D vdpa_dev_net_device_attr_set(vdev, info);
> +       } else {
> +               NL_SET_ERR_MSG_FMT_MOD(info->extack, "%s device not suppo=
rted",
> +                                      name);
> +       }
> +
> +mdev_err:
> +       put_device(dev);
> +dev_err:
> +       up_write(&vdpa_dev_lock);
> +       return err;
> +}
> +
>  static int vdpa_dev_config_dump(struct device *dev, void *data)
>  {
>         struct vdpa_device *vdev =3D container_of(dev, struct vdpa_device=
, dev);
> @@ -1497,6 +1576,11 @@ static const struct genl_ops vdpa_nl_ops[] =3D {
>                 .doit =3D vdpa_nl_cmd_dev_stats_get_doit,
>                 .flags =3D GENL_ADMIN_PERM,
>         },
> +       {
> +               .cmd =3D VDPA_CMD_DEV_ATTR_SET,
> +               .doit =3D vdpa_nl_cmd_dev_attr_set_doit,
> +               .flags =3D GENL_ADMIN_PERM,
> +       },
>  };
>
>  static struct genl_family vdpa_nl_family __ro_after_init =3D {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 7977ca03ac7a..3511156c10db 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -582,11 +582,20 @@ void vdpa_set_status(struct vdpa_device *vdev, u8 s=
tatus);
>   *          @dev: vdpa device to remove
>   *          Driver need to remove the specified device by calling
>   *          _vdpa_unregister_device().
> +  * @dev_set_attr: change a vdpa device's attr after it was create
> + *          @mdev: parent device to use for device
> + *          @dev: vdpa device structure
> + *          @config:Attributes to be set for the device.
> + *          The driver needs to check the mask of the structure and then=
 set
> + *          the related information to the vdpa device. The driver must =
return 0
> + *          if set successfully.
>   */
>  struct vdpa_mgmtdev_ops {
>         int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
>                        const struct vdpa_dev_set_config *config);
>         void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *d=
ev);
> +       int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_devic=
e *dev,
> +                           const struct vdpa_dev_set_config *config);
>  };
>
>  /**
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 842bf1201ac4..71edf2c70cc3 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -19,6 +19,7 @@ enum vdpa_command {
>         VDPA_CMD_DEV_GET,               /* can dump */
>         VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
>         VDPA_CMD_DEV_VSTATS_GET,
> +       VDPA_CMD_DEV_ATTR_SET,
>  };
>
>  enum vdpa_attr {
> --
> 2.45.0
>

Thanks


