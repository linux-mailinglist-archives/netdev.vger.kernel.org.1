Return-Path: <netdev+bounces-186761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A58AA0F2A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81137A00F1
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF352192E5;
	Tue, 29 Apr 2025 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPM8QfwD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4153217F27;
	Tue, 29 Apr 2025 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937538; cv=none; b=rFX0fZGAV4Gg4T8KnzpJGFh0HjVyebPBh1IGOFL/ImHXcx0aZlX0CCBGGw3b/Ec+fuI44Q1mviUnUvm4ZF7dYuZ1uacv5FUdPUoCYy48rCBWRzw0bzOqr8v/skcc6TQYK2ZN/zpo/6+g37SZ80dHIjQrcnnvGPsF847gUjWltq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937538; c=relaxed/simple;
	bh=2vK8wfdhctKeMX6+VICfhLvjVMLwuPS43jp7sj0kcGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMdE3TJf9jita2HrlKQAcNTh/gmZjL+9kVczfd8IXo5jdY/f//iiJCs6rIOBgmLj6T0Jk81tXG8HySeksE+2TrBTZzYDgkuXs+a6zKNvwyu9Pz02B4Gqr6P+1elkdqERnoWqiPsx8bPo+ST3DcEKszPHH2osvh5df4x5E7MMOYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPM8QfwD; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30db1bd3bddso61555891fa.3;
        Tue, 29 Apr 2025 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745937534; x=1746542334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hNaKeCz9vpCJ6XP4Ntl5vXieH5atU3q47S1kV0QIhA=;
        b=CPM8QfwDmyC7eB6ch5dPE4cYuy+j0HPF3CqxWZmlyY0v3150OeP/KdNOTlsPkrSjc4
         p7gHgOoGwW72WZdF1tLqmgF3da/uUzwIzCQf8b/hyTSxWg4JafMa9C0Sj3YDMothPIiW
         MFs+osMQ3RTj/VFmbwHhJ/2rsNd65YvDvN/Z6O7DgPTT6wJArGXBoUBBtXLoW51vDggd
         rhMjQwgKWfC2rHv3SHnVDLBBzWSWP8FzRGcPsgdKcdoT8o6gUf5JfKBbYjK/7p5z0BNG
         OYyox4JUIgLbxF0+YgxRMuXvBZFtiVJ62POeE4CNlJGcTUOlt6uE0Htk8XZi7f2aFC2O
         RpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745937534; x=1746542334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hNaKeCz9vpCJ6XP4Ntl5vXieH5atU3q47S1kV0QIhA=;
        b=exHO6eZWmpct7tmwZTVtpp6rIpwWZfGYxp2l5sUeowZin10v6s4mFtT/i633B+eTbS
         RGfLNEWuJqhYJYQJ3iVpLW4mh4k38g+LXwOuS07B7s++RRYAvj4eDb+LnjBEVymQ2h9n
         Oe+E+UHcStGuWSk4YcdYd/3PY9qIzSriKiwEf71GxRVtu6O1hEUvwvt8f3lDJmJ8egP9
         H7N0dSXhJEm9zuzI9bzCVzn4Yin+YvKjxdmelg+EAtsOX/70GG/cQ7NdLR0kt9v8oCUt
         xEYxSkntBobYR/zfY6MBm79ymqHN8ubzP5LgztJK4mawt3WxXfEUGlm8hxfrZyBYWNY4
         cxQw==
X-Forwarded-Encrypted: i=1; AJvYcCU6lcYvRK1QhFYM806IMZUN68IaFN5fEtD5b9MNwMKwQGrF5if1YRta1gkI86naA1lh6hZSA4kVStDdwIDG13o=@vger.kernel.org, AJvYcCX/N3gTpkpWh06nmGjJ1wC6pj4rb4x7OxvIGzrs0asM2znwqqD491KO1TnsMhdZcG7UgFiykyyn@vger.kernel.org
X-Gm-Message-State: AOJu0YzAzSuFaZghPQcHm4Xn4bsfRes0CIUHWSYPZb7HCcGShvg8RRJG
	E54qiy+Qktgfs1ibczGrRO1AjrV7nYbxesfvrZL18Obbg35hdWjrLX/Dt4EFeZZDY28PzjJ2pvT
	ZzaoEYa3z9mYNSOlPAHqgDTKPyJb10hzC
X-Gm-Gg: ASbGnctpZXkbP6rzhWy2d3H4VqTnicnir+PIjoQ6IJFhql12wIKtKA9HclsoWbzPemi
	UBPRQC6GqJDiiPxHPdywJOdgeAY26WdmT1kgA46sb/0nXrtbvxFl5F5GbgYRcSEraUeq8orU3vA
	dPgmHkKnUwVpWOQszWJ/1nFk1j0H+5JqQ=
