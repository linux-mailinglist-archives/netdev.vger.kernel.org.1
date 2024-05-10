Return-Path: <netdev+bounces-95523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEF58C27E0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 17:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E74287DA4
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A0617107F;
	Fri, 10 May 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlVZZVxI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA8D171078
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355098; cv=none; b=sZ8KFxTGd0kjyOmqU3I9bbYJ+pP2vgJPuUOMYSdFWD0A30fWtg/pUwCffzDUDP0w8fQbjLMoP7SvXHBw+c3YgfnZVN9RAbDi8dslndXAItF4LEb9aupaAQABaLao4FRyVgibrSVlmO2mythS4ysSLKw/dKx9yGOZndAUKsVHRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355098; c=relaxed/simple;
	bh=Oi9NEHASOXuewRoh3iOeTIdWpwfp17+Yk6hzeitr6nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rn7kzhfJWT02GwWm89oFCKuAupkyZm7BubSBzwB55zMw0tCfMUAkrsOpZqZNykoDrrVyp3Yx/WW+CoEO6s/tGNaaN5P36Jdoke1nCuZ/Wx7ghpgXCx637f8amK8pMHLYnfMPTqci37ylKOKU8Yyfy07XkuM+LJU1hxOAg9I98Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlVZZVxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69970C113CC;
	Fri, 10 May 2024 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715355097;
	bh=Oi9NEHASOXuewRoh3iOeTIdWpwfp17+Yk6hzeitr6nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GlVZZVxImpI/8ZrhkbUJR5P357gUHlZa15tvpRJYQz5FX1S7aWgSfwlxpqU57WSJu
	 0S0NpUmYzNf0wl4XXNLkOVlk8ckPtdxoYlwbF202GASyBChgi+9vksvImGV8E9kR6J
	 oOI/iL9ubaji0ylxD/IrfW1Vfok6BzYKgyEgrE6C1/rpOXlHI/eHUJ8yso6UnPOg9d
	 1EX9aDGJO1X8aq+CEXSlT5dVnuIIhgCeQXFj0qiE6QUNoYAJNSS/KlyPcF5RuAKCRu
	 2KduumzFcmcbmd0lAHSPRzSatvNk5HjiNLPADFdcNz9oRobWr4b7mnQXEJ3Wa/4gTs
	 gGvu1Fj+3uO2Q==
Date: Fri, 10 May 2024 16:31:33 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH net 1/5] net/mlx5e: Fix netif state handling
Message-ID: <20240510153133.GC2347895@kernel.org>
References: <20240509112951.590184-1-tariqt@nvidia.com>
 <20240509112951.590184-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509112951.590184-2-tariqt@nvidia.com>

On Thu, May 09, 2024 at 02:29:47PM +0300, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> mlx5e_suspend cleans resources only if netif_device_present() returns
> true. However, mlx5e_resume changes the state of netif, via
> mlx5e_nic_enable, only if reg_state == NETREG_REGISTERED.
> In the below case, the above leads to NULL-ptr Oops[1] and memory
> leaks:
> 
> mlx5e_probe
>  _mlx5e_resume
>   mlx5e_attach_netdev
>    mlx5e_nic_enable  <-- netdev not reg, not calling netif_device_attach()
>   register_netdev <-- failed for some reason.
> ERROR_FLOW:
>  _mlx5e_suspend <-- netif_device_present return false, resources aren't freed :(
> 
> Hence, clean resources in this case as well.
> 
> [1]
> BUG: kernel NULL pointer dereference, address: 0000000000000000

...

> Fixes: 2c3b5beec46a ("net/mlx5e: More generic netdev management API")
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Hi,

I think that this bug is caused by asymmetry in resource allocation/freeing
such that there are cases where _mlx5e_suspend() doesn't unwind
_mlx5e_resume().

It seems to me that asymmetry was introduced by the check for
reg_state != NETREG_REGISTERED in mlx5e_nic_enable() by:

610e89e05c3f ("net/mlx5e: Don't sync netdev state when not registered")

So perhaps that is a more appropriate commit for the Fixes tag.
I do note that commit was a fix for:

26e59d8077a3 ("net/mlx5e: Implement mlx5e interface attach/detach callbacks")

So perhaps a second fixes tag for that commit is also appropriate.

Perhaps it's not important enough to revise things, I don't feel strongly
about it, so feel free to add the following regardless.

Reviewed-by: Simon Horman <horms@kernel.org>

All that said, I do wonder if it would be better in the long run to
implement things in such a way that there is symmetry in resource
allocation / deallocation. Passing flags to control how much cleanup is
performed does seem a bit awkward.


