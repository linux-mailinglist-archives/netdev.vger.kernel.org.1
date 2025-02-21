Return-Path: <netdev+bounces-168358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3D1A3EA48
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105063B6402
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA861494BB;
	Fri, 21 Feb 2025 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7+xkN4z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50078F52
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102167; cv=none; b=R/b43+n0hTtbzxAQiRGG1mh483QPmmJGRnnCYFatBJFcuNo3u1YpLM+uwyyiD1jB/uxUQPqFHOiDuhMf2iOmAu2dql53K2ncrojWmBHLDp4BBOQffrFXc6qvLgzkz2waU4A++mcAslAYD5GLw53juthzRUPZBAGnwUaSNUX3dGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102167; c=relaxed/simple;
	bh=qsb/qAM/w6ThPYz0i3XfWMcwV6tAC/0iGnqjqFvKufY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uma6ucGUvlteeYakh+BG7wC0wWd1moKn5DKrG4NS+q9v0FkDisSfY1CBlBlozGl0pKaRfqec1Qx4QHsZDpavJ0xdScuvW3jj5hmcXXIA54OH1xthyKDpzdck0kOQcKEYwULDmZbijD+A8l3VMXGj2f1hFpmErnL9aqiESpCH00E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c7+xkN4z; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6fb73240988so10921257b3.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 17:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740102163; x=1740706963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cq5wW7Mlxo5wbIWOTLy11yQHQNcqPwg4CfQNw3smvx8=;
        b=c7+xkN4zus6B77uMCft+l8gAl5H5NPR7G24krwTEGv8A2GwQVQckfvlHVKp63Hw5Ja
         J147u1DPkKIh9gmaaQqA+rfQUvD6UNGJAHWCWwcuHq3IJRclkBcyz4lKoFwpOxWbZDVa
         Xcisx3womfsK01Hx5+6mehkSREZDQ27PpYa4AY8FeqW0ixNCeXIpq3xxxKv8fleKyEiQ
         SpzmAULpMf4OOfFGnckgntitJpdjQdZDezzgElAZukQcyI0xBBSEmzp4cQInwvbEgUlr
         AfaKVUjfX62Za+iop9h1jJK4mW4Z5umijpmSXjwo+ce4zIg6r3javDjZjgq5DpTJ4WNo
         T4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740102163; x=1740706963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cq5wW7Mlxo5wbIWOTLy11yQHQNcqPwg4CfQNw3smvx8=;
        b=Dmc3xl0vaA2eqQqvPYVHKYzif+bgvoeE55RFs7bXV2mGuXZZmJAKzDzpen4TXkvzbS
         h4wgbTV9Xd+eVG+Vn/YVVmwQSxcVGXvqLnKnEHETMK/fwH/N9ST+XGufkX/31hXrjrY+
         jYe4Y1BfOEryUwziEwBrw4sDnQs7pNwLoxU3t/UhWoCIawcK1Wm/9zabYAngP9XquoiM
         mSEIndy1oKrFLH16VAAZW0jV1Ig8bKbqLmMZSasPDnxR6uQxuU21FYIMkUlo7xzTalog
         em1t+b9Kjc1KIQG1/FXbmOQxhrGxJTYq8THB5ByDKcI71eoFnHTLuH6nUR9o9dqHD2Pb
         E7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUA939Fx20Re8hTmXQH1Wx3kZ1Qd2j/7jcjIheo+wfedv0mK9iPnsuy7EeI5mhUQX7tPm8jVLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ib8aZ4wxSXbIqzpqOuWVh0qStm7cppaLdB3zxPkh8mlwQrhx
	53ptkFlb1DUC42qs19Khpwkjt5v4Q4pwzem2WzLyrzCqDUwLPi0XeeM57minoVz2re7QAoObS47
	3Ro30marwcMpfdk1ODdwg+a/svNjCzj9/nWa3
X-Gm-Gg: ASbGncvxYyzR1vSjuZmftaMcCw8vCYZwaG2PkV1p9jdPdEz+xz9m/HSX3mtjJf2S0gR
	C5ds92oWlsqMgjsRvlrXEzc7SJ1YPC/FsoDP4bd7Je/1XGT5OVEglFBKVs2/sCjwa20Mi5jEmhL
	ffagbbWCRU
