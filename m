Return-Path: <netdev+bounces-127605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3564975DBF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 01:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F24B1F22CAD
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BBA185B6E;
	Wed, 11 Sep 2024 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o25ZVdyC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533431AE845
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726098253; cv=none; b=KzZgZex1nOVTOZKZk642TYYchvIgc689Puws1YWccvLa/rvhS389ZU44QUDfq8bggBpSX1uiuMbDSqkb+rniz0WpLzCPxiH0NIrZE39wKLTPPUSnzz0R34VvAlmXorDCREANLR71IQYAJG+DYbQYDHHVuJopWNAvNGnVq85jVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726098253; c=relaxed/simple;
	bh=TZvKk+aBa1gxaCCHniqOn5LTKrUf552B6WpBkAaylu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LelPykvvAgEX7IS7SqPycLNNmkry0KY8BA0GOG64Rb0eEZ/lYhv+hhgK7TgSU26aZ3nc3E2/q27FkIZeWpp/ufxOair7s7YLvwAijs3eWbeq47cZuvQnGSnVDXIKfcHpB6MO+ZraHt1Ij7YA2J32JmfxMXduMXYnM8ankyuIbWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o25ZVdyC; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso472133e87.2
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 16:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726098248; x=1726703048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jDCB4+Ox2YHS0ikdUG/pV1MDZUz4L9aV0DcLYdAPqA=;
        b=o25ZVdyC/Nw6fG8Jkz0BMK75gkikXD97PuEdgIEdwQ7QF0xlvigbTX5AZyVpItYZcv
         c7dqr3PJPPfmf7CllRzCtnXr7QRZeohoQbqhb3r8foIAx35ZUY7elfFKkEPENELGHxTQ
         HGlvzZ3KNkH61auRTSICwrPoV3r/IZqkeALwnvSTuIWLnyUFjv5I6256HzOZ6Jj2dMiA
         IPrbJ0Y6ZFygEAD3Pe+XrkR1budfT/O65nzRzcdYVMYo4TpRdoEB+AmR7bUY0gZ9khBX
         VJBq9eJR0lfp2C+1QQ3yExlrW3v7H4TWBmVHHYPj/q9FK1dGAh07FPA4oWidUxF4zc/G
         diYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726098248; x=1726703048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jDCB4+Ox2YHS0ikdUG/pV1MDZUz4L9aV0DcLYdAPqA=;
        b=w/P/hsTcoBinSK6ANqz5h0dXxRxdlnZNj07PPJYiqRBQ+zEv3ZZlNWjyAe88tluDVC
         iRC8Y9dMdcvdmWDTNPk9QAEV9QrtKKypMtTvgyC+wzx1u6ucMFZuLGJ08cIan57/GxAA
         K8qrg0S92KWwP/wbXRddlAVeHk8yfZ+416Bi5zqGiO4AYPq51NGci+PPnL/0Zy51iBAH
         LzRAzy9ADznY6V9kGjbhBkufhOBXwVsRy0zuQGyuko3wXStIj2igtjTbfypm2dPnTghl
         sFskEVAZfDwuXblD+ND6WjqW3Peb07qQKVTjKiMVvrQkbVDtHuXbBzBwhVhsyIA4hs5l
         CXtA==
X-Forwarded-Encrypted: i=1; AJvYcCWw6fNOZ1Dfce/xG7lQJxSrSwGcwiDx9ohE1qFuLBUapOKjrfr8OStgCwcB/Zm0ZgFHyGRAaOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH0syQtUoK0ktXv7c2L2Nq6j9e8BXNo6nRCfRWzf8jF6hsb0lA
	9ezsI9fFGOPRc3AJIjEZ6WDX7mSGiPByePDS++PAz/jhaqx6bjd8f4jdDy3hg0S8U/Au1ISX0HS
	wyM4f2DswPXQIfNA7fkhuqHxt2JmuwVHJwe/WD4FeIbGHkQDtU1SoGjU=
