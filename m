Return-Path: <netdev+bounces-185100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672B7A987E8
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143CC3AAFE5
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D761926C3B0;
	Wed, 23 Apr 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Up4iEUVK"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81F426C38B;
	Wed, 23 Apr 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745405681; cv=none; b=kvEe00fFmylmJKoxvl6hEDiiI9IhmeteDj61K8rlOLPrGSxBQ0PrNLY+ZgW6U35wY3butKkfvpfjs2D9oQPLye5+ZqgMQppHXMV/zoWXDVdmn+MMolkVaB+1BokyvuOmb/8WWv1zR+DO3YXY5Gs8a8DkssjgAalf76hlTPCdk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745405681; c=relaxed/simple;
	bh=PKRxF5CSeXMnjowgFobPAyzE/YcGtkyPnA1UcaUN9us=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a+LcjmrP+aAmIEUhBFNn9Acs/1Ynlxd4CoEG48xtNiLKMafWkZqzL67qLbyaLLHlkpWek0i9/N6Z0MlbeF415BpADvvd9FI8Cr3kmWJqgfDkLPBM/C/V54P6h32PGfTfmQOiRi6dYGOfduLoen1S3LmCU7rj2+OCuXAHQuZLDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Up4iEUVK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53NArs5S32446350, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745405634; bh=PKRxF5CSeXMnjowgFobPAyzE/YcGtkyPnA1UcaUN9us=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Up4iEUVKeOna4yP778vBMZbKx3A5ugyvfwy4E59mKuVEspOFdjU5nDYImJuGg93Ta
	 2s3nZiiqJOKmiCKWL6GRdPslfW1tmpOa/rJiQqP+Ok8izxkqZbmczfzalWl29f8xBW
	 ykmkbtInuWV4wYGYGE091BxRluJdVutQV4RwIZNFQziPGs2P+k8Auy4vZIvBWGvOr2
	 rwAk0Wsc88eQN5sdtpsUTDgMIIvW/Ria1cF6Lf3epwXpNT7khGrDZ1H0+rUT2/d0tw
	 020Inc4nvp5WwwScw7UYATJeNHa0EhO6NZloDnpyiOE+sKGhgxRQtbVRPC9lIEAqrf
	 Lq2AFD62IU/0Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53NArs5S32446350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 18:53:54 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Apr 2025 18:53:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 23 Apr 2025 18:53:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 23 Apr 2025 18:53:53 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Simon Horman <horms@kernel.org>
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
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>, Andrew Lunn <andrew@lunn.ch>,
        David Laight
	<david.laight.linux@gmail.com>
Subject: RE: [PATCH net v3 3/3] rtase: Fix a type error in min_t
Thread-Topic: [PATCH net v3 3/3] rtase: Fix a type error in min_t
Thread-Index: AQHbr3bl9x+S2lV3JkCdeosgY8bnPbOvL9aAgAHmKAA=
Date: Wed, 23 Apr 2025 10:53:53 +0000
Message-ID: <040b019af779423f96752f10a697195b@realtek.com>
References: <20250417085659.5740-1-justinlai0215@realtek.com>
 <20250417085659.5740-4-justinlai0215@realtek.com>
 <20250422132831.GH2843373@horms.kernel.org>
In-Reply-To: <20250422132831.GH2843373@horms.kernel.org>
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
> + David Laight
>=20
> On Thu, Apr 17, 2025 at 04:56:59PM +0800, Justin Lai wrote:
> > Fix a type error in min_t.
> >
> > Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this
> > module")
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 55b8d3666153..bc856fb3d6f3 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -1923,7 +1923,7 @@ static u16 rtase_calc_time_mitigation(u32
> time_us)
> >       u8 msb, time_count, time_unit;
> >       u16 int_miti;
> >
> > -     time_us =3D min_t(int, time_us, RTASE_MITI_MAX_TIME);
> > +     time_us =3D min_t(u32, time_us, RTASE_MITI_MAX_TIME);
>=20
> Hi Justin, Andrew, David, all,
>=20
> I may be on the wrong track here, but near the top of minmax.h I see:
>=20
> /*
>  * min()/max()/clamp() macros must accomplish several things:
>  *
>  * - Avoid multiple evaluations of the arguments (so side-effects like
>  *   "x++" happen only once) when non-constant.
>  * - Perform signed v unsigned type-checking (to generate compile
>  *   errors instead of nasty runtime surprises).
>  * - Unsigned char/short are always promoted to signed int and can be
>  *   compared against signed or unsigned arguments.
>  * - Unsigned arguments can be compared against non-negative signed
> constants.
>  * - Comparison of a signed argument against an unsigned constant fails
>  *   even if the constant is below __INT_MAX__ and could be cast to int.
>  */
>=20
> So, considering the 2nd last point, I think we can simply use min() both =
above
> and below. Which would avoid the possibility of casting to the wrong type=
 again
> in future.
>=20
> Also, aside from which call is correct. Please add some colour to the com=
mit
> message describing why this is a bug if it is to be treated as a fix for =
net rather
> than a clean-up for net-next.
>=20
> >
> >       if (time_us > RTASE_MITI_TIME_COUNT_MASK) {
> >               msb =3D fls(time_us);
> > @@ -1945,7 +1945,7 @@ static u16 rtase_calc_packet_num_mitigation(u16
> pkt_num)
> >       u8 msb, pkt_num_count, pkt_num_unit;
> >       u16 int_miti;
> >
> > -     pkt_num =3D min_t(int, pkt_num, RTASE_MITI_MAX_PKT_NUM);
> > +     pkt_num =3D min_t(u16, pkt_num, RTASE_MITI_MAX_PKT_NUM);
> >
> >       if (pkt_num > 60) {
> >               pkt_num_unit =3D RTASE_MITI_MAX_PKT_NUM_IDX;
> > --
> > 2.34.1
> >

Hi Simon,

According to a more detailed clarification, this part is actually an
enhancement and does not cause any issues during operation, so it is
not a real bug. Therefore, I will post this patch in net-next.

Thanks,
Justin

