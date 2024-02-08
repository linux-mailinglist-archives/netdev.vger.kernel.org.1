Return-Path: <netdev+bounces-70278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0581D84E3AD
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 16:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7281C2410A
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135AE7B3C5;
	Thu,  8 Feb 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mdq0MRLH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42DB7A738
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404755; cv=none; b=j8GuB3LDTN4KW5tYV3hk3DNfjVPeAC8MxfCPPQVg/YhBsEqDGxPq1J2WnDhcrg7yO6z7te2tqMDDxyy32Cj/woe0B2XTDvCUf49QB2w9eIbC3IYW88AEuBtG41rus/AHqNhVm8PfPcwjQiwc9f+ssVbM47sxXLT9m4E1GUjl8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404755; c=relaxed/simple;
	bh=2uvW8kPnzkkWIWFn6yWuvb0snEIJfj8JXilHbn0rjJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9rPCsDBKEaQn6EklBwLVfPAM9YIqTsFfXByDu2p84M+SAm2VWBFphduPGqLfaOuKITEySw3C0yPtSdgz78WvgT8zQOf6NUgzkGKJCcS1jm2ODopsbJ94Sp9AInUNz2PgIA0nWhN4IerrAI07TmWP02iMAxJnNDj+knaYOtzLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mdq0MRLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40726C433F1;
	Thu,  8 Feb 2024 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707404754;
	bh=2uvW8kPnzkkWIWFn6yWuvb0snEIJfj8JXilHbn0rjJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mdq0MRLHKSSkEK2HNBg4fXd2fbagQ9FADhpkP8TfJMChDrNOyCrbVyiqiuM+VAHcu
	 DqEbEEbRpQnTNI9CVIGnWRdaLSBp6ZgdWzL1oDUe3cWblTUggJ0h6vKC4snh82HWdY
	 d+UGzeU0Y87FZItD9G9pUvhG1Np05uYQRVnKZdFLSwD/IU6b5Boey51bIs12vuQFvb
	 D25ozZY/bs0iELViMgm+1KNzpCdf8SGmR6PKRCRSJSCg69CLwpIuv676o1bSLOPU4C
	 L95r6b7vm+R2cXQyvcpmTTGWlAL1Mu9X0Agm0CUAcv1HohU17iJ+tugz/7xqYgqJ5k
	 2tUhuIyooP0Iw==
Date: Thu, 8 Feb 2024 15:05:50 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [patch net] net/mlx5: DPLL, Fix possible use after free after
 delayed work timer triggers
Message-ID: <20240208150550.GK1435458@kernel.org>
References: <20240206164328.360313-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206164328.360313-1-jiri@resnulli.us>

On Tue, Feb 06, 2024 at 05:43:28PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> I managed to hit following use after free warning recently:

...

> I didn't manage to reproduce it. Though the issue seems to be obvious.
> There is a chance that the mlx5_dpll_remove() calls
> cancel_delayed_work() when the work runs and manages to re-arm itself.
> In that case, after delay timer triggers next attempt to queue it,
> it works with freed memory.
> 
> Fix this by using cancel_delayed_work_sync() instead which makes sure
> that work is done when it returns.
> 
> Fixes: 496fd0a26bbf ("mlx5: Implement SyncE support using DPLL infrastructure")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


