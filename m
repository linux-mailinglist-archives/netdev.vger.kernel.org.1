Return-Path: <netdev+bounces-152480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9B09F412B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 04:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1127D188AC13
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8CC8615A;
	Tue, 17 Dec 2024 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBDmBqNY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F27B182CD;
	Tue, 17 Dec 2024 03:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734405363; cv=none; b=s/dCOJRTQJZ9PsAkL+95CFJkdW8jPsyPB4apK3v1JVH5VFPb1BK1VPfXqsEf+OgArC7CUEWJ8wCv+bPlMfGAmnPmk8+lK0PBo97V5uquJCdrgT+D1qOrrlbVmzenji17esvs885Yp0oQfbBd791secq80HERhxYbHlInSba4iGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734405363; c=relaxed/simple;
	bh=eSRcpHm69MKKFSD0FM6k6Y/jBE7bXgw9nkqltvgqD6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1icJ5UmweHTByYyo7lfG3lMNwcCXz1+StX9rSUO5W1qwnilTa58pr/83avArO8G6Lb1+8gLSH5t98No1osUUWc1mjIFZjsQKmF76w0eBQlbGmwFta+kC0c0SvzDdxRT8UFS22Ret42opJRgeBZn871cABOvZXBEa5+8UmMYtzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBDmBqNY; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-303489e8775so26277391fa.3;
        Mon, 16 Dec 2024 19:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734405358; x=1735010158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ek0BUeoz9KKImBp4+0OJ6FTIElZBmqTJgwSOKMqpYcU=;
        b=jBDmBqNYU65ksy49Dl/+ypyCEPJKi6Kp/qjzlYxyJvIet0JzELXmKKod1p+o9AR8AL
         jOqmR72xlxmFidRULDQPqgRPPohrd5ZIYKaRJZrz1rDHoYyalX3085BDsyJ3JFepVoQk
         IhgRcpXJNRnZbRMDgBZyY2JWDTt13OFqDULhO2zzWHflhuO+vE6n3ML0T9qO9MK/OFrt
         gblpsEm3ruR0usTgg2F5yocB9QOftjKQs9wvNrU4DU6gQLgrPv0I+TsDODqhuAn35Gzs
         4+fUD41G6/2UGLlPOOW+Catq6Fd8aZhIKHJn9N7YIE3dUxFL+kxLcQf0GlrtPNnsgHX5
         oo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734405358; x=1735010158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ek0BUeoz9KKImBp4+0OJ6FTIElZBmqTJgwSOKMqpYcU=;
        b=jjSR0CH5G5JfdwD+r4hNZsIiPeAIa3MmRbAgeT7qA2tU7S3HFyIAFqEuP75TqYMrRh
         TAhwPZTXXWHB9/rKv6ncuE/8BagptJEZ1PxdhhNpZPt5WPDdQ+et2snFg9tu4cmq3rSO
         qzrCLxDYqFz5aZZ/gOJkACnAIEOqe8xBAw/hH70iu/ykyklRukOsv5fyEKMYKFqiQyEs
         65f5ChwEWllREhkdHVWea8fj5jeBGFog9uHGYy4fzdQsEwhmtlZgtEpGHNNfEpaZ0hBS
         veCpxhIarjyZJj8ffEGMWIPP4accEh4zQgZxS5tUc/LHpDfmtmGU6rLGTHQtv3lEC4f0
         pzyA==
X-Forwarded-Encrypted: i=1; AJvYcCUQk5ZH8Zk2kWbyAJ2OytwnsFX9Kxq0mmS56XT6AH4ffZLc7dYXXJLjlOI8Ww9iIRHPImPUSp81DzhjeBdE@vger.kernel.org, AJvYcCX8S5jJkx+LE5p2tFIbbvlEa+mOgnOSotWrqhK9cYaVwHxl0dTR7l6TwMqa5RI085OCnKunSu+Sfyjz64u+aDQ=@vger.kernel.org, AJvYcCXGUsy5gyMhyxGeBx5trEcBCQarkhyG95+hc7SNu0qyl3Q6DNQopP/qMsBzte3e6NfZNB6Bl5/S@vger.kernel.org
X-Gm-Message-State: AOJu0YzwqrKCGKKHLh45tUmjRlkHZqvxX08NDxY+mIZFx6gWn7rcuCfx
	LkXUco2/Y2u5zGG3vSIibt+nXuFPFdZNZnN+IX7wAFqugSw/tllKD65hdWTh31BEIpjS8Lg8oHo
	v+0g3dopEafhiFvB+vNpZnhndK3U=
