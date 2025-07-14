Return-Path: <netdev+bounces-206694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F5BB0417B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A692C7ADFFA
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFE52594AA;
	Mon, 14 Jul 2025 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm9TZXlf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E87254848;
	Mon, 14 Jul 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502875; cv=none; b=ZAUhqeeWd5+VYtjSa0mgVDs09VDpCnJNHzXJxfg90v5NARFbOM9JWiulVi+Zew1hKJaMGTKJf5DsXxmHdIANTnMuHxXhCa91FELGkteug+d5pX3W/9oYeU6fwCp64KhsEgx/vY3leboWGlLdLy0pRwcjGOHKUR/srACaM5PWVUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502875; c=relaxed/simple;
	bh=S5zzvy8qBN4oLuPgCKkXFZd4YsWaT+CALAOShFjWnx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REnsRjOBEXWQAlkiNxrSz0BCj3sLms+FPpO6G/ZBqAKxYGPCy45UDuOKztmH2HUlN7jH85oQDr9Etr7j1MHTo2JNwym638Y8NgRcmKuTQD+bGZFvvi2207Jp0P2Z5dI7bC/vkRY9XbBkAk1A4a6CIbO3LQJXAY0x5iZYpmbK90s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mm9TZXlf; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32f1763673cso53647261fa.3;
        Mon, 14 Jul 2025 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752502871; x=1753107671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tr9tLd8PzVeEnhN2KZdTshX06WyiXWHv7nHjm3Vcz+0=;
        b=Mm9TZXlfMrmfuXFN7oVKuucdKaMK7ZzzPvZ+JugIF2wc/2T6M1UulikagdZ/0RcirN
         ePYeG2WY84Ip4uJrnDQ71235bpejwEOK9z3z7Lcyde/kOMP9/clgJpqunIOXDq0Warzt
         nvwBSjK3PEiflVzWQWdqXPahRGYyuLbdkchy3tJCKq+kAOQhoOSwiPhxnzsgbwDtF3F1
         ERwQc0Ayu6Sce2sNsgIiW3Laac1nCByDe+VfmnrIBKSsU6fyKZ6uXDEZrMMUJjM7PqXY
         kvme8pfRe0gw+rjDZWo7Uqj6Ogd+7WrTlSDKjh2NFtmifU3Q4o3kknVn1L0N+8Mru6TY
         ukJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752502871; x=1753107671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tr9tLd8PzVeEnhN2KZdTshX06WyiXWHv7nHjm3Vcz+0=;
        b=n+v9G86OdqENyT5dtzBICHiagjcOFkF6mS6FmQiFsNMeG/E9+/7uStH6/e1Vd6KEYW
         5WN0DN0jE1T2ahDR7VBMJHnk4PoqU8H1dqc256Fy/NQabSOCDQG65G4d6HA7Lp0EDy8I
         bT5d5FKyaE1dlsQuDw61RGSGDNBvqkbfAU717L3Js6Tpt/hLZiKiqwp6y+PJqmT3JtBl
         5ZmW91/gQH0GK1CHI8UNUuGdtTHNz3Fg5I5IGy+AXemqyoAeVSNOEfqrAorvU7AS08V+
         XdsXSAhWvyGE+J1+05ElMWlDuogF19gftWu01jtQWGP3HSPqQYUwU3qUgj8p3Lxg9vf1
         KBUA==
X-Forwarded-Encrypted: i=1; AJvYcCVG3C6CRbmuQyIic+oUc3/s8f2M4TZZCTnB+40GAS5y2A5RuJfZw5yU9jyU3mO08NmucfxnFcVie2Rhd1Cb@vger.kernel.org, AJvYcCVjzPNZI0UuKsSShZWsGDTveJkxjiGthnW7Xh/61m8ZsVdeLsB+ZFAe6MsbA1yODS+lxgKmsnGINYk4E51Vvsg=@vger.kernel.org, AJvYcCXSmCdMr+kWlJpmEj3VxXCWTmodcA1HAZjooSC8m66406bsZiw+Sj2sede+eGJeHisv+IDsGOka@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLPj+kjVah3aNbixJ1QWh9x7rkO9hGm95f6ZUElecLzCZob3F
	FFeOhgtyzrIpUNl4r2mhWveMasPkgGjmbQ4BIny8ycoetOpDT5qpXjj25yryITv5R/h8kjp1N3f
	79jwtACtvmDjkIjkaYYBEEYJysapTM2s=
X-Gm-Gg: ASbGncvKPhRVCS7p1M11SmFOjkSMJLDYcprl1LciA5Sfi7tRNNyKAj9raLBd5MKFR53
	UEtMH6ZuWVCSH9aCVETbACXG6r32XHXxLQVxBXQ2WDSUlmaPkdaJR/kTcRrl+8Tfzr4DhuHcZTU
	Rd7wDrExX3wGys6N2Y66aEtxMspB9CaPyYdENLGOLOcHxomXoekmPFccJhTPd3ePm3rDdTYdY2D
	2NpAVivNmZC4vXB
