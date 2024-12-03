Return-Path: <netdev+bounces-148685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7CA9E2D92
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B9E2832D9
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B0A1F75AB;
	Tue,  3 Dec 2024 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JXszHkTk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C727205E31
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259060; cv=none; b=J7UUbApFcqPTOAmz9vUkh7Dgx0NVi4t4ADZe2NoGD8/UFsRUJXLhwLnbXkdXmStF+yfuZo03zzVvKgQt5of5cRlMW6XxtCCRF1qH6hfTKtS9WwH3Ky/ECnuQ2Agz4edy/YorETL/RGuZZMGx3egqC+GZhquwbaZMuFeMyX76MyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259060; c=relaxed/simple;
	bh=0jrgZwpKPRjGzlJxUIaUnijR+xRE5akyKtN5kB7pdgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ty8m4yeWyu9AyUaDo17iWKzRS8k4F14CG+Y78TH7YStiBqfaRjXTGoIzeAuGcUVPUYU/v2ABdZsUKykpq9raAB/dphdG4y6G/VhImZanDiFbizmbu67IaxHjiVGg/ERPwQ7jZTnMwrgnHdVGAdr2bwqov/DLEfhySCZViKe7Bbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JXszHkTk; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6eeb31b10ceso52490757b3.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 12:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733259057; x=1733863857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/umpvWZPnDmrSAxJLv/ctlpcerObMggE3HlXzf7jLg=;
        b=JXszHkTkDIHSdz/aHS58uBCT1AwH3pKHPPUPKOSqeT7W7iEN5FOpQP1GNXhy3mivxm
         MIP9a7ZFBF/UumDV/Yy1PRjBGInVxKtE99iM6WB5dbPclnJRzHcNdHqV0uovdqxO7uAA
         rzydGzet1GmhKZGKCkMEtyXHiLJuOsuBhNt7id9rzeLSPCBIO2oaqdcYxy2FkgXhLJCu
         nDNi/YREFncRHszMoBNeyGq7eZg4tpUKu/H51GxzlcGSsJ5SjLwgkim8MV4K3O2wvauJ
         Uf3owSTpyScHAaq203618Lyx3s2hc0n5/r92ULGqW1GFuX80XgethUztOpF9CS6BLQsj
         EqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259057; x=1733863857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/umpvWZPnDmrSAxJLv/ctlpcerObMggE3HlXzf7jLg=;
        b=f0YlWPFdXSkqADmOXAWAK7hQie4kPU9FgEj9FpuZJpixHSUhQN/PCxEaO8xlYwoWpv
         kFirqANBAxX6nW8EUQuYyFtDye2xa+kRgPEax2BHu5yCgtbTtUL5zw30/lfspx3di02+
         yA+T8Wxp43v5pOVqmaFKhVcDUsvioHyYtXczOSPJOu/UmSiTYo1sSlasp1f1X1b3ucLs
         NyT98o2iSsN5mSdHV7H9TkkMLOz92/RnGZQ5BrqdoHfjNorEGsMYDMIMmHDr5/mQWE3G
         R+cUA48h5oHlOWVNb3sLZpWQPMWJaTEjO73RMkAI4t9EMrgiJ3sTcv9c5T7lc2HVgb4L
         mKLw==
X-Forwarded-Encrypted: i=1; AJvYcCVv9AhvGUOBF15rnUUQpR/OjuFauMFZ5iIdB36hrJ3z02OHbwZjxRGJ6QbxnuhgzauE5HAheUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXxwk+LL7fT4Kdt7ysdeS2yEKEi8F+FoEv0zjVEzFFyGDJuKvk
	y626vZa18eQH5t0P6tdXZfxqUAo7Que8YmIdQp55r5EWj4flP2yIp2zrNGonCAV0uBL5/ZLzT0Z
	a17/hlfo+7YwdZS0Z48DGxNkYchQkFMqyA/CtJj4QTAtKppg=
X-Gm-Gg: ASbGncviBAU7JXeWL4IR36Eas9oAd0l71xiUy12sf6i8mTDqHxcczsMZaoEooUkPH6a
	dT1kYpgX2aKesBW9d75JwbQKDXHYHTw==
X-Google-Smtp-Source: AGHT+IETyrPn+qxpgNa2zd4Zu/tXJRKTNJh3mXdNJVuHLjp9T9+PvrVxCQJU1B/HIq28nlX/Sl8ivZYRSJyiga6LujA=
X-Received: by 2002:a05:6902:260b:b0:e39:9f40:7a85 with SMTP id
 3f1490d57ef6-e39de281957mr1629188276.42.1733259057201; Tue, 03 Dec 2024
 12:50:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126145911.4187198-1-edumazet@google.com> <173300343374.2487269.7082262124805020262.git-patchwork-notify@kernel.org>
In-Reply-To: <173300343374.2487269.7082262124805020262.git-patchwork-notify@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 15:50:46 -0500
Message-ID: <CAHC9VhQFEsPfAZ2MLw7mB7xwOFHPA+TXf9fv9JQDMEFfsZDWJQ@mail.gmail.com>
Subject: Re: [PATCH net] selinux: use sk_to_full_sk() in selinux_ip_output()
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+2d9f5f948c31dcb7745e@syzkaller.appspotmail.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	kuniyu@amazon.com, brianvv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 4:50=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:

Jakub, do you know when we can expect to see this sent up to Linus?

> On Tue, 26 Nov 2024 14:59:11 +0000 you wrote:
> > In blamed commit, TCP started to attach timewait sockets to
> > some skbs.
> >
> > syzbot reported that selinux_ip_output() was not expecting them yet.
> >
> > Note that using sk_to_full_sk() is still allowing the
> > following sk_listener() check to work as before.
> >
> > [...]
>
> Here is the summary with links:
>   - [net] selinux: use sk_to_full_sk() in selinux_ip_output()
>     https://git.kernel.org/netdev/net/c/eedcad2f2a37
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

--=20
paul-moore.com

