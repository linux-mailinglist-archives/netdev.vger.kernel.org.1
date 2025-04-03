Return-Path: <netdev+bounces-179166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537DAA7B002
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5179188637E
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1345425B680;
	Thu,  3 Apr 2025 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXjye9VD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C7254AE6;
	Thu,  3 Apr 2025 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743710482; cv=none; b=HS83Byj5mNwSvFjjANUWKfDr4RNq1ZqGbVkU4lBtBC1tOy23Rt2n8TEDWOCayIPyti3WH9tIT+kf4oO628XVJHfkKo3u9Gg3I5CMD/FCOpKtaJAN6Z7CRpkvr43fHsFQyZdHvdUu76h4e7MizIZ/VGMpijw8T5ISZwfbzLe834Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743710482; c=relaxed/simple;
	bh=NIcugxrGCTMeFIo/ilYLA1E0+NtZZxh0KZqUq8ENVoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmDYWBKiKaEF7VPa7FfqDIuewM+1d3KXsUB+xtOCXG47bnmFZ1xEVQCk9fllJdiY0+tboJZKq5H9rjyjqeo18SC0u6IHVTjyEjmEbP4GZMN8RHxCDi705nSyQKJ2yoD3vvZpVcGPCtfMXJ3q0CpqyX/XGmNE9YWsFtQ1OItzLN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXjye9VD; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30c461a45f8so12855121fa.1;
        Thu, 03 Apr 2025 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743710476; x=1744315276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp5SwNpnRHfyD00L0+eXHCyeHlQRWoAaMcVufCqv91Q=;
        b=AXjye9VDD0F1NddFepfvisiGvbhM+zcEtuZWQaSk9TwdR4yqBfflHTSYUrPOGyccLA
         ObZGcBavnozgFgz/JhbW2imwXwidruYfLqpfRQg5l3K7p3oXo1n8dlxBz9hUylVI0XLL
         qg4DQEBevThlLd7aWivaqoYzY7koYHrKb177nwGDzJ2JrCRfkKYVv8ZsPC/6EyPdWK2W
         G1lZaCbOfHpWt4CnAWc5uyd3ZnsgZkAQbxrKkQlW6kOB7orwHb7od8Haxqk1lbG5r2JW
         zGQ6ftcIxOA550kExqTGtExVeQEvabPNDbiffXfMXQHFxJQQvh+C8supVZXRodnbkjXi
         IugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743710476; x=1744315276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gp5SwNpnRHfyD00L0+eXHCyeHlQRWoAaMcVufCqv91Q=;
        b=NSGPp628DjQXEHO7k0hUR42uuGOWhE17HTIJ4E+LYkV7rZw8XIgqH5EHhjW9puvAwC
         EEQvc8x0nFYP0ekmVtqwwpMaAlmF9A/JYq0PADaa8k/ZjVfyRDeKJ5eOI0TqkI5gqA9o
         fl8fsBvH9/QygRYmgOjior+7VX1ZHKMa6v2jvd31+FOiKtjHoV3BgaIOCAdaKmzIwoT4
         9Gj2bTs60W3I+vDN2tOOnBd0KkMw/Sivq1bk6zOBSCRf6QFmqJbQE6moc/Z6xv3BDAV+
         v8/jlT5Z/SKV5tLKTksElPT5Yuy0y/a2MECEUCpKvAJR86LLrnOgr5N++vBECXNwx1IY
         qcDg==
X-Forwarded-Encrypted: i=1; AJvYcCU7EmmZ1cvE43bRzA2I4sGukrEBa6Bwfd11z2Zi2ke1fXsIE4s3Gsn+JHsvnagvQYuB/HMGCYbEoQhhgEfR@vger.kernel.org, AJvYcCUZYD1Rwvvej6luHbRlaXRWuEhKdLBItckB5uqK/jysjwnUVqg0qA4Zhmi2c2M/XdcSyXGFzQ3Ja28fObDH7Zg=@vger.kernel.org, AJvYcCWRy9Q5Q7FyS/paAOG/FCzOUpmlDpAHv2ME6yWzJkCTloJspRPU4hGKLiXZiefTWvEHWUeIIz3h@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo21ioj8ORybnr3iA2X9/5M8wX9PY37T4m7/qa03ZVAvkRanit
	9bL8dJ5iHCJ1WXhazjId1Ztt4KjBGAD6ezml1QyL6Sm0dR9tvxUr0mDQJnnQy5YOKxAKQCgSWIW
	2v73qsTCi7kkzAr7yjxjfEpWxRuU=
