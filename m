Return-Path: <netdev+bounces-243181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC774C9AE9B
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 10:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2C9D4E3FE7
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 09:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E8030C359;
	Tue,  2 Dec 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2YRMeqc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZoM5yYaT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083E530DD18
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668356; cv=none; b=kHAO7hmgDiL0JILQI+G0GzrqtR8kEYJFNIE5C0IIxssWt6yOIYAjO0DcINlnR/JoO1jOLIwle5Mp82UoLjKhISA8b8qgUsIJ1qZ2Flcgqk53gzLqT6qpkDwd5pZd5B07bcd7ioT7aZbN2j9u3/Q+Jyy05xMSNbJlYusMhpxNFhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668356; c=relaxed/simple;
	bh=fh/Jj35tkhjEYdxNP2DeGwH8posCscq1/yAsepR1Gn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMugFGF7fProlg6hgepb0+f9IzupGvmCVG4ZS7rp8jGfLJcFa1YJowSx3ZbE4pQsciwNBUXWi5iLHMdPf36gl+47IeZlfcRfgfKb23+be/cOPCtojkaU7+dV3Y653Cr2MBfvQA8upQaD5C3bRMu0MuUC1JzqZ4Ty4aXB8mdyGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2YRMeqc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZoM5yYaT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764668353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7PMkBJ3jqGuxhzGxj8q5ujXEQJkMs5T+aOdk2vs/fKM=;
	b=Q2YRMeqcb2BExPOcBJsaNKX1Tat50zS52TS1JsUUxgxOq+hrVtZLX8kGML286GmFuZwuNt
	cbKJospRYzWh5OiXK1bfVgT4K/NMHQxKz7QNGLJhlzWo25LW9HMHznCr0o2kGoEyEKVeOs
	PrSDnIFv/wOqY1QT/KZzg1+YQcxFPKA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-x1gxPLocNta-KXYdgIXivQ-1; Tue, 02 Dec 2025 04:39:12 -0500
X-MC-Unique: x1gxPLocNta-KXYdgIXivQ-1
X-Mimecast-MFC-AGG-ID: x1gxPLocNta-KXYdgIXivQ_1764668352
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-78a930d7fb2so65498517b3.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 01:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764668351; x=1765273151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PMkBJ3jqGuxhzGxj8q5ujXEQJkMs5T+aOdk2vs/fKM=;
        b=ZoM5yYaTVlXW3xlTy/HJ6dMEwm6+lxXBWnoF9nMmCL8A5/FWIPPsMCVzlBaDeIuaiU
         Cc0WEbI0su+hfFh+7X4IUZm4EHbZ0f+YMRT9s689GMpAyb3Cxta1V/C7TtOa1Kh2lvM1
         +lEdVV/u0SBM6zohyDJMAupRFyEvAQDEtLfL4BqlEAAr61vxPkMhJB+4qoI72ge0ZLU/
         8zVFGHBv7yPwlUyBagxfHcGznJAZF24bC9ZZPdmYmd/XoUa0Fqfp5EL33HM7cixH9+ve
         wP8qBiDsPpZKCq+Dz6BfX/QQl9+FgCxie9diR6sr7uqdoliIQy2pVYQK8aA8MAUDeAG3
         9A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668351; x=1765273151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PMkBJ3jqGuxhzGxj8q5ujXEQJkMs5T+aOdk2vs/fKM=;
        b=kWKGuko/241gqYNlw3JVpuQHva26RrKebP4vE6UAK+3wgrXtjBK+ngqIF9sG3jhfyu
         09zkrJ/DpVrC60dY+/F+dfSp/YMLWJxlMiXQ7JNl6iKOYIIALuUuQQqZHGEfWUrW8qo7
         5JiTquMZXgA8bZIJ4Z5kMFHlPozUWKbT4SODpCeA4YZDSUY0//ny2+ksDfOKWHvpnV81
         he/Herp1KIBNAwI5imrjSMBnnZONkyuTKN6itfdzkU3MzX0TYL0j7bcu3qNw1GyAUZUI
         kLWIhN1xJyxAIrd3+UOLLvjSzqu1T30Tf091EQjkxwRh7C1X344rVLZoQAhy4rA2Olgz
         fi4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhrjz0fjYRcHdQu/SCE4vtn5nNWHKkMaBUR5lHOgVxR5nLF+wmxMX3Q92WM0lErJwD9z/6F4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05CaU+YaeDEXTuS2PjMjvzPZ57uw+thEPzCDU1kQg6FMtXhSw
	MnMGOU3DGDHpESRk0CSj/lkLmVM8cuMl4hHuHyiPPcEc94XSNSHVn2TBbzO3BN5NuSpLjHsZlWA
	SkQvNe73QypNE0CDru7JcgNG0Xx7CEmrKs+Cp6t8fM9e9gshiimctQ4jMLJByVTDMXQ==
