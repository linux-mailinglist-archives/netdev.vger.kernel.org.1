Return-Path: <netdev+bounces-121519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9CE95D7D9
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBCC1F248A8
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA30C1C4ED0;
	Fri, 23 Aug 2024 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEknBgB+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7A1C4627
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445165; cv=none; b=u43MJD6Qev6/A0Ls9pRMG/RmxumLjgXTSFSsAZdmwCM2WoAQ1llmF2jMKkx+liS320iqpkpIMwo5w0QAEL22XN+KsP6tEhX55M31qVX8Y40j92B76RaZuId+vUSxlSNQIIXh7XORROo9L08leIQac9eSXWHQMBjBEsi/9q9HDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445165; c=relaxed/simple;
	bh=JQ5JOZzwdnT0+kxGtvfHEPjKZb5ojwItdamZxhU5O7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZulDfFfFWl3GxRWDOE1e580ZqQNZnado30aoycgDTXTtVRyWPhATJVB2FBZq7w0pQDrcMUKfGM68EonZZ65jrd60dRfuL6qDArIN2sWg5z14Z31lhy51z3eWjIN6AMO1jbacdHYhniPvvw2VbMBAEuiueJsuR7hw90sPbDCWkhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEknBgB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA631C32786;
	Fri, 23 Aug 2024 20:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724445165;
	bh=JQ5JOZzwdnT0+kxGtvfHEPjKZb5ojwItdamZxhU5O7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEknBgB+FrWd4YSfzQrsmKvoTzieo/Wjv01t4wP1RNGQ7QQAHfeGM8cF9uxJm/m+E
	 GrF6jX5AvUCHMU98ZTrUbV0hQ07BxKVYj9eHuZi8HLP9VRJ0C5wqS44igUi/w2Gh2p
	 iaWuY5bmNo8zJR7AhHazxrDlsTqhhRQXCfB2eV4N/O1USfm++0MRiSXdktPrpv6UX7
	 dIOv/gGoET5HWOUlh8CIfHr+kCzJhKs4Du6+JiVBc9sInIQoBNNvw+IMf8/xbheM2W
	 e9E5OdeKzv7fdp4yXQl0HfeVyG1IYwTNwGBiMLrY1+sgjT2YDma199LlIJ3Tfo9Ztq
	 zm2qauuRfbypg==
Date: Fri, 23 Aug 2024 21:32:41 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v7 iwl-next 4/6] ice: Process TSYN IRQ in a separate
 function
Message-ID: <20240823203241.GG2164@kernel.org>
References: <20240820102402.576985-8-karol.kolacinski@intel.com>
 <20240820102402.576985-12-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820102402.576985-12-karol.kolacinski@intel.com>

On Tue, Aug 20, 2024 at 12:21:51PM +0200, Karol Kolacinski wrote:
> Simplify TSYN IRQ processing by moving it to a separate function and
> having appropriate behavior per PHY model, instead of multiple
> conditions not related to HW, but to specific timestamping modes.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index cf3b02d14b19..861f6224540a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2760,6 +2760,65 @@ enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf)
>  	}
>  }
>  
> +/**
> + * ice_ptp_ts_irq - Process the PTP Tx timestamps in IRQ context
> + * @pf: Board private structure
> + *
> + * Return: IRQ_WAKE_THREAD if Tx timestamp read has to be handled in the bottom
> + *         half of the interrupt and IRQ_HANDLED otherwise.
> + */
> +irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
> +{
> +	struct ice_hw *hw = &pf->hw;
> +
> +	switch (hw->mac_type) {
> +	case ICE_MAC_E810:
> +		/* E810 capable of low latency timestamping with interrupt can
> +		 * request a single timestamp in the top half and wait for
> +		 * a second LL TS interrupt from the FW when it's ready.
> +		 */
> +		if (hw->dev_caps.ts_dev_info.ts_ll_int_read) {
> +			struct ice_ptp_tx *tx = &pf->ptp.port.tx;
> +			u8 idx;
> +
> +			if (!ice_pf_state_is_nominal(pf))
> +				return IRQ_HANDLED;
> +
> +			spin_lock(&tx->lock);
> +			idx = find_next_bit_wrap(tx->in_use, tx->len,
> +						 tx->last_ll_ts_idx_read + 1);
> +			if (idx != tx->len)
> +				ice_ptp_req_tx_single_tstamp(tx, idx);
> +			spin_unlock(&tx->lock);
> +
> +			return IRQ_HANDLED;
> +		}
> +		fallthrough; /* non-LL_TS E810 */
> +	case ICE_MAC_GENERIC:
> +	case ICE_MAC_GENERIC_3K_E825:
> +		/* All other devices process timestamps in the bottom half due
> +		 * to sleeping or polling.
> +		 */
> +		if (!ice_ptp_pf_handles_tx_interrupt(pf))
> +			return IRQ_HANDLED;
> +
> +		set_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread);
> +		return IRQ_WAKE_THREAD;
> +	case ICE_MAC_E830:
> +		/* E830 can read timestamps in the top half using rd32() */
> +		if (ice_ptp_process_ts(pf) == ICE_TX_TSTAMP_WORK_PENDING) {
> +			/* Process outstanding Tx timestamps. If there
> +			 * is more work, re-arm the interrupt to trigger again.
> +			 */
> +			wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
> +			ice_flush(hw);
> +		}
> +		return IRQ_HANDLED;

I think it would be better to split out adding E830 support into a separate
patch, leaving this patch as strictly refactoring of existing code.

> +	default:
> +		return IRQ_HANDLED;
> +	}
> +}
> +
>  /**
>   * ice_ptp_maybe_trigger_tx_interrupt - Trigger Tx timstamp interrupt
>   * @pf: Board private structure
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h

...

> @@ -360,6 +361,11 @@ static inline bool ice_ptp_process_ts(struct ice_pf *pf)
>  	return true;
>  }
>  
> +static inline irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
> +{
> +	return IRQ_HANDLED;
> +}

This no-op implementation is in effect if CONFIG_PTP_1588_CLOCK is not
enabled. Whereas previously the fuller implementation would have run.
I think that deserves some coverage in the patch description.

> +
>  static inline u64
>  ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
>  		    const struct ice_pkt_ctx *pkt_ctx)
> -- 
> 2.46.0
> 
> 

