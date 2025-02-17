Return-Path: <netdev+bounces-166899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C10BA37D5C
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB7F3B0FEE
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921221A2630;
	Mon, 17 Feb 2025 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="THDu/qdl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF471A3155
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781906; cv=none; b=WkeiGENrLjzp5dbfAUvemrMcSXRVR4WXiuQeCLU++nq0t0DVz4GDIgdPP8GAkvwykAZhFe2zV34Zrqqqnykj9f7VREvi0F0BQ65/ywURw0BFxuX1suWCEtC+gAwrnDQ5ZgTKzBtLuMnXgs/gl7hs5IcGnSgDrubcJpraEUvD4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781906; c=relaxed/simple;
	bh=uHKqqnEnYVzh3/HhKoXxwHr3L+iFlmKJ7NHNrFpxNOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlGOON+AlgyzQMAL55OvLICOxjo0T5sVNWyD1DHFtmjEQZSbvbDo0yHCGET5dQpFuXv9s6I9G+Sm/Fyexwqggs+/uJnIyq1uEQNujvRW3I0lBGTgjpy3tcH+i53evDALLYY/cnAuk9olezVXY4y8RrunG5JE/He9sZ1WmNZfbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=THDu/qdl; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fb2a0e4125so31259597b3.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 00:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739781903; x=1740386703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtQU9bp9FLNUk8UWpGUSEUOWyePThwilF4/88ev1EGQ=;
        b=THDu/qdlGKow8UGmbwKOmihBBE0ieU8W+rhLZxS0b3ilaOEXLorGaT8ItlTrnV9SzO
         TvmjZbyOtpcaIv+fN2Z+AM4bzdSnx7ACvm5/N0J8YVfhSHpC0UFaOa0cArjd7bNcWjoV
         RpAgK10pd+IOnWzsfQL1qYKAoZ90xG4hAPMc1eajc/5637gionAus7gsEZKgRLDtRrCN
         Eg5aiUW0lOAYAXjTO74a9mACiZmtO93KDE/2EYpqfAcN1CuqdJ92oBajsf4NBMvwDTN2
         bTNy6tptgJQH+47UoXf/IhPCYWhhzf2WGD2PlVMYvmhdLWHcMTVVaLWI64rQyCbHHzsr
         y6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739781903; x=1740386703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtQU9bp9FLNUk8UWpGUSEUOWyePThwilF4/88ev1EGQ=;
        b=dKC+IUQyy5YtCZIZtuJhWk35KpxRMTFLshTXd7iZbiG43KeVN7gxyQlOT5gf2G7adu
         +HWDT/yWDbjyDPyTo6r1tt32yoPN6T2TPTpaP0oY4TuNFaoj4F/wXaimOivHPXza9qmE
         YZtbwPddjxAzzbWUuJm/buwqY7QyhPCo/04HgZdifHc4nuS67Y7fNfEcQu5i/lmbMBxQ
         nnRFK+rcHnMtcLd7XIavnZaR10FQjR8hqPSzTwx+jdPCdRl6Arh5yabeHGsNVbMvojF5
         E8lMAwPnzewHrwtR2FlepzGAUzx5hSgQRTrr+9+Cshvqi8SAz3pr5mkM2P5dTuaIWyLJ
         iSrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU2eFwWT7R816Vf+Ezqk48iJG12WLdlEGH6Se+HMiVLoE1ux+2Nm4/Hk9Q9ugNP0Zu486ggfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykqXQiG46hV3lN8atTRYWNIjzkLIr6kJZ2YzeLwSnDcSkmch/7
	l7EOIIJ3UXjbY1jiOirC3j9Hi1gSbQ0nB7xWGcJUGWofsGeCvkHJxyhIvWtkRd7NEoE/hwvVWIi
	eN9LPgW6A7Zm+PSsMBcerKyH65tcgttU71RMo
X-Gm-Gg: ASbGncuS5QuF4JkS04fqOOkkRlPuUpdspogMnt70s0QlRqUCmDsgr3tEFHEC1UvhQti
	5UHo58zaA/x/mlCBf6SE7dZc8UTgHvJLXZDMkXby51YkdY+IVcvKYJNKAhOlKuCWh41LYbXew4g
	==
