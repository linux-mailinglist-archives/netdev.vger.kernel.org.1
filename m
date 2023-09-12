Return-Path: <netdev+bounces-33023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B379C4CC
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 06:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA9C2815A5
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 04:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EEFA93E;
	Tue, 12 Sep 2023 04:43:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D29817D0
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:43:37 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484B0B9
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 21:43:36 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qfvFK-00DAwK-Di; Tue, 12 Sep 2023 12:43:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 12 Sep 2023 12:43:32 +0800
Date: Tue, 12 Sep 2023 12:43:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, davejwatson@fb.com, kuba@kernel.org,
	vakul.garg@nxp.com, borisp@nvidia.com, john.fastabend@gmail.com
Subject: Re: [PATCH net 1/5] net: tls: handle -EBUSY on async encrypt/decrypt
 requests
Message-ID: <ZP/sdGHy7LVE3UEc@gondor.apana.org.au>
References: <9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net>
 <ZPq6vSOSkDuzBBDb@gondor.apana.org.au>
 <ZPtED-ZlSEQmPSlr@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPtED-ZlSEQmPSlr@hog>

On Fri, Sep 08, 2023 at 05:55:59PM +0200, Sabrina Dubroca wrote:
>
> Uh, ok, I didn't know that, thanks for explaining. When I was fixing
> this code I couldn't find a mention of what the expectations for
> MAY_BACKLOG are. Could you add a comment describing this in the
> headers (either for #define CRYPTO_TFM_REQ_MAY_BACKLOG or
> aead_request_set_callback, wherever is more appropriate). MAY_BACKLOG
> is used by both tls and tipc (talking only about networking) and
> neither seem to respect this need to back off.

Patches are welcome :)

A bit of history: at the beginning we always dropped requests
that we couldn't queue because the only user was IPsec so this
is the expected behaviour.

When storage crypto support was added there was a need for reliable
handling of resource constraints so that's why MAY_BACKLOG was added.
However, the expectation is obviously that you must stop sending new
requests once you run into the resource constraint.

> Jakub, I guess we should drop the CRYPTO_TFM_REQ_MAY_BACKLOG for net,
> and maybe consider adding it back (with the back off) in
> net-next. Probably not urgent considering that nobody seems to have
> run into this bug so far.

I think that would be the prudent action.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

