Return-Path: <netdev+bounces-28400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E8D77F557
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F349C1C2135E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8705B134C5;
	Thu, 17 Aug 2023 11:34:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA9512B8E
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E638C433C8;
	Thu, 17 Aug 2023 11:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692272068;
	bh=OT/vaCsEy2dq7av0fIwvh1s+ZDLoCVA2muMXmfmO+5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MpDQXAX4D62qmXBl3gC4hUgHYzzZ/A3OenjpWbJnKDpNTbAO/QvDEZ8WQPCbG13Bz
	 6Ok9vpcN4fvHD9sA38A/pJpBRyjrsqITwndRQgf1OpmhIyvipwpe/9sG5fENlP2vwt
	 YMnXLzmsXtk+Yrc8cslCpcdAcJsh3sDVLopFjGMDUGCnxX9qA9EvzjgI3811w2/Isn
	 RN3foHEuczdvUPXsW0g/fcVuoHkj4p8gc8ffRx9Gj3tlsCd0h2jbEVU2ZaJX8lACus
	 yGzGgVQeMRIvQcfBJDX7nzWZADsa+M5ZlHsPSoFu3PIjTvovRKmuLEjcVEQsuLqQK7
	 9TuAaD3qR1/0g==
Date: Thu, 17 Aug 2023 14:34:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next 04/14] ice: refactor ice_vf_lib to make
 functions static
Message-ID: <20230817113424.GM22185@unreal>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
 <20230816204736.1325132-5-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204736.1325132-5-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 01:47:26PM -0700, Tony Nguyen wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> As following methods are not used outside ice_vf_lib,
> they can be made static:
> ice_vf_rebuild_host_vlan_cfg
> ice_vf_rebuild_host_tx_rate_cfg
> ice_vf_set_host_trust_cfg
> ice_vf_rebuild_host_mac_cfg
> ice_vf_rebuild_aggregator_node_cfg
> ice_vf_rebuild_host_cfg
> ice_set_vf_state_qs_dis
> ice_vf_set_initialized
> 
> In order to achieve that, the order in which these
> were defined was reorganized.
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 468 +++++++++---------
>  .../ethernet/intel/ice/ice_vf_lib_private.h   |   2 -
>  2 files changed, 234 insertions(+), 236 deletions(-)

<...>

> +/**
> + * ice_vf_set_host_trust_cfg - set trust setting based on pre-reset value
> + * @vf: VF to configure trust setting for
> + */
> +static void ice_vf_set_host_trust_cfg(struct ice_vf *vf)
> +{
> +	if (vf->trusted)
> +		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +	else
> +		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +}

assign_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps, vf->trusted);

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

