Return-Path: <netdev+bounces-261840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMVlIgadoWl8ugQAu9opvQ
	(envelope-from <netdev+bounces-261840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:32:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2CF1B7B9A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 197B230095F3
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E933E2C178D;
	Fri, 27 Feb 2026 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWXfr0a6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD222D8DAF
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199169; cv=pass; b=aUqsVuLQcOlusAZK4s2BTx6RLxzDO7oZ/U0XHqWzXRSwk+IxPSqJfq90aPIqWP1ApW5Hvb2IB+VoANloumGHG6rcJkjsrubQgFIcIlHpkRY9AHEXVZYmTiIIBQT0rN3+qbIeS3gzOcnmeNagx2aBQ85tpYFlEVMwjT/R9o1WrD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199169; c=relaxed/simple;
	bh=1efvok38BWQzpMoHE6DK58+5k0KPaM+mxDOFRHBb3w0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5PjntA/jqkuN5fxG2ycqtO4wJojoKf1Ut2cQVh3FIcGzFR07G5AVFLo4P9f9mO+TJ7ZovE717+U6fp3tHlKXrquu89ict9bg64lfOBe1r6BAjBWfGR48dEFrSRVrglnKl+K59LCknYQpRLL8HvKCRV5Am6uJbFustEp3UvTA2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWXfr0a6; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3870dec27f4so29906501fa.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 05:32:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772199167; cv=none;
        d=google.com; s=arc-20240605;
        b=dlPjdclMKcuvzeYXgTBF/O3Ce8THBvnxqCOdJa1aEhLJrJV7LufcApLfqk1POjFSoE
         YtY9Avv46BHSyizQMLLgBo6qaiRTyNpnPwBabaWd0owd4SONg/K8i8OqPH3CK15UXyxA
         XEwbt9iV5VEOT6LFgk6XniRI9SZV212tYvPIcUGwzUhuwhdl6J0AWnQ2tB/UBfMl8daG
         YkHkkJOhQJNtUm9Lsta4g8YwZ5e+ZZSvbsvwzNKxegFYeWOa97Fnl0aURX8hsAQyFT2k
         5ZPBSosfrldJK6DF/QUAHHXiqKBHkB02KcHwR/BcvOklTNNIeHYCHieNrcGxypStrqQG
         IRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1efvok38BWQzpMoHE6DK58+5k0KPaM+mxDOFRHBb3w0=;
        fh=83RO23ydqzPh3LLv2tNM+4NMMZZExmI9WEdkeqMjHj0=;
        b=j0jJ/NRN5yROECJYQIvbmVBQzwDVlG1JNySKVlrmcNRm7j5umj2sszTJW9B9V4W/bT
         rlaefTnjVU4wxZrzw6JnP884qS3PVZ/biFh0yLY4fFX7+0cb5Hkzw+k6qKre6lYmBeCD
         J0x15cP98hmH2VefAKSIDeMJjAoI7rFi2tyAXJG3tiRKt6DXn5VujAVdjuQNQtiTvK66
         /c5AHZrSseOyPFCo+8ofErXjXwV3VlWEQIhUqYFq77UYqtJ1Sk7nJbSbMUMgfX/7kSLg
         S5q0OsMpvPpVqnq1W44KRE33NNxKNF0kfi0uL7s8Dup1LKaMGi7cGAYc3Qj88hMbwIpm
         yTaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772199167; x=1772803967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1efvok38BWQzpMoHE6DK58+5k0KPaM+mxDOFRHBb3w0=;
        b=eWXfr0a69m1FOlL3rJN/HvqDnO4ocvOtqKmMf45RqY97N2Z8ixC8Bf6AxJc4n592/A
         n+6k7B40oWt/Fx9KgCvS8DmChAXn+rK7jsd8q0KRCsUhPdtXvuHOnYk50MOu8cze/TKG
         FX5SVmT6o9kV/L30u1GXhGwg2Ad7VMtQc8Q+XkzT26Z4ZC3IKhro6Efw+So/fq6aX8yX
         1O0xsO+X6t80mMXYvQdiyE4p85K4lP94eI4/rjJQ9xnbmvnU6hkxX8QEotHcOmyMwnag
         +lNaN/ehefamWVIkNkUhHKLz8lu6BSLx+y6Vt1r1izMgxyeYns1sUFq3aNmpompRWKo8
         tnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772199167; x=1772803967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1efvok38BWQzpMoHE6DK58+5k0KPaM+mxDOFRHBb3w0=;
        b=MdB47sPq91SyR0Bnn5oMriIiO4t7/BmOZtXH0dYxHE6IHuOki0NWNk9EO/4jVJGrvv
         4dkN5SMmNxHAPpSsVoIsaMZ9f8E0fQ938drB/SdA2MxPlidDZuFKK08/39++O037grFx
         01aEdYKd3nUx0MpaACeqE2+cozYnMYzyf61Peja5MbhJ7yb9kDRJ3La93S9E1TamUOoy
         3xbjE4mqdJzwvFtpB7pDU+8ChTzl4U/WDtfBqNWcvKGgIwD/26knwyCuklm52wJFiQ7S
         qepjDRI8Gj9YHElGV97dvogViPA40IFraSFyqpFKV7GnisZbxUixGYFq9RQkm8zhXaUS
         VlVg==
X-Forwarded-Encrypted: i=1; AJvYcCWkYVnFcHODBlfc/VW4y4Q6u7hubwmBWJ6BobpuvT14dqkxd0jp/DBls2KOSSxne/UsSH+abUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy15013d2jbiPc0rrxpeCCopkLOXevUd5AnFXuHP6Nm5TQ+o2HW
	XM5Do4oPFTJ289UoXxp3+lJwsZf+cdTwlNFCI1hiSVTHZEuKsxA/FhbLPfxJQ/LFXCgaAsebY4f
	geNrYQwYG+SgOvwAXt9DGY12pF8+Np3M=
X-Gm-Gg: ATEYQzyC6dyVXDLt6yoZNe5wNMIVrM7IRqrnUDYSqCmUTAxTeMpE5QPMCwmb123dYdU
	yXE2tGWrvD5AxWNM2Njp7GYXuQ91zYBPC72N6lPgMOTeoDtqOBfsXC/gR3GqucdTDJgoa4td1cu
	KCLoy1D7aXcBiLM/BSNs7JGz7sf/7ATC+Nf215U+aHfD5dvbfUwmA1wWJFS9Hpcrx3BjUPGOULN
	jH38/EJCBH1HyPLeAsqx20MOSU5gxT/3wYcnjwKWr4CQbhAj53mIf+FOgJGPCT2nPuYddxC3uKw
	lZ0CI2GZ7UNIoLs1wpICm3ZY/7wCZfT3sXtnSw==
X-Received: by 2002:a2e:a405:0:b0:387:5ea:e298 with SMTP id
 38308e7fff4ca-389f1d90b4cmr23696831fa.8.1772199166242; Fri, 27 Feb 2026
 05:32:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508091424.26870-1-jonas.gorski@gmail.com>
 <ce4d9b7b-aaf6-4796-94fb-8c3d6a1dcd4d@gmail.com> <d7f9775e-0af6-4294-837b-47e31e0d30d7@broadcom.com>
 <CACna6rw1kF-r40dr-nxouV9E0AigmeVj9fxQm_Px34Z_n2up9g@mail.gmail.com>
In-Reply-To: <CACna6rw1kF-r40dr-nxouV9E0AigmeVj9fxQm_Px34Z_n2up9g@mail.gmail.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Fri, 27 Feb 2026 14:32:32 +0100
X-Gm-Features: AaiRm50smvB4bv0MpaVHmC8DvzzWFdrNiIM27bkL7vaXPZx9vQ3KXv19FnWGVIA
Message-ID: <CACna6ry9B9LiPbWdXzi7FCcaU1YC+HPkor53AiSEaRSNUMcLwQ@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: prevent standalone from trying to
 forward to other ports
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261840-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,hauke-m.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zajec5@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: AB2CF1B7B9A
X-Rspamd-Action: no action

pt., 27 lut 2026 o 13:23 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> napisa=
=C5=82(a):
> czw., 26 lut 2026 o 22:26 Florian Fainelli
> <florian.fainelli@broadcom.com> napisa=C5=82(a):
> > Could you try to program GMNGCFG (page 0x02, offset 0) bits 7:6 to have
> > the value 0b11 which is dual IMP port (IMPO is port 8 and IMP1 is port
> > 5) and see if that helps?
>
> On my Luxul XWR-3150 (it uses gmac0 and port 5) the value of
> B53_MGMT_PAGE (0x02) / B53_GLOBAL_CONFIG (0x00) is 0xc2. Nothing to
> set there I suppose?

I tried other possible values:
0x02
0x82
0x42

None affected my switch / wan / lan ports.

--=20
Rafa=C5=82

