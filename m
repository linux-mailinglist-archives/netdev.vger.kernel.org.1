Return-Path: <netdev+bounces-206705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D9FB04244
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA377A4786
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B78A253F2D;
	Mon, 14 Jul 2025 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJYyPtBC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CC02E413;
	Mon, 14 Jul 2025 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504943; cv=none; b=BadoGP+GWPhyP4Y2WMUNqtP0dajriBuGnl2r1wNyDEdus3aLeCJtM74wYGYMbGleVGpFuWB5/AJGax4QwvZckF4HtGtRJQ+ttorafkUQXfQaN8nhr2/8Vr+pf3BLeAnzVx1oQQq4TNv5yN9mCRnnoIRxheF9UqWNgCTadMrrXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504943; c=relaxed/simple;
	bh=JrYHwBX9oTRUeFX4/qMdQViVBFF5h1o7HcQ8NDHRHy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6RKyBESYQx+qd9mkcWzMEAhNuIv0x3lcnptMYxxi0CJkI4LC5wLVJsARwB6tHQ7h8bgq0/8jh9LadSXJq3v7H7nAc4KNtr64xLYTFj0Rbtd2AUIehCryyDedmg9KoVGm6go1yxtZrVU93Emal/wptfq+yR3L2USKC6zBaX2wlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJYyPtBC; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso35725661fa.1;
        Mon, 14 Jul 2025 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752504939; x=1753109739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKgDO5csyaxuYQJuBhoIAKqxGNCXu8IfFYy6KA9g8g8=;
        b=mJYyPtBCWvNDjhznxnXf0lnpzs2/EFylrdceqOAX/C3L1Q/rMgZeXmoi7+yr7hRt8U
         zAz8qbkQc33+NuzHYww1P7ZFWjisvhsgah8lH5vdHvRUeyXOTC/M6aRpuj7ap2UHZzt8
         Rj1JQP6Yc1PcD70QJ0U4oDluuKHyCbdkdKMmC1iWGTESGLCYj3+adGYk+WLE6c/O9hmD
         Xm8QY7ekgeAw0LAJ2ADM7K3cO20lLDA9jKuEH5EjY9s/lQlZjDSErGIVNZNa/QzbOtAq
         9s3JZVsa0K9xB17qWWf6CMy6E4UkMEdqzWZrZidBxNrdI8sQ/Ys1x+vO5ImoYLmH1P4n
         go3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504939; x=1753109739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKgDO5csyaxuYQJuBhoIAKqxGNCXu8IfFYy6KA9g8g8=;
        b=uXsrarTsBBkc46v7ZYTtBaFwSwNRTc83wK2+lqY9778UAZnlGkulwrBaZL0kn6jrLW
         fQ388+XRNABnQxyiArChUI0HvAL5zzUNedAVqEIAEXWOMIH4MlbJMX8t0x3ylUEyGqTZ
         Qhp+0ZVwpyd0b0vzWnzODcSIJPasaG3R0OvWgIdr/4xJ5Z6Bran//iOc5gS4ZIbrswYz
         SNTNqgIBzyA+EKrhRlhnVcQsleEB3LulXid4//8FERGlVzwhjZRJbQqAXxMWyEhgRH1g
         g/jqMvb02SmziXJtvhhzHft7CwRZFTg9n+oWxZAyte6oj5B5aZEsMj+DgsJXJSyQaZA+
         IGtA==
X-Forwarded-Encrypted: i=1; AJvYcCXHIpe5a8Y/gSE8woqkDUe64TjrDYNC7wUZoR4dzrmg8uMZEJje4h1ggPGSCzP4ewox7/OYRZEf@vger.kernel.org, AJvYcCXhglI5GH/ED2BiWMWI0T/E0Xr/WgXCvqW9kCXC9HEQ1hsd1TiC+HFbqN2X4Vyxxvwws770Yx0c9ZeDvB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IMrQNpU0vMyDCvOoqMuK47MXnqhJsij5+UwtBjcpv+cS1jNS
	yHOz0cZlI3NN3ylSyNa7F2lbYyzsk/nwkP+i3ngEmrXFWoyl1imxU6KGerpTLn+Zg0QESrx7dC+
	Ti1nE2fZsc1RkfWGOFTBIE1PQ8IhOmy8=
X-Gm-Gg: ASbGncvWhJ3BXLQbtq7W7OeoylRiFvxn7mDPZLlupfcDK6xMp6ATq7hyaF6H7oNttkf
	bGfkwx/bkdlTbYdwVMq3rCGU+TNA9a36ATw3WxuWnDRry+tBudhfX+6/kLOeyn77fa6oQlPFcrA
	KkV1vRtnWnQ+h3TJv2EafpQH8sAGsjSJsFwKcTUqPb8xm4XHEeporp4XHNY66prkAe6VePiiOAv
	1AtvQ==
