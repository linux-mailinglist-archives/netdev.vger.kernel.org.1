Return-Path: <netdev+bounces-186755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD96AA0ED5
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF294A0FCC
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A6A1DF73C;
	Tue, 29 Apr 2025 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBkIkY9E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A6E86353;
	Tue, 29 Apr 2025 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937101; cv=none; b=iRW4UNdLxDm5rbf0+2Yi5wterrvnjKmeWpRkKay4bTdCa+ameJdcEJiJt7ezGN3OnmGDYxTNpV3PPZN7v6LUcgqqf8PplEUtj4dk0UkxRvN8OjyMjuXAPSW4T3AqQKu6mRKv2CARp2oOzy5+NMq3OSLpHzzUlVMz4lU1J2hoWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937101; c=relaxed/simple;
	bh=BuV2kIcOU1QQNR3kYDfQPsfP9qEL9yxy190zugAJauk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmmrTxDTw/+/msycs3BJp/Q9APwjRwRBj6Xz8sStLgt3tKK0nZhwP5fgv4CGMyYKHWUqkf131LmPnzUdu3zXZOljlOdTBjM5rSGDXAPX6lE9EKe8mok8gi7rvKjsLlELZQCucP/TzTyPLefst223FcFj84vHC94mC1IBipbjiCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBkIkY9E; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bf1d48843so53179121fa.2;
        Tue, 29 Apr 2025 07:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745937098; x=1746541898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7La73gWRjthE0KmwgISND3H1wfD+o1YzxL8iBXHILs=;
        b=mBkIkY9EYKUv9mjW0koDcydNLfyW6CuGyYET3mEOnTx21D2lqR60ROF50u8w6zzze4
         PVWEaXFehSb+vIpn7OjVURbBSSJqgABIOOp3xTk3RSNobRMu2snF92RWJMc9kZVOaLJf
         4t0zN8I/r2lMIE2KeEzbjZR7kom771mEgpqMa9jCrcNHeR8O5gPuhyTUxFkGL9PeLMc2
         4rp9p/4ApD2IeCHEJ7fetTRSF6C2rIU6/0OvIoC+8Jqq9+1Lm86hkZZSruKRoJCiUwj0
         jZGklGyHjIncImAz1c8WkRgXt1rPB8RMH01VNQazjsdaje4D3Vi+0fAjP/1r6bLlSb/N
         IIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745937098; x=1746541898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7La73gWRjthE0KmwgISND3H1wfD+o1YzxL8iBXHILs=;
        b=OxqY+hTAmES7vHFyvb7pdyBqMkZkWSf29FY+EevrMWJz6el9bGV+bVKlqdxR3BQCCP
         YjMhXPrMCqG8XVyJcoLv+3QM0eNka9NG37Vhkqns/ZtCJ3reIGOd9AMt97mKlpSsu7pS
         a+VGeUv14zvbYzkpevmMDuKSxL2l8+nVTNOOouSiDHy0rOPtyAq0ARS0xzh11O7VTKbv
         gt34UMhEGGhgyiFSZjH/e2QCczYNARYxT7earqH/7LpHJwsTkPwumhpVK/bviH/y+XpI
         zrqdhsBxeD5oMGeaADt/DKSyi0W+Aicxp5GWS9BMNGv0zVP7qVexuRa/X3m1saX9b+f7
         7y6g==
X-Forwarded-Encrypted: i=1; AJvYcCVuLfCIJR1LhtP6fga6ICWLCHRh1r0AR78BZzOD0+Nxs0gLd/SX/HcTHLIfwaUEfYj13cQcVLafNZsl4zK0oy0=@vger.kernel.org, AJvYcCXyjbrmp4n9pxBUuHKHUhs74Ri9x/Qwxj2mcL1Q6jFHS3JNyCcZmY57sZMsY223qOnc5TkmH+LS@vger.kernel.org
X-Gm-Message-State: AOJu0YwJbiKaOGDQx/3P9yFSiDL+ELfKezgYnOOQ7Y8GbPmQceHYQ35/
	/CMudMzzbt7YgL/mXYQxiUsaLWHZ6RtBZnM9bI4Xi8jMSVw3p/OXzs1hzAsXaeeehwQMzO2V3zd
	qBaf0HHy68NyiM4IDtgogBlCGcME=
