Return-Path: <netdev+bounces-244755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA4ACBE24F
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB443300BA1B
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4065287503;
	Mon, 15 Dec 2025 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXNwPPYh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F21221710
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765806789; cv=none; b=m3r/aMF1nEqG8pDFsIkdd2/xYvDMgD7avjb+wzLtjR9R6GbyBZaXRc+qjE/njO40zyNIgFZQAz4RHhnVG8HaJTC+83+EFel4dDB0RmdUrdTdV2TdzEuDQW1UFaVwgNzk3kd9Hv3thZm0kt1Epvej+w05lIdT/bRTccVnRW+8wgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765806789; c=relaxed/simple;
	bh=8zFWZMTo6an8vJ27NvevOZe+yH1eUMcNsTqP/opKK1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7NjXd7eTbltyhaYJGMlyG/G37LA4rBNfg/2gKggVkBksYBeG++p0VfnWRM6lkvdHZ/pRrkgb+6fwVX4TVb4xWlKf87N8p5PrSvpBpDwfsZjWFItvLiiwKnSRkNtNjJs5Rwa0ysuGhi0rqApjJQ4FFR+TJcrE2AHW/K0djkMO9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXNwPPYh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47118259fd8so35229955e9.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 05:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765806786; x=1766411586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oX4nrpvWkPai7atYZDyI6XfqJxF8RgdX6YGg5FC9Ik=;
        b=nXNwPPYhb6KbJX+H8ZmlKqZlqD+XS1jpECQeGBScxQQyiSaYrLYN9Oj9TZrtDEpI/L
         Y1bW8bG9Gx1Fis9UeOD7l1eoGWaRCGEU/X2RbcPLTD5mBr8iW1637dBEP1vvxvPQho0G
         B7jD5fYPPXaymFIdlSg2JD2bCtV0AJJ8d8DGeU+uaP84kxMQs5/qTI2CjMn8yLfRFdXR
         xnhvKE1d7CaskcDr+R5xXK3vgbY871QE8P/VztJluXQu1SV0FU1kNzC/j+StMf5Zxt1V
         vfoyfdznbTvr0TLVcOVFEbqUucQWTl4kAoBZQYnW9WqRHqxr2yRQe7/7KHghzlnT4S4o
         /FeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765806786; x=1766411586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0oX4nrpvWkPai7atYZDyI6XfqJxF8RgdX6YGg5FC9Ik=;
        b=Yr7sTFzQq6zIshtZctW7XoOG1nA5RmjDQKXWC+wyUiI4hrM0/iz4IYUQF8NvF5Ijb/
         Xi3f76dG/BbmT2OK01VgPojqeDTX6BluSlxlbJ4nXXJLe5lEnMjWO9YevZKGmLWcfQT6
         8JjJ/NS9UnXorksRuY5gpxfEkRNV5pXuewvZXM1NfPsbR38l3H4MX6+aFgOrBrTYi1vC
         k7raL/7y5vrUywyrkObqvslb7B+DjcLZ8ILTHYbAMLeq2ya6dO+f0JaZkiDZEamBtQ9a
         D2YmAukZTvYO5vOJ/YU/Pi99VvWP62VwKY42/uq8ewGsPBYegMMk39rsv/zdH4Ah/Of/
         B8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHtkp6GeEJd1lR+jlZpVOQXMj3o0GtfyNkzkjYJMoTRSUbffiprN6qhFv8Tr4ebajqZIyMfGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzVlBJ5mXjHH/09bX+JLrenbb4pMpbgf9GGD9wvFdpK31/U/EN
	fGoF/zu0PmzNKb9eE9Y44hnW3jku4aJ6N/XuU1D0BSEmvFhyVqRJLuAv
