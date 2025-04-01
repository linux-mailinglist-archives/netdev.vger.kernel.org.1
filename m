Return-Path: <netdev+bounces-178627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CCDA77E73
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 17:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D9016CBB4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E881F204F6C;
	Tue,  1 Apr 2025 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBFj0tVC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E99172BD5;
	Tue,  1 Apr 2025 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519783; cv=none; b=LOpyQ+h1EeZcBU6cwrZzHHJsIQx0l1YMrWJ6cFDljxYcRgcWF1h+Pmhs0vh8Oibq8aizAXpZwW8mGu9OTOOOJPkBcwf12Rxr0NyEBL1Uau7YWTS2WHZP3zd5aZDnzQMAYbQy+sw731fWjl7C87cRtBXqlRpsT6kF9V3gceLamxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519783; c=relaxed/simple;
	bh=wQX/6r1HicDeq6PuDPmsJtO/NS4civwzmJfyacojBQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZCddBiec/7NF4Vka4yVp1oVOvQ21gJH46ohEjfsYs7fHlgoZI8zfINpmjDySBlmYlf3k6vnXkWX7Qbc8Hz+T57gEGamxN1oX0LDISw/Q03Uvhl4rnuiTPqqWYO3VW0bDFqeqjfrjDrnR2ZaUPvQtRQZylMdNIEw8E9f1zI40Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBFj0tVC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54996d30bfbso5018031e87.2;
        Tue, 01 Apr 2025 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743519780; x=1744124580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ItTzDfNkSi4Mf2QT8Y+hfOau5IdB5EKjExcEmLqs1g=;
        b=IBFj0tVC4RVJMZvZmZNjYiCORCvB30AIj/UWTnQsg+QKPAWFYsRGCAGers1IimGjFO
         2ZwijoSXYLtKbxQXDBnvdLwXr8E5WLkbWBwdiFypnz9hSk9jnERbLHQ1AhMw3MWGpQNa
         UaAZ/nAz/QSywPKcMxurU4QybrC4og4Dq4Unp1sXh17moGOU7ggDAKjYOVGgP5GzBvS6
         zL+8q2x+YXpaeDOwiFMTpgb1x29PBnj7Ejx1wt8TO3soplqxwphmLz9PStRU672UXnqI
         A5j1mVH3WemRYbN/zVMa6o9z6vGNvJohFyGiRvWo7MsgmzCPAX//LXNsvuE7mKRwadnq
         KVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743519780; x=1744124580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ItTzDfNkSi4Mf2QT8Y+hfOau5IdB5EKjExcEmLqs1g=;
        b=ANblMTGyVtNtWYxaUNT755WTHxhgI+r361c7Qp5/Qh8ScCimI/JKSY0zGGbkQ3fBBe
         2KydYChsJNa15nD1Qv7Y4H7kjaOx2ysIuI9zJ/zRKyats0ync8Gvf69JVZAv6tvcW4Xq
         QLYw5sufA5d3WwvmkApveyuJPqU/uOUSqWPQrw8Hq8FtsW8oufr3RPhOWjyF/gnmGrc9
         Syz8ldoWz7c6cJ/0D3XYEUQEPpYwG+QV/nK9ru7Q/ZDqKlAvGMcALjW6pu1XcciNpDXI
         nS3Cpdj6En6OzciSEnxki3qzdvKM71uqLHdbc1J1rMA4r6pk90UO2MoY0oQCbpNauJfA
         xr2w==
X-Forwarded-Encrypted: i=1; AJvYcCUt8A4z7u0zIzzFKdmb00IoTD13gRuSDM/3nSW9ryxMyTEJBjfrK36GhpFLrzexrFWmbWyPH92pUWt3vdWg@vger.kernel.org, AJvYcCVGUnAc/zHWwlo7/viEZwjnLB6YtvsKT9PXmp3UXPOpvDT/3tGoE/eqlU7yAJJtrp2woNcWe2s+qWbQ6ByEYpQ=@vger.kernel.org, AJvYcCWAVldWCyi2st8aLcT+TWpUoTFcLBJlWJNu+IOgV+zVjZm8QPd065oxsf4qFKgu3fDux69hSM8g@vger.kernel.org
X-Gm-Message-State: AOJu0YxsMHAI7yIni5U8+0E/rE7z5q+rFcdYm5e7qjZR3O8je6e4abpH
	BjrR3twVXsdm922Sw76o6AG+Rx1+I9MGoT2UTlU0XrrAJ+LN9HosDDdfEfTBW8dAZgAajLEckdm
	uJ67HsbrsGRc9HSfFKVeJfbx/vuM=
X-Gm-Gg: ASbGncvA3EeGKhaaP3XdWIXOdvVeen/bHs7KwqfVG1skv+N3kXZ01VxHk7l5p0kevFr
	93cBDTErbZSQE/dusL0ViymCE0xIiy8EThGRTARpX95Iq8QeTSOqebviTevc3AAydjif0ZKdPxX
	JeXcYruapkiMKFTocbMW22UwJF
X-Google-Smtp-Source: AGHT+IG9lkvz+/segokrcPGduFm+kqy5h5i5eUNl8bye2QSuO4N5ixqHjeJBETJp5Kno6r2L8/Ic9JQefmItXq9wbz4=
X-Received: by 2002:a05:6512:b08:b0:549:8924:2212 with SMTP id
 2adb3069b0e04-54b10dc7dd2mr4993652e87.17.1743519779433; Tue, 01 Apr 2025
 08:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401134424.3725875-1-chharry@google.com>
