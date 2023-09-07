Return-Path: <netdev+bounces-32438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F76A79793D
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E428F280C92
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E711A134DB;
	Thu,  7 Sep 2023 17:08:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BD46D22
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 17:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEFFC43391;
	Thu,  7 Sep 2023 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694106508;
	bh=8jO1W9mwUvUnadY4KgpKhvkbf1MemC0e4uimo5BuJz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AzM0rQmCUMf0ZFSbEc1BwCzm2ypPlMdLo+R3MwnzGaQfYMWxZPCg8PMOBVC3VmpKm
	 XSSKdE0Wo0nEYM1GywOuLT1mNoM1sEg7oKwu6GsvQKlYbqaINM14SREVdLNa4TzhS4
	 0FR4lPmLWg72nwQonPuXArq0XwiLF/pVV9V6Mj5AFweGMpIBA9vo+0gGJiykdwKsYl
	 sm7hputKL1xNXybZ1MXGbdUifhWdul43/c9pJGsQss7B04avGXVIdTDPhToceDJ6nZ
	 jX8vPpEy3+QcCH1eeaXan6D61X6uBk4b6ChhXcmh5lpW1N28rUB4733qtDsrDUQsS/
	 Gaa40gi2hCf2Q==
Date: Thu, 7 Sep 2023 10:08:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, Dave
 Watson <davejwatson@fb.com>, Vakul Garg <vakul.garg@nxp.com>, Boris
 Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net 5/5] tls: don't decrypt the next record if it's of a
 different type
Message-ID: <20230907100827.7c3553ec@kernel.org>
In-Reply-To: <ZPm__x5TcsmqagBH@hog>
References: <cover.1694018970.git.sd@queasysnail.net>
	<be8519564777b3a40eeb63002041576f9009a733.1694018970.git.sd@queasysnail.net>
	<20230906204727.08a79e00@kernel.org>
	<ZPm__x5TcsmqagBH@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Sep 2023 14:21:59 +0200 Sabrina Dubroca wrote:
> I wonder if the way we're using ctx->async_wait here is correct. I'm
> observing crypto_wait_req return 0 even though the decryption hasn't
> run yet (and it should return -EBADMSG, not 0). I guess
> tls_decrypt_done calls the completion (since we only had one
> decrypt_pending), and then crypto_wait_req thinks everything is
> already done.
> 
> Adding a fresh crypto_wait in tls_do_decryption (DECLARE_CRYPTO_WAIT)
> and using it in the !darg->async case also seems to fix the UAF (but
> makes the bad_cmsg test case fail in the same way as what I wrote in
> the cover letter for bad_in_large_read -- not decrypting the next
> message at all makes the selftest pass).
> 
> Herbert, WDYT? We're calling tls_do_decryption twice from the same
> tls_sw_recvmsg invocation, first with darg->async = true, then with
> darg->async = false. Is it ok to use ctx->async_wait for both, or do
> we need a fresh one as in this patch?

I think you're right, we need a fresh one. The "non-async" call to
tls_do_decryption() will see the completion that the "async" call
queued and think it can progress. Then at the end of recv we check
->decrypt_pending and think we're good to exit. But the "non-async"
call is still crypt'ing.

All makes sense.

