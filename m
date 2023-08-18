Return-Path: <netdev+bounces-28915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EAD781267
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 19:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6598A1C21241
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 17:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143FC1AA8A;
	Fri, 18 Aug 2023 17:55:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41C363A0
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 17:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251FBC433C8;
	Fri, 18 Aug 2023 17:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1692381344;
	bh=KONQ3xcRnoS4lAb+HMyH7HyVsHgReeRIXjIT4SA1idM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LiCZSUBAW80WQNaU36+qdHOShmUA4NduLKvtU+3U3wolKrrnJP6VYMIT9f+aaMWhK
	 rloZUyqzQ5lrxYiHlDnT6pwL4rsw4o2AQ1ydrgH8OW5l7WYjLE5HLxYprkfW0o+yUm
	 9//vTI5ECw1kakPC+YBXBwCRn5iCMPWX/PY5QFs0=
Date: Fri, 18 Aug 2023 10:55:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Elena Reshetova
 <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>, Hans
 Liljestrand <ishkamiel@gmail.com>, Trond Myklebust
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
Message-Id: <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
In-Reply-To: <20230818041740.gonna.513-kees@kernel.org>
References: <20230818041740.gonna.513-kees@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 21:17:41 -0700 Kees Cook <keescook@chromium.org> wrote:

> From: Elena Reshetova <elena.reshetova@intel.com>
> 
> atomic_t variables are currently used to implement reference counters
> with the following properties:
>  - counter is initialized to 1 using atomic_set()
>  - a resource is freed upon counter reaching zero
>  - once counter reaches zero, its further
>    increments aren't allowed
>  - counter schema uses basic atomic operations
>    (set, inc, inc_not_zero, dec_and_test, etc.)
> 
> Such atomic variables should be converted to a newly provided
> refcount_t type and API that prevents accidental counter overflows and
> underflows. This is important since overflows and underflows can lead
> to use-after-free situation and be exploitable.

ie, if we have bugs which we have no reason to believe presently exist,
let's bloat and slow down the kernel just in case we add some in the
future?  Or something like that.  dangnabbit, that refcount_t.

x86_64 defconfig:

before:
   text	   data	    bss	    dec	    hex	filename
   3869	    552	      8	   4429	   114d	kernel/cred.o
   6140	    724	     16	   6880	   1ae0	net/sunrpc/auth.o

after:
   text	   data	    bss	    dec	    hex	filename
   4573	    552	      8	   5133	   140d	kernel/cred.o
   6236	    724	     16	   6976	   1b40	net/sunrpc/auth.o


Please explain, in a non handwavy and non cargoculty fashion why this
speed and space cost is justified.

