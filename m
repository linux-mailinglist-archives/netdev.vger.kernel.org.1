Return-Path: <netdev+bounces-152636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F7D9F4F0A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE447A217C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F091F4E3D;
	Tue, 17 Dec 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgqhHxVN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233101F7073;
	Tue, 17 Dec 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448437; cv=none; b=Xiv8ADD7UBavDHBlp7eQ+v6spmuQF22qifZU2TaCHG5ZjmzUWW6KlFt1ibpoQXVizbE1MJfB6u2oDNVEHt3xHIshUuAkDoJJssjQl2XA0AJ+tDeZ+3sD7DMpYq5LtGce7VGQSyrR7qqyKWZaFMWUYQxYlaLenxDF9mwFkxeuJv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448437; c=relaxed/simple;
	bh=dC4kf7WmBE16IlOVgzUG/2XZ8xgqg+mTXMjISJaro0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3f33lIb9NvTlF61jVUnsvP6XnhSk2tEkT+wCHUew/R0GEe+kNDtPZvak+ECgZAKHAMBup7TwOj4KhiaDV/Od4QDd1wxgnP0KLpdAAIgo25Wv4gCImnnHobcRrmp/fiN9YBLrXBdbt01bFyP20qvNBFCA8no2O1EhVTDe+tCBgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgqhHxVN; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3035046d4bfso24401341fa.0;
        Tue, 17 Dec 2024 07:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734448433; x=1735053233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB9s4afg/Hh18Oanf+CJOTVO5QSNNFkQtjnMwqaF1oM=;
        b=YgqhHxVN+Ej3GsbOovhB1fyPLbRt//6AFFO4Bz9stD5XvW7y6pyV2DVZAI8A32HujM
         Gje7WDXQTR68l/dzF+WAqxrxtzQDKSfJDXe+XTs4lyrJwTGQ3j2zgkJDDZ9l0naVJUbF
         7wlbCmTdiU6+9+hO92dFeyqPHvm3Oy4/PTWrK2gsJ3e/hYpfwM1mDjjpLWl38qVzI1NZ
         rUdVc4N66S1tdx0waRVspHGmKMeOPrKQBQrSNA0UnIJupKmPASEtlnTG0lfPX8HESbFA
         mPDDS6zWGEUha+/8nRP/mOd+OxQedZVylJOAp4mdWzLYgHi9Al0T7XeTyUyFcAllk7yc
         XHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734448433; x=1735053233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yB9s4afg/Hh18Oanf+CJOTVO5QSNNFkQtjnMwqaF1oM=;
        b=vUBGKh6zpd2G2zcHDvkyQn0NBghREB3n9lEuw4p8TaxwnDhixxy7RPplc8OpwZZh1m
         YpB1EWTWsnnBlayN55fVR/PO2m3+UHZgJjdwCgs/mxkXmUUhbedne91Bj6OdM9osd2uu
         gCnr5i6pXjMPatGKmXZvn3V64koLK9gz70XVtKNRFkKWZkr48PxJBpc3wZjEJnC+ux91
         Koig6ISPadn15QX+DOiMyODhpYc5wp0SPBnRZddASmLQ+XsPjktOvJ8ZgFdcrY2JjxDi
         CFp0dA21KZpIefEXAzdSX1a+IZAv10XftwBO0PEcmJAPwcLNBhgrCFNg3qLCq9r78AF+
         jLzg==
X-Forwarded-Encrypted: i=1; AJvYcCUE7EWw43ksjOXEPPqXK/HrDm2e2v/TRj1sqZWjfU/d7CxB1X62+gj723fFDUMF/oA6Ru/xuL+a@vger.kernel.org, AJvYcCXZlaeYCWE1Ksw+UILM+6OpC45B7bjXm7SeaMi5y3+iE4J8Rh2U/j+J3pYG8EXKcrHlpDlAfuiM7hq3tmdIY0Y=@vger.kernel.org, AJvYcCXpZ5zADh/z3ti1BvjGmsuFPBhw1pLHcqjbIr7LjQcZe23PWKyTDsoGUOIsIOfQYuctxFu1yMPM0HfDIJwG@vger.kernel.org
X-Gm-Message-State: AOJu0YxkO+xSUtwPst/N9OOuRWUVylDMBmv/GUoXNp/5wDKw/GipIvcn
	l5kIdMEiSUs098Dm91YiyUnY1ofle+ilWJXB7+EJvDVnT+8wwJx5p164bt2llQ+A647gD++kIi1
	DCXPQgsUryPDFbdHKqDb5KdmGPhA=
