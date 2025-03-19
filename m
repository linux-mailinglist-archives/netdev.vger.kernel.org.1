Return-Path: <netdev+bounces-175974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE99A681A2
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1C5189FC97
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9DD347B4;
	Wed, 19 Mar 2025 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWzFUW8l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ECE1C6B4;
	Wed, 19 Mar 2025 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344804; cv=none; b=ZJSQRp5ZrLKaKldCmilDhEpVeadHS2mX8fakLy0Q+glL/tQw6TqCGkJ6C32V2wjKZuCDVul+XtRdNuqQqMvij6RmeGVWWzPbV0RmEUF/uxisyBuayPHN5c0Q5RouBJltVMCRegZPaeZIVRtblPbMHke4f6678qOF9F0Xirq3fLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344804; c=relaxed/simple;
	bh=drJSKEBLFLYr0WuxGH8sNwYoyO8GyGSP34YO/5Gt0Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgjUMTzM5U56PQrfhbUwZAN/K3ExbL4JWDTEZ0X0MNeHCCvOIrXRNoCh3iYxC5dHUEh9dppOzjgIRTTzl20jIIm+shx6vADBAkCq7C+4SSySEQA6Eszq7BgguUW2X0N7i/ijblHxjvCzrPJNCoYIbZX/BTkHnE7H6CRiLb0ykBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWzFUW8l; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85b4277d03fso196989939f.1;
        Tue, 18 Mar 2025 17:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742344801; x=1742949601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pF3rKAbtwRpNpJJUBHBzadk02bRgA6h529sX7PrSrVg=;
        b=GWzFUW8lY3Xpq+KviVQ4bN/404sFrp3jv5MbMtOCVZGsl0VX9PGks7MHeOLA79XVS5
         1aw2upFqUUUqFRifznBL1rgFATfU5OEckP/JDGuscio1NeZkaXuD+LHXzLqu9C+IUrph
         2a7+klUKCqz6sovzHklK6rjRS1YqtD3JiSHagInUYSoKmwB7ZppPySq886sZhYV4TEZR
         oafbAAU0rBTkmfEkyTwN8hmb/Kj4fRbN3yo+EWGsL8td/jQ6wE7Wlu+X1hd0Q4DjurHU
         nZNmdwyZGP5TLof7FPwTrwXhhyDoTV2TgnCGFN7Exa0c+C4+iyrCeHu1gKdG86umPb0d
         0wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742344801; x=1742949601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pF3rKAbtwRpNpJJUBHBzadk02bRgA6h529sX7PrSrVg=;
        b=Ktwt/2kYupEy0ujP4MF0SxRyDRuIZfrWy7KNFsqFcm0VlE0d4c2u3xE0GDgXBTFjws
         g3oTkuXKpdKD3l8b0OwGnNEAdE8bxccHBGchO9Qjjatso5l5pkJlhPj/aZ/kqxIBD0kd
         JKXB5gX6AOAlU0WptFYA0qvtbIAGHp2XG9vrcLkzxVP0aYZ4YJ48sbN90JrJyhZ8FdzU
         2j8VZgf1ofzz2ThziPy3z3BKITlAaA7VOt+YVn2xnkZmGzt8R2A9CvMP9fydPvHSAR1W
         jtn3Gj9H6+59ujfrd9rUNP3YyNOMSdnfJ1Gvvp5WWJtHutjwrXFhjFJ6uNEweQ5J8v2+
         o4sg==
X-Forwarded-Encrypted: i=1; AJvYcCWdPwP0uIytX0m2tqHevAHmBppnAGLrzG4B9JW1dpZ81mi0epqEhScm6Ej1/bweQI0NCNNVIWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq4Qs2x9b93Nljdm5m4RebqFQID5p5eYABLxN0KLdWAh4kvgYK
	ACQWQ28uF9YZ7fraTd5QqOrenlnsgdlaOz0mOiZBsiWtVSWrTAFqjMGogTo4rBl4c8cMDXq8HQ4
	lW2t5VadP+xoho3wsVuUuLY2KgGc=
X-Gm-Gg: ASbGncsxF5nmCmCptWdfSJzGXih7FhUF3Cd9/a3PI1pRMgLw25Zp2pglUVLNZ69TzLJ
	GhNZyYvLiNIP3ny7SeoS5/POxGSXbQXM+0wQKnWZXJrxqvGG1I3uvoCca/QsI8mpMnKf7Q7XR5N
	rnEJc6d2z2vvaSz/wGIEmkvyD2