X-Google-Smtp-Source: AGHT+IFv25s94eTshSlQ99k1GFSIdZpkudSJYBxlEVRj+v7lYPuzRldQqXMLGqzCb6/NnsB0mYCmDTzM9pi6MTXLDcs=
X-Received: by 2002:a2e:be11:0:b0:30b:d17b:26aa with SMTP id
 38308e7fff4ca-33053298910mr37764911fa.2.1752502870805; Mon, 14 Jul 2025
 07:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <474a5321753aba17ec2819ba59adfd157ecfb343.1752501596.git.pav@iki.fi>
 <bbdbe42b-614c-4f66-8712-f0ab8d54b490@molgen.mpg.de>
In-Reply-To: <bbdbe42b-614c-4f66-8712-f0ab8d54b490@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 14 Jul 2025 10:20:58 -0400
X-Gm-Features: Ac12FXzdCcOWcVCDmHTQLk2byvGNCXMRrDfigJYmUdSRGVRnx5_2pIJH8NiXFFQ
Message-ID: <CABBYNZL1O0On5xz6_sa0L+GsAWuPNNDk2oLhRUw-THJ9kF1ZTg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ISO: add socket option to report packet seqnum
 via CMSG
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	johan.hedberg@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, Jul 14, 2025 at 10:15=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Pauli,
>
>
> Thank you for your patch.
>
>
> Am 14.07.25 um 16:02 schrieb Pauli Virtanen:
> > User applications need a way to track which ISO interval a given SDU
> > belongs to, to properly detect packet loss. All controllers do not set
> > timestamps, and it's not guaranteed user application receives all packe=
t
> > reports (small socket buffer, or controller doesn't send all reports
> > like Intel AX210 is doing).
> >
> > Add socket option BT_PKT_SEQNUM that enables reporting of received
> > packet ISO sequence number in BT_SCM_PKT_SEQNUM CMSG.
>
> Are there user applications already supporting this, so it can be tested?
>
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >
> > Notes:
> >      Intel AX210 is not sending all reports:
> >
> >      $ btmon -r dump.btsnoop -I -C90|grep -A1 'ISO Data RX: Handle 2304=
'
> >      ...
> >      > ISO Data RX: Handle 2304 flags 0x02 dlen 64                     =
 #1713 [hci0] 22.567744
