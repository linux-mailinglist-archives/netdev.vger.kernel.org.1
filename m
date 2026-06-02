Return-Path: <netdev+bounces-294136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFshKfGxHmr7JAAAu9opvQ
	(envelope-from <netdev+bounces-294136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:35:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A0362CB11
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04A333049339
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 10:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6512D3C8738;
	Tue,  2 Jun 2026 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WL+SBZtw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1551D243956
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395330; cv=none; b=jzWZs12aeIu488Z3vp3a4mIvQuHvXn+WDd+T/RQbxiYYuWyLDNhX9EDepGZPgnUP4jNx5Qd9YIKE4y04WgiNAeJj0JM/UmUDcJZ/O+hE6Ib2wgaIAiZqHw54am8gMt54lMM2xwPAsLzdaKdbj7hAdvFFSPfIEYVv58LUO2pXyRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395330; c=relaxed/simple;
	bh=1BFtdgLgx1WuF9HW/LWBdynSaVB4mxxZa6n9opIQPRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwhsJF6BAOQWWdQCcBZ0fRjobOjAL5EtbwpG6gN4lNsrV0L05JAPUjhJCEd6PrXCDjfB+k4WcvJDC1IlqMmHGd30or4ABZJlRKI2cEHkA7Xbr+WR/vN+ftOqZYRHcZRICF2jOAY+FNA57KiCn3ihkISjMArSwZ/36OnhQUyIYqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WL+SBZtw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780395327; x=1811931327;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1BFtdgLgx1WuF9HW/LWBdynSaVB4mxxZa6n9opIQPRM=;
  b=WL+SBZtwj/zKZl7UKJyVPDoU4kj9JwA4U3+r1Fx4frf+Iph260IXgAC/
   bXhEW2tzD3MNj/S3tKUJD0FbqCz3ZvzqOOg7GfcmXR8BoTa8DGLxP/LfM
   hA6wtcl8lc7KO+AS4gqtP9kJC0rjDYjpSad2gSe9K6WX9I/NxlZ34Eglm
   wcOyi8CK5Pg64Xun5g2QOIrVz6QYA/Y+R4BMAFhgvn9fGS2rn+vB4AQeX
   Xvz/i1eRlSntJFwyH+9yWutrkr5dMIxUoiG1p3vRg+R+cFp8JDHmCCt9p
   xGo7decjm00jk1d6rIk4OIvGitcpZw27j7P0n0ShaNDuBq8Tik6iVm5jB
   g==;
X-CSE-ConnectionGUID: rcwJSgGCRSixo7DQ0eQdeQ==
X-CSE-MsgGUID: O8M/SZWERR6+tppV2KtWdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80320784"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="80320784"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:15:26 -0700
X-CSE-ConnectionGUID: QOxO0qGNTGGxUPsJZYMb0g==
X-CSE-MsgGUID: ZpNGIpfISR2Bw0Ck6nKUqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="281976068"
Received: from mszycik-desk.igk.intel.com (HELO [10.217.160.157]) ([10.217.160.157])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:15:24 -0700
Message-ID: <961dca76-3025-45a4-b11e-0ee8f241d290@linux.intel.com>
Date: Tue, 2 Jun 2026 12:15:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix E810 low latency
 timestamp interrupt handling
To: Jacob Keller <jacob.e.keller@intel.com>,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemyslaw Korba <przemyslaw.korba@intel.com>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org
References: <20260529-jk-fix-e810-ll-interface-function-v1-1-ec84a408af7e@intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260529-jk-fix-e810-ll-interface-function-v1-1-ec84a408af7e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A9A0362CB11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.intel.com:mid];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-294136-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Action: no action



