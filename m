Return-Path: <netdev+bounces-68479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF2B846FFD
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C871C26A60
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D299140788;
	Fri,  2 Feb 2024 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LpzTI4ob"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51504140771
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876226; cv=none; b=aGtNSztZousKwWaM44mi37gRz3CEE+WwfWb6kyHRX9p7ykKedPzgjIPdHUAEC0kvfs61W8018crNS/f0ykYQwL6HjWHTzNJdol3qNpJkQFdPQBcNUw6Re0s1IPDKu5mrTRS9skwom56CX/8AdBPxLa72GWeY7/i6nlfboLx0ars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876226; c=relaxed/simple;
	bh=6WMlixFsMD3YXZFA7X0TiodSA2ARpqznFCPL+NJ64J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI2sahJu98sKqdUWUXcSbmQGMCrGjFdlyEL/0trwl4/LWGCLF0PbTuVfk90bw7GVHOyegp/rC3FIVY2NFDsAeuvVs45gHm2Ba2s2YAgLcrPb0A3U2D2zazpk8Hvh74OjYb3igiwiVGnq/KJEsphivyV73LrJoXfrtVENTTCgwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LpzTI4ob; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29041136f73so1509852a91.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 04:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706876224; x=1707481024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ0esveh//cg9XCkiI/7xWePudzmiIjItwxrOruHVwk=;
        b=LpzTI4obYAxHG+Gkig1OmPJWjP1D7uCoxw6UBg4vbSrdCkGBoxM0DmUc7l0biBlLHO
         5WmQINucpkAfAX0/VONbedxa2YvfDqR8UPCIidaEWy5PTELhJMPbvyRbk1UctJFjqf5N
         KWD9EtZB5AjPgIhMX1zUwQFe8JOb42Vh8WwsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876224; x=1707481024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ0esveh//cg9XCkiI/7xWePudzmiIjItwxrOruHVwk=;
        b=nVXAwOPDj5OsokQQlLEbXWXIo8/lcLk+RCWfCOrCQaG2QfS5Xcs+/UzjZmhMpwN+iU
         tSUTLI5iY7xHN5lSWv93hNgl4wW6hZIBsZE5/zpQo4cM2L9R4sFdabJC4TMn2k16kSBY
         aozpUafAqMwTE521PbGU5yqGpNLvz7Utm+LW0V8i/Kwm60b8cpCu4d6CrdL5+dEKfn/M
         K7VK/y1P1BYDYpjhZwkluR4kddeDPEzQqlXu70UhG1XpYbfQ+lsGYeo8u95SEB/eBd/M
         Dm+liEdQ0DZlcZLlZv6VGG8u5u7orWSxYRTDngly0v/qovZNwq+7h3SaE5DpPjSgJ6T0
         DA8g==
X-Gm-Message-State: AOJu0YxeADCAir3KZkY5YnPljWDCAL8xjsw/PC9wzgFhWFbHrVRojk9T
	ve8fxYsn8Pi+Wo6FjXO6o0RdJXOw6W8Eyfz6aEkvAzIbUxOact+gp/ziPyJVhA==
X-Google-Smtp-Source: AGHT+IGg88zNLC34obB5/fOW4+rC0GoCG14stcT3rLU6L9HZrzANdbP1B4KMEzwmTO1dY9t5epZ2BQ==
X-Received: by 2002:a17:90b:1298:b0:296:1dcf:c296 with SMTP id fw24-20020a17090b129800b002961dcfc296mr1876188pjb.18.1706876223734;
        Fri, 02 Feb 2024 04:17:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUGVn+0c2h4HxapCQwK+CBO5gK3KOvlzIatkL3Eg+0hshg2pC4xRmXdAPGwrPO866Nj9YF+U6s6nJkm+zEO0B/JBsHbpfqLIrHUgGxhmDm7PR7dJOIlSKekZQeCfpS4kk6gdUCRy8AKy1koQcYXJUoBqPtoXthgUI8I+/eaEfrPbo4kflZwbchOOzcwU5swL0S6WdMTIJa+mw55to+6uV3nDPQwGmi8fzDIZ1/ceDsJxByCfPOeO0l/S81b9BgnbLDHSPgD7FlGPHvtp8Z/FomG1NkHrVilLrlukHP1pAw9wYKJnI22iJxJmSjYHmQniMGlZYsc/cdM58fBdkhFMawZoGvAvkTYiXvNll9VJlnJ8j/FX+IAuDXHo43itnq+OGQQdsBiGyQPYcczK3z4vcpWYVXqya3O7moVN8gWmQjkhvZgr8SZOqWDhbrhJgPiVmYM7CkU25sPa9I0PqKXD5aa7cvoHKmNkLXZ4/epetFyeC0sd5jBRU3IEcz8/3lo1E3SteGrn+6+Y/KEkJjGEjE/TlV+t7ZzrhslvL+T17oohFYN0g54YBk1TJzsBIkJwnqakFKkOfMS15bofbWnqaCKkx+rJlTObTtkF5AePTEEUWmqLLwa3jLiNLz4lnivpuzOGcGhWnPJl5a421rYycnirgqxJHh/cGTKPA8EmcYWycgZa67VxpoBN5oGlmkdby+KZtTF2BuWlV1VWF5HfxIzOVdG8qZz4Q257WM=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id su13-20020a17090b534d00b002927a36b7a0sm1671429pjb.23.2024.02.02.04.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:17:03 -0800 (PST)
