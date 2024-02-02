Return-Path: <netdev+bounces-68642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765D38476D6
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9666B1C2621E
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939AD14AD32;
	Fri,  2 Feb 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXa9LSQc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF405FDD3
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896671; cv=none; b=KiyOmgaEh++tjYqYJOFKRZ9tnQ5RQCGRzufEV8gtCfPhvbfJuhK9W9hZFK0TuytxNJ0hrSA2XuRIrQ2/qbVADWA3nAFSQujtm6NGqYd/n+CPqwfxxl77cku5TN1K3BwRh8Id17QsIHrVgrZ7d9eBEANQ1OPQkDG+f9v23zS/jes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896671; c=relaxed/simple;
	bh=O0Ijxe3iouVkU+ctZW0o94wwuJeWzFX+RJXvWXfYqm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJSX3L2TxEoFICXFMrFpfh23sOzSm5am4p8egq9zyMrrZH34V3xFUxlqLL7CKfifO6wZnYGRAQAQpemysqGtuHEq7101OPu5FjBs5949oErSxwWZjZsz54Il+Z9BOyGB+KRxoSJAKF85XcaTZHmgv139X6TUBVEechmbAsKBcRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXa9LSQc; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6dd9bf348so1946412276.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706896669; x=1707501469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXuKjTCgboOBmFq8bmRxIMTjCW3TaPqGKc9JTvBcec4=;
        b=MXa9LSQcMpd+RLZeRNejvmLWFCNsdW4QavYYz8XOi86tusZ0PxLY4uvMNzTjIMZT6S
         OXFRazDwdfPCPNTAlAf6tpuYmHX2OYeZmAYzlYn6wujV4b76WKX6sObfyLVLlNY7uN2A
         mc4UJi1yPmICQoBPuanZVupzwPC8bHKZi3CWJyIVlv1CQ37InInPomFxo3zWTl5WbpRk
         OOtpGMdldvwVpSZBsahlqD1V5+NmBkdJNqoFaW0EghLuBmEim37so520sBqoPnupt4qv
         niCuY96sY5w0JRxQqsiT48nDKgiijemCbFVja/2pyFqMk0lSeUj7R8XKJ/30ZdFzxhyh
         9yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706896669; x=1707501469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXuKjTCgboOBmFq8bmRxIMTjCW3TaPqGKc9JTvBcec4=;
        b=rjDcop8+f+Q70F94BOV3zA+fzB83xpttYivHv1ZXTrLB30im/4w1P1YPdtVwwHYspJ
         5mmYFP1LpU3irF0hLs8p4Ja13jn03ABoxSI3xsZ6FL0URAgoUju8t5p/t2xk/ZCa7u+H
         lySGC6iShjgPZNqP0k72D7850uUYT2cR2WZpG4xDV79/kZq3h2iIaNY9NSS1AkARWIfJ
         sZBX7ipGS+D7qBPcrgF3cY3nFKmarrSDXdziWUa4OWG/WSr9f5Bp/VHpF0cIyb5D2i3T
         UrUQKKYmr3Z5SwPMm+X9u7sdXdCkjDC3SMli6y/A5TgPEt+qIk6vQ/lHxh0FrEm6ZCoW
         ESwg==
X-Gm-Message-State: AOJu0YzXqeSLziGva0FZYAf+TIzzIif5mnu+jCnnvGzx/0IfmiFud1tV
	i204K+yQvy/wcLnuIfnk7hmAgZ4jwefMTPtEMrfYvge2ZBhCTGJS
