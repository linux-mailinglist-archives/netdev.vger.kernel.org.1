Return-Path: <netdev+bounces-200774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1ABAE6D14
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F993A6B17
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780BD2E2F0F;
	Tue, 24 Jun 2025 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXonvqAg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63FA4C74;
	Tue, 24 Jun 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784218; cv=none; b=Yh0y4aON/FiYbRJmugC81iLe5NU6/DIKsjHL15npois9FJV28f4ITqoEYHKhKMBbfZ109StK3ioXBQ/WpTboOQMOYysGd9cGaKZ9JalNDHThnV+Ha53Ilu1zzklKmv9lJ8kDL+pvSQDwWPvZX1l5NA2nlAI5OLW8/Z+396h2e1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784218; c=relaxed/simple;
	bh=AgHRWFWxIx9KUKW4HrV9Ys8bNutvq7sqr84rBYc0Nbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBuBvueUXB05f0pindx7yXxzRVW2y42tUVSElHFb2a8vg6gu6clJd3pApHBlgSObMFXw0JYwKGcFDEvlQ+Joe9XTAJ2UjJjNoB37yC9m/RLyTtwKUbfa4J+xsk0Om3OqAMkt0m7DhpbXthMFelQx46s8UE72ais8PNWeEjwYEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXonvqAg; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b910593edso5983531fa.1;
        Tue, 24 Jun 2025 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750784215; x=1751389015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VoQhHpan+D63Bosvv29YyZ4TMwKoS/MmYILKEYS0J4=;
        b=RXonvqAgYCTCKoXHlPhOKNPVAuUZVsq5zg7JKlnOJL5HB7HNFLSfDCt0NyB1jF7xMK
         ieUD9PXFhPee+WRZT8XtFBG0RgsJVg3NPzSDfM/dFTQQULCP0zSeoOb9whEvoi0hq8kU
         8pbiDObOwh3jPHr8uVNH3L63i74vQ2DoJ/etMAeZvCzyE/0az5NrvCdii0UcTTMc1yj9
         E2uLMLCoO+AROF6roohmwFlQiTbsjK5FODqlnDZPjYMmm/bzYksAxB72xn08GyC7KrhT
         Te2ykYFEb6oxrX4VIlkUgfYmijeCTY5BCmICZZ5LeuUVXkQrgcVY6v9/rO8Q73CX8IkY
         jkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750784215; x=1751389015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VoQhHpan+D63Bosvv29YyZ4TMwKoS/MmYILKEYS0J4=;
        b=EOoFcNIz5FWCzOcl5iy6RUcwCAt/2+Lbn7Ti+ACHnjW1QjOpLZptzfKEMLXaH9WiKS
         OOk/Nm42wK7963q2HOrHCF+cc2kEbMhQiNX9UkWSjs+FJScMDQe1mFe43+uBh1TPlSEg
         S5mtUu4eCIUOQKs3ZJwRB2gkDqibzYTwm1YoUlAYGK86ip9d6N1KP6TIqPQkRgfxog6Y
         bcfHil35rGeWHvKjE/btJ6UTdSCLpKhrUdp9FXvx0Ni+C4eP5N/zaeHV9ovK1cQHdnnJ
         p8qJPNep8cRbum3i0I1evKFB2l0zZ6OQ78xApYwCSVxYuzstfbjSmIyJu0uDJiYSjQhM
         hbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWKpdMd4ZRTKMBWsKMxO6u5moNKr2zlbGzC2LOcq7OUps1ArS3f54YOsOrn0bV3Hf9yEowUNyL@vger.kernel.org, AJvYcCXe2iDiNlQY02r0r/WMhjfRTZNY782lePG30zLEgwynBY3TraqalD65ov+ej4BqBmDt54D2p+mmAQwzHQdST60=@vger.kernel.org, AJvYcCXxFAX7axo4B6ueitXGwR/tEIt/6PymgtSAI33UG35hietuF3j87XUCzQ1+KNojqmCRw9vwFnIFEAbBZpO7@vger.kernel.org
