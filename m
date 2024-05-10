Return-Path: <netdev+bounces-95527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D388C2831
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 17:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64781C20B2C
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD0171672;
	Fri, 10 May 2024 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+BiQFiI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F7517109F
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715356267; cv=none; b=tl/u775pVyipB37jEpbBYKnX8lw+n0pKF6pJP+Wq55lruYXd3QEUWnHRWMbFOc+DJyhYA88xMAV7kgV7JLeuz0WBUXNK+74H3eSsNKqvq4Xrn9kv9e+eaNPB9Em0IUZMrhjFEOdXoNbCs8Id4R/nJ5he0ZGyE+BrlWgworuYk9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715356267; c=relaxed/simple;
	bh=bwhw9xfTF12vBBFR3nb3ZRyGZjn7sganRoVIUqYiKu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjAZZzpfLzFP5XF4ZWLcOZydcuEipETvXylpeDgEgtlt87SkWZKt6b3ikZiztIg++jn2i6/3QTjriHUgwJ130D6MmiqfWGqqwfkQie5WrrhAjW3Ryx692SQhRQ55jUZawPJLyZqwvtE3mT88lAD266xj1+sMvU41VUOc1JDiJW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+BiQFiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B45C113CC;
	Fri, 10 May 2024 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715356267;
	bh=bwhw9xfTF12vBBFR3nb3ZRyGZjn7sganRoVIUqYiKu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+BiQFiId7p94jIf5klSQvOrIlSoQCE6jindoHoSAOep3FK0P2PB5HW6qaMBpFjjT
	 1jkJuNBJ63TAeheSNwhzRDjJsGKmPaPTjvwO9GmyydA5wF/st4VyDfSEiapEavfAbq
	 Pfo2Ma8dyknxRcOKxcB7esP8u0uoTO5YStHCRSHUrAwTiwclDghu/yxdv0NG/fl7D7
	 /hSPbvsOEQUjnxPt+fF6ojfl2JP7MhdNBZIwjVt3iIGZ+6OuWxpuIueTANztA/VGWQ
	 Y8X9UJXWQTYPJghoK9R7+R+TdqLWgeuXEMgLyOwwHj1qsl0/6h3qvxk6/KumrGDc5i
	 nMhwV7YntGXYg==
Date: Fri, 10 May 2024 16:51:02 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH net 3/5] net/mlx5: Reload only IB representors upon lag
 disable/enable
Message-ID: <20240510155102.GE2347895@kernel.org>
References: <20240509112951.590184-1-tariqt@nvidia.com>
 <20240509112951.590184-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509112951.590184-4-tariqt@nvidia.com>

On Thu, May 09, 2024 at 02:29:49PM +0300, Tariq Toukan wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> On lag disable, the bond IB device along with all of its
> representors are destroyed, and then the slaves' representors get reloaded.
> 
> In case the slave IB representor load fails, the eswitch error flow
> unloads all representors, including ethernet representors, where the
> netdevs get detached and removed from lag bond. Such flow is inaccurate
> as the lag driver is not responsible for loading/unloading ethernet
> representors. Furthermore, the flow described above begins by holding
> lag lock to prevent bond changes during disable flow. However, when
> reaching the ethernet representors detachment from lag, the lag lock is
> required again, triggering the following deadlock:
> 
> Call trace:
> __switch_to+0xf4/0x148
> __schedule+0x2c8/0x7d0
> schedule+0x50/0xe0
> schedule_preempt_disabled+0x18/0x28
> __mutex_lock.isra.13+0x2b8/0x570
> __mutex_lock_slowpath+0x1c/0x28
> mutex_lock+0x4c/0x68
> mlx5_lag_remove_netdev+0x3c/0x1a0 [mlx5_core]
> mlx5e_uplink_rep_disable+0x70/0xa0 [mlx5_core]
> mlx5e_detach_netdev+0x6c/0xb0 [mlx5_core]
> mlx5e_netdev_change_profile+0x44/0x138 [mlx5_core]
> mlx5e_netdev_attach_nic_profile+0x28/0x38 [mlx5_core]
> mlx5e_vport_rep_unload+0x184/0x1b8 [mlx5_core]
> mlx5_esw_offloads_rep_load+0xd8/0xe0 [mlx5_core]
> mlx5_eswitch_reload_reps+0x74/0xd0 [mlx5_core]
> mlx5_disable_lag+0x130/0x138 [mlx5_core]
> mlx5_lag_disable_change+0x6c/0x70 [mlx5_core] // hold ldev->lock
> mlx5_devlink_eswitch_mode_set+0xc0/0x410 [mlx5_core]
> devlink_nl_cmd_eswitch_set_doit+0xdc/0x180
> genl_family_rcv_msg_doit.isra.17+0xe8/0x138
> genl_rcv_msg+0xe4/0x220
> netlink_rcv_skb+0x44/0x108
> genl_rcv+0x40/0x58
> netlink_unicast+0x198/0x268
> netlink_sendmsg+0x1d4/0x418
> sock_sendmsg+0x54/0x60
> __sys_sendto+0xf4/0x120
> __arm64_sys_sendto+0x30/0x40
> el0_svc_common+0x8c/0x120
> do_el0_svc+0x30/0xa0
> el0_svc+0x20/0x30
> el0_sync_handler+0x90/0xb8
> el0_sync+0x160/0x180
> 
> Thus, upon lag enable/disable, load and unload only the IB representors
> of the slaves preventing the deadlock mentioned above.
> 
> While at it, refactor the mlx5_esw_offloads_rep_load() function to have
> a static helper method for its internal logic, in symmetry with the
> representor unload design.
> 
> Fixes: 598fe77df855 ("net/mlx5: Lag, Create shared FDB when in switchdev mode")
> Co-developed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


