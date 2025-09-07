Return-Path: <netdev+bounces-220670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB31B47A69
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 12:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF0C7AB7EC
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7242206BB;
	Sun,  7 Sep 2025 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWQXaP5l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96891DFFC
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239834; cv=none; b=cmfpBf/gD8DjBYI0D50Z1WjN/H62X8pqq0yKNC4Pyyl0oMuOBzORnsqbYFf80WpIPbzEUlP6n7iJqfkdK8whRX9yjH1+ekI6VM4f5g+hrC2Lv8t1A430tutq/jyB/XbinpoO7tDMMQ6i9/z5bggIjGoHDmw4a59g3UtQxnWU/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239834; c=relaxed/simple;
	bh=tJbqCT/dL/pXhTLso1c35Cdt4edlHxMzTZnmNAw7NWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiExJeY2oHoCOcGIi8xA/VEO3bLkRi5sJIQZC2V9MamWqbkEWAOGOOYnuh5ES09uTy4XYQRm+AdlRUNh4n6IFslW40xjWggOUrrSXVJJYb0iwmeK5FSUC4TQM938O+sufDs+pT4bKbda6jeiE6i88Uq0psjpajom8dgFYYiwU+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWQXaP5l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757239831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6DodS/D3il1OZVtt+DLEBRGBvnGB9ItExnL9arzW9Rk=;
	b=YWQXaP5lsk4eDHAT5E6ly3MmVAjePIKxG8SuDAJ8bO9vJOCnnen9VdXMbO+sib7DVvW7fI
	05zgV7HqL0U/gpEaSttzIUpKn7MY1DseNvL5vwh/KAiwXpJDYDm59iYAWeYczXkpU2Zuoq
	CmkA0BywUmckwRNoNx7fQFt69fNKifo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-KtwHmvbjP_yWHucIsJpfGQ-1; Sun, 07 Sep 2025 06:10:28 -0400
X-MC-Unique: KtwHmvbjP_yWHucIsJpfGQ-1
X-Mimecast-MFC-AGG-ID: KtwHmvbjP_yWHucIsJpfGQ_1757239828
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45ddbfd44aaso12588455e9.2
        for <netdev@vger.kernel.org>; Sun, 07 Sep 2025 03:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757239828; x=1757844628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DodS/D3il1OZVtt+DLEBRGBvnGB9ItExnL9arzW9Rk=;
        b=rpTR698rQn1vwTTYd/8H+NAaACTaB3oquG+XBzpxbKzhVAqfUhdfj6IkrmaKHZHnG0
         zWUYMAdQlXNB1zWAvDpCHd9ulhjhX1GiU7mBlkhloGjuR8x1I+YAuVEOUlk0+Yn01u3g
         dZkVvSo6RaP+YDiCCRt56yWWgOsweq7dBAvII2hE0e+1kreInFWvG7nQFjIqY1poAUDh
         0GLkMIc8elW8LR6yOMR1Fm+cXmlzoQYKDAF5d2Qec23lyMOlKP0n000Z2BRunXKZsncF
         GjFDpr5c83ixkLS9ou3L2bRb8zotDos69ODOubP+O7wCkyGvyixO2UZJ3lQT98Irx7hA
         PVyg==
X-Forwarded-Encrypted: i=1; AJvYcCUTjyBbqQ+UFrbCqm5EYhbLZoBN89n3F47QQWc7Qu18bo0+7nA2lUEIy22J/5svwPX/b3qV6To=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97PEBlq4+uTo41H5k+mkqY2sGe4jqZIqJQp2uRxFMyWWGidvl
	B8Y4XFz+i10WhkzUP+Y9Z0jCawDJdwIYM92H4ytZYTpLixAm31wQUWTgSI4De0F+gWHdRk0P5fD
	YkOmscovJGdu/5GjB5xTy0jiylpVScmwRKIjPd5mkYJyidZDhQouZOHAXFg==
