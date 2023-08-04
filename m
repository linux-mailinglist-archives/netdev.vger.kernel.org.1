Return-Path: <netdev+bounces-24332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 176D876FCEE
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 11:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6528282175
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 09:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEABA921;
	Fri,  4 Aug 2023 09:11:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D599479
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:11:54 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E14C49EC;
	Fri,  4 Aug 2023 02:11:52 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qRqqT-003ayv-PZ; Fri, 04 Aug 2023 17:11:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Aug 2023 17:11:41 +0800
Date: Fri, 4 Aug 2023 17:11:41 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: =?us-ascii?B?PT9VVEYtOD9CP1QyNWtjbVZxSUUxdmMyN0RvY1NOWldzPT89?= <omosnacek@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Harald Freudenberger <freude@linux.vnet.ibm.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>, linux-crypto@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: Fix missing initialisation affecting gcm-aes-s390
Message-ID: <ZMzAzX3WQn3ZT2N+@gondor.apana.org.au>
References: <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
 <97730.1690408399@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97730.1690408399@warthog.procyon.org.uk>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 10:53:19PM +0100, David Howells wrote:
>     
> Fix af_alg_alloc_areq() to initialise areq->first_rsgl.sgl.sgt.sgl to point
> to the scatterlist array in areq->first_rsgl.sgl.sgl.
> 
> Without this, the gcm-aes-s390 driver will oops when it tries to do
> gcm_walk_start() on req->dst because req->dst is set to the value of
> areq->first_rsgl.sgl.sgl by _aead_recvmsg() calling
> aead_request_set_crypt().
> 
> The problem comes if an empty ciphertext is passed: the loop in
> af_alg_get_rsgl() just passes straight out and doesn't set areq->first_rsgl
> up.
> 
> This isn't a problem on x86_64 using gcmaes_crypt_by_sg() because, as far
> as I can tell, that ignores req->dst and only uses req->src[*].
> 
> [*] Is this a bug in aesni-intel_glue.c?
> 
> The s390x oops looks something like:
> 
>  Unable to handle kernel pointer dereference in virtual kernel address space
>  Failing address: 0000000a00000000 TEID: 0000000a00000803
>  Fault in home space mode while using kernel ASCE.
>  AS:00000000a43a0007 R3:0000000000000024
>  Oops: 003b ilc:2 [#1] SMP
>  ...
>  Call Trace:
>   [<000003ff7fc3d47e>] gcm_walk_start+0x16/0x28 [aes_s390]
>   [<00000000a2a342f2>] crypto_aead_decrypt+0x9a/0xb8
>   [<00000000a2a60888>] aead_recvmsg+0x478/0x698
>   [<00000000a2e519a0>] sock_recvmsg+0x70/0xb0
>   [<00000000a2e51a56>] sock_read_iter+0x76/0xa0
>   [<00000000a273e066>] vfs_read+0x26e/0x2a8
>   [<00000000a273e8c4>] ksys_read+0xbc/0x100
>   [<00000000a311d808>] __do_syscall+0x1d0/0x1f8
>   [<00000000a312ff30>] system_call+0x70/0x98
>  Last Breaking-Event-Address:
>   [<000003ff7fc3e6b4>] gcm_aes_crypt+0x104/0xa68 [aes_s390]
> 
> Fixes: c1abe6f570af ("crypto: af_alg: Use extract_iter_to_sg() to create scatterlists")
> Reported-by: Ondrej Mosnáček <omosnacek@gmail.com>
> Link: https://lore.kernel.org/r/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: Sven Schnelle <svens@linux.ibm.com>
> cc: Harald Freudenberger <freude@linux.vnet.ibm.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: linux-crypto@vger.kernel.org
> cc: linux-s390@vger.kernel.org
> cc: regressions@lists.linux.dev
> ---
>  crypto/af_alg.c |    1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

