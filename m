Return-Path: <netdev+bounces-141930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7CE9BCB1F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB0D1F23E68
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EA81D3184;
	Tue,  5 Nov 2024 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI1xhvXi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D0B1D2B22;
	Tue,  5 Nov 2024 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804395; cv=none; b=X7i7152pnkwnI9wLmMyKk9vnGZuITSf8g1MhNz7eg32X6ohkoYZ4WUx3EPwGeV67nzupGB5ufwpuutcdofF07Znd96dn7NrhoHVxUnHgVZgX9gMFEBr/JYKrVQeHpFiCPBy+vyVv/p8B3ss8f7dUCfvfTvrh3iVUTpAlx9n3SDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804395; c=relaxed/simple;
	bh=X2aiaB2QLjmzxEz4BJTmcz5/caU1jLhjakEdzScTUNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgYgmL7Y7cEMDILS1/yOkE84PWZhMz/IaYCV5ccBlgHi4YbHr7N/VDEyvE3YBaJScbn3iGu73V4M6ORnC6xAQwAJ2G342X6KbkgHbCgGw7ClovQFVvfljBhvOsfGopZkawpfZfoQnOB2n462RYJn8e5S2c24DWqiMxLSNu5HelY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI1xhvXi; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f1292a9bso6067725e87.2;
        Tue, 05 Nov 2024 02:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730804391; x=1731409191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dxc2q9MRuwdMNmLTNPGQBcREWP4Y2xIFNTUX1iciaC4=;
        b=EI1xhvXiq+qZH+OEBYJ3V1kR2lYkJfPbwqQu/TtWgcsEf+LPPWQIdONTvHtH6k+M9J
         75f6HVODXmFoNZrLCNDGtHVbesVm3JxL2l27xrVIUKCKokvZjC6NzPvRkYuM1JbZ2hPX
         pEtzQk51yjQS0TjdRlZWBtIfvMoQ+Dz+g5BYNkG86XWE1t+Cp4Ho8i54On4fRdKSZn5q
         INi8AJnkQyST9hZ95WTZr+gWqcf0xbTWl37RFDXFV0W4pCMlxfd3PxK26iAGn6WzoOxn
         5bTgsKJ4pBxn/Dm4rJGpw97PNtBw8+EuL0WQlzUi6vFZiUbDKJ3J8f4PfS3WftK3RFto
         mVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730804391; x=1731409191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dxc2q9MRuwdMNmLTNPGQBcREWP4Y2xIFNTUX1iciaC4=;
        b=w3G+TiI01UFPk018ccXuiDUVOiB52IzSqxN4HLojKYdCxF8in4D6AvO7hJArikPOyi
         iOq3oJcETA5zo4zBc3jtrIMBFkrQOBOg0O9w8dHC+VGYpiWhgnup4kSgnY1S8Iz8Ndo0
         DpvW7vptks4saydCm+bSLTwB5nZgjCOcsvFUiVHLB5ajbmx3o/OZkeNsd7JnfBzeUhuW
         87OwLBVRO9GfIyJdQT2TgFaWtGnmlP5MfwG9GYCd/v4CEm5zlZh7/PT+1GamDEHHHny2
         lmcR7Dn1f34Fxp6SdXQIe96BoKWD3R9rol9k7n3066/B9av5Tvxsd8wxw3hzpH5rlbDf
         hWCw==
X-Forwarded-Encrypted: i=1; AJvYcCUr3ZtqsZ+XvFvPsf7EB15/V9D+Js5SNHDkgCK1QzfBiJ2/wtOA9RY3XRDJZDlRFgE24oE+Rgg1@vger.kernel.org, AJvYcCVKklOTX26mA4BGg62YIpT4Kfc2pqg2aDZkTq/3Go5YeyptdSR5gZZ9gH4kKfaCKHmHwuWfzfGJoJ3UN60XXJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+EQaXqKeY9rVnHOPnQnRbL3taVMYGPizkCYLyCV2MLcqi4HnH
	bVcTDGPlfBQTe9mtS1SvGCQOXixx3rTdBYHrVHhp4q7u48WTg66y0Y/1dw==
X-Google-Smtp-Source: AGHT+IGq9JvfEkZmwPMa2lZzGZKak8jTwKZkT3pCyrwQTV+HHuGBoCtanFcoeGc8mG4qdJKn8Yefwg==
X-Received: by 2002:a05:6512:2341:b0:536:554a:24c2 with SMTP id 2adb3069b0e04-53b348c8978mr18599811e87.13.1730804391074;
        Tue, 05 Nov 2024 02:59:51 -0800 (PST)
Received: from [10.0.0.4] ([37.170.92.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5e7c8bsm188562115e9.26.2024.11.05.02.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 02:59:50 -0800 (PST)
Message-ID: <7a2e5da2-5122-4c73-9a94-20e7f21a26f5@gmail.com>
Date: Tue, 5 Nov 2024 11:59:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/5] rtnetlink: do_setlink: Use sockaddr_storage
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241104221450.work.053-kees@kernel.org>
 <20241104222513.3469025-3-kees@kernel.org>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20241104222513.3469025-3-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/4/24 11:25 PM, Kees Cook wrote:
> Instead of a heap allocation use a stack allocated sockaddr_storage to
> support arbitrary length addr_len value (but bounds check it against the
> maximum address length).
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>   net/core/rtnetlink.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index f0a520987085..eddd10b74f06 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -2839,21 +2839,17 @@ static int do_setlink(const struct sk_buff *skb,
>   	}
>   
>   	if (tb[IFLA_ADDRESS]) {
> -		struct sockaddr *sa;
> -		int len;
> +		struct sockaddr_storage addr;
> +		struct sockaddr *sa = (struct sockaddr *)&addr;


We already use too much stack space.


Please move addr into struct rtnl_newlink_tbs ?


>   
> -		len = sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
> -						  sizeof(*sa));
> -		sa = kmalloc(len, GFP_KERNEL);
> -		if (!sa) {
> +		if (dev->addr_len > sizeof(addr.__data)) {
>   			err = -ENOMEM;
>   			goto errout;
>   		}
>   		sa->sa_family = dev->type;
> -		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
> +		memcpy(addr.__data, nla_data(tb[IFLA_ADDRESS]),
>   		       dev->addr_len);
>   		err = dev_set_mac_address_user(dev, sa, extack);
> -		kfree(sa);
>   		if (err)
>   			goto errout;
>   		status |= DO_SETLINK_MODIFIED;

