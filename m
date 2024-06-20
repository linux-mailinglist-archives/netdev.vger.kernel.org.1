Return-Path: <netdev+bounces-105350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B642F910903
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C321C20C5F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEC41AED21;
	Thu, 20 Jun 2024 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mj4qRAQJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E6A1AE87B
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895180; cv=none; b=XsMfDQgFpLVIPxyNN4x3o7i18Yxch/D8W/NSuNOwjnNySStJx6SsLQTWAYNUuKsy4h0EFhGnEt5xaS48WcPTxaFWCtIf30baL8eapobcUCpGYrW+ULIf3vnMkdqJ9kw6+z2s9+fzvpchVZVj+g/+OY3sZ0MyOR7Gq+u5CFm56s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895180; c=relaxed/simple;
	bh=cOjlLG7J6uNFSBufcYc1U6uO2TdqNqn9wVWkYk95jjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7C8HzC5mD/wIZ2qI6aN01+Z7eGs2nwfHHJm1u53RraXt+XWwSFzE4bujkKp3W9pcli6g86mBHB7zXHZqAiC78ozveIE7pcE3vzS4FS/LhjgpdpkXyFb8XccnTa+9BJluQHrzOWGlyrIzMDHfNh0Szu9lDUO245aASnWcQpa0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mj4qRAQJ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-63bce128c70so8106777b3.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718895178; x=1719499978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCNEYn05yS9gykrfyaJDjrazGTz47gbZUOuJaEqz7AQ=;
        b=Mj4qRAQJ2Wx5lLhhpLxAQFkU3cYGQB2F6Hum+kp+9EhQTIRbkIt6eMTyMUPKeaqnTv
         0Dd0hxRQpRJ0ayAaZFEWNqJKf+v+6czaYyhkSKePJBD0erUSKj5ENB5otFFOMYnxeMTe
         SxsMkigkfuVbHFswgLVP+91M9n89kGcDi3MgN3vUwqm0jho665jzA2zxEX2BaEv8IHNs
         Kn5QkS2DFyISLU8KfPYx9lBxByYvfdPwEmqU04PjFL0Cff4CWv4/dGZPlacA0zVoEvbo
         hxH51qFUSAlIbgWay8sdMtxzKzyPFt3ZWMb3kdp53iz8E1C1O1hdYmAe2kgxN/TSMXlO
         En0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895178; x=1719499978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCNEYn05yS9gykrfyaJDjrazGTz47gbZUOuJaEqz7AQ=;
        b=KkKUlb/L4aWIJWOO+lRLGPjETCKLBkWyQw2rLSoo312sLa99hDJcFns15XxphO3DLu
         c0e7iHSR74JvvX1qE1mByauFCtEpkMfkQwV8q1wihot8mFnX1XtoLox1bhu2mMq2pG0W
         aOp56m2VzGTTr0qP/JIaJCayC4ptu766l7YVpJIX0BSvnXnhFttMUzKe4ZPQGrHhvzzV
         Yjw0lXFotM7w8fBIv6qQ/1yAi6gvMH9auePfRoOolg16Q/bMAJ9HGPSDkg+eDgUEphT3
         6pm77J70y/RrgD+FOxdkcUh8XiPvdJ6FHeJGbat/SnfdnxWTJWIPUmFNlSSPNDSvpzgT
         0DRg==
X-Forwarded-Encrypted: i=1; AJvYcCWnTXY611Ot+AIP1RzNYTysXrsMItjq027DX+vJoz+PtJu05jOmBAp9e4AEmYC4vGgW29f2GWQCk6jZ6M3WSbadfBZ4fgiT
X-Gm-Message-State: AOJu0YzJaoaadT/MaLA99tGOJ7naa+NnbYIiX/5GwDC4n1lLjI17A2HA
	W6knctHaRWkyD1cbpWlByLe/j9TzYI1CYSvGE1j0n69SE9x+jIrTOQGYnhcWApm7ZucmTy1QLj3
	SGbFgpwZvkZLd78Iu/mVSibFF1FE/N30pz5gVOg==
X-Google-Smtp-Source: AGHT+IF40pdsLHGJGXsUitmodarquEe+C+A7BtlyIVzKzW3fRxNf20I0BvEb3GK+3HmTvwvssyu3em+pUpOJ1efXyLE=
X-Received: by 2002:a81:e30d:0:b0:61b:e61e:8988 with SMTP id
 00721157ae682-63949fecfc4mr58602707b3.18.1718895177927; Thu, 20 Jun 2024
 07:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612075829.18241-1-brgl@bgdev.pl> <171889385052.4585.15983645082672209436.git-patchwork-notify@kernel.org>
 <8d6af7e2-76f8-4daa-a751-a1abe29af103@kernel.org> <CABBYNZJ5z91HExR-dkwrEPoF1pEGbkAP0X6tpftEGz-kd7vdsw@mail.gmail.com>
In-Reply-To: <CABBYNZJ5z91HExR-dkwrEPoF1pEGbkAP0X6tpftEGz-kd7vdsw@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 20 Jun 2024 16:52:46 +0200
Message-ID: <CACMJSevy9w9L3c9fmbZcwO2BdmtJiQmHBTqJSiSXUs-fcmEqAQ@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable tag between the Bluetooth and pwrseq
 branches for v6.11-rc1
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, patchwork-bot+bluetooth@kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, marcel@holtmann.org, krzk+dt@kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Jun 2024 at 16:44, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Krzysztof,
>
> On Thu, Jun 20, 2024 at 10:35=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> >
> > On 20/06/2024 16:30, patchwork-bot+bluetooth@kernel.org wrote:
> > > Hello:
> > >
> > > This pull request was applied to bluetooth/bluetooth-next.git (master=
)
> > > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> > >
> > > On Wed, 12 Jun 2024 09:58:29 +0200 you wrote:
> > >> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >>
> > >> Hi Marcel, Luiz,
> > >>
> > >> Please pull the following power sequencing changes into the Bluetoot=
h tree
> > >> before applying the hci_qca patches I sent separately.
> > >>
> > >> [...]
> > >
> > > Here is the summary with links:
> > >   - [GIT,PULL] Immutable tag between the Bluetooth and pwrseq branche=
s for v6.11-rc1
> > >     https://git.kernel.org/bluetooth/bluetooth-next/c/4c318a2187f8
> >
> >
> > Luiz,
> >
> > This pulls looks wrong. Are you sure you have correct base? The diffsta=
t
> > suggests you are merging into rc2, not rc3. This will be confusing in
> > merge commit. It is much safer, including possible feedback from Linus,
> > if you use exactly the same base.
>
> So you are saying I need to rebase? I usually only rebase when it
> comes the time to do a pull-request using net-next as a base since
> that is where bluetooth-next normally lands.
>

Technically you're all set - you pulled rc3 together with my tag. But
if you pulled rc3 separately and then my tag, the merge commit for the
latter would look much cleaner.

And for the record: you don't need to rebase anything. Does net-next
require you to? That would be weird. I assume they also are based on
one of the RC tags. You almost never should rebase on top of an rc,
instead you merge it into your branch and send the PR starting from
the latest rc tag. Git is smart and will figure it out. You may be
afraid you'll "lose" some commits because you will not see it in the
immediate git log. That's true, they will be buried underneath the
pile of Merge commits from upstream, but worry not: git will always
find all commits missing from upstream when you do `git request-pull`.

Bart

> > Best regards,
> > Krzysztof
> >
>
>
> --
> Luiz Augusto von Dentz

