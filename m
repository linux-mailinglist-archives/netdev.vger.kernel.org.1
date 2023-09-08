Return-Path: <netdev+bounces-32524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F137981FB
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 08:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A012818C1
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 06:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E63915C8;
	Fri,  8 Sep 2023 06:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43213184F
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 06:10:24 +0000 (UTC)
X-Greylist: delayed 225 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 23:10:09 PDT
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2859A1BEE
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 23:10:09 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qeUgt-00Buer-Fo; Fri, 08 Sep 2023 14:10:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Sep 2023 14:10:05 +0800
Date: Fri, 8 Sep 2023 14:10:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, davejwatson@fb.com,
	kuba@kernel.org, vakul.garg@nxp.com, borisp@nvidia.com,
	john.fastabend@gmail.com
Subject: Re: [PATCH net 1/5] net: tls: handle -EBUSY on async encrypt/decrypt
 requests
Message-ID: <ZPq6vSOSkDuzBBDb@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net>
X-Newsgroups: apana.lists.os.linux.netdev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sabrina Dubroca <sd@queasysnail.net> wrote:
> Since we're setting the CRYPTO_TFM_REQ_MAY_BACKLOG flag on our
> requests to the crypto API, crypto_aead_{encrypt,decrypt} can return
> -EBUSY instead of -EINPROGRESS in valid situations. For example, when
> the cryptd queue for AESNI is full (easy to trigger with an
> artifically low cryptd.cryptd_max_cpu_qlen), requests will be enqueued
> to the backlog but still processed. In that case, the async callback
> will also be called twice: first with err == -EINPROGRESS, which it
> seems we can just ignore, then with err == 0.
> 
> I've only tested this on AESNI with cryptd.
> 
> Fixes: a54667f6728c ("tls: Add support for encryption using async offload accelerator")
> Fixes: 94524d8fc965 ("net/tls: Add support for async decryption of tls records")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
> net/tls/tls_sw.c | 23 +++++++++++++++--------
> 1 file changed, 15 insertions(+), 8 deletions(-)

You should only use MAY_BACKLOG if you can actually back off and
stop issuing new requests.  In that case you can only restart
issuing new requests when the EINPROGRESS notification comes in.

If that's not the case here you should drop MAY_BACKLOG altogether.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

