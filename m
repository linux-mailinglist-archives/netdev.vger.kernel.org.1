Return-Path: <netdev+bounces-160826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80C9A1B9F7
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 17:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1702E162E97
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDA915688C;
	Fri, 24 Jan 2025 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGFKrLz3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB415C120;
	Fri, 24 Jan 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734822; cv=none; b=Rlrf4W9LvasTJRicZG4r2r44ddBhAksUuXvm7asH14bkJJDUxUtknCxGVKe0fThHUQtFnf9tWAofAotz3U0PtRGi6iBkI0r/RzVizO71xnBPOmrOfyFpgeas/8IeBoDLwpafQkD/WB+SgRrEb/QZxIkYQbQ3G30VnbGYu3H3yf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734822; c=relaxed/simple;
	bh=Xg/zFkhNFdxzzxD1FJUR3gV5+xFOECyixQLzK3uV3nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZnHID49zcaDKWgilr9EuEwGlY4UhlXuNPbkLw+MNW4PTGJYDx+9TI5UrR/PQDXqyal3UHB834xCdDfXytucZxOSsGvuSN47ZGRm3MSmo1mt8RfmpeU1Dw4L0xrdHwjojatPQRstaYsNQz5VrMY/rcRrpMKXnpq4qNGC/es0rQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGFKrLz3; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30761be8fa7so23040641fa.2;
        Fri, 24 Jan 2025 08:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737734818; x=1738339618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBgJVnTlF1zTLD/T+wwFneTc6TjdTb9VUTzxEiiL4Vg=;
        b=iGFKrLz3WrRIMfLNp+c0B3vybG5MEJmAjFVd6lbEBf63AkkLKu/J6tXJ/N0e952Lfr
         DKfoANlXWPHUjMZRJg4v7eK+HxU/Wqwu44yJdYAnkOhUSNkgdtKIy+QCpW2gP147jd5F
         gtpFDMRrFMvAcIGc7WuZ/F8DhhuuqDspSOwmvpFX49WeSTpxGh5NvzF7PPxnPhI7fWUb
         zsK5dQTG9WkNgIqO+3D+Mjf+2OjvN4tPeB+z3n9VzAncAYV3t5tpbyCXUyvlaJJyMK5O
         Ci/3dQhxPq5YIWdvyRarIKdihffFziGWTVL6OAvZjY49MIO27No5qleDuRqjJZtBQra+
         RkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737734818; x=1738339618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBgJVnTlF1zTLD/T+wwFneTc6TjdTb9VUTzxEiiL4Vg=;
        b=SHSgtyK4RpmTJe6u0dvCq0ixpMKfabKeY+kRKNi6y82y8dqhNCTj75cRjhmI4/22vn
         Xy3q74jeTnRT+xcCA83b3K1r3YLXaXAmqkutdZwZejXesMuYoffjkAQsxkoo5E98gCLF
         C4BYWFgjCqCkQbRtGRokxflEmsRTSCPpTsfuxjVwmvsDed46WgY6a3gA9/2yCURWj0Zl
         jMnijRPfAva0cD70Pce70AjkTtv52oMZ+GSXcUO/5xmT1qg0pLuSQlA3ytdBH/lbhrvw
         p1Cl/b6WMhZwLbV1UyU3bEaLdMSivEuTtMEoDYPqpfRbHCDJJuLKv/NaUQo6hL3opkBB
         hrnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPNmn2KBYbi3LCLpS4QOQEGVRx87d8f+CP463wl8UHPt9V/tjwx2baq76IG8CF6O0Wn1THxuseGzOcsTQ=@vger.kernel.org, AJvYcCWGBVuX1nWTkNhJBvg45zDG8b3Dc1J8sgeqD3ILnAvXxFDGsMbn6Syx46gQ+EmC18oWu0GetFRM@vger.kernel.org
X-Gm-Message-State: AOJu0YxuQxN//QmLw6/STr8gl0qTVkSbGEJO3sjoQNTRoG8Mdil7O8PQ
	Ndb5Km6gUAX5AEpFNJSLWSnd6322RM7yPLGkpE3/HT5405zmu4KSaKsLT9HheQTtQXkturDBKKw
	oOgJg4fd7kt/BNfHR5aKE+atUstw=
X-Gm-Gg: ASbGncsIz5FMkPh7e5sHta/AEUsP40hlv2bLLV0eTpB5eao3a1ehGqSEwzl4+TOMJdc
	uhbp/dilr5dGrGQS8le2n65b3zOLgfDaV9R4zHeqSikL/z+4TCsLgaxo9pIfnkl8=