X-Gm-Gg: ASbGnct5sCHvhutyXgAAIfXMCzAdp3maz9oUeviniPtOU0oTbrRS3VjG6b7FvXRxVF9
	FkuqDMJgaYrK2Q7mhsQ1WFyCv5w5oXSSWs54dtSlt32IqmA4bRvI/szUut2+7GjxqYP51r5/OAJ
	GKjAPSwVKnBeADFRp8s6qUMHUowZXjpL8=
X-Google-Smtp-Source: AGHT+IFLMgvgtO3VpelWAllyGGOfLmlI23DRkW+kNEE8JExIPtXZ6j571Y+YrrYIfVm1BYFU7V0qJwYiX2cm8uqf8YU=
X-Received: by 2002:a05:651c:154e:b0:30b:edd8:886 with SMTP id
 38308e7fff4ca-31d34774bf1mr16555611fa.9.1745937097750; Tue, 29 Apr 2025
 07:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com>
 <e8190a3bedc0c477347d0799f5a4c16480bfb4e9.camel@iki.fi> <d68a9f4b25f6df883a75f1a44eb90bee64d4c3bc.camel@iki.fi>
In-Reply-To: <d68a9f4b25f6df883a75f1a44eb90bee64d4c3bc.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Apr 2025 10:31:25 -0400
X-Gm-Features: ATxdqUEhiSlxovu_06ig3E2bD8qA5L00Ddka1s76SH1l3tndrqrkUV6FxtYsx6c
Message-ID: <CABBYNZ+StxjHC4f_JmPdJg2iv+o+ngyEuSvsBZB7Rrr=9juouQ@mail.gmail.com>
Subject: Re: [PATCH] iso: add BT_ISO_TS optional to enable ISO timestamp
To: Pauli Virtanen <pav@iki.fi>
Cc: yang.li@amlogic.com, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Apr 29, 2025 at 10:29=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> ti, 2025-04-29 kello 17:26 +0300, Pauli Virtanen kirjoitti:
> > Hi,
> >
> > ti, 2025-04-29 kello 11:35 +0800, Yang Li via B4 Relay kirjoitti:
> > > From: Yang Li <yang.li@amlogic.com>
> > >
> > > Application layer programs (like pipewire) need to use
> > > iso timestamp information for audio synchronization.
> >
> > I think the timestamp should be put into CMSG, same ways as packet
> > status is. The packet body should then always contain only the payload.
>
> Or, this maybe should instead use the SOF_TIMESTAMPING_RX_HARDWARE
> mechanism, which would avoid adding a new API.

Either that or we use BT_PKT_STATUS, does SOF_TIMESTAMPING_RX_HARDWARE
requires the use of errqueue?

