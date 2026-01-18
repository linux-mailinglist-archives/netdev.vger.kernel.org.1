Return-Path: <netdev+bounces-250931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C10D9D39B0E
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 23:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E059F300B80C
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 22:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFFB311979;
	Sun, 18 Jan 2026 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX8psjA5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23443033E9
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768777087; cv=none; b=SiHzJqaNSmXLbIOYfLXuQSTuq74pGikuVRTiqgyB+aRcZ0TfR5ISnrwkQst9k6ulJQ0a0uM3T1vzCBN+YMDEQisqWwnFGiNoO+4KqdSSkCvrASl2KcsdT2CWHtHVCy4ZXoyRUGY3gkGLccLE5jrsv7FhZNpi8L5jrF6E7iEnHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768777087; c=relaxed/simple;
	bh=1I1MOn7VsYdFW2g0y2syTgWaqsitpk1YdLsYX251mws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNMZQJxQH6wXrAB4lo/JZvcxw7uF5XrTLk0TQNqsb4AwHvjo9CjCcZdtPX7c3LoOJ8QoGxvhrtAQCA9NK8BqhQlilNSHZKf4kHRjMZqEu0m1IvTdaNTVF4BFZQMka5/4BKg1tR9QfPDeh66AqqD/sbBpWoj8isK97pnP/WBOg+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX8psjA5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so3236608f8f.2
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 14:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768777084; x=1769381884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+AoEirnNJ8wGXGTX+1JJR7Q6d2HFcn4CnXldkR9miw=;
        b=nX8psjA51zZSVGSRaMhEbPPfy1p8Rlis4vA0128w+cVit/sCzHv89UM2zpaHFZVUD2
         uM1qRGKKX76f8CLUm6LGjMi6oeMtRjmoKsYvXfbUlAlqr4U2ws3r3Av6a8kB6NwjppE3
         kURXr/LS/bRTD/LVZ/2l1CX/16JYd0cKw8fArr9T1SliLLX/yLLs69+g+6Kq4v4qM5F8
         4p0z306RH2KCBOjyPKQ1yuyqOHz8U32DsIn+LynOoQmvIECLeljbhWKaB1fyQEFEcsUa
         4EjognIdYvShNz2YqusmElMAoCKeZKBztzM/c45RAqeyGbb7L44oxZQgSAZlJ2jeZDRV
         hGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768777084; x=1769381884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+AoEirnNJ8wGXGTX+1JJR7Q6d2HFcn4CnXldkR9miw=;
        b=Fu1peN/BqQk2nAK461ec0dG7kllFvS5imkirGq6+sC2GFO/eJxyl5tFuap0AC97U+b
         zeQXEZ94dpSl6mzI8nARqpo4IEl86bE6kLrL+K+q0hB4nuENdgqjFigZqP0KmNfdDw/C
         uY9oMkHRaSjlKy8GrsLa1kKTo54otXgvnj208+NOmEtMLgofFUnSshWaQmvTyzNRZRzb
         q/REb9NdEVPwmSnmFsth5Bs85iGFvuvSsbdkbzPFYEDbADke5SF9kMzEAIABIY/OZuC6
         RfWZNoK3gLanxAdFMckbcIwkF/5GgPH+SqOlsJCn+Jo/TtxGicDvCHHkvGeIwfn2jk+b
         RE1A==
X-Forwarded-Encrypted: i=1; AJvYcCXiC+r6O0kqEnG3PwlAmQfCssFxsfhY1JgI5nvhgq8EDi8OmC3HkkmspxihqEH4tmYk8/36dBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmlDC2z6AQuo+zCqbj7k7JVReg4km4Dodbh0bEgDkDz8DeOOsK
	KEr5qv+e2qMc5+YunnxF2GKi9TCNUmPZ8dx7FKlBo86+AZsDtULmcu7K
