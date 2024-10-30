Return-Path: <netdev+bounces-140330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E27629B5FDB
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 11:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89117B217F1
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 10:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED8B1E32B9;
	Wed, 30 Oct 2024 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpYY+w+D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0C1E2854
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283491; cv=none; b=tfM9gA57r3IDyIYNmsas++qMVkHAEpJJ67arM8mdJBF3qLaQkf+/rFdoijQwpUj21mGHNudOMUdGoNGTi10RmQ6AuEwxbkjdIREOpG1+lYjWmw5yFj0aCpBsx3kGA+72A3VtC5hvBtAWM8KSHWkGjAqjPzgp+M/ZrBswogNxcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283491; c=relaxed/simple;
	bh=AYFYjYlVzqkFG3juHcep4H0Nn5r8MErOklDDE8t5F10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo/rbpdCnbbCdMqv95ZFcPDl4QVOB8yj0F+duCQUhvpAaXD+mhbQB/Idjc5VOgbZKW6Ci9r827Zd9gwhKVnt+KyEneYhdSY7h50WVtyCgTiivwCOIU10xNbfNUedsghCTnVB4lXhJHUWSXO4ilzMQY9FlFB8yU5trefahgc95MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpYY+w+D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730283487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqa2j/WHF+GdlD6lOgLdezIWaPBVcoIw8hhYMnhBHDI=;
	b=OpYY+w+D3fM4a2hdPIE0itgwdPfPOt17IDeXR74p1oiMzfww7Yosd0iM3D611WRyXkheG1
	oIk9Wi2LnT7HR7YPnHocNXB5amTxQhuS1T+w73Q+PeQijSDJ5Qq+AH1K6lbPU9aOKH8ctf
	K98xOfoZ5KQX2FBuhxZIkKVBAx9AnyU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-Po8IUl34NOm1C3Tfl6hKRg-1; Wed,
 30 Oct 2024 06:18:04 -0400
X-MC-Unique: Po8IUl34NOm1C3Tfl6hKRg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EBB7195609E;
	Wed, 30 Oct 2024 10:18:02 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.141])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A3071956088;
	Wed, 30 Oct 2024 10:18:01 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AD2B6A80661; Wed, 30 Oct 2024 11:17:58 +0100 (CET)
Date: Wed, 30 Oct 2024 11:17:58 +0100
From: Corinna Vinschen <vinschen@redhat.com>
To: Chris H <christopher.s.hall@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-net v2 1/4] igc: Ensure the PTM cycle is reliably
 triggered
Message-ID: <ZyIH1rVt35JAFTW8@calimero.vinschen.de>
Mail-Followup-To: Chris H <christopher.s.hall@intel.com>,
	intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20241023023040.111429-1-christopher.s.hall@intel.com>
 <20241023023040.111429-2-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023023040.111429-2-christopher.s.hall@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Chris,

On Oct 23 02:30, Chris H wrote:
> From: Christopher S M Hall <christopher.s.hall@intel.com>
> 
> Writing to clear the PTM status 'valid' bit while the PTM cycle is
> triggered results in unreliable PTM operation. To fix this, clear the
> PTM 'trigger' and status after each PTM transaction.
> 
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
>   fails
> 
> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

In the v1 thread in August I asked for adding a description of the kdump
problem we observed to the commit message.  I came up with this text,
maybe we can still add it, or maybe a shhortened version of it?

  This patch also fixes a hang in igc_probe() when loading the igc
  driver in the kdump kernel on systems supporting PTM.

  The igc driver running in the base kernel enables PTM trigger in
  igc_probe().  Therefore the driver is always in PTM trigger mode,
  except in brief periods when manually triggering a PTM cycle.

  When a crash occurs, the NIC is reset while PTM trigger is enabled.
  Due to a hardware problem, the NIC is subsequently in a bad busmaster
  state and doesn't handle register reads/writes.  When running
  igc_probe() in the kdump kernel, the first register access to a NIC
  register hangs driver probing and ultimately breaks kdump.

  With this patch, igc has PTM trigger disabled most of the time,
  and the trigger is only enabled for very brief (10 - 100 us) periods
  when manually triggering a PTM cycle.  Chances that a crash occurs
  during a PTM trigger are not 0, but extremly reduced.


