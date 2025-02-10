Return-Path: <netdev+bounces-164865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD914A2F722
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD651882E19
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A8425B668;
	Mon, 10 Feb 2025 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="WGITDGI/"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1276158862;
	Mon, 10 Feb 2025 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212434; cv=pass; b=ARP88kulV9a6IektU2Dp2nb2remj9nBj1vVGGvqi+6LYQF/lwoGA9GblPD2EkppytGtWXLa+Sg0mQKEwerx8jTw6mlQKDZ2tnPMO5vfzClocRSq2zGw/zdjCpgtz6KlxHXejTy9i0MdZaDKOy6Z+xMxru8gHexg7ZoH5GwCgvXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212434; c=relaxed/simple;
	bh=EvvdHY67Cdd2eoiuX5I0UX0hwEeMuWJcjOcgWy2y7ys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UInKb5o096eOK9AE50uuCaOVvwp1qlYaz9bwEUHn1pDkXqBhxifHjEClUyo1JFDzH8+h/G8WkNd0QGaYq6l16WLLX2PQYIzRkhY0CtBYYNED35pSbDHGORh5aolHGy3gm2injSObTuCXZsT8XrhqQQEA4DtBncBOZXKchPtgYqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=WGITDGI/; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YsCrr5wmkz49Psm;
	Mon, 10 Feb 2025 20:33:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739212430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I47Ie5ci+9LqX9WKcQTRfZj78YsLSdtB08dm8G+suK4=;
	b=WGITDGI/LEBMB1mpxJ2oZW9rjUGggE5N4Y/ovqLGSLYZpx6Lz+SpGxeTUFGkD8cg9JBAc5
	jpDl8ZHkdRdIAR5cUpP7Lr+hO66eGMjXB4PgowbRkYLOYgPO9FgBcz/D2s20yDx8+66BI+
	GMlXIXjF2MJXAGhNI4OQFbuTPDEppqxma6IAR2g2SNSQJ9zkozDEi8zsy6wcd1e754EKcS
	89OF9wolzOn/0+dFJxlwP0q7ZBMJasqhzapnzPQQAnQfLak6Zabbx5n2pUauX9MBL1iudD
	pddkDwEjmdnIC1X/qb6yb368IC21ZPpOiUOtn0vbkilel6aZlIYQObBK6zge5A==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739212430; a=rsa-sha256;
	cv=none;
	b=WAId3Byr2lvGQZK2FrTEfxXiUbBCJYRsMJAhVIlj5JUYM1xc4KBlHmG6l8cfq0fhR44sdG
	nlLZJM6DIVU27tYA+OoSXq4ia6amXiSwOXBKXy9P6aAH1qqmRiDdzi6N1UHIO5aHaG9arf
	54SFn7zUQPBHEtlkkb4HHhqru+daKiv0OvWmmoQiLmrUI7zIrNg/oW1yS87Q/ouJnvsELn
	N80BZrm88eiSrOYwRXADEoy/rIOhfHn6WIvkIdcvKg3wGGENap7BRUKocizO+tlERgoDrV
	jIAoSSDITooRP/u4S2g04oCZ1GF+bkxqazX7pAdxqR4gO6AWOCewl7RnXUIipw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739212430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I47Ie5ci+9LqX9WKcQTRfZj78YsLSdtB08dm8G+suK4=;
	b=gzqUyEApc9U85LIyKD4hc2V0N6dCtizeNyCsJ6FTMA/M6KOSqy+Galu72Tubh4eodShfX8
	l+TpTBhFowKKsNj+c56sanU2+APItD9e1/SHVCKvXcL+r3e+l0bhQwFZgklaNRp0YzDGSM
	4IAs2Rj5+OGKllgHOliw7OoClCeOxUZxmGp9v2WBm4t/otmeygGHieCoEqLBPiKrNtiEB1
	s5AJkMwe/A10VRhBb/iTIQkkz4XHn7mSD4X156rr1hhRTsI1h71Dsg4w+zS2eM//ludJLh
	zGh0rd1mSrM0XT/jVRsYcZafJQ78c7F2xYDqnRDplZm5Se8640GnwK1jPw5F0w==
Message-ID: <1af6d30be276e3bba9c7982d1910138028a52898.camel@iki.fi>
Subject: Re: [PATCH v3 3/5] Bluetooth: ISO: add TX timestamping
From: Pauli Virtanen <pav@iki.fi>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, willemdebruijn.kernel@gmail.com
Date: Mon, 10 Feb 2025 20:33:46 +0200
In-Reply-To: <CAL+tcoBZU8C76XTLoz9LEWR+e+x3ct_izbC0q-kKXkTxxqhoHg@mail.gmail.com>
References: <cover.1739097311.git.pav@iki.fi>
	 <f3f0fa8615fbfebbf58212bd407e51579f85412a.1739097311.git.pav@iki.fi>
	 <CAL+tcoBZU8C76XTLoz9LEWR+e+x3ct_izbC0q-kKXkTxxqhoHg@mail.gmail.com>
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

