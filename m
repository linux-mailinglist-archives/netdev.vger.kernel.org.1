Return-Path: <netdev+bounces-201513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3BAE9A0E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 408CF7ACD13
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E473929C344;
	Thu, 26 Jun 2025 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XypsRnvl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F91F218AB4
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930272; cv=none; b=pSTa2ruwe/8a21BG1A92ycgSyWfVNrv5gPZE+KbTPjM7PQx65wjtZtcAdaRMmOCfhD0gFhl+jBVFoU8HNDDC3lQaZrh1YltOKvg2SGDeeTVXz3VQOwOz86/AYeskUTVSv6EQAZliQyVNHLo6vlTsThTSjvazQC/wIHh70kM9Eyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930272; c=relaxed/simple;
	bh=iV6sZecp/0ekGFb8aiEiBDamNCmKsCvEA/oF3WhwGx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNOvkNKS+M4bFq5odF9oBKRotu3MWwHpGdPZMXbpyE/vLv4vPahtnarK5+WddXPLMnwMCuhae7HGrauABYGnLMx2ZGMTw2mhYtz/+aJRexb2YxAF9qYnb3o++exk6avKjR5a/sTPtQjfoi0iA995fR2WExPN+X7ToR2O8IfVJto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XypsRnvl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750930270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgNUE+XzivfXoCyzCi7KHp3ehpyfWekDKWAzGfVAe2I=;
	b=XypsRnvla56yBjossezeCdPoEqwoqMDNj68hKUgCLtApbaYWEGQv2nM6B1mgVIFId7g/PC
	/ZSxI2BfakmPGHpvmdGyXxHIU47xh7e0xh8PF4XygL8l57d+FXqXPUyhZpOepRDwppeJwD
	SDreU/frJHilLUvfwb5Hkds/ojF0fFM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-zGPiq5ncMLmEf1petWCDQw-1; Thu, 26 Jun 2025 05:31:08 -0400
X-MC-Unique: zGPiq5ncMLmEf1petWCDQw-1
X-Mimecast-MFC-AGG-ID: zGPiq5ncMLmEf1petWCDQw_1750930267
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so3928465e9.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 02:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750930267; x=1751535067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgNUE+XzivfXoCyzCi7KHp3ehpyfWekDKWAzGfVAe2I=;
        b=ONMXxA3LxR2W4i1l3lSf7vJE7JXxwKJsYVS4wgE3MmMX6xN2n2KJGjE7T6HsR5uqyt
         iTJ5zJ1PgyVvEQmClKrxyjuSan9iishnS5SL97wy2LgHoTb87MFhnZTENf0AbRUQrNHC
         ztLSY8qXkG0/2l+jSgEBkajed8tLMPb2eUugbevBO4lWggzD5GLA//Ni6IvaImR93EOj
         IctC6K4etKBr8RzS3Xt1Z+GaHDSPFFIbBRNpHo7vD7P1YwAFQjfVBJXUGnkej9IbfKi9
         Jl/mxzt/F+A3ZVRKjai1S7BDSA5GGZDGszTsTX2CcslFvD1RY3TKeQbW22T9HlWFe4G0
         YAZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1ajCseXbGufX50yamUmxyFLSCxerfMfAMiFw/5JKeY7GK4WW+0jYFcoHFFpf0Z3fKSgITlFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycjO4xkNOxFvSF2q/UPBWrr49XydGKymeb3IIzTQcb2biiwBTs
	0HlSyyxK/MZFjbvFB/GvLtvOZP8S5aM2j3QH0uR2trf/UkhbA9Rc4E01c0s2FhoGV88uswtQSkS
	cnbPbOWWbj4ZsV2xVs2zsq0w4VEik0x7t4ZishkZsiOc9X8KOdLPK3F+42A==
X-Gm-Gg: ASbGncva5FBwKzt01dJ3I0rtUBtx2KVBHSsmcp5Vr0dV7nuSN5YEH4OhOvzcWrC94vc
	KrfvpV3jIqECxh1BkL+6lD8lws5vs9rpVJ0iq99KUIKzMQ0pyVqxvCP6rYesB9ZywYd7fTHavGu
	iX7O4MD9V/IvYJmCiuFxGx95Ejx0FPC65kJNRl9SPq81EoYOPPPljMDx4SG3WSsqQaXffCuADw5
	/4wHKARmKyH+0bhPHRU/0W+9Npjfzq+MUWIm9L/zX8DdSoodQpZsiad1LGcDo0fRU9AnxJYcAvN
	efHe/mOn4GqRnp1mT1KdUGTZgs6UYa8eupV997FtfxFAoh+caoEimjvviLm7EmFvaUSqlw==
