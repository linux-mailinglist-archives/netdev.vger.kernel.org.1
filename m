Return-Path: <netdev+bounces-27621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DA477C918
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 10:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347C32813B7
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E524BA2B;
	Tue, 15 Aug 2023 08:06:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E5BE61
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FBBC433C8;
	Tue, 15 Aug 2023 08:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692086761;
	bh=MBjm+i9oi2ovjJMqGomAYUboVzAwAtJyrjcdgX8noeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZWSfEB167QEpWQhBRCSB/0mt7Mx57zwzwAS1gjcDe7zXNzq1dO8d6V419dvV8dIp
	 E7EyMkdi7QDHs7jWoD/TlVe5eHOVNd9tttE1Czn7m2K6IAedfY+oa/7gOSf0d+MCNi
	 07WXZd6/pKzqeRmAwtu6+KBXiG/pQOMFeoHJdF1N5RrQwJRdGyp6IfxkiGMzZMsPvE
	 vEoRcIduM2Y8koNlu7K3xvBcRAd4XlOkrKRUZus0YY3wsKlc5+Qi/m06QEyJApm/I0
	 arjNyZU5wy7ploc4kHMMRt5ZPxoe9O5SWRdp0F55aLtCQVAFkPgqJCH+9EP4ra/YSq
	 Gy/mJ8qPiCLpA==
Date: Tue, 15 Aug 2023 11:05:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Florian Westphal <fw@strlen.de>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	steffen.klassert@secunet.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	timo.teras@iki.fi, yuehaibing@huawei.com, weiyongjun1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch net, v2] net: xfrm: skip policies marked as dead while
 reinserting policies
Message-ID: <20230815080557.GK22185@unreal>
References: <20230814140013.712001-1-dongchenchen2@huawei.com>
 <20230815060026.GE22185@unreal>
 <20230815060454.GA2833@breakpoint.cc>
 <20230815073033.GJ22185@unreal>
 <ZNsukMSQmzmXpgbS@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNsukMSQmzmXpgbS@gondor.apana.org.au>

On Tue, Aug 15, 2023 at 03:51:44PM +0800, Herbert Xu wrote:
> On Tue, Aug 15, 2023 at 10:30:33AM +0300, Leon Romanovsky wrote:
> >
> > But policy has, and we are not interested in validity of it as first
> > check in if (...) will be true for policy->walk.dead.
> > 
> > So it is safe to call to dir = xfrm_policy_id2dir(policy->index) even
> > for dead policy.
> 
> If you dereference policy->index on a walker object it will read memory
> before the start of the walker object.  That could do anything, perhaps
> even triggering a page fault.

Where do you see walker object? xfrm_policy_id2dir() is called on policy
object, which is defined as "struct xfrm_policy".

Thanks

> 
> Cheers,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

