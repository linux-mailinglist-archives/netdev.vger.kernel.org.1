Return-Path: <netdev+bounces-144855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131DD9C88FF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38DF281402
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C11F893D;
	Thu, 14 Nov 2024 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPDDBUwb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB411F8917
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583980; cv=none; b=JuNGXKdrikqhpp00006gzAyxMywxG7GG3J+krxQpaXVgRWxb0b0VzDqCzHgtrxJ1zNSrQg1wXpBbUQc0YK4zSWIjtZNA1c+YzI4KIRo286IKyWSpNgay5+HFsbklHyM1kMwqx0i6U6IeLuM9YMYALQcsxBVOQiwnVpANsDNMdPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583980; c=relaxed/simple;
	bh=V39RIN2jCDCxaKnoONcb8DL4UIqTets440Hul9Wz37k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBT4owtXQC4ffpRoR7Hx15EkeWqNuB+EyL4WsB0urXSQH+Dd/BQkKfmpf+ZGz7pehuNRu1ZJAKVX5DFIDw1EA/LX+/wn/RkoTfK6OAfhb+u4OmorQoOuHFIF6JFm8A2UhM6ue0462mhOTrppCtMK7mEojFmhAGh4ZoG2PW+JTmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPDDBUwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ED0C4CECD;
	Thu, 14 Nov 2024 11:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731583979;
	bh=V39RIN2jCDCxaKnoONcb8DL4UIqTets440Hul9Wz37k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPDDBUwbVx22gySud/IB4lNvx0g7sPasPnMBo8rV0XdQukYHmMMzK0rmjmmmAzt/c
	 AriG3AaWS+nCttT+1J+FOlNg9dXpXQ5U7Id2a0Bb0ik1SYpFnH6/XmdisEwgJHNWJ4
	 z4ImRmMOr4wRsGWtUl7SgWIhs6j+hrl+83FZBnECVF1o69oxKyxYEQmMM5zZzKyquH
	 vdUsqYadiCcyjAFqXFppKCJENcTd+junAjWBjnJ4K3Sl5ni2cdLcFvNF7+bKa2YF3q
	 +AEaX7l11qU7kkDuJ4nsrV8AKV46kn431GxDbWt3YimYs4d442QG+P86NUTozv0WaP
	 Jn77kLKfRq5ow==
Date: Thu, 14 Nov 2024 13:32:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: jbrandeb@kernel.org
Cc: netdev@vger.kernel.org, jbrandeburg@cloudflare.com,
	intel-wired-lan@lists.osuosl.org,
	Dave Ertman <david.m.ertman@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1] ice: do not reserve resources for RDMA when
 disabled
Message-ID: <20241114113252.GC499069@unreal>
References: <20241114000105.703740-1-jbrandeb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114000105.703740-1-jbrandeb@kernel.org>

On Wed, Nov 13, 2024 at 04:00:56PM -0800, jbrandeb@kernel.org wrote:
> From: Jesse Brandeburg <jbrandeb@kernel.org>
> 
> If the CONFIG_INFINIBAND_IRDMA symbol is not enabled as a module or a
> built-in, then don't let the driver reserve resources for RDMA.
> 
> Do this by avoiding enabling the capability when scanning hardware
> capabilities.
> 
> Fixes: d25a0fc41c1f ("ice: Initialize RDMA support")
> CC: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Jesse Brandeburg <jbrandeb@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 009716a12a26..70be07ad2c10 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -2174,7 +2174,8 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
>  			  caps->nvm_unified_update);
>  		break;
>  	case ICE_AQC_CAPS_RDMA:
> -		caps->rdma = (number == 1);
> +		if (IS_ENABLED(CONFIG_INFINIBAND_IRDMA))

ice_eth is not dependent on CONFIG_INFINIBAND_IRDMA and can be built
perfectly without irdma. So technically, you disabled RDMA for such
kernels and users won't be able to load out-of-tree built module.

I don't care about out-of-tree code, but it is worth to add into commit
message, so users will know what to do it IRDMA stopped to work for them.

Thanks

> +			caps->rdma = (number == 1);
>  		ice_debug(hw, ICE_DBG_INIT, "%s: rdma = %d\n", prefix, caps->rdma);
>  		break;
>  	case ICE_AQC_CAPS_MAX_MTU:
> 
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> -- 
> 2.39.5
> 
> 