X-Gm-Gg: ASbGncvj4uqMuZhs5vbBJPiMgXi8zVFHKa404CRwZrvamIAg33yAVhyJ3beWHRyfAIW
	S8XKpbu55+eaYIwlWi5UxCDQw5MuThM7k/KErCmo=
X-Google-Smtp-Source: AGHT+IF/fwC4fEcrU0me+R1qHhTcviSbQyta6ihqmDNWbSBxiQgTlMSFQeBGmL8Rkjlrf9QLPq1f+IM0Y147ROfkRLU=
X-Received: by 2002:a05:651c:1a0c:b0:302:5308:ba48 with SMTP id
 38308e7fff4ca-302544642d1mr48197431fa.12.1734448432767; Tue, 17 Dec 2024
 07:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216080758.3450976-1-quic_chejiang@quicinc.com>
 <CABBYNZLRdu_f9eNEapPp5mNqgcUE0jby5VPpaMaArY_FjyjB8Q@mail.gmail.com>
 <CABBYNZKPu20vHx3DMGXVobR_5t-WUgt-KX41+tA1Lrz+aDFY-Q@mail.gmail.com>
 <bb9505d6-e8ae-47dc-a1e0-6d1974dc12ac@quicinc.com> <CABBYNZJuic=HfeF1-ybuKELCOEOYk9OWtvqXC4vyrnnZLUp7RQ@mail.gmail.com>
 <ae3a0f6d-c844-4874-acf4-03a4f9cf3a24@quicinc.com>
In-Reply-To: <ae3a0f6d-c844-4874-acf4-03a4f9cf3a24@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 17 Dec 2024 10:13:40 -0500
Message-ID: <CABBYNZJcHvVYBUmS6AeA6OGnV8n1EKh5JxB8aLqP9OBqA-amyg@mail.gmail.com>
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

