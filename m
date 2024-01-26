Return-Path: <netdev+bounces-66279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C32283E3C0
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C63A1F26834
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 21:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD598249F0;
	Fri, 26 Jan 2024 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5c2XL7h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B30249E4
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303686; cv=none; b=bvZu4kWg7dEbD8UCE56PAdbsbM+UuecYE5MZByjlCBC3RR/Zv6Lk3eIkV8WDt1/2aIi84Qh/TdGRvfc7j5UjOIBzo2RmPMp2wvsRUDHF85hXNiBj9UXI33Ym9pWX6l95TwHGUOHi3FfDMOxpC1nO+FgL7NokOTgHL+yHrchEhV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303686; c=relaxed/simple;
	bh=ddgyhT5l8a4neWPXdkQQmIhRJQzuqcyyjo3CnbGfr5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STpGzgAaXMeCbPCWw79vvdF63pGzFXSGmhMSuoWRQIp79e1F1qiEcTsLvnPQ+OvEbzFfOCqKRG/J4dRB+PIKDG6WMk10IUaShIPEwQcnEI5ju24DPtEVOw4h56S3sKDeJq68j15i3ap/s7fH7xfXQsbH9IHu/n1lh/Dv5DLUeKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5c2XL7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D09C43394;
	Fri, 26 Jan 2024 21:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706303686;
	bh=ddgyhT5l8a4neWPXdkQQmIhRJQzuqcyyjo3CnbGfr5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5c2XL7h9VsfkT5jNccVWizIEAR6YjRJDYbaodzTn82njxdZl8Kzj2lT7rVCSlNEo
	 af5dAqH0wA4QNUS87t9gL1E2vnBh/EeD3AqTSxDeimKvr4imeFYTID3EbtD+IK8mQT
	 PF1+uD51DgyldhwTnSxTgtHzgi2uB9oBw3Wjbn6EM/h/5vvISBaMAkyZIGnN7biF7t
	 aBktub+0Il0RhdBKBczC/VNwnTbnhTU3Ry7jeveIP5QCldqBSNzyzM6YthmrbGlgUM
	 hw9tCZsqPf0Oqu+z3NoXC5dKfBkIcZp528eCeZvyhte8+sMk1HcHwP+iFZmF3AUBWI
	 VCrJJr1vWLYiw==
Date: Fri, 26 Jan 2024 21:14:41 +0000
From: Simon Horman <horms@kernel.org>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next] taprio: validate TCA_TAPRIO_ATTR_FLAGS
 through policy instead of open-coding
Message-ID: <20240126211441.GF401354@kernel.org>
References: <20240125165942.37920-1-alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125165942.37920-1-alessandromarcolini99@gmail.com>

On Thu, Jan 25, 2024 at 05:59:42PM +0100, Alessandro Marcolini wrote:
> As of now, the field TCA_TAPRIO_ATTR_FLAGS is being validated by manually
> checking its value, using the function taprio_flags_valid().
> 
> With this patch, the field will be validated through the netlink policy
> NLA_POLICY_MASK, where the mask is defined by TAPRIO_SUPPORTED_FLAGS.
> The mutual exclusivity of the two flags TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD
> and TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST is still checked manually.
> 
> Changes since RFC:
> - fixed reversed xmas tree
> - use NL_SET_ERR_MSG_MOD() for both invalid configuration
> 
> Changes since v1:
> - Changed NL_SET_ERR_MSG_MOD to NL_SET_ERR_MSG_ATTR when wrong flags
>   issued
> - Changed __u32 to u32
> 
> Changes since v2:
> - Added the missing parameter for NL_SET_ERR_MSG_ATTR (sorry again for
>   the noise)
> 
> Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
> ---

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

For reference, and I don't think it's probably not
necessary to repost because of this, these days
it is normal to put the Changes below the scissors (---).
This means they don't end up in the git history.
But now we have lore that seems to be less of an issue.