X-Gm-Gg: AY/fxX4PBgnK7irJNtAetK6xsVAMj59XAjVSo+D020Jl+ce7QHQSyeYRYz6cwwT+akV
	mWpNJYi5uxkslduatK4hCHoF8fF83tp1zp5ekPbBwZ+8HwKKKeHWls6duKCb5wcY35OIs/rwlOe
	BoOilAXRyDHhfWdeewRlsy02VPGlK5ja02/mexL74f3nYyiROHeCBycN/xPZfxg/7oxVrzktg/M
	nE/j0NNI+V9Cqr8MkjKkCzcGWkSsvRIRAbNZS3nwRtZr/KH6WXSe2xP6WmB7yxsGsVmHefo0yqu
	4UwCXu99CJgTaFo1eDbGZredmm1uf6mS73YDOK2PUkvctOA2sl1XkwFuuT8EhWkp9maLJZth3Ow
	Xi+6Ai86WNcqJ59uFxNGsVNs5vE1cQ4NA0ppKRIFhY+skEpxOI04AePl+RBpvCriSquVVaB1Dy+
	/UJG/s9GhPmqyabbbOMaEffc0wA3iQ9kqBm4BfoOZLnnIdZfFriduz
X-Google-Smtp-Source: AGHT+IGhHsIa/I96pYEni0zAnzO9+wzE6tXY69h25/pF+Ws1y0k0/TacBAYssZKxcUf8ahWpq5bA6w==
X-Received: by 2002:a05:600c:8286:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-47a8f8ab861mr110451985e9.1.1765806786085;
        Mon, 15 Dec 2025 05:53:06 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f3352a0sm69034975e9.0.2025.12.15.05.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 05:53:05 -0800 (PST)
Date: Mon, 15 Dec 2025 13:53:01 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: Anders Grahn <anders.grahn@gmail.com>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Phil Sutter
 <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Anders Grahn <anders.grahn@westermo.com>,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH] netfilter: nft_counter: Fix reset of counters on 32bit
 archs
Message-ID: <20251215135301.75986b89@pumpkin>
In-Reply-To: <aUAAuyGGhDjyfNoM@strlen.de>
References: <20251215121258.843823-1-anders.grahn@westermo.com>
	<aUAAuyGGhDjyfNoM@strlen.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 13:36:11 +0100
Florian Westphal <fw@strlen.de> wrote:

> Anders Grahn <anders.grahn@gmail.com> wrote:
> > nft_counter_reset() calls u64_stats_add() with a negative value to reset
> > the counter. This will work on 64bit archs, hence the negative value
> > added will wrap as a 64bit value which then can wrap the stat counter as
> > well.
> > 
> > On 32bit archs, the added negative value will wrap as a 32bit value and
> > _not_ wrapping the stat counter properly. In most cases, this would just
> > lead to a very large 32bit value being added to the stat counter.
> > 
> > Fix by introducing u64_stats_sub().
> > 
> > Fixes: 4a1d3acd6ea8 ("netfilter: nft_counter: Use u64_stats_t for statistic")
> > Signed-off-by: Anders Grahn <anders.grahn@westermo.com>
> > ---
> >  include/linux/u64_stats_sync.h | 10 ++++++++++
> >  net/netfilter/nft_counter.c    |  4 ++--
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
> > index 457879938fc1..9942d29b17e5 100644
> > --- a/include/linux/u64_stats_sync.h
> > +++ b/include/linux/u64_stats_sync.h
> > @@ -89,6 +89,11 @@ static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
> >  	local64_add(val, &p->v);
> >  }
> >  
> > +static inline void u64_stats_sub(u64_stats_t *p, unsigned long val)
> > +{
> > +	local64_sub(val, &p->v);
> > +}  
> 
> That still truncates val on 32bit.  Maybe use "s64 val"?
> 

It probably depends on the type of total->bytes and total->packets.
The 'bytes' value will wrap 32bits quickly, so may need to be 64bit anyway.
And if (elsewhere) there are this_cpu->bytes += val; total->bytes += val;
pairs you can't 'undo' the adds once total->bytes has wrapped.
So should any of these types be 'long' at all?

I sometimes think that 'long' should be pretty much never used in the
kernel because of the 32bit/64bit portability issues.
But that should have been sorted over 20 years ago.
Maybe M$ had it right keeping long as 32bits :-)

	David



