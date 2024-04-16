Return-Path: <netdev+bounces-88372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2918A6E7C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5FF1F217F0
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0213B78D;
	Tue, 16 Apr 2024 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+q5qeqa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF5E1E494
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278191; cv=none; b=YPwegZBFpNfQVFsXQixTWg9yGInAbosyHNm4Mf7LXNpt18YOPAg0vg6D+e/pQ3mNFcA12dGnQE+hO6u9H6GXTxQUoA2R6EzJdg4JT3oIvyBOOKjdM6UwoUE8MROwbKDldFItTQL5uYD4qgvN1LTxayMTKgfKw+MwykISDK+viNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278191; c=relaxed/simple;
	bh=OMO3Z+vBDNnheSn/i4/lzW6SDprIkCkuQn8+nffrW5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8tboRu1eEGPVBOTcSElslY7z082Li0M/p3IaXu/ISyYlGfbki/x5z94nIhETElSNeugfwNdtT+zHUKyoQIm9mHErW6Eg6CTCKPAIa9SPAnJEgDQt2dISyvbrXK4GzUQHIzC6Qmt6vIErho3y5cmWPQJO3sPHiOo3jCJgATD1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+q5qeqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801FFC113CE;
	Tue, 16 Apr 2024 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713278190;
	bh=OMO3Z+vBDNnheSn/i4/lzW6SDprIkCkuQn8+nffrW5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+q5qeqahuxjRr/9+8zXDKMhkIRtg7EHqPzE2dVWfSOttUlxJsSl0gV1ErQ9pkg5R
	 fuR8HU1UWvMBih7ezPvk6PPYozO/3Wr0CyvzVxC9K5XwfYA6JhPKwGlzaQTX2yx/Us
	 7PsjhBGa7kenXt01t1KfxuN6eYvXzzEL59OiFYjjG8mJhy5Tdma9TgRbz9aqcxLlyN
	 wTLk+dKD21239ly4s30kf2z+41G7vcIF7N1ACkBblt+rDvexE7OFs+WGXWiEqvDnBV
	 MdJi2D3lSeL8pytDJF5v/76g+MDmgL3MCKRkWi4FCfSmxj4J1ILX+D3xtaaxt1vHqS
	 95Tl4TcMzaUFg==
Date: Tue, 16 Apr 2024 15:36:26 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	mlxsw@nvidia.com, Tim 'mithro' Ansell <me@mith.ro>
Subject: Re: [PATCH net 2/3] mlxsw: core_env: Fix driver initialization with
 old firmware
Message-ID: <20240416143626.GR2320920@kernel.org>
References: <cover.1713262810.git.petrm@nvidia.com>
 <314f08cecbcae00340390e077cf20e02d0b48446.1713262810.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <314f08cecbcae00340390e077cf20e02d0b48446.1713262810.git.petrm@nvidia.com>

On Tue, Apr 16, 2024 at 12:24:15PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The driver queries the Management Capabilities Mask (MCAM) register
> during initialization to understand if it can read up to 128 bytes from
> transceiver modules.
> 
> However, not all firmware versions support this register, leading to the
> driver failing to load.
> 
> Fix by treating an error in the register query as an indication that the
> feature is not supported.
> 
> Fixes: 1f4aea1f72da ("mlxsw: core_env: Read transceiver module EEPROM in 128 bytes chunks")
> Reported-by: Tim 'mithro' Ansell <me@mith.ro>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/core_env.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.c b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
> index 53b150b7ae4e..5d02b6aef4d2 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
> @@ -1360,17 +1360,15 @@ static struct mlxsw_linecards_event_ops mlxsw_env_event_ops = {
>  static int mlxsw_env_max_module_eeprom_len_query(struct mlxsw_env *mlxsw_env)
>  {
>  	char mcam_pl[MLXSW_REG_MCAM_LEN];
> -	bool mcia_128b_supported;
> +	bool mcia_128b_supported = false;
>  	int err;
>  
>  	mlxsw_reg_mcam_pack(mcam_pl,
>  			    MLXSW_REG_MCAM_FEATURE_GROUP_ENHANCED_FEATURES);
>  	err = mlxsw_reg_query(mlxsw_env->core, MLXSW_REG(mcam), mcam_pl);
> -	if (err)
> -		return err;
> -
> -	mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_MCIA_128B,
> -			      &mcia_128b_supported);
> +	if (!err)
> +		mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_MCIA_128B,
> +				      &mcia_128b_supported);
>  
>  	mlxsw_env->max_eeprom_len = mcia_128b_supported ? 128 : 48;

Hi Petr and Ido,

This function now always returns 0.
Perhaps the return type can be updated to void?


