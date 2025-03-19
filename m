Return-Path: <netdev+bounces-176247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1903A697E2
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCD5427266
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7891E5B8A;
	Wed, 19 Mar 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="e6cLqBdk"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385221B2194;
	Wed, 19 Mar 2025 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408517; cv=pass; b=LClwpZpMxaOl/W0eIqEKgx4a8wjOGjap9+hriiRT9TTeUzHTMJZ9WVW9aNC1N7sXGsZ295CJVCSsnhIQyA9XFarbx0Zj9COQPqcTE3XOaZIFYcRJeuqBKd5yTuQSkx1hpszGxX5wWoKbn5vZesZpe3FH1hnyKNtK5fEx6tKQzME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408517; c=relaxed/simple;
	bh=TkSpyenTBeOjSOlCVkpdDm2zboMOPBCnaDHkA82P2+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MT8Uk6UPnwfLZXC50wYl3K0gu1Mhg3OD70W+FtRDiqsBfUqgw1YqjaGlVF/OIEF0FGKL74FFlZW6fyzKne54nqt5kZdmRqUMEberbWPVQG9R/gpIEB28Q4eL3tQQb890qCKlhfk2y4Dm+1r2rLmmuRBTgqQatMoXQf4jG+ByuQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=e6cLqBdk; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZHxqy63LWz49Q8B;
	Wed, 19 Mar 2025 20:21:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742408512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8JmU2u8GZ5AvPQHn2ZkNkJ9pb5K3WnLjMnWPwP7+EQE=;
	b=e6cLqBdkB27MuNzyMh1y8vJtU2dhlY0ooWDmdzC/R3jNlAEqzN2H61ZeLPcJzk096BPM+4
	CB1Yq0zkgui/hqA7Ts2a84iJ6ObxKIS3nKalWeEo3EMT+EDP50hw9wm0u32zUMfQQj9gil
	ldltPBnzDvgemhs+5mYby0YAe3E2bCUxGqStxQCKR/I4gaD1nQ61zollG8vNrACfaKfXvk
	BkO369RVvVTTb+lVNaZtx+qtodUrZVdBUlhX0A7irP7hbRYWkKTwDUayAbMgh66Xgdbnh0
	YBZwUD5W2QkacbDLTR3AD8IRRvgNeOPKOwaRoYMQybj78WSvJuS607TdLd70bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1742408511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8JmU2u8GZ5AvPQHn2ZkNkJ9pb5K3WnLjMnWPwP7+EQE=;
	b=jS8zfqW0Q8/xYlhxp/dp7cA2xKLdiiJpqRQguVWFia3/cKlF8NWpQWUn5oibtNNMfKYcnY
	3NFEb/KLikCpgjma23T3+275RUj2kOre3bhvp2nEzV/WWitTELX+ieBpH7e44Jz95XkBuK
	Y4FVWoiV9JQugYWz5bhRGssO6g+/q1BSVRVq51qC5YBdDFU0FA2S9zA3wfpdV4VH81YdAi
	wDadUl/G2tosee7k6tnsbz8JGN1GoZFVlGR28pNDJLNNuskzTiuzVkkMKuJzgDdXNp63I8
	WrOhLP60kiRPGuCMQju77O7mSTMQv7uqp786evu6ve3ou3/ND5GqOH1zoy6Z7g==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1742408512; a=rsa-sha256;
	cv=none;
	b=ptJHAgEjtOnAZIGvtHeJKDjLfuj/UDtSFTj2PWemUiaB7UuMN23OeV54CDwZGMk/6+OWx6
	5M8X0UZk+cie4mX14u6jCRNnWfzjvatpEwkmRDYddYO6Uk20ceAkFs+VU0EQsrkUYET4Oa
	bLlH8MZ1edXDCjNmj8iprK2lpZu6fmzOB0wCz6zhpX4Pbul9w+VKHeOIT4Jm649Zyhx2gp
	K0/PEOmyRlMLQDv4OHnj8W9RAN9KzVAGqwb/92Avy+ANInN0j7vVtPTo/zy/VFWFDyY8pU
	4yLjUTGuQs/i0QToibV4GDxX97aEjCCKZVR45yR5Pq4Zj4qnIDwiD9fEUDkalA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <51825f597184a8010aa66f58b00c291d2bca75f7.camel@iki.fi>
Subject: Re: [PATCH v5 2/5] Bluetooth: add support for skb TX SND/COMPLETION
 timestamping
From: Pauli Virtanen <pav@iki.fi>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, willemdebruijn.kernel@gmail.com
Date: Wed, 19 Mar 2025 20:21:49 +0200
In-Reply-To: <CAL+tcoCr-Z_PrWMsERtsm98Q4f-RXkMVzTW3S1gnNY6cFQM0Sg@mail.gmail.com>
References: <cover.1742324341.git.pav@iki.fi>
	 <a5c1b2110e567f499e17a4a67f1cc7c2036566c4.1742324341.git.pav@iki.fi>
	 <CAL+tcoCr-Z_PrWMsERtsm98Q4f-RXkMVzTW3S1gnNY6cFQM0Sg@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2025-03-19 kello 08:39 +0800, Jason Xing kirjoitti:
> On Wed, Mar 19, 2025 at 3:10=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Support enabling TX timestamping for some skbs, and track them until
> > packet completion. Generate software SCM_TSTAMP_COMPLETION when getting
> > completion report from hardware.
> >=20
> > Generate software SCM_TSTAMP_SND before sending to driver. Sending from
> > driver requires changes in the driver API, and drivers mostly are going
> > to send the skb immediately.
> >=20
> > Make the default situation with no COMPLETION TX timestamping more
> > efficient by only counting packets in the queue when there is nothing t=
o
> > track.  When there is something to track, we need to make clones, since
> > the driver may modify sent skbs.
> >=20
> > The tx_q queue length is bounded by the hdev flow control, which will
> > not send new packets before it has got completion reports for old ones.
> >=20
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >=20
> > Notes:
> >     v5:
> >     - Add hci_sockm_init()
> >     - Back to decoupled COMPLETION & SND, like in v3
> >     - Handle SCO flow controlled case
> >=20
> >  include/net/bluetooth/hci_core.h |  20 +++++
> >  net/bluetooth/hci_conn.c         | 122 +++++++++++++++++++++++++++++++
> >  net/bluetooth/hci_core.c         |  15 +++-
> >  net/bluetooth/hci_event.c        |   4 +
> >  4 files changed, 157 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index f78e4298e39a..5115da34f881 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -261,6 +261,12 @@ struct adv_info {
> >         struct delayed_work     rpa_expired_cb;
> >  };
> >=20
> > +struct tx_queue {
> > +       struct sk_buff_head queue;
> > +       unsigned int extra;
> > +       unsigned int tracked;
> > +};
> > +
> >  #define HCI_MAX_ADV_INSTANCES          5
> >  #define HCI_DEFAULT_ADV_DURATION       2
> >=20
> > @@ -733,6 +739,8 @@ struct hci_conn {
> >         struct sk_buff_head data_q;
> >         struct list_head chan_list;
> >=20
> > +       struct tx_queue tx_q;
> > +
> >         struct delayed_work disc_work;
> >         struct delayed_work auto_accept_work;
> >         struct delayed_work idle_work;
> > @@ -1572,6 +1580,18 @@ void hci_conn_enter_active_mode(struct hci_conn =
*conn, __u8 force_active);
> >  void hci_conn_failed(struct hci_conn *conn, u8 status);
> >  u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
> >=20
> > +void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb);
> > +void hci_conn_tx_dequeue(struct hci_conn *conn);
> > +void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
> > +                           const struct sockcm_cookie *sockc);
> > +
> > +static inline void hci_sockcm_init(struct sockcm_cookie *sockc, struct=
 sock *sk)
> > +{
> > +       *sockc =3D (struct sockcm_cookie) {
> > +               .tsflags =3D READ_ONCE(sk->sk_tsflags),
> > +       };
> > +}
> > +
> >  /*
> >   * hci_conn_get() and hci_conn_put() are used to control the life-time=
 of an
> >   * "hci_conn" object. They do not guarantee that the hci_conn object i=
s running,
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index d097e308a755..95972fd4c784 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -27,6 +27,7 @@
> >=20
> >  #include <linux/export.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/errqueue.h>
> >=20
> >  #include <net/bluetooth/bluetooth.h>
> >  #include <net/bluetooth/hci_core.h>
> > @@ -1002,6 +1003,7 @@ static struct hci_conn *__hci_conn_add(struct hci=
_dev *hdev, int type, bdaddr_t
> >         }
> >=20
> >         skb_queue_head_init(&conn->data_q);
> > +       skb_queue_head_init(&conn->tx_q.queue);
> >=20
> >         INIT_LIST_HEAD(&conn->chan_list);
> >         INIT_LIST_HEAD(&conn->link_list);
> > @@ -1155,6 +1157,7 @@ void hci_conn_del(struct hci_conn *conn)
> >         }
> >=20
> >         skb_queue_purge(&conn->data_q);
> > +       skb_queue_purge(&conn->tx_q.queue);
> >=20
> >         /* Remove the connection from the list and cleanup its remainin=
g
> >          * state. This is a separate function since for some cases like
> > @@ -3064,3 +3067,122 @@ int hci_abort_conn(struct hci_conn *conn, u8 re=
ason)
> >          */
> >         return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL)=
;
> >  }
> > +
> > +void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
> > +                           const struct sockcm_cookie *sockc)
> > +{
> > +       struct sock *sk =3D skb ? skb->sk : NULL;
> > +
> > +       /* This shall be called on a single skb of those generated by u=
ser
> > +        * sendmsg(), and only when the sendmsg() does not return error=
 to
> > +        * user. This is required for keeping the tskey that increments=
 here in
> > +        * sync with possible sendmsg() counting by user.
> > +        *
> > +        * Stream sockets shall set key_offset to sendmsg() length in b=
ytes
> > +        * and call with the last fragment, others to 1 and first fragm=
ent.
> > +        */
> > +
> > +       if (!skb || !sockc || !sk || !key_offset)
> > +               return;
> > +
> > +       sock_tx_timestamp(sk, sockc, &skb_shinfo(skb)->tx_flags);
> > +
> > +       if (sockc->tsflags & SOF_TIMESTAMPING_OPT_ID &&
> > +           sockc->tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
> > +               if (sockc->tsflags & SOCKCM_FLAG_TS_OPT_ID) {
> > +                       skb_shinfo(skb)->tskey =3D sockc->ts_opt_id;
> > +               } else {
> > +                       int key =3D atomic_add_return(key_offset, &sk->=
sk_tskey);
> > +
> > +                       skb_shinfo(skb)->tskey =3D key - 1;
> > +               }
> > +       }
> > +}
> > +
> > +void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
> > +{
> > +       struct tx_queue *comp =3D &conn->tx_q;
> > +       bool track =3D false;
> > +
> > +       /* Emit SND now, ie. just before sending to driver */
> > +       if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> > +               __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SN=
D);
>=20
> It's a bit strange that SCM_TSTAMP_SND is under the control of
> SKBTX_SW_TSTAMP. Can we use the same flag for both lines here
> directly? I suppose I would use SKBTX_SW_TSTAMP then.

This is more or less open-coded skb_tx_timestamp(), which drivers do
before sending to HW, for the Bluetooth case. AFAIK it should be done
like this.

