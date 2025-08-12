Return-Path: <netdev+bounces-212943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CBCB22A1A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7B418987DF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070DA2C1597;
	Tue, 12 Aug 2025 14:01:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E72C1598;
	Tue, 12 Aug 2025 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007280; cv=none; b=j4kYKwKvNdamThprgb6ndxWvYg8joFObHy2AoQZtIDME2MXKzt9eWC1wTEsUGMzvS8/EySkYorADQ4FbaqFO6URgFZJ1HUOjTDgyAkVyQzSV2NUgyw9hI9UelwpGiUDxWR8KNmh32UqHEAsC5kMfYh1GWrNk9dfA9yUYiu3FVSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007280; c=relaxed/simple;
	bh=Zr9/17TTBQAL8gP4A5m0f6S37khEjFu/dkvQjbggPAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScE4EVK4JeOtdR3hfUNDnMRe5nztfr4HRy9Z2OQePZVJIvgPFEfrofsQ37nFCnftuv/FPTSgNVoek006wozqa/ASdtr9xwOxm5+ZbcKc/ZWoyBW11nMQ88kh7nHiYK5NLhqY+Uf3gB5l4Wh+y0//5lQQVuhrNJ5yNXpJsaXb7NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 129DD61E647BA;
	Tue, 12 Aug 2025 16:00:44 +0200 (CEST)
Message-ID: <1940cd0a-f6c5-47ae-abaf-31a5f3579159@molgen.mpg.de>
Date: Tue, 12 Aug 2025 16:00:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2] igb: Fix NULL pointer dereference in
 ethtool loopback test
To: Tianyu Xu <xtydtc@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 kuba@kernel.org, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tianyu Xu <tianyxu@cisco.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Joe Damato <joe@dama.to>
References: <20250812131056.93963-1-tianyxu@cisco.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250812131056.93963-1-tianyxu@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Tianyu,


Thank you for your patch.

Am 12.08.25 um 15:10 schrieb Tianyu Xu:
> The igb driver currently causes a NULL pointer dereference when executing
> the ethtool loopback test. This occurs because there is no associated

Where is this test located? Or, how do I run the test manually?

> q_vector for the test ring when it is set up, as interrupts are typically
> not added to the test rings.
> 
> Since commit 5ef44b3cb43b removed the napi_id assignment in
> __xdp_rxq_info_reg(), there is no longer a need to pass a napi_id to it.
> Therefore, simply use 0 as the last parameter.
> 
> Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Tianyu Xu <tianyxu@cisco.com>
> ---
> Thanks to Aleksandr and Joe for your feedback. I have added the Fixes tag
> and formatted the lines to 75 characters based on your comments.
> 
>   drivers/net/ethernet/intel/igb/igb_main.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index a9a7a94ae..453deb6d1 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4453,8 +4453,7 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
>   	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
>   		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
>   	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
> -			       rx_ring->queue_index,
> -			       rx_ring->q_vector->napi.napi_id);
> +			       rx_ring->queue_index, 0);
>   	if (res < 0) {
>   		dev_err(dev, "Failed to register xdp_rxq index %u\n",
>   			rx_ring->queue_index);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

