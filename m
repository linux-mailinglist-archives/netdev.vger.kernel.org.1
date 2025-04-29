Return-Path: <netdev+bounces-186687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF78AA05F0
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 10:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7EE5462D31
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F4328A408;
	Tue, 29 Apr 2025 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="l1S1RSh7"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51027FD70;
	Tue, 29 Apr 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916022; cv=none; b=pTDdzlQM3P5HLrD4cr90yGYD6ZePEJqFOYUJpJkX5FeJYhxOv2qIGU7WTAdY7Bq+aLau9YgZmKxtRXBud/wpoDhta5kc34+KQXTO4dcRdGld9U17RVDlc/91kbJjusf3uXxz9Uo4Ia0vBz9S/YbT/LfYOo7gAj708mnHjv9mGv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916022; c=relaxed/simple;
	bh=j12eYWd/fxQAB51x01tD6d/Td9XPVxu5Ngf9D7Bibug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sa4UShdd/tRqtzw8Eotg3KisUhuqtMomHpfaIV8s9OtxMGvhRvQjASc82lsrhTE4d3amJuuHDBdiZuq/FaNxQXAIjj1IyvoR+SCOpYSg2b8A/anbxFga0iJ5YA4oM/sXmTuNUmuOsYo9ilkVnskn25V70l4oiXJ5FU63pH4FUbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=l1S1RSh7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53T8dYX11431601, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745915974; bh=j12eYWd/fxQAB51x01tD6d/Td9XPVxu5Ngf9D7Bibug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=l1S1RSh7e/l3UMksXQjyh67q3dgLza40FSvzQRaUxiGu7ODmzaHc6MbmfsaXnrhIB
	 lu1hFAvI5lWDpVSeOQm0zjw8T2CCWa28hHARdXUqwO1+VC8FFQxh68z4b71nkr/rM1
	 7R2DvI1TLQshPUybXgBOArs9AUUJxBO+FP2BryhyixzHYpGXd7z3lB9kzzOtHB8kAw
	 rWa/hugBAebBTKMljGFPQ5QoMTYt413GAduF7a403SYhgosUMvZRCorQMWEPZ0KoJm
	 1NFxCJAiLZE/tKzCNeyma+ieKEBSviqNWPQ1/EPoI4gw0gfqRyWyV5/Ttjg/+8W5MG
	 JSVfX3AiNf6HQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53T8dYX11431601
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 16:39:34 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Apr 2025 16:39:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 29 Apr 2025 16:39:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 29 Apr 2025 16:39:34 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: David Laight <david.laight.linux@gmail.com>
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
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net v2 3/3] rtase: Fix a type error in min_t
Thread-Topic: [PATCH net v2 3/3] rtase: Fix a type error in min_t
Thread-Index: AQHbrs2sHT6BFvalLE26yBqqUlL/zbO236AAgAOGx2A=
Date: Tue, 29 Apr 2025 08:39:34 +0000
Message-ID: <c5036c8c87c34b558e29428e9133d4d7@realtek.com>
References: <20250416124534.30167-1-justinlai0215@realtek.com>
	<20250416124534.30167-4-justinlai0215@realtek.com>
 <20250427114646.4253b39d@pumpkin>
In-Reply-To: <20250427114646.4253b39d@pumpkin>
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

> On Wed, 16 Apr 2025 20:45:34 +0800
> Justin Lai <justinlai0215@realtek.com> wrote:
>=20
> > Fix a type error in min_t.
>=20
> NAK, in particular u16 is likely to be buggy Consider what would happen i=
f
> RTBASE_MITI_MAX_PKT_NUM was 65536.
> (Yes, I know that isn't the intent of the code...)
>=20
> As pointed out earlier using min() shouldn't generate a compile warning a=
nd
> won't mask off significant bits.
>=20
> Also I think it isn't a bug in any sense because the two functions have a=
 single
> caller that passes a constant.
>=20
>         David

Hi David,

This is indeed not a bug fix, and I have modified it to use min instead
of min_t, and posted it to net-next.

Thanks,
Justin

>=20
>=20
> >
> > Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this
> > module")
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
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


