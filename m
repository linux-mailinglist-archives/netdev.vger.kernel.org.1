Return-Path: <netdev+bounces-201561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A746AE9E61
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8648A3AE93F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E296A2E540F;
	Thu, 26 Jun 2025 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP/sruRc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023CFBA53;
	Thu, 26 Jun 2025 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943696; cv=none; b=usMRzCRQRbaJLOy4Uudv7CY/zYb0gonnRTYV3BGZ5XCA8kBjaEYF+MItgR39/jmWvDSKBaqdBETDXq3Ybx8yO4ef2cnHY+SQ6fraK5dl9FMgGdrI6fhTGY7Rhgp1id3URXAnFQLgMezRzcyMHcVR0GZZMrv4KQB3Y02ZAffe58Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943696; c=relaxed/simple;
	bh=1CEaKdy1TOG3I9LzmMkTnI5kzN0ZIN0cpolnrxRYvOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXB/8Ox9lHPC27+oaFS4SZ6yAxd2SDDJArAnwIAalezf1CX1ZCGUbii2LrsKTG1BP7yTI0uEyaEzJF28x3Tf/aaWz49ll0kbUCzXTb0Z6ioIF/txZrlHTg4u8Eqqh03sWWZL6IqHxbH8qh3gEs3+WJigGEo8XGoCOalD8Pe5iiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nP/sruRc; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32ade3723adso10387291fa.0;
        Thu, 26 Jun 2025 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750943693; x=1751548493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lnf8dy7gqziu3el989oNu2CQe5RMJbnDd94a6NU/JI=;
        b=nP/sruRc2aXgC0JdCnspy1WocPkNMawYDIXHviUO4f3kSLfgrb32pswfeACrzVEAWD
         Ex19oxFZCWRnwpMg2Ac5hBrqat5yX1NcF8BUInOpT9D2Wtl9ukLEoa+J/0YwGwvb9YRH
         fp6GOKoJNDPuXEv2xBCVPo10joXkSfQwhORX2yi164AdOZ2ojqAjaDQwHCvxBiW5piDa
         36iE7DJ5z+6UID1zQNrgomrN2hoQ20jRsVheQB6i+6KeeZ/KxES+GyG/zjAog22w2FV+
         Csu8a4f1IKuhNraFmuT0GkP3cP1Cnqc5/SEZxJ2J19UlOaVBVgE1YgtoXVkYhtFlNgi3
         bblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750943693; x=1751548493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lnf8dy7gqziu3el989oNu2CQe5RMJbnDd94a6NU/JI=;
        b=ZMqGjKwssbGerV7D3wWJvBb9hAZpSHNdhNZ30JPG9rrhZ8/bXGh7vfSABf9HIrTFLr
         UxndAYBbXmgltViKAN7yNMMw4lvuDvT7lAMqVwedgid4LcQJq0v/AWTIvTpFkH0jFZud
         XdZpINJBzkQrl36ooOZQfjo9aMeHXrKZ/PzxhyIxXKml4KWZJS31JLpkEabKvbq2Qc48
         OJGLczhMPZkOUsq/ZHwOvSU+qvWItisXQHEKe3zxOnG7dsdHHtpWuAqGN588Fvy1lnDM
         pQOjsYz59C+I9nGcbY3yv3bak4iO5AL6N3LT+SVgjaL7Mxmvihm4hrSBiFf9YfBNZEDc
         mDCg==
X-Forwarded-Encrypted: i=1; AJvYcCUEDy4zmWGYsMqttaqi0WDrdMtn7+WiOr1AUS8UUndAsFwE9HTRxDtQjhE9F/PFAtZNelBQWtMWDW1tHV3l@vger.kernel.org, AJvYcCVKNrURyXp0DqVSP6wc6JNO7NCl3rSAWY73akJjcffLp2PAb+xz8M3vV9qBhg7aizhaxWdYqBiTS2MC0q0rBgo=@vger.kernel.org, AJvYcCVqSAzbQYlaGgg83TePRBemDO2jeMBfQ5dGw/49kMqnDyrwl35+Atea4GjMyIC+qOS1pW95xgT0@vger.kernel.org
X-Gm-Message-State: AOJu0YxwlyrzIcvRTm/wxZ7fn0CE4hRBPGx9Fs91fUZsutQqReS4vu5v
	0mjGWwDSfHXoX6DoHzlrZJs49VbR5NAy/lVQK8jjC3IC2uvar87/EH+O5E4bgosp13U04yXYtWF
	zn0yWehqCjd9TxnSQjl5WUsHbnbpgcbI=
X-Gm-Gg: ASbGncvVMbbVURJyFo19Rux0yw5tm3690dTmBOBHhwQuZRCcM6yGUyaGQh32X1pp7tT
	xYJIpeRVqHTCQdFz/Yw/NLw4FYCJLp1JHln/rOej9UmCmCkY8Lwo95mOccw6N3CXmuBECzfTddD
	XgZnVB5ssQE3KOS7rrXZ1kSZvVKIP2vU70B7oV7ygtFg==
X-Google-Smtp-Source: AGHT+IGE8RpqcSJalWopzSPMD6gmtxmQMZZk8w6T2SLCJ0icJVZoYy+rFvK8hokg31uZA75ITTysdg/W64MRaXJYPtc=
X-Received: by 2002:a2e:b754:0:b0:32b:47be:e1a5 with SMTP id
 38308e7fff4ca-32cc65c1285mr14373901fa.39.1750943692808; Thu, 26 Jun 2025
 06:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625-handle_big_sync_lost_event-v2-1-81f163057a21@amlogic.com>
 <1306a61f39fd92565d1e292517154aa3009dbd11.camel@iki.fi> <1842c694-045e-4014-9521-e95718f32037@amlogic.com>
In-Reply-To: <1842c694-045e-4014-9521-e95718f32037@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Jun 2025 09:14:40 -0400
X-Gm-Features: Ac12FXyiFO_dBm7V7r6zYY31bmSDmDlgXR2PMhxLYRZlfXCNtBk2c9BYbH8_4KU
Message-ID: <CABBYNZJYeYdggm7WEoz4iPM5UAp3F-BOTrL2yTcTfSrgSnQ2ww@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_event: Add support for handling LE BIG
 Sync Lost event
To: Yang Li <yang.li@amlogic.com>
Cc: Pauli Virtanen <pav@iki.fi>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Thu, Jun 26, 2025 at 1:54=E2=80=AFAM Yang Li <yang.li@amlogic.com> wrote=
:
>
> Hi Pauli,
> > [ EXTERNAL EMAIL ]
> >
> > Hi,
> >
> > ke, 2025-06-25 kello 16:42 +0800, Yang Li via B4 Relay kirjoitti:
> >> From: Yang Li <yang.li@amlogic.com>
> >>
> >> When the BIS source stops, the controller sends an LE BIG Sync Lost
> >> event (subevent 0x1E). Currently, this event is not handled, causing
> >> the BIS stream to remain active in BlueZ and preventing recovery.
> >>
> >> Signed-off-by: Yang Li <yang.li@amlogic.com>
> >> ---
> >> Changes in v2:
> >> - Matching the BIG handle is required when looking up a BIG connection=
.
> >> - Use ev->reason to determine the cause of disconnection.
> >> - Call hci_conn_del after hci_disconnect_cfm to remove the connection =
entry
> >> - Delete the big connection
> >> - Link to v1: https://lore.kernel.org/r/20250624-handle_big_sync_lost_=
event-v1-1-c32ce37dd6a5@amlogic.com
> >> ---
> >>   include/net/bluetooth/hci.h |  6 ++++++
> >>   net/bluetooth/hci_event.c   | 31 +++++++++++++++++++++++++++++++
> >>   2 files changed, 37 insertions(+)
> >>
> >> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> >> index 82cbd54443ac..48389a64accb 100644
> >> --- a/include/net/bluetooth/hci.h
> >> +++ b/include/net/bluetooth/hci.h
> >> @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
> >>        __le16  bis[];
> >>   } __packed;
> >>
> >> +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
> >> +struct hci_evt_le_big_sync_lost {
> >> +     __u8    handle;
> >> +     __u8    reason;
> >> +} __packed;
> >> +
> >>   #define HCI_EVT_LE_BIG_INFO_ADV_REPORT       0x22
> >>   struct hci_evt_le_big_info_adv_report {
> >>        __le16  sync_handle;
> >> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >> index 66052d6aaa1d..d0b9c8dca891 100644
> >> --- a/net/bluetooth/hci_event.c
> >> +++ b/net/bluetooth/hci_event.c
> >> @@ -7026,6 +7026,32 @@ static void hci_le_big_sync_established_evt(str=
uct hci_dev *hdev, void *data,
> >>        hci_dev_unlock(hdev);
> >>   }
> >>
> >> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data=
,
> >> +                                         struct sk_buff *skb)
> >> +{
> >> +     struct hci_evt_le_big_sync_lost *ev =3D data;
> >> +     struct hci_conn *bis, *conn;
> >> +
> >> +     bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
> >> +
> >> +     hci_dev_lock(hdev);
> >> +
> >> +     list_for_each_entry(bis, &hdev->conn_hash.list, list) {
> > This should check bis->type =3D=3D BIS_LINK too.
> Will do.
> >
> >> +             if (test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags) &=
&
> >> +                 (bis->iso_qos.bcast.big =3D=3D ev->handle)) {
> >> +                     hci_disconn_cfm(bis, ev->reason);
> >> +                     hci_conn_del(bis);
> >> +
> >> +                     /* Delete the big connection */
> >> +                     conn =3D hci_conn_hash_lookup_pa_sync_handle(hde=
v, bis->sync_handle);
> >> +                     if (conn)
> >> +                             hci_conn_del(conn);
> > Problems:
> >
> > - use after free
> >
> > - hci_conn_del() cannot be used inside list_for_each_entry()
> >    of the connection list
> >
> > - also list_for_each_entry_safe() allows deleting only the iteration
> >    cursor, so some restructuring above is needed
>
> Following your suggestion, I updated the hci_le_big_sync_lost_evt functio=
n.
>
> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
> +                                           struct sk_buff *skb)
> +{
> +       struct hci_evt_le_big_sync_lost *ev =3D data;
> +       struct hci_conn *bis, *conn, *n;
> +
> +       bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
> +
> +       hci_dev_lock(hdev);
> +
> +       /* Delete the pa sync connection */
> +       bis =3D hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->handle)=
;
> +       if (bis) {
> +               conn =3D hci_conn_hash_lookup_pa_sync_handle(hdev,
> bis->sync_handle);
> +               if (conn)
> +                       hci_conn_del(conn);
> +       }
> +
> +       /* Delete each bis connection */
> +       list_for_each_entry_safe(bis, n, &hdev->conn_hash.list, list) {
> +               if (bis->type =3D=3D BIS_LINK &&
> +                   bis->iso_qos.bcast.big =3D=3D ev->handle &&
> +                   test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags)) {
> +                       hci_disconn_cfm(bis, ev->reason);
> +                       hci_conn_del(bis);
> +               }
> +       }

Id follow the logic in hci_le_create_big_complete_evt, so you do something =
like:

    while ((conn =3D hci_conn_hash_lookup_big_state(hdev, ev->handle,
                              BT_CONNECTED)))...

That way we don't operate on the list cursor, that said we may need to
add the role as parameter to hci_conn_hash_lookup_big_state, because
the BIG id domain is role specific so we can have clashes if there are
Broadcast Sources using the same BIG id the above would return them as
well and even if we check for the role inside the while loop will keep
returning it forever.

> +
> +       hci_dev_unlock(hdev);
> +}
>
> >
> >> +             }
> >> +     }
> >> +
> >> +     hci_dev_unlock(hdev);
> >> +}
> >> +
> >>   static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, voi=
d *data,
> >>                                           struct sk_buff *skb)
> >>   {
> >> @@ -7149,6 +7175,11 @@ static const struct hci_le_ev {
> >>                     hci_le_big_sync_established_evt,
> >>                     sizeof(struct hci_evt_le_big_sync_estabilished),
> >>                     HCI_MAX_EVENT_SIZE),
> >> +     /* [0x1e =3D HCI_EVT_LE_BIG_SYNC_LOST] */
> >> +     HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
> >> +                  hci_le_big_sync_lost_evt,
> >> +                  sizeof(struct hci_evt_le_big_sync_lost),
> >> +                  HCI_MAX_EVENT_SIZE),
> >>        /* [0x22 =3D HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
> >>        HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
> >>                     hci_le_big_info_adv_report_evt,
> >>
> >> ---
> >> base-commit: bd35cd12d915bc410c721ba28afcada16f0ebd16
> >> change-id: 20250612-handle_big_sync_lost_event-4c7dc64390a2
> >>
> >> Best regards,
> > --
> > Pauli Virtanen



--=20
Luiz Augusto von Dentz

