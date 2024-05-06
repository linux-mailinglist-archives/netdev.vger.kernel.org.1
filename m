Return-Path: <netdev+bounces-93589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387FC8BC5EA
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 04:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6F0281AAA
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 02:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9E3399B;
	Mon,  6 May 2024 02:45:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7122075;
	Mon,  6 May 2024 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714963533; cv=none; b=iX1OTyeDWJGwYHGRXXC/ajpYQVG2UTzzwUetcx/TrnjDYn9u/13bo8N4bWtflYj4yfqYZOjBOJhT0bci/UkKS46PpOTKlwD4XpLlR+T0vrpJHjvb9cMoHI0mIagv319R3FVvZ7KvtN9OTZxPtq0U/PVMJNLflPKne5lqWhzAJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714963533; c=relaxed/simple;
	bh=oOeHH2W9Cd+yFl/mMg3CVMUPul4l8dHXAZfySlsb4QU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P0SmX4/AkYsjDvSPvog/CyuFLiwnG04NZZqBOoU0gkHW5IlWFog2CFaFK71NHIfsT9n9qneN1WJBGVET49GljAlxKoGwu5lDwEqC32nyXApLEba7Boq8rplOMoJhVCaDxpDe8wN5X5vFT0xmvzs/G/0UrjzkjgjYpbYoU1q/lCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4462jCiiD1819573, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4462jCiiD1819573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 10:45:12 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 10:45:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 10:45:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 6 May 2024 10:45:11 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Simon Horman <horms@kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v17 02/13] rtase: Implement the .ndo_open function
Thread-Topic: [PATCH net-next v17 02/13] rtase: Implement the .ndo_open
 function
Thread-Index: AQHanHHZpNHx0voP+0CDD26jysJVP7GEr5aAgATU6AA=
Date: Mon, 6 May 2024 02:45:11 +0000
Message-ID: <745b2ee9e81f4904920e0e4fe6e4df89@realtek.com>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
 <20240502091847.65181-3-justinlai0215@realtek.com>
 <20240503085257.GM2821784@kernel.org>
In-Reply-To: <20240503085257.GM2821784@kernel.org>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

>=20
>=20
> On Thu, May 02, 2024 at 05:18:36PM +0800, Justin Lai wrote:
> > Implement the .ndo_open function to set default hardware settings and
> > initialize the descriptor ring and interrupts. Among them, when
> > requesting irq, because the first group of interrupts needs to process
> > more events, the overall structure will be different from other groups
> > of interrupts, so it needs to be processed separately.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
>=20
> Hi Justin,
>=20
> some minor feedback from my side.
>=20
> > ---
> >  .../net/ethernet/realtek/rtase/rtase_main.c   | 419 ++++++++++++++++++
> >  1 file changed, 419 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 5ddb5f7abfe9..b286aac1eedc 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -130,6 +130,293 @@ static u32 rtase_r32(const struct rtase_private *=
tp,
> u16 reg)
> >       return readl(tp->mmio_addr + reg);  }
> >
> > +static void rtase_set_rxbufsize(struct rtase_private *tp) {
> > +     tp->rx_buf_sz =3D RTASE_RX_BUF_SIZE; }
>=20
> I'm a big fan of helpers, but maybe it's better to just open-code this on=
e as it is
> trivial and seems to only be used once.

OK, I understand what you mean, I will modify it.
>=20
> > +
> > +     rtase_set_rxbufsize(tp);
> > +
> > +     ret =3D rtase_alloc_desc(tp);
> > +     if (ret)
> > +             goto err_free_all_allocated_mem;
> > +
> > +     ret =3D rtase_init_ring(dev);
> > +     if (ret)
> > +             goto err_free_all_allocated_mem;
> > +
> > +     rtase_hw_config(dev);
> > +
> > +     if (tp->sw_flag & RTASE_SWF_MSIX_ENABLED) {
> > +             ret =3D request_irq(ivec->irq, rtase_interrupt, 0,
> > +                               dev->name, ivec);
> > +             if (ret)
> > +                     goto err_free_all_allocated_irq;
>=20
> This goto jumps to code that relies on i to set the bounds on a loop.
> However, i is not initialised here. Perhaps it should be set to 1?
>=20
> Flagged by Smatch, and clang-18 W=3D1 builds.

Thank you for telling me the problem here, I will modify it.
>=20
> > +
> > +             /* request other interrupts to handle multiqueue */
> > +             for (i =3D 1; i < tp->int_nums; i++) {
> > +                     ivec =3D &tp->int_vector[i];
> > +                     snprintf(ivec->name, sizeof(ivec->name),
> > + "%s_int%i", tp->dev->name, i);
>=20
> nit: This line could trivially be split into two lines,
>      each less than 80 columns wide.
>=20
I will check if there are other similar issues and make corrections.

