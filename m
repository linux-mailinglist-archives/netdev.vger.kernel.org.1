Return-Path: <netdev+bounces-178631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1780A77EE3
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 17:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63623A5614
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED4820AF93;
	Tue,  1 Apr 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LcNDXGoo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6AB20AF87
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521259; cv=none; b=OAx+NAiE//UL/+GGEfmpXOT392w6foZNDexi+ZP3JejIyrfQwLZ3jyAin6X+wz06YEvYUye4VVVHZvQJX8q72vbuW30O5F0OjrzzQsOFuNW6TjFSRdJCRn4xNC+CJ1fDtR0GtWSH0AQDM9fbaSkfjBSDD9chTTWjUJQ6/JIq66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521259; c=relaxed/simple;
	bh=Hc0JBTwcblF9exbzjWcnb6VWqPc+E1BTIFbOZZXNqbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9uK5Q35ELNKKSrIg0bq4NaaPjZi1YTeXKSyyFmtaDlyGYcrlnRUcMWGJ2Mdk15Z4j6UZMMjlXmuxYvsMCIkbcjegH4qRrVN9CPdXed+wUaO4+LLgMJ4Iud6zFW35ggG2pTc+C6CeMsVTF7129zaRHlQFR15QG6WQcdn27arQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LcNDXGoo; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef7c9e9592so46781517b3.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743521256; x=1744126056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrTAT73/pytPO5BDqSRBwDug9yOh7SSsAyZQaMHt+8I=;
        b=LcNDXGoo1/14bwqIr6BqiNbGMGciIpqqwfec7r1lMpdLwaE+8kE3Bhd2+Ds6bQvj7B
         agaTRiB01p0eWsYoMaBf+/sn5C/oTSwzOAxLTtb0U/24Sl5USQ0sn/nuWPM0DetTrO4P
         gj0l0x98Tey/r7HfelNjXfJz75BP7P/dEX1XXouC4WjpERDmCpsPtpEqhk2Hq1X5QmBx
         ApHFF8z1COI5WqD22PuSMjhmnLbtNq9TqpsJ/5hfrisupMdcMEotkAzDfJBLTLuxaFbc
         nNnK2O7KAdShcmLW7P8NUHfS2hfkQ6e2b0wu/ewiXbZL8Vld2FQBnJFYuqGhaKD3Knyy
         ucaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743521256; x=1744126056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrTAT73/pytPO5BDqSRBwDug9yOh7SSsAyZQaMHt+8I=;
        b=YClPuDUg4JomieNF3Ygi2nXQCAx3n8o4VS1cBQtUGA3vJrOX+oDiZyoLCyJKsnFP+y
         Ejhcr/X/tBmgcgc9CG6mkAWeFF5e7Z1BHDI3XyMUdovO7wwNQ6lMrNggYqXhEXXxRVon
         2INCDppbg30R7dXk01fPLEb58Ul4TQGbPWjSt0SKWpIQArSbgMr/m2nS3ETAvXDPwyCc
         A68ZErpNRLFQv2K2alxMsY+kq4NkbgNYy5jeDWh4HZ+Jtp0pzOdZjgHZNOxPxJ9J06B4
         vthSpGZ8mpUi20DBiXBtPvROm77gQ3S+WTGBggvuMsa+8V5npIriP8jY4+fDu92RmyAN
         vUUA==
X-Forwarded-Encrypted: i=1; AJvYcCW6uWFIFji7IzlFOT/Qq2Yr/oyzAbTTP0cNfzEkPxxr0GcUcZvyqDCKPnB0iyFmH/50ZJZR7gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT3kxAfQFPDUW69SFXsWt16pryNOuMrRsCbC8IP5x4OCXK2Zwz
	7YXiXcSS864dS4YXNBVlTeEqBLHvbDngemcPyqi1zohVstRKh7EeGXIkTzSdtciv3E22VIR9Lwu
	jrJ1VnxQm0uV7sD3QgfwrGyX/9XII6IL8/b0n