On 29/05/2026 22:22, Jacob Keller wrote:
> The driver has supported a low latency timestamp interface since commit
> 82e71b226e0e ("ice: Enable SW interrupt from FW for LL TS").
> 
> This interface is triggered by calling ice_ptp_req_tx_single_tstamp(),
> which is called by ice_ptp_ts_irq(), which in turn is called when the
> driver gets an interrupt from hardware indicating that a timestamp is
> available.
> 
> This function doesn't check if a timestamp request is already in progress,
> and as a result could trash an existing outstanding requests when called.
> It turns out that this is unlikely in practice due to a number of
> circumstances that prevent most of the ways that could happen.
> 
> 1. The ice_misc_intr_thread_fn() might trigger a software-generated
>    interrupt with the PFINT_OICR_TSYN_TX flag. However, we don't enter the
>    thread function since ice_ptp_ts_irq() always returns IRQ_HANDLED for
>    E810 devices which support the low latency firmware interface.
> 
> 2. The ice_ptp_maybe_trigger_tx_interrupt() function might trigger a
>    software-generated interrupt if it detects waiting timetstamps. However
>    it checks ptp.port.tx.has_ready_bitmap which is always false for E810,
>    so never enters the code path.
> 
> However, it is still possible that another Tx timestamp request could
> happen and complete and race with the firmware completing the outstanding
> low latency timestamp request.
> 
> This doesn't happen often in practice because many applications only
> trigger a single outstanding Tx timestamp at once. However, if the user
> runs multiple copies of ptp4l or uses other userspace stack which does,
> they might miss timestamps or get corrupted timestamp data.
> 
> To fix this, have the ice_ptp_req_tX_single_tstamp() function check and
> only begin the operation if the ATQBAL_FLAGS_INTR_IN_PROGRESS flag was not
> yet set. This prevents a new possible request from trashing an outstanding
> request. Note that on completion of a request, the ice_ll_ts_intr()
> function will initiate a request for the next outstanding timestamp, so no
> timestamps will be lost.
> 
> Additionally, although the ice_ptp_tx_tstamps_pending() function doesn't
> currently get called for E810 devices, it should still not return true for
> devices which support the low latency interrupt. If for some reason code is
> refactored and the miscellaneous thread function does execute, it should
> not trigger a new software interrupt for devices using the low latency
> interrupt interface. Add an explicit check to make this function always
> return false when the device is operating in this mode.
> 
> Finally, convert the atqbal_flags to DECLARE_BITMAP and use test/set bit
> functions. This helps in clarity as we can use test_and_set_bit and
> test_and_clear_bit.
> 
> Fixes: 82e71b226e0e ("ice: Enable SW interrupt from FW for LL TS")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
+ some nits

