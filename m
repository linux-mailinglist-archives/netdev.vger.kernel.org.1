Return-Path: <netdev+bounces-244702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4401ECBD2CD
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 10:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE97B3009864
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 09:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6094314B7D;
	Mon, 15 Dec 2025 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MlyuHyeG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC5A286413
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791144; cv=none; b=p3GUzftXHTR3mUFb3rPXYFmfrvqp0aKZsRowGD1H+8/Ittq1ybXKY5tQf6a8W99CAEGTdCm5VubwLTCp5wA4riQq/0Ngci04NFzlG/rG69iFuVRsM1BA8yWyIh/vezmzpguUBDD39TRZYl9iKvg/H9RPLYWLM750hRnmvh+obw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791144; c=relaxed/simple;
	bh=3u9umm7/VPjetaVInDHrnL/zR8rzXm2g3nThmHm+BUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOcA5ld3IlY+lW0FK2FDEAzucr0W1jX6obBgtema5Rjg5/6AMq39V+kJ0Lrn9xnH5kslGsVA3dNr4zZjEzNdTfyIq2U/mvmkOhilxMefGTOkziYoYVYvCidbLgva3Bc782vBZ098zB+NZRyWkyx4YP7i4U65H7oDo1qRtediKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MlyuHyeG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so4876916a12.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 01:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765791140; x=1766395940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMgRQp2NAuNDw0Pr8DKsFpJ1DQmsliJUNJj+b1nHdRA=;
        b=MlyuHyeGNU/hwfhc8TNJZIHkuMZvDLYkHIG0aKz8n4YJGzOpXjNR9ltFG2r3GqnLDm
         UZh2qsTa72lAtxe0DW8o2maHEGuJfrYFtaF2+qlVDnEVhvA8vwU2gGW6eXd11YSLAGNX
         TSNdgOJQClkV8kFYPZ0L/Ypi6+kLiCZEKXU7ACAOu8jLElWimU/caMAIM9drAPmK2sHz
         rW2m0xh6Jt7MCUfJSzm8l+5kQ91OvQDKZJTcHmq0Y0DyDpeQZxsGxr1eEir1C940C4ma
         h6knkXpR0A4VkeXeeOlLiqfVXVprYK0XBBvBKNbnsnMEWiZTPq+O9abnX77iAt8Ox3u7
         IcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765791140; x=1766395940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMgRQp2NAuNDw0Pr8DKsFpJ1DQmsliJUNJj+b1nHdRA=;
        b=mMz9PPBrv9n/DUamwmIoSET+fLwwWKwnBGHmwPJaaXSgfqG3bUeOKp2rjqmdc9BhqE
         0hZaVbupnmfMJ3vAj/zQVYs1OgFG5Yw2PLAOymr0QJSRcVXy8Pjzp3ItrTAQkGKIRU2/
         13pROFuNwsLU5D42+9N9HHIp+ISglzNlZPi8H+FTTSRm4Wa7BS/r8V4Ortn0zEds7uI9
         OM5tAhEnjD4mgKDEVwO28xW6vi08qsqUpd46AzvL8SBVyzCLHVqY19XLcPYKuz1qJCZN
         96GuSbEeAvvkgqlWHHbKfdFmn7ppMAYwleC2xlfefDkLINiIAf63XZa5Y0P7xiv/4DGH
         ictQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhSzpWW224pVfgovWgwAuHg1qukDmTAPdkfvazSZoyFb6MfXgVe6aO0tzliUHBGy1NrciKvyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy97PgOSg3hxWgRGf6dXzIjz38IfczK27zfV+vzQFs+Vnxg8duN
	7wZQtFHybzKeAEjCpbevggjpsgeu8Vc2pv5DLIeUxr16BvcRuSudtNCr0j9T5GLallM=
X-Gm-Gg: AY/fxX7cC1s97D9WDxjWOZL+2ql/YLX8a3WFkpdbN/qu8GqrNbJsiFc7lUv+BMaraPM
	PjVQdukXFvcSZn/MB74dGWbEJ28++atGVF3qOc3Js9WyQEp0ZhP8/DPl3zOxytMMAES8pxYXMVg
	V+ZBITRwKoLThWU/XVbmVTEiJjicR2WGisAfUtC28e3wzWg7ef9/vDVOdsZCH2psKObIpt8Itu4
	foUghogyH9v+LelhM9b/sC20mtW08yi8KEpI6uZ4NZ+0/feKLjLKn3TRCVxQduI5Pc7fufvmQzY
	babBjz2c5iUpWetPf977TeMTSx4eZyptT8LmpbCM3SRRxaEtZ7aCZKiU37yQJ4/6bKvGdtHAp4h
	nd+TZN5af6UsA4Ccxfq5per/Zb6YR1CzBRF3A7YCq4k5VrTvHppMGCs2522pKYkLM2wt2zh6x/k
	76wjdi4JZH56rqzIZTftquElOf254dCS2QC8xkmZ1tnE4/SiUcvJC1fRpbPjjvYWyBwFpvTXwIt
	cU=
