Return-Path: <netdev+bounces-160821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEB1A1B9B7
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 16:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775FC3A572F
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CDA157485;
	Fri, 24 Jan 2025 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx2ECspQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD915623A;
	Fri, 24 Jan 2025 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734108; cv=none; b=LXrX9ixuJe9GJ6bQUrKIRTt5wy+Q833zkZkCb8z1MxkpGkBbiVgvGKeoDbmc7Wkna+/VKGQa9yovyc5sKPBfuw2s3rMHJeWvUCju2N3LYkqu31kSeyYvsGzMA3qZymPnX9NZedhZ01Sa5Shc0URhU0CnYF176LOKAsWUmyYJ4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734108; c=relaxed/simple;
	bh=3FhEfHod4hMTW/jyRqf8DZwzVbpPsYxnVpjspkvh2S8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coGTT/Xs1yPGomhj1aTFXPT6MzhSFvoha4zgkUWX5lpXvtMTqOfZU1KoVSEcb2kVhOW81fo1C3i9sdRokkMW9Gvar1kIemut8GoUX+Rgkg+YPwQmkoAltr5zJMsNKpi4Qpixu4jXX/o5zd1BR1w7vdXC9OXBgjPYgVxYPWo6b8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx2ECspQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5439e331cceso2656129e87.1;
        Fri, 24 Jan 2025 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737734105; x=1738338905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guIeUf9YGzMkSFqOQtrBhVl1ehI54j4VIgCWcFPEf3c=;
        b=Dx2ECspQM75DmUo25IehfO5isI51oXEw9NOzlaL8tqPQTonzfvtHtYsu4owypQgAwk
         R/z7LLN777a4H+OpLRQ+u5AKBYMFt+OBBPu31vRbCRNK9gSXuhw8QVdczxsOtZv5/N4q
         EpdSGTgr67J4BMqjOwSIlndVfYKnL6NKf+9vkl5KxE//467ULDEGd05uAMhYskGLprKy
         7ybtuNQYHnFIp0YaX9wDTMxmV+ELlQD+1RmdHhueZpfXUoVBkmHo84NbRESXAquzWNq0
         /oioe1b36JNidJV1YK8gFPcwlXJlHopbPARmyeZeOviHQif3Bs8srlBIx8lTx5qCwyDn
         6gvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737734105; x=1738338905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guIeUf9YGzMkSFqOQtrBhVl1ehI54j4VIgCWcFPEf3c=;
        b=GnpyRxqaSmOrMPxtSmi4Ec2Be6H2bZDwfFng4Ylq1UmJjOWwKvLuxTOe+MOIw1sm/J
         FpKxYxxSqszo7kZ1HTNzFN+wrFKjrfMYO4VvlDGtiRXLjq525XcrNzBDaonEp7pJR/Rb
         AUMhMp0+V4yGYpcVw9Q62xd/2V6pU4CpOplbMwGs23L38yFnX7VbTE3/87NoTua1itK7
         Z+xp2Z7urehZtwd/zM6uHXlG2J7W3hqMq99HQ89/gd2oVnCei1o3Z3x8HcTBcKd7XHKy
         ZHWV6wqPsJP0ZawyZ3i8lk0pvOu40HvgMsrSMasIAq6QlOU42dTDLZB9G5P6ObaIrb7/
         10+A==
X-Forwarded-Encrypted: i=1; AJvYcCUr5OcWJ4MfOpvypxUbY8mM0+8gifSbWWNV4irMklMuaOot78pkuvRV7Mt9t6ao/KpmPIXoMaliQy1aryY=@vger.kernel.org, AJvYcCUsVUmoF0WaXq1lergPQQ1PR49SZ1UwHBKEMovxSRJ9NjyJ61Afpi2ZtPSbPmxYV5jkn7wpRRDq@vger.kernel.org
X-Gm-Message-State: AOJu0YwcsaoEtOlc8sxeXC34pekuvcf0X1VP3j4NvVISkj4XXL9QSBQ3
	q96gp1vwlkUoOddOJh7bdYiHV9ZXHJ0hedgvCqEI81Bs3DRbrrEzSXnd0eXuCR3Fli1JzlLgD1K
	z743QUsD3NbBu9k/S8FpGACPQODQ=
X-Gm-Gg: ASbGnctTzKOBvUyr6box6iy+iCf31RIUIFl6Ad9Zb3nMd90RKIivrtaQwAC335W+ycS
	4QpKL/0M00milh8Iesl6NTWfVw9/q7wfsPrSz9BuHkcVpbteqH+nyHEuOmPcTQLw=
