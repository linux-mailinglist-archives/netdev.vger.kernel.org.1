Return-Path: <netdev+bounces-206702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B4B04215
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9564A1FF8
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC1215B0EC;
	Mon, 14 Jul 2025 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="kkQlX8Xh"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A5184;
	Mon, 14 Jul 2025 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504345; cv=pass; b=ogB0uRsI2ieJ4Wel30dUCj1NbO2XZQ1JjEYsIwRq8JKlg4pPn8ZsgPfO5rOsVOB6x66SesLC0l/EIYBW9bQLYS7LzFW32Gh2UYIhzuyyymybgdMJFjES2BNXa5uI3DGBw0hjHzMQJ3SWTtZ+wYWF8uIaBwZLm5F5GFPjFTGmsfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504345; c=relaxed/simple;
	bh=AluodgJJ4pCiMBK8vS9h6VTHUhg62nB2KZ8+Ey2PiZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hamu80FIe57r3vgd1xj7odqZgKUrLr4BrmqNOkESQSBmTiOaB7wtuLz2tVfC5zq+fjGi0lMM7+m1MUIxExjU9j4SP/DwKL6fq1IycWme3KgvaSAGcMpJ+UKHqhb6tF8i/LzWIPPm1E9Wwlut5uQ8Ims4ItoGDwn08x6TBoF+BOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=kkQlX8Xh; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bglVJ1pg7z49PvR;
	Mon, 14 Jul 2025 17:45:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1752504331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AYEFGmmvDmeviR6rkKIz3uLXvuK4dd7UkL/yPvtIRM=;
	b=kkQlX8Xh8ldWAMmO8yiUC3vcOrdtrzLg4Dgc8b7uThfjB6MuCIqGa3pjSqYFhwtpVeTapX
	rRYNpktEi4A+S5k1iJbsjhsgzUXnvf4gYejWqOtyMZWR0TfZws4ydIBZySN7LSWJgGyb9K
	kJKighJ2x91eRaG21FGG4pzDoCwjhU0RqZNwhWq5Njy6o0WqUySDZxxuQ/3sRjn1Qt9HTQ
	MULey9XQ3jwXdEqpEa1EnnIdLViems36Bbc/nA7NF4e4jR87pRCmx4AGI7jDN9o1nAUu4m
	v2EtTRftYhY6NmWpv3FaVHuS2cIUsBTjM5VpjseNIG+eqCQGjGIvkByPbu361Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1752504331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AYEFGmmvDmeviR6rkKIz3uLXvuK4dd7UkL/yPvtIRM=;
	b=n7cmTUjVnQa9B20xk6f6JzI32ZMX5Lu7eivwiA3So3qFrNt6OMf1yTUg5l90qhNLQvWAXY
	7b6Gs7aOmaJ14VYKgFcU6V1H1FoXcSIgWocTTDNW3MZY4WfsiRY/m2h2aciKKN0qUD4wl/
	G6eE5pxJWqWr4pXK0Pu68su91rEZ7FiqPbzEHb+YuvTSpMEb+Pg3AF8jSN2YruHxCgkhN2
	Q7bp7VFKAnGdx8axOLtMnD4W+Hp6++YVheMBBBS06/jRFyIKC8r4WcDdyodvTEuwyLBPqF
	xe8ZVNCue/8CiVIRm7BAZuvsY93juFtPThR2+qs/HKDunUXbvlF7kRSGNqXXvA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1752504331; a=rsa-sha256;
	cv=none;
	b=JcOY28FlpleDIZ6k+ofXZpbdSDio+1fakOTJvqElFHSo+6VRpgeccdrNcMj4SN38bPUxCI
	Y4YYJwON/5NdtqqQvnAObQ6ticMDtJlj0D+taqEDZVkc/QQNQ3OYz9qnWGUndRi6IJ1EaL
	WCv7+fxJZX6B5UFxTXUsD4iCzo32Us4sV65vlAsVwDx4vrArLB5sdpGcGV1VVkw9Eh4AWb
	ndybFufTpjSLg/ws0NYDby0IOptnp6Lx5D+idBloE5zt3eBu+QT/dHRH+hyZtsv7kzqqqx
	Izw7nKIGC89Ir7MnU3CrQ05s0CCMb7sNhLjQS1EjH4AO19kaSMTQdBhL/McJyw==
