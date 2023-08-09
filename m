Return-Path: <netdev+bounces-25995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EE6776608
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 19:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94477281E48
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013021DA57;
	Wed,  9 Aug 2023 17:02:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F391CA13
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 17:02:12 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB49211F
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 10:02:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso11454790e87.0
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691600529; x=1692205329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjIM/ijvSM8/MDaGJoo16Y0WNhCaEmIRqKMsiPBM2wM=;
        b=T9ZQUjKWWfmPZqDf3wQWwhBnsSq5HwjyhNx06C/Qs/b28tTqhURb6KY/+OUCVNp/Kr
         KzUuXVC7p/fUclfJcpjpvo81oHhy4+HJjBrSTAMzEvoAgIUvccLqdLKmzC63krToqn39
         4SakwAuGj/80v9DUUFGzdqpfH8AcWRQD/7m/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600529; x=1692205329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjIM/ijvSM8/MDaGJoo16Y0WNhCaEmIRqKMsiPBM2wM=;
        b=IC8/PFkSDGm+E3cykUqQFGeYbySbWHQNBsEDYl1vaRd3SGNPYBZrA9S6rPTWmeUGF9
         pG3BaM3KPd2XRUYoqtGVugQCBhvu6tE4kKQ5RGtxc1yC9NVBNQgfujgrEW7VKllsNK8b
         XagSDOKhi2krCJX9kx3CU+9x6RNeQWXi13mBEAMNkG5FUf+HLY9nhqMwHsuNsgQP3yfY
         LL87CqLtk7b+7QH720Vio+3dIg4/V09Za+n44OOjxL9g67Crz1Z8ePODixWMPd2yJOFP
         7zw79yeqI1YPXBLPZbcSUgUpWW+ZXEdHowsYvSlW+XZs2DOjiKMeSD2FNE/iMXAi76BN
         ZzAA==
X-Gm-Message-State: AOJu0YyvivzKqX0zviLhTPMdhVvhXbtijcjV7P6FPqiXJblrMli7nr8M
	lZCBTFXERJWhvfZWACcr3g81+PDGhUHtTC2bgOL1id+S
X-Google-Smtp-Source: AGHT+IFrB98dVzsBIMwcUIDAmwbKVrICYqKQ2nVveX21ORiYEhglISeoofSp0LcpC/Z9dW52RY2lYg==
X-Received: by 2002:a05:651c:105:b0:2b9:edcd:8770 with SMTP id a5-20020a05651c010500b002b9edcd8770mr2331192ljb.43.1691600528879;
        Wed, 09 Aug 2023 10:02:08 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id g21-20020a1709061e1500b009920a690cd9sm8234349ejj.59.2023.08.09.10.02.08
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 10:02:08 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99c136ee106so11754266b.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 10:02:08 -0700 (PDT)
X-Received: by 2002:a17:906:7486:b0:99b:4bab:2844 with SMTP id
 e6-20020a170906748600b0099b4bab2844mr2356279ejl.55.1691600527705; Wed, 09 Aug
 2023 10:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87edkce118.wl-tiwai@suse.de> <20230809143801.GA693@lst.de>
 <CAHk-=wiyWOaPtOJ1PTdERswXV9m7W_UkPV-HE0kbpr48mbnrEA@mail.gmail.com> <87wmy4ciap.wl-tiwai@suse.de>
In-Reply-To: <87wmy4ciap.wl-tiwai@suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Aug 2023 10:01:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-mUL6mp4chAc6E_UjwpPLyCPRCJK+iB4ZMD2BqjwGHA@mail.gmail.com>
Message-ID: <CAHk-=wh-mUL6mp4chAc6E_UjwpPLyCPRCJK+iB4ZMD2BqjwGHA@mail.gmail.com>
Subject: Re: [PATCH RFC] Introduce uniptr_t as a generic "universal" pointer
To: Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 9 Aug 2023 at 09:05, Takashi Iwai <tiwai@suse.de> wrote:
>
> OTOH, it simplifies the code well for us; as of now, we have two
> callbacks for copying PCM memory from/to the device, distinct for
> kernel and user pointers.  It's basically either copy_from_user() or
> memcpy() of the given size depending on the caller.  The sockptr_t or
> its variant would allow us to unify those to a single callback.

I didn't see the follow-up patches that use this, but...

> (And yeah, iov_iter is there, but it's definitely overkill for the
> purpose.)

You can actually use a "simplified form" of iov_iter, and it's not all that bad.

If the actual copying operation is just a memcpy, you're all set: just
do copy_to/from_iter(), and it's a really nice interface, and you
don't have to carry "ptr+size" things around.

And we now have a simple way to generate simple iov_iter's, so
*creating* the iter is trivial too:

        struct iov_iter iter;
        int ret = import_ubuf(ITER_SRC/DEST, uptr, len, &iter);

        if (unlikely(ret < 0))
                return ret;

and you're all done. You can now pass '&iter' around, and it has a
nice user pointer and a range in it, and copying that thing is easy.

Perhaps somewhat strangely (*) we don't have the same for a simple
kernel buffer, but adding that wouldn't be hard. You either end up
using a 'kvec', or we could even add something like ITER_KBUF if it
really matters.

Right now the kernel buffer init is a *bit* more involved than the
above ubuf case:

        struct iov_iter iter;
        struct kvec kvec = { kptr, len};

        iov_iter_kvec(&iter, ITER_SRC/DEST, &kvec, 1, len);

and that's maybe a *bit* annoying, but we could maybe simplify this
with some helper macros even without ITER_KBUF.

So yes, iov_iter does have some abstraction overhead, but it really
isn't that bad. And it *does* allow you to do a lot of things, and can
actually simplify the users quite a bit, exactly because it allows you
to just pass that single iter pointer around, and you automatically
have not just the user/kernel distinction, you have the buffer size,
and you have a lot of helper functions to use it.

I really think that if you want a user-or-kernel buffer interface, you
should use these things.

Please? At least look into it.

                 Linus

(*) Well, not so strange - we've just never needed it.

