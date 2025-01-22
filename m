Return-Path: <netdev+bounces-160409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC86A1992F
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 20:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1907188B814
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 19:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1522153F4;
	Wed, 22 Jan 2025 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GE4DFN6B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD11BC099;
	Wed, 22 Jan 2025 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737574541; cv=none; b=IhMvV4Eu5EJmzu5N5v8Twba74b5QAh9NgjfSyUXNmCRgqBB6xFFtKPOEE611Tc08kFcXuYj5iilhiBjC9M4fLMFHk2k8u/TlbBmHvw6cCpHE46w+2NFJkbgDy9W4UB4WTm86EjOCcmuxypHEIoz2B7pbhRlL9ZSTqjcO3q250dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737574541; c=relaxed/simple;
	bh=pWdK2mQDY5HlXeQS6usAgbsfhp/bz3al25i+V8ItNhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btwrdA7PKMHpooogjbEBhWy36NLcjNzl5LdX9lzQqJXgeEMRuAXKf8My8VExeTujqJT0K6oWFDDGfZl14jaCIqYGKuIRESFVlXSBKUcw+IrZsBXMtrLqTaruopDtsVtuXOPfuAiuadavhieYKtoOlTr631jNHbc0S5pAcVjtByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GE4DFN6B; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30616d71bb0so566561fa.3;
        Wed, 22 Jan 2025 11:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737574538; x=1738179338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViuIGnmpsM7OpwaOSMp9fmLpeslWIcGU8ME3qhVjoYQ=;
        b=GE4DFN6BrmY7nyX9gO7ItsFA3htZafey9A8+alb+vMduru9Bx79v/ck/ZmPbsagOT9
         5yElufT/oguOhEH43yiJ9pVuvKocrS152kLPdbRQ+xQGRC5wAV3oV6avkqa2lC6VLf4W
         npTztn4wnNYPIkTqoKIFUiJvJ77ZokyY33CCma8/DZsFPFDPei+qKOg86OUFWxSY8e8I
         V66NJMKDkNOpR8zV2ruzNC9bhNzu7qPM0FIJZo3lgr4Xdfw8jRdKdpEiSCRUcBPavY7g
         cp1PvYM6C/jcLa1fr5G1qZibzSYCejF1lgyXUFdn9O04un2Em/cKVf0PDqTp/pHS+Zle
         Q1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737574538; x=1738179338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViuIGnmpsM7OpwaOSMp9fmLpeslWIcGU8ME3qhVjoYQ=;
        b=lN9OkhaZ2lPD0Sdt9hBGqJNpxUE4fWwUOCeLrA6GOoWdf01Wikb+W79NIyFAa2vvSR
         LkoEZv+ozzvRYyjro8s67W0uHuFds6M0bAxRLQ+IvkOAYY32DWGdbuE6+zeQJtqMN2O1
         6w5qisMWKKL9WvtvCyPwylLk9cJzr3Dcaman53pN2wRLPcXdYOkKukVd4tsWM6iRQMl5
         KAwCG70Nnq3iNAqMYgAzzVI6lUgTRmKj45SnpXmv+9gQsBmGCrrCz4FPI3wGSaJgIpnS
         TmGJLKjz336XWpBIB6mKKGT+nkG4kNdKXrTMytgHjZ9VIFM6YZKkqYdXTPTiN2DLRDVj
         HvPg==
X-Forwarded-Encrypted: i=1; AJvYcCV8j5fY3W98bmbhx3figazxoHnKN3L3QgIDNC0yz+m7NlbpRdpFRmO56Tjp6vY0mTwnkwp+EODVGOPrvuY=@vger.kernel.org, AJvYcCW+UoyILwDeU3rulGreNfvVfJGPVf5Rjq1oVNimG+Xdu+0/M3WcUfY5We+DaqPKvr6iT27PpMF9@vger.kernel.org
X-Gm-Message-State: AOJu0YzqjYp/h6SIq/ipwxv4/TjGPqdkjBow5vJuQuVOxof/VxVKER1j
	xNNYGUPlfmAm3UWW82HViBI1qKv9rxm4iqtZG3qnZKh6jxo1UND5h4VhvNI++huYotIE+3e8p7s
	em2A8U7gY1+w3WHMaL9XaYm9yjiA=
X-Gm-Gg: ASbGnctn0FHfQKBIbyJmiumbIb9JMkzUY0JwOSB74dI81iX67jRAL9a3RnYPI7VlOKf
	hQ5l3+zOMz0aa9R+pZJTY9vUN+b4226V0utrZE0qq3nGZ06cbPMZp
X-Google-Smtp-Source: AGHT+IGumYq4DOyOxiGgYC5VbRbhEou7FwYr9bPhnRQ+y5IECo4fGxQYFT3sGlddNrJbrWhKtV93CBD0mkNuc6/HLhM=
X-Received: by 2002:a05:651c:242:b0:2ff:a89b:4210 with SMTP id
 38308e7fff4ca-3072ca5c9f4mr75515661fa.8.1737574537566; Wed, 22 Jan 2025
 11:35:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122131925.v2.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
In-Reply-To: <20250122131925.v2.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Jan 2025 14:35:25 -0500
X-Gm-Features: AbW1kvYkVnhdTTX1O6DhXg2D4FpSu5nKWLJ-SUQr4IwBwYo32PfG3W1vWvIz4Ig
Message-ID: <CABBYNZKoXT4u4=KJZUvG4g1OEi+xQ-LchiH8gvEZURNTzJoQDw@mail.gmail.com>
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