X-Gm-Gg: ASbGncv1Qw0YiC/6c7ORZWRM50G2o3EJ/TMZE0QU6JEuxOFT8kKgOtpO2ik7WuZPdEs
	88VZvGcLwcZa75Kin7vn36mj+3WAmEPW8arNUceM=
X-Google-Smtp-Source: AGHT+IGBI2eiHe1xauNXuOrvtUOCDdglVJvOd736H8nBHkg5e1lGanGQKA9/FcfdAawrxdgo3wHCsrWRmFNWtb0NZxk=
X-Received: by 2002:a05:651c:b29:b0:300:3a15:8f26 with SMTP id
 38308e7fff4ca-3025447e328mr49690201fa.0.1734405358076; Mon, 16 Dec 2024
 19:15:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216080758.3450976-1-quic_chejiang@quicinc.com>
 <CABBYNZLRdu_f9eNEapPp5mNqgcUE0jby5VPpaMaArY_FjyjB8Q@mail.gmail.com>
 <CABBYNZKPu20vHx3DMGXVobR_5t-WUgt-KX41+tA1Lrz+aDFY-Q@mail.gmail.com> <bb9505d6-e8ae-47dc-a1e0-6d1974dc12ac@quicinc.com>
In-Reply-To: <bb9505d6-e8ae-47dc-a1e0-6d1974dc12ac@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Dec 2024 22:15:45 -0500
Message-ID: <CABBYNZJuic=HfeF1-ybuKELCOEOYk9OWtvqXC4vyrnnZLUp7RQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix disconnect complete event
 timeout issue
To: "Cheng Jiang (IOE)" <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_jiaymao@quicinc.com, 
	quic_shuaz@quicinc.com, quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng,

