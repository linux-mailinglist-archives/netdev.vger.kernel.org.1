Return-Path: <netdev+bounces-164559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DD6A2E3BE
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 06:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED81518868B0
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 05:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1891F190072;
	Mon, 10 Feb 2025 05:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7OnH5ur"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA711946C8;
	Mon, 10 Feb 2025 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739165981; cv=none; b=AJSzlSPJJaazd2BCy4vbXbaZN6j0TH9EvZzX9CLaxCk3L2C/z9X9qow3G95CePZXgpBIFQEk1xS+KNOfOq7s8DJ+F8IFurk34mzgVyBsmlJWltlTjhMHcmCQPqBu8iiuzSPktduG67s4kj06IT45j+UGe+vOwPril04JBWijT+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739165981; c=relaxed/simple;
	bh=X1J06BPBmQ30XZ7Y3k8sU2PycwOxaHC5sCgx9Zw9vMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaOJ6KbU5Ijhr9qcJEtfJh9zEttOyp7IINjjnM3xOvqi8Kx7Wc8qrokRra9xkM1LyXIpOuvB0/LEkslq1cMew26JEylrtvkM1xkAOwjsnREzXEfF9S0a3vv1esvu7yMFtDgnA9eU3D9WIjN4Ovb6Fm+Rfq6uXD/ZU289zMYaoDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7OnH5ur; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso13180025ab.1;
        Sun, 09 Feb 2025 21:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739165978; x=1739770778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnyPEqWN8H3LUc+08QvTCnoMRygSKI8+a3GL2Cg+x7I=;
        b=f7OnH5uriQS7NxqHEkR94ZHYlg13CQTUcFkcIGj/BlpucuvpCn2SZLyznATa9ClFQG
         3IWHl2cTXc2RDwTJSghmJZAAAeHVhiUnckU+FFQEWgx9QmISz1R3rrFNHACdgHKPSRqD
         FKNjurvXUmdJ46i671V5zgH7AcMmlKGD9nHmjA5wLkeCxM67yJFKdbOq+amDOJcpVTE2
         BT/Bcwoi2CX/r+hlAiccjLSQdB7TkiGy5kcAs5Cfhl72YEgMGrEzeOi8jNzGo2BnRIBr
         Pux7KeIXTtyyDYO5COO0wbwYLyZ9aKlqejA9a8euLOTaRA03Ij3hSQhLREvF1woyH64w
         hMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739165978; x=1739770778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnyPEqWN8H3LUc+08QvTCnoMRygSKI8+a3GL2Cg+x7I=;
        b=K1IMh/iMRdLElu2cC197P4Bi5WFJ89q2nvxc9WngDevUrwLkQgyGfgKloXbW3MhjVk
         5Pkx11r3Au2RF1DfUXpx1mB8Xyo+ObbgNwbtnm7Pvfu990U/Nxlk8YIUpb0Y1Mv+fqrv
         hzC3hr5uVb9UFvZCZsBCbuNzmWD1Y+TkXcxx2u4hu1b804WKglm+ORoYx7CbVcVPcRGL
         uolFzOVIPneISMRvOQwU36QH6uCsDIPKyP517mQsTfITAD6BsXm26c8bdd21FrIJJwMV
         IdeKNGXK3IJ48YdbT/Ep1iEEP86JmeJtBqhZlW2M9spsiTsWidV3P3S4fpqPPe/LRAWh
         pZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCX6FydOKP/N7dugMfpS/15ML81UCFsNInXE+E5FCCSZKZEDXIJgrQnSuj1IFOu04oL5kUmhHkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9cHofCRvfWxvmG5w4i4leoibZiZhw9mOrCjvnN4qO5xIj829
	P0xaiKxfovRm1Fje+xQRQoE2vVVUAQMeWIF4RRSVbnAr3El2nykYx6ePyEe4yhK+NbnDnHGrM/Y
	CbEs+oEm1qyslx1SP5PgEHMx9zk8=
X-Gm-Gg: ASbGncuPZZWd3lkIG8tNHtSdy/W5/io1YTTgZvALHFgLIwY3kZSTyE+yngiyALE1v4+
	FxD6P1RkYmATcgZlWj4w271fTNRxj/wJvOryvTmU9Vq/QL36CLs4ghkPXL4Qc48sY4lfDFc+/
X-Google-Smtp-Source: AGHT+IF/o3VIRkWhVwlpgrJOPdANxr3zGKb7vLyjK6s4plJiIpL9nPCjiHNavQVaMe2MWxbirVXzPXjyxJS9Px4Hhfk=
X-Received: by 2002:a05:6e02:12c1:b0:3cf:b9b8:5052 with SMTP id
 e9e14a558f8ab-3d13dcd8ffamr97028605ab.3.1739165978024; Sun, 09 Feb 2025
 21:39:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739097311.git.pav@iki.fi> <8a23a01e5d323df4907b5f5d08995d4bee86a391.1739097311.git.pav@iki.fi>