ma, 2025-02-10 kello 13:19 +0800, Jason Xing kirjoitti:
> On Sun, Feb 9, 2025 at 6:39=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
> >=20
> > Add BT_SCM_ERROR socket CMSG type.
> >=20
> > Support TX timestamping in ISO sockets.
> >=20
> > Support MSG_ERRQUEUE in ISO recvmsg.
> >=20
> > If a packet from sendmsg() is fragmented, only the first ACL fragment i=
s
> > timestamped.
> >=20
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >  include/net/bluetooth/bluetooth.h |  1 +
> >  net/bluetooth/iso.c               | 24 ++++++++++++++++++++----
> >  2 files changed, 21 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index 435250c72d56..bbefde319f95 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -156,6 +156,7 @@ struct bt_voice {
> >  #define BT_PKT_STATUS           16
> >=20
> >  #define BT_SCM_PKT_STATUS      0x03
> > +#define BT_SCM_ERROR           0x04
> >=20
> >  #define BT_ISO_QOS             17
> >=20
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index 44acddf58a0c..f497759a2af5 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -518,7 +518,8 @@ static struct bt_iso_qos *iso_sock_get_qos(struct s=
ock *sk)
> >         return &iso_pi(sk)->qos;
> >  }
> >=20
> > -static int iso_send_frame(struct sock *sk, struct sk_buff *skb)
> > +static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
> > +                         const struct sockcm_cookie *sockc)
> >  {
> >         struct iso_conn *conn =3D iso_pi(sk)->conn;
> >         struct bt_iso_qos *qos =3D iso_sock_get_qos(sk);
> > @@ -538,10 +539,12 @@ static int iso_send_frame(struct sock *sk, struct=
 sk_buff *skb)
> >         hdr->slen =3D cpu_to_le16(hci_iso_data_len_pack(len,
> >                                                       HCI_ISO_STATUS_VA=
LID));
> >=20
> > -       if (sk->sk_state =3D=3D BT_CONNECTED)
> > +       if (sk->sk_state =3D=3D BT_CONNECTED) {
> > +               hci_setup_tx_timestamp(skb, 1, sockc);
> >                 hci_send_iso(conn->hcon, skb);
> > -       else
> > +       } else {
> >                 len =3D -ENOTCONN;
> > +       }
> >=20
> >         return len;
> >  }
> > @@ -1348,6 +1351,7 @@ static int iso_sock_sendmsg(struct socket *sock, =
struct msghdr *msg,
> >  {
> >         struct sock *sk =3D sock->sk;
> >         struct sk_buff *skb, **frag;
> > +       struct sockcm_cookie sockc;
> >         size_t mtu;
> >         int err;
> >=20
> > @@ -1360,6 +1364,14 @@ static int iso_sock_sendmsg(struct socket *sock,=
 struct msghdr *msg,
> >         if (msg->msg_flags & MSG_OOB)
> >                 return -EOPNOTSUPP;
> >=20
> > +       sockcm_init(&sockc, sk);
>=20
> No need to initialize other irrelevant fields since Willem started to
> clean up this kind of init phase in TCP[1].
>=20
> [1]: https://lore.kernel.org/all/20250206193521.2285488-2-willemdebruijn.=
kernel@gmail.com/

Ok.

> > +
> > +       if (msg->msg_controllen) {
> > +               err =3D sock_cmsg_send(sk, msg, &sockc);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
>=20
> I'm not familiar with bluetooth, but I'm wondering if the above code
> snippet is supposed to be protected by the socket lock as below since
> I refer to TCP as an example? Is it possible that multiple threads
> call this sendmsg at the same time?

I think parallel sendmsg() is possible, but I understood sock_cmsg_send
itself doesn't need lock_sock(), if I read correctly e.g. udp_sendmsg()
seems to be using it via ip_cmsg_send() unlocked.

The lock_sock() that are below IIRC protect the invariant that=C2=A0
sk->sk_state =3D=3D BT_CONNECTED has special meaning here.
>=20

> >         lock_sock(sk);
> >=20
> >         if (sk->sk_state !=3D BT_CONNECTED) {
> > @@ -1405,7 +1417,7 @@ static int iso_sock_sendmsg(struct socket *sock, =
struct msghdr *msg,
> >         lock_sock(sk);
> >=20
> >         if (sk->sk_state =3D=3D BT_CONNECTED)
> > -               err =3D iso_send_frame(sk, skb);
> > +               err =3D iso_send_frame(sk, skb, &sockc);
> >         else
> >                 err =3D -ENOTCONN;
> >=20
> > @@ -1474,6 +1486,10 @@ static int iso_sock_recvmsg(struct socket *sock,=
 struct msghdr *msg,
> >=20
> >         BT_DBG("sk %p", sk);
> >=20
> > +       if (unlikely(flags & MSG_ERRQUEUE))
> > +               return sock_recv_errqueue(sk, msg, len, SOL_BLUETOOTH,
> > +                                         BT_SCM_ERROR);
> > +
> >         if (test_and_clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
> >                 sock_hold(sk);
> >                 lock_sock(sk);
> > --
> > 2.48.1
> >=20
> >=20


