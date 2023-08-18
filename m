Return-Path: <netdev+bounces-28948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB1D78135C
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 21:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439C91C20F65
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 19:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848C1BB2E;
	Fri, 18 Aug 2023 19:31:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B756112
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 19:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B4EC433C7;
	Fri, 18 Aug 2023 19:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1692387111;
	bh=uh51fKDWUGz5RlUKsAx0lMoUB8sMNSymJzbCiuP6hPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d77MsN0ra2ujWVxyT+5nZLZanrBh+hIwlraWSyVTQL5hw2QqTqld7DGC55I1oHIYc
	 mPnLA6xHxGer4Xz12vnrpRZjL4C5oj5zEaSV8b21xBoCmjZgqO/L6l4yaVSOqIvWPc
	 pfv8h66dJQI2piFjndcXZN2VOnN4qJOdl5cgZDN8=
Date: Fri, 18 Aug 2023 12:31:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>, linux-hardening@vger.kernel.org, Elena
 Reshetova <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>,
 Hans Liljestrand <ishkamiel@gmail.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
 Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil
 Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Alexey Gladkov <legion@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Yu Zhao <yuzhao@google.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
Message-Id: <20230818123148.801b446cfdbd932787d47612@linux-foundation.org>
In-Reply-To: <202308181146.465B4F85@keescook>
References: <20230818041740.gonna.513-kees@kernel.org>
	<20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
	<CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
	<202308181146.465B4F85@keescook>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 18 Aug 2023 11:48:16 -0700 Kees Cook <keescook@chromium.org> wrote:

> On Fri, Aug 18, 2023 at 08:17:55PM +0200, Jann Horn wrote:
> > On Fri, Aug 18, 2023 at 7:56 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > On Thu, 17 Aug 2023 21:17:41 -0700 Kees Cook <keescook@chromium.org> wrote:
> > >
> > > > From: Elena Reshetova <elena.reshetova@intel.com>
> > > >
> > > > atomic_t variables are currently used to implement reference counters
> > > > with the following properties:
> > > >  - counter is initialized to 1 using atomic_set()
> > > >  - a resource is freed upon counter reaching zero
> > > >  - once counter reaches zero, its further
> > > >    increments aren't allowed
> > > >  - counter schema uses basic atomic operations
> > > >    (set, inc, inc_not_zero, dec_and_test, etc.)
> > > >
> > > > Such atomic variables should be converted to a newly provided
> > > > refcount_t type and API that prevents accidental counter overflows and
> > > > underflows. This is important since overflows and underflows can lead
> > > > to use-after-free situation and be exploitable.
> > >
> > > ie, if we have bugs which we have no reason to believe presently exist,
> > > let's bloat and slow down the kernel just in case we add some in the
> > > future?
> > 
> > Yeah. Or in case we currently have some that we missed.
> 
> Right, or to protect us against the _introduction_ of flaws.

We could cheerfully add vast amounts of code to the kernel to check for
the future addition of bugs.  But we don't do that, because it would be
insane.

> > Though really we don't *just* need refcount_t to catch bugs; on a
> > system with enough RAM you can also overflow many 32-bit refcounts by
> > simply creating 2^32 actual references to an object. Depending on the
> > structure of objects that hold such refcounts, that can start
> > happening at around 2^32 * 8 bytes = 32 GiB memory usage, and it
> > becomes increasingly practical to do this with more objects if you
> > have significantly more RAM. I suppose you could avoid such issues by
> > putting a hard limit of 32 GiB on the amount of slab memory and
> > requiring that kernel object references are stored as pointers in slab
> > memory, or by making all the refcounts 64-bit.
> 
> These problems are a different issue, and yes, the path out of it would
> be to crank the size of refcount_t, etc.

Is it possible for such overflows to occur in the cred code?  If so,
that's a bug.  Can we fix that cred bug without all this overhead? 
With a cc:stable backport.  If not then, again, what is the non
handwavy, non cargoculty justification for adding this overhead to
the kernel?

