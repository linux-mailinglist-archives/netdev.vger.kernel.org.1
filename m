Return-Path: <netdev+bounces-212104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8E3B1DEE6
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 23:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB3E3B66AC
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 21:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE84C1A08BC;
	Thu,  7 Aug 2025 21:32:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB632E370A
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754602347; cv=none; b=BxKH+zFc1+gLEFpWVkLG9mIS9Zq2mliAz9MgiNrwnWm/D8QNyEkAqzgx32zMqebHmnb1TMNL3W9YAgaXB55L0V48OgBUnHItoCSfiJ0HH2vfS2cC6apqNvMqaMB3dixz1n1D5b2yHxTgIormhvSS/VQYqo62/d5RdzHDaVk/9Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754602347; c=relaxed/simple;
	bh=7pVP4/N6YeK3todbA5w2yvuoV5FQL1pyfUZVKxKzjAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iXZr/3ffqFF+iCevBk/JYbaI8zu2PxhDCUpSyDpwANXCsW04ucWhxEdsCEZdslOa1oqrLip8CVbTxbOA4BxmQ/iV7mp/ubzPl3gwJ8fDGdnJ2ZXgMlXpzbHu0j32tlqj0FDvWsc88iKSgVeVCsKNiTcSrHEKXfOV/yZCDusFroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7c7.dynamic.kabel-deutschland.de [95.90.247.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E5BF860288277;
	Thu, 07 Aug 2025 23:32:06 +0200 (CEST)
Message-ID: <7961b079-fb26-4541-b7d3-63bddd484e2a@molgen.mpg.de>
Date: Thu, 7 Aug 2025 23:32:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: fix NULL access of
 tx->in_use in ice_ll_ts_intr
To: Jacob Keller <jacob.e.keller@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
References: <20250807-jk-ice-fix-tx-tstamp-race-v1-0-730fe20bec11@intel.com>
 <20250807-jk-ice-fix-tx-tstamp-race-v1-2-730fe20bec11@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250807-jk-ice-fix-tx-tstamp-race-v1-2-730fe20bec11@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jacob,


Thank you for the patch.

Am 07.08.25 um 19:35 schrieb Jacob Keller:
> Recent versions of the E810 firmware have support for an extra interrupt to
> handle report of the "low latency" Tx timestamps coming from the
> specialized low latency firmware interface. Instead of polling the
> registers, software can wait until the low latency interrupt is fired.
> 
> This logic makes use of the Tx timestamp tracking structure, ice_ptp_tx, as
> it uses the same "ready" bitmap to track which Tx timestamps.

Is the last part “to track which Tx timestamps” complete?

> Unfortunately, the ice_ll_ts_intr() function does not check if the
> tracker is initialized before its first access. This results in NULL
> dereference or use-after-free bugs similar to the issues fixed in the
> ice_ptp_ts_irq() function.
> 
> Fix this by only checking the in_use bitmap (and other fields) if the
> tracker is marked as initialized. The reset flow will clear the init field
> under lock before it tears the tracker down, thus preventing any
> use-after-free or NULL access.
> 
> Fixes: 82e71b226e0e ("ice: Enable SW interrupt from FW for LL TS")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 8e0b06c1e02b..7b002127e40d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3176,12 +3176,14 @@ static irqreturn_t ice_ll_ts_intr(int __always_unused irq, void *data)
>   	hw = &pf->hw;
>   	tx = &pf->ptp.port.tx;
>   	spin_lock_irqsave(&tx->lock, flags);
> -	ice_ptp_complete_tx_single_tstamp(tx);
> +	if (tx->init) {
> +		ice_ptp_complete_tx_single_tstamp(tx);
>   
> -	idx = find_next_bit_wrap(tx->in_use, tx->len,
> -				 tx->last_ll_ts_idx_read + 1);
> -	if (idx != tx->len)
> -		ice_ptp_req_tx_single_tstamp(tx, idx);
> +		idx = find_next_bit_wrap(tx->in_use, tx->len,
> +					 tx->last_ll_ts_idx_read + 1);
> +		if (idx != tx->len)
> +			ice_ptp_req_tx_single_tstamp(tx, idx);
> +	}
>   	spin_unlock_irqrestore(&tx->lock, flags);
>   
>   	val = GLINT_DYN_CTL_INTENA_M | GLINT_DYN_CTL_CLEARPBA_M |
> 

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

