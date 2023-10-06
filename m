Return-Path: <netdev+bounces-38578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E183F7BB7B4
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6F71C20A14
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7C51C2BA;
	Fri,  6 Oct 2023 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny9UHmuN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516AB1D543
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B3EC433C7;
	Fri,  6 Oct 2023 12:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696595618;
	bh=C0l7PeGE1vtEgo9DM9OGtxhUx5rYGAf3MThJoKdVq7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ny9UHmuNzt0oHqRHoVuzX6mix3ZySYkhx3RVjnK+s1jzfIoQhCC2KKfXRiyneWF6/
	 S6KS4GGL1wCrNhYmxwc55p9xyTCTjQrZzEbUUiHSgaXeqY6UgWtBsggqbI4IA9qSBq
	 ay2XMiEe1UlsI1HkZ15xNeIbHukbaDfIen9EcQEdQ80Bcq6tsuXBHNXgRi5gWru8z7
	 YC0zrUGwSDI6+BjTAIb+aHYpo1n0eaMjN5LtgmF/tJdAhrvvJY//ZdL2wUlOQbl/g1
	 vzOYJookGLQzCEeo0RNGUjjUrLzJ7SYcaq/DK28xFJkqtr4nFVVuInynNjyvB/T5F5
	 ctK6dyBdcTYAQ==
Date: Fri, 6 Oct 2023 14:33:34 +0200
From: Simon Horman <horms@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, jiri@resnulli.us,
	corbet@lwn.net, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v3 4/5] ice: dpll: implement phase related
 callbacks
Message-ID: <ZR/+noRCdnsy6QJo@kernel.org>
References: <20231006114101.1608796-1-arkadiusz.kubalewski@intel.com>
 <20231006114101.1608796-5-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006114101.1608796-5-arkadiusz.kubalewski@intel.com>

On Fri, Oct 06, 2023 at 01:41:00PM +0200, Arkadiusz Kubalewski wrote:
> Implement new callback ops related to measurment and adjustment of
> signal phase for pin-dpll in ice driver.
> 
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Hi Arkadiusz,

some minor feedback from my side.

If you do end up re-spinning the series, please consider
running checkpatch.pl --codespell.

> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 224 +++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_dpll.h |  10 +-
>  2 files changed, 230 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c

...

> +/**
> + * ice_dpll_phase_offset_get - callback for get dpll phase shift value
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @dpll: registered dpll pointer
> + * @dpll_priv: private data pointer passed on dpll registration
> + * @phase_adjust: on success holds pin phase_adjust value

nit: The parameter is called phase_offset, not phase_adjust in the code below

> + * @extack: error reporting
> + *
> + * Dpll subsystem callback. Handler for getting phase shift value between
> + * dpll's input and output.
> + *
> + * Context: Acquires pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error
> + */
> +static int
> +ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
> +			  const struct dpll_device *dpll, void *dpll_priv,
> +			  s64 *phase_offset, struct netlink_ext_ack *extack)
> +{
> +	struct ice_dpll *d = dpll_priv;
> +	struct ice_pf *pf = d->pf;
> +
> +	mutex_lock(&pf->dplls.lock);
> +	if (d->active_input == pin)
> +		*phase_offset = d->phase_offset * ICE_DPLL_PHASE_OFFSET_FACTOR;
> +	else
> +		*phase_offset = 0;
> +	mutex_unlock(&pf->dplls.lock);
> +
> +	return 0;
> +}
> +
>  /**
>   * ice_dpll_rclk_state_on_pin_set - set a state on rclk pin
>   * @pin: pointer to a pin

...

> @@ -1656,6 +1867,15 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
>  				return ret;
>  			pins[i].prop.capabilities |=
>  				DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE;
> +			pins[i].prop.phase_range.min =
> +				pf->dplls.input_phase_adj_max;
> +			pins[i].prop.phase_range.max =
> +				-pf->dplls.input_phase_adj_max;
> +		} else {
> +			pins[i].prop.phase_range.min =
> +				pf->dplls.output_phase_adj_max,

nit: It probably doesn't make any difference, but perhaps ',' should be ';'.

As flagged by clang-16 with -Wcomma

> +			pins[i].prop.phase_range.max =
> +				-pf->dplls.output_phase_adj_max;
>  		}
>  		pins[i].prop.capabilities |=
>  			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;

...

