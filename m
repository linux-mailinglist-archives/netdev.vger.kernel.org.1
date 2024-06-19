Return-Path: <netdev+bounces-104952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D2490F456
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B95283E16
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35CA156220;
	Wed, 19 Jun 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+lVsXx2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD7155A5B
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815234; cv=none; b=W/wJISB8yTAe5CnTzrwirTkdbBQFMitiZmPQSbBqTWhLnH3FI8UBRFkfFVuEt4Nebt4JvDrpVkU91pKxRzmglFu9h6x7gG1mNSKsGjJ8fBoRXvbDgJvP3a187tnD66GkomEnboH9+L327ymtGID0cXHXpLr0FMW8aDA/WiW3xRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815234; c=relaxed/simple;
	bh=WiLlLBvmqm2nG+tSOKaMxsR1LfIbZPqnHSXTtDsVPdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuQQwrB2AkfJNLiN4C5zxP7ybDkV1toWYKOlEfrCCL3/E7VJE5vgY+IwYEAXOFFmmXFJilnK5jW+x6sZrUS9EDN1X86e6Sv9i3cuUDX3qT6CXBjHp1by5BraB947Vt+0TSyg4aT5sIE8gOPW6WGK6WMnN4ANvCbeUt2XHvbDwDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+lVsXx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B75C2BBFC;
	Wed, 19 Jun 2024 16:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718815234;
	bh=WiLlLBvmqm2nG+tSOKaMxsR1LfIbZPqnHSXTtDsVPdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+lVsXx2w8ziK9fO9ZTjiSESUTh0JRsezGDN+Ij3X248Z9GcnF6zFBBJZAjtacIjY
	 u1ObTWLZ6FIA3cKEVRJGmQWt9S/imwNy7lYfUk177sVOxucMC/TPTU5K1DHUnks3cY
	 jHADDm4d7Z6dDC9m0/dwIVEeJ18hGky7OfIx7bU9Zmn3hnkeO4QhIcXZUdKyghMorp
	 YRF6XmEKTxreQyqTuvDCM5Bqn/vUxWayGujlxKkcbFQyF3SCuekS7a2odSJbazq6gm
	 wZr5rrWgpwZvGewcuhNTG/f5AuER5/Oba5Y7d/lpRSZtQOYAHaT5pLGhNQBZVU2qP/
	 X4M/J7aFV3BBA==
Date: Wed, 19 Jun 2024 17:40:30 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-net 2/3] ice: Don't process extts if PTP is disabled
Message-ID: <20240619164030.GJ690967@kernel.org>
References: <20240618104310.1429515-1-karol.kolacinski@intel.com>
 <20240618104310.1429515-3-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618104310.1429515-3-karol.kolacinski@intel.com>

On Tue, Jun 18, 2024 at 12:41:37PM +0200, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_ptp_extts_event() function can race with ice_ptp_release() and
> result in a NULL pointer dereference which leads to a kernel panic.
> 
> Panic occurs because the ice_ptp_extts_event() function calls
> ptp_clock_event() with a NULL pointer. The ice driver has already
> released the PTP clock by the time the interrupt for the next external
> timestamp event occurs.
> 
> To fix this, modify the ice_ptp_extts_event() function to check the
> PTP state and bail early if PTP is not ready. To ensure that the IRQ
> sees the state change, call synchronize_irq() before removing the PTP
> clock.

Hi Karol and Jacob,

After pf->ptp.state is set in ptp_clock_event(),
ice_ptp_disable_all_extts() is called which in turn calls
synchronize_irq(). Which I assume is what the last sentence above refers
to. But the way it is worded it sounds like a call to synchronize_irq() is
being added by this patch, which is not the case.

I suppose it is not a big deal, but this did confuse me.
So perhaps the wording could be enhanced?

> Another potential fix would be to ensure that all the GPIO configuration
> gets disabled during release of the driver. This is currently not
> trivial as each device family has its own set of configuration which is
> not shared across all devices. In addition, only some of the device
> families use the pin configuration interface. For now, relying on the
> state flag is the simpler solution.
> 
> Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 30f1f910e6d9..b952cad42f92 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1559,6 +1559,10 @@ void ice_ptp_extts_event(struct ice_pf *pf)
>  	u8 chan, tmr_idx;
>  	u32 hi, lo;
>  
> +	/* Don't process timestamp events if PTP is not ready */
> +	if (pf->ptp.state != ICE_PTP_READY)
> +		return;
> +
>  	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
>  	/* Event time is captured by one of the two matched registers
>  	 *      GLTSYN_EVNT_L: 32 LSB of sampled time event
> @@ -1573,10 +1577,8 @@ void ice_ptp_extts_event(struct ice_pf *pf)
>  			event.timestamp = (((u64)hi) << 32) | lo;
>  			event.type = PTP_CLOCK_EXTTS;
>  			event.index = chan;
> -
> -			/* Fire event */
> -			ptp_clock_event(pf->ptp.clock, &event);
>  			pf->ptp.ext_ts_irq &= ~(1 << chan);
> +			ptp_clock_event(pf->ptp.clock, &event);
>  		}
>  	}
>  }

I'm also confused (often, TBH!) as to how the last hunk of this
patch relates to the problem at hand.