X-Gm-Gg: AY/fxX7fLSY5Y6hencqrDH23ohpxQhYA5RBxveHFAAQN1eNBM8obUo22e84XrBuM0PG
	LjlWvPpG3zsJeIe6lWhrASB9vRT1JjyLpGwZ/DAgAa+ZqW3cKwBA2MWkSqaz/B5YN1nJvu58ztT
	lXsvlpJQGJE6FmM6P5aADIKfOBYKWEP9bB/JtTsQu3KxfsOa5xsXOtFGXFBX+XBoH7KyLBlA6oW
	Q7vCGr50yaMjqlru3ceysqjKm3vrD0N9LsZqwPZub695wnYOwUboyQmmmlaNwmW2cKcCeSm4EGe
	ync14MbmqwTEBwq4ADX/Jo6v1PI1SnUvftxluaJNaCJb3HOURuxM46fEOv77l8tUgsQ8DTz6XHd
	aAMnbhmGEQWBwHBwTMQmzvXwMs39FOfKKUjxhtjTD6Jon3eznDg+3/scMNrkg0+hTmoMu3J9NYe
	qqLHBRXi/g3eghqyUjP0NXtSjUQspRlAYbTpuc6Mvhjvl7q+Pr8zi3
X-Received: by 2002:a05:6000:1acd:b0:431:656:c73a with SMTP id ffacd0b85a97d-4356a07745fmr12404015f8f.31.1768777084002;
        Sun, 18 Jan 2026 14:58:04 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569922032sm20046992f8f.8.2026.01.18.14.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 14:58:03 -0800 (PST)
Date: Sun, 18 Jan 2026 22:58:02 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Dumazet <edumazet@google.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, Nicolas Pitre <npitre@baylibre.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
Message-ID: <20260118225802.5e658c2a@pumpkin>
In-Reply-To: <20260118114724.cb7b7081109e88d4fa3c5836@linux-foundation.org>
References: <20260118152448.2560414-1-edumazet@google.com>
	<20260118114724.cb7b7081109e88d4fa3c5836@linux-foundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 11:47:24 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 18 Jan 2026 15:24:48 +0000 Eric Dumazet <edumazet@google.com> wrote:
> 
> > inline keyword is often ignored by compilers.
> > 
> > We need something slightly stronger in networking fast paths
> > but __always_inline is too strong.
> > 
> > Instead, generalize idea Nicolas used in commit d533cb2d2af4
> > ("__arch_xprod64(): make __always_inline when optimizing for performance")
> > 
> > This will help CONFIG_CC_OPTIMIZE_FOR_SIZE=y users keeping
> > their kernels small.  
> 
> This is good.  __always_inline is ambiguous and the name lacks
> commentary value.
> 
> If we take away __always_inline's for-performance role then what
> remains?  __always_inline is for tricky things where the compiler needs
> to be coerced into doing what we want?
> 
> IOW, I wonder if we should take your concept further, create more
> fine-grained controls over this which have self-explanatory names.
> 
> 
> 
> mm/ alone has 74 __always_inlines, none are documented, I don't know
> why they're present, many are probably wrong.
> 
> Shit, uninlining only __get_user_pages_locked does this:
> 
>    text	   data	    bss	    dec	    hex	filename
>  115703	  14018	     64	 129785	  1faf9	mm/gup.o
>  103866	  13058	     64	 116988	  1c8fc	mm/gup.o-after

The next questions are does anything actually run faster (either way),
and should anything at all be marked 'inline' rather than 'always_inline'.

After all, if you call a function twice (not in a loop) you may
want a real function in order to avoid I-cache misses.

I've had to mark things that are called once 'always_inline', and
also 'big looking' functions that are called with constants and optimise
to almost nothing.

But I'm sure there is a lot of code that is 'inline_for_bloat' :-)
(Don't talk to me about C++ class definitions....)

On 32bit you probably don't want to inline __arch_xprod_64(), but you do
want to pass (bias ? m : 0) and may want separate functions for the
'no overflow' case (if it is common enough to worry about).

	David