X-Gm-Gg: ASbGncvJn4O2uTZcs2IpJmNdnp1K8Ohe1uFh9/mnn/WL1Evt+xFH8XKwYUDbYnw64zx
	JikCEin/6IG+A0h7vRgbywmZQodN2iivbt0Y+DQ6ilUoMqe5PRM2cIZVH6jDpqVjKwMMn+udCVl
	7XBumwF7yTA1Ej/UjX5fQngO3F
X-Google-Smtp-Source: AGHT+IFHX1QsTqlZsJ9AIOF6/XL97ehCoVbt8vCXWqwBV0i0Po4JMvL7erMuBmCi4+9t8WOC0f0fLnUlciYNl6wXJYA=
X-Received: by 2002:a05:651c:154e:b0:30b:badf:75f0 with SMTP id
 38308e7fff4ca-30f0be061b3mr29201fa.2.1743710475489; Thu, 03 Apr 2025 13:01:15
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402162737.3271704-1-chharry@google.com>
In-Reply-To: <20250402162737.3271704-1-chharry@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Apr 2025 16:01:02 -0400
X-Gm-Features: ATxdqUGsy-YnLinPasxcjTshijUMJKU9LCLM7Z9jBz3AXUUOCfLaoTmO7A9mlAM
Message-ID: <CABBYNZJhxZOa30z1jxbnNpYJJb=QM1RZtpnL-Hp+beE_1VOZqg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Introduce HCI Driver Packet
To: Hsin-chen Chuang <chharry@google.com>
Cc: Hsin-chen Chuang <chharry@chromium.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Wed, Apr 2, 2025 at 12:28=E2=80=AFPM Hsin-chen Chuang <chharry@google.co=
m> wrote:
>
> From: Hsin-chen Chuang <chharry@chromium.org>
>
> Although commit 75ddcd5ad40e ("Bluetooth: btusb: Configure altsetting
> for HCI_USER_CHANNEL") has enabled the HCI_USER_CHANNEL user to send out
> SCO data through USB Bluetooth chips, it's observed that with the patch
> HFP is flaky on most of the existing USB Bluetooth controllers: Intel
> chips sometimes send out no packet for Transparent codec; MTK chips may
> generate SCO data with a wrong handle for CVSD codec; RTK could split
> the data with a wrong packet size for Transparent codec; ... etc.
>
> To address the issue above one needs to reset the altsetting back to
> zero when there is no active SCO connection, which is the same as the
> BlueZ behavior, and another benefit is the bus doesn't need to reserve
> bandwidth when no SCO connection.
>
> This patch introduces a fundamental solution that lets the user space
> program to configure the altsetting freely:
> - Define the new packet type HCI_DRV_PKT which is specifically used for
>   communication between the user space program and the Bluetooth drviers
> - Define the btusb driver command HCI_DRV_OP_SWITCH_ALT_SETTING which
>   indicates the expected altsetting from the user space program
> - btusb intercepts the command and adjusts the Isoc endpoint
>   correspondingly
>
> This patch is tested on ChromeOS devices. The USB Bluetooth models
> (CVSD, TRANS alt3, and TRANS alt6) could pass the stress HFP test narrow
> band speech and wide band speech.
>
> Cc: chromeos-bluetooth-upstreaming@chromium.org
> Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control US=
B alt setting")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
>
>  drivers/bluetooth/btusb.c       | 112 ++++++++++++++++++++++++++++++++
>  drivers/bluetooth/hci_drv_pkt.h |  62 ++++++++++++++++++
>  include/net/bluetooth/hci.h     |   1 +
>  include/net/bluetooth/hci_mon.h |   2 +
>  net/bluetooth/hci_core.c        |   2 +
>  net/bluetooth/hci_sock.c        |  12 +++-
>  6 files changed, 189 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/bluetooth/hci_drv_pkt.h
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5012b5ff92c8..644a0f13f8ee 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -26,6 +26,7 @@
>  #include "btbcm.h"
>  #include "btrtl.h"
>  #include "btmtk.h"
> +#include "hci_drv_pkt.h"
>
>  #define VERSION "0.8"
>
> @@ -2151,6 +2152,111 @@ static int submit_or_queue_tx_urb(struct hci_dev =
*hdev, struct urb *urb)
>         return 0;
>  }
>
> +static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts);
> +
> +static int btusb_drv_process_cmd(struct hci_dev *hdev, struct sk_buff *c=
md_skb)
> +{
> +       struct hci_drv_cmd_hdr *hdr;
> +       u16 opcode, cmd_len;
> +
> +       hdr =3D skb_pull_data(cmd_skb, sizeof(*hdr));
> +       if (!hdr)
> +               return -EILSEQ;
> +
> +       opcode =3D le16_to_cpu(hdr->opcode);
> +       cmd_len =3D le16_to_cpu(hdr->len);
> +       if (cmd_len !=3D cmd_skb->len)
> +               return -EILSEQ;
> +
> +       switch (opcode) {
> +       case HCI_DRV_OP_READ_SUPPORTED_DRIVER_COMMANDS: {
> +               struct hci_drv_resp_read_supported_driver_commands *resp;
> +               struct sk_buff *resp_skb;
> +               struct btusb_data *data =3D hci_get_drvdata(hdev);
> +               int ret;
> +               u16 num_commands =3D 1; /* SUPPORTED_DRIVER_COMMANDS */
> +
> +               if (data->isoc)
> +                       num_commands++; /* SWITCH_ALT_SETTING */
> +
> +               resp_skb =3D hci_drv_skb_alloc(
> +                       opcode, sizeof(*resp) + num_commands * sizeof(__l=
e16),
> +                       GFP_KERNEL);
> +               if (!resp_skb)
> +                       return -ENOMEM;
> +
> +               resp =3D skb_put(resp_skb,
> +                              sizeof(*resp) + num_commands * sizeof(__le=
16));
> +               resp->status =3D HCI_DRV_STATUS_SUCCESS;
> +               resp->num_commands =3D cpu_to_le16(num_commands);
> +               resp->commands[0] =3D
> +                       cpu_to_le16(HCI_DRV_OP_READ_SUPPORTED_DRIVER_COMM=
ANDS);
> +
> +               if (data->isoc)
> +                       resp->commands[1] =3D
> +                               cpu_to_le16(HCI_DRV_OP_SWITCH_ALT_SETTING=
);
> +
> +               ret =3D hci_recv_frame(hdev, resp_skb);
> +               if (ret)
> +                       return ret;
> +
> +               kfree_skb(cmd_skb);
> +               return 0;
> +       }

If you have to enclose a case with {} then it probably makes more
sense to add a dedicated function to do that, that said it would
probably be best to add a struct table that can be used to define
supported commands. I also recommend splitting the commit adding the
command from the introduction of HCI_DRV_PKT.

> +       case HCI_DRV_OP_SWITCH_ALT_SETTING: {
> +               struct hci_drv_cmd_switch_alt_setting *cmd;
> +               struct hci_drv_resp_status *resp;
> +               struct sk_buff *resp_skb;
> +               int ret;
> +               u8 status;
> +
> +               resp_skb =3D hci_drv_skb_alloc(opcode, sizeof(*resp), GFP=
_KERNEL);
> +               if (!resp_skb)
> +                       return -ENOMEM;
> +
> +               cmd =3D skb_pull_data(cmd_skb, sizeof(*cmd));
> +               if (!cmd || cmd_skb->len || cmd->new_alt > 6) {
> +                       status =3D HCI_DRV_STATUS_INVALID_PARAMETERS;
> +               } else {
> +                       ret =3D btusb_switch_alt_setting(hdev, cmd->new_a=
lt);
> +                       if (ret)
> +                               status =3D HCI_DRV_STATUS_UNSPECIFIED_ERR=
OR;
> +                       else
> +                               status =3D HCI_DRV_STATUS_SUCCESS;
> +               }
> +
> +               resp =3D skb_put(resp_skb, sizeof(*resp));
> +               resp->status =3D status;
> +
> +               ret =3D hci_recv_frame(hdev, resp_skb);
> +               if (ret)
> +                       return ret;
> +
> +               kfree_skb(cmd_skb);
> +               return 0;
> +       }
> +       default: {
> +               struct hci_drv_resp_status *resp;
> +               struct sk_buff *resp_skb;
> +               int ret;
> +
> +               resp_skb =3D hci_drv_skb_alloc(opcode, sizeof(*resp), GFP=
_KERNEL);
> +               if (!resp_skb)
> +                       return -ENOMEM;
> +
> +               resp =3D skb_put(resp_skb, sizeof(*resp));
> +               resp->status =3D HCI_DRV_STATUS_UNKNOWN_COMMAND;
> +
> +               ret =3D hci_recv_frame(hdev, resp_skb);
> +               if (ret)
> +                       return ret;
> +
> +               kfree_skb(cmd_skb);
> +               return 0;
> +       }
> +       }
> +}
> +
>  static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         struct urb *urb;
> @@ -2192,6 +2298,9 @@ static int btusb_send_frame(struct hci_dev *hdev, s=
truct sk_buff *skb)
>                         return PTR_ERR(urb);
>
>                 return submit_or_queue_tx_urb(hdev, urb);
> +
> +       case HCI_DRV_PKT:
> +               return btusb_drv_process_cmd(hdev, skb);
>         }
>
>         return -EILSEQ;
> @@ -2669,6 +2778,9 @@ static int btusb_send_frame_intel(struct hci_dev *h=
dev, struct sk_buff *skb)
>                         return PTR_ERR(urb);
>
>                 return submit_or_queue_tx_urb(hdev, urb);
> +
> +       case HCI_DRV_PKT:
> +               return btusb_drv_process_cmd(hdev, skb);
>         }
>
>         return -EILSEQ;
> diff --git a/drivers/bluetooth/hci_drv_pkt.h b/drivers/bluetooth/hci_drv_=
pkt.h
> new file mode 100644
> index 000000000000..800e0090f816
> --- /dev/null
> +++ b/drivers/bluetooth/hci_drv_pkt.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 Google Corporation
> + */
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci.h>
> +
> +struct hci_drv_cmd_hdr {
> +       __le16  opcode;
> +       __le16  len;
> +} __packed;
> +
> +struct hci_drv_resp_hdr {
> +       __le16  opcode;
> +       __le16  len;
> +} __packed;
> +
> +struct hci_drv_resp_status {
> +       __u8    status;
> +} __packed;
> +
> +#define HCI_DRV_STATUS_SUCCESS                 0x00
> +#define HCI_DRV_STATUS_UNSPECIFIED_ERROR       0x01
> +#define HCI_DRV_STATUS_UNKNOWN_COMMAND         0x02
> +#define HCI_DRV_STATUS_INVALID_PARAMETERS      0x03
> +
> +/* Common commands that make sense on all drivers start from 0x0000. */
> +
> +#define HCI_DRV_OP_READ_SUPPORTED_DRIVER_COMMANDS      0x0000
> +struct hci_drv_resp_read_supported_driver_commands {
> +       __u8    status;
> +       __le16  num_commands;
> +       __le16  commands[];
> +} __packed;
> +
> +/* btusb specific commands start from 0x1135.
> + * No particular reason - It's my lucky number.
> + */
> +
> +#define HCI_DRV_OP_SWITCH_ALT_SETTING  0x1135