X-Google-Smtp-Source: AGHT+IHcO3NCLnBWYIcEnl3NgEG/pKUlRKt5tc+j8CKkuF05USkQ/01cpeODP4jWohKAsfkPcPOYjh1IQ0HbztY5gr8=
X-Received: by 2002:a05:6902:230d:b0:e5a:cece:f38d with SMTP id
 3f1490d57ef6-e5e245e77edmr1162202276.13.1740102163233; Thu, 20 Feb 2025
 17:42:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219220255.v7.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
In-Reply-To: <20250219220255.v7.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
From: Hsin-chen Chuang <chharry@google.com>
Date: Fri, 21 Feb 2025 09:42:16 +0800
X-Gm-Features: AWEUYZlQLidDoKhTdpV_KHzPWs-VkWpNfJwvrhAjNMOnNOTN7JpIBytEj46gzRk
Message-ID: <CADg1FFfCjXupCu3VaGprdVtQd3HFn3+rEANBCaJhSZQVkm9e4g@mail.gmail.com>
Subject: Re: [PATCH v7] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	gregkh@linuxfoundation.org
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 10:03=E2=80=AFPM Hsin-chen Chuang <chharry@google.c=
om> wrote:
>
> From: Hsin-chen Chuang <chharry@chromium.org>
>
> Expose the isoc_alt attr with device group to avoid the racing.
>
> Now we create a dev node for btusb. The isoc_alt attr belongs to it and
> it also becomes the parent device of hci dev.
>
> Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control US=
B alt setting")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
>
> Changes in v7:
> - Use container_of() rather than dev_set_drvdata() + dev_get_drvdata()
>
> Changes in v6:
> - Fix EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL
> - Use container_of() rather than dev_set_drvdata() + dev_get_drvdata()
>
> Changes in v5:
> - Merge the ABI doc into this patch
> - Manage the driver data with device
>
> Changes in v4:
> - Create a dev node for btusb. It's now hci dev's parent and the
>   isoc_alt now belongs to it.
> - Since the changes is almost limitted in btusb, no need to add the
>   callbacks in hdev anymore.
>
> Changes in v3:
> - Make the attribute exported only when the isoc_alt is available.
> - In btusb_probe, determine data->isoc before calling hci_alloc_dev_priv
>   (which calls hci_init_sysfs).
> - Since hci_init_sysfs is called before btusb could modify the hdev,
>   add new argument add_isoc_alt_attr for btusb to inform hci_init_sysfs.
>
> Changes in v2:
> - The patch has been removed from series
>
>  .../ABI/stable/sysfs-class-bluetooth          |  13 ++
>  drivers/bluetooth/btusb.c                     | 114 +++++++++++++-----
>  include/net/bluetooth/hci_core.h              |   1 +
>  net/bluetooth/hci_sysfs.c                     |   3 +-
>  4 files changed, 103 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentati=
on/ABI/stable/sysfs-class-bluetooth
> index 36be02471174..c1024c7c4634 100644
> --- a/Documentation/ABI/stable/sysfs-class-bluetooth
> +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> @@ -7,3 +7,16 @@ Description:   This write-only attribute allows users to=
 trigger the vendor reset
