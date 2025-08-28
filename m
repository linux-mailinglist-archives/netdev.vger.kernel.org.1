Return-Path: <netdev+bounces-217747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D39F8B39B2C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDC31C2775B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC430EF8E;
	Thu, 28 Aug 2025 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CnDG0qTn"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263ED30E84F
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379532; cv=none; b=KnakNqvu51pn3L57MjShnw69Hpm+RxD+TjGUbFGz0Mii9TEZwEm12rWN/LIUge3qtJ7XonJyuzxOdZfde8GkiP05zBDYN3ROpL40yQn0tI1wRBYINkTGdy66z1n7BOACHcRL44bCel0+e6bayD/UDP7Q1uReiaJx79VJ7nB1mXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379532; c=relaxed/simple;
	bh=azVT6OyX17mJ1mLSMWuru5qH6So32sdeLByBxjRBfgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmaMMmxoWmdiXcxmsSYjUZH5T8pZf+KrqENcFBNIy+uqG/hGWsQ+0VoEVn+LS0uyZOHI+BESok/hyGQemPB2dyF3ifHeWa38Ub+Nz7XCw8XApJQpgbYXaExeg0q8o6LqYv8dUU28NWG52W6e8Z5GV7pL3tB5nJvqRpDTenUQps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CnDG0qTn; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <25ff983c-8479-4c2e-9afc-2a3befedabb0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756379516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3IXxPSrRxO339QcDyVUwSO1LP7tYTXUUNNhlUINf988=;
	b=CnDG0qTnaRMloKRTbTSYCakSn5XmfRrARG6tNq8n5gwCsObaWhfkxM4SLVB+IDWuwY0iIX
	dgT2ejDDe7wM0F4dyfpODdaz5RC/Cbh5Z4kXMsRYci1rnlyENpSmZM1lZz6EmF4XzX/zDN
	ACQFl2SdexFK5QqpTo6teYPxNUJcJ8I=
Date: Thu, 28 Aug 2025 12:11:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ptp: ocp: fix use-after-free bugs causing by
 ptp_ocp_watchdog
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 jonathan.lemon@gmail.com, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org
References: <20250828082949.28189-1-duoming@zju.edu.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250828082949.28189-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 09:29, Duoming Zhou wrote:
> The ptp_ocp_detach() only shuts down the watchdog timer if it is
> pending. However, if the timer handler is already running, the
> timer_delete_sync() is not called. This leads to race conditions
> where the devlink that contains the ptp_ocp is deallocated while
> the timer handler is still accessing it, resulting in use-after-free
> bugs. The following details one of the race scenarios.
> 
> (thread 1)                           | (thread 2)
> ptp_ocp_remove()                     |
>    ptp_ocp_detach()                   | ptp_ocp_watchdog()
>      if (timer_pending(&bp->watchdog))|   bp = timer_container_of()
>        timer_delete_sync()            |
>                                       |
>    devlink_free(devlink) //free       |
>                                       |   bp-> //use
> 
> Resolve this by unconditionally calling timer_delete_sync() to ensure
> the timer is reliably deactivated, preventing any access after free.
> 
> Fixes: 773bda964921 ("ptp: ocp: Expose various resources on the timecard.")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

> ---
>   drivers/ptp/ptp_ocp.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index d39073dc4072..4e1286ce05c9 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -4557,8 +4557,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>   	ptp_ocp_debugfs_remove_device(bp);
>   	ptp_ocp_detach_sysfs(bp);
>   	ptp_ocp_attr_group_del(bp);
> -	if (timer_pending(&bp->watchdog))
> -		timer_delete_sync(&bp->watchdog);
> +	timer_delete_sync(&bp->watchdog);
>   	if (bp->ts0)
>   		ptp_ocp_unregister_ext(bp->ts0);
>   	if (bp->ts1)


