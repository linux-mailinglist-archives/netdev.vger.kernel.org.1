Return-Path: <netdev+bounces-240844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A07C7B0CE
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F029F3416D0
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DE72EE5F4;
	Fri, 21 Nov 2025 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ymkEGfKR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634C36D503
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745565; cv=none; b=fCONFhjwmju4DEYDwJAIJNwUJ+EWPVZKGUXMSnSbdKX7dRCnZLi/pkduqKDk29db1CFuF+H0OyaI/iX/pJtFnGWdDSQhJpsExhjc/LWYLH+MWXPYxAh8XS8g7cul76S3AGB1q4sTawQpPJZF3IiVquH239esPdxgRZHK0i1eJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745565; c=relaxed/simple;
	bh=5tTA6XHiuO6J8Vx09SQlNUM32hRgQutWIQ+RTR9tEDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqP+PEV7zCspHKAUuOvoFbcTkITmtLTngqE9ENynZ8J1s4un0C2WSirR2F0puD4tXI/txGsGcu0RW2LbLT5+OsEGTnjHKWQR1MgMKuAeuHNJ3qywuW//2cttKwRUU9pM7u1MP9Q14/KZ3z1+uNCvWbXzXdB69IU30/N6kOoQFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ymkEGfKR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so2639688b3a.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763745564; x=1764350364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z1wEApu4pRl1D9aAMSad5P9vXTiEST9RBR6KKRRvoJQ=;
        b=ymkEGfKR732ooBM2lNeRPil2wz+1AY5mDJwjB48Q5+I7AW5FGvwazEFZxcQZUiPPKc
         wHmz/oKMKmimYKUPJgp/U4iZ/jNiCFi++Foyd6UTaCg2YiaFleEhoupVTz4hBGTRSB5t
         EM9rn/G/2guJ9/TRvtq5asPGRYVdipJ7aB5LEAgHhYz+lGbPgpGARKh3gYHK8EUe1HFm
         wW7M/vhJlTpEuUlvNhNCnXXMF68AexXbVX9xm3tLppqq8eEOgMOnE4fEUOUqs5j+TdBS
         tw1SVQepfgeB9j6y75pKcKVzWj9MNfia4RbYDl0nQM7XYKXbjX3dk3P5FzjAUmPtrXzr
         6JdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763745564; x=1764350364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1wEApu4pRl1D9aAMSad5P9vXTiEST9RBR6KKRRvoJQ=;
        b=QAp7eAvsGyofqY5bzUAWwzGfR8ZDdQD0ksya2LHLGKtGo11m5NnVLaNGJXMCjFjND6
         mdGEG0tFhjCVmNz2T69QzkhwqIqxkM3q4c2xNfhqhYwlfDp0HTHh/qcdqlCG4Ix/rwFH
         qzQzibOcwRxlvwrNPdYsv6WfqYEWI/6nOQo6jPyGzc4t1lts3/CKKlqLmhQCd0BSn5sA
         tvAqRtFiLBpgwQVOo54qIMejzUt5ASi/gm2p/L+7pJO44QPR3m1Bla/0hpwFfCQ7edP2
         sz09sOUygNz9UHg1YhCwE+C1R665i80urW/eWlZ6ZPJmAUyvVPdZY8/UQmtmiP2qynV+
         59Wg==
X-Gm-Message-State: AOJu0Yx52quMarfjlDfqDyNZF9mSyAXSrLZhg8z5GfvcJAh1hhsr6KyP
	Y8en8jvk/BmuGsoLIzvjQDfbK/3Wbb27J9t0xMVxuYh7dj3nBrINasU+yrNcky3mQJk=
X-Gm-Gg: ASbGncv75x92sFtJz64G6qU/H5iuXfZZUpr0Yx8GqcJlWHUPH62/9qz7ZoOLitE8dLo
	ZcIUDngHEuW5lSKFGVFibAFM8Af6w7ESLD1D+oGy/DgW4dOMkSFIs+h2tkXI++G5o6jplM2zGUk
	2jcy770flWRk/XH7eykSg52uHOa4JwuBIk9YxoyAqJ5U8WB045P5DeNvkYHB0QVYjfdJMdtFlS1
	UlZClhSH6W+AqmfacOOqhWLkvhdYTHgevy4apuUdj8vJgSxHy1XFNKcI7Af1jV/WwcgsMiEayvJ
	CUkJd12jZKY0N09pv2btN3I43OJK8SRtzDGRshUHz8UTbqqWWWhv6QJzrOphqdfhCeJEU1jwIQj
	1PyA2b8qWl5hezwDVFjzpOuHNwkuPZwCVr0uW3vpihmCGgXlkDu96ktBFDv3eESHupiocWDAYMr
	8tWAjIaOcw2XwdvBLuMO9dFTrWznntaPABU8Y151kXGRJ+kX42bXH5fNgiOdt+ipCikBNt8W9Jy
	5lZhQE=
X-Google-Smtp-Source: AGHT+IH/JrxblVTlWPARZrsuUGSoqbvLEtV3yN9KWOVmAWmn6HBajdPORV0H5F/tfd5Z8J2sLl2MGg==
X-Received: by 2002:a05:6a20:7f8e:b0:355:1add:c298 with SMTP id adf61e73a8af0-36150e8f01bmr3614637637.21.1763745563284;
        Fri, 21 Nov 2025 09:19:23 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7:9190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760ac62ecsm6186397a12.26.2025.11.21.09.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 09:19:22 -0800 (PST)
Message-ID: <0f575098-7474-4293-afd0-3590e000365f@davidwei.uk>
Date: Fri, 21 Nov 2025 09:19:21 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 6/7] selftests/net: add LOCAL_PREFIX_V{4,6}
 env to HW selftests
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
References: <20251120033016.3809474-1-dw@davidwei.uk>
 <20251120033016.3809474-7-dw@davidwei.uk>
 <20251120192443.21bd30d1@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251120192443.21bd30d1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-20 19:24, Jakub Kicinski wrote:
> On Wed, 19 Nov 2025 19:30:15 -0800 David Wei wrote:
>> +LOCAL_PREFIX_V6, LOCAL_PREFIX_V6
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I suppose one of these was supposed to say 4?

Oops, yes. Thanks, will correct.

> 
>> +Local IP prefix that is publicly routable. Devices assigned with an address
>> +using this prefix can directly receive packets from a remote.
> 
> How about this:
> 
> Local IP prefix/subnet which can be used to allocate extra IP addresses
> (for network name spaces behind macvlan, veth, netkit devices).
> DUT must be reachable using these addresses from the endpoint.

Sounds good.

