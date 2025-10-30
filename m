Return-Path: <netdev+bounces-234228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91152C1DFE0
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83AD94E391B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845DF23EAAB;
	Thu, 30 Oct 2025 01:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="z2f2jBD4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4FD167272
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786586; cv=none; b=an/JpILxCOJYNqNI57lAcGqj+unZv+0FkiTLG39kiqOhanAPHYF1MejvMnDw2S3EzeWObI8DPoRj9dNlI70hKftDVUPpBMc8/SxARXxCVn602YUKiqxnNABhxvwlajPVXgtYavIAxM5RN6Ol21izNDPKXhdb269k315othHGJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786586; c=relaxed/simple;
	bh=ApnOkJTeJN9SwzhlYumtmdrp3M8VXnBslYV22QHPqOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FABZZ7u8Wig/JgihMPt4gNh0JqR6PBWlVyXDZ45bW5MDhTlkvT8KHQReUN5gyg916N0PQYS7THo7wgHewI0b7C3ss6Ast/lngzjXcPKa/trqinF+bl+mx7a+z4Yh5HD92kequR7HXTTk0IY1BUsrI+MoSWClwDbZUrXSfZHA7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=z2f2jBD4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso487853b3a.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 18:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761786584; x=1762391384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DC56w2Gnej1UzyVks0PmY05Z5Cx6PU+WnketIZWknXg=;
        b=z2f2jBD4I/5+zy0HmTq+Umo3aJ5owX1dantBSS41lSwsgjvMLZlyIEF/LcrY3Yf3hv
         9JhbzzQ0Is9zyvmwRdipAylDoJWizWbnd9REiFnzGOBp2S1iAdTOWLJQs+NI6FzqwBOb
         qMhKIH5Y56pdBWzgGKb8JaHqNR/diPgno/xdDMJ61i4b84wY6VpLdUeyWF7RtyMoIRxD
         PYMuFYvjgd9OLFXSkBz1ZUXXjtIL/e0MlmEeEqhp3BJhjoFNIYLOUjZLwe1heIjTfhzg
         r2D0EEZQfWveIgQ1qiNnaawWy9Mc0HkFRp9gsSjS/jxSYomKHRc/YqjWGwakrfjI2kbc
         cVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761786584; x=1762391384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC56w2Gnej1UzyVks0PmY05Z5Cx6PU+WnketIZWknXg=;
        b=RC8LggfnbEvQI+feGVAPJkwUeKtJ484Zn00FUtn+Z40GIyYyhZ9QPKOy3KqoNFMhir
         3weHbfaZakFg2SETvIda82pi0jWUj3PnEa7SiU9oKMgKk5OIh8owJ7LMQtHoG7SKDl2E
         IgS98CoeYt75lt3aTjOFeS7n9xw5sC94VFG88/eBfOd+pxcNWw62p0a5dfTHrDOmGZ/D
         rvDCGRqTGmk6fFBXjXPEW1eyc1e/z7Fy+vmWzmR5lq5Q8Oxv8UnA5svQBdIJe3Jw3/Ld
         bEmRKgv31iSeZLY5NbYMKR+S6DURJEOMDRLZFTiU40XJUqCbTLGsHzP/VA8s0mBHi9pF
         q+7A==
X-Forwarded-Encrypted: i=1; AJvYcCVuVMHGVJmHELJHrbh0sAXInorTEtQieWnLSfLOTVpGwmMLcTFdGQqioM1K5eBRBHqTKte/rqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuR+4d4XrOSZ8uVYU155l8DcnDLeyIzIFVHo1EavxwJprbwYWk
	eirb/WuDrmvFxLLT2U8PPctke6EjM2O6sBGe25RFUuepfyHIpXP73JNKQ+na0AVPbN0=
X-Gm-Gg: ASbGncsQx9iWb9CGsECAvh6/T9xP/+DMbNLdxmrCnW8/HutqWgBTRkdPeS5vz919J82
	5U1vRchKeLq65sbIzz9ZTBNyXDyBk7dI7IBNAazpo9PrB6r77kiEJngltWgitYRA0oE9RRih1oJ
	+RcP+V10bKI5nRkNt6HSV0xdyXN1nYtNtKnlqaxkLfuI01v7oVB+hKehC45b5vpCsbzuV7o6KCX
	reHa6zvN45cQTtZyBilsqrr3/v1ZKasjapiZg1EVBSDv1XDO5Cl9qHc4a6tjNTUnTnO9qtLdpPd
	TB5lBdjMzYgoqy0nGacQEEPZaAm5jZ18+ouwS/+dHHNHo8faGTKwpXnFSLq5h7gXIyT+Xq+D6/7
	rfeMyshz5eYhrpJSr/OsDb+Hh8NUL+nzaxaMQeaziYAKMIAVtj/2QuVmmHK5SMLD3u53V0Ntb7K
	79zNwGgAGSdK7o2g/NOGLeD7haEd2y066OOxRXbOU=
X-Google-Smtp-Source: AGHT+IEN/s9i5GxqInOBrLtzfbTyORHeB8Hnnm6Zak2Au/a4QkVkLO7E1FgOwxV4cDeipVhcZPrLGA==
X-Received: by 2002:a05:6a00:84f:b0:77f:2b7d:edf1 with SMTP id d2e1a72fcca58-7a4e4e12a29mr5503622b3a.16.1761786584366;
        Wed, 29 Oct 2025 18:09:44 -0700 (PDT)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012d02sm17086192b3a.4.2025.10.29.18.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 18:09:44 -0700 (PDT)
Message-ID: <839bc664-0e4b-4e70-9a9e-6f0c4c896d9e@davidwei.uk>
Date: Wed, 29 Oct 2025 18:09:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net: io_uring/zcrx: call
 netdev_queue_get_dma_dev() under instance lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20251029231654.1156874-1-dw@davidwei.uk>
 <20251029231654.1156874-3-dw@davidwei.uk>
 <20251029165457.557f8f7d@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251029165457.557f8f7d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-29 16:54, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 16:16:54 -0700 David Wei wrote:
>> +	ifq->netdev = netdev_get_by_index_lock(current->nsproxy->net_ns, reg.if_idx);
>>   	if (!ifq->netdev) {
>>   		ret = -ENODEV;
>> -		goto err;
>> +		goto netdev_unlock;
>>   	}
>>   
>>   	ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, reg.if_rxq);
>>   	if (!ifq->dev) {
>>   		ret = -EOPNOTSUPP;
>> -		goto err;
>> +		goto netdev_unlock;
>>   	}
>> +	netdev_hold(ifq->netdev, &ifq->netdev_tracker, GFP_KERNEL);
>>   	get_device(ifq->dev);
>>   
>>   	ret = io_zcrx_create_area(ifq, &area);
>>   	if (ret)
>> -		goto err;
>> +		goto netdev_unlock;
> 
> Without looking at larger context this looks sus.
> You're jumping to the same label before and after you took the ref on
> the netdev..

Sorry you're right, and actually io_zcrx_ifq_free() does netdev_put()
unconditionally. I'll correct this in v3.

