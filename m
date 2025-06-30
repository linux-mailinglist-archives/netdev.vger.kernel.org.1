Return-Path: <netdev+bounces-202434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EDBAEDEC8
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A38C188166D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A52148850;
	Mon, 30 Jun 2025 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU5gWg65"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACC51CA84;
	Mon, 30 Jun 2025 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289421; cv=none; b=Y39OKLT+lEgSwZ+A7i5/9Xd1zjmyVaIW6xJxZBAzeHPgLh5sJrLXNDr5045V1Wim+2EjuPdfJf+GvPHvjayyL7nlKjc4PbhgC9B4lao4ko/wub67CmLHYrUm5caMBrg6mAOUGoJI/d9R+gEAq1tCeV6l68tslsc8YJI6BGJElW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289421; c=relaxed/simple;
	bh=yn9mLE0idjEt7iWU6ZybaCqJqoHhTQtY902q4jfHEmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9cOctYIxryZ7z8PDoNgwug3s/m23z662pI84Tj0OA62SP7ewmzsgHtAJMeF7rmacqSId1RNAQd34OIPZldPT/ZNUERF9o3xqHk5DtSMpTYsNzvmA2VjxYQJkjSzWF2ZUzpzPaYZMgDyRk67HopV0O220zm8HQEaCX8QrYLMQfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU5gWg65; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b4876dfecso51561081fa.1;
        Mon, 30 Jun 2025 06:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751289416; x=1751894216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wsGBAomzjNcEfdABu2y6WPn9Ln3RqBcR9gn0wE3fUw=;
        b=KU5gWg65WmLz8L0eYyaSZtQGTUf8e+ubDUDKyVGXl+ETb+/+Lxyj/P55AQ7cRppekb
         tkvu7C4aUoS7q956fW+qG3BsSm/tGXv941KUrHTOYiVZIj7/2+CGR/4CmI6mXmp4fpXU
         V44MBPthhcadOWwCbL7Cisj3WbG3vVsZHbKPLIn0vb/ttVCNe4+CpdPLWyPiWbVTqIqC
         qeq0OhQLrtEygRvX+RfDzjS/t6fI+AqXEeCBWueo2iq3XkQOUCCdJotBEw071K32KI78
         hn/aQtorZ4qMJ3JiKhii5dbMJ3c08bcqmASOjOccDYvNW+IhAPD2kzs8keqXOcnekIPX
         wNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751289416; x=1751894216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wsGBAomzjNcEfdABu2y6WPn9Ln3RqBcR9gn0wE3fUw=;
        b=TOVzE7/SKkGE2Uenwa8tLFBocS5ETUeH+zRrzzrMVdBA/cy3L3MrD/Aehii87Wn5kf
         wnCakkbEUUzRrZfkHHR3WI3Ziw/+xqXd6BIAanFDKJ2e/QZT1ZNonxP1WL5pzbW6/GRY
         jFGApJ22l5MjxMLJ2EpXjdiQsVYEHQUHRsos4Er5gJulJwRVsb/nyxFbYiahqEVGBdeB
         SV/vB0+AnsbVqiV9UKLyLOvNLkisqMteSuBFybOGDY9fAeZ9v997bUgn06mjg/aSiz8a
         iZZxNf/6SDY6CvbzuQ4XX/FiBIiiRkLoH5jipsCsUryu9xAngCNOoIsjuwHQpu9ByNuX
         cGsA==
X-Forwarded-Encrypted: i=1; AJvYcCVIYKzwXQQSo4ZF9lZdb4/2W5vBgwHo+YGg2GRgdsTUHgrI9StoZSo8WqqseTTy7/xJ/L42zlzEAf1wAtx6@vger.kernel.org, AJvYcCWXIJsXgD7P8JM9fW0gB784dvNO+4LcGhngTxoskymFydpPmco0o1Fo3k+FEPxtyXzIt5vLYxHH@vger.kernel.org, AJvYcCXr+f6D2pPloHzy5bOkBaYf6M2MU0xRDNemZLmiCZdoyMZLZQ68Y6048vnHdceKSOqiwo2hAxYXBz2pFQlHlS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEpuOAnDcDLlfu9Nw8FlJGQz8nURNRpuM7+XfPVMzMdCqEgtga
	9HnEZOQgKYB7wdlhL+nRwH/fFSOpNX2XSO0I28CcSdCHB8+s23oHF1W33q7w5rQFm0FrkJU7Cv6
	Gjr4wMXn15vsP3BE++v+NmOWUCkhci+U=
