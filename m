Return-Path: <netdev+bounces-306295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ve5IOsq/T2osnwIAu9opvQ
	(envelope-from <netdev+bounces-306295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:35:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D96F9732F93
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:35:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yahoo.com header.s=s2048 header.b=ujvpBcz6;
	dmarc=pass (policy=reject) header.from=yahoo.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306295-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306295-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 133B6300442F
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F87342501;
	Thu,  9 Jul 2026 15:13:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sonic305-21.consmr.mail.ne1.yahoo.com (sonic305-21.consmr.mail.ne1.yahoo.com [66.163.185.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A136BCC4
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 15:13:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609982; cv=none; b=c63PLILy+TuwUcolNpFOpp08wldYTf/W/F8BNtkZ4Zxoylt7ijydiQgzyUedNEH98KdZQsJaMPK7yv8a7V/7l3eP78NN0Lt9o6WpEiZCJS3jbEFwL9sNVKIs8D3cp1yTWSwcDkfBOGE/rPIEoTOckCHFGkCaZUeXQd5oNErQ/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609982; c=relaxed/simple;
	bh=Ncsb8W3MPkLyXDKm+Y8UivlCJmy1txyn92Y12PYUKg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HR/AKJFFbnbn+8sJFQJkQGmMqA3E8jCubHh5F6q5jl1rr7nPyLIoPwcR7rAh7HjRpqAH9lvhlRGB07RdYDpoA133TQhw4o4QTsQzMik3ZaujFAju6nDTJRatPGczuk6LiQfMHkYdkOUdqsMhgClYUPa9sNjyaII/1yyaPvQy+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ujvpBcz6; arc=none smtp.client-ip=66.163.185.147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1783609980; bh=xbLKV+fyL/sTfAdSz0wMm/SRXvoeeDb8C93qT5s1TUg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ujvpBcz6EGizFjhm90K5VoZehOhXimSKxmcjRFqudnEhm2wxzKDEYI4/w/Dys2ppr5pa82A/FFXENA6XW45H1DIQWBslkRKbAxrHlZ7MJ8dYqgpxO1vO3wnwsbSVFQiSNRYbvhQinE/117OSj7C6wbCwoIZ4fOigwxHpk/nXDSC4x1ggg1NQPzOSWD5pOYohqFAAEAcfsv8LAdlL076moEM9jO5Pes9pYAv0VcZBj7RGBfZZuEG1bA4qtQKEbctqHXa2VfXmhBQC3A4+CYnskuIS4+s1Mv/9wCBksU3pNxC0SL4/dLglUyOO3dSX5aWe1gokdMSwptP6X7acY/uYbQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1783609980; bh=3jbR8+4hvuFH8nyEbtr3RKejiomjccs2/+MAYkBDTKV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rRdoRQDBOM1Bn7ZGLW/BbHgbnDPU0PGPGcuEdubr2Bwk1IQFkGBeVP/8/dcxzAqaCcWx0tzOKob71nI0QdpMHaarFTnNXZYQAsCNyNZoaTF+tRTdOAHPLlH/NhMzcC3kJGIlxE0tfXgdZz0b2x0f4j9KvM6d7/nhy8aqXF4AzCsJ1GIda3xOD1KiRBUg9V5lSb4Ii7x+UyK/ydngQGlqGjJPhwaX9i/qwLq74xDOpkEkJW5V4u7fHgOiv86/9R00WI0QnCuSunnDmx5paMPP71VvyqWMx/RgltBoMvV3TmjmciMj9yP3JM5iMpyHXqUGfVE1tJLu0fwwC0Pb3h0FCA==
X-YMail-OSG: WaGoWxkVM1lAKZnwCA9sep4_X9xkcRp5Vc0Ym9UhzpQEAyYma9_hiogfBXtcO6r
 BSbeH.tFoyg_esPPgrG5rEpV10kHttFjGEwj1cFO.3NBIaiZyCPLDsGsCiXW_RHA9jkwAB6V0atL
 iCKfrfPLhxlsjILmqjrSL1HWrQB53Cn1wOiPP.heyCGyPImjB3fo5G_t4K8Z.3CJU2koaKMb0YwD
 6RxxLBPVR0SGO9GzX._lkN.M1WFu6qntr27OCzwk9bBtTxHwpAx1fII7n2ACRLXhYctdggd_HQi6
 4qhqLkHJfFm2ZMrFyCJAJ7Y1.do_GJUHdFNu.wh8cZcmJrQENKlbc_.Coe_WNGRhxw_0je0k5MLP
 g4RyGn603MysLFlPJPesrh5VkdHvtDolth4NEzPFGPR29Vu_.V2X22W2x0OHbWeimKISZAI50Db3
 QTd.HjtkxVptBZadmB7Bo4U3pJIL3uYFjyg49JaG5Lh4y_D0WSOImXTHo_nCqb1_H_LWeVDvstIs
 TLoQFUIrjUBzpaj95OOx11r1E51qjTCEPyG4jm9XLG81ovFgvzeYaEqdQahXaiiULXlhsWNmIYoS
 _31jdQISu96PduZhUqRH5DNtj2kVIjBt1PxsH9T2Qd2VwTC_GWNrIzCzEQlmIg35ew7mT5v44MCD
 0Lj0Ft1m.dqfgIzTwEH7adWaHmM8atrHAAa8yfgpzxNGEUr4Zdcgb_Ts.OMze32GhQq19yQREQSJ
 PmAPs3fAsBi96pDzJRmg8lgsaCPlI0wPOoyztfCL0Y7p7c.e.A46s1x7Ar_MRb40WgENW1ORnIey
 jLaXpUYeH9cJGwqtoeHjYL0.TVw9lruwPWIZQTRb9vtGB4pvg4FtPeVRiBny9jVAghzTG4t6Hg80
 P6H49XZYtFmgTbyuxV_GgNYWqMgKveJoDmiYvFiK7JoN3X4www8FMx5NWbcc4jlLiDodOCv0VaCy
 3.JAzjMOf8UrcemPDnGCAI9iek0U3WhHk5NZVS0xL2W4ip7BcFuMdl1ilH3yePEmCQ1nhlv1r.oX
 8w484MYT9SK3C5ZGxpo5rtL0Kwiw5bsAzSnkPT1qWmDGtmTAU8cRq2DG0oqeKgUtpiLW.QwHhOLu
 CExO74cfAwNfyM5cY84gIrEMBtsIOOTAAQKv20natR8FbOOYaN6c6PkvgUHQlZJWoY87y8AXlX4T
 u1QxD27WsMlmnjG52kA6gLpyoEbnM2L6Oz27A3easn9oYJ3fLtURnhDHttfeLC8mZrSHyLVH3EI5
 WPhOYbuY90j0DNVw_V7AvhX3rUeohmlGvpaFa7Zc7nN4zyfmeYoLQuvrKfrIM2pzRBiAgPFD9BT.
 ZuWbldObzu3IJYpVdPB6IRlP59k3MFBaT9Bjb3tfXgh99I__th7tPxK5iuCb65FoKY9SW4ZVbsS0
 xFX4qc6I8xc_KScuXGh_sH2TRrrDskByaCvi5pXqji0nLpowdAjY_gcesAcpa4FPLkh8s7husQAe
 N4WI9g5Yx1.q_27w4oHeJUBCbEFrzPNohvO_oOXjB3VUqg51cJOQchgLkJcn8Nvhrr7EuUFZo7zR
 .xSKiR8abPujrso0ofvXf1kKwXJ3MviDgpBIfQjgODEE0x2NBwUhxb32KK2prBk3zE_kh4kwBK6H
 4x0KMn8Wz_d48o8azxFV8FCSqNXiT3ZMKVN_Q3dMISa0O4GBEXufWnMnCFJtMsXmMmiyNo1ByJTf
 yx3mKnBCSIAyc1nbE5Zc0z8JhDw7sJ0bFQE48.v.q6O3ZAWDhOOcgOVDX4W.zAtVwCmmeYrMG92_
 NpF8jbQUaSYmQD3DK5UsZRTRh3cWbqVkGnUx4KexVNtaEd0OX3GuaNaM1xT_EvwuS10pKDPICFSq
 ZOCW6uRLRaHWrrMig6CZW8h6mRiD6NC_Ye97cCpWDfE6iHpUHLsIS7JKXcllr6g3ea7etBbtdN5g
 KBhycZZun7mRJoxy8DoE2PORmPilx2AHdoGOSW2nwRF9HZRc5a2IpzKdUIW42z2TCfSnzkqaANVO
 S5E62Iopn2oeBBM1kFfEm7WEdnBUbVCgs8la4ZZOX783O.kq042k9Vqqi3Km3Fl5OFeXUe_YG0IF
 vixJuoJ8yr6.BBAlmO22GOSaTIhTW6RTvjBGY_wERWkhI6hSeEqt1H65B3VX04ROjznSqutst6Xh
 LG35ttxUG4mak3InyRI5W9tOaVINCb6lAqsGs7aP6x04oTxVTAQRRFuU96LJ_TYgXwhmOLBuIEfJ
 5s9mErvz6uBHJqFCPAr6tP7ysfrBgIziiS2ZMmXCTy8hlkW22XgDSPHdeQKQLjB9NCfSj1Ys-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 0f3b3ae9-870c-4d16-900f-ff8a23c57d9e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jul 2026 15:13:00 +0000
Received: by hermes--production-ir2-7b48fcd765-2bc6j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3fa513dfaadcb2c8a76ae27bd4128239;
          Thu, 09 Jul 2026 15:02:40 +0000 (UTC)
Message-ID: <276c436f-696c-4301-831e-6a79e4756905@yahoo.com>
Date: Thu, 9 Jul 2026 17:02:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: dsa: realtek: rtl8365mb: add HSGMII
 support for RTL8367S
To: Johan Alvarado <contact@c127.dev>
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <0100019f45cc4fe2-2464b68a-dfcf-4e93-9bfc-8445370d8e3e-000000@email.amazonses.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <0100019f45cc4fe2-2464b68a-dfcf-4e93-9bfc-8445370d8e3e-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26086 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[yahoo.com];
	TAGGED_FROM(0.00)[bounces-306295-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:contact@c127.dev,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:luizluca@gmail.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,bootlin.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D96F9732F93

Hi Johan

On 7/9/2026 9:34 AM, Johan Alvarado wrote:
> Hi Mieczyslaw,
> 
> On 7/3/2026 5:12 PM, Mieczyslaw Nalewaj wrote:
>> Johan, looks like you forgot to include the scheduler bandwidth bits
>> for the CPU port. Without this, HSGMII will still be capped at the
>> old SGMII rate limits. Something like:
> 
> Good catch. I had dropped these on the assumption that the vendor
> driver never touches them, but your mail made me look again: the
> "Max rate" block in dal_rtl8367c_switch_init() programs exactly these
> registers for EXT_PORT0 - the port 6 ingress and egress rate limiters
> are raised to 0x7FFFF via rtl8367c_setAsicPortIngressBandwidth() and
> rtl8367c_setAsicPortEgressRate(), followed by a raw write of 0x0007
> to 0x03fa (LINE_RATE_HSG_H). I had missed it because those writes go
> through the indexed register macros and a raw address rather than the
> PORT6_* register names.
> 
> On my board this was masked by the bootloader: U-Boot runs the vendor
> switch init (rtk_switch_init() from the ipq5018 gmac driver) and
> leaves the limits raised, but the kernel driver then issues a full
> chip reset in rtl8365mb_setup(), which puts these registers back to
> their reset defaults. With the ingress/egress limiters back at their
> defaults that would indeed cap HSGMII at roughly 1 Gbps, and I could
> not have seen it in testing because my downstream ports are 1G only
> (as noted in the cover letter, 2.5G line rate is unverified on my
> hardware).
> 
> One caveat I want to be transparent about: for the same reason I
> cannot verify the cap itself, and the vendor documentation leaves
> some room for doubt. The rtl8367c_setAsicPortIngressBandwidth()
> comment describes the bandwidth value 0x1FFFF as "disable", and
> that is exactly the reset default - I read back both limiters as
> 0x1FFFF (LSBs at 0xFFFF, MSBs at 1) on my RTL8367S after the
> driver's chip reset - so the limiter may in fact be disabled out
> of reset (though that note looks like stale text from earlier
> 17-bit-granularity chips, given this family's maximum is 0x7FFFF).
> 
> Raising the limiters is safe under either reading: if the default
> really is a ~1 Gbps limit, the write removes it, and if it means
> "disabled", the new value (0x7FFFF * 8 Kbps, about 4.19 Gbps, well
> above the 2.5G line rate) never engages.
> 
> While I cannot push more than 1 Gbps, I did verify that these
> registers really are the live rate limiters for the SerDes CPU
> port, by going the other way: on a build with the setup-time
> writes described below already in place, I lowered the limiters at
> runtime (via regmap debugfs) to 12500 * 8 Kbps = 100 Mbps
> and ran iperf3 across the CPU port. Throughput clamps from ~460 to
> ~95 Mbps with the ingress limiter lowered (CPU-originated traffic)
> and from ~600 to ~96 Mbps with the egress limiter lowered
> (CPU-bound traffic); restoring the maximum returns both directions
> to baseline. The ~95/100 ratio is the expected TCP goodput for a
> 100 Mbps wire-rate limit, so both limiters demonstrably meter this
> port at the documented 8 Kbps granularity. The only thing this
> cannot settle is the meaning of the 0x1FFFF default itself
> (~1.048 Gbps cap vs. disabled), since any value at or above the
> traffic I can generate behaves identically. If you have an
> RTL8367S setup that can push more than 1 Gbps across the HSGMII
> CPU port, a before/after measurement would be a very welcome
> confirmation of the cap.
> 
> So I'll add the writes in v5, following the vendor init: raise the
> port 6 ingress/egress limiters to their maximum once at setup time,
> rather than per interface mode. Two differences from your snippet:
> the vendor init writes the full 19-bit rate value, i.e. the LSB
> halves too (0x00cf and 0x0398 set to 0xFFFF), so I'll program both
> halves rather than only the *_CTRL1 registers, to avoid depending on
> the reset defaults of the LSB registers. And LINE_RATE_HSG_H needs no
> new write at all: the driver's common init jam table has always
> written 0x03fa = 0x0007 in rtl8365mb_switch_init(), so that one is
> already at its maximum on every probe (which also matches the 7 you
> read back for it). I have this running on my board already: with the
> setup-time writes in place both limiters read back 0x7FFFF after
> probe, and the HSGMII link comes up and forwards as before.
> 
> As an aside, a per-interface-mode variant of these writes does exist
> in the vendor code, but only for other chip families: in
> rtl8367c_setAsicPortExtMode(), the chip id 0x0652/0x6368 branch
> programs its rate registers (0x0130/0x039f/0x03fa) on every mode
> change, with 7s for EXT_HSGMII and lower values otherwise, and the
> 0x0801/0x6511 branch writes 0x00d0/0x0399/0x03fa = 7 only for
> EXT_HSGMII (which is where the pattern in your snippet comes from).
> For the 0x6367 family the ext-mode path never touches them, and the
> vendor only programs them once, unconditionally, in switch_init -
> which is another reason I prefer the one-time setup write over doing
> it from the PCS path.
> 
> For completeness, the same vendor block also touches three related
> bits: rtl8367c_setAsicPortIngressBandwidth() additionally clears the
> port 6 ingress metering pre-IFG bit and sets the "flow control when
> ingress rate exceeded" bit (PORT6_MISC_CFG, 0x00ce bits 10/11), and
> switch_init follows the egress rate write with
> rtl8367c_setAsicPortEgressRateIfg(ENABLED), which sets the global
> "egress rate accounting includes IFG" bit (SCHEDULE_WFQ_CTRL 0x0300
> bit 0). With the limiters raised to maximum the meter never engages,
> so neither the exceed action nor the IFG accounting has any
> observable effect. I plan to leave those three bits at their reset
> defaults and program only the rate values and LINE_RATE_HSG_H, to
> keep the driver's footprint on the QoS block minimal - but I'm happy
> to mirror the vendor init exactly if you'd rather not deviate from
> it.
> 
>> One more thing while we're on this: I checked the equivalent
>> registers for RGMII on the RTL8367S, and they come out to 1, 1, 7
>> respectively (INGRESSBW_PORT6_RATE_CTRL1, PORT6_EGRESSBW_CTRL1,
>> LINE_RATE_HSG_H). For correctness these should be set to those
>> values in the RGMII path as well, rather than left at whatever
>> reset/default state they're currently in.
> 
> The 1/1 you read back for the rate limiter MSBs match the reset
> defaults I see on my RTL8367S as well, and the 7 for LINE_RATE_HSG_H
> is the value the common init jam table writes on every probe, as
> above. Since the driver hard-resets the chip and then replays the
> init jam on every probe, those values are already guaranteed in
> the RGMII case, so writing them again from the RGMII path would be
> a no-op. These fields are also the MSBs of the per-port QoS rate
> limiters rather than link-mode configuration, so I would prefer to
> touch them as little as possible from the link paths. My plan for
> v5 is therefore the single write at setup time described above,
> which covers both SGMII and HSGMII and has no functional effect on
> RGMII either way: both the default value (~1.048 Gbps, if it acts
> as a limit at all) and the raised maximum sit above the 1G RGMII
> line rate, so the meter never engages there. Let me know if you
> see a problem with that.
> 
> Best regards,
> Johan

Performance degradation without setting these registers can only be
observed in HSGMII mode with simultaneous load on multiple LAN ports.

This was noticed during work on adding support for the Mercusys MR85X
router with DSA to OpenWrt: https://github.com/openwrt/openwrt/pull/19445#issuecomment-4505613294

Regards