Id actually start from 0x00, each driver can have its own command
opcodes, and we can probably add a description to Read Supported
Driver Commands in case it is not clear or for decoding purposes, we
could also return some driver info so the upper layers know what is
the driver.

> +struct hci_drv_cmd_switch_alt_setting {
> +       __u8    new_alt;
> +} __packed;
> +
> +static inline struct sk_buff *hci_drv_skb_alloc(u16 opcode, u16 plen, gf=
p_t how)
> +{
> +       struct hci_drv_resp_hdr *hdr;
> +       struct sk_buff *skb;
> +
> +       skb =3D bt_skb_alloc(sizeof(*hdr) + plen, how);
> +       if (!skb)
> +               return NULL;
> +
> +       hdr =3D skb_put(skb, sizeof(*hdr));
> +       hdr->opcode =3D __cpu_to_le16(opcode);
> +       hdr->len =3D __cpu_to_le16(plen);
> +
> +       hci_skb_pkt_type(skb) =3D HCI_DRV_PKT;
> +
> +       return skb;
> +}
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index a8586c3058c7..e297b312d2b7 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -494,6 +494,7 @@ enum {
>  #define HCI_EVENT_PKT          0x04
>  #define HCI_ISODATA_PKT                0x05
>  #define HCI_DIAG_PKT           0xf0
> +#define HCI_DRV_PKT            0xf1
>  #define HCI_VENDOR_PKT         0xff
>
>  /* HCI packet types */
> diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_=
mon.h
> index 082f89531b88..bbd752494ef9 100644
> --- a/include/net/bluetooth/hci_mon.h
> +++ b/include/net/bluetooth/hci_mon.h
> @@ -51,6 +51,8 @@ struct hci_mon_hdr {
>  #define HCI_MON_CTRL_EVENT     17
>  #define HCI_MON_ISO_TX_PKT     18
>  #define HCI_MON_ISO_RX_PKT     19
> +#define HCI_MON_DRV_TX_PKT     20
> +#define HCI_MON_DRV_RX_PKT     21
>
>  struct hci_mon_new_index {
>         __u8            type;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 5eb0600bbd03..bb4e1721edc2 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2911,6 +2911,8 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_=
buff *skb)
>                 break;
>         case HCI_ISODATA_PKT:
>                 break;
> +       case HCI_DRV_PKT:
> +               break;
>         default:
>                 kfree_skb(skb);
>                 return -EINVAL;
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 022b86797acd..428ee5c7de7e 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -234,7 +234,8 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk=
_buff *skb)
>                         if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT &&
>                             hci_skb_pkt_type(skb) !=3D HCI_ACLDATA_PKT &&
>                             hci_skb_pkt_type(skb) !=3D HCI_SCODATA_PKT &&
> -                           hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT)
> +                           hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT &&
> +                           hci_skb_pkt_type(skb) !=3D HCI_DRV_PKT)
>                                 continue;
>                 } else {
>                         /* Don't send frame to other channel types */
> @@ -391,6 +392,12 @@ void hci_send_to_monitor(struct hci_dev *hdev, struc=
t sk_buff *skb)
>                 else
>                         opcode =3D cpu_to_le16(HCI_MON_ISO_TX_PKT);
>                 break;
> +       case HCI_DRV_PKT:
> +               if (bt_cb(skb)->incoming)
> +                       opcode =3D cpu_to_le16(HCI_MON_DRV_RX_PKT);
> +               else
> +                       opcode =3D cpu_to_le16(HCI_MON_DRV_TX_PKT);
> +               break;
>         case HCI_DIAG_PKT:
>                 opcode =3D cpu_to_le16(HCI_MON_VENDOR_DIAG);
>                 break;
> @@ -1860,7 +1867,8 @@ static int hci_sock_sendmsg(struct socket *sock, st=
ruct msghdr *msg,
>                 if (hci_skb_pkt_type(skb) !=3D HCI_COMMAND_PKT &&
>                     hci_skb_pkt_type(skb) !=3D HCI_ACLDATA_PKT &&
>                     hci_skb_pkt_type(skb) !=3D HCI_SCODATA_PKT &&
> -                   hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT) {
> +                   hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT &&
> +                   hci_skb_pkt_type(skb) !=3D HCI_DRV_PKT) {
>                         err =3D -EINVAL;
>                         goto drop;
>                 }
> --
> 2.49.0.504.g3bcea36a83-goog
>


--=20
Luiz Augusto von Dentz

