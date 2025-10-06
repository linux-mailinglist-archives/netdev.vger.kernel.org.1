Return-Path: <netdev+bounces-228017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 342CFBBF181
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 21:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A655C4E13FE
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 19:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DEC1A9FA4;
	Mon,  6 Oct 2025 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hlmgABmo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89C63208
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779011; cv=none; b=VCYFO5FWkYrQwKz0eTzK+ss719TJ3Smtj7kMY8QscZ9jCQsFfqa+BZvaoCmsfrMwgn+BNZURoWB61nc8AhwIjHkq5QJPqcTv3hLTEmRwpZomB/XKaZvmNW91YbeEsTCKdWYEAm+i+RQliiQ5Ygye0OJFI1O9+yyEvFp0HVRKlzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779011; c=relaxed/simple;
	bh=oJtnpIg+R+qK4oiapz5pJH9B6d0O7u0uKM9fGnb29to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AICxqX/JBR7jzc6WDdvBXhl9XzjJ1dmRt9nDyCGTctxtlMC7JBLoMPoR2l3fqGZ8qi+gpGpSVuh0kjW1PpvlSf3ipMyRvsNoD8w8wvWDGaA8R3zdWWacOQvjraLkFifctIJ2KhmLO/Cp0o4JDKbwFXyAoFlRV2sEBQwFa59jNAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hlmgABmo; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1104980966b.1
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 12:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759779007; x=1760383807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fx1K28q8EZoOq6NcrsSqSFqNryQpu7AB3eVtIUWzySE=;
        b=hlmgABmoliRHyqK3HeIKpf0pPJTok2vWg+xZMjTqGfKcIKDIILM7NmP1oe6XY5i/z1
         3fLN8N59zjAKXqhwNLzqv4rYpLLBA7Sw1WqgudU2TIpmRFe3S7c43nbdPkPtzm9BcKV3
         vQSGHn+TI2LaeHUXKU2TN+FnDdeoiso9+VDx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759779007; x=1760383807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fx1K28q8EZoOq6NcrsSqSFqNryQpu7AB3eVtIUWzySE=;
        b=dboxz/3Fi2Sjp59LKV0krJKB7jllUgBQNb1NwgISeW0ObuZ7Gv7MMys6oegnox0BFy
         VcQqB0Nm/LYjNvej9hGsEZA+uAXnJdPfl1N/VIc03MqU/2NPOHoZmuQ5HLKycMwB2j5/
         foj4AgAwiixm2fCIoLfm6xlEhYQcrC8vJNAhZ15ov257P9v/9s5vCeBORdDUgUeBCpBz
         +9TAXtaIZTUzLTmW6nT8KuBnTjBnbwjfXHvZBjxjEmu4rsaZKEVdZWad9XztaUlf7hcD
         u/T7SG1jZPI/d0Eynw5mTKXuc1Pk61VNzdi6HKcngaJ9O13rSuuNU7nGVIr0nM43WJJr
         IgEw==
X-Forwarded-Encrypted: i=1; AJvYcCXOnNXxpzjFoeVFO7bKbFe0dDWVZIrKg7rcYhCp8AA3dzD8bx4jA3XxAj8oKoU6LcRQV6pm+RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJM3a0f/2e+j3z8g+wt+2IEghoDor5mLwe2XX+stksm4XQ9ic6
	RJJ/oleJiOGSiHRcQtNaTlDNaLCxlMIWe+Y7K7DQuQLLlaBiN/4BvWHdSOKg8DSggKAdPv8ONrU
	4uMDNeoI=
X-Gm-Gg: ASbGncufbDY4dIMtqLjaTgN6uEGJ4gRxQgKm35k1MJ/qlBHYiv8D2EJcLFlYff52yv8
	SZnlV3g3rwMGDxgZMcBkEdRHVrQPOrvN7NeQQ5RxozNUTv5SV7AvnwofcQMy12N4q7BxwU01E65
	g+Q6tNJKD36/SbpzjgvanHb6SG1Qf1gid8++kODqkceKhgYJI4c/8hCI7SB8cTJWOUuxo58IXaN
	3OymSQUWtZWXy3LtLeX2MsZa/XLViR3MeeJXwBGx8DzRMrCE9F6VrYl8+LJm9ZnYDK/gTrFlwAU
	J0Nf1EYpUfMJCUXZqxonpnUa8/7za8oVDQPogUusV0RMIQe3osQvOQkfLd8qCSjJujCh8kzlaVl
	4MM7+mq9eEK+PZzE0SyE6x6iKjNtZa7WEtTvI89k/HqjOPvh814P1TdlST5vZVRBq6/Wvj6d74Y
	s8y4KqMCCXMzr9vnuUbg5JyRfbweDLBFY=
