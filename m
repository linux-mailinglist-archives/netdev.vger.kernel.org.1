Return-Path: <netdev+bounces-150595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE4A9EAD52
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF16D188DECE
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3D8223E89;
	Tue, 10 Dec 2024 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Asu0KpH2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB86223E90
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824410; cv=none; b=RerAQMAEuxbfKbknHSYz3cmrFB5TvB2e+sdpnzzAEPRk/0AbRL8T03An6o2l5ZCC45e8i2S+OTv8WvtoyU1jTnhkeRMEQUasod+DhbRncsazQ5Ei4jDrloVMM6Lc4Bw0Jntb/651u/aqVNhGxyiglRGZH5BYAwCGZN+DpnuZ7ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824410; c=relaxed/simple;
	bh=5j4Dk8LXBjZqOyEFGw3cHHkqdvLYPJPuGAYZqOZ1gsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjRwcfP9XvDaNLUsqnu9zsJbygyr8kkv0kUoJgfQpUeHZXJZdnDDsSv2SuTDEGbdJ50rVsSNNeqk33kPBURcW0eQWNxRUsVZwgMt2bMOuhvnrQoFKJCglQUyW6i5kmDjReVS3nrkxhb8KzowSI4wnAm0nTvRIUIVa9GBifVnRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Asu0KpH2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733824409; x=1765360409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5j4Dk8LXBjZqOyEFGw3cHHkqdvLYPJPuGAYZqOZ1gsg=;
  b=Asu0KpH21kPBA93osX+KP8P/+5Fy+dvm+eCn2yyv1/RSw50oSKyTg+ZO
   r4n53/rhuzGKPPhNtMCOQEIv0ErtZdm5Bio+p7iILASrykdPta2pmzDop
   e6Ad0kKDcAUF7WUo40VyO1NYQ3ODN91WrJ+1iQxhJvft1HH9LIRkLHzQZ
   fs3yQwSpXY4QZquYWvelJHEWyUYbL3YuKo4llLHIL2yFG3YzyTuHEo2tx
   fzxHDsuTA9Z5aCFgpk8am2s+FLGt+hzL3qzX5kLltzgQWlpm49l0G8vzn
   Lobm8oIxcVYHFKpvATIcI9tFOqM7F3Deb9s936YPEZaXEkPr1mT1RpPop
   g==;
X-CSE-ConnectionGUID: BDj2rhfeQ2u+MPCnu/d6dQ==
X-CSE-MsgGUID: c23XTtgPSL2PF3OYd3rqKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45541953"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45541953"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 01:53:26 -0800
X-CSE-ConnectionGUID: 4iYS4OinRDmUfCLTyTXixw==
X-CSE-MsgGUID: URPu72AYQYWamYBoeRw1cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="132743742"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 01:53:24 -0800
Date: Tue, 10 Dec 2024 10:50:21 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
	Vladyslav Mykhaliuk <vmykhaliuk@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next] mlxsw: spectrum_flower: Do not allow mixing
 sample and mirror actions
Message-ID: <Z1gO3ewMq07er0TN@mev-dev.igk.intel.com>
References: <d6c979914e8706dbe1dedbaf29ffffb0b8d71166.1733822570.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6c979914e8706dbe1dedbaf29ffffb0b8d71166.1733822570.git.petrm@nvidia.com>

On Tue, Dec 10, 2024 at 10:45:37AM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The device does not support multiple mirror actions per rule and the
> driver rejects such configuration:
> 
>  # tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw action mirred egress mirror dev swp2 action mirred egress mirror dev swp3
>  Error: mlxsw_spectrum: Multiple mirror actions per rule are not supported.
>  We have an error talking to the kernel
> 
> Internally, the sample action is implemented by the device by mirroring
> to the CPU port. Therefore, mixing sample and mirror actions in a single
> rule does not work correctly and results in the last action effect.
> 
> Solve by rejecting such misconfiguration:
> 
>  # tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw action mirred egress mirror dev swp2 action sample rate 100 group 1
>  Error: mlxsw_spectrum: Sample action after mirror action is not supported.
>  We have an error talking to the kernel
> 
>  # tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw action sample rate 100 group 1 action mirred egress mirror dev swp2
>  Error: mlxsw_spectrum: Mirror action after sample action is not supported.
>  We have an error talking to the kernel
> 
> Reported-by: Vladyslav Mykhaliuk <vmykhaliuk@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> index f07955b5439f..6a4a81c63451 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> @@ -192,6 +192,11 @@ static int mlxsw_sp_flower_parse_actions(struct mlxsw_sp *mlxsw_sp,
>  				return -EOPNOTSUPP;
>  			}
>  
> +			if (sample_act_count) {
> +				NL_SET_ERR_MSG_MOD(extack, "Mirror action after sample action is not supported");
> +				return -EOPNOTSUPP;
> +			}
> +
>  			err = mlxsw_sp_acl_rulei_act_mirror(mlxsw_sp, rulei,
>  							    block, out_dev,
>  							    extack);
> @@ -265,6 +270,11 @@ static int mlxsw_sp_flower_parse_actions(struct mlxsw_sp *mlxsw_sp,
>  				return -EOPNOTSUPP;
>  			}
>  
> +			if (mirror_act_count) {
> +				NL_SET_ERR_MSG_MOD(extack, "Sample action after mirror action is not supported");
> +				return -EOPNOTSUPP;
> +			}
> +
>  			err = mlxsw_sp_acl_rulei_act_sample(mlxsw_sp, rulei,
>  							    block,
>  							    act->sample.psample_group,
> -- 
> 2.47.0

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks

