Return-Path: <netdev+bounces-32529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B8C798254
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 08:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176802819BA
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 06:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31351859;
	Fri,  8 Sep 2023 06:26:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA615C8
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 06:26:49 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE18F19A6
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 23:26:47 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qeUd8-00BuY9-RN; Fri, 08 Sep 2023 14:06:11 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Sep 2023 14:06:12 +0800
Date: Fri, 8 Sep 2023 14:06:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Dave Watson <davejwatson@fb.com>, Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net 5/5] tls: don't decrypt the next record if it's of a
 different type
Message-ID: <ZPq51KxgmELpTgOs@gondor.apana.org.au>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPm__x5TcsmqagBH@hog>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 07, 2023 at 02:21:59PM +0200, Sabrina Dubroca wrote:
>
> Herbert, WDYT? We're calling tls_do_decryption twice from the same
> tls_sw_recvmsg invocation, first with darg->async = true, then with
> darg->async = false. Is it ok to use ctx->async_wait for both, or do
> we need a fresh one as in this patch?

Yes I think your patch makes sense and the existing code could
malfunction if two decryption requests occur during the same
tls_sw_recvmsg call, with the first being async and the second
being sync.

However, I'm still unsure about the case where two async decryption
requests occur during the same tls_sw_recvmsg call.  Or perhaps this
is not possible due to other constraints that are not obvious?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