X-Google-Smtp-Source: AGHT+IG5a2JoB6MPALuGu/sxJ7xG4xlsOI956yhNYLfwsMrziOKcdpDwwoXsX4S0GUsZbzmigwPUxg==
X-Received: by 2002:a17:907:9702:b0:b45:66f6:6a16 with SMTP id a640c23a62f3a-b49c5273641mr1435817066b.65.1759779006564;
        Mon, 06 Oct 2025 12:30:06 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b32bsm1234610466b.50.2025.10.06.12.30.04
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 12:30:04 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so10988597a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 12:30:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFe1OMq/a0ByYTZ501hDxIOCgsXjL9bkZzO0qrSNzASr+Bpw9Qi773dMlZlXUt2p4eVh3dWxc=@vger.kernel.org
X-Received: by 2002:a05:6402:3508:b0:634:bdde:d180 with SMTP id
 4fb4d7f45d1cf-639348de6a9mr15286102a12.10.1759779004368; Mon, 06 Oct 2025
 12:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIirh_7k4SWzE-bF@gondor.apana.org.au> <05b7ef65-37bb-4391-9ec9-c382d51bae4d@kernel.org>
 <aN5GO1YLO_yXbMNH@gondor.apana.org.au> <562363e8-ea90-4458-9f97-1b1cb433c863@kernel.org>
 <8bb5a196-7d55-4bdb-b890-709f918abad0@kernel.org> <1a71398e-637f-4aa5-b4c6-0d3502a62a0c@kernel.org>
 <f31dbb22-0add-481c-aee0-e337a7731f8e@oracle.com> <20251002172310.GC1697@sol>
 <2981dc1d-287f-44fc-9f6f-a9357fb62dbf@oracle.com> <CAHk-=wjcXn+uPu8h554YFyZqfkoF=K4+tFFtXHsWNzqftShdbQ@mail.gmail.com>
 <3b1ff093-2578-4186-969a-3c70530e57b7@oracle.com> <CAHk-=whzJ1Bcx5Yi5JC57pLsJYuApTwpC=WjNi28GLUv7HPCOQ@mail.gmail.com>
 <e1dc974a-eb36-4090-8d5f-debcb546ccb7@oracle.com>
In-Reply-To: <e1dc974a-eb36-4090-8d5f-debcb546ccb7@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 12:29:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7TAP8fD42m_eaHE23ywfp7Y2ciqeGC=ULsKbuVTdMrg@mail.gmail.com>
X-Gm-Features: AS18NWDFEycobIg3uvQ3ZOEKPRIEa2VRgJ-r9kp-mkVxA6gr2b-Ogc2Dp8E1ZOA
Message-ID: <CAHk-=wj7TAP8fD42m_eaHE23ywfp7Y2ciqeGC=ULsKbuVTdMrg@mail.gmail.com>
Subject: Re: 6.17 crashes in ipv6 code when booted fips=1 [was: [GIT PULL]
 Crypto Update for 6.17]
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, "nstange@suse.de" <nstange@suse.de>, 
	"Wang, Jay" <wanjay@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 12:12, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> Yes, thank you, I've already acknowledged that my patch caused boot
> failures and I apologize for that unintentional breakage. Why does this
> mean we should throw fips=1 in the bin, though?

That's not what I actually ever said.

I said "as long as it's that black-and-white". You entirely ignored that part.

THAT was my point. I don't think it makes much sense to treat this as
some kind of absolute on/off switch.

So I would suggest that "fips=1" mean that we'd *WARN* about use of
things like this that FIPS says should be off the table in 2031.

The whole "disable it entirely" was a mistake. That's obvious in
hindsight. So let's *learn* from that mistake and stop doing that.

If somebody is in a situation where they really need to disable SHA1,
I think they should hard-disable it and just make sure it doesn't get
compiled in at all.

But for the foreseeable immediate future, the reasonable thing to do
is AT MOST to warn about fips rules, not break things.

Because the black-and-white thing is obviously broken. One boot
failure was enough - we're *NOT* doubling down on that mistake.

                Linus

