Return-Path: <netdev+bounces-245397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A705CCCC55
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 506E93022F05
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411A1366572;
	Thu, 18 Dec 2025 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOrYbKyM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF79366567
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766075368; cv=none; b=LMeam8PCYY4FM45StJZwhSdmKVJqOVlBzy53vMHMjaCnARlfdhz9oRMC12KESkA77CaFCZPqDGMoUPIHXZlhGlAjxGwLeQkzxeEOPfPzTlL6+kX47gOAgXlJ730I0LDMi7tS/Lpy4RUf6IzZ1HLoNNf/M8VyReNL9ZEuIOFMig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766075368; c=relaxed/simple;
	bh=zXX2/NiUfkloBnXKh4lMbliIbzAn7LdSq2fbSJlmbS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTJaNoHJJp94KgJgKRmQbC4qu5BdpWpqF0DKgr39lV9A2uiREspbPdJFNl/KUMoDUAXznMrxT233aTtKqc9nd9Dp6FwBef99USRTjSiO7mIk12mrSdJtzQZld4SPxFLi+SSO4vIF0A5QcP5Pr+3NJ0Iu8YlbdQfRcKze5PWBstw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kOrYbKyM; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-656d9230cf2so411864eaf.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 08:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766075364; x=1766680164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMSbry1+P/RNP4K+kKiw/SAaU8hSKKePZ7aYLlJ/2Ro=;
        b=kOrYbKyMd2wZymPsuzAKT6xrOvB4aJzZjNSLJWOTzJJ2PVkFASLC23EEaVV7ebm3Pm
         XPHbpFxM1Ede9y8XQKTufZVArc7p5AwbcFaOaXAzmpMgSrn1Oa0uiXjVMRm4/vT2PY0Y
         y7Q6RzMmmNa2VbyD1sRj3+1bhHkZzRqewdpVMCCm1jJH+CAWgHmZEw3igmL+YoDu9nEf
         B8BcciPRZupYwiCR9e1It7WL/mw2rfj73Cx9Zm1gYN7bkkvJ/5oRCWZ2F7YOININuEoh
         uTX5bqd7xV/QHl+7TAXaN/hRQtAFJM5xvHVV7QonO6eqnOrFV/76ZIz9uq+hMdDE61bw
         FGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766075364; x=1766680164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zMSbry1+P/RNP4K+kKiw/SAaU8hSKKePZ7aYLlJ/2Ro=;
        b=b+51aQIHkMdLtcXZfspbKCQOgDk/zoXFJXZvE5tymFPhvgoKzkN0BzioyI9+Rb0Bl0
         wz9mbWx9gsvwN9Qt8hywQ+tqkb1AByGBFo6avauXfkJIriWsQMOsNtvtygpKxIaxizPq
         3Rx5ZYNtkbO/kaPQKOgUtQgJuoweFXg8UOewnO9wxmNCYnW8P74yI3D9XPThFs9RS3Ma
         SkVC3OBgmwetQ4i/Z8mh/ISfFBqTlML8FdUje5RDm2uKsE67zF1ZdqZ+46eMcEau8YVn
         mSjpjK9RkodINSZB/y3M3FosUG0esIRVmm+LewWW5iJy4lSDQUKa+XHd3CiK/r3dgHGb
         za7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUK2i9AY0JHmzhJN+Q+ESdMwd8OY1VGOGFIvlXKn/ePkthzTnCg9h+vDj5xHH5yFVDEGedG5G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxaOoThE/I2JgDyPRW0ufunndB5Q+qOtxzccOaHIriU4jA7/1H
	Ru18sgHqjOdzGiVBoLHEIurqXteqsDUHaixlN8V2RFyvSvo2KCBqZH7Ngf1C5wqswbc7e2Zhh/6
	EQMXuMDfpV1UugcA7iE96pS+8osgIwIkJUU8+A/ax8w==
X-Gm-Gg: AY/fxX5Lk7EV9p9A6WEyjitpJpQpc8r6omlQZ+6+7H+a6kBh0BH91vj/448VXE5w2Sq
	yfF48Fk2SdJtmxZqPyDFHWBVeMr9EdCfxyw5UV8NarSUeIWEdo/LD0aSzNQ8lwrYCABSgShkIyd
	S/1OrOxLP9SdCnmsFi75hBlsCmMxj7y6qJhXZwm8YdPlus5INr1yMQgT58qTsxhzswDnIVxWk3R
	SgowrQKOmO2Bkh5FvN8wqihWJQ14vQnNku4YMDOWWJIBcLnPdQw53eGsyvmN1IWhQlQYVYHsGsi
	RBxQsMv9bCAg7TakECgEfNYpDg==
X-Google-Smtp-Source: AGHT+IG4Ae8pfu7GZWy4M+xMepW+pZBXhOq0aMMfvpQMcwHosUK2iqdP0ZilC2IC9nPL0ue49M44wROrYBjFkfFnq4M=
X-Received: by 2002:a05:6820:6389:b0:657:4e49:83b7 with SMTP id
 006d021491bc7-65d0e9fe36fmr11432eaf.1.1766075363719; Thu, 18 Dec 2025
 08:29:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <CAHUa44FrDZbvRvfN8obf80_k=Eqxe9YxHpjaE5jU7nkxPUwfag@mail.gmail.com> <20251218135332f323fa91@mail.local>