On Tue, Dec 17, 2024 at 12:51=E2=80=AFAM Cheng Jiang (IOE)
<quic_chejiang@quicinc.com> wrote:
>
> Hi Luiz,
>
> On 12/17/2024 11:15 AM, Luiz Augusto von Dentz wrote:
> > Hi Cheng,
> >
> > On Mon, Dec 16, 2024 at 9:49=E2=80=AFPM Cheng Jiang (IOE)
> > <quic_chejiang@quicinc.com> wrote:
> >>
> >> Hi Luiz,
> >>
> >> On 12/16/2024 10:42 PM, Luiz Augusto von Dentz wrote:
> >>> Hi Cheng,
> >>>
> >>> On Mon, Dec 16, 2024 at 9:32=E2=80=AFAM Luiz Augusto von Dentz
> >>> <luiz.dentz@gmail.com> wrote:
> >>>>
> >>>> Hi Cheng,
> >>>>
> >>>> On Mon, Dec 16, 2024 at 3:08=E2=80=AFAM Cheng Jiang <quic_chejiang@q=
uicinc.com> wrote:
> >>>>>
> >>>>> Sometimes, the remote device doesn't acknowledge the LL_TERMINATE_I=
ND
> >>>>> in time, requiring the controller to wait for the supervision timeo=
ut,
> >>>>> which may exceed 2 seconds. In the current implementation, the
> >>>>> HCI_EV_DISCONN_COMPLETE event is ignored if it arrives late, since
> >>>>> the hci_abort_conn_sync has cleaned up the connection after 2 secon=
ds.
> >>>>> This causes the mgmt to get stuck, resulting in bluetoothd waiting
> >>>>> indefinitely for the mgmt response to the disconnect. To recover,
> >>>>> restarting bluetoothd is necessary.
> >>>>>
> >>>>> bluetoothctl log like this:
> >>>>> [Designer Mouse]# disconnect D9:B5:6C:F2:51:91
> >>>>> Attempting to disconnect from D9:B5:6C:F2:51:91
> >>>>> [Designer Mouse]#
> >>>>> [Designer Mouse]# power off
> >>>>> [Designer Mouse]#
> >>>>> Failed to set power off: org.freedesktop.DBus.Error.NoReply.
> >>>>>
> >>>>> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> >>>>> ---
> >>>>>  include/net/bluetooth/hci_core.h |  2 ++
> >>>>>  net/bluetooth/hci_conn.c         |  9 +++++++++
> >>>>>  net/bluetooth/hci_event.c        |  9 +++++++++
> >>>>>  net/bluetooth/hci_sync.c         | 18 ++++++++++++++++++
> >>>>>  4 files changed, 38 insertions(+)
> >>>>>
> >>>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetoo=
th/hci_core.h
> >>>>> index 734cd50cd..2ab079dcf 100644
> >>>>> --- a/include/net/bluetooth/hci_core.h
> >>>>> +++ b/include/net/bluetooth/hci_core.h
> >>>>> @@ -753,6 +753,8 @@ struct hci_conn {
> >>>>>
> >>>>>         struct bt_codec codec;
> >>>>>
> >>>>> +       struct completion disc_ev_comp;
> >>>>> +
> >>>>>         void (*connect_cfm_cb)  (struct hci_conn *conn, u8 status);
> >>>>>         void (*security_cfm_cb) (struct hci_conn *conn, u8 status);
> >>>>>         void (*disconn_cfm_cb)  (struct hci_conn *conn, u8 reason);
> >>>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> >>>>> index d097e308a..e0244e191 100644
> >>>>> --- a/net/bluetooth/hci_conn.c
> >>>>> +++ b/net/bluetooth/hci_conn.c
> >>>>> @@ -1028,6 +1028,15 @@ static struct hci_conn *__hci_conn_add(struc=
t hci_dev *hdev, int type, bdaddr_t
> >>>>>
> >>>>>         hci_conn_init_sysfs(conn);
> >>>>>
> >>>>> +       /* This disc_ev_comp is inited when we send a disconnect re=
quest to
> >>>>> +        * the remote device but fail to receive the disconnect com=
plete
> >>>>> +        * event within the expected time (2 seconds). This occurs =
because
> >>>>> +        * the remote device doesn't ack the terminate indication, =
forcing
> >>>>> +        * the controller to wait for the supervision timeout.
> >>>>> +        */
> >>>>> +       init_completion(&conn->disc_ev_comp);
> >>>>> +       complete(&conn->disc_ev_comp);
> >>>>> +
> >>>>>         return conn;
> >>>>>  }
> >>>>>
> >>>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >>>>> index 2cc7a9306..60ecb2b18 100644
> >>>>> --- a/net/bluetooth/hci_event.c
> >>>>> +++ b/net/bluetooth/hci_event.c
> >>>>> @@ -3366,6 +3366,15 @@ static void hci_disconn_complete_evt(struct =
hci_dev *hdev, void *data,
> >>>>>         if (!conn)
> >>>>>                 goto unlock;
> >>>>>
> >>>>> +       /* Wake up disc_ev_comp here is ok. Since we hold the hdev =
lock
> >>>>> +        * hci_abort_conn_sync will wait hdev lock release to conti=
nue.
> >>>>> +        */
> >>>>> +       if (!completion_done(&conn->disc_ev_comp)) {
> >>>>> +               complete(&conn->disc_ev_comp);
> >>>>> +               /* Add some delay for hci_abort_conn_sync to handle=
 the complete */
> >>>>> +               usleep_range(100, 1000);
> >>>>> +       }
> >>>>> +
> >>>>>         if (ev->status) {
> >>>>>                 mgmt_disconnect_failed(hdev, &conn->dst, conn->type=
,
> >>>>>                                        conn->dst_type, ev->status);
> >>>>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> >>>>> index 0badec712..783d04b57 100644
> >>>>> --- a/net/bluetooth/hci_sync.c
> >>>>> +++ b/net/bluetooth/hci_sync.c
> >>>>> @@ -5590,6 +5590,24 @@ int hci_abort_conn_sync(struct hci_dev *hdev=
, struct hci_conn *conn, u8 reason)
> >>>>>                 break;
> >>>>>         }
> >>>>>
> >>>>> +       /* Check whether the connection is successfully disconnecte=
d.
> >>>>> +        * Sometimes the remote device doesn't acknowledge the
> >>>>> +        * LL_TERMINATE_IND in time, requiring the controller to wa=
it
> >>>>> +        * for the supervision timeout, which may exceed 2 seconds.=
 In
> >>>>> +        * this case, we need to wait for the HCI_EV_DISCONN_COMPLE=
TE
> >>>>> +        * event before cleaning up the connection.
> >>>>> +        */
> >>>>> +       if (err =3D=3D -ETIMEDOUT) {
> >>>>> +               u32 idle_delay =3D msecs_to_jiffies(10 * conn->le_s=
upv_timeout);
> >>>>> +
> >>>>> +               reinit_completion(&conn->disc_ev_comp);
> >>>>> +               if (!wait_for_completion_timeout(&conn->disc_ev_com=
p, idle_delay)) {
> >>>>> +                       bt_dev_warn(hdev, "Failed to get complete")=
;
> >>>>> +                       mgmt_disconnect_failed(hdev, &conn->dst, co=
nn->type,
> >>>>> +                                              conn->dst_type, conn=
->abort_reason);
> >>>>> +               }
> >>>>> +       }
> >>>>
> >>>> Why don't we just set the supervision timeout as timeout then? If we
> >>>> will have to wait for it anyway just change hci_disconnect_sync to u=
se
> >>>> 10 * conn->le_supv_timeout as timeout instead.
> >>>>
> >> hci_disconnect_sync uses __hci_cmd_sync_status_sk to wait for the
> >> HCI_EV_DISCONN_COMPLETE event, which will send the command in hci_cmd_=
work.
> >> In hci_cmd_work, it will start a timer with HCI_CMD_TIMEOUT(2s) to wai=
t
> >> for the event. So even in hci_disconnect_sync we can set the timeout t=
o
> >> supervision timeout, hci_disconnect_sync still timeout after 2s.
> >
> > Wait, why are you talking about HCI_CMD_TIMEOUT when I told you to use
> > the supervision timeout instead? If it still timeout after to 2
> > seconds then there is something still forcing HCI_CMD_TIMEOUT which
> > shouldn't happen.
> >
> Since the lower layer (hci_cmd_work) has set the timeout to HCI_CMD_TIMEO=
UT, so
> even the upper layer set to a larger timeout value, like supervision time=
out,
> it still get the timeout after HCI_CMD_TIMEOUT. The timeout flow is:
> hci_disconnect_sync -> __hci_cmd_sync_sk(wait_event_interruptible_timeout=
) ->
> hci_cmd_work -> hci_cmd_timeout -> hci_cmd_sync_cancel_sync -> wake up th=
e
> wait_event_interruptible_timeout in __hci_cmd_sync_sk -> hci_disconnect_s=
ync timeout.
>
> So even if we set a large timeout value in hci_disconnect_sync, it doesn'=
t work
> since it's waked up by other event, not the real timeout.
>
> What's more, in the hci_disconnect_sync, if the reason it not power_off, =
it waits
> for the disconnect complete event rather than command status event. Accor=
ding to
> BT core spec, disconnect complete event has to wait for remote's ack or w=
ait until
> supervision timeout. It's a valid case that the disconnect complete event=
 taking
> more than 2s.

You seems to be confusing the role of 2 different timers:

    err =3D wait_event_interruptible_timeout(hdev->req_wait_q,
                           hdev->req_status !=3D HCI_REQ_PEND,
                           timeout);

and

            queue_delayed_work(hdev->workqueue, &hdev->cmd_timer,
                       HCI_CMD_TIMEOUT);

The former waits for a specific event, while the later waits for
handle_cmd_cnt_and_timer, each can have a distinct timeout as in the
code bellow:

    return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_EXT_CREATE_CONN,
                    plen, data,
                    HCI_EV_LE_ENHANCED_CONN_COMPLETE,
                    conn->conn_timeout, NULL);

The reason there are 2 timers is that we need to track the number of
commands outstanding in the controller, and no you can't delay Command
Status:

When the Controller receives the HCI_Disconnect command, it _shall_ send th=
e
HCI_Command_Status event to the Host.

So even if HCI_Disconnection_Complete is delayed the following shall
still work provided the HCI_Command_Status is still being generated
accordingly:

index 0badec7120ab..0ab607fb6433 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5444,7 +5444,7 @@ static int hci_disconnect_sync(struct hci_dev
*hdev, struct hci_conn *conn,
                return __hci_cmd_sync_status_sk(hdev, HCI_OP_DISCONNECT,
                                                sizeof(cp), &cp,
                                                HCI_EV_DISCONN_COMPLETE,
-                                               HCI_CMD_TIMEOUT, NULL);
+                                               conn->disc_timeout, NULL);

        return __hci_cmd_sync_status(hdev, HCI_OP_DISCONNECT, sizeof(cp), &=
cp,
                                     HCI_CMD_TIMEOUT);

Then we need to adjust conn->disc_timeout according to supervision
timeout, that said it appears disc_timeout is actually acting as idle
timeout, so perhaps we need a separate field, also it doesn't look
like we track the supervision timeout for non-LE links.

> >>>> That said, we really need to fix bluetoothd if it is not able to be
> >>>> cleaned up if SET_POWERED command fails, but it looks like it is
> >>>> handling errors correctly so it sounds like something else is at pla=
y.
> >>>
> >> The issue arises after a 2-second timeout of hci_disconnect_sync. Duri=
ng
> >> hci_abort_conn_sync, the connection is cleaned up by hci_conn_failed.
> >> after supervision timeout, the disconnect complete event arrives, but
> >> it returns at line 3370 since the connection has already been removed.
> >> As a result, bluetoothd does not send the mgmt event for MGMT_OP_DISCO=
NNECT
> >> to the application layer (bluetoothctl), causing bluetoothctl to get s=
tuck
> >> and unable to perform other mgmt commands.
> >
> > The command shall have completed regardless if disconnect complete has
> > been received or not, the is the whole point of having a timeout, so
> > this makes no sense to me, or you are not describing what is happening
> > here. Also there is no MGMT_OP_DISCONNECT pending, it is
> > MGMT_OP_SET_POWERED, if you are talking about the DISCONNECTED event
> > that is a totally different thing and perhaps that is the source of
> > the problem because if we do cleanup hci_conn even in case the command
> > fails/times out then we should be generating a disconnected event as
> > well.
> >
> Here is the flow describe the issue. For normal case:
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90          =E2=94=8C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90           =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90           =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90      =
     =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=90
> =E2=94=82bluetootctl=E2=94=82          =E2=94=82bluetoothd=E2=94=82      =
     =E2=94=82kernel=E2=94=82           =E2=94=82controller=E2=94=82       =
    =E2=94=82remote=E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98          =E2=94=94=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=98           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=
=94=80=E2=94=80=E2=94=98           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98      =
     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=
=98
>       =E2=94=82   disconnect cmd     =E2=94=82                    =E2=94=
=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80>=E2=94=82        =
            =E2=94=82                    =E2=94=82                    =E2=
=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82    MGMT_OP         =E2=94=
=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82    _DISCONNECT     =E2=94=
=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80>=E2=
=94=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82  HCI_Disconnect    =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80>=E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                    =E2=94=82   LL_TERMINATE     =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                    =E2=94=82   _IND             =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                    =E2=94=82=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80>=E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                    =E2=94=82        ACK         =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                    =E2=94=82<=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82   Disc_Comp_Evt    =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82<=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82   MGMT Response    =E2=94=
=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82<=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82      disc succ       =E2=94=82                    =E2=94=
=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82<=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=82         =
           =E2=94=82                    =E2=94=82                    =E2=94=
=82
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90          =E2=94=8C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90           =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=
=94=80=E2=94=80=E2=94=90           =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90      =
     =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=
=90
> =E2=94=82bluetootctl=E2=94=82          =E2=94=82bluetoothd=E2=94=82      =
     =E2=94=82kernel=E2=94=82           =E2=94=82controller=E2=94=82       =
    =E2=94=82remote=E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98          =E2=94=94=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=98           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98      =
     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98
>
>
> The failure case like this:
>
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90          =E2=94=8C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90           =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90            =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90      =
     =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=90
> =E2=94=82bluetootctl=E2=94=82          =E2=94=82bluetoothd=E2=94=82      =
     =E2=94=82kernel=E2=94=82            =E2=94=82controller=E2=94=82      =
     =E2=94=82remote=E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98          =E2=94=94=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=98           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=
=94=80=E2=94=80=E2=94=98            =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98      =
     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=
=98
>       =E2=94=82     disconnect       =E2=94=82                    =E2=94=
=82                     =E2=94=82                    =E2=94=82
>       =E2=94=82     cmd              =E2=94=82                    =E2=94=
=82                     =E2=94=82                    =E2=94=82
>       =E2=94=82=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80>=E2=94=82        =
            =E2=94=82                     =E2=94=82                    =E2=
=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                     =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82    MGMT_OP_        =E2=94=
=82                     =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82    DISCONNECT      =E2=94=
=82                     =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80>=E2=
=94=82                     =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                     =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                   =E2=94=
=8C=E2=94=B4=E2=94=90     HCI_           =E2=94=82                    =E2=
=94=82
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82     Disconnect     =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80>=E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82                    =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82                    =E2=94=82  LL_TERMINATE     =E2=94=8C=E2=
=94=B4=E2=94=90
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82                    =E2=94=82  _IND             =E2=94=82 =E2=
=94=82
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82                    =E2=94=82=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80> =E2=94=82 =E2=94=82
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82                    =E2=94=82                   =E2=94=82 =E2=
=94=82
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82 2s                 =E2=94=82                   =E2=94=82 =E2=
=94=82
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82                    =E2=94=82                   =E2=94=82 =E2=
=94=82
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82                    =E2=94=82                   =E2=94=82 =E2=
=94=82 More
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82                    =E2=94=82                   =E2=94=82 =E2=
=94=82 than
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82                    =E2=94=82                   =E2=94=82 =E2=
=94=82 2s
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82                    =E2=94=82                   =E2=94=82 =E2=
=94=82
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82                    =E2=94=82                   =E2=94=82 =E2=
=94=82
>       =E2=94=82                      =E2=94=82                   =E2=94=
=82 =E2=94=82                    =E2=94=82                   =E2=94=82 =E2=
=94=82
>       =E2=94=82                      =E2=94=82                   =E2=94=
=94=E2=94=AC=E2=94=98                    =E2=94=82                   =E2=94=
=82 =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90                =E2=94=82  =
                 =E2=94=82 =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82    =E2=94=82 hci_disconnect =E2=94=82                   =E2=94=82 =E2=
=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82<=E2=94=80=E2=94=80=E2=94=80=E2=94=98 sync timeout,  =E2=94=82          =
         =E2=94=82 =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82      del 'con' by   =E2=94=82                   =E2=94=82 =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82      hci_conn_failed=E2=94=82                   =E2=94=82 =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                     =E2=94=82                   =E2=94=94=E2=94=AC=E2=
=94=98
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                     =E2=94=82        ACK         =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                     =E2=94=82<=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                     =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82   Disc_Comp_Evt     =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82<=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82                     =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82                    =E2=94=
=82=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90                =E2=94=82  =
                  =E2=94=82
>       =E2=94=82                     \=E2=94=82/                   =E2=94=
=82    =E2=94=82 ignore the     =E2=94=82                    =E2=94=82
>       =E2=94=82                      X                    =E2=94=82<=E2=
=94=80=E2=94=80=E2=94=80=E2=94=98 event since    =E2=94=82                 =
   =E2=94=82
>       =E2=94=82                     /=E2=94=82\                   =E2=94=
=82      'con' has been =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82     MGMT           =E2=94=
=82      deleted        =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82     Response       =E2=94=
=82                     =E2=94=82                    =E2=94=82
>       =E2=94=82                      =E2=94=82<=E2=94=80 =E2=94=80 =E2=94=
=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80=
=E2=94=82                     =E2=94=82                    =E2=94=82
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90          =E2=94=8C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90           =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=
=94=80=E2=94=80=E2=94=90            =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90      =
     =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=
=90
> =E2=94=82bluetootctl=E2=94=82          =E2=94=82bluetoothd=E2=94=82      =
     =E2=94=82kernel=E2=94=82            =E2=94=82controller=E2=94=82      =
     =E2=94=82remote=E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98          =E2=94=94=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=98           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98            =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98      =
     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98
>
>
> So in the failure case, the bluetoothd is blocked by waiting the mgmt res=
ponse from kernel. From
> our test, bluetoothd can't accept any command related to mgmt from blueto=
thctl.
>
> >>
> >> 3355 static void hci_disconn_complete_evt(struct hci_dev *hdev, void *=
data,
> >> 3356              struct sk_buff *skb)
> >> 3357 {
> >> 3358   struct hci_ev_disconn_complete *ev =3D data;
> >> 3359   u8 reason;
> >> 3360   struct hci_conn_params *params;
> >> 3361   struct hci_conn *conn;
> >> 3362   bool mgmt_connected;
> >> 3363
> >> 3364   bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
> >> 3365
> >> 3366   hci_dev_lock(hdev);
> >> 3367
> >> 3368   conn =3D hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->ha=
ndle));
> >> 3369   if (!conn)
> >> 3370     goto unlock;
> >> 3371
> >> 3372   if (ev->status) {
> >> 3373     mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
> >> 3374                conn->dst_type, ev->status);
> >> 3375     goto unlock;
> >> 3376   }
> >> 3377
> >> 3378   conn->state =3D BT_CLOSED;
> >> 3379
> >> 3380   mgmt_connected =3D test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, =
&conn->flags);
> >> 3381
> >>
> >>> I double checked this and apparently this could no longer fail:
> >>>
> >>> +               /* Disregard possible errors since hci_conn_del shall=
 have been
> >>> +                * called even in case of errors had occurred since i=
t would
> >>> +                * then cause hci_conn_failed to be called which call=
s
> >>> +                * hci_conn_del internally.
> >>> +                */
> >>> +               hci_abort_conn_sync(hdev, conn, reason);
> >>>
> >>> So it will clean up the hci_conn no matter what is the timeout, so
> >>> either you don't have this change or it is not working for some
> >>> reason.
> >>>
> >> The issue is mgmt command is not repsonsed by bluetoothd, then the blu=
etootlctl is
> >> blocked. It does not happen during the power off stage. It happened wh=
en disconnect
> >> a BLE device, but the disconnect complete event sent from controller t=
o host 2s later.
> >> Then it causes the mgmt in bluetoothctl is blocked as decribed as abov=
e.
> >
> > There is a difference about a MGMT command, initiated by bluetoothd,
> > versus a MGMT event initiated by the kernel, so the daemon is not
> > blocked it just don't get a disconnection event, which is different
> > than a command complete.
> >
> > What is the command sequence that you use to reproduce the problem?
> Here is the command log:
> [CHG] Controller 8C:FD:F0:21:81:87 Pairable: yes
> [bluetooth]# power on
> Changing power on succeeded
> [bluetooth]# connect CF:90:67:3C:7A:56
> Attempting to connect to CF:90:67:3C:7A:56
> [CHG] Device CF:90:67:3C:7A:56 Connected: yes
> Connection successful
> [CHG] Device CF:90:67:3C:7A:56 ServicesResolved: yes
> [Designer Mouse]#
> [Designer Mouse]# disconnect D9:B5:6C:F2:51:91
> Attempting to disconnect from D9:B5:6C:F2:51:91 ## no disconnection succe=
ss response
> [Designer Mouse]#
> [Designer Mouse]# power off
> [Designer Mouse]#
> Failed to set power off: org.freedesktop.DBus.Error.NoReply
>
> To easily reproduce this issue, we use a firmware which always send the d=
isconnect
> complete event more than 2s. Then the issue occurred 100%.
>
> Actually, the root cause is the hci_disconnect_sync doesn't handle this c=
ase since it
> relies on __hci_cmd_sync_status_sk, which maximum timeout value is constr=
ained to 2s.
>
> >
> >>>>>         hci_dev_lock(hdev);
> >>>>>
> >>>>>         /* Check if the connection has been cleaned up concurrently=
 */
> >>>>>
> >>>>> base-commit: e25c8d66f6786300b680866c0e0139981273feba
> >>>>> --
> >>>>> 2.34.1
> >>>>>
> >>>>
> >>>>
> >>>> --
> >>>> Luiz Augusto von Dentz
> >>>
> >>>
> >>>
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz

