Return-Path: <netdev+bounces-176357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D242A69D36
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 01:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034239003B6
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 00:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722C42C1A2;
	Thu, 20 Mar 2025 00:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb63N2nv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BE579F2;
	Thu, 20 Mar 2025 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742430384; cv=none; b=p2jqwqJzqL5Nf+AnycbpG6I9srRG6fWYIONjpL12sOpwoyCt4BQz0qEcVswAYfQwQSZEky/6jTBG/ubgl9qFXZ5kbdQGHzUueZODJGc3jkkqlMGjmiaH1rZLtIRzh1Jfdl+0ooGZ9B/nqH/SZmIHJfGbpUdzKJOrp+ze1RWi/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742430384; c=relaxed/simple;
	bh=k7n1HmYFIGTnB6PpbETMXV/UAeLFqhxbqsDeafeELuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCQne89SHWB5FRBbRFcYtHK05evXfx6I4LPZS3DR2zhsRwygQzbVboCanNBieZLjaubctwFmZVruvt7+1J+tPZSOteqXC1XPrhe7+hbYHo570p4JeDPORWZeGcuCnYIl63reL/NYhj54D2us1MSPGj+OIe8ttA6tIf5FY25FajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb63N2nv; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d434c84b7eso1930125ab.1;
        Wed, 19 Mar 2025 17:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742430381; x=1743035181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GD/QUahzlel9pVjJyBVH4IBTVWFPytZXyyZma6xeJ8=;
        b=hb63N2nvTAAmwvOuxvkzXHPhSfLUSsETf1UXnw0wbBMRU75ZSHwAGcqWSlaH0GOYhv
         UFGd6+VlIqaSsMxj544xF2wYq/KoxzT0yG+ouNxo38mlqja9zJjMYLcvsQpMlMmS27Ad
         gy+OZYIdDix/jZQOQlhC2wCsiZ9nMBhDVhanrLgJzmCu9/wBadxz12Zb+pjGSoCWb7Cc
         ljHI2w5bg2pmLYQ32PUAmS6TH13SxDHt4h5kfgJCKK1GGN3YAv+snYRbXjUPZNRxGQgf
         J/yeZLlRZndCqhfcQFB0M0/IYX6jm+ovzJCk3QfqxNxTByWjV4HG7vb1veAYGG4O3QxQ
         BXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742430381; x=1743035181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GD/QUahzlel9pVjJyBVH4IBTVWFPytZXyyZma6xeJ8=;
        b=OXOB8d10cJhFn6SDwUXd3/dDmabFB6YFz3azpdnRL1jKNymZ9roxURnDGTIc44U8GG
         EftiqgCAEwXg+D4j9B0bxpTT+9YxLGnyo5mbfTwdq5RfjhMUhzCYURQI24T+PfcB4I3F
         U+UosLPkWzm+VgFjhgNvaEQPodLIsOqmXj4jN8QqoghO14+TG56Hl4FQ3vPxSfcQytVK
         MEsTXui84v4uxxlJPoCOPh3Nr99EvkFxxV6NQTmks7zR0wfuKlATk/eMESiMJ7zCvyal
         R0/QsuFDR5HtShfEqxheQRMZuMCr++JUN7n320wOT9FPZU2qYWxTvGgpqk9lklDGlHZa
         SQOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeEUAEBQLw2xYLSyRFJdDbC6NNt+caWJHOl70rbXIGPnrwMkyYhaQ4JD+mzyt5pfaUffsaOlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5B+XwMqmwbKX9coOGxqTPBHczaCdnLb7WYXEpvSAWy8Ehm9pz
	3MA8ks8h7AjGeKjOU/brDDFowGxuuL++j7m1+tBgruyts7Qd/xc1z7tznJQ2YKq+QJEyBA3Jvq8
	R16ie+U8QElnvNvhAIvi3eTEsPXk=
X-Gm-Gg: ASbGncvGIzPItgCIrozxN09c8lLtAdZC2zIZ9CPmJrFTLepQY8x5ODSfnkSmHhX3DMX
	VoRwHBLLD5INmmkfcNWW5+EvqG8UKT3+NvWA3p3Nuf0qr/+QbSTazY6YXqs+THTNr9PPGXMPXQo
	ZufT5PRPc7AqxWIcbn+mFznJFH
X-Google-Smtp-Source: AGHT+IFI5KA+lLU1anJ9meBQEFYqnPSrmISES7DL9BipJri6b/n//Y1VGsK3WYtBthA0arRT83uYyc3UY6h46vt8mEk=
X-Received: by 2002:a92:c26e:0:b0:3a7:88f2:cfa9 with SMTP id
 e9e14a558f8ab-3d586b59993mr37800245ab.11.1742430381212; Wed, 19 Mar 2025
 17:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742324341.git.pav@iki.fi> <a5c1b2110e567f499e17a4a67f1cc7c2036566c4.1742324341.git.pav@iki.fi>
 <CAL+tcoCr-Z_PrWMsERtsm98Q4f-RXkMVzTW3S1gnNY6cFQM0Sg@mail.gmail.com> <51825f597184a8010aa66f58b00c291d2bca75f7.camel@iki.fi>
In-Reply-To: <51825f597184a8010aa66f58b00c291d2bca75f7.camel@iki.fi>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Mar 2025 08:25:45 +0800
X-Gm-Features: AQ5f1JqN9wyhlCAtJf-nfpeWlB_nSjDUDYmHA7mHhO177I6TFVXNPItYoccbA3g
Message-ID: <CAL+tcoBb1cE-=V+LDSkyTBOB=Vk95FL0yZ-YpUouSHO_7ASjcA@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: add support for skb TX SND/COMPLETION timestamping
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 2:21=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ke, 2025-03-19 kello 08:39 +0800, Jason Xing kirjoitti:
> > On Wed, Mar 19, 2025 at 3:10=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Support enabling TX timestamping for some skbs, and track them until
> > > packet completion. Generate software SCM_TSTAMP_COMPLETION when getti=
ng
> > > completion report from hardware.
> > >
> > > Generate software SCM_TSTAMP_SND before sending to driver. Sending fr=
om
> > > driver requires changes in the driver API, and drivers mostly are goi=
ng
> > > to send the skb immediately.
> > >
> > > Make the default situation with no COMPLETION TX timestamping more
> > > efficient by only counting packets in the queue when there is nothing=
 to
> > > track.  When there is something to track, we need to make clones, sin=
ce
> > > the driver may modify sent skbs.
> > >
> > > The tx_q queue length is bounded by the hdev flow control, which will
> > > not send new packets before it has got completion reports for old one=
s.
> > >
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > ---
> > >
> > > Notes:
> > >     v5:
> > >     - Add hci_sockm_init()
> > >     - Back to decoupled COMPLETION & SND, like in v3
> > >     - Handle SCO flow controlled case
> > >
> > >  include/net/bluetooth/hci_core.h |  20 +++++
> > >  net/bluetooth/hci_conn.c         | 122 +++++++++++++++++++++++++++++=
++
> > >  net/bluetooth/hci_core.c         |  15 +++-
> > >  net/bluetooth/hci_event.c        |   4 +
> > >  4 files changed, 157 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
> > > index f78e4298e39a..5115da34f881 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -261,6 +261,12 @@ struct adv_info {
> > >         struct delayed_work     rpa_expired_cb;
> > >  };
> > >
> > > +struct tx_queue {
> > > +       struct sk_buff_head queue;
> > > +       unsigned int extra;
> > > +       unsigned int tracked;
> > > +};
> > > +
> > >  #define HCI_MAX_ADV_INSTANCES          5
> > >  #define HCI_DEFAULT_ADV_DURATION       2
> > >
> > > @@ -733,6 +739,8 @@ struct hci_conn {
> > >         struct sk_buff_head data_q;
> > >         struct list_head chan_list;
> > >
> > > +       struct tx_queue tx_q;
> > > +
> > >         struct delayed_work disc_work;
> > >         struct delayed_work auto_accept_work;
> > >         struct delayed_work idle_work;
> > > @@ -1572,6 +1580,18 @@ void hci_conn_enter_active_mode(struct hci_con=
n *conn, __u8 force_active);
> > >  void hci_conn_failed(struct hci_conn *conn, u8 status);
> > >  u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
> > >
> > > +void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb);
> > > +void hci_conn_tx_dequeue(struct hci_conn *conn);
> > > +void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
> > > +                           const struct sockcm_cookie *sockc);
> > > +
> > > +static inline void hci_sockcm_init(struct sockcm_cookie *sockc, stru=
ct sock *sk)
> > > +{
> > > +       *sockc =3D (struct sockcm_cookie) {
> > > +               .tsflags =3D READ_ONCE(sk->sk_tsflags),
> > > +       };
> > > +}
> > > +
> > >  /*
> > >   * hci_conn_get() and hci_conn_put() are used to control the life-ti=
me of an
> > >   * "hci_conn" object. They do not guarantee that the hci_conn object=
 is running,
> > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > index d097e308a755..95972fd4c784 100644
> > > --- a/net/bluetooth/hci_conn.c
> > > +++ b/net/bluetooth/hci_conn.c
> > > @@ -27,6 +27,7 @@
> > >
> > >  #include <linux/export.h>
> > >  #include <linux/debugfs.h>
> > > +#include <linux/errqueue.h>
> > >
> > >  #include <net/bluetooth/bluetooth.h>
> > >  #include <net/bluetooth/hci_core.h>
> > > @@ -1002,6 +1003,7 @@ static struct hci_conn *__hci_conn_add(struct h=
ci_dev *hdev, int type, bdaddr_t
> > >         }
> > >
> > >         skb_queue_head_init(&conn->data_q);
> > > +       skb_queue_head_init(&conn->tx_q.queue);
> > >
> > >         INIT_LIST_HEAD(&conn->chan_list);
> > >         INIT_LIST_HEAD(&conn->link_list);
> > > @@ -1155,6 +1157,7 @@ void hci_conn_del(struct hci_conn *conn)
> > >         }
> > >
> > >         skb_queue_purge(&conn->data_q);
> > > +       skb_queue_purge(&conn->tx_q.queue);
> > >
> > >         /* Remove the connection from the list and cleanup its remain=
ing
> > >          * state. This is a separate function since for some cases li=
ke
> > > @@ -3064,3 +3067,122 @@ int hci_abort_conn(struct hci_conn *conn, u8 =
reason)
> > >          */
> > >         return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NUL=
L);
> > >  }
> > > +
> > > +void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
> > > +                           const struct sockcm_cookie *sockc)
> > > +{
> > > +       struct sock *sk =3D skb ? skb->sk : NULL;
> > > +
> > > +       /* This shall be called on a single skb of those generated by=
 user
> > > +        * sendmsg(), and only when the sendmsg() does not return err=
or to
> > > +        * user. This is required for keeping the tskey that incremen=
ts here in
> > > +        * sync with possible sendmsg() counting by user.
> > > +        *
> > > +        * Stream sockets shall set key_offset to sendmsg() length in=
 bytes
> > > +        * and call with the last fragment, others to 1 and first fra=
gment.
> > > +        */
> > > +
> > > +       if (!skb || !sockc || !sk || !key_offset)
> > > +               return;
> > > +
> > > +       sock_tx_timestamp(sk, sockc, &skb_shinfo(skb)->tx_flags);
> > > +
> > > +       if (sockc->tsflags & SOF_TIMESTAMPING_OPT_ID &&
> > > +           sockc->tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
> > > +               if (sockc->tsflags & SOCKCM_FLAG_TS_OPT_ID) {
> > > +                       skb_shinfo(skb)->tskey =3D sockc->ts_opt_id;
> > > +               } else {
> > > +                       int key =3D atomic_add_return(key_offset, &sk=
->sk_tskey);
> > > +
> > > +                       skb_shinfo(skb)->tskey =3D key - 1;
> > > +               }
> > > +       }
> > > +}
> > > +
> > > +void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
> > > +{
> > > +       struct tx_queue *comp =3D &conn->tx_q;
> > > +       bool track =3D false;
> > > +
> > > +       /* Emit SND now, ie. just before sending to driver */
> > > +       if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> > > +               __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_=
SND);
> >
> > It's a bit strange that SCM_TSTAMP_SND is under the control of
> > SKBTX_SW_TSTAMP. Can we use the same flag for both lines here
> > directly? I suppose I would use SKBTX_SW_TSTAMP then.
>
> This is more or less open-coded skb_tx_timestamp(), which drivers do
> before sending to HW, for the Bluetooth case. AFAIK it should be done
> like this.

You're right. Sorry for misreading this part yesterday somehow...

>
> >
> > > +
> > > +       /* COMPLETION tstamp is emitted for tracked skb later in Numb=
er of
> > > +        * Completed Packets event. Available only for flow controlle=
d cases.
> > > +        *
> > > +        * TODO: SCO support without flowctl (needs to be done in dri=
vers)
> > > +        */
> > > +       switch (conn->type) {
> > > +       case ISO_LINK:
> > > +       case ACL_LINK:
> > > +       case LE_LINK:
> > > +               break;
> > > +       case SCO_LINK:
> > > +       case ESCO_LINK:
> > > +               if (!hci_dev_test_flag(conn->hdev, HCI_SCO_FLOWCTL))
> > > +                       return;
> > > +               break;
> > > +       default:
> > > +               return;
> > > +       }
> > > +
> > > +       if (skb->sk && (skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_=
TSTAMP))
> > > +               track =3D true;
> > > +
> > > +       /* If nothing is tracked, just count extra skbs at the queue =
head */
> > > +       if (!track && !comp->tracked) {
> > > +               comp->extra++;
> > > +               return;
> > > +       }
> > > +
> > > +       if (track) {
> > > +               skb =3D skb_clone_sk(skb);
> > > +               if (!skb)
> > > +                       goto count_only;
> > > +
> > > +               comp->tracked++;
> > > +       } else {
> > > +               skb =3D skb_clone(skb, GFP_KERNEL);
> > > +               if (!skb)
> > > +                       goto count_only;
> > > +       }
> > > +
> > > +       skb_queue_tail(&comp->queue, skb);
> > > +       return;
> > > +
> > > +count_only:
> > > +       /* Stop tracking skbs, and only count. This will not emit tim=
estamps for
> > > +        * the packets, but if we get here something is more seriousl=
y wrong.
> > > +        */
> > > +       comp->tracked =3D 0;
> > > +       comp->extra +=3D skb_queue_len(&comp->queue) + 1;
> > > +       skb_queue_purge(&comp->queue);
> > > +}
> > > +
> > > +void hci_conn_tx_dequeue(struct hci_conn *conn)
> > > +{
> > > +       struct tx_queue *comp =3D &conn->tx_q;
> > > +       struct sk_buff *skb;
> > > +
> > > +       /* If there are tracked skbs, the counted extra go before deq=
ueuing real
> > > +        * skbs, to keep ordering. When nothing is tracked, the order=
ing doesn't
> > > +        * matter so dequeue real skbs first to get rid of them ASAP.
> > > +        */
> > > +       if (comp->extra && (comp->tracked || skb_queue_empty(&comp->q=
ueue))) {
> > > +               comp->extra--;
> > > +               return;
> > > +       }
> > > +
> > > +       skb =3D skb_dequeue(&comp->queue);
> > > +       if (!skb)
> > > +               return;
> > > +
> > > +       if (skb->sk) {
> > > +               comp->tracked--;
> >
> > Need an explicit if statement here?
>
> I think no, see explanation of how it works in the reply to Willem:
> https://lore.kernel.org/linux-bluetooth/5882af942ef8cf5c9b4ce36a348f95980=
7a387b0.camel@iki.fi/
>
> > > +               __skb_tstamp_tx(skb, NULL, NULL, skb->sk,
> > > +                               SCM_TSTAMP_COMPLETION);
> >
> > This is the socket timestamping, and that's right. My minor question
> > is: for the use of bpf timestamping (that should be easy as you've
> > done in patch 1, I presume), I'm not sure if you're familiar with it.
> > If not, I plan to implement it myself in a follow-up patch and then
> > let you do some tests? Of course, I will provide the bpf test script
>
> I saw the BPF timestamping things, but didn't look in full detail yet.
> I don't know much about BPF, but IIUC, is it just as simple as adding
> BPF_SOCK_OPS_TSTAMP_COMPLETION_CB and then modifying
> skb_tstamp_tx_report_bpf_timestamping() accordingly?
>
> I think we'd want to add also the BPF tests in the Bluetooth socket
> timestamping tests

Good to know that!

>
> https://web.git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/test-runn=
er.rst
> https://web.git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/tester.=
h#n91
> https://web.git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/iso-tes=
ter.c#n2275
> https://web.git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/sco-tes=
ter.c#n755
> https://web.git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/l2cap-t=
ester.c#n1369
>
> If you could show an example how to setup the BPF tstamps and pass the
> resulting tstamp data in some way back to the application, that could
> be very helpful (and I could postpone learning BPF for a little while
> longer :)

Sure, I can leave it to you as long as you want to take over it :)

A simple case where I re-support the bpf extension for socket
timestamping goes like this commit [1]. And the selftest can be seen
here[2].

A rough thought is that letting it pass in
skb_tstamp_tx_report_bpf_timestamping() and adding corresponding BPF
flag as you mentioned before are the key to do it on top of the
current series. It should not be that hard. If you have any questions
on how we move on about this point, please feel free to reach out to
me anytime.

[1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.gi=
t/commit/?id=3D6b98ec7e882af1c3088a88757e2226d06c8514f9
[2]: https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.gi=
t/commit/?id=3Df4924aec58dd9e14779f4bc11a6bf3a830a42a6c
Note: you will compile tools/testing/selftests/bpf/ and run
./test_progs -t net_timestamp to see how it works.

Thanks,
Jason

>
> > :)
> >
> > Thanks,
> > Jason
> >
> > > +       }
> > > +
> > > +       kfree_skb(skb);
> > > +}
> > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > index 94d9147612da..5eb0600bbd03 100644
> > > --- a/net/bluetooth/hci_core.c
> > > +++ b/net/bluetooth/hci_core.c
> > > @@ -3029,6 +3029,13 @@ static int hci_send_frame(struct hci_dev *hdev=
, struct sk_buff *skb)
> > >         return 0;
> > >  }
> > >
> > > +static int hci_send_conn_frame(struct hci_dev *hdev, struct hci_conn=
 *conn,
> > > +                              struct sk_buff *skb)
> > > +{
> > > +       hci_conn_tx_queue(conn, skb);
> > > +       return hci_send_frame(hdev, skb);
> > > +}
> > > +
> > >  /* Send HCI command */
> > >  int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
> > >                  const void *param)
> > > @@ -3575,7 +3582,7 @@ static void hci_sched_sco(struct hci_dev *hdev,=
 __u8 type)
> > >         while (*cnt && (conn =3D hci_low_sent(hdev, type, &quote))) {
> > >                 while (quote-- && (skb =3D skb_dequeue(&conn->data_q)=
)) {
> > >                         BT_DBG("skb %p len %d", skb, skb->len);
> > > -                       hci_send_frame(hdev, skb);
> > > +                       hci_send_conn_frame(hdev, conn, skb);
> > >
> > >                         conn->sent++;
> > >                         if (conn->sent =3D=3D ~0)
> > > @@ -3618,7 +3625,7 @@ static void hci_sched_acl_pkt(struct hci_dev *h=
dev)
> > >                         hci_conn_enter_active_mode(chan->conn,
> > >                                                    bt_cb(skb)->force_=
active);
> > >
> > > -                       hci_send_frame(hdev, skb);
> > > +                       hci_send_conn_frame(hdev, chan->conn, skb);
> > >                         hdev->acl_last_tx =3D jiffies;
> > >
> > >                         hdev->acl_cnt--;
> > > @@ -3674,7 +3681,7 @@ static void hci_sched_le(struct hci_dev *hdev)
> > >
> > >                         skb =3D skb_dequeue(&chan->data_q);
> > >
> > > -                       hci_send_frame(hdev, skb);
> > > +                       hci_send_conn_frame(hdev, chan->conn, skb);
> > >                         hdev->le_last_tx =3D jiffies;
> > >
> > >                         (*cnt)--;
> > > @@ -3708,7 +3715,7 @@ static void hci_sched_iso(struct hci_dev *hdev)
> > >         while (*cnt && (conn =3D hci_low_sent(hdev, ISO_LINK, &quote)=
)) {
> > >                 while (quote-- && (skb =3D skb_dequeue(&conn->data_q)=
)) {
> > >                         BT_DBG("skb %p len %d", skb, skb->len);
> > > -                       hci_send_frame(hdev, skb);
> > > +                       hci_send_conn_frame(hdev, conn, skb);
> > >
> > >                         conn->sent++;
> > >                         if (conn->sent =3D=3D ~0)
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index 0df4a0e082c8..83990c975c1f 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -4415,6 +4415,7 @@ static void hci_num_comp_pkts_evt(struct hci_de=
v *hdev, void *data,
> > >                 struct hci_comp_pkts_info *info =3D &ev->handles[i];
> > >                 struct hci_conn *conn;
> > >                 __u16  handle, count;
> > > +               unsigned int i;
> > >
> > >                 handle =3D __le16_to_cpu(info->handle);
> > >                 count  =3D __le16_to_cpu(info->count);
> > > @@ -4425,6 +4426,9 @@ static void hci_num_comp_pkts_evt(struct hci_de=
v *hdev, void *data,
> > >
> > >                 conn->sent -=3D count;
> > >
> > > +               for (i =3D 0; i < count; ++i)
> > > +                       hci_conn_tx_dequeue(conn);
> > > +
> > >                 switch (conn->type) {
> > >                 case ACL_LINK:
> > >                         hdev->acl_cnt +=3D count;
> > > --
> > > 2.48.1
> > >
> > >
>
> --
> Pauli Virtanen

