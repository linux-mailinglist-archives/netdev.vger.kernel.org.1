Return-Path: <netdev+bounces-92799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E94C08B8E1F
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 18:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258671C21286
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 16:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B1C130484;
	Wed,  1 May 2024 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGRF/wER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E212FF7E
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580617; cv=none; b=ZhTHOX+4EGdlmDNOeCd9gA50PmYem6jjv3rpt6E9E+PvsQReT/rgaAPidH4veLB7E3Go4IGPHKEsHPQofUF1qg660jJ1/cnNWmN+tw2RG6gMcJROtSbKJkhQg4Pn8GwaGQITPpS2jhtgVVlIsa9snsTJPyF4zyZLg3taT3Zs9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580617; c=relaxed/simple;
	bh=ZzwkZ/EkeuQlBEthD/LjsTTbxL+u6lGHOizRSZMPv8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4Fi2xNblzzHImMVdcJCz3OCxFTv835TwOZJCvm45yfQ1IyKOgO5mQNHbLS6+MCMABrZcUaYE39dmKKL4Bz24BRanqQXiH8/1cxHgedNEfcnf1oxVxaEITGcLnxPYtmhZcjZv+kaRDwk5xohBr66edpWl10c+zM5N4aRvzc+mqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sGRF/wER; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso10953958e87.2
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714580614; x=1715185414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzwkZ/EkeuQlBEthD/LjsTTbxL+u6lGHOizRSZMPv8Y=;
        b=sGRF/wERqovuREC11lLIusyeokGjblxFViniBJ0Etw11OMIMBQ/4E4hLGNSoUsc3bp
         awiHqt2V1CFR/Qy9APq1IP8FocpapeCTg2Y2bzWHhX+ZLHqGCK+P6p4OdlhKmeZ5d8Co
         G4wg1Leyxo+Tox8bE2MKpbvkq0kji/KduODJUYu97sd3qjyhZsrhI7mRslLYHdv5LG9R
         Z1ck8ItDqooi6/jkr60fSzMLf7Qi8Gwwbfs6Pu912uJuxJbzlzYIz+uDxd7Za5eDKfbS
         Q8iEom9AfXmAG8CyUTBiAdWzr38XlgLU4GEXJdIL5ZizC65PPOkaHPmvwz6sKy9LIOSg
         yQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580614; x=1715185414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzwkZ/EkeuQlBEthD/LjsTTbxL+u6lGHOizRSZMPv8Y=;
        b=X+SLiRgUA4y1WtrXD07+e2PHhMngsYgYarzbmnZPHIWKXxrJ1+mhnb0jJDA80ODI+r
         1b7EC6UAikA7WXQ+C6Z5lqUeLY44VRgypCr3klKt/Qfx58CvNMseF6xGeUAZCa3RgkzM
         c0yP+/y0tMlPhkQxtFE8DaiIzSmYj461xzEgdISveLU1THyhsJrnv2hG7zY+nd4K87WA
         Gy6+6wH3M/JLA7xvQFU5Sp0LTAlTunfS7IeO9apth7D6KfyZH6Eob1jKvV4+nKjWVQXG
         npgl8xZZu7kGWk8gxsk0EcZK1yCYxAPdqkH+FjIki27xoNaAQLHPJaKKlFL1E2VRyjQG
         ljBA==
X-Forwarded-Encrypted: i=1; AJvYcCXNbb+40/N0O1HMbU2hS8OvCu5pt9oGYcw1fRa+sYtTrbeS1tJrTsb20PXHvCZ46qAed9OMuKXk3OIXo5cEPTYuIrXnSjNB
X-Gm-Message-State: AOJu0YyqRS6yrBXtLHyDqeMDkJnjSnAmMTKAinrqOTBdTShkOYJhwwnb
	rCS9xOWoqwxvUJ66zMtyReT5aZA5Q+FP0QxA//tyVpxTNoicbRVuyKs7rbx1GTXLWYVSOfEhtR5
	oAXBC9bv+tohNGfNaouf3Om664LELdtI862oH
X-Google-Smtp-Source: AGHT+IEsy5I2YIZMKY3kDryMfIwVdDmm/X+sEhcO+wyIss+PM8K10fJ6+WJtP8XYdS2HuBe/R6SfY3RlojydwiRe3ZA=
X-Received: by 2002:ac2:5f1d:0:b0:51d:aeae:27f6 with SMTP id
 29-20020ac25f1d000000b0051daeae27f6mr2433245lfq.16.1714580613679; Wed, 01 May
 2024 09:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424165646.1625690-2-dtatulea@nvidia.com> <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
 <CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
 <4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
 <20240426160557.51de91f9@kernel.org> <c307a3086d255d1dfed22284f500aa9fb70f11a3.camel@nvidia.com>
 <7a5a1d74040052afc8cc6cc5c2700fdf2e836b0c.camel@nvidia.com>
 <CAHS8izOsFqiSiS4Z-E-jfD70aogNp5Bcyt7Rk8xFoR2TcDjz=g@mail.gmail.com> <20240501072434.5720fd42@kernel.org>
In-Reply-To: <20240501072434.5720fd42@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 1 May 2024 09:23:20 -0700
Message-ID: <CAHS8izO2PT3ZrDdHhNOZ7+AL_SKZfDko9ZUWuTd8O84bjOVDHg@mail.gmail.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	Jianbo Liu <jianbol@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"edumazet@google.com" <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 7:24=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 1 May 2024 00:48:43 -0700 Mina Almasry wrote:
> > > 1) Revert commit 2cc3aeb5eccc
> > > ("skbuff: Fix a potential race while recycling page_pool packets"). I=
 tested
> > > this btw and it works (for this specific scenario).
> > >
> > > 2) Revert Mina's commit a580ea994fd3 ("net: mirror skb frag ref/unref=
 helpers")
> > > for now.
> >
> > I vote for #1, and IIUC Jakub's feedback, he seems to prefer this as
> > well.
>
> I vote #2, actually :( Or #3 make page pool ref safe to acquire
> concurrently, but that plus fixing all the places where we do crazy
> things may be tricky.
>
> Even taking the ref is not as simple as using atomic_long_inc_not_zero()
> sadly, partly because we try to keep the refcount at one, in an apparent
> attempt to avoid dirtying the cache line twice.
>
> So maybe partial revert to stop be bleeding and retry after more testing
> is the way to go?
>

OK, I will upload a revert sometime today.

> I had a quick look at the code and there is also a bunch of functions
> which "shift" frags from one skb to another, without checking whether
> the pp_recycle state matches.

You posted a diff, I will pick it up in a separate patch.

--=20
Thanks,
Mina

