Return-Path: <netdev+bounces-25509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F4C774673
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14CA28183D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F721154A9;
	Tue,  8 Aug 2023 18:57:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7AD1427F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0356FC433C8;
	Tue,  8 Aug 2023 18:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691521027;
	bh=Yz8kmXDHelcgfNpUcTRyVue95xN8llNn+98L/IKGKR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=riIVQ21Wdku5UYYuh5T/YtsWCZWhUtFORY3womBGnauYPurNSGCsz4MOfW2gMr0NV
	 QU3Cw7k0RuoviH+eOjeBiSjVVqy6HbDY7o/z4q1RsL8TSVelOhTt5tfV7t7DUW3EA/
	 PjUXvQueEo1cIp6hqDxVeZCQEZeJIl3NgjQZB9LjJqyX3Bpm4aWme+CwjJWUrE5ddJ
	 SLKoYuYopBuidifjlanuVFSsF96zuEd9VDOWedTftawsv/7oQCz/ZYUWWUOhnGE7Vx
	 OH28kkaJR2LyhuYY9f0BEe10z7PyxhncQBdfkPFVp+0LLHLUEq0PV8Fv58xDupXdFT
	 zlVyR9Tsxmipg==
Date: Tue, 8 Aug 2023 21:57:00 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/10] mlx4: Avoid resetting MLX4_INTFF_BONDING
 per driver
Message-ID: <20230808185700.GK94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-7-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-7-petr.pavlu@suse.com>

On Fri, Aug 04, 2023 at 05:05:23PM +0200, Petr Pavlu wrote:
> The mlx4_core driver has a logic that allows a sub-driver to set the
> MLX4_INTFF_BONDING flag which then causes that function mlx4_do_bond()
> asks the sub-driver to fully re-probe a device when its bonding
> configuration changes.
> 
> Performing this operation is disallowed in mlx4_register_interface()
> when it is detected that any mlx4 device is multifunction (SRIOV). The
> code then resets MLX4_INTFF_BONDING in the driver flags.
> 
> Move this check directly into mlx4_do_bond(). It provides a better
> separation as mlx4_core no longer directly modifies the sub-driver flags
> and it will allow to get rid of explicitly keeping track of all mlx4
> devices by the intf.c code when it is switched to an auxiliary bus.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/intf.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

