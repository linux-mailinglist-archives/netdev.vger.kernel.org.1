Return-Path: <netdev+bounces-152242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391DF9F3346
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618FF16219B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED57204092;
	Mon, 16 Dec 2024 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEbQl3ps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68321DDE9;
	Mon, 16 Dec 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359590; cv=none; b=Njml/R0d+Cz3U2gdR5VVUXOjOKvxGla8lvBPW6avRDMer2hA+J/E0wKbMU8Z40w/b4EccdSD+MBBg/h1wVw81EL0U9QqJf1b3aX5D3NYn+b73BBsdyOKcM+CanIg7gVEPwjL57KTQSOSNkfbOTOvxGyYLwJAloG+WCSXDutEjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359590; c=relaxed/simple;
	bh=8xMQSMajVdEloFdHjNjiGT8ocden+NeG4pG+oObPpxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Se5FoGjCNfaZxiePeQmzXyqZPzkEKpgR1F09EhIO6SCZtpnixuYzStocbQrJODetwGKRnK7JNwg0FyqV8ArXUiDA7ILLArRXQIAPkeukzmB19L3Niw0LpwhEofr4+L2fLLqYZ/LxdTSSMVgLsm6XKsu2e2gUSWb/z6hOhB1AkcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEbQl3ps; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53e3778bffdso4412754e87.0;
        Mon, 16 Dec 2024 06:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734359587; x=1734964387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcGJusMROs1d9U6OcF/dUgFih+81cOor/KxZG4XJKuc=;
        b=aEbQl3psbb8Tp2lwTDGB7rEoDiwmoHQrIFjMuTzxBaksj8/oG/OyZV/j6NiSDvgpfN
         OpoBh1ShtoTs+3gRMN3w4eX3HN9CFaZjg4BimsLK1WR9nQTtIO70BtbWts6p0rzUa+li
         KIq6FhOfqUbicGn6e/QvvIfEUubexDfQ9Go0GDLRBOqy7cM65RmDmS8kkHnqJS4wjzPV
         QEFN2aQLvNQumxOooFyyndb2IBxkhd65BpD/ZQdDyeeGEmjpRd7rVFDs023NZDOuU++7
         hONgmEhUqUkK9FCvTiuUZ/u6q1+p6HHEc4VjrHytk5PzVf6LMHgL8u4uwTIWDLqjRmPk
         KNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734359587; x=1734964387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcGJusMROs1d9U6OcF/dUgFih+81cOor/KxZG4XJKuc=;
        b=H60btENafmSO4TIDaHiJUS4FGYSCYJiovgtmUEb9Yp1bXsyID7ltIyREpPUNCMMs6H
         UrlF6GnsTWEvI2W1PCF3Oq3ZrRNvsgJsz+j7p98BGZFK8NlHpnstEUmnQiIrhJTokUUN
         +N4My77Ssd+BlPjDQqnKXKG+VJz/Cd270kZMyoV/pxPESbmd17YtavRMoUxxs5UxQihg
         JrfUh00m1PEQmCiR0ulb3k2HGlEnv3J+PCTk0YvTE4cyvSEhygFcGMtHYA2e1MrDX5Ay
         kge9QjvgZGu54cxdLMz33EPAj7/dWGjjPaus0764AUesHeyldi88ttn51SWkLGgvQT7x
         8zlg==
X-Forwarded-Encrypted: i=1; AJvYcCU16G9GXMkeEiNwe7EwlMHltibJSXoAGdRflYVxeHFQiFtzrQIkBDh0f+rcXlHJWCOciKHJs4OI@vger.kernel.org, AJvYcCW9yMtJGIg4KZ7duIW8s6nKhZ06JRvCsUqF7eUnpub9lOIVIP1mp5DqLVY1/fv/Pm3d7ADOwrn9W8iomJ2cX9s=@vger.kernel.org, AJvYcCWAqlUlGxfXVuxIAgfCdYng8SjFk9tTXRrzmsTEk+nP3sXKIqfyk1OzhrxqO098BluIYsu+cCpkXUPM4CJb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7gbypabxdszfYiZCzeQeluuJglDRwKpanpHIvjQKpuMCEZq5N
	5nRu3Wda/kVsg0WYLwyeWS/OYzXDQeDsJUAyrEe/kuzt0elEyxOzJCGDEvPJtMlgb52P1d4D1v8
	31hHUqWpL7R+R1H5HCreYb6F9Lm3wnmdy
X-Gm-Gg: ASbGncujnBcp+vYl0RaI/rSKNZBFyAh2sBxXl22wdyhvb9UFqLzSr4OphyHBnx27B9M
	INit/8zV4naWEecSMKWxbH/iXI5zjrQKtMNwi
X-Google-Smtp-Source: AGHT+IELpcpoOMr0HZIYsbPkHXhRImQ+VIsxUYWZmevTZLApJPoAOQq0DMX0ucJCu/DDTc7ZaIih4Z12yiHzp+r6PE8=
X-Received: by 2002:a05:6512:39c8:b0:540:1b7e:7b4a with SMTP id
 2adb3069b0e04-540905955d7mr4268744e87.36.1734359586622; Mon, 16 Dec 2024
 06:33:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216080758.3450976-1-quic_chejiang@quicinc.com>
