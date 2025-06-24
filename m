Return-Path: <netdev+bounces-200781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FE6AE6D6B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0760C3A5C02
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABF7296160;
	Tue, 24 Jun 2025 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+f9Z0q7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED031A8F60;
	Tue, 24 Jun 2025 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750785480; cv=none; b=Dhc6XvMvWllrzs/z/ezv/A8HUojxCcYdqib3ZNGIpiRPnbcN/TjulUqg9vXiTVBaK2hptzJ6ulgDh8hmrVS14ncd0DF86PJ3qPnBprizj3/c7c/ldnTb3IlySBbWOTcT7UBt1y9A1wr12lNHdmgCanV/GTHKAzZUN2gYwLIi6uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750785480; c=relaxed/simple;
	bh=ZQcYuSV6tMQxBUJFzohKcyvpbAeHCnEsgspV3MTw8yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goW80PcIt7HlurQZA74XmztHliAecKIg8dSUG54EAcAMx9BAyghVSixBY9dWNi39sOW+uoWf+BN+/eixgfj1odpQFVlcFQuD18ZKNLqSUntGdTsKjkR33GaYqpJvCKssOhAZqieVGwvj9yThRhUQH+AWviq+uLgAcp/ob3jxVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+f9Z0q7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553bcf41440so725905e87.3;
        Tue, 24 Jun 2025 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750785476; x=1751390276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dD2fv/FyvR3vL0nW87jnGU7/WWgZVwmKknU/+iBLI9Q=;
        b=f+f9Z0q7snTvLI8QB5u9h7Gh59hg42wVllJfxpr/5TVamchebXYQaBtImZi1s/FJLc
         fzsS0MVD0I8MnCt07y2UEfUf/CyWP7wg4MRFkt0rcbJyk8q7o99bAI5hdoWlvxFKTTXT
         EzGG2qiw8iuAhP7u0rersNs+Fm0Zk7IOmBqz1XKK4FavekSTIDBaxIf1BpnpqoPrSctL
         Vp2TrqNMxJL+7ZQ2CtqhN5YuuPh3zppJoOh27lfOG7anSVsVEOBGDNEvqE8j4/SjZfCu
         b+1peZb+0qEtM+F1a47ytZdp8nrKDYV5g5L81nOUIE6QgTGgMKgZqo50Qs73XKRehb0A
         Etdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750785476; x=1751390276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dD2fv/FyvR3vL0nW87jnGU7/WWgZVwmKknU/+iBLI9Q=;
        b=UKoQKFjZOJxVkG4e1d4+9E4F2o0/hA1+2vjJLejBbV27kXCm41kP/OiRdIgIpWCl5C
         lRYoy0E6kDWwYPmgP2add3ssZvTqYM1HAhPb9ajhIrUaupwPzt42o+b8fBp0Ha+bDe0S
         ewg3pDrMli4jn8gt4Txhk41t5l+Buhs4WXiFrHTJbk9E8qPnTp/ITmBGvfFeKFUhFe0A
         xPc6U5tSUQFIxDlj39LHIz9VQokHjNYj3uDScIu6D+CcSVxFbIc0+n4fLA1NkhaAANsk
         gA4ZYD2gZCBGGcEu/H/usHXk2p9Or6N8emMdf9bx56nC8axhuGnQ8Jvc6NCChsGTNL2u
         weNA==
X-Forwarded-Encrypted: i=1; AJvYcCWDxeEPjwEuvVqilqOfPJgZS0aRLYaPwnWpi9o88GANxXQfGNDHY3aaEjXhcr6f5TfiEH3I666czkKTau+X@vger.kernel.org, AJvYcCX3a9ER+Vpl6HxKz50GMMcQ6IKzNfd1Ag57EdPQ6uThNjq90obID79nr/SsDa9aUdmRml5kWCkB@vger.kernel.org, AJvYcCXeSUAJpZtEJwkdJQ2Q91roaLxxs3ypXMJJEnrDKYPq+KwjrQNRgHzasN3JKG4kyD1nB5bJp8mCQbDW1ksdE6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4jDa4px+OaEPOHz5WIwDfiNq2RwvyNfaDlkIL41hDGxgMc+Pq
	bvwhGmcGCatBU7bLJQ/fSG7GBYQbmUy+zxbf/4vg+WSkjx0EJ0eB/ICyXilXNDsCv5gztA3auh1
	x48HZgVrFLslZrdBd5kl+JXP919ilSFo=
X-Gm-Gg: ASbGncuzKrrepLcolmdaEq9arM8CEuAlwozc+A0+hbxXGWi/mmBZrdjk4hw/RYBG4Kv
	/HWvJWKkuFeNOOIy9FiBzNjUSFGsoWKH0Int0mXnd6iFwgMiaHIzLCW3wnobiwAHUDxJbranBWZ
	X0wJOffi9MyN5ttvlwNJnxJtVLvlHN4qicJLVSTwspDAac8uYOygjG
X-Google-Smtp-Source: AGHT+IFyF0LJlIgVrtRIVtMOC+mLe54h3HBRC7zc+10FBt2LeB8PDF4mFxBcKA7niCsB+DUnu5DqY/3HdEvvr8C5at8=
X-Received: by 2002:a05:6512:1598:b0:553:2357:288c with SMTP id
 2adb3069b0e04-553e3baca32mr6231942e87.17.1750785475915; Tue, 24 Jun 2025
 10:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com>
 <CABBYNZKhTOWGXRWe5EYP0Mp3ynO5TmV-zgE43AVmNgm-=01gbg@mail.gmail.com>
In-Reply-To: <CABBYNZKhTOWGXRWe5EYP0Mp3ynO5TmV-zgE43AVmNgm-=01gbg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Jun 2025 13:17:42 -0400
X-Gm-Features: Ac12FXw5Is5OTy_TVZqaHeGrfUNdtgreGonI577hPXpo625AlzmTVIcd6uXCP0A
Message-ID: <CABBYNZLakMqxtJwzmpi2DuBg9ftzLutBKN8S-UEmwo9k9uek5g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Add support for handling LE BIG
 Sync Lost event
To: yang.li@amlogic.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 24, 2025 at 12:56=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Tue, Jun 24, 2025 at 1:20=E2=80=AFAM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
> >
> > From: Yang Li <yang.li@amlogic.com>
> >
> > When the BIS source stops, the controller sends an LE BIG Sync Lost
> > event (subevent 0x1E). Currently, this event is not handled, causing
> > the BIS stream to remain active in BlueZ and preventing recovery.
> >
> > Signed-off-by: Yang Li <yang.li@amlogic.com>
> > ---
> >  include/net/bluetooth/hci.h |  6 ++++++
> >  net/bluetooth/hci_event.c   | 23 +++++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 82cbd54443ac..48389a64accb 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
> >         __le16  bis[];
> >  } __packed;
> >
> > +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
> > +struct hci_evt_le_big_sync_lost {
> > +       __u8    handle;
> > +       __u8    reason;
> > +} __packed;
> > +
> >  #define HCI_EVT_LE_BIG_INFO_ADV_REPORT 0x22
> >  struct hci_evt_le_big_info_adv_report {
> >         __le16  sync_handle;
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 66052d6aaa1d..730deaf1851f 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -7026,6 +7026,24 @@ static void hci_le_big_sync_established_evt(stru=
ct hci_dev *hdev, void *data,
> >         hci_dev_unlock(hdev);
> >  }
> >
> > +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
> > +                                           struct sk_buff *skb)
> > +{
> > +       struct hci_evt_le_big_sync_lost *ev =3D data;
> > +       struct hci_conn *conn;
> > +
> > +       bt_dev_dbg(hdev, "BIG Sync Lost: big_handle 0x%2.2x", ev->handl=
e);
> > +
> > +       hci_dev_lock(hdev);
> > +
> > +       list_for_each_entry(conn, &hdev->conn_hash.list, list) {
> > +               if (test_bit(HCI_CONN_BIG_SYNC, &conn->flags))
> > +                       hci_disconn_cfm(conn, HCI_ERROR_REMOTE_USER_TER=
M);
> > +       }
>
> Let's start with the obvious problems:
>
> 1. This does not use the handle, instead it disconnects all the
> connections with HCI_CONN_BIG_SYNC
> 2. It doesn't use the reason either
> 3. hci_disconnect_cfm should be followed with hci_conn_del to free the hc=
i_conn
>
> So this does tell me you don't fully understand what you are doing, I
> hope I am not dealing with some AI generated code otherwise I would
> just do it myself.

Btw, the spec does says the controller shall cleanup the connection
handle and data path:

When the HCI_LE_BIG_Sync_Lost event occurs, the Controller shall
remove the connection handle(s) and data paths of all BIS(s) in the
BIG with which the Controller was synchronized.

I wonder if that shall be interpreted as no HCI_Disconnection_Complete
shall be generated or what, also we might need to implement this into
BlueZ emulator in order to replicate this in our CI tests.

It seems we are not sending anything to the remote devices when
receiving BT_HCI_CMD_LE_BIG_TERM_SYNC:

https://github.com/bluez/bluez/blob/master/emulator/btdev.c#L6661

> > +       hci_dev_unlock(hdev);
> > +}
> > +
> >  static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void =
*data,
> >                                            struct sk_buff *skb)
> >  {
> > @@ -7149,6 +7167,11 @@ static const struct hci_le_ev {
> >                      hci_le_big_sync_established_evt,
> >                      sizeof(struct hci_evt_le_big_sync_estabilished),
> >                      HCI_MAX_EVENT_SIZE),
> > +       /* [0x1e =3D HCI_EVT_LE_BIG_SYNC_LOST] */
> > +       HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
> > +                    hci_le_big_sync_lost_evt,
> > +                    sizeof(struct hci_evt_le_big_sync_lost),
> > +                    HCI_MAX_EVENT_SIZE),
> >         /* [0x22 =3D HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
> >         HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
> >                      hci_le_big_info_adv_report_evt,
> >
> > ---
> > base-commit: bd35cd12d915bc410c721ba28afcada16f0ebd16
> > change-id: 20250612-handle_big_sync_lost_event-4c7dc64390a2
> >
> > Best regards,
> > --
> > Yang Li <yang.li@amlogic.com>
> >
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

