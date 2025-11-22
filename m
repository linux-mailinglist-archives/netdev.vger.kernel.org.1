Return-Path: <netdev+bounces-240937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FB4C7C2D2
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 03:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4079D355CCB
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA692C15BB;
	Sat, 22 Nov 2025 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="A+Cwe3d+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E60299AAC
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763778267; cv=none; b=ZLyyWJN6NZQi/IN5EnEu4kdhs1dbqArUphCe9tKLM+Ze+SLFLMzESKNKI1FSopZF2U2fwL5vbsLLFG8kfe7K83gI84p1Ot/zUi5pn7lNkPaBZYrxrQ8jedRDXT4mT2CYU5faYYRMrJERVvsW4ZMSUtG5ZcaW56LN/44eK8G5KNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763778267; c=relaxed/simple;
	bh=+9kQ7ERWLwTlaPx1EhDKNoAuqJ/jvyH4D66SoqIYqMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKNljyN7n/h5lJevhckdmmktXnsyxw5+5+sg8aOffaw5DSbsYHjPcxZRdZn7/jdwqfptmZqvoNtPxFoLEHHMa9nEQFUOBy6rcmhx8kt8mB17PTFk7QXQvOc2KURozT4H6O8CnhFIkFdTMcxwjbW808gJFPjsVj4AnjJjvGWQIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=A+Cwe3d+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aace33b75bso2416449b3a.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 18:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763778265; x=1764383065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ojkf+/G+q9Gv01FKljG9PyqzEmpjYg6z7CQ4+Z6Hvpc=;
        b=A+Cwe3d+vSA9yIGIUKxSUKgvB/BDfrJqrZzqbfemmMYyVW28MQR5z0lX1Is7yGyQLW
         ExRUG4nwmlw42YiN1IOOZebP6KFC5Yexsmo9pDJgS+xjQ75s4+D+qRW62MunxN8rViI3
         kCKrUQTBaiwK3TwAB/v57iqrFRwTDShRJaCUx85wxWFDYlnEvbeVN2kkQbOBzYxDYGmA
         3QJfsMavHRzZF/tHHjqKLEGF595HRMcxGucJdjKL1kV8GoKbLcV151CXiFxtHAI01i5l
         TujgQk2EzC/WcYSFBpqDH22298bEIzXUAYsUDnEpSbIPNi+sdIiZgyrfGYcy1JrKsqvw
         gXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763778265; x=1764383065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ojkf+/G+q9Gv01FKljG9PyqzEmpjYg6z7CQ4+Z6Hvpc=;
        b=CTg59Z7iTEFnlyFSvShe8ntSKqbe+QA3Hzaih6b3LUTOD9+tzQ+uoY8lrie6MqyA2o
         JRVp381BPxKKF1UV3w4jMeN+FKvQWbofVWCnocRyo5EigJjDyg4xC2WQM0V74lFH+htj
         ypJtuNJRx4GitaZCmTy0airGz5rjLAazVqmgzDJQnyWcpfJyQ311X7x0baPK44Nbs8/M
         pALGi1daizxDAh64Sawa61jE0vVLCTm+GZfcTztjiQyJGPLx7c/E3Wthv5jjLxyzfEnD
         Fmy6Dxh97D1IcebyWIPv60b6JujAKuSFY7n/I/BOFcF12mM/nvNUDp6eu/5wxcXow+R/
         AiDQ==
X-Gm-Message-State: AOJu0YwNA5XpIhP+Xzo9sYzGh6QtGKyBKm5nmORmzGHR4/NgM8C24aOK
	u0K7GSKJq84p7ZatkGECY6WshT1Rg3RJF5brPEAzQTRnx8L4BjUTTBBTIbpDzamYKjHxF4QeXXx
	NV1dh