X-Gm-Gg: ASbGncv5BoDIsTR6z+6aC5a7eyGX56pBholND6ilGDRy3UAXUx9Pgy8hmvkKX6R8n28
	zil2wWE3n4KoHir+rGiHABiBpokwb9e9jx+vlDSXoYYq7Znew0dYQAcnrBGEF55z3uQApwdvKsN
	SiNCfiLpbDxtRf7r0rnTXD4fJe
X-Google-Smtp-Source: AGHT+IEjX/jjY8IHxq9srXQvt2Ttjh0zWE7Q87FlLz3zplPodhA9JDcKoR+aISyyJLiyJEMASpHY8zS7u8oRwVeU+TU=
X-Received: by 2002:a05:690c:6c82:b0:6fd:474a:60a8 with SMTP id
 00721157ae682-7025710afc9mr197129247b3.11.1743521255933; Tue, 01 Apr 2025
 08:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401134424.3725875-1-chharry@google.com> <CABBYNZKu_jRm4b-gBT=DRtn0c_svgxyM7tc_u3HDRCUAwvABnQ@mail.gmail.com>
In-Reply-To: <CABBYNZKu_jRm4b-gBT=DRtn0c_svgxyM7tc_u3HDRCUAwvABnQ@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Tue, 1 Apr 2025 23:26:59 +0800
X-Gm-Features: AQ5f1JqKHimVqd6cxraxMet6vAte91WjpA6TRIa_BXNcv9HJ6LM7mbljvPf2jcU
Message-ID: <CADg1FFePfuOmHE+s9Fks8LvPY5dt9gcxrULn+X5wM9S3J57H7A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add driver command BTUSB_DRV_CMD_SWITCH_ALT_SETTING
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hsin-chen Chuang <chharry@chromium.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Tue, Apr 1, 2025 at 11:03=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Tue, Apr 1, 2025 at 9:44=E2=80=AFAM Hsin-chen Chuang <chharry@google.c=
om> wrote:
> >
> > From: Hsin-chen Chuang <chharry@chromium.org>
> >
> > Although commit 75ddcd5ad40e ("Bluetooth: btusb: Configure altsetting
> > for HCI_USER_CHANNEL") has enabled the HCI_USER_CHANNEL user to send ou=
t
> > SCO data through USB Bluetooth chips, it's observed that with the patch
> > HFP is flaky on most of the existing USB Bluetooth controllers: Intel
> > chips sometimes send out no packet for Transparent codec; MTK chips may
> > generate SCO data with a wrong handle for CVSD codec; RTK could split
> > the data with a wrong packet size for Transparent codec; ... etc.
> >
> > To address the issue above one needs to reset the altsetting back to
> > zero when there is no active SCO connection, which is the same as the
> > BlueZ behavior, and another benefit is the bus doesn't need to reserve
> > bandwidth when no SCO connection.
> >
> > This patch introduces a fundamental solution that lets the user space
> > program to configure the altsetting freely:
> > - Define the new packet type HCI_DRV_PKT which is specifically used for
> >   communication between the user space program and the Bluetooth drvier=
s
> > - Define the btusb driver command BTUSB_DRV_CMD_SWITCH_ALT_SETTING whic=
h
> >   indicates the expected altsetting from the user space program
> > - btusb intercepts the command and adjusts the Isoc endpoint
> >   correspondingly
> >
> > This patch is tested on ChromeOS devices. The USB Bluetooth models
> > (CVSD, TRANS alt3, and TRANS alt6) could pass the stress HFP test narro=
w
> > band speech and wide band speech.
> >
> > Cc: chromeos-bluetooth-upstreaming@chromium.org
> > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control =
USB alt setting")
> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > ---
> >
> >  drivers/bluetooth/btusb.c       | 67 +++++++++++++++++++++++++++++++++
> >  include/net/bluetooth/hci.h     |  1 +
> >  include/net/bluetooth/hci_mon.h |  2 +
> >  net/bluetooth/hci_core.c        |  2 +
> >  net/bluetooth/hci_sock.c        | 14 +++++--
> >  5 files changed, 83 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 5012b5ff92c8..a7bc64e86661 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2151,6 +2151,67 @@ static int submit_or_queue_tx_urb(struct hci_dev=
 *hdev, struct urb *urb)
> >         return 0;
> >  }
> >
> > +static struct sk_buff *btusb_drv_response(u8 opcode, size_t data_len)
> > +{
> > +       struct sk_buff *skb;
> > +
> > +       /* btusb driver response starts with 1 oct of the opcode,
> > +        * and followed by the command specific data.
> > +        */
> > +       skb =3D bt_skb_alloc(1 + data_len, GFP_KERNEL);
> > +       if (!skb)
> > +               return NULL;
> > +
> > +       skb_put_u8(skb, opcode);
> > +       hci_skb_pkt_type(skb) =3D HCI_DRV_PKT;
> > +
> > +       return skb;
> > +}
> > +
> > +static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts=
);
> > +
> > +#define BTUSB_DRV_CMD_SWITCH_ALT_SETTING 0x35
>
> Any particular reason why you are starting with 0x35? We may need to
> add something like Read Supported Driver Commands to begin with.

