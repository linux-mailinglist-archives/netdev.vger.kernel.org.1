Return-Path: <netdev+bounces-18756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BC37588C2
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 00:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC532281752
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 22:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56D01775B;
	Tue, 18 Jul 2023 22:54:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6FB168A5
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 22:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BC9C433C8;
	Tue, 18 Jul 2023 22:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689720892;
	bh=1hPBVUZKx9DcSFz9qEiAQCMaCu6XICTp5tPsfBL3VTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZENGkevC8W/gj/0tZ9tVvAElZY3lwTUMr999oZl+jwvHVvtSMgDpH1KbGMEAU4qs
	 GdpVYRatm0rSzVuAMU4XHsXzxbuISlJXTbyX6Ak0+tmkqQfllCv6T0ItKeE5MMHk1i
	 p33MlEu6cwmh6M4Wxxhhb5pd4+W3wYK2dE/YtpA2o5B+XvJOMq1ia1u6cYxrdVIx0U
	 mYPIoJrkuqKmEMSsiz1ZArYA01s/aryDGYYvNiRUoqAk6VAHtXJ1FOfnqL0xq3TBGo
	 uBMtWz1SprpEJs7h1FI0mxBwReuRTZEjdlXn/cq6JQTFCphSKiIDvhQXXnaOHRyuA3
	 6utEntLUgpgtg==
Date: Tue, 18 Jul 2023 15:54:50 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Kees Cook <keescook@chromium.org>, Haren Myneni <haren@us.ibm.com>,
	Nick Terrell <terrelln@fb.com>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Richard Weinberger <richard@nod.at>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	qat-linux@intel.com, linuxppc-dev@lists.ozlabs.org,
	linux-mtd@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 01/21] crypto: scomp - Revert "add support for
 deflate rfc1950 (zlib)"
Message-ID: <20230718225450.GD1005@sol.localdomain>
References: <20230718125847.3869700-1-ardb@kernel.org>
 <20230718125847.3869700-2-ardb@kernel.org>
 <20230718223239.GB1005@sol.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718223239.GB1005@sol.localdomain>

On Tue, Jul 18, 2023 at 03:32:39PM -0700, Eric Biggers wrote:
> On Tue, Jul 18, 2023 at 02:58:27PM +0200, Ard Biesheuvel wrote:
> > This reverts commit a368f43d6e3a001e684e9191a27df384fbff12f5.
> > 
> > "zlib-deflate" was introduced 6 years ago, but it does not have any
> > users. So let's remove the generic implementation and the test vectors,
> > but retain the "zlib-deflate" entry in the testmgr code to avoid
> > introducing warning messages on systems that implement zlib-deflate in
> > hardware.
> > 
> > Note that RFC 1950 which forms the basis of this algorithm dates back to
> > 1996, and predates RFC 1951, on which the existing IPcomp is based and
> > which we have supported in the kernel since 2003. So it seems rather
> > unlikely that we will ever grow the need to support zlib-deflate.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  crypto/deflate.c | 61 +++++-----------
> >  crypto/testmgr.c |  8 +--
> >  crypto/testmgr.h | 75 --------------------
> >  3 files changed, 18 insertions(+), 126 deletions(-)
> 
> So if this is really unused, it's probably fair to remove it on that basis.
> However, it's not correct to claim that DEFLATE is obsoleted by zlib (the data
> format).  zlib is just DEFLATE plus a checksum, as is gzip.
> 
> Many users of zlib or gzip use an external checksum and therefore would be
> better served by DEFLATE, avoiding a redundant builtin checksum.  Typically,
> people have chosen zlib or gzip simply because their compression library
> defaulted to it, they didn't understand the difference, and they overlooked that
> they're paying the price for a redundant builtin checksum.
> 
> An example of someone doing it right is EROFS, which is working on adding
> DEFLATE support (not zlib or gzip!):
> https://lore.kernel.org/r/20230713001441.30462-1-hsiangkao@linux.alibaba.com
> 
> Of course, they are using the library API instead of the clumsy crypto API.
> 

Ah, I misread this patch, sorry.  It's actually removing support for zlib (the
data format) from the scomp API, leaving just DEFLATE.  That's fine too; again,
it ultimately just depends on what is actually being used via the scomp API.
But similarly you can't really claim that zlib is obsoleted by DEFLATE just
because of the RFC dates.  As I mentioned, many people do use zlib (the data
format), often just because it's the default of zlib (the library) and they
didn't know any better.  For example, btrfs compression supports zlib.

- Eric

