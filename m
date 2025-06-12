Return-Path: <netdev+bounces-196895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B95AD6DB9
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E085518823B5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6765322F16C;
	Thu, 12 Jun 2025 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="BHusKA3f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594822423F
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724131; cv=none; b=XPmaflalUNHTJWdFG0LET+mqb/lx2rtcdpn4DCTkcygRfAUkVAjHg0neKl2syoVjQnR12+UWFYbclV7mYisB0LNkYXk9PKrgdYg57O0fRcvD5yYHwYE8MAkLMy/p29LXIhNNMJ1BUfY8/wofmocG5YVOz9IbC/F2xMfu3Z34lHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724131; c=relaxed/simple;
	bh=3GWmdbB0w1BSvmxp9Ey36VmDGkdHwgulojzxWn96ZME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjwEFaUjvx71j0xNaCeV4+FYjjkoNX+M4bupFuvLdESAjJb1AcydseK3yfpm8dg+HGNIkAsK0dYz5biAR/wTvC3HTTSsUHT6cYEGzbLuXEyCUuYLLxb2D+F8MYOX3RHi2K30gdVHXvBO397prlKVcURCsRnqi5++45BaHj9H1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=BHusKA3f; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5533302b49bso731398e87.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724128; x=1750328928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+W8IEXCelRHkbXSn0HF8wtnz86HqtGZfQIOxYUfrenw=;
        b=BHusKA3fyzgIYJJ/yGriUs4PmeRUz3qdDItNSV4lwWckaMvqsF440pWwOYioOdrSjb
         CcWm7nCiB5T88ViuZZP0jFpmJNVTF3i0aXQv+4cxScdwIs/adNITqLa4mzqtCQZGTT06
         GgtW8xWSloqMrtQDV+LVrSM37E/eNJuZKQMlC4CgybaDtu/Nz0BJWAu6e8SPEifSz6vM
         ALlpInmx6Uy19aOQ8CpXtHntsAuj1+ov5Q9kSNKRYppyy7Kye5MeSokS6hpotF+SiOO8
         vSrWO0M8qDIqPY/xQEjPoJ+9CZBdDUzjrk766q/oKMQGxFQnMSW8y3ehcacqNzDF4fjJ
         9RZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724128; x=1750328928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+W8IEXCelRHkbXSn0HF8wtnz86HqtGZfQIOxYUfrenw=;
        b=wXMpfkHpCQPUYfhCyFVEbLSw1zOTR40jt7nuHXDmLlkz/TFfrMCsxUQO8jSMEXgnRq
         4KfdKa/+hACOAGpTUoKxfuOIwKyymCBPhQfYmaBNIFI+OtM2iAObFywV1LlTaYvbzOYl
         biGvKRPMSRbxQg8TcJVu0enlz0jF8Utv8oHfM+9qK6O6HzFunW5Xzoi6wn4MAnBCNLEb
         eilbcliR/A4twusz8EK4cz9ofKfKJBXvnlZV0MQVX4MYTHQj/4fEhaCfWRG/r4HOE5c8
         5Ykywzxhip8j1Fkp6Lgkg2QnCBE/r/M4pBFfMmVf37akF+QxMviTKaHDTFAtq8yNuSYP
         KuXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSihy18BEnXFLnp9MKg8b3XB0+HAY1vJyzi8tSQfGqW4lTPlI/yIPtk1hw7nIKpeqtSfT52DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxavtKBurloaUGRUCmiYayRBgZBJlfqAr/pi83+IoFPQ2/5BjYS
	UQrIikUeKzfPHVQv1wKtlnYNoH6FRAxR7dAOEXQAjIIdYfijRmnb8XUVVxwwV4z27EM=
X-Gm-Gg: ASbGncseek378PQuV2iXwG8E3gGgeuQbS9/ASZeERWU3Il3qNT7CO32Jaq37HqM2dYA
	ah7zZ+kXF6R/X/fNiKW+lXFNuBSh8MOddNrEGpzhjmV+GNonuEkfKHZLmn9pzRz/lsjzOjWIAY3
	urTEGmKWp7cwpUplbgbxl/mADOCU4t4vm7PU5nIFQNQRrgSppp2OanbXp6133Hak4k1nx0G1Hg9
	iobQE2AosXQUCXreW5fMaQy+Bb5EM0wWOjKRkjabaO90KznZDjNyAGW8IntsvFt7jYLUsJHo70D
	DC+aOK9077gDtpGdR4NGrYoPEVJZwQdaLFSPm/aFssMgdnBZbBoZqh53pvfNL3XiqDsY+NwIi9D
	+x4jWwISp6Pg8aR8hkXdAtZw5V7gRRkw=
X-Google-Smtp-Source: AGHT+IFLFsCecT/gY1iosbqVuRFJ/vA4oxF+8N7npDlqGHibBF7MfT+pUgVFE/0M5Y+0WF+tBVSZ/Q==
X-Received: by 2002:a05:6512:2310:b0:549:8b24:989d with SMTP id 2adb3069b0e04-5539c051365mr2146356e87.0.1749724127660;
        Thu, 12 Jun 2025 03:28:47 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac11678csm67683e87.9.2025.06.12.03.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:28:47 -0700 (PDT)
Message-ID: <09c653e7-308f-4075-a3ba-892846e1360b@blackwall.org>
Date: Thu, 12 Jun 2025 13:28:45 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/14] net: ipv4: ipmr: ipmr_queue_xmit(): Drop
 local variable `dev'
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1749499963.git.petrm@nvidia.com>
 <1de06ab553e52f9303761764f1ede7e03715a773.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <1de06ab553e52f9303761764f1ede7e03715a773.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> The variable is used for caching of rt->dst.dev. The netdevice referenced
> therein does not change during the scope of validity of that local. At the
> same time, the local is only used twice, and each of these uses will end up
> in a different function in the following patches, further eliminating any
> use the local could have had.
> 
> Drop the local altogether and inline the uses.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/ipv4/ipmr.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


