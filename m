Return-Path: <netdev+bounces-247657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA2CFCF2F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 229E730C6CBC
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C02F7ACA;
	Wed,  7 Jan 2026 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PhseDA4r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0510F2DA776
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778592; cv=none; b=Qyv92mRQqg4oLRkQPDsSu9EZBEUKOL1saj6k0K6/RXcNjVMnSEuTsSTMAxeQnS1X+SImVj89kZNkz0YiWO/crWJ7nfZvXCxx2HqRgxvpaCv/8SIZI2qRvGGXrHO8OjidvwNAeG/35GvzaeYwYZV1Kv6KgxBONjRaWEAj7H0Clos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778592; c=relaxed/simple;
	bh=BvNOm3NYbiU+ikXbwLgo3IoCKmUPU46BKkQ49BFiqJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moOMAQn4bbiAqd9Tln2FMh2i0gJjZ2Re25Bbo4vaLnk6YGyie7PUsfdDX5EnmfpWqTyw8XxcwBJZ079gKJYn6oIGoG0MyUCtgkXrdluDuAYD2hlnWe2Zm9R28VdUyFkimxBQcmySHYaUBuowipB8QmZIjetoekTfVtS98G4CN/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PhseDA4r; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3fa11ba9ed5so1315052fac.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 01:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767778587; x=1768383387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAJ5e65k3z1Bl84v4hSYV5jHbNZ5QqotFXMyK4sLylU=;
        b=PhseDA4rqOuGczQm8OI6ScQU96wNFWhck5YtuZvI3HSw+b+MsyyRb890d3laSxoB3e
         QFMpjN6aTvp+kbwyhLQo2J9od15tVdqXeg59qbxlSb2KYBiiePlcD4da/NZp15pAKkBy
         Mk1tudHrk3NEZlkxU0REHb8ECZjHYoNl+keMpMdQ8J1+7BWavYQN1EE+0Q2ZubgyH3cb
         9q7tX7boJlgSoFQqNjwa2K7JwHtBqMT7CB+3UG+mFjwSA01TAfkwDnk4noi5e4tQfzrH
         kz3GB4HSeiNTKvHacsIsX4s+4xZ7qV5xS1hoE6TuLlj8MomLoCEBFuyuvnfIZdE9Vpkz
         rY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767778587; x=1768383387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GAJ5e65k3z1Bl84v4hSYV5jHbNZ5QqotFXMyK4sLylU=;
        b=pYWpWd3B4jOLYDWXPwDsqff1rkhLCmvHeXV8veWxkQXE7UQxB7wVl5nLpP8OImv3n1
         Hj1ZXRzSr7uFebzuHJXSBINTuYQafgW/TVP+oL5fCqL7drr7g/u8Mc/NbTPRLc++04AO
         Pn4GiHyGWMqYjI8vlud4a++m4tWFNIFzO4YJ6U/kZMebaIunnZ12bYvMYu4myPWIksbp
         KkT1MOMPg18m+GxqP4EYg6e+f8dp+BQg1ibW5K+dklynElrsK1CJaicXaF8P5n/0sYZi
         OU2V006SZwOTzo/RoXq+Wiq4tpqLpEMViYE+L/JX4iulGPY9KrEJ9R8sIP6hziML7l5K
         pwXg==
X-Forwarded-Encrypted: i=1; AJvYcCVVxlAoc/rLJLSg1C7KrfmUNwC2Sz9rrjLBsl3aK92LDw6/pIKsRL0I4bXMG6Jm/LRVaEqPhIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/k38nJKSr/IUjhtE/CAjWlYiouVIx+bkk6NqeO9DtDaFXrCQz
	c/wuFWdOyEjDW5Mup1QvW4HuLrlvF4KdNEqSiH0+TIi+X7Fxa0DOWpp7N8mroRG1XEjecT2Xamk
	HDO2U8dS72oGPPwkBHV1GLJlBkDiOHYqWGCkjZIFQYw==
X-Gm-Gg: AY/fxX4maAsdxaUqp/F+YlbP0UNW1Tto/15VnQoe8dYFxW5DaObwZVDNNS0530tPh1h
	OHwujBAoLkWMhqAZXM5NhDBJvDjq+CtZ/ebi6kbC/OcSSUyuJZCsPxPVdRMR4vqSxr+Ml27afyF
	+/SxPjg5SRTwK8C0IDWazn9Kz7BeBeE1Ahw/j+qCjNWtfskozWSVsh/P29Jn7O7eYGrDncr2l5q
	X/89k/uLOv7GAGG9OafpVw0L7h5QX6gztBebrAy4WBbO85vgK5CSGhwHEf4tksenQCMPHN0Lh3h
	ENuD+mEVH76AWYPAcTiKlAmx9g==