X-Google-Smtp-Source: AGHT+IEaCg0quo15SNx/nGnta9oq72ocRWkg5l3SHsMTaK2wohhdkzDoQR/uDt0uWt8Scz8Vq184Fw==
X-Received: by 2002:a17:907:1c0b:b0:b7a:1be1:984 with SMTP id a640c23a62f3a-b7d23a912c7mr930197866b.64.1765791140272;
        Mon, 15 Dec 2025 01:32:20 -0800 (PST)
Received: from localhost (p200300f65f006608181e6e27368f7e86.dip0.t-ipconnect.de. [2003:f6:5f00:6608:181e:6e27:368f:7e86])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa56a7f9sm1329836266b.51.2025.12.15.01.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 01:32:19 -0800 (PST)
Date: Mon, 15 Dec 2025 10:32:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Peter Huewe <peterhuewe@gmx.de>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, netdev@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v1 00/17] tee: Use bus callbacks instead of driver
 callbacks
Message-ID: <dhunzydod4d7vj73llpuqemxb5er2ja4emxusr66irwf77jhhb@es4yd2axzl25>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <aT--ox375kg2Mzh-@sumit-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yi4htjinth7u7w6q"
Content-Disposition: inline
In-Reply-To: <aT--ox375kg2Mzh-@sumit-X1>


--yi4htjinth7u7w6q
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 00/17] tee: Use bus callbacks instead of driver
 callbacks
MIME-Version: 1.0

Hello Sumit,

On Mon, Dec 15, 2025 at 04:54:11PM +0900, Sumit Garg wrote:
> On Thu, Dec 11, 2025 at 06:14:54PM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > the objective of this series is to make tee driver stop using callbacks
> > in struct device_driver. These were superseded by bus methods in 2006
> > (commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shutdown
> > methods.")) but nobody cared to convert all subsystems accordingly.
> >=20
> > Here the tee drivers are converted. The first commit is somewhat
> > unrelated, but simplifies the conversion (and the drivers). It
> > introduces driver registration helpers that care about setting the bus
> > and owner. (The latter is missing in all drivers, so by using these
> > helpers the drivers become more correct.)
> >=20
> > The patches #4 - #17 depend on the first two, so if they should be
> > applied to their respective subsystem trees these must contain the first
> > two patches first.
>=20
> Thanks Uwe for your efforts to clean up the boilerplate code for TEE bus
> drivers.

Thanks for your feedback. I will prepare a v2 and address your comments
(whitespace issues and wrong callback in the shutdown method).

> > Note that after patch #2 is applied, unconverted drivers provoke a
> > warning in driver_register(), so it would be good for the user
> > experience if the whole series goes in during a single merge window.
>=20
> +1
>=20
> I suggest the whole series goes via the Jens tree since there shouldn't
> be any chances for conflict here.
>=20
> > So
> > I guess an immutable branch containing the frist three patches that can
> > be merged into the other subsystem trees would be sensible.
> >=20
> > After all patches are applied, tee_bus_type can be made private to
> > drivers/tee as it's not used in other places any more.
> >=20
>=20
> Feel free to make the tee_bus_type private as the last patch in the series
> such that any followup driver follows this clean approach.

There is a bit more to do for that than I'm willing to invest. With my
patch series applied `tee_bus_type` is still used in
drivers/tee/optee/device.c and drivers/tee/tee_core.c. Maybe it's
sensible to merge these two files into a single one.

The things I wonder about additionally are:

 - if CONFIG_OPTEE=3Dn and CONFIG_TEE=3Dy|m the tee bus is only used for
   drivers but not devices.

 - optee_register_device() calls device_create_file() on
   &optee_device->dev after device_register(&optee_device->dev).
   (Attention half-knowledge!) I think device_create_file() should not
   be called on an already registered device (or you have to send a
   uevent afterwards). This should probably use type attribute groups.
   (Or the need_supplicant attribute should be dropped as it isn't very
   useful. This would maybe be considered an ABI change however.)

 - Why does optee_probe() in drivers/tee/optee/smc_abi.c unregister all
   optee devices in its error path (optee_unregister_devices())?

Best regards
Uwe

--yi4htjinth7u7w6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmk/1ZQACgkQj4D7WH0S
/k5/qQf+NMGu64faecGn5WH+D12Iy/zqcfwRwh4Jv5/z/9n8f9SRKuXtH6kM3hvA
3qOp/DbN1aDIomzFdgcPUq9OJEeC51ry33uJW7UWHl5lUk4UawAR28vX/1R3nV7t
tz6suQjR2YkY2a/sAxZTSKZZ/A6RTGDxePvozHzuElCmEYDDbNhZpHsvgsLqs3T+
Cso9zyEM2is8g673w2FcAnlW3JL/8jKClvZfcm9JEIRlx48uP6uCqbWeRcYS3rrt
JBUGmWSMNEfYbD3cQbhybixsTPLzfKqkGrbJSyVRkJ2AUAQuRS14sbv7uSGhFw3B
QWGugzTdTxcSdC0SqkOUZrCXgVUKmA==
=VNEB
-----END PGP SIGNATURE-----

--yi4htjinth7u7w6q--

