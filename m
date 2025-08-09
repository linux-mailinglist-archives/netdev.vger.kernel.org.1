Return-Path: <netdev+bounces-212320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA71FB1F3C5
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 11:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351CA725BAC
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E5F2236FC;
	Sat,  9 Aug 2025 09:35:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9822154B
	for <netdev@vger.kernel.org>; Sat,  9 Aug 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754732115; cv=none; b=HL3gENf/EJ8GDEn7C3HOmEPCUq5LkoyTe0yeAxEiq2raZndXeJGh0M348COfDkvGPVOKTdrXTV+gfhFDJiQ/SycR0qgEetOnnnEvoMC12zVEUgcs0GkZTI99B+5iRIb+14EPGbPsyUTVz+fBwmGUikV9zgd0R4PLSxXha8RiFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754732115; c=relaxed/simple;
	bh=DbaJ8wSy2aBvN1DyLRNIaKCgsblUMiZsq1siRu42B3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vj3wbB02u/RhjJi0UMwU9uOxxWssD5XWhTKoeRqKwX6D4gIdHQU/fOO64FU4/MfvrEYvPljiVBOn5oer3UC4TR+9dkmqKVWzq3/Pka3fI8XB8duGBEiMlWgpLZp6I+w+okhHZNLh8SC29rCIc2/In0lXq7oLDNUk1Q0OzH0PEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7a9.dynamic.kabel-deutschland.de [95.90.247.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6D8BC61E647B7;
	Sat, 09 Aug 2025 11:34:52 +0200 (CEST)
Message-ID: <f0752ae6-25f8-4504-b23b-052f60007deb@molgen.mpg.de>
Date: Sat, 9 Aug 2025 11:34:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: fix incorrect counter for buffer allocation
 failures
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
 netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, aleksander.lobakin@intel.com,
 anthony.l.nguyen@intel.com
References: <20250808155310.1053477-1-michal.kubiak@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250808155310.1053477-1-michal.kubiak@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Michal,


Thank you for your patch.


Am 08.08.25 um 17:53 schrieb Michal Kubiak:
> Currently, the driver increments `alloc_page_failed` when buffer allocation fails
> in `ice_clean_rx_irq()`. However, this counter is intended for page allocation
> failures, not buffer allocation issues.
> 
> This patch corrects the counter by incrementing `alloc_buf_failed` instead,
> ensuring accurate statistics reporting for buffer allocation failures.
> 
> Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
> Reported-by: Jacob Keller <jacob.e.keller@intel.com>
> Suggested-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thank you, but I merely asked to send in the patch separately and didn’t 
spot the error. So, I’d remove the tag, but you add the one at the end.

> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 93907ab2eac7..1b1ebfd347ef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1337,7 +1337,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>   			skb = ice_construct_skb(rx_ring, xdp);
>   		/* exit if we failed to retrieve a buffer */
>   		if (!skb) {
> -			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
> +			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
>   			xdp_verdict = ICE_XDP_CONSUMED;
>   		}
>   		ice_put_rx_mbuf(rx_ring, xdp, ntc, xdp_verdict);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


PS: A little off-topic: As this code is present since v6.3-rc1, I 
wonder, why this has not been causing any user visible issues in the 
last two years. Can somebody explain this?

