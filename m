Return-Path: <netdev+bounces-14636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B25742C73
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2361C209FB
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D344713AD4;
	Thu, 29 Jun 2023 18:53:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7075134C6
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 18:53:34 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D71CB9
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 11:53:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9924ac01f98so130282366b.1
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688064811; x=1690656811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiqBI6HJiAQKTdUamzsYg0eRal+ETXSDiBXUd1jkkc8=;
        b=DBh/dJlAnYjrWVHe2S0hSw3z8FR2ILmnwnvz5iL9rHZaAh/43qoHsnskAOP07F9xqj
         rJhtJC1pu5gSVKdMJCMlNKxn/ZFYMN7mnaOiL+4QJv/HmM48EAFnJDdKLV0ellkV98OV
         Qn0jMNS02qDNVTR5Clzfw+ALGFNXxGiOylv7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688064811; x=1690656811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiqBI6HJiAQKTdUamzsYg0eRal+ETXSDiBXUd1jkkc8=;
        b=lMMkOqnjz+2EX4FtnuNrhub+X4+fYdhomJweiYRh9pNoANMkjq7u13zQxQtp0w6xdK
         8XFEULL8zzVtbmMoOYWGDieuKuQKkHYX+8DhpvrhvSebCltLW2uJP7pGpvWHcrXpu2Kz
         jPHyzP3+JeZ8EVZGOl0iDTLzx14+cA75cywfrLhDj04rr7zJX55hdjHAKwG1lEk/SVpN
         zB27/1/VyiwmOaCD20fKtbdcNlIrg/rywShfGgPmHU9o3tYkazUPrphNhvFX/wgEgFhT
         IHsYPvdmeRSY9QeDEOu6KWi6LqnVfNH2DngDZhaUIlY8obKcF4wVqFQiLEimhn7R+XsZ
         s2/A==
X-Gm-Message-State: ABy/qLZ+AMMsR3vllbRO8j4PSxop8g2dFQSvWn7MdnI9J+WICSVPOx2H
	xPRDxiLjq6qUURa2cvcNFFafkD1yMtEAiXtzBDfiElv7
X-Google-Smtp-Source: APBJJlF1eOlBx08h/zHfDDdN8EUFtmqy0KKul7yu3/TxgQVx06Z9W4TmmYVuDB7/uu44ZFHCIDkv+A==
X-Received: by 2002:a17:906:ae51:b0:991:e5a5:cd4b with SMTP id lf17-20020a170906ae5100b00991e5a5cd4bmr218441ejb.56.1688064811397;
        Thu, 29 Jun 2023 11:53:31 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id bm4-20020a170906c04400b00973ca837a68sm7151542ejb.217.2023.06.29.11.53.30
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 11:53:30 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51de841a727so467444a12.3
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 11:53:30 -0700 (PDT)
X-Received: by 2002:aa7:d450:0:b0:51d:8953:1c89 with SMTP id
 q16-20020aa7d450000000b0051d89531c89mr100997edr.8.1688064809998; Thu, 29 Jun
 2023 11:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <CAHk-=wiDwfyj0CCupT-oEToqsNLcbsTQdcgDupF=ZETUjJQJtQ@mail.gmail.com>
 <4bd92932-c9d2-4cc8-b730-24c749087e39@mattwhitlock.name> <CAHk-=whYWEUU69nY6k4j1_EQnQDNPy4TqAMvpf1UA111UDdmYg@mail.gmail.com>
 <ZJ3OoCcSxZzzgUur@casper.infradead.org>
In-Reply-To: <ZJ3OoCcSxZzzgUur@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 Jun 2023 11:53:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjixHw6n_R5TQWW1r0a+GgFAPGw21KMj6obkzr3qXXbYA@mail.gmail.com>
Message-ID: <CAHk-=wjixHw6n_R5TQWW1r0a+GgFAPGw21KMj6obkzr3qXXbYA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
To: Matthew Wilcox <willy@infradead.org>
Cc: Matt Whitlock <kernel@mattwhitlock.name>, David Howells <dhowells@redhat.com>, 
	netdev@vger.kernel.org, Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@kvack.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 29 Jun 2023 at 11:34, Matthew Wilcox <willy@infradead.org> wrote:
>
> I think David muddied the waters by talking about vmsplice().  The
> problem encountered is with splice() from the page cache.  Reading
> the documentation,
>
>        splice()  moves  data  between two file descriptors without copyin=
g be=E2=80=90
>        tween kernel address space and user address space.  It transfers u=
p  to
>        len bytes of data from the file descriptor fd_in to the file descr=
iptor
>        fd_out, where one of the file descriptors must refer to a pipe.

Well, the original intent really always was that it's about zero-copy.

So I do think that the answer to your test-program is that yes, it
really traditionally *should* output "new".

A splice from a file acts like a scatter-gather mmap() in the kernel.
It's the original intent, and it's the whole reason it's noticeably
faster than doing a write.

Now, do I then agree that splice() has turned out to be a nasty morass
of problems?  Yes.

And I even agree that while I actually *think* that your test program
should output "new" (because that is the whole point of the exercise),
it also means that people who use splice() need to *understand* that,
and it's much too easy to get things wrong if you don't understand
that the whole point of splice is to act as a kind of ad-hoc in-kernel
mmap thing.

And to make matters worse, for mmap() we actually do have some
coherency helpers. For splice(), the page ref stays around.

It's kind of like GUP and page pinning - another area where we have
had lots of problems and lots of nasty semantics and complications
with other VM operations over the years.

So I really *really* don't want to complicate splice() even more to
give it some new semantics that it has never ever really had, because
people didn't understand it and used it wrong.

Quite the reverse. I'd be willing to *simplify* splice() by just
saying "it was all a mistake", and just turning it into wrappers
around read/write. But those patches would have to be radical
simplifications, not adding yet more crud on top of the pain that is
splice().

Because it will hurt performance. And I'm ok with that as long as it
comes with huge simplifications. What I'm *not* ok with is "I mis-used
splice, now I want splice to act differently, so let's make it even
more complicated".

               Linus

