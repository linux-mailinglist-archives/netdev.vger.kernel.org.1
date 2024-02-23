Return-Path: <netdev+bounces-74284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC660860BD4
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8461C24ACF
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 08:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD49E171A6;
	Fri, 23 Feb 2024 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5kNBBqy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330C818E1F
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675820; cv=none; b=jhslP4PSj7sxsg6p2IuQt4iWigQHBG1cNG5rT3eZGcY70HVeuUB9Gl+hnzUjW9tpH59PTfcizHxJ21LNM81tX4gWfDyNFJjOS7Q7dDWSNA510xopfqLLg1QX+umnxdcH1GD/Q0hMYOR5uBUrpCGUPgvKHVUlbzUdJh2r8Qd+/K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675820; c=relaxed/simple;
	bh=g4fEFJgj1LNifD+bFXhI85PDQ62DDkon3OyLPe5DmNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIkGXarI6D1xnB4S5pxOMsO+yxxUIBoK49huBvIcXt22BULZYgW7vCid/e3mdE9m42/N6lOgUePSRwJGaxcCFOZEbHF5zKxkQ8hWQnLVzTehWjpz5DodiiQ9ytsGkymzEA4ZTjuWV0vDTYtmSRopctuZEFhlSuq4C6WHw6uS+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5kNBBqy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6084e809788so449887b3.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 00:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708675818; x=1709280618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9SZ/l9JmELO0y3E6GKljNPAvT+MO258Yb7plVrChJek=;
        b=G5kNBBqy1XaZp/ggX9Fk8+MrwJt5UfQnKj5CA+fRsPHUKJk8O8WEKXYZeYV/aZG7rn
         H/9w/pWWab/qaVwdWJSxUlRrC1imUWGXdRBD2FabKGo/dylygBcE/N4UBhK3XZC7Ia1y
         sKzOLb+jdi0+Ss+V3mt2P7xUDxGcw4amB/Lqizg0ppLqhLf5iXN4cpYqDFTSuNzSxL1y
         U2elcKiPqMx1biMeJm8uKIVuU0d1MqvgA+f8tWRFKHweuHLWa5bjXmGE8Q3PoowPat0n
         f1aGAKakXAy1lTGb3MI2iStxBiXYw+tezl6Z5JgXLnzuHsup01Btpki2q3ryXU1WQI44
         rTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708675818; x=1709280618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SZ/l9JmELO0y3E6GKljNPAvT+MO258Yb7plVrChJek=;
        b=pi1Luhf/qSMQP/XVlpnTRVtuTv5MajMjAOpskWsHStetFBxb7d4XAIYiW3kcua4F1x
         C9gwFbCWJe965HHhfpdMeMdQC277gGeB3bABw3fHfar3gJUt/qfmeL/bxt5cP+Z/yrz0
         GdhKcTGE1r/rGjdUDhkW0yzVVa1zXHSRSyPQwIMq4E5x/4WfmcVacOajkfNsc5Q4ZcOi
         WoXJNnoAPyFzQO9q+m4FmuVsJmj8Y7MRyNlhnTrcN9+I7ZEU0oyIGCrLVwjpJMHouML4
         mn6MhylEBd3m4AkR4fuRMhcklarO+6IW2CbBFfP6gU53sKIxtnpe11CQe472o0juIOM/
         NQCw==
X-Forwarded-Encrypted: i=1; AJvYcCWzAbWIHhcGR7D5zvhRrrGMtdqx1NPg/ZfkQ9Qjwq1dk9deTkaTGljkmq+67uctX2FMGHSELtsyZVaD53c2Nwd4MaRUpv/R
X-Gm-Message-State: AOJu0YwX3O8IufAJ4+8H7wriL4usvcogf6hsr4/OUOM7Jygc0tjBc/Cn
	f430vbIBDy9mafXP0EfcxB+bXY1hdIbD3FXuaCihRPtkChM8qch0mQ5lQH62
X-Google-Smtp-Source: AGHT+IGLPhJAsG6K2Ap0X9nQGnjwMu6FxISD7yBveHQRZLkGl455VOI6Jo/+fn5EAmHNC45XK9IPFA==
X-Received: by 2002:a0d:ea0b:0:b0:608:a1a9:9fb5 with SMTP id t11-20020a0dea0b000000b00608a1a99fb5mr2106185ywe.5.1708675818001;
        Fri, 23 Feb 2024 00:10:18 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:ed33:997d:2a31:1f4? ([2600:1700:6cf8:1240:ed33:997d:2a31:1f4])
        by smtp.gmail.com with ESMTPSA id l145-20020a0de297000000b00607bfa1913csm3465057ywe.114.2024.02.23.00.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 00:10:17 -0800 (PST)
Message-ID: <1c1e30f4-c898-4fa7-8f26-9eee1b1f0f09@gmail.com>
Date: Fri, 23 Feb 2024 00:10:16 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/net: force synchronized GC for a test.
Content-Language: en-US
To: Kui-Feng Lee <thinker.li@gmail.com>, netdev@vger.kernel.org,
 ast@kernel.org, martin.lau@linux.dev, kernel-team@meta.com, kuba@kernel.org,
 davem@davemloft.net, dsahern@kernel.org
Cc: kuifeng@meta.com
References: <20240223075251.2039008-1-thinker.li@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240223075251.2039008-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry! Post the patch to a wrong list.

On 2/22/24 23:52, Kui-Feng Lee wrote:
> Due to the slowness of the test environment, always set off a synchronized
> GC after waiting for GC. This can fix the problem that Fib6 garbage
> collection test fails occasionally.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   tools/testing/selftests/net/fib_tests.sh | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
> index 3ec1050e47a2..0a82c9bc07bb 100755
> --- a/tools/testing/selftests/net/fib_tests.sh
> +++ b/tools/testing/selftests/net/fib_tests.sh
> @@ -823,7 +823,9 @@ fib6_gc_test()
>   	    $IP -6 route add 2001:20::$i \
>   		via 2001:10::2 dev dummy_10 expires $EXPIRE
>   	done
> +	# Wait for GC
>   	sleep $(($EXPIRE * 2 + 1))
> +	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
>   	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
>   	log_test $ret 0 "ipv6 route garbage collection (with permanent routes)"
>   
> @@ -864,7 +866,7 @@ fib6_gc_test()
>   
>   	# Wait for GC
>   	sleep $(($EXPIRE * 2 + 1))
> -
> +	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
>   	check_rt_num 5 $($IP -6 route list |grep -v expires|grep 2001:20::|wc -l)
>   	log_test $ret 0 "ipv6 route garbage collection (replace with permanent)"
>   