> ---
> This was originally motivated by changes in our out-of-tree release where
> the issue of a software-generated interrupt was causing significantly more
> issues. After further investigation it seems that the upstream
> implementation is more robust, preventing the thread function from running
> for E810. However, there appears to be a small window where issues can crop
> up if multiple outstanding timestamps are requested near concurrently. This
> change is motivated at closing that gap and ensuring consistency of
> timestamps returned through the low latency interface.
> 
> To trigger the issue you will need to issue multiple Tx timestamp requests
> near but not quite simultaneously, and it may be quite a rare race
> condition.
> ---
>  drivers/net/ethernet/intel/ice/ice_type.h   |  8 ++++++--
>  drivers/net/ethernet/intel/ice/ice_ptp.c    | 24 +++++++++++++++++++-----
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 ++++++------
>  3 files changed, 31 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
> index 1e82f4c40b32..7035ea6c59db 100644
> --- a/drivers/net/ethernet/intel/ice/ice_type.h
> +++ b/drivers/net/ethernet/intel/ice/ice_type.h
> @@ -859,12 +859,16 @@ struct ice_mbx_data {
>  #define ICE_PORTS_PER_QUAD	4
>  #define ICE_GET_QUAD_NUM(port) ((port) / ICE_PORTS_PER_QUAD)
>  
> -#define ATQBAL_FLAGS_INTR_IN_PROGRESS	BIT(0)
> +enum ice_atqbal_flags {
> +	ATQBAL_FLAGS_INTR_IN_PROGRESS,
> +
> +	ATQBAL_FLAGS_NBITS, /* must be last */

Nit: no comma

> +};
>  
>  struct ice_e810_params {
>  	/* The wait queue lock also protects the low latency interface */
>  	wait_queue_head_t atqbal_wq;
> -	unsigned int atqbal_flags;
> +	DECLARE_BITMAP(atqbal_flags, ATQBAL_FLAGS_NBITS);
>  };
>  
>  struct ice_eth56g_params {
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 36df742c326c..11059deb5d41 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -382,6 +382,7 @@ void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx)
>  	struct ice_ptp_port *ptp_port;
>  	unsigned long flags;
>  	struct sk_buff *skb;
> +	struct device *dev;
>  	struct ice_pf *pf;
>  
>  	if (!tx->init)
> @@ -389,6 +390,7 @@ void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx)
>  
>  	ptp_port = container_of(tx, struct ice_ptp_port, tx);
>  	pf = ptp_port_to_pf(ptp_port);
> +	dev = ice_pf_to_dev(pf);
>  	params = &pf->hw.ptp.phy.e810;
>  
>  	/* Drop packets which have waited for more than 2 seconds */
> @@ -408,7 +410,13 @@ void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx)
>  
>  	spin_lock_irqsave(&params->atqbal_wq.lock, flags);
>  
> -	params->atqbal_flags |= ATQBAL_FLAGS_INTR_IN_PROGRESS;
> +	if (test_and_set_bit(ATQBAL_FLAGS_INTR_IN_PROGRESS,
> +			     params->atqbal_flags)) {
> +		dev_dbg(dev, "%s: low latency interrupt request already in progress?\n",

Why the '?', are we not certain it's in progress?

> +			__func__);
> +		spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
> +		return;

Nit: could be an unroll.

> +	}
>  
>  	/* Write TS index to read to the PF register so the FW can read it */
>  	wr32(&pf->hw, REG_LL_PROXY_H,
> @@ -449,7 +457,8 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
>  
>  	spin_lock_irqsave(&params->atqbal_wq.lock, flags);
>  
> -	if (!(params->atqbal_flags & ATQBAL_FLAGS_INTR_IN_PROGRESS))
> +	if (!test_and_clear_bit(ATQBAL_FLAGS_INTR_IN_PROGRESS,
> +				params->atqbal_flags))
>  		dev_dbg(dev, "%s: low latency interrupt request not in progress?\n",
>  			__func__);
>  
> @@ -459,8 +468,6 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
>  	reg_ll_high = rd32(&pf->hw, REG_LL_PROXY_H);
>  
>  	/* Wake up threads waiting on low latency interface */
> -	params->atqbal_flags &= ~ATQBAL_FLAGS_INTR_IN_PROGRESS;
> -
>  	wake_up_locked(&params->atqbal_wq);
>  
>  	spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
> @@ -2712,7 +2719,14 @@ bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
>  	struct ice_hw *hw = &pf->hw;
>  	int ret;
>  
> -	/* Check software indicator */
> +	/* E810 devices with support for the low latency timestamp interrupt
> +	 * have specialized handling for timestamps. They should not
> +	 * re-schedule the miscellaneous interrupt.
> +	 */
> +	if (hw->mac_type == ICE_MAC_E810 &&
> +	    hw->dev_caps.ts_dev_info.ts_ll_int_read)
> +		return false;
> +
>  	switch (pf->ptp.tx_interrupt_mode) {
>  	case ICE_PTP_TX_INTERRUPT_NONE:
>  		return false;
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 2c18e16fe053..02d4cc942c8d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -4521,8 +4521,8 @@ ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
>  
>  	/* Wait for any pending in-progress low latency interrupt */
>  	err = wait_event_interruptible_locked_irq(params->atqbal_wq,
> -						  !(params->atqbal_flags &
> -						    ATQBAL_FLAGS_INTR_IN_PROGRESS));
> +						  !test_bit(ATQBAL_FLAGS_INTR_IN_PROGRESS,
> +							    params->atqbal_flags));
>  	if (err) {
>  		spin_unlock_irq(&params->atqbal_wq.lock);
>  		return err;
> @@ -4754,8 +4754,8 @@ static int ice_ptp_prep_phy_adj_ll_e810(struct ice_hw *hw, s32 adj)
>  
>  	/* Wait for any pending in-progress low latency interrupt */
>  	err = wait_event_interruptible_locked_irq(params->atqbal_wq,
> -						  !(params->atqbal_flags &
> -						    ATQBAL_FLAGS_INTR_IN_PROGRESS));
> +						  !test_bit(ATQBAL_FLAGS_INTR_IN_PROGRESS,
> +							    params->atqbal_flags));
>  	if (err) {
>  		spin_unlock_irq(&params->atqbal_wq.lock);
>  		return err;
> @@ -4846,8 +4846,8 @@ static int ice_ptp_prep_phy_incval_ll_e810(struct ice_hw *hw, u64 incval)
>  
>  	/* Wait for any pending in-progress low latency interrupt */
>  	err = wait_event_interruptible_locked_irq(params->atqbal_wq,
> -						  !(params->atqbal_flags &
> -						    ATQBAL_FLAGS_INTR_IN_PROGRESS));
> +						  !test_bit(ATQBAL_FLAGS_INTR_IN_PROGRESS,
> +							    params->atqbal_flags));
>  	if (err) {
>  		spin_unlock_irq(&params->atqbal_wq.lock);
>  		return err;
> 
> ---
> base-commit: 2412591cfe66e681374c5265e691695cd913d099
> change-id: 20260528-jk-fix-e810-ll-interface-function-5dad155217d8
> 
> Best regards,
> --  
> Jacob Keller <jacob.e.keller@intel.com>
> 
> 