In-Reply-To: <20241216080758.3450976-1-quic_chejiang@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Dec 2024 09:32:53 -0500
Message-ID: <CABBYNZLRdu_f9eNEapPp5mNqgcUE0jby5VPpaMaArY_FjyjB8Q@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix disconnect complete event
 timeout issue
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_jiaymao@quicinc.com, 
	quic_shuaz@quicinc.com, quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng,

On Mon, Dec 16, 2024 at 3:08=E2=80=AFAM Cheng Jiang <quic_chejiang@quicinc.=
com> wrote:
>
> Sometimes, the remote device doesn't acknowledge the LL_TERMINATE_IND
> in time, requiring the controller to wait for the supervision timeout,
> which may exceed 2 seconds. In the current implementation, the
> HCI_EV_DISCONN_COMPLETE event is ignored if it arrives late, since
> the hci_abort_conn_sync has cleaned up the connection after 2 seconds.
> This causes the mgmt to get stuck, resulting in bluetoothd waiting
> indefinitely for the mgmt response to the disconnect. To recover,
> restarting bluetoothd is necessary.
>
> bluetoothctl log like this:
> [Designer Mouse]# disconnect D9:B5:6C:F2:51:91
> Attempting to disconnect from D9:B5:6C:F2:51:91
> [Designer Mouse]#
> [Designer Mouse]# power off
> [Designer Mouse]#
> Failed to set power off: org.freedesktop.DBus.Error.NoReply.
>
> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> ---
>  include/net/bluetooth/hci_core.h |  2 ++
>  net/bluetooth/hci_conn.c         |  9 +++++++++
>  net/bluetooth/hci_event.c        |  9 +++++++++
>  net/bluetooth/hci_sync.c         | 18 ++++++++++++++++++
>  4 files changed, 38 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 734cd50cd..2ab079dcf 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -753,6 +753,8 @@ struct hci_conn {
>
>         struct bt_codec codec;
>
> +       struct completion disc_ev_comp;
> +
>         void (*connect_cfm_cb)  (struct hci_conn *conn, u8 status);
>         void (*security_cfm_cb) (struct hci_conn *conn, u8 status);
>         void (*disconn_cfm_cb)  (struct hci_conn *conn, u8 reason);
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index d097e308a..e0244e191 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1028,6 +1028,15 @@ static struct hci_conn *__hci_conn_add(struct hci_=
dev *hdev, int type, bdaddr_t
>
>         hci_conn_init_sysfs(conn);
>
> +       /* This disc_ev_comp is inited when we send a disconnect request =
to
> +        * the remote device but fail to receive the disconnect complete
> +        * event within the expected time (2 seconds). This occurs becaus=
e
> +        * the remote device doesn't ack the terminate indication, forcin=
g
> +        * the controller to wait for the supervision timeout.
> +        */
> +       init_completion(&conn->disc_ev_comp);
> +       complete(&conn->disc_ev_comp);
> +
>         return conn;
>  }
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 2cc7a9306..60ecb2b18 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3366,6 +3366,15 @@ static void hci_disconn_complete_evt(struct hci_de=
v *hdev, void *data,
>         if (!conn)
>                 goto unlock;
>
> +       /* Wake up disc_ev_comp here is ok. Since we hold the hdev lock
> +        * hci_abort_conn_sync will wait hdev lock release to continue.
> +        */
> +       if (!completion_done(&conn->disc_ev_comp)) {
> +               complete(&conn->disc_ev_comp);
> +               /* Add some delay for hci_abort_conn_sync to handle the c=
omplete */
> +               usleep_range(100, 1000);
> +       }
> +
>         if (ev->status) {
>                 mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
>                                        conn->dst_type, ev->status);
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 0badec712..783d04b57 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5590,6 +5590,24 @@ int hci_abort_conn_sync(struct hci_dev *hdev, stru=
ct hci_conn *conn, u8 reason)
>                 break;
>         }
>
> +       /* Check whether the connection is successfully disconnected.
> +        * Sometimes the remote device doesn't acknowledge the
> +        * LL_TERMINATE_IND in time, requiring the controller to wait
> +        * for the supervision timeout, which may exceed 2 seconds. In
> +        * this case, we need to wait for the HCI_EV_DISCONN_COMPLETE
> +        * event before cleaning up the connection.
> +        */
> +       if (err =3D=3D -ETIMEDOUT) {
> +               u32 idle_delay =3D msecs_to_jiffies(10 * conn->le_supv_ti=
meout);
> +
> +               reinit_completion(&conn->disc_ev_comp);
> +               if (!wait_for_completion_timeout(&conn->disc_ev_comp, idl=
e_delay)) {
> +                       bt_dev_warn(hdev, "Failed to get complete");
> +                       mgmt_disconnect_failed(hdev, &conn->dst, conn->ty=
pe,
> +                                              conn->dst_type, conn->abor=
t_reason);
> +               }
> +       }

Why don't we just set the supervision timeout as timeout then? If we
will have to wait for it anyway just change hci_disconnect_sync to use
10 * conn->le_supv_timeout as timeout instead.

That said, we really need to fix bluetoothd if it is not able to be
cleaned up if SET_POWERED command fails, but it looks like it is
handling errors correctly so it sounds like something else is at play.

>         hci_dev_lock(hdev);
>
>         /* Check if the connection has been cleaned up concurrently */
>
> base-commit: e25c8d66f6786300b680866c0e0139981273feba
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

