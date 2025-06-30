Return-Path: <netdev+bounces-202646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F052AAEE76D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 21:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094443BE031
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3072E28E571;
	Mon, 30 Jun 2025 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp4dGBuS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6C928F514;
	Mon, 30 Jun 2025 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311462; cv=none; b=FWGnZ7MdaF0goGW+6WRpU8uF9EWaHaAYtWjjeigH+hiogfwjAZrqf82t5ruu8ulnE37OTReGRua2wJg+IkSVSGy7FfAmPu2tto0CVs2gnMcqm8cDuJ8Hh5JVaqkWX5P5/i0lvKjtXsOE9MMyUTHt3UlmdanDZ++6wc6qqGoGWjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311462; c=relaxed/simple;
	bh=hgJGruXRln0HIU1QewagyaTXUW8ytMVv5FSc58v3gk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6mp1giIkWS99WLpnh2jl0vOG+YfeuITmfrWshBso1xAC9qtks4wnhN+s/cceODbXauCIK+71EOPOARQLfa3eK6xm5aTdSNUE/eq3l8ismJM+sDrVFPUko12SSgNGo4AT2jB2fBNWF30CiB2oMNNw1oIwt1RsHeQqgojdGBElLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp4dGBuS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32ac42bb4e4so21993031fa.0;
        Mon, 30 Jun 2025 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751311458; x=1751916258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3iXjTxlr7wRgS/7gvePRNwHH5SCq/n2+EMHRv3w9tw=;
        b=hp4dGBuSiruoppNF9DuyDEjwLFdD6twEA3HY6A6xQL0wS8gAe20otl+ncKXdJr87Pr
         NSUWagUj11Y7xkjM626wteWwnb7vUzqYEF/4slhwHHm5hb1COs9khx8NXtoEEuhkRApj
         IjXAdxJVTrKWQNhzEG1iBZY2icYw4Eeeewnen8kR/XY4icJEHh5Bo/Y/drvjGHjC1aNe
         nZw7s9yskMD2JnVMYQixXuY50ie7rGLsvRqO+aWvVMXBOGlLFzATAZMrZWxXGglR6QIK
         OEmlog8iVqG6OMSQr3xzbF5M0aam2QIsuFiSVQPgCw7vqITpllvoi5PDksWhwAkO1mP5
         sGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751311458; x=1751916258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3iXjTxlr7wRgS/7gvePRNwHH5SCq/n2+EMHRv3w9tw=;
        b=XdJDD99Y38fO3mbRcLAUQegqBESXGTrcV4mY0XUo7V53fFgRaYl1VOsTUgFeDuxl3E
         0ppiyqx2ZHsp1iWSePuSGL8AC8wLvmSqzQqoeG7zr+ka52EIx3pjjnvJiIPVW1ocu6W3
         ZOs6+LmEqQ/rApWHlut6Duu6IWYmuVHCMNME/YDhFzRz7nBvwOuzxzhE268QRNpnzJRD
         DVMBmEMOD1YMV8SgqI0aKpj4iUMPhKwQiC0HhrSg7Cgtzxa5OSFstHcMW6p3+VmMafvZ
         nFMfQaFtiz4iCCuokeiyUbLNlKRpW+Wp/RYwWBR8BfbeoxrBc363Fv+WjL2rwCG1nypy
         k3ig==
X-Forwarded-Encrypted: i=1; AJvYcCVBOMGeqWvoddi1UNwhrin8VyHE0/8bY623tXh1c8HcFapXNr62s6VkJ71gGTsU/YhkH/KIceCk@vger.kernel.org, AJvYcCWIQbhU69iCg8FAiv4EGd+xIjvYVg45mVw6BGrTPUheOanyKVwVhQ/KKV7MKhWKWFKajTCNnLXLMbUMfajf@vger.kernel.org, AJvYcCXzOTcFrYhoYU8BpL5el/ac+LxEX9uZydB9OxZWiw/Yaes3xh1f9sdFiyfIBZuZ2AK8kRjquan9zWqeZki9EW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xIpulYb19Rpz4nuW7JvpH06+RIOZuM3Pj/X8fE0U1yidEKeb
	GLPS9YPeDlWZPW8w02rJwi9zYw8C9Wi2Ug7UqZUIkkTLbNwbn54BvmeCJlF4c5H/y5nkTrVpsrj
	E1Sb/X1V6jyiDJDjvlS7NMcJFmUUmQu4=
