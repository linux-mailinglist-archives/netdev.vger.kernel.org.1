Return-Path: <netdev+bounces-113226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A67393D3FC
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 15:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B4D9B20471
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E72E17B510;
	Fri, 26 Jul 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EH/NxXha"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B117838C
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999823; cv=none; b=QaVU21Rv5vWVS5aSDsOKKenqkjLspM4ifTEFeOV1bb84KH5oDeYGChcj57ppjxWkvPg3aU0nuGPBivODhcc4BzPU9xGAPB9hRAscGmJmrWz+6Cxgj52rn6Ki1pJTAGGVG6PAamrdOJX+TOUhsDhbmjS47P7L6Ez8+EMaqNnQDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999823; c=relaxed/simple;
	bh=E8TJ6MRlezfed8oV6XYbKMbJ33WOOqUbYyIaqIuvt2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bF18WaQh+f3kQcmi9VQdd2MkVDAfJr1x+CK+FHaCWS8tRzd2IKb3YqI2avTvdBkRWVuB4Lqa9NdQ2cfB7WcMNR/QZbXf+2gfYYNPVu1RMQRp2Q9Q07LqzPD092rXsCFmJMhvHsQt6rbTlgpQ6iGr3v/Q8nC1dpJj85h6AMBfBqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EH/NxXha; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721999821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vllFnlg84B30xrdVTJ9/E1KQIK8lYuMk6An3oA0P1n0=;
	b=EH/NxXhagzzQf2+ti+1fvY7xzBFXd8EDfHcmltXf7AxQv7F6IdteW8fI6DAoWaUfPoo0Bi
	spmAU2JIiPjh9TtL+lsdr7/2szwhhrUDrHgR8rlOj1TkU8QSAhWJuSoIDuSHPF4f6a7DaN
	f+0AF0mqx5YMVz2LCUat9vYk60xzfFU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-y4wB4rE6NxG7W15yEEY5bQ-1; Fri, 26 Jul 2024 09:17:00 -0400
X-MC-Unique: y4wB4rE6NxG7W15yEEY5bQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7aa054fb2eso80320366b.3
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 06:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999819; x=1722604619;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vllFnlg84B30xrdVTJ9/E1KQIK8lYuMk6An3oA0P1n0=;
        b=djIYctJYOl2JpEwwrrLEc+6TUP7N5QMkvUMR6w+Y371qDRBAuT/TOkSN16oC2dxqY2
         kEicxJi8RYT5AgKgNVEI744t9kITV8j/mnC1hwVTGhDmLbmDAVkU1QT61NcK3yGCQ6ij
         o3NYnMUb247dmWzM4H2qH9Tktd2DehQnu0BKlJqGqJ6JGfe11A+uvE0nCFsEVpjdc/Dc
         POl4XnPz92SCGPt5gu0s9ZiWZ8JI5nQopqHJ8Kfw2ap8UNsOhGKtmW1X8V38Z3IBRQF5
         VfwMPlLabFDNXwEFlexiV0e3U1+rl9OM64YYwQSeN2gLihsWugeK6L2uDpyLEli4afZg
         dLDw==
X-Forwarded-Encrypted: i=1; AJvYcCU+zIpNp2sQ+T7cbT62cI8JYm78CXFB0FJM2U+Of0R1OKytZNJh88acgeb3ayvRjsVRKBnJcBSSqCD0OKFXfxdULih2gpa0
X-Gm-Message-State: AOJu0YzlpQrxumGjPQibNJAGw7XlLYAX9vo9FbKd4PoXO7c0cDcAYFqm
	kUFyZCHCisEQ6KE492AITvN3W5N4xZzAJJeqF3ubxvKELNR5YuL1Q51A53DSiCTXuIJeUiRgcsC
	EBe4BEHS1NoH+54jSKX2q2V/1+jBNz49uLbV56Vu+pTZQNeEEcQScX+AKCMW+m7SA+6aFhS34Bp
	PE136jJwhZEKE4MsSz9bIXH+qk/O3E
X-Received: by 2002:a50:ab18:0:b0:5a2:6142:24c1 with SMTP id 4fb4d7f45d1cf-5ac6203a20amr5122268a12.5.1721999818734;
        Fri, 26 Jul 2024 06:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNMLKfBY9RgUZNbuxfkLr4bAwXidi3+wYsQGX8RjCIa2lMVc2O1E44vHMrqEn2jQlboMjIf0XHetK/IL3iMXI=
X-Received: by 2002:a50:ab18:0:b0:5a2:6142:24c1 with SMTP id
 4fb4d7f45d1cf-5ac6203a20amr5122229a12.5.1721999818239; Fri, 26 Jul 2024
 06:16:58 -0700 (PDT)
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
Date: Fri, 26 Jul 2024 21:16:20 +0800
Message-ID: <CACLfguUBQ7p8M+aUT5EjKmaBP2tNF6B3_AEhPTqC-66MD0CYcg@mail.gmail.com>
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
Cindy

Cindy
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
>
> > +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> > +                                      struct genl_info *info)
>
> Nit: Does the above pass ./scripts/checkpatch.pl --strict ? I am asking
> because it seems like the alignment might be off?
>
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


