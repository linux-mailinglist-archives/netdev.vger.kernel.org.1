Return-Path: <netdev+bounces-77309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88500871372
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 03:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DE91C224B7
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 02:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29168182BD;
	Tue,  5 Mar 2024 02:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGjt6YWO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641071805E
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 02:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604856; cv=none; b=eG1h2DI+9mPPfRVhZVxh2pQmyGYboMOf0bcx5l6yhorRHsjWKCT4iVShty88xucJ6KMt6aNxzlUb01x58lTRBhiH4boqwaXV7LMZxAQAa3UTBo0gsVxhl5MIZXeceXK1QWDajOIoYhCv87M5augju/GEPNRoxDDr6u7yjRaiFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604856; c=relaxed/simple;
	bh=IGZRWDazN2zylhLDLaR1zEMQEzaAe/lNYzTbi9dGg5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svvKFsbyMAaY1gCmCL+LeX6FHy1Riv74kAaVk8G20C8hzzDe9+SBExoupWlStk/Wi4GDxGF9Ma03DY1ksqoQT8JCOFqOOkAN3XWlNLaR+I8CzJfHl/WhpRSqTty5tj1m83j7EC4Fb0E1rM4dwWd3GnJ4GnwSDhvEsAHujxi/xjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGjt6YWO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso6323966a12.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 18:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709604853; x=1710209653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5OaE1yAPnXFqd9/rVrso6AMB2uzPejdz81y+lu6U9Y=;
        b=hGjt6YWOrInDuoC8Wo1vU3Ig7vmwbNVSwlMBuSdDxIDcvFAfBbaahato0TJn/vQ/x+
         PmCNVNA27BynSyBYZCJ73R+TPjabjwVKE7BKAjRLKhumQYu414viItljoR/FBq/+fZ3I
         xo0gpoy6MzTL8rMjvRbjLfRgdpjpC79VfqJ7ULyyMhvoBykBxCoirZWo6+Tm/UkaEex7
         RRu5f1mLcOxTwwZjYRmONvoOBgCEx0udFDgyHbJ3JhMEWrlof8E0NTmy1TN90cP9oPWA
         BzQ/V2awqPiqVkj50XKE9q1SiW97bGKMTqs/RGo+Jm8MkY/wNGN1WT6xEXN6Fx9l5fbx
         N38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709604853; x=1710209653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5OaE1yAPnXFqd9/rVrso6AMB2uzPejdz81y+lu6U9Y=;
        b=AklpnQ/i0mqnpxSn2EAF8BTeqtAV1pWce/EEyjG3CaXnox2LX3oedbsdJu2DSUkmxU
         hEiG8coGjjKzVSvNeU/b2fmjTNgY/insux0p4ahTGkuSqM3r77f31SSdR7g2hzM4qERi
         VjXXzqPM/nWyXZeTOHEZQbpbUp++dYpCYTK20j7UfsKWmz6APC25K+N58b9SxaHQuyDw
         7yvSpFS25ITrinUQN47G77FmAPdE95XJ9X0ranioIdsSli+PSHc0GaBeSnoLMcvG5t5P
         9lcc14A7XwczGXRZ6JQstbd0rZ4OERwcooXbdfee3uLBprkShroCrx/fiDdL/sbo3sNZ
         iJag==
X-Forwarded-Encrypted: i=1; AJvYcCVWxTEnfDMnBLMY5MWVOqQEo3OMel+xXbswcv0BiYi5YGXjEH2hGC1bzhhrzPiaZdk2LJ6LayzJY1yNe1hOj/nKQZb0gTqm
X-Gm-Message-State: AOJu0YwzqNf4sL44HLoTGbYvr59qrWHGEIMICs0aD3e1AKTtsG+XmjFf
	dEQo3fycLGzluj6oU7IUNnvAy8hvQ+g808Pi9+Acn9sg9dNRAH2sKiNiD559/RGurG2DX5vxvP/
	ZiSDEFNvVtwBFMgETW2fXi7KhwRjOgMTwftZ6
X-Google-Smtp-Source: AGHT+IGg9U7IbxKRNfI2fcyJJ9fkxcYFv9013ElhjEX5PDmjOmQ1/lJ8GjkyLCdPWUWtvlGnjOJvqqtv0CIc4nhukgM=
X-Received: by 2002:a17:906:711a:b0:a44:8fa9:d36f with SMTP id
 x26-20020a170906711a00b00a448fa9d36fmr7346866ejj.41.1709604852487; Mon, 04
 Mar 2024 18:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229212236.3152897-1-ziweixiao@google.com> <170954702808.29163.14572409164565217897.git-patchwork-notify@kernel.org>
In-Reply-To: <170954702808.29163.14572409164565217897.git-patchwork-notify@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 4 Mar 2024 18:13:58 -0800
Message-ID: <CAHS8izNC9-ZD-tn+FWK_uEc=50pKw3WEQosBBDg+LWxBgfy4Kw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] gve: Add header split support
To: patchwork-bot+netdevbpf@kernel.org
Cc: Ziwei Xiao <ziweixiao@google.com>, netdev@vger.kernel.org, jeroendb@google.com, 
	pkaligineedi@google.com, shailend@google.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	rushilg@google.com, jfraker@google.com, jrkim@google.com, 
	hramamurthy@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:10=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
>
> On Thu, 29 Feb 2024 13:22:33 -0800 you wrote:
> > Currently, the ethtool's ringparam has added a new field tcp-data-split
> > for enabling and disabling header split. These three patches will
> > utilize that ethtool flag to support header split in GVE driver.
> >
> > Jeroen de Borst (3):
> >   gve: Add header split device option
> >   gve: Add header split data path
> >   gve: Add header split ethtool stats
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next,1/3] gve: Add header split device option
>     https://git.kernel.org/netdev/net-next/c/0b43cf527d1d
>   - [net-next,2/3] gve: Add header split data path
>     https://git.kernel.org/netdev/net-next/c/5e37d8254e7f
>   - [net-next,3/3] gve: Add header split ethtool stats
>     https://git.kernel.org/netdev/net-next/c/056a70924a02
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>

The patches have already been merged so it probably doesn't matter,
but FWIW I was able to rebase my changes on top of these and test with
devmem TCP and everything looks fine. So, for what it's worth:

Tested-by: Mina Almasry <almasrymina@google.com>

Thanks Ziwei!

--=20
Thanks,
Mina

