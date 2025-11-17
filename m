Return-Path: <netdev+bounces-239280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41997C669F9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23713361AE8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64C82B9B7;
	Tue, 18 Nov 2025 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EHYMEOdv"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-22.consmr.mail.ne1.yahoo.com (sonic304-22.consmr.mail.ne1.yahoo.com [66.163.191.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C529A1
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763424560; cv=none; b=qqi0899Lhxexeu45rBLlP73oW94bqOE+VYa49KaynycdqYk/NU1QGloGf+LYqAoI91QGYA3NkDwq7yLempptXM97Tp9LIKhtdETg0PKyM27mddYrMeyrZBhfEXtn2/C3X/sDmam/H4be+1esBR0Qlh4+bOS/w6QwChDK+eIm/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763424560; c=relaxed/simple;
	bh=sDS8nJ+7QRCBIWiF+ZSg+ecSQqk6Tlavgg7jd/hTqoA=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=PJE2G5SoXWz3+aYkPNuMhb+1OBJC+ggu71HPtH/cnzPriqYkaCOhI/mK50niWc0i1xKsQe2v6sppaxhPXvGFpiXxkrk8x8P6gOWDPBTn0BEjdFNQh0jqDRYX4uGFY/r9eqMFyBNTY4xqnpeB95Jf5qFsbiRQSEf+lbQKBRbnLNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=EHYMEOdv; arc=none smtp.client-ip=66.163.191.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763424552; bh=sDS8nJ+7QRCBIWiF+ZSg+ecSQqk6Tlavgg7jd/hTqoA=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=EHYMEOdvpVOi9L36D0nkFOw4EJOEa3aJ7u2i2kgXlgWX4tq9euOXHyBBpZrNTWyM76DYisxBFTgsO1FD8e+SFONwqEbpuGP8IKjHaEwkN1RUG1CWLQHWFDuZ73dqusMPKe8sjMmXiDqxRXbxLybJQwtWEhb1nnKh+d1VpBp+rMEhBvgm1c1g5Ke6RUdzELWo6kHSeJPEBtostRSIiNPH3Zp0o+r9S9lVL3crHBYThYjQK8eBQfzIVcN6A6G4DIXF55171f8JSZHE6IDOQoKsBefpYwayWtmP+FBINM7bEhyVpiaJNXrOYtHUXK42AS/XVn3WUhDpiwoYt3GOyvsKDA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763424552; bh=vze8TQ1BPHp04ZoMXi/n86ndl1ZGSwHA/rRfKtya2RK=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=FLw1raEHMjjopAxtzZb+vJYK4pzp/w0YrAdigGuY2q9BPSkXzI1xrCSDXkpZVh3LDdc5EdiQ5d+Ix4tHsa+N+VgtD9Xazm1gmAumuGtgV6UuTvKqvJLvsKEg++r11WNoO7RLkIKygkM8m2CXn/+eyiX0dh30aX92lvknLg2C+TZqRdKjT+8CzoMSEHfqAWwnFs1PW41X9jDixv4ub/RWqNlk808FbFrxaI4Ru4A/egGAMr8vi2gEeMERum3H848srUbbc80qCB794F+hxLLFiVnQSc9+PR6/F75qGQGqGpaK7tfl9X250HvuozAKz9vPbOR3qV7SNgRsYAsJEUOF9Q==
