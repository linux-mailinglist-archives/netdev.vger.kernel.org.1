Return-Path: <netdev+bounces-22227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D5C7669D2
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2171C21836
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEAB111A1;
	Fri, 28 Jul 2023 10:07:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133391118B
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:07:18 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3954E1FF5;
	Fri, 28 Jul 2023 03:07:17 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qPKM4-0011VE-8y; Fri, 28 Jul 2023 18:05:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Jul 2023 18:05:52 +0800
Date: Fri, 28 Jul 2023 18:05:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
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
Subject: Re: [RFC PATCH 00/21] crypto: consolidate and clean up compression
 APIs
Message-ID: <ZMOTAB595JyptIN4@gondor.apana.org.au>
References: <20230718125847.3869700-1-ardb@kernel.org>
 <ZMOQiPadP2jggZ2i@gondor.apana.org.au>
 <CAMj1kXFRAhoyRD8mGe4xKZ-xGord2vwPXHCM7O8DPOpYWcgnJw@mail.gmail.com>
 <ZMORcmIA/urS8OI4@gondor.apana.org.au>
 <CAMj1kXFnr64b7SA1zYvSOrXazdH_O5G=i4re=taQa9hAeRbh-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFnr64b7SA1zYvSOrXazdH_O5G=i4re=taQa9hAeRbh-w@mail.gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 12:03:23PM +0200, Ard Biesheuvel wrote:
>
> Fair enough. But my point remains: this requires a lot of boilerplate
> on the part of the driver, and it would be better if we could do this
> in the acomp generic layer.

Absolutely.  If the hardware can't support allocate-as-you-go then
this should very much go into the generic layer.

> Does the IPcomp case always know the decompressed size upfront?

No it doesn't know.  Of course, we could optimise it because we know
that in 99% cases, the packet is going to be less than 4K.  But we
need a safety-net for those weird jumbo packets.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

