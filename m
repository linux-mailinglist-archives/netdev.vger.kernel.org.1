Return-Path: <netdev+bounces-27609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A8377C88D
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119AD1C20B82
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038AA957;
	Tue, 15 Aug 2023 07:30:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60BD79DC
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D60EC433C7;
	Tue, 15 Aug 2023 07:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692084638;
	bh=SbIDQHXt/hhs9F57hfAmfS0Ie2IAVVlXFLiLxVti/74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NO/RpVZfB/c/U8hCBZBj9r6JDwYMBBSo/hMEvrGfVEC+/5zTAKi3ribpuuiLZkFhZ
	 42V+Ij5BR3IFxLTbvZyBMjnah5YSYeYD7xzDDr8diiI8st2pB1nl3VM/EZ818m76Tr
	 aswmIrDKv6l9RxnDnGQTj8JnSPQazgEfl2tj5hps8UBRNNri5Vq4IdyU8kP2xjqK9q
	 yZvvoO46/rwSPfwAbTNgZb5HRf8W8m5Y+7P5loozts1vOj70tlHRk/ERei5lOT1E2k
	 j6Hd0FP4EuhdH4u61/1NTYVgiL2xY6Tw4m1/af4emGCmlUWVvWkfIiBWelITh86Rl2
	 UY5/9rtp7LXFQ==
Date: Tue, 15 Aug 2023 10:30:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Dong Chenchen <dongchenchen2@huawei.com>, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	timo.teras@iki.fi, yuehaibing@huawei.com, weiyongjun1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch net, v2] net: xfrm: skip policies marked as dead while
 reinserting policies
Message-ID: <20230815073033.GJ22185@unreal>
References: <20230814140013.712001-1-dongchenchen2@huawei.com>
 <20230815060026.GE22185@unreal>
 <20230815060454.GA2833@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815060454.GA2833@breakpoint.cc>

On Tue, Aug 15, 2023 at 08:04:54AM +0200, Florian Westphal wrote:
> Leon Romanovsky <leon@kernel.org> wrote:
> > >  		dir = xfrm_policy_id2dir(policy->index);
> > > -		if (policy->walk.dead || dir >= XFRM_POLICY_MAX)
> > > +		if (dir >= XFRM_POLICY_MAX)
> > 
> > This change is unnecessary, previous code was perfectly fine.
> 
> Are you sure? AFAICS walker struct has no 'index' member.

But policy has, and we are not interested in validity of it as first
check in if (...) will be true for policy->walk.dead.

So it is safe to call to dir = xfrm_policy_id2dir(policy->index) even
for dead policy.

Thanks