>=20
> > +
> > +       /* COMPLETION tstamp is emitted for tracked skb later in Number=
 of
> > +        * Completed Packets event. Available only for flow controlled =
cases.
> > +        *
> > +        * TODO: SCO support without flowctl (needs to be done in drive=
rs)
> > +        */
> > +       switch (conn->type) {
> > +       case ISO_LINK:
> > +       case ACL_LINK:
> > +       case LE_LINK:
> > +               break;
> > +       case SCO_LINK:
> > +       case ESCO_LINK:
> > +               if (!hci_dev_test_flag(conn->hdev, HCI_SCO_FLOWCTL))
> > +                       return;
> > +               break;
> > +       default:
> > +               return;
> > +       }
> > +
> > +       if (skb->sk && (skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_TS=
TAMP))
> > +               track =3D true;
> > +
> > +       /* If nothing is tracked, just count extra skbs at the queue he=
ad */
> > +       if (!track && !comp->tracked) {
> > +               comp->extra++;
> > +               return;
> > +       }
> > +
> > +       if (track) {
> > +               skb =3D skb_clone_sk(skb);
> > +               if (!skb)
> > +                       goto count_only;
> > +
> > +               comp->tracked++;
> > +       } else {
> > +               skb =3D skb_clone(skb, GFP_KERNEL);
> > +               if (!skb)
> > +                       goto count_only;
> > +       }
> > +
> > +       skb_queue_tail(&comp->queue, skb);
> > +       return;
> > +
> > +count_only:
> > +       /* Stop tracking skbs, and only count. This will not emit times=
tamps for
> > +        * the packets, but if we get here something is more seriously =
wrong.
> > +        */
> > +       comp->tracked =3D 0;
> > +       comp->extra +=3D skb_queue_len(&comp->queue) + 1;
> > +       skb_queue_purge(&comp->queue);
> > +}
> > +
> > +void hci_conn_tx_dequeue(struct hci_conn *conn)
> > +{
> > +       struct tx_queue *comp =3D &conn->tx_q;
> > +       struct sk_buff *skb;
> > +
> > +       /* If there are tracked skbs, the counted extra go before deque=
uing real
> > +        * skbs, to keep ordering. When nothing is tracked, the orderin=
g doesn't
> > +        * matter so dequeue real skbs first to get rid of them ASAP.
> > +        */
> > +       if (comp->extra && (comp->tracked || skb_queue_empty(&comp->que=
ue))) {
> > +               comp->extra--;
> > +               return;
> > +       }
> > +
> > +       skb =3D skb_dequeue(&comp->queue);
> > +       if (!skb)
> > +               return;
> > +
> > +       if (skb->sk) {
> > +               comp->tracked--;
>=20
> Need an explicit if statement here?

I think no, see explanation of how it works in the reply to Willem:
https://lore.kernel.org/linux-bluetooth/5882af942ef8cf5c9b4ce36a348f959807a=
387b0.camel@iki.fi/

> > +               __skb_tstamp_tx(skb, NULL, NULL, skb->sk,
> > +                               SCM_TSTAMP_COMPLETION);
>=20
> This is the socket timestamping, and that's right. My minor question
> is: for the use of bpf timestamping (that should be easy as you've
> done in patch 1, I presume), I'm not sure if you're familiar with it.
> If not, I plan to implement it myself in a follow-up patch and then
> let you do some tests? Of course, I will provide the bpf test script

I saw the BPF timestamping things, but didn't look in full detail yet.
I don't know much about BPF, but IIUC, is it just as simple as adding
BPF_SOCK_OPS_TSTAMP_COMPLETION_CB and then modifying
skb_tstamp_tx_report_bpf_timestamping() accordingly?

I think we'd want to add also the BPF tests in the Bluetooth socket
timestamping tests

https://web.git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/test-runner=
.rst
https://web.git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/tester.h#=
n91
https://web.git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/iso-teste=
r.c#n2275
https://web.git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/sco-teste=
r.c#n755
https://web.git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/l2cap-tes=
ter.c#n1369

If you could show an example how to setup the BPF tstamps and pass the
resulting tstamp data in some way back to the application, that could
be very helpful (and I could postpone learning BPF for a little while
longer :)

> :)
>=20
> Thanks,
> Jason
>=20
> > +       }
> > +
> > +       kfree_skb(skb);
> > +}
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 94d9147612da..5eb0600bbd03 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3029,6 +3029,13 @@ static int hci_send_frame(struct hci_dev *hdev, =
struct sk_buff *skb)
> >         return 0;
> >  }
> >=20
> > +static int hci_send_conn_frame(struct hci_dev *hdev, struct hci_conn *=
conn,
> > +                              struct sk_buff *skb)
> > +{
> > +       hci_conn_tx_queue(conn, skb);
> > +       return hci_send_frame(hdev, skb);
> > +}
> > +
> >  /* Send HCI command */
> >  int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
> >                  const void *param)
> > @@ -3575,7 +3582,7 @@ static void hci_sched_sco(struct hci_dev *hdev, _=
_u8 type)
> >         while (*cnt && (conn =3D hci_low_sent(hdev, type, &quote))) {
> >                 while (quote-- && (skb =3D skb_dequeue(&conn->data_q)))=
 {
> >                         BT_DBG("skb %p len %d", skb, skb->len);
> > -                       hci_send_frame(hdev, skb);
> > +                       hci_send_conn_frame(hdev, conn, skb);
> >=20
> >                         conn->sent++;
> >                         if (conn->sent =3D=3D ~0)
> > @@ -3618,7 +3625,7 @@ static void hci_sched_acl_pkt(struct hci_dev *hde=
v)
> >                         hci_conn_enter_active_mode(chan->conn,
> >                                                    bt_cb(skb)->force_ac=
tive);
> >=20
> > -                       hci_send_frame(hdev, skb);
> > +                       hci_send_conn_frame(hdev, chan->conn, skb);
> >                         hdev->acl_last_tx =3D jiffies;
> >=20
> >                         hdev->acl_cnt--;
> > @@ -3674,7 +3681,7 @@ static void hci_sched_le(struct hci_dev *hdev)
> >=20
> >                         skb =3D skb_dequeue(&chan->data_q);
> >=20
> > -                       hci_send_frame(hdev, skb);
> > +                       hci_send_conn_frame(hdev, chan->conn, skb);
> >                         hdev->le_last_tx =3D jiffies;
> >=20
> >                         (*cnt)--;
> > @@ -3708,7 +3715,7 @@ static void hci_sched_iso(struct hci_dev *hdev)
> >         while (*cnt && (conn =3D hci_low_sent(hdev, ISO_LINK, &quote)))=
 {
> >                 while (quote-- && (skb =3D skb_dequeue(&conn->data_q)))=
 {
> >                         BT_DBG("skb %p len %d", skb, skb->len);
> > -                       hci_send_frame(hdev, skb);
> > +                       hci_send_conn_frame(hdev, conn, skb);
> >=20
> >                         conn->sent++;
> >                         if (conn->sent =3D=3D ~0)
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 0df4a0e082c8..83990c975c1f 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -4415,6 +4415,7 @@ static void hci_num_comp_pkts_evt(struct hci_dev =
*hdev, void *data,
> >                 struct hci_comp_pkts_info *info =3D &ev->handles[i];
> >                 struct hci_conn *conn;
> >                 __u16  handle, count;
> > +               unsigned int i;
> >=20
> >                 handle =3D __le16_to_cpu(info->handle);
> >                 count  =3D __le16_to_cpu(info->count);
> > @@ -4425,6 +4426,9 @@ static void hci_num_comp_pkts_evt(struct hci_dev =
*hdev, void *data,
> >=20
> >                 conn->sent -=3D count;
> >=20
> > +               for (i =3D 0; i < count; ++i)
> > +                       hci_conn_tx_dequeue(conn);
> > +
> >                 switch (conn->type) {
> >                 case ACL_LINK:
> >                         hdev->acl_cnt +=3D count;
> > --
> > 2.48.1
> >=20
> >=20

--=20
Pauli Virtanen

