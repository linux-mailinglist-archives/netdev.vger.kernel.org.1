Return-Path: <netdev+bounces-76499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA31686DF6C
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 11:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718301F27243
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 10:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3954C69E0B;
	Fri,  1 Mar 2024 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoGklKrS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062C69D22
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289655; cv=none; b=TR6nuO+tcQKSALJ41gtcz/eFUYMx0BKsBQshNlGk/eK9dOdLFpMyI9GEOjkfXpqAJeooxciEaXA7ua/lwe5u8l0ZZK9i2sCvcGPnwWi69JV5aKV6Y3ysmd165SWEEmYiFgHxajuddVFgUevUx2zYLtzXleflc4WknC2CdlvmZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289655; c=relaxed/simple;
	bh=Ra6cSlyolKnZOT+x+KE99EWAMqJIzp5p1tWWW4lurxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2L2zCEUfLdRCCVfnyv1sfxz2Ix+heZuNcPJcqi8QedGFnWozyZQKKt9W5z6a2BXymm/8P8VlrJKVTvAZM2Jjnmt1BUJ7fjfdsIfLvk+qU0uqXcnFqWDEWBf9/2TP4I6rVsXTLXP119QsZYToUDOk4TqW0AqasBtyOd8U8s8k+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QoGklKrS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5131316693cso2442278e87.0
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 02:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709289651; x=1709894451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ra6cSlyolKnZOT+x+KE99EWAMqJIzp5p1tWWW4lurxk=;
        b=QoGklKrSaHQufGjl7UiIcSHL1aRdUlHefsa6d6wnuEhfb22brAqYN3YqVCHjbWWphn
         JJtOUvBjdOaKQ3YHjXvWQ/D7S7r4FMvJpzU+ESzn/UhKaBTMRR2iUC0BN9Q4SAo4ht4N
         GwQwp9pHsvGL8nI08vtma4BSXa97aLoCHJSaAq+MsQGNbH9+XeZZ083vLXPxRdO0tFUZ
         faF0vjTF8bj3H4RA+Km1tQzGoPLPTFAfScWKs7rPuIhfzyuPTu9UzeZvEgEIexke8L0z
         vNKBIDfXYjvzXL5PO5K96+jIyYEp5Xo618ZjDm9xkOy6NWvskp/8wtE02iH9FgkS2TU2
         bycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709289651; x=1709894451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ra6cSlyolKnZOT+x+KE99EWAMqJIzp5p1tWWW4lurxk=;
        b=JMqd+LmDM/Wc/y48RqnMfvIMf6enQizqZtmu+ZNrlXcYdOtRkRRxU19BpTqL82giwt
         y1wosRPXV+7kWHtOW1POD58rnp28uwtgmLNqm19Ltgv32jI+ZmiVYbOUzENjsp1Oyknc
         q5HzSIGvcNIdVpuCsrCBlWodbc/mGXXxQjcBWYzxScp3AGbB7X2TYQpYUS1AfkW8YQJK
         cnCXcMwryURd8xL6CqhaZN5ajp5gGKApeY8sqCxqTFqGuVrOyyhpu/YtjPJ+qOC67KSS
         VNnvK4z4p01nXm1NHGGJl4qQpD3mVAF8CNp3MlxmiKo1wzRiEBvGPOioQurvPh9SK0Gu
         CSOA==
X-Forwarded-Encrypted: i=1; AJvYcCWAofcmljjeb/VQ74VjOGXf6K9cByQgTv/kY1js0gQLWviF6yitea9nCQK2iQ/MAYyEsjiI2NlC1QI7WWjj4T9aXxyhLvwt
X-Gm-Message-State: AOJu0YwJj24/IMp1ItVjFTB6wwxDfw8MNe9YjGxZVhrMKdHyf7zF0Ae5
	EFauv/MGaauv60oJ4LAdMueXUxhHPp6l8hDT156qnwXUUJon4d4OGsrk1eVXsBsbMQLWWXD3jJs
	lYCpHhVUZOEWkR6S0EUNiAmH0zKS48uwughTlUg==
X-Google-Smtp-Source: AGHT+IG4e7/s1uuUYp4dHG85171S4Q+gGlplaozIehkOAliSCNldXyvuHR3OnM5fP293XSZeb0WYM/ZrAe0jNmIzuK0=
X-Received: by 2002:a05:6512:20d2:b0:513:2992:bd92 with SMTP id
 u18-20020a05651220d200b005132992bd92mr825557lfr.11.1709289651335; Fri, 01 Mar
 2024 02:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <499bc85ca1d96ec1f7daff6b7df4350dc50e9256.1707931443.git.lorenzo@kernel.org>
 <20240214101450.25ee7e5d@kernel.org> <Zc0RIWXBnS1TXOnM@lore-desk>
 <CAC_iWj+5TMe8ixXrLM3DUS+RAmDu+gmb1rfcHiU04re8phQVDA@mail.gmail.com> <d3047f5c-673e-4891-94b6-f2448c5385dd@kernel.org>
In-Reply-To: <d3047f5c-673e-4891-94b6-f2448c5385dd@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Mar 2024 12:40:15 +0200
Message-ID: <CAC_iWjJqZA4itFNyf1Czur8ACZ8S+9JhSsgjstC2Pho8V4xZDA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: page_pool: make page_pool_create inline
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	lorenzo.bianconi@redhat.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi Jesper,

On Fri, 1 Mar 2024 at 12:33, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>
>
>
> On 01/03/2024 11.27, Ilias Apalodimas wrote:
> >
> > On Wed, 14 Feb 2024 at 21:14, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >>
> >>> On Wed, 14 Feb 2024 19:01:28 +0100 Lorenzo Bianconi wrote:
> >>>> Make page_pool_create utility routine inline a remove exported symbol.
> >>>
> >>> But why? If you add the kdoc back the LoC saved will be 1.
> >>
> >> I would remove the symbol exported since it is just a wrapper for
> >> page_pool_create_percpu()
> >
> > I don't mind either. But the explanation above must be part of the
> > commit message.
>
> I hope my benchmark module will still work...
>
> https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/bench_page_pool_simple.c#L181

Since we rely on this so much, perhaps we should make an effort to
merge it, even in a version that only works for x86.
I know it's fairly easy to compile and run locally, but having it as
part of the CI is better -- more people will be able to look at the
results quickly and determine if we have a performance degradation

Cheers
/Ilias
>
>
> --Jesper