X-YMail-OSG: fCdAucQVM1kC2IMkKG7KhCOR.lUjDlctwhQM8nA2R7aRk33x1VRV1aAqp34L249
 KOBjSXE2nXek5y_Rju9RzSxEiZwgLRRI..WSUxxt8ebqhITRCD0wxL3tnT_KbsCew0BINxkGj44g
 jrsIMuR1v4AMIhiTmO_OMj726Lf40NAmVR4oLix7Z_XhIx1QYDo7EP9VMld8xEEPTsm_EWEe8FbS
 FYWf0i7WhAKV.Bfb.WkvOBFfDX.W8SfVU1MeHBw7NlzQlXD9fMc0qpTCPy3t2gXXVHbYTowQIn2G
 h3Vdr_Tt0QQRakpexY0wdGUIA7qUKe4sjF7Tb1LoK0UFbYRPZt6gvNVI9HbUWX2jzKBFsvfpQ7s1
 W17jESgSikYZZYKoHZ1W8MSqAvFoV26uu4KfdxrjdSTh5_BsmDc9IyFGOMXJj7BxewKbEjRCXsgQ
 qHrebBpN4.fRfA9A1VGKXk.DTO_ifYtP4rXy41BtG02qWPB4eadBLE9UJ4HQ0bS_l9nQ48c0LGVo
 vB_gpM1V52Hsv31Z7z8uqUUoD6mWSUBRYpqcr0T13jZOLpAbjSoeWmGlJjyMEecZ88l8ZUyf2rPN
 nDmrnBByn5q38FxYLgKx.1grpnaKwP2whsrc2AsmlUf8OLeyFRiH2h8wvq_zV1.T.4GZqufrWnQ3
 VM70i5XUtWTDOh7O5iTTX0upS52Ycb7f.mD4Y5eE7AKqDHjlWLgOtBvR6hhkAoTctZx83bxKuw.W
 8.Pya_kwZ8ZaW2cOPvqp_pab0_j11pt29oXookRZj3Y_IsskipiKu3u7gOdnGHfpN9eE1BNB_4dR
 Xp5gXWsxZ7OjSgvuC76Baz6esrUrKRnkJk9psOMJwtPrbebnutbehHfdF.71r5kk_xdOgL0UBCwW
 4Cod9jUb8uMo5y3PNw47jZXlQ5WY_XqDmsL4IU8IAEG1LAn.wkJ91KkPHwGtG3rFX44JeRF5vWQl
 Aeok4nlysQOcILwaYpD1YTACK9485HDEGs_40sn2VpPzBU_KZh_oNYmv4FDVbd5SifepLiBmviGQ
 O7_5izRQ4XmsTRLK87._I_1k2F6KWri.TKfUfVf35oxiVXu4V3e_DiCGZTravAUIxsls4F6ZJlce
 f8bDp2E2vZ3wmWtImnKRrEfYZIQ1pmpeaROLKt6wvJpVuEDXGuW6W.p5Bgz544pDQ4fTk6KWbaj5
 he08vx0Pe1_Hwlk2ZoUptn46mWFdqoBSwoDlUu6fNo_w64ihN12c4e7fiN9u8RYYMYLJJ6L3tFEG
 LfJXH7O6Enc4KEU_hdGPBbKd6_HQx8Q_.mTpJyexPT.3D52Un45a9zHl7md7H.BESXlJXZ_Rwwwf
 DuAUM8uhPvSXv919_lpggFaU7yZD1PPRh44EKWSmedvnQawTm43fqoqLRxbllNbgluiXcJIaX634
 0f6jE_zKf6G6MZ2ekZtOvyjDnwRR5gtEXwOnojgk5XnoCeB0KoLErhnwnE9du04ER6Q9kcSvyg7V
 YQ9.5hbfcIR3A9XzdTTNA7effhNs11mXdzFQG8xZKwkaBIrVCsW1C.y0CkfqXaW3V636lguBRlti
 Iean5sxLvyJxdfgXZGi4pR1J.4mN5QCiKiA2zYTOSGJJB1EXcm9wxfG1IweBgb.uvtH400jZakRm
 DXhAkBF_hIWL_TSojJHJc9.VHhtNH7fMQJn_iPgecTJgv6B7cFDt_EULICjit1S4vE5JYUT2ENIV
 de_yOs3jt1Lt8.cD6h7PqwaHWtcQsVpHFKZJ_DLG3q2ZPmIXvSjp3oaTvfG9q5dJl3a_66NGJdez
 uJdMVzF5wYkSuoM0su3CbFgDeyYw1XzCNGXt9XEAysAUrv4.2OBP8UWuKZWEb8PrL3JSKy_Hl2Qk
 s474OvFZhDpWYi2dMJRKn9zbf9hbShKR0z_M84142QTEXwpEnjjP7vErrUtGBalErYyUBOZ5KsBy
 _ZfzQXTiK70cqZZ.dV..aVJo7aojIXyd1rnfNWkhQGsggtEvtJ_q7niBiNHR4EYeRmUyrib3rF5Z
 O_oWk2gti8Rhk6dcukpZPVScBUUXisiKnstQN6raFCSzW_RmRKeF3Uy0Q8XBeB75PYb0sxjABWzy
 iMQzswLERupo34oqdk2ZaBgA.8mbMrW4J.A.VYclNl4i92cRCv_NGP2xM5CL6neQx6StYzbFAzKN
 Atru25SwvwJF1xp.x_2c3Piv7bYVlUayxe8F4Ny093_CC8ggrH8jSCedAjSqurpSUyHZiZ4YA42S
 ZZqhOvQI0rcRgOrAMhWKFAAqe.PRmfAAyYngr6ZFAH1ZzUw--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 9b51e3e3-4e7d-4543-8491-80db4875e8d7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Nov 2025 00:09:12 +0000
Date: Mon, 17 Nov 2025 23:58:48 +0000 (UTC)
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: Netdev <netdev@vger.kernel.org>
Cc: "inus.walleij@linaro.org" <inus.walleij@linaro.org>, 
	"edumazet@google.com" <edumazet@google.com>, 
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, 
	"olteanv@gmail.com" <olteanv@gmail.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, 
	Andrew Lunn <andrew@lunn.ch>
Message-ID: <878777925.105015.1763423928520@mail.yahoo.com>
Subject: [PATCH] net: dsa: realtek: rtl8365mb: Do not subtract ifOutDiscards
 from rx_packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <878777925.105015.1763423928520.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.24652 YMailNorrin

rx_packets should report the number of frames successfully received:
unicast + multicast + broadcast. Subtracting ifOutDiscards (a TX
counter) is incorrect and can undercount RX packets. RX drops are
already reported via rx_dropped (e.g. etherStatsDropEvents), so
there is no need to adjust rx_packets.

This patch removes the subtraction of ifOutDiscards from rx_packets
in rtl8365mb_stats_update().

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
=C2=A0drivers/net/dsa/realtek/rtl8365mb.c | 3 +--
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/=
rtl8365mb.c
index 964a56e..af0d84d 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1480,8 +1480,7 @@ static void rtl8365mb_stats_update(struct realtek_pri=
v *priv, int port)
=C2=A0
=C2=A0 =C2=A0 =C2=A0stats->rx_packets =3D cnt[RTL8365MB_MIB_ifInUcastPkts] =
+
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cnt[RTL8365MB=
_MIB_ifInMulticastPkts] +
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cnt[RTL8365MB_MIB_=
ifInBroadcastPkts] -
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cnt[RTL8365MB_MIB_=
ifOutDiscards];
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cnt[RTL8365MB_MIB_=
ifInBroadcastPkts];
=C2=A0
=C2=A0 =C2=A0 =C2=A0stats->tx_packets =3D cnt[RTL8365MB_MIB_ifOutUcastPkts]=
 +
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cnt[RTL8365MB=
_MIB_ifOutMulticastPkts] +
--=C2=A0
2.46.0

