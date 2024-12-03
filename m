Return-Path: <netdev+bounces-148455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0179E1DB7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA6A1B392EA
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4B11E631B;
	Tue,  3 Dec 2024 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jTTDxWzA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F71E572E
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226602; cv=none; b=Zs5a5Ju30e997po1HM1FniSdmO7zrw+XYxJeu+5dnH4ddv3hpAHAbTJph7lPvYfVVSqq0+B6dTEicK+UPTtmHfkKbuIms2W70dQNljY5O+I6XCPfWGcsUklKYHPouWdFzcAOt9o0h+tD/xcrTTPwxA8I1umVHcyR/H6wr2LV2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226602; c=relaxed/simple;
	bh=qpNNCsPIgITiLdoRQfCJAiK5prJ5MmKbaYwoDG9Z54A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UglS6KGYqJzp+09vbIzBQEU4udX3xyYn/gUMUDGAr0DCFSEauq5+rnJZ04DkPMlXFu5fzHHU0ZjZCmEv1etVExO0Q1AlEGg1OKojes4MruRQcs/UNwtNwGjpbNaSp09Gmrbuq+R/ypfKWj9s8v93jacZI+LRMHXSNPsMlVaVt3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jTTDxWzA; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-434a10588f3so34905115e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 03:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733226598; x=1733831398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1eGTuoIcul4oTlM0V2VgbBHVZmBmDWQofZqgaFw1zw=;
        b=jTTDxWzAOUE2BTaTv3FDSUia/mcKKlE/IC5o3NjyTRAJV9ZyjRQuBi088868SIjmIR
         lyIrOg5CfLcIbDfMOI73atdC8r68iDNyS/rtTnIIdW206kulByKYZLOrbbtTW003LcVc
         pYXK28lG4dc1Btk87wHKx/kRT80njm0WsQmJCH3021e+GntMXgXNHUC3gUqL06uhCmdl
         yHlacz4LYv95v3mP44UnahV6yYdvLppFJPlWgpI3JjjP/jT+ZT/frL5mqo4pz9IOqfWL
         Grk8U7T/uFy1z7TGDcg9WkKNomEKyDVaETWlFUpQkx0PiTvOhRKJyNrp816LYltl0fpz
         /7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733226598; x=1733831398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1eGTuoIcul4oTlM0V2VgbBHVZmBmDWQofZqgaFw1zw=;
        b=rfXhkC1dQNYQQNuwzPPvegWcy2DAbvJQFhalAYifuDS5EThDxweFDjVjyYIQTS9dWP
         Bt1wmVRqWXXa4gbvE5KIkyVKhkJX8zMqIKfX4DXrQSSvHeZebJsqmBGHrLWVydzZqudO
         KZZwfz+jU2HQTDJJjEios+rupGROgaSdHjIfjklkIVgtqf9O+BXomqpZ7wY3ZdpeJ99A
         eAODl7rRDQpLfv0VGBxdAgadS3jJqI0P4SId3RDp0I7qxu71MCdqvbJKZgU7eJ5Nt3OH
         8tx+yrHNe8B6SCs0rFsuSW61ivWrlq6tIvJce2kndXvXj1FchcK+4YHWwlZr/11hldo8
         jNcA==
X-Forwarded-Encrypted: i=1; AJvYcCX9OUUZNP/y81dWQ4KkUBxZCi+ZCQbaI1VoMQg1VGlWMso+nLIz4ydTHeGDmYEhQEgfTRe9wys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZ5/awg8kwqRmWdnVB4NFa/Q4621LBqAXTD4KBwcmF33aeKFe
	QebzUCbCG1HlNHHvOomlS0Fsa9omllGHFNAbrRrqs84TJtP+Jwohw0Um5yVJPBY=
X-Gm-Gg: ASbGnctKMgJ18raixyilLRoT8zu0XzZMXA+A/65N071RQOXvfJT3iekqeokG3PLPFan
	o8XGVfBNeZmYBroopT96KMepyyuFcDbf0hlwx8xRmNauEpvYKwnR3pN6p8Bbb3Fvp4C1zZXzm+o
	YqShzGFdY6HbVBC/j7e5QIhXlXTTry1p0EyLCkhKItT04qPJ9hm/p0m1Sl3l74Q+lIgGPpfIrrw
	sXIlEKP1vl5kvrFs7Y2XNK+sI8TqytPDmw9HjzMiXJFJEhpbbkmgLX1HyS/sWdHM9to4etKCKOo
	xzR4tSKefu+e0XteU7RK2Q/iUSSI92R8QaUVBuw=