X-Google-Smtp-Source: AGHT+IFA4tPKWXpHb8/2sOnwA3s6Jrtu5WC/GL8p+8EVSoqtGGJ2R0bzk+nd+0foot0+yyxOHyy3sP7ltEf0dc0iuco=
X-Received: by 2002:a2e:a99e:0:b0:30d:6a15:6a69 with SMTP id
 38308e7fff4ca-319dc41d3d5mr41329491fa.20.1745937533547; Tue, 29 Apr 2025
 07:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com>
 <e8190a3bedc0c477347d0799f5a4c16480bfb4e9.camel@iki.fi> <d68a9f4b25f6df883a75f1a44eb90bee64d4c3bc.camel@iki.fi>
 <CABBYNZ+StxjHC4f_JmPdJg2iv+o+ngyEuSvsBZB7Rrr=9juouQ@mail.gmail.com> <86F23E2B-3648-4EDE-8FAA-96C6DEA84813@iki.fi>
In-Reply-To: <86F23E2B-3648-4EDE-8FAA-96C6DEA84813@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Apr 2025 10:38:40 -0400
X-Gm-Features: ATxdqUGaLA10X7JV1bhMp_jkzVsKxxGnZH_AzHaXMUtjCadBgQAq6WLx50Q6JPY
Message-ID: <CABBYNZKKJE05c3037Pab-GpJK0P2NoYNm=eYa9g93NpshEaHXg@mail.gmail.com>
Subject: Re: [PATCH] iso: add BT_ISO_TS optional to enable ISO timestamp
To: Pauli Virtanen <pav@iki.fi>
Cc: yang.li@amlogic.com, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Apr 29, 2025 at 10:35=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> 29. huhtikuuta 2025 17.31.25 GMT+03:00 Luiz Augusto von Dentz <luiz.dentz=
@gmail.com> kirjoitti:
> >Hi Pauli,
> >
> >On Tue, Apr 29, 2025 at 10:29=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wro=
te:
> >>
> >> ti, 2025-04-29 kello 17:26 +0300, Pauli Virtanen kirjoitti:
> >> > Hi,
> >> >
> >> > ti, 2025-04-29 kello 11:35 +0800, Yang Li via B4 Relay kirjoitti:
> >> > > From: Yang Li <yang.li@amlogic.com>
> >> > >
> >> > > Application layer programs (like pipewire) need to use
> >> > > iso timestamp information for audio synchronization.
> >> >
> >> > I think the timestamp should be put into CMSG, same ways as packet
> >> > status is. The packet body should then always contain only the paylo=
ad.
> >>
> >> Or, this maybe should instead use the SOF_TIMESTAMPING_RX_HARDWARE
> >> mechanism, which would avoid adding a new API.
> >
> >Either that or we use BT_PKT_STATUS, does SOF_TIMESTAMPING_RX_HARDWARE
> >requires the use of errqueue?
>
> No, it just adds a CMSG, similar to the RX software tstamp.

Perfect, then there should be no problem going with that, we might
want to introduce some tests for it and perhaps have the emulator
adding timestamps headers so we can test this with the likes of
iso-tester.

