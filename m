Return-Path: <netdev+bounces-96537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E7F8C65DF
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11BF7B22510
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 11:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF436D1B2;
	Wed, 15 May 2024 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU0Ui2IV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A976219E8
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715773471; cv=none; b=PaNt9HslB/o1tG/9UohLR2UJHw+ZwwrGfJDHCibCjRSkpMdPIVPT4AxQRoz7nJN0/aCj+ixdsOyAvNDm2s15abBNw0bMVg7ixLsQpKi9VYk3iMeB6RJfNkI1ytpaLSFfXpUHRQ5Gw9KKfxoYga6RQYsqg3+JJ2SJPAWpgwi150U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715773471; c=relaxed/simple;
	bh=mz7nCAbBzHsc6+8nf0xVU1JedGYqnxUgbxB0iRjjLSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMhIqNYnoR6fZfJaJlch9hDdiNwu1XDOg3/M3Ufh5sh0Lj953z0IiyXI4oa+cLlZGU0fWEzXQrWUKmdNRGeN4/eMoiyInA92tvV+AQcQu75exvsNyNwAx83+IGj+7zPbyICI802mfezSqPeYZoUT/mW1uWlOg0t8HXpgMFgWqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU0Ui2IV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C420EC116B1;
	Wed, 15 May 2024 11:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715773470;
	bh=mz7nCAbBzHsc6+8nf0xVU1JedGYqnxUgbxB0iRjjLSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kU0Ui2IVNENmHFIKKjNEVWtOXqIJPQt0Xgr1Ow8ZFlGeif0V7KegPO5Df5kFYilvn
	 /n7/zWvcSZIUH8a7vFxBo2KBIpe893vLApDwdwbg5MazoStxE+jWshiXh2VkY8oarI
	 rbxc1x/x8uIV2oqoFqSwLfwCst+qAckyc3IZHFJUrsgL91m/ZODQA3WNIGaiHBvxO5
	 4D/kLqkFYywu+RCKpaYqaEomUMeYd64hS4k1FOyks4o8AFg7f2uKOJKdB5a65CuFt0
	 ohBJAIfTzZQmC1qQLx/mvX1jRLcqTot4ebBlmHheSFE9mWAJCfxqwPBxRRaa4z++IG
	 cr0fbLxzhNodg==
Date: Wed, 15 May 2024 12:44:26 +0100
From: Simon Horman <horms@kernel.org>
To: Tony Battersby <tonyb@cybernetics.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] bonding: fix oops during rmmod
Message-ID: <20240515114426.GJ154012@kernel.org>
References: <641f914f-3216-4eeb-87dd-91b78aa97773@cybernetics.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <641f914f-3216-4eeb-87dd-91b78aa97773@cybernetics.com>

On Tue, May 14, 2024 at 03:57:29PM -0400, Tony Battersby wrote:
> "rmmod bonding" causes an oops ever since commit cc317ea3d927 ("bonding:
> remove redundant NULL check in debugfs function").  Here are the relevant
> functions being called:
> 
> bonding_exit()
>   bond_destroy_debugfs()
>     debugfs_remove_recursive(bonding_debug_root);
>     bonding_debug_root = NULL; <--------- SET TO NULL HERE
>   bond_netlink_fini()
>     rtnl_link_unregister()
>       __rtnl_link_unregister()
>         unregister_netdevice_many_notify()
>           bond_uninit()
>             bond_debug_unregister()
>               (commit removed check for bonding_debug_root == NULL)
>               debugfs_remove()
>               simple_recursive_removal()
>                 down_write() -> OOPS
> 
> However, reverting the bad commit does not solve the problem completely
> because the original code contains a race that could cause the same
> oops, although it was much less likely to be triggered unintentionally:
> 
> CPU1
>   rmmod bonding
>     bonding_exit()
>       bond_destroy_debugfs()
>         debugfs_remove_recursive(bonding_debug_root);
> 
> CPU2
>   echo -bond0 > /sys/class/net/bonding_masters
>     bond_uninit()
>       bond_debug_unregister()
>         if (!bonding_debug_root)
> 
> CPU1
>         bonding_debug_root = NULL;
> 
> So do NOT revert the bad commit (since the removed checks were racy
> anyway), and instead change the order of actions taken during module
> removal.  The same oops can also happen if there is an error during
> module init, so apply the same fix there.
> 
> Fixes: cc317ea3d927 ("bonding: remove redundant NULL check in debugfs function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>

Reviewed-by: Simon Horman <horms@kernel.org>


