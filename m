Return-Path: <netdev+bounces-189097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EC9AB05A7
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 23:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDFD984523
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 21:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAF52248B4;
	Thu,  8 May 2025 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="hMDnF7Bx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8A20FA86
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746741556; cv=none; b=AuNKKsHNdewjjtNzSQInU/OGlk/sVQRlSq+QJIhiaUic5cf2IhogudrXhIRfsEoYq6NaOJGGsvf8Mjea4mqG/FnVkPjdlpJgDQ/V2M5Fzu6OJ+oPeupSG9iJHCruPNtFKprjcyMHgcQHxBKGcdNalqQwQqmJhw+NuqaQoK+kVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746741556; c=relaxed/simple;
	bh=RcMpxjM0SBsWiUvaLtv7ypt2hc1LOWKx7i2yRwa9bbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSsxmKd2OGdKc8soGeSTlxGqQEogk6kODDNJUj6BKKfcpQhd+Z9mK2r51SwjZ0dzDl5mx1+fGnWEt067HwPMCAGiVlwTIF6ovNvQve5J95Dbo83Yhw8Xh3nRgtmHdKcgz5Z4DWwKRRiAia9uH0+F7vMAk8d9uAztLh1SYPEaoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=hMDnF7Bx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22e730c05ddso15276955ad.2
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746741555; x=1747346355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEDc2EtJgKPJGqy02JAFGdLWN2lNiFsVQXcu8wIsSmw=;
        b=hMDnF7BxMJ2T6w68R9N+CTQrRmepW4Z0cnOdDJhQhW5aRt2a/pNgvTv/0yRfUBgvSl
         Chgy1OODk+vhK1LD0GLnrSfHMst6ZaLwwiCsqUvOq2B9ODUVdgyIB7ajPgIM5B31yJyT
         Ak6b5G9AZwS8UMQT8mb5jMv7IMweNO7V0O9P1Z2o1VCNcjKghKNVOuY78y+p08GduEJY
         V0GW0MR/d9lMr+Q9VHyE17iYCuOKOEmkqW8lLb7tvmmQBGZLyarkrCufsNMl0h9JWIxz
         GyJGqke8TLPef5g0hOfQpPNNnucr324ftKS2kQ18DuFmsggGZCdABHPkYvUaAGCzD9W2
         3Ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746741555; x=1747346355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEDc2EtJgKPJGqy02JAFGdLWN2lNiFsVQXcu8wIsSmw=;
        b=lGQw70QhGX0n2kICZuUBDdMYCBxvX4630J4GKFgEbJErMRtUlIT1qTDp6Wgl1hZsNP
         k3wFqoBEX/68WX1zeAKvKCOcWX4lHMxBLRmZzLa3N45Y1SoSM39PPh5HfGd9IBP1PT/s
         ga12VSXMsuFYMtrHx6Gzm7i1pkyftxBBv3pwgoCbmGFvFF11fCjQTMs5S7I16ukueJVM
         5fPKM3QrvOE85BETad4Su0WV8Qc/ISYXHR4IYG9Qyqvwe4iiFFXdScwYgtRAt828Gf+2
         vJTAi/vwnOXjupbeS3xx5FUPC+Sxevc6WwREnF29lVgtLOK7yUgQvhlYDfqLRyQmmGLW
         rIXQ==
X-Gm-Message-State: AOJu0Yzs5KGeepQf4Tco0BaRwYPEsATf0MvSAcCJVUZlRb4+g2UlzWax
	/mTIw0TI9Xj7fdYl57yWhimbZ70vInsgooBFjwkjqj3Y0N3RlkMduKBJYEGoVBo=
X-Gm-Gg: ASbGncuzvflLvW4ZPPAsYa4lSR6sVRmEO/LV2MiktsL5gZ3tSiazD8AN1M743/cEnx2
	PunANIw0bKyXGmR4D4e1SHc1e8Yzw+dN4XXcf/gTO2rXjPz+V6YcaZB7sw1FSToAH92s9DYHL+u
	rhjEzPKU4E9sATvtpWKjuYd67K1gjciEYZnjvpNoJ6hzhwYaORro/k7FzcqOIWJ9kFh2+Bajofz
	X7MxreR+EnDG7PQc73l3D5DRpPykXOGeL9MYLSJHU+8epm5fRa7Ou29J4q52vZEEM0lM2gZMrxw
	+zawDTRcXvnq0huz0ZzsHkESeFJzR8iYr9y8CmcQGFbpTJ9jpl/lQvd0mpw9c0lKLvQTO9E7N6F
	dUfQ=
X-Google-Smtp-Source: AGHT+IEQc8Chr3MQouZYg+naSTE2nFIyRZdRZh97Oepc5jfMUidKqI1wUYOzkkoyAHeAUOkCkEvLrA==
X-Received: by 2002:a17:902:e84d:b0:22e:8183:1fae with SMTP id d9443c01a7336-22fc8e94b54mr14491915ad.41.1746741554770;
        Thu, 08 May 2025 14:59:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1079:4a23:3f58:8abc? ([2620:10d:c090:500::5:2fc5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828a3a5sm4337645ad.161.2025.05.08.14.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 14:59:14 -0700 (PDT)
Message-ID: <e339c382-c0f5-40dd-994e-34b388c68181@davidwei.uk>
Date: Thu, 8 May 2025 14:59:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: drv-net: ping: make sure the ping
 test restores checksum offload
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250508214005.1518013-1-kuba@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250508214005.1518013-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/25 14:40, Jakub Kicinski wrote:
> The ping test flips checksum offload on and off.
> Make sure the original value is restored if test fails.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>   tools/testing/selftests/drivers/net/ping.py | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
> index af8df2313a3b..e0f114612c1a 100755
> --- a/tools/testing/selftests/drivers/net/ping.py
> +++ b/tools/testing/selftests/drivers/net/ping.py
> @@ -50,6 +50,16 @@ no_sleep=False
>           cmd(f"echo {test_string} | socat -t 2 -u STDIN TCP:{cfg.remote_baddr}:{port}", shell=True)
>       ksft_eq(nc.stdout.strip(), test_string)
>   
> +def _schedule_checksum_reset(cfg, netnl) -> None:
> +    features = ethtool(f"-k {cfg.ifname}", json=True)
> +    setting = ""
> +    for side in ["tx", "rx"]:
> +        f = features[0][side + "-checksumming"]
> +        if not f["fixed"]:

I checked and found that "fixed" is a ternary:

         "rx-checksumming": {
             "active": true,
             "fixed": false,
             "requested": true
         },
         "tx-checksumming": {
             "active": true,
             "fixed": null,
             "requested": null
         },

Python loads this JSON as False and None types respectively, and `not
f["fixed"]` is true for both False and None. Maybe this doesn't matter
but flagging it.

> +            setting += " " + side
> +            setting += " " + ("on" if f["requested"] or f["active"] else "off")
> +    defer(ethtool, f" -K {cfg.ifname} " + setting)

This does rx/tx-gro too even if not explicitly requested. I assume that
is okay?