>                 The reset may or may not be done through the device trans=
port
>                 (e.g., UART/USB), and can also be done through an out-of-=
band
>                 approach such as GPIO.
> +
> +What:          /sys/class/bluetooth/btusb<usb-intf>/isoc_alt
> +Date:          13-Feb-2025
> +KernelVersion: 6.13
> +Contact:       linux-bluetooth@vger.kernel.org
> +Description:   This attribute allows users to configure the USB Alternat=
e setting
> +               for the specific HCI device. Reading this attribute retur=
ns the
> +               current setting, and writing any supported numbers would =
change
> +               the setting. See the USB Alternate setting definition in =
Bluetooth
> +               core spec 5, vol 4, part B, table 2.1.
> +               If the HCI device is not yet init-ed, the write fails wit=
h -ENODEV.
> +               If the data is not a valid number, the write fails with -=
EINVAL.
> +               The other failures are vendor specific.
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index de3fa725d210..495f0ceba95d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -920,6 +920,8 @@ struct btusb_data {
>         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
>
>         struct qca_dump_info qca_dump;
> +
> +       struct device dev;
>  };
>
>  static void btusb_reset(struct hci_dev *hdev)
> @@ -3682,7 +3684,7 @@ static ssize_t isoc_alt_show(struct device *dev,
>                              struct device_attribute *attr,
>                              char *buf)
>  {
> -       struct btusb_data *data =3D dev_get_drvdata(dev);
> +       struct btusb_data *data =3D container_of(dev, struct btusb_data, =
dev);
>
>         return sysfs_emit(buf, "%d\n", data->isoc_altsetting);
>  }
> @@ -3691,10 +3693,13 @@ static ssize_t isoc_alt_store(struct device *dev,
>                               struct device_attribute *attr,
>                               const char *buf, size_t count)
>  {
> -       struct btusb_data *data =3D dev_get_drvdata(dev);
> +       struct btusb_data *data =3D container_of(dev, struct btusb_data, =
dev);
>         int alt;
>         int ret;
>
> +       if (!data->hdev)
> +               return -ENODEV;
> +
>         if (kstrtoint(buf, 10, &alt))
>                 return -EINVAL;
>
> @@ -3704,6 +3709,36 @@ static ssize_t isoc_alt_store(struct device *dev,
>
>  static DEVICE_ATTR_RW(isoc_alt);
>
> +static struct attribute *btusb_sysfs_attrs[] =3D {
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(btusb_sysfs);
> +
> +static void btusb_sysfs_release(struct device *dev)
> +{
> +       struct btusb_data *data =3D container_of(dev, struct btusb_data, =
dev);
> +
> +       kfree(data);
> +}
> +
> +static const struct device_type btusb_sysfs =3D {
> +       .name    =3D "btusb",
> +       .release =3D btusb_sysfs_release,
> +       .groups  =3D btusb_sysfs_groups,
> +};
> +
> +static struct attribute *btusb_sysfs_isoc_alt_attrs[] =3D {
> +       &dev_attr_isoc_alt.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(btusb_sysfs_isoc_alt);
> +
> +static const struct device_type btusb_sysfs_isoc_alt =3D {
> +       .name    =3D "btusb",
> +       .release =3D btusb_sysfs_release,
> +       .groups  =3D btusb_sysfs_isoc_alt_groups,
> +};
> +
>  static int btusb_probe(struct usb_interface *intf,
>                        const struct usb_device_id *id)
>  {
> @@ -3745,7 +3780,7 @@ static int btusb_probe(struct usb_interface *intf,
>                         return -ENODEV;
>         }
>
> -       data =3D devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
> +       data =3D kzalloc(sizeof(*data), GFP_KERNEL);
>         if (!data)
>                 return -ENOMEM;
>
> @@ -3768,8 +3803,10 @@ static int btusb_probe(struct usb_interface *intf,
>                 }
>         }
>
> -       if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep)
> -               return -ENODEV;
> +       if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep) {
> +               err =3D -ENODEV;
> +               goto out_free_data;
> +       }
>
>         if (id->driver_info & BTUSB_AMP) {
>                 data->cmdreq_type =3D USB_TYPE_CLASS | 0x01;
> @@ -3823,16 +3860,46 @@ static int btusb_probe(struct usb_interface *intf=
,
>
>         data->recv_acl =3D hci_recv_frame;
>
> +       if (id->driver_info & BTUSB_AMP) {
> +               /* AMP controllers do not support SCO packets */
> +               data->isoc =3D NULL;
> +       } else {
> +               /* Interface orders are hardcoded in the specification */
> +               data->isoc =3D usb_ifnum_to_if(data->udev, ifnum_base + 1=
);
> +               data->isoc_ifnum =3D ifnum_base + 1;
> +       }
> +
> +       if (id->driver_info & BTUSB_BROKEN_ISOC)
> +               data->isoc =3D NULL;
> +
> +       /* Init a dev for btusb. The attr depends on the support of isoc.=
 */
> +       if (data->isoc)
> +               data->dev.type =3D &btusb_sysfs_isoc_alt;
> +       else
> +               data->dev.type =3D &btusb_sysfs;
> +       data->dev.class =3D &bt_class;
> +       data->dev.parent =3D &intf->dev;
> +
> +       err =3D dev_set_name(&data->dev, "btusb%s", dev_name(&intf->dev))=
;
> +       if (err)
> +               goto out_free_data;
> +
> +       err =3D device_register(&data->dev);
> +       if (err < 0)
> +               goto out_put_sysfs;
> +
>         hdev =3D hci_alloc_dev_priv(priv_size);
> -       if (!hdev)
> -               return -ENOMEM;
> +       if (!hdev) {
> +               err =3D -ENOMEM;
> +               goto out_free_sysfs;
> +       }
>
>         hdev->bus =3D HCI_USB;
>         hci_set_drvdata(hdev, data);
>
>         data->hdev =3D hdev;
>
> -       SET_HCIDEV_DEV(hdev, &intf->dev);
> +       SET_HCIDEV_DEV(hdev, &data->dev);
>
>         reset_gpio =3D gpiod_get_optional(&data->udev->dev, "reset",
>                                         GPIOD_OUT_LOW);
> @@ -3971,15 +4038,6 @@ static int btusb_probe(struct usb_interface *intf,
>                 hci_set_msft_opcode(hdev, 0xFD70);
>         }
>
> -       if (id->driver_info & BTUSB_AMP) {
> -               /* AMP controllers do not support SCO packets */
> -               data->isoc =3D NULL;
> -       } else {
> -               /* Interface orders are hardcoded in the specification */
> -               data->isoc =3D usb_ifnum_to_if(data->udev, ifnum_base + 1=
);
> -               data->isoc_ifnum =3D ifnum_base + 1;
> -       }
> -
>         if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
>             (id->driver_info & BTUSB_REALTEK)) {
>                 btrtl_set_driver_name(hdev, btusb_driver.name);
> @@ -4012,9 +4070,6 @@ static int btusb_probe(struct usb_interface *intf,
>                         set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirk=
s);
>         }
>
> -       if (id->driver_info & BTUSB_BROKEN_ISOC)
> -               data->isoc =3D NULL;
> -
>         if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
>                 set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirk=
s);
>
> @@ -4067,10 +4122,6 @@ static int btusb_probe(struct usb_interface *intf,
>                                                  data->isoc, data);
>                 if (err < 0)
>                         goto out_free_dev;
> -
> -               err =3D device_create_file(&intf->dev, &dev_attr_isoc_alt=
);
> -               if (err)
> -                       goto out_free_dev;
>         }
>
>         if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
> @@ -4101,6 +4152,16 @@ static int btusb_probe(struct usb_interface *intf,
>         if (data->reset_gpio)
>                 gpiod_put(data->reset_gpio);
>         hci_free_dev(hdev);
> +
> +out_free_sysfs:
> +       device_del(&data->dev);
> +
> +out_put_sysfs:
> +       put_device(&data->dev);
> +       return err;
> +
> +out_free_data:
> +       kfree(data);
>         return err;
>  }
>
> @@ -4117,10 +4178,8 @@ static void btusb_disconnect(struct usb_interface =
*intf)
>         hdev =3D data->hdev;
>         usb_set_intfdata(data->intf, NULL);
>
> -       if (data->isoc) {
> -               device_remove_file(&intf->dev, &dev_attr_isoc_alt);
> +       if (data->isoc)
>                 usb_set_intfdata(data->isoc, NULL);
> -       }
>
>         if (data->diag)
>                 usb_set_intfdata(data->diag, NULL);
> @@ -4152,6 +4211,7 @@ static void btusb_disconnect(struct usb_interface *=
intf)
>                 gpiod_put(data->reset_gpio);
>
>         hci_free_dev(hdev);
> +       device_unregister(&data->dev);
>  }
>
>  #ifdef CONFIG_PM
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 05919848ea95..776dd6183509 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1843,6 +1843,7 @@ int hci_get_adv_monitor_offload_ext(struct hci_dev =
*hdev);
>
>  void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
>
> +extern const struct class bt_class;
>  void hci_init_sysfs(struct hci_dev *hdev);
>  void hci_conn_init_sysfs(struct hci_conn *conn);
>  void hci_conn_add_sysfs(struct hci_conn *conn);
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 041ce9adc378..f8c2c1c3e887 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -6,9 +6,10 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>
> -static const struct class bt_class =3D {
> +const struct class bt_class =3D {
>         .name =3D "bluetooth",
>  };
> +EXPORT_SYMBOL_GPL(bt_class);
>
>  static void bt_link_release(struct device *dev)
>  {
> --
> 2.48.1.601.g30ceb7b040-goog
>

Hi Luiz and Greg,

Friendly ping for review, thanks.

--=20
Best Regards,
Hsin-chen