Um, it's just my lucky number. No particular reason in terms of the design.
And sure Read Supported Driver Commands seems good, but does that
indicate that the meaning of the opcodes is shared across different
driver modules? That's fine but we would need to move these
definitions somewhere else.

>
> > +static int btusb_drv_cmd(struct hci_dev *hdev, struct sk_buff *skb)
> > +{
> > +       /* btusb driver command starts with 1 oct of the opcode,
> > +        * and followed by the command specific data.
> > +        */
> > +       if (!skb->len)
> > +               return -EILSEQ;
>
> We might need to define a struct header, and I'd definitely recommend
> using skb_pull_data for parsing.

So far the header has only 1 oct of the opcode. Would you suggest
something similar to HCI command e.g. 2 oct of the opcode + 1 oct of
the param length?

>
> > +       switch (skb->data[0]) {
> > +       case BTUSB_DRV_CMD_SWITCH_ALT_SETTING: {
> > +               struct sk_buff *resp;
> > +               int status;
> > +
> > +               /* Response data: Total 1 Oct
> > +                *   Status: 1 Oct
> > +                *     0 =3D Success
> > +                *     1 =3D Invalid command
> > +                *     2 =3D Other errors
> > +                */
> > +               resp =3D btusb_drv_response(BTUSB_DRV_CMD_SWITCH_ALT_SE=
TTING, 1);
> > +               if (!resp)
> > +                       return -ENOMEM;
> > +
> > +               if (skb->len !=3D 2 || skb->data[1] > 6) {
> > +                       status =3D 1;
> > +               } else {
> > +                       status =3D btusb_switch_alt_setting(hdev, skb->=
data[1]);
> > +                       if (status)
> > +                               status =3D 2;
> > +               }
> > +               skb_put_u8(resp, status);
> > +
> > +               kfree_skb(skb);
> > +               return hci_recv_frame(hdev, resp);
> > +       }
> > +       }
> > +
> > +       return -EILSEQ;
> > +}
> > +
> >  static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> >  {
> >         struct urb *urb;
> > @@ -2192,6 +2253,9 @@ static int btusb_send_frame(struct hci_dev *hdev,=
 struct sk_buff *skb)
> >                         return PTR_ERR(urb);
> >
> >                 return submit_or_queue_tx_urb(hdev, urb);
> > +
> > +       case HCI_DRV_PKT:
> > +               return btusb_drv_cmd(hdev, skb);
> >         }
> >
> >         return -EILSEQ;
> > @@ -2669,6 +2733,9 @@ static int btusb_send_frame_intel(struct hci_dev =
*hdev, struct sk_buff *skb)
> >                         return PTR_ERR(urb);
> >
> >                 return submit_or_queue_tx_urb(hdev, urb);
> > +
> > +       case HCI_DRV_PKT:
> > +               return btusb_drv_cmd(hdev, skb);
> >         }
> >
> >         return -EILSEQ;
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index a8586c3058c7..e297b312d2b7 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -494,6 +494,7 @@ enum {
> >  #define HCI_EVENT_PKT          0x04
> >  #define HCI_ISODATA_PKT                0x05
> >  #define HCI_DIAG_PKT           0xf0
> > +#define HCI_DRV_PKT            0xf1
> >  #define HCI_VENDOR_PKT         0xff
> >
> >  /* HCI packet types */
> > diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hc=
i_mon.h
> > index 082f89531b88..bbd752494ef9 100644
> > --- a/include/net/bluetooth/hci_mon.h
> > +++ b/include/net/bluetooth/hci_mon.h
> > @@ -51,6 +51,8 @@ struct hci_mon_hdr {
> >  #define HCI_MON_CTRL_EVENT     17
> >  #define HCI_MON_ISO_TX_PKT     18
> >  #define HCI_MON_ISO_RX_PKT     19
> > +#define HCI_MON_DRV_TX_PKT     20
> > +#define HCI_MON_DRV_RX_PKT     21
>
> Are you planning to write some btmon decoding for these packets?

Yeah, I believe this is helpful for debugging. ChromeOS still uses
btmon for btsnoop capturing.

>
> >  struct hci_mon_new_index {
> >         __u8            type;
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 5eb0600bbd03..bb4e1721edc2 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2911,6 +2911,8 @@ int hci_recv_frame(struct hci_dev *hdev, struct s=
k_buff *skb)
> >                 break;
> >         case HCI_ISODATA_PKT:
> >                 break;
> > +       case HCI_DRV_PKT:
> > +               break;
> >         default:
> >                 kfree_skb(skb);
> >                 return -EINVAL;
> > diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> > index 022b86797acd..0bc4f77ed17b 100644
> > --- a/net/bluetooth/hci_sock.c
> > +++ b/net/bluetooth/hci_sock.c
> > @@ -234,7 +234,8 @@ void hci_send_to_sock(struct hci_dev *hdev, struct =
sk_buff *skb)
> >                         if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT &&
> >                             hci_skb_pkt_type(skb) !=3D HCI_ACLDATA_PKT =
&&
> >                             hci_skb_pkt_type(skb) !=3D HCI_SCODATA_PKT =
&&
> > -                           hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT)
> > +                           hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT =
&&
> > +                           hci_skb_pkt_type(skb) !=3D HCI_DRV_PKT)
> >                                 continue;
> >                 } else {
> >                         /* Don't send frame to other channel types */
> > @@ -391,6 +392,12 @@ void hci_send_to_monitor(struct hci_dev *hdev, str=
uct sk_buff *skb)
> >                 else
> >                         opcode =3D cpu_to_le16(HCI_MON_ISO_TX_PKT);
> >                 break;
> > +       case HCI_DRV_PKT:
> > +               if (bt_cb(skb)->incoming)
> > +                       opcode =3D cpu_to_le16(HCI_MON_DRV_RX_PKT);
> > +               else
> > +                       opcode =3D cpu_to_le16(HCI_MON_DRV_TX_PKT);
> > +               break;
> >         case HCI_DIAG_PKT:
> >                 opcode =3D cpu_to_le16(HCI_MON_VENDOR_DIAG);
> >                 break;
> > @@ -1806,7 +1813,7 @@ static int hci_sock_sendmsg(struct socket *sock, =
struct msghdr *msg,
> >         if (flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL | MSG_ERRQUEUE | MSG_=
CMSG_COMPAT))
> >                 return -EINVAL;
> >
> > -       if (len < 4 || len > hci_pi(sk)->mtu)
> > +       if (len > hci_pi(sk)->mtu)
> >                 return -EINVAL;
> >
> >         skb =3D bt_skb_sendmsg(sk, msg, len, len, 0, 0);
> > @@ -1860,7 +1867,8 @@ static int hci_sock_sendmsg(struct socket *sock, =
struct msghdr *msg,
> >                 if (hci_skb_pkt_type(skb) !=3D HCI_COMMAND_PKT &&
> >                     hci_skb_pkt_type(skb) !=3D HCI_ACLDATA_PKT &&
> >                     hci_skb_pkt_type(skb) !=3D HCI_SCODATA_PKT &&
> > -                   hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT) {
> > +                   hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT &&
> > +                   hci_skb_pkt_type(skb) !=3D HCI_DRV_PKT) {
> >                         err =3D -EINVAL;
> >                         goto drop;
> >                 }
> > --
> > 2.49.0.472.ge94155a9ec-goog
> >
>
>
> --
> Luiz Augusto von Dentz

--=20
Best Regards,
Hsin-chen

