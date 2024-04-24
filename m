Return-Path: <netdev+bounces-90980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D53318B0D3A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665F71F27971
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFF615EFCB;
	Wed, 24 Apr 2024 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OM7383lA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E3A15ECD4
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970327; cv=none; b=NpDzMWWITM0jtXOZBRtkvxmRatdYzdVMLKo2Iwna0lN/A32ty85E/L9rS5URtF8rRX0kbRsBzgXOTdIC3Iwi8/zqhk+isU3Le3fG6Y1Mw1YU5+o/ZBKf1NzIut/HwcTbOEUYEllNwy+nfbHZOGsV3p6hRBLMobzBPb0VeZJ+IVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970327; c=relaxed/simple;
	bh=cACQyMhstsz88NRckV8hjM1YF2dp4LZ/nfybjX86E5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDfU6BbTjp3fGaAgKF7ZPvdZxNjU+jeBoJd+mUM/sSh2+BDW0lZB8FmrSkWG7qupYf2wUPC/OQX3ZJCar/Tv4/A2iTTGWN4rPBAiJjumzIrjT/CPe+3NW4HG7sN8hMr6p3dXBRyGW9gHBckmf+7gyAySU4QBpHl3k0D4YYogwLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OM7383lA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC18C113CD;
	Wed, 24 Apr 2024 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713970327;
	bh=cACQyMhstsz88NRckV8hjM1YF2dp4LZ/nfybjX86E5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OM7383lAARbCmbhtheD7NYbmputEttiBmRpMWIBEEKaE+jn/6kOwCABzP4AWMGLu7
	 XpSQf6T5W54WkuU6xpL3DvsXQM9RU4529E+xsdk40yVhDjFdjHfQEyNn2fZTmaM0aK
	 TuZ6VFTLsHMOHLjADsR2RRiO4TFdNWTuGlUm/wgM/x5SbY6VGa+Ro48P4YEimlruKg
	 st1Ba89uAC2TJHCPOROBPsMkwqUsLjUnQVCB1Tj27k5yJj+DqP65Z9rjzRuC9Sbe0i
	 Pd8IsFDbkZxfSwgt8Y/3qLXMSxyWlK5+/27xxCXR2AxQXeNjYwDgsFkya68yzE+kNo
	 MByvYUXiNdzlg==
Date: Wed, 24 Apr 2024 15:52:02 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov <green@qrator.net>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net 6/9] mlxsw: spectrum_acl_tcam: Fix memory leak during
 rehash
Message-ID: <20240424145202.GH42092@kernel.org>
References: <cover.1713797103.git.petrm@nvidia.com>
 <d5edd4f4503934186ae5cfe268503b16345b4e0f.1713797103.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5edd4f4503934186ae5cfe268503b16345b4e0f.1713797103.git.petrm@nvidia.com>

On Mon, Apr 22, 2024 at 05:25:59PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The rehash delayed work migrates filters from one region to another.
> This is done by iterating over all chunks (all the filters with the same
> priority) in the region and in each chunk iterating over all the
> filters.
> 
> If the migration fails, the code tries to migrate the filters back to
> the old region. However, the rollback itself can also fail in which case
> another migration will be erroneously performed. Besides the fact that
> this ping pong is not a very good idea, it also creates a problem.
> 
> Each virtual chunk references two chunks: The currently used one
> ('vchunk->chunk') and a backup ('vchunk->chunk2'). During migration the
> first holds the chunk we want to migrate filters to and the second holds
> the chunk we are migrating filters from.
> 
> The code currently assumes - but does not verify - that the backup chunk
> does not exist (NULL) if the currently used chunk does not reference the
> target region. This assumption breaks when we are trying to rollback a
> rollback, resulting in the backup chunk being overwritten and leaked
> [1].
> 
> Fix by not rolling back a failed rollback and add a warning to avoid
> future cases.
> 
> [1]
> WARNING: CPU: 5 PID: 1063 at lib/parman.c:291 parman_destroy+0x17/0x20
> Modules linked in:
> CPU: 5 PID: 1063 Comm: kworker/5:11 Tainted: G        W          6.9.0-rc2-custom-00784-gc6a05c468a0b #14
> Hardware name: Mellanox Technologies Ltd. MSN3700/VMOD0005, BIOS 5.11 01/06/2019
> Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
> RIP: 0010:parman_destroy+0x17/0x20
> [...]
> Call Trace:
>  <TASK>
>  mlxsw_sp_acl_atcam_region_fini+0x19/0x60
>  mlxsw_sp_acl_tcam_region_destroy+0x49/0xf0
>  mlxsw_sp_acl_tcam_vregion_rehash_work+0x1f1/0x470
>  process_one_work+0x151/0x370
>  worker_thread+0x2cb/0x3e0
>  kthread+0xd0/0x100
>  ret_from_fork+0x34/0x50
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> Fixes: 843500518509 ("mlxsw: spectrum_acl: Do rollback as another call to mlxsw_sp_acl_tcam_vchunk_migrate_all()")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...