X-Google-Smtp-Source: AGHT+IGhSme5cXkK3EUBM+K8SxsIR8ybN9PvtObrG6PhesDpnpYk8xJ+KCWCi3W1k5U0IPu8K+bnDgAz6J4U22VXvoY=
X-Received: by 2002:a05:6512:3c9f:b0:535:681d:34b0 with SMTP id
 2adb3069b0e04-53678fe6a7emr772699e87.47.1726098247382; Wed, 11 Sep 2024
 16:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822200252.472298-1-wangfe@google.com> <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal> <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal> <Zt67MfyiRQrYTLHC@gauss3.secunet.de> <20240911104040.GG4026@unreal>
In-Reply-To: <20240911104040.GG4026@unreal>
From: Feng Wang <wangfe@google.com>
Date: Wed, 11 Sep 2024 16:43:55 -0700
Message-ID: <CADsK2K_ip7YUipHa3ZYW7tmvgU0_vEsDTkeACrgi7oN5VLTqpQ@mail.gmail.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
To: Leon Romanovsky <leon@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	antony.antony@secunet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steffen,

Can you reconsider the revert of the CL? Based on our discussion, I
believe we've reached a consensus that the xfrm id is necessary. If
some customers prefer not to utilize it, we can extend the offload
flag (something like XFRM_DEV_OFFLOAD_FLAG_ACQ) to manage this
behavior. The default setting would remain consistent with the current
implementation.

Thank you!

Feng

On Wed, Sep 11, 2024 at 3:40=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Sep 09, 2024 at 11:09:05AM +0200, Steffen Klassert wrote:
> > On Mon, Sep 02, 2024 at 12:44:52PM +0300, Leon Romanovsky wrote:
> > > On Mon, Sep 02, 2024 at 09:44:24AM +0200, Steffen Klassert wrote:
> > > > >
> > > > > Steffen,
> > > > >
> > > > > What is your position on this patch?
> > > > > It is the same patch (logically) as the one that was rejected bef=
ore?
> > > > > https://lore.kernel.org/all/ZfpnCIv+8eYd7CpO@gauss3.secunet.de/
> > > >
> > > > This is an infrastructure patch to support routing based IPsec
> > > > with xfrm interfaces. I just did not notice it because it was not
> > > > mentioned in the commit message of the first patchset. This should =
have
> > > > been included into the packet offload API patchset, but I overlooke=
d
> > > > that xfrm interfaces can't work with packet offload mode. The stack
> > > > infrastructure should be complete, so that drivers can implement
> > > > that without the need to fix the stack before.
> > >
> > > Core implementation that is not used by any upstream code is rarely
> > > right thing to do. It is not tested, complicates the code and mostly
> > > overlooked when patches are reviewed. The better way will be to exten=
d
> > > the stack when this feature will be actually used and needed.
> >
> > This is our tradeoff, an API should be fully designed from the
> > beginning, everything else is bad design and will likely result
> > in band aids (as it happens here). The API can be connected to
> > netdevsim to test it.
> >
> > Currently the combination of xfrm interfaces and packet offload
> > is just broken.
>
> I don't think that it is broken. It is just not implemented. XFRM
> interfaces are optional field, which is not really popular in the
> field.
>
> > Unfortunalely this patch does not fix it.
> >
> > I think we need to do three things:
> >
> > - Fix xfrm interfaces + packet offload combination
> >
> > - Extend netdevsim to support packet offload
> >
> > - Extend the API for xfrm interfaces (and everything
> >   else we forgot).
>
> This is the most challenging part. It is not clear what should
> we extend if customers are not asking for it and they are extremely
> happy with the current IPsec packet offload state.
>
> BTW, I'm aware of one gap, which is not clear how to handle, and
> it is combination of policy sockets and offload.
>
> >
> > > IMHO, attempt to enrich core code without showing users of this new f=
low
> > > is comparable to premature optimization.
> > >
> > > And Feng more than once said that this code is for some out-of-tree
> > > driver.
> >
> > It is an API, so everyone can use it.
>
> Of course, as long as in-kernel user exists.
>
> Thanks

