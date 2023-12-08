Return-Path: <netdev+bounces-55235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EE9809F4C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC0E1F2102B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 09:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224D0125A7;
	Fri,  8 Dec 2023 09:28:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B1F1724;
	Fri,  8 Dec 2023 01:28:13 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B89RiMA2781900, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B89RiMA2781900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Dec 2023 17:27:44 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 8 Dec 2023 17:27:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 8 Dec 2023 17:27:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 8 Dec 2023 17:27:44 +0800
From: Justin Lai <justinlai0215@realtek.com>
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
Subject: RE: [PATCH net-next v13 01/13] rtase: Add pci table supported in this module
Thread-Topic: [PATCH net-next v13 01/13] rtase: Add pci table supported in
 this module
Thread-Index: AQHaI4J1hYqre02tzkGBvHQzDpC7MLCU5PoAgAV9LKCAALy7AIAECGwQ
Date: Fri, 8 Dec 2023 09:27:44 +0000
Message-ID: <e5281291c4c04630ab818fdc8394841b@realtek.com>
References: <20231130114327.1530225-1-justinlai0215@realtek.com>
	<20231130114327.1530225-2-justinlai0215@realtek.com>
	<20231201203602.7e380716@kernel.org>
	<ae4807e31b53452ebf176098d95cf1fb@realtek.com>
 <20231205194050.7033cc2b@kernel.org>
In-Reply-To: <20231205194050.7033cc2b@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
> On Wed, 6 Dec 2023 03:28:32 +0000 Justin Lai wrote:
> > > > +static void rtase_remove_one(struct pci_dev *pdev) {
> > > > +     struct net_device *dev =3D pci_get_drvdata(pdev);
> > > > +     struct rtase_private *tp =3D netdev_priv(dev);
> > > > +     struct rtase_int_vector *ivec;
> > > > +     u32 i;
> > > > +
> > > > +     for (i =3D 0; i < tp->int_nums; i++) {
> > > > +             ivec =3D &tp->int_vector[i];
> > > > +             netif_napi_del(&ivec->napi);
> > >
> > > NAPI instances should be added on ndo_open()
> >
> > Do you want me to call netif_napi_add() in the .ndo_open function, and
> > netif_napi_del() in the .ndo_stop function? However, I saw that many
> > drivers do it in probe and remove. What is the purpose of doing this
> > in .ndo_open and .ndo_stop?
>=20
> They will sit in a fixed-size hash table used for NAPI lookup in the core=
. Not a
> big deal, but not the best way either.
>=20
> I think the main thing that prompted me to ask was that I couldn't find
> napi_disable() in the first few patches. You should probably call it on c=
lose,
> otherwise making sure NAPI is not running when you start freeing rings is=
 hard.
> synchronize_irq() will not help you at all if you're using NAPI.

Thanks, I will call napi_disable() on close to fix this issue.