> >
> >> > >
> >> > > Signed-off-by: Yang Li <yang.li@amlogic.com>
> >> > > ---
> >> > >  include/net/bluetooth/bluetooth.h |  4 ++-
> >> > >  net/bluetooth/iso.c               | 58 ++++++++++++++++++++++++++=
+++++++------
> >> > >  2 files changed, 52 insertions(+), 10 deletions(-)
> >> > >
> >> > > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluet=
ooth/bluetooth.h
> >> > > index bbefde319f95..a102bd76647c 100644
> >> > > --- a/include/net/bluetooth/bluetooth.h
> >> > > +++ b/include/net/bluetooth/bluetooth.h
> >> > > @@ -242,6 +242,7 @@ struct bt_codecs {
> >> > >  #define BT_CODEC_MSBC              0x05
> >> > >
> >> > >  #define BT_ISO_BASE                20
> >> > > +#define BT_ISO_TS          21
> >> > >
> >> > >  __printf(1, 2)
> >> > >  void bt_info(const char *fmt, ...);
> >> > > @@ -390,7 +391,8 @@ struct bt_sock {
> >> > >  enum {
> >> > >     BT_SK_DEFER_SETUP,
> >> > >     BT_SK_SUSPEND,
> >> > > -   BT_SK_PKT_STATUS
> >> > > +   BT_SK_PKT_STATUS,
> >> > > +   BT_SK_ISO_TS
> >> > >  };
> >> > >
> >> > >  struct bt_sock_list {
> >> > > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> >> > > index 2f348f48e99d..2c1fdea4b8c1 100644
> >> > > --- a/net/bluetooth/iso.c
> >> > > +++ b/net/bluetooth/iso.c
> >> > > @@ -1718,7 +1718,21 @@ static int iso_sock_setsockopt(struct socke=
t *sock, int level, int optname,
> >> > >             iso_pi(sk)->base_len =3D optlen;
> >> > >
> >> > >             break;
> >> > > +   case BT_ISO_TS:
> >> > > +           if (optlen !=3D sizeof(opt)) {
> >> > > +                   err =3D -EINVAL;
> >> > > +                   break;
> >> > > +           }
> >> > >
> >> > > +           err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optv=
al, optlen);
> >> > > +           if (err)
> >> > > +                   break;
> >> > > +
> >> > > +           if (opt)
> >> > > +                   set_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
> >> > > +           else
> >> > > +                   clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
> >> > > +           break;
> >> > >     default:
> >> > >             err =3D -ENOPROTOOPT;
> >> > >             break;
> >> > > @@ -1789,7 +1803,16 @@ static int iso_sock_getsockopt(struct socke=
t *sock, int level, int optname,
> >> > >                     err =3D -EFAULT;
> >> > >
> >> > >             break;
> >> > > +   case BT_ISO_TS:
> >> > > +           if (len < sizeof(u32)) {
> >> > > +                   err =3D -EINVAL;
> >> > > +                   break;
> >> > > +           }
> >> > >
> >> > > +           if (put_user(test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)=
,
> >> > > +                       (u32 __user *)optval))
> >> > > +                   err =3D -EFAULT;
> >> > > +           break;
> >> > >     default:
> >> > >             err =3D -ENOPROTOOPT;
> >> > >             break;
> >> > > @@ -2271,13 +2294,21 @@ static void iso_disconn_cfm(struct hci_con=
n *hcon, __u8 reason)
> >> > >  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 fla=
gs)
> >> > >  {
> >> > >     struct iso_conn *conn =3D hcon->iso_data;
> >> > > +   struct sock *sk;
> >> > >     __u16 pb, ts, len;
> >> > >
> >> > >     if (!conn)
> >> > >             goto drop;
> >> > >
> >> > > -   pb     =3D hci_iso_flags_pb(flags);
> >> > > -   ts     =3D hci_iso_flags_ts(flags);
> >> > > +   iso_conn_lock(conn);
> >> > > +   sk =3D conn->sk;
> >> > > +   iso_conn_unlock(conn);
> >> > > +
> >> > > +   if (!sk)
> >> > > +           goto drop;
> >> > > +
> >> > > +   pb =3D hci_iso_flags_pb(flags);
> >> > > +   ts =3D hci_iso_flags_ts(flags);
> >> > >
> >> > >     BT_DBG("conn %p len %d pb 0x%x ts 0x%x", conn, skb->len, pb, t=
s);
> >> > >
> >> > > @@ -2294,17 +2325,26 @@ void iso_recv(struct hci_conn *hcon, struc=
t sk_buff *skb, u16 flags)
> >> > >             if (ts) {
> >> > >                     struct hci_iso_ts_data_hdr *hdr;
> >> > >
> >> > > -                   /* TODO: add timestamp to the packet? */
> >> > > -                   hdr =3D skb_pull_data(skb, HCI_ISO_TS_DATA_HDR=
_SIZE);
> >> > > -                   if (!hdr) {
> >> > > -                           BT_ERR("Frame is too short (len %d)", =
skb->len);
> >> > > -                           goto drop;
> >> > > -                   }
> >> > > +                   if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags))=
 {
> >> > > +                           hdr =3D (struct hci_iso_ts_data_hdr *)=
skb->data;
> >> > > +                           len =3D hdr->slen + HCI_ISO_TS_DATA_HD=
R_SIZE;
> >> > > +                   } else {
> >> > > +                           hdr =3D skb_pull_data(skb, HCI_ISO_TS_=
DATA_HDR_SIZE);
> >> > > +                           if (!hdr) {
> >> > > +                                   BT_ERR("Frame is too short (le=
n %d)", skb->len);
> >> > > +                                   goto drop;
> >> > > +                           }
> >> > >
> >> > > -                   len =3D __le16_to_cpu(hdr->slen);
> >> > > +                           len =3D __le16_to_cpu(hdr->slen);
> >> > > +                   }
> >> > >             } else {
> >> > >                     struct hci_iso_data_hdr *hdr;
> >> > >
> >> > > +                   if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags))=
 {
> >> > > +                           BT_ERR("Invalid option BT_SK_ISO_TS");
> >> > > +                           clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->fl=
ags);
> >> > > +                   }
> >> > > +
> >> > >                     hdr =3D skb_pull_data(skb, HCI_ISO_DATA_HDR_SI=
ZE);
> >> > >                     if (!hdr) {
> >> > >                             BT_ERR("Frame is too short (len %d)", =
skb->len);
> >> > >
> >> > > ---
> >> > > base-commit: 16b4f97defefd93cfaea017a7c3e8849322f7dde
> >> > > change-id: 20250421-iso_ts-c82a300ae784
> >> > >
> >> > > Best regards,
> >
> >
> >



--=20
Luiz Augusto von Dentz

