Return-Path: <netdev+bounces-213670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E53DBB262DC
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C47188CD47
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DE52F39D5;
	Thu, 14 Aug 2025 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2Qo/JnH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A62F39A0;
	Thu, 14 Aug 2025 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167568; cv=none; b=L7PrcjFeltAtiI+o9VOzCOmI66caRevVc2H8Hc6iJXO6NUIO7XPXpcKxkHHgNt+uvwukE7EN6h/ef5yyGaj/Oy3CT1jws/iDx7VQRi1+TO4k7GFWpVaQ1DKFvfz964giQCW7hGi0yoLb+wPrrIPUk7Cda3+OSY7VTbA7+wUNQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167568; c=relaxed/simple;
	bh=CYzbKVOF/TPdEmZ8s/gMlGCZBSnCGBFSN85mnNON29o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRX6X6jzZZgAhPaau5dEYQ2y/Yyi2kqFcGwu9rd2VM0VF/iy/pbZ1aIGBSIuSuoUXp+VKaONVBJkTFfGPbsAEY/MvtnX6Uu0R89Y0N3RDAuvJ5WAMrTt6xHyyh89n/nRL2R3bfS5SObXQwywhuKF7UkFyg6uWTVi6ItfZvOw/Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2Qo/JnH; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109bedc38so150231cf.2;
        Thu, 14 Aug 2025 03:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755167565; x=1755772365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uidag5GH3rbfp6RvsevZJFZiGLSa9EyuN+ZmrX0Ohk0=;
        b=a2Qo/JnHFNH/HV2PqscLXujDOgzNWzNA+xghTMSzmc8xSFL9dozAsok3LsTQGGCpt+
         ZMUIqNQj2zsqXzs8bm1Edr7bKW3LGsy6G2dhgIydUqIbjpGhj2VbvvT8UU5jM6PMKs/W
         PZgmwpVYfzbCLfYUh+JhyAor9G7VwAubY3UzIK0Rfh5Zs5ZqNOJRJB8jbBjLQ5tuyzOW
         kz/UjFCLFN5XAAo95AGgOQYF2bqn3axF3dBhYvJOw8plwqzhUh1xkCs3ho8KzoitHEiZ
         FYXi3NBZLon68PbaThYRETcwZ5VaP9QmLXh0EQJjyvTvUVlf1DxLEq9J/nV1LsMDeB3C
         GUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167565; x=1755772365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uidag5GH3rbfp6RvsevZJFZiGLSa9EyuN+ZmrX0Ohk0=;
        b=pjQiP+tiOfVFnOJJlgE0yiu6M/PXi7C/gbeLWzGHZ0sMpMbvI/+SqLjmjIFlajMnWH
         pfKA4EK+EM1EHPY1XTqTL7Ux7sAxVo4DGKg8noJZxjAGL/B6d9sU+TfYbaPXT2JJkKdC
         mApMCKmpRNS600an2ZEpfm7it+jES6CpRpSvPYJkxaopr83PLxylFGWZnNAp15vs3BXm
         +dH7pe65amBQfAMKsYzHUxOxB3UmLp0td1Lr3G7VcRaCGB9B5vUopAj3EtJLgAzZm180
         7x+VAGKleRASqEMNjrZFEHwAg7GGjFom46QvRyIaPsODd3ewDf73PmOXO2gGpcik+OE2
         SU3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeRWfsNBeqGtxVKYRoAvbhwwCz/gwql5kzrkE9vN5aI+K35+OE2GFGDrFOrkxfONtrCywV5s4fLsZ0+ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg4cbbT3Pba+j0b8w6lu4axG3qfVP1uvrppfIF9TKysxGF2YS1
	48Oul4QH5SvlJQB2B9sYprDsK28XUTmU/T70z/43JBl+P+AUfEnPaqJLl5Fjw6rZsYABByIb5sj
	v+bjhIsAJ5ahH9cmuaOckHikb4TZxYNA=
X-Gm-Gg: ASbGnctLKUAPE7v3kQm3EJpZPH/gkPPYy41j7AJi2OJWcrUGKoaSrK3mpCvx+tHVLn5
	Pwjy1MAGpX7JQUwCNwpDeLjE57TAAZRLG5KGhMgnOKYd+VowYDoT8HzkwPhXFy1bGZ5K3QCN2ko
	bVnwDvtdzOhkGDLHfVkjggH5XfoG72e2nXdEojrJiTIYl/R3nGTfrnflFBSw54Z6QrgLsMxTkM+
	bvkyA==
X-Google-Smtp-Source: AGHT+IFu31MRahXeNRGXB5OCH9nzb1U/olRrBgEEv0rdSL8Stn8Hl/kczWWsDd0HZkH7R447MArgv+9zbTEYHlkXCT4=
X-Received: by 2002:ac8:5885:0:b0:4ab:6b8c:1a41 with SMTP id
 d75a77b69052e-4b10aa84523mr16219091cf.7.1755167565307; Thu, 14 Aug 2025
 03:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812082244.60240-1-miguelgarciaroman8@gmail.com> <175513140725.3830230.6064788817690151758.git-patchwork-notify@kernel.org>
In-Reply-To: <175513140725.3830230.6064788817690151758.git-patchwork-notify@kernel.org>
From: =?UTF-8?B?TWlndWVsIEdhcmPDrWEgUm9tw6Fu?= <miguelgarciaroman8@gmail.com>
Date: Thu, 14 Aug 2025 12:32:34 +0200
X-Gm-Features: Ac12FXySgBOEXQm53QMc0vwZNeEvULA1MusZ7LbWpESUt9ICaStDDiAZ1RsJJy8
Message-ID: <CABKbRoJDogS-uzy-vott1LHxEPB3tVU4SrBwaagmrhreXxuX9A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tun: replace strcpy with strscpy for ifr_name
To: patchwork-bot+netdevbpf@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El jue, 14 ago 2025 a las 2:29, <patchwork-bot+netdevbpf@kernel.org> escrib=
i=C3=B3:
>
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
Perfect, thanks!
>
> On Tue, 12 Aug 2025 10:22:44 +0200 you wrote:
> > Replace the strcpy() calls that copy the device name into ifr->ifr_name
> > with strscpy() to avoid potential overflows and guarantee NULL terminat=
ion.
> >
> > Destination is ifr->ifr_name (size IFNAMSIZ).
> >
> > Tested in QEMU (BusyBox rootfs):
> >  - Created TUN devices via TUNSETIFF helper
> >  - Set addresses and brought links up
> >  - Verified long interface names are safely truncated (IFNAMSIZ-1)
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next,v2] tun: replace strcpy with strscpy for ifr_name
>     https://git.kernel.org/netdev/net-next/c/a57384110dc6
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>