X-Google-Smtp-Source: AGHT+IGAcD5/abo0x66lU0yq0nB2enwV8hk01y9CRBcYfmrhlYmLekhTk1f+24JvARvsR+Wy7Kv0tR1XAxoG1lqGB/I=
X-Received: by 2002:a05:6e02:2588:b0:3d0:235b:4810 with SMTP id
 e9e14a558f8ab-3d586b2a02dmr9180575ab.2.1742344801264; Tue, 18 Mar 2025
 17:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742324341.git.pav@iki.fi> <a5c1b2110e567f499e17a4a67f1cc7c2036566c4.1742324341.git.pav@iki.fi>
In-Reply-To: <a5c1b2110e567f499e17a4a67f1cc7c2036566c4.1742324341.git.pav@iki.fi>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Mar 2025 08:39:24 +0800
X-Gm-Features: AQ5f1JoMsIkIrj4zSPRTqHEHKHheFQq7_Hy24_HS7mKbWpDfPVPR9yRbt_4d_q8
Message-ID: <CAL+tcoCr-Z_PrWMsERtsm98Q4f-RXkMVzTW3S1gnNY6cFQM0Sg@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: add support for skb TX SND/COMPLETION timestamping
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 3:10=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Support enabling TX timestamping for some skbs, and track them until
> packet completion. Generate software SCM_TSTAMP_COMPLETION when getting
> completion report from hardware.
>
> Generate software SCM_TSTAMP_SND before sending to driver. Sending from
> driver requires changes in the driver API, and drivers mostly are going
> to send the skb immediately.
>
> Make the default situation with no COMPLETION TX timestamping more
> efficient by only counting packets in the queue when there is nothing to
> track.  When there is something to track, we need to make clones, since
> the driver may modify sent skbs.
>
> The tx_q queue length is bounded by the hdev flow control, which will
> not send new packets before it has got completion reports for old ones.
>
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     v5:
>     - Add hci_sockm_init()
>     - Back to decoupled COMPLETION & SND, like in v3
>     - Handle SCO flow controlled case
>
>  include/net/bluetooth/hci_core.h |  20 +++++
>  net/bluetooth/hci_conn.c         | 122 +++++++++++++++++++++++++++++++
>  net/bluetooth/hci_core.c         |  15 +++-
>  net/bluetooth/hci_event.c        |   4 +
>  4 files changed, 157 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index f78e4298e39a..5115da34f881 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -261,6 +261,12 @@ struct adv_info {
>         struct delayed_work     rpa_expired_cb;
>  };
>
> +struct tx_queue {
> +       struct sk_buff_head queue;
> +       unsigned int extra;
> +       unsigned int tracked;
> +};
> +
>  #define HCI_MAX_ADV_INSTANCES          5
>  #define HCI_DEFAULT_ADV_DURATION       2
>
> @@ -733,6 +739,8 @@ struct hci_conn {
>         struct sk_buff_head data_q;
>         struct list_head chan_list;
>
> +       struct tx_queue tx_q;
> +
>         struct delayed_work disc_work;
>         struct delayed_work auto_accept_work;
>         struct delayed_work idle_work;
> @@ -1572,6 +1580,18 @@ void hci_conn_enter_active_mode(struct hci_conn *c=
onn, __u8 force_active);
>  void hci_conn_failed(struct hci_conn *conn, u8 status);
>  u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
>
> +void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb);
> +void hci_conn_tx_dequeue(struct hci_conn *conn);
> +void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
> +                           const struct sockcm_cookie *sockc);
> +
> +static inline void hci_sockcm_init(struct sockcm_cookie *sockc, struct s=
ock *sk)
> +{
> +       *sockc =3D (struct sockcm_cookie) {
> +               .tsflags =3D READ_ONCE(sk->sk_tsflags),
> +       };
> +}
> +
>  /*
>   * hci_conn_get() and hci_conn_put() are used to control the life-time o=
f an
>   * "hci_conn" object. They do not guarantee that the hci_conn object is =
running,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index d097e308a755..95972fd4c784 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -27,6 +27,7 @@
>
>  #include <linux/export.h>
>  #include <linux/debugfs.h>
> +#include <linux/errqueue.h>
>
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -1002,6 +1003,7 @@ static struct hci_conn *__hci_conn_add(struct hci_d=
ev *hdev, int type, bdaddr_t
>         }
>
>         skb_queue_head_init(&conn->data_q);
> +       skb_queue_head_init(&conn->tx_q.queue);
>
>         INIT_LIST_HEAD(&conn->chan_list);
>         INIT_LIST_HEAD(&conn->link_list);
> @@ -1155,6 +1157,7 @@ void hci_conn_del(struct hci_conn *conn)
>         }
>
>         skb_queue_purge(&conn->data_q);
> +       skb_queue_purge(&conn->tx_q.queue);
>
>         /* Remove the connection from the list and cleanup its remaining
>          * state. This is a separate function since for some cases like
> @@ -3064,3 +3067,122 @@ int hci_abort_conn(struct hci_conn *conn, u8 reas=
on)
>          */
>         return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
>  }
> +
> +void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
> +                           const struct sockcm_cookie *sockc)
> +{
> +       struct sock *sk =3D skb ? skb->sk : NULL;
> +
> +       /* This shall be called on a single skb of those generated by use=
r
> +        * sendmsg(), and only when the sendmsg() does not return error t=
o
> +        * user. This is required for keeping the tskey that increments h=
ere in
> +        * sync with possible sendmsg() counting by user.
> +        *
> +        * Stream sockets shall set key_offset to sendmsg() length in byt=
es
> +        * and call with the last fragment, others to 1 and first fragmen=
t.
> +        */
> +
> +       if (!skb || !sockc || !sk || !key_offset)
> +               return;
> +
> +       sock_tx_timestamp(sk, sockc, &skb_shinfo(skb)->tx_flags);
> +
> +       if (sockc->tsflags & SOF_TIMESTAMPING_OPT_ID &&
> +           sockc->tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
> +               if (sockc->tsflags & SOCKCM_FLAG_TS_OPT_ID) {
> +                       skb_shinfo(skb)->tskey =3D sockc->ts_opt_id;
> +               } else {
> +                       int key =3D atomic_add_return(key_offset, &sk->sk=
_tskey);
> +
> +                       skb_shinfo(skb)->tskey =3D key - 1;
> +               }
> +       }
> +}
> +
> +void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
> +{
> +       struct tx_queue *comp =3D &conn->tx_q;
> +       bool track =3D false;
> +
> +       /* Emit SND now, ie. just before sending to driver */
> +       if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> +               __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SND)=
;

