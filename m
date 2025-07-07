Return-Path: <netdev+bounces-204491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBDEAFAD5F
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B979189B47E
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AD928982C;
	Mon,  7 Jul 2025 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="T2UrGMXE"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C7A21FF29;
	Mon,  7 Jul 2025 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874115; cv=pass; b=YVN0uEEBGcFjxGwxAvFBw/77GMWOpcNOfvnLbfmd68S7t/oHyIVx/6YCmM95TArmjhQWVXHo2W50c5l9+3zvBbTleK45CT3jfFLnuIeBVeCNPCP/E771Y/kO8kXl/s4fUhtA/RIo43eNLlm3om605Pum2fIej6tcQoDaIIcsH/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874115; c=relaxed/simple;
	bh=EEvrguarnDhVlbcjHI4o/Byu1O/5VKQZB2CJ3M6w1BU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q3HjWxplvoNmw55rZXMPjkH3SYQDjaBt4iSkWPHfCd4F6hWq3ah0564TOiWmeCW0RGKa4pey/dRMI+zrDlXbj4VQVu770/WlefWfX4BTYsDZQfNJzcaldGxA9UGT2/BU9OhZQ527AZhGh5gSA7+y9Xqn18ebB5/x+7+VQIGKiaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=T2UrGMXE; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bbGQW1GK8z49Py8;
	Mon,  7 Jul 2025 10:41:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1751874100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7+mwUpiMnx981qagHlNXIXl+8q7sLqHuoxEHPtxJ+WM=;
	b=T2UrGMXEGTMBnh13iGVE1koeNS6HetAJQ3Gy2TbgWLWMtyNBs5b4nSbSlDkvz6K9fDTgAx
	XCL90dBc2nD9KBJQvRjs0a4C+FA8i49VaODfJRp7oHAf6tRpOWrGOFMPeqGU2uws6jxo92
	xMMpkDUhc+n+KQt//+lFYfvxFWPaQLp6Af+a4KUT4XKdKBZUXbj6k9eXdb9J6U5rM9m35o
	JgQIwLeaiJvYpQ0Y1nCfCaXI7aU4/xdcLNZ6ddw62VKwmqqkIT8UEYBBGvXUpIoUGQ/CT3
	TwYa4R0Jlu7xrS1esl2GQixFRJCRbxuTb+ukBO8vyKvL4UdC64eg55l3bpomoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1751874100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7+mwUpiMnx981qagHlNXIXl+8q7sLqHuoxEHPtxJ+WM=;
	b=NGLlF7FQ3s3A3qWjaXpn+sVyseNw4M96YHTeq49loEg2pjLmIeX0C7Z/lEKhtBHkCdI5qm
	RAvj9FDleMLgnF7S2A73nic0aSZ48tFFV5wha/XtcvAQnCiFIbOaDvKR0HEyzsDf5TVWPB
	wQyJQYWyl08yFuU/BSJ9Uq0HnTYDrEIgY2VvdcTaQfS36AcHIYN386o/dcYAbCrlvv6zPj
	vkj3Q9whHUK0EPY0pqqTqtjl74Z+fer8Su1U4alSIeZoaJie0izH0vMX294KXkctZ72czh
	WA3uFikqOe7ZHc4tKEkDzDm0mAB3JGBhdwIWqczfYIAsxpBNVAjJVy8Y3hr8Yg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1751874100; a=rsa-sha256;
	cv=none;
	b=aHoEWx8VCg26aHNgLKKR3i+iFDU/cWuiQagEv56T1IzKDwZAdu3cho78pnBk6KNeNvlhKP
	admPgzOThqaFwRgXrfYb8sQuTZgvEgzgbvXS0xYRQeC+wDUeEKhtCBeNZO3oRo2uGcFP5L
	QRsAkiBDkdRXS9bGUCctMdtthbqHro9kM2FqvkKjQ6Qx/8ugH1D3UqIBczsVKVNsB93at+
	4B/xzF/wUmas3iy+h0iHLFpEKuBiOCmlQCxiz1hVk4gPRGmJOk8h3R9l8CbHm/J2JV1w/j
	CwO4+FE8ONDqQZ4qBxW7dX+7QNCl63hrztdVnERW4jNqmPwsdOCotsbpG6dLyQ==
Message-ID: <3586e2f53a1a4c0772515846cf5ec91044e2cfec.camel@iki.fi>
Subject: Re: [PATCH v3] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
From: Pauli Virtanen <pav@iki.fi>
To: Yang Li <yang.li@amlogic.com>, Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman	 <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 07 Jul 2025 10:41:36 +0300
In-Reply-To: <df9f6977-0d63-41b3-8d9b-c3a293ed78ec@amlogic.com>
References: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
	 <bebb44579ed8379a0d69a2f2793a70471b08ea91.camel@iki.fi>
	 <df9f6977-0d63-41b3-8d9b-c3a293ed78ec@amlogic.com>
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