X-Gm-Gg: ASbGncsQ2dgoCPxFBTCLzwCOdPYzFHH1962mPxDNogM9prHfd99L/Bp862q8JJ+v1ws
	fSHeX1XBcniZQ0wp2Sz6FBiAobhwPR7d8yxYK1qCOEsGB5tEATzs4xfdV02+xc32U3iZjAPXKjw
	C2O82Vd5HJH7L8Wj+fGvq6rLLYN9fMfrLT3IcFMEJh/5OqPOdH9YUO
X-Google-Smtp-Source: AGHT+IHqfrVrXjAmxTwPAB2MERp3GBklfRdsTgjaQs/AFCkdE3CkTwnnHiu26810eLpCjQcbX41neMSggFC8FpSJF5w=
X-Received: by 2002:a2e:a4b8:0:b0:329:1550:1446 with SMTP id
 38308e7fff4ca-32cd007663bmr38314581fa.0.1751289415953; Mon, 30 Jun 2025
 06:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625-handle_big_sync_lost_event-v2-1-81f163057a21@amlogic.com>
 <1306a61f39fd92565d1e292517154aa3009dbd11.camel@iki.fi> <1842c694-045e-4014-9521-e95718f32037@amlogic.com>
 <CABBYNZJYeYdggm7WEoz4iPM5UAp3F-BOTrL2yTcTfSrgSnQ2ww@mail.gmail.com>
 <312a1cc3-bf55-443e-baad-fd35fede40c8@amlogic.com> <CABBYNZJu-LY1kBQCa6cMJyxMQ2PU8PGT-B_qgy56quZAFSjChg@mail.gmail.com>
 <45469157-ff75-4c4f-953e-09ec6b399071@amlogic.com>
In-Reply-To: <45469157-ff75-4c4f-953e-09ec6b399071@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Jun 2025 09:16:43 -0400
X-Gm-Features: Ac12FXwQgFMalu4oplE6JZRfJbfZ2yMDNTR_9GRO6kTGNc5r5AwJwwkpTiKpVKw
Message-ID: <CABBYNZKBDiftD_C6LHYpWxrduHe-jNYJp=y+AZo1xXreec1O-g@mail.gmail.com>
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

On Mon, Jun 30, 2025 at 2:15=E2=80=AFAM Yang Li <yang.li@amlogic.com> wrote=
:
>
> Hi,
> > [ EXTERNAL EMAIL ]
> >
> > Hi,
> >
> > On Fri, Jun 27, 2025 at 7:31=E2=80=AFAM Yang Li <yang.li@amlogic.com> w=
rote:
> >> Hi Luiz,
> >>> [ EXTERNAL EMAIL ]
> >>>
> >>> Hi Yang,
> >>>
> >>> On Thu, Jun 26, 2025 at 1:54=E2=80=AFAM Yang Li <yang.li@amlogic.com>=
 wrote:
> >>>> Hi Pauli,
> >>>>> [ EXTERNAL EMAIL ]
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> ke, 2025-06-25 kello 16:42 +0800, Yang Li via B4 Relay kirjoitti:
> >>>>>> From: Yang Li <yang.li@amlogic.com>
> >>>>>>
> >>>>>> When the BIS source stops, the controller sends an LE BIG Sync Los=
t
> >>>>>> event (subevent 0x1E). Currently, this event is not handled, causi=
ng
> >>>>>> the BIS stream to remain active in BlueZ and preventing recovery.
> >>>>>>
> >>>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
> >>>>>> ---
> >>>>>> Changes in v2:
> >>>>>> - Matching the BIG handle is required when looking up a BIG connec=
tion.
> >>>>>> - Use ev->reason to determine the cause of disconnection.
> >>>>>> - Call hci_conn_del after hci_disconnect_cfm to remove the connect=
ion entry
> >>>>>> - Delete the big connection
> >>>>>> - Link to v1: https://lore.kernel.org/r/20250624-handle_big_sync_l=
ost_event-v1-1-c32ce37dd6a5@amlogic.com
> >>>>>> ---
> >>>>>>     include/net/bluetooth/hci.h |  6 ++++++
> >>>>>>     net/bluetooth/hci_event.c   | 31 +++++++++++++++++++++++++++++=
++
> >>>>>>     2 files changed, 37 insertions(+)
> >>>>>>
> >>>>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/h=
ci.h
> >>>>>> index 82cbd54443ac..48389a64accb 100644
> >>>>>> --- a/include/net/bluetooth/hci.h
> >>>>>> +++ b/include/net/bluetooth/hci.h
> >>>>>> @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
> >>>>>>          __le16  bis[];
> >>>>>>     } __packed;
> >>>>>>
> >>>>>> +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
> >>>>>> +struct hci_evt_le_big_sync_lost {
> >>>>>> +     __u8    handle;
> >>>>>> +     __u8    reason;
> >>>>>> +} __packed;
> >>>>>> +
> >>>>>>     #define HCI_EVT_LE_BIG_INFO_ADV_REPORT       0x22
> >>>>>>     struct hci_evt_le_big_info_adv_report {
> >>>>>>          __le16  sync_handle;
> >>>>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >>>>>> index 66052d6aaa1d..d0b9c8dca891 100644
> >>>>>> --- a/net/bluetooth/hci_event.c
> >>>>>> +++ b/net/bluetooth/hci_event.c
> >>>>>> @@ -7026,6 +7026,32 @@ static void hci_le_big_sync_established_evt=
(struct hci_dev *hdev, void *data,
> >>>>>>          hci_dev_unlock(hdev);
> >>>>>>     }
> >>>>>>
> >>>>>> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *=
data,
> >>>>>> +                                         struct sk_buff *skb)
> >>>>>> +{
> >>>>>> +     struct hci_evt_le_big_sync_lost *ev =3D data;
> >>>>>> +     struct hci_conn *bis, *conn;
> >>>>>> +
> >>>>>> +     bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
> >>>>>> +
> >>>>>> +     hci_dev_lock(hdev);
> >>>>>> +
> >>>>>> +     list_for_each_entry(bis, &hdev->conn_hash.list, list) {
> >>>>> This should check bis->type =3D=3D BIS_LINK too.
> >>>> Will do.
> >>>>>> +             if (test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flag=
s) &&
> >>>>>> +                 (bis->iso_qos.bcast.big =3D=3D ev->handle)) {
> >>>>>> +                     hci_disconn_cfm(bis, ev->reason);
> >>>>>> +                     hci_conn_del(bis);
> >>>>>> +
> >>>>>> +                     /* Delete the big connection */
> >>>>>> +                     conn =3D hci_conn_hash_lookup_pa_sync_handle=
(hdev, bis->sync_handle);
> >>>>>> +                     if (conn)
> >>>>>> +                             hci_conn_del(conn);
> >>>>> Problems:
> >>>>>
> >>>>> - use after free
> >>>>>
> >>>>> - hci_conn_del() cannot be used inside list_for_each_entry()
> >>>>>      of the connection list
> >>>>>
> >>>>> - also list_for_each_entry_safe() allows deleting only the iteratio=
n
> >>>>>      cursor, so some restructuring above is needed
> >>>> Following your suggestion, I updated the hci_le_big_sync_lost_evt fu=
nction.
> >>>>
> >>>> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *da=
ta,
> >>>> +                                           struct sk_buff *skb)
> >>>> +{
> >>>> +       struct hci_evt_le_big_sync_lost *ev =3D data;
> >>>> +       struct hci_conn *bis, *conn, *n;
> >>>> +
> >>>> +       bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
> >>>> +
> >>>> +       hci_dev_lock(hdev);
> >>>> +
> >>>> +       /* Delete the pa sync connection */
> >>>> +       bis =3D hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->ha=
ndle);
> >>>> +       if (bis) {
> >>>> +               conn =3D hci_conn_hash_lookup_pa_sync_handle(hdev,
> >>>> bis->sync_handle);
> >>>> +               if (conn)
> >>>> +                       hci_conn_del(conn);
> >>>> +       }
> >>>> +
> >>>> +       /* Delete each bis connection */
> >>>> +       list_for_each_entry_safe(bis, n, &hdev->conn_hash.list, list=
) {
> >>>> +               if (bis->type =3D=3D BIS_LINK &&
> >>>> +                   bis->iso_qos.bcast.big =3D=3D ev->handle &&
> >>>> +                   test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flag=
s)) {
> >>>> +                       hci_disconn_cfm(bis, ev->reason);
> >>>> +                       hci_conn_del(bis);
> >>>> +               }
> >>>> +       }
> >>> Id follow the logic in hci_le_create_big_complete_evt, so you do some=
thing like:
> >>>
> >>>       while ((conn =3D hci_conn_hash_lookup_big_state(hdev, ev->handl=
e,
> >>>                                 BT_CONNECTED)))...
> >>>
> >>> That way we don't operate on the list cursor, that said we may need t=
o
> >>> add the role as parameter to hci_conn_hash_lookup_big_state, because
> >>> the BIG id domain is role specific so we can have clashes if there ar=
e
> >>> Broadcast Sources using the same BIG id the above would return them a=
s
> >>> well and even if we check for the role inside the while loop will kee=
p
> >>> returning it forever.
> >> I updated the patch according to your suggestion; however, during test=
ing, it resulted in a system panic.
> > What is the backtrace?
> >
> >> hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u=
16 state)
> >>
> >>           list_for_each_entry_rcu(c, &h->list, list) {
> >>                   if (c->type !=3D BIS_LINK || bacmp(&c->dst, BDADDR_A=
NY) ||
> >> +                       c->role !=3D HCI_ROLE_SLAVE ||
> >>                       c->state !=3D state)
> >>                           continue;
> > It needs to be passed as an argument not just change the role
> > internally otherwise it will break the existing users of it.
>
> After testing, I found that the dst addr of the two BIS connections
> under BIG sync is the address of the BIS source, so I added separate
> checks for MASTER and SLAVE roles.
>
> [  268.202466][1 T1962  d.] lookup big: 00000000736585c7, addr
> 21:97:07:b1:9f:66, type 131, handle 0x0100, state 1, role 1
> [  268.203806][1 T1962  d.] lookup big: 0000000041894659, addr
> 21:97:07:b1:9f:66, type 131, handle 0x0101, state 1, role 1
>
> I updated as below,
>
> -hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,
> __u16 state)
> +hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,
> +                                                 __u16 state, __u8 role)
>   {
>          struct hci_conn_hash *h =3D &hdev->conn_hash;
>          struct hci_conn  *c;
> @@ -1335,10 +1336,18 @@ hci_conn_hash_lookup_big_state(struct hci_dev
> *hdev, __u8 handle,  __u16 state)
>          rcu_read_lock();
>
>          list_for_each_entry_rcu(c, &h->list, list) {
> -               if (c->type !=3D BIS_LINK || bacmp(&c->dst, BDADDR_ANY) |=
|
> -                       c->role !=3D HCI_ROLE_SLAVE ||
> -                   c->state !=3D state)
> -                       continue;
> +               if (role =3D=3D HCI_ROLE_MASTER) {
> +                       if (c->type !=3D BIS_LINK || bacmp(&c->dst,
> BDADDR_ANY) ||
> +                               c->state !=3D state || c->role !=3D role)
> +                               continue;
> +               } else {
> +                       if (c->type !=3D BIS_LINK ||
> +                               c->state !=3D state ||
> +                               c->role !=3D role)
> +                               continue;
> +               }
>
> >
> >> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data=
,
> >> +                                           struct sk_buff *skb)
> >> +{
> >> +       struct hci_evt_le_big_sync_lost *ev =3D data;
> >> +       struct hci_conn *bis, *conn;
> >> +
> >> +       bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
> >> +
> >> +       hci_dev_lock(hdev);
> >> +
> >> +       /* Delete the pa sync connection */
> >> +       bis =3D hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->hand=
le);
> >> +       if (bis) {
> >> +               conn =3D hci_conn_hash_lookup_pa_sync_handle(hdev, bis=
->sync_handle);
> >> +               if (conn)
> >> +                       hci_conn_del(conn);
> >> +       }
> >> +
> >> +       /* Delete each bis connection */
> >> +       while ((bis =3D hci_conn_hash_lookup_big_state(hdev, ev->handl=
e,
> >> +                                                       BT_CONNECTED))=
) {
> >> +               clear_bit(HCI_CONN_BIG_SYNC, &bis->flags);
> >> +               hci_disconn_cfm(bis, ev->reason);
> >> +               hci_conn_del(bis);
> >> +       }
> >> +
> >> +       hci_dev_unlock(hdev);
> >> +}
> >>
> >> However, during testing, I encountered some issues:
> >>
> >> 1. The current BIS connections all have the state BT_OPEN (2).
> > Hmm, that doesn't sound right, if the BIG Sync has been completed the
> > BIS connection shall be moved to BT_CONNECTED. Looks like we are not
> > marking it as connected:
> >
> > hci_le_big_sync_established_evt (Broadcast Sink):
> >
> >          set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
> >         hci_iso_setup_path(bis);
> >
> > hci_le_create_big_complete_evt (Broadcast Source):
> >
> >          conn->state =3D BT_CONNECTED;
> >          set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
> >          hci_debugfs_create_conn(conn);
> >          hci_conn_add_sysfs(conn);
> >          hci_iso_setup_path(conn);
>
> Yes, in addition, state =3D BT_CONNECTED also needs to be set in
> hci_cc_le_setup_iso_path.
>
> I will update the patch again.
>
> @@ -3890,7 +3890,7 @@ static u8 hci_cc_le_setup_iso_path(struct hci_dev
> *hdev, void *data,
>                  hci_conn_del(conn);
>                  goto unlock;
>          }
> -
> +     conn->state =3D BT_CONNECTED;

