Return-Path: <netdev+bounces-187406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC3AA6F8F
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 12:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E100D3BD073
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5DA23C4ED;
	Fri,  2 May 2025 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H64ScWfx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89E22F773
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181704; cv=none; b=uzmvh6nLUBTWe+bmGzcJ3RP2TezjQujpvRp0RvV58c8j59RoPwGXPmm9iYX+Ewh3eLcUHBokdl1QC4WQlUk5aMPnceycML1HK7uM3C1Li9UsDCuErjC6m9yo+JOQkthA1BbHo1tJV2t8BafuXoFOiEXcu44mMyIHc021kKRPBlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181704; c=relaxed/simple;
	bh=SEU8CqxPdXWm5kBs+itfyCdnnlLFQ0gV+s9EvH0h3a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cca699BrTE+1x2Jw1FEDiWFNFNg8azaI5irhJAm1SIlTJYMIqYUoPXrnwX5NiicYF8jFMmL0/PnifzWludqWjD4XuE/wkocDYzg6x88xDTiHaHPOOc1Arb7XnM77KPQkPwV8PuxU7u0z1D9F09ICnsaXzYcu+C/uJthu5Wd/jWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H64ScWfx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746181702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSbhw2lx3uIU9bt71Ke9bjoVhiyqLGEvU1SMMBHqrLU=;
	b=H64ScWfxSM7cF+QCqeuldvCfQnV5iv/rxuLuU2M06TyvrdBDVdfvLjxJbiE9I6wZAdZ3Gm
	mNU2SEC7sst43cb1pSzqdwLWtk5rsocUrVnFYUu6K3GEF6vxlKE76/QLbP29u+y/1+MLZy
	tlolETy7gRGUeShMloRFcNgvZtlGDko=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-FJRT0iXdNtW8MgQnolXxbA-1; Fri, 02 May 2025 06:28:20 -0400
X-MC-Unique: FJRT0iXdNtW8MgQnolXxbA-1
X-Mimecast-MFC-AGG-ID: FJRT0iXdNtW8MgQnolXxbA_1746181700
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912539665cso1127261f8f.1
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 03:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746181700; x=1746786500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSbhw2lx3uIU9bt71Ke9bjoVhiyqLGEvU1SMMBHqrLU=;
        b=F+3A9wwA2qCLRVfQjMScBDiVyoR/XFO1Wr2dc7XxJfs+SuhoyJNGMYpBpltKQcNC6d
         +DZi3zS168yPIS/y6R2aM5MjCUdvYxwepA6Mv7Wwez7tRn6r5uj4Kaf3t8XQSLlzXzVF
         kjbW1+CxHjp+AUc7l0UlZu7zK/mMCfmdGK4QNau+F6y9T+n4UCFUTTQ7o4qDZ8gXOj0A
         DT6dQKrFpLNIvFqzQnR3n0vD6sYGzfhor0G1J/hHPEB1KgCtvo2Y9M8e7+SqJJwl6K4p
         NLP+2i/MdDNrfvJtSQ6uawfmzfw/UunVw76B/B5tCDjFYDvfdhd0lnLtJVpMosMQmmRg
         GLzA==
X-Forwarded-Encrypted: i=1; AJvYcCVatzXbBd+euz04p7Ew2gXHefKx7TkW+/n9SnZGC0gIGmk4fkYN4U0T3or4Y6r5AwijvdBiS6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS0Tnh8LJsOpDyJvZCdyP+6nCm8VxDKqYSti94K5Bh8f/ffbj3
	IQp1SmvWy5DmXfvGPdKjoqcZ89IG1i7GOWbUv2zDAjwIdQB+Lg0qZp46VlEsGdcet56L4UqKkB1
	OVETifj7Gxh1pQGDvAoPVEl7R3delWNVVIyCnDzAJGfv4ROOC9O6uxA==
X-Gm-Gg: ASbGnctPwzFwWt9qCNPFBF0nnn0J9DSBg+BU1/dtBXvr8LOH56ADv9rvsOZE5bdTV+i
	C/SuZj6pO5wkQDpJiN+SI74T7HyGexcKXbl9ZOytbjckHfiGF0NZAjbXFYAMjyLChCmWcX9z7uv
	aNjh+alL4CaEl4Gy4ksUGukMN1QbvIvOoEMG7tU1vThCTgg8+nX3mv1sBHrtXIo+hZZ3Gtl3kAl
	9cIK+5YfzAHZNIw46IwSPYlF0efsZ6a/A1gz2sshsCueH++X6EEEt2SHF8JYjbd95ewtoy/3DdC
	wE4zNgXQSrxplhdCZIQ=
X-Received: by 2002:a05:6000:1a85:b0:3a0:8524:b480 with SMTP id ffacd0b85a97d-3a09402cacbmr5066369f8f.2.1746181699718;
        Fri, 02 May 2025 03:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWyOVTRRGEVNWXO/iDfooNor6IST3SO4x3a3xxs7csOvOKwxwfMPv7xS3Tnv2MrR9Li9kpkg==
X-Received: by 2002:a05:6000:1a85:b0:3a0:8524:b480 with SMTP id ffacd0b85a97d-3a09402cacbmr5066344f8f.2.1746181699348;
        Fri, 02 May 2025 03:28:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:246d:aa10::f39? ([2a0d:3344:246d:aa10::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2ad784asm85337125e9.7.2025.05.02.03.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 03:28:18 -0700 (PDT)
Message-ID: <74e11512-934b-446c-94cf-93bf97eff9fb@redhat.com>
Date: Fri, 2 May 2025 12:28:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] selftests/vsock: add initial vmtest.sh for
 vsock
To: Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250428-vsock-vmtest-v3-1-181af6163f3e@gmail.com>
 <a57wg5kmprrpk2dm3zlzvegb3gzj73ubs5lxeukyinc4edlcsw@itkgfcm44qu2>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a57wg5kmprrpk2dm3zlzvegb3gzj73ubs5lxeukyinc4edlcsw@itkgfcm44qu2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/25 3:06 PM, Stefano Garzarella wrote:
> On Mon, Apr 28, 2025 at 04:48:11PM -0700, Bobby Eshleman wrote:
>> This commit introduces a new vmtest.sh runner for vsock.
>>
>> It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
>> H2G, and loopback. The testing tools from tools/testing/vsock/ are
>> reused. Currently, only vsock_test is used.
>>
>> VMCI and hyperv support is automatically built, though not used.
>>
>> Only tested on x86.
>>
>> To run:
>>
>>  $ tools/testing/selftests/vsock/vmtest.sh
> 
> I tried and it's working, but I have a lot of these messages in the
> output:
>      dmesg: read kernel buffer failed: Operation not permitted
> 
> I'm on Fedora 41:
> 
> $ uname -r
> 6.14.4-200.fc41.x86_64

This sounds like the test tripping on selinux. I think this problem
should not be handled by the script itself.

[...]
> ERROR: trailing whitespace
> #174: FILE: tools/testing/selftests/vsock/vmtest.sh:47:
> +^Ivm_server_host_client^IRun vsock_test in server mode on the VM and in client mode on the host.^I$
> 
> WARNING: line length of 104 exceeds 100 columns
> #174: FILE: tools/testing/selftests/vsock/vmtest.sh:47:
> +	vm_server_host_client	Run vsock_test in server mode on the VM and in client mode on the host.	
> 
> ERROR: trailing whitespace
> #175: FILE: tools/testing/selftests/vsock/vmtest.sh:48:
> +^Ivm_client_host_server^IRun vsock_test in client mode on the VM and in server mode on the host.^I$
> 
> WARNING: line length of 104 exceeds 100 columns
> #175: FILE: tools/testing/selftests/vsock/vmtest.sh:48:
> +	vm_client_host_server	Run vsock_test in client mode on the VM and in server mode on the host.	
> 
> ERROR: trailing whitespace
> #176: FILE: tools/testing/selftests/vsock/vmtest.sh:49:
> +^Ivm_loopback^I^IRun vsock_test using the loopback transport in the VM.^I$
> 
> ERROR: trailing whitespace
> #443: FILE: tools/testing/selftests/vsock/vmtest.sh:316:
> +IFS="^I$
> 
> total: 4 errors, 4 warnings, 0 checks, 382 lines checked
> 
I almost forgot: I think it's better to avoid the special formatting and
replies on review for proper updating of the script's help.

Thanks,

Paolo


