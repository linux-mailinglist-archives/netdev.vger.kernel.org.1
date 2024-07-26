Return-Path: <netdev+bounces-113230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EAC93D40C
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 15:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC501C234EB
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 13:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340D717B511;
	Fri, 26 Jul 2024 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgSND7wn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8616978C8D
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000020; cv=none; b=Y3h51wgPVFRF3y6331ni6Tg/Nyoazerv49BdoVGaPq5hjdyrfGrfHX7Ss7ACph5ig22PYAWgrqSPcSN591Elh1r2gVf5STo5I9p4bjaX8VY0mC1qnBFM++bjddvNZ1SKCojifgmQYgO0QNcisALs6zStelbiE8NKKNM+uz9v2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000020; c=relaxed/simple;
	bh=okBVGW+4Ldc/gYbopPMTEK9G1vsz0TiBtRfOBBB3ybs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OZwd0fe7H3mkI7435XjjRjQ2HsoOgAjLtzmtR/scVvZLn6NYIJD5RMSmUBdF33NIxpDX9/vjipJAmK+PNxII2Ds6S2kquP9w3pkvYyErGvGyxhUet1hT+W8/hgIXSU54ERtmlAr+gFmyr0SZMlrshuHX7+TYw3iDq1cOrgH3vYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgSND7wn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722000017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhcUQuVGN/p5AORVU51L+UH99nfvjtvJ6aAvMYY+bH4=;
	b=KgSND7wnvrJXZThhOJcqsJIbzjZUGySQsrYjHrk+h8EDa/dGV41n+qlNAKbC+yjx42Iml1
	U1pibKvi45GjFt/bZ3tw8Zvbh6RPrFCyi9A1N+nP3YaAFKtrDkfyQEehxWOurep5t1+OU6
	SrF8SaesGQsSFeSICVq8QzrXOty9FRA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-7sh6M5Y4Odmo6wx8SqtJKA-1; Fri, 26 Jul 2024 09:20:14 -0400
X-MC-Unique: 7sh6M5Y4Odmo6wx8SqtJKA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a4c36f66c3so1631632a12.3
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 06:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722000013; x=1722604813;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhcUQuVGN/p5AORVU51L+UH99nfvjtvJ6aAvMYY+bH4=;
        b=Pfv3Njog/iKDL6++Kt1lzQ/PZrMAiKPpJF4Of/RR3gBqg/M1p5KTuucaMZnrA1HAVC
         TGNEoiP9oEDgTas1QIpJcd0Wd5HFRt5y1i+JoebArUxTF8ga9cTRbCMWlXM61uwvRZR0
         mFyJfXHiSnWpYkdWBRfZBa/1IPMrbkMsZdQ2xmd8f1IKFrREJ0YM/jKzTEZXVJWl0ZzW
         cIcjaDfUlGIaJTGYNPyliSlR31hzw1lGlFxBjZe4G1uF8nuzkbPj3IMwX10KtznXRJRo
         o3cHe3mWH7tGtCaQWXWQlhlztCDX5HCAejpMn0iXV8N5yOe9JBPUyHQpSKoDwfFws1jy
         19pA==
X-Forwarded-Encrypted: i=1; AJvYcCXJPjBFI+TTaD5Ae8PdH0mnp3MAI2Ms8/2/To6OBcVMI4wZd3hC+/JDCxLdZ7yltQ9x/DQkogAuj5zh6wH3b7cE1bLyKG8C
X-Gm-Message-State: AOJu0YxUYYxve//hh4wqcVXxHFtzyfNWXLNtdYpjLmtd+ia+kcBB0VHy
	bE18qJJWwMo+xN0xxePoZkGB542yFplmupl3li0xefofu36ny/TH7ImUzoRT2qYaSrtq0jKIX/N
	O5ltoCzCnDWqy9P70QWeYm3mLGRODTE4u56Wnsbrtvd7pfcu4mWUTV5TL2tOC/bcbxAH3RRTVy5
	A9A7Q56EP8B3gqF2qoAkfsLouKWov+
X-Received: by 2002:a50:c04d:0:b0:5a3:b45:3970 with SMTP id 4fb4d7f45d1cf-5ac27750881mr3153319a12.0.1722000013059;
        Fri, 26 Jul 2024 06:20:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtB78u5qVHemteUb/n5/CBlV2qDcx0mVsZ+2chC9WujC4lrXXqlD2osHIxxTvD60+aLUAhJOP6uvrm/JcF0xc=
X-Received: by 2002:a50:c04d:0:b0:5a3:b45:3970 with SMTP id
 4fb4d7f45d1cf-5ac27750881mr3153306a12.0.1722000012559; Fri, 26 Jul 2024
 06:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725013217.1124704-1-lulu@redhat.com> <20240725013217.1124704-2-lulu@redhat.com>
 <ZqKLd9ZIJ4l5tAL8@LQ3V64L9R2>
In-Reply-To: <ZqKLd9ZIJ4l5tAL8@LQ3V64L9R2>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 26 Jul 2024 21:19:34 +0800
Message-ID: <CACLfguU1pBgRLQwUXXX70ROhy41KvFuHd_08_t-YXS75hsafzg@mail.gmail.com>
Subject: Re: [PATH v6 1/3] vdpa: support set mac address from vdpa tool
To: Joe Damato <jdamato@fastly.com>, Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, 
	mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 01:29, Joe Damato <jdamato@fastly.com> wrote:
>
> On Thu, Jul 25, 2024 at 09:31:02AM +0800, Cindy Lu wrote:
> [...]
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 8d391947eb8d..532cf3b52b26 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -1361,6 +1361,81 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
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
>
> Nit: IIRC networking code prefers reverse-xmas tree style and
> macaddr above needs to be moved.
>
will fix  this
thanks
cindy
> > +     down_write(&vdev->cf_lock);
> > +     if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > +             set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> > +             macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> > +
> > +             if (is_valid_ether_addr(macaddr)) {
> > +                     ether_addr_copy(set_config.net.mac, macaddr);
> > +                     memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> > +                     if (mdev->ops->dev_set_attr) {
> > +                             err = mdev->ops->dev_set_attr(mdev, vdev,
> > +                                                           &set_config);
> > +                     } else {
> > +                             NL_SET_ERR_MSG_FMT_MOD(
> > +                                     info->extack,
> > +                                     "device does not support changing the MAC address");
> > +                     }
> > +             } else {
> > +                     NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                            "Invalid MAC address");
> > +             }
> > +     }
> > +     up_write(&vdev->cf_lock);
> > +     return err;
> > +}
>
> Nit: other code in this file has line breaks separating functions.
> Probably good to add one here?
>
sure will change this
thanks
Cindy
>
> > +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> > +                                      struct genl_info *info)
>
> Nit: Does the above pass ./scripts/checkpatch.pl --strict ? I am asking
> because it seems like the alignment might be off?
>
I tried this, but there doesn't seem to have warning. I'll double-check this.
Thanks
cindy
> > +{
> > +     const char *name;
> > +     int err = 0;
> > +     struct device *dev;
> > +     struct vdpa_device *vdev;
> > +     u64 classes;
>
> Nit: Same as above; I believe networking code is supposed to follow
> reverse xmas tree order so these variables should be rearranged.
>
will fix  this

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
> > +             NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
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
>
> [...]
>