X-Gm-Gg: ASbGnctzeYU0buqE+LuvAPTR3CxCu+Lx2XWmW+4geBunrjY4cytFtGo8lzcXhnAPOLs
	R5QcugpzHYBMzkB1JjIf/4MshPEzjGpNameG+oo7wRDOQZkU0YWETcpCOQBp7DXvC6AMwTXI+5N
	sibNFjq1opvJUgajeHPqdlv7PLCtrx4n7dZTFEQYi3cTOt/tKN5qP5UAaKgSdwKgNSxloo/CIQq
	tS4VSFiGIvs3Hole7eAdVarcBKTEYS8z9qQqGnQ2sWPokj30K6r6LbjdjFGkp+lpFpczkIrAg1E
	oaQWUJ1DWNIgWkkGmC9LgSuInl8F8EFzw6czT05txPE=
X-Received: by 2002:a05:600c:a43:b0:45b:81ad:336 with SMTP id 5b1f17b1804b1-45dddea520dmr45649105e9.16.1757239827649;
        Sun, 07 Sep 2025 03:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZwy05Oxnn/uLFEdxO+a3Pq30Y/KFZY8SeGX8oadgdr4naG2NeFsAWZWYI3JBmpwo1ni6luA==
X-Received: by 2002:a05:600c:a43:b0:45b:81ad:336 with SMTP id 5b1f17b1804b1-45dddea520dmr45648895e9.16.1757239827172;
        Sun, 07 Sep 2025 03:10:27 -0700 (PDT)
Received: from [192.168.68.125] ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3db9b973869sm18990381f8f.18.2025.09.07.03.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 03:10:26 -0700 (PDT)
Message-ID: <f566a9c4-af28-4135-bae3-01ea5ad1ba97@redhat.com>
Date: Sun, 7 Sep 2025 13:10:24 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,v3,2/2] i40e: support generic devlink param
 "max_mac_per_vf"
To: Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, przemyslawx.patynowski@intel.com,
 jiri@resnulli.us, netdev@vger.kernel.org, aleksandr.loktionov@intel.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
References: <20250903214305.57724-1-mheib@redhat.com>
 <20250903214305.57724-2-mheib@redhat.com>
 <efb80605-187f-4b80-8ba9-8065d1b9e9d0@intel.com>
 <20250905114642.GA551420@horms.kernel.org>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <20250905114642.GA551420@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/25 2:46 PM, Simon Horman wrote:
