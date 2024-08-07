Return-Path: <netdev+bounces-116323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57263949EF4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 07:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86CB2884DD
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 05:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D4818FDDE;
	Wed,  7 Aug 2024 05:05:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723C01E520
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 05:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723007156; cv=none; b=RbmzRyM5n61NIrASa/E0ImyMd36YoP6JCn7hyWoWMVKjPRhhPI7DmyHZnmwB2HSIU37JAJuKdMGc4OYvGLmDFkH2IvyAw8I4OQcktcDRhc0iR/QTB5ax38d7FjjrxqdloISADvPOhMmXcsNHCsG2/2wf7fXXa0ZsqtXdDRUnVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723007156; c=relaxed/simple;
	bh=ee8hSU2BcFEqHCeDFqvOdGOb/Tfkz2nTQiUFjfBDli0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siE8T57ucKN4sb8sucFQxXk8Ns7cg4wnPgX6F6KtkVt78diELQEe+7PsDWtiWUhzwYL3KLGvbdm0xIU4ffSFOegLZzYrd01THTtPfnfJ9sls/+nur7RFQO+ZD96KpK9l4sM2g1P7x3UgNi+zZFAd/o+pxoDE37XgpWzwOv5ZD74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af7d2.dynamic.kabel-deutschland.de [95.90.247.210])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AB78A61E5FE01;
	Wed,  7 Aug 2024 07:05:15 +0200 (CEST)
Message-ID: <61c9f4d5-0572-46fb-86c6-483025dd3ca2@molgen.mpg.de>
Date: Wed, 7 Aug 2024 07:05:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/5] igc: Ensure the PTM
 cycle is reliably triggered
To: Christopher S M Hall <christopher.s.hall@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
 vinschen@redhat.com, vinicius.gomes@intel.com, netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 rodrigo.cadore@l-acoustics.com
References: <20240807003032.10300-1-christopher.s.hall@intel.com>
 <20240807003032.10300-2-christopher.s.hall@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240807003032.10300-2-christopher.s.hall@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Christopher,


Thank you for the patch.

Am 07.08.24 um 02:30 schrieb christopher.s.hall@intel.com:
> From: Christopher S M Hall <christopher.s.hall@intel.com>
> 
> Writing to clear the PTM status 'valid' bit while the PTM cycle is
> triggered results in unreliable PTM operation. To fix this, clear the
> PTM 'trigger' and status after each PTM transaction.

I do not understand, why the *valid* bit is not needed anymore, and why 
it’s the trigger bit seems to do the same task. It’d be great if you 
elaborated.

Is that also documented in the dataheet?