X-Google-Smtp-Source: AGHT+IG5C0qrGiUnxqMhxIwtJtkQ9upCSRvl3YoxiqroNIUXUx6lSn71xEGH5nDb+pMTx4RRSLdAG9n/WHcAHH6ZPW8=
X-Received: by 2002:a05:6512:1247:b0:542:98e0:7c67 with SMTP id
 2adb3069b0e04-5439c27d401mr11464703e87.51.1737734104669; Fri, 24 Jan 2025
 07:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122131925.v2.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <CABBYNZKoXT4u4=KJZUvG4g1OEi+xQ-LchiH8gvEZURNTzJoQDw@mail.gmail.com> <CADg1FFdt2mQsN4YjLTn=zp_+MahopN371EDiXQEbp+GTSaNtBg@mail.gmail.com>
In-Reply-To: <CADg1FFdt2mQsN4YjLTn=zp_+MahopN371EDiXQEbp+GTSaNtBg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Jan 2025 10:54:52 -0500
X-Gm-Features: AWEUYZkWwQ9j64FeGr_QC9cJXdLOlxGXKVanrqf7QNMj6671n9VWp6ZxqJE-8T8
Message-ID: <CABBYNZJ__OMJZtEE0BFpaUdKPQv+Ym-OnsJj-kN=i_gZCeVN5w@mail.gmail.com>
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

