Return-Path: <netdev+bounces-33022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F579C4C9
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 06:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED8F28161A
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 04:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C49E443D;
	Tue, 12 Sep 2023 04:38:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308BE17D0
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:38:46 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC125B8
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 21:38:45 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qfvAX-00DAvf-ER; Tue, 12 Sep 2023 12:38:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 12 Sep 2023 12:38:35 +0800
Date: Tue, 12 Sep 2023 12:38:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Dave Watson <davejwatson@fb.com>, Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net 5/5] tls: don't decrypt the next record if it's of a
 different type
Message-ID: <ZP/rS+NtSbJ3EuWc@gondor.apana.org.au>
References: <cover.1694018970.git.sd@queasysnail.net>
 <be8519564777b3a40eeb63002041576f9009a733.1694018970.git.sd@queasysnail.net>
 <20230906204727.08a79e00@kernel.org>
 <ZPm__x5TcsmqagBH@hog>
 <ZPq51KxgmELpTgOs@gondor.apana.org.au>
 <ZPtACbUa9rQz0uFq@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPtACbUa9rQz0uFq@hog>

On Fri, Sep 08, 2023 at 05:38:49PM +0200, Sabrina Dubroca wrote:
>
> tls_decrypt_done only runs the completion when decrypt_pending drops
> to 0, so this should be covered.

That doesn't look very safe.  What if the first decrypt completes
before the second decrypt even starts? Wouldn't that cause two
complete calls on ctx->async_wait?

> I wonder if this situation could happen:
> 
> tls_sw_recvmsg
>   process first record
>     decrypt_pending = 1
>                                   CB runs
>                                   decrypt_pending = 0
>                                   complete(&ctx->async_wait.completion);
> 
>   process second record
>     decrypt_pending = 1
>   tls_sw_recvmsg reaches "recv_end"
>     decrypt_pending != 0
>     crypto_wait_req sees the first completion of ctx->async_wait and proceeds
> 
>                                   CB runs
>                                   decrypt_pending = 0
>                                   complete(&ctx->async_wait.completion);

Yes that's exactly what I was thinking of.

I think this whole thing needs some rethinking and rewriting.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

