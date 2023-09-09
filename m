Return-Path: <netdev+bounces-32688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EB9799596
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 03:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CB7281B8F
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 01:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17E81101;
	Sat,  9 Sep 2023 01:26:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF115A8
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 01:26:56 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3901FED
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:26:55 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qemDu-00CEVm-Qd; Sat, 09 Sep 2023 08:53:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 09 Sep 2023 08:53:21 +0800
Date: Sat, 9 Sep 2023 08:53:21 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	vakul.garg@nxp.com, borisp@nvidia.com, john.fastabend@gmail.com
Subject: Re: [PATCH net 1/5] net: tls: handle -EBUSY on async encrypt/decrypt
 requests
Message-ID: <ZPvCAWVEvvrkARA0@gondor.apana.org.au>
References: <9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net>
 <ZPq6vSOSkDuzBBDb@gondor.apana.org.au>
 <ZPtED-ZlSEQmPSlr@hog>
 <20230908142602.2ced0631@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908142602.2ced0631@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 08, 2023 at 02:26:02PM -0700, Jakub Kicinski wrote:
>
> and call it after we get EBUSY? We'll drain the pending queue all the
> way to empty, which may not be too great for throughput, but who cares
> - right now we don't handle EBUSY at all, so it must be extremely rare.

EBUSY means that you're sending requests to the Crypto API faster
than it can process them.  If left unhandled you will eventually
exhaust all memory.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

