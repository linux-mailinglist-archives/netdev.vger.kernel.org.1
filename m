Return-Path: <netdev+bounces-112505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9B4939996
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 08:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3431C21893
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 06:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFB913C838;
	Tue, 23 Jul 2024 06:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mu8RPrCD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CEB1E4BE
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721715407; cv=none; b=ExcJYz93selyb68duM9si6jMQ/A2kOqBgkFwc8ne/zFmeS9GWyPkePq2NePZj2Y4021fB3g9nl+S+BYPoo/60xqw25219AbG3DODiphpqv1ovJNe9xHrvUCO4LPSDgyldfOT6XHiVkvicIvaeAsT4Aw6ZP+pCgRWrhfngyDkRV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721715407; c=relaxed/simple;
	bh=TDAPJYlNNXL6/u9T+2aBYeR493uq1ZnAkIJCKgTpw+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OI1Hqsea2NGVCmRSJdK0bRQGagIZN7dj2DX8tf8Za7qrXm5qjCTmcknOR1mcLHwMiSHROvJUNQe8TRZ4mc66/2OZZ17hQ9hyEp2GggaT24k20DTTTvcer7vHhivKSu7a4OEYsQ58Hum/ZklhCj9WsQmYHSLNxYNStp0RlWPlOIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mu8RPrCD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721715404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GwretsHfxBM6reyjeplcxYx1DO8MB9d91mww/CN7l0Q=;
	b=Mu8RPrCDErUnx9Lq4Gwh0SmdUtU8rvEg5EJoWu/WrLZrjgd41E2QZaNQa3zxphi8nxuwF/
	1gbdm5CnvFUpR4R/evfXnBQLXzZTdnqyEENC7b5uUN8QFfR8hENl34Rfx+YJ8M2I0ijK/h
	y4n43hGmV3bm8ae4ygOmCqCeT0Wrtq8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-XYkgC0zSMq-XoQ_3oPsCaw-1; Tue, 23 Jul 2024 02:16:42 -0400
X-MC-Unique: XYkgC0zSMq-XoQ_3oPsCaw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ef311ad4bcso14891691fa.0
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 23:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721715401; x=1722320201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwretsHfxBM6reyjeplcxYx1DO8MB9d91mww/CN7l0Q=;
        b=seIF1Z1y31x6b2bBbyMST8HsN5p3t3fmYfpaMixQ65FsZz9UO8a6oLgpBIfLW+LOFx
         xtsZTNT4ESLtyL0abezoplrJoSmf0E+lhWOrMvMnTLvV8JhlJT6yZRYbtWaqnH82zuM4
         4vgyWbT9T6zdAT2ZzLkif7PCEWEn79tJ/N6VKcr9AavzIq12kZGH/IQShQOrzHLzVVIE
         XCPEV+AD5OYs7y+j2+q54tLxPAU04cbQ922wqYIwQc0r4/n7k8VMTTBszSpAqPqEbXfh
         MyDUbQHe9MvZNcuDxWdHU2B8fyV2/s6Bc37IWi8QA24p+owSeLAWK4v9rhsvzUlSMdvI
         0lzA==
X-Forwarded-Encrypted: i=1; AJvYcCUxSBnMRkc4qW92jKdr9JWCnSvg48aEAXNmhEJG7wzLeXvVORJV3o/CwjC0oYpk5X+ANnmkEHl8m30nBTPyjgf/c+MKzjFP
X-Gm-Message-State: AOJu0YzaYhH/zwBFAMBUFP/xfUKd+fbxJsISnXuHgk1726s9aVeHQsAb
	0EWJC9/0Mix4J8+8IwjV9mMWqqRg+pTq/IT/OD/RcUdM+7idNOescN6QjQJ1EFqLDhJeoUT/eZC
	P2I2ee4Fzy/gRCABdETk+BFPw7gobXjrmFUinCXpEXQ8ltaEwalyu47aCq8bnWipvAHWDtdrYcV
	8o3jtFWlv0IJof9m/aCdHCfLt8/zDC
