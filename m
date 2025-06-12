Return-Path: <netdev+bounces-196796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BDBAD6626
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 05:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2832817ABF6
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 03:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251321DE4FF;
	Thu, 12 Jun 2025 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZxLc8dA6"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7610957;
	Thu, 12 Jun 2025 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749698911; cv=none; b=o+8ueUZT+WK6eRtQNbaCzZ0BlssZJ71nxnEZ4jBcXkJvJ+KgKtptdc09yIW9ZCUb833g4jr7cBD9cwbyWVyx3+YSGnr7xUorrzzkmYoqyJ07mpnTuqOiKhyyHNOtNhH/hRlYmxbIhS3Gc34aBpa9NpoEY0tFcPpoJOzFdrKsb6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749698911; c=relaxed/simple;
	bh=bUvehuoml30p8aPi1ZM9ydnS9yaYvxNEJd96+Pn0+kE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AtjnxCEWE/aX1nbPH+vC/9vWAVakItEQnfGfGCzLGoNEk/mBU83AeOM35dmENyU1BlpfvL0FFAWlGD1tS/OV5w/4/ruDWZOvwD1bFEivGy5HlY9qSA+/11zgWCTk4YD0eVGXVuB6cIVyhTxvYWiVTgJTkvDUT0G4LgURNDYifQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZxLc8dA6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55C3S56m81837699, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749698885; bh=VBWxyGdP2iKFf0ocWsJN478ovB6IZJkx64x1ve0SHZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZxLc8dA6vVWpeqmiT+cw0arbwYU3resH1lbepGuAEuXvK6n/vDBgxPN+QwzhR8dN4
	 ZfLCFmf1LLbXNi7vBi7Eha5a3VKNfhREoz6E4reujLYkzwT/WroI5P954dkmELlrJ0
	 qePnAQCIzeKpUQKju30/XXcsU2N1jPfX4nzmT3iwahGku9IlHVotAer7ppEAktn8t/
	 +H4pRTBeOBCtUp0+8C1/DfYzPezyKisjMIEgR/1ZNscy+cdQo152MbaNypbq9uJcVU
	 kCwHMNmNuuZElYw9uHosrhenRJbFA/OWlG6z/lMdqpzBOFrfgybt7CCnRsoXKHNKr6
	 YO1Z7a6FqYcuQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55C3S56m81837699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 11:28:05 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 11:28:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 12 Jun 2025 11:28:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 12 Jun 2025 11:28:04 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Joe Damato <joe@dama.to>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        "jdamato@fastly.com" <jdamato@fastly.com>,
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next 2/2] rtase: Link queues to NAPI instances
Thread-Topic: [PATCH net-next 2/2] rtase: Link queues to NAPI instances
Thread-Index: AQHb2fNMMFGZrVpSUkGdaCviahUiEbP9eXUAgAFmCJA=
Date: Thu, 12 Jun 2025 03:28:04 +0000
Message-ID: <1fb1d09b719548f0a2bad261f2bf9b4a@realtek.com>
References: <20250610103334.10446-1-justinlai0215@realtek.com>
 <20250610103334.10446-3-justinlai0215@realtek.com>
 <aEmM6D9DKxxiarSP@MacBook-Air.local>
