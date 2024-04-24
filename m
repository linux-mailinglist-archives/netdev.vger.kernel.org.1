Return-Path: <netdev+bounces-90983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CCE8B0D42
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCAAFB253D9
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F357315F41B;
	Wed, 24 Apr 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syIDAmzU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35915F414
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970356; cv=none; b=E8Y5pU9siMW7XCuvh3MAfh6dZ6uUB02nBkGBbCdebZKqBSm4CwLABOv10Wimau0sxPu7K/Jt0s0kK9PU+VntNh4KAZZ5OkA3LdZNfDQNEVmonXR/95gA+c62eEBoPbuinyIL9Ayp9tFeIB4ERIkSJ+D0EtM24Hy3XdaO9gp8LCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970356; c=relaxed/simple;
	bh=5x3yHfuXonp2WI73CmKckwBu5jWagrDv+Ekt4EbPEaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL0fwcIYKIDPlIh0+SKhn/s46cRYKUp6/mKqZ+qR0+2He7TYWDTCSinrYYRVH6WBTekxsXdpmYaqZlhF4mGVxSOK/uKn6I+W2MolEacjl1kGYnChdxvlhpZ2lXhVrNgrDMZlb5/KwhISB76fQqXHOJEho0rUTKkY7a0foHlHYvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syIDAmzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761B0C2BD10;
	Wed, 24 Apr 2024 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713970356;
	bh=5x3yHfuXonp2WI73CmKckwBu5jWagrDv+Ekt4EbPEaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syIDAmzUIETVy84bRuRhJAdvNe5and4Osfsszd9Gc2RWV3fVV0ftalynsLRBx4+OE
	 leeWIJls97oM8ACzo8/314E0qB3tDqDe/9rzQh49zVEJLP1WdD1phhepa2TJBseqeh
	 LJGZBzwJL0G+jRbJgA3/vwcmdYMpFzsFwI3g3PYlCvTFP290pzFaUNF6icbxKbiPeC
	 KQbimIicsm9ytenGlVkQaKshfxfjgJmy7DrfUFoCSa4ynckMPrqrM8+GpjgRuibBl/
	 5gsbV5Vn3U2evRvN2YSa5p7hzdUn89Y2X/uO720e4XNBv/+Y8K7JCwQLa0qPYtqOag
	 MwkGd6eXMRddg==
Date: Wed, 24 Apr 2024 15:52:32 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov <green@qrator.net>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net 7/9] mlxsw: spectrum_acl_tcam: Fix warning during
 rehash
Message-ID: <20240424145232.GI42092@kernel.org>
References: <cover.1713797103.git.petrm@nvidia.com>
 <cc17eed86b41dd829d39b07906fec074a9ce580e.1713797103.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc17eed86b41dd829d39b07906fec074a9ce580e.1713797103.git.petrm@nvidia.com>

On Mon, Apr 22, 2024 at 05:26:00PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> As previously explained, the rehash delayed work migrates filters from
> one region to another. This is done by iterating over all chunks (all
> the filters with the same priority) in the region and in each chunk
> iterating over all the filters.
> 
> When the work runs out of credits it stores the current chunk and entry
> as markers in the per-work context so that it would know where to resume
> the migration from the next time the work is scheduled.
> 
> Upon error, the chunk marker is reset to NULL, but without resetting the
> entry markers despite being relative to it. This can result in migration
> being resumed from an entry that does not belong to the chunk being
> migrated. In turn, this will eventually lead to a chunk being iterated
> over as if it is an entry. Because of how the two structures happen to
> be defined, this does not lead to KASAN splats, but to warnings such as
> [1].
> 
> Fix by creating a helper that resets all the markers and call it from
> all the places the currently only reset the chunk marker. For good
> measures also call it when starting a completely new rehash. Add a
> warning to avoid future cases.
> 
> [1]
> WARNING: CPU: 7 PID: 1076 at drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c:407 mlxsw_afk_encode+0x242/0x2f0
> Modules linked in:
> CPU: 7 PID: 1076 Comm: kworker/7:24 Tainted: G        W          6.9.0-rc3-custom-00880-g29e61d91b77b #29
> Hardware name: Mellanox Technologies Ltd. MSN3700/VMOD0005, BIOS 5.11 01/06/2019
> Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
> RIP: 0010:mlxsw_afk_encode+0x242/0x2f0
> [...]
> Call Trace:
>  <TASK>
>  mlxsw_sp_acl_atcam_entry_add+0xd9/0x3c0
>  mlxsw_sp_acl_tcam_entry_create+0x5e/0xa0
>  mlxsw_sp_acl_tcam_vchunk_migrate_all+0x109/0x290
>  mlxsw_sp_acl_tcam_vregion_rehash_work+0x6c/0x470
>  process_one_work+0x151/0x370
>  worker_thread+0x2cb/0x3e0
>  kthread+0xd0/0x100
>  ret_from_fork+0x34/0x50
>  </TASK>
> 
> Fixes: 6f9579d4e302 ("mlxsw: spectrum_acl: Remember where to continue rehash migration")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


