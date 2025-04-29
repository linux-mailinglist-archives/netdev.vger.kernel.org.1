Return-Path: <netdev+bounces-186690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D55AA060D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 10:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E984A05B0
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 08:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39121FCFE9;
	Tue, 29 Apr 2025 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GIz3i8Pv"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691461DFDB9;
	Tue, 29 Apr 2025 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916388; cv=none; b=IHkMZIA/OtEOsOSMk4ot3FrmmjfwHJe33h5wakINrgX8QB32AY330dolcVSR/CbQJFYKCOYpMmxY+6wEEinZcojKQ1qZbjkJtTq3NJZ+2XdpzE7XdF5p0SoQL+Qe4FwtZEFMFBgzjoQZsgz3jN/0BjcN5cf37ycDGS+akDarbI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916388; c=relaxed/simple;
	bh=eG8So+o0uRKW+/DEX7X8dk+GZQKjvj4ZwSH7mzOVWqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l4v7rz16TrSLFrYiNLF74RGIvaW8NT5RxhAzfGELeiEoIEB0HA4VMzpdXuTai3nhljkeC+MXhoJlxErstV+waRtAxy3PDgTQhbEjcx8XOn1luO4W1FIHF03qzgzUx2iwsuN3ctmIH/4tcKZRd8HATtKkpi9zgtUkCgodb2zGnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GIz3i8Pv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53T8k6Qe9439353, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745916366; bh=eG8So+o0uRKW+/DEX7X8dk+GZQKjvj4ZwSH7mzOVWqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GIz3i8PvXEK3lMdVHins8diOFrx6KDbzxR9gwRNifomuus5tFeIh0avllPKOb35SX
	 Xy3oBTmu7x56kJRNu4BVnbsXF9RSa4XTXqE82Q38FBFoE4BusYEClNXEtppw0T/a7O
	 kTo8xRUsKR9CuwEtT/7EXOizfwmBBdc+BAFASmAk1+/1uvaEipUVqq286EL7lHdh6x
	 KW2G8gIZXTQkwZaD5NbQGdnVbBxynL5J/mkhh0966eIT3LHttH2zd18T43MR1fivi5
	 zrNolJ9h+ck+D+eIVdZ7gIA64q2T2zNLtZ/ny0AoenvHzdPqM5GlWY9qP0/eso/A8x
	 fMJuLlznibsJg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53T8k6Qe9439353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 16:46:06 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Apr 2025 16:46:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 29 Apr 2025 16:46:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 29 Apr 2025 16:46:06 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: David Laight <david.laight.linux@gmail.com>,
        Simon Horman
	<horms@kernel.org>
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
	<larry.chiu@realtek.com>, Andrew Lunn <andrew@lunn.ch>
Subject: RE: [PATCH net v3 3/3] rtase: Fix a type error in min_t
Thread-Topic: [PATCH net v3 3/3] rtase: Fix a type error in min_t
Thread-Index: AQHbr3bl9x+S2lV3JkCdeosgY8bnPbOvL9aAgAegywCAA5RAwA==
Date: Tue, 29 Apr 2025 08:46:06 +0000
Message-ID: <e390dbb55290465cb2a4dd688d86d2b6@realtek.com>
References: <20250417085659.5740-1-justinlai0215@realtek.com>
	<20250417085659.5740-4-justinlai0215@realtek.com>
	<20250422132831.GH2843373@horms.kernel.org> <20250427105750.2f8efb02@pumpkin>
In-Reply-To: <20250427105750.2f8efb02@pumpkin>
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

> On Tue, 22 Apr 2025 14:28:31 +0100
> Simon Horman <horms@kernel.org> wrote:
>=20
> > + David Laight
> >
> > On Thu, Apr 17, 2025 at 04:56:59PM +0800, Justin Lai wrote:
> > > Fix a type error in min_t.
> > >
> > > Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this
> > > module")
> > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > > ---
> > >  drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > index 55b8d3666153..bc856fb3d6f3 100644
> > > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > @@ -1923,7 +1923,7 @@ static u16 rtase_calc_time_mitigation(u32
> time_us)
> > >     u8 msb, time_count, time_unit;
> > >     u16 int_miti;
> > >
> > > -   time_us =3D min_t(int, time_us, RTASE_MITI_MAX_TIME);
> > > +   time_us =3D min_t(u32, time_us, RTASE_MITI_MAX_TIME);
> >
> > Hi Justin, Andrew, David, all,
> >
> > I may be on the wrong track here, but near the top of minmax.h I see:
> >
> > /*
> >  * min()/max()/clamp() macros must accomplish several things:
> >  *
> >  * - Avoid multiple evaluations of the arguments (so side-effects like
> >  *   "x++" happen only once) when non-constant.
> >  * - Perform signed v unsigned type-checking (to generate compile
> >  *   errors instead of nasty runtime surprises).
> >  * - Unsigned char/short are always promoted to signed int and can be
> >  *   compared against signed or unsigned arguments.
> >  * - Unsigned arguments can be compared against non-negative signed
> constants.
> >  * - Comparison of a signed argument against an unsigned constant fails
> >  *   even if the constant is below __INT_MAX__ and could be cast to int=
.
> >  */
> >
> > So, considering the 2nd last point, I think we can simply use min()
> > both above and below. Which would avoid the possibility of casting to
> > the wrong type again in future.
> >
> > Also, aside from which call is correct. Please add some colour to the
> > commit message describing why this is a bug if it is to be treated as
> > a fix for net rather than a clean-up for net-next.
>=20
> Indeed.
> Using min_t(u16,...) is entirely an 'accident waiting to happen'.
> If you are going to cast all the arguments to a function you really bette=
r ensure
> the type is big enough for all the arguments.
> The fact that one is 'u16' in no way indicates that casting the
> other(s) won't discard high significant bits.
> (and if you want a u16 result it is entirely wrong.)
>=20
> In this case i don't understand the code at all.
> The function is static and is only called once with a compile-time consta=
nt
> value.
> So, AFIACT, should reduce to a compile time constant.
>=20
> There is also the entire 'issue' of using u16 variables at all.
> You might want u16 structure members (to save space or map hardware) but
> for local variables they are only likely to increase code size.
>=20
>         David
>=20
>=20
> >
> > >
> > >     if (time_us > RTASE_MITI_TIME_COUNT_MASK) {
> > >             msb =3D fls(time_us);
> > > @@ -1945,7 +1945,7 @@ static u16
> rtase_calc_packet_num_mitigation(u16 pkt_num)
> > >     u8 msb, pkt_num_count, pkt_num_unit;
> > >     u16 int_miti;
> > >
> > > -   pkt_num =3D min_t(int, pkt_num, RTASE_MITI_MAX_PKT_NUM);
> > > +   pkt_num =3D min_t(u16, pkt_num, RTASE_MITI_MAX_PKT_NUM);
>=20
> So a definite NAK on that change.
>=20
> > >
> > >     if (pkt_num > 60) {
> > >             pkt_num_unit =3D RTASE_MITI_MAX_PKT_NUM_IDX;
> > > --
> > > 2.34.1
> > >

Hi David,

The boundary protection mechanism is in place to preserve potential
future scalability. I have modified the code to use min instead of
min_t and have posted it to net-next.

Thanks,
Justin