X-Google-Smtp-Source: AGHT+IFzEcfJwJbmSGmxxJuOHDdTToHqdDgSmLqq3NDRAC9IeNTwW37Z/VvDDmE5lXdVKM9Ysce5REuNrHaRDFhKerY=
X-Received: by 2002:a2e:be06:0:b0:302:1d8e:f4fd with SMTP id
 38308e7fff4ca-3072cb3f528mr115560681fa.35.1737734817939; Fri, 24 Jan 2025
 08:06:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122131925.v2.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <CABBYNZKoXT4u4=KJZUvG4g1OEi+xQ-LchiH8gvEZURNTzJoQDw@mail.gmail.com>
 <CADg1FFdt2mQsN4YjLTn=zp_+MahopN371EDiXQEbp+GTSaNtBg@mail.gmail.com> <CABBYNZJ__OMJZtEE0BFpaUdKPQv+Ym-OnsJj-kN=i_gZCeVN5w@mail.gmail.com>
In-Reply-To: <CABBYNZJ__OMJZtEE0BFpaUdKPQv+Ym-OnsJj-kN=i_gZCeVN5w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Jan 2025 11:06:45 -0500
X-Gm-Features: AWEUYZlKNKW8jZkP7zAqAhu9WL1EgeEReJVF89WWI_jRmA658Xl4Bp-mbELYrxM
Message-ID: <CABBYNZ+aEpJNnz1OSAeqOxFf4s2AbvoRC+FJcRS6y5+g0Mmu+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: Fix possible race with userspace of
 sysfs isoc_alt
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Fri, Jan 24, 2025 at 10:54=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Wed, Jan 22, 2025 at 11:57=E2=80=AFPM Hsin-chen Chuang <chharry@google=
.com> wrote:
> >
> > Hi Luiz,
> >
> > On Thu, Jan 23, 2025 at 3:35=E2=80=AFAM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Hsin-chen,
> > >
> > > On Wed, Jan 22, 2025 at 12:20=E2=80=AFAM Hsin-chen Chuang <chharry@go=
ogle.com> wrote:
> > > >
> > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > >
> > > > Use device group to avoid the racing. To reuse the group defined in
> > > > hci_sysfs.c, defined 2 callbacks switch_usb_alt_setting and
> > > > read_usb_alt_setting which are only registered in btusb.
> > > >
> > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to cont=
rol USB alt setting")
> > > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  drivers/bluetooth/btusb.c        | 42 ++++++++--------------------=
----
> > > >  include/net/bluetooth/hci_core.h |  2 ++
> > > >  net/bluetooth/hci_sysfs.c        | 33 +++++++++++++++++++++++++
> > > >  3 files changed, 45 insertions(+), 32 deletions(-)
> > > >
> > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > > index 75a0f15819c4..bf210275e5b7 100644
> > > > --- a/drivers/bluetooth/btusb.c
> > > > +++ b/drivers/bluetooth/btusb.c
> > > > @@ -2221,6 +2221,13 @@ static int btusb_switch_alt_setting(struct h=
ci_dev *hdev, int new_alts)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static int btusb_read_alt_setting(struct hci_dev *hdev)
> > > > +{
> > > > +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> > > > +
> > > > +       return data->isoc_altsetting;
> > > > +}
> > > > +
> > > >  static struct usb_host_interface *btusb_find_altsetting(struct btu=
sb_data *data,
> > > >                                                         int alt)
> > > >  {
> > > > @@ -3650,32 +3657,6 @@ static const struct file_operations force_po=
ll_sync_fops =3D {
> > > >         .llseek         =3D default_llseek,
> > > >  };
> > > >
> > > > -static ssize_t isoc_alt_show(struct device *dev,
> > > > -                            struct device_attribute *attr,
> > > > -                            char *buf)
> > > > -{
> > > > -       struct btusb_data *data =3D dev_get_drvdata(dev);
> > > > -
> > > > -       return sysfs_emit(buf, "%d\n", data->isoc_altsetting);
> > > > -}
> > > > -
> > > > -static ssize_t isoc_alt_store(struct device *dev,
> > > > -                             struct device_attribute *attr,
> > > > -                             const char *buf, size_t count)
> > > > -{
> > > > -       struct btusb_data *data =3D dev_get_drvdata(dev);
> > > > -       int alt;
> > > > -       int ret;
> > > > -
> > > > -       if (kstrtoint(buf, 10, &alt))
> > > > -               return -EINVAL;
> > > > -
> > > > -       ret =3D btusb_switch_alt_setting(data->hdev, alt);
> > > > -       return ret < 0 ? ret : count;
> > > > -}
> > > > -
> > > > -static DEVICE_ATTR_RW(isoc_alt);
> > > > -
> > > >  static int btusb_probe(struct usb_interface *intf,
> > > >                        const struct usb_device_id *id)
> > > >  {
> > > > @@ -4040,9 +4021,8 @@ static int btusb_probe(struct usb_interface *=
intf,
> > > >                 if (err < 0)
> > > >                         goto out_free_dev;
> > > >
> > > > -               err =3D device_create_file(&intf->dev, &dev_attr_is=
oc_alt);
> > > > -               if (err)
> > > > -                       goto out_free_dev;
> > > > +               hdev->switch_usb_alt_setting =3D btusb_switch_alt_s=
etting;
> > > > +               hdev->read_usb_alt_setting =3D btusb_read_alt_setti=
ng;
> > > >         }
> > > >
> > > >         if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
> > > > @@ -4089,10 +4069,8 @@ static void btusb_disconnect(struct usb_inte=
rface *intf)
> > > >         hdev =3D data->hdev;
> > > >         usb_set_intfdata(data->intf, NULL);
> > > >
> > > > -       if (data->isoc) {
> > > > -               device_remove_file(&intf->dev, &dev_attr_isoc_alt);
> > > > +       if (data->isoc)
> > > >                 usb_set_intfdata(data->isoc, NULL);
> > > > -       }
> > > >
> > > >         if (data->diag)
> > > >                 usb_set_intfdata(data->diag, NULL);
> > > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetoo=
th/hci_core.h
> > > > index f756fac95488..5d3ec5ff5adb 100644
> > > > --- a/include/net/bluetooth/hci_core.h
> > > > +++ b/include/net/bluetooth/hci_core.h
> > > > @@ -641,6 +641,8 @@ struct hci_dev {
> > > >                                      struct bt_codec *codec, __u8 *=
vnd_len,
> > > >                                      __u8 **vnd_data);
> > > >         u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buf=
f *skb);
> > > > +       int (*switch_usb_alt_setting)(struct hci_dev *hdev, int new=
_alts);
> > > > +       int (*read_usb_alt_setting)(struct hci_dev *hdev);
> > > >  };
> > > >
> > > >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> > > > diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> > > > index 041ce9adc378..887aa1935b1e 100644
> > > > --- a/net/bluetooth/hci_sysfs.c
> > > > +++ b/net/bluetooth/hci_sysfs.c
> > > > @@ -102,8 +102,41 @@ static ssize_t reset_store(struct device *dev,=
 struct device_attribute *attr,
> > > >  }
> > > >  static DEVICE_ATTR_WO(reset);
> > > >
> > > > +static ssize_t isoc_alt_show(struct device *dev,
> > > > +                            struct device_attribute *attr,
> > > > +                            char *buf)
> > > > +{
> > > > +       struct hci_dev *hdev =3D to_hci_dev(dev);
> > > > +
> > > > +       if (hdev->read_usb_alt_setting)
> > > > +               return sysfs_emit(buf, "%d\n", hdev->read_usb_alt_s=
etting(hdev));
> > > > +
> > > > +       return -ENODEV;
> > > > +}
> > > > +
> > > > +static ssize_t isoc_alt_store(struct device *dev,
> > > > +                             struct device_attribute *attr,
> > > > +                             const char *buf, size_t count)
> > > > +{
> > > > +       struct hci_dev *hdev =3D to_hci_dev(dev);
> > > > +       int alt;
> > > > +       int ret;
> > > > +
> > > > +       if (kstrtoint(buf, 10, &alt))
> > > > +               return -EINVAL;
> > > > +
> > > > +       if (hdev->switch_usb_alt_setting) {
> > > > +               ret =3D hdev->switch_usb_alt_setting(hdev, alt);
> > > > +               return ret < 0 ? ret : count;
> > > > +       }
> > > > +
> > > > +       return -ENODEV;
> > > > +}
> > > > +static DEVICE_ATTR_RW(isoc_alt);
> > > > +
> > > >  static struct attribute *bt_host_attrs[] =3D {
> > > >         &dev_attr_reset.attr,
> > > > +       &dev_attr_isoc_alt.attr,
> > > >         NULL,
> > > >  };
> > > >  ATTRIBUTE_GROUPS(bt_host);
> > >
> > > While this fixes the race it also forces the inclusion of an attribut=
e
> > > that is driver specific, so I wonder if we should introduce some
> > > internal interface to register driver specific entries like this.
> >
> > Do you mean you prefer the original interface that only exports the
> > attribute when isoc_altsetting is supported?
> > Agree it makes more sense but I hit the obstacle: hci_init_sysfs is
> > called earlier than data->isoc is determined. I need some time to
> > verify whether changing the order won't break anything.
>
> We might have to do something like the following within hci_init_sysfs:
>
> if (hdev->isoc_alt)
>     dev->type =3D bt_host_isoc_alt
> else
>     dev->type =3D bt_host
>
> Now perhaps instead of adding the callbacks to hdev we add the
> attribute itself, btw did you check if there isn't a sysfs entry to
> interact with USB alternate settings? Because contrary to reset this
> actually operates directly on the driver bus so it sort of made more
> sense to me that this would be handled by USB rather than Bluetooth.

A quick git grep shows that this exists:

Documentation/ABI/testing/sysfs-bus-usb:What:
/sys/bus/usb/devices/usbX/bAlternateSetting

> > >
> > > > --
> > > > 2.48.1.262.g85cc9f2d1e-goog
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