X-Received: by 2002:a2e:95d6:0:b0:2ef:2608:2e47 with SMTP id 38308e7fff4ca-2ef26083b39mr46317611fa.13.1721715400675;
        Mon, 22 Jul 2024 23:16:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJf8UnmN3gB5DzdyjimO+vJJWP2Kg+yamwjyd++AXmIBiMCv8D5gFUtR7EDiNX3USoHnyIQWDJkbBJPW/Rm2g=
X-Received: by 2002:a2e:95d6:0:b0:2ef:2608:2e47 with SMTP id
 38308e7fff4ca-2ef26083b39mr46317411fa.13.1721715400244; Mon, 22 Jul 2024
 23:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <20240723054047.1059994-2-lulu@redhat.com>
 <CACGkMEuoYAkAxhZrZfyWpMV__eimDvNCWYogidC6qMpOVBh0aw@mail.gmail.com>
In-Reply-To: <CACGkMEuoYAkAxhZrZfyWpMV__eimDvNCWYogidC6qMpOVBh0aw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 23 Jul 2024 14:16:02 +0800
Message-ID: <CACLfguVAVsbRODBOXS9zX=tc-3xyCTYVas2XXLR+rpSLiPNC-g@mail.gmail.com>
Subject: Re: [PATH v5 1/3] vdpa: support set mac address from vdpa tool
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jul 2024 at 14:01, Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, Jul 23, 2024 at 1:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add new UAPI to support the mac address from vdpa tool
> > Function vdpa_nl_cmd_dev_attr_set_doit() will get the
> > new MAC address from the vdpa tool and then set it to the device.
> >
> > The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >
> > Here is example:
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
> > ---
> >  drivers/vdpa/vdpa.c       | 84 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/vdpa.h      |  9 +++++
> >  include/uapi/linux/vdpa.h |  1 +
> >  3 files changed, 94 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 8d391947eb8d..07d61ee62839 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -1361,6 +1361,85 @@ static int vdpa_nl_cmd_dev_config_get_doit(struc=
t sk_buff *skb, struct genl_info
> >         return err;
> >  }
> >
> > +static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
> > +                                       struct genl_info *info)
> > +{
> > +       struct vdpa_dev_set_config set_config =3D {};
> > +       const u8 *macaddr;
> > +       struct vdpa_mgmt_dev *mdev =3D vdev->mdev;
> > +       struct nlattr **nl_attrs =3D info->attrs;
> > +       int err =3D -EINVAL;
> > +
> > +       if (!vdev->mdev)
> > +               return -EINVAL;
>
> It looks like the caller has already done this check?
>
sure, will remove this
> > +
> > +       down_write(&vdev->cf_lock);
> > +       if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC)) &&
>
> This is not a virtio feature, so I don't get why we need to check
> VIRTIO_NET_F_MAC.
>
will remove this
> > +           nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > +               set_config.mask |=3D BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACA=
DDR);
> > +               macaddr =3D nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAC=
ADDR]);
> > +
> > +               if (is_valid_ether_addr(macaddr)) {
> > +                       memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> > +                       if (mdev->ops->dev_set_attr) {
> > +                               err =3D mdev->ops->dev_set_attr(mdev, v=
dev,
> > +                                                             &set_conf=
ig);
> > +                       } else {
> > +                               NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                                      "device not supp=
orted");
>
> "Device does not support setting mac address" ?
>
sure, will change this
Thanks
cindy
> > +                       }
> > +               } else {
> > +                       NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                              "Invalid MAC address");
> > +               }
> > +       }
> > +       up_write(&vdev->cf_lock);
> > +       return err;
> > +}
> > +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> > +                                        struct genl_info *info)
> > +{
> > +       const char *name;
> > +       int err =3D 0;
> > +       struct device *dev;
> > +       struct vdpa_device *vdev;
> > +       u64 classes;
> > +
> > +       if (!info->attrs[VDPA_ATTR_DEV_NAME])
> > +               return -EINVAL;
> > +
> > +       name =3D nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> > +
> > +       down_write(&vdpa_dev_lock);
> > +       dev =3D bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match)=
;
> > +       if (!dev) {
> > +               NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> > +               err =3D -ENODEV;
> > +               goto dev_err;
> > +       }
> > +       vdev =3D container_of(dev, struct vdpa_device, dev);
> > +       if (!vdev->mdev) {
> > +               NL_SET_ERR_MSG_MOD(
> > +                       info->extack,
> > +                       "Fail to find the specified management device")=
;
> > +               err =3D -EINVAL;
> > +               goto mdev_err;
> > +       }
> > +       classes =3D vdpa_mgmtdev_get_classes(vdev->mdev, NULL);
> > +       if (classes & BIT_ULL(VIRTIO_ID_NET)) {
> > +               err =3D vdpa_dev_net_device_attr_set(vdev, info);
> > +       } else {
> > +               NL_SET_ERR_MSG_FMT_MOD(info->extack, "%s device not sup=
ported",
> > +                                      name);
> > +       }
> > +
> > +mdev_err:
> > +       put_device(dev);
> > +dev_err:
> > +       up_write(&vdpa_dev_lock);
> > +       return err;
> > +}
> > +
> >  static int vdpa_dev_config_dump(struct device *dev, void *data)
> >  {
> >         struct vdpa_device *vdev =3D container_of(dev, struct vdpa_devi=
ce, dev);
> > @@ -1497,6 +1576,11 @@ static const struct genl_ops vdpa_nl_ops[] =3D {
> >                 .doit =3D vdpa_nl_cmd_dev_stats_get_doit,
> >                 .flags =3D GENL_ADMIN_PERM,
> >         },
> > +       {
> > +               .cmd =3D VDPA_CMD_DEV_ATTR_SET,
> > +               .doit =3D vdpa_nl_cmd_dev_attr_set_doit,
> > +               .flags =3D GENL_ADMIN_PERM,
> > +       },
> >  };
> >
> >  static struct genl_family vdpa_nl_family __ro_after_init =3D {
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index 7977ca03ac7a..3511156c10db 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -582,11 +582,20 @@ void vdpa_set_status(struct vdpa_device *vdev, u8=
 status);
> >   *          @dev: vdpa device to remove
> >   *          Driver need to remove the specified device by calling
> >   *          _vdpa_unregister_device().
> > +  * @dev_set_attr: change a vdpa device's attr after it was create
> > + *          @mdev: parent device to use for device
> > + *          @dev: vdpa device structure
> > + *          @config:Attributes to be set for the device.
> > + *          The driver needs to check the mask of the structure and th=
en set
> > + *          the related information to the vdpa device. The driver mus=
t return 0
> > + *          if set successfully.
> >   */
> >  struct vdpa_mgmtdev_ops {
> >         int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
> >                        const struct vdpa_dev_set_config *config);
> >         void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device =
*dev);
> > +       int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_dev=
ice *dev,
> > +                           const struct vdpa_dev_set_config *config);
> >  };
> >
> >  /**
> > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > index 842bf1201ac4..71edf2c70cc3 100644
> > --- a/include/uapi/linux/vdpa.h
> > +++ b/include/uapi/linux/vdpa.h
> > @@ -19,6 +19,7 @@ enum vdpa_command {
> >         VDPA_CMD_DEV_GET,               /* can dump */
> >         VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
> >         VDPA_CMD_DEV_VSTATS_GET,
> > +       VDPA_CMD_DEV_ATTR_SET,
> >  };
> >
> >  enum vdpa_attr {
> > --
> > 2.45.0
> >
>
> Thanks
>


