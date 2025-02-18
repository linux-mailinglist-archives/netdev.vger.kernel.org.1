Return-Path: <netdev+bounces-167511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80509A3A877
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8049E188CC34
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562A11BC9F0;
	Tue, 18 Feb 2025 20:13:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDEA17A304;
	Tue, 18 Feb 2025 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739909606; cv=none; b=OMZMRBixXnsSIfLkfgM9O0hiBoOcmcmHH3GQciqzBMFcRi/tNYUvBbw/SVvM7aJR9mvvUF5csgKhoIEVvYBLbv+peVyht0gH3WUjPtzStYG6kNufEg+D0Sfa6/9NP7Gwbr0HR1I7n3z+NFj6x92ihK8BgLV+HfK3gZpsU8segR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739909606; c=relaxed/simple;
	bh=9aoTnZaAQdDDUsyfrBJSBKe6SCyuLiBTL06Pr2f2E3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtiExT8S+8qkmiR8hFrriwmbsuEfOhyVk29X4EfJUSoMONak2EbMiM1vwmf8reLpvexY0h3VZjFtDixvse7S/+h/ghUSJpghJK0gBOuvtkbHWP2HRX8z85r6K+62MNSF4/hGrRJZkQ6AW0UJLVmilU0nCrmfvf1qPwOt/MCmNq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af2b0.dynamic.kabel-deutschland.de [95.90.242.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7537261E64797;
	Tue, 18 Feb 2025 21:12:39 +0100 (CET)
Message-ID: <8db2e1cd-553e-4082-a018-ec269592b69f@molgen.mpg.de>
Date: Tue, 18 Feb 2025 21:12:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] r8152: Call napi_schedule() from proper context
To: Frederic Weisbecker <frederic@kernel.org>,
 Francois Romieu <romieu@fr.zoreil.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org
References: <20250212174329.53793-1-frederic@kernel.org>
 <20250212174329.53793-3-frederic@kernel.org>
 <20250212204929.GA2685909@electric-eye.fr.zoreil.com>
 <Z60LYAml7kq_7XOb@pavilion.home>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <Z60LYAml7kq_7XOb@pavilion.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Frederic, dear Francois,


Thank you for the patch and review.


Am 12.02.25 um 21:58 schrieb Frederic Weisbecker:
> Le Wed, Feb 12, 2025 at 09:49:29PM +0100, Francois Romieu a écrit :
>> Frederic Weisbecker <frederic@kernel.org> :
>> [...]
>>> r8152 may call napi_schedule() on device resume time from a bare task
>>> context without disabling softirqs as the following trace shows:
>> [...]
>>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
>>> index 468c73974046..1325460ae457 100644
>>> --- a/drivers/net/usb/r8152.c
>>> +++ b/drivers/net/usb/r8152.c
>>> @@ -8537,8 +8537,11 @@ static int rtl8152_runtime_resume(struct r8152 *tp)
>>>   		clear_bit(SELECTIVE_SUSPEND, &tp->flags);
>>>   		smp_mb__after_atomic();
>>>   
>>> -		if (!list_empty(&tp->rx_done))
>>> +		if (!list_empty(&tp->rx_done)) {
>>> +			local_bh_disable();
>>>   			napi_schedule(&tp->napi);
>>> +			local_bh_enable();
>>> +		}
>>
>> AFAIU drivers/net/usb/r8152.c::rtl_work_func_t exhibits the same
>> problem.
> 
> It's a workqueue function and softirqs don't seem to be disabled.
> Looks like a goot catch!

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>

Are you going to send a v2, so it might get into Linux 6.14, or is it 
too late anyway?


Kind regards,

Paul

