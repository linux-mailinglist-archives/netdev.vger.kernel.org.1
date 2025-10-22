Return-Path: <netdev+bounces-231600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DDEBFB316
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 548EE4E445E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A62D0C63;
	Wed, 22 Oct 2025 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRePhIDS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB24298CC0
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125954; cv=none; b=VEVrpnXnZeTmZoigz4xBgoDYfNElmdW9u4I9jVkfeU9gx7pkDsStuZXP3M1Zppc5mNGi5E+Wfs1EmsifoxyKGvPetT1DF6O6tVbBknOtju9c2RqlyaVJ1q5FgiT9smmTB4RIsPpG023dhsiNJjzengYMBNBmMdZY9Twes5sS+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125954; c=relaxed/simple;
	bh=UZ0OPkGP8yNVJlDHumkQcuasIKQr+bwGLQCUf7u5PAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6lpfvN4p+aIvrPLzU+Y0OJCbsuIatqEDvVVEnmfO16w0+xixWjm0lTgPKCBDu6EKJKsPLNzK+LU0+rYba8izEAX6hE7aS0HdRKTMyGf0hotZcMtlAyqNcHXbHGVX+kJGHmMwvCxN7ur/zrJz9kumuZ7RkO/g2PhUt6abXs9ouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRePhIDS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761125952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuYmiOLCaPZRj40EIc99HdJ/xOeorodHm2jhiotawYQ=;
	b=dRePhIDSGb6E4K2W29vvLfCsyocAp1bR7KN6/ImCMY6UL7BN85ooRJj8hk8mQshxJkgiIX
	P2MrB2ygvLJUlAaotbfB/S4CjR10EWiAAOOE46CFkXkf1bpJw38OKQRn4d4PX8CFXRckUQ
	uKkMjSapvX93m6X1aHXXp+95QpzL1fs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-JfGlX4O8NZ60j4G1FRi6dA-1; Wed, 22 Oct 2025 05:39:10 -0400
X-MC-Unique: JfGlX4O8NZ60j4G1FRi6dA-1
X-Mimecast-MFC-AGG-ID: JfGlX4O8NZ60j4G1FRi6dA_1761125949
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4256fae4b46so4728386f8f.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 02:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761125949; x=1761730749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuYmiOLCaPZRj40EIc99HdJ/xOeorodHm2jhiotawYQ=;
        b=BMfaXRbRik83Ms8LykAGEybPuEC9piSX95xrKi0hJrey9oU1k3g4Fvo7pX2yJbI7sN
         Yq1KWl6wb91lHvADiZBSSV++ci1oBbeHvV4dO+1ecwS3KdJ5QtLgwKdgbuEoL2EvNg1H
         8bhxQl1sTx2M/w9qFf0arIWp37XMvkSMDA1N9QiVPyUPtcrg0Kj2VNgjWeZfyg9c3mPY
         ebRp/6xKvDrQ6hKT8vTH9QfmK2nqipTQJeMdGIdvjNM3XRUfuZhHkxT1R63tnNBInY+W
         ti6IeJtATYCVEpnSZ9lAzQ5u/KRmgV6SjOdPH1yVgzCff7E10G0OLvEgCX5+x4DfIwzM
         ogIg==
X-Forwarded-Encrypted: i=1; AJvYcCXFMjymvH9USkoUJ9rgQqGvbElfanuRMUpXRw2INvZtoJDaJInVbKgnZbXhKOj1DDNls1Ih/cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjfvyQhNVvKYWLy3iBqQ0UW16kY2xCPN9ZdBpwuwh98xsBpKdW
	s0OTvwMZusVxdekTxj5YDUeN2LN6j/nY/nXPJNNJl9O+eu23Ea/pdELImU5PhnrG75Jg0jSI+f4
	IxYu1l3DHFxD11Q0+WO7M1HuO+Z/xqGMIeU8un3FfwvSUzBL/VxY98L0tHA==
X-Gm-Gg: ASbGncv2UcAUAHIKHpvZoFlVRwU0hGeFSf7ExpA/5QYJ8wFXNmkauGn8jddcciYzkRx
	h60qZttf4H+ND2YoKX44fMf+2nyFOkPx35wv8qEon1owZV6rUisZOOSG3RtqA34VbHFE1txDSOP
	w7FNbaReJbGTKZv+xL/QDTgt5mow5e1mOL1+8lL5CmLI6y7UjZfjyVYp/Z37QZPVHa6gdONrhWc
	9SGZUFlzOQC48JhWal7BmVeULKmWDVeozzPTH73Bo4lqiMo49L4FgzW+GEXCcEFno2GbwD1oCyp
	Zyyk2gMckXCsAc8bGwNaul03ee1wQz1UtVl3FW4kg/frtg2YmScSAcYVkjymtYTfuIQFEVKAzFz
	aKBoB4lEzUd+jVkvfLBzdRxRU99G1g9r9qLpG
