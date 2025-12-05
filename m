Return-Path: <netdev+bounces-243872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C559CCA9114
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 20:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5638D31CA88D
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 19:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B01134D91C;
	Fri,  5 Dec 2025 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dUfStDec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1E52D73B2
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764961514; cv=none; b=nrGTLe61Xm4TyV80CIWHFAbFZAshYaSOcOTZb8MdUfzcUk81o6AQ8Q8lsl9U/JjAlSRqFAxus9BL27UqwzWOSTLUCI0TijG29AFyEJ+XTetF7iCcDlaC4gsksbB7T5kvdNKy/ytG3MRafBwa5b2BpO+7fRkbPZADkMzoiln8Rxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764961514; c=relaxed/simple;
	bh=CLD1baVuz0aPlkZ9/npCREzBxjQuD75wSRnWmSzVU1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nhdye6SaWGzs5/x05PwD49507g4GjeC0h8n4VFYXYOQVbT3HuVK9bT2yHfNp2jEXVbj+P15NUrMPXBVF2MR1jMl1kY6FnFnEFCR9q5MSQ2olkjcss4EXu077k7I2Pxk8sRfNDR2cQ0VdZvwZQLsK2mv5wFHcLXWd4pILqivGKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dUfStDec; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so2979551b3a.1
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 11:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764961511; x=1765566311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kfKtWFj0h7AG19WLVu+MIuy9f6wSoSxNprszwsHw4lE=;
        b=dUfStDecnEgGIPHwwfCnVUKz97CHnULBEl/QXhZf9Ek7td/WfnbPZFezrdoo36fSi9
         5BXvqY9KstC0CAlw0jR6x8bNW/Q5C6+Z3m+xGTtth12jSxDLanjgVp+bSE4/jcG9A89k
         SHYAulBWa1FcnptiD7IMWILrR+pzqazxx4AgYEkoTDZFGnOuVthZ7Azt/+fajlstr0wP
         +CCZGa+jg3pVaDQ+E4RxSEEDK3xwJ/PWmkpiv01g6UYIhrYE4dh6siqeeMveC+UcuYJ/
         EX/mg9xowI6bwwxiywMd1BgDRVGw1SEBuU3S3ppWAwNxY2+bV/zWgpotpIIV/q01j1Wf
         VS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764961511; x=1765566311;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfKtWFj0h7AG19WLVu+MIuy9f6wSoSxNprszwsHw4lE=;
        b=Y17daVLCK2iNg9SB10PObP1mlF1ESTfVKBCwsd90nfuarxpY+wa+l5NdI3OC4nvB5l
         ciBQxAjCXpevk6b/CJH7oDD0zxBGvhbj+4AZX38O1Jn0W6KXUUwPhGWDMd84LrRTTNIl
         OvGGjqDTNxlR1P5sQatqi3VnrHYQemJWj2fjtNkKnVYG7qO0CCS/ndAEp0HlJJmdqTxh
         R4UjdM0SNxV3DoPKdgWnX3Q/NUgyopcXIy5FID3QMEm+z7tlHl3jRVnu/o2dZZYKgMxC
         eiBBGUa/awcwAuHPyBtMjH6qVBA4kQh9t1pnjdOc57wYPA0nmUFS+Gaj+YtlAoqFN7au
         8Xvw==
X-Forwarded-Encrypted: i=1; AJvYcCXlUCq5YWkv91UKXyFlbueksYwnAUwIEmQ5+LqPln11+NI08kTQ2B35794MWtEnHScl9CPOEZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8HsHieQXla6WgUbSLsvrOl4VStFQ97brkKXPLVoSjIvB82gz
	IowYwzXrt2MOSmjFTogTLu+t661+eSw+Pqa4Fmkn2NUz4BVmMQiPjWzq+jbRfx4RCYQ=