> > >
> > > Signed-off-by: Yang Li <yang.li@amlogic.com>
> > > ---
> > >  include/net/bluetooth/bluetooth.h |  4 ++-
> > >  net/bluetooth/iso.c               | 58 +++++++++++++++++++++++++++++=
++++------
> > >  2 files changed, 52 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetoot=
h/bluetooth.h
> > > index bbefde319f95..a102bd76647c 100644
> > > --- a/include/net/bluetooth/bluetooth.h
> > > +++ b/include/net/bluetooth/bluetooth.h
> > > @@ -242,6 +242,7 @@ struct bt_codecs {
> > >  #define BT_CODEC_MSBC              0x05
> > >
> > >  #define BT_ISO_BASE                20
> > > +#define BT_ISO_TS          21
> > >
> > >  __printf(1, 2)
> > >  void bt_info(const char *fmt, ...);
> > > @@ -390,7 +391,8 @@ struct bt_sock {
> > >  enum {
> > >     BT_SK_DEFER_SETUP,
> > >     BT_SK_SUSPEND,
> > > -   BT_SK_PKT_STATUS
> > > +   BT_SK_PKT_STATUS,
> > > +   BT_SK_ISO_TS
> > >  };
> > >
> > >  struct bt_sock_list {
> > > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > > index 2f348f48e99d..2c1fdea4b8c1 100644
> > > --- a/net/bluetooth/iso.c
> > > +++ b/net/bluetooth/iso.c
> > > @@ -1718,7 +1718,21 @@ static int iso_sock_setsockopt(struct socket *=
sock, int level, int optname,
> > >             iso_pi(sk)->base_len =3D optlen;
> > >
> > >             break;
> > > +   case BT_ISO_TS:
> > > +           if (optlen !=3D sizeof(opt)) {
> > > +                   err =3D -EINVAL;
> > > +                   break;
> > > +           }
> > >
> > > +           err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
> > > +           if (err)
> > > +                   break;
> > > +
> > > +           if (opt)
> > > +                   set_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
> > > +           else
> > > +                   clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
> > > +           break;
> > >     default:
> > >             err =3D -ENOPROTOOPT;
> > >             break;
> > > @@ -1789,7 +1803,16 @@ static int iso_sock_getsockopt(struct socket *=
sock, int level, int optname,
> > >                     err =3D -EFAULT;
> > >
> > >             break;
> > > +   case BT_ISO_TS:
> > > +           if (len < sizeof(u32)) {
> > > +                   err =3D -EINVAL;
> > > +                   break;
> > > +           }
> > >
> > > +           if (put_user(test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags),
> > > +                       (u32 __user *)optval))
> > > +                   err =3D -EFAULT;
> > > +           break;
> > >     default:
> > >             err =3D -ENOPROTOOPT;
> > >             break;
> > > @@ -2271,13 +2294,21 @@ static void iso_disconn_cfm(struct hci_conn *=
hcon, __u8 reason)
> > >  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
> > >  {
> > >     struct iso_conn *conn =3D hcon->iso_data;
> > > +   struct sock *sk;
> > >     __u16 pb, ts, len;
> > >
> > >     if (!conn)
> > >             goto drop;
> > >
> > > -   pb     =3D hci_iso_flags_pb(flags);
> > > -   ts     =3D hci_iso_flags_ts(flags);
> > > +   iso_conn_lock(conn);
> > > +   sk =3D conn->sk;
> > > +   iso_conn_unlock(conn);
> > > +
> > > +   if (!sk)
> > > +           goto drop;
> > > +
> > > +   pb =3D hci_iso_flags_pb(flags);
> > > +   ts =3D hci_iso_flags_ts(flags);
> > >
> > >     BT_DBG("conn %p len %d pb 0x%x ts 0x%x", conn, skb->len, pb, ts);
> > >
> > > @@ -2294,17 +2325,26 @@ void iso_recv(struct hci_conn *hcon, struct s=
k_buff *skb, u16 flags)
> > >             if (ts) {
> > >                     struct hci_iso_ts_data_hdr *hdr;
> > >
> > > -                   /* TODO: add timestamp to the packet? */
> > > -                   hdr =3D skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SI=
ZE);
> > > -                   if (!hdr) {
> > > -                           BT_ERR("Frame is too short (len %d)", skb=
->len);
> > > -                           goto drop;
> > > -                   }
> > > +                   if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)) {
> > > +                           hdr =3D (struct hci_iso_ts_data_hdr *)skb=
->data;
> > > +                           len =3D hdr->slen + HCI_ISO_TS_DATA_HDR_S=
IZE;
> > > +                   } else {
> > > +                           hdr =3D skb_pull_data(skb, HCI_ISO_TS_DAT=
A_HDR_SIZE);
> > > +                           if (!hdr) {
> > > +                                   BT_ERR("Frame is too short (len %=
d)", skb->len);
> > > +                                   goto drop;
> > > +                           }
> > >
> > > -                   len =3D __le16_to_cpu(hdr->slen);
> > > +                           len =3D __le16_to_cpu(hdr->slen);
> > > +                   }
> > >             } else {
> > >                     struct hci_iso_data_hdr *hdr;
> > >
> > > +                   if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)) {
> > > +                           BT_ERR("Invalid option BT_SK_ISO_TS");
> > > +                           clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags=
);
> > > +                   }
> > > +
> > >                     hdr =3D skb_pull_data(skb, HCI_ISO_DATA_HDR_SIZE)=
;
> > >                     if (!hdr) {
> > >                             BT_ERR("Frame is too short (len %d)", skb=
->len);
> > >
> > > ---
> > > base-commit: 16b4f97defefd93cfaea017a7c3e8849322f7dde
> > > change-id: 20250421-iso_ts-c82a300ae784
> > >
> > > Best regards,



--=20
Luiz Augusto von Dentz

