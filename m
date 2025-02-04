Return-Path: <netdev+bounces-162645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC5CA27765
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670C7165BD9
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CD02153FB;
	Tue,  4 Feb 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="N89QFI4G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF702153F9
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687141; cv=none; b=gPWVfbfF74Au6IVv09jhwGCqiF3jWivW83gGvl5huX8s6GAAZ7JkcaDKxLiehQ6f1CO5aRYM0/cvMBHtunm+NyD0nr6CR+93SqTqEYynwuXv+nU6DXHMF0t88f8upnrHITgQqfwHQXWLLR9QThFVtEgEni6ooR8MG1yHPZHPilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687141; c=relaxed/simple;
	bh=0PASJOGllBGLZ3gQhDBsRTrZlmy+W/LVjGQ8o/A868U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcfF/IUG/GF2Oe23nEUCVewXkEMS6I9iRPf2Pg0xkdJq48OA5i+nQOHkk/JNbIYpvmDx+DdCSxY7XNMYll+wQMqducwVEVfzjwbn3DZ3a9mvji7BXEXEudBV1xFgRwkoneWHxKHyWwOG4gHue0XST9Akml1y60uB4nDIER05hjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=N89QFI4G; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso12720803a12.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 08:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738687137; x=1739291937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OfcaS6F5B/ipM5xuopawfwMj67/i+N0X7XbgI7at4MI=;
        b=N89QFI4GKWi0Zj1mDGkcP8OwXXhzmq+fKajF6XakdVWZp+cHZEKD+ZJTCd3MSNKs4r
         Iy+L/bcIjr0pM0KpjZGs/kCgihuvJcSTBw4SwHx8UPD/ebj+zglZES/uQObWztsw9LmY
         H3xM4HQMRFlK7WyfeBIO7XHMYRcEE+JfDSdO/EFxM0KB0mAaoQ6vjuw1Z1KzUdRSxVlJ
         0tLYeiKzXJWc7ScW9DpWqFPdtoTAF7QaGKXqUvLOfDMsJovHXwOifzmpIKlPmyqp0AXO
         B8nQZXxvsb3H49YDMdWcatKhRsgTI+MctO2CcLHct6yISG6gy5IdWc4DSHFUUT4fd6ck
         CJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738687137; x=1739291937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfcaS6F5B/ipM5xuopawfwMj67/i+N0X7XbgI7at4MI=;
        b=U+gPG9uQPuo69/ON6d4PMN1jpaZ4UnnCKSjfJhkvy/yiubsGe7UkKZD8OBgWJ+P2Mb
         cBvRBf8TUQIMiG8MCETYyQcACz3P5lh2r4XszdrUG5Gike8ep2cMDh0Emna4Tnw5lnwY
         USkJvDFFxmG+sEUy4oY2uEZHeoU+6f6jl4KUhrTGr1BTOdWx5f1aMEJgJQl6+ak7OlMt
         3yCX8JW0KjAyE90CX7pCone9ZpfUVLPmU2NWj9Wo8QQLPxIUmMERy7S9Gtccy9byZjrH
         ZjsWXkCWGoEb+oI8P9EVSgXUyetzF3n5goJGCsUamU39/vM7+0KJrR1f5eZ6gVeVZkUD
         fIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU65AV/+1oQam3Kg6KD+9vUoY5bpO3nlJF/+8zcUUsKMwj76L62jQopl9wDeR+zn6GtSArs7Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU41Ml/dJ6qkySBa6XdIHe2+zbs7RPvgmaZS8Cz1z71ulH90m6
	o1UIJwDdmPkVmnTGr1Qhs6Jsrtoqa1yPh1D58DVvt6hy33BojWQtuUlbdBBmEgU=
X-Gm-Gg: ASbGnctS/Tfqs+v4ZXWbhbbkVnjdh8N6nbOxL57UROEnqVPzw4DdYdl9Vv0o0kLF22z
	IfGaD9ICPFRyWoEFmfbBJ3tXI6E6Dmh/PX9zuRKtNVRVEVx6wMlhxyMCHRmWybhZzM+MssE5CXa
	nD7CZK9hDsQx8qlqvLh7HvTYOqCPsUqFVuyW4Wd/4gSqAsdbPJs861Kmwu0nXC1OKj+NuUDYRZW
	+iB9NbXp/NcDOGGQOFwsj9obTaiUfNEAmdVT0dvJX00DTrA9u7//fNv6Vq0LyiLvG0I3qeKQAIX
	ybBsXsGbM2/12Gxhw1D92a0wQsZheS49y9we2eqfHIc5bVE=
X-Google-Smtp-Source: AGHT+IEj/A19q+tnjm1oSa7v8JSTclt7YnbJq4fgE+mQeliBIrb2/9tYjjzQlWHh03ls1ZrNoyekDA==
X-Received: by 2002:a05:6402:3806:b0:5d9:3118:d0b8 with SMTP id 4fb4d7f45d1cf-5dcc14cfa72mr5091031a12.8.1738687137420;
        Tue, 04 Feb 2025 08:38:57 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724055e5sm9991086a12.45.2025.02.04.08.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 08:38:56 -0800 (PST)
Message-ID: <66eeca24-0995-401f-8ca7-d0dbb86f6b7c@blackwall.org>
Date: Tue, 4 Feb 2025 18:38:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bonding: delete always true device check
To: Leon Romanovsky <leon@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>
Cc: Leon Romanovsky <leonro@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <0b2f8f5f09701bb43bbd83b94bfe5cb506b57adc.1738587150.git.leon@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <0b2f8f5f09701bb43bbd83b94bfe5cb506b57adc.1738587150.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 14:59, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> XFRM API makes sure that xs->xso.dev is valid in all XFRM offload
> callbacks. There is no need to check it again.
> 
> Fixes: 1ddec5d0eec4 ("bonding: add common function to check ipsec device")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> There is nothing urgent in this change, it can go to net-next too.
> ---
>  drivers/net/bonding/bond_main.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index bfb55c23380b..154e670d8075 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -432,9 +432,6 @@ static struct net_device *bond_ipsec_dev(struct xfrm_state *xs)
>  	struct bonding *bond;
>  	struct slave *slave;
>  
> -	if (!bond_dev)
> -		return NULL;
> -
>  	bond = netdev_priv(bond_dev);
>  	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
>  		return NULL;

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