It's a bit strange that SCM_TSTAMP_SND is under the control of
SKBTX_SW_TSTAMP. Can we use the same flag for both lines here
directly? I suppose I would use SKBTX_SW_TSTAMP then.

> +
> +       /* COMPLETION tstamp is emitted for tracked skb later in Number o=
f
> +        * Completed Packets event. Available only for flow controlled ca=
ses.
> +        *
> +        * TODO: SCO support without flowctl (needs to be done in drivers=
)
> +        */
> +       switch (conn->type) {
> +       case ISO_LINK:
> +       case ACL_LINK:
> +       case LE_LINK:
> +               break;
> +       case SCO_LINK:
> +       case ESCO_LINK:
> +               if (!hci_dev_test_flag(conn->hdev, HCI_SCO_FLOWCTL))
> +                       return;
> +               break;
> +       default:
> +               return;
> +       }
> +
> +       if (skb->sk && (skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_TSTA=
MP))
> +               track =3D true;
> +
> +       /* If nothing is tracked, just count extra skbs at the queue head=
 */
> +       if (!track && !comp->tracked) {
> +               comp->extra++;
> +               return;
> +       }
> +
> +       if (track) {
> +               skb =3D skb_clone_sk(skb);
> +               if (!skb)
> +                       goto count_only;
> +
> +               comp->tracked++;
> +       } else {
> +               skb =3D skb_clone(skb, GFP_KERNEL);
> +               if (!skb)
> +                       goto count_only;
> +       }
> +
> +       skb_queue_tail(&comp->queue, skb);
> +       return;
> +
> +count_only:
> +       /* Stop tracking skbs, and only count. This will not emit timesta=
mps for
> +        * the packets, but if we get here something is more seriously wr=
ong.
> +        */
> +       comp->tracked =3D 0;
> +       comp->extra +=3D skb_queue_len(&comp->queue) + 1;
> +       skb_queue_purge(&comp->queue);
> +}
> +
> +void hci_conn_tx_dequeue(struct hci_conn *conn)
> +{
> +       struct tx_queue *comp =3D &conn->tx_q;
> +       struct sk_buff *skb;
> +
> +       /* If there are tracked skbs, the counted extra go before dequeui=
ng real
> +        * skbs, to keep ordering. When nothing is tracked, the ordering =
doesn't
> +        * matter so dequeue real skbs first to get rid of them ASAP.
> +        */
> +       if (comp->extra && (comp->tracked || skb_queue_empty(&comp->queue=
))) {
> +               comp->extra--;
> +               return;
> +       }
> +
> +       skb =3D skb_dequeue(&comp->queue);
> +       if (!skb)
> +               return;
> +
> +       if (skb->sk) {
> +               comp->tracked--;

Need an explicit if statement here?

> +               __skb_tstamp_tx(skb, NULL, NULL, skb->sk,
> +                               SCM_TSTAMP_COMPLETION);

This is the socket timestamping, and that's right. My minor question
is: for the use of bpf timestamping (that should be easy as you've
done in patch 1, I presume), I'm not sure if you're familiar with it.
If not, I plan to implement it myself in a follow-up patch and then
let you do some tests? Of course, I will provide the bpf test script
:)

Thanks,
Jason

> +       }
> +
> +       kfree_skb(skb);
> +}
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 94d9147612da..5eb0600bbd03 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3029,6 +3029,13 @@ static int hci_send_frame(struct hci_dev *hdev, st=
ruct sk_buff *skb)
>         return 0;
>  }
>
> +static int hci_send_conn_frame(struct hci_dev *hdev, struct hci_conn *co=
nn,
> +                              struct sk_buff *skb)
> +{
> +       hci_conn_tx_queue(conn, skb);
> +       return hci_send_frame(hdev, skb);
> +}
> +
>  /* Send HCI command */
>  int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
>                  const void *param)
> @@ -3575,7 +3582,7 @@ static void hci_sched_sco(struct hci_dev *hdev, __u=
8 type)
>         while (*cnt && (conn =3D hci_low_sent(hdev, type, &quote))) {
>                 while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
>                         BT_DBG("skb %p len %d", skb, skb->len);
> -                       hci_send_frame(hdev, skb);
> +                       hci_send_conn_frame(hdev, conn, skb);
>
>                         conn->sent++;
>                         if (conn->sent =3D=3D ~0)
> @@ -3618,7 +3625,7 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
>                         hci_conn_enter_active_mode(chan->conn,
>                                                    bt_cb(skb)->force_acti=
ve);
>
> -                       hci_send_frame(hdev, skb);
> +                       hci_send_conn_frame(hdev, chan->conn, skb);
>                         hdev->acl_last_tx =3D jiffies;
>
>                         hdev->acl_cnt--;
> @@ -3674,7 +3681,7 @@ static void hci_sched_le(struct hci_dev *hdev)
>
>                         skb =3D skb_dequeue(&chan->data_q);
>
> -                       hci_send_frame(hdev, skb);
> +                       hci_send_conn_frame(hdev, chan->conn, skb);
>                         hdev->le_last_tx =3D jiffies;
>
>                         (*cnt)--;
> @@ -3708,7 +3715,7 @@ static void hci_sched_iso(struct hci_dev *hdev)
>         while (*cnt && (conn =3D hci_low_sent(hdev, ISO_LINK, &quote))) {
>                 while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
>                         BT_DBG("skb %p len %d", skb, skb->len);
> -                       hci_send_frame(hdev, skb);
> +                       hci_send_conn_frame(hdev, conn, skb);
>
>                         conn->sent++;
>                         if (conn->sent =3D=3D ~0)
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 0df4a0e082c8..83990c975c1f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4415,6 +4415,7 @@ static void hci_num_comp_pkts_evt(struct hci_dev *h=
dev, void *data,
>                 struct hci_comp_pkts_info *info =3D &ev->handles[i];
>                 struct hci_conn *conn;
>                 __u16  handle, count;
> +               unsigned int i;
>
>                 handle =3D __le16_to_cpu(info->handle);
>                 count  =3D __le16_to_cpu(info->count);
> @@ -4425,6 +4426,9 @@ static void hci_num_comp_pkts_evt(struct hci_dev *h=
dev, void *data,
>
>                 conn->sent -=3D count;
>
> +               for (i =3D 0; i < count; ++i)
> +                       hci_conn_tx_dequeue(conn);
> +
>                 switch (conn->type) {
>                 case ACL_LINK:
>                         hdev->acl_cnt +=3D count;
> --
> 2.48.1
>
>

