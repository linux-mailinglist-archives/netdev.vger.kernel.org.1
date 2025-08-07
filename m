Return-Path: <netdev+bounces-212103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD416B1DEE1
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 23:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F4F188DFC3
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B3C23AE9A;
	Thu,  7 Aug 2025 21:29:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78654430
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754602179; cv=none; b=PlftCulLEW7WHFRB5t7Yck+jZnwuLzZbS7OmT8LmcflImj6ZlXOtsVonAHMMilGLv9K+besKNhlcs3Xp9pCrwkh89vFs6+c5/xOWmaEdXKUKw+ztfWsNpKYMI64truKv+ZOLheqfv7CV9gXXZ4Fjgo3SgsWnIonEsQDrDPmb3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754602179; c=relaxed/simple;
	bh=f2yBH7mNmbBsosSxXQehBIdyuMWEVMx4aW9mfLLzbH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=qmoEK0JjuYubHPmidy+winv2xEaQ/scCZzT/imIoHjrTaGUfOAJtLVx1pFRv70Jwg9VS+dDmuIbK5xVbd7QO9U8Jp/KXI6Y7zW0aXNSjJ2uJcCFVboxY5rZNFMiQaE+z0Skxl6XxxcoHt5dePvpW9pWPNL7lTgd4aJKEqNPNJto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7c7.dynamic.kabel-deutschland.de [95.90.247.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C3D6460288276;
	Thu, 07 Aug 2025 23:29:10 +0200 (CEST)
Message-ID: <9e72404e-ab66-43dc-8065-1c7008178db6@molgen.mpg.de>
Date: Thu, 7 Aug 2025 23:29:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: fix NULL access of
 tx->in_use in ice_ptp_ts_irq
To: Jacob Keller <jacob.e.keller@intel.com>
References: <20250807-jk-ice-fix-tx-tstamp-race-v1-0-730fe20bec11@intel.com>
 <20250807-jk-ice-fix-tx-tstamp-race-v1-1-730fe20bec11@intel.com>
Content-Language: en-US
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250807-jk-ice-fix-tx-tstamp-race-v1-1-730fe20bec11@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jacob,


Thank you for the patch.

Am 07.08.25 um 19:35 schrieb Jacob Keller:
> The E810 device has support for a "low latency" firmware interface to
> access and read the Tx timestamps. This interface does not use the standard
> Tx timestamp logic, due to the latency overhead of proxying sideband
> command requests over the firmware AdminQ.
> 
> The logic still makes use of the Tx timestamp tracking structure,
> ice_ptp_tx, as it uses the same "ready" bitmap to track which Tx
> timestamps.
> 
> Unfortunately, the ice_ptp_ts_irq() function does not check if the tracker
> is initialized before its first access. This results in NULL dereference or
> use-after-free bugs similar to the following:
> 
> [245977.278756] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [245977.278774] RIP: 0010:_find_first_bit+0x19/0x40
> [245977.278796] Call Trace:
> [245977.278809]  ? ice_misc_intr+0x364/0x380 [ice]
> 
> This can occur if a Tx timestamp interrupt races with the driver reset
> logic.

Do you have a reproducer?

> Fix this by only checking the in_use bitmap (and other fields) if the
> tracker is marked as initialized. The reset flow will clear the init field
> under lock before it tears the tracker down, thus preventing any
> use-after-free or NULL access.

Great commit message. Thank you for taking the time to write this down.

> Fixes: f9472aaabd1f ("ice: Process TSYN IRQ in a separate function")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index e358eb1d719f..fb0f6365a6d6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2701,16 +2701,19 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
>   		 */
>   		if (hw->dev_caps.ts_dev_info.ts_ll_int_read) {
>   			struct ice_ptp_tx *tx = &pf->ptp.port.tx;
> -			u8 idx;
> +			u8 idx, last;
>   
>   			if (!ice_pf_state_is_nominal(pf))
>   				return IRQ_HANDLED;
>   
>   			spin_lock(&tx->lock);
> -			idx = find_next_bit_wrap(tx->in_use, tx->len,
> -						 tx->last_ll_ts_idx_read + 1);
> -			if (idx != tx->len)
> -				ice_ptp_req_tx_single_tstamp(tx, idx);
> +			if (tx->init) {
> +				last = tx->last_ll_ts_idx_read + 1;
> +				idx = find_next_bit_wrap(tx->in_use, tx->len,
> +							 last);
> +				if (idx != tx->len)
> +					ice_ptp_req_tx_single_tstamp(tx, idx);
> +			}
>   			spin_unlock(&tx->lock);
>   
>   			return IRQ_HANDLED;
> 

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

