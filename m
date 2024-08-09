Return-Path: <netdev+bounces-117224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B12CB94D27C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22411C213E1
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13AC193090;
	Fri,  9 Aug 2024 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnzKiw/O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28193195980;
	Fri,  9 Aug 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214953; cv=none; b=saEiiYC8I3GAmcy9YcoRH2L1hpwwp07X/cooRZu4janHyzvpcDc43AAeJi+a7iO/MeN0J1h0USbq0/99liFLX1gTi5XTu8LINbWUiUYtyysk/NJ/J4HOvSjzp1npqpAYr+7rb18Zbwkr9d/+aqipu/q2mTeiB9PFQ0ZVm0nBfCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214953; c=relaxed/simple;
	bh=vn7LfbjPhATnOujxqUmZwluZtBU3qLpvzFawLfUqrU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbYCrUd1vm1D3vmCx5FAw701yFoKjpRM7DDbRl2Wm4dwl0JhKD9uCYJeZWiDVqpy4DLE26LGq0O3tWdybMSXSu6xqSecbADqnhcFddwlAwn3zq0GVNos2Rz44otQtPtxWLiOA6E3esbfswkeMOBwHfimcaiAeynIzdDMQvTOjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnzKiw/O; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f0271b0ae9so21790151fa.1;
        Fri, 09 Aug 2024 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723214950; x=1723819750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CE9WjafHbNcAarbfWw+lBM4t01a9uasEkOO/YQedVzY=;
        b=PnzKiw/OmjXq0pmmGKSfnsmAyhbtppB6mE/dYO0QJt0LMfI6Wf9xZBKSweoQvp8wJU
         u8WSaYiYdHFQWFyoWWdv6RMXME9ugyLM9p4w83rjvnA86fCFo074IEPrRl9ZQTUwKGO8
         piSKp/UikOwM9lbagexOWOqP8GPojamTF9eFZwaDZ/4i4wLfn4Y6fPdn2FooZYmRkFNI
         vIOXuovUaCKrJCXaQz4x20ohLo7kM1VvwkMaqvLyWtsWc2onzBETXj2QKs+ecRU8cINS
         ghfzzCowFExbxCI7LKFysIWaxSZ5rcJZFFnHX/r5YKwkfAOOiL2c0i4BTb62rfJFhvor
         BDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723214950; x=1723819750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE9WjafHbNcAarbfWw+lBM4t01a9uasEkOO/YQedVzY=;
        b=jNFfZSUpsIH7y6SVAavX4iTTjqzSeWcfaP6TcemWfTAGXI8PyB9Hpl8ophXKZPPSN7
         ZqTDhHGjcjXKsNhhsCXx45iq0ynpJdueomEAYHLSqWF7xlAa4sOrfubHZWagABUwbzX+
         kFvJTJmNrzdV7WaXRM5s/P2743WIHtYynMkCig2H1mITZoJ/UbAwTirRRj3B/GZqEstn
         wzm/tgiE1kGU3lHbO8f2c3Ya9fBxveuNIj9WbVS33/hE/f8mm73OEZnxAfYc1sALBd7h
         d5WvBmA0+hfaYGpD1IMh2WbNvp7qD0aojmyV+vVi02vN9BMUihHs/Jdd/QP4XjyKfbyM
         4pVw==
X-Forwarded-Encrypted: i=1; AJvYcCUCA3IcJgzOKwxrsb3fLOwJcgdBgTpKBTOWxZoY+yGNhDGAOVJfCc35HzedwPxSSk3ssM8DltOs7/6HnYS8K3nJ7oGHrsXY3rUCJrSqK2TPfkdoblpQDPzcF0CVrnDrZLgJvN2fgGlu
X-Gm-Message-State: AOJu0YyeE9tj2KepMEa5FdNDTJv867TJzBIGvAPWfcj18AjlHC5h8p35
	RFRxJ8sACIuI9MhkNJshJaLre1jjMy3r+aencLsWjMch8fp372koikl8hMYa7eDKcVPc3yedp8N
	OzN0Jkz/lqIu22KJEjq+aGqOqAADxIimu
X-Google-Smtp-Source: AGHT+IFZqhLtje5XgnpiqTXNnHVHcvu6hqbGLwt4IP16T8g3vt4Ks5rc+0NKr3pTRE679D+NKxLwoSyJ1e+mflcZxpI=
X-Received: by 2002:a05:651c:551:b0:2ef:2c86:4d45 with SMTP id
 38308e7fff4ca-2f1a6d1d224mr14931431fa.27.1723214949602; Fri, 09 Aug 2024
 07:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807210103.142483-1-luiz.dentz@gmail.com> <172308842863.2761812.8638817331652488290.git-patchwork-notify@kernel.org>
In-Reply-To: <172308842863.2761812.8638817331652488290.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Aug 2024 10:48:56 -0400
Message-ID: <CABBYNZ+ERf+EzzbWSz3nt2Qo2yudktM_wiV5n3PRajaOnEmU=A@mail.gmail.com>
Subject: Re: pull request: bluetooth 2024-07-26
To: patchwork-bot+netdevbpf@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Wed, Aug 7, 2024 at 11:40=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This pull request was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Wed,  7 Aug 2024 17:01:03 -0400 you wrote:
> > The following changes since commit 1ca645a2f74a4290527ae27130c8611391b0=
7dbf:
> >
> >   net: usb: qmi_wwan: add MeiG Smart SRM825L (2024-08-06 19:35:08 -0700=
)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git=
 tags/for-net-2024-08-07
> >
> > [...]
>
> Here is the summary with links:
>   - pull request: bluetooth 2024-07-26
>     https://git.kernel.org/netdev/net/c/b928e7d19dfd
>
> You are awesome, thank you!

Im trying to rebase on top of net-next but Im getting the following error:

In file included from arch/x86/entry/vdso/vgetrandom.c:7:
arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c: In function
=E2=80=98memcpy_and_zero_src=E2=80=99:
arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:18:17: error:
implicit declaration of function =E2=80=98__put_unaligned_t=E2=80=99; did y=
ou mean
=E2=80=98__put_unaligned_le24=E2=80=99? [-Wimplicit-function-declaration]

I tried to google it but got no results, perhaps there is something
wrong with my .config, it used to work just fine but it seems
something had changed.

> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>


--=20
Luiz Augusto von Dentz

