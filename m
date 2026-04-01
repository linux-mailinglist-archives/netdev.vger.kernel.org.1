Return-Path: <netdev+bounces-274011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFGUO1/mzGnuXgYAu9opvQ
	(envelope-from <netdev+bounces-274011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:33:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B89377B4E
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A48BB3045E2E
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D7B3C2763;
	Wed,  1 Apr 2026 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoruhzNj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1E3C9EC2
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035860; cv=none; b=fJlBe54SqXibmHwdSiwayA/vMF2AhY331Tw7/2SUUHJGGh7oo9kQUfdZXrCXc0AdldXXzLqmSIiSRnV4Sql1c/cjFnkaD/WPs3uLJo/gYdxmh11h4BwGvLcPFsgas6wYY/bW2PrSzN+lYUa/DlwOqfCTtN5okG4eVlIFY0nGZYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035860; c=relaxed/simple;
	bh=YpTVgd1sw5RHE5YdArlkFp7gGnSHs+j3Q+WcGRLkl7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jw4ASUaEmpanjShm8k6Gl0DmRwg63PLLEiZFrdcXxTZ5BaUshp7kXSsG10B0SKMBsqQ+b7/5NycU7cbad4Kk5hQLq+BCjr5kLzkbtIH1VmdH/UGbWAwt4rOjpTYB8yEuoV41YrRvuZnmMaHmBtrhlDM65r6IdazSUrN8Qlh5uz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoruhzNj; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c56aa62931so330854eec.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775035859; x=1775640659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkI/fz+llLTTdSLavf1iUsbgqDaGPYdZQBjuAYgwBGU=;
        b=MoruhzNjlWwhGVoWK/EF42A61xW/CrEIb73ssQTXcUOzbb/s6CMZH2PqKeQ8N4Z+iU
         vv3hA0Wn37pkSJeSJUVhx+D/bkZf2reujH/wmQqL21nmBsHf48GQ23Fby8Y8BHUxWRYu
         PXav8jQTHcX8A9/61bgGy1vERH7ejMCSJJDLSwZHkJBK+tM8xjJ+QvPSyld0oIQekCNa
         kQUsBXGH7Qg4knC1woShkjSMUfrAYwnUDnlyUqrc3SmqpRXeEqOMQ+bQ/VNFye5F382k
         Yio78YK74Fv3bTBQkMG2oZfVVnk0yabhTFIuNISf3Yi+J2Rl/n1z0IeCTHGTGmljNV5e
         Mi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775035859; x=1775640659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkI/fz+llLTTdSLavf1iUsbgqDaGPYdZQBjuAYgwBGU=;
        b=LnEuEdIFeQEBOu3IpC9bUiiGn8eVSLhIsSd9al32sZHfO/QfSCtnHpv5+JPvgRQ77U
         g2nK5tpZwlx9XvMMOnoV69cEUzcCoeIB4wt2cp7sgqSvUC0zMY2dCMvQrUxJbfPAASYb
         xoFj4jXjy8rVnDEYq59B2dcHOhhdWoRdFtQBFzV8vp63dLEgwIxdJDQTEMsjwyJOtX9x
         QgbfDXhiBVUtt8w93laNFqXzBzYyOYI3Q/FBT70sGmFSTrSwOBhpy64YhHXFZbJmkcTh
         sY/ziP9Um4bRzADApWS1ueDsgrvXdsxOECn3oEE2MWtMhCQJ12tULO7f/Nj+ep9IOAB7
         WBPg==
X-Forwarded-Encrypted: i=1; AJvYcCXwf0ZIo3XpnuA7UE2Y3oqR+LZOhxeh694DYYw9XjtoC6GylhC+Q/bNO/o0iBwK+9778fyLO6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc38X+QCjrvRYYXbqVj8VRx6ajamfHLn8GVxqDeCnIsBzxrUu8
	qAdCKm7i/EFS3eO5SRcCO8fKwweYuxljwZnd7bOZHulcrjIn4+WyhLRn
X-Gm-Gg: ATEYQzyvGEBOC8aGk60cWPFrptZYVStLspNhmC41MxewLLsJ62pReMNQQJaCTCsGAJ6
	dGPcOpsPMKH3W3dr4pJqNBbq8/QoJlb7YV6pJUYU1rdl2ocEWDYDR12E/wfDxYGSMjulMJKy3g2
	RX01c35FHcpTvkiSw2pmdE/yJovC1M9eM2gB+YVRKACfIVInfziQwOvFUx8MUBdGZFA82Py1Yag
	TicURa+TuQbZiw8OT0oZJSaoH7hqOXAoclhc3orl1YmabqHw9gSVoDgodjA/V2V3c96k72iy8Es
	bFQ+R6DI0HT88IQzKMpB0fBwa4TK24dNJee3O/Jtr1C7K8+6Di6Wvcnhc67fKeAdPHQ8uhY8y3p
	5tVfsPhERqIOqon3px387KimCtjPjIQ2z7WdxMrJfWwgCInxp/1JoOzVMiM2rhIp/uFrC8KI6tM
	+7VzKVjKtVtWph9ZPT9EY=
X-Received: by 2002:a05:7300:2391:b0:2c3:9981:e8ee with SMTP id 5a478bee46e88-2c930e75639mr1622096eec.12.1775035858460;
        Wed, 01 Apr 2026 02:30:58 -0700 (PDT)
Received: from pek-khao-d3 ([128.224.246.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b272esm12069210eec.15.2026.04.01.02.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:30:57 -0700 (PDT)
Date: Wed, 1 Apr 2026 17:30:51 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: macb: Consolidate
 MACB_CAPS_ISR_CLEAR_ON_WRITE checks in IRQ handler
Message-ID: <aczly5AD_PkYv6mJ@pek-khao-d3>
References: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
 <20260328-macb-irq-v1-2-7b3e622fb46c@gmail.com>
 <20260331195400.16bb697c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sZo9AqLLTSJ+2qKC"
Content-Disposition: inline
In-Reply-To: <20260331195400.16bb697c@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274011-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93B89377B4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--sZo9AqLLTSJ+2qKC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 28 Mar 2026 18:17:46 +0800 Kevin Hao wrote:
On Tue, Mar 31, 2026 at 07:54:00PM -0700, Jakub Kicinski wrote:
> > Currently, the MACB_CAPS_ISR_CLEAR_ON_WRITE flag is checked in every
> > branch of the IRQ handler. This repeated evaluation is unnecessary.
> > By consolidating the flag check, we eliminate redundant loads of
> > bp->caps when TX and RX events occur simultaneously, a common scenario
> > under high network throughput. Additionally, this optimization reduces
> > the function size from 0x2e8 to 0x2c4.
>=20
> feels a bit subjective TBH. An alternative improvement would be to
> factor out the conditional to a helper:
>=20
> static void macb_queue_isr_clear(bp, queue, mask)
> {
> 	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
> 		queue_writel(queue, ISR, mask);
> }

In addition to the similar pattern in the macb_interrupt() function, there =
are
seven other instances of this pattern in the macb driver.
  $ git grep "if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)" drivers/net/eth=
ernet/cadence/ | wc -l
  7

I agree that using a helper function, as you proposed, would reduce the num=
ber
of source code lines and improve the readability of the driver. However, su=
ch
changes would not affect the final generated code.

The goal of my changes is to reduce both the footprint of macb_interrupt() =
and
the number of assembly instructions executed within its event loop.

Before the patch, the condition `if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRIT=
E)`
produced the following assembly:
  ffff800080d58b1c:       387b6a68        ldrb    w8, [x19, x27]
  ffff800080d58b20:       360000c8        tbz     w8, #0, ffff800080d58b38 =
<macb_interrupt+0xd0>

After the patch, the condition `if (isr_clear)` results in:
  ffff800080d58a4c:       360000d8        tbz     w24, #0, ffff800080d58a64=
 <macb_interrupt+0xac>

Thus, we eliminate two `ldrb` overheads per iteration of the event loop in
macb_interrupt() when both TX and RX events occur simultaneously. This also
reduces the function's footprint by 36 bytes, as the `ldrb` instructions are
omitted in each event branch.

Therefore, your proposed changes and mine serve different purposes.
I acknowledge that my change represents only a very slight optimization for
the interrupt handler. I am also open to your preference for improving sour=
ce
code readability. Please let me know your decision.

Thanks,
Kevin

--sZo9AqLLTSJ+2qKC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmnM5csACgkQk1jtMN6u
sXHUUwgAn805sv0mfVlx7680D9Qh0+UKC5TqfEp1QJBG0eZ51VMg5fkiOqV6zXp4
4yQlwROsRFSPwCBgwhOH2w0pHC4n0s+zfuvJA2gyHkER9wBd1frlBK4lmaGvVkWu
DEqJjJy86/XZGNHaalpUROyL2y7xIFaolaK5vbjuXvahkRH0wuX3XfPNZzeSHe//
TFK9A+Ha9LFXeDgQV1z7Ank5Ce+IwIcRSmJ1+NPtmsrLvNBrI1AWWXl2gl5PbA1c
Jft2dI1wW1Xd0OI6QZNe3ZYtoVaSQXFARTQ1r9IRauAWUMulWGYpwVeWCCxgwmWJ
81BY819IAeMtoAOiNq78PXF1Qj5PXA==
=8IaX
-----END PGP SIGNATURE-----

--sZo9AqLLTSJ+2qKC--

