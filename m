Return-Path: <netdev+bounces-38896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB197BCEDD
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 16:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7D91C208D9
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 14:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B5DD30B;
	Sun,  8 Oct 2023 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8v9ntIo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8757C8EA
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 14:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A87C433C8;
	Sun,  8 Oct 2023 14:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696774177;
	bh=8N7Vu6fE1UJTylpIcqubQbtnPqSDc9vbK19cmandGTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8v9ntIo4lhKIghBZSRBhlYjXsHkQY3sWR2jPYFyw9FdI99M4fFj093QZe5y+QYJl
	 znMoQDTEZlkmhHZLKC5pCyL+oprcaqZetk+sDbg+0bv4yelyRe6NpgGf+G8FLBUWl6
	 00gzF9iYydvCzVdiF44VN4otPc+eKoTZu2pzezz+kYx4miTAUROAiobh/71rUjsRbY
	 LhD36ezyhf7H0APKZNWkK4ir0Ca7Q/E4wPbTqS4iRGkyGl8ZIl4jnfO6Kr0shTYYV0
	 R8DKmiG170ypeGTN75QVZOito3Ojhj4nawIIVw4ZeCiwFMczeS2lUUa2mZQ25wo7Yi
	 olsgoxsMr9BGA==
Date: Sun, 8 Oct 2023 16:09:34 +0200
From: Simon Horman <horms@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] ice: Fix SRIOV LAG disable on non-compliant
 aggreagate
Message-ID: <20231008140934.GI831234@kernel.org>
References: <20231006210211.1443696-1-david.m.ertman@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006210211.1443696-1-david.m.ertman@intel.com>

On Fri, Oct 06, 2023 at 02:02:11PM -0700, Dave Ertman wrote:
> If an attribute of an aggregate interface disqualifies it from supporting
> SRIOV, the driver will unwind the SRIOV support.  Currently the driver is
> clearing the feature bit for all interfaces in the aggregate, but this is
> not allowing the other interfaces to unwind successfully on driver unload.
> 
> Only clear the feature bit for the interface that is currently unwinding.
> 
> Fixes: bf65da2eb279 ("ice: enforce interface eligibility and add messaging for SRIOV LAG")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
> index 2c96d1883e19..c9071228b1ea 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> @@ -1513,17 +1513,12 @@ static void ice_lag_chk_disabled_bond(struct ice_lag *lag, void *ptr)
>   */
>  static void ice_lag_disable_sriov_bond(struct ice_lag *lag)
>  {
> -	struct ice_lag_netdev_list *entry;
>  	struct ice_netdev_priv *np;
> -	struct net_device *netdev;
>  	struct ice_pf *pf;
>  
> -	list_for_each_entry(entry, lag->netdev_head, node) {
> -		netdev = entry->netdev;
> -		np = netdev_priv(netdev);
> -		pf = np->vsi->back;
> -
> -		ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
> +	np = netdev_priv(lag->netdev);
> +	pf = np->vsi->back;
> +	ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
>  	}
>  }

Hi Dave,

unfortunately applying this patch results in a build failure.

-- 
pw-bot: changes-requested



