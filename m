Return-Path: <netdev+bounces-239678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA5DC6B57A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DED534E074C
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6DD2D73AB;
	Tue, 18 Nov 2025 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mrTstzpA"
X-Original-To: netdev@vger.kernel.org
Received: from sonic322-56.consmr.mail.ne1.yahoo.com (sonic322-56.consmr.mail.ne1.yahoo.com [66.163.189.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF927B4E1
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492745; cv=none; b=igtZs4O8t0fKbbidhh2g7gT/eIYgWhU78LpW1SVlqJlcGTf0xxTtaLIlHtf+xgUk+sftlRhe+jH8y04esdQCbRvaHEV9vu4Bhn1k/hhfE0Yk9SJHsPBBI0q5a2nMjWRGm8hSgtMR7eLCDLuocPaYsArU1KZSFx00bzMk0gqCBlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492745; c=relaxed/simple;
	bh=Am0w0O1oTsJ2baWsUCyBeBsShTL4A1mKbqTg6dcE8h0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=b42N/6uGEbc8fyiD7ig7KHxeQ1sHgRSt/GVUFgdZgHJNZ0PMxFNa2M7BNI4AEugeeZz0V9WaOO8D3pNMiNR23eijPeeNQHNj2aMLkAGySnonrqO8OuVOtMlJ5mxm9So8p13JOdgRPhcJ7dmATuPKPNKB1zqgo1BXKWaa/p/97C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mrTstzpA; arc=none smtp.client-ip=66.163.189.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763492737; bh=Am0w0O1oTsJ2baWsUCyBeBsShTL4A1mKbqTg6dcE8h0=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=mrTstzpActELPdisgN3sGZsN0MVBxGRUzPOoZljaCf09Kwvt+66WrTyLdFrIiEiHLHxTBF5v6VDjvKGqNvGxnKXBNaRvgtDJARcVBTJEldEvaIXsaAPRWxEpsVEr4CgchGN+/vhxu52HeVcFKQm0sBnn40icab/tXYcfOGtywuW+wyGbcxBfmS9DKX8nRfdoFsk0KXjkfagXf+V81Ou2ZIgx44ZHocZbL+/47hWTlwNt9bocBov/8sSug/wgH5hoXjVsswSu8dhJ2vhnlgojFBBR4s8BWDrHCIJflDNqWJHr8HhabNhEPB8Vcvrp8R175wHGWIj90cxdetvtVAZh8Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763492737; bh=GBwICHr35mgQfakXpWJ7uDCO6Y2ed+Mp00WNJvgsMCC=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=jBwPhg40G4RudwznVXhDAPbNKz5wGdWa11TmV7zIKxzV1WoCtipjjfus84IOxQJOpj8RGY/iUJb2Y2whblLVHTadKBOzhp2EZiwfBKbJji3NQjpPV48iTa9Ti8d22sAMKujFTB7modJZUsrDpML8aYPM8TgJP5t7ZIOfqU32Tx73AXtfl4VNEa1ccQ4ITCXmChounCykc7WHd9Qfe8Fylb17Fe1exhobHCPdyvBmv/QNeVnXAfq2HvcljqFzkaqqKmDWue+Ol3ahoLgdpc6psCSr/rjeKRqH58xOiEffozVQWhNnJ7feaDdaiBx4uSzA981E5Rd0wEa9qfUJj66SiA==
X-YMail-OSG: UW1DNcgVM1leZSAd99BqObY.9bhOdZbhYJs5OGbKkl0daNUIY7pTMayzjkuJxnL
 iMvDaWrfza94fesuEd583QyMpHLf9JR77G5pFJHQr4MVJaY..8dL.xzbAm2HLJGSwtIw.m4WfpZw
 PqgymtJXa9NH5WpJ2zpOIb8MlJbDQRVOxLCkhPJjhF1jWKqiA2QFeCpOU0hW3v1lo5CQUvb9YTSD
 kKF7Rj5qGXzUmJsK3Cii4YphsbCjfm0D4MfEHHmvhiX8mDNPSgsRdJCzXL5CDUBnO27Hxn.icVz8
 XzPJ_UMQI2Oc1N6Vo6FMrrIn9cOOYX.TCZyXpUPRupFO0hPER82EY.l61klR5FqQ_V4OHXpXviI1
 tE4wCiLHEcfOgaTNebgaIPIeIJRvsmkvw.JFgw62Ok8VINT7.ZeKG_2ccavTu1.TEjwipya5BWOI
 FBnuegX_a_ZX1e3BPMp1wDNwX.DujJYtsAiwasqjjzBhYiUbXKBZtoxgO5R53hq3fDaOlgVqJg1B
 HSvRuR_zyfUBRb4p0smd2PhrRKnZ4Qn222hZ9vcYzHgZnHke_zh_nrzu_tXxZ5LY58sc48fJ0fBj
 FWXFdQfnur.UPEqPB_LUjnMM4UITjKD_fylpjPmja0XaJqyFNjABPuU7S.1b0xX4asDI1.GPKY.0
 HJL2lgVfhThOJb0ppNtI7uKAHvC2BsdcpNeWzhRuYrdEnX1GlFTaiXv4E8a9d78imcylQCca0EoO
 dAATWHM.9bj8As67FkXQyL8nnppwAemEdyBHs4P9.DOV5rc2PU8bniphHiFRxV.58kxlS3Hd7NeC
 ysgmB.yYl9oM__qJG9yfxpUzZiR4c.x6BJRxjTATnT21yYHQphYmWxHUtL.lgn3p95NpI37Xnt0l
 P41AiYnY5Hbj87QhLYJLNbaCnQfIfCF6JisbbhHLMVxtTrv5lHtfArwJT.TbqQDqJ5LbF5YRjEDG
 ABO2_Wj_ZMcRA25Dx1NyC9R7ber_o1dOLqahRPTOQsqqXeWIyv9q7Rz2kY2yeOEAu8ZWCzz6O4RT
 RkS12X9s_vy9s4PcEIqR9b8HbseiXtjCj6cGp7NnVX0XGUX_kXRcsHvxq0LvbPX8rwduY4te.xBh
 Hvw6NIFRqT0GVLyMNh_noxGbyp3FauSM_QZKz90kd6lSGKyxXEVvMaFK6o4YurmGzY5iPnyKfLMM
 WixY2rwqKlN3HOt0EFo1g6hfcthBW1usSL6crwivIDAt1Zp9q3l73axCo5Bu5intN8.rKUU97r_V
 EtElzZ8PGrqlLQi5ehHU1QkyG5qiWwIn4KK_pYQo2q51V4kbRJjrMESlConiRT.ECJrH9.ri7bOC
 jC3.rQvLTe05lNEvXt2Xvlt62igm4npJxFpXQcwZ5qQQts9ybkyEgcaQFRYrsjoNglVTWBE0YbJM
 C8c7jWHwi8sAapdOdgKaIX6vAIqdChstsWz1fIQFxBBfn0pEMyTu3GaIyYlt8MoTgwylvikK9qYf
 VBrfa86daccAicqDm09gAs2QawI9OhLqleIWtJ64AWJkNUavreOJmC45Y0s58_9trwFe5luCxBzX
 va_JQdeWWS1YMZWySeKGVwPRhCH0yehiry6nsJBQ_bJ0BGJ_EPdswyAsWHtPBtH633QEDM_aDwYB
 vSmgTL.5K1Ce8qcgl2MW_hNbPYlKX2s1Gk5PmsmdXGIhuxX9.lsKjdovt0NrqDKTRwaG4KU3Hztg
 4hI2LSjiNV.CS6IppVnAvTYyPYfN5FUVGzz1fto..n7QhMgcnntodNAWuTbAolL.nYLsdZ9F7mcb
 ThQUlUHSCGQE3efrvmLdMEMtZPuTwMRQdq4DxejUt91PE4UpqViA3MpMiwVj42T5kBIt0qiYIoEq
 Cuk701WOAcOPYDYSP0lii4Ssj5NVQEHmzgGpC1TST0DzSM_4N5sUAzIUkpBBY_QuS6md4mNoecf_
 u0UbVVWXsBAZ4QrOXKkiSgXkdLoFD25RVmL6hP10Tr2BFC876jhqxnfd8UAfBFXCV2mazL4xo.D2
 eBHmGwZfL2fF.dRni32f71fJOxd2GPGSwsdSCvR4vpNgqJrrQJltRolP3SfySdVFIPGVyQbdl9H1
 myey7RTStSo4UE.Gfc8d35jy30qGawXztuxKYAUtAazZS4xMytcfj1IkS1srMS9cy_pcJKGhyox.
 Sdu0iS6a7K0rtiOzATkLFY4BAa7dDLqZNIa0ik_A_zJemC1S0V.GfMzKe4JMaAfPrCvpHaWLZ2fO
 vR.MvDMossrSPJ35tsPKIAwk96ow_TF1asfkb2jR5.4_P7_Z79Ro-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 5079ac9d-e548-4166-af4f-1af55b70a763
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Nov 2025 19:05:37 +0000
Date: Tue, 18 Nov 2025 18:45:19 +0000 (UTC)
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Netdev <netdev@vger.kernel.org>, 
	"inus.walleij@linaro.org" <inus.walleij@linaro.org>, 
	"edumazet@google.com" <edumazet@google.com>, 
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, 
	"olteanv@gmail.com" <olteanv@gmail.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, 
	"davem@davemloft.net" <davem@davemloft.net>
Message-ID: <527355522.9591320.1763491519924@mail.yahoo.com>
In-Reply-To: <a31ffe45-5457-42a2-aac5-2f2da9368408@lunn.ch>
References: <878777925.105015.1763423928520.ref@mail.yahoo.com> <878777925.105015.1763423928520@mail.yahoo.com> <a31ffe45-5457-42a2-aac5-2f2da9368408@lunn.ch>
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: Do not subtract
 ifOutDiscards from rx_packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.24652 YMailNorrin

I can't pinpoint the commit that caused this error. The file's history on G=
itHub starts on October 18, 2021, and this error is already occurring.


W wtorek, 18 listopada 2025 17:55:26 CET, Andrew Lunn <andrew@lunn.ch> napi=
sa=C5=82(-a):=20

On Mon, Nov 17, 2025 at 11:58:48PM +0000, Mieczyslaw Nalewaj wrote:
> rx_packets should report the number of frames successfully received:
> unicast + multicast + broadcast. Subtracting ifOutDiscards (a TX
> counter) is incorrect and can undercount RX packets. RX drops are
> already reported via rx_dropped (e.g. etherStatsDropEvents), so
> there is no need to adjust rx_packets.
>=20
> This patch removes the subtraction of ifOutDiscards from rx_packets
> in rtl8365mb_stats_update().

It does look like a cut/paste error of some sort.

Please could you figure out a Fixes: tag, and submit this to net.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

=C2=A0 =C2=A0 Andrew

---
pw-bot: cr

