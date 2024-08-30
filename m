Return-Path: <netdev+bounces-123885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED258966B78
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3487281694
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE97171066;
	Fri, 30 Aug 2024 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aak8bVrZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6DC16DC3A;
	Fri, 30 Aug 2024 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054480; cv=none; b=rECC8nMhKr5rs6z9iy4rndx5VUltddiMnoMwdHiEtuSDbvSU4bE5sTvR4HcPKZ+HJauXCw7e+lKpm5PHQ/3iDc4w2PNZq1BEYIbcsJWGJITYPj5cbo321hdDzmneM7Xj3z/Dm+YJnYVshN5OgsxsVTw96tKAz52psSDNHotwuzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054480; c=relaxed/simple;
	bh=V2BzNcrGkNzfsuRDDxr7pv4K4r6CmS2XCVgqdcF0iyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nl11GiodNOQG3VN8NLXedgIQjwmCY20B21jJASQFT+L8zyWWzJyI5LwE8F0+KWHTYldMqj6YcX3s6frZcxJzqHBmMhYkkxBisd1HJDy2XKd+Knuw6KhAYOLyHwif9ERGZqKf8YVbZSwXvLTYAogq0DcTZVqCSE5fbm/oN7dle84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aak8bVrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30C8C4CEC2;
	Fri, 30 Aug 2024 21:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725054479;
	bh=V2BzNcrGkNzfsuRDDxr7pv4K4r6CmS2XCVgqdcF0iyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aak8bVrZJp9udde+pUotS9CbFC1p4p3o//AvmebbToX83GtzeoiVcVfdXsBFxbHqq
	 +VNVifvEnDPmLFj9zMdKObZpY7qM7asX3GU6LF8DCk5qGtwaAx5eSWgfCKabGSI0Yo
	 9gfWJoYJtJgC70SxcshmWFY8LPFJAN9ycvMNEZzMqrxmL8VhDIcXjOFzSm9vuw83LY
	 17jEdjRynzAtXkF8oxgNZlVBx9tEWqbUob9BqGD5Tjr2rGBj6rFzyheo+bQTomOOzU
	 uimD4tddDUIbw4MUXyHqacLr+0YThBtVRLGvwjfuTN2SHixC4h44YZlaz0IC32QHfK
	 p6hgOJlUZC7VQ==
Date: Fri, 30 Aug 2024 14:47:57 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	Netdev <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Florian Westphal <fw@strlen.de>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: net/xfrm/xfrm_policy.c:1286:8: error: variable 'dir' is
 uninitialized when used here [-Werror,-Wuninitialized]
Message-ID: <20240830214757.GA3819549@thelio-3990X>
References: <CA+G9fYtemFfuhc7=eNyP3TezM9Euc8sFtHe4GDR4Z9XdHzXSJA@mail.gmail.com>
 <20240830164706.GW1368797@kernel.org>
 <20240830170449.GX1368797@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830170449.GX1368797@kernel.org>

Hi Simon (and Naresh),

On Fri, Aug 30, 2024 at 06:04:49PM +0100, Simon Horman wrote:
> On Fri, Aug 30, 2024 at 05:47:06PM +0100, Simon Horman wrote:
> > + Florian, Steffen
> > 
> > On Fri, Aug 30, 2024 at 12:15:10PM +0530, Naresh Kamboju wrote:
> > > The x86_64 defconfig builds failed on today's Linux next-20240829
> > > due to following build warnings / errors.
> > > 
> > > Regressions:
> > > * i386, build
> > >   - clang-18-defconfig
> > >   - clang-nightly-defconfig
> > > 
> > > * x86_64, build
> > >   - clang-18-lkftconfig
> > >   - clang-18-lkftconfig-compat
> > >   - clang-18-lkftconfig-kcsan
> > >   - clang-18-lkftconfig-no-kselftest-frag
> > >   - clang-18-x86_64_defconfig
> > >   - clang-nightly-lkftconfig
> > >   - clang-nightly-lkftconfig-kselftest
> > >   - clang-nightly-x86_64_defconfig
> > >   - rustclang-nightly-lkftconfig-kselftest
> > > 
> > > first seen on next-20240829.
> > >   Good: next-20240828
> > >   BAD:  next-20240829
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > 
> > > build log:
> > > --------
> > > net/xfrm/xfrm_policy.c:1286:8: error: variable 'dir' is uninitialized
> > > when used here [-Werror,-Wuninitialized]
> > >  1286 |                 if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
> > >       |                      ^~~
> > > net/xfrm/xfrm_policy.c:1257:9: note: initialize the variable 'dir' to
> > > silence this warning
> > >  1257 |         int dir;
> > >       |                ^
> > >       |                 = 0
> > > 1 error generated.

Thanks for the report.

> > I believe that is due to
> > commit 08c2182cf0b4 ("xfrm: policy: use recently added helper in more places")
> > 
> > I will work on a fix to initialise dir in the loop where it is used.
> 
> Patch is here:
> - [PATCH ipsec-next] xfrm: Initialise dir in xfrm_hash_rebuild()
>   https://lore.kernel.org/netdev/20240830-xfrm_hash_rebuild-dir-v1-1-f75092d07e1b@kernel.org/T/#u

I sent the same patch as a v1 but Florian pointed out that dir needs to
be initialized in the other loop too. I sent my v2 for it yesterday, it
just needs to be merged.

https://lore.kernel.org/all/20240829-xfrm-restore-dir-assign-xfrm_hash_rebuild-v2-1-1cf8958f6e8e@kernel.org/

Cheers,
Nathan

