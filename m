Return-Path: <netdev+bounces-228272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0DBC6025
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 18:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9A04234B7
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C352E28468B;
	Wed,  8 Oct 2025 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UkdwCwvG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811010957
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940173; cv=none; b=Bk+2oNvdsBn4te8e59nHJ9o7IkZvCiQsfK05DclPOXGgknvILQQ04asSwFiYJnyBMQ3IqV9r5XazHw/4USajg5nsg9FatjBfzJgkQzZqV9u4kUeIvdDgMzeobCay78CeispNIHS1NTuHjanClWWtMYew5TAAHZdVtjknNTjR+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940173; c=relaxed/simple;
	bh=uEGenzvUyzBkuEtUVn+BvDaUco6V3TK5byPQuBV+0Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd32iQfG9vPwfbrMp1Az2O0WK+0hdoznHjkumez7WSLb7JPY01cgoI8BzD0eHFvDbIjzdYGRVkaiDjSWiYnssA971SvEyYzO9zJNjtS1ho0fwNvFY/hy13zgxAIe8JZm0BaOM0izFH8irJtLBlIZrBe596od1CAYcFOJyoWfleY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UkdwCwvG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb78ead12so1387600066b.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 09:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759940170; x=1760544970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wafGHdomjeTMWOaW1CHD+uCxSHknTrB56S6k0QVoIaI=;
        b=UkdwCwvGeprzmnUJT0VslBL3TFeZXaXJ71qE+O0aiugDMXUermNrtZAV92kuuNfxjx
         33G2FEFmOr7R4KFxRHcehbNlcGL7pnW9RAPgOKnmqfqNA3A5tjtGsyjUQv5Gvql+xaj6
         G9AEyyNFuKQp4j79ucmrtczyQ99Q8bGUZvGoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940170; x=1760544970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wafGHdomjeTMWOaW1CHD+uCxSHknTrB56S6k0QVoIaI=;
        b=bbGGaF/KKRz11eAzO3CqVpciOAfbZTkj4bKqDiWAIJi1KaiH9T5U45obKDjrsfD6Z4
         fq0Bi5CoWqG5QgYPmESoa1ka939s4W6UD39yDlU1zS/uU2UIC8mLudEkczH8KT9lgjEo
         WNF0LPlKHQhCJzvoG8JrBqP3mrZNWPwexMZTwhwIv7F82es6z85SFQGUw/VFH5ZMoG+f
         mVN9gqHYypSWd2rmVDa4wAjZypG9yIDvnK6rvJY6wFBTSx9a1qJCl2GlPtst1O1TTnZ5
         /zG5o53bAUVNhui/1jqNL4rvl6VVoAIvMhp08utzCLYVrXDvPb0kHkDE6479Az+V+d0U
         3fSw==
X-Forwarded-Encrypted: i=1; AJvYcCWq0IlHmfT3gkKj7bcMs/0VkIWBR8+66Vs55Dh22u79kpeaBWemJmTYLKWDBzaQnzx5myAJ5FY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFsHxwyGdrvHygYmqxqohDHXDi0c0amowH6s9tkeUEQrvlu7s
	muoPCD5ZLPqi0xyUhddeJx+ViynU73m2qPzmw2pzAe1YDShlPxYtheGb4YwhtN/KEPzWttdOzih
	dZQS+dOI=
X-Gm-Gg: ASbGncsJ1STpjIJroVpupZG4RX3aYw/MQoCTxC1LY2BBKMlMIr/acLRl5LhwdBA+jaU
	fTqs6EYCLIxGk6/LEaQmEe95sMeJYUjtLb3LZNfpPRlMRrADN19eVGyEn9FyNkbqL9PGK7t+9N2
	8QZ8Hp7lpxeKc9S88zJv+Xb3UwrTkkF8vZiclAWA+wHphFGVW0Nxi1rF+2ecbdP1yozU+GkxwQX
	d4QV8EHU65EqWKMtzqXWFRef/0HdLMEL3sAZZ6DVQdU1jdeg/j57s8E3SrPpnyAPEXtH+JFKglJ
	PKO2OOLRF/m9O5ZBiRGDcijJRk98Jw2f1GQKW1u8ajpGJzyTeFs+xLCmCr6k3e48SiBozBqxG0S
	bMclp/AOSFGAm+9aUsxNsNAnEzCDpkF7ei+Z6shm21Gy/jU6F9l8eXbuICEx+5Q/z3v6WsBDJ+l
	NSkHLd4FIKVVMljSy1YbWv