X-Google-Smtp-Source: AGHT+IH8mMrbtH032ZDWJFlkRThntfnwmPEqUqd2JDeL8NGsufG7LDpL42U7yHJF4QJdKPnzDUAc6fHTBjr7gAIIOLU=
X-Received: by 2002:a4a:ba13:0:b0:659:9a49:8f89 with SMTP id
 006d021491bc7-65f55085418mr579167eaf.78.1767778586821; Wed, 07 Jan 2026
 01:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com> <d14a9c41-9df7-438f-bb58-097644d5d93f@nvidia.com>
In-Reply-To: <d14a9c41-9df7-438f-bb58-097644d5d93f@nvidia.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 7 Jan 2026 10:36:15 +0100
X-Gm-Features: AQt7F2pWAOmWwJm8vdt2KOCYOYr18EvzYgjBZjv21zyTW_ttRjt9UA8BFElgUTo
Message-ID: <CAHUa44Hhyz_zF5JtCz00YqbgoPTLK2iS7NBT8UwOLpAz=3VZAA@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] tee: Use bus callbacks instead of driver callbacks
To: Jon Hunter <jonathanh@nvidia.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jonathan Corbet <corbet@lwn.net>, Sumit Garg <sumit.garg@kernel.org>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, 
	linux-mips@vger.kernel.org, netdev@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Tue, Jan 6, 2026 at 10:40=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
> Hi Uwe,
>
> On 15/12/2025 14:16, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >
> > the objective of this series is to make tee driver stop using callbacks
> > in struct device_driver. These were superseded by bus methods in 2006
> > (commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shutdown
> > methods.")) but nobody cared to convert all subsystems accordingly.
> >
> > Here the tee drivers are converted. The first commit is somewhat
> > unrelated, but simplifies the conversion (and the drivers). It
> > introduces driver registration helpers that care about setting the bus
> > and owner. (The latter is missing in all drivers, so by using these
> > helpers the drivers become more correct.)
> >
> > v1 of this series is available at
> > https://lore.kernel.org/all/cover.1765472125.git.u.kleine-koenig@baylib=
re.com
> >
> > Changes since v1:
> >
> >   - rebase to v6.19-rc1 (no conflicts)
> >   - add tags received so far
> >   - fix whitespace issues pointed out by Sumit Garg
> >   - fix shutdown callback to shutdown and not remove
> >
> > As already noted in v1's cover letter, this series should go in during =
a
> > single merge window as there are runtime warnings when the series is
> > only applied partially. Sumit Garg suggested to apply the whole series
> > via Jens Wiklander's tree.
> > If this is done the dependencies in this series are honored, in case th=
e
> > plan changes: Patches #4 - #17 depend on the first two.
> >
> > Note this series is only build tested.
> >
> > Uwe Kleine-K=C3=B6nig (17):
> >    tee: Add some helpers to reduce boilerplate for tee client drivers
> >    tee: Add probe, remove and shutdown bus callbacks to tee_client_driv=
er
> >    tee: Adapt documentation to cover recent additions
> >    hwrng: optee - Make use of module_tee_client_driver()
> >    hwrng: optee - Make use of tee bus methods
> >    rtc: optee: Migrate to use tee specific driver registration function
> >    rtc: optee: Make use of tee bus methods
> >    efi: stmm: Make use of module_tee_client_driver()
> >    efi: stmm: Make use of tee bus methods
> >    firmware: arm_scmi: optee: Make use of module_tee_client_driver()
> >    firmware: arm_scmi: Make use of tee bus methods
> >    firmware: tee_bnxt: Make use of module_tee_client_driver()
> >    firmware: tee_bnxt: Make use of tee bus methods
> >    KEYS: trusted: Migrate to use tee specific driver registration
> >      function
> >    KEYS: trusted: Make use of tee bus methods
> >    tpm/tpm_ftpm_tee: Make use of tee specific driver registration
> >    tpm/tpm_ftpm_tee: Make use of tee bus methods
>
>
> On the next-20260105 I am seeing the following warnings ...
>
>   WARNING KERN Driver 'optee-rng' needs updating - please use bus_type me=
thods
>   WARNING KERN Driver 'scmi-optee' needs updating - please use bus_type m=
ethods
>   WARNING KERN Driver 'tee_bnxt_fw' needs updating - please use bus_type =
methods
>
> I bisected the first warning and this point to the following
> commit ...
>
> # first bad commit: [a707eda330b932bcf698be9460e54e2f389e24b7] tee: Add s=
ome helpers to reduce boilerplate for tee client drivers
>
> I have not bisected the others, but guess they are related
> to this series. Do you observe the same?

Yes, I see the same.

I'm sorry, I didn't realize that someone might bisect this when I took
only a few of the patches into next. I've applied all the patches in
this series now.

Thanks,
Jens