X-Google-Smtp-Source: AGHT+IEwNu4gavMUs2eRKV+7hXQwwlbV59oWdEB7cZuwnGCAYMQ5sS96025Uj+qSsF05OybIZtpKNRv0EX5d2WCed+k=
X-Received: by 2002:a05:651c:4114:b0:32a:5fe2:81b2 with SMTP id
 38308e7fff4ca-3305343e1d8mr28857601fa.23.1752504937982; Mon, 14 Jul 2025
 07:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <474a5321753aba17ec2819ba59adfd157ecfb343.1752501596.git.pav@iki.fi>
 <CABBYNZL0FjLf6NZ1U0Wo4cOyCfH=17FkN_6-CT1RqNdJVyMfZA@mail.gmail.com> <f809b3350fa5ead274b83120d9b38ecdef0dcf76.camel@iki.fi>
In-Reply-To: <f809b3350fa5ead274b83120d9b38ecdef0dcf76.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 14 Jul 2025 10:55:25 -0400
X-Gm-Features: Ac12FXxW85rZfkjywBNvkA3ylKg4o5URO3ix8SCZMuqKVgjSTm45z_jNw9bF6fM
Message-ID: <CABBYNZ+3cwNGNocVxxGYF5QLu9WAoBy1qpbfkOmnJjzSj-=ivg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ISO: add socket option to report packet seqnum
 via CMSG
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	johan.hedberg@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Jul 14, 2025 at 10:45=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ma, 2025-07-14 kello 10:15 -0400, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Mon, Jul 14, 2025 at 10:03=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wr=
ote:
> > >
> > > User applications need a way to track which ISO interval a given SDU
> > > belongs to, to properly detect packet loss. All controllers do not se=
t
> > > timestamps, and it's not guaranteed user application receives all pac=
ket
> > > reports (small socket buffer, or controller doesn't send all reports
> > > like Intel AX210 is doing).
> > >
> > > Add socket option BT_PKT_SEQNUM that enables reporting of received
> > > packet ISO sequence number in BT_SCM_PKT_SEQNUM CMSG.
> > >
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > ---
> > >
> > > Notes:
> > >     Intel AX210 is not sending all reports:
> > >
> > >     $ btmon -r dump.btsnoop -I -C90|grep -A1 'ISO Data RX: Handle 230=
4'
> > >     ...
> > >     > ISO Data RX: Handle 2304 flags 0x02 dlen 64                    =
  #1713 [hci0] 22.567744