X-Google-Smtp-Source: AGHT+IH0+1ygY43Twywfd69CCe1zGCQpGW9I0UDrVR7uGgx+v0GzSjTKx9YaRxZuXBSgo0Tyvz8K1CWLqo2rjZZooeI=
X-Received: by 2002:a05:6902:228e:b0:e5d:b7d8:ad3b with SMTP id
 3f1490d57ef6-e5dc90494c4mr7071537276.19.1739781903000; Mon, 17 Feb 2025
 00:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021425-surgical-wackiness-0940@gregkh>
In-Reply-To: <2025021425-surgical-wackiness-0940@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Mon, 17 Feb 2025 16:44:35 +0800
X-Gm-Features: AWEUYZkU4pAvQqrg9Y27OTUWlYEhkhk1cyfkzNcIxbkv2X1qa0Cn2tjdpsxIdyM
Message-ID: <CADg1FFd3H0DLV-WX8jTB1VGyOZYEzchP99QvYxWmg1XCOo1ttg@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 7:37=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Feb 14, 2025 at 07:16:17PM +0800, Hsin-chen Chuang wrote:
> > From: Hsin-chen Chuang <chharry@chromium.org>
> >
> > Expose the isoc_alt attr with device group to avoid the racing.
> >
> > Now we create a dev node for btusb. The isoc_alt attr belongs to it and
> > it also becomes the parent device of hci dev.
> >
> > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control =
USB alt setting")
>
> Wait, step back, why is this commit needed if you can change the alt
> setting already today through usbfs/libusb without needing to mess with
> the bluetooth stack at all?

In short: We want to configure the alternate settings without
detaching the btusb driver, while detaching seems necessary for
libusb_set_interface_alt_setting to work (Please correct me if I'm
wrong!)

Background:
The Bluetooth Core Specification defines a protocol for the operating
system to communicate with a Bluetooth chipset, called HCI (Host
Controller Interface) (Host=3DOS, Controller=3Dchipset).
We could say the main purpose of the Linux Bluetooth drivers is to set
up and get the HCI ready for the "upper layer" to use.

Who could be the "upper layer" then? There are mainly 2: "Control" and
"User" channels.
Linux has its default Bluetooth stack, BlueZ, which is splitted into 2
parts: the kernel space and the user space. The kernel space part
provides an abstracted Bluetooth API called MGMT, and is exposed
through the Bluetooth HCI socket "Control" channel.
On the other hand Linux also exposes the Bluetooth HCI socket "User"
channel, allowing the user space APPs to send/receive the HCI packets
directly to/from the chipset. Google's products (Android, ChromeOS,
etc) use this channel.

Now why this patch?
It's because the Bluetooth spec defines something specific to USB
transport: A USB Bluetooth chipset must/should support these alternate
settings; When transferring this type of the Audio data this alt must
be used, bla bla bla...
The Control channel handles this in the kernel part. However, the
applications built on top of the User channel are unable to configure
the alt setting, and I'd like to add the support through sysfs.

