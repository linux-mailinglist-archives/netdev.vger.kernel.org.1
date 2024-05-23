Return-Path: <netdev+bounces-97815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587318CD5A3
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5576281595
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7DD14BFA8;
	Thu, 23 May 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvSXR7qA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53ED14BF90;
	Thu, 23 May 2024 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474224; cv=none; b=nOiMtFZebmeUaLR7bEC3BMh3zcdqYMk+FlRcYj2sXwo5kVQQ1emcYvYT66CujZBsPRZ+i9CiVvrvXB8u/1XNrLqLCaZEINsFJ0I95ZkxSg6La+xJviIEfOes2Hm5pOkEylNkjNwGY+Mh2WQzo9umYR16IRlLt64ufu65qYBBev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474224; c=relaxed/simple;
	bh=yrGCGjJOaGbQ0l/A8VzBNklsCpurFdk/1Chj5MJVhT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMR+ciuRBx9NLqJdXUQdAfSf70Ck9EBLGu8W9fnRvuWP47k0kWm3lMrWBbQfvnDG9KE3frQVeN8FojJTQJCUIpkSn0PYv///5NueET8zVvB0aQFtJimelbvWO91kypfMkrrEiYP+csIBF++ugoAxYf+hHObLntDZwSjKsbpAi+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvSXR7qA; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e951296784so8340761fa.1;
        Thu, 23 May 2024 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716474221; x=1717079021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JG/V5KaB4zeIXCOM315hO8c28tW7uX6d2gIJRmze4Sk=;
        b=UvSXR7qA9OdaXZbX96iV2lNFOxmYzi8ZG0WPc7xoJFozc/5Mkb9uEoMyZz90/1VhRC
         xnEZYkwdu9wQ+w+pXEjtkoSjn8rcpGloXWgV9JtkuQIU2+wWLDYG6WAxipWY0MfQ8hTH
         ErXn3/NYOsSf8nGkXhDPL6haPELb2jRey9lKn9IGLEZGxSVOZ9yzMLkP97XZE3yJwxKy
         TahwFtEa+Zua2vA9b7BUuojdGymiasM0UU3YjK9pLZrICyo61B/mrheTjrZc9zbPn8c7
         U+91VMz3+11GOvqyoyYJ/VlfMamTJgeWkT5DQnlm+bS1L7O18NgRy/bwvvlK/Zs0OYQl
         oOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716474221; x=1717079021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JG/V5KaB4zeIXCOM315hO8c28tW7uX6d2gIJRmze4Sk=;
        b=inLvXStIaRKsoyp8pr5U+LarSRXM02C1EKQ0PyznliLQhAA7y9WatJC1Tuzomu7hBq
         b49+1x5SaDkJYgl4JHXhf+3SWceMDdX+8/jxlV37HTLVXffz5Zz8rDkEXV/4cXv9JYn3
         k3XWvHmQ0gY/LTQZQYbJ2zM2cexzBLvnF8pVH6E4YHyJI9Og9BwJLcyidot2aPZ5RXsM
         MS1x/Gzq7XNYCHYxWCNkK67ulo5P8HmDJznAzRWfw8FkJUXnuS5VxEPCubZhbaVnK9RB
         cjk7MsifZgONdBU5+4Y1H7KfWjBmiDMhh/6Nux5ibd/4PXUK5U2a1KeUCgpueX3GLYP6
         Adhw==
X-Forwarded-Encrypted: i=1; AJvYcCV4PjwWuqoXVc8HsbmUBfe6crwhWtUNdkL+rNjA+QJ1fPgURJSyXRENlo0hz9l8v0Yobyuk4l6YN9aGwQp9U8TQRo4UZtRJ+5GrkOIJvSgJ5Yj8eTlrfLy3rs8Z5MU565Jiqqc6
X-Gm-Message-State: AOJu0YxAve2eq4/yOnA56SYqJmraHMNga/qOCwMF2SGfa6Dk/ZMnPAlz
	M68N8KGhwAxOL0vM3mhI0foIzotKIDWTOVKFfo0x2Ucdbk9iXSH78hpJ/bYHIaY85nOHc0U0JJA
	d0PiXeFSIGVGPFceZJkyJymbtBZY=
X-Google-Smtp-Source: AGHT+IGiRbs1hDX03MTpGZZ2hY8YXqvy0WZ9IOUYqgmmAlA8zEqhk35ziVBDHsEFXF6DXxoKy9iv4DOcHv0cMorh2Bc=
X-Received: by 2002:a2e:80ca:0:b0:2e7:1621:89d0 with SMTP id
 38308e7fff4ca-2e951b4ee15mr8234391fa.2.1716474220912; Thu, 23 May 2024
 07:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523060934.2883716-1-yinghsu@chromium.org>
In-Reply-To: <20240523060934.2883716-1-yinghsu@chromium.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 May 2024 10:23:23 -0400
Message-ID: <CABBYNZKwLTri10NfQ07sywymPCFq2mwvb8==Zjn1QMD-kwpobA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add vendor-specific packet classification
 for ISO data
To: Ying Hsu <yinghsu@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ying,

On Thu, May 23, 2024 at 2:09=E2=80=AFAM Ying Hsu <yinghsu@chromium.org> wro=
te:
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
> Changes in v2:
> - Adds vendor-specific packet classificaton in hci_dev.
> - Keeps reclassification in hci_recv_frame.
>
>  drivers/bluetooth/btusb.c        | 19 +++++++++++++++++++
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 16 ++++++++++++++++
>  3 files changed, 36 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 79aefdb3324d..75561e749c50 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -966,6 +966,24 @@ static void btusb_intel_cmd_timeout(struct hci_dev *=
hdev)
>         gpiod_set_value_cansleep(reset_gpio, 0);
>  }
>
> +#define BT_USB_INTEL_ISODATA_HANDLE_BASE 0x900
> +
> +static u8 btusb_intel_classify_pkt_type(struct hci_dev *hdev, struct sk_=
buff *skb)

We might as well move this to btintel.c since it should not be USB specific=
.

> +{
> +       /*
> +        * Distinguish ISO data packets form ACL data packets
> +        * based on their conneciton handle value range.
> +        */
> +       if (hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA_PKT) {
> +               __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->handle);
> +
> +               if (hci_handle(handle) >=3D BT_USB_INTEL_ISODATA_HANDLE_B=
ASE)
> +                       return HCI_ISODATA_PKT;
> +       }
> +
> +       return hci_skb_pkt_type(skb);
> +}
> +
>  #define RTK_DEVCOREDUMP_CODE_MEMDUMP           0x01
>  #define RTK_DEVCOREDUMP_CODE_HW_ERR            0x02
>  #define RTK_DEVCOREDUMP_CODE_CMD_TIMEOUT       0x03
> @@ -4451,6 +4469,7 @@ static int btusb_probe(struct usb_interface *intf,
>                 /* Transport specific configuration */
>                 hdev->send =3D btusb_send_frame_intel;
>                 hdev->cmd_timeout =3D btusb_intel_cmd_timeout;
> +               hdev->classify_pkt_type =3D btusb_intel_classify_pkt_type=
;
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


--=20
Luiz Augusto von Dentz