On Wed, Jan 22, 2025 at 12:20=E2=80=AFAM Hsin-chen Chuang <chharry@google.c=
om> wrote:
>
> From: Hsin-chen Chuang <chharry@chromium.org>
>
> Use device group to avoid the racing. To reuse the group defined in
> hci_sysfs.c, defined 2 callbacks switch_usb_alt_setting and
> read_usb_alt_setting which are only registered in btusb.
>
> Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control US=
B alt setting")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
>
> (no changes since v1)
>
>  drivers/bluetooth/btusb.c        | 42 ++++++++------------------------
>  include/net/bluetooth/hci_core.h |  2 ++
>  net/bluetooth/hci_sysfs.c        | 33 +++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 75a0f15819c4..bf210275e5b7 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2221,6 +2221,13 @@ static int btusb_switch_alt_setting(struct hci_dev=
 *hdev, int new_alts)
>         return 0;
>  }
>
> +static int btusb_read_alt_setting(struct hci_dev *hdev)
> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +
> +       return data->isoc_altsetting;
> +}
> +
>  static struct usb_host_interface *btusb_find_altsetting(struct btusb_dat=
a *data,
>                                                         int alt)
>  {
> @@ -3650,32 +3657,6 @@ static const struct file_operations force_poll_syn=
c_fops =3D {
>         .llseek         =3D default_llseek,
>  };
>
> -static ssize_t isoc_alt_show(struct device *dev,
> -                            struct device_attribute *attr,
> -                            char *buf)
> -{
> -       struct btusb_data *data =3D dev_get_drvdata(dev);
> -
> -       return sysfs_emit(buf, "%d\n", data->isoc_altsetting);
> -}
> -
> -static ssize_t isoc_alt_store(struct device *dev,
> -                             struct device_attribute *attr,
> -                             const char *buf, size_t count)
> -{
> -       struct btusb_data *data =3D dev_get_drvdata(dev);
> -       int alt;
> -       int ret;
> -
> -       if (kstrtoint(buf, 10, &alt))
> -               return -EINVAL;
> -
> -       ret =3D btusb_switch_alt_setting(data->hdev, alt);
> -       return ret < 0 ? ret : count;
> -}
> -
> -static DEVICE_ATTR_RW(isoc_alt);
> -
>  static int btusb_probe(struct usb_interface *intf,
>                        const struct usb_device_id *id)
>  {
> @@ -4040,9 +4021,8 @@ static int btusb_probe(struct usb_interface *intf,
>                 if (err < 0)
>                         goto out_free_dev;
>
> -               err =3D device_create_file(&intf->dev, &dev_attr_isoc_alt=
);
> -               if (err)
> -                       goto out_free_dev;
> +               hdev->switch_usb_alt_setting =3D btusb_switch_alt_setting=
;
> +               hdev->read_usb_alt_setting =3D btusb_read_alt_setting;
>         }
>
>         if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
> @@ -4089,10 +4069,8 @@ static void btusb_disconnect(struct usb_interface =
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
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index f756fac95488..5d3ec5ff5adb 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -641,6 +641,8 @@ struct hci_dev {
>                                      struct bt_codec *codec, __u8 *vnd_le=
n,
>                                      __u8 **vnd_data);
>         u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *skb=
);
> +       int (*switch_usb_alt_setting)(struct hci_dev *hdev, int new_alts)=
;
> +       int (*read_usb_alt_setting)(struct hci_dev *hdev);
>  };
>
>  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 041ce9adc378..887aa1935b1e 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -102,8 +102,41 @@ static ssize_t reset_store(struct device *dev, struc=
t device_attribute *attr,
>  }
>  static DEVICE_ATTR_WO(reset);
>
> +static ssize_t isoc_alt_show(struct device *dev,
> +                            struct device_attribute *attr,
> +                            char *buf)
> +{
> +       struct hci_dev *hdev =3D to_hci_dev(dev);
> +
> +       if (hdev->read_usb_alt_setting)
> +               return sysfs_emit(buf, "%d\n", hdev->read_usb_alt_setting=
(hdev));
> +
> +       return -ENODEV;
> +}
> +
> +static ssize_t isoc_alt_store(struct device *dev,
> +                             struct device_attribute *attr,
> +                             const char *buf, size_t count)
> +{
> +       struct hci_dev *hdev =3D to_hci_dev(dev);
> +       int alt;
> +       int ret;
> +
> +       if (kstrtoint(buf, 10, &alt))
> +               return -EINVAL;
> +
> +       if (hdev->switch_usb_alt_setting) {
> +               ret =3D hdev->switch_usb_alt_setting(hdev, alt);
> +               return ret < 0 ? ret : count;
> +       }
> +
> +       return -ENODEV;
> +}
> +static DEVICE_ATTR_RW(isoc_alt);
> +
>  static struct attribute *bt_host_attrs[] =3D {
>         &dev_attr_reset.attr,
> +       &dev_attr_isoc_alt.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(bt_host);

While this fixes the race it also forces the inclusion of an attribute
that is driver specific, so I wonder if we should introduce some
internal interface to register driver specific entries like this.

> --
> 2.48.1.262.g85cc9f2d1e-goog
>


--=20
Luiz Augusto von Dentz

