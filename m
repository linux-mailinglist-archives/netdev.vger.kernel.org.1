Return-Path: <netdev+bounces-187589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C69AA7E81
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 06:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87B51B65F85
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 04:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC80191484;
	Sat,  3 May 2025 04:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="en84ObQa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC15B4C98
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 04:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746248054; cv=none; b=O1/W7HB4HICxT8vwT5EQPEgMGnpYEOEpt6Pi+Vyw6FYMAb0J1p7lbKpPRIr0IeTkJKseW6lyJjiM67mNmPW4WTxLobgqm3WDDek5mo7YqZgFOUW2AmKu4gFytIIThFtuO1+VqcNszoYepfwmWNEhU91jmZOBnx2mSArHJzCfJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746248054; c=relaxed/simple;
	bh=cVzNzhqh1D6Eu0+afrSWWS0mYqx/ap2p78ze7BMZGKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGJ4DCY/vnnwvUpBal1XXtM3qYB40lcTRksVvX/LvOUA11XxhP//+gemN3QHZvJTJhagpyxPMi3+nXFGzqLn3P8Q58tijz+Gr6/CVL4P1pWXIaHwpFLQWyVN89dzlOSjGWg0EgwcWW2ntz3Ezol735w6A9oLvG8vzOCTp6ULYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=en84ObQa; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74068f95d9fso221299b3a.0
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 21:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746248052; x=1746852852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCV+n1jdj4vZ34r/Bl86+ScL2E/MFwgQ38gnwGhyIT4=;
        b=en84ObQansPfTctq8OAWkS4IwmgoDEuAQH6IRH35ckuBgKybrIDgxLH+O28kRw0LIs
         g21JfErdbhBZvlVEQ2RPuSeHI4jwlts9+uoQJ3F44ZjTChahr61LhlSp5m+L8vINAozh
         Uf8sw9BvBlocQN2+uXaNVk2hf1wmfsAq/raT63lzqBQSSvJEkfo3++iasIiLYkMawMwM
         30ct93lKNRpRzt+hDjnAfdYR4GYjjYWqmnEywlycFKy/oCwWIlziMV8IsS3ya1TZ8szo
         1yBNQva9527iL7ygx/l35LHByj99KQ8sGGgBUux3XfB39h2nMjMnt7KRCwojpYhDvibB
         ejVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746248052; x=1746852852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCV+n1jdj4vZ34r/Bl86+ScL2E/MFwgQ38gnwGhyIT4=;
        b=I/smBDGB8qBk336uB08ttOB0n6guBV8mnFXQPovA7P/85ECyoxwelRhUTUK36xJuxI
         lbaCiTdPzcn91+7LRpbm2E8bNmtQyo+1GKwLv2zsNI2s5LJYmx1JFjjbbo0ljm2z1IbX
         yXEuMqt/SF55TjlX7oYdyzH3vIGbdNi+6yr5xlE1feq7fLL4gIyMN+LLY4tmWLOiYc6Q
         gv/E7al8JSpJoTrA+HGjBVuQkh4pFhcYXJ7yck0kAE0G2iaAsfCfWf9MxBlJAFQLmcn5
         13g4ZMy/7tkumRwyMQ7H6laYPH2ZczOhgyVg4IzWvPgeSJ5CcDLonfDRjfqezAelVNEe
         smuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHo2QKBSG6eP6pXqY23bbO/hFxyyV3j244gnLvulWiynFTwCPtq+DRP5Otw0di5xhjU/wQd5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpd/I7D3n+Rm4mDw9DsTSNrzP6I6jqnExXuU1r0MwQErCyCbNy
	15qc6ROwvF1ZzEXY6NI9LxELX9kxYILRSbVUXOulm9dvDfsID/atBMvMUmhdOUg=
X-Gm-Gg: ASbGncvY98iTRJKad39DoUNreS/noRV4vpYBYrkRl66yOo7km5BONq93QkcrtCX/WI+
	V5ktpLEAVNg+IVSx83XOTsLNWBekW/IfWDSrGKr8h9hryIAXFkkVR9Wq1v7Eh/VWC3BGy4HrQT6
	WpXz7gHZYlAhNnvEkQ4CngoGNH0oP9L6XfrL0iYz7mUmvq68y9Kh6vlh+AzuDhacmtLGFXsyR6u
	7UMiVhlJhCPtk8X6PlOcQKOcryx7OTettIef3++J0nx8Zr6v5uqtSNEr7eumpT13n9ScpSP9OGL
	nHtNVDzT7XZhpWFimhtAFModeDOkQ9EyDlO6dm2WDtjpL+4=
