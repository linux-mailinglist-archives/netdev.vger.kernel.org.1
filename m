Return-Path: <netdev+bounces-57407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8858130BD
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120EF1C208D9
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B834D13E;
	Thu, 14 Dec 2023 13:00:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A31E116;
	Thu, 14 Dec 2023 05:00:56 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BED0T3K0846654, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BED0T3K0846654
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 21:00:29 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 14 Dec 2023 21:00:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 14 Dec 2023 21:00:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 14 Dec 2023 21:00:29 +0800
From: JustinLai0215 <justinlai0215@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>, Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v14 06/13] rtase: Implement .ndo_start_xmit function
Thread-Topic: [PATCH net-next v14 06/13] rtase: Implement .ndo_start_xmit
 function
Thread-Index: AQHaKbubsEorOK9BY0aC7C+4Ofl+iLClijsAgAM7r5A=
Date: Thu, 14 Dec 2023 13:00:29 +0000
Message-ID: <ce315d58376c40d4abf82d80bf203c81@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	<20231208094733.1671296-7-justinlai0215@realtek.com>
 <20231212113212.1cfb9e19@kernel.org>
In-Reply-To: <20231212113212.1cfb9e19@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

>=20
> On Fri, 8 Dec 2023 17:47:26 +0800 Justin Lai wrote:
> > +static int tx_handler(struct rtase_ring *ring, int budget)
>=20
> I don't see how this is called, the way you split the submission makes it=
 a bit
> hard to review, oh well. Anyway - if you pass the NAPI budget here - that=
's not
> right, it may be 0, and you'd loop forever.
> For Tx - you should try to reap some fixed number of packets, say 128, th=
e
> budget is for Rx, not for Tx.

Even if the budget is 0, this function will not loop forever, it will just =
run all tx_left.
Or what changes would you like us to make?
>=20
> > +     const struct rtase_private *tp =3D ring->ivec->tp;
> > +     struct net_device *dev =3D tp->dev;
> > +     int workdone =3D 0;
> > +     u32 dirty_tx;
> > +     u32 tx_left;
> > +
> > +     dirty_tx =3D ring->dirty_idx;
> > +     tx_left =3D READ_ONCE(ring->cur_idx) - dirty_tx;
> > +
> > +     while (tx_left > 0) {
> > +             u32 entry =3D dirty_tx % NUM_DESC;
> > +             struct tx_desc *desc =3D ring->desc +
> > +                                    sizeof(struct tx_desc) * entry;
> > +             u32 len =3D ring->mis.len[entry];
> > +             u32 status;
> > +
> > +             status =3D le32_to_cpu(desc->opts1);
> > +
> > +             if (status & DESC_OWN)
> > +                     break;
> > +
> > +             rtase_unmap_tx_skb(tp->pdev, len, desc);
> > +             ring->mis.len[entry] =3D 0;
> > +             if (ring->skbuff[entry]) {
> > +                     dev_consume_skb_any(ring->skbuff[entry]);
>=20
> napi_consume_skb, assuming you call this from NAPI

Ok, I will modify it.
>=20
> > +                     ring->skbuff[entry] =3D NULL;
> > +             }
> > +
> > +             dev->stats.tx_bytes +=3D len;
> > +             dev->stats.tx_packets++;
> > +             dirty_tx++;
> > +             tx_left--;
> > +             workdone++;
> > +
> > +             if (workdone =3D=3D budget)
> > +                     break;
> > +     }
> > +
> > +     if (ring->dirty_idx !=3D dirty_tx) {
> > +             WRITE_ONCE(ring->dirty_idx, dirty_tx);
> > +
> > +             if (__netif_subqueue_stopped(dev, ring->index) &&
> > +                 rtase_tx_avail(ring))
> > +                     netif_start_subqueue(dev, ring->index);
>=20
> Please use the start / stop macros from include/net/netdev_queues.h I'm
> pretty sure the current code is racy.
>=20

Ok, I will use the macros from include/net/netdev_queues.h.

