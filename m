Return-Path: <netdev+bounces-169970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 966C6A46AEF
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48553A51B8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A86237A3C;
	Wed, 26 Feb 2025 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="IsHfiaQS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF7722540A
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597863; cv=none; b=G7NMD8Dn7mv5TiP2omefz8rUHM9Ed6aO2uO0zPGY6tkhxnZKumBPAwh/kybKtB+AiebufyfGllz0zoy75qFsc07/BLLkqxX9vcXoz5umOFYYlqkdn333xNlTED18jt6wKBsXn08FhAtXD2YSDH9rSEWTWPdOURJuM0p22JzuQdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597863; c=relaxed/simple;
	bh=+MPxJiszOeCmFsn8+9MqxMgk4It36YrHrcETxZymxZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWG4fRouxeeRKV0pzxM6fEs2udq2nCcIZk7AdOobK0UFD3L4MECjQKIJn9Dq1TvkXnGPI3XsJNCCCjkR7ZNL+Lw+ZNeJh2gehqSsZu/eX7cU5hITNbhFRQO3/28C3fnhflgrEwxclPRQHEV4bZEekEPmXZU1gsNLmPY2ePW+KKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=IsHfiaQS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c8f38febso1910365ad.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1740597861; x=1741202661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/sflnpIC6yKwseTfHm3vT9z2UOLJa7dEKR1pgDETj+Y=;
        b=IsHfiaQS04ZUz/3DCH5S0DOwiRC7GjFG/TLqvpLRYM6MtZgPsmMMchJo7hM34E9dzp
         GYY1nVx32t9BWNt4Cge9fW7lnvbsmNg9JvUk8UJRdnw7+4pC9Q8OxIY5zhd73G/T9t3f
         1FUy8KyIGv1r6p/3lonrpTJ0I969LTDxq3By3DoslF0xmJ1kD983XlJBMA+Q7o3ipqjF
         TGAEobrE1aJwwIaomr8zPADA8ZUSOULcM+nfxR8dpkynLZfUxNP6j1+AWcyyTjqbg4lu
         cj1LCALJNC7GvavlWfD4SwW0ScnPMoT66gRBPpyhgiOUJKsFMoDBWJvRp2A5PRzkjtLZ
         3+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597861; x=1741202661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/sflnpIC6yKwseTfHm3vT9z2UOLJa7dEKR1pgDETj+Y=;
        b=OapEY7628cZ554YUudfug7EcBWkant6ucy6cZlwppzESqUjfPKMNZUFFxOFuIBZN6J
         Y8IcMpaxhdIvlKPNCGZxEagIalLtKPcpmBid7KyD31BqefI7+FYdyDXZxDByD2dhHMW2
         7bQ2fLKiaeWgJvf7HWJb5wcqsTHh2Wc2vP+ZLTgiYLt+FH9MAoIuqunxlMuPzfabj3IW
         tAcwTdzV2DNuRaOGGgyo/IOWlT0iuzXiqaYBIKlPDrQhZpcXIpiy1kIXtkDYVoJqpOGp
         T2ee8xFtqka2aT+FNqvKXooab6h8C2YDO6XORR23Ndghqxwy5zmBwJK9lZRou8w5My+L
         dfMw==
X-Forwarded-Encrypted: i=1; AJvYcCUCBVxgJMcCkflFO+I4AtU1AWRzjlpX+ShwhPX+SDwyCgm9izcWdVIyALWxIrQBNpMO6t2GbMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jBvsHn5ujMkQGr66TF0Cub+emiXX1ZHYWZdKaH/tDH9QHOfA
	r0iVQenGCT3+sdMmx/j5LmyD5eQpbgebYqa4idgCRF5y9OcedkeYeFNghNYkUNU=
X-Gm-Gg: ASbGncvJCgDhw62icNI7T2fylucxrmPRywvGnT/uDKQWLvCXjs5VHvwzOPEj1luC37d
	+e+oRILognR+IyEyLKybUM0FiSU6ei+2lhveRmAFzBvjokUdU+7AWmvEl1ta3aNO4R3I1Nwc8vC
	8k14wIUeNTiVDbmKqwTKmzNMbXVbFei+YeNx65NyLOukWyJy6xH4TYFlzeQkR4fEIeQ07jlkJ57
	7A1AzEN2dwDN/aE/UnTaCpJ6uqlWh+JlWNdCB9FWE8UxQosFWMqyPqwlm2U5KZGu4r/ytfdELVq
	E2/i7fueN/4+f1BMtd38RYsKQcnr8h3hdUSWMlxW/8JPocw9fv2sOjXdzOZTi+FW3jbJ8g==
X-Google-Smtp-Source: AGHT+IG0kO7k4eegwSBS0bGAJzlZ+5QciSS8EYAlWnYhxBYs9Vs7ZY1jsyhgzaQSgGTs4piCQxxvzw==
X-Received: by 2002:a17:902:f60b:b0:216:725c:a137 with SMTP id d9443c01a7336-2219ffb8b58mr407759205ad.28.1740597859464;
        Wed, 26 Feb 2025 11:24:19 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:18cb:90d0:372a:99ae? ([2620:10d:c090:500::4:af20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0908eesm36470885ad.124.2025.02.26.11.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 11:24:19 -0800 (PST)
Message-ID: <35c55f5b-7c1c-46cf-8d6c-50ee2479bbda@davidwei.uk>
Date: Wed, 26 Feb 2025 11:24:16 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] selftests: drv-net: Check if combined-count exists
Content-Language: en-GB
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250226181957.212189-1-jdamato@fastly.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250226181957.212189-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-02-26 10:19, Joe Damato wrote:
> Some drivers, like tg3, do not set combined-count:
> 
> $ ethtool -l enp4s0f1
> Channel parameters for enp4s0f1:
> Pre-set maximums:
> RX:		4
> TX:		4
> Other:		n/a
> Combined:	n/a
> Current hardware settings:
> RX:		4
> TX:		1
> Other:		n/a
> Combined:	n/a
> 
> In the case where combined-count is not set, the ethtool netlink code
> in the kernel elides the value and the code in the test:
> 
>   netnl.channels_get(...)
> 
> With a tg3 device, the returned dictionary looks like:
> 
> {'header': {'dev-index': 3, 'dev-name': 'enp4s0f1'},
>  'rx-max': 4,
>  'rx-count': 4,
>  'tx-max': 4,
>  'tx-count': 1}
> 
> Note that the key 'combined-count' is missing. As a result of this
> missing key the test raises an exception:
> 
>  # Exception|     if channels['combined-count'] == 0:
>  # Exception|        ~~~~~~~~^^^^^^^^^^^^^^^^^^
>  # Exception| KeyError: 'combined-count'
> 
> Change the test to check if 'combined-count' is a key in the dictionary
> first and if not assume that this means the driver has separate RX and
> TX queues.
> 
> With this change, the test now passes successfully on tg3 and mlx5
> (which does have a 'combined-count').
> 
> Fixes: 1cf270424218 ("net: selftest: add test for netdev netlink queue-get API")
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  v2:
>    - Simplify logic and reduce indentation as suggested by David Wei.
>      Retested on both tg3 and mlx5 and test passes as expected.
> 
>  v1: https://lore.kernel.org/lkml/20250225181455.224309-1-jdamato@fastly.com/

Thanks Joe.

Reviewed-by: David Wei <dw@davidwei.uk>