X-Gm-Gg: ASbGncvGuTm8HiaBw2VOnBmQDoioTU09qMgJ9MdlYpQa49ggg5LiF6OTW8ieWSkC7eE
	TFTRH/1lIlZpUt2ql7j1L3uZyG1WHzFxOYE21bxrJsIWHW+B/3MGXGC0n6SQd1LuM+8cCio4C31
	sXmaDrTtSbDqYZRD8Xy07m6atRL9xrWpNP7sURQsFPcvGBh+TuwgURUF8ZaJu+z+gVZgygTVOQl
	0me3ea3BkVXNoPrYZSPoKW8lidwCrmp3QKwb1nXsPFeaBcAUBDtxsf8XMnFKSINH+fRJXb3oY6w
	Ch8q0d9DP6l916GaXcEpuktyNktDZzFbiIs0kdUgptZgl1Jn2EfnRfyGt/pZUrMUJ3IdchARVMz
	FW9VOdB4LQ9+N3w==
X-Received: by 2002:a05:690e:12c7:b0:640:decb:4537 with SMTP id 956f58d0204a3-64302b2c8e6mr30698771d50.58.1764668351506;
        Tue, 02 Dec 2025 01:39:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWKQ+i5bqFZm7//7GYVsSKxVMOBPANik6NYt+jiekHdH1VddhXBg0QSY7EECKghHytlG2NOQ==
X-Received: by 2002:a05:690e:12c7:b0:640:decb:4537 with SMTP id 956f58d0204a3-64302b2c8e6mr30698758d50.58.1764668351141;
        Tue, 02 Dec 2025 01:39:11 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c484722sm5995288d50.23.2025.12.02.01.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 01:39:10 -0800 (PST)
Message-ID: <5f4331ce-7ca1-4109-99b1-90e45d9026ef@redhat.com>
Date: Tue, 2 Dec 2025 10:39:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next] selftests: ipv6_icmp: add tests for ICMPv6
 handling
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org, horms@kernel.org,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net
References: <20251126201943.4480-1-fmancera@suse.de>
 <20251126201943.4480-2-fmancera@suse.de>
 <341a110e-7ba0-4846-abf4-5143042c8e80@kernel.org>
 <30ee83e6-bed4-43c8-bbe2-ea19fbf17ce3@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <30ee83e6-bed4-43c8-bbe2-ea19fbf17ce3@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 9:58 AM, Fernando Fernandez Mancera wrote:
> On 11/29/25 4:56 PM, David Ahern wrote:
>> On 11/26/25 12:19 PM, Fernando Fernandez Mancera wrote:
>>> Test ICMPv6 to link local address and local address. In addition, this
>>> test set could be extended to cover more situations in the future.
>>>
>>> ICMPv6 to local addresses
>>>      TEST: Ping to link local address                                   [OK]
>>>      TEST: Ping to link local address from ::1                          [OK]
>>>      TEST: Ping to local address                                        [OK]
>>>      TEST: Ping to local address from ::1                               [OK]
>>>
>>
>> VRF based tests are needed as well to ensure this change works properly
>> with VRFs.
> 
> Thank you David. I am reposting it with VRF based tests once net-next 
> tree is open again.

While at it, please have a look at the shellcheck reported issues:

https://netdev-ctrl.bots.linux.dev/logs/build/1028021/14331024/shellcheck/stderr

Also, not a big deal but you could possibly simplify a bit the `ip addr`
parse code using json formatting:

ip -j -6 addr show dev ${dev} | jq -r '.[].addr_info[].local'


Cheers,

Paolo