In-Reply-To: <8a23a01e5d323df4907b5f5d08995d4bee86a391.1739097311.git.pav@iki.fi>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 10 Feb 2025 13:39:00 +0800
X-Gm-Features: AWEUYZk8TuCONW_npJybrjwgWpKdvewR9erdmcGrq9Njp_PPouV8ALbojTOhDnk
Message-ID: <CAL+tcoCHfAbxCLjF2M-K6Zqj9q1rCFuXcdgO8Eb_tBMDsSYAxw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] Bluetooth: add support for skb TX SND/COMPLETION timestamping
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 9, 2025 at 6:40=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
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
>  include/net/bluetooth/hci_core.h |  13 ++++
>  net/bluetooth/hci_conn.c         | 117 +++++++++++++++++++++++++++++++
>  net/bluetooth/hci_core.c         |  17 +++--
>  net/bluetooth/hci_event.c        |   4 ++
>  4 files changed, 146 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 05919848ea95..1f539a9881ad 100644
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
> @@ -1571,6 +1579,11 @@ void hci_conn_enter_active_mode(struct hci_conn *c=
onn, __u8 force_active);
>  void hci_conn_failed(struct hci_conn *conn, u8 status);
>  u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
>
> +void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb);
> +void hci_conn_tx_dequeue(struct hci_conn *conn);
> +void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
> +                           const struct sockcm_cookie *sockc);
> +
>  /*
>   * hci_conn_get() and hci_conn_put() are used to control the life-time o=
f an
>   * "hci_conn" object. They do not guarantee that the hci_conn object is =
running,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index d097e308a755..e437290d8b70 100644
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
> @@ -3064,3 +3067,117 @@ int hci_abort_conn(struct hci_conn *conn, u8 reas=
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

Will applications take control of managing the tskey on their own
instead of kernel in the future?

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
> +       if (skb->sk && (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP))

Nit: I think it's not necessary to test if skb->sk is NULL here since
__skb_tstamp_tx() will do the check.

> +               __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SND)=
;
> +
> +       /* COMPLETION tstamp is emitted for tracked skb later in Number o=
f
> +        * Completed Packets event. Available only for flow controlled ca=
ses.
> +        *
> +        * TODO: SCO support (needs to be done in drivers)
> +        */
> +       switch (conn->type) {
> +       case ISO_LINK:
> +       case ACL_LINK:
> +       case LE_LINK:
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
> +               __skb_tstamp_tx(skb, NULL, NULL, skb->sk,
> +                               SCM_TSTAMP_COMPLETION);
> +       }
> +
> +       kfree_skb(skb);
> +}
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index e7ec12437c8b..e0845188f626 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3025,6 +3025,13 @@ static int hci_send_frame(struct hci_dev *hdev, st=
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
> @@ -3562,7 +3569,7 @@ static void hci_sched_sco(struct hci_dev *hdev)
>         while (hdev->sco_cnt && (conn =3D hci_low_sent(hdev, SCO_LINK, &q=
uote))) {
>                 while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
>                         BT_DBG("skb %p len %d", skb, skb->len);
> -                       hci_send_frame(hdev, skb);
> +                       hci_send_conn_frame(hdev, conn, skb);
>
>                         conn->sent++;
>                         if (conn->sent =3D=3D ~0)
> @@ -3586,7 +3593,7 @@ static void hci_sched_esco(struct hci_dev *hdev)
>                                                      &quote))) {
>                 while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
>                         BT_DBG("skb %p len %d", skb, skb->len);
> -                       hci_send_frame(hdev, skb);
> +                       hci_send_conn_frame(hdev, conn, skb);
>
>                         conn->sent++;
>                         if (conn->sent =3D=3D ~0)
> @@ -3620,7 +3627,7 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
>                         hci_conn_enter_active_mode(chan->conn,
>                                                    bt_cb(skb)->force_acti=
ve);
>
> -                       hci_send_frame(hdev, skb);
> +                       hci_send_conn_frame(hdev, chan->conn, skb);
>                         hdev->acl_last_tx =3D jiffies;
>
>                         hdev->acl_cnt--;
> @@ -3676,7 +3683,7 @@ static void hci_sched_le(struct hci_dev *hdev)
>
>                         skb =3D skb_dequeue(&chan->data_q);
>
> -                       hci_send_frame(hdev, skb);
> +                       hci_send_conn_frame(hdev, chan->conn, skb);
>                         hdev->le_last_tx =3D jiffies;
>
>                         (*cnt)--;
> @@ -3710,7 +3717,7 @@ static void hci_sched_iso(struct hci_dev *hdev)
>         while (*cnt && (conn =3D hci_low_sent(hdev, ISO_LINK, &quote))) {
>                 while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
>                         BT_DBG("skb %p len %d", skb, skb->len);
> -                       hci_send_frame(hdev, skb);
> +                       hci_send_conn_frame(hdev, conn, skb);
>
>                         conn->sent++;
>                         if (conn->sent =3D=3D ~0)
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 2cc7a9306350..144b442180f7 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4405,6 +4405,7 @@ static void hci_num_comp_pkts_evt(struct hci_dev *h=
dev, void *data,
>                 struct hci_comp_pkts_info *info =3D &ev->handles[i];
>                 struct hci_conn *conn;
>                 __u16  handle, count;
> +               unsigned int i;
>
>                 handle =3D __le16_to_cpu(info->handle);
>                 count  =3D __le16_to_cpu(info->count);
> @@ -4415,6 +4416,9 @@ static void hci_num_comp_pkts_evt(struct hci_dev *h=
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

