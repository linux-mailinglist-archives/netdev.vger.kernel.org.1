Return-Path: <netdev+bounces-186753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B83BAA0ECB
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EDB67A440E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFB617BCE;
	Tue, 29 Apr 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV0IYmHf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C11CF96;
	Tue, 29 Apr 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937019; cv=none; b=tDGy2KwbVZYJkAgsxy/ERkuql5KRXBu/d+ul0kqTuU1JORut3BedtG+hO9IJ133rYOWtFXGJriNyqRBYOywTk9slgnd2bFwFNDXvkqfjwWGrsbUM+JS0FyQCXEGLweqe2TOH+/T8szZeUhMMC1ySNPxUSGG5zw8AmtYWz46xhqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937019; c=relaxed/simple;
	bh=UPtOa0SzyuMGEFE179DbDjMTeVeanzALrsnrmfuTIEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWBEp3cz4UsF2WKSDkI0N9SZXF/c3so67ur7mI66J4Fi2QVusWBp+sNhOoY4c1fPLsfqyAxXOdlAhhxIeS5Pd659tnBXskrSl5He0lBHj1WksKQvIVB1z9AKeLtKsKHr9Anrmh6qeUjdsVOq6IAojzgBfOYytbYT7Yd70b+Ex+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV0IYmHf; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-310447fe59aso69183441fa.0;
        Tue, 29 Apr 2025 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745937014; x=1746541814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpQLTpPzB1jZyN5f72lhub9RcOsAU7eBBJYKWAaNvvY=;
        b=QV0IYmHf2/9PwQVDriEY/JrYDDZWDschkT7MKIN7gxV7yOTZLXk7OaXvVLE/rugKSg
         MeBntRTmLP4lE3UFGUpzOPoij2T1lFE2cg3d5hrpWRv0powmKxoaixoHJ7Jlxi5lbpmP
         pfWkXmZm9obl+KHGbz6I2bhnhT7BNnopEjIvBvOs0QcawMJzTrMgn/XFMeB69A0SWQ6Y
         /9ha4qk7UPgP+QHYl9c1ZjSsKDDHh4HOaodLOGuEc8Rn+1cedxGZEG9zmwtdRS+LA03E
         UITdVJQVQqZjtvpzdCz5+srF2k3JZJcEndXBqpT9u/Lnxhs3Yi1U0PCZe22feU0p1ZKu
         cwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745937014; x=1746541814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpQLTpPzB1jZyN5f72lhub9RcOsAU7eBBJYKWAaNvvY=;
        b=fMLjPnHWe4XCB1WjSjAl0wA8vf5NEFcv3ue15cwJFTP66FCBUGxR2HUT4AJB8Jmyxd
         AlQJsd0YfV2wqqANJOpfAXJu7iL7c0cCX2z/EUZa6916TZ7cJD0zA5vJOcT7CxR5lCNx
         SnZpU0CKoGOZ+1R+Ixd/IotW2Dxn9Aobr/NpfXfCNt1/1KBsuwUQ5Ua0UMklfB/KTMz8
         a2KsGtPopeQqURzjXnI6EqVzlJH9xQ2MVbbUmlhLODqiJGl4JEqu7u9s24je+BhBEcUE
         YHrx3r/UqV3UGw3GqTS7wNnJDu++R58ql1DDXGHoixNnT5OtxrgF9ZQglxeAbDTs90mw
         C8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCU97p8jHH5UgPSHbB3C2te+sVOoy7tO+rwR9dIgaXDh2I1h4SP8q9EZdZq/46KH9xyGb043FMt/GHu6rFKEF9Q=@vger.kernel.org, AJvYcCWS6ui3GCpfK82Gsgv+47h3OQRhHALJpnyX1X7SzjcwBgYoC9BY5JmY5tknFvoTk5lztuKXQ+vc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2rCgdrh9OJjk12XrnuOT42Aucux7J8Ti1+rk5MZOJcuOJ+zwc
	wZXe9zIt5TxfaCquoc60FLcN/e4tg8M+XY2DkTNJJL93QJvjQDeCKVeGygEj5D0l4n87ArA8shq
	Lg+guH2JLSx0L8IN7jQK7DXpOAHR7VSZy
X-Gm-Gg: ASbGncvaWkp+Vsiipd/rNuC1Lyp3jErk94bVHyYtL2jb3tRJxBNxDFzFtopCdwBeh50
	Ke9XtnCZnJtQeJ492GA5jaVtWHbHDfzm2teIqG5xEBBZXk1Cpoi5nmPcZVB1SYwrUC/MnzWBuzq
	orLUEdd5RtuE8rUGCc9f8Y
X-Google-Smtp-Source: AGHT+IHTf/zF1vktcr16ROB5WJxGYDurobN5SDMwh/shpIjFHw8n3NvuWDzYIRTfyZtDpYU8JxiC4Lz6V742OSWrivs=
X-Received: by 2002:a2e:a550:0:b0:30c:dbf:51a5 with SMTP id
 38308e7fff4ca-31d362ef9ddmr14434651fa.35.1745937013528; Tue, 29 Apr 2025
 07:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com> <e8190a3bedc0c477347d0799f5a4c16480bfb4e9.camel@iki.fi>
In-Reply-To: <e8190a3bedc0c477347d0799f5a4c16480bfb4e9.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Apr 2025 10:30:01 -0400
X-Gm-Features: ATxdqUFnVWMq6BnTI5y6YMrwGJ8RYfRWqdPJUV4EL3CJ6pfoIUAuwjk9Jwkanl8
Message-ID: <CABBYNZL5XrGm1TzR_cnOUiuXkSfdGSZ7a8Zu5ZPqCsNnq9Cbuw@mail.gmail.com>
Subject: Re: [PATCH] iso: add BT_ISO_TS optional to enable ISO timestamp
To: Pauli Virtanen <pav@iki.fi>
Cc: yang.li@amlogic.com, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Apr 29, 2025 at 10:26=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ti, 2025-04-29 kello 11:35 +0800, Yang Li via B4 Relay kirjoitti:
> > From: Yang Li <yang.li@amlogic.com>
> >
> > Application layer programs (like pipewire) need to use
> > iso timestamp information for audio synchronization.
>
> I think the timestamp should be put into CMSG, same ways as packet
> status is. The packet body should then always contain only the payload.

Yes, we shall not have headers being sent to the application as part
of the payload.

> >
> > Signed-off-by: Yang Li <yang.li@amlogic.com>
> > ---
> >  include/net/bluetooth/bluetooth.h |  4 ++-
> >  net/bluetooth/iso.c               | 58 +++++++++++++++++++++++++++++++=
++------
> >  2 files changed, 52 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index bbefde319f95..a102bd76647c 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -242,6 +242,7 @@ struct bt_codecs {
> >  #define BT_CODEC_MSBC                0x05
> >
> >  #define BT_ISO_BASE          20
> > +#define BT_ISO_TS            21
> >
> >  __printf(1, 2)
> >  void bt_info(const char *fmt, ...);
> > @@ -390,7 +391,8 @@ struct bt_sock {
> >  enum {
> >       BT_SK_DEFER_SETUP,
> >       BT_SK_SUSPEND,
> > -     BT_SK_PKT_STATUS
> > +     BT_SK_PKT_STATUS,
> > +     BT_SK_ISO_TS
> >  };
> >
> >  struct bt_sock_list {
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index 2f348f48e99d..2c1fdea4b8c1 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -1718,7 +1718,21 @@ static int iso_sock_setsockopt(struct socket *so=
ck, int level, int optname,
> >               iso_pi(sk)->base_len =3D optlen;
> >
> >               break;
> > +     case BT_ISO_TS:
> > +             if (optlen !=3D sizeof(opt)) {
> > +                     err =3D -EINVAL;
> > +                     break;
> > +             }
> >
> > +             err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
> > +             if (err)
> > +                     break;
> > +
> > +             if (opt)
> > +                     set_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
> > +             else
> > +                     clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
> > +             break;
> >       default:
> >               err =3D -ENOPROTOOPT;
> >               break;
> > @@ -1789,7 +1803,16 @@ static int iso_sock_getsockopt(struct socket *so=
ck, int level, int optname,
> >                       err =3D -EFAULT;
> >
> >               break;
> > +     case BT_ISO_TS:
> > +             if (len < sizeof(u32)) {
> > +                     err =3D -EINVAL;
> > +                     break;
> > +             }
> >
> > +             if (put_user(test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags),
> > +                         (u32 __user *)optval))
> > +                     err =3D -EFAULT;
> > +             break;
> >       default:
> >               err =3D -ENOPROTOOPT;
> >               break;
> > @@ -2271,13 +2294,21 @@ static void iso_disconn_cfm(struct hci_conn *hc=
on, __u8 reason)
> >  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
> >  {
> >       struct iso_conn *conn =3D hcon->iso_data;
> > +     struct sock *sk;
> >       __u16 pb, ts, len;
> >
> >       if (!conn)
> >               goto drop;
> >
> > -     pb     =3D hci_iso_flags_pb(flags);
> > -     ts     =3D hci_iso_flags_ts(flags);
> > +     iso_conn_lock(conn);
> > +     sk =3D conn->sk;
> > +     iso_conn_unlock(conn);
> > +
> > +     if (!sk)
> > +             goto drop;
> > +
> > +     pb =3D hci_iso_flags_pb(flags);
> > +     ts =3D hci_iso_flags_ts(flags);
> >
> >       BT_DBG("conn %p len %d pb 0x%x ts 0x%x", conn, skb->len, pb, ts);
> >
> > @@ -2294,17 +2325,26 @@ void iso_recv(struct hci_conn *hcon, struct sk_=
buff *skb, u16 flags)
> >               if (ts) {
> >                       struct hci_iso_ts_data_hdr *hdr;
> >
> > -                     /* TODO: add timestamp to the packet? */
> > -                     hdr =3D skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SI=
ZE);
> > -                     if (!hdr) {
> > -                             BT_ERR("Frame is too short (len %d)", skb=
->len);
> > -                             goto drop;
> > -                     }
> > +                     if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)) {
> > +                             hdr =3D (struct hci_iso_ts_data_hdr *)skb=
->data;
> > +                             len =3D hdr->slen + HCI_ISO_TS_DATA_HDR_S=
IZE;
> > +                     } else {
> > +                             hdr =3D skb_pull_data(skb, HCI_ISO_TS_DAT=
A_HDR_SIZE);
> > +                             if (!hdr) {
> > +                                     BT_ERR("Frame is too short (len %=
d)", skb->len);
> > +                                     goto drop;
> > +                             }
> >
> > -                     len =3D __le16_to_cpu(hdr->slen);
> > +                             len =3D __le16_to_cpu(hdr->slen);
> > +                     }
> >               } else {
> >                       struct hci_iso_data_hdr *hdr;
> >
> > +                     if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)) {
> > +                             BT_ERR("Invalid option BT_SK_ISO_TS");
> > +                             clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags=
);
> > +                     }
> > +
> >                       hdr =3D skb_pull_data(skb, HCI_ISO_DATA_HDR_SIZE)=
;
> >                       if (!hdr) {
> >                               BT_ERR("Frame is too short (len %d)", skb=
->len);
> >
> > ---
> > base-commit: 16b4f97defefd93cfaea017a7c3e8849322f7dde
> > change-id: 20250421-iso_ts-c82a300ae784
> >
> > Best regards,
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz

