Return-Path: <netdev+bounces-112544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1841B939DAA
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CE6285D74
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 09:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415BF152799;
	Tue, 23 Jul 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8Qgq0j2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FC3152537
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726656; cv=none; b=PjFW1PHOLWhcnqobpEoPX4cmmiRfbcgpHVL9Z/r2ND9cgJ70SSQdFTEkTto4qKvrIg0DaTJ8rZKQbUZWfeTuMHsCdD1QoLRcqqxHbO7zJnIOyaFmUm+2P+AADhugBMlT0usxGyMWwQtNjY22KN+vdey7REofj2p8AnKxfXj6CbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726656; c=relaxed/simple;
	bh=Yncer6iw6PhfpuYRJqGAfWtYlWU0gZdo6+GNkPi9OG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dB6ALy+NtXAAxL+9risMgaX1a7RCRaUuTkhxiNAHMx+DcGx2qDTx4KwbH0g/4vzyhIPOi5CqCxXRdM0C4k2cPmyl7+ItKyGpLsMVyrK/F9U7xBDroCfcoyOZKWNJTBTOH2sT2s4j6VONjLaP4iPa86m9nGXYWOCFJhPyg2i0I/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8Qgq0j2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721726653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=di3b6+JsOF88ta+JmszT4sf4RN4aT8grE7boITm/z88=;
	b=H8Qgq0j2nWHU9twGNaeASorcAJqSCZjzCbFDh+zH+OWxKGOyUX6qJf+Hiw+0wUOiIV4hmQ
	GAkyzlyBbDlw/X/s0mtENURev2PWFvW2h2Vsx1Tu9udbDI0qXjcHjtemK4jdvVFFeEaNhf
	gCM4lCGsEI+y6XvyaZDCSfTjAbDPJ0Q=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-zFsl2_FmNta60FMFnM44LA-1; Tue, 23 Jul 2024 05:24:10 -0400
X-MC-Unique: zFsl2_FmNta60FMFnM44LA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef2c1db4abso1837101fa.3
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 02:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721726649; x=1722331449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=di3b6+JsOF88ta+JmszT4sf4RN4aT8grE7boITm/z88=;
        b=c5rr0O9rQJHkhDmMivHpi5nbKPrYs5ENGadNOn/M3sPwrEdvhCRVw3yMO5IueecIHG
         IHRMwwFVTLU6hxn6nowI9X7qvYX0aFrWoHdtG6x6RTXMoSC3J2NwGXYeXbkR0DpJzTbh
         pPhZdqdnYvaJOUfJD3ph6Ar82jVpBpmV9PqjuhrFJ4m1AAh49SAAg4vuatDZCJtn1x8h
         sCf/2FckpjjxkY4IAttB8d9SN3uY5ORAOeTXXn7D2H0wXemEv5Nseoguw3phY1KsVhiO
         SwJI+Bz+jEWKshD/uLREpjNj/+ZqKvKMu+vTpO7zhX04DBQzo8q6s8FehbtPSFK7pGTu
         SY4w==
X-Forwarded-Encrypted: i=1; AJvYcCWT5T5ApNjB46ZKm7qEg+xMivspldnzBRQ++WwwYM/xHcfFUSYh5k5iZuceLmhPa77xx7XePHYhSPOC9lkaOH9nteFSPBCI
X-Gm-Message-State: AOJu0Yzf4paeuMsZ4WUWCiQVWT5oMl7QFqMPxpqsmBpGbPG1cwbjyY7B
	B/64WXd+y6Y8iMePH+4BDi9wFLc+ciV5Z+/syz7y5/+uPS3gpM8VJI3ToJ2VJpfDPfBhAwLiIz4
	88N3InVpidozTgMtQl8zVkqAk6pOPCOC/2S/woIFVc+waSeRNsh07Ig==
X-Received: by 2002:a2e:9357:0:b0:2ef:1c03:73e6 with SMTP id 38308e7fff4ca-2ef1c0374aemr31782151fa.5.1721726648767;
        Tue, 23 Jul 2024 02:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJWuDgcUZs1POGKMrOCZ33+7BgDR786BaYJXF0A6bQ28l60Nv/FdFgs8F4ROQIQKbxoHgZfA==
X-Received: by 2002:a2e:9357:0:b0:2ef:1c03:73e6 with SMTP id 38308e7fff4ca-2ef1c0374aemr31782081fa.5.1721726648322;
        Tue, 23 Jul 2024 02:24:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868480csm10896053f8f.13.2024.07.23.02.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 02:24:07 -0700 (PDT)
Message-ID: <416ebc12-50a1-48e5-a17f-8999f3b460cd@redhat.com>
Date: Tue, 23 Jul 2024 11:24:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: forwarding: skip if kernel not support
 setting bridge fdb learning limit
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Johannes Nixdorf <jnixdorf-oss@avm.de>,
 linux-kselftest@vger.kernel.org
References: <20240723082252.2703100-1-liuhangbin@gmail.com>
 <d5dc8f31-26ed-488c-9d63-a96b95609814@blackwall.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d5dc8f31-26ed-488c-9d63-a96b95609814@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/24 10:30, Nikolay Aleksandrov wrote:
> On 23/07/2024 11:22, Hangbin Liu wrote:
>> If the testing kernel doesn't support setting fdb_max_learned or show
>> fdb_n_learned, just skip it. Or we will get errors like
>>
>> ./bridge_fdb_learning_limit.sh: line 218: [: null: integer expression expected
>> ./bridge_fdb_learning_limit.sh: line 225: [: null: integer expression expected
>>
>> Fixes: 6f84090333bb ("selftests: forwarding: bridge_fdb_learning_limit: Add a new selftest")
>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>> ---
>>   .../forwarding/bridge_fdb_learning_limit.sh    | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
>> index 0760a34b7114..a21b7085da2e 100755
>> --- a/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
>> +++ b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
>> @@ -178,6 +178,22 @@ fdb_del()
>>   	check_err $? "Failed to remove a FDB entry of type ${type}"
>>   }
>>   
>> +check_fdb_n_learned_support()
>> +{
>> +	if ! ip link help bridge 2>&1 | grep -q "fdb_max_learned"; then
>> +		echo "SKIP: iproute2 too old, missing bridge max learned support"
>> +		exit $ksft_skip
>> +	fi
>> +
>> +	ip link add dev br0 type bridge
>> +	local learned=$(fdb_get_n_learned)
>> +	ip link del dev br0
>> +	if [ "$learned" == "null" ]; then
>> +		echo "SKIP: kernel too old; bridge fdb_n_learned feature not supported."
>> +		exit $ksft_skip
>> +	fi
>> +}
>> +
>>   check_accounting_one_type()
>>   {
>>   	local type=$1 is_counted=$2 overrides_learned=$3
>> @@ -274,6 +290,8 @@ check_limit()
>>   	done
>>   }
>>   
>> +check_fdb_n_learned_support
>> +
>>   trap cleanup EXIT
>>   
>>   setup_prepare
> 
> Isn't the selftest supposed to be added after the feature was included?
> 
> I don't understand why this one is special, we should have the same
> issue with all new features.

I must admit I was surprised when I learned the fact, but the stable 
team routinely runs up2date upstream self-tests on top of stable/older 
kernels:

https://lore.kernel.org/mptcp/ZAHLYvOPEYghRcJ1@kroah.com/

The expected self-test design is to probe the tested feature and skip if 
not available in the running kernel. The self-test should not break when 
run on an older kernel not offering such feature.

I understand some (most?) of the self-tests do not cope with the above 
perfectly, but we can improve ;).

Thanks,

Paolo