Ive submitted a fix addressing this already:

https://patchwork.kernel.org/project/bluetooth/patch/20250627151902.421666-=
1-luiz.dentz@gmail.com/

> >> [  131.813237][1 T1967  d.] list conn 00000000fd2e0fb2, handle 0x0010,
> >> state 1 #LE link
> >> [  131.813439][1 T1967  d.] list conn 00000000553bfedc, handle 0x0f01,
> >> state 2  #PA link
> >> [  131.814301][1 T1967  d.] list conn 0000000074213ccb, handle 0x0100,
> >> state 2 #bis1 link
> >> [  131.815167][1 T1967  d.] list conn 00000000ee6adb18, handle 0x0101,
> >> state 2 #bis2 link
> >>
> >> 2. hci_conn_hash_lookup_big_state() fails to find the corresponding BI=
S
> >> connection even when the state is set to OPEN.
> >>
> >> Therefore, I=E2=80=99m considering reverting to the original patch, bu=
t adding a
> >> role check as an additional condition.
> >> What do you think?
> >>
> >> +       /* Delete each bis connection */
> >> +       list_for_each_entry_safe(bis, n, &hdev->conn_hash.list, list) =
{
> >> +               if (bis->type =3D=3D BIS_LINK &&
> >> +                   bis->role =3D=3D HCI_ROLE_SLAVE &&
> >> +                   bis->iso_qos.bcast.big =3D=3D ev->handle &&
> >> +                   test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags)=
) {
> >> +                       hci_disconn_cfm(bis, ev->reason);
> >> +                       hci_conn_del(bis);
> >> +               }
> >> +       }
> >>
> >>>> +
> >>>> +       hci_dev_unlock(hdev);
> >>>> +}
> >>>>
> >>>>>> +             }
> >>>>>> +     }
> >>>>>> +
> >>>>>> +     hci_dev_unlock(hdev);
> >>>>>> +}
> >>>>>> +
> >>>>>>     static void hci_le_big_info_adv_report_evt(struct hci_dev *hde=
v, void *data,
> >>>>>>                                             struct sk_buff *skb)
> >>>>>>     {
> >>>>>> @@ -7149,6 +7175,11 @@ static const struct hci_le_ev {
> >>>>>>                       hci_le_big_sync_established_evt,
> >>>>>>                       sizeof(struct hci_evt_le_big_sync_estabilish=
ed),
> >>>>>>                       HCI_MAX_EVENT_SIZE),
> >>>>>> +     /* [0x1e =3D HCI_EVT_LE_BIG_SYNC_LOST] */
> >>>>>> +     HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
> >>>>>> +                  hci_le_big_sync_lost_evt,
> >>>>>> +                  sizeof(struct hci_evt_le_big_sync_lost),
> >>>>>> +                  HCI_MAX_EVENT_SIZE),
> >>>>>>          /* [0x22 =3D HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
> >>>>>>          HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
> >>>>>>                       hci_le_big_info_adv_report_evt,
> >>>>>>
> >>>>>> ---
> >>>>>> base-commit: bd35cd12d915bc410c721ba28afcada16f0ebd16
> >>>>>> change-id: 20250612-handle_big_sync_lost_event-4c7dc64390a2
> >>>>>>
> >>>>>> Best regards,
> >>>>> --
> >>>>> Pauli Virtanen
> >>>
> >>> --
> >>> Luiz Augusto von Dentz
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

