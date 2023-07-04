Return-Path: <netdev+bounces-15321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7465746CB7
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 11:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEE21C20A1E
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 09:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7B469D;
	Tue,  4 Jul 2023 09:04:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94546443F
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 09:04:36 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA136127;
	Tue,  4 Jul 2023 02:04:29 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qGbxR-000RVO-1q; Tue, 04 Jul 2023 19:04:26 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 04 Jul 2023 17:04:18 +0800
Date: Tue, 4 Jul 2023 17:04:18 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Ondrej Mosnacek <omosnacek@gmail.com>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	regressions@lists.linux.dev
Subject: Re: Regression bisected to "crypto: af_alg: Convert
 af_alg_sendpage() to use MSG_SPLICE_PAGES"
Message-ID: <ZKPgkgiddAl9qddT@gondor.apana.org.au>
References: <CAAUqJDvFuvms55Td1c=XKv6epfRnnP78438nZQ-JKyuCptGBiQ@mail.gmail.com>
 <1357760.1688460637@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1357760.1688460637@warthog.procyon.org.uk>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
	PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 09:50:37AM +0100, David Howells wrote:
> One problem with libkcapi is that it's abusing vmsplice().  It must not use
> vmsplice(SPLICE_F_GIFT) on a buffer that's in the heap.  To quote the manual
> page:
> 
> 	      The user pages are a gift to the kernel.   The  application  may
>               not  modify  this  memory ever, otherwise the page cache and on-
>               disk data may differ.  Gifting pages to the kernel means that  a
>               subsequent  splice(2)  SPLICE_F_MOVE  can  successfully move the
>               pages;  if  this  flag  is  not  specified,  then  a  subsequent
>               splice(2)  SPLICE_F_MOVE must copy the pages.  Data must also be
>               properly page aligned, both in memory and length.
> 
> Basically, this can destroy the integrity of the process's heap as the
> allocator may have metadata there that then gets excised.

All it's saying is that if you modify the data after sending it off
via splice then the data that will be on the wire is undefined.

There is no reason why this should crash.

> If I remove the flag, it still crashes, so that's not the only problem.

If we can't fix this the patches should be reverted.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

