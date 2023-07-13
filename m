Return-Path: <netdev+bounces-17666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F07752A00
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14C01C2140F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58FA1F198;
	Thu, 13 Jul 2023 17:43:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D051F173
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 17:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4DDC433C7;
	Thu, 13 Jul 2023 17:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689270201;
	bh=VMQgTRexU8gK7QDdbgMUyLMgwOWHm6tyCRiZtVTWiP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9o1DEHfbUeIZ8cXLls5jIS/XwjtsxifbZp0+YlW694OFUAtuJHmCFATBGaD9vDb4
	 mKhMeI+MtnaAo0RVU2aU3q3xbVdgRn37kD1FdEcdh2pejpvA7qrM4rj6u4H0OkULJQ
	 QD5GIoYbaTyLMQ/p5ytemJAVvSlpfBX1OLCWEnsWgaDrWtWzUwyOceaNBcdCpmyWdQ
	 u9R54OpF6kTMlXSuRex2jrDh/eG0pm5lp+19o157l//CXbQIgdVBvVhD3dOp68TeGk
	 mQwMYrXRFE3qnkILyMjmnPjSancnYUzwzJVWYfjMWnstraLNjOoJ9ejxpJJnN+CHsD
	 fGHaQWo1lMhnQ==
Date: Thu, 13 Jul 2023 20:43:17 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Eric Dumazet <edumazet@google.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 09/12] net/mlx5: Compare with old_dest param to
 modify rule destination
Message-ID: <20230713174317.GH41919@unreal>
References: <cover.1689064922.git.leonro@nvidia.com>
 <5fd15672173653d6904333ef197b605b0644e205.1689064922.git.leonro@nvidia.com>
 <20230712173259.4756fe08@kernel.org>
 <20230713063345.GG41919@unreal>
 <20230713100401.5fe0fa77@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713100401.5fe0fa77@kernel.org>

On Thu, Jul 13, 2023 at 10:04:01AM -0700, Jakub Kicinski wrote:
> On Thu, 13 Jul 2023 09:33:45 +0300 Leon Romanovsky wrote:
> > > This says Fixes, should I quickly toss it into net so it makes
> > > tomorrow's PR?  
> > 
> > This is a fix, but it useful for this series only, which actually
> > needs to modify flow steering rule destinations on the fly.
> > 
> > There is no other code in mlx5 which needs this fix.
> 
> Reads like "can't be triggered with current code", in which case 
> the right thing to do is to add "can't be triggered with current
> code" to the commit message, rather than the Fixes tag.

The code is wrong, so comes Fixes line, but I can remove it.

> 
> I had a look thru the series yesterday, and it looks good to me
> (tho I'm no ipsec expert). Thanks for putting in the work!
> 
> Could you add some info about how the code in the series can be
> exercised / example configurations? And please CC Simon, it'd be
> great to get him / someone at Corigine to review.
> 
> And obviously Steffen, why did you not CC Steffen?! :o

It works exactly like "regular" IPsec, nothing special, except
now users can switch to switchdev before adding IPsec rules.

 devlink dev eswitch set pci/0000:06:00.0 mode switchdev

Same configurations as here:
https://lore.kernel.org/netdev/cover.1670005543.git.leonro@nvidia.com/
Packet offload mode:
  ip xfrm state offload packet dev <if-name> dir <in|out>
  ip xfrm policy .... offload packet dev <if-name>
Crypto offload mode:
  ip xfrm state offload crypto dev <if-name> dir <in|out>
or (backward compatibility)
  ip xfrm state offload dev <if-name> dir <in|out>

I didn't add Steffen as it is more flow steering magic series
and not IPsec :).

I'll resubmit on Sunday.

Thanks

