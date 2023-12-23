Return-Path: <netdev+bounces-60103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C71B81D5C0
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 19:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404E4283294
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 18:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B2D11CB8;
	Sat, 23 Dec 2023 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS4lintz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06412E47
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 18:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B849AC433C8;
	Sat, 23 Dec 2023 18:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703355737;
	bh=7YgZjgPdz3vwKmJhQ2IYJpvkLXR6GFQjhfBpY5pwTQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DS4lintziKXlrbH/1Z5KCbLcHJ14mdE7uWCg662+xMU30MgHMuS7obF/vD2C1a6yC
	 9/EctNgrYBk391CR3FsWE7bHRdKpsEaAisWGYHqtoqUAchCi1fFwqHWAVTL6YQ/d0n
	 tAa+qbzn7zAjmnaAZVnBd1b9qNn2s6M1D7hnjKTLjVks5rSyYYUrSdFz7pUcGWnNGX
	 U9cckBeLEGTlKBi8kQzBRmEsTs3Iu/Co1I+E1nzVU+y17NeVFKAqHzkcDcOn/9wj7X
	 lVJMnvdSH9l0r8Q/zA0dBqN2VlSNmmru/Hz+Cs3P6SL5rjRt00bhWjd0t+QJybf0/i
	 2T1VKwWfT+WPQ==
Date: Sat, 23 Dec 2023 18:22:13 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4 iwl-next 2/6] ice: pass reset type to PTP reset
 functions
Message-ID: <20231223182213.GK201037@kernel.org>
References: <20231221100326.1030761-1-karol.kolacinski@intel.com>
 <20231221100326.1030761-3-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221100326.1030761-3-karol.kolacinski@intel.com>

On Thu, Dec 21, 2023 at 11:03:22AM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_ptp_prepare_for_reset() and ice_ptp_reset() functions currently
> check the pf->flags ICE_FLAG_PFR_REQ bit to determine if the current
> reset is a PF reset or not.
> 
> This is problematic, because it is possible that a PF reset and a higher
> level reset (CORE reset, GLOBAL reset, EMP reset) are requested
> simultaneously. In that case, the driver performs the highest level
> reset requested. However, the ICE_FLAG_PFR_REQ flag will still be set.
> 
> The main driver reset functions take an enum ice_reset_req indicating
> which reset is actually being performed. Pass this data into the PTP
> functions and rely on this instead of relying on the driver flags.
> 
> This ensures that the PTP code performs the proper level of reset that
> the driver is actually undergoing.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
> index 2457380142e1..bbac053bd099 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> @@ -314,8 +314,8 @@ enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
>  
>  u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
>  			const struct ice_pkt_ctx *pkt_ctx);
> -void ice_ptp_reset(struct ice_pf *pf);

Hi Karol and Jacob,

I think that the declaration of ice_ptp_reset() is
needed for the case where CONFIG_PTP_1588_CLOCK=y
until patch 5/6 of this series.

> -void ice_ptp_prepare_for_reset(struct ice_pf *pf);
> +void ice_ptp_prepare_for_reset(struct ice_pf *pf,
> +			       enum ice_reset_req reset_type);
>  void ice_ptp_init(struct ice_pf *pf);
>  void ice_ptp_release(struct ice_pf *pf);
>  void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup);

...