> > >             dd 01 3c 00 6d 08 e9 14 1e 3b 85 7b 35 c2 25 0b  ..<.m...=
.;.{5.%.
> > >     --
> > >     > ISO Data RX: Handle 2304 flags 0x02 dlen 64                    =
  #1718 [hci0] 22.573745
> > >             de 01 3c 00 41 65 22 4f 99 9b 0b b6 ff cb 06 00  ..<.Ae"O=
........
> > >     --
> > >     > ISO Data RX: Handle 2304 flags 0x02 dlen 64                    =
  #1727 [hci0] 22.587933
> > >             e0 01 3c 00 8b 6e 33 44 65 51 ee d7 e0 ee 49 d8  ..<..n3D=
eQ....I.
> > >     --
> > >     > ISO Data RX: Handle 2304 flags 0x02 dlen 64                    =
  #1732 [hci0] 22.596742
> > >             e1 01 3c 00 a7 48 54 a7 c1 9f dc 37 66 fe 04 ab  ..<..HT.=
...7f...
> > >     ...
> > >
> > >     Here, report for packet with sequence number 0x01df is missing.
> > >
> > >     This may be spec violation by the controller, see Core v6.1 pp. 3=
702
> > >
> > >         All SDUs shall be sent to the upper layer including the indic=
ation
> > >         of validity of data. A report shall be sent to the upper laye=
r if
> > >         the SDU is completely missing.
> >
> > We may want to report this to Intel, let me check internally.
> >
> > >     Regardless, it will be easier for user applications to see the HW
> > >     sequence numbers directly, so they don't have to count packets an=
d it's
> > >     in any case more reliable if packets get dropped due to socket bu=
ffer
> > >     size.
> > >
> > >  include/net/bluetooth/bluetooth.h |  9 ++++++++-
> > >  net/bluetooth/af_bluetooth.c      |  7 +++++++
> > >  net/bluetooth/iso.c               | 21 ++++++++++++++++++---
> > >  3 files changed, 33 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetoot=
h/bluetooth.h
> > > index 114299bd8b98..0e31779a3341 100644
> > > --- a/include/net/bluetooth/bluetooth.h
> > > +++ b/include/net/bluetooth/bluetooth.h
> > > @@ -244,6 +244,10 @@ struct bt_codecs {
> > >
> > >  #define BT_ISO_BASE            20
> > >
> > > +#define BT_PKT_SEQNUM          21
> > > +
> > > +#define BT_SCM_PKT_SEQNUM      0x05
> > > +
> > >  __printf(1, 2)
> > >  void bt_info(const char *fmt, ...);
> > >  __printf(1, 2)
> > > @@ -391,7 +395,8 @@ struct bt_sock {
> > >  enum {
> > >         BT_SK_DEFER_SETUP,
> > >         BT_SK_SUSPEND,
> > > -       BT_SK_PKT_STATUS
> > > +       BT_SK_PKT_STATUS,
> > > +       BT_SK_PKT_SEQNUM,
> > >  };
> > >
> > >  struct bt_sock_list {
> > > @@ -475,6 +480,7 @@ struct bt_skb_cb {
> > >         u8 pkt_type;
> > >         u8 force_active;
> > >         u16 expect;
> > > +       u16 pkt_seqnum;
> >
> > We may also need the status or are you planning on reusing the
> > existing pkt_status? In any case we may want to add something to
> > iso-tester to confirm this is working as intended and catch possible
> > regressions.
>
> BT_PKT_STATUS + BT_SCM_PKT_STATUS are already implemented for ISO, and
> there is test for it in iso-tester.c
>
> ISO Receive Packet Status - Success

Great, I forgot we had a test already, makes sense now.

> How it works in this version is that user application that wants to get
> both does
>
>         opt =3D 1;
>         setsockopt(fd, SOL_BLUETOOTH, BT_PKT_STATUS, &opt, sizeof(opt));
>         opt =3D 1;
>         setsockopt(fd, SOL_BLUETOOTH, BT_PKT_SEQNUM, &opt, sizeof(opt));
>         ...
>         uint16_t seqnum;
>         uint8_t status;
>         for (cmsg=3DCMSG_FIRSTHDR(&msg); cmsg; cmsg =3D CMSG_NXTHDR(&msg,=
 cmsg)) {
>                 if (cmsg->cmsg_level !=3D SOL_BLUETOOTH)
>                         continue;
>                 if (cmsg->cmsg_type =3D=3D BT_SCM_PKT_SEQNUM)
>                         memcpy(&seqnum, CMSG_DATA(cmsg), sizeof(uint16_t)=
);
>                 else if (cmsg->cmsg_type =3D=3D BT_SCM_PKT_STATUS)
>                         memcpy(&status, CMSG_DATA(cmsg), sizeof(uint8_t))=
;
>         }
>
> In theory we might indeed also change BT_SCM_PKT_STATUS to a struct
> like
>
>         struct bt_iso_pkt_status {
>                 u8 status;
>                 u16 seqnum;
>         } __packed;
>
> It's then not really fully compatible with any existing applications,
> since applications may be eg using something like
>
>         char buf[CMSG_SPACE(uint8_t)];
>
> to reserve space for the BT_PKT_STATUS CMSG, which then won't
> necessarily fit anymore. Maybe it could be changed just for ISO, but
> then different socket types would have different CMSG size for the same
> SCM.
>
> I think it's probably OK to use separate CMSG like here, then user
> application can also know if kernel supports the socket option.

Yeah, we might need to document though, I will try to put together the
initial doc/iso.rst so we can document it in the future. btw are
missing examples to how to handle timestamping handling on the likes
of doc/l2cap.rst and doc/sco.rst, it would be really great if we could
sort that out as well.

> > >         u8 incoming:1;
> > >         u8 pkt_status:2;
> > >         union {
> > > @@ -488,6 +494,7 @@ struct bt_skb_cb {
> > >
> > >  #define hci_skb_pkt_type(skb) bt_cb((skb))->pkt_type
> > >  #define hci_skb_pkt_status(skb) bt_cb((skb))->pkt_status
> > > +#define hci_skb_pkt_seqnum(skb) bt_cb((skb))->pkt_seqnum
> > >  #define hci_skb_expect(skb) bt_cb((skb))->expect
> > >  #define hci_skb_opcode(skb) bt_cb((skb))->hci.opcode
> > >  #define hci_skb_event(skb) bt_cb((skb))->hci.req_event
> > > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetoot=
h.c
> > > index 6ad2f72f53f4..44b7acb20a67 100644
> > > --- a/net/bluetooth/af_bluetooth.c
> > > +++ b/net/bluetooth/af_bluetooth.c
> > > @@ -364,6 +364,13 @@ int bt_sock_recvmsg(struct socket *sock, struct =
msghdr *msg, size_t len,
> > >                         put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_STATU=
S,
> > >                                  sizeof(pkt_status), &pkt_status);
> > >                 }
> > > +
> > > +               if (test_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags)) {
> > > +                       u16 pkt_seqnum =3D hci_skb_pkt_seqnum(skb);
> > > +
> > > +                       put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_SEQNU=
M,
> > > +                                sizeof(pkt_seqnum), &pkt_seqnum);
> > > +               }
> >
> > In case we want to reuse the pkt_status then perhaps the order shall
> > be pk_seqnum followed by pkt_status otherwise we need a struct that
> > holds them both.
>
> The order of the CMSG shouldn't matter if they have separate BT_SCM
> types & socket flags.

You mean because they are normally processed in a loop so all options
shall be related to each other? That makes sense if they can only
appear once, which I guess is the case here.

> >
> > >         }
> > >
> > >         skb_free_datagram(sk, skb);
> > > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > > index fc22782cbeeb..469450bb6b6c 100644
> > > --- a/net/bluetooth/iso.c
> > > +++ b/net/bluetooth/iso.c
> > > @@ -1687,6 +1687,17 @@ static int iso_sock_setsockopt(struct socket *=
sock, int level, int optname,
> > >                         clear_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags=
);
> > >                 break;
> > >
> > > +       case BT_PKT_SEQNUM:
> > > +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), opt=
val, optlen);
> > > +               if (err)
> > > +                       break;
> > > +
> > > +               if (opt)
> > > +                       set_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags);
> > > +               else
> > > +                       clear_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags=
);
> > > +               break;
> > > +
> > >         case BT_ISO_QOS:
> > >                 if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT=
_BOUND &&
> > >                     sk->sk_state !=3D BT_CONNECT2 &&
> > > @@ -2278,7 +2289,7 @@ static void iso_disconn_cfm(struct hci_conn *hc=
on, __u8 reason)
> > >  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
> > >  {
> > >         struct iso_conn *conn =3D hcon->iso_data;
> > > -       __u16 pb, ts, len;
> > > +       __u16 pb, ts, len, sn;
> > >
> > >         if (!conn)
> > >                 goto drop;
> > > @@ -2308,6 +2319,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_=
buff *skb, u16 flags)
> > >                                 goto drop;
> > >                         }
> > >
> > > +                       sn =3D hdr->sn;
> > >                         len =3D __le16_to_cpu(hdr->slen);
> > >                 } else {
> > >                         struct hci_iso_data_hdr *hdr;
> > > @@ -2318,18 +2330,20 @@ void iso_recv(struct hci_conn *hcon, struct s=
k_buff *skb, u16 flags)
> > >                                 goto drop;
> > >                         }
> > >
> > > +                       sn =3D hdr->sn;
> > >                         len =3D __le16_to_cpu(hdr->slen);
> > >                 }
> > >
> > >                 flags  =3D hci_iso_data_flags(len);
> > >                 len    =3D hci_iso_data_len(len);
> > >
> > > -               BT_DBG("Start: total len %d, frag len %d flags 0x%4.4=
x", len,
> > > -                      skb->len, flags);
> > > +               BT_DBG("Start: total len %d, frag len %d flags 0x%4.4=
x sn %d",
> > > +                      len, skb->len, flags, sn);
> > >
> > >                 if (len =3D=3D skb->len) {
> > >                         /* Complete frame received */
> > >                         hci_skb_pkt_status(skb) =3D flags & 0x03;
> > > +                       hci_skb_pkt_seqnum(skb) =3D sn;
> > >                         iso_recv_frame(conn, skb);
> > >                         return;
> > >                 }
> > > @@ -2352,6 +2366,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_=
buff *skb, u16 flags)
> > >                         goto drop;
> > >
> > >                 hci_skb_pkt_status(conn->rx_skb) =3D flags & 0x03;
> > > +               hci_skb_pkt_seqnum(conn->rx_skb) =3D sn;
> > >                 skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, =
skb->len),
> > >                                           skb->len);
> > >                 conn->rx_len =3D len - skb->len;
> > > --
> > > 2.50.1
> > >
> >
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz

