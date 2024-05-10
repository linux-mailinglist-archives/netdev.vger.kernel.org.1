Return-Path: <netdev+bounces-95525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2990C8C27FA
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 17:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB521F2123E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E6814F128;
	Fri, 10 May 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSm6Cehh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6DBA41
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355513; cv=none; b=Yxyr+StfnYFLJGgke9BlpyUR6IE9b353MDcxPYlUgCxrOxuyBkIegEYQIYoWISC4cCO0xuqCMaGcg/umd0uFv2vlE2KVfY8TojAfPLu5Bdh4UFkrXKGuXM53esOCHeTVpjcMPHU8mRIwvoT/He6y4ZGMY2c6F9rHGCZ5xcZz2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355513; c=relaxed/simple;
	bh=e4QUd1E3o2WVynnSxkzof7zi0y5Sma144waHZowIdOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpcEdUAsvP4C3DYE00WS7t9+zqvCaiWV246+XHnGqW7Dvz5hJ+0hcHrMrbfkcjMeGS/RvAepj+v12whb8AFCWurieGT0COzRT2HMtG5wif2AJBtvt6UWDP/lcrz0RfwDyLMZ/8KWl3V9N3+xUt4UdZgLo+G76Trt13cyK9107SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSm6Cehh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298BCC113CC;
	Fri, 10 May 2024 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715355512;
	bh=e4QUd1E3o2WVynnSxkzof7zi0y5Sma144waHZowIdOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSm6CehhwvHqY59t8F+aJIGQasGrKLohOVGC5OeCmAmf2qbHIubZX2ArkQVjaOkGh
	 IXk/oZljF9XhN0mEFMTs/8P7eV5jrn09acjkuYckUmZz//nPnrrrD+fRkIfJss340c
	 PZvJ+FTL+QA/CqmtRGMEEO1ydVJaT1PxJHtagVOiRIYHeXdM9dWDpM6ZQ/pxOYnoVy
	 M8fOEar3l6Mb3FTAWDS8a2yD6na1Sek+/1ebesgl+nziYvQb4Cp/5i4SIWdA8xStJb
	 QdVjK40FjLdczwuBHKx5fMb3Fm6yTDCTDu3yrgPEHfFskkXDhFrc8E7fsO6FXSDVkE
	 JKks+Jy7nbVTA==
Date: Fri, 10 May 2024 16:38:27 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net 2/5] net/mlx5: Fix peer devlink set for SF
 representor devlink port
Message-ID: <20240510153827.GD2347895@kernel.org>
References: <20240509112951.590184-1-tariqt@nvidia.com>
 <20240509112951.590184-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509112951.590184-3-tariqt@nvidia.com>

On Thu, May 09, 2024 at 02:29:48PM +0300, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> The cited patch change register devlink flow, and neglect to reflect
> the changes for peer devlink set logic. Peer devlink set is
> triggering a call trace if done after devl_register.[1]
> 
> Hence, align peer devlink set logic with register devlink flow.
> 
> [1]
> WARNING: CPU: 4 PID: 3394 at net/devlink/core.c:155 devlink_rel_nested_in_add+0x177/0x180
> CPU: 4 PID: 3394 Comm: kworker/u40:1 Not tainted 6.9.0-rc4_for_linust_min_debug_2024_04_16_14_08 #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> Workqueue: mlx5_vhca_event0 mlx5_vhca_state_work_handler [mlx5_core]
> RIP: 0010:devlink_rel_nested_in_add+0x177/0x180
> Call Trace:
>  <TASK>
>  ? __warn+0x78/0x120
>  ? devlink_rel_nested_in_add+0x177/0x180
>  ? report_bug+0x16d/0x180
>  ? handle_bug+0x3c/0x60
>  ? exc_invalid_op+0x14/0x70
>  ? asm_exc_invalid_op+0x16/0x20
>  ? devlink_port_init+0x30/0x30
>  ? devlink_port_type_clear+0x50/0x50
>  ? devlink_rel_nested_in_add+0x177/0x180
>  ? devlink_rel_nested_in_add+0xdd/0x180
>  mlx5_sf_mdev_event+0x74/0xb0 [mlx5_core]
>  notifier_call_chain+0x35/0xb0
>  blocking_notifier_call_chain+0x3d/0x60
>  mlx5_blocking_notifier_call_chain+0x22/0x30 [mlx5_core]
>  mlx5_sf_dev_probe+0x185/0x3e0 [mlx5_core]
>  auxiliary_bus_probe+0x38/0x80
>  ? driver_sysfs_add+0x51/0x80
>  really_probe+0xc5/0x3a0
>  ? driver_probe_device+0x90/0x90
>  __driver_probe_device+0x80/0x160
>  driver_probe_device+0x1e/0x90
>  __device_attach_driver+0x7d/0x100
>  bus_for_each_drv+0x80/0xd0
>  __device_attach+0xbc/0x1f0
>  bus_probe_device+0x86/0xa0
>  device_add+0x64f/0x860
>  __auxiliary_device_add+0x3b/0xa0
>  mlx5_sf_dev_add+0x139/0x330 [mlx5_core]
>  mlx5_sf_dev_state_change_handler+0x1e4/0x250 [mlx5_core]
>  notifier_call_chain+0x35/0xb0
>  blocking_notifier_call_chain+0x3d/0x60
>  mlx5_vhca_state_work_handler+0x151/0x200 [mlx5_core]
>  process_one_work+0x13f/0x2e0
>  worker_thread+0x2bd/0x3c0
>  ? rescuer_thread+0x410/0x410
>  kthread+0xc4/0xf0
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x2d/0x50
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork_asm+0x11/0x20
>  </TASK>
> 
> Fixes: bf729988303a ("net/mlx5: Restore mistakenly dropped parts in register devlink flow")
> Fixes: c6e77aa9dd82 ("net/mlx5: Register devlink first under devlink lock")

Hi Tariq, Shay, all,

I agree that this patch addresses problems introduced by both of the
commits cited above. But I also note that they are both fixes for the
following commit. So I wonder if it should be cited in a Fixes tag too.

cf530217408e ("devlink: Notify users when objects are accessible")

> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

The above notwithstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

