Return-Path: <netdev+bounces-90512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BD18AE558
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EBA1C219E5
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453B712B17B;
	Tue, 23 Apr 2024 11:52:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B0583CAA
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873172; cv=none; b=u3xXUcL8lI7dH6rS9EKRKJtfMmdKFeUC8M3gjqwKD8sA1SA7Z4zAFwjjoGGtdW3BeMlXmLMyIxG+wOpAjW+UBnpMg7JuaPUkJda9vxriV5/8/1QvS6b6ZJnxrX1bKWUmzbWEVLfovziG/PiK6EUm12/WWOSD5/sL4+NtRyMTbEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873172; c=relaxed/simple;
	bh=b04MyvKSekoRkZfbb2lCAurxalynMJ5tz/7M7CwrKOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=XwkCVAP6qnLzKmky/aVhvzvFhBgdnmAE6hVGFbc/CqD+vZBJHC8b2oOI570XByLRqB7Fb1ZJMfiPzHJBW0iJvScETqSK9W94M0Q073Q6tX9AXht4V9PjwS3vHciwBTMaIL1wuy0MbWeLca5pW1vidRBR0slkaGM7/N32c2laylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B75D061E5FE36;
	Tue, 23 Apr 2024 13:52:26 +0200 (CEST)
Message-ID: <5d30a9df-224e-4285-94d1-53f6995d648a@molgen.mpg.de>
Date: Tue, 23 Apr 2024 13:52:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] igb: cope with large MAX_SKB_FRAGS.
To: Corinna Vinschen <vinschen@redhat.com>
References: <20240423102446.901450-1-vinschen@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20240423102446.901450-1-vinschen@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Corinna,


Thank you for the patch.


Am 23.04.24 um 12:24 schrieb Corinna Vinschen:
> From: Paolo Abeni <pabeni@redhat.com>

It’d be great if you removed the trailing dot/period in the commit 
message summary.

> Sabrina reports that the igb driver does not cope well with large
> MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> corruption on TX.
> 
> The root cause of the issue is that the driver does not take into
> account properly the (possibly large) shared info size when selecting
> the ring layout, and will try to fit two packets inside the same 4K
> page even when the 1st fraglist will trump over the 2nd head.
> 
> Address the issue forcing the driver to fit a single packet per page,
> leaving there enough room to store the (currently) largest possible
> skb_shared_info.

If you have a reproducer for this, it’d be great if you could document 
it in the commit message.

> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAG")
> Reported-by: Jan Tluka <jtluka@redhat.com>
> Reported-by: Jirka Hladky <jhladky@redhat.com>
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Corinna Vinschen <vinschen@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>   drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index a3f100769e39..22fb2c322bca 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4833,6 +4833,7 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
>   
>   #if (PAGE_SIZE < 8192)
>   	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
> +	    SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2) ||
>   	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
>   		set_ring_uses_large_buffer(rx_ring);
>   #endif


Kind regards,

Paul