X-Gm-Gg: ASbGnctu5BtdkaIS6aQUUrbR0gQQkPiOPoLjL+srW4s/hp9eCHLT9h8W0OGDLOGMv2Q
	aZz8FVkSb00R6zG/VmpIlflozx3R5x47upJNwQERUho+2snKbv6AICracMFGbkhjjkt+YhZnmB7
	jaZhDKmbxA8UMdbSBGQNVOnkY1ssloM92Au1OlXTT/AFQ7
X-Google-Smtp-Source: AGHT+IHnGmU+g8CW1VpOTSmBwexfp7kaHHdSDT+IQ7WxVBjgwQJF+0cMNvBk+wdrYs9n5iInkcIXpftXxRQioXwer7E=
X-Received: by 2002:a05:651c:4190:b0:32a:88a3:a98 with SMTP id
 38308e7fff4ca-32cdc50f025mr35560791fa.38.1751311457822; Mon, 30 Jun 2025
 12:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-handle_big_sync_lost_event-v3-1-a4cf5bf6ec82@amlogic.com>
In-Reply-To: <20250630-handle_big_sync_lost_event-v3-1-a4cf5bf6ec82@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Jun 2025 15:24:03 -0400
X-Gm-Features: Ac12FXyO2klQJe7tvwu1OmJf8ds4Pvpt3K3aJ0Cbaw2wuxlMkDYORr-4wEq5hhA
Message-ID: <CABBYNZ+eVbYr4+08-qCccV+2BpUibV7jA55jJti9+PFS_4L1yg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_event: Add support for handling LE BIG
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

On Mon, Jun 30, 2025 at 2:45=E2=80=AFAM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> When the BIS source stops, the controller sends an LE BIG Sync Lost
> event (subevent 0x1E). Currently, this event is not handled, causing
> the BIS stream to remain active in BlueZ and preventing recovery.
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v3:
> - Delete the PA sync connection separately.
> - Add state and role check when lookup BIS connections
> - Link to v2: https://lore.kernel.org/r/20250625-handle_big_sync_lost_eve=
nt-v2-1-81f163057a21@amlogic.com
>
> Changes in v2:
> - Matching the BIG handle is required when looking up a BIG connection.
> - Use ev->reason to determine the cause of disconnection.
> - Call hci_conn_del after hci_disconnect_cfm to remove the connection ent=
ry
> - Delete the big connection
> - Link to v1: https://lore.kernel.org/r/20250624-handle_big_sync_lost_eve=
nt-v1-1-c32ce37dd6a5@amlogic.com
> ---
>  include/net/bluetooth/hci.h      |  6 ++++++
>  include/net/bluetooth/hci_core.h | 16 ++++++++++++----
>  net/bluetooth/hci_conn.c         |  3 ++-
>  net/bluetooth/hci_event.c        | 39 ++++++++++++++++++++++++++++++++++=
++++-
>  4 files changed, 58 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 82cbd54443ac..48389a64accb 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
>         __le16  bis[];
>  } __packed;
>
> +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
> +struct hci_evt_le_big_sync_lost {
> +       __u8    handle;
> +       __u8    reason;
> +} __packed;
> +
>  #define HCI_EVT_LE_BIG_INFO_ADV_REPORT 0x22
>  struct hci_evt_le_big_info_adv_report {
>         __le16  sync_handle;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index a760f05fa3fb..5ab19d4fef93 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1340,7 +1340,8 @@ hci_conn_hash_lookup_big_sync_pend(struct hci_dev *=
hdev,
>  }
>
>  static inline struct hci_conn *
> -hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16=
 state)
