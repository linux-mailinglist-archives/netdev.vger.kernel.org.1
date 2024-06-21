Return-Path: <netdev+bounces-105818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D409130D6
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 01:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD41286972
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 23:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AEC16F27D;
	Fri, 21 Jun 2024 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QqGJqM+w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C51C6F2F1
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 23:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719011942; cv=none; b=NkLwW1hoJTlY+E36X/nbdgePdnN2agUvPlFyPA0j8LOEj6ZKSG7SEouSeaGhaHuyqADVTLbR+NulvwuCDDYijaSyC1kR1UYhb9SfKEOjsoyNKKH8kfImF34SRt0lacxvNLLZYD66+iB+CRXQ8ufNjDyW3b6yVYswD1e75pOunR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719011942; c=relaxed/simple;
	bh=Gn3DJb+zESEJBowNLklC/dB4nSSMSWXbRChavmZhQhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H00s8/cpLxzmwQ5GUyTkcyFAFwOKHwHV9rPHxLMoUPZM+l5/0eA1LY3qILJaugC5CZFqreeV6t+b7CIhPw1ALairdk9upZXrO/lirCEGLpUE75nEZJ0hVks6DaKSBMnG8pyXBI3T5ZNINizowuKy514GvBZw9+e89aZmN8bWr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QqGJqM+w; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e72224c395so26336461fa.3
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719011939; x=1719616739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a2rnkJTBDtNIKWQQ680DNdljrfWh8lccsRjNGx9v3JY=;
        b=QqGJqM+wbL+wHdDaHSMKgpxw989b1Gc+RpxiFSHorpUOQtJZgU7HMg6loAByvfBl5+
         PKYBh3wCfZEJxlpB/1q6R1KZzOzq2tnkSrxVmVxJyyQobzT8TyfxtU4qlaXpap7muKw/
         TVPd4zkDtpcZOiRHyKKvFqBPqUykgbrXOMVkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719011939; x=1719616739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2rnkJTBDtNIKWQQ680DNdljrfWh8lccsRjNGx9v3JY=;
        b=dlQZHWMk6+B/0iJ34gMBuh32yiIQw3Wagc3BfL/W0hXpjoWlangGdJ57mUh/3pZBm6
         /H+0DNw0LgvXpbVjz6Iy2ugESbNAGxzya5NWHPhhRlgh4ojzmRmqIT5C910IQwzDOVRM
         jCh+SsK2RcHsdWkWqk+wqkF+f+62WC5/KJrLbZt86rBAkTztL4tbJ2Yn0JNj2wked5nz
         tsKNnFg+XInhhdVtg0gy/vx4IVlAecg2L85gD0WUomt1+PObrgsgsHMDBPqcbDmjJ7Lh
         TlkMIqIF+lYq77IXzVdMEFNUZjW8Zgf5QpQmxJhT3MREQoqJKBHS0upFEdFMJ8xnQ4VR
         eeFw==
X-Forwarded-Encrypted: i=1; AJvYcCWW9CUpYgcbTAzT+x6RRK6cUizGGrU7pmDCbNJy0tYS16jVLelPbA3XwWVFscrp4WzGG8XxILOzzsP5Sw0Q2s4uwV9gtFXf
X-Gm-Message-State: AOJu0YyEMaNjm7e9PXfBEESmzIO7MR4uwDr3XHgCZ6uBIPLlTRzJd/u3
	vVoDRKwpG3Z3/fncgDAfvmonb8y6yJyJ1yo9DYt9e8dNbwDmOgp8FniKwec80TxYCRngsIwqYSR
	n5NY66g==
X-Google-Smtp-Source: AGHT+IH/jscsdOd369smyg3MgFEWvZzE6Kw04cGVJQNoGiN4OFCs3J3jGHTDvDjAEP6DFVHVs+Q9Ow==
X-Received: by 2002:ac2:4c4a:0:b0:523:8cd3:42cb with SMTP id 2adb3069b0e04-52ccaa59926mr7448820e87.7.1719011938560;
        Fri, 21 Jun 2024 16:18:58 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63b4bfdsm341464e87.11.2024.06.21.16.18.58
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 16:18:58 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec10324791so27606651fa.1
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 16:18:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8fAE736nkIdYIm/G9Znhi2vHqjW40J3kNHIHt3DEhTYgo7jKFAuNKAxPUKFXhFIy84BUzM0m4NRq8m07xYjUNt9rrQvOv
X-Received: by 2002:a2e:9a86:0:b0:2ec:3206:57e4 with SMTP id
 38308e7fff4ca-2ec3ceb7d18mr65006831fa.15.1719011937769; Fri, 21 Jun 2024
 16:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621211819.1690234-1-yabinc@google.com> <ZnYAQhNjVEvFlkdY@gondor.apana.org.au>
In-Reply-To: <ZnYAQhNjVEvFlkdY@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Jun 2024 16:18:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWXCP9Jn=y=MXot3T6sECEyK5nTmuvT=WDQM9h_NtJqA@mail.gmail.com>
Message-ID: <CAHk-=whWXCP9Jn=y=MXot3T6sECEyK5nTmuvT=WDQM9h_NtJqA@mail.gmail.com>
Subject: Re: [PATCH v2] Fix initializing a static union variable
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Yabin Cui <yabinc@google.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 15:36, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Jun 21, 2024 at 02:18:19PM -0700, Yabin Cui wrote:
> > saddr_wildcard is a static union variable initialized with {}.
> >
> > Empty brace initialization of union types is unspecified prior to C23,
> > and even in C23, it doesn't guarantee zero initialization of all fields
> > (see sections 4.5 and 6.2 in
> > https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2900.htm).
>
> What about all the other places in the kernel that use the same
> idiom? A grep shows that there are more than a hundred spots in
> the kernel where {} is used to initialise a union.

The important part is not what the standards text says - we happily
use things like inline asms that are entirely outside the standard -
but that apparently clang silently generates bogus code.

And from my admittedly _very_ limited testing, it's not that clang
always gets this wrong, but gets this wrong for a very particular
case: where the first field is smaller than the other fields.

And when the union is embedded in a struct, the struct initialization
seems to be ok from a quick test, but I might have screwed that test
up.

Now, it's still a worry, but I just wanted to point out that it's not
necessarily that *every* case is problematic.

Also, the problem Yabin found isn't actually limited to the empty
initializer. It happens even when you have an explicit zero in there.
All you need is _any_ initializer that doesn't initialize the whole
size.

End result: the "empty initializer" is a red herring and only relevant
to that standards paperwork.

So empty initializers are not relevant to the actual bug in question,
and I actually think that commit message is actively misleading in
trying to make it be about some "Linux isn't following standatrds".

But that also means that searching for empty initializers isn't going
to find all potential problem spots.

Notice how the suggested kernel patch was to remove the initializer
entirely, and just rely on "static variables are always zero" instead.

I don't know how to detect this problem case sanely, since the clang
bug occurs with non-static variables too, and with an actual non-empty
initializer too.

           Linus