X-Google-Smtp-Source: AGHT+IEQsLJecURZAd9fSStc3KV0EDy7cvLpWAyPwmlqHN/JL3hVsGcr4+n6FbMLEW/abRs60NC6vg==
X-Received: by 2002:a5b:d09:0:b0:db9:9134:bb28 with SMTP id y9-20020a5b0d09000000b00db99134bb28mr5854539ybp.4.1706896668899;
        Fri, 02 Feb 2024 09:57:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUyaS+RkctRob/SnAjvJyEIgAoKeLwMFcTVljhNCQwl9VNJ4Y340GGYES//HyV9B0BuK5RGw5FkwdTlXG8gkMPx67YacMFWosAOI1A/mViZ7EvPq3nv7hELUgdL68TZTbrvxSjAiP68Lhg4B8vjlm4Q31a7c4ugIfk62gXHsQApxeLaY8lDOQpl7eyQRDhjb1u2DaTingsEefSz03LpIfWKE8yxrxQnf9t0NvV0Tt53kMXotQg5Y4TgXnpbLMWyFoTmWlwQev3TyzultKiPChvAg3Pj7bXiDV8quVkc95u5yxcozgKrjOiO+0PjNgHaqTHgaWcS
Received: from ?IPV6:2600:1700:6cf8:1240:b98b:e4f8:58e3:c2f? ([2600:1700:6cf8:1240:b98b:e4f8:58e3:c2f])
        by smtp.gmail.com with ESMTPSA id e69-20020a25d348000000b00dc6b6dee1dbsm531544ybf.48.2024.02.02.09.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 09:57:48 -0800 (PST)
Message-ID: <536038f7-cc33-46c7-a3e9-2c9f27bc9c81@gmail.com>
Date: Fri, 2 Feb 2024 09:57:46 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/5] net/ipv6: set expires in
 modify_prefix_route() if RTF_EXPIRES is set.
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, thinker.li@gmail.com
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kuifeng@meta.com
References: <20240202082200.227031-1-thinker.li@gmail.com>
 <20240202082200.227031-5-thinker.li@gmail.com> <ZbzdBRd4teS_4Eey@Laptop-X1>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZbzdBRd4teS_4Eey@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/2/24 04:16, Hangbin Liu wrote:
> On Fri, Feb 02, 2024 at 12:21:59AM -0800, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Make the decision to set or clean the expires of a route based on the
>> RTF_EXPIRES flag, rather than the value of the "expires" argument.
>>
>> The function inet6_addr_modify() is the only caller of
>> modify_prefix_route(), and it passes the RTF_EXPIRES flag and an expiration
>> value. The RTF_EXPIRES flag is turned on or off based on the value of
>> valid_lft. The RTF_EXPIRES flag is turned on if valid_lft is a finite value
>> (not infinite, not 0xffffffff). Even if valid_lft is 0, the RTF_EXPIRES
>> flag remains on. The expiration value being passed is equal to the
>> valid_lft value if the flag is on. However, if the valid_lft value is
>> infinite, the expiration value becomes 0 and the RTF_EXPIRES flag is turned
>> off. Despite this, modify_prefix_route() decides to set the expiration
>> value if the received expiration value is not zero. This mixing of infinite
>> and zero cases creates an inconsistency.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   net/ipv6/addrconf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>> index 36bfa987c314..2f6cf6314646 100644
>> --- a/net/ipv6/addrconf.c
>> +++ b/net/ipv6/addrconf.c
>> @@ -4788,7 +4788,7 @@ static int modify_prefix_route(struct inet6_ifaddr *ifp,
>>   	} else {
>>   		table = f6i->fib6_table;
>>   		spin_lock_bh(&table->tb6_lock);
>> -		if (!expires) {
>> +		if (!(flags & RTF_EXPIRES)) {
> 
> Hi Kui-Feng,
> 
> I may missed something. But I still could not get why we shouldn't use
> expires for checking? If expires == 0, but RTF_EXPIRES is on,
> shouldn't we call fib6_clean_expires()?


The case that expires == 0 and RTF_EXPIES is on never happens since
inet6_addr_modify() rejects valid_lft == 0 at the beginning. This
patch doesn't make difference logically, but make inet6_addr_modify()
and modify_prefix_route() consistent.

Does that make sense to you?


> 
> Thanks
> Hangbin
>>   			fib6_clean_expires(f6i);
>>   			fib6_remove_gc_list(f6i);
>>   		} else {
>> -- 
>> 2.34.1
>>

