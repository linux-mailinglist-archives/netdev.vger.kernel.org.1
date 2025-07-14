Return-Path: <netdev+bounces-206703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB5AB0423B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2739F3BB076
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D8F253F11;
	Mon, 14 Jul 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="PfTKt4jU"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3382C1D6DA9;
	Mon, 14 Jul 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504848; cv=pass; b=Vo44BhRPww5LhRZgczWzqfh7BYt0oLG15x6+yzB+0zxiKgfmkfQQR2CEbnQ/tL8BAeYXK3T/dqBP4U1qyrkAX0lxwaZY9NeYJAKKAm3LtbAHHXLg/qyPIUI07SGjC/Htv6b1TU4iy55C4EBo0hExhDEcy/QlEt8U9hh2jA6cEtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504848; c=relaxed/simple;
	bh=k5tNNchD0zNmEUYsd6Uak+az218JrIf5PnyysmBEifI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d7dUCPxb5obCgRCtczz9pdH1838KEt2JOPxI4oG4Z59g8czALQ941iExkZty3fIgNM2k+jphDw2L9nV4mnUfZCuN8AN1B9rx2FNZlWeTS6blHEhL7CHyPcCTOAeluCYnlVRfdpglpQjHNptExaWR9yDx0TBfFxm8EsoQ1Pa62+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=PfTKt4jU; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bglh61rHCz49Q05;
	Mon, 14 Jul 2025 17:53:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1752504840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wKmZlwrq1xSSNxDILuP9WT7dI5hD6EGbV2mJv5duTeg=;
	b=PfTKt4jU8jyHbEmmNiF823fDChLyLa34UEGie4MhNQ6I2GG7pjlksuap8RHt8uTVcEjM9A
	QsVIKK8Xxo3v/PBUNzaD1fsyPILKH1QwXwit1m6x4b400UK3jpQH9JkJkFH5eqilDNzw7u
	L7fYDti9QfVR0GB3JR8vUqi+NWWS1aYdF4BiROen+BJ7iEkOBQ/CEXLh+PIqkrlcbwGAgP
	GOLJ9hOfSz0zSRV4w1Z1Y6eH/A7hiSUQd0d9mDLhoURswGeBAX5Z98j66/iQDoTkd5Kp3i
	Z1yGBCyOCfRaxMjPRSp3QF5MSM9dFiSDPOCnTBL/ciPwOZJP6RX3VL7cbm0CvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1752504840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wKmZlwrq1xSSNxDILuP9WT7dI5hD6EGbV2mJv5duTeg=;
	b=WttnkpeIF87o+FIJ5jiz5g2+kamwkUbaawdEsoIizw7zuzIHwk1FpW5GY/OMDqx0ze/o4S
	e4TQqW8+lZ7/GZmCECQvvLsmb78/QcL5icewxe8y8zT2hWBfAYAQMMgTrRlxljx8fGg/KB
	TQWSasaddkNxARXl16W8eV/W7DmPQpVpyCI9sXTUSwDPPoG+6k1te/QsuMRMHtc1Ejkz0d
	4t/HM57VYvO87ou+K/pgUE5nXN098sONr+xKIfJYJAb3H5ljQqeUMgmu6veFhKiSI6/2as
	A9siqlAoSBtx4o90VmqDkzguJL+Mj+GajTZgDA+Qc1qcQ9E6/dXawl46gGrmTw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1752504840; a=rsa-sha256;
	cv=none;
	b=TEpwuJpFIPQkrwOz6CWnnEwr/zAbKkio3OkLPrBsOoi/HdXaiqHmrlznRV5nu0KqTIaTwB
	yk3NTR/WS1lJ65Ru5LJI/x8GzuJNz48EdFXMzOqwRhc2awWR9mXgBGwyf7xwoncV4gbbXm
	Jvl6qFcVtdfI+DrjavxrOLRq3BrusvFKOMxbwqLyfjbj1rLodstDwmUOZ+olQgSIeDvfBE
	Un7qF336h9gNFeSawiR5UBTcpOH2Pi1zTq7uMX+nm1qhuML78HsrytrS2tsKRyqiff3LjI
	CaeaBw0+t78vKZM6d7d2Ch4oFuylNbsBJH1IAPqX2evnyrDmJJN712PJ6626sA==
