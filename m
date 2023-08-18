Return-Path: <netdev+bounces-28967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5E478144B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C0628249B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792391BF1B;
	Fri, 18 Aug 2023 20:25:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF21BEF6
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:25:04 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156BD4216
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 13:25:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6887ccba675so1125285b3a.3
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 13:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692390299; x=1692995099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKjBP6hN7INqNwDmWxh7eEodgLwdBsbDZDvaG7+HpeE=;
        b=egJ39qsdNDnaP8eBPC82Q2jt0LO0zgNc95KY2wtH+1V9wbBTLh1Ky6jQ8rTauBiJ/b
         ht64aXi61KNBL+Y8bEkkcaHZ81EwY79cKy4mJrPXZWraEd9SsbYba8O66Uznhj9BPFlo
         Uapx6baXCoHKgND+281kPb5nFph/dYaduliqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692390299; x=1692995099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKjBP6hN7INqNwDmWxh7eEodgLwdBsbDZDvaG7+HpeE=;
        b=S8vKRdo+zX+4AFygOP4Py4k5aT02RppqaHT/UAvxxAVUFlFqamxL3Dc3O5vnTQCuq9
         83OC6oEzuQynKVjB9sSv9JVGOkIMWdCVK3Wda0q2m53CTfHygEWQxOe+svluoxcQZSel
         CESL3UtrjhoQlvKQzBkytX/5BAmgPjf7dsL6nuMmITlFjpYkpjUlPlztpAyJRH2z1mZQ
         LEPTbz/BFAQj+B4aOXPMaccDcM6331zgL7wjWNafBH7LYIZ5uxRzl+cFJGWsUdt3JhOX
         NeE+gbypgfZwLSrNTvq6MT9KyVCSd/pvBEEpcUX40ejnHO4TOTW4r92I/E+/mIALkOFt
         Q4dQ==
X-Gm-Message-State: AOJu0YxDE3PMa6esvbEulLFvnR62qq8YkJ5oOY+1i3yODvmm59f9fkIK
	PmNg2L5uF9CPzsI1oajLdLpxHA==
X-Google-Smtp-Source: AGHT+IFzZ5xua6284VP9UIz+L1TCJGOBeZWzRVDjkLYvOiLi5m1A3dBrZZ7aSqweUnt5zS1+NUVOeA==
X-Received: by 2002:a05:6a00:24c6:b0:687:3022:9c1a with SMTP id d6-20020a056a0024c600b0068730229c1amr298176pfv.28.1692390299149;
        Fri, 18 Aug 2023 13:24:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b0056428865aadsm1755227pgp.82.2023.08.18.13.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 13:24:58 -0700 (PDT)
Date: Fri, 18 Aug 2023 13:24:58 -0700
From: Kees Cook <keescook@chromium.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
	linux-hardening@vger.kernel.org,
	Elena Reshetova <elena.reshetova@intel.com>,
	David Windsor <dwindsor@gmail.com>,
	Hans Liljestrand <ishkamiel@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
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
Message-ID: <202308181317.66E6C9A5@keescook>
References: <20230818041740.gonna.513-kees@kernel.org>
 <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
 <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
 <202308181146.465B4F85@keescook>
 <20230818123148.801b446cfdbd932787d47612@linux-foundation.org>
 <e5234e7bd9fbd2531b32d64bc7c23f4753401cee.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5234e7bd9fbd2531b32d64bc7c23f4753401cee.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 04:10:49PM -0400, Jeff Layton wrote:
> [...]
> extra checks (supposedly) compile down to nothing. It should be possible
> to build alternate refcount_t handling functions that are just wrappers
> around atomic_t with no extra checks, for folks who want to really run
> "fast and loose".

No -- there's no benefit for this. We already did all this work years
ago with the fast vs full break-down. All that got tossed out since it
didn't matter. We did all the performance benchmarking and there was no
meaningful difference -- refcount _is_ atomic with an added check that
is branch-predicted away. Peter Zijlstra and Will Deacon spent a lot of
time making it run smoothly. :)

-Kees

-- 
Kees Cook