On Mon, Dec 16, 2024 at 9:49=E2=80=AFPM Cheng Jiang (IOE)
<quic_chejiang@quicinc.com> wrote:
>
> Hi Luiz,
>
> On 12/16/2024 10:42 PM, Luiz Augusto von Dentz wrote:
> > Hi Cheng,
> >
> > On Mon, Dec 16, 2024 at 9:32=E2=80=AFAM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> >>
> >> Hi Cheng,
> >>
> >> On Mon, Dec 16, 2024 at 3:08=E2=80=AFAM Cheng Jiang <quic_chejiang@qui=
cinc.com> wrote:
> >>>
> >>> Sometimes, the remote device doesn't acknowledge the LL_TERMINATE_IND
> >>> in time, requiring the controller to wait for the supervision timeout=
,
> >>> which may exceed 2 seconds. In the current implementation, the
> >>> HCI_EV_DISCONN_COMPLETE event is ignored if it arrives late, since
> >>> the hci_abort_conn_sync has cleaned up the connection after 2 seconds=
.
> >>> This causes the mgmt to get stuck, resulting in bluetoothd waiting
> >>> indefinitely for the mgmt response to the disconnect. To recover,
> >>> restarting bluetoothd is necessary.
> >>>
> >>> bluetoothctl log like this:
> >>> [Designer Mouse]# disconnect D9:B5:6C:F2:51:91
> >>> Attempting to disconnect from D9:B5:6C:F2:51:91
> >>> [Designer Mouse]#
> >>> [Designer Mouse]# power off
> >>> [Designer Mouse]#
> >>> Failed to set power off: org.freedesktop.DBus.Error.NoReply.
> >>>
> >>> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> >>> ---
> >>>  include/net/bluetooth/hci_core.h |  2 ++
> >>>  net/bluetooth/hci_conn.c         |  9 +++++++++
> >>>  net/bluetooth/hci_event.c        |  9 +++++++++
> >>>  net/bluetooth/hci_sync.c         | 18 ++++++++++++++++++
> >>>  4 files changed, 38 insertions(+)
> >>>
> >>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
> >>> index 734cd50cd..2ab079dcf 100644
> >>> --- a/include/net/bluetooth/hci_core.h
> >>> +++ b/include/net/bluetooth/hci_core.h
> >>> @@ -753,6 +753,8 @@ struct hci_conn {
> >>>
> >>>         struct bt_codec codec;
> >>>
> >>> +       struct completion disc_ev_comp;
> >>> +
> >>>         void (*connect_cfm_cb)  (struct hci_conn *conn, u8 status);
> >>>         void (*security_cfm_cb) (struct hci_conn *conn, u8 status);
> >>>         void (*disconn_cfm_cb)  (struct hci_conn *conn, u8 reason);
> >>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> >>> index d097e308a..e0244e191 100644
> >>> --- a/net/bluetooth/hci_conn.c
> >>> +++ b/net/bluetooth/hci_conn.c
> >>> @@ -1028,6 +1028,15 @@ static struct hci_conn *__hci_conn_add(struct =
hci_dev *hdev, int type, bdaddr_t
> >>>
> >>>         hci_conn_init_sysfs(conn);
> >>>
> >>> +       /* This disc_ev_comp is inited when we send a disconnect requ=
est to
> >>> +        * the remote device but fail to receive the disconnect compl=
ete
> >>> +        * event within the expected time (2 seconds). This occurs be=
cause
> >>> +        * the remote device doesn't ack the terminate indication, fo=
rcing
> >>> +        * the controller to wait for the supervision timeout.
> >>> +        */
> >>> +       init_completion(&conn->disc_ev_comp);
> >>> +       complete(&conn->disc_ev_comp);
> >>> +
> >>>         return conn;
> >>>  }
> >>>
> >>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >>> index 2cc7a9306..60ecb2b18 100644
> >>> --- a/net/bluetooth/hci_event.c
> >>> +++ b/net/bluetooth/hci_event.c
> >>> @@ -3366,6 +3366,15 @@ static void hci_disconn_complete_evt(struct hc=
i_dev *hdev, void *data,
> >>>         if (!conn)
> >>>                 goto unlock;
> >>>
> >>> +       /* Wake up disc_ev_comp here is ok. Since we hold the hdev lo=
ck
> >>> +        * hci_abort_conn_sync will wait hdev lock release to continu=
e.
> >>> +        */
> >>> +       if (!completion_done(&conn->disc_ev_comp)) {
> >>> +               complete(&conn->disc_ev_comp);
> >>> +               /* Add some delay for hci_abort_conn_sync to handle t=
he complete */
> >>> +               usleep_range(100, 1000);
> >>> +       }
> >>> +
> >>>         if (ev->status) {
> >>>                 mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
> >>>                                        conn->dst_type, ev->status);
> >>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> >>> index 0badec712..783d04b57 100644
> >>> --- a/net/bluetooth/hci_sync.c
> >>> +++ b/net/bluetooth/hci_sync.c
> >>> @@ -5590,6 +5590,24 @@ int hci_abort_conn_sync(struct hci_dev *hdev, =
struct hci_conn *conn, u8 reason)
> >>>                 break;
> >>>         }
> >>>
> >>> +       /* Check whether the connection is successfully disconnected.
> >>> +        * Sometimes the remote device doesn't acknowledge the
> >>> +        * LL_TERMINATE_IND in time, requiring the controller to wait
> >>> +        * for the supervision timeout, which may exceed 2 seconds. I=
n
> >>> +        * this case, we need to wait for the HCI_EV_DISCONN_COMPLETE
> >>> +        * event before cleaning up the connection.
> >>> +        */
> >>> +       if (err =3D=3D -ETIMEDOUT) {
> >>> +               u32 idle_delay =3D msecs_to_jiffies(10 * conn->le_sup=
v_timeout);
> >>> +
> >>> +               reinit_completion(&conn->disc_ev_comp);
> >>> +               if (!wait_for_completion_timeout(&conn->disc_ev_comp,=
 idle_delay)) {
> >>> +                       bt_dev_warn(hdev, "Failed to get complete");
> >>> +                       mgmt_disconnect_failed(hdev, &conn->dst, conn=
->type,
> >>> +                                              conn->dst_type, conn->=
abort_reason);
> >>> +               }
> >>> +       }
> >>
> >> Why don't we just set the supervision timeout as timeout then? If we
> >> will have to wait for it anyway just change hci_disconnect_sync to use
> >> 10 * conn->le_supv_timeout as timeout instead.
> >>
> hci_disconnect_sync uses __hci_cmd_sync_status_sk to wait for the
> HCI_EV_DISCONN_COMPLETE event, which will send the command in hci_cmd_wor=
k.
> In hci_cmd_work, it will start a timer with HCI_CMD_TIMEOUT(2s) to wait
> for the event. So even in hci_disconnect_sync we can set the timeout to
> supervision timeout, hci_disconnect_sync still timeout after 2s.

Wait, why are you talking about HCI_CMD_TIMEOUT when I told you to use
the supervision timeout instead? If it still timeout after to 2
seconds then there is something still forcing HCI_CMD_TIMEOUT which
shouldn't happen.

> >> That said, we really need to fix bluetoothd if it is not able to be
> >> cleaned up if SET_POWERED command fails, but it looks like it is
> >> handling errors correctly so it sounds like something else is at play.
> >
> The issue arises after a 2-second timeout of hci_disconnect_sync. During
> hci_abort_conn_sync, the connection is cleaned up by hci_conn_failed.
> after supervision timeout, the disconnect complete event arrives, but
> it returns at line 3370 since the connection has already been removed.
> As a result, bluetoothd does not send the mgmt event for MGMT_OP_DISCONNE=
CT
> to the application layer (bluetoothctl), causing bluetoothctl to get stuc=
k
> and unable to perform other mgmt commands.

The command shall have completed regardless if disconnect complete has
been received or not, the is the whole point of having a timeout, so
this makes no sense to me, or you are not describing what is happening
here. Also there is no MGMT_OP_DISCONNECT pending, it is
MGMT_OP_SET_POWERED, if you are talking about the DISCONNECTED event
that is a totally different thing and perhaps that is the source of
the problem because if we do cleanup hci_conn even in case the command
fails/times out then we should be generating a disconnected event as
well.

>
> 3355 static void hci_disconn_complete_evt(struct hci_dev *hdev, void *dat=
a,
> 3356              struct sk_buff *skb)
> 3357 {
> 3358   struct hci_ev_disconn_complete *ev =3D data;
> 3359   u8 reason;
> 3360   struct hci_conn_params *params;
> 3361   struct hci_conn *conn;
> 3362   bool mgmt_connected;
> 3363
> 3364   bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
> 3365
> 3366   hci_dev_lock(hdev);
> 3367
> 3368   conn =3D hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handl=
e));
> 3369   if (!conn)
> 3370     goto unlock;
> 3371
> 3372   if (ev->status) {
> 3373     mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
> 3374                conn->dst_type, ev->status);
> 3375     goto unlock;
> 3376   }
> 3377
> 3378   conn->state =3D BT_CLOSED;
> 3379
> 3380   mgmt_connected =3D test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &co=
nn->flags);
> 3381
>
> > I double checked this and apparently this could no longer fail:
> >
> > +               /* Disregard possible errors since hci_conn_del shall h=
ave been
> > +                * called even in case of errors had occurred since it =
would
> > +                * then cause hci_conn_failed to be called which calls
> > +                * hci_conn_del internally.
> > +                */
> > +               hci_abort_conn_sync(hdev, conn, reason);
> >
> > So it will clean up the hci_conn no matter what is the timeout, so
> > either you don't have this change or it is not working for some
> > reason.
> >
> The issue is mgmt command is not repsonsed by bluetoothd, then the blueto=
otlctl is
> blocked. It does not happen during the power off stage. It happened when =
disconnect
> a BLE device, but the disconnect complete event sent from controller to h=
ost 2s later.
> Then it causes the mgmt in bluetoothctl is blocked as decribed as above.

There is a difference about a MGMT command, initiated by bluetoothd,
versus a MGMT event initiated by the kernel, so the daemon is not
blocked it just don't get a disconnection event, which is different
than a command complete.

What is the command sequence that you use to reproduce the problem?

> >>>         hci_dev_lock(hdev);
> >>>
> >>>         /* Check if the connection has been cleaned up concurrently *=
/
> >>>
> >>> base-commit: e25c8d66f6786300b680866c0e0139981273feba
> >>> --
> >>> 2.34.1
> >>>
> >>
> >>
> >> --
> >> Luiz Augusto von Dentz
> >
> >
> >
>


--=20
Luiz Augusto von Dentz

