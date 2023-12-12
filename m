Return-Path: <netdev+bounces-56349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E7180E922
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8009281878
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B392F5B5CC;
	Tue, 12 Dec 2023 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2YYmUsg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A775B5C9
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 10:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97666C433C8;
	Tue, 12 Dec 2023 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702376958;
	bh=iOmLw4iZ300s3Fur2rlkcac2KCwHfVdoXpxspxKo6qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t2YYmUsgfnJ/2wZdQHtsPkJwCyrGhYd+wK61fu8DCkWuSesA9BRVGIpNrXicSpBy+
	 iHW4SPYZUBdD5q/xHmgkXS9bGy2kZ3JCchttT3ggJnKrk+8y1ybBBRHYt8O1Kbfn4i
	 GGZXtJJcmJ+Xo5Yhes9izoY/V2/n6JeftJ76N8XtYaYg4nfxks+co0s7boLY7y9BzG
	 EsBDd94vYFGi4TYtdIMr5hTxiP3+qaNx6YT2ETIM15vD4yWaOA3xcYs1k4suvVVsvB
	 IsKFvMvIjhWYpUo/MjdrnZjxr3xoIzkt9TneK2iiA2vNBDm2l820W1YVorNpqg07d2
	 wokyTCGIMCT7w==
Date: Tue, 12 Dec 2023 10:29:13 +0000
From: Simon Horman <horms@kernel.org>
To: Lukasz Plachno <lukasz.plachno@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jakub Buchocki <jakubx.buchocki@intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2 2/2] ice: Implement 'flow-type ether' rules
Message-ID: <20231212102913.GX5817@kernel.org>
References: <20231207124838.29915-1-lukasz.plachno@intel.com>
 <20231207124838.29915-3-lukasz.plachno@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207124838.29915-3-lukasz.plachno@intel.com>

On Thu, Dec 07, 2023 at 01:48:40PM +0100, Lukasz Plachno wrote:
> From: Jakub Buchocki <jakubx.buchocki@intel.com>
> 
> Add support for 'flow-type ether' Flow Director rules via ethtool.
> 
> Rules not containing masks are processed by the Flow Director,
> and support the following set of input parameters in all combinations:
> src, dst, proto, vlan-etype, vlan, action.
> 
> It is possible to specify address mask in ethtool parameters but only
> 00:00:00:00:00 and FF:FF:FF:FF:FF are valid.
> The same applies to proto, vlan-etype and vlan masks:
> only 0x0000 and 0xffff masks are valid.
> 
> Signed-off-by: Jakub Buchocki <jakubx.buchocki@intel.com>
> Co-developed-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Lukasz Plachno <lukasz.plachno@intel.com>

...

> @@ -1268,6 +1374,16 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
>  		ret = ice_set_fdir_ip6_usr_seg(seg, &fsp->m_u.usr_ip6_spec,
>  					       &perfect_filter);
>  		break;
> +	case ETHER_FLOW:
> +		ret = ice_set_ether_flow_seg(seg, &fsp->m_u.ether_spec);
> +		if (!ret && (fsp->m_ext.vlan_etype || fsp->m_ext.vlan_tci)) {
> +			if (!ice_fdir_vlan_valid(fsp)) {
> +				ret = -EINVAL;
> +				break;
> +			}
> +			ret = ice_set_fdir_vlan_seg(seg, &fsp->m_ext);
> +		}
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}

Hi Jakub,

A bit further down this function, perfect_filter is used as follows.

	...

	if (user && user->flex_fltr) {
		perfect_filter = false;
		...
	}

	...

	assign_bit(fltr_idx, hw->fdir_perfect_fltr, perfect_filter);

And unlike other non-error cases handled in the switch statement,
the new ETHER_FLOW case does not set perfect_filter.

It's unclear to me if this is actually the case or not,
but Smatch flags that perfect_filter may now be used uninitialised
in the assign_bit() call above.

...

