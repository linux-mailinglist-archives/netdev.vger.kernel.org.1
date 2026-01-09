Return-Path: <netdev+bounces-248555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42940D0B658
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 17:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B91F5300AC65
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F190A363C78;
	Fri,  9 Jan 2026 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tQr+GUqE"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32EC23B60A
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977105; cv=none; b=N0PV2lHHSeC9vnYH+P7EY20tHo6loMECmA3ZAplmpbtzdff5zpRjcoAy793d2nXg0lqvGuztqw8SDP8EpOZht9mB149O5khyFxDWb/LuFIhI8BZQaJh66fJ6cd3tRpko1iBE2SU6wNc9G9k3bBMGjMyto85pvIYuCx5feIhKpsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977105; c=relaxed/simple;
	bh=IFBVDrDk1Xd+UtYj4EGWtgyA63ewmZqM78nyqcEQFN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCC7XYnpGqjjIbCmat8jOAEMQRrTVzjo9pin0+sJ3JykmLFkCfDr423yRXAv1vTwpLBvPfn5SMo2u9kiIkfYCALQNqjgPpyL3Qug/FMT0ky0a+4ZiwF1hJn3Y+4MZ0peWOmKK0/KPpAs/XBSN1hlDbj8URv3PkYXdYdG/gEEQJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tQr+GUqE; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ddd25fe0-a6a8-4ba9-8cb1-3f91ca562928@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767977102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYFnK9M2AIQkRcKaK9Bzkhziz5Pcw9IZvYQQgIQcJrE=;
	b=tQr+GUqEnapX9C1zO0lUW5erwG29kre6jbLHTyx2Yve3hPA0P7fr+QG8LCobaUq6803Hbv
	9MUPPp3zoFVtMM/lTSQB97z2ik8JD/kwZ63Icj/QogUhANTqGefeTOkTwFeimfBwSMHvBG
	WUobxEp3hsj/yh54jBYPcyLKEJR2IEI=
Date: Fri, 9 Jan 2026 16:44:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ice: fix setting RSS VSI hash for E830
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20260109085339.49839-1-marcin.szycik@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260109085339.49839-1-marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/01/2026 08:53, Marcin Szycik wrote:
> ice_set_rss_hfunc() performs a VSI update, in which it sets hashing
> function, leaving other VSI options unchanged. However, ::q_opt_flags is
> mistakenly set to the value of another field, instead of its original
> value, probably due to a typo. What happens next is hardware-dependent:
> 
> On E810, only the first bit is meaningful (see
> ICE_AQ_VSI_Q_OPT_PE_FLTR_EN) and can potentially end up in a different
> state than before VSI update.
> 
> On E830, some of the remaining bits are not reserved. Setting them
> to some unrelated values can cause the firmware to reject the update
> because of invalid settings, or worse - succeed.
> 
> Reproducer:
>    sudo ethtool -X $PF1 equal 8
> 
> Output in dmesg:
>    Failed to configure RSS hash for VSI 6, error -5
> 
> Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index cf8ba5a85384..08268f1a03da 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -8038,7 +8038,7 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
>   	ctx->info.q_opt_rss |=
>   		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hfunc);
>   	ctx->info.q_opt_tc = vsi->info.q_opt_tc;
> -	ctx->info.q_opt_flags = vsi->info.q_opt_rss;
> +	ctx->info.q_opt_flags = vsi->info.q_opt_flags;

The very same typo pattern is in ice_vc_handle_rss_cfg() in
ice/virt/rss.c

I believe both places have to be fixed.

>   
>   	err = ice_update_vsi(hw, vsi->idx, ctx, NULL);
>   	if (err) {