X-Google-Smtp-Source: AGHT+IFsnaahKV4dsatLKWcqYS7Ec/1sg7wL73iHar/F358cxfbXSRjS1/ttRnI5KGYWJY45r+/TUA==
X-Received: by 2002:a05:600c:4690:b0:434:a929:42bb with SMTP id 5b1f17b1804b1-434d09cd002mr20521795e9.18.1733226598426;
        Tue, 03 Dec 2024 03:49:58 -0800 (PST)
Received: from localhost (p200300f65f242d005bbc9b581c6b9666.dip0.t-ipconnect.de. [2003:f6:5f24:2d00:5bbc:9b58:1c6b:9666])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f7dccasm185521965e9.43.2024.12.03.03.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:49:57 -0800 (PST)
Date: Tue, 3 Dec 2024 12:49:54 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jakub Kicinski <kuba@kernel.org>, richardcochran@gmail.com, 
	yangbo.lu@nxp.com, dwmw2@infradead.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Next <linux-next@vger.kernel.org>
Subject: Re: [PATCH] ptp: Switch back to struct platform_driver::remove()
Message-ID: <5qiehbnmzufzqjgn2l4jcghebdx7llr52lgl7hi2jizpg7gfnd@c73bpxxxdeiv>
References: <20241130145349.899477-2-u.kleine-koenig@baylibre.com>
 <173318582905.3964978.17617943251785066504.git-patchwork-notify@kernel.org>
 <CAMuHMdV3J=o2x9G=1t_y97iv9eLsPfiej108vU6JHnn=AR-Nvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jpb65nidl5tvnz4e"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV3J=o2x9G=1t_y97iv9eLsPfiej108vU6JHnn=AR-Nvw@mail.gmail.com>


--jpb65nidl5tvnz4e
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] ptp: Switch back to struct platform_driver::remove()
MIME-Version: 1.0

Hello Geert,

thanks for pointing out this conflict.

On Tue, Dec 03, 2024 at 10:48:36AM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 3, 2024 at 1:30=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.or=
g> wrote:
> > This patch was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> >
> > On Sat, 30 Nov 2024 15:53:49 +0100 you wrote:
> > > After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> > > return void") .remove() is (again) the right callback to implement for
> > > platform drivers.
> > >
> > > Convert all platform drivers below drivers/ptp to use .remove(), with
> > > the eventual goal to drop struct platform_driver::remove_new(). As
> > > .remove() and .remove_new() have the same prototypes, conversion is d=
one
> > > by just changing the structure member name in the driver initializer.
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - ptp: Switch back to struct platform_driver::remove()
> >     https://git.kernel.org/netdev/net-next/c/b32913a5609a
>=20
> Note that this now conflicts with commit e70140ba0d2b1a30 ("Get rid of
> 'remove_new' relic from platform driver struct") upstream.

Indeed. The differences are only about whitespace.

> Resolution: just take the version from upstream.

But IMHO my variant is better than Linus's. After Linus' change the =3D
for .probe and .remove are aligned in the conflicting files. However the
other members initialized there are only using a single space before the
=3D. My change used the single space variant consistently for the whole
initializer.

So I suggest to either drop my change, or in the conflict resolution
take my variant and not Linus's.

Best regards
Uwe

--jpb65nidl5tvnz4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdO8F8ACgkQj4D7WH0S
/k6KEAf9F+5sS9kn27evKyDBVLtmYthIzlL6RVq3+pB4aw882KLlwsIKZEZaG6sW
h4CUtJwrjOm62GfBaKL54529/j8wJ23voQX99z8W+JBYIBaPqwRs7gTHNYXAaQC8
nbke+jKVEgm3BOxK3tfoOfWYyJbar8FkCWWbVTKbrM04bkO2XeLYK88qCHDx47mp
q6hyI0EgLoxE9OlGJVbCx4SInXXDyeQD7I96G5VccSaxxmoSp5Zx82sXGn6CfzVr
RKCNPJ+oqpnBi4muJ9S9SHhxXxGfyBm5ZASzxOFcuEzMmufUXsrfVUsm1m7R6I5w
cKSWIjE8MZEFpl9kZ9kUZTn26f1Tyw==
=hFOS
-----END PGP SIGNATURE-----

--jpb65nidl5tvnz4e--

