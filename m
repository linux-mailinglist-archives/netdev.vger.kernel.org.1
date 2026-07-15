Return-Path: <netdev+bounces-307757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vyCIIjaIV2qiWQAAu9opvQ
	(envelope-from <netdev+bounces-307757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 15:16:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4DE75E8D7
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 15:16:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=WHO+EdBF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307757-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307757-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7848430CD2A3
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9371F1E98E3;
	Wed, 15 Jul 2026 13:12:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867A6420498
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 13:12:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121147; cv=none; b=ezvcsMfUBG16wmuvAiSx+H2Fl4eNMjZstxPuRpq7MX5UnKzCU4bGPe3uyyueEhcVHM4zVAKA2e02Z3ZlbpzM8PsVfSxjzo5suBE6fKK4z1ADbO+ClAHpLyD87guim2FFVAsqQqNao58BmMXDd+bcrg9LetrRWJg3vqpUKtf5Ecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121147; c=relaxed/simple;
	bh=cg3RdC+8r06kFIso1ksJ5pziwGTKdb20qOL/6Jpy/xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSPz4Jeq2eTEsqa/uUQSsKRbkitoeekLugfv3npTT1ryI3ZTwu939h89FntlMB3n/Y4hCkisTBA++YAkcrf7IHZurpV06BTa0xDN/pQWsYYz1AxQP4crcCZBV4RyXyIgR87wljokjtQUH+0q1aGOh9J3WO6+xXByF9+TPxaqN7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WHO+EdBF; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493f60208a5so46128575e9.3
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 06:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784121144; x=1784725944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=juQNkQzcMB1WeyX2ItASwvvn19gapwKTqhQHKKAeewQ=;
        b=WHO+EdBFljAjkjKDGMreM1Ifi23akFSJUKch6utuOILInpkguUZKUfeZxscud6rt5h
         8wPM4fXLCHB/21nCVfrnEVTfUAOyoPk+DFrqXQvDOk1gYRZ42herZsMI/m0dtVz2irk7
         6Cdq2iXNgW8T7LE7DSICg0h8WHbFSUAMr7S8Tp8XktDEPdlxLuMqINtRsWiwanZgCzr4
         v4QniQIYpQBswfW14h4UnDF1BBqH5hFg3HyAEi15ICWfRwSCtHM0Z2uoAzOafNKME46B
         yQYYg7z0CsmqcxYGNRKMNWaug/lhTDU2Owxt8GGGitHAXCYN8861aGbK+zwT+/42pYQf
         8DKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784121144; x=1784725944;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=juQNkQzcMB1WeyX2ItASwvvn19gapwKTqhQHKKAeewQ=;
        b=Zmp5hISjJ+zpPaMg4/aW2G2vhTsbl+M7jvwoUP5MLFD33njy6QdKF0aCrLu3dKYMd6
         nTat8jYMMJ0mM1lTbG6OIiRXyfLEVhfoQPXi69eSPnQyzXnnvMdFITBO1wIuFXnCtHH+
         y82xZmIFCQr/9tyOMAXdtVY+1AOBGeBoEjxd/BwmxW3b0zKu4E5ZVNHAXvAVoDKubsVj
         ugSNnZhcwvbKYQwPEJthVZJYzDPVSOpBkP6WDdkAvecXXV92YtVfgeaZpmxjRMfXOPOb
         xHqx6ilOlTYMzziKBUR6UPyeJcdZcLQuEnSl5RLOjHW3Y75jMnD3QHv9GuUOZaj3UCrI
         VwFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqz5a6IXYWcHSFyeNuk8aLi+dadj8cdqLLGBqkUpKv8jxZWKSoPt7npz9d0L2feFHH6bgRLFBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyThUJaKBZsWcH6R2mEj6YeUDOiqCFna2yiDStChIOk8NqnFIo
	duc4Dm0tNuBS9vmGuQK4L7cqn7F6hOcOlsoBo842zP4+3kSpEzeksnBe+FBr2sgQGx8=
X-Gm-Gg: AfdE7cki6Qsqz8gXpbT4uKbfyAmktmtgUtJgrdz8nU5wnpGm+UzQtwU88n4iuyaO2mU
	BSn4LgI0nwSc8coc5AFwubINYJ4+zqdkiF67lfOPhLUW4nYLUXVhhzUnuganZD4gtevX59RoXbL
	pgPtl9V53OPOUro8xBv07a5OM8GY9mgnriqIH+C2XcLI5YES6lUi9ej+hPBat2v4WxMJac65svE
	moOJf1F0QE5Gf+WsuhUHImSIO9y3Up0ANIzarjr1BbkY/sTgSF2JOceh8sXaE7VRgE2dRUC4bYm
	VwDfvfvNMtnG58kvTKtKii4hvjnqHPqEAPxms9siS+Yc48ctwt1koyQ5EQnO0cqOCg13pPoWM8o
	pXlU5705jDDeO0QiOO3qDVAHN8iYhQJJBGFf+2zjfA5v+Y+A5e35E6ok9Lw9lfs7zDTu0OifbUe
	Moekn4CKSo2MfAjyaxAnOEy7siFCFCbQBYCyWyMPbwBQiQSUMz/EmnbXglRGvZP2S1pF5D5VRzO
	gg=
X-Received: by 2002:a7b:c344:0:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-4953c1474famr22547365e9.5.1784121143660;
        Wed, 15 Jul 2026 06:12:23 -0700 (PDT)
Received: from localhost (p200300f65f47db04249e031dea91a10d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:249e:31d:ea91:a10d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f4635aa34sm15038952f8f.15.2026.07.15.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 06:12:22 -0700 (PDT)
Date: Wed, 15 Jul 2026 15:12:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Dan Carpenter <error27@gmail.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	MD Danish Anwar <danishanwar@ti.com>, Michael Grzeschik <mgr@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Yibo Dong <dong100@mucse.com>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: rnpgbe: Pass an expression directly in
 rnpgbe_rm_adapter()
Message-ID: <aleFN4Z2XT3NP3od@monoceros>
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <alScHkiC3EmGzOlI@stanley.mountain>
 <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jvg5qx7ygkch6d5n"
Content-Disposition: inline
In-Reply-To: <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de>
X-Spamd-Result: default: False [0.24 / 15.00];
	RCVD_UNAUTH_PBL(2.00)[];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Markus.Elfring@web.de,m:error27@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:danishanwar@ti.com,m:mgr@kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:dong100@mucse.com,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[web.de];
	TAGGED_FROM(0.00)[bounces-307757-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[baylibre.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_PBL(0.00)[2003:f6:5f47:db04:249e:31d:ea91:a10d:received];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,ti.com,redhat.com,linux.dev,mucse.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,209.85.128.41:received];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,monoceros:mid,baylibre.com:dkim,baylibre.com:from_mime,lwn.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC4DE75E8D7
X-Rspamd-Action: no action


--jvg5qx7ygkch6d5n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] net: rnpgbe: Pass an expression directly in
 rnpgbe_rm_adapter()
MIME-Version: 1.0

On Mon, Jul 13, 2026 at 10:22:06AM +0200, Markus Elfring wrote:
> >> The address of a data structure member was determined before
> >> a corresponding null pointer check in the implementation of
> >> the function =E2=80=9Crnpgbe_rm_adapter=E2=80=9D.
> >>
> >> Thus avoid the risk for undefined behaviour by omitting the variable =
=E2=80=9Chw=E2=80=9D.
> >> Pass the required address directly to a function call.
> >>
> >> This issue was detected by using the Coccinelle software.
> >>
> >> Fixes: 2ee95ec17e97c58b65e978a08b75fa8cb6424e4e ("net: rnpgbe: Add reg=
ister_netdev")
> >=20
> > There is no NULL dereference here.  It's just pointer math.
> > No need for a Fixes tag.
>=20
> How does your view fit to information in an article like =E2=80=9CFun with
> NULL pointers, part 1=E2=80=9D(by Jonathan Corbet from 2009-07-20)?
> https://lwn.net/Articles/342330/

It does fit, because the problematic code discussed in Jonathan Corbet's
article is of the type:

	int i =3D ptr->i;

	if (!ptr)
		do_something();

while here we have:

	int *i =3D &ptr->i;

	if (!ptr)
		do_something();

which at least in my test[1] is relevantly different. Note, I didn't
study the C standard if the compiler is free to optimize out
do_something() also in the 2nd case, but at least today gcc doesn't.

Best regards
Uwe

[1] Me knowing about ARM assembly, that's what I checked:

	$ cat test.c
	#include <stdio.h>
	#include <stdlib.h>

	struct mystruct {
		int i;
		char c;
	};

	int funcdirect(struct mystruct *ptr)
	{
		int i =3D ptr->i;

		if (!ptr)
			return -1;

		printf("i =3D %d\n", i);
		return 0;
	}

	int funcindirect(struct mystruct *ptr)
	{
		int *i =3D &ptr->i;

		if (!ptr)
			return -1;

		printf("i =3D %d\n", *i);
		return 0;
	}
	$ arm-linux-gnueabihf-gcc -O3 -c test.c
	$ objdump -D test.o

	test.o:     file format elf32-littlearm


	Disassembly of section .text:

	00000000 <funcdirect>:
	   0:	b508      	push	{r3, lr}
	   2:	4603      	mov	r3, r0
	   4:	4803      	ldr	r0, [pc, #12]	@ (14 <funcdirect+0x14>)
	   6:	6819      	ldr	r1, [r3, #0]
	   8:	4478      	add	r0, pc
	   a:	f7ff fffe 	bl	0 <printf>
	   e:	2000      	movs	r0, #0
	  10:	bd08      	pop	{r3, pc}
	  12:	bf00      	nop
	  14:	00000008 	andeq	r0, r0, r8

	00000018 <funcindirect>:
	  18:	b138      	cbz	r0, 2a <funcindirect+0x12>
	  1a:	6801      	ldr	r1, [r0, #0]
	  1c:	4804      	ldr	r0, [pc, #16]	@ (30 <funcindirect+0x18>)
	  1e:	b508      	push	{r3, lr}
	  20:	4478      	add	r0, pc
	  22:	f7ff fffe 	bl	0 <printf>
	  26:	2000      	movs	r0, #0
	  28:	bd08      	pop	{r3, pc}
	  2a:	f04f 30ff 	mov.w	r0, #4294967295	@ 0xffffffff
	  2e:	4770      	bx	lr
	  30:	0000000c 	andeq	r0, r0, ip

So in funcdirect the check is not present, while it is in funcindirect.

--jvg5qx7ygkch6d5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpXhywACgkQj4D7WH0S
/k79awgAqpBASv+7f51qDle6yT4mmgAmQOxoRhY30/FRK6rnNe+P5pjQw6aPGYm8
rR9CXQDnj8dC1KTwbLAVezCqi3uLEHPjCz3wEwCgPyvdTWBGethtw9rDlpEtaTTg
+RilevanhOB1vEDMGHPkYjWs1LUdjAKLw+5AUASdQfoNUPFIYPGNq3W+x1Ih90uf
vaaYugKrrNRSqSTCwPjWJJnp2CXIW98veoXLlNtHscl2cc95kW4l8m1vjS5VPZyN
WnFo068hMRmphIJLxSDhvWOVoGfQxkFuS/lxOEXskJe4QEsXi/9hEr6dFkoFLVyr
bjPFJzzF7XtM0RI5fdNwFOxGWbWxIA==
=YJNG
-----END PGP SIGNATURE-----

--jvg5qx7ygkch6d5n--