Message-ID: <e647579c99fcbfeb0c89f041ea5ea61e608be099.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: ISO: add socket option to report packet
 seqnum via CMSG
From: Pauli Virtanen <pav@iki.fi>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	johan.hedberg@gmail.com, luiz.dentz@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 14 Jul 2025 17:53:56 +0300
In-Reply-To: <bbdbe42b-614c-4f66-8712-f0ab8d54b490@molgen.mpg.de>
References: 
	<474a5321753aba17ec2819ba59adfd157ecfb343.1752501596.git.pav@iki.fi>
	 <bbdbe42b-614c-4f66-8712-f0ab8d54b490@molgen.mpg.de>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=mQINBGX+qmEBEACt7O4iYRbX80B2OV+LbX06Mj1Wd67SVWwq2sAlI+6fK1YWbFu5jOWFy
 ShFCRGmwyzNvkVpK7cu/XOOhwt2URcy6DY3zhmd5gChz/t/NDHGBTezCh8rSO9DsIl1w9nNEbghUl
 cYmEvIhQjHH3vv2HCOKxSZES/6NXkskByXtkPVP8prHPNl1FHIO0JVVL7/psmWFP/eeB66eAcwIgd
 aUeWsA9+/AwcjqJV2pa1kblWjfZZw4TxrBgCB72dC7FAYs94ebUmNg3dyv8PQq63EnC8TAUTyph+M
 cnQiCPz6chp7XHVQdeaxSfcCEsOJaHlS+CtdUHiGYxN4mewPm5JwM1C7PW6QBPIpx6XFvtvMfG+Ny
 +AZ/jZtXxHmrGEJ5sz5YfqucDV8bMcNgnbFzFWxvVklafpP80O/4VkEZ8Og09kvDBdB6MAhr71b3O
 n+dE0S83rEiJs4v64/CG8FQ8B9K2p9HE55Iu3AyovR6jKajAi/iMKR/x4KoSq9Jgj9ZI3g86voWxM
 4735WC8h7vnhFSA8qKRhsbvlNlMplPjq0f9kVLg9cyNzRQBVrNcH6zGMhkMqbSvCTR5I1kY4SfU4f
 QqRF1Ai5f9Q9D8ExKb6fy7ct8aDUZ69Ms9N+XmqEL8C3+AAYod1XaXk9/hdTQ1Dhb51VPXAMWTICB
 dXi5z7be6KALQARAQABtCZQYXVsaSBWaXJ0YW5lbiA8cGF1bGkudmlydGFuZW5AaWtpLmZpPokCWg
 QTAQgARAIbAwUJEswDAAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBGrOSfUCZNEJOswAnOS
 aCbhLOrBPBQJl/qsDAhkBAAoJEOSaCbhLOrBPB/oP/1j6A7hlzheRhqcj+6sk+OgZZ+5eX7mBomyr
 76G+m/3RhPGlKbDxKTWtBZaIDKg2c0Q6yC1TegtxQ2EUD4kk7wKoHKj8dKbR29uS3OvURQR1guCo2
 /5kzQQVxQwhIoMdHJYF0aYNQgdA+ZJL09lDz+JC89xvup3spxbKYc9Iq6vxVLbVbjF9Uv/ncAC4Bs
 g1MQoMowhKsxwN5VlUdjqPZ6uGebZyC+gX6YWUHpPWcHQ1TxCD8TtqTbFU3Ltd3AYl7d8ygMNBEe3
 T7DV2GjBI06Xqdhydhz2G5bWPM0JSodNDE/m6MrmoKSEG0xTNkH2w3TWWD4o1snte9406az0YOwkk
 xDq9LxEVoeg6POceQG9UdcsKiiAJQXu/I0iUprkybRUkUj+3oTJQECcdfL1QtkuJBh+IParSF14/j
 Xojwnf7tE5rm7QvMWWSiSRewro1vaXjgGyhKNyJ+HCCgp5mw+ch7KaDHtg0fG48yJgKNpjkzGWfLQ
 BNXqtd8VYn1mCM3YM7qdtf9bsgjQqpvFiAh7jYGrhYr7geRjary1hTc8WwrxAxaxGvo4xZ1XYps3u
 ayy5dGHdiddk5KJ4iMTLSLH3Rucl19966COQeCwDvFMjkNZx5ExHshWCV5W7+xX/2nIkKUfwXRKfK
 dsVTL03FG0YvY/8A98EMbvlf4TnpyyaytBtQYXVsaSBWaXJ0YW5lbiA8cGF2QGlraS5maT6JAlcEE
 wEIAEEWIQRqzkn1AmTRCTrMAJzkmgm4SzqwTwUCZf6qYQIbAwUJEswDAAULCQgHAgIiAgYVCgkICw
 IEFgIDAQIeBwIXgAAKCRDkmgm4SzqwTxYZD/9hfC+CaihOESMcTKHoK9JLkO34YC0t8u3JAyetIz3
 Z9ek42FU8fpf58vbpKUIR6POdiANmKLjeBlT0D3mHW2ta90O1s711NlA1yaaoUw7s4RJb09W2Votb
 G02pDu2qhupD1GNpufArm3mOcYDJt0Rhh9DkTR2WQ9SzfnfzapjxmRQtMzkrH0GWX5OPv368IzfbJ
 S1fw79TXmRx/DqyHg+7/bvqeA3ZFCnuC/HQST72ncuQA9wFbrg3ZVOPAjqrjesEOFFL4RSaT0JasS
 XdcxCbAu9WNrHbtRZu2jo7n4UkQ7F133zKH4B0SD5IclLgK6Zc92gnHylGEPtOFpij/zCRdZw20VH
 xrPO4eI5Za4iRpnKhCbL85zHE0f8pDaBLD9L56UuTVdRvB6cKncL4T6JmTR6wbH+J+s4L3OLjsyx2
 LfEcVEh+xFsW87YQgVY7Mm1q+O94P2soUqjU3KslSxgbX5BghY2yDcDMNlfnZ3SdeRNbssgT28PAk
 5q9AmX/5YyNbexOCyYKZ9TLcAJJ1QLrHGoZaAIaR72K/kmVxy0oqdtAkvCQw4j2DCQDR0lQXsH2bl
 WTSfNIdSZd4pMxXHFF5iQbh+uReDc8rISNOFMAZcIMd+9jRNCbyGcoFiLa52yNGOLo7Im+CIlmZEt
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2025-07-14 kello 16:15 +0200, Paul Menzel kirjoitti:
> Dear Pauli,
>=20
>=20
> Thank you for your patch.
>=20
>=20
> Am 14.07.25 um 16:02 schrieb Pauli Virtanen:
> > User applications need a way to track which ISO interval a given SDU
> > belongs to, to properly detect packet loss. All controllers do not set
> > timestamps, and it's not guaranteed user application receives all packe=
t
> > reports (small socket buffer, or controller doesn't send all reports
> > like Intel AX210 is doing).
> >=20
> > Add socket option BT_PKT_SEQNUM that enables reporting of received
> > packet ISO sequence number in BT_SCM_PKT_SEQNUM CMSG.
>=20
> Are there user applications already supporting this, so it can be tested?