X-Gm-Gg: ASbGncukOxSNHSWXys/bQB+6adaIx4k3YOlBBUnuljPQx+ubQRa6h4ABB+r+0Lgj45n
	398JXyiKa2Mj+ItxPbvSEC3ZK0G78nh9UlYlQQLrcNM3+yxonzLMwevi0JoU5hijZc84tCnw0l0
	YWw2pd5OkvYJhZVHonlbxzmB+ueRj3Iq8mltUQXXw07rysw1J8bxfJa/IKcyBF7he7aYipWs7FT
	ZM3YD4HGWCleDSRf9/FQMfZaHyq3VsFuQ/h+pSEJVbmV4n4aXUQb7lHF0Ce/PkPlHCt4jbNK0Z9
	JjmEX4FEbCqyCzethehGRgsDOBG0eX5nacJTGz9tFQz0vobqJaWgHUUMLIv1zSUADrJwx7Q3n9Y
	uixqRfISM+Iv1yqgvO/9gn5k5o5+2EvRbq1HTM1osdgzhG2bDrz+te6vMb1vbcdG43YOg0wQTU/
	mPJFyUQw7zGih0YMW7F1sKYEcGCFg/5Xd0tBiViY/gmwuBAhr5EDRoLbObhpFC
X-Google-Smtp-Source: AGHT+IHj2I0QtRdK8n93HjO9KKM6mXsG22wEZinxx2cM9iuMEsR+ZGktnAPpiSiTZvBU5amhEgEV4g==
X-Received: by 2002:a05:6a00:2e82:b0:7aa:9723:3217 with SMTP id d2e1a72fcca58-7c58e40f6dcmr4183400b3a.25.1763778265558;
        Fri, 21 Nov 2025 18:24:25 -0800 (PST)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7d515sm7391811b3a.3.2025.11.21.18.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 18:24:25 -0800 (PST)
Message-ID: <cbf20bde-74f8-41d1-a259-37c5d29a194d@davidwei.uk>
Date: Fri, 21 Nov 2025 18:24:24 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/7] selftests/net: add MemPrvEnv env
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
References: <20251120033016.3809474-1-dw@davidwei.uk>
 <20251120033016.3809474-3-dw@davidwei.uk>
 <20251120191823.368addb5@kernel.org>
 <1cfe74a1-092c-406b-9fe5-e1206aedb473@davidwei.uk>
 <20251121174122.32eff22a@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251121174122.32eff22a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-11-21 17:41, Jakub Kicinski wrote:
> On Fri, 21 Nov 2025 09:14:49 -0800 David Wei wrote:
>> On 2025-11-20 19:18, Jakub Kicinski wrote:
>>> On Wed, 19 Nov 2025 19:30:11 -0800 David Wei wrote:
>>>> Memory provider HW selftests (i.e. zcrx, devmem) require setting up a
>>>> netdev with e.g. flow steering rules. Add a new MemPrvEnv that sets up
>>>> the test env, restoring it to the original state prior to the test. This
>>>> also speeds up tests since each individual test case don't need to
>>>> repeat the setup/teardown.
>>>
>>> Hm, this feels a bit too specific to the particular use case.
>>> I think we have a gap in terms of the Env classes for setting up
>>> "a container" tests. Meaning - NetDrvEpEnv + an extra NetNs with
>>> a netkit / veth.  init net gets set up to forward traffic to and
>>> from the netkit / veth with BPF or routing. And the container
>>> needs its own IP address from a new set of params.
>>>
>>> I think that's the extent of the setup provided by the env.
>>> We can then reuse the env for all "container+offload" cases.
>>> The rest belongs in each test module.
>>
>> Got it. You'd like me to basically reverse the current env setup.
> 
> 🤔️ not sure
> 
>> Move the netns, netkit/veth setup, bpf forwarding using the new
>> LOCAL_PREFIX env var etc into the env setup.
> 
> Yes to that, I think.
> 
>> Move the NIC queue stuff back out into helpers and call it from the
>> test module.
> 
> Don't go too hard on the helpers, tho. "code reuse" is explicitly
> an anti-goal for selftests. I really don't want net/lib/py
> to become a framework folks must learn to understand or debug tests.

Okay, understood. I'll use helpers judiciously.


