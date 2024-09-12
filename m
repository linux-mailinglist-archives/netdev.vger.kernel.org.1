Return-Path: <netdev+bounces-127963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A33199773BB
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8AF1F24DA4
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4161BDA94;
	Thu, 12 Sep 2024 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+5bG2t6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685E2C80
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177429; cv=none; b=dRBNa2o/GghmgpRwaE49cHAtN+RLjToEBTkgqcnHmWqSdwBDoOGTP6Q/6uEOJwS9rLWs3HbdHTxzWuaMAIqUk/1uqC+Y/N3QPLixcESdNAVNWt+NQVSh7TqgqQaX77mMs8B3MqJEDpUoUlDFBtruOnVI3x8iJU+GzvVqLJ8W9Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177429; c=relaxed/simple;
	bh=GMy1j4BS7OEtxsfhiBWd34e/jEkG+gCT/gBIQ5xQDuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG7/lYj5Pfm8Kidx/uCAp/C6rTj4TFSU5LFGF5n3A+KRTlD+8U/CABe0NZumjug0a8xkvG39Uq4yCL9gC1euCdLIm+ZNAVYJpXPn/lyK7CQ32pErt8ERyyaQaVD7Iqr9CES+KSRxNe20/KJX6/+bom4Q9xo7i+ZHZzMNo3Kj8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+5bG2t6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2057835395aso17123925ad.3
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 14:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726177427; x=1726782227; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uOPaLrktNmoWlJYWm7HobLTRY5ro1t3zMBcb6LRzGZg=;
        b=e+5bG2t6TQZGE57n3W+NMgAx+WRtKP/dK7f6UwsscRS1tbm5g+N3dQqOQdImOZtpqs
         DftJYvnHW0ABNHk0ODF1oasp7BZEmIMFxoI4PHmwE62EM+6QOSVclcl/2ldeRl5cyc4H
         I7axQpnd/SBCmQt/ILRw05NUgyEC8qWH5NWpFaAVxPz+W58p5gbSurOKbmGXLP5yJgzh
         mwGlfUTej6BJASXoIJQQNswYbhE98quDtXGceEt8nnYoqMxjRbqURlYS2g2bAdFAuhsJ
         WakGeOHz14ahMZpKXdmkWhon7xOs7eggmw0mvuwAojshClrvHRzVPBOoYB9MWyxA0ck1
         AcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726177427; x=1726782227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOPaLrktNmoWlJYWm7HobLTRY5ro1t3zMBcb6LRzGZg=;
        b=KbOxbcWT6sxtecPN0h0GRq5RL0rrCEAPgRYmOF/ttx6pXAwzQ/0dXpjM+hZhnXdvqr
         LbNSNfKOrTy6FE+zKfuXDwn+d/zIqVLrBHd9F0ZJ00tFtymkxJYyABogfx2PENeZR8RI
         MAog8A3Ubicn9934E5Fu5gN7U9D0YISQqVlR8MeYBImJAM9Ey2HNEyShDF48ceuojmT+
         Y64/lJiIqtoJ+vHg7OxpZgUTiroUEJp5dNJ2KvayuYwA6mXyUhA5BNxyRwUJF5NKXUgK
         sTprqt6WPAjxwdbClMfT2nuEeHt7CJILbKHXwcH4a8+7/k+L+W0/nADee91MxEnrYOzC
         3cZg==
X-Forwarded-Encrypted: i=1; AJvYcCWUaAWI1BEFaxh9CfdYLejZcDKGUtCoEILhd07RReLjFvfZxsogIwk/i9Eqb+yzjKmUp/ungKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1FNf28EER9tzrycQYsZtQ4SnAHg1L6fxsmqbDWTrreWMfA/A
	CYhtdsOt3f+Terv5pYPfWzsE8/tu0lGmJz8Z4SLdJR9qoQoMWGE=
X-Google-Smtp-Source: AGHT+IH7gWUt+AZUwfwHqbrs57V4KfatnFEJwrbYuzEfFkEgTvV4iuvLi7dKjnyTxEHQtVnX1F+CEw==
X-Received: by 2002:a17:902:e812:b0:206:c75a:29d9 with SMTP id d9443c01a7336-2076e3eb0cbmr51453205ad.42.1726177427442;
        Thu, 12 Sep 2024 14:43:47 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9a83sm18194615ad.217.2024.09.12.14.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:43:46 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:43:46 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 00/13] selftests: ncdevmem: Add ncdevmem to ksft
Message-ID: <ZuNgklyeerU5BjqG@mini-arch>
References: <20240912171251.937743-1-sdf@fomichev.me>
 <ZuNFcP6UM4e5EdUX@mini-arch>
 <CAHS8izM8e4OhOFjRm9cF2LuN=ePWPgd-EY09fZHSybgcOaH4MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM8e4OhOFjRm9cF2LuN=ePWPgd-EY09fZHSybgcOaH4MA@mail.gmail.com>

On 09/12, Mina Almasry wrote:
> On Thu, Sep 12, 2024 at 12:48 PM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
> >
> > On 09/12, Stanislav Fomichev wrote:
> > > The goal of the series is to simplify and make it possible to use
> > > ncdevmem in an automated way from the ksft python wrapper.
> > >
> > > ncdevmem is slowly mutated into a state where it uses stdout
> > > to print the payload and the python wrapper is added to
> > > make sure the arrived payload matches the expected one.
> >
> > Mina, what's your plan/progress on the upstreamable TX side? I hope
> > you're still gonna finish it up?
> >
> 
> I'm very open to someone pushing the TX side, but there is a bit of a
> need here to get the TX side done sooner than later. In reality I
> don't think anyone cares as much as me to push this ASAP so I
> plan/hope to look into it. I have made some progress but a bit to be
> worked through at the moment. I hope to have something ready as the
> merge window reopens; very likely doable.

Perfect!

> > I have a PoC based on your old RFC over here (plus all the selftests to
> > verify it). I also have a 'loopback' mode to test/verify UAPI parts on qemu
> > without real HW.
> >
> 
> This sounds excellent. Where is here? Is there a link missing?
> 
> I'm happy to push those patches forward, giving you full credit of
> course (either signed-off-by both of us or 'Based on work by
> stfomichev@gmail.com' etc).

Great, let me clean them up a bit and I'll post an RFC to the list for
you to take over sometime tomorrow (or ignore or whatever).
Didn't want to send out anything without asking you first..
And this will be based on top of this series.

> > Should I post it as an RFC once the merge window closes? Or maybe send
> > it off list? I don't intent to push those patches further. If you already
> > have the implementation on your side, maybe at least the selftests will be
> > helpful to reuse?
> 
> Everything would be useful to reuse. Thank you very much, this is amazing.
> 
> BTW, I was planning on looking into both TX and improving tests and
> you have looked into both, which is amazing, thank you. Would you
> Pavel/David/Taehee others would be interested in, say, a monthly
> face-to-face call to discuss future work? I am under the impression
> Taehee will push devmem support for bnxt and Pavel for io uring ZC, so
> we may have a bunch of details to discuss.
> 
> Any sync would be hosted on bbb, public to anyone to join.
> 
> No pressure, of course. Communicating on-list via email has worked so
> far, so in a sense there is no reason to change things :D

If you think it's helpful to coordinate - sure! Doing something once
a month is not a huge commitment :-D Set the dates and send out a link.

