Return-Path: <netdev+bounces-19197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D0759F19
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43112819FE
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75D51BB58;
	Wed, 19 Jul 2023 19:56:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA0275DF
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:56:59 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C83E92
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:56:58 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e56749750so10043885a12.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1689796616; x=1692388616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCAWdeG436mH+DfARvo16QjhMFi/Eb5+1UBeyzzjyUI=;
        b=KDf25kUkA8y5VPkkc7HrbMTq3b2TUQ9qV1Rqf5zm3CstAGUdbu1d6TNxedY+pIsa7j
         2FZ1elHv1v1po8knHje3+LiAmx8Xahh5ExqZRnI0mXGfRX7m3EFLlyAK10LkH8G1Mz8+
         NL2rNXbVT3ccaArlkF+ebJlcCMIxueJ9R+uLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689796616; x=1692388616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCAWdeG436mH+DfARvo16QjhMFi/Eb5+1UBeyzzjyUI=;
        b=G+6KOee8nT7fqMPe7q2MkHu6BsN8DkNSuB25Be0zK2tsfBKIcZ03luonVBSWVJRLW4
         DRrsMBQMSxApxMASUsVhyJZ1uojNcljhgS035Ka7qXhMTtU79LsDfZfrR3Vpnzjai9GX
         kUz7KsOUdrNUYfp5Pt10rJlgd1XKrsgfb2ggava61dL+OqeplpskLLMzCxNFs1U0NDro
         TEyDBjXGjJJP/lpq9RG9NQm5AjDNeYBDi07d2szTb2uqjYYXZ/1gC4znwbBbf5Lo53Uz
         13Ev74QHi2lUtJb2AQ5WgmBmLqriaq/JkUZhi856mbJbz0Eiq7LwFjXp4R0bU1J1HCyr
         Hd6w==
X-Gm-Message-State: ABy/qLY3YZFFYmY6VwbvBxxPkKVyVFwGdOQGhXfRdpgcZhf23uz+6tE0
	F25WUtqicFrl4gfJkH6ImT+nLkmo6UokbJH/iIq5PA==
X-Google-Smtp-Source: APBJJlHY/0j9zo7xINflNaeK8tuqOdnpsiGywd4+hJhWLhzGqpSvrN0Bo9bC2obyVshWt0JU/Kz9CjVIL8pOynOaHLU=
X-Received: by 2002:a17:906:7485:b0:993:f497:adbe with SMTP id
 e5-20020a170906748500b00993f497adbemr4056662ejl.19.1689796616378; Wed, 19 Jul
 2023 12:56:56 -0700 (PDT)
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
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 19 Jul 2023 21:56:44 +0200
Message-ID: <CAJfpegtYQXgAyejoYWRVkf+9y91O70jaTu+mm+3zhnGPJhKwcA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
To: Matthew Wilcox <willy@infradead.org>
Cc: Matt Whitlock <kernel@mattwhitlock.name>, David Howells <dhowells@redhat.com>, 
	netdev@vger.kernel.org, Dave Chinner <david@fromorbit.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 19 Jul 2023 at 21:44, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jul 19, 2023 at 09:35:33PM +0200, Miklos Szeredi wrote:
> > On Wed, 19 Jul 2023 at 19:59, Matt Whitlock <kernel@mattwhitlock.name> =
wrote:
> > >
> > > On Wednesday, 19 July 2023 06:17:51 EDT, Miklos Szeredi wrote:
> > > > On Thu, 29 Jun 2023 at 17:56, David Howells <dhowells@redhat.com> w=
rote:
> > > >>
> > > >> Splicing data from, say, a file into a pipe currently leaves the s=
ource
> > > >> pages in the pipe after splice() returns - but this means that tho=
se pages
> > > >> can be subsequently modified by shared-writable mmap(), write(),
> > > >> fallocate(), etc. before they're consumed.
> > > >
> > > > What is this trying to fix?   The above behavior is well known, so
> > > > it's not likely to be a problem.
> > >
> > > Respectfully, it's not well-known, as it's not documented. If the spl=
ice(2)
> > > man page had mentioned that pages can be mutated after they're alread=
y
> > > ostensibly at rest in the output pipe buffer, then my nightly backups
> > > wouldn't have been incurring corruption silently for many months.
> >
> > splice(2):
> >
> >        Though we talk of copying, actual copies are generally avoided.
> > The kernel does this by implementing a pipe buffer as a set  of
> > refer=E2=80=90
> >        ence-counted  pointers  to  pages  of kernel memory.  The
> > kernel creates "copies" of pages in a buffer by creating new pointers
> > (for the
> >        output buffer) referring to the pages, and increasing the
> > reference counts for the pages: only pointers are copied, not the
> > pages of the
> >        buffer.
> >
> > While not explicitly stating that the contents of the pages can change
> > after being spliced, this can easily be inferred from the above
> > semantics.
>
> So what's the API that provides the semantics of _copying_?

What's your definition of copying?

Thanks,
Miklos

