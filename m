Return-Path: <netdev+bounces-121521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C873395D7E0
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D551F243C8
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5411C7B64;
	Fri, 23 Aug 2024 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtZMp+jS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367A51C6F7D
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445222; cv=none; b=ecHpZIIDpmzb+yRKXqQutYzS3GWP93YkE+BgO3BvouQ4ed2vJiJsAGU0iQlNjKpytbwG1UCMCfFGCMU7W9u1YFhUhL4MpxIfrPE9Y2HRZZV3UZ8WrTPgx1H4ctyZ0CYRsY+7eT5RULrxd6/OEdU295JpyYLq7/SQTzKbP/Je2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445222; c=relaxed/simple;
	bh=AUYPCHt3tYNY9yFLugWcI1QD2hn6lJfc/4jgQhr4Szg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUyJ1GIqCdlfWNiUN004mNl2kg23jGGw9Yjygps/Hmb/lUJE8ZnFMBplkjL+Eiy+5NyJ45ZLG4vKTNLkWeBtNJ7pV+gVyu6TqwTki2JwjK9oR9n3CTou4/TYmKJDb+VC/Ow7ZM+48x4lVaAPcn8efPCiBynquNcWyJ30nrAwzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtZMp+jS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC2FC4AF09;
	Fri, 23 Aug 2024 20:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724445221;
	bh=AUYPCHt3tYNY9yFLugWcI1QD2hn6lJfc/4jgQhr4Szg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtZMp+jSxLRK32WyV/0NUGBkmuXlJfkzdQcMcR1VZ6k1cCZIKK9prg5wG7xi4I4aH
	 RJY0atKWWJxxqo7kZTJvFhXx7DvKxXV5w/LW17Qw+CzIWBHoFPi3eB5/qmMbS/dw6V
	 PCiOij8cESjSCC/qAy28Z4sP+hk/OcXMApjyGQyhGLpYthWjHlUiGjGvriZbLLlfTG
	 v/1TkV8WzXvLx71y/ir/gDB1ccqJOuxIrNywrO4y1wRZSWo3r+2H5M1BownBQB7WUZ
	 nIoxjnfFmYAhjx2EVWLV6VU+7zugTn32st5IsXF6EpZMVU66Nj4bsvZWDrGPyCoFfd
	 Veyx4pptmJwqQ==
Date: Fri, 23 Aug 2024 21:33:37 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Michal Michalik <michal.michalik@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: Re: [PATCH v7 iwl-next 3/6] ice: Implement PTP support for E830
 devices
Message-ID: <20240823203337.GH2164@kernel.org>
References: <20240820102402.576985-8-karol.kolacinski@intel.com>
 <20240820102402.576985-11-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820102402.576985-11-karol.kolacinski@intel.com>

On Tue, Aug 20, 2024 at 12:21:50PM +0200, Karol Kolacinski wrote:
> From: Michal Michalik <michal.michalik@intel.com>
> 
> Add specific functions and definitions for E830 devices to enable
> PTP support.
> Introduce new PHY model ICE_PHY_E830.
> E830 devices support direct write to GLTSYN_ registers without shadow
> registers and 64 bit read of PHC time.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Co-developed-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c

...

> @@ -1405,10 +1416,11 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
>  
>  	switch (hw->mac_type) {
>  	case ICE_MAC_E810:
> -		/* Do not reconfigure E810 PHY */
> +	case ICE_MAC_E830:
> +		/* Do not reconfigure E810 or E830 PHY */
>  		return;
> -	case ICE_MAC_GENERIC_3K_E825:
>  	case ICE_MAC_GENERIC:
> +	case ICE_MAC_GENERIC_3K_E825:
>  		ice_ptp_port_phy_restart(ptp_port);
>  		return;
>  	default:

The re-ordering of ICE_MAC_GENERIC_3K_E825 does not feel like it belongs
in this patch. Perhaps it can be squashed into the earlier patch
in the series that adds the code that is being shuffled here?

...

> @@ -3271,10 +3285,8 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
>  	mutex_init(&ptp_port->ps_lock);
>  
>  	switch (hw->mac_type) {
> -	case ICE_MAC_GENERIC_3K_E825:
> -		return ice_ptp_init_tx_eth56g(pf, &ptp_port->tx,
> -					      ptp_port->port_num);
>  	case ICE_MAC_E810:
> +	case ICE_MAC_E830:
>  		return ice_ptp_init_tx_e810(pf, &ptp_port->tx);
>  	case ICE_MAC_GENERIC:
>  		kthread_init_delayed_work(&ptp_port->ov_work,
> @@ -3282,6 +3294,9 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
>  
>  		return ice_ptp_init_tx_e82x(pf, &ptp_port->tx,
>  					    ptp_port->port_num);
> +	case ICE_MAC_GENERIC_3K_E825:
> +		return ice_ptp_init_tx_eth56g(pf, &ptp_port->tx,
> +					      ptp_port->port_num);
>  	default:
>  		return -ENODEV;
>  	}

Ditto.

...

