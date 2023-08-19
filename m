Return-Path: <netdev+bounces-29092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E722A781963
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 13:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DCE281BE6
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C38C6117;
	Sat, 19 Aug 2023 11:52:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA9136B
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 11:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32BAC433C8;
	Sat, 19 Aug 2023 11:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692445974;
	bh=p80tG6Msagq3qG3K3mTzridTHLNJ86Q45EqvFAMqETk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cjls2mjf/Zsmdq35f259rjkIdz4rLF5YbLThk3yRpsmYugPw8aiKe36V1BKuynfdI
	 OzI4NHHhpQHsEinL6Jz4ZJl3Tt77YAOML/UResLEunzWNaXEwG1+gJi0wHV9lXTsQe
	 5ppUbtOIjjht92+Mtxdc/hA1hahqhPt9NNcvZnXSfdrkKT/+CJKt0v5RsLUuXljjlS
	 zoy/qAX6Twl20meTg9KYuYVm1OgJffR+pvkvDDZGB+FwXiALVAhnySrN85FIdYvq0q
	 PwGE0CF+jM1BoASa1YAE4nn4AVTsJklLcpzn6VHbNRzbWRrWU2Qrd9KyV+FvaV5TxR
	 0U4GsZWElnnow==
Date: Sat, 19 Aug 2023 14:52:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 iwl-next 1/9] ice: use ice_pf_src_tmr_owned where
 available
Message-ID: <20230819115249.GP22185@unreal>
References: <20230817141746.18726-1-karol.kolacinski@intel.com>
 <20230817141746.18726-2-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230817141746.18726-2-karol.kolacinski@intel.com>

On Thu, Aug 17, 2023 at 04:17:38PM +0200, Karol Kolacinski wrote:
> The ice_pf_src_tmr_owned() macro exists to check the function capability
> bit indicating if the current function owns the PTP hardware clock.

This is first patch in the series, but I can't find mentioned macro.
My net-next is based on 5b0a1414e0b0 ("Merge branch 'smc-features'")
➜  kernel git:(net-next) git grep ice_pf_src_tmr_owned
shows nothing.

On which branch is it based?

Thanks


> 
> This is slightly shorter than the more verbose access via
> hw.func_caps.ts_func_info.src_tmr_owned. Be consistent and use this
> where possible rather than open coding its equivalent.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index a6dd336d2500..b6858f04152c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3185,7 +3185,7 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
>  
>  		ena_mask &= ~PFINT_OICR_TSYN_EVNT_M;
>  
> -		if (hw->func_caps.ts_func_info.src_tmr_owned) {
> +		if (ice_pf_src_tmr_owned(pf)) {
>  			/* Save EVENTs from GLTSYN register */
>  			pf->ptp.ext_ts_irq |= gltsyn_stat &
>  					      (GLTSYN_STAT_EVENT0_M |
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 97b8581ae931..0669ca905c46 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2447,7 +2447,7 @@ void ice_ptp_reset(struct ice_pf *pf)
>  	if (test_bit(ICE_PFR_REQ, pf->state))
>  		goto pfr;
>  
> -	if (!hw->func_caps.ts_func_info.src_tmr_owned)
> +	if (!ice_pf_src_tmr_owned(pf))
>  		goto reset_ts;
>  
>  	err = ice_ptp_init_phc(hw);
> -- 
> 2.39.2
> 
> 