>
> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > ---
> >
> > Changes in v5:
> > - Merge the ABI doc into this patch
> > - Manage the driver data with device
> >
> > Changes in v4:
> > - Create a dev node for btusb. It's now hci dev's parent and the
> >   isoc_alt now belongs to it.
> > - Since the changes is almost limitted in btusb, no need to add the
> >   callbacks in hdev anymore.
> >
> > Changes in v3:
> > - Make the attribute exported only when the isoc_alt is available.
> > - In btusb_probe, determine data->isoc before calling hci_alloc_dev_pri=
v
> >   (which calls hci_init_sysfs).
> > - Since hci_init_sysfs is called before btusb could modify the hdev,
> >   add new argument add_isoc_alt_attr for btusb to inform hci_init_sysfs=
.
> >
> > Changes in v2:
> > - The patch has been removed from series
> >
> >  .../ABI/stable/sysfs-class-bluetooth          |  13 ++
> >  drivers/bluetooth/btusb.c                     | 111 ++++++++++++++----
> >  include/net/bluetooth/hci_core.h              |   1 +
> >  net/bluetooth/hci_sysfs.c                     |   3 +-
> >  4 files changed, 102 insertions(+), 26 deletions(-)
> >
> > diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documenta=
tion/ABI/stable/sysfs-class-bluetooth
> > index 36be02471174..c1024c7c4634 100644
> > --- a/Documentation/ABI/stable/sysfs-class-bluetooth
> > +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> > @@ -7,3 +7,16 @@ Description:         This write-only attribute allows =
users to trigger the vendor reset
> >               The reset may or may not be done through the device trans=
port
> >               (e.g., UART/USB), and can also be done through an out-of-=
band
> >               approach such as GPIO.
> > +
> > +What:                /sys/class/bluetooth/btusb<usb-intf>/isoc_alt
> > +Date:                13-Feb-2025
> > +KernelVersion:       6.13
> > +Contact:     linux-bluetooth@vger.kernel.org
> > +Description: This attribute allows users to configure the USB Alternat=
e setting
> > +             for the specific HCI device. Reading this attribute retur=
ns the
> > +             current setting, and writing any supported numbers would =
change
> > +             the setting. See the USB Alternate setting definition in =
Bluetooth
> > +             core spec 5, vol 4, part B, table 2.1.
> > +             If the HCI device is not yet init-ed, the write fails wit=
h -ENODEV.
> > +             If the data is not a valid number, the write fails with -=
EINVAL.
> > +             The other failures are vendor specific.
>
> Again, what's wrong with libusb/usbfs to do this today?
>
>
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 1caf7a071a73..e2fb3d08a5ed 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -920,6 +920,8 @@ struct btusb_data {
> >       int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> >
> >       struct qca_dump_info qca_dump;
> > +
> > +     struct device dev;
>
> Ah, so now this structure's lifecycle is determined by the device you
> just embedded in it?  Are you sure you got this right?

Yes, I think so. The structure should be freed when usb disconnects.
In the current implementation all its members are released when usb
disconnects except for the structure itself, because it's allocated
through devm_kzalloc. Since we now make it a device we could make the
lifecycle clearer.

>
> >  };
> >
> >  static void btusb_reset(struct hci_dev *hdev)
> > @@ -3693,6 +3695,9 @@ static ssize_t isoc_alt_store(struct device *dev,
> >       int alt;
> >       int ret;
> >
> > +     if (!data->hdev)
> > +             return -ENODEV;
> > +
> >       if (kstrtoint(buf, 10, &alt))
> >               return -EINVAL;
> >
> > @@ -3702,6 +3707,36 @@ static ssize_t isoc_alt_store(struct device *dev=
,
> >
> >  static DEVICE_ATTR_RW(isoc_alt);
> >
> > +static struct attribute *btusb_sysfs_attrs[] =3D {
> > +     NULL,
> > +};
> > +ATTRIBUTE_GROUPS(btusb_sysfs);
> > +
> > +static void btusb_sysfs_release(struct device *dev)
> > +{
> > +     struct btusb_data *data =3D dev_get_drvdata(dev);
>
> That feels wrong, it's embedded in the device, not pointed to by the
> device.  So this should be a container_of() call, right?

Thanks for the feedback. So now rather than dev_set_drvdata() +
dev_get_drvdata() I am going to use container_of() only.

>
> > +
> > +     kfree(data);
> > +}
> > +
> > +static const struct device_type btusb_sysfs =3D {
> > +     .name    =3D "btusb",
> > +     .release =3D btusb_sysfs_release,
> > +     .groups  =3D btusb_sysfs_groups,
> > +};
> > +
> > +static struct attribute *btusb_sysfs_isoc_alt_attrs[] =3D {
> > +     &dev_attr_isoc_alt.attr,
> > +     NULL,
> > +};
> > +ATTRIBUTE_GROUPS(btusb_sysfs_isoc_alt);
> > +
> > +static const struct device_type btusb_sysfs_isoc_alt =3D {
> > +     .name    =3D "btusb",
> > +     .release =3D btusb_sysfs_release,
> > +     .groups  =3D btusb_sysfs_isoc_alt_groups,
> > +};
> > +
> >  static int btusb_probe(struct usb_interface *intf,
> >                      const struct usb_device_id *id)
> >  {
> > @@ -3743,7 +3778,7 @@ static int btusb_probe(struct usb_interface *intf=
,
> >                       return -ENODEV;
> >       }
> >
> > -     data =3D devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
> > +     data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> >       if (!data)
> >               return -ENOMEM;
> >
> > @@ -3766,8 +3801,10 @@ static int btusb_probe(struct usb_interface *int=
f,
> >               }
> >       }
> >
> > -     if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep)
> > -             return -ENODEV;
> > +     if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep) {
> > +             err =3D -ENODEV;
> > +             goto out_free_data;
> > +     }
> >
> >       if (id->driver_info & BTUSB_AMP) {
> >               data->cmdreq_type =3D USB_TYPE_CLASS | 0x01;
> > @@ -3821,16 +3858,47 @@ static int btusb_probe(struct usb_interface *in=
tf,
> >
> >       data->recv_acl =3D hci_recv_frame;
> >
> > +     if (id->driver_info & BTUSB_AMP) {
> > +             /* AMP controllers do not support SCO packets */
> > +             data->isoc =3D NULL;
> > +     } else {
> > +             /* Interface orders are hardcoded in the specification */
> > +             data->isoc =3D usb_ifnum_to_if(data->udev, ifnum_base + 1=
);
> > +             data->isoc_ifnum =3D ifnum_base + 1;
> > +     }
> > +
> > +     if (id->driver_info & BTUSB_BROKEN_ISOC)
> > +             data->isoc =3D NULL;
> > +
> > +     /* Init a dev for btusb. The attr depends on the support of isoc.=
 */
> > +     if (data->isoc)
> > +             data->dev.type =3D &btusb_sysfs_isoc_alt;
> > +     else
> > +             data->dev.type =3D &btusb_sysfs;
>
> When walking the class, are you sure you check for the proper types now?
> Does anyone walk all of the class devices anywhere?

Sorry I don't quite understand. What does walk mean in this case? Is
it the user space program walks the /sys/class/bluetooth?

>
> > +     data->dev.class =3D &bt_class;
> > +     data->dev.parent =3D &intf->dev;
> > +
> > +     err =3D dev_set_name(&data->dev, "btusb%s", dev_name(&intf->dev))=
;
>
> what does this name look like in a real system?  squashing them together
> feels wrong, why is 'btusb' needed here at all?

Below is the Bluetooth class layout that could be like after this patch.
I guess we better keep the "btusb" or "usb" prefix so it's less
confusing when more transports (UART, PCIe, etc) are added.

# ls -l /sys/class/bluetooth
total 0
lrwxrwxrwx. 1 root root 0 Feb 17 15:23 btusb2-1.5:1.0 ->
../../devices/platform/soc/16700000.usb/usb2/2-1/2-1.5/2-1.5:1.0/bluetooth/=
btusb2-1.5:1.0
lrwxrwxrwx. 1 root root 0 Feb 17 15:23 hci0 ->
../../devices/platform/soc/16700000.usb/usb2/2-1/2-1.5/2-1.5:1.0/bluetooth/=
btusb2-1.5:1.0/hci0

>
> > +     if (err)
> > +             goto out_free_data;
> > +
> > +     dev_set_drvdata(&data->dev, data);
> > +     err =3D device_register(&data->dev);
> > +     if (err < 0)
> > +             goto out_put_sysfs;
> > +
> >       hdev =3D hci_alloc_dev_priv(priv_size);
> > -     if (!hdev)
> > -             return -ENOMEM;
> > +     if (!hdev) {
> > +             err =3D -ENOMEM;
> > +             goto out_free_sysfs;
> > +     }
> >
> >       hdev->bus =3D HCI_USB;
> >       hci_set_drvdata(hdev, data);
> >
> >       data->hdev =3D hdev;
> >
> > -     SET_HCIDEV_DEV(hdev, &intf->dev);
> > +     SET_HCIDEV_DEV(hdev, &data->dev);
> >
> >       reset_gpio =3D gpiod_get_optional(&data->udev->dev, "reset",
> >                                       GPIOD_OUT_LOW);
> > @@ -3969,15 +4037,6 @@ static int btusb_probe(struct usb_interface *int=
f,
> >               hci_set_msft_opcode(hdev, 0xFD70);
> >       }
> >
> > -     if (id->driver_info & BTUSB_AMP) {
> > -             /* AMP controllers do not support SCO packets */
> > -             data->isoc =3D NULL;
> > -     } else {
> > -             /* Interface orders are hardcoded in the specification */
> > -             data->isoc =3D usb_ifnum_to_if(data->udev, ifnum_base + 1=
);
> > -             data->isoc_ifnum =3D ifnum_base + 1;
> > -     }
> > -
> >       if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
> >           (id->driver_info & BTUSB_REALTEK)) {
> >               btrtl_set_driver_name(hdev, btusb_driver.name);
> > @@ -4010,9 +4069,6 @@ static int btusb_probe(struct usb_interface *intf=
,
> >                       set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirk=
s);
> >       }
> >
> > -     if (id->driver_info & BTUSB_BROKEN_ISOC)
> > -             data->isoc =3D NULL;
> > -
> >       if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
> >               set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirk=
s);
> >
> > @@ -4065,10 +4121,6 @@ static int btusb_probe(struct usb_interface *int=
f,
> >                                                data->isoc, data);
> >               if (err < 0)
> >                       goto out_free_dev;
> > -
> > -             err =3D device_create_file(&intf->dev, &dev_attr_isoc_alt=
);
>
> You have now moved the file, are you sure you don't also need to update
> the documentation?

