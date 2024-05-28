Return-Path: <netdev+bounces-98398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9526F8D13FD
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 07:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05CF1C20BC0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 05:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F9B4CB4E;
	Tue, 28 May 2024 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Of+b1TDk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF258AB4
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 05:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874726; cv=none; b=GSRPMrM2ZRe5EmswQHPDgGgUteHwaw4xleYTyCgOYTE0t1eDgiNRJQr8EP7Nuqy4xjAFok+ZhhrQtR4P4BHCGx1wTykqG8M9C4U8KMCq1/7AQoAhU/LjDllJidmYnoTa5saFwA8cR7C7e57DHzg44s6Qs2XDAdFcrEd/TSufLP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874726; c=relaxed/simple;
	bh=pM12po3gha2D8QBSrm7xtySOBhJB8u/bYiWytufyqHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=As+W7yuaWeQyILPngayj38HH3rzI5NQ4Q39sL6xme5/XE6SFmQGNO27BlStFzcF8TNw5dLUkFfSit87yCoYS85Bg1TqLpBiEfXn/hSUCE872vNJnLyamAckTGwXMFEhMRU0hxZ1f8JG7tL9gGhtQmuuMFxHupp8M9jaQVmOhndE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Of+b1TDk; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5789733769dso3798176a12.1
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 22:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716874723; x=1717479523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPWXo/J3uejSSu8mlmVk0yuvimtdxSykPn1BBI/x35U=;
        b=Of+b1TDkK3J+gm+KDLMTcy42tU4c0ZSfYo0NeXkZK+oP8xDgf5gKNtEU6NUS4Pyvun
         CzFLOQeMBgZig/cING4zTCFgHfQkEbqXDta0D1Hq2zp6jEd7ZW4kLqAP9JIr+6GvoGwS
         93vThHSR6Ignbv7nv4k++uFJqt6miZVkPNHLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716874723; x=1717479523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPWXo/J3uejSSu8mlmVk0yuvimtdxSykPn1BBI/x35U=;
        b=POcUzEHxCNZ2p6Ik1I4fwj+YEVxNb/9khGobrF5UzW6TOrP5Kpm1/tCiJw5saXPmYr
         tKsNO0nGjD0fknwV8kWp3KARu4qN5//sRAKUwnel7ZD8ks6l8m2eTNVFF7fwa4xqf48s
         Wj6BmVDXDSzUEfIrEJ9c2HvTp9yxxI88zLT8IITz/jNPPbqoRJiD8LGalyjHDsPC+f+o
         spNcVtjq8J5So/AL9J4fcJquMec/gCxrdaxHK5dE3SYR9rZ6BfuDW/jicg9v67HpNYi3
         /eCksCO2gYA8BD5UWaaCeLbMdNWzmIMtdg9XcfiwG55wsFHaBauJd3cKmvlPkLXDu0dv
         njeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAbkao67fFmO0H3wpRC0mzxeUz4dVP9ckJm+nnGz7K/GjtkxM8xxOO8RWvYe6SSMBcRzytV9wq+2yqDRKjXKCsRy0Oq2tQ
X-Gm-Message-State: AOJu0YzPvlpNGvEVR9U4Lktdfo84R5qhJjItZ4BohWjwUqYAXuICF0s4
	mguZLy3rMcuBk6h++o6sjf/JBXx5ug/+/HX9GlA+oEFnQFRMh/6KlX7Q7msiXYxZI8+tWc34JFw
	=
X-Google-Smtp-Source: AGHT+IFmSW1+mwL206DSsjtBOU0bGcNFRK0rCAjYofvCi8UZhN+6ru9zsgR2d+BTFOpAPTXS8GGqTA==
X-Received: by 2002:a17:906:11d4:b0:a59:a85c:a5ca with SMTP id a640c23a62f3a-a62616defdamr979059966b.7.1716874723117;
        Mon, 27 May 2024 22:38:43 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda4e18sm566144866b.200.2024.05.27.22.38.42
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 22:38:42 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a352bbd9so70383966b.1
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 22:38:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNPBz+Z1mVkw9+zXzr8YaIPCXsb156UhpsBzXojaQBvgzB+oxgygHZmqKh/IwmVpr2T3IRhGrtSQWs4xZxS2PPjZkqZflL
X-Received: by 2002:a17:906:f753:b0:a5a:89a8:49c5 with SMTP id
 a640c23a62f3a-a6262b14549mr865274566b.33.1716874721422; Mon, 27 May 2024
 22:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524045045.3310641-1-yinghsu@chromium.org>
In-Reply-To: <20240524045045.3310641-1-yinghsu@chromium.org>
From: Ying Hsu <yinghsu@chromium.org>
Date: Tue, 28 May 2024 13:38:02 +0800
X-Gmail-Original-Message-ID: <CAAa9mD0XeCEkpAa-ms71MAKMVJ9zcT=jOCDO+LeBL8CmaXjagg@mail.gmail.com>
Message-ID: <CAAa9mD0XeCEkpAa-ms71MAKMVJ9zcT=jOCDO+LeBL8CmaXjagg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Add vendor-specific packet classification
 for ISO data
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	pmenzel@molgen.mpg.de, horms@kernel.org
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

We just found Rx ACL data packets on the INTEL_STP2_AC7265 BT
controller are using connection handle value >=3D 0x900 (e.g.
3585=3D0xe01):
```
> ISO Data RX: Handle 3585 flags 0x02 dlen 16                              =
                          #536 [hci0] 2024-05-28 00:41:23.779341
```

