Return-Path: <netdev+bounces-131622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A47198F0DF
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB032B20C1B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4079B186E40;
	Thu,  3 Oct 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6DaANjP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90B13D245;
	Thu,  3 Oct 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963834; cv=none; b=jFf/aXPcCRDrG275XPDbPRY7SJ9h23G843Bj2UGBFgSGY63Pw464vtXFyYqaYYKgriRBxGFRZYYZ/IddxcB4W85jYwCbgihAviAiO72Tqo+PUmQmXVWE4p1QOsypfoZiTCthK4cIdIzeAYxqD5Rjrpc6+GEqDRNnZzwYmu6TA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963834; c=relaxed/simple;
	bh=5+7E/v+NBFcStoxwEGfB5ErtrU1EjG11vFev0zwN4cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNjEhDdYpcS/sXokrq90AzvnP/AkXINTKTExuccYdrOOAK1uoBivNOMCTOpVgmH3gVxiY5i5GiEWRcxnVYbppU8qQvMhQB0Pa32CnMnb7f3sFG+pDxaFbSJHEQ1rRcNLjblXxfp2y3Tr6xEDN1YG7bfniA5cB+BylQsLizsQQyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6DaANjP; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9ab721058so171877085a.1;
        Thu, 03 Oct 2024 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727963831; x=1728568631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+7E/v+NBFcStoxwEGfB5ErtrU1EjG11vFev0zwN4cI=;
        b=O6DaANjP+fSjxyuoznFvu52qflZfL2Mva/R2CJAsHRSkyvLe/lzGwW0v3Urfq+WTfC
         rW0prEzOoXl4e0w8g7bjGbuAooBMFMIaR4SN50Oad4Brxuqm1CpRQIDMX3UE7hPJ2vv3
         79mCnOarvTKvK6HEh592xJtFYhuuCwbBI99fiq+tXsQT6lTADi525oQ01tM73bvcbX/N
         ttVB2cgK5l4VTNNQJ1jVTo/Nhm15uCLMSosRkXiYiBsjDzDbf8Fwz9WWb3xTrjZdiOcZ
         JxotINGOuru07kf7oVRRmXTs/9nO38/toBVpz0hsjhDB/j1Z/IvagLeklhaLAVIPdnoc
         v4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727963831; x=1728568631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+7E/v+NBFcStoxwEGfB5ErtrU1EjG11vFev0zwN4cI=;
        b=FNJbMc6h1AdOA/6ODQ/TzR/lQ/HCd8mFSaFst6BpVO6QNQE25sT5OnpUCdf3Tf8TkO
         YxjTIuk5DjchOTWb3seHXGs+7ZbPgdKLyw6M/ozSUt97Rylvi3Y4bMAleNnSaewiyhAJ
         aSr+xGTXi1rad0bAYCcbWTEmkP/ilgEMLfWAYlVcD9yhYGBUsYqdHojv/+kpdAx3itTy
         /xWUhU6jqITGYePjsR0DD4Frm1DYUuG5RqZ4UoWSznr+lgGDDXUdLxAJXoRxDoouKOxe
         N2Fd6tgtakevLfImprr447/+kgG6IGy9mIvqTAsXJ3YRWkv5jdNXW6Apx3Qb/F1b52Tw
         +A3w==
X-Forwarded-Encrypted: i=1; AJvYcCUCsTgX1APIk1G2D3cs4NHItZKoribnd8H/WNx8t+H+sFmQowwZqNf6bKemwImtGPeQmgFBQLR/@vger.kernel.org, AJvYcCXVmh9K7plyayTaTE9sSbH1DJ43HYQ4BLoamvNq4JVZ09L9mbWyKpvO81Y5lPCy0IgaNpoX6hrEcnEEFR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ9S9kWu/s3w539EGg4JSU+vD73PFXPcq9Cpx7VSO1v2cPyBXB
	2cXRmZFkn3QBmCguNZuHt79x7YPKdr/lJrXhMQEvEHxXl9stKlxCeH446568YanRh4w4SzGKQqM
	dTCAX4kqw9AStV9veB4id/GzcRWQ0soBM
X-Google-Smtp-Source: AGHT+IFCbMVVGIGq73P4Y/QNwLIkzCTAGy8/AdgmUOrEHiZEuXxYZzqp+S9vDI1+VqUzSAWzBUEoQC7SwTM9Zxy8P/4=
X-Received: by 2002:a05:6214:234b:b0:6cb:29fe:f5bc with SMTP id
 6a1803df08f44-6cb901688fbmr50859226d6.17.1727963831510; Thu, 03 Oct 2024
 06:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001193352.151102-1-yyyynoom@gmail.com> <CAAjsZQx1NFdx8HyBmDqDxQbUvcxbaag5y-ft+feWLgQeb1Qfdw@mail.gmail.com>
 <CANn89i+aHZWGqWjCQXacRV4SBGXJvyEVeNcZb7LA0rCwifQH2w@mail.gmail.com>
In-Reply-To: <CANn89i+aHZWGqWjCQXacRV4SBGXJvyEVeNcZb7LA0rCwifQH2w@mail.gmail.com>
From: Moon Yeounsu <yyyynoom@gmail.com>
Date: Thu, 3 Oct 2024 22:56:59 +0900
Message-ID: <CAAjsZQxEKLZd-fQdRiu68uX6Kg4opW4wsQRaLcKyfnQ+UyO+vw@mail.gmail.com>
Subject: Re: [PATCH net] net: add inline annotation to fix the build warning
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux@weissschuh.net, j.granados@samsung.com, judyhsiao@chromium.org, 
	James.Z.Li@dell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 11:41=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Oct 2, 2024 at 3:47=E2=80=AFPM Moon Yeounsu <yyyynoom@gmail.com> =
wrote:
> >
> > Moon is stupid. He doesn't understand what's going on. It makes me upse=
t.
> >
> > https://lore.kernel.org/netdev/20240919145609.GF1571683@kernel.org/
> >
> > Simon did the best effort for him, but he didn't remember that.
> >
> > Please don't reply to this careless patch.
> >
> > Replies to me to remember all the maintainer's dedication and thoughtfu=
lness and to take this to heart.
> >
> > Before I send the patch, I'll check it again and again. And fix the sub=
ject `net` to `net-next`.
> >
> > I'm very very disappointed to myself :(
>
> LOCKDEP is more powerful than sparse, I would not bother with this at all=
.

Totally agree with that. `Sparse` has a lot of problems derived from its na=
ture.
And It is too annoying to silence the warning message. I know that
this patch just fixes for a fix. (What a trivial?)
But, even though `LOCKDEP` is more powerful than `Sparse`, that can't
be the reason to ignore the warning message.

It is only my opinion and this topic may be outside of the net
subsystem. Please don't be offended by my words and ignorance. I don't
want to make a problem, rather want to fix a problem.
If there's no reason to use `Sparse`, then, how about just removing it
from the kernel? If It can't, we have to make Sparse more useful at
least make to have to care about this warning message.

> LOCKDEP is more powerful than sparse, I would not bother with this at all=
.

Leastways, This sentence is irrational in my view. Let me know, world!

