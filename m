Return-Path: <netdev+bounces-160475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D27EA19DD0
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 05:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEB71885567
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 04:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A180A1ADC85;
	Thu, 23 Jan 2025 04:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzMUweKU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486921ADC75
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 04:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737608267; cv=none; b=abuQb2gp4k/61RXN1n6nJtsq7Ux31+wXyiA7EIwJFG+81xgB7bWTaSkfvx1X0b3qNcZZtrg/dUT6KHaNVp7FSKvcthiGPH1LFxDJAOq9yZHIy1CZhAmKGa1UL1WA/tJoCWlrUJIzmU3vbw3wTIZmPvzE9wDf/NweHZf56XKjgmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737608267; c=relaxed/simple;
	bh=gXGST6/fJwV5Do5lFRM2gwK3r63i8h21UsR/WokvCsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLubSghLd5js+mI7e76sSs2C5clZ2AbSGu+ZdA4G1nAPupBMOgCb4IqyVgkX2KtAJPZVasF1mm+La+mxnHXCulmbmJ23fjfWvHO5xwIOg4BeTMpJTZ7uI/GHHaw1GfVS7XhLW288As38akK00XwsRcd19/eehv7lZMX4r0qomZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzMUweKU; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e53c9035003so783754276.2
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 20:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737608264; x=1738213064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iLrSrrpPpe4BqQ40aqwnxmgvffYQ/EZQy8IbB10yas=;
        b=XzMUweKUuSR4HSPIw4abx+rgXGFdYW/J996lweTQTK591xZkMXZme5cXiPg3mh5kU6
         FlJfUoGYBicTXxcnmLxQ3Gig2XyFGyjcGR8UULbIdUhk1hYr5vGAcVIlQOlG9Uuc051X
         gIF5zVT0om/1Uc44Ms4CKQaOUkX0ZvCRGWODawv1TUWbgN3HIM7gDXnDF5aupTBm5MPq
         KAg2b8sPPlvHP+iiv8SvNQBFMewLUMbin5ARU/sP+bIWKMC8Fp3nLnDyK9WDRMLSiBgn
         DdnQUqgjVCfHDq/HsdtzgVA55n6PE0zRegWRHq7E4mxTlFacqX+JjSgpgyyFLP5QzDA2
         iFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737608264; x=1738213064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iLrSrrpPpe4BqQ40aqwnxmgvffYQ/EZQy8IbB10yas=;
        b=xTgPG8Y83a3Y2L41RMwcYDCbu1KyuOV0DbhhHhROd0HPUJx2YCSF0J6EoYgHX7KlA7
         I7TtZOY1I8yeFL8S07yvU1demYubDw0eIhv+gX/uaFabho+6LmHlZ9XFCxl0E4WmYOBe
         KPjigVGjqd+JtVuOZJ7VqBTAtI1EV7gMeiVD2tqyjUnOMtoEyIN1bCVvevQOle2IFjHP
         7fQdPkIY4FNAc+WP1kAWvgvsuzEnZkPI3RBlyeCw2UPiXGxbvj6pZ2bfCgfRr3RBj7Fk
         sag+2Il+qtn5x8JiR54wdMwRClzvnLCRMKEboucIjnheoqKOIYySyCprK+WduaxsWygd
         X9YQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3/ZS8NIseqIF8rzb1IzrNnKeakJCJ5GRPBUy6VfMbpvAR+QDZ4TlbFiKdVcknlQZPHi3qY48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLPJ8HhlH/KNplnujpE4KdXRmB1jdCqKIcJYeYytBs3yxh0cqh
	xZcXdOp8aW20cyq8z+0+0vKn4Du5wNgjvM85qYQsMzywOvG+voiyVAB1YzjyV8XmPHs9tCXSigp
	1fNMykMyi8535TOt72MMF67f/+y7IvIbPSXWA
