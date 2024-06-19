Return-Path: <netdev+bounces-104953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B1090F458
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3051C2817BB
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C79152E03;
	Wed, 19 Jun 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlBsEfYC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4615099A
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815372; cv=none; b=ZB+Lrgdb1tVpmQAGraxJZ1hN3XdUxtSONWaUGAOrDkNZ43CdYh4klMuvD6SGlyNSnbBmhorKvyjBwD+6QoOKVT6yNuNxOdIMbLA0fCd4q6DnsVPd/nkd/Tol5mr0P+vohhlulMXaTWuXjjweeeEw3U1NI0pA+qwjsFBnq0Kjl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815372; c=relaxed/simple;
	bh=Prisqet5/3qScXbJ+8JlF2VLayZ0w3KdlQsw2CiQZjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSvK2SISC+ce4Q6EvmTvTZyUaAe/QUCesyWncMirE8eQVWwWRmeXQ/k+qrfKeVlw6zF+YSRwr/Ta96ws3CM4+GdWFksZoXhX+5TXnuBiVnG103oWDsXiffXjOGuXBgMQRQa+nf6w9BdhFz6Ewgx1A9+/Nlrpewjsf2DGP9v+vBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlBsEfYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28027C2BBFC;
	Wed, 19 Jun 2024 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718815371;
	bh=Prisqet5/3qScXbJ+8JlF2VLayZ0w3KdlQsw2CiQZjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlBsEfYCPsU8qD2KyFDb7wpkDzsrH08IFZKavp7ta2Dg3D4ff6avaxGPQXYWHT3zx
	 f0RKQEhMUzHp+iofray7A+kRVOfhNFpT8DmDC/1KsgL0+QrmpvT+W7nklrbLyfHnUq
	 2IIl1XxAFJoCyPRONUw/GkN73j9mWO6RuVzPQXGEWJ12P+8HqellBcBWTAFfwDnLGN
	 PiehNDnuyDKDSTtsDzJxCek4YY6s2NpJM00ts1FVKdFUa0ZCTgoULjTKPZzL0IhC/I
	 xc6D4jPCKNhbWw7aLZJ2kph+4scuRQ6YTTUwoRzR+c9+4iyWyIFXSXYYePnC4eoLG/
	 GEYlbPc0ukTQg==
Date: Wed, 19 Jun 2024 17:42:47 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-net 1/3] ice: Fix improper extts handling
Message-ID: <20240619164247.GK690967@kernel.org>
References: <20240618104310.1429515-1-karol.kolacinski@intel.com>
 <20240618104310.1429515-2-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618104310.1429515-2-karol.kolacinski@intel.com>

On Tue, Jun 18, 2024 at 12:41:36PM +0200, Karol Kolacinski wrote:
> From: Milena Olech <milena.olech@intel.com>
> 
> Extts events are disabled and enabled by the application ts2phc.
> However, in case where the driver is removed when the application is
> running, channel remains enabled. As a result, in the next run of the
> app, two channels are enabled and the information "extts on unexpected
> channel" is printed to the user.
> 
> To avoid that, extts events shall be disabled when PTP is released.
> 
> Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

Hi Milena and Karol,

Some feedback from my side.

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 0f17fc1181d2..30f1f910e6d9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1584,27 +1584,24 @@ void ice_ptp_extts_event(struct ice_pf *pf)
>  /**
>   * ice_ptp_cfg_extts - Configure EXTTS pin and channel
>   * @pf: Board private structure
> - * @ena: true to enable; false to disable
>   * @chan: GPIO channel (0-3)
> - * @gpio_pin: GPIO pin
> - * @extts_flags: request flags from the ptp_extts_request.flags
> - */
> -static int
> -ice_ptp_cfg_extts(struct ice_pf *pf, bool ena, unsigned int chan, u32 gpio_pin,
> -		  unsigned int extts_flags)
> + * @config: desired EXTTS configuration.
> + * @store: If set to true, the values will be stored
> + *
> + * Configure an external timestamp event on the requested channel.
> +  */

nit: There is an extra leading space on the line above.

     Also, although not strictly related to this change,
     please consider adding a Returns: section to this kernel doc.

> +static void ice_ptp_cfg_extts(struct ice_pf *pf, unsigned int chan,
> +			      struct ice_extts_channel *config, bool store)

...

> @@ -1869,21 +1915,31 @@ static int ice_ptp_gpio_enable_e823(struct ptp_clock_info *info,
>  				    struct ptp_clock_request *rq, int on)
>  {
>  	struct ice_pf *pf = ptp_info_to_pf(info);
> -	struct ice_perout_channel clk_cfg = {0};
>  	int err;
>  
>  	switch (rq->type) {
>  	case PTP_CLK_REQ_PPS:
> +	{
> +		struct ice_perout_channel clk_cfg = {};
> +
>  		clk_cfg.gpio_pin = PPS_PIN_INDEX;
>  		clk_cfg.period = NSEC_PER_SEC;
>  		clk_cfg.ena = !!on;
>  
>  		err = ice_ptp_cfg_clkout(pf, PPS_CLK_GEN_CHAN, &clk_cfg, true);
>  		break;
> +	}
>  	case PTP_CLK_REQ_EXTTS:
> -		err = ice_ptp_cfg_extts(pf, !!on, rq->extts.index,
> -					TIME_SYNC_PIN_INDEX, rq->extts.flags);
> +	{
> +		struct ice_extts_channel extts_cfg = {};
> +
> +		extts_cfg.flags = rq->extts.flags;
> +		extts_cfg.gpio_pin = TIME_SYNC_PIN_INDEX;
> +		extts_cfg.ena = !!on;
> +
> +		ice_ptp_cfg_extts(pf, rq->extts.index, &extts_cfg, true);
>  		break;

This function returns err.
But with this patch err is uninitialised here.

Perhaps err be set to the return value of ice_ptp_cfg_extts()
as it was before this patch?

Flagged by allmodconfig W=1 builds with gcc-13 and clang-18, and Smatch.

> +	}
>  	default:
>  		return -EOPNOTSUPP;
>  	}

...

