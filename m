Return-Path: <netdev+bounces-211888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FA4B1C40B
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 12:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43759185CA5
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E9328A1FB;
	Wed,  6 Aug 2025 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="JEehZpJQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F3279DA0
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474921; cv=none; b=iX372InPGGZuc18EOU+q12zzvmgiAkXNrjFuGqNqlVqeLJ/4uLeeyilzADxS4rmeajwRkqVu4hmr3w8EZpo0CQet+3P0xhKCEFwBB/AV7mDMswWgXt8AvQfESvBrAC94VRj8FXd5GULhGdEPMA7zpXOlQtrBZdfiq/vd6V/h1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474921; c=relaxed/simple;
	bh=U2JrnGb9Xf2jRF2IOWpWZy0sZRe4JnvPHaey0BJseeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7qgdaomF9D0xRWc0mw53w4BsGw05B6q96OAVnC9yDT6uLRPdGkaMzy1r7AP0BeBxaltHb3f76zFqQI7DbiOjw/OTfQT3o2gWwgw2M547h7N+Z8TK7dCPIJZBIYxHwjvIMzbH/j5IkqY3bryeGB05nOJuK/GJX1fn9jflt2YDJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=JEehZpJQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so11773673a12.2
        for <netdev@vger.kernel.org>; Wed, 06 Aug 2025 03:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1754474918; x=1755079718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PY6/G7pBaRSasiyeewCuatLBOeurRAH6HZiC5wn0WeE=;
        b=JEehZpJQEATKaIaQnM/2drXK1ImuKA91HPxCTwHvVubLtheEmdso77Ow8W/d7HbpTe
         KlPeIILPa69Bn9Peu80L9WQEN0J8jPzdd3a9wmld5mSIt7j8+NspRqGCxTyniB8dZHoV
         3EaRAxcXc3Oh3i67LzjbpNGNTw04J8Va23Z89Fb8fUr35U0dCUGuC8Da+m0FqCuoRTAJ
         ZIb7WrsoXCI5PUpkLvO8/8bX4VZW2LpTKNYxS2/+qfkS/Lu9c5UAfJOkLaatTys7Tky5
         R3uK0n9/hpy8ZMV0x5XFX8Zh4xx0DINLf22DYel4zeTEMFOdJtt8PrMRlDf45QWfhjpY
         dhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754474918; x=1755079718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PY6/G7pBaRSasiyeewCuatLBOeurRAH6HZiC5wn0WeE=;
        b=E3A0EEvQO95Pupdjk4430EIhESuDeNZw1Ha+lTG/hfxFHcdlUy6lSGSN5pm3P1Su1M
         RDeMTP44OSRV4G8wNZLe78sj4jq2H6UxniaUqC12McvlcIp4C6djBAu2woZazf/P8pVU
         H+sBcYIwJCbNOM5b4stfapL9cWGZCIFFD0SC/E8+5hYKZnqCAJUmWyCNPRECyYq0KnEk
         qlLw6ENTr9oOvrlLwrfycK2O8LOY4kiVAuGUvPh1Kb686ZhXhO8AJa29Oc2XHD7KdUBi
         zz/5saoA+74F5Ws+qQH85ngTUOrNfMWbxSWwmS+6L+R9j2LH5Ib4SnIEeSSpSD12JleY
         i9XA==
X-Forwarded-Encrypted: i=1; AJvYcCVNJ7x6IGlqhMfFf7jAaxD576o//Nk81tny9q5+nH/bI1jK8JOP335oJ5VrzQp70b+xzO1IUF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcT/yAHzDxXtpABdvISPQmDfZtG0VpUPrfNDuiRCb7tZm5nfcx
	dubYZVCgbCRnUXsBk3FzW71wZqRhmNxEErzZUqTkFm+jRSvRX6Wf5ukuxlp0oFETajk=
X-Gm-Gg: ASbGncvt8BgVkoj7utRAQ9pex++xRKAIkUF+hVPtr5YEqfYmfq7f3m7yyxxx+GS8VQ6
	e2Ryx7oGCY9kAQ1vNZLk8EW4TgBYZ1rJbodhNn7nNKJ/pTeTyG9ZmptweCZOxTUnYOvOUwC3IDU
	ETY4YIcaHNdgmJh1VAuszRGqdQIc+bFvJiCrA1aBPmGu7RdUXxWnWZWgi++3xyLLJ3nekAWpP6e
	2K63h/R2TPc40/U79zMt4gowXSfYEh6K37qtmbZI50lRKLbeNDaGT2+yf8KH47Yj5wC8mwRHKx2
	WhEyZEPcDoCf3JOKfB89GNlKwQ961BgLnOsaTe1BNmeMfI66VkjYTqes91/NvIrveHnjjnYCB4C
	yNHWKWoEFoWFYhTWyp959od9T6Bq6J5Hr2LjODa7Hb8R/vaVnudfSNQ==
X-Google-Smtp-Source: AGHT+IElrfPbH/2D55e2rlcv5FQ2+nV/avO3uQbNHxygYaj/il5iaACu/FDGxguffGR+FDFOFBDWOQ==
X-Received: by 2002:a05:6402:1d4a:b0:615:dc48:1e9 with SMTP id 4fb4d7f45d1cf-6179da2be8cmr919460a12.15.1754474917669;
        Wed, 06 Aug 2025 03:08:37 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f16062sm9845241a12.18.2025.08.06.03.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 03:08:37 -0700 (PDT)
Message-ID: <9071898b-ad70-45f1-a671-89448ea168df@blackwall.org>
Date: Wed, 6 Aug 2025 13:08:35 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: fix soft lockup in
 br_multicast_query_expired()
To: Wang Liang <wangliang74@huawei.com>, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com
References: <20250806094941.1285944-1-wangliang74@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250806094941.1285944-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 12:49, Wang Liang wrote:
> When set multicast_query_interval to a large value, the local variable
> 'time' in br_multicast_send_query() may overflow. If the time is smaller
> than jiffies, the timer will expire immediately, and then call mod_timer()
> again, which creates a loop and may trigger the following soft lockup
> issue:
> 
>   watchdog: BUG: soft lockup - CPU#1 stuck for 221s! [rb_consumer:66]
>   CPU: 1 UID: 0 PID: 66 Comm: rb_consumer Not tainted 6.16.0+ #259 PREEMPT(none)
>   Call Trace:
>    <IRQ>
>    __netdev_alloc_skb+0x2e/0x3a0
>    br_ip6_multicast_alloc_query+0x212/0x1b70
>    __br_multicast_send_query+0x376/0xac0
>    br_multicast_send_query+0x299/0x510
>    br_multicast_query_expired.constprop.0+0x16d/0x1b0
>    call_timer_fn+0x3b/0x2a0
>    __run_timers+0x619/0x950
>    run_timer_softirq+0x11c/0x220
>    handle_softirqs+0x18e/0x560
>    __irq_exit_rcu+0x158/0x1a0
>    sysvec_apic_timer_interrupt+0x76/0x90
>    </IRQ>
> 
> This issue can be reproduced with:
>   ip link add br0 type bridge
>   echo 1 > /sys/class/net/br0/bridge/multicast_querier
>   echo 0xffffffffffffffff >
>   	/sys/class/net/br0/bridge/multicast_query_interval
>   ip link set dev br0 up
> 
> Fix this by comparing expire time with jiffies, to avoid the timer loop.
> 
> Fixes: 7e4df51eb35d ("bridge: netlink: add support for igmp's intervals")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/bridge/br_multicast.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 1377f31b719c..631ae3b4c45d 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1892,7 +1892,8 @@ static void br_multicast_send_query(struct net_bridge_mcast *brmctx,
>  	time += own_query->startup_sent < brmctx->multicast_startup_query_count ?
>  		brmctx->multicast_startup_query_interval :
>  		brmctx->multicast_query_interval;
> -	mod_timer(&own_query->timer, time);
> +	if (time_is_after_jiffies(time))
> +		mod_timer(&own_query->timer, time);
>  }
>  
>  static void

This is the wrong way to fix it, it is a configuration issue, so we could either
cap the value at something that noone uses, e.g. 24 hours, or we could make sure time
is at least 1s (that is BR_MULTICAST_QUERY_INTVL_MIN).

The simple fix would be to do a min(time, BR_MULTICAST_QUERY_INTVL_MIN), but I'd go
for something similar to:
 commit 99b40610956a
 Author: Nikolay Aleksandrov <razor@blackwall.org>
 Date:   Mon Dec 27 19:21:15 2021 +0200

     net: bridge: mcast: add and enforce query interval minimum

for the maximum to avoid the overflow altogether. By the way multicast_startup_query_interval 
would also cause the same issue, so you'd have to cap it.

Cheers,
 Nik