X-Google-Smtp-Source: AGHT+IHVvCw+e79OLK9LKYm6TnJDnlFfBgFxcEBlACMqCm8nLVtS77ZdSMfxj04/CUsBdW2ceeb+gA==
X-Received: by 2002:a05:6a00:2793:b0:73e:10ea:1196 with SMTP id d2e1a72fcca58-74058a1f996mr8477230b3a.8.1746248052238;
        Fri, 02 May 2025 21:54:12 -0700 (PDT)
Received: from [192.168.1.21] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7a397sm2528583b3a.28.2025.05.02.21.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 21:54:11 -0700 (PDT)
Message-ID: <0db1b7f0-028c-44e9-bf98-81468dee32f0@davidwei.uk>
Date: Fri, 2 May 2025 21:54:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] selftests: drv: net: avoid skipping tests
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 ap420073@gmail.com, linux-kselftest@vger.kernel.org
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
 <20250503013518.1722913-3-mohsin.bashr@gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250503013518.1722913-3-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/25 18:35, Mohsin Bashir wrote:
> On a system with either of the ipv4 or ipv6 information missing, tests
> are currently skipped. Ideally, the test should run as long as at least
> one address family is present. This patch make test run whenever
> possible.
> 
> Before:
> ./drivers/net/ping.py
> TAP version 13
> 1..6
> ok 1 ping.test_default # SKIP Test requires IPv4 connectivity
> ok 2 ping.test_xdp_generic_sb # SKIP Test requires IPv4 connectivity
> ok 3 ping.test_xdp_generic_mb # SKIP Test requires IPv4 connectivity
> ok 4 ping.test_xdp_native_sb # SKIP Test requires IPv4 connectivity
> ok 5 ping.test_xdp_native_mb # SKIP Test requires IPv4 connectivity
> ok 6 ping.test_xdp_offload # SKIP device does not support offloaded XDP
> Totals: pass:0 fail:0 xfail:0 xpass:0 skip:6 error:0
> 
> After:
> ./drivers/net/ping.py
> TAP version 13
> 1..6
> ok 1 ping.test_default
> ok 2 ping.test_xdp_generic_sb
> ok 3 ping.test_xdp_generic_mb
> ok 4 ping.test_xdp_native_sb
> ok 5 ping.test_xdp_native_mb
> ok 6 ping.test_xdp_offload # SKIP device does not support offloaded XDP
> Totals: pass:5 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> Fixes: 75cc19c8ff89 ("selftests: drv-net: add xdp cases for ping.py")
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>   tools/testing/selftests/drivers/net/ping.py | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
> index 5272e8b3536d..16b7d3ab0fc8 100755
> --- a/tools/testing/selftests/drivers/net/ping.py
> +++ b/tools/testing/selftests/drivers/net/ping.py
> @@ -12,7 +12,8 @@ from lib.py import defer, ethtool, ip
>   no_sleep=False
>   
>   def _test_v4(cfg) -> None:
> -    cfg.require_ipver("4")
> +    if not cfg.addr_v["4"]:
> +        return

What if cfg.remote_addr_v['4'] doesn't exist?

>   
>       cmd("ping -c 1 -W0.5 " + cfg.remote_addr_v["4"])
>       cmd("ping -c 1 -W0.5 " + cfg.addr_v["4"], host=cfg.remote)
> @@ -20,7 +21,8 @@ def _test_v4(cfg) -> None:
>       cmd("ping -s 65000 -c 1 -W0.5 " + cfg.addr_v["4"], host=cfg.remote)
>   
>   def _test_v6(cfg) -> None:
> -    cfg.require_ipver("6")
> +    if not cfg.addr_v["6"]:
> +        return
>   
>       cmd("ping -c 1 -W5 " + cfg.remote_addr_v["6"])
>       cmd("ping -c 1 -W5 " + cfg.addr_v["6"], host=cfg.remote)

