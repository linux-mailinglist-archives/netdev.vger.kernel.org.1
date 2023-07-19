Return-Path: <netdev+bounces-19199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BC9759F6A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 22:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E56281A3F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 20:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43131BB5E;
	Wed, 19 Jul 2023 20:16:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F9275C8
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 20:16:31 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7311FE9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 13:16:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so11974129e87.2
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689797786; x=1692389786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ReDr3/cUrrY5O6f157kS0Oes02zkOeh4YD/h5uR7Jps=;
        b=coi65PEzCV7rCDEfL1mpkcR6k+K28LAsBIXeiZTCZLjyw2Hy4j+ku4FXsXBZCMuun9
         P4YFf7zHA3iWFEyAOCYUleRCXXLr6ChxfuWsEDVI8+N1e2T11Lo54fctsXWy4wHwot4X
         ek09n/z1vP6HGncPkGB8YnuM4OcDKlXEa7zZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689797786; x=1692389786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReDr3/cUrrY5O6f157kS0Oes02zkOeh4YD/h5uR7Jps=;
        b=GvZh18gcgbix4n7ytkBAcgADFBSbfpci0/Hg022UiVmd75reMbrXV+of8BlarBaj6t
         B8oWcHdM0lyDa0dW+B2bwUfTqCSvN48sEnW7jxnGqlgSk9SGJ0c6ygkr9arU7qgshU3S
         u0jO7vSzfrxtjMfGvLb5Y0Q6fTjBoAR1oSQNQOmZYIH+/UrUfoQ+alLm+TUrdSgDmz0y
         Szoc5Hg+iiv0py8F65NuyXob/wKbukhIUJLNTbzf09+OCmP6gLkXczhYdgJatGXXetDV
         qp5Ay90Z5n8vKS2fNRaR+lL7f3xOgVKBm7fPFR9SZTCR3R3ab+EhC4FJO0XDG52p8D06
         TAZw==
X-Gm-Message-State: ABy/qLbbdYjOat047ZAy7LAym8plOiZeydw0sswJtpI4WPEvN9fk5DN6
	KFc9uRfXXOZyW4AvNZxn5p6gDcJr23YVA4+i7nx3GEnL
X-Google-Smtp-Source: APBJJlHNQgb54ib4lIQHtuiHA229s524hE3ZomoP9SxXZe3awMf2L6JXiVZYPpkQhOpMcfZ76CZ1tg==
X-Received: by 2002:a19:8c4b:0:b0:4f9:52f3:9a2b with SMTP id i11-20020a198c4b000000b004f952f39a2bmr541431lfj.54.1689797785934;
        Wed, 19 Jul 2023 13:16:25 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id h8-20020a05651211c800b004f9c44b3e6dsm1097593lfr.127.2023.07.19.13.16.25
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 13:16:25 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so15318e87.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 13:16:25 -0700 (PDT)
X-Received: by 2002:a05:6512:368c:b0:4fb:85ad:b6e2 with SMTP id
 d12-20020a056512368c00b004fb85adb6e2mr613569lfs.50.1689797784754; Wed, 19 Jul
 2023 13:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name> <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org>
In-Reply-To: <ZLg9HbhOVnLk1ogA@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jul 2023 13:16:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
Message-ID: <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
To: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Matt Whitlock <kernel@mattwhitlock.name>, 
	David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 19 Jul 2023 at 12:44, Matthew Wilcox <willy@infradead.org> wrote:
>
> So what's the API that provides the semantics of _copying_?

It's called "read()" and "write()".

Seriously.

The *ONLY* reason for splice() existing is for zero-copy. If you don't
want zero-copy (aka "copy by reference"), don't use splice.

Stop arguing against it. If you don't want zero-copy, you use read()
and write(). It really is that simple.

And no, we don't start some kind of crazy "versioned zero-copy with
COW". That's a fundamental mistake. It's a mistake that has been done
- several times - and made perhaps most famous by Hurd, that made that
a big thing.

And yes, this has been documented *forever*. It may not have been
documented on the first line, because IT WAS SO OBVIOUS. The whole
reason splice() is fast is because it avoids the actual copy, and does
a copy-by-reference.

That's still a copy. But a copy-by-reference is a special thing. If
you don't know what copy-by-reference is, or don't want it, don't use
splice().

I don't know how many different ways I can say the same thing.

IF YOU DON'T WANT ZERO-COPY, DON'T USE SPLICE.

IF YOU DON'T UNDERSTAND THE DIFFERENCE BETWEEN COPY-BY-VALUE AND
COPY-BY-REFERENCE, DON'T USE SPLICE.

IF YOU DON'T UNDERSTAND THE *POINT* OF SPLICE, DON'T USE SPLICE.

It's kind of a bit like pointers in C: if you don't understand
pointers but use them anyway, you're going to have a hard time. That's
not the fault of the pointers. Pointers are very very powerful. But if
you are used to languages that only do copy-by-value, you are going to
think they are bad things.

                  Linus

