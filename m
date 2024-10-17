Return-Path: <netdev+bounces-136588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 519689A23A1
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 15:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86471F28B53
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5AE1DD864;
	Thu, 17 Oct 2024 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTwTC+Yv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE5C1D414F
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171304; cv=none; b=Xcyewrf83KC0VikxAsoFa0jmgr+RqNayWm2DxvpX/V0oasNTeMQQOlCaLPUQ7T3pGQ8L0vTbfZSPa+dMAnV/7WqbIMlfpdMD5zf9r+b2EijwtTa16NNyKj7dmoRHsCGtsy/Mw7Nhaw4sKobeagjyppnLPmhBCStJ8dEreHMYPsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171304; c=relaxed/simple;
	bh=jKb47RF51cs4sVm2Mb0fQ05sNuGcsISFltwiPj+VHmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krmKOXo9omfcyeh6ebFHM5xooI7LpR2gfph5D467KdWvSSU+LQYI23Ij57KaYrhRIAwlyykyh/m1W7xuvEpCFIkr0aCs2MD5IP/OnI4nQPibZQlSBov3QIGk4obDn1Bvpd2P9XtVVLSOS1DUZDnNGyF8CZ2w1uDBGmw3NLhH0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTwTC+Yv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so26065a12.0
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729171299; x=1729776099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTQRQmYmbBP7VbJIkK3yW+XkncP2gDgr8i0Gezu06dY=;
        b=YTwTC+YvmJXwhosaw8pPDCCBIj8x158oZxiv4/8rZHf94IUs+cDZennX8A8uuEk+jW
         KAPLbtwMEKAn3gbMfSTVcn0K5ijg4Z8sXrIrE2jWLHpSFxY//jF2tOsehnmt24VHgvtR
         a1ULWmAp3YNc9WQ33b0LZMBBsrRzPj/w+AT0xi66k3sXl2JXjwqB17u3ykfkCJgjCGpg
         VnsfLDu4APgqZjYHTotS0j6Ac3n0eso6UL6odAP1Iyrmw0B0VHqbf1iO9U2fsaySbQjo
         g2tSwXMxA+/IkDqgu6jaaXq4T72louGo2isQaMNtEpuQuVEKJTxZ/Vdfc9VI2DUGvI3B
         d39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729171299; x=1729776099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTQRQmYmbBP7VbJIkK3yW+XkncP2gDgr8i0Gezu06dY=;
        b=B5PUYHVCN9AwIeC4KGqXWjKIUxc3EiBzgzNi4m69+sVSdc/49P83FuRd9Di0um7iLj
         IeLUDfGlckg65BwQA3RqroDzPRCRMNlFON/htN9B31ceBjAZmUXt0kL0Ej1sD0CzoqZE
         ZXAZe/jHzYcYtR3e0phTiwWrl9ZyuWIEnzWC4EhaK69X+08Vduq/iTTQiVqjqtMxe1Dq
         Q8CW1Hzi4J/YsnDfQLcdQIueYYvqShLCqvv2VlGCbWWP4XVHsy9STZUm2J5CrzbsGdVd
         24dgvmNbepJH1ZA23xvZmy/0cmjau3CLqyAk+zGyunXGdqohnWPrZ51RERnScjft0EFo
         u2Ug==
X-Gm-Message-State: AOJu0YycDRXUCAO4HFSilj7NRVeSIygErzELVBgfGxp+yYdHvSkOEtlz
	09pKMjNWz50Bb9NGjrFeVC9SzFpPFWy3lD3McAVgR3tVlNsiV+rF2WryygUO3L8MmLrccZQMzNG
	tqWFTyZ6SRZi0JYawwOVFq/w/bUBUEpA7+Mb01uO3IB4jaw/1XVtacNA=
X-Google-Smtp-Source: AGHT+IHXoCjqZIdik0rXch5AkWEnTB3KwPZCC+POt0ByxAfhPaeeCc3/7Lo+ea+jqFWVs34BYFfRjOECWR5zAfIsXyY=
X-Received: by 2002:a05:6402:34c6:b0:5c4:2e9f:4cfc with SMTP id
 4fb4d7f45d1cf-5c9a6613d74mr392434a12.6.1729171298991; Thu, 17 Oct 2024
 06:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017094315.6948-1-fw@strlen.de> <CANP3RGeeR9vso0MyjRhFuTmx5K7ttt0bisHucce0ONeJotXOZw@mail.gmail.com>
 <20241017105251.GA12005@breakpoint.cc> <CANP3RGcWhTKOgNsCEb8bMNhktgdzXH+00s5zTKU3=iVocT5rqw@mail.gmail.com>
 <20241017113330.GB12005@breakpoint.cc>
In-Reply-To: <20241017113330.GB12005@breakpoint.cc>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 17 Oct 2024 15:21:22 +0200
Message-ID: <CANP3RGcb9cpOgSOFaX2=eKoPicawsWtdEQU4EeCt3+g0V8Pw2A@mail.gmail.com>
Subject: Re: [PATCH ipsec] xfrm: migrate: work around 0 if_id on migrate
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Nathan Harold <nharold@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Yan Yan <evitayan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:33=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Maciej =C5=BBenczykowski <maze@google.com> wrote:
> > > If you think a Kconfig knob makes sense for Android sake I can respin
> > > with such a knob, but I think I'd have to make it default-y.
> >
> > I'll trust your judgment.  I thought we could maybe eventually
> > deprecate and delete this, but it sounds like that isn't going to be
> > the case...
>
> We could also say 'android fixed it in userspace' and not fix it
> in kernel for now until someone else complains.

The Android patch is here:
https://android-review.googlesource.com/c/platform/system/netd/+/3303667

But I'm not certain if this is enough (though I would assume so).

It's so much simpler and more correct than the kernel fix...

> Or modify the pr_warn to also say something like
> "deprecated and scheduled to be removed in 2026"?
>
> I'm not thrilled with this patch :-)

Let's see what Yan Yan thinks is the right approach.
XFRM migration seems like one of those things with very very few
users, so it might be easy to just fix them.

