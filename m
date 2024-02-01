Return-Path: <netdev+bounces-68167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF7984601D
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 19:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F376E1F2E31A
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE84D7E113;
	Thu,  1 Feb 2024 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FE1tXchw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ABB62158
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812824; cv=none; b=c7KUGmrP62Oeo+RY6Jz7ATp4/r9Mk441/XwfHzKoDYkjnQX0omBObqs3gdG3nGxccXt8zbCWtNKQdicHrtve4yyYHdEsULCB//C1zCAOUR7yBdadlezr6a18ho831jzDjHfZRi2SSeuGNnXCHWp+F9w0xkPZVNAGfWfxcQfYnCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812824; c=relaxed/simple;
	bh=X0j4+MbN03mdxo3/x+zdxdiOigFmbwcnINLA8FU6mrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MITfuOH5VKpWCnJjY0xlsUizRLv0f9hYSZ1EhbIhyUshdYEOixyuDz+hzWahf3iQI66dKfA5Xvd85c6rw2ecMdvj9T1ZUd6O3Hbz2I+IC16fLsQ6FeihCF0rq5iyYvTQPwm/TgHHGV4+1+W+hhUgoxQFMvxmrprao6ajzrzHUf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FE1tXchw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706812821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+bng6XVxC/t11ZZID4vMLTIFN/umfC4M7wqJVe9R1U=;
	b=FE1tXchwOS2TgHKQeILwW3Nn9JM3ngADKPZOcAXFsfCGV/d7+cB/8dctDecyA2WumdJhbf
	ZPyldgNN9Kb+7IlxUDCN+AD91Z4i8tQAtVkLIQETTNDWZ+UYxwCgpMitoRycEFNDjePmBB
	mSXtDVz5L2bE2T6CEIkPRjwuedz6A7M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Tf9wIBJsM9e0o_APNGzP6Q-1; Thu, 01 Feb 2024 13:40:20 -0500
X-MC-Unique: Tf9wIBJsM9e0o_APNGzP6Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a365b809240so72537266b.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 10:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706812819; x=1707417619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+bng6XVxC/t11ZZID4vMLTIFN/umfC4M7wqJVe9R1U=;
        b=mNAMl6trxA4sJ2QGAhTgm5BSNOs9UO7SeK5p0Big7ndlzaMEEgrbw34g4KXMiNW+te
         LRLjj2UK8G74bbx34e9FTmC1S4aOig3fvwkzLLVX2dz+jPR4EMERmFy2hfZeGA0D+lHA
         RSnHdpVOd/DyZunMYPV1HVQ2HueIziwJbkRs5ZuMAzBBoIYFIf9n7OScbGGI/Ui0wB6A
         iLzlvkDUOERvVw23Cxr7nr8jHrCCdzkvg9yNvPDbUz2FSTXndN1vDO1YpP6fLjC9syuS
         UoObHxZvsBDuGVdQemvHiXtEGiA9ovsRqVa3kRCJ6gBTCQsCB+tSUUP6FmJ5nDZoimpa
         fARQ==
X-Gm-Message-State: AOJu0Yx60aS47IevCNObc7t+jwWaNFW/A2Ye20vR6nWOhUQbUnV6nsH4
	GV7IdkRwOkwaImDt3PQPFuBzFJQ5uO5hqf8q/bLNaATMl1XPCZrqQJd/mE3vUS11I1JVwziSNYD
	2pEEh/GOKP6TAgz19IRdOgHXSz7BzPdk/tKL5f++Xu3pt1eVcmhTlWQ==
X-Received: by 2002:a17:906:19d0:b0:a36:71c1:1244 with SMTP id h16-20020a17090619d000b00a3671c11244mr4565208ejd.37.1706812819429;
        Thu, 01 Feb 2024 10:40:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtavPwgfasui9zwW/bxID6sE4aGs2F4byGvh+XKGlKGEYKhoA4nEg3A+zAUHgqKpkQBqYDHg==
X-Received: by 2002:a17:906:19d0:b0:a36:71c1:1244 with SMTP id h16-20020a17090619d000b00a3671c11244mr4565200ejd.37.1706812819182;
        Thu, 01 Feb 2024 10:40:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX+Iu01ep0DjiTWVqQ4kQbq/oX+PQEcqNpfcQoJSe3sblPcoDMSvHROZIpLT2JUf2YAsc4XSmnvXqVPzNwaYnGg4f3u/22WJ3utFqtQ5w9HiIIOfsXZfIEQQFpqFCeAZEITXjOAnSBHwHaHv5aoDDSSDuTqkk2Ey5Eo8m/LzaNdSIwyT9DCC7yWAy5t6M0MBEKO/8AriiWlECnhMDJHIf1pK+k23jMyUSV7WoeErjDYCj4y8tuAcUaQfzhSWzCWZvOkIlyoBJ7YX4/XKpQ=
Received: from [192.168.1.227] (109-81-83-128.rct.o2.cz. [109.81.83.128])
        by smtp.gmail.com with ESMTPSA id lj25-20020a170906f9d900b00a35a3e2b90asm51130ejb.149.2024.02.01.10.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 10:40:18 -0800 (PST)
Message-ID: <48ce5a45-4d95-4d12-83ef-ee7d15bb9773@redhat.com>
Date: Thu, 1 Feb 2024 19:40:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix unaligned access in
 ice_create_lag_recipe
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: Daniel Machon <daniel.machon@microchip.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Dave Ertman <david.m.ertman@intel.com>, intel-wired-lan@lists.osuosl.org
References: <20240131115823.541317-1-mschmidt@redhat.com>
 <Zbo6aIJMckCdObs1@nanopsycho>
 <8c35a3f0-26a2-4bdd-afe1-dcd11fb67405@intel.com>
Content-Language: en-US
From: Michal Schmidt <mschmidt@redhat.com>
In-Reply-To: <8c35a3f0-26a2-4bdd-afe1-dcd11fb67405@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/24 17:59, Alexander Lobakin wrote:
> From: Jiri Pirko <jiri@resnulli.us>
> Date: Wed, 31 Jan 2024 13:17:44 +0100
> 
>> Wed, Jan 31, 2024 at 12:58:23PM CET, mschmidt@redhat.com wrote:
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
>>> index 2a25323105e5..d4848f6fe919 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
>>> @@ -1829,9 +1829,7 @@ static int ice_create_lag_recipe(struct ice_hw *hw, u16 *rid,
>>> 	new_rcp->content.act_ctrl_fwd_priority = prio;
>>> 	new_rcp->content.rid = *rid | ICE_AQ_RECIPE_ID_IS_ROOT;
>>> 	new_rcp->recipe_indx = *rid;
>>> -	bitmap_zero((unsigned long *)new_rcp->recipe_bitmap,
>>> -		    ICE_MAX_NUM_RECIPES);
>>> -	set_bit(*rid, (unsigned long *)new_rcp->recipe_bitmap);
>>> +	put_unaligned_le64(BIT_ULL(*rid), new_rcp->recipe_bitmap);
>>
>> Looks like there might be another incorrect bitmap usage for this in
>> ice_add_sw_recipe(). Care to fix it there as well?
> 
> Those are already fixed in one switchdev series and will be sent to IWL
> soon.
> I believe this patch would also make no sense after it's sent.

Hi Alexander,
When will the series be sent?
The bug causes a kernel panic. Will the series target net.git?
Michal