ma, 2025-07-07 kello 09:48 +0800, Yang Li kirjoitti:
> Hi,
> > [ EXTERNAL EMAIL ]
> >=20
> > Hi,
> >=20
> > pe, 2025-07-04 kello 13:36 +0800, Yang Li via B4 Relay kirjoitti:
> > > From: Yang Li <yang.li@amlogic.com>
> > >=20
> > > User-space applications (e.g., PipeWire) depend on
> > > ISO-formatted timestamps for precise audio sync.
> > >=20
> > > Signed-off-by: Yang Li <yang.li@amlogic.com>
> > > ---
> > > Changes in v3:
> > > - Change to use hwtimestamp
> > > - Link to v2: https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d199c=
8068@amlogic.com
> > >=20
> > > Changes in v2:
> > > - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
> > > - Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30d=
e6cb@amlogic.com
> > > ---
> > >   net/bluetooth/iso.c | 10 +++++++++-
> > >   1 file changed, 9 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > > index fc22782cbeeb..67ff355167d8 100644
> > > --- a/net/bluetooth/iso.c
> > > +++ b/net/bluetooth/iso.c
> > > @@ -2301,13 +2301,21 @@ void iso_recv(struct hci_conn *hcon, struct s=
k_buff *skb, u16 flags)
> > >                if (ts) {
> > >                        struct hci_iso_ts_data_hdr *hdr;
> > >=20
> > > -                     /* TODO: add timestamp to the packet? */
> > >                        hdr =3D skb_pull_data(skb, HCI_ISO_TS_DATA_HDR=
_SIZE);
> > >                        if (!hdr) {
> > >                                BT_ERR("Frame is too short (len %d)", =
skb->len);
> > >                                goto drop;
> > >                        }
> > >=20
> > > +                     /* The ISO ts is based on the controller=E2=80=
=99s clock domain,
> > > +                      * so hardware timestamping (hwtimestamp) must =
be used.
> > > +                      * Ref: Documentation/networking/timestamping.r=
st,
> > > +                      * chapter 3.1 Hardware Timestamping.
> > > +                      */
> > > +                     struct skb_shared_hwtstamps *hwts =3D skb_hwtst=
amps(skb);
> > > +                     if (hwts)
> > In addition to the moving variable on top, the null check is spurious
> > as skb_hwtstamps is never NULL (driver/net/* do not check it either).
> >=20
> > Did you test this with SOF_TIMESTAMPING_RX_HARDWARE in userspace?
> > Pipewire does not try to get HW timestamps right now.
> >=20
> > Would be good to also add some tests in bluez/tools/iso-tester.c
> > although this needs some extension to the emulator/* to support
> > timestamps properly.
>=20
>=20
> Yes, here is the patch and log based on testing with Pipewire:
>=20
> diff --git a/spa/plugins/bluez5/media-source.c=20
> b/spa/plugins/bluez5/media-source.c
> index 2fe08b8..10e9378 100644
> --- a/spa/plugins/bluez5/media-source.c
> +++ b/spa/plugins/bluez5/media-source.c
> @@ -407,7 +413,7 @@ static int32_t read_data(struct impl *this) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct msghdr msg =3D {0};
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iovec iov;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char control[128];
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct timespec *ts =3D NULL;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct scm_timestamping *ts =3D NUL=
L;
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iov.iov_base =3D this->buffer=
_read;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iov.iov_len =3D b_size;
> @@ -439,12 +445,14 @@ again:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cmsghdr *cmsg;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (cmsg =3D CMSG_FIRSTHDR(&=
msg); cmsg !=3D NULL; cmsg =3D=20
> CMSG_NXTHDR(&msg, cmsg)) {
>  =C2=A0#ifdef SCM_TIMESTAMPING
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* Check for timestamp */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (cmsg->cmsg_level =3D=3D SOL_SOCKET && cmsg->cmsg_type =3D=
=3D=20
> SCM_TIMESTAMPING) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ts =3D (struct=
 scm_timestamping *)CMSG_DATA(cmsg);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spa_log_error(=
this->log, "%p: received timestamp=20
> %ld.%09ld",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 this, ts->ts[2].tv_sec,=20
> ts->ts[2].tv_nsec);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>  =C2=A0#endif
>=20
>  =C2=A0@@ -726,9 +734,9 @@ static int transport_start(struct impl *this)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (setsockopt(this->fd, SOL_=
SOCKET, SO_PRIORITY, &val,=20
> sizeof(val)) < 0)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 spa_log_warn(this->log, "SO_PRIORITY failed: %m");
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D SOF_TIMESTAMPING_RX_HARDWAR=
E | SOF_TIMESTAMPING_RAW_HARDWARE;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (setsockopt(this->fd, SOL_SOCKET=
, SO_TIMESTAMPING, &val,=20
> sizeof(val)) < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 spa_log_warn(this->log, "SO_TIMESTAMPING failed: %m");
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* don't fail if timestamping is not supported */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> trace log=EF=BC=9A
>=20
> read_data: 0x1e78d68: received timestamp 7681.972000000
> read_data: 0x1e95000: received timestamp 7681.972000000
> read_data: 0x1e78d68: received timestamp 7691.972000000
> read_data: 0x1e95000: received timestamp 7691.972000000

The counter increases by 10 *seconds* on each step. Is there some
scaling problem here, or is the hardware producing bogus values?

Isn't it supposed to increase by ISO interval (10 *milliseconds*)?

> read_data: 0x1e78d68: received timestamp 7701.972000000
> read_data: 0x1e95000: received timestamp 7701.972000000
> read_data: 0x1e78d68: received timestamp 7711.972000000
> read_data: 0x1e95000: received timestamp 7711.972000000
> read_data: 0x1e78d68: received timestamp 7721.972000000
> read_data: 0x1e95000: received timestamp 7721.972000000
> read_data: 0x1e78d68: received timestamp 7731.972000000
>=20
> >=20
> > > +                             hwts->hwtstamp =3D us_to_ktime(le32_to_=
cpu(hdr->ts));
> > > +
> > >                        len =3D __le16_to_cpu(hdr->slen);
> > >                } else {
> > >                        struct hci_iso_data_hdr *hdr;
> > >=20
> > > ---
> > > base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
> > > change-id: 20250421-iso_ts-c82a300ae784
> > >=20
> > > Best regards,
> > --
> > Pauli Virtanen

--=20
Pauli Virtanen