X-Received: by 2002:a05:600c:3b03:b0:450:d367:c385 with SMTP id 5b1f17b1804b1-45381af6a8fmr68716305e9.16.1750930267148;
        Thu, 26 Jun 2025 02:31:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgfmk2x3IGT4lfFfPj29nqAbQAOK8g0wuOO6mRNZ2Gy9Qr0EEdkOBTfnWk8apILg5ZGN1W9A==
X-Received: by 2002:a05:600c:3b03:b0:450:d367:c385 with SMTP id 5b1f17b1804b1-45381af6a8fmr68715815e9.16.1750930266654;
        Thu, 26 Jun 2025 02:31:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:bd10:2bd0:124a:622c:badb? ([2a0d:3344:244f:bd10:2bd0:124a:622c:badb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453814ae64fsm31617725e9.1.2025.06.26.02.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 02:31:06 -0700 (PDT)
Message-ID: <7a25c9c4-610c-4e93-8855-1ec335cd2b64@redhat.com>
Date: Thu, 26 Jun 2025 11:31:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] rose: fix dangling neighbour pointers in
 rose_rt_device_down()
To: Kohei Enju <enjuk@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kohei.enju@gmail.com, kuba@kernel.org, kuniyu@google.com,
 linux-hams@vger.kernel.org, mingo@kernel.org, netdev@vger.kernel.org,
 syzbot+e04e2c007ba2c80476cb@syzkaller.appspotmail.com, tglx@linutronix.de
References: <20250625095005.66148-2-enjuk@amazon.com>
 <20250625133911.29344-1-enjuk@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250625133911.29344-1-enjuk@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/25 3:38 PM, Kohei Enju wrote:
>> Message-ID: <20250625095005.66148-2-enjuk@amazon.com> (raw)
>>
>> There are two bugs in rose_rt_device_down() that can lead to
>> use-after-free:
>>
>> 1. The loop bound `t->count` is modified within the loop, which can
>>    cause the loop to terminate early and miss some entries.
>>
>> 2. When removing an entry from the neighbour array, the subsequent entries
>>    are moved up to fill the gap, but the loop index `i` is still
>>    incremented, causing the next entry to be skipped.
>>
>> For example, if a node has three neighbours (A, B, A) and A is being
>> removed:
>> - 1st iteration (i=0): A is removed, array becomes (B, A, A), count=2
>> - 2nd iteration (i=1): We now check A instead of B, skipping B entirely
>> - 3rd iteration (i=2): Loop terminates early due to count=2
>>
>> This leaves the second A in the array with count=2, but the rose_neigh
>> structure has been freed. Accessing code assumes that the first `count`
>> entries are valid pointers, causing a use-after-free when it accesses
>> the dangling pointer.
> 
> (Resending because I forgot to cite the patch, please ignore the former 
> reply from me. Sorry for messing up.)

This resend was not needed.

> 
> The example ([Senario2] below) in the commit message was incorrect. 

Please send an updated version of the patch including the correct
description in the commit message.

[...]
>> @@ -497,22 +497,14 @@ void rose_rt_device_down(struct net_device *dev)
>>  			t         = rose_node;
>>  			rose_node = rose_node->next;
>>  
>> -			for (i = 0; i < t->count; i++) {
>> +			for (i = t->count - 1; i >= 0; i--) {
>>  				if (t->neighbour[i] != s)
>>  					continue;
>>  
>>  				t->count--;
>>  
>> -				switch (i) {
>> -				case 0:
>> -					t->neighbour[0] = t->neighbour[1];
>> -					fallthrough;
>> -				case 1:
>> -					t->neighbour[1] = t->neighbour[2];
>> -					break;
>> -				case 2:
>> -					break;
>> -				}
>> +				for (j = i; j < t->count; j++)
>> +					t->neighbour[j] = t->neighbour[j + 1];

You can possibly use memmove() here instead of adding another loop.

/P


