Return-Path: <netdev+bounces-133610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B51E996745
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0A028218A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9BC18FDDB;
	Wed,  9 Oct 2024 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/IUZLiG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989C18FC83
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469706; cv=none; b=lbvgrNHGx0MsYf6UdxTKaphTMxtFdMajvatT9TpaILxwve0eAlCvaJsVAZ1GZwwEXSua8iVhlEu9jMiUJ3hktAYNF+TnTlBa5FLCaAMFVM3X+cuiU6lZl/QEQ92KOh5BE6LVHky2lZI5rWf1Yro5Aqb9C0H3ZR0kT1+XYnXwrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469706; c=relaxed/simple;
	bh=/fIjIpUdHAzWUFceihGJMz4qHHzjyT7pvRboVHLIXt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sE7MZtfxo8v8/+AoNkyEELxNJ1f4UFoaRaZcxbIoJzIDQWIBEjNKTcB5uJPG4Ck5XfBeim7l/G4AtewCI4Kg29/1cYx2mzhwOqEn+BWQrikesJF0oDn7Ye4c40JY2Rh4qjBJ6Nz1F95hoBHm1KK7lGn65sj9H1KvqZCaFMco81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R/IUZLiG; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e2904ce7e14so325186276.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 03:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728469702; x=1729074502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fIjIpUdHAzWUFceihGJMz4qHHzjyT7pvRboVHLIXt8=;
        b=R/IUZLiGTVMjm+vz/itDZc9wmAPVMljxmRitpZEJud1G0u3w5i1YUFXS5nVV3WYoz8
         ubvhh9K122Gjzldf8MIilxZWJIq+pHQJNBlZFum0GVuFc1MEaHETL5T008QXAFwPq1ot
         kitLFU3/SkC2aWezlO4OguLTOZSf+tA1tyYrfik4ykoNQkvXAj6c52HeG1Ysmw2AI238
         HsY2f3tX4OKHncsdhEvf1LEfHqNJ6jQgUxWv1stM9PG3qos2FQm71ynZckctR1C4pJwx
         vtDImDcHsDnvehucXFysFeu2BI8sfq7nFQW1sE+ns0FrP0/6loH6Z+NZH4YNYSRSMgNb
         7/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728469702; x=1729074502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fIjIpUdHAzWUFceihGJMz4qHHzjyT7pvRboVHLIXt8=;
        b=QhazwZqoSHzmEj7cv0Opszyx8rPSro2/55f6uMQz/qsNLFSBRCGHTdwY7dxLJCKQd9
         rOVb1PSsGDS8IYcpvmjjdoFYPI/NsBHPhFByEsncLYIwqk7Lkovuc0X7tEYeiq3/dUOH
         VZZhZkCUsjtv73VbF1sBy2sYSfVxyGrcVjELW2aU8gOkxsMNmZ3VN29IQtUBOdadVbuJ
         QWK8cV1li87LasrYuUER13xAHl+1dv+1y7ZHrhSdtOV5neP2cUq8lWdLe526SoHQTtS3
         pnXxrD7QaEf2pqsFpth5ERmBTERbc1YyG9+ffIfv2bHSDqr5UIQBrsddeGjhmsBwQ3OD
         PZHA==
X-Forwarded-Encrypted: i=1; AJvYcCXpsh2oYS+cRiPVVg0LlZlNDmV4mCN2IZmUJpO0YrloPcJklg2y6VhGxuzO6wQvzW6r6DMjBCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI699cefI1D/6nHFTq5IGj6m1idsdxCt6nyYuFKcPH0QiVa5ql
	aahj+n2tIldJd5n/a1X99u6hgjC2sCPTJCgU/3RlFEY4bWpGoS5LMHQFRNdkwF4iPGgup+x7cKZ
	M8xmF9Pe3QigLFjTc7EpVKsIs1BG4l7YaFGvMqA==
X-Google-Smtp-Source: AGHT+IHNaU3Z3+DDKTWwqyhccdWy6KGvX0jRFFJtFda2WTvGLlJcpHA53hhWZp12VBznxD4kUpVSZMoh/Lgesk7avnk=
X-Received: by 2002:a25:eb02:0:b0:e25:96a4:1706 with SMTP id
 3f1490d57ef6-e28fe43f3d1mr1744852276.19.1728469701975; Wed, 09 Oct 2024
 03:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
 <CAPDyKFp0N6UJhnHS164Tdf=xkWB0jzq65L9TdvYazeBQ-6WjeQ@mail.gmail.com>
 <20241007184924.GH14766@pendragon.ideasonboard.com> <CAPDyKFpQVnF7eQv3dup8k-3EijnMjuveCG9sZ=Rpey1Y6MBJEg@mail.gmail.com>
 <20241007222502.GG30699@pendragon.ideasonboard.com> <CAPDyKFrGNwna6Y2pqSRaBbRYHKRaD2ayqQHLtoqLPOu9Et7qTg@mail.gmail.com>
 <CAJZ5v0jvJyS7D5-wURi2kyWN-rmNa+YqupeQJ000pQRVd9VBcQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jvJyS7D5-wURi2kyWN-rmNa+YqupeQJ000pQRVd9VBcQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 12:27:45 +0200
Message-ID: <CAPDyKFqh_BS=6eN4tQzZ20sWCHL3kdnrY=1Mgd7B9gfBamm8bw@mail.gmail.com>
Subject: Re: [PATCH 00/51] treewide: Switch to __pm_runtime_put_autosuspend()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, patches@opensource.cirrus.com, 
	iommu@lists.linux.dev, imx@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org, 
	linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org, 
	asahi@lists.linux.dev, Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Oct 2024 at 20:25, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Oct 8, 2024 at 12:35=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Tue, 8 Oct 2024 at 00:25, Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > >
> > > Hi Ulf,
> > >
> > > On Tue, Oct 08, 2024 at 12:08:24AM +0200, Ulf Hansson wrote:
> > > > On Mon, 7 Oct 2024 at 20:49, Laurent Pinchart wrote:
> > > > > On Fri, Oct 04, 2024 at 04:38:36PM +0200, Ulf Hansson wrote:
> > > > > > On Fri, 4 Oct 2024 at 11:41, Sakari Ailus wrote:
> > > > > > >
> > > > > > > Hello everyone,
> > > > > > >
> > > > > > > This set will switch the users of pm_runtime_put_autosuspend(=
) to
> > > > > > > __pm_runtime_put_autosuspend() while the former will soon be =
re-purposed
> > > > > > > to include a call to pm_runtime_mark_last_busy(). The two are=
 almost
> > > > > > > always used together, apart from bugs which are likely common=
. Going
> > > > > > > forward, most new users should be using pm_runtime_put_autosu=
spend().
> > > > > > >
> > > > > > > Once this conversion is done and pm_runtime_put_autosuspend()=
 re-purposed,
> > > > > > > I'll post another set to merge the calls to __pm_runtime_put_=
autosuspend()
> > > > > > > and pm_runtime_mark_last_busy().
> > > > > >
> > > > > > That sounds like it could cause a lot of churns.
> > > > > >
> > > > > > Why not add a new helper function that does the
> > > > > > pm_runtime_put_autosuspend() and the pm_runtime_mark_last_busy(=
)
> > > > > > things? Then we can start moving users over to this new interfa=
ce,
> > > > > > rather than having this intermediate step?
> > > > >
> > > > > I think the API would be nicer if we used the shortest and simple=
st
> > > > > function names for the most common use cases. Following
> > > > > pm_runtime_put_autosuspend() with pm_runtime_mark_last_busy() is =
that
> > > > > most common use case. That's why I like Sakari's approach of repu=
rposing
> > > > > pm_runtime_put_autosuspend(), and introducing
> > > > > __pm_runtime_put_autosuspend() for the odd cases where
> > > > > pm_runtime_mark_last_busy() shouldn't be called.
> > > >
> > > > Okay, so the reason for this approach is because we couldn't find a
> > > > short and descriptive name that could be used in favor of
> > > > pm_runtime_put_autosuspend(). Let me throw some ideas at it and may=
be
> > > > you like it - or not. :-)
> > >
> > > I like the idea at least :-)
> > >
> > > > I don't know what options you guys discussed, but to me the entire
> > > > "autosuspend"-suffix isn't really that necessary in my opinion. The=
re
> > > > are more ways than calling pm_runtime_put_autosuspend() that trigge=
rs
> > > > us to use the RPM_AUTO flag for rpm_suspend(). For example, just
> > > > calling pm_runtime_put() has the similar effect.
> > >
> > > To be honest, I'm lost there. pm_runtime_put() calls
> > > __pm_runtime_idle(RPM_GET_PUT | RPM_ASYNC), while
> > > pm_runtime_put_autosuspend() calls __pm_runtime_suspend(RPM_GET_PUT |
> > > RPM_ASYNC | RPM_AUTO).
> >
> > __pm_runtime_idle() ends up calling rpm_idle(), which may call
> > rpm_suspend() - if it succeeds to idle the device. In that case, it
> > tags on the RPM_AUTO flag in the call to rpm_suspend(). Quite similar
> > to what is happening when calling pm_runtime_put_autosuspend().
>
> Right.
>
> For almost everybody, except for a small bunch of drivers that
> actually have a .runtime_idle() callback, pm_runtime_put() is
> literally equivalent to pm_runtime_put_autosuspend().
>
> So really the question is why anyone who doesn't provide a
> .runtime_idle() callback bothers with using this special
> pm_runtime_put_autosuspend() thing, which really means "do a
> runtime_put(), but skip my .runtime_idle() callback".

My guess is that it's in most cases a legacy pattern that is being
followed. Also note that rpm_idle() didn't "always" tag on the
RPM_AUTO flag, even if it's quite a while ago (2013) since we added
it.

Unless there is some actual optimization involved, as it also allows
us to skip calling rpm_idle() and go directly for rpm_suspend().

>
> > >
> > > >
> > > > Moreover, it's similar for pm_runtime_mark_last_busy(), it's called
> > > > during rpm_resume() too, for example. So why bother about having
> > > > "mark_last_busy" in the new name too.
> > > >
> > > > That said, my suggestion is simply "pm_runtime_put_suspend".
> > >
> > > Can we do even better, and make pm_runtime_put() to handle autosuspen=
d
> > > automatically when autosuspend is enabled ?
> >
> > As stated above, this is already the case.
>
> What really is needed appears to be a combination of
> pm_runtime_mark_last_busy() with pm_runtime_put().

This makes sense to me too, but I don't think we should limit it to this.

Making pm_runtime_put_autosuspend (or if the name
"pm_runtime_put_suspend" is better?) to do the similar thing, is
probably a good idea too. At least in my opinion.

>
> Granted, pm_runtime_put() could do the pm_runtime_mark_last_busy()
> thing automatically if autosuspend is enabled and the only consequence
> of it might be delaying a suspend of the device until its autosuspend
> timer expires, which should not be a problem in the vast majority of
> cases.

Right.

I guess we should expect the *sync* variants to be used, if the timer
really needs to be overridden.

Kind regards
Uffe