In-Reply-To: <20251218135332f323fa91@mail.local>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 18 Dec 2025 17:29:11 +0100
X-Gm-Features: AQt7F2pA2I_HJOEbadmjsOrYtjrxD8lxVlzGBd-sNqyaYCgybyYAHq_YVDlH-Pg
Message-ID: <CAHUa44GpW5aO26GDyL9RZub9vVYvVcJ7etwO0yXBN_mUi0W4AA@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] tee: Use bus callbacks instead of driver callbacks
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jonathan Corbet <corbet@lwn.net>, Sumit Garg <sumit.garg@kernel.org>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
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
	linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 2:53=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 18/12/2025 08:21:27+0100, Jens Wiklander wrote:
> > Hi,
> >
> > On Mon, Dec 15, 2025 at 3:17=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > >
> > > Hello,
> > >
> > > the objective of this series is to make tee driver stop using callbac=
ks
> > > in struct device_driver. These were superseded by bus methods in 2006
> > > (commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shutdown
> > > methods.")) but nobody cared to convert all subsystems accordingly.
> > >
> > > Here the tee drivers are converted. The first commit is somewhat
> > > unrelated, but simplifies the conversion (and the drivers). It
> > > introduces driver registration helpers that care about setting the bu=
s
> > > and owner. (The latter is missing in all drivers, so by using these
> > > helpers the drivers become more correct.)
> > >
> > > v1 of this series is available at
> > > https://lore.kernel.org/all/cover.1765472125.git.u.kleine-koenig@bayl=
ibre.com
> > >
> > > Changes since v1:
> > >
> > >  - rebase to v6.19-rc1 (no conflicts)
> > >  - add tags received so far
> > >  - fix whitespace issues pointed out by Sumit Garg
> > >  - fix shutdown callback to shutdown and not remove
> > >
> > > As already noted in v1's cover letter, this series should go in durin=
g a
> > > single merge window as there are runtime warnings when the series is
> > > only applied partially. Sumit Garg suggested to apply the whole serie=
s
> > > via Jens Wiklander's tree.
> > > If this is done the dependencies in this series are honored, in case =
the
> > > plan changes: Patches #4 - #17 depend on the first two.
> > >
> > > Note this series is only build tested.
> > >
> > > Uwe Kleine-K=C3=B6nig (17):
> > >   tee: Add some helpers to reduce boilerplate for tee client drivers
> > >   tee: Add probe, remove and shutdown bus callbacks to tee_client_dri=
ver
> > >   tee: Adapt documentation to cover recent additions
> > >   hwrng: optee - Make use of module_tee_client_driver()
> > >   hwrng: optee - Make use of tee bus methods
> > >   rtc: optee: Migrate to use tee specific driver registration functio=
n
> > >   rtc: optee: Make use of tee bus methods
> > >   efi: stmm: Make use of module_tee_client_driver()
> > >   efi: stmm: Make use of tee bus methods
> > >   firmware: arm_scmi: optee: Make use of module_tee_client_driver()
> > >   firmware: arm_scmi: Make use of tee bus methods
> > >   firmware: tee_bnxt: Make use of module_tee_client_driver()
> > >   firmware: tee_bnxt: Make use of tee bus methods
> > >   KEYS: trusted: Migrate to use tee specific driver registration
> > >     function
> > >   KEYS: trusted: Make use of tee bus methods
> > >   tpm/tpm_ftpm_tee: Make use of tee specific driver registration
> > >   tpm/tpm_ftpm_tee: Make use of tee bus methods
> > >
> > >  Documentation/driver-api/tee.rst             | 18 +----
> > >  drivers/char/hw_random/optee-rng.c           | 26 ++----
> > >  drivers/char/tpm/tpm_ftpm_tee.c              | 31 +++++---
> > >  drivers/firmware/arm_scmi/transports/optee.c | 32 +++-----
> > >  drivers/firmware/broadcom/tee_bnxt_fw.c      | 30 ++-----
> > >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 25 ++----
> > >  drivers/rtc/rtc-optee.c                      | 27 ++-----
> > >  drivers/tee/tee_core.c                       | 84 ++++++++++++++++++=
++
> > >  include/linux/tee_drv.h                      | 12 +++
> > >  security/keys/trusted-keys/trusted_tee.c     | 17 ++--
> > >  10 files changed, 164 insertions(+), 138 deletions(-)
> > >
> > > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > > --
> > > 2.47.3
> > >
> >
> > Thank you for the nice cleanup, Uwe.
> >
> > I've applied patch 1-3 to the branch tee_bus_callback_for_6.20 in my
> > tree at https://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-te=
e.git/
> >
> > The branch is based on v6.19-rc1, and I'll try to keep it stable for
> > others to depend on, if needed. Let's see if we can agree on taking
> > the remaining patches via that branch.
>
> 6 and 7 can go through your branch.

Good, I've added them to my branch now.

Thanks,
Jens