X-Gm-Message-State: AOJu0YyeuG5ZFImxkC6jzeZh6N/oQBiaMj9nMmZ1YPwSAgxn/mUIYUwN
	QFCkta6a+Uf16vvAF+3rw5memprPpZ/6lBMA2eZptXqmVxPChaC2ehTbrLwhdXS/yOHWddtyIBY
	C0MtvPuvE46UqzIT/0VVic+yLW7wWIIw=
X-Gm-Gg: ASbGncs3VQVWKBBj+pfE+u5+vczS/NSwYehEtG7bTIAjGEOLzVmjmQ4jEwBQlGjSvcx
	kdnewkaS0KfUlESTzjcoqubanh7k6MOOmAh7Uz8m4TVJdILXQcWgIbbJ0gjKZlVxa0hI0dXF0vQ
	98hKkac4880wdjxLxRUkMQ5Kc+3AmeEIyOEE4cf0QUBA==
X-Google-Smtp-Source: AGHT+IF9tlG/Gv4Lk4VPNnSQdf0XriXwGuTEEIpNivagx5btkou/+ZjKG+079WltVHyDDGPW391ut8kUgJSDubGtay4=
X-Received: by 2002:a05:651c:1a0a:b0:30b:b987:b6a7 with SMTP id
 38308e7fff4ca-32b98d274cdmr49886061fa.0.1750784214368; Tue, 24 Jun 2025
 09:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com>
In-Reply-To: <20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Jun 2025 12:56:42 -0400
X-Gm-Features: Ac12FXwfD8-7gKRlIL52DwzZvy4dFplbLmxCSBpOC3BkWgzU9Tbie0wrLyB5g3Q
Message-ID: <CABBYNZKhTOWGXRWe5EYP0Mp3ynO5TmV-zgE43AVmNgm-=01gbg@mail.gmail.com>
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

On Tue, Jun 24, 2025 at 1:20=E2=80=AFAM Yang Li via B4 Relay
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
>  include/net/bluetooth/hci.h |  6 ++++++
>  net/bluetooth/hci_event.c   | 23 +++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
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
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 66052d6aaa1d..730deaf1851f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -7026,6 +7026,24 @@ static void hci_le_big_sync_established_evt(struct=
 hci_dev *hdev, void *data,
>         hci_dev_unlock(hdev);
>  }
>
> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
> +                                           struct sk_buff *skb)
> +{
> +       struct hci_evt_le_big_sync_lost *ev =3D data;
> +       struct hci_conn *conn;
> +
> +       bt_dev_dbg(hdev, "BIG Sync Lost: big_handle 0x%2.2x", ev->handle)=
;
> +
> +       hci_dev_lock(hdev);
> +
> +       list_for_each_entry(conn, &hdev->conn_hash.list, list) {
> +               if (test_bit(HCI_CONN_BIG_SYNC, &conn->flags))
> +                       hci_disconn_cfm(conn, HCI_ERROR_REMOTE_USER_TERM)=
;
> +       }

Let's start with the obvious problems:

1. This does not use the handle, instead it disconnects all the
connections with HCI_CONN_BIG_SYNC
2. It doesn't use the reason either
3. hci_disconnect_cfm should be followed with hci_conn_del to free the hci_=
conn

So this does tell me you don't fully understand what you are doing, I
hope I am not dealing with some AI generated code otherwise I would
just do it myself.

> +       hci_dev_unlock(hdev);
> +}
> +
>  static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *d=
ata,
>                                            struct sk_buff *skb)
>  {
> @@ -7149,6 +7167,11 @@ static const struct hci_le_ev {
>                      hci_le_big_sync_established_evt,
>                      sizeof(struct hci_evt_le_big_sync_estabilished),
>                      HCI_MAX_EVENT_SIZE),
> +       /* [0x1e =3D HCI_EVT_LE_BIG_SYNC_LOST] */
> +       HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
> +                    hci_le_big_sync_lost_evt,
> +                    sizeof(struct hci_evt_le_big_sync_lost),
> +                    HCI_MAX_EVENT_SIZE),
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