I sent the associated tests to linux-bluetooth list

https://lore.kernel.org/linux-bluetooth/c9a75585e3640d8a1efca0bf96158eec1ca=
25fdc.1752501450.git.pav@iki.fi/

>=20
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >=20
> > Notes:
> >      Intel AX210 is not sending all reports:
> >     =20
> >      $ btmon -r dump.btsnoop -I -C90|grep -A1 'ISO Data RX: Handle 2304=
'
> >      ...
> >      > ISO Data RX: Handle 2304 flags 0x02 dlen 64                     =
 #1713 [hci0] 22.567744
> >              dd 01 3c 00 6d 08 e9 14 1e 3b 85 7b 35 c2 25 0b  ..<.m....=
;.{5.%.
> >      --
> >      > ISO Data RX: Handle 2304 flags 0x02 dlen 64                     =
 #1718 [hci0] 22.573745
> >              de 01 3c 00 41 65 22 4f 99 9b 0b b6 ff cb 06 00  ..<.Ae"O.=
.......
> >      --
> >      > ISO Data RX: Handle 2304 flags 0x02 dlen 64                     =
 #1727 [hci0] 22.587933
> >              e0 01 3c 00 8b 6e 33 44 65 51 ee d7 e0 ee 49 d8  ..<..n3De=
Q....I.
> >      --
> >      > ISO Data RX: Handle 2304 flags 0x02 dlen 64                     =
 #1732 [hci0] 22.596742
> >              e1 01 3c 00 a7 48 54 a7 c1 9f dc 37 66 fe 04 ab  ..<..HT..=
..7f...
> >      ...
> >     =20
> >      Here, report for packet with sequence number 0x01df is missing.
>=20
> Sorry, but where are the sequence number in the trace?

It's the first two bytes, see Core specification Vol 4E Sec 5.4.5 "HCI
ISO Data packets".

> >     =20
> >      This may be spec violation by the controller, see Core v6.1 pp. 37=
02
> >     =20
> >          All SDUs shall be sent to the upper layer including the indica=
tion
> >          of validity of data. A report shall be sent to the upper layer=
 if
> >          the SDU is completely missing.
> >     =20
> >      Regardless, it will be easier for user applications to see the HW
> >      sequence numbers directly, so they don't have to count packets and=
 it's
> >      in any case more reliable if packets get dropped due to socket buf=
fer
> >      size.
>=20
> I wouldn=E2=80=99t mind to have the note in the commit message.

I'm not sure it's a spec violation --- the text in the specification is
not fully clear what "All SDUs" means in the context here --- so I
don't really want to say so in the commit message.

The limited socket buffer and tha AX210 drops some reports is mentioned
in the commit message.

>=20
> >   include/net/bluetooth/bluetooth.h |  9 ++++++++-
> >   net/bluetooth/af_bluetooth.c      |  7 +++++++
> >   net/bluetooth/iso.c               | 21 ++++++++++++++++++---
> >   3 files changed, 33 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index 114299bd8b98..0e31779a3341 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -244,6 +244,10 @@ struct bt_codecs {
> >  =20
> >   #define BT_ISO_BASE		20
> >  =20
> > +#define BT_PKT_SEQNUM		21
> > +
> > +#define BT_SCM_PKT_SEQNUM	0x05
> > +
> >   __printf(1, 2)
> >   void bt_info(const char *fmt, ...);
> >   __printf(1, 2)
> > @@ -391,7 +395,8 @@ struct bt_sock {
> >   enum {
> >   	BT_SK_DEFER_SETUP,
> >   	BT_SK_SUSPEND,
> > -	BT_SK_PKT_STATUS
> > +	BT_SK_PKT_STATUS,
> > +	BT_SK_PKT_SEQNUM,
> >   };
> >  =20
> >   struct bt_sock_list {
> > @@ -475,6 +480,7 @@ struct bt_skb_cb {
> >   	u8 pkt_type;
> >   	u8 force_active;
> >   	u16 expect;
> > +	u16 pkt_seqnum;
>=20
> Excuse my ignorance, just want to make sure, the type is big enough.

The hardware sequence number is also 16 bits.

> >   	u8 incoming:1;
> >   	u8 pkt_status:2;
> >   	union {
> > @@ -488,6 +494,7 @@ struct bt_skb_cb {
> >  =20
> >   #define hci_skb_pkt_type(skb) bt_cb((skb))->pkt_type
> >   #define hci_skb_pkt_status(skb) bt_cb((skb))->pkt_status
> > +#define hci_skb_pkt_seqnum(skb) bt_cb((skb))->pkt_seqnum
> >   #define hci_skb_expect(skb) bt_cb((skb))->expect
> >   #define hci_skb_opcode(skb) bt_cb((skb))->hci.opcode
> >   #define hci_skb_event(skb) bt_cb((skb))->hci.req_event
> > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.=
c
> > index 6ad2f72f53f4..44b7acb20a67 100644
> > --- a/net/bluetooth/af_bluetooth.c
> > +++ b/net/bluetooth/af_bluetooth.c
> > @@ -364,6 +364,13 @@ int bt_sock_recvmsg(struct socket *sock, struct ms=
ghdr *msg, size_t len,
> >   			put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_STATUS,
> >   				 sizeof(pkt_status), &pkt_status);
> >   		}
> > +
> > +		if (test_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags)) {
> > +			u16 pkt_seqnum =3D hci_skb_pkt_seqnum(skb);
> > +
> > +			put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_SEQNUM,
> > +				 sizeof(pkt_seqnum), &pkt_seqnum);
> > +		}
> >   	}
> >  =20
> >   	skb_free_datagram(sk, skb);
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index fc22782cbeeb..469450bb6b6c 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -1687,6 +1687,17 @@ static int iso_sock_setsockopt(struct socket *so=
ck, int level, int optname,
> >   			clear_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
> >   		break;
> >  =20
> > +	case BT_PKT_SEQNUM:
> > +		err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
> > +		if (err)
> > +			break;
> > +
> > +		if (opt)
> > +			set_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags);
> > +		else
> > +			clear_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags);
> > +		break;
> > +
> >   	case BT_ISO_QOS:
> >   		if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOUND &&
> >   		    sk->sk_state !=3D BT_CONNECT2 &&
> > @@ -2278,7 +2289,7 @@ static void iso_disconn_cfm(struct hci_conn *hcon=
, __u8 reason)
> >   void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
> >   {
> >   	struct iso_conn *conn =3D hcon->iso_data;
> > -	__u16 pb, ts, len;
> > +	__u16 pb, ts, len, sn;
>=20
> Use `seqnum` for consistency with the parts above.
>=20
> >  =20
> >   	if (!conn)
> >   		goto drop;
> > @@ -2308,6 +2319,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_bu=
ff *skb, u16 flags)
> >   				goto drop;
> >   			}
> >  =20
> > +			sn =3D hdr->sn;
> >   			len =3D __le16_to_cpu(hdr->slen);
> >   		} else {
> >   			struct hci_iso_data_hdr *hdr;
> > @@ -2318,18 +2330,20 @@ void iso_recv(struct hci_conn *hcon, struct sk_=
buff *skb, u16 flags)
> >   				goto drop;
> >   			}
> >  =20
> > +			sn =3D hdr->sn;
> >   			len =3D __le16_to_cpu(hdr->slen);
> >   		}
> >  =20
> >   		flags  =3D hci_iso_data_flags(len);
> >   		len    =3D hci_iso_data_len(len);
> >  =20
> > -		BT_DBG("Start: total len %d, frag len %d flags 0x%4.4x", len,
> > -		       skb->len, flags);
> > +		BT_DBG("Start: total len %d, frag len %d flags 0x%4.4x sn %d",
> > +		       len, skb->len, flags, sn);
> >  =20
> >   		if (len =3D=3D skb->len) {
> >   			/* Complete frame received */
> >   			hci_skb_pkt_status(skb) =3D flags & 0x03;
> > +			hci_skb_pkt_seqnum(skb) =3D sn;
> >   			iso_recv_frame(conn, skb);
> >   			return;
> >   		}
> > @@ -2352,6 +2366,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_bu=
ff *skb, u16 flags)
> >   			goto drop;
> >  =20
> >   		hci_skb_pkt_status(conn->rx_skb) =3D flags & 0x03;
> > +		hci_skb_pkt_seqnum(conn->rx_skb) =3D sn;
> >   		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
> >   					  skb->len);
> >   		conn->rx_len =3D len - skb->len;
>=20
>=20
> Kind regards,
>=20
> Paul

--=20
Pauli Virtanen