There's no documentation for this attr so far, and this patch aims to
add the doc.

>
>
> > -             if (err)
> > -                     goto out_free_dev;
> >       }
> >
> >       if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
> > @@ -4099,6 +4151,16 @@ static int btusb_probe(struct usb_interface *int=
f,
> >       if (data->reset_gpio)
> >               gpiod_put(data->reset_gpio);
> >       hci_free_dev(hdev);
> > +
> > +out_free_sysfs:
> > +     device_del(&data->dev);
> > +
> > +out_put_sysfs:
> > +     put_device(&data->dev);
> > +     return err;
> > +
> > +out_free_data:
> > +     kfree(data);
> >       return err;
> >  }
> >
> > @@ -4115,10 +4177,8 @@ static void btusb_disconnect(struct usb_interfac=
e *intf)
> >       hdev =3D data->hdev;
> >       usb_set_intfdata(data->intf, NULL);
> >
> > -     if (data->isoc) {
> > -             device_remove_file(&intf->dev, &dev_attr_isoc_alt);
> > +     if (data->isoc)
> >               usb_set_intfdata(data->isoc, NULL);
> > -     }
> >
> >       if (data->diag)
> >               usb_set_intfdata(data->diag, NULL);
> > @@ -4150,6 +4210,7 @@ static void btusb_disconnect(struct usb_interface=
 *intf)
