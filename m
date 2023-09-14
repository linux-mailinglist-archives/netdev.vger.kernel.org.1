Return-Path: <netdev+bounces-33807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B15E7A03AD
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532FF1C20E2E
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601EE219F3;
	Thu, 14 Sep 2023 12:22:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB1208BD
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 12:22:27 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70FCD1FC0;
	Thu, 14 Sep 2023 05:22:26 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38ECLd5A21169338, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38ECLd5A21169338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Sep 2023 20:21:41 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 14 Sep 2023 20:21:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 14 Sep 2023 20:21:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Thu, 14 Sep 2023 20:21:39 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v7 02/13] net:ethernet:realtek:rtase: Implement the .ndo_open function
Thread-Topic: [PATCH net-next v7 02/13] net:ethernet:realtek:rtase: Implement
 the .ndo_open function
Thread-Index: AQHZ5Voer1zs1eayP0a8NW2oYFXOS7AYxCOAgAF8KOA=
Date: Thu, 14 Sep 2023 12:21:39 +0000
Message-ID: <226589a878f64b5eae3b7ca55936e926@realtek.com>
References: <20230912091830.338164-1-justinlai0215@realtek.com>
 <20230912091830.338164-3-justinlai0215@realtek.com>
 <a7a4d7b6-84cd-49fc-9fde-1a6a232bf7af@lunn.ch>
In-Reply-To: <a7a4d7b6-84cd-49fc-9fde-1a6a232bf7af@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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

> On Tue, Sep 12, 2023 at 05:18:19PM +0800, Justin Lai wrote:
> > Implement the .ndo_open function to set default hardware settings and
> > initialize the descriptor ring and interrupts. Among them, when
> > requesting irq, because the first group of interrupts needs to process
> > more events, the overall structure will be different from other groups
> > of interrupts, so it needs to be processed separately.
>=20
> Please take a look at the page pool code.
>=20
>        Andrew

Hi, Andrew
Do you want us to use Page Pool API in this driver?

