Return-Path: <netdev+bounces-27615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD4877C8E6
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C112813B4
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D1BAD5A;
	Tue, 15 Aug 2023 07:52:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9135242
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:52:34 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295821733;
	Tue, 15 Aug 2023 00:52:31 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qVoq8-003twA-AO; Tue, 15 Aug 2023 15:51:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 15 Aug 2023 15:51:44 +0800
Date: Tue, 15 Aug 2023 15:51:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Leon Romanovsky <leon@kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	steffen.klassert@secunet.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	timo.teras@iki.fi, yuehaibing@huawei.com, weiyongjun1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch net, v2] net: xfrm: skip policies marked as dead while
 reinserting policies
Message-ID: <ZNsukMSQmzmXpgbS@gondor.apana.org.au>
References: <20230814140013.712001-1-dongchenchen2@huawei.com>
 <20230815060026.GE22185@unreal>
 <20230815060454.GA2833@breakpoint.cc>
 <20230815073033.GJ22185@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815073033.GJ22185@unreal>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
	PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_PASS,TVD_RCVD_IP,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 10:30:33AM +0300, Leon Romanovsky wrote:
>
> But policy has, and we are not interested in validity of it as first
> check in if (...) will be true for policy->walk.dead.
> 
> So it is safe to call to dir = xfrm_policy_id2dir(policy->index) even
> for dead policy.

If you dereference policy->index on a walker object it will read memory
before the start of the walker object.  That could do anything, perhaps
even triggering a page fault.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