Thanks,
Corinna


> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
>  drivers/net/ethernet/intel/igc/igc_ptp.c     | 70 ++++++++++++--------
>  2 files changed, 42 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 8e449904aa7d..afd0512dc9f8 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -593,6 +593,7 @@
>  #define IGC_PTM_STAT_T4M1_OVFL		BIT(3) /* T4 minus T1 overflow */
>  #define IGC_PTM_STAT_ADJUST_1ST		BIT(4) /* 1588 timer adjusted during 1st PTM cycle */
>  #define IGC_PTM_STAT_ADJUST_CYC		BIT(5) /* 1588 timer adjusted during non-1st PTM cycle */
> +#define IGC_PTM_STAT_ALL        	GENMASK(5, 0) /* Used to clear all status */
>  
>  /* PCIe PTM Cycle Control */
>  #define IGC_PTM_CYCLE_CTRL_CYC_TIME(msec)	((msec) & 0x3ff) /* PTM Cycle Time (msec) */
> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
> index 946edbad4302..00cc80d8d164 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -974,11 +974,38 @@ static void igc_ptm_log_error(struct igc_adapter *adapter, u32 ptm_stat)
>  	}
>  }
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
>  static int igc_phc_get_syncdevicetime(ktime_t *device,
>  				      struct system_counterval_t *system,
>  				      void *ctx)
>  {
> -	u32 stat, t2_curr_h, t2_curr_l, ctrl;
> +	u32 stat, t2_curr_h, t2_curr_l;
>  	struct igc_adapter *adapter = ctx;
>  	struct igc_hw *hw = &adapter->hw;
>  	int err, count = 100;
> @@ -994,25 +1021,13 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
>  		 * are transitory. Repeating the process returns valid
>  		 * data eventually.
>  		 */
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
>  		err = readx_poll_timeout(rd32, IGC_PTM_STAT, stat,
>  					 stat, IGC_PTM_STAT_SLEEP,
>  					 IGC_PTM_STAT_TIMEOUT);
> +		igc_ptm_reset(hw);
> +
>  		if (err < 0) {
>  			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
>  			return err;
> @@ -1021,15 +1036,7 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
>  		if ((stat & IGC_PTM_STAT_VALID) == IGC_PTM_STAT_VALID)
>  			break;
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
>  	} while (--count);
>  
>  	if (!count) {
> @@ -1255,7 +1262,7 @@ void igc_ptp_stop(struct igc_adapter *adapter)
>  void igc_ptp_reset(struct igc_adapter *adapter)
>  {
>  	struct igc_hw *hw = &adapter->hw;
> -	u32 cycle_ctrl, ctrl;
> +	u32 cycle_ctrl, ctrl, stat;
>  	unsigned long flags;
>  	u32 timadj;
>  
> @@ -1290,14 +1297,19 @@ void igc_ptp_reset(struct igc_adapter *adapter)
>  		ctrl = IGC_PTM_CTRL_EN |
>  			IGC_PTM_CTRL_START_NOW |
>  			IGC_PTM_CTRL_SHRT_CYC(IGC_PTM_SHORT_CYC_DEFAULT) |
> -			IGC_PTM_CTRL_PTM_TO(IGC_PTM_TIMEOUT_DEFAULT) |
> -			IGC_PTM_CTRL_TRIG;
> +			IGC_PTM_CTRL_PTM_TO(IGC_PTM_TIMEOUT_DEFAULT);
>  
>  		wr32(IGC_PTM_CTRL, ctrl);
>  
>  		/* Force the first cycle to run. */
> -		wr32(IGC_PTM_STAT, IGC_PTM_STAT_VALID);
> +		igc_ptm_trigger(hw);
> +
> +		if (readx_poll_timeout_atomic(rd32, IGC_PTM_STAT, stat,
> +					      stat, IGC_PTM_STAT_SLEEP,
> +					      IGC_PTM_STAT_TIMEOUT))
> +			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
>  
> +		igc_ptm_reset(hw);
>  		break;
>  	default:
>  		/* No work to do. */
> -- 
> 2.34.1


