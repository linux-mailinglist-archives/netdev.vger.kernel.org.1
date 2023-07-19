Return-Path: <netdev+bounces-18749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A151775887E
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 00:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD58A2817AA
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 22:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66E8168BE;
	Tue, 18 Jul 2023 22:32:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC7A442E
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 22:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41861C433C7;
	Tue, 18 Jul 2023 22:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689719561;
	bh=7Gbf5E8xcaK5OEKWGb4CHdLczRMlJnuQEgylfRoJijU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ufuwLPWCK8dWV8FkCqtCEz1epizX5iOUu9r0pzjEB8rAo3vv70aUHG7DaVTyC0KRg
	 9GffXUB6RPQfiH4Pwwly5QDNxRzp24n52b7+3LD9ARpF8rJiXrkrBeyyZXIPCRwCL3
	 YnFduPkPfkN/Xgp87N8DLRjyb4cFcZH/W6xsrlYbCUBOsPO7LPaSINVyNCf7nN7z43
	 VbtnrwxtgFI9aorRlk+A+3KII5/Vn0DPycSXnFotjqn6aFg9SWYv2fXiVGJgnhvXsX
	 jEkhDeNqSzOymSxwFCvBFlJkeTEmz1CT/UJjdF6RKWm+b8SD1lfeb02J5lyYQ8cZJU
	 KTXuktmKYxzVQ==
Date: Tue, 18 Jul 2023 15:32:39 -0700
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
Message-ID: <20230718223239.GB1005@sol.localdomain>
References: <20230718125847.3869700-1-ardb@kernel.org>
 <20230718125847.3869700-2-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718125847.3869700-2-ardb@kernel.org>

On Tue, Jul 18, 2023 at 02:58:27PM +0200, Ard Biesheuvel wrote:
> This reverts commit a368f43d6e3a001e684e9191a27df384fbff12f5.
> 
> "zlib-deflate" was introduced 6 years ago, but it does not have any
> users. So let's remove the generic implementation and the test vectors,
> but retain the "zlib-deflate" entry in the testmgr code to avoid
> introducing warning messages on systems that implement zlib-deflate in
> hardware.
> 
> Note that RFC 1950 which forms the basis of this algorithm dates back to
> 1996, and predates RFC 1951, on which the existing IPcomp is based and
> which we have supported in the kernel since 2003. So it seems rather
> unlikely that we will ever grow the need to support zlib-deflate.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  crypto/deflate.c | 61 +++++-----------
>  crypto/testmgr.c |  8 +--
>  crypto/testmgr.h | 75 --------------------
>  3 files changed, 18 insertions(+), 126 deletions(-)

So if this is really unused, it's probably fair to remove it on that basis.
However, it's not correct to claim that DEFLATE is obsoleted by zlib (the data
format).  zlib is just DEFLATE plus a checksum, as is gzip.

Many users of zlib or gzip use an external checksum and therefore would be
better served by DEFLATE, avoiding a redundant builtin checksum.  Typically,
people have chosen zlib or gzip simply because their compression library
defaulted to it, they didn't understand the difference, and they overlooked that
they're paying the price for a redundant builtin checksum.

An example of someone doing it right is EROFS, which is working on adding
DEFLATE support (not zlib or gzip!):
https://lore.kernel.org/r/20230713001441.30462-1-hsiangkao@linux.alibaba.com

Of course, they are using the library API instead of the clumsy crypto API.

- Eric

