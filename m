Return-Path: <netdev+bounces-152249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 986269F3368
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35BC1621B6
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D028205E01;
	Mon, 16 Dec 2024 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emG9PzO1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EA61DDEA;
	Mon, 16 Dec 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360196; cv=none; b=Y2KBERtIWQjnrjIrmMxznC44PlPqy4yzSR6fBFqyWJJwIU6SIYT9UZ+/ZQABt8+tRT/xdz38bKuoAmblX3H77o67x/dR1RQ4gEw1Nf7oZJvPlNhx4aXBURYGdwtOZ+M/VOahIxl4UxBgndkfy/YTcjiYjklikXGa/Ah8NDHEm2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360196; c=relaxed/simple;
	bh=ZKesCLAuKhoyuXC+NxSLvR/TFkhORrckFJ+JL5jsHMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhkZnLy+g8Pf1yV3H81KUaGNcyf/DAAVH4GltqGsb4xRQjibai3L5AK5FAwbaukoZmAqa3ue85/yogfWY78j3xbILlnz5IBx4vVEjpQq46PJSjlW07oK0WYgL/lopAICXuFKvAmhtb/iBqz25mWo6XBpWy8zaQCoIHqf58Upx68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emG9PzO1; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3011c7b39c7so45775011fa.1;
        Mon, 16 Dec 2024 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734360192; x=1734964992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pghn7pNnls8+Zm6tM5i0njJRynoVolOOk4wpphYelrM=;
        b=emG9PzO164uWmtDmiH5wiX1RZ/k5PtBrlxx/xvZqyB6OWWifamdTsiw7vpvwGEmbnT
         WZb5TmNX4BpnBKG54wBmVPBLrIMlE/S0l5Z2UO6wJATpsLzP5+fWU8ywCD/fF/TILig4
         DDIPiCssIiXNaH73g+JQRs4Wo9JalN/W0kku9gP/sfp0GT2qnVU+T8lC0qXKGmZMW+md
         s7DBHUcr9Da01EoKmPup6Hnd3K5WIpEwqJ0qdLlGzUIcAI6HJSfhz2E617bJ3FN8n2ZM
         iHCwiaxisU54LqebAlNIDrN4NaVCEqRiYVPdp9x/6v/SuQKjYlN8uYYQc16qAAkKkCof
         jxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734360192; x=1734964992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pghn7pNnls8+Zm6tM5i0njJRynoVolOOk4wpphYelrM=;
        b=eW/6NM8WQhbwrLZB1r1vv7r62BEd9J4NyoD7aKg/cVXFkl/JVoneAwaq7hg2Km2EX4
         8qr+ErAZoph1VPP8P4Mfh1+n9WaTgK92t65+T4g4awgILot/gGKx50+1kHinP9evzb3C
         xnZggorpyKO9D1INIWPE+XB/qIE6zBhV2ibjZ5T/J82te/1xqkL86BjTTNLwKQKGqZpN
         IedQb4TANX6ZR6XuMf8npjTy2QSI3KpAdy/Dfy9Ym6KkFAHa9p3kLb6ML2Xaz8hEY8jw
         tw2TDr1UrJoYdyGHX9H8GL8xFt/1x0oIb8I4UwrchaVGLY7KVily8P/HLQKctLw6DY98
         mn0w==
X-Forwarded-Encrypted: i=1; AJvYcCUVmOqUwgn20TIB5ACr43jBCWoDtpX3uoCpa+zRt2993wDXIfhn1UDSiWYdJMogZfQEs7c6xZXsbMmhpVU68r4=@vger.kernel.org, AJvYcCXTrmz1Sr3K9yRKxYpPBfxKK9fANSj5/tRjZtYqRZvXBbrpG/vjqWu1/FzJmRN4WWYoCqrnJ5vj@vger.kernel.org, AJvYcCXxvoDLWI9qk3w4I+p46Clwi7DkEv2gBnX594sC3uXvVvL3d7bHxHB7WZ2xAdLsRgTXifKizeYIiRhuhVqT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo+28z9ABjZyo2E4DmZV9ltReVUYspLQCLKdH4Q8Ylf+p/T6bK
	vQDm8azufHDDsksuADquBUm+sMy1HPGhNQTrb35OtFn4jpkY3YV2iZaKWnm+Fj2me6zpVpp0j5R
	sRD00xuQ9AtCIJ2PNuRkq45fmrYw=
X-Gm-Gg: ASbGncsGbYRmXzma3wRCKBPtQ50iqVbRXMu58L122VcvqK9alY+g7pIvWn92rIQXQWM
	SaJ4yZXHWQBgPoIk6zcYpZNaYmxkf+ZwOspVO
X-Google-Smtp-Source: AGHT+IFwEU6Xlgpmakn9f75/E1cHBZzjBBB+rsjk+CfC6Yvf5CRaFGglrJiuLvlU19TxYx0YW9oRu3vEUfRSodBRnzk=
X-Received: by 2002:a2e:a781:0:b0:302:4a4e:67da with SMTP id
 38308e7fff4ca-302545b94ddmr45520721fa.36.1734360191931; Mon, 16 Dec 2024
 06:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216080758.3450976-1-quic_chejiang@quicinc.com> <CABBYNZLRdu_f9eNEapPp5mNqgcUE0jby5VPpaMaArY_FjyjB8Q@mail.gmail.com>
In-Reply-To: <CABBYNZLRdu_f9eNEapPp5mNqgcUE0jby5VPpaMaArY_FjyjB8Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Dec 2024 09:42:58 -0500
Message-ID: <CABBYNZKPu20vHx3DMGXVobR_5t-WUgt-KX41+tA1Lrz+aDFY-Q@mail.gmail.com>
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

