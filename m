Return-Path: <netdev+bounces-108348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCC891EFFB
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F451F20CCA
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 07:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0479E130A47;
	Tue,  2 Jul 2024 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIymyHPO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278112EBE3
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905145; cv=none; b=A9lHXvKg7S8MKG9oHWCEDQu/8n+ozQTxxjpDdEQcE9Xt+z1VVpulFSXL82ViYD4vfuGYcma/9o2gihTnvbdGpNpFvRV0EBFjKOnWttuJfreUfxnKswQFxxYFl6GRG0lJEjfBbZnARd2h3cex4Hk7B+yDoEdT0aqdza7SrqjWQmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905145; c=relaxed/simple;
	bh=+ge6tAmaVPb2bOPqgXQXLi1bjghpjzxR3PeUjmC6ZFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nahG0UrNyfdAHf53tc/M9H2Q7aLSKnq0fusxSD8ehWdK8+4DW2FWLG5eb2bi/oe4zvU+OdWxNW/k3AgLphtczDxIp4hfclKo0NViYpa7C6GWzShI+vGGeFhl3pLOhcdEDXgOLKiXxGHMCDaw27tGHcSpx/qZA/phUnURiyPAWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIymyHPO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719905143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4ZYA4VwwgmhzsjOOvPpKnWtY4b2oQ9ob1D+VTZtWSA=;
	b=dIymyHPOAdawZF2rrt6dy8qKiTi0JrfKSNVnONnPm166rLJ7hvfZJUPxp3roeZcTBbyrjF
	Vbm2crWL+oeUOlsWISxYa4dwxAkXqaulSuMhw3cqLfm+gEtQ49QmBzefU202Ca23GkqUia
	ndS0I0H7rXZeqYXI4Jve6ElP+ZGylZA=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-gMlalewwNJOPbNtm7pdo_Q-1; Tue, 02 Jul 2024 03:25:37 -0400
X-MC-Unique: gMlalewwNJOPbNtm7pdo_Q-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-25c9cf90f74so3278673fac.3
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 00:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719905137; x=1720509937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4ZYA4VwwgmhzsjOOvPpKnWtY4b2oQ9ob1D+VTZtWSA=;
        b=u93ZUQGZ7lE0sK0rFHJdDw4BOm9nqRNgL6QJqm3HKrLGZD2dJrP3W+slW/CUE2c0oX
         9H16YLYQUlAU3cdP25A4ZN5rFEJUACoRXCX75q1hV6A9JY7B4Fwh7JbRf9oDhAcg0LDo
         XDU5QDhcWRQostLbCh51El5nNZ2aGeEl/MAziBgmclofGH0V8J6W7vkioPrw6BlqtsYf
         307yn5Dbg+YUZUF9MF0NvYwWLB69KVFX/M6TKqFkl+VpqGJXzuQ0vCSDD2lqgSEw38sK
         00XozVFTlgQ+/nOqR+M7EXMm7M7+X4QeT5kXykiZ98YR3vrhlw8wAt3WzF62DzHwWSf3
         xMAA==
X-Forwarded-Encrypted: i=1; AJvYcCVnBLYlzlRt3mbgUZYWY4dR8RJ12ZC5Rs3+ewwcKb9hQjoWXZFRLPcH2DJkGhHvLOgYyCCbVjh/WQ2b9go0g2KLn90rglDk
X-Gm-Message-State: AOJu0YxR+I0AoK9YDgOVfgPmj0p5qhuKWc73aUCEoz/4U7AVfy13YJhq
	8tVPbBwvLZw+8eZuUJlJFLXTKdaVf9kW5IgIRNO2wWcyNEem+jxKD1MQyUUeRA2j7z/LErdhf+j
	boDDGDTAbhgwSJGX1iFALS5zGUkDcl1t65mLTIlBe1i01vxpKE74OJA5fKwhV59/xEIN+bFl7RM
	Dmwh4ziCD9mvdppUBLCeK9wccCWid8
X-Received: by 2002:a05:6870:fb93:b0:255:1a08:ff25 with SMTP id 586e51a60fabf-25db3716474mr4936750fac.52.1719905136654;
        Tue, 02 Jul 2024 00:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcuxoh9oBaDGraYXUM9EK2lEIF9vnX3/3hqZm9mlN/EmPlc5hdJVF00K2j42YHOJVsz6YIrEKnUABXLMEZH/E=
X-Received: by 2002:a05:6870:fb93:b0:255:1a08:ff25 with SMTP id
 586e51a60fabf-25db3716474mr4936741fac.52.1719905136235; Tue, 02 Jul 2024
 00:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701051239.112447-1-lulu@redhat.com> <20240701051239.112447-2-lulu@redhat.com>
In-Reply-To: <20240701051239.112447-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 2 Jul 2024 15:25:24 +0800
Message-ID: <CACGkMEsZHYeh7zxx-OE0yN91oZfAQcodQ2uSOiBSLRWAYPc53w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vdpa: support set mac address from vdpa tool
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 1:12=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
>  drivers/vdpa/vdpa.c       | 73 +++++++++++++++++++++++++++++++++++++++
>  include/linux/vdpa.h      |  2 ++
>  include/uapi/linux/vdpa.h |  1 +
>  3 files changed, 76 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index a7612e0783b3..0b70610a4c7f 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1149,6 +1149,74 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct =
sk_buff *skb, struct genl_info
>         return err;
>  }
>
> +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> +                                        struct genl_info *info)
> +{
> +       struct vdpa_dev_set_config set_config =3D {};
> +       struct nlattr **nl_attrs =3D info->attrs;
> +       struct vdpa_mgmt_dev *mdev;
> +       const u8 *macaddr;
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
> +       mdev =3D vdev->mdev;
> +       classes =3D vdpa_mgmtdev_get_classes(mdev, NULL);
> +       if ((classes & BIT_ULL(VIRTIO_ID_NET)) &&
> +           nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> +               if (!(mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC=
))) {
> +                       NL_SET_ERR_MSG_FMT_MOD(
> +                               info->extack,
> +                               "Missing features 0x%llx for provided att=
ributes",
> +                               BIT_ULL(VIRTIO_NET_F_MAC));
> +                       err =3D -EINVAL;
> +                       goto mdev_err;
> +               }
> +               macaddr =3D nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACAD=
DR]);
> +               memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> +               set_config.mask |=3D BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADD=
R);
> +               if (mdev->ops->dev_set_attr) {
> +                       err =3D mdev->ops->dev_set_attr(mdev, vdev, &set_=
config);
> +               } else {
> +                       NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +                                              "features 0x%llx not suppo=
rted",
> +                                              BIT_ULL(VIRTIO_NET_F_MAC))=
;
> +               }
> +
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
> @@ -1285,6 +1353,11 @@ static const struct genl_ops vdpa_nl_ops[] =3D {
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
> index db15ac07f8a6..e8bb274887ef 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -581,6 +581,8 @@ struct vdpa_mgmtdev_ops {
>         int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
>                        const struct vdpa_dev_set_config *config);
>         void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *d=
ev);
> +       int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_devic=
e *dev,
> +                           const struct vdpa_dev_set_config *config);

Let's add a doc for this new op.

Others look good.

Thanks

>  };
>
>  /**
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 54b649ab0f22..76b3a1fd13f3 100644
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