X-Gm-Gg: ASbGnctbDMPA5dltBfY8Q5UNsSJKTWSLwJ4Egml4DBQj8JqitMzVHt0g/7duCYTtYNj
	5Wu1iY4qdMHBU0W1sDV3hFVeCgp4Ed1jrSAWOfbqfT4d3knMKchFti35IAyfSwJYx4e2fZ8h+IM
	Czp5NydF3AEAiojmB8KYFWPxmhhQdNvigq7bIJMCQs80+5WLbXGD1ZbMdYjIzV62inpkE3mD6wM
	ugBY5mjW4f+I7Al4ffFaAE+EovKSeM8RRCpxH0kpB8ULSCXAEpa7V3Uyx1gGICBJQa8p3IxOdn3
	euPIpRm42LeOHAnytBEqt6aMWMsMnlf8yItQodZaBwRXDaOU++r7/AhguAKADkM5Pg+6P1TeVSy
	FGKrhuqrlQGw4kefj4CgINDmQIH8+gTv0eZAykMeEH+VsyeGZ1ucxQyzW8NNVY/dzvOLpUay+Of
	MT2hDgjH0OXZshrjyvychoE/73
X-Google-Smtp-Source: AGHT+IFfFzVs0sM1jEuOstiWTaR8h34ot20r+QUvf9mPWY8T0+Eh61GtJBFRPqo38eLmH0QVT7Pdig==
X-Received: by 2002:a05:6a00:181f:b0:7a2:710d:43e7 with SMTP id d2e1a72fcca58-7e8c1a39444mr196640b3a.24.1764961511062;
        Fri, 05 Dec 2025 11:05:11 -0800 (PST)
Received: from [100.96.46.103] ([104.28.205.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2afa31e9fsm5970056b3a.68.2025.12.05.11.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 11:05:10 -0800 (PST)
Message-ID: <d6dcd835-7564-481a-a854-25b187893e6c@cloudflare.com>
Date: Fri, 5 Dec 2025 11:05:08 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v1] ice: stop counting UDP csum
 mismatch as rx_errors
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 IWL <intel-wired-lan@lists.osuosl.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20251201233853.15579-1-jbrandeb@kernel.org>
 <IA3PR11MB8986697A94FB36E893C7E87FE5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Autocrypt: addr=jbrandeburg@cloudflare.com; keydata=
 xjMEZs5VGxYJKwYBBAHaRw8BAQdAUXN66Fq6fDRHlu6zZLTPwJ/h0HAPFdy8PYYCdZZ3wfjN
 LUplc3NlIEJyYW5kZWJ1cmcgPGpicmFuZGVidXJnQGNsb3VkZmxhcmUuY29tPsKZBBMWCgBB
 FiEEbDWZ8Owh8iVtmZ5hwWdFDvX9eL8FAmbOVRsCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsC
 BBYCAwECHgcCF4AACgkQwWdFDvX9eL/S7QD7BVW5aabfPjCwaGfLU2si1OkRh2lOHeWx7cvG
 fGUD3CUBAIYDDglURDpWnxWcN34nE2IHAnowjBpGnjG1ffX+h4UFzjgEZs5VGxIKKwYBBAGX
 VQEFAQEHQBkrBJLpr10LX+sBL/etoqvy2ZsqJ1JO2yXv+q4nTKJWAwEIB8J+BBgWCgAmFiEE
 bDWZ8Owh8iVtmZ5hwWdFDvX9eL8FAmbOVRsCGwwFCQWjmoAACgkQwWdFDvX9eL8blgEA4ZKn
 npEoWmyR8uBK44T3f3D4sVs0Fmt3kFKp8m6qoocBANIyEYnUUfsJFtHh+5ItB/IUk67vuEXg
 snWjdbYM6ZwN
In-Reply-To: <IA3PR11MB8986697A94FB36E893C7E87FE5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/25 12:26 AM, Loktionov, Aleksandr wrote:
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
>> b/drivers/net/ethernet/intel/ice/ice_main.c
>> index 86f5859e88ef..d004acfa0f36 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -6995,7 +6995,6 @@ void ice_update_vsi_stats(struct ice_vsi *vsi)
>>   		cur_ns->rx_errors = pf->stats.crc_errors +
>>   				    pf->stats.illegal_bytes +
>>   				    pf->stats.rx_undersize +
>> -				    pf->hw_csum_rx_error +
> 
> Good day , Jesse
> It looks like you remove the single place where the ' hw_csum_rx_error' var is being really used.
> What about removing it's declaration and calculation then?

Hi Aleks! That's not true, however, as the stat is incremented in 
receive path and shown in ethtool -S. I think it is incredibly valuable 
to have in the ethtool stats that the hardware is "not offloading" a 
checksum. As well, all the other drivers in the high-speed Ethernet 
category have a similar counter.

I hope you'll agree it's still useful?

