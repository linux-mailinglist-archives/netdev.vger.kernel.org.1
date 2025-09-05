Return-Path: <netdev+bounces-220251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB50B450FE
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD23FA026AB
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385662FD7B8;
	Fri,  5 Sep 2025 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="W7LH4ISd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7D02FD7B2
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059971; cv=none; b=X2K9W7mzV/JImukOFLll/YQPBoQb9IpmN35UQnmmQeXR+LRTEDSZ3uCLhs30VUDAuwPngq+0yhi8uX3HX5X2jzH4i7QTZCcnNNiLvlIEbdoe9E5a0z+FVPIDoRtV3NmyzngjPGndukszZa6R3dtD5gHbicNl771Tx/VPcBapDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059971; c=relaxed/simple;
	bh=QNCnBVfzbZNiOOovghiEodPKf1tnotCU2pQKXJrMrWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOe37c9ujFuDrTxfYBir1kXCMtDsKx4P60IFMAGmnNTNNg6tIjVwxmMloUCYOCD9q3zcKEnLdlN8eqLTIeZ+vK1F1HsQlNqTRziDWfoTfInKiKLi3bW3+7WwUJfRvNvYTqzHp1coyUUU1MpzIL8cFuwisA+kBP3ov3aUZUmTwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=W7LH4ISd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dd0d53e04so2093685e9.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1757059968; x=1757664768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GsSlj88KDJUopgbpsaUO+WZlul/yjMIpN+zX4T0J6tA=;
        b=W7LH4ISdHLq24xQkqO+Pr6Hzv5CsZkgZ/UGODlDwW9DHIH2rUyYxkVliJJv2GvEfHP
         cBeQi7ClqVDKDYZun8G8zvVi36JulwICyboJZhF/80dsBY77tbcJY3RuYR3txWybybl/
         t5UkgMfpNKvJ/P+gEapOS8G2Z5k/Cp/SaQP+jGaMNyowUosXQgy8cJQmVhW8awv8qIH8
         T/3YyURHXTclb9qu1HtZtvbPm4RP6GFQkHtI2CFsZBxKx1Y3fc6JVafLhq1K3GaiMS0o
         Igv/eaYBaozi5P1c9AZ/k6fJegPGIQMNYAh8l+zqT4KXvT1Mohy+pqlh5trNmqNhSvAf
         7wTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757059968; x=1757664768;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsSlj88KDJUopgbpsaUO+WZlul/yjMIpN+zX4T0J6tA=;
        b=vo1B/lIERzUXZkf1zc3zZ9/hJ1LoccLwF9eTb5jaVA3eb28VMtEA1dHajMo33qE//D
         qc7XAxZsX2YgZBZn5kngDczCq9UBj0338bJw0wqJMiZ6FEGygHvwmvkXfdjt/EEIcBcP
         hON8ka9Cg4YUIDHcTy52gtlle2RlHqGC9tGCR69NlHeoKPYfqnMrYwlDHUhTQaZGIbqt
         KKKlsggx0kDgjsA8C4cP2IlfdWqmFeQa2J/balSDzCvFfmLdRSBmNndgpKtFPjCHC3IF
         GOqMARb7oOCtiSket+TiMA5F43ij9HOz4K02jypHsU4BjxToQOdzUXBUDx9TVCVlg9QD
         Nntw==
X-Gm-Message-State: AOJu0YzD/j7OVKhjrb3YUs12jZ+vdbaPdFHyQLGNyIqjs8iF8O/YRF+i
	cANqzByf60XTaw9pXPHMD3ZO+HQiq/OuYH0k7vm9DSpLHvSmNgqtAaqnGMxxRsUXzfw2CyQcwp4
	pkJaZKgM=
X-Gm-Gg: ASbGncv388jIgepR8iqJblGkrdpdqsQy/H9gY9v0mMsAC4vBBTu3GdiOHhpctHmstQQ
	OIOpJlGstn8ZhHYIKwHokOFUPq4hjhVkF75nUpc9py0EPxziGUlMwBLcR27awuAmGlAHWEy4kxD
	VvIYk00Px7QuFc1+0WYK5zRGtt0O40/cFCBaf65j/jz2/0wI9fpH3guWeHRvpV2aIRwcrGoOh4h
	rP4CFdX6t9KSm+BrE9CJf5fw0PUD1xxd8eXMkgbCkH1doCytui03JthjxcNcVIOWhKVyr5iDR5M
	bDfJLI59Oxo6AbSn88kc+hgs4au5ClxZbiltSllOD6EmF53+qPZDUVksT/V7eCmmz8+zZn/qgHp
	WqAvepY53wjmd5yxbz57CYFlGlsDwmHFD+ie6TA8w9VSxM3QAG+D/84F6BihA5P2OiwYB0s/GRC
	zHCv4XiN6lMg5I/qCQWum4
X-Google-Smtp-Source: AGHT+IHWrN9p5XeGjFAEXjrogbk7f2reVbPwgk1/9j0dRF2egSHn1DCR3CU9220t0onAp9N6UA9Ndg==
X-Received: by 2002:a05:600c:34c4:b0:45b:8a1e:3b83 with SMTP id 5b1f17b1804b1-45bd8a2f401mr49361985e9.8.1757059967617;
        Fri, 05 Sep 2025 01:12:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd0869b33sm68367345e9.9.2025.09.05.01.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 01:12:46 -0700 (PDT)
Message-ID: <ed08170f-4c9b-44df-9299-6bdec5aa5d38@6wind.com>
Date: Fri, 5 Sep 2025 10:12:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2 net-next] ipv6: Add sanity checks on
 ipv6_devconf.seg6_enabled
To: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250903115648.3126719-1-yuehaibing@huawei.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250903115648.3126719-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/09/2025 à 13:56, Yue Haibing a écrit :
> In ipv6_srh_rcv() we use min(net->ipv6.devconf_all->seg6_enabled,
> idev->cnf.seg6_enabled) is intended to return 0 when either value is zero,
> but if one of the values is negative it will in fact return non-zero.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v2: use proc_dointvec_minmax()
> ---
>  net/ipv6/addrconf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 40e9c336f6c5..69ec9cb6031e 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -7192,7 +7192,9 @@ static const struct ctl_table addrconf_sysctl[] = {
>  		.data		= &ipv6_devconf.seg6_enabled,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
This sysctl has existed for almost a decade; you cannot change it, as it may
break a user setup that was using another value.

Regards,
Nicolas

