Return-Path: <netdev+bounces-158243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E7CA1138F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED261889FB6
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18648212B0B;
	Tue, 14 Jan 2025 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVpZU2/d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D38211278
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736891968; cv=none; b=YLwN70CLnCB/mFjCqJ0VmYhVUAO9++RbvjPPmdo3Ii3RkI8aObZxxihqv9hCeMSqBEp97puU/XclkoFROKafIoRzMwLxIPRf6IOqRG1hveZzzI08HSrb0Vvw4v7kUTON/hetD78auXhNtucS05EO7x0suqb7e/F7T3awrd09rJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736891968; c=relaxed/simple;
	bh=zAdJhi0EI4DSgCLvkfLMz61d8vkKWIg/klTwTYfDWFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVZF2J3dskzVU8AmTotDRmsiqtfWtE0WLT39JYt5+GVQYkRtHZZs6cUffGC4ZujZ8E+R5g3Uk2EjJ/YpCQwbPuKaicLpncV1VE4s2R3gxh8w8A+opuOaMC6TnN7KQr8JY/W80ohGl72KKI/dYhWzRGAN6qXizubYeCkdsLOCbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVpZU2/d; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so11865899a12.2
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736891964; x=1737496764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WjjekFXncfCFBue3MsiK/kEiypPJdZR/OHfV73Kcms=;
        b=wVpZU2/dEUyhoBZez+DiNlvriByrb75WYNLTp7I+ANfCM9e4DpeEhK/D6LEIwuLv14
         KbZAhLKjvyZjmuHsKQkaVSN3m9MyZD3cWsaumz3/5XPLxluG0YZYNOfIfwCgSMpi96sX
         KQGghzF+Apl0xPG3/oDuXHekYkdvq4ItR0PSOaZmgpFx1vBWp0yEHG21Xe38S3zfjAKz
         0s/S2NId4UPG7+fJFyW4qnQ3ClCQrs6gO8cdnQw2IVMv5Xfm5ll+UoZVhWUULeSQHbfY
         CazPqG4vgJ+7vk2Xm5xft31J96Pp4oxDPFyTSdr4v2nIMd55XpYupE6YRmSD2GehAlmr
         kQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736891964; x=1737496764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WjjekFXncfCFBue3MsiK/kEiypPJdZR/OHfV73Kcms=;
        b=vQsY76mYk2E0iF6Dq8MQIjvwBXNohi+FSc6nMi6llmdDrJ2xEHXV0Vu7ZVDBwfdcVc
         DS8+PzD3h73DcRNTq3NUfmn5LXyfpfqxIVJDOdgrKQyAFR6PPGv7xBK0j0KG12T7g34S
         irXZVa0LikDLD8m0DcsmR+QmniWi5a/Y0ihqZ3zWfzI1CVHcPAmVznTzt6nIhVOm5TZk
         N9c8KMIoCiRoX3P49h80ucHeSqHCo+0uoTILDv3aMektpZVdqtyujmdf40uhRso1UGtZ
         jpR92KHfrgf0NY015H9QZiJZLpGmE2wRaa3t7KsCuPwixgmd7L4s88VUr7/7D5x1HlLd
         TVEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe3QjZhQXuKmMPq098vkZkdO+ilFlR9UO4zNDR7K1moW4r0yxzmQM77rHQxFKJtZmGKIyuddQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJdDWb0Frz5naRTivwBolB0JMaWPGHqFjSdTyaLjreJKb3/8V
	5fbp1JMBnON+sA2RpcCYTgxfQ4WrOfkMjNGYcYPAw3zWa2kflRhSEAehxOeg3xa3gCoLKDav+Zl
	/XUWKMYcinKdlg/B2nTxE0n/XUt6CUOjR+U4F
X-Gm-Gg: ASbGncv99ubboTC1HPPQPSGmDU2KHuPxj1VWrhIdilulL+EYMZtotNaLWFaXu1mnhwK
	JxltCZB+jllTS1ngLqVYkyJhX/gvCpclYyKWaTQ==
X-Google-Smtp-Source: AGHT+IHO/D5nGE0bNMT49v4j047gGPPXUv4kVtDIzDxc/DxZMriA7ICnz2tGGjwyolTyapLUqfQZ1/0wB17Ymu5m6z0=
X-Received: by 2002:a05:6402:538d:b0:5d3:d7ae:a893 with SMTP id
 4fb4d7f45d1cf-5d972e48691mr23734588a12.25.1736891964471; Tue, 14 Jan 2025
 13:59:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113171509.3491883-1-edumazet@google.com> <20250114133648.36702172@kernel.org>
In-Reply-To: <20250114133648.36702172@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jan 2025 22:59:13 +0100
X-Gm-Features: AbW1kvZU_26wk6DItbf6sCy7t-sz0xkO0wdiwzmIeeeSYmWT8kfwnA5NVXu4xWI
Message-ID: <CANn89i+G_GfMCYwbYEq7+XHbqjxPWDrA9dRJ35pTQji1xuB+Rw@mail.gmail.com>
Subject: Re: [PATCH net-next] inet: ipmr: fix data-races
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 10:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 13 Jan 2025 17:15:09 +0000 Eric Dumazet wrote:
> > Following fields of 'struct mr_mfc' can be updated
> > concurrently (no lock protection) from ip_mr_forward()
> > and ip6_mr_forward()
> >
> > - bytes
> > - pkt
> > - wrong_if
> > - lastuse
> >
> > They also can be read from other functions.
> >
> > Convert bytes, pkt and wrong_if to atomic_long_t,
> > and use READ_ONCE()/WRITE_ONCE() for lastuse.
>
> Drivers poke into this:
>
> drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c:1006:43: error: invalid=
 operands to binary !=3D (have =E2=80=98atomic_long_t=E2=80=99 {aka =E2=80=
=98atomic64_t=E2=80=99} and =E2=80=98u64=E2=80=99 {aka =E2=80=98long long u=
nsigned int=E2=80=99})
> + 1006 |         if (mr_route->mfc->mfc_un.res.pkt !=3D packets)
> +      |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^~
> +      |                                      |
> +      |                                      atomic_long_t {aka atomic64=
_t}

Oops, oh well, thanks, I will send a V2.

