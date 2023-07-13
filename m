Return-Path: <netdev+bounces-17674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FB9752A28
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 20:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0831C213D2
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557BD1F929;
	Thu, 13 Jul 2023 18:05:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5F720F8B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 18:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227B5C433C7;
	Thu, 13 Jul 2023 18:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689271557;
	bh=JOffV38HpofkL9AhrtqED9xZO/jzqmy3T9Uh5IItXpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EOODMZsSFjgaJsXBRSz3Ak4zsUDupn/NKepwOuZjvA540ttQrrFhIXpWu3YlFgPBM
	 wdMTCo77WQ1FsudH+7EeTGjioYRipWXYS5t/uajE9jnGZMpvS6W+cgfnA5JbIsxMy0
	 9+C3WnGLLtEdjbeH1NDnkLmymtsp1mvFbgQFf/HzRKPvyM1XszJOkLVzTs6iSpfvgg
	 cpcEoIRCvqfeHuEySmGI2eaEqed3QeMkTKcBY/wAJmDorDInCw0LYB4nAFbFdjANdW
	 LATHSry5kXkxYJG7NBOTHCFpSObjcZOwoCk79JFswaoW5xzoV/Y90rVUdCB3bkgRij
	 WG+TBN5J0/J7Q==
Date: Thu, 13 Jul 2023 11:05:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 09/12] net/mlx5: Compare with old_dest param to
 modify rule destination
Message-ID: <20230713110556.682d21ba@kernel.org>
In-Reply-To: <20230713174317.GH41919@unreal>
References: <cover.1689064922.git.leonro@nvidia.com>
	<5fd15672173653d6904333ef197b605b0644e205.1689064922.git.leonro@nvidia.com>
	<20230712173259.4756fe08@kernel.org>
	<20230713063345.GG41919@unreal>
	<20230713100401.5fe0fa77@kernel.org>
	<20230713174317.GH41919@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 20:43:17 +0300 Leon Romanovsky wrote:
> > Reads like "can't be triggered with current code", in which case 
> > the right thing to do is to add "can't be triggered with current
> > code" to the commit message, rather than the Fixes tag.  
> 
> The code is wrong, so comes Fixes line, but I can remove it.

Yes, perhaps after death we will inhabit a world with clear,
non-conflicting rules, where law can be followed to the letter
and "truth" and "good" are clearly and objectively defined.

Until the sweat release, tho, let's apply common sense, and 
not add Fixes tags to patches which can't possibly be of interest 
to backporters.

Please and thank you...

> > I had a look thru the series yesterday, and it looks good to me
> > (tho I'm no ipsec expert). Thanks for putting in the work!
> > 
> > Could you add some info about how the code in the series can be
> > exercised / example configurations? And please CC Simon, it'd be
> > great to get him / someone at Corigine to review.
> > 
> > And obviously Steffen, why did you not CC Steffen?! :o  
> 
> It works exactly like "regular" IPsec, nothing special, except
> now users can switch to switchdev before adding IPsec rules.
> 
>  devlink dev eswitch set pci/0000:06:00.0 mode switchdev
> 
> Same configurations as here:
> https://lore.kernel.org/netdev/cover.1670005543.git.leonro@nvidia.com/
> Packet offload mode:
>   ip xfrm state offload packet dev <if-name> dir <in|out>
>   ip xfrm policy .... offload packet dev <if-name>
> Crypto offload mode:
>   ip xfrm state offload crypto dev <if-name> dir <in|out>
> or (backward compatibility)
>   ip xfrm state offload dev <if-name> dir <in|out>

I see, so all policy based IPsec?
Does the order of processing in the device match the kernel?
TC packet rewrites or IPsec comes first?

> I didn't add Steffen as it is more flow steering magic series
> and not IPsec :).
> 
> I'll resubmit on Sunday.

Thanks!

