Return-Path: <netdev+bounces-51381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B2A7FA6BC
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 17:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E88B0B2130C
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41422F866;
	Mon, 27 Nov 2023 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHvTLHVO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942928E04
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B86C433C8;
	Mon, 27 Nov 2023 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701103604;
	bh=fBXkpMFA9S/5p32o9jFsYCv1lzUrDzQObofJV4PDyds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHvTLHVOKpushLJOsi2d3zCV/LY8agHtoqdPXGkpLG4rQ1VSwGL0OE2VziNre+sSE
	 eNUYVR6vE1NLcx4GnZ+/J31yRdhiP4ZNvN80OSeyDAWsdAeUe6ovl2pr6FlCnL7Zh6
	 x0nVsHE5ECQhb/2oLt1KIPpuuQeR4vXJWVKP8n9XLyt/dpiSlAK8Zsx7T048FiZ4vK
	 jO3VsRap/dBqZZ2cN6SpPD+7rWm66JfqlgqVdLiu19ZfVu/WmhhEMOUU2tVqLjPOBm
	 UIlcCWBzucqhqNTOb1oISbPhw+3n835BaJYSA37VlkcJyXt7PEFu2LgXWOddKvZ+0/
	 165qaMSiteFfw==
Date: Mon, 27 Nov 2023 16:46:40 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Michal Michalik <michal.michalik@intel.com>
Subject: Re: [PATCH iwl-next 1/2] ice: Schedule service task in IRQ top half
Message-ID: <20231127164640.GF84723@kernel.org>
References: <20231124114155.251360-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124114155.251360-1-karol.kolacinski@intel.com>

On Fri, Nov 24, 2023 at 12:41:54PM +0100, Karol Kolacinski wrote:
> Schedule service task and EXTTS in the top half to avoid bottom half
> scheduling if possible, which significantly reduces timestamping delay.
> 
> Co-developed-by: Michal Michalik <michal.michalik@intel.com>
> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  1 -
>  drivers/net/ethernet/intel/ice/ice_main.c | 18 ++++++++++--------
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 3ea33947b878..d5a8da0c02c3 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -517,7 +517,6 @@ enum ice_pf_flags {
>  };
>  
>  enum ice_misc_thread_tasks {
> -	ICE_MISC_THREAD_EXTTS_EVENT,
>  	ICE_MISC_THREAD_TX_TSTAMP,
>  	ICE_MISC_THREAD_NBITS		/* must be last */
>  };
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 1f159b4362ec..6b91ec6f420d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3078,6 +3078,7 @@ static void ice_ena_misc_vector(struct ice_pf *pf)
>  static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
>  {
>  	struct ice_pf *pf = (struct ice_pf *)data;
> +	irqreturn_t ret = IRQ_HANDLED;
>  	struct ice_hw *hw = &pf->hw;
>  	struct device *dev;
>  	u32 oicr, ena_mask;
> @@ -3161,6 +3162,8 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
>  		ena_mask &= ~PFINT_OICR_TSYN_TX_M;
>  		if (ice_ptp_pf_handles_tx_interrupt(pf))

Hi Karol,

it seems that a trailing '{' is missing from the line above.

>  			set_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread);
> +			ret = IRQ_WAKE_THREAD;
> +		}
>  	}
>  
>  	if (oicr & PFINT_OICR_TSYN_EVNT_M) {

...