In-Reply-To: <aEmM6D9DKxxiarSP@MacBook-Air.local>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> On Tue, Jun 10, 2025 at 06:33:34PM +0800, Justin Lai wrote:
> > Link queues to NAPI instances with netif_queue_set_napi. This
> > information can be queried with the netdev-genl API.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> >  drivers/net/ethernet/realtek/rtase/rtase.h    |  4 +++
> >  .../net/ethernet/realtek/rtase/rtase_main.c   | 33 +++++++++++++++++--
> >  2 files changed, 35 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h
> > b/drivers/net/ethernet/realtek/rtase/rtase.h
> > index 498cfe4d0cac..be98f4de46c4 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase.h
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> > @@ -39,6 +39,9 @@
> >  #define RTASE_FUNC_RXQ_NUM  1
> >  #define RTASE_INTERRUPT_NUM 1
> >
> > +#define RTASE_TX_RING 0
> > +#define RTASE_RX_RING 1
> > +
> >  #define RTASE_MITI_TIME_COUNT_MASK    GENMASK(3, 0)
> >  #define RTASE_MITI_TIME_UNIT_MASK     GENMASK(7, 4)
> >  #define RTASE_MITI_DEFAULT_TIME       128
> > @@ -288,6 +291,7 @@ struct rtase_ring {
> >       u32 cur_idx;
> >       u32 dirty_idx;
> >       u16 index;
> > +     u8 ring_type;
>=20
> Two questions:
>=20
> 1. why not use enum netdev_queue_type instead of making driver specific
> values that are the opposite of the existing enum values ?
>=20
> If you used the existing enum, you could omit the if below (see below), a=
s
> well?
>=20
> 2. is "ring" in the name redundant? maybe just "type"? asking because bel=
ow
> the code becomes "ring->ring_type" and maybe "ring->type" is better?
>=20
> >       struct sk_buff *skbuff[RTASE_NUM_DESC];
> >       void *data_buf[RTASE_NUM_DESC];
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index a88af868da8c..ef3ada91d555 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -326,6 +326,7 @@ static void rtase_tx_desc_init(struct rtase_private
> *tp, u16 idx)
> >       ring->cur_idx =3D 0;
> >       ring->dirty_idx =3D 0;
> >       ring->index =3D idx;
> > +     ring->ring_type =3D RTASE_TX_RING;
> >       ring->alloc_fail =3D 0;
> >
> >       for (i =3D 0; i < RTASE_NUM_DESC; i++) { @@ -345,6 +346,10 @@
> > static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)
> >               ring->ivec =3D &tp->int_vector[0];
> >               list_add_tail(&ring->ring_entry,
> &tp->int_vector[0].ring_list);
> >       }
> > +
> > +     netif_queue_set_napi(tp->dev, ring->index,
> > +                          NETDEV_QUEUE_TYPE_TX,
> > +                          &ring->ivec->napi);
> >  }
> >
> >  static void rtase_map_to_asic(union rtase_rx_desc *desc, dma_addr_t
> > mapping, @@ -590,6 +595,7 @@ static void rtase_rx_desc_init(struct
> rtase_private *tp, u16 idx)
> >       ring->cur_idx =3D 0;
> >       ring->dirty_idx =3D 0;
> >       ring->index =3D idx;
> > +     ring->ring_type =3D RTASE_RX_RING;
> >       ring->alloc_fail =3D 0;
> >
> >       for (i =3D 0; i < RTASE_NUM_DESC; i++) @@ -597,6 +603,9 @@ static
> > void rtase_rx_desc_init(struct rtase_private *tp, u16 idx)
> >
> >       ring->ring_handler =3D rx_handler;
> >       ring->ivec =3D &tp->int_vector[idx];
> > +     netif_queue_set_napi(tp->dev, ring->index,
> > +                          NETDEV_QUEUE_TYPE_RX,
> > +                          &ring->ivec->napi);
> >       list_add_tail(&ring->ring_entry,
> > &tp->int_vector[idx].ring_list);  }
> >
> > @@ -1161,8 +1170,18 @@ static void rtase_down(struct net_device *dev)
> >               ivec =3D &tp->int_vector[i];
> >               napi_disable(&ivec->napi);
> >               list_for_each_entry_safe(ring, tmp, &ivec->ring_list,
> > -                                      ring_entry)
> > +                                      ring_entry) {
> > +                     if (ring->ring_type =3D=3D RTASE_TX_RING)
> > +                             netif_queue_set_napi(tp->dev,
> ring->index,
> > +
> NETDEV_QUEUE_TYPE_TX,
> > +                                                  NULL);
> > +                     else
> > +                             netif_queue_set_napi(tp->dev,
> ring->index,
> > +
> NETDEV_QUEUE_TYPE_RX,
> > +                                                  NULL);
> > +
>=20
> Using the existing enum would simplify this block?
>=20
>   netif_queue_set_napi(tp->dev, ring->index, ring->type, NULL);
>=20
> >                       list_del(&ring->ring_entry);
> > +             }
> >       }
> >
> >       netif_tx_disable(dev);
> > @@ -1518,8 +1537,18 @@ static void rtase_sw_reset(struct net_device
> *dev)
> >       for (i =3D 0; i < tp->int_nums; i++) {
> >               ivec =3D &tp->int_vector[i];
> >               list_for_each_entry_safe(ring, tmp, &ivec->ring_list,
> > -                                      ring_entry)
> > +                                      ring_entry) {
> > +                     if (ring->ring_type =3D=3D RTASE_TX_RING)
> > +                             netif_queue_set_napi(tp->dev,
> ring->index,
> > +
> NETDEV_QUEUE_TYPE_TX,
> > +                                                  NULL);
> > +                     else
> > +                             netif_queue_set_napi(tp->dev,
> ring->index,
> > +
> NETDEV_QUEUE_TYPE_RX,
> > +                                                  NULL);
> > +
>=20
> Same as above?

Hi Joe,

Thank you for your reply. I will use the enum netdev_queue_type to avoid
needing if statements to determine the ring type later. I will also rename
ring_type to type.

Thanks,
Justin