In-Reply-To: <20250401134424.3725875-1-chharry@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Apr 2025 11:02:47 -0400
X-Gm-Features: AQ5f1Jo0H0iGr0LbtRuChF9uABv1xzTOuZHK9m7_bmOAutYvprTkBYislY1b-m4
Message-ID: <CABBYNZKu_jRm4b-gBT=DRtn0c_svgxyM7tc_u3HDRCUAwvABnQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add driver command BTUSB_DRV_CMD_SWITCH_ALT_SETTING
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

On Tue, Apr 1, 2025 at 9:44=E2=80=AFAM Hsin-chen Chuang <chharry@google.com=
> wrote:
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
> - Define the btusb driver command BTUSB_DRV_CMD_SWITCH_ALT_SETTING which
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
>  drivers/bluetooth/btusb.c       | 67 +++++++++++++++++++++++++++++++++
>  include/net/bluetooth/hci.h     |  1 +
>  include/net/bluetooth/hci_mon.h |  2 +
>  net/bluetooth/hci_core.c        |  2 +
>  net/bluetooth/hci_sock.c        | 14 +++++--
>  5 files changed, 83 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5012b5ff92c8..a7bc64e86661 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2151,6 +2151,67 @@ static int submit_or_queue_tx_urb(struct hci_dev *=
hdev, struct urb *urb)
>         return 0;
>  }
>
> +static struct sk_buff *btusb_drv_response(u8 opcode, size_t data_len)
> +{
> +       struct sk_buff *skb;
> +
> +       /* btusb driver response starts with 1 oct of the opcode,
> +        * and followed by the command specific data.
> +        */
> +       skb =3D bt_skb_alloc(1 + data_len, GFP_KERNEL);
> +       if (!skb)
> +               return NULL;
> +
> +       skb_put_u8(skb, opcode);
> +       hci_skb_pkt_type(skb) =3D HCI_DRV_PKT;
> +
> +       return skb;
> +}
> +
> +static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts);
> +
> +#define BTUSB_DRV_CMD_SWITCH_ALT_SETTING 0x35

Any particular reason why you are starting with 0x35? We may need to
add something like Read Supported Driver Commands to begin with.

> +static int btusb_drv_cmd(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       /* btusb driver command starts with 1 oct of the opcode,
> +        * and followed by the command specific data.
> +        */
> +       if (!skb->len)
> +               return -EILSEQ;

We might need to define a struct header, and I'd definitely recommend
using skb_pull_data for parsing.

> +       switch (skb->data[0]) {
> +       case BTUSB_DRV_CMD_SWITCH_ALT_SETTING: {
> +               struct sk_buff *resp;
> +               int status;
> +
> +               /* Response data: Total 1 Oct
> +                *   Status: 1 Oct
> +                *     0 =3D Success
> +                *     1 =3D Invalid command
> +                *     2 =3D Other errors
> +                */
> +               resp =3D btusb_drv_response(BTUSB_DRV_CMD_SWITCH_ALT_SETT=
ING, 1);
> +               if (!resp)
> +                       return -ENOMEM;
> +
> +               if (skb->len !=3D 2 || skb->data[1] > 6) {
> +                       status =3D 1;
> +               } else {
> +                       status =3D btusb_switch_alt_setting(hdev, skb->da=
ta[1]);
> +                       if (status)
> +                               status =3D 2;
> +               }
> +               skb_put_u8(resp, status);
> +
> +               kfree_skb(skb);
> +               return hci_recv_frame(hdev, resp);
> +       }
> +       }
> +
> +       return -EILSEQ;
> +}
> +
>  static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         struct urb *urb;
> @@ -2192,6 +2253,9 @@ static int btusb_send_frame(struct hci_dev *hdev, s=
truct sk_buff *skb)
>                         return PTR_ERR(urb);
>
>                 return submit_or_queue_tx_urb(hdev, urb);
> +
> +       case HCI_DRV_PKT:
> +               return btusb_drv_cmd(hdev, skb);
>         }
>
>         return -EILSEQ;
> @@ -2669,6 +2733,9 @@ static int btusb_send_frame_intel(struct hci_dev *h=
dev, struct sk_buff *skb)
>                         return PTR_ERR(urb);
>
>                 return submit_or_queue_tx_urb(hdev, urb);
> +
> +       case HCI_DRV_PKT:
> +               return btusb_drv_cmd(hdev, skb);
>         }
>
>         return -EILSEQ;
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

Are you planning to write some btmon decoding for these packets?

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
> index 022b86797acd..0bc4f77ed17b 100644
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
> @@ -1806,7 +1813,7 @@ static int hci_sock_sendmsg(struct socket *sock, st=
ruct msghdr *msg,
>         if (flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL | MSG_ERRQUEUE | MSG_CM=
SG_COMPAT))
>                 return -EINVAL;
>
> -       if (len < 4 || len > hci_pi(sk)->mtu)
> +       if (len > hci_pi(sk)->mtu)
>                 return -EINVAL;
>
>         skb =3D bt_skb_sendmsg(sk, msg, len, len, 0, 0);
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
> 2.49.0.472.ge94155a9ec-goog
>


--=20
Luiz Augusto von Dentz