X-Gm-Gg: ASbGnctmrJuDrbhZKLciXUSZkTLkDgIzvHECnYdy4W89xP/5P02zHNEOcOIkASTqvLg
	gnwN1Jbo3kVUNpKD1g339BcRQlQUYvXnUCX9Z98wBWTh+yMtj5SJhrwsEod+bbh15DKNjQw==
X-Google-Smtp-Source: AGHT+IHw30UHsHJMDbPUuK8hZBKTwSVtpKrIowAAcEbatGnNkbAkvD1p/2ygh9YC8YFN9vpyDnwchG1tI5ye+jHjemA=
X-Received: by 2002:a05:6902:2089:b0:e57:8bbb:b911 with SMTP id
 3f1490d57ef6-e57b106410emr16615739276.19.1737608264015; Wed, 22 Jan 2025
 20:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122131925.v2.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <CABBYNZKoXT4u4=KJZUvG4g1OEi+xQ-LchiH8gvEZURNTzJoQDw@mail.gmail.com>
In-Reply-To: <CABBYNZKoXT4u4=KJZUvG4g1OEi+xQ-LchiH8gvEZURNTzJoQDw@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Thu, 23 Jan 2025 12:57:17 +0800
X-Gm-Features: AbW1kvbTxTtlZSbyA9ivfrSgLdev-buUmaUqiyJmWXFScjR17gRUJCehKfNPqW8
Message-ID: <CADg1FFdt2mQsN4YjLTn=zp_+MahopN371EDiXQEbp+GTSaNtBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: Fix possible race with userspace of
 sysfs isoc_alt
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Thu, Jan 23, 2025 at 3:35=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Wed, Jan 22, 2025 at 12:20=E2=80=AFAM Hsin-chen Chuang <chharry@google=
.com> wrote:
> >
> > From: Hsin-chen Chuang <chharry@chromium.org>
> >
> > Use device group to avoid the racing. To reuse the group defined in
> > hci_sysfs.c, defined 2 callbacks switch_usb_alt_setting and
> > read_usb_alt_setting which are only registered in btusb.
> >
> > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control =
USB alt setting")
> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/bluetooth/btusb.c        | 42 ++++++++------------------------
> >  include/net/bluetooth/hci_core.h |  2 ++
> >  net/bluetooth/hci_sysfs.c        | 33 +++++++++++++++++++++++++
> >  3 files changed, 45 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 75a0f15819c4..bf210275e5b7 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2221,6 +2221,13 @@ static int btusb_switch_alt_setting(struct hci_d=
ev *hdev, int new_alts)
> >         return 0;
> >  }
> >
> > +static int btusb_read_alt_setting(struct hci_dev *hdev)
> > +{
> > +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> > +
> > +       return data->isoc_altsetting;
> > +}
> > +
> >  static struct usb_host_interface *btusb_find_altsetting(struct btusb_d=
ata *data,
> >                                                         int alt)
> >  {
> > @@ -3650,32 +3657,6 @@ static const struct file_operations force_poll_s=
ync_fops =3D {
> >         .llseek         =3D default_llseek,
> >  };
> >
> > -static ssize_t isoc_alt_show(struct device *dev,
> > -                            struct device_attribute *attr,
> > -                            char *buf)
> > -{
> > -       struct btusb_data *data =3D dev_get_drvdata(dev);
> > -
> > -       return sysfs_emit(buf, "%d\n", data->isoc_altsetting);
> > -}
> > -
> > -static ssize_t isoc_alt_store(struct device *dev,
> > -                             struct device_attribute *attr,
> > -                             const char *buf, size_t count)
> > -{
> > -       struct btusb_data *data =3D dev_get_drvdata(dev);
> > -       int alt;
> > -       int ret;
> > -
> > -       if (kstrtoint(buf, 10, &alt))
> > -               return -EINVAL;
> > -
> > -       ret =3D btusb_switch_alt_setting(data->hdev, alt);
> > -       return ret < 0 ? ret : count;
> > -}
> > -
> > -static DEVICE_ATTR_RW(isoc_alt);
> > -
> >  static int btusb_probe(struct usb_interface *intf,
> >                        const struct usb_device_id *id)
> >  {
> > @@ -4040,9 +4021,8 @@ static int btusb_probe(struct usb_interface *intf=
,
> >                 if (err < 0)
> >                         goto out_free_dev;
> >
> > -               err =3D device_create_file(&intf->dev, &dev_attr_isoc_a=
lt);
> > -               if (err)
> > -                       goto out_free_dev;
> > +               hdev->switch_usb_alt_setting =3D btusb_switch_alt_setti=
ng;
> > +               hdev->read_usb_alt_setting =3D btusb_read_alt_setting;
> >         }
> >
> >         if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
> > @@ -4089,10 +4069,8 @@ static void btusb_disconnect(struct usb_interfac=
e *intf)
> >         hdev =3D data->hdev;
> >         usb_set_intfdata(data->intf, NULL);
> >
> > -       if (data->isoc) {
> > -               device_remove_file(&intf->dev, &dev_attr_isoc_alt);
> > +       if (data->isoc)
> >                 usb_set_intfdata(data->isoc, NULL);
> > -       }
> >
> >         if (data->diag)
> >                 usb_set_intfdata(data->diag, NULL);
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index f756fac95488..5d3ec5ff5adb 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -641,6 +641,8 @@ struct hci_dev {
> >                                      struct bt_codec *codec, __u8 *vnd_=
len,
> >                                      __u8 **vnd_data);
> >         u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *s=
kb);
> > +       int (*switch_usb_alt_setting)(struct hci_dev *hdev, int new_alt=
s);
> > +       int (*read_usb_alt_setting)(struct hci_dev *hdev);
> >  };
> >
> >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> > diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> > index 041ce9adc378..887aa1935b1e 100644
> > --- a/net/bluetooth/hci_sysfs.c
> > +++ b/net/bluetooth/hci_sysfs.c
> > @@ -102,8 +102,41 @@ static ssize_t reset_store(struct device *dev, str=
uct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_WO(reset);
> >
> > +static ssize_t isoc_alt_show(struct device *dev,
> > +                            struct device_attribute *attr,
> > +                            char *buf)
> > +{
> > +       struct hci_dev *hdev =3D to_hci_dev(dev);
> > +
> > +       if (hdev->read_usb_alt_setting)
> > +               return sysfs_emit(buf, "%d\n", hdev->read_usb_alt_setti=
ng(hdev));
> > +
> > +       return -ENODEV;
> > +}
> > +
> > +static ssize_t isoc_alt_store(struct device *dev,
> > +                             struct device_attribute *attr,
> > +                             const char *buf, size_t count)
> > +{
> > +       struct hci_dev *hdev =3D to_hci_dev(dev);
> > +       int alt;
> > +       int ret;
> > +
> > +       if (kstrtoint(buf, 10, &alt))
> > +               return -EINVAL;
> > +
> > +       if (hdev->switch_usb_alt_setting) {
> > +               ret =3D hdev->switch_usb_alt_setting(hdev, alt);
> > +               return ret < 0 ? ret : count;
> > +       }
> > +
> > +       return -ENODEV;
> > +}
> > +static DEVICE_ATTR_RW(isoc_alt);
> > +
> >  static struct attribute *bt_host_attrs[] =3D {
> >         &dev_attr_reset.attr,
> > +       &dev_attr_isoc_alt.attr,
> >         NULL,
> >  };
> >  ATTRIBUTE_GROUPS(bt_host);
>
> While this fixes the race it also forces the inclusion of an attribute
> that is driver specific, so I wonder if we should introduce some
> internal interface to register driver specific entries like this.

Do you mean you prefer the original interface that only exports the
attribute when isoc_altsetting is supported?
Agree it makes more sense but I hit the obstacle: hci_init_sysfs is
called earlier than data->isoc is determined. I need some time to
verify whether changing the order won't break anything.

>
> > --
> > 2.48.1.262.g85cc9f2d1e-goog
> >
>
>
> --
> Luiz Augusto von Dentz

