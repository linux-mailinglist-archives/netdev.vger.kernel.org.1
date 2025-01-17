Return-Path: <netdev+bounces-159191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AC5A14B5E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF52169289
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1224F1F91C3;
	Fri, 17 Jan 2025 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EV5xkqd9"
X-Original-To: netdev@vger.kernel.org
Received: from sonic311-13.consmr.mail.bf2.yahoo.com (sonic311-13.consmr.mail.bf2.yahoo.com [74.6.131.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3C1F8ACC
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737103383; cv=none; b=D1yAYPlH9il/PbmlQbEwdOKsUWj8WitV/PtAi5NSodPCJbZeYkOhK1vMdW/88rP4A3b6h6V/LlaUS3AlhdGN08+kL3BmapK247UImUKJ6QfJ6INYdWkahZVoMtHZ5hCNx6+XhJhwSIfS/2IJRHf7fHX3jZILCCgVPAfoVE9+Rb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737103383; c=relaxed/simple;
	bh=JydKW0XBoFIW6JR9GbccD/VCybrAMocrK6vruMkGGW4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MUCOIDOLswOL7PNN5a6yzb8fXr5sm01yslZJyxDlF5YVRoJpVIjWohzdvz7zpTT3H/M9dqvsqetCXeOHwoPkx+6ty7L5o8w8GQY7JgJUI49u3SUgF3nvXgXoWV84hYdh9kHXtE7EUeiYCB22t//mRgR8wWJWjZ5lvpm5ia/R7a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=EV5xkqd9; arc=none smtp.client-ip=74.6.131.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737103381; bh=JydKW0XBoFIW6JR9GbccD/VCybrAMocrK6vruMkGGW4=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=EV5xkqd9Q2ZXXKZvrEZZvLVk8L/v8l7AYM52Z+yvzZFHQCKyvyGtlgESZiXGdiH9/80BU0MNIbQ3UrSXtbEmzblrVei0VlnJ3oLKgSRUbOhjoeljr3iT5QawXqYQKgO2b+t75EUp3NBW6R38cCoKmg6DjuzTMD7LQeAGw8Ym7IHbFAm3Ne4t1Igp8mag2FU/K40fK//iTkhRZ/zlCm2wxlykiTluOzt5PWgNQWL9G0+MHrJeCAAHBAPlvgNcEzcM3ylNlAgvlahD0Ya0onRbWPebCU1KUx3hImV6bjXULuBDUmloCHe+RTVtAAnl/f0UiebjNLWQgZDp12lb5GAlTQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737103381; bh=7KKyKxE4TXI02qdjMkeLKZquJ6P7WAuAUdxo9CQmTSj=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=gxIwPqvT6PuE87i5K2M+uCssoryzk81TA4t5oChF68ivkpmR0bjNTEcOyljD8h4cCOUqGt3MRCeDRxCLL38rKIhay91n7EosY4uxaixKHiOpEN2s03xFFegsVGGpQLjc+kEM1RdKdE3j4vBxV0k37BBqXzlxyZNvgLwG0wKXdilivZOxsZNW+jAP4cyph7fHtecbytSsH1JB/LnIGH6LuwWLHaSJ59rrbXpqlONPaAjZhaMVqT8zC+hEsONNW2SWyCSGtz0C9wFDKm4SnNBLKxNlapDGaJFM/yJgvGhLBXhTCpNMbqWyaDC+frR6t2ZLYy/3Hnj/VGlQOfZAhZLHhw==
X-YMail-OSG: 7CmAlRwVM1nyuMrd7OErjoOQX77GearftKmctHeW.C1Z5w.5_HoP1YBsLp3JoDb
 iF07PH3OA.N1ObOUWgc7Qvz57vEtJTLajAQYt3UWg6ZoXshMxuZTE0juYU.p8cWX5KR9n774Nfmy
 A9Me3z7KeSjOYX9cg0E9AkNTGWeOCs8z.KKCWFysI.QWSI_YOzho1R5W3xvjEd6Di8Wn6TKPUc68
 7UWbIm.EvK0_LWoTE9016HW3aTTyWodBXj6.8xNLXq5y4Yqq8ykt_Nilo2bZTvo9bqkDaGxIRZh.
 1kVGdy9ZIIM_lKb5P.yhWIsFunSXcACXr8OrOcGH5_F2WnLMEOWQz8u9s_VGyZFibefFSrZeAAQS
 p.9qlRTj0ts5IdbJPGGHGrMWkCAr74I_Z1UoRhgvZvoBnT5O0.aBcR7jsC87sfzrLk6o6VZm75SB
 R1kcrmjcm8qNtthUhu5Eq3Xq5tA5inVKHy0QchbApqb_6NFPguN4HcckncmHpYNrnxT3QzZqNi_y
 KwUy8ZNF7ZmTTP742.a2KjbE6pd6oFXYdGGLbF8pB43oPYLbyrdlI6oC.z41mUZgIGxJrifPPNJJ
 Ot6rK7jVH7VIq3FzJLwius33_JlIo2fzYHQLt6lRfK80fyEOlCoR6pihuPsz.OacZfMkMK8wTAK7
 5TFkDOSdiGlLqZP.80BAeg5uLAZuea2bmFX.G5yIe4k8FA9fg7dzBL0izoAzIPuO_cpqR3K2lF3l
 8gkDhjAYuURsgkADoA7E4xdSxzR9ZzIvHMn08WaX7Lta3vnWiC7k5cG7njV3Q2ULA1PTuIrS.nsx
 x15AMk3RC1pN38bm_gNgDDNniKVC923WqHIVehZZDwZofZ9mZ9r2zUCFyUYXLJtiAOyk.SXJneHb
 82r8g7Q7xG.ys6wo0RC0humuXUSciBPGKN1YJk7B6sfp7SKfL1qFSQjzrGD9wKaaR8PqrNeyPeFx
 V0GsLaWzMmsgc4awxz7vJxhhIKnX_UJt5_MviRgqghSDogyrOD7RqLQxmMMuuCU1kHZAk5DOcyzM
 mseXKlDKOsx69fCNGXpGKuEgTuC6xrtM.VoQw_0LSE8uyVsqVJWj8CFVKD1h0D4v0.B_KjaQC3UH
 RUV0t8rQKypjcF3mmQFQIUZ.qGl.7sWsA3SJhByaOoDwBnS8cwd8W5Zx2wRvjC1zDskA4mcOKX.7
 0akLlu.fyM7W96F304Tk4HzPnsm8famYL18Xf9S7pJIO6gy3Sak3jj.U0ZyRa91ZqAwWHlhmY57a
 NMmtiuiLXmn5ufvmEuJdonFa09wZN0uNNdruubSJMwZRP7yUe7hhA98NfsEJfLbQ0qGVNifiahCV
 Ds6_JP5uQ0of_.55H3blBkyzngk3Qyo0_Z_vusP.NRjhmlIQYowl8JyC2InArIKZxfEzcHd7NIMR
 ZfqByckndS428DvScYyTAueZCb7OOfJ8lmednl827eZ5Wg1jhNm1Yayi.vgDurHd5q52eRWtVZwe
 XQ2aaZWHxoaDbpWE3tTKP7DHl71R6ZFPRoBHqwKRjJXtzOXf6Avo.bdZZy0mBqLWpivqNAwf1doD
 O6sYWd2gwP7sxCXEoXvLuF5xlzYLdLxF56UctPIrt9vwAUXONKjiiDuqHv0ahseYiynI0fOA9090
 Y3mPp8rFLy7Wzmk.xGfhcSbmOzu_DcCLhtRV4bQtX1PsX0tPMIQzXK_oADUe2LCre2QDSnyhjatr
 WutxJHvZ2q3ZeNQMfv3ZexR48LeQFCwkM2_ui8w7Oskl0op2WSC_b2wNTUEkyp2YA3Xq6B.jkPmy
 OhJ_WVEFpC.scP2AMefLRavUTMW2PUczatPdq1l8kQXTVNGmbt7zVIhvvaC6MCeM1El1Nrsh4KkT
 Q5jcC0m1sZL6h5WH3ZAeJRVk7Abt3zUFKkSouEotUsoO.pEgtBi5CL2WCdMT3ErqYtlZ9gyH8o.1
 wFNnrftrk5k4SJQH2QNRgp5EaPYLnBw9xZbK_n5fU8nrjHG4xutqLZo.ngcxqGLVNWNGOlWCLBAq
 Qa6giU5kmM9gRmpfilnxo6Quxf8BBoPGrHJhcquI8g45biFUEfjDvf3cHMhiMuP7C1gYtMOHex_f
 Ym.L9GfU1XHd116zG969T5CqzatQgmItbGtDcixhg.R4uDljGn5wwogGC675GkDapa9PIk24NC0g
 Vdm__Hj.VIbPmbgTLuf.57_sjDIWfTMFnrI58KfpaoCysADfPeoIh68yn28bjn6HWIbsiq08LDgJ
 E6WoGQDEaFxGhMnWkjBNg
X-Sonic-MF: <ma.arghavani@yahoo.com>
X-Sonic-ID: 53ff2133-04e3-4925-b08d-f692ca9f3f6d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Fri, 17 Jan 2025 08:43:01 +0000
Date: Fri, 17 Jan 2025 08:12:38 +0000 (UTC)
From: Mahdi Arghavani <ma.arghavani@yahoo.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"edumazet@google.com" <edumazet@google.com>, 
	"haibo.zhang@otago.ac.nz" <haibo.zhang@otago.ac.nz>, 
	"david.eyers@otago.ac.nz" <david.eyers@otago.ac.nz>, 
	"abbas.arghavani@mdu.se" <abbas.arghavani@mdu.se>
Message-ID: <444436856.605765.1737101558108@mail.yahoo.com>
In-Reply-To: <CADVnQy=3xz2_gjnM1vifjPJ_2TpT55mc=Oh7hO_omAAi9P6fxw@mail.gmail.com>
References: <20250115010450.2472-1-ma.arghavani.ref@yahoo.com> <20250115010450.2472-1-ma.arghavani@yahoo.com> <CAL+tcoAtzuGZ8US5NcJwJdBh29afYGZHpeMJ4jXgiSnWBr75Ww@mail.gmail.com> <501586671.358052.1737020976218@mail.yahoo.com> <CAL+tcoA9yEUmXnHFdotcfEgHqWSqaUXu1Aoj=cfCtL5zFG1ubg@mail.gmail.com> <CADVnQy=3xz2_gjnM1vifjPJ_2TpT55mc=Oh7hO_omAAi9P6fxw@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp_cubic: fix incorrect HyStart round start
 detection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.23187 YMailNorrin

Hi,
>>>+ What is moRTT? Is that ca->curr_rtt? It would be great to share the
debug patch you used, so we know for certain how to interpret each
column in the debug output.

Yes. moRTT stands for ca->curr_rtt
t=C2=A0stands for tp->tcp_mstamp,=C2=A0
c=C2=A0stands for =C2=A0tp->snd_cwnd,
i=C2=A0stands for tcp_packets_in_flight(tp),=C2=A0
a=C2=A0stands for acked,=C2=A0
RTT=C2=A0stands for (tp->srtt_us >> 3),=C2=A0
minRTT stands for=C2=A0 ca->delay_min,=C2=A0
d =C2=A0stands for=C2=A0 total delivered,
l stands for tp->lost,
tRnd stands for=C2=A0ca->round_start
Please ignore the rest.

>>>+ Are both HYSTART-DELAY and HYSTART-ACK-TRAIN enabled for both of those=
 tests?
Yes.

Best Wishes,
Mahdi Arghavani




On Friday, January 17, 2025 at 03:42:50 AM GMT+13, Neal Cardwell <ncardwell=
@google.com> wrote:=20





On Thu, Jan 16, 2025 at 6:40=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:

>
> On Thu, Jan 16, 2025 at 5:49=E2=80=AFPM Mahdi Arghavani <ma.arghavani@yah=
oo.com> wrote:
> >
> > Hi Jason,
> >
> > I will explain this using a test conducted on my local testbed. Imagine=
 a client and a server connected through two Linux software routers. In thi=
s setup, the minimum RTT is 150 ms, the bottleneck bandwidth is 50 Mbps, an=
d the bottleneck buffer size is 1 BDP, calculated as (50M / 1514 / 8) * 0.1=
50 =3D 619 packets.
> >
> > I conducted the test twice, transferring data from the server to the cl=
ient for 1.5 seconds:
> >
> > TEST 1) With the patch applied: HyStart stopped the exponential growth =
of cwnd when cwnd =3D 632 and the bottleneck link was saturated (632 > 619)=
.
> >
> >
> > TEST 2) Without the patch applied: HyStart stopped the exponential grow=
th of cwnd when cwnd =3D 516 and the bottleneck link was not yet saturated =
(516 < 619). This resulted in 300 KB less delivered data compared to the fi=
rst test.
>
> Thanks for sharing these numbers. I would suggest in the v3 adding the
> above description in the commit message. No need to send v3 until the
> maintainers of TCP (Eric and Neal) give further suggestions :)
>
> Feel free to add my reviewed-by tag in the next version:
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>
> Thanks,
> Jason


Mahdi, a few quick questions about your test logs, beforePatch.log and
afterPatch.log:

+ What is moRTT? Is that ca->curr_rtt? It would be great to share the
debug patch you used, so we know for certain how to interpret each
column in the debug output.

+ Are both HYSTART-DELAY and HYSTART-ACK-TRAIN enabled for both of those te=
sts?

thanks,
neal