To mitigate potential issues, we can limit the patch to verified
models like AX211. What do you think?

On Fri, May 24, 2024 at 12:50=E2=80=AFPM Ying Hsu <yinghsu@chromium.org> wr=
ote:
>
> When HCI raw sockets are opened, the Bluetooth kernel module doesn't
> track CIS/BIS connections. User-space applications have to identify
> ISO data by maintaining connection information and look up the mapping
> for each ACL data packet received. Besides, btsnoop log captured in
> kernel couldn't tell ISO data from ACL data in this case.
>
> To avoid additional lookups, this patch introduces vendor-specific
> packet classification for Intel BT controllers to distinguish
> ISO data packets from ACL data packets.
>
> Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> ---
> Tested LE audio unicast recording on a ChromeOS device with Intel AX211
>
> Changes in v3:
> - Move Intel's classify_pkt_type implementation from btusb.c to btintel.c=
.
>
> Changes in v2:
> - Adds vendor-specific packet classificaton in hci_dev.
> - Keeps reclassification in hci_recv_frame.
>
>  drivers/bluetooth/btintel.c      | 19 +++++++++++++++++++
>  drivers/bluetooth/btintel.h      |  6 ++++++
>  drivers/bluetooth/btusb.c        |  1 +
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 16 ++++++++++++++++
>  5 files changed, 43 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 27e03951e68b..bf1bd2b13c96 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -3187,6 +3187,25 @@ void btintel_secure_send_result(struct hci_dev *hd=
ev,
>  }
>  EXPORT_SYMBOL_GPL(btintel_secure_send_result);
>
> +#define BTINTEL_ISODATA_HANDLE_BASE 0x900
> +
> +u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       /*
> +        * Distinguish ISO data packets form ACL data packets
> +        * based on their connection handle value range.
> +        */
> +       if (hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA_PKT) {
> +               __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->handle);
> +
> +               if (hci_handle(handle) >=3D BTINTEL_ISODATA_HANDLE_BASE)
> +                       return HCI_ISODATA_PKT;
> +       }
> +
> +       return hci_skb_pkt_type(skb);
> +}
> +EXPORT_SYMBOL_GPL(btintel_classify_pkt_type);
> +
>  MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
>  MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
>  MODULE_VERSION(VERSION);
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 9dbad1a7c47c..4b77eb8d47a8 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -245,6 +245,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev=
,
>  int btintel_shutdown_combined(struct hci_dev *hdev);
>  void btintel_hw_error(struct hci_dev *hdev, u8 code);
>  void btintel_print_fseq_info(struct hci_dev *hdev);
> +u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb);
>  #else
>
>  static inline int btintel_check_bdaddr(struct hci_dev *hdev)
> @@ -378,4 +379,9 @@ static inline void btintel_hw_error(struct hci_dev *h=
dev, u8 code)
>  static inline void btintel_print_fseq_info(struct hci_dev *hdev)
>  {
>  }
> +
> +static inline u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct =
sk_buff *skb)
> +{
> +       return hci_skb_pkt_type(skb);
> +}
>  #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 79aefdb3324d..2ecc6d1140a5 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4451,6 +4451,7 @@ static int btusb_probe(struct usb_interface *intf,
>                 /* Transport specific configuration */
>                 hdev->send =3D btusb_send_frame_intel;
>                 hdev->cmd_timeout =3D btusb_intel_cmd_timeout;
> +               hdev->classify_pkt_type =3D btintel_classify_pkt_type;
>
>                 if (id->driver_info & BTUSB_INTEL_NO_WBS_SUPPORT)
>                         btintel_set_flag(hdev, INTEL_ROM_LEGACY_NO_WBS_SU=
PPORT);
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 9231396fe96f..7b7068a84ff7 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -649,6 +649,7 @@ struct hci_dev {
>         int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
>                                      struct bt_codec *codec, __u8 *vnd_le=
n,
>                                      __u8 **vnd_data);
> +       u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *skb=
);
>  };
>
>  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index b3ee9ff17624..8b817a99cefd 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2941,15 +2941,31 @@ int hci_reset_dev(struct hci_dev *hdev)
>  }
>  EXPORT_SYMBOL(hci_reset_dev);
>
> +static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct sk_buff=
 *skb)
> +{
> +       if (hdev->classify_pkt_type)
> +               return hdev->classify_pkt_type(hdev, skb);
> +
> +       return hci_skb_pkt_type(skb);
> +}
> +
>  /* Receive frame from HCI drivers */
>  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> +       u8 dev_pkt_type;
> +
>         if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
>                       && !test_bit(HCI_INIT, &hdev->flags))) {
>                 kfree_skb(skb);
>                 return -ENXIO;
>         }
>
> +       /* Check if the driver agree with packet type classification */
> +       dev_pkt_type =3D hci_dev_classify_pkt_type(hdev, skb);
> +       if (hci_skb_pkt_type(skb) !=3D dev_pkt_type) {
> +               hci_skb_pkt_type(skb) =3D dev_pkt_type;
> +       }
> +
>         switch (hci_skb_pkt_type(skb)) {
>         case HCI_EVENT_PKT:
>                 break;
> --
> 2.45.1.288.g0e0cd299f1-goog
>

