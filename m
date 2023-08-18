Return-Path: <netdev+bounces-28930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F05578130A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100471C20FCD
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2681AA8A;
	Fri, 18 Aug 2023 18:46:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB43D64
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:46:23 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F93E3A98
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:46:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68891000f34so1074918b3a.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692384382; x=1692989182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+2hSnqS9Yzw5UTj15WMzjQ4zmGmjbbgkpHMU7Oa/T4=;
        b=UGM65oHnI7oqrbisB5aTDPxGyCJnzpdwN0H0USoMcryzreFY0ONqRc/qg1vwjk1sq3
         qFoovE7ZU111JOa8bRkXKvDMWQPwf90N8xDBjMdvpDzPnkSYv2djLX94Y6ZB1jiZeWdb
         TkJSyWpXy92Rmq5gWls3IQDvHLP4CnwS2f+Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692384382; x=1692989182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+2hSnqS9Yzw5UTj15WMzjQ4zmGmjbbgkpHMU7Oa/T4=;
        b=eZaSji2XnFXyZ4LODHbrDO4iBsHMtpma0qN0QTKYhfA8/GCA+N/cFJmoCqKNvoqxbW
         RPClvkNx4z1RjY1sCfJSHc0aQN7gfRXegII4pMj1oO8aA3hOzcZQfJ8blOgHHPAKU3+N
         kGZk7dQHliQNbusylXgBSYGwBXEO02eA62lzpnyolqFs/dG0qYcEiykxIfSsf48cqoSZ
         uMP/MC2IkdnnaXRZfyCNSejQFVBVPLnfYXDVYLxbbC4B+gU5+8rK/hOPTu4PqApfiZVw
         n6/fQkAwsicKY+8VqbokDiFhw040ufMeBmU1h/lmnaaFIFhT9JXUg4zIz/9gtvCLbSoi
         utRg==
X-Gm-Message-State: AOJu0YwGhyKOe0+1dwxel/BRAdQiMTEJr4LKpG4WjXxTznepWtpeAInl
	dQmdUYpDVX7US+RXGc18U3W1rQ==
X-Google-Smtp-Source: AGHT+IE3Zchz6xeyBBEDLoYNbU06PWpcwMQMcoo53Bn+vR9Ag+FUXv04ngK0q6kWf3a8SLZaL9fVbw==
X-Received: by 2002:a05:6a00:150d:b0:678:ee57:7b29 with SMTP id q13-20020a056a00150d00b00678ee577b29mr15648pfu.30.1692384381927;
        Fri, 18 Aug 2023 11:46:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j3-20020a62e903000000b006879493aca0sm1855587pfh.26.2023.08.18.11.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:46:21 -0700 (PDT)
Date: Fri, 18 Aug 2023 11:46:20 -0700
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org,
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
Message-ID: <202308181131.045F806@keescook>
References: <20230818041740.gonna.513-kees@kernel.org>
 <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 10:55:42AM -0700, Andrew Morton wrote:
> On Thu, 17 Aug 2023 21:17:41 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > From: Elena Reshetova <elena.reshetova@intel.com>
> > 
> > atomic_t variables are currently used to implement reference counters
> > with the following properties:
> >  - counter is initialized to 1 using atomic_set()
> >  - a resource is freed upon counter reaching zero
> >  - once counter reaches zero, its further
> >    increments aren't allowed
> >  - counter schema uses basic atomic operations
> >    (set, inc, inc_not_zero, dec_and_test, etc.)
> > 
> > Such atomic variables should be converted to a newly provided
> > refcount_t type and API that prevents accidental counter overflows and
> > underflows. This is important since overflows and underflows can lead
> > to use-after-free situation and be exploitable.
> 
> ie, if we have bugs which we have no reason to believe presently exist,
> let's bloat and slow down the kernel just in case we add some in the
> future?  Or something like that.  dangnabbit, that refcount_t.
> 
> x86_64 defconfig:
> 
> before:
>    text	   data	    bss	    dec	    hex	filename
>    3869	    552	      8	   4429	   114d	kernel/cred.o
>    6140	    724	     16	   6880	   1ae0	net/sunrpc/auth.o
> 
> after:
>    text	   data	    bss	    dec	    hex	filename
>    4573	    552	      8	   5133	   140d	kernel/cred.o
>    6236	    724	     16	   6976	   1b40	net/sunrpc/auth.o
> 
> 
> Please explain, in a non handwavy and non cargoculty fashion why this
> speed and space cost is justified.

Since it's introduction, refcount_t has found a lot of bugs. This is easy
to see even with a simplistic review of commits:

$ git log --date=short --pretty='format:%ad %C(auto)%h ("%s")' \
          --grep 'refcount_t:' | \
  cut -d- -f1 | sort | uniq -c
      1 2016
     15 2017
      9 2018
     23 2019
     24 2020
     18 2021
     24 2022
     10 2023

It's not really tapering off, either. All of these would have been silent
memory corruptions, etc. In the face of _what_ is being protected,
"cred" is pretty important for enforcing security boundaries, etc,
so having it still not protected is a weird choice we've implicitly
made. Given cred code is still seeing changes and novel uses (e.g.
io_uring), it's not unreasonable to protect it from detectable (and
_exploitable_) problems.

While the size differences look large in cred.o, it's basically limited
only to cred.o:

   text    data     bss     dec     hex filename
30515570        12255806        17190916        59962292        392f3b4 vmlinux.before
30517500        12255838        17190916        59964254        392fb5e vmlinux.after

And we've even seen performance _improvements_ in some conditions:
https://lore.kernel.org/lkml/20200615005732.GV12456@shao2-debian/

Looking at confirmed security flaws, exploitable reference counting
related bugs have dropped significantly. (The CVE database is irritating
to search, but most recent refcount-related CVEs are due to counts that
are _not_ using refcount_t.)

I'd rather ask the question, "Why should we _not_ protect cred lifetime
management?"

-Kees

-- 
Kees Cook