> +hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,
> +                              __u16 state, __u8 role)
>  {
>         struct hci_conn_hash *h =3D &hdev->conn_hash;
>         struct hci_conn  *c;
> @@ -1348,9 +1349,16 @@ hci_conn_hash_lookup_big_state(struct hci_dev *hde=
v, __u8 handle,  __u16 state)
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(c, &h->list, list) {
> -               if (c->type !=3D BIS_LINK || bacmp(&c->dst, BDADDR_ANY) |=
|
> -                   c->state !=3D state)
> -                       continue;
> +               if (role =3D=3D HCI_ROLE_MASTER) {
> +                       if (c->type !=3D BIS_LINK || bacmp(&c->dst, BDADD=
R_ANY) ||
> +                               c->state !=3D state || c->role !=3D role)
> +                               continue;

We don't really need to compare the address anymore since we now have
dedicated types for CIS and BIS, Id probably fix that in a leading
patch since that should have been added as a Fixes to the commit that
introduced the separate types, I will send a fix for it just make sure
you rebase your tree on top of bluetooth-next.

> +               } else {
> +                       if (c->type !=3D BIS_LINK ||
> +                               c->state !=3D state ||
> +                               c->role !=3D role)
> +                               continue;
> +               }

Then all we need to do is add the role check.

>
>                 if (handle =3D=3D c->iso_qos.bcast.big) {
>                         rcu_read_unlock();
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 4f379184df5b..6bb1ab42db39 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2146,7 +2146,8 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev,=
 bdaddr_t *dst, __u8 sid,
>         struct hci_link *link;
>
>         /* Look for any BIS that is open for rebinding */
> -       conn =3D hci_conn_hash_lookup_big_state(hdev, qos->bcast.big, BT_=
OPEN);
> +       conn =3D hci_conn_hash_lookup_big_state(hdev, qos->bcast.big,
> +                                            BT_OPEN, HCI_ROLE_MASTER);
>         if (conn) {
>                 memcpy(qos, &conn->iso_qos, sizeof(*qos));
>                 conn->state =3D BT_CONNECTED;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 66052d6aaa1d..f3e3e4964677 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3903,6 +3903,8 @@ static u8 hci_cc_le_setup_iso_path(struct hci_dev *=
hdev, void *data,
>                 goto unlock;
>         }
>
> +       conn->state =3D BT_CONNECTED;
> +
>         switch (cp->direction) {
>         /* Input (Host to Controller) */
>         case 0x00:
> @@ -6913,7 +6915,7 @@ static void hci_le_create_big_complete_evt(struct h=
ci_dev *hdev, void *data,
>
>         /* Connect all BISes that are bound to the BIG */
>         while ((conn =3D hci_conn_hash_lookup_big_state(hdev, ev->handle,
> -                                                     BT_BOUND))) {
> +                                       BT_BOUND, HCI_ROLE_MASTER))) {
>                 if (ev->status) {
>                         hci_connect_cfm(conn, ev->status);
>                         hci_conn_del(conn);
> @@ -6968,6 +6970,7 @@ static void hci_le_big_sync_established_evt(struct =
hci_dev *hdev, void *data,
>         }
>
>         clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
> +       conn->state =3D BT_CONNECTED;

Wrong line, anyway I have fixed this upstream already so you need to rebase=
.

>         conn->num_bis =3D 0;
>         memset(conn->bis, 0, sizeof(conn->num_bis));
> @@ -7026,6 +7029,35 @@ static void hci_le_big_sync_established_evt(struct=
 hci_dev *hdev, void *data,
>         hci_dev_unlock(hdev);
>  }
>
> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
> +                                    struct sk_buff *skb)
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
> +                                               BT_CONNECTED, HCI_ROLE_SL=
AVE))) {
> +               clear_bit(HCI_CONN_BIG_SYNC, &bis->flags);
> +               hci_disconn_cfm(bis, ev->reason);
> +               hci_conn_del(bis);
> +       }
> +
> +       hci_dev_unlock(hdev);
> +}
> +
>  static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *d=
ata,
>                                            struct sk_buff *skb)
>  {
> @@ -7149,6 +7181,11 @@ static const struct hci_le_ev {
>                      hci_le_big_sync_established_evt,
>                      sizeof(struct hci_evt_le_big_sync_estabilished),
>                      HCI_MAX_EVENT_SIZE),
> +       /* [0x1e =3D HCI_EVT_LE_BIG_SYNC_LOST] */
> +       HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
> +                    hci_le_big_sync_lost_evt,
> +                    sizeof(struct hci_evt_le_big_sync_lost),
> +                    HCI_MAX_EVENT_SIZE),

After you fix the comments I do expect some code to introduce support
into our emulator and then add some test to iso-tester that causes the
test to generate HCI_EVT_LE_BIG_SYNC_LOST so we can confirm this is
working as intended.

>         /* [0x22 =3D HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
>         HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
>                      hci_le_big_info_adv_report_evt,
>
> ---
> base-commit: bd35cd12d915bc410c721ba28afcada16f0ebd16
> change-id: 20250612-handle_big_sync_lost_event-4c7dc64390a2
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>


--=20
Luiz Augusto von Dentz