> The issue can be reproduced with the following:
> 
> $ sudo phc2sys -R 1000 -O 0 -i tsn0 -m
> 
> Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
> quickly reproduce the issue.
> 
> PHC2SYS exits with:
> 
> "ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
>    fails
> 
> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
>   drivers/net/ethernet/intel/igc/igc_ptp.c     | 70 ++++++++++++--------
>   2 files changed, 42 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 511384f3ec5c..ec191d26c650 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -583,6 +583,7 @@
>   #define IGC_PTM_STAT_T4M1_OVFL		BIT(3) /* T4 minus T1 overflow */
>   #define IGC_PTM_STAT_ADJUST_1ST		BIT(4) /* 1588 timer adjusted during 1st PTM cycle */
>   #define IGC_PTM_STAT_ADJUST_CYC		BIT(5) /* 1588 timer adjusted during non-1st PTM cycle */
> +#define IGC_PTM_STAT_ALL        		GENMASK(5, 0) /* Used to clear all status */
>   
>   /* PCIe PTM Cycle Control */
>   #define IGC_PTM_CYCLE_CTRL_CYC_TIME(msec)	((msec) & 0x3ff) /* PTM Cycle Time (msec) */
> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
> index 946edbad4302..00cc80d8d164 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -974,11 +974,38 @@ static void igc_ptm_log_error(struct igc_adapter *adapter, u32 ptm_stat)
>   	}
>   }
>   
> +static void igc_ptm_trigger(struct igc_hw *hw)
> +{
> +	u32 ctrl;
> +
> +	/* To "manually" start the PTM cycle we need to set the
> +	 * trigger (TRIG) bit
> +	 */
> +	ctrl = rd32(IGC_PTM_CTRL);
> +	ctrl |= IGC_PTM_CTRL_TRIG;
> +	wr32(IGC_PTM_CTRL, ctrl);
> +	/* Perform flush after write to CTRL register otherwise
> +	 * transaction may not start
> +	 */
> +	wrfl();
> +}
> +
> +static void igc_ptm_reset(struct igc_hw *hw)
> +{
> +	u32 ctrl;
> +
> +	ctrl = rd32(IGC_PTM_CTRL);
> +	ctrl &= ~IGC_PTM_CTRL_TRIG;
> +	wr32(IGC_PTM_CTRL, ctrl);
> +	/* Write to clear all status */
> +	wr32(IGC_PTM_STAT, IGC_PTM_STAT_ALL);
> +}
> +
>   static int igc_phc_get_syncdevicetime(ktime_t *device,
>   				      struct system_counterval_t *system,
>   				      void *ctx)
>   {
> -	u32 stat, t2_curr_h, t2_curr_l, ctrl;
> +	u32 stat, t2_curr_h, t2_curr_l;
>   	struct igc_adapter *adapter = ctx;
>   	struct igc_hw *hw = &adapter->hw;
>   	int err, count = 100;
> @@ -994,25 +1021,13 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
>   		 * are transitory. Repeating the process returns valid
>   		 * data eventually.
>   		 */
> -
> -		/* To "manually" start the PTM cycle we need to clear and
> -		 * then set again the TRIG bit.
> -		 */
> -		ctrl = rd32(IGC_PTM_CTRL);
> -		ctrl &= ~IGC_PTM_CTRL_TRIG;
> -		wr32(IGC_PTM_CTRL, ctrl);
> -		ctrl |= IGC_PTM_CTRL_TRIG;
> -		wr32(IGC_PTM_CTRL, ctrl);
> -
> -		/* The cycle only starts "for real" when software notifies
> -		 * that it has read the registers, this is done by setting
> -		 * VALID bit.
> -		 */
> -		wr32(IGC_PTM_STAT, IGC_PTM_STAT_VALID);
> +		igc_ptm_trigger(hw);
>   
>   		err = readx_poll_timeout(rd32, IGC_PTM_STAT, stat,
>   					 stat, IGC_PTM_STAT_SLEEP,
>   					 IGC_PTM_STAT_TIMEOUT);
> +		igc_ptm_reset(hw);
> +
>   		if (err < 0) {
>   			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
>   			return err;
> @@ -1021,15 +1036,7 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
>   		if ((stat & IGC_PTM_STAT_VALID) == IGC_PTM_STAT_VALID)
>   			break;
>   
> -		if (stat & ~IGC_PTM_STAT_VALID) {
> -			/* An error occurred, log it. */
> -			igc_ptm_log_error(adapter, stat);
> -			/* The STAT register is write-1-to-clear (W1C),
> -			 * so write the previous error status to clear it.
> -			 */
> -			wr32(IGC_PTM_STAT, stat);
> -			continue;
> -		}
> +		igc_ptm_log_error(adapter, stat);

Could this refactoring be a separate commit?

>   	} while (--count);
>   
>   	if (!count) {
> @@ -1255,7 +1262,7 @@ void igc_ptp_stop(struct igc_adapter *adapter)
>   void igc_ptp_reset(struct igc_adapter *adapter)
>   {
>   	struct igc_hw *hw = &adapter->hw;
> -	u32 cycle_ctrl, ctrl;
> +	u32 cycle_ctrl, ctrl, stat;
>   	unsigned long flags;
>   	u32 timadj;
>   
> @@ -1290,14 +1297,19 @@ void igc_ptp_reset(struct igc_adapter *adapter)
>   		ctrl = IGC_PTM_CTRL_EN |
>   			IGC_PTM_CTRL_START_NOW |
>   			IGC_PTM_CTRL_SHRT_CYC(IGC_PTM_SHORT_CYC_DEFAULT) |
> -			IGC_PTM_CTRL_PTM_TO(IGC_PTM_TIMEOUT_DEFAULT) |
> -			IGC_PTM_CTRL_TRIG;
> +			IGC_PTM_CTRL_PTM_TO(IGC_PTM_TIMEOUT_DEFAULT);
>   
>   		wr32(IGC_PTM_CTRL, ctrl);
>   
>   		/* Force the first cycle to run. */
> -		wr32(IGC_PTM_STAT, IGC_PTM_STAT_VALID);
> +		igc_ptm_trigger(hw);
> +
> +		if (readx_poll_timeout_atomic(rd32, IGC_PTM_STAT, stat,
> +					      stat, IGC_PTM_STAT_SLEEP,
> +					      IGC_PTM_STAT_TIMEOUT))
> +			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");

I’d add the timeout value to the message.

>   
> +		igc_ptm_reset(hw);
>   		break;
>   	default:
>   		/* No work to do. */


Kind regards,

Paul