X-Received: by 2002:a05:6000:2911:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-42704db22camr15953043f8f.44.1761125949408;
        Wed, 22 Oct 2025 02:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/aOryQn5sy8rYEtqe6i7g3LA3GyVmEJjSxmfNQPD4o765qZMFTbY8a7U8TNz9fPJlo12+lA==
X-Received: by 2002:a05:6000:2911:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-42704db22camr15953008f8f.44.1761125948937;
        Wed, 22 Oct 2025 02:39:08 -0700 (PDT)
Received: from [192.168.68.125] (bzq-79-177-149-47.red.bezeqint.net. [79.177.149.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a1505sm24495428f8f.8.2025.10.22.02.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:39:08 -0700 (PDT)
Message-ID: <075914db-d497-4428-97e2-256b35f40729@redhat.com>
Date: Wed, 22 Oct 2025 12:39:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/14] i40e: support generic devlink param
 "max_mac_per_vf"
To: Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
 <20251016-jk-iwl-next-2025-10-15-v2-2-ff3a390d9fc6@intel.com>
 <20251020182515.457ad11c@kernel.org>
 <d39fc2bd-56bf-4c5b-99a2-398433238220@intel.com>
 <20251021160745.7ff31970@kernel.org>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <20251021160745.7ff31970@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Thank you for the review.

As Jacob Keller mentioned, this change enforces that a VF can never go 
above the maximum allowed value. However, there could still be other 
hardware-related restrictions.

Regarding the scenario you described, if the maximum is decreased to 2 
after VF1 has already added 4 filters, then the next time the user tries 
to add a new MAC address to VF1 (or to any VF that already has 2 or more 
MAC filters), they will see an error message in the kernel log:
  "Cannot add more MAC addresses: VF reached its maximum allowed limit 2"

I didn’t really consider the decreasing scenario, since this change is 
intended to be configured by the system administrator once, before 
setting up the VFs. If for some reason they decide to reduce the limit 
during the VF’s lifetime, I believe it’s the user’s responsibility to 
first remove the old MAC addresses and filters from the VF.


On 10/22/25 2:07 AM, Jakub Kicinski wrote:
> On Tue, 21 Oct 2025 13:39:27 -0700 Jacob Keller wrote:
>> On 10/20/2025 6:25 PM, Jakub Kicinski wrote:
>>> On Thu, 16 Oct 2025 23:08:31 -0700 Jacob Keller wrote:
>>>> - The configured value is a theoretical maximum. Hardware limits may
>>>>    still prevent additional MAC addresses from being added, even if the
>>>>    parameter allows it.
>>>
>>> Is "administrative policy" better than "theoretical max" ?
>>
>> That could be a bit more accurate.
>>
>>> Also -- should we be scanning the existing state to check if some VM
>>> hasn't violated the new setting and error or at least return a extack
>>> to the user to warn that the policy is not currently adhered to?
>>
>> My understanding here is that this enforces the VF to never go *above*
>> this value, but its possible some other hardware restriction (i.e. out
>> of filters) could prevent a VF from adding more filters even if the
>> value is set higher.
>>
>> Basically, this sets the maximum allowed number of filters, but doesn't
>> guarantee that many filters are actually available, at least on X710
>> where filters are a shared resource and we do not have a good mechanism
>> to coordinate across PFs to confirm how many have been made available or
>> reserved already. (Until firmware rejects adding a filter because
>> resources are capped)
>>
>> Thus, I don't think we need to scan to check anything here. VFs should
>> be unable to exceed this limit, and thats checked on filter add.
> 
> Sorry, just to be clear -- this comment is independent on the comment
> about "policy" vs "theoretical".
> 
> What if:
>   - max is set to 4
>   - VF 1 adds 4 filters
>   - (some time later) user asks to decrease max to 2
> 
> The devlink param is CMODE_RUNTIME so I'm assuming it can be tweaked
> at any point in time.
> 
> We probably don't want to prevent lowering the max as admin has no way
> to flush the filters. Either we don't let the knob be turned when SRIOV
> is enabled or we should warn if some VF has more filters than the new
> max?
> 