> >               gpiod_put(data->reset_gpio);
> >
> >       hci_free_dev(hdev);
> > +     device_unregister(&data->dev);
> >  }
> >
> >  #ifdef CONFIG_PM
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 05919848ea95..776dd6183509 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1843,6 +1843,7 @@ int hci_get_adv_monitor_offload_ext(struct hci_de=
v *hdev);
> >
> >  void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
> >
> > +extern const struct class bt_class;
> >  void hci_init_sysfs(struct hci_dev *hdev);
> >  void hci_conn_init_sysfs(struct hci_conn *conn);
> >  void hci_conn_add_sysfs(struct hci_conn *conn);
> > diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> > index 041ce9adc378..aab3ffaa264c 100644
> > --- a/net/bluetooth/hci_sysfs.c
> > +++ b/net/bluetooth/hci_sysfs.c
> > @@ -6,9 +6,10 @@
> >  #include <net/bluetooth/bluetooth.h>
> >  #include <net/bluetooth/hci_core.h>
> >
> > -static const struct class bt_class =3D {
> > +const struct class bt_class =3D {
> >       .name =3D "bluetooth",
> >  };
> > +EXPORT_SYMBOL(bt_class);
>
> EXPORT_SYMBOL_GPL(), right?
>
> thanks,
>
> greg k-h

--=20
Best Regards,
Hsin-chen