X-Google-Smtp-Source: AGHT+IEFIjOZRZc5i1Hs98v/erwlPwVn2CcyvG0BPXM+1Lm9iNgFlnTWL3j/qv1firYt6FX1Y5JvyQ==
X-Received: by 2002:a17:907:9404:b0:b07:c1df:875 with SMTP id a640c23a62f3a-b50acc2f5camr493757966b.56.1759940169649;
        Wed, 08 Oct 2025 09:16:09 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4f314sm1671246466b.69.2025.10.08.09.16.07
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 09:16:07 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so13207274a12.3
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 09:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeT/afjts2fMiUczrk+Bu72Tnh+GrhOjrWlPZWxZ7I9wIDbAApVT8wMV7evnp8C3m/mP3xnyM=@vger.kernel.org
X-Received: by 2002:a05:6402:1ed0:b0:639:e469:8ad1 with SMTP id
 4fb4d7f45d1cf-639e469a2e6mr1978291a12.20.1759940166695; Wed, 08 Oct 2025
 09:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a71398e-637f-4aa5-b4c6-0d3502a62a0c@kernel.org>
 <f31dbb22-0add-481c-aee0-e337a7731f8e@oracle.com> <20251002172310.GC1697@sol>
 <2981dc1d-287f-44fc-9f6f-a9357fb62dbf@oracle.com> <CAHk-=wjcXn+uPu8h554YFyZqfkoF=K4+tFFtXHsWNzqftShdbQ@mail.gmail.com>
 <3b1ff093-2578-4186-969a-3c70530e57b7@oracle.com> <CAHk-=whzJ1Bcx5Yi5JC57pLsJYuApTwpC=WjNi28GLUv7HPCOQ@mail.gmail.com>
 <e1dc974a-eb36-4090-8d5f-debcb546ccb7@oracle.com> <20251006192622.GA1546808@google.com>
 <0acd44b257938b927515034dd3954e2d36fc65ac.camel@redhat.com> <20251008121316.GJ386127@mit.edu>
In-Reply-To: <20251008121316.GJ386127@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Oct 2025 09:15:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTKNg8+F5EUP2oxcfr14P7geOOpaPBwhxF7a0jjBm2GA@mail.gmail.com>
X-Gm-Features: AS18NWCvIhnESJ0gUsT-9HGa5XjpSt2eBl3AMS3_hBGymdQg0Vd76BELyTS6HCA
Message-ID: <CAHk-=whTKNg8+F5EUP2oxcfr14P7geOOpaPBwhxF7a0jjBm2GA@mail.gmail.com>
Subject: Re: 6.17 crashes in ipv6 code when booted fips=1 [was: [GIT PULL]
 Crypto Update for 6.17]
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Simo Sorce <simo@redhat.com>, Eric Biggers <ebiggers@kernel.org>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "nstange@suse.de" <nstange@suse.de>, "Wang, Jay" <wanjay@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 05:13, Theodore Ts'o <tytso@mit.edu> wrote:
>
> If there is something beyond hard-disabling CONFIG_CRYPTO_SHA1 which
> all distributions could agree with --- what would that set of patches
> look like, and would it be evenly vaguely upstream acceptable.  It
> could even hidden behind CONFIG_BROKEN.  :-)

Maybe just

 (a) make it a runtime flag - so that it can't mess up the boot, at least

 (b) make it ternary so that you get a "warn vs turn off"

 (c) and allow people to clear it too - so that you can sanely *test*
it without forcing a possibly unusable machine

and then

 (d) make the clearing be dependent on that 'lockdown' set that nobody
remotely normal uses anyway

would make this thing a whole lot more testable, and a whole lot less abrupt.

Christ, if even FIPS went "we know this is a big thing, we'll give you
a decade to sort things out", then the kernel damn well shouldn't make
it some black-and-white sudden flag.

So we should *NOT* say "FIPS says turn it off eventually, so we should
turn it off". No. That was very very wrong.

We should say "FIPS says turn it off eventually, so we should give
users simple tools to find problem spots".

And that "simple tools" very much is about not making it some kind of
"Oh, what happens is that the machine is unusable". It should be that
"Oh, look, now it gives a warning that I would have a problem in XYZ
if it wasn't available".

                   Linus

