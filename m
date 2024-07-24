Return-Path: <netdev+bounces-112713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC7793AB2B
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 04:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4551C22EF4
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 02:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42CA14006;
	Wed, 24 Jul 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBd/pLv3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D61C6A3
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787544; cv=none; b=qpK1qCtIWviSe394QpKQKT4M9PwYU9LzmxTLuRXrNzU9xW9Q0jYykrmP8PaTI4XSV2LgDn+EJZBgchFixaXUNi5rV5I0HJHpkd7daV7kzcgbuHmiDJ48v0SwSNGL3fLSQdg61e2lWZR6iPR7BXik+mjGymD+cfEVkfhVxIUCfJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787544; c=relaxed/simple;
	bh=pvLH4gHm4FBYDuFbbBP4fMwtKLA49f5CaaWi0YuUzAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNzVuLRo5eKTILeIQOpvWkROpJy4y0llafrUAsDhs+grmosk2SUqKTQiMrgO2EwAeD0TjQGWaF1XIaCyXrVabSnx0wkCRxsqNY1w9/24+SwgoBMOObE8ZexQkmwUeGl9mMTGJCDylBNB1xc2O3dTaEkVoODnffu6oHsYe50zz4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBd/pLv3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721787541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ehtuLszjv4cOJgMAfliSF/UD4RjIXwvAD86bpdUkiuk=;
	b=WBd/pLv3+DGU+LfdXdoil2Y47mMKTLG9tm0klO0ywUZn5qpXuv/uqRXuOhBagRFX3Q1DD3
	FYFR0PGyj5RshUO0Ebh1g5pua9Su2jY5EHHOSzwNuZ5C5ejT5ZfkmPoTIidPAKb8sL0WLp
	3Qes+3/ve2YAcAOTQV39V7eEK0is7jM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-pT21XcujMVqHEr97VpzLTQ-1; Tue, 23 Jul 2024 22:12:53 -0400
X-MC-Unique: pT21XcujMVqHEr97VpzLTQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef286cf0e8so32341081fa.0
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 19:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721787171; x=1722391971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehtuLszjv4cOJgMAfliSF/UD4RjIXwvAD86bpdUkiuk=;
        b=U5hocRl284LY/nDcut468Z0VjEuL7aXcYCLpvVoDlCstYQRhNYAJ2yZ9T9VKjeUhmd
         giVbJKppK/c23P25JQT/07xwx0uTfwqNuIc/WAl8RBhT+OuCQYKrbFT57C1aRepsoGku
         cFCxPcq+UP++ddIJ+mezySkqeiKQkyBALa1JSAyIUz5tY9qIriBTv86I/UMubuOfyJFp
         XeF+ln5mLTgkjCpoJDdc6r/ox1sF/mHZf1Omgjw+AzEAqPcMwnrkVbzrY6C0idOwluQN
         7KQfwy8U/2f+qUCMnWLNxfc2Wl52tCqYrdfwQ/uZ2hTYRA2iorEqs8JmzuFxW5pF0CY6
         LFQA==
X-Forwarded-Encrypted: i=1; AJvYcCW1m7WM/sSPoZLyXENI8yuHposJmCDIOWMibLEt3VglhGv5M5EgJoBDIK41LMWzNnvZt6ZPSgVVfN9a+cnWhU7GYW62XXYT
X-Gm-Message-State: AOJu0YzsVpSRzzaUnotpdZ1jbH/XBeAiKYGz5qMVd108p+HUrr2GPPnv
	rTUxw9a0LQ6/C+shGJ7Wqyt3fiH8OaWuvZDglf2mAjZ/QPerQYRVEvlsBGGJfA5MOBv462LY39t
	8hZL4gUNtXxOPpFpz1sxoBKZe6IdyczuqodFTS9FnLDwc7L0xR1UZSNjHDw1LyOeE7EHLIw84uc
	YrKXbzRT3yHCMBj0FPxp24sYfcZr9U
X-Received: by 2002:a2e:2e09:0:b0:2ef:2b45:b71d with SMTP id 38308e7fff4ca-2f02b741b1cmr9587761fa.24.1721787171643;
        Tue, 23 Jul 2024 19:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2haBDetr3B12GRUddIecLnBaa3DkGcUp0iNR3ZPqOWC2HtbRoOF28NQwySlFGXAweIO8RddD9ZSszJMao+28=
