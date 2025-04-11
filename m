Return-Path: <netdev+bounces-181551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26875A856F0
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CECE1BC0163
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1642980CB;
	Fri, 11 Apr 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Cg7iEOwC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB1290BD6
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361180; cv=none; b=nPoLaIJa71SGu/lwzJCkjgMOOLrPy5X2KIxCAshi/x29ZbxagrbA2E07GTkd+3RjX8/7h8W48XOV3js0jpyT6rDBg+4MHi4QKPrfH/xCHZe3HSzQB+RmBkHC4gAJGmYJ9O79YVrujw3rkDczH8PxgysSEAah5CCZUorN3IiwTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361180; c=relaxed/simple;
	bh=sxso+kVbfJAi9DIGOHSC8fpzXVVfBFw5jhcrBoSAr8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBYPkdHJceOLM0hC7rcNsMlzH5AKxuOY9SB9JIA4Wbj9MECFcDorAOwFhC18R0JlNjE9xY2FV5Uj1aoZPrBKvzmX0B9ylJBOw4SrOXBPTyy9PVtpghq3rTyxfVKiEPRZUgI/E7o54c2JbKzviY+WxZVH4WmxT4OhLoBuCKwk1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Cg7iEOwC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso12324925e9.3
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 01:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744361175; x=1744965975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FIH33XwPVxisy4YuF3BBBxAiOFW2ENyBMF7nIXApkn0=;
        b=Cg7iEOwCz2GMwSWOV/+NVmN7IfshmfMMsfA1V+ICnhDf/pKqflRUqApkiEIUI0c/tI
         T+qrMGuEz/vayY/ILlWyztEXko+hGrcXKReLiR1cq3aLIzGml7A+W34EXiP85o4x4N1R
         Y1Qai1TaGcoEHNE8ETBO+HeMKobVwmvJ/g9SKDY7Qqqy/m8ZawjC4BvYUNOnoiWvMD0A
         lGn7FPR6tZ02FsIeHBfHIZrL2IY0UTUyKmJx/8EqA1gNqS0qf1owCS2bkGyI7cX9N4uT
         +oYq05RU+zhwagLzMa+muqXAsmvzDSV/H8uhLY1LcD4lcpalcNzlBNYXoxslY6hoEeZW
         +dpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744361175; x=1744965975;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIH33XwPVxisy4YuF3BBBxAiOFW2ENyBMF7nIXApkn0=;
        b=AAtaX5jGufXXGVUX0peMQWdk6CpzR2uhOxc0hFXhyni+GSv84wLcepTumZp6fVcUEW
         uzO96stcDrKu4m+MTXkPTCzMICMyldMyIlTUEPk0LJnsFSWzntI0eolJano6bmeyS59r
         WymWvRTcQN6kXIBxVtFh7SI96WSbw/8XEF/cgNjJffFTEKxhTo+oXfUI6LJ3K4xMRHNB
         /jr+fbFui0A9yIkX+sWY4TlUz+Hyd4UkL2HZ+0zY04T+1qA5peHQ6oMuKEPfa+KitM3y
         qGksCKb5CmzkQGFRM97nSF3U7nXLpaNAZBvFBymmdUzYnpJtY6P/HVUU8bK89YzA2vSJ
         J6Dg==
X-Gm-Message-State: AOJu0YwyTLLoMDTSSlA+BWKB+ARZq7JhDGvRcWm84JHsdaNqxGP7ItXO
	MX+KJVTD4Qt1Hi9kHXIzUS4qoJiWGuPd8MYJG/BTBeGpwoDZRJfviakEl7Y6NeQQ2UCiBvd+ziA
	lC2MKKXxZCezaLh5vVPbMH6VVSKL5Y253HoHDhrROCU/5esI=
X-Gm-Gg: ASbGncuM0ga4hobMpTV9RRpbBzgb+rhi9fA4kzA2kSzWNlhWEgAhm1ueod0iBtSpttw
	Vk0DOQ/L6RbkcKtus+Q6KPesksfzZkuhmjjJN7eYFxytIuhDvNxInUMS05A7qFQEP71C5SuPZZN
	1j8yzqkZd2w49tH/JbQOxrD2/6yk54A0xDHcbj0sVZv9CTTBZ7gsf8LnRegSy2wZ7xjH1IS4KuH
	bEZtmZ2hNXz+Wa135ApDmkCSTNTVDH8eq/1XuKSsi0pSez9vcV/vuRpY7rGQE8YCV8An/Ps47+A
	Tn+I3Ctdi6vQXOa7nSwJ8agbcz2UWHunbLCNyVGwbZRH8BbTk1nvZOyu8wfOiIUKD6yc4+L1VXl
	6HMI=
X-Google-Smtp-Source: AGHT+IE6oI30N+UvufzHNyAwyyReLUJoKKfM7r3c3yqJ2rQueKGdV8mtdHpGdKvpB1e2cp9zWVWkgw==
X-Received: by 2002:a05:600c:1396:b0:43c:f8fc:f686 with SMTP id 5b1f17b1804b1-43f3a9287a7mr12879505e9.3.1744361175439;
        Fri, 11 Apr 2025 01:46:15 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:e8be:40be:972d:7ee4? ([2001:67c:2fbc:1:e8be:40be:972d:7ee4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075a65dsm82676205e9.31.2025.04.11.01.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 01:46:15 -0700 (PDT)
Message-ID: <989a0a56-6891-4ecf-951c-81e7f9c0d7af@openvpn.net>
Date: Fri, 11 Apr 2025 10:46:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 07/23] ovpn: implement basic TX path (UDP)
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
 <20250407-b4-ovpn-v25-7-a04eae86e016@openvpn.net>
 <20250410200733.4fea860f@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250410200733.4fea860f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2025 05:07, Jakub Kicinski wrote:
> On Mon, 07 Apr 2025 21:46:15 +0200 Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
>> index 97f6a249b09fe26cc6d078d80abc955f8d35e821..200036757fcd0a7f2ae554a1e3a3c03915c0e32f 100644
>> --- a/drivers/net/ovpn/socket.c
>> +++ b/drivers/net/ovpn/socket.c
>> @@ -185,9 +185,8 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
>>   		goto sock_release;
>>   	}
>>   
>> -	ovpn_sock->ovpn = peer->ovpn;
>> -	ovpn_sock->sock = sock;
>>   	kref_init(&ovpn_sock->refcount);
>> +	ovpn_sock->sock = sock;
> 
>> @@ -31,7 +262,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
>>   {
>>   	struct socket *sock = ovpn_sock->sock;
>>   	struct ovpn_socket *old_data;
>> -	int ret = 0;
>> +	int ret;
>>   
>>   	/* make sure no pre-existing encapsulation handler exists */
>>   	rcu_read_lock();
> 
> Some unrelated-looking chunks here

ACK

> 
>> +			dev_core_stats_tx_dropped_inc(ovpn->dev);
> 
> Since you're already using TSTATS could you switch to DSTATS
> to count drops, and leave the core stats for the core ?

I see DSTATS was implemented mid last year - I think we just didn't see 
that.

I will switch to DSTATS like other tunnels have done.

Thanks!

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