On Wed, Jan 22, 2025 at 11:57=E2=80=AFPM Hsin-chen Chuang <chharry@google.c=
om> wrote:
>
> Hi Luiz,
>
> On Thu, Jan 23, 2025 at 3:35=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Hsin-chen,
> >
> > On Wed, Jan 22, 2025 at 12:20=E2=80=AFAM Hsin-chen Chuang <chharry@goog=
le.com> wrote:
> > >
> > > From: Hsin-chen Chuang <chharry@chromium.org>
> > >
> > > Use device group to avoid the racing. To reuse the group defined in
> > > hci_sysfs.c, defined 2 callbacks switch_usb_alt_setting and
> > > read_usb_alt_setting which are only registered in btusb.
> > >
> > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to contro=
l USB alt setting")
> > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  drivers/bluetooth/btusb.c        | 42 ++++++++----------------------=
--
> > >  include/net/bluetooth/hci_core.h |  2 ++
> > >  net/bluetooth/hci_sysfs.c        | 33 +++++++++++++++++++++++++
> > >  3 files changed, 45 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > index 75a0f15819c4..bf210275e5b7 100644
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -2221,6 +2221,13 @@ static int btusb_switch_alt_setting(struct hci=
_dev *hdev, int new_alts)
> > >         return 0;
> > >  }
> > >
> > > +static int btusb_read_alt_setting(struct hci_dev *hdev)
> > > +{
> > > +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> > > +
> > > +       return data->isoc_altsetting;
> > > +}
> > > +
> > >  static struct usb_host_interface *btusb_find_altsetting(struct btusb=
_data *data,
> > >                                                         int alt)
> > >  {
> > > @@ -3650,32 +3657,6 @@ static const struct file_operations force_poll=
_sync_fops =3D {
> > >         .llseek         =3D default_llseek,
> > >  };
> > >
> > > -static ssize_t isoc_alt_show(struct device *dev,
> > > -                            struct device_attribute *attr,
> > > -                            char *buf)
> > > -{
> > > -       struct btusb_data *data =3D dev_get_drvdata(dev);
> > > -
> > > -       return sysfs_emit(buf, "%d\n", data->isoc_altsetting);
> > > -}
> > > -
> > > -static ssize_t isoc_alt_store(struct device *dev,
> > > -                             struct device_attribute *attr,
> > > -                             const char *buf, size_t count)
> > > -{
> > > -       struct btusb_data *data =3D dev_get_drvdata(dev);
> > > -       int alt;
> > > -       int ret;
> > > -
> > > -       if (kstrtoint(buf, 10, &alt))
> > > -               return -EINVAL;
> > > -
> > > -       ret =3D btusb_switch_alt_setting(data->hdev, alt);
> > > -       return ret < 0 ? ret : count;
> > > -}
> > > -
> > > -static DEVICE_ATTR_RW(isoc_alt);
> > > -
> > >  static int btusb_probe(struct usb_interface *intf,
> > >                        const struct usb_device_id *id)
> > >  {
> > > @@ -4040,9 +4021,8 @@ static int btusb_probe(struct usb_interface *in=
tf,
> > >                 if (err < 0)
> > >                         goto out_free_dev;
> > >
> > > -               err =3D device_create_file(&intf->dev, &dev_attr_isoc=
_alt);
> > > -               if (err)
> > > -                       goto out_free_dev;
> > > +               hdev->switch_usb_alt_setting =3D btusb_switch_alt_set=
ting;
> > > +               hdev->read_usb_alt_setting =3D btusb_read_alt_setting=
;
> > >         }
> > >
> > >         if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
> > > @@ -4089,10 +4069,8 @@ static void btusb_disconnect(struct usb_interf=
ace *intf)
> > >         hdev =3D data->hdev;
> > >         usb_set_intfdata(data->intf, NULL);
> > >
> > > -       if (data->isoc) {
> > > -               device_remove_file(&intf->dev, &dev_attr_isoc_alt);
> > > +       if (data->isoc)
> > >                 usb_set_intfdata(data->isoc, NULL);
> > > -       }
> > >
> > >         if (data->diag)
> > >                 usb_set_intfdata(data->diag, NULL);
> > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
> > > index f756fac95488..5d3ec5ff5adb 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -641,6 +641,8 @@ struct hci_dev {
> > >                                      struct bt_codec *codec, __u8 *vn=
d_len,
> > >                                      __u8 **vnd_data);
> > >         u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff =
*skb);
> > > +       int (*switch_usb_alt_setting)(struct hci_dev *hdev, int new_a=
lts);
> > > +       int (*read_usb_alt_setting)(struct hci_dev *hdev);
> > >  };
> > >
> > >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> > > diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> > > index 041ce9adc378..887aa1935b1e 100644
> > > --- a/net/bluetooth/hci_sysfs.c
> > > +++ b/net/bluetooth/hci_sysfs.c
> > > @@ -102,8 +102,41 @@ static ssize_t reset_store(struct device *dev, s=
truct device_attribute *attr,
> > >  }
> > >  static DEVICE_ATTR_WO(reset);
> > >
> > > +static ssize_t isoc_alt_show(struct device *dev,
> > > +                            struct device_attribute *attr,
> > > +                            char *buf)
> > > +{
> > > +       struct hci_dev *hdev =3D to_hci_dev(dev);
> > > +
> > > +       if (hdev->read_usb_alt_setting)
> > > +               return sysfs_emit(buf, "%d\n", hdev->read_usb_alt_set=
ting(hdev));
> > > +
> > > +       return -ENODEV;
> > > +}
> > > +
> > > +static ssize_t isoc_alt_store(struct device *dev,
> > > +                             struct device_attribute *attr,
> > > +                             const char *buf, size_t count)
> > > +{
> > > +       struct hci_dev *hdev =3D to_hci_dev(dev);
> > > +       int alt;
> > > +       int ret;
> > > +
> > > +       if (kstrtoint(buf, 10, &alt))
> > > +               return -EINVAL;
> > > +
> > > +       if (hdev->switch_usb_alt_setting) {
> > > +               ret =3D hdev->switch_usb_alt_setting(hdev, alt);
> > > +               return ret < 0 ? ret : count;
> > > +       }
> > > +
> > > +       return -ENODEV;
> > > +}
> > > +static DEVICE_ATTR_RW(isoc_alt);
> > > +
> > >  static struct attribute *bt_host_attrs[] =3D {
> > >         &dev_attr_reset.attr,
> > > +       &dev_attr_isoc_alt.attr,
> > >         NULL,
> > >  };
> > >  ATTRIBUTE_GROUPS(bt_host);
> >
> > While this fixes the race it also forces the inclusion of an attribute
> > that is driver specific, so I wonder if we should introduce some
> > internal interface to register driver specific entries like this.
>
> Do you mean you prefer the original interface that only exports the
> attribute when isoc_altsetting is supported?
> Agree it makes more sense but I hit the obstacle: hci_init_sysfs is
> called earlier than data->isoc is determined. I need some time to
> verify whether changing the order won't break anything.

We might have to do something like the following within hci_init_sysfs:

if (hdev->isoc_alt)
    dev->type =3D bt_host_isoc_alt
else
    dev->type =3D bt_host

Now perhaps instead of adding the callbacks to hdev we add the
attribute itself, btw did you check if there isn't a sysfs entry to
interact with USB alternate settings? Because contrary to reset this
actually operates directly on the driver bus so it sort of made more
sense to me that this would be handled by USB rather than Bluetooth.

> >
> > > --
> > > 2.48.1.262.g85cc9f2d1e-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