X-Received: by 2002:a2e:2e09:0:b0:2ef:2b45:b71d with SMTP id
 38308e7fff4ca-2f02b741b1cmr9587621fa.24.1721787171177; Tue, 23 Jul 2024
 19:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <20240723054047.1059994-2-lulu@redhat.com>
 <8ff8f8d8-1061-42a2-b238-82f685639115@lunn.ch>
In-Reply-To: <8ff8f8d8-1061-42a2-b238-82f685639115@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 24 Jul 2024 10:12:14 +0800
Message-ID: <CACLfguUf-HtNqL9ykGGY_XCQadUS7fJR+kn3q7S+cH7aUGmqYg@mail.gmail.com>
Subject: Re: [PATH v5 1/3] vdpa: support set mac address from vdpa tool
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 02:48, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Jul 23, 2024 at 01:39:20PM +0800, Cindy Lu wrote:
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
> > @@ -1361,6 +1361,85 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
> >       return err;
> >  }
> >
> > +static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
> > +                                     struct genl_info *info)
> > +{
> > +     struct vdpa_dev_set_config set_config = {};
> > +     const u8 *macaddr;
> > +     struct vdpa_mgmt_dev *mdev = vdev->mdev;
> > +     struct nlattr **nl_attrs = info->attrs;
> > +     int err = -EINVAL;
> > +
> > +     if (!vdev->mdev)
> > +             return -EINVAL;
> > +
> > +     down_write(&vdev->cf_lock);
> > +     if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC)) &&
> > +         nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > +             set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> > +             macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> > +
> > +             if (is_valid_ether_addr(macaddr)) {
> > +                     memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> > +                     if (mdev->ops->dev_set_attr) {
> > +                             err = mdev->ops->dev_set_attr(mdev, vdev,
> > +                                                           &set_config);
> > +                     } else {
> > +                             NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                                    "device not supported");
> > +                     }
> > +             } else {
> > +                     NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                            "Invalid MAC address");
> > +             }
> > +     }
> > +     up_write(&vdev->cf_lock);
> > +     return err;
> > +}
> > +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> > +                                      struct genl_info *info)
> > +{
> > +     const char *name;
> > +     int err = 0;
> > +     struct device *dev;
> > +     struct vdpa_device *vdev;
> > +     u64 classes;
> > +
> > +     if (!info->attrs[VDPA_ATTR_DEV_NAME])
> > +             return -EINVAL;
> > +
> > +     name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> > +
> > +     down_write(&vdpa_dev_lock);
> > +     dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
> > +     if (!dev) {
> > +             NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> > +             err = -ENODEV;
> > +             goto dev_err;
> > +     }
> > +     vdev = container_of(dev, struct vdpa_device, dev);
> > +     if (!vdev->mdev) {
> > +             NL_SET_ERR_MSG_MOD(
> > +                     info->extack,
> > +                     "Fail to find the specified management device");
> > +             err = -EINVAL;
> > +             goto mdev_err;
> > +     }
> > +     classes = vdpa_mgmtdev_get_classes(vdev->mdev, NULL);
> > +     if (classes & BIT_ULL(VIRTIO_ID_NET)) {
> > +             err = vdpa_dev_net_device_attr_set(vdev, info);
> > +     } else {
> > +             NL_SET_ERR_MSG_FMT_MOD(info->extack, "%s device not supported",
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
> >       struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
> > @@ -1497,6 +1576,11 @@ static const struct genl_ops vdpa_nl_ops[] = {
> >               .doit = vdpa_nl_cmd_dev_stats_get_doit,
> >               .flags = GENL_ADMIN_PERM,
> >       },
> > +     {
> > +             .cmd = VDPA_CMD_DEV_ATTR_SET,
> > +             .doit = vdpa_nl_cmd_dev_attr_set_doit,
> > +             .flags = GENL_ADMIN_PERM,
> > +     },
> >  };
> >
> >  static struct genl_family vdpa_nl_family __ro_after_init = {
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index 7977ca03ac7a..3511156c10db 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -582,11 +582,20 @@ void vdpa_set_status(struct vdpa_device *vdev, u8 status);
> >   *        @dev: vdpa device to remove
> >   *        Driver need to remove the specified device by calling
> >   *        _vdpa_unregister_device().
> > +  * @dev_set_attr: change a vdpa device's attr after it was create
> > + *        @mdev: parent device to use for device
>
> The indentation looks a bit odd here.
>
>     Andrew
>
sure, Will fix this
thanks
cindy
> ---
> pw-bot: cr
>