Message-ID: <f809b3350fa5ead274b83120d9b38ecdef0dcf76.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: ISO: add socket option to report packet
 seqnum via CMSG
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	johan.hedberg@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 14 Jul 2025 17:45:26 +0300
In-Reply-To: <CABBYNZL0FjLf6NZ1U0Wo4cOyCfH=17FkN_6-CT1RqNdJVyMfZA@mail.gmail.com>
References: 
	<474a5321753aba17ec2819ba59adfd157ecfb343.1752501596.git.pav@iki.fi>
	 <CABBYNZL0FjLf6NZ1U0Wo4cOyCfH=17FkN_6-CT1RqNdJVyMfZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ma, 2025-07-14 kello 10:15 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Mon, Jul 14, 2025 at 10:03=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrot=
e:
> >=20
> > User applications need a way to track which ISO interval a given SDU
> > belongs to, to properly detect packet loss. All controllers do not set
> > timestamps, and it's not guaranteed user application receives all packe=
t
> > reports (small socket buffer, or controller doesn't send all reports
> > like Intel AX210 is doing).
> >=20
> > Add socket option BT_PKT_SEQNUM that enables reporting of received
> > packet ISO sequence number in BT_SCM_PKT_SEQNUM CMSG.
> >=20
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >=20
> > Notes:
> >     Intel AX210 is not sending all reports:
> >=20
> >     $ btmon -r dump.btsnoop -I -C90|grep -A1 'ISO Data RX: Handle 2304'
> >     ...
> >     > ISO Data RX: Handle 2304 flags 0x02 dlen 64                      =
#1713 [hci0] 22.567744
> >             dd 01 3c 00 6d 08 e9 14 1e 3b 85 7b 35 c2 25 0b  ..<.m....;=
.{5.%.
> >     --
> >     > ISO Data RX: Handle 2304 flags 0x02 dlen 64                      =
#1718 [hci0] 22.573745
> >             de 01 3c 00 41 65 22 4f 99 9b 0b b6 ff cb 06 00  ..<.Ae"O..=
......
> >     --
> >     > ISO Data RX: Handle 2304 flags 0x02 dlen 64                      =
#1727 [hci0] 22.587933
> >             e0 01 3c 00 8b 6e 33 44 65 51 ee d7 e0 ee 49 d8  ..<..n3DeQ=
....I.
> >     --
> >     > ISO Data RX: Handle 2304 flags 0x02 dlen 64                      =
#1732 [hci0] 22.596742
> >             e1 01 3c 00 a7 48 54 a7 c1 9f dc 37 66 fe 04 ab  ..<..HT...=
.7f...
> >     ...
> >=20
> >     Here, report for packet with sequence number 0x01df is missing.
> >=20
> >     This may be spec violation by the controller, see Core v6.1 pp. 370=
2
> >=20
> >         All SDUs shall be sent to the upper layer including the indicat=
ion
> >         of validity of data. A report shall be sent to the upper layer =
if
> >         the SDU is completely missing.
>=20
> We may want to report this to Intel, let me check internally.
>=20
> >     Regardless, it will be easier for user applications to see the HW
> >     sequence numbers directly, so they don't have to count packets and =
it's
> >     in any case more reliable if packets get dropped due to socket buff=
er
> >     size.
> >=20
> >  include/net/bluetooth/bluetooth.h |  9 ++++++++-
> >  net/bluetooth/af_bluetooth.c      |  7 +++++++
> >  net/bluetooth/iso.c               | 21 ++++++++++++++++++---
> >  3 files changed, 33 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index 114299bd8b98..0e31779a3341 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -244,6 +244,10 @@ struct bt_codecs {
> >=20
> >  #define BT_ISO_BASE            20
> >=20
> > +#define BT_PKT_SEQNUM          21
> > +
> > +#define BT_SCM_PKT_SEQNUM      0x05
> > +
> >  __printf(1, 2)
> >  void bt_info(const char *fmt, ...);
> >  __printf(1, 2)
> > @@ -391,7 +395,8 @@ struct bt_sock {
> >  enum {
> >         BT_SK_DEFER_SETUP,
> >         BT_SK_SUSPEND,
> > -       BT_SK_PKT_STATUS
> > +       BT_SK_PKT_STATUS,
> > +       BT_SK_PKT_SEQNUM,
> >  };
> >=20
> >  struct bt_sock_list {
> > @@ -475,6 +480,7 @@ struct bt_skb_cb {
> >         u8 pkt_type;
> >         u8 force_active;
> >         u16 expect;
> > +       u16 pkt_seqnum;
>=20
> We may also need the status or are you planning on reusing the
> existing pkt_status? In any case we may want to add something to
> iso-tester to confirm this is working as intended and catch possible
> regressions.

BT_PKT_STATUS + BT_SCM_PKT_STATUS are already implemented for ISO, and
there is test for it in iso-tester.c

ISO Receive Packet Status - Success

How it works in this version is that user application that wants to get
both does

	opt =3D 1;
	setsockopt(fd, SOL_BLUETOOTH, BT_PKT_STATUS, &opt, sizeof(opt));
	opt =3D 1;
	setsockopt(fd, SOL_BLUETOOTH, BT_PKT_SEQNUM, &opt, sizeof(opt));
	...
	uint16_t seqnum;
	uint8_t status;
	for (cmsg=3DCMSG_FIRSTHDR(&msg); cmsg; cmsg =3D CMSG_NXTHDR(&msg, cmsg)) {
		if (cmsg->cmsg_level !=3D SOL_BLUETOOTH)
			continue;
		if (cmsg->cmsg_type =3D=3D BT_SCM_PKT_SEQNUM)
			memcpy(&seqnum, CMSG_DATA(cmsg), sizeof(uint16_t));
		else if (cmsg->cmsg_type =3D=3D BT_SCM_PKT_STATUS)
			memcpy(&status, CMSG_DATA(cmsg), sizeof(uint8_t));
	}

In theory we might indeed also change BT_SCM_PKT_STATUS to a struct
like

	struct bt_iso_pkt_status {
		u8 status;
		u16 seqnum;
	} __packed;

It's then not really fully compatible with any existing applications,
since applications may be eg using something like

	char buf[CMSG_SPACE(uint8_t)];

to reserve space for the BT_PKT_STATUS CMSG, which then won't
necessarily fit anymore. Maybe it could be changed just for ISO, but
then different socket types would have different CMSG size for the same
SCM.

I think it's probably OK to use separate CMSG like here, then user
application can also know if kernel supports the socket option.

> >         u8 incoming:1;
> >         u8 pkt_status:2;
> >         union {
> > @@ -488,6 +494,7 @@ struct bt_skb_cb {
> >=20
> >  #define hci_skb_pkt_type(skb) bt_cb((skb))->pkt_type
> >  #define hci_skb_pkt_status(skb) bt_cb((skb))->pkt_status
> > +#define hci_skb_pkt_seqnum(skb) bt_cb((skb))->pkt_seqnum
> >  #define hci_skb_expect(skb) bt_cb((skb))->expect
> >  #define hci_skb_opcode(skb) bt_cb((skb))->hci.opcode
> >  #define hci_skb_event(skb) bt_cb((skb))->hci.req_event
> > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.=
c
> > index 6ad2f72f53f4..44b7acb20a67 100644
> > --- a/net/bluetooth/af_bluetooth.c
> > +++ b/net/bluetooth/af_bluetooth.c
> > @@ -364,6 +364,13 @@ int bt_sock_recvmsg(struct socket *sock, struct ms=
ghdr *msg, size_t len,
> >                         put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_STATUS,
> >                                  sizeof(pkt_status), &pkt_status);
> >                 }
> > +
> > +               if (test_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags)) {
> > +                       u16 pkt_seqnum =3D hci_skb_pkt_seqnum(skb);
> > +
> > +                       put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_SEQNUM,
> > +                                sizeof(pkt_seqnum), &pkt_seqnum);
> > +               }
>=20
> In case we want to reuse the pkt_status then perhaps the order shall
> be pk_seqnum followed by pkt_status otherwise we need a struct that
> holds them both.

The order of the CMSG shouldn't matter if they have separate BT_SCM
types & socket flags.

>=20
> >         }
> >=20
> >         skb_free_datagram(sk, skb);
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index fc22782cbeeb..469450bb6b6c 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -1687,6 +1687,17 @@ static int iso_sock_setsockopt(struct socket *so=
ck, int level, int optname,
> >                         clear_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
> >                 break;
> >=20
> > +       case BT_PKT_SEQNUM:
> > +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optva=
l, optlen);
> > +               if (err)
> > +                       break;
> > +
> > +               if (opt)
> > +                       set_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags);
> > +               else
> > +                       clear_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags);
> > +               break;
> > +
> >         case BT_ISO_QOS:
> >                 if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_B=
OUND &&
> >                     sk->sk_state !=3D BT_CONNECT2 &&
> > @@ -2278,7 +2289,7 @@ static void iso_disconn_cfm(struct hci_conn *hcon=
, __u8 reason)
> >  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
> >  {
> >         struct iso_conn *conn =3D hcon->iso_data;
> > -       __u16 pb, ts, len;
> > +       __u16 pb, ts, len, sn;
> >=20
> >         if (!conn)
> >                 goto drop;
> > @@ -2308,6 +2319,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_bu=
ff *skb, u16 flags)
> >                                 goto drop;
> >                         }
> >=20
> > +                       sn =3D hdr->sn;
> >                         len =3D __le16_to_cpu(hdr->slen);
> >                 } else {
> >                         struct hci_iso_data_hdr *hdr;
> > @@ -2318,18 +2330,20 @@ void iso_recv(struct hci_conn *hcon, struct sk_=
buff *skb, u16 flags)
> >                                 goto drop;
> >                         }
> >=20
> > +                       sn =3D hdr->sn;
> >                         len =3D __le16_to_cpu(hdr->slen);
> >                 }
> >=20
> >                 flags  =3D hci_iso_data_flags(len);
> >                 len    =3D hci_iso_data_len(len);
> >=20
> > -               BT_DBG("Start: total len %d, frag len %d flags 0x%4.4x"=
, len,
> > -                      skb->len, flags);
> > +               BT_DBG("Start: total len %d, frag len %d flags 0x%4.4x =
sn %d",
> > +                      len, skb->len, flags, sn);
> >=20
> >                 if (len =3D=3D skb->len) {
> >                         /* Complete frame received */
> >                         hci_skb_pkt_status(skb) =3D flags & 0x03;
> > +                       hci_skb_pkt_seqnum(skb) =3D sn;
> >                         iso_recv_frame(conn, skb);
> >                         return;
> >                 }
> > @@ -2352,6 +2366,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_bu=
ff *skb, u16 flags)
> >                         goto drop;
> >=20
> >                 hci_skb_pkt_status(conn->rx_skb) =3D flags & 0x03;
> > +               hci_skb_pkt_seqnum(conn->rx_skb) =3D sn;
> >                 skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, sk=
b->len),
> >                                           skb->len);
> >                 conn->rx_len =3D len - skb->len;
> > --
> > 2.50.1
> >=20
>=20

--=20
Pauli Virtanen

