Return-Path: <netdev+bounces-67344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A568E842E88
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 22:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA211F257C6
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 21:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AB7762CF;
	Tue, 30 Jan 2024 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="am9Umhsl"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD1762CD
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649301; cv=none; b=W3AUH++2mShDcpbn7EEzSJaKf5tcqepylamTpcIULBx49cDqHWDWHUEodMh2OEiKWWT5LzrKcURzyMZau82WZlL2Vy7n4hl3KSTXKf5FEtwEIcAD/mm0spq8lyPuF0cLBqHiSL2g0jvD/kUQn9w9m2Dhv4p+4Lc1K5AinepEWio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649301; c=relaxed/simple;
	bh=1CFaWEvQVDvYhx15c2XRxd1375cnGeVGGDtfH7ZsF1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9HpxHdsbi/jpFchuIlS/4ginHTiVrFAiaR6itgTZIk0xF9EQ/1nbQM4jsJtM1R93eTaNzvp0WWPZAGNueGgT2zlBNcdIRrkPN5OiGRFgtI11nzQDMT8MpU7Vs1v17tWvQWYQWDlzDBd0zp4B8xZElx+hniJiMehah0ms2Xa1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=am9Umhsl; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c5e27a8a-739e-4b7d-a189-46b9c30361c8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706649297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4nWujvqliycDziul7nM2PHyp70jjut7+7kz2A3Ksdo=;
	b=am9UmhslURaPrR7w9/ea4gSdXlsFNnNAS0hoqbqIh9HdO/eIUrEvroIAKuCPP7wHn4MBcr
	Gv6X67RKvF0/JhqYryD37VfQlhP5jg0xGv+mVEuI+1dSAxXAinq/dymjBYojyNHUfP7UDX
	Csbb3wLpIUgCxKbELxivlSFclEDbO58=
Date: Tue, 30 Jan 2024 21:14:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch net-next] dpll: move xa_erase() call in to match
 dpll_pin_alloc() error path order
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, arkadiusz.kubalewski@intel.com
References: <20240130155814.268622-1-jiri@resnulli.us>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240130155814.268622-1-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/01/2024 15:58, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This is cosmetics. Move the call of xa_erase() in dpll_pin_put()
> so the order of cleanup calls matches the error path of
> dpll_pin_alloc().

Jiri, remind me please, why do we clean up xarray in error path in the
same order we allocate them?

The patch looks good,

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   drivers/dpll/dpll_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 5152bd1b0daf..61e5c607a72f 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -560,9 +560,9 @@ void dpll_pin_put(struct dpll_pin *pin)
>   {
>   	mutex_lock(&dpll_lock);
>   	if (refcount_dec_and_test(&pin->refcount)) {
> +		xa_erase(&dpll_pin_xa, pin->id);
>   		xa_destroy(&pin->dpll_refs);
>   		xa_destroy(&pin->parent_refs);
> -		xa_erase(&dpll_pin_xa, pin->id);
>   		dpll_pin_prop_free(&pin->prop);
>   		kfree(pin);
>   	}