On Mon, Dec 16, 2024 at 9:32=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Cheng,
>
> On Mon, Dec 16, 2024 at 3:08=E2=80=AFAM Cheng Jiang <quic_chejiang@quicin=
c.com> wrote:
> >
> > Sometimes, the remote device doesn't acknowledge the LL_TERMINATE_IND
> > in time, requiring the controller to wait for the supervision timeout,
> > which may exceed 2 seconds. In the current implementation, the
> > HCI_EV_DISCONN_COMPLETE event is ignored if it arrives late, since
> > the hci_abort_conn_sync has cleaned up the connection after 2 seconds.
> > This causes the mgmt to get stuck, resulting in bluetoothd waiting
> > indefinitely for the mgmt response to the disconnect. To recover,
> > restarting bluetoothd is necessary.
> >
> > bluetoothctl log like this:
> > [Designer Mouse]# disconnect D9:B5:6C:F2:51:91
> > Attempting to disconnect from D9:B5:6C:F2:51:91
> > [Designer Mouse]#
> > [Designer Mouse]# power off
> > [Designer Mouse]#
> > Failed to set power off: org.freedesktop.DBus.Error.NoReply.
> >
> > Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> > ---
> >  include/net/bluetooth/hci_core.h |  2 ++
> >  net/bluetooth/hci_conn.c         |  9 +++++++++
> >  net/bluetooth/hci_event.c        |  9 +++++++++
> >  net/bluetooth/hci_sync.c         | 18 ++++++++++++++++++
> >  4 files changed, 38 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 734cd50cd..2ab079dcf 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -753,6 +753,8 @@ struct hci_conn {
> >
> >         struct bt_codec codec;
> >
> > +       struct completion disc_ev_comp;
> > +
> >         void (*connect_cfm_cb)  (struct hci_conn *conn, u8 status);
> >         void (*security_cfm_cb) (struct hci_conn *conn, u8 status);
> >         void (*disconn_cfm_cb)  (struct hci_conn *conn, u8 reason);
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index d097e308a..e0244e191 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1028,6 +1028,15 @@ static struct hci_conn *__hci_conn_add(struct hc=
i_dev *hdev, int type, bdaddr_t
> >
> >         hci_conn_init_sysfs(conn);
> >
> > +       /* This disc_ev_comp is inited when we send a disconnect reques=
t to
> > +        * the remote device but fail to receive the disconnect complet=
e
> > +        * event within the expected time (2 seconds). This occurs beca=
use
> > +        * the remote device doesn't ack the terminate indication, forc=
ing
> > +        * the controller to wait for the supervision timeout.
> > +        */
> > +       init_completion(&conn->disc_ev_comp);
> > +       complete(&conn->disc_ev_comp);
> > +
> >         return conn;
> >  }
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 2cc7a9306..60ecb2b18 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -3366,6 +3366,15 @@ static void hci_disconn_complete_evt(struct hci_=
dev *hdev, void *data,
> >         if (!conn)
> >                 goto unlock;
> >
> > +       /* Wake up disc_ev_comp here is ok. Since we hold the hdev lock
> > +        * hci_abort_conn_sync will wait hdev lock release to continue.
> > +        */
> > +       if (!completion_done(&conn->disc_ev_comp)) {
> > +               complete(&conn->disc_ev_comp);
> > +               /* Add some delay for hci_abort_conn_sync to handle the=
 complete */
> > +               usleep_range(100, 1000);
> > +       }
> > +
> >         if (ev->status) {
> >                 mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
> >                                        conn->dst_type, ev->status);
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 0badec712..783d04b57 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -5590,6 +5590,24 @@ int hci_abort_conn_sync(struct hci_dev *hdev, st=
ruct hci_conn *conn, u8 reason)
> >                 break;
> >         }
> >
> > +       /* Check whether the connection is successfully disconnected.
> > +        * Sometimes the remote device doesn't acknowledge the
> > +        * LL_TERMINATE_IND in time, requiring the controller to wait
> > +        * for the supervision timeout, which may exceed 2 seconds. In
> > +        * this case, we need to wait for the HCI_EV_DISCONN_COMPLETE
> > +        * event before cleaning up the connection.
> > +        */
> > +       if (err =3D=3D -ETIMEDOUT) {
> > +               u32 idle_delay =3D msecs_to_jiffies(10 * conn->le_supv_=
timeout);
> > +
> > +               reinit_completion(&conn->disc_ev_comp);
> > +               if (!wait_for_completion_timeout(&conn->disc_ev_comp, i=
dle_delay)) {
> > +                       bt_dev_warn(hdev, "Failed to get complete");
> > +                       mgmt_disconnect_failed(hdev, &conn->dst, conn->=
type,
> > +                                              conn->dst_type, conn->ab=
ort_reason);
> > +               }
> > +       }
>
> Why don't we just set the supervision timeout as timeout then? If we
> will have to wait for it anyway just change hci_disconnect_sync to use
> 10 * conn->le_supv_timeout as timeout instead.
>
> That said, we really need to fix bluetoothd if it is not able to be
> cleaned up if SET_POWERED command fails, but it looks like it is
> handling errors correctly so it sounds like something else is at play.

I double checked this and apparently this could no longer fail:

+               /* Disregard possible errors since hci_conn_del shall have =
been
+                * called even in case of errors had occurred since it woul=
d
+                * then cause hci_conn_failed to be called which calls
+                * hci_conn_del internally.
+                */
+               hci_abort_conn_sync(hdev, conn, reason);

So it will clean up the hci_conn no matter what is the timeout, so
either you don't have this change or it is not working for some
reason.

> >         hci_dev_lock(hdev);
> >
> >         /* Check if the connection has been cleaned up concurrently */
> >
> > base-commit: e25c8d66f6786300b680866c0e0139981273feba
> > --
> > 2.34.1
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

