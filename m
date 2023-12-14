Return-Path: <netdev+bounces-57404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A27208130A0
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD9F1C20C98
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DD94D13D;
	Thu, 14 Dec 2023 12:54:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CE2113;
	Thu, 14 Dec 2023 04:54:30 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BECsBVp9840430, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BECsBVp9840430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 20:54:11 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 14 Dec 2023 20:54:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 14 Dec 2023 20:54:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 14 Dec 2023 20:54:11 +0800
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
Subject: RE: [PATCH net-next v14 03/13] rtase: Implement the rtase_down function
Thread-Topic: [PATCH net-next v14 03/13] rtase: Implement the rtase_down
 function
Thread-Index: AQHaKbuZ68k3qmPPt0euso8G9Dk2ErCliPGAgAM8MgA=
Date: Thu, 14 Dec 2023 12:54:11 +0000
Message-ID: <39c9b2df2a02412b84f6e7946f012917@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	<20231208094733.1671296-4-justinlai0215@realtek.com>
 <20231212112735.180d455f@kernel.org>
In-Reply-To: <20231212112735.180d455f@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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
> On Fri, 8 Dec 2023 17:47:23 +0800 Justin Lai wrote:
> > +     netif_stop_queue(dev);
>=20
> You most likely want to stop the napi before you call this.
> Otherwise NAPI can do some clean up and restart the queue.
>=20
> > +     /* give a racing hard_start_xmit a few cycles to complete */
> > +     synchronize_rcu();
>=20
> Call netif_tx_disable() instead of stop_queue(), it takes the tx lock so =
you don't
> have to worry about in-flight packets.

Thanks for your suggestion, I will modify it.
>=20
> > +     netif_carrier_off(dev);
> > +
> > +     for (i =3D 0; i < tp->int_nums; i++) {
> > +             ivec =3D &tp->int_vector[i];
> > +             synchronize_irq(ivec->irq);
>=20
> Why?

This is redundant code, I will remove it.
>=20
> > +             /* wait for any pending NAPI task to complete */
> > +             napi_disable(&ivec->napi);
> > +     }