> On Wed, Sep 03, 2025 at 03:25:40PM -0700, Jacob Keller wrote:
>>
>>
>> On 9/3/2025 2:43 PM, mheib@redhat.com wrote:
>>> From: Mohammad Heib <mheib@redhat.com>
>>>
>>> Currently the i40e driver enforces its own internally calculated per-VF MAC
>>> filter limit, derived from the number of allocated VFs and available
>>> hardware resources. This limit is not configurable by the administrator,
>>> which makes it difficult to control how many MAC addresses each VF may
>>> use.
>>>
>>> This patch adds support for the new generic devlink runtime parameter
>>> "max_mac_per_vf" which provides administrators with a way to cap the
>>> number of MAC addresses a VF can use:
>>>
>>> - When the parameter is set to 0 (default), the driver continues to use
>>>    its internally calculated limit.
>>>
>>> - When set to a non-zero value, the driver applies this value as a strict
>>>    cap for VFs, overriding the internal calculation.
>>>
>>> Important notes:
>>>
>>> - The configured value is a theoretical maximum. Hardware limits may
>>>    still prevent additional MAC addresses from being added, even if the
>>>    parameter allows it.
>>>
>>> - Since MAC filters are a shared hardware resource across all VFs,
>>>    setting a high value may cause resource contention and starve other
>>>    VFs.
>>>
>>> - This change gives administrators predictable and flexible control over
>>>    VF resource allocation, while still respecting hardware limitations.
>>>
>>> - Previous discussion about this change:
>>>    https://lore.kernel.org/netdev/20250805134042.2604897-2-dhill@redhat.com
>>>    https://lore.kernel.org/netdev/20250823094952.182181-1-mheib@redhat.com
>>>
>>> Signed-off-by: Mohammad Heib <mheib@redhat.com>
>>> ---
>>
>> This version looks good to me. With or without minor nits relating to
>> rate limiting and adding mac_add_max to the untrusted message:
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Thanks, I'm very pleased to see this one coming together.
Me too :L)
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>>> index 081a4526a2f0..6e154a8aa474 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>>> @@ -2935,33 +2935,48 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
>>>   		if (!f)
>>>   			++mac_add_cnt;
>>>   	}
>>> -
>>> -	/* If this VF is not privileged, then we can't add more than a limited
>>> -	 * number of addresses.
>>> +	/* Determine the maximum number of MAC addresses this VF may use.
>>> +	 *
>>> +	 * - For untrusted VFs: use a fixed small limit.
>>> +	 *
>>> +	 * - For trusted VFs: limit is calculated by dividing total MAC
>>> +	 *  filter pool across all VFs/ports.
>>>   	 *
>>> -	 * If this VF is trusted, it can use more resources than untrusted.
>>> -	 * However to ensure that every trusted VF has appropriate number of
>>> -	 * resources, divide whole pool of resources per port and then across
>>> -	 * all VFs.
>>> +	 * - User can override this by devlink param "max_mac_per_vf".
>>> +	 *   If set its value is used as a strict cap for both trusted and
>>> +	 *   untrusted VFs.
>>> +	 *   Note:
>>> +	 *    even when overridden, this is a theoretical maximum; hardware
>>> +	 *    may reject additional MACs if the absolute HW limit is reached.
>>>   	 */
>>
>> Good. I think this is better and allows users to also increase limit for
>> untrusted VFs without requiring them to become fully "trusted" with the
>> all-or-nothing approach. Its more flexible in that regard, and avoids
>> the confusion of the parameter not working because a VF is untrusted.
> 
> +1
> 
>>>   	if (!vf_trusted)
>>>   		mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
>>>   	else
>>>   		mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs, hw->num_ports);
>>>   
>>> +	if (pf->max_mac_per_vf > 0)
>>> +		mac_add_max = pf->max_mac_per_vf;
>>> +
>>
>> Nice, a clean way to edit the maximum without needing too much special
>> casing.
>>
>>>   	/* VF can replace all its filters in one step, in this case mac_add_max
>>>   	 * will be added as active and another mac_add_max will be in
>>>   	 * a to-be-removed state. Account for that.
>>>   	 */
>>>   	if ((i40e_count_active_filters(vsi) + mac_add_cnt) > mac_add_max ||
>>>   	    (i40e_count_all_filters(vsi) + mac_add_cnt) > 2 * mac_add_max) {
>>> +		if (pf->max_mac_per_vf == mac_add_max && mac_add_max > 0) {
>>> +			dev_err(&pf->pdev->dev,
>>> +				"Cannot add more MAC addresses: VF reached its maximum allowed limit (%d)\n",
>>> +				mac_add_max);
>>> +				return -EPERM;
>>> +		}
>>
>> Good, having the specific error message will aid system administrators
>> in debugging.
> 
> Also, +1.
> 
>> One thought I had, which isn't a knock on your code as we did the same
>> before.. should these be rate limited to prevent VF spamming MAC filter
>> adds clogging up the dmesg buffer?
>>
>> Given that we didn't do it before, I think its reasonable to not hold
>> this patch up for such a cleanup.
>>
>>>   		if (!vf_trusted) {
>>>   			dev_err(&pf->pdev->dev,
>>>   				"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
>>>   			return -EPERM;
>>>   		} else {
>>
>> We didn't rate limit it before. I am not sure how fast the VF can
>> actually send messages, so I'm not sure if that change would be required.
>>
>> You could optionally also report the mac_add_max for the untrusted
>> message as well, but I think its fine to leave as-is in that case as well.
> 
> I'm not sure either. I'm more used to rate limits in the datapath,
> where network traffic can result in a log.
> 
> I think that if we want to go down the path you suggest then we should
> look at what other logs fall into the same category: generated by VM admin
> actions. And perhaps start by looking in the i40e driver for such cases.
> 
> Just my 2c worth on this one.
> 
>>
>>>   			dev_err(&pf->pdev->dev,
>>> -				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
>>> +				"Cannot add more MAC addresses: trusted VF reached its maximum allowed limit (%d)\n",
>>> +				mac_add_max);
>>>   			return -EPERM;
>>>   		}
>>>   	}
>>
> 
> 
> 

Thank you, Jacob, Simon, and Aleksandr, for reviewing this. I really 
appreciate your time.


