Return-Path: <netdev+bounces-48111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B969F7EC901
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7510B281597
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71853EA72;
	Wed, 15 Nov 2023 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XKo7BfFs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF24535EFB
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 16:59:10 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314D1FA
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:59:08 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso10007928e87.2
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700067546; x=1700672346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ac4Ls6gftQvQgbcRf5XLhX5PwcgnIwraX4CtQN05HrE=;
        b=XKo7BfFsmcb0YnmWGpFnRQNbI2Ieviv+2uP/0392a453G8aponkQClciBNjNx83HvJ
         otRxo545V4Qaj3CIzSwU9Nu3f9Hi1VuVhDDc3eVgvL+7UiuqvYnXeRvozTm4NBl4NcDf
         1b0+PoQFPZN2fbqXb/iAYA+fXVjOg9nCJA2Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067546; x=1700672346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ac4Ls6gftQvQgbcRf5XLhX5PwcgnIwraX4CtQN05HrE=;
        b=FUjrV24yNVQW4tgA7gb9AkApg9aMStPAw/FhMway8wD19nhC7gZQVWFLwQCSUt3kDh
         qx6BZO66S2gX5p2RCR7ac+EW3aKsqI877d2+mxSWKw5Yd2h9T4Fa15rLUfD/sXNOWFUD
         fA+/jAupLblr1RY4CHd81CV2VJM/zmy5hPikt2LB2QDQW5UaCWxMcx1qRfwM5Bh1v3I4
         qfETScLTV/LGTAP+1F4WH+LB/Fzcx8CpwFmTew4GBpgkSmOjSBdTYFyLNxreLSdYqNEc
         FGJ4jZ0nz+qUEPUJJ3s0H471hFaCgysfGW1QuuEEbVKxcgkQkMbRfldZq9YOdzEPuVI1
         N7GQ==
X-Gm-Message-State: AOJu0YyQl9R5TSxNfdLl//eEBpL5CQmwf859yT4NbuUe1xyyns21pKzy
	RgZMqZx+39Fqr9UNozDpFd9V+8ohuC3Hn/+zzqK8cyS+
X-Google-Smtp-Source: AGHT+IGmzQgDlsIajpfAKGWm7KIbLzuoWkgkhT1onJBenDhACv4fn7xZSmooCi2dFguYFx1YDFrIBA==
X-Received: by 2002:ac2:4e0a:0:b0:502:d743:9fc4 with SMTP id e10-20020ac24e0a000000b00502d7439fc4mr11833501lfr.37.1700067546469;
        Wed, 15 Nov 2023 08:59:06 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id f21-20020ac25335000000b004fb7848bacbsm1686733lfh.46.2023.11.15.08.59.05
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:59:06 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-507975d34e8so10008882e87.1
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:59:05 -0800 (PST)
X-Received: by 2002:a19:7119:0:b0:507:9787:6773 with SMTP id
 m25-20020a197119000000b0050797876773mr9107681lfc.36.1700067545585; Wed, 15
 Nov 2023 08:59:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com> <20231115154946.3933808-6-dhowells@redhat.com>
 <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com> <3936726.1700066370@warthog.procyon.org.uk>
In-Reply-To: <3936726.1700066370@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Nov 2023 11:58:48 -0500
X-Gmail-Original-Message-ID: <CAHk-=whEj_+oP0mwNr7eArnOzWf_380-+-6LD9RtQXVs29fYJQ@mail.gmail.com>
Message-ID: <CAHk-=whEj_+oP0mwNr7eArnOzWf_380-+-6LD9RtQXVs29fYJQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] iov_iter: Create a function to prepare userspace
 VM for UBUF/IOVEC tests
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, loongarch@lists.linux.dev, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 11:39, David Howells <dhowells@redhat.com> wrote:
>
> I was trying to make it possible to do these tests before starting userspace
> as there's a good chance that if the UBUF/IOVEC iterators don't work right
> then your system can't be booted.

Oh, I don't think that any unit test should bother to check for that
kind of catastrophic case.

If something is so broken that the kernel doesn't boot properly even
into some basic test infrastructure, then bisection will trivially
find where that breakage was introduced.

And if it's something as core as the iov iterators, it won't even get
past the initial developer unless it's some odd build system
interaction.

So extreme cases aren't even worth checking for. What's worth testing
is "the system boots and works, but I want to check the edge cases".

IOW, when it comes to things like user copies, it's things like
alignment, and the page fault edge cases with EFAULT in particular.
You can easily get the return value wrong for a user copy that ends up
with an unaligned fault at the end of the last mapped page. Everything
normal will still work fine, because nobody does something that odd.

But those are best handled as user mode tests.

           Linus

