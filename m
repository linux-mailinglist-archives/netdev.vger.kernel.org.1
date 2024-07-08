Return-Path: <netdev+bounces-109756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7952C929DC5
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304971F22727
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D8A38FA1;
	Mon,  8 Jul 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eLi1tjIA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7039F22616
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425381; cv=none; b=lL3bpfvOxd6QjrmIqSpmxFjB2D6fr33ndPgGxGmxOUSh1Qd1dKkbAtZ656PXOK7cU1N7utqP/qQAU860KHfx/SNqDLr0qeiN1wnUDfa2VC9fbjva3DhkmL3+RNjaPP5LeHOWd7UndxlCiLM06MGNDWNKlV0grhVJzoi/1dwgsFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425381; c=relaxed/simple;
	bh=2WNnS5Ed+QgY8ledxMvxGMDxncRSAKKGFHvuKNwZa1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UclZ1XH1I/raZhaWrLLTBZhKMZpQ/rIoU7Sl0oZ5t2118HY3KfmoPfJJ9ryAmALxWFRS+rBCIACB0tzoP43S3LKgIVwLnk4pjU6tGKRteW+8i2Bz3Q8mI5zYdc+nbDzAp6x6QdSxnnfzedrurt03cw3NDEYpE0fM/GjsqH7VSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eLi1tjIA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e9b9fb3dcso4292815e87.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720425379; x=1721030179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cI+b6zZefVxWCDyuwymB94RDj7i623gqz9pEKZZ/HUc=;
        b=eLi1tjIAtKi1USa+ueEXtPIAOdWYFT5sBJznsKBYuzVW9q/hQp5WLa2o4eqecethsy
         oLKWftIMREt4AenslfG8SDn+vxz9xjr058YEG1j2esZ5mGRz36FHLirUklEuXk0aXD0C
         S0mfK+MglpapoTJkG3nqdbDH6CoR12mNuakvr5M3WDlIxIV+pCeEEWpTn6l4KstmWzFD
         X3P6LjOeCgKg+1TaNgQmJ0YVc0z5baj4zwDzGmGlsmiD5KEjbYPlfvzWqwOcm433vnBJ
         2YY3O+4wqR7XtJDNR1cYu42BQOt7kY/CXtr/W0JDAHaf8dY6Ff0UCtljOXr3LkTRb+US
         bKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425379; x=1721030179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cI+b6zZefVxWCDyuwymB94RDj7i623gqz9pEKZZ/HUc=;
        b=ZRSlU9rlv5jomJDZX6Ce0i+1ztu7wh1akFxcjj0cSThnOAq04hPEyGO+Bc0FBfhDvM
         Q7AkhAoX9QkZ5irgskEd4A5GamJKFAvgbQ04VScJBWqOLmY0sVWFTEjeR35OI+8I09Ts
         hyryMHMWUvGuuCzpEh+DVJZqq1Gn03RSvdOKyZmbKm9ZjOTAd+meevLkUhkihS6e3QAC
         oyMkjlpfJLczsf0iRrYUsAx/EqJWl+P8KfN2MvgupmfppYruw3rN0JMSw599yKrQb6j8
         XOsfDUpUMAk2+fd8MmW3Qx9fZ4mLVCBH9by8yT/jeLycVDBQCcCEsERQqegJbizeDpje
         LMEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN9r4jq4f3RhVAO22v0E44sOWvOLwqAQ06Vry9Zmi3lNcdynde3lMluJEjT2AgKwvGgVlmkbckbdqpA7+N3oGsokORRZDH
X-Gm-Message-State: AOJu0YyHkyj6CFpE+U6Rb7scbWAYNa2f9H+N9HWy+2AFkarE1/2U8sA3
	U3H9xP6cg0gLEOtZ96Q/7en2wpmMAlSbABfnZZ+eR01z+UqABFYBAUmyMVH/Z9msI77EqjrCJlU
	6tlUdcbrpBZjewpp6mqsScSwuK0vKntmmpbiwCA==
X-Google-Smtp-Source: AGHT+IGFWc/GiNwCeWCda6P1abEDxOrxu23BHJ4QAAaGmQRRyt/kIGRCRZLijQxssSIvMk9hjQol1uqf4lADD/xlxx0=
X-Received: by 2002:a05:6512:313b:b0:52c:e040:7d9 with SMTP id
 2adb3069b0e04-52ea06e8479mr6931400e87.59.1720425378646; Mon, 08 Jul 2024
 00:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703181132.28374-1-brgl@bgdev.pl> <20240705170440.22a39045@kernel.org>
 <CAMRc=Mc8BxJ+8U3gs1yHX=a3ZFcfqn+Dke6Rz_LcAOeqT3Cjmw@mail.gmail.com> <CAMRc=McHVQ8oRz=dm2Zu39pV49r2QWRg5eiJ-HoqhepYtZXDXw@mail.gmail.com>
In-Reply-To: <CAMRc=McHVQ8oRz=dm2Zu39pV49r2QWRg5eiJ-HoqhepYtZXDXw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 8 Jul 2024 09:56:07 +0200
Message-ID: <CAMRc=McLpG2yfuaEwwdd8+HTJbhKLqE5hqbbyV36SiXWT_+Maw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] net: phy: aquantia: enable support for aqr115c
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 8:26=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> On Sat, Jul 6, 2024 at 7:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> >
> > On Sat, Jul 6, 2024 at 2:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Wed,  3 Jul 2024 20:11:27 +0200 Bartosz Golaszewski wrote:
> > > > [PATCH net-next v3 0/4] net: phy: aquantia: enable support for aqr1=
15c
> > >
> > > Doesn't seem to apply:
> > >
> > > Applying: net: phy: aquantia: rename and export aqr107_wait_reset_com=
plete()
> > > error: patch failed: drivers/net/phy/aquantia/aquantia.h:201
> > > error: drivers/net/phy/aquantia/aquantia.h: patch does not apply
> > > Patch failed at 0001 net: phy: aquantia: rename and export aqr107_wai=
t_reset_complete()
> > > hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patc=
h
> > > hint: When you have resolved this problem, run "git am --continue".
> > > hint: If you prefer to skip this patch, run "git am --skip" instead.
> > > hint: To restore the original branch and stop patching, run "git am -=
-abort".
> > > hint: Disable this message with "git config advice.mergeConflict fals=
e"
> > > --
> > > pw-bot: cr
> >
> > It conflicts with the fix I sent separately to add include guards that
> > I had in my branch as well. I'll resend it.
> >
> > Bart
>
> Actually this conflicts with commit 61578f679378 ("net: phy: aquantia:
> add support for PHY LEDs") that was applied to net-next recently. The
> resolution is trivial - just leave both sides as they are. Can you
> resolve it when applying or do you want a new version after all?
>
> Bart

Nevermind, I resent this version rebased on top of today's net-next.

Bart

