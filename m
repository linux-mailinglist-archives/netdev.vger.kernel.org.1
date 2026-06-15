Return-Path: <netdev+bounces-299359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PObwLi62L2rjEwUAu9opvQ
	(envelope-from <netdev+bounces-299359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:22:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 173436847D7
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:22:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yahoo.com header.s=s2048 header.b=b+JoZdVQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299359-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299359-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=yahoo.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E7B93045005
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7AC3C2784;
	Mon, 15 Jun 2026 08:18:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-10.consmr.mail.ne1.yahoo.com (sonic313-10.consmr.mail.ne1.yahoo.com [66.163.185.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25393C277F
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 08:18:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511497; cv=none; b=D6iHJ0OGT+g5XiRXn1rFCXRnf5WQDF9Wwjz4RYEop6xsB3tvaJux3AyK6jqClAFliLMNODfkFRR1p3WOaO37io78N8HVUl0nM9CJJJN5kxuoyZi0LWSNoHKX2CT40gauauQ53iGLq/8TKd5PqAcqpfbGVSX6H/bcj8AbYe7q15A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511497; c=relaxed/simple;
	bh=yvCVzqImGRUZZ9h3hgG/1sCOj+NBomhdJ3FPLmQIKEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TowLc1EqHH9w466Wdj+vGQde45rXvlQOzKlnwHqEzUgDeIRplEgdGnsi3GUzuKz/9WAyOt78prZZWnGYELNLB7EUHjoD+SLL1CmTn3tHL8y4TL5bTPom0f+7AWV2VCOqRAROnvgqtMwPTlpwtOGySGR9Nsmp/qX0ogchSHz90gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=b+JoZdVQ; arc=none smtp.client-ip=66.163.185.33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1781511495; bh=Bc9px8cI20ZVXe9+AP1eIGT2WkRsSPaJgX7qz7NUCo4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=b+JoZdVQ5LwcxxBnm/r7iaYazGPJEseOibcQrF+CHPlvd/4uXkMkZniUOM5nt1F+You41iJoDzKLzPIwytQErYt9LJi6hH5+ah2LMTSek+PDzN5cX+BRTV/sG7Yf2yxcNycEu5/hFmjS+8gA/9C7PX8rOTDokBExJ6WpD/51+X2AVc5Qiaaw/QJNg5IGzjVNOpjLOiMtZYflaYv/s/eOXOpXuXYarub73rru64bTuorWKzQU57CktdkAKK8ts2rt5kpSpWa/UyrJu30me4DglxQmAVS26RO5+5WtG9EQZhzX76xoWiOf1PFFU9y2A4daD7NCNJgbYWB64qfC781UPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1781511495; bh=lbw1EQlpX33TNkWngKdFCIS2Va9voPDIg/nFrvvHHBW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=JZ4X98Xemw/KQBaEIH/mYcr65g8tGkzXc33s5UrZvBcS3cj8Fy5HtuS7W2tzxFeotPEKmd7TKZhctom6oeETRKyJeWWEDb5bDFAMr8EOqPkx33+O9FjeThskXHqoYBzMIxAKE7W/aWhGjaGqtRInHW5Qr/+M+8GKGeIHR7uGgBnbGM9HZr1MWDTaWvh1peD6VYIgatmumCDI1sONISYhOmCBu8pHfv68BYUq4881bZv6cz19jp4o8FfiHkAisQHNHspD+vbXTM5bp48HhP3oKmxGhNbDDXFz7sHrfM9z1puxU+MaB/mHaV2nXXAbECxP0Prmo7JjwZzRFDnonsfoTg==
X-YMail-OSG: hThR9zQVM1kDxYknI6LHONk7KJtL5mhx7mKQvueg4X_Of9w0u9UebaVPJBHw0JY
 tRSXo2uK3n_Oa.p.3iTambb4yn7LjC2zplqqgYmnwOBqb3dNoI2bOA9aIAaPWbNCzLp975oCoj6W
 9C2zrlr06NLdcYqHBM28zP85Ui5rVj.KdAKOP2BVZqx28JOIYlEWXJIjtW4nVgbfCje_THfRQ18s
 KckSVOYwDfJGrjKwqIiRRA0_6q8LyF2pva0saG6fI88OludRglEoZ_49LyTBgserdRrsm_jevuZy
 Nkd7S_y8YNBL5EccnJK4K__fBhWvLXyQX4.7r6jb4LXUP0PA37ukFl796k5d713R0WLQ3ZtMXp3F
 3O6b4P2kwKM_2V8pbmEfLVcsIwFZZ.y0DY1Cl0db4YEk9ugKOR0YLPn2oaoukbBAQVHzHIy5W1oz
 exSQYnL7PlXnpRhr4SYqEJtLH4YNrAHtu49qsD.fX8caApzcQFgmbf_Ufvt_NYiE6YtLsnE89Pvw
 kq9j5yGv7T6sf9gVLfYguOvOdqu_RoX55F1A0Q0viq4Y0kdGjT4wXkMPJmIoR4wRmqX7igqbQw6U
 .BzoPc1mW_snKL4onD2kOnsB6gBcblFxDBz_wbtrk7DZfUkBwpTZQmM2NgJbFJUKlMy5Wb4AF.eB
 SrvuAtAl8ApTVvplZWm_4mN21VllEdNveO5pE9oftvidPBuJi_DeDoZ05Gj_WEC._ZvK6SgJdqHr
 6YFkvQrtaB1VojdPahqeI.c5VFKIH.LrbeaSbs2qGOX4d4L3TbyM_Tte.BzoWfUASfXqZoahzw31
 GUwg4KqTIiJZRudUSRvntX4MWOB_RyEnUeJ4efkuVHizgDj5JyGWuKFw4tG2LkF6pf6Hrp1jy2Wv
 RreMkpmEurbLDwTjo9nMHhn.qv2ziSpD5ZPlp8LdokVhuD8g1EiYrEMynZ3mgCQbCQJaZAw1MuCY
 ETqT_5yNVxzbAxJMVVrlQ5gLxFwzCOauAtY.GQjbuQCcfo4RjTaKsOAbZuiZaLvfcktlKsf_bokT
 zUTHSlzDpsmkxtV5qMGn8AbUoJQVwWut5wzBGR6LYtExF0OSD_hKLJTvvEJ1yZt0Y8g_g6OGOY2X
 fRxRPl8DoVyZgVNJlsVGFqnF9FmBKYwpb3P03OX3WigIzCh2S3oX9YIfC.vjHi2ve1VfMf1UrIU7
 6rXO0N9bbGLBMKCcbRcZ.ejXxAWmsk3KH1_kGqfrRyrTXdfpikF_E.FooBiWC3VD37131sQncVfb
 uSPtESoSvlRDf1ct66xsKO0HXAPXz3ZoD7SdyuYG1XCuATZf7.yFGmSKMk_FvkIVV33LAlLgObxm
 J_LR6HNI8VGsZk1HSwrbNAqEs7Un6vcz4nF3RBJ9KMDgH8VrNiE2_iaUmlSgyi0gr.Qxh3WL5Yuf
 twv_C9BuXMwKpRH1Y3SZME08XCeyCEMYp8Tb.XgwLmfQb0CVzdXt4XodZaNxzYVvMastFsNHIzdz
 86KXyzKusFR10sLMZDPfZQyep1JkCPi7nVvRYjzv9eAR0k2sjHwwBo4yW997b34CHxW1J29MVW86
 pagx1G3Psj8fSiCqT3Eha.YZTOeYHBIJxuhCMt4YFwxNeq24v4jviwpXSESelFTtisiDr8bxGQ36
 ly0knEH0u2igVuf5JQC7qTP6dZB9eBobiptKecabsYAleR._I1PrJzHOhubbAfHeMx1iYRRL_5zl
 4HT_IhBr_ixDk_4nbx_dKro1vm.C1QCwZkgJlfOpUQLw2q8u09tr74e1ycj8Ooa5PWL8oATDKK2J
 oIL3izebtvAKDaTjicND8cn5CQspBWe5fgsG5yTUveVLTFgFQnnuBf0bXmfLRZgscmOwrIMlAfRi
 S9jlQEW237QkHYZhCIt55tlRRuZS4yb7msNrMkuA5gZAaTO7ki0uFrQOTMNQcFXLYAUMAQ6Q8rq6
 3IO.nuOulgONvoA4Ajj0LzgjvmoWVsMrlVNTJSt8UHY98LfiuMJm7GHDYQ_BVtUcB0_vh1vvpZ1G
 8W3n2OUBUx7CLxgcuvBrQtMHI2v8KCyCbEPaWJ9kWbi1LLj5UmJghFc7DrXeObfYxxPyeqQclvMI
 eyCPIpgknAU39LT1JeJAGyKC9lcERAGMRR21Iq3JxzzeHP_L7vfivpfTMtNKVTdvdHtLpBQpkw0E
 H8IsCix6cjQgN63CwnFirN0K5f_vsoYjGchyt2ebeSTKYDnrKD9SuoMOcKsP_wgrfwKlILkF6kAA
 63.yezhCie079UWxaWH_Dqna0gfUU21k7Hekllu2H.BkdMg34p7BKdNEcQWmtw6iLvcNbPxao_y7
 _HbeRycsgXJft2xrerJc69VU6H5IiH2N.1Wp9rRk-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 9f434d0b-e22a-40f6-8885-ea7bf5e92160
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 15 Jun 2026 08:18:15 +0000
Received: by hermes--production-ir2-89844b765-l79qj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0cc11c8e7a555de02951ddb59df734b9;
          Mon, 15 Jun 2026 07:23:28 +0000 (UTC)
Message-ID: <30f6ce89-dfe8-4b8f-adab-d52e18d9dad2@yahoo.com>
Date: Mon, 15 Jun 2026 09:23:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/2] net: dsa: realtek: rtl8365mb: add
 SGMII/HSGMII support for RTL8367S
To: Johan Alvarado <contact@c127.dev>, linusw@kernel.org,
 alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, luizluca@gmail.com, linux-kernel@vger.kernel.org
References: <0100019ec34ab9b0-cd42493d-62f2-4bd7-9ace-2e4f8e41bbbd-000000@email.amazonses.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <0100019ec34ab9b0-cd42493d-62f2-4bd7-9ace-2e4f8e41bbbd-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25942 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:contact@c127.dev,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux@armlinux.org.uk,m:luizluca@gmail.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299359-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[c127.dev,kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,c127.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 173436847D7

The fix applies not only to the RTL8367S but also to the RTL8367SB.

On 6/14/2026 1:21 AM, Johan Alvarado wrote:
> The RTL8367S is a 5+2 port switch from the same family as the
> RTL8365MB-VC already supported by this driver. Its chip info table
> entry declares SGMII and HSGMII on external interface 1, but the
> driver so far only implements RGMII, leaving boards that wire the
> switch to the CPU over the SerDes without a working CPU port.
> 
> This series implements both modes. The configuration sequence and the
> SerDes tuning parameters are derived from the GPL-licensed Realtek
> rtl8367c vendor driver, as distributed in the Mercusys MR80X GPL code
> drop, and cross-checked against the real register sequence captured at
> runtime by chainloading a custom U-Boot ahead of the stock firmware
> and logging the live SerDes accesses on hardware.
> 
> The vendor driver brings up the SerDes by loading firmware into the
> switch's embedded DW8051 microcontroller. Analysis of that firmware
> (by Luiz Angelo Daros de Luca) showed it only performs a SerDes
> data-path reset right after the SerDes reset is deasserted, and then
> runs a link-polling loop that writes the external interface force
> registers -- duplicating, and racing with, the link management phylink
> already performs. This series therefore keeps the DW8051 disabled and
> performs the one necessary action (the data-path reset via the SerDes
> BMCR register) directly in the driver, avoiding both the race and a
> dependency on a redistributable firmware blob.
> 
> Patch 1 adds the SerDes indirect access helpers and SGMII (1 Gbps)
> support. Patch 2 extends this to HSGMII (2.5 Gbps), which phylink
> represents as 2500base-x.
> 
> Tested on a Mercusys MR80X v2.20 (RTL8367S wired to the SoC over the
> SerDes), in both SGMII and HSGMII modes with a fixed-link device tree
> description: link bring-up verified across cold boots, warm reboots,
> module reloads and link down/up cycles, with sustained traffic and no
> CRC/symbol errors. The HSGMII link is confirmed running at 2.5G at the
> register level (SoC uniphy mode and gmac clocks); per-direction
> throughput could not be pushed past ~1 Gbps on this board because the
> SoC side is driven by the IPQ5018 SSDK and the user-facing PHY is 1G,
> so full 2.5G line-rate throughput remains unverified on my hardware.
> 
> Signed-off-by: Johan Alvarado <contact@c127.dev>
> ---
> v3:
>   - Drop the DW8051 firmware loading entirely. Analysis of the vendor
>     firmware showed it only duplicates the link management phylink
>     already does; the one needed action (SerDes data-path reset via
>     the BMCR register) is now performed directly in the driver, with
>     the DW8051 kept disabled. This removes the dependency on the
>     rtl8367s-sgmii.bin firmware blob, which could not be redistributed
>     via linux-firmware (the GPL vendor source ships it as a byte array
>     without the corresponding microcode source). Thanks to Luiz Angelo
>     Daros de Luca for the firmware analysis.
> v2: https://lore.kernel.org/netdev/0100019eb0b1822e-ffc5626c-1b9f-4c8a-8a1a-759a9e665f4f-000000@email.amazonses.com/
>   - No code changes; resend because the SMTP provider used for v1
>     corrupted the mails and patch 1/2 never reached the list.
> v1: https://lore.kernel.org/netdev/aebccaad-eca3-4ea4-99dd-ae7edbc8981b@smtp-relay.sendinblue.com/
> 
> Johan Alvarado (2):
>   net: dsa: realtek: rtl8365mb: add SGMII support for RTL8367S
>   net: dsa: realtek: rtl8365mb: add HSGMII support for RTL8367S
> 
>  drivers/net/dsa/realtek/rtl8365mb.c | 336 +++++++++++++++++++++++++++-
>  1 file changed, 332 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 8f4695fb67b259b2cae0be1eef55859bfc559058


