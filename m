Return-Path: <netdev+bounces-28933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E785D78130F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A077B2824C5
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FFB1B7C2;
	Fri, 18 Aug 2023 18:48:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682EC19BB0
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:48:21 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FE74202
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:48:18 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6889288a31fso869951b3a.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692384498; x=1692989298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GP1DcfQVRyZ/pIKJy2r3P+ha5kBKzRQgOLNbP0+yBQs=;
        b=ePIhLMmxprOtmHRcgmlOpi4JqeUCi+e4RdG8FfoL1iL+oNcVBkj0XqtQJnTQxIBI4k
         N240Kufklz5cX2Cv3kEJRxkj6dAYrBnfvoOljZRepjUqNAMdn2IvVDKUNd3y9Lk1Zsx/
         1ujg1FJNf2ZXsaWwM9P4BvfmM5oo41BjtKtEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692384498; x=1692989298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GP1DcfQVRyZ/pIKJy2r3P+ha5kBKzRQgOLNbP0+yBQs=;
        b=koXLC7F3wKbZ6e+PWNiJcY0Cjn5UkD8Pn3qZsq9VrrFUmTZP/n4Gut+Li2Jj2KQ6C3
         etpC+AnKjMiiUtod6lIxigE6VWiG2i76MboD40erkryQMO9FrBzkpZHWpmprJzJWKShr
         M5uBmGX4RUnsZNGBWykxTSKeGLmrnkjMvKeC2K/y1A0t8p87WvU19y+TTzWE20YNxX4A
         DwjYUnfyPdiO4ylOSt0P+NlYqsBCMx7ooVGB0RXzwHJMkXtYoN6wb1kNpD6zDixxj0Qd
         6GwdcT4Moul1bsLk+5oTgpggKDCiIPr/txcyZMXyAWSOu1o3SAps5KkmUSNfNyPe69MA
         9vQQ==
X-Gm-Message-State: AOJu0YxzFc8hYQAnCvR5b5QDpldoFzXt3GSXKNd8mi3X/g4TcYONW5bN
	xymBdsg4EL6h2gjmIYkfYRL6Lg==
X-Google-Smtp-Source: AGHT+IGq/UUkwq5B2XE8Euk/g23oQaEh8/MVfrEjyY6KOesc26jzK9pN4ZLSFXkSGrYh9NRVjUtvLA==
X-Received: by 2002:a05:6a00:9a3:b0:688:2256:f767 with SMTP id u35-20020a056a0009a300b006882256f767mr70601pfg.5.1692384497561;
        Fri, 18 Aug 2023 11:48:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a62bd09000000b0068844ee18dfsm1841699pff.83.2023.08.18.11.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:48:16 -0700 (PDT)
Date: Fri, 18 Aug 2023 11:48:16 -0700
From: Kees Cook <keescook@chromium.org>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org,
	Elena Reshetova <elena.reshetova@intel.com>,
	David Windsor <dwindsor@gmail.com>,
	Hans Liljestrand <ishkamiel@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Alexey Gladkov <legion@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
Message-ID: <202308181146.465B4F85@keescook>
References: <20230818041740.gonna.513-kees@kernel.org>
 <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
 <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 08:17:55PM +0200, Jann Horn wrote:
> On Fri, Aug 18, 2023 at 7:56 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Thu, 17 Aug 2023 21:17:41 -0700 Kees Cook <keescook@chromium.org> wrote:
> >
> > > From: Elena Reshetova <elena.reshetova@intel.com>
> > >
> > > atomic_t variables are currently used to implement reference counters
> > > with the following properties:
> > >  - counter is initialized to 1 using atomic_set()
> > >  - a resource is freed upon counter reaching zero
> > >  - once counter reaches zero, its further
> > >    increments aren't allowed
> > >  - counter schema uses basic atomic operations
> > >    (set, inc, inc_not_zero, dec_and_test, etc.)
> > >
> > > Such atomic variables should be converted to a newly provided
> > > refcount_t type and API that prevents accidental counter overflows and
> > > underflows. This is important since overflows and underflows can lead
> > > to use-after-free situation and be exploitable.
> >
> > ie, if we have bugs which we have no reason to believe presently exist,
> > let's bloat and slow down the kernel just in case we add some in the
> > future?
> 
> Yeah. Or in case we currently have some that we missed.

Right, or to protect us against the _introduction_ of flaws.

> Though really we don't *just* need refcount_t to catch bugs; on a
> system with enough RAM you can also overflow many 32-bit refcounts by
> simply creating 2^32 actual references to an object. Depending on the
> structure of objects that hold such refcounts, that can start
> happening at around 2^32 * 8 bytes = 32 GiB memory usage, and it
> becomes increasingly practical to do this with more objects if you
> have significantly more RAM. I suppose you could avoid such issues by
> putting a hard limit of 32 GiB on the amount of slab memory and
> requiring that kernel object references are stored as pointers in slab
> memory, or by making all the refcounts 64-bit.

These problems are a different issue, and yes, the path out of it would
be to crank the size of refcount_t, etc.

-- 
Kees Cook