Date: Fri, 2 Feb 2024 04:17:02 -0800
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Fangrui Song <maskray@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Bill Wendling <morbo@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/6] ubsan: Reintroduce signed and unsigned overflow
 sanitizers
Message-ID: <202402020405.7E0B5B3784@keescook>
References: <20240202101311.it.893-kees@kernel.org>
 <20240202101642.156588-2-keescook@chromium.org>
 <CANpmjNPPbTNPJfM5MNE6tW-jCse+u_RB8bqGLT3cTxgCsL+x-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPPbTNPJfM5MNE6tW-jCse+u_RB8bqGLT3cTxgCsL+x-A@mail.gmail.com>

On Fri, Feb 02, 2024 at 12:01:55PM +0100, Marco Elver wrote:
> On Fri, 2 Feb 2024 at 11:16, Kees Cook <keescook@chromium.org> wrote:
> > [...]
> > +config UBSAN_UNSIGNED_WRAP
> > +       bool "Perform checking for unsigned arithmetic wrap-around"
> > +       depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
> > +       depends on !X86_32 # avoid excessive stack usage on x86-32/clang
> > +       depends on !COMPILE_TEST
> > +       help
> > +         This option enables -fsanitize=unsigned-integer-overflow which checks
> > +         for wrap-around of any arithmetic operations with unsigned integers. This
> > +         currently causes x86 to fail to boot.
> 
> My hypothesis is that these options will quickly be enabled by various
> test and fuzzing setups, to the detriment of kernel developers. While
> the commit message states that these are for experimentation, I do not
> think it is at all clear from the Kconfig options.

I can certainly rephrase it more strongly. I would hope that anyone
enabling the unsigned sanitizer would quickly realize how extremely
noisy it is.

> Unsigned integer wrap-around is relatively common (it is _not_ UB
> after all). While I can appreciate that in some cases wrap around is a
> genuine semantic bug, and that's what we want to find with these
> changes, ultimately marking all semantically valid wrap arounds to
> catch the unmarked ones. Given these patterns are so common, and C
> programmers are used to them, it will take a lot of effort to mark all
> the intentional cases. But I fear that even if we get to that place,
> _unmarked_  but semantically valid unsigned wrap around will keep
> popping up again and again.

I agree -- it's going to be quite a challenge. My short-term goal is to
see how far the sanitizer itself can get with identifying intentional
uses. For example, I found two more extremely common code patterns that
trip it now:

	unsigned int i = ...;
	...
	while (i--) { ... }

This trips the sanitizer at loop exit. :P It seems like churn to
refactor all of these into "for (; i; i--)". The compiler should be able
to identify this by looking for later uses of "i", etc.

The other is negative constants: -1UL, -3ULL, etc. These are all over
the place and very very obviously intentional and should be ignored by
the compiler.

> What is the long-term vision to minimize the additional churn this may
> introduce?

My hope is that we can evolve the coverage over time. Solving it all at
once won't be possible, but I think we can get pretty far with the
signed overflow sanitizer, which runs relatively cleanly already.

If we can't make meaningful progress in unsigned annotations, I think
we'll have to work on gaining type-based operator overloading so we can
grow type-aware arithmetic. That will serve as a much cleaner
annotation. E.g. introduce jiffie_t, which wraps.

> I think the problem reminds me a little of the data race problem,
> although I suspect unsigned integer wraparound is much more common
> than data races (which unlike unsigned wrap around is actually UB) -
> so chasing all intentional unsigned integer wrap arounds and marking
> will take even more effort than marking all intentional data races
> (which we're still slowly, but steadily, making progress towards).
> 
> At the very least, these options should 'depends on EXPERT' or even
> 'depends on BROKEN' while the story is still being worked out.

Perhaps I should hold off on bringing the unsigned sanitizer back? I was
hoping to work in parallel with the signed sanitizer, but maybe this
isn't the right approach?

-- 
Kees Cook