> >              dd 01 3c 00 6d 08 e9 14 1e 3b 85 7b 35 c2 25 0b  ..<.m....=
;.{5.%.
> >      --
> >      > ISO Data RX: Handle 2304 flags 0x02 dlen 64                     =
 #1718 [hci0] 22.573745
> >              de 01 3c 00 41 65 22 4f 99 9b 0b b6 ff cb 06 00  ..<.Ae"O.=
.......
> >      --
> >      > ISO Data RX: Handle 2304 flags 0x02 dlen 64                     =
 #1727 [hci0] 22.587933
> >              e0 01 3c 00 8b 6e 33 44 65 51 ee d7 e0 ee 49 d8  ..<..n3De=
Q....I.
> >      --
> >      > ISO Data RX: Handle 2304 flags 0x02 dlen 64                     =
 #1732 [hci0] 22.596742
> >              e1 01 3c 00 a7 48 54 a7 c1 9f dc 37 66 fe 04 ab  ..<..HT..=
..7f...
> >      ...
> >
> >      Here, report for packet with sequence number 0x01df is missing.
>
> Sorry, but where are the sequence number in the trace?

Looks like btmon don't actually print it, though that probably is
something we want to add along with handling of timestamp if that is
used.

> >
> >      This may be spec violation by the controller, see Core v6.1 pp. 37=
02
> >
> >          All SDUs shall be sent to the upper layer including the indica=
tion
> >          of validity of data. A report shall be sent to the upper layer=
 if
> >          the SDU is completely missing.
> >
> >      Regardless, it will be easier for user applications to see the HW
> >      sequence numbers directly, so they don't have to count packets and=
 it's
> >      in any case more reliable if packets get dropped due to socket buf=
fer
> >      size.
>
> I wouldn=E2=80=99t mind to have the note in the commit message.
>
> >   include/net/bluetooth/bluetooth.h |  9 ++++++++-
> >   net/bluetooth/af_bluetooth.c      |  7 +++++++
> >   net/bluetooth/iso.c               | 21 ++++++++++++++++++---
> >   3 files changed, 33 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index 114299bd8b98..0e31779a3341 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -244,6 +244,10 @@ struct bt_codecs {
> >
> >   #define BT_ISO_BASE         20
> >
> > +#define BT_PKT_SEQNUM                21
> > +
> > +#define BT_SCM_PKT_SEQNUM    0x05
> > +
> >   __printf(1, 2)
> >   void bt_info(const char *fmt, ...);
> >   __printf(1, 2)
> > @@ -391,7 +395,8 @@ struct bt_sock {
> >   enum {
> >       BT_SK_DEFER_SETUP,
> >       BT_SK_SUSPEND,
> > -     BT_SK_PKT_STATUS
> > +     BT_SK_PKT_STATUS,
> > +     BT_SK_PKT_SEQNUM,
> >   };
> >
> >   struct bt_sock_list {
> > @@ -475,6 +480,7 @@ struct bt_skb_cb {
> >       u8 pkt_type;
> >       u8 force_active;
> >       u16 expect;
> > +     u16 pkt_seqnum;
>
> Excuse my ignorance, just want to make sure, the type is big enough.
>
> >       u8 incoming:1;
> >       u8 pkt_status:2;
> >       union {
> > @@ -488,6 +494,7 @@ struct bt_skb_cb {
> >
> >   #define hci_skb_pkt_type(skb) bt_cb((skb))->pkt_type
> >   #define hci_skb_pkt_status(skb) bt_cb((skb))->pkt_status
> > +#define hci_skb_pkt_seqnum(skb) bt_cb((skb))->pkt_seqnum
> >   #define hci_skb_expect(skb) bt_cb((skb))->expect
> >   #define hci_skb_opcode(skb) bt_cb((skb))->hci.opcode
> >   #define hci_skb_event(skb) bt_cb((skb))->hci.req_event
> > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.=
c
> > index 6ad2f72f53f4..44b7acb20a67 100644
> > --- a/net/bluetooth/af_bluetooth.c
> > +++ b/net/bluetooth/af_bluetooth.c
> > @@ -364,6 +364,13 @@ int bt_sock_recvmsg(struct socket *sock, struct ms=
ghdr *msg, size_t len,
> >                       put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_STATUS,
> >                                sizeof(pkt_status), &pkt_status);
> >               }
> > +
> > +             if (test_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags)) {
> > +                     u16 pkt_seqnum =3D hci_skb_pkt_seqnum(skb);
> > +
> > +                     put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_SEQNUM,
> > +                              sizeof(pkt_seqnum), &pkt_seqnum);
> > +             }
> >       }
> >
> >       skb_free_datagram(sk, skb);
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index fc22782cbeeb..469450bb6b6c 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -1687,6 +1687,17 @@ static int iso_sock_setsockopt(struct socket *so=
ck, int level, int optname,
> >                       clear_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
> >               break;
> >
> > +     case BT_PKT_SEQNUM:
> > +             err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
> > +             if (err)
> > +                     break;
> > +
> > +             if (opt)
> > +                     set_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags);
> > +             else
> > +                     clear_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags);
> > +             break;
> > +
> >       case BT_ISO_QOS:
> >               if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOU=
ND &&
> >                   sk->sk_state !=3D BT_CONNECT2 &&
> > @@ -2278,7 +2289,7 @@ static void iso_disconn_cfm(struct hci_conn *hcon=
, __u8 reason)
> >   void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
> >   {
> >       struct iso_conn *conn =3D hcon->iso_data;
> > -     __u16 pb, ts, len;
> > +     __u16 pb, ts, len, sn;
>
> Use `seqnum` for consistency with the parts above.
>
> >
> >       if (!conn)
> >               goto drop;
> > @@ -2308,6 +2319,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_bu=
ff *skb, u16 flags)
> >                               goto drop;
> >                       }
> >
> > +                     sn =3D hdr->sn;
> >                       len =3D __le16_to_cpu(hdr->slen);
> >               } else {
> >                       struct hci_iso_data_hdr *hdr;
> > @@ -2318,18 +2330,20 @@ void iso_recv(struct hci_conn *hcon, struct sk_=
buff *skb, u16 flags)
> >                               goto drop;
> >                       }
> >
> > +                     sn =3D hdr->sn;
> >                       len =3D __le16_to_cpu(hdr->slen);
> >               }
> >
> >               flags  =3D hci_iso_data_flags(len);
> >               len    =3D hci_iso_data_len(len);
> >
> > -             BT_DBG("Start: total len %d, frag len %d flags 0x%4.4x", =
len,
> > -                    skb->len, flags);
> > +             BT_DBG("Start: total len %d, frag len %d flags 0x%4.4x sn=
 %d",
> > +                    len, skb->len, flags, sn);
> >
> >               if (len =3D=3D skb->len) {
> >                       /* Complete frame received */
> >                       hci_skb_pkt_status(skb) =3D flags & 0x03;
> > +                     hci_skb_pkt_seqnum(skb) =3D sn;
> >                       iso_recv_frame(conn, skb);
> >                       return;
> >               }
> > @@ -2352,6 +2366,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_bu=
ff *skb, u16 flags)
> >                       goto drop;
> >
> >               hci_skb_pkt_status(conn->rx_skb) =3D flags & 0x03;
> > +             hci_skb_pkt_seqnum(conn->rx_skb) =3D sn;
> >               skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb-=
>len),
> >                                         skb->len);
> >               conn->rx_len =3D len - skb->len;
>
>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz

