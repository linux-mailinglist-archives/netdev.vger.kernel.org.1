Return-Path: <netdev+bounces-201974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8565AEBAF9
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 17:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75914A6440
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BB42E8888;
	Fri, 27 Jun 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJWCIl5i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2259CA6F;
	Fri, 27 Jun 2025 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036620; cv=none; b=BEPF7suS354pq3vXB2bVcG08aej547riEaOG4JRw5wZltUrJGlN2wSQChjtKrXb226t/3daDogPP6s7hWEl9brL5cp0ReU90W8tPCYvfAnnS/Ngzr/wEojnMEEIFINOa6T8XYWq6jdKfSmr/2vxBVfJeRUy9obS0wvoGhLcJNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036620; c=relaxed/simple;
	bh=k2ZH7dpRiYyANE7zqbJJ1IJmJzuRlRwHkY+sJo2b05Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0ez7BgaRfI2YjtHFRn9ERdHIKLMst5oaDQtT1Jd3VlgvhUsz7GH39/7b6ZEAmEeO4cuLb1V36fuLTNNtdVj89dojsLr64anUu52YMrMKPPS1TF1MJDgvi0OkQy+k9K7Gj5sCSSk/wyWFAB8YR5JMac5gRwQkT/Np+yhsJQbJgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJWCIl5i; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b78b5aa39so23066231fa.1;
        Fri, 27 Jun 2025 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036614; x=1751641414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMiqeXr+4nS41bauhSbOXNsW/VhAIsL/CC0xrZ3a5VU=;
        b=kJWCIl5ihEvYu9RCVQSC6PF0Xx1e8fDPlR9thd7w55VRwCQHjSNFz1y9j1PXMztVH4
         qeIfdBKEHQ85g1n3ySa4LQZJP3pLgIZ6jrqGIULWHujoA417tRWO3quDaYCb/BAqsKPI
         KjmW9aV0Yol5DOx/urd33eGHZcrZ80kKai2xnzFrIWdjW3V/CAHZq6NVs9r8HC1tKAyF
         Zr5ebmx1iCo422QRSPhUN5muCo41QPnuy2wMiPGjJ3vAQ9EH96Tv47q+9NNWhmYzmogx
         8PfxRS/uKqSforeqd8q8w+bUZ+xx61ov7LWrWCFPoBRRRsuE2boJ/md504I7f6jLbm2J
         znBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036614; x=1751641414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMiqeXr+4nS41bauhSbOXNsW/VhAIsL/CC0xrZ3a5VU=;
        b=Wa2zXlFNsCA08wzaw144Tsa1z/GuO64ytg72ARvti+f3CYRCp+Gltj4EkWIyJRrChc
         tl4r2oKUTI/PLhx3bpWS2HtaM4HQkHL6dyayUVaKs8uSGvbxeGP+J2mCp8w5HR/+yi2g
         /GiI3vgmig+rgohOwjyUGknafaEgSA5dpj6qBgJs7T2DY6YULHmQliXyWDG7e1FSFoCK
         XpdSD7WRcPj3U7Ovijpl1F+3QY7YAoUxoVotwMNIYID/wkkvMJUhJAbYFKEwmCcZN73l
         N95Km5P4FJ/OdnjbjhKJ/daBEMnd4xp6Ztq2oMa/MRpjeyyiRsbsl7+vO2RXD7vMVaMq
         F8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXJJN6dgQUnZ8QITttmfnI2+wv45eZ8NGovjy15rZi6OvCpTiEa6UUtHFgO0tfBaJX2fgPp1ACj5CsSnNxK@vger.kernel.org, AJvYcCXk2Ala7iUwaaaRw7Z6K9NUcqRihqLjmXCRQmuh5EG01UPAKe+/sRSsFfB4XNj6OjdczX8gVm4iq4YUnkiejlM=@vger.kernel.org, AJvYcCXwUOqW7V3I3ZJI+Pn+eipSI74NVFDfWw1Fek3r98D0NaVCjlwBYkM+Fvp39u+bVAn3F4iWmbKp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2YN9he/OIpkZj8bCBiOt8b1Sz0UIMdYAGHtaX8zAw7eXRHqE8
	Ze1thg8rSrYNBpbYbnWaYBgSA+skH8aEBYPuKw8x67MmIPWUuflGPsy8p8Sy2q+Bc1OmYXxZbrs
	Y+olKVYFb/4AMFtbBzhyrI/G39MhG3jw1V8V7ORo=
X-Gm-Gg: ASbGncsRx+ZlcfWn+XO+g11ppiTNXbaWi3tW3yL7Y7ajuefGlB0qDRu8oU0N14fHq1o
	dkQY2ehxDTLeN8vQA5OEDZAn9GdFVnp9zXY6TW/MjzY91dqm1B6MKXxuT57ZwoKz0YDT92BlIT+
	litVTDcVYyh4jOd3xxmObvy6WM3XngU5yp49e+lU8N/Q==
X-Google-Smtp-Source: AGHT+IEH1p0UvPn8YYIutya5ceBVuO5F0NMGl8ciGBbx6h6QCibpaR1rZvYCYYi5Slg74AI4DRcitXxdYChIWYMtA/o=
X-Received: by 2002:a05:651c:41c5:20b0:32a:6aa0:2173 with SMTP id
 38308e7fff4ca-32cdc517e8amr8003791fa.20.1751036613367; Fri, 27 Jun 2025
 08:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625-handle_big_sync_lost_event-v2-1-81f163057a21@amlogic.com>
 <1306a61f39fd92565d1e292517154aa3009dbd11.camel@iki.fi> <1842c694-045e-4014-9521-e95718f32037@amlogic.com>
 <CABBYNZJYeYdggm7WEoz4iPM5UAp3F-BOTrL2yTcTfSrgSnQ2ww@mail.gmail.com> <312a1cc3-bf55-443e-baad-fd35fede40c8@amlogic.com>
In-Reply-To: <312a1cc3-bf55-443e-baad-fd35fede40c8@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 27 Jun 2025 11:03:20 -0400
X-Gm-Features: Ac12FXzXQPablLsQ67nvY_6PYFNCjNjwbEsaQTj3hseCdtWpFxTrWfrCWHsnBS4
Message-ID: <CABBYNZJu-LY1kBQCa6cMJyxMQ2PU8PGT-B_qgy56quZAFSjChg@mail.gmail.com>
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

Hi,

On Fri, Jun 27, 2025 at 7:31=E2=80=AFAM Yang Li <yang.li@amlogic.com> wrote=
:
>
> Hi Luiz,
> > [ EXTERNAL EMAIL ]
> >
> > Hi Yang,
> >
> > On Thu, Jun 26, 2025 at 1:54=E2=80=AFAM Yang Li <yang.li@amlogic.com> w=
rote:
> >> Hi Pauli,
> >>> [ EXTERNAL EMAIL ]
> >>>
> >>> Hi,
> >>>
> >>> ke, 2025-06-25 kello 16:42 +0800, Yang Li via B4 Relay kirjoitti:
> >>>> From: Yang Li <yang.li@amlogic.com>
> >>>>
> >>>> When the BIS source stops, the controller sends an LE BIG Sync Lost
> >>>> event (subevent 0x1E). Currently, this event is not handled, causing
> >>>> the BIS stream to remain active in BlueZ and preventing recovery.
> >>>>
> >>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
> >>>> ---
> >>>> Changes in v2:
> >>>> - Matching the BIG handle is required when looking up a BIG connecti=
on.
> >>>> - Use ev->reason to determine the cause of disconnection.
> >>>> - Call hci_conn_del after hci_disconnect_cfm to remove the connectio=
n entry
> >>>> - Delete the big connection
> >>>> - Link to v1: https://lore.kernel.org/r/20250624-handle_big_sync_los=
t_event-v1-1-c32ce37dd6a5@amlogic.com
> >>>> ---
> >>>>    include/net/bluetooth/hci.h |  6 ++++++
> >>>>    net/bluetooth/hci_event.c   | 31 +++++++++++++++++++++++++++++++
> >>>>    2 files changed, 37 insertions(+)
> >>>>
> >>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci=
.h
> >>>> index 82cbd54443ac..48389a64accb 100644
> >>>> --- a/include/net/bluetooth/hci.h
> >>>> +++ b/include/net/bluetooth/hci.h
> >>>> @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
> >>>>         __le16  bis[];
> >>>>    } __packed;
> >>>>
> >>>> +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
> >>>> +struct hci_evt_le_big_sync_lost {
> >>>> +     __u8    handle;
> >>>> +     __u8    reason;
> >>>> +} __packed;
> >>>> +
> >>>>    #define HCI_EVT_LE_BIG_INFO_ADV_REPORT       0x22
> >>>>    struct hci_evt_le_big_info_adv_report {
> >>>>         __le16  sync_handle;
> >>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >>>> index 66052d6aaa1d..d0b9c8dca891 100644
> >>>> --- a/net/bluetooth/hci_event.c
> >>>> +++ b/net/bluetooth/hci_event.c
> >>>> @@ -7026,6 +7026,32 @@ static void hci_le_big_sync_established_evt(s=
truct hci_dev *hdev, void *data,
> >>>>         hci_dev_unlock(hdev);
> >>>>    }
> >>>>
> >>>> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *da=
ta,
> >>>> +                                         struct sk_buff *skb)
> >>>> +{
> >>>> +     struct hci_evt_le_big_sync_lost *ev =3D data;
> >>>> +     struct hci_conn *bis, *conn;
> >>>> +
> >>>> +     bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
> >>>> +
> >>>> +     hci_dev_lock(hdev);
> >>>> +
> >>>> +     list_for_each_entry(bis, &hdev->conn_hash.list, list) {
> >>> This should check bis->type =3D=3D BIS_LINK too.
> >> Will do.
> >>>> +             if (test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags)=
 &&
> >>>> +                 (bis->iso_qos.bcast.big =3D=3D ev->handle)) {
> >>>> +                     hci_disconn_cfm(bis, ev->reason);
> >>>> +                     hci_conn_del(bis);
> >>>> +
> >>>> +                     /* Delete the big connection */
> >>>> +                     conn =3D hci_conn_hash_lookup_pa_sync_handle(h=
dev, bis->sync_handle);
> >>>> +                     if (conn)
> >>>> +                             hci_conn_del(conn);
> >>> Problems:
> >>>
> >>> - use after free
> >>>
> >>> - hci_conn_del() cannot be used inside list_for_each_entry()
> >>>     of the connection list
> >>>
> >>> - also list_for_each_entry_safe() allows deleting only the iteration
> >>>     cursor, so some restructuring above is needed
> >> Following your suggestion, I updated the hci_le_big_sync_lost_evt func=
tion.
> >>
> >> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data=
,
> >> +                                           struct sk_buff *skb)
> >> +{
> >> +       struct hci_evt_le_big_sync_lost *ev =3D data;
> >> +       struct hci_conn *bis, *conn, *n;
> >> +
> >> +       bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
> >> +
> >> +       hci_dev_lock(hdev);
> >> +
> >> +       /* Delete the pa sync connection */
> >> +       bis =3D hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->hand=
le);
> >> +       if (bis) {
> >> +               conn =3D hci_conn_hash_lookup_pa_sync_handle(hdev,
> >> bis->sync_handle);
> >> +               if (conn)
> >> +                       hci_conn_del(conn);
> >> +       }
> >> +
> >> +       /* Delete each bis connection */
> >> +       list_for_each_entry_safe(bis, n, &hdev->conn_hash.list, list) =
{
> >> +               if (bis->type =3D=3D BIS_LINK &&
> >> +                   bis->iso_qos.bcast.big =3D=3D ev->handle &&
> >> +                   test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags)=
) {
> >> +                       hci_disconn_cfm(bis, ev->reason);
> >> +                       hci_conn_del(bis);
> >> +               }
> >> +       }
> > Id follow the logic in hci_le_create_big_complete_evt, so you do someth=
ing like:
> >
> >      while ((conn =3D hci_conn_hash_lookup_big_state(hdev, ev->handle,
> >                                BT_CONNECTED)))...
> >
> > That way we don't operate on the list cursor, that said we may need to
> > add the role as parameter to hci_conn_hash_lookup_big_state, because
> > the BIG id domain is role specific so we can have clashes if there are
> > Broadcast Sources using the same BIG id the above would return them as
> > well and even if we check for the role inside the while loop will keep
> > returning it forever.
>
> I updated the patch according to your suggestion; however, during testing=
, it resulted in a system panic.

What is the backtrace?

> hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 =
state)
>
>          list_for_each_entry_rcu(c, &h->list, list) {
>                  if (c->type !=3D BIS_LINK || bacmp(&c->dst, BDADDR_ANY) =
||
> +                       c->role !=3D HCI_ROLE_SLAVE ||
>                      c->state !=3D state)
>                          continue;

It needs to be passed as an argument not just change the role
internally otherwise it will break the existing users of it.

> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
> +                                           struct sk_buff *skb)
> +{
> +       struct hci_evt_le_big_sync_lost *ev =3D data;
> +       struct hci_conn *bis, *conn;
> +
> +       bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
> +
> +       hci_dev_lock(hdev);
> +
> +       /* Delete the pa sync connection */
> +       bis =3D hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->handle)=
;
> +       if (bis) {
> +               conn =3D hci_conn_hash_lookup_pa_sync_handle(hdev, bis->s=
ync_handle);
> +               if (conn)
> +                       hci_conn_del(conn);
> +       }
> +
> +       /* Delete each bis connection */
> +       while ((bis =3D hci_conn_hash_lookup_big_state(hdev, ev->handle,
> +                                                       BT_CONNECTED))) {
> +               clear_bit(HCI_CONN_BIG_SYNC, &bis->flags);
> +               hci_disconn_cfm(bis, ev->reason);
> +               hci_conn_del(bis);
> +       }
> +
> +       hci_dev_unlock(hdev);
> +}
>
> However, during testing, I encountered some issues:
>
> 1. The current BIS connections all have the state BT_OPEN (2).

Hmm, that doesn't sound right, if the BIG Sync has been completed the
BIS connection shall be moved to BT_CONNECTED. Looks like we are not
marking it as connected:

hci_le_big_sync_established_evt (Broadcast Sink):

        set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
       hci_iso_setup_path(bis);

hci_le_create_big_complete_evt (Broadcast Source):

        conn->state =3D BT_CONNECTED;
        set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
        hci_debugfs_create_conn(conn);
        hci_conn_add_sysfs(conn);
        hci_iso_setup_path(conn);

> [  131.813237][1 T1967  d.] list conn 00000000fd2e0fb2, handle 0x0010,
> state 1 #LE link
> [  131.813439][1 T1967  d.] list conn 00000000553bfedc, handle 0x0f01,
> state 2  #PA link
> [  131.814301][1 T1967  d.] list conn 0000000074213ccb, handle 0x0100,
> state 2 #bis1 link
> [  131.815167][1 T1967  d.] list conn 00000000ee6adb18, handle 0x0101,
> state 2 #bis2 link
>
> 2. hci_conn_hash_lookup_big_state() fails to find the corresponding BIS
> connection even when the state is set to OPEN.
>
> Therefore, I=E2=80=99m considering reverting to the original patch, but a=
dding a
> role check as an additional condition.
> What do you think?
>
> +       /* Delete each bis connection */
> +       list_for_each_entry_safe(bis, n, &hdev->conn_hash.list, list) {
> +               if (bis->type =3D=3D BIS_LINK &&
> +                   bis->role =3D=3D HCI_ROLE_SLAVE &&
> +                   bis->iso_qos.bcast.big =3D=3D ev->handle &&
> +                   test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags)) {
> +                       hci_disconn_cfm(bis, ev->reason);
> +                       hci_conn_del(bis);
> +               }
> +       }
>
> >
> >> +
> >> +       hci_dev_unlock(hdev);
> >> +}
> >>
> >>>> +             }
> >>>> +     }
> >>>> +
> >>>> +     hci_dev_unlock(hdev);
> >>>> +}
> >>>> +
> >>>>    static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, =
void *data,
> >>>>                                            struct sk_buff *skb)
> >>>>    {
> >>>> @@ -7149,6 +7175,11 @@ static const struct hci_le_ev {
> >>>>                      hci_le_big_sync_established_evt,
> >>>>                      sizeof(struct hci_evt_le_big_sync_estabilished)=
,
> >>>>                      HCI_MAX_EVENT_SIZE),
> >>>> +     /* [0x1e =3D HCI_EVT_LE_BIG_SYNC_LOST] */
> >>>> +     HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
> >>>> +                  hci_le_big_sync_lost_evt,
> >>>> +                  sizeof(struct hci_evt_le_big_sync_lost),
> >>>> +                  HCI_MAX_EVENT_SIZE),
> >>>>         /* [0x22 =3D HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
> >>>>         HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
> >>>>                      hci_le_big_info_adv_report_evt,
> >>>>
> >>>> ---
> >>>> base-commit: bd35cd12d915bc410c721ba28afcada16f0ebd16
> >>>> change-id: 20250612-handle_big_sync_lost_event-4c7dc64390a2
> >>>>
> >>>> Best regards,
> >>> --
> >>> Pauli Virtanen
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

