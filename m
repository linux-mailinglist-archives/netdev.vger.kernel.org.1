Return-Path: <netdev+bounces-169644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A786AA450D6
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 00:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72ACA3A88C5
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 23:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B81235BF4;
	Tue, 25 Feb 2025 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="24IEUHon"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8821322B
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740525090; cv=none; b=lCsKNawsvJIc36HlOzKu1lnNRmQSDoq+vfktogA7/hRmtnpgiTIz5aEBl9jNfF9It4VZswpwZoMWf5jJxKD2jFlwWoMarnS9oMYRbWGgwmfvxN9tYMQmVDYb1iWwXmYSg+J1yqAvV83HXjbrPp52EzesWZTQtSkIIkhFrEYREsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740525090; c=relaxed/simple;
	bh=/ftNyy+vaSlm3/4HIx02nxkWhTTu1YUQIglU9aKLez0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPmBIA6RIGE5uMn4oWHhBXdr5qx5gCC2BT3zcjo1R6BGpa87QnirRflUxxwb9JO3aJqd0bCUjG3EYpXHh4QB2BgAqPcLfugnTq8QvovTF9BN00rvLJ6HbzQ4G/Z/WKj0+TQUqBeaps3GgkQbTmRX8g2FZ8pFxtMT5u6syHEEcrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=24IEUHon; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2230c74c8b6so35748525ad.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 15:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1740525087; x=1741129887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQ61ZtswOD85wV8P56MHQvltVEA+rd3ScB/YgelJwiQ=;
        b=24IEUHonfKFuYeI1HnDl8T/rbU5ssotbAmQ+Fkt+Z7XAs4d5YsgB0vn3up24UE9Oum
         uUDdonmVpnzvb9b9ACLipECX6Vw238VL4GJGRjp5TvG3fbB66BJ1GkK4IZiYZv0WnKZJ
         6nO/kwTQtyNhschW4/QHsk4aFGN4x5HlFP/mXpoXKFyEhKxZIUB4Fqlzgg0M08hjEQJJ
         qnaO88DK0HGu0LClL2Qq0RLXAysD3KAYzchJ9k6uEWAUdkBjBNZa/fXQj43YqYzjaV5O
         YLZGkdMYxW0RLRZEctXtRqdnwOcahNcIqMJ9DgXG9CkacscxnCGSSKbhAqTzAXxoeI6S
         mzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740525087; x=1741129887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ61ZtswOD85wV8P56MHQvltVEA+rd3ScB/YgelJwiQ=;
        b=m6FzF3GEYp+kc1VMoNbRh4omTYIar0yLieBQiKs2BEp6Eqt16/a6ZO/2TpaLZLBVLs
         EJKCtsSFOszOXxVXR1bTCqJ/Yp9F7XEjQ4T4ndx9JDsNg9WiicdcxblcyNNrZ6E8xCia
         GPjg0ZEqrXuOTnRWORMXO+9FHJdB9LeyrOViF2aBtrqoBKsnZJ4RHQWSMteg8hgJDlIx
         pafs0oEclvFjmHLJRqMRcgqtIgSw9oSm820Im+5BP8IlcptCxS5aCZBSuhaPARHzCDHH
         pbEGYVETCnTe8uwSJsPDL1DoXFt7Ia00z9Jiq6VRG/4KR3acfoSTVR5QGPhmpyh/WDWn
         F36g==
X-Forwarded-Encrypted: i=1; AJvYcCXjTzRBXlcn/4m0Y8tpptwPfEWX+jNvltUInWNPYhljb4WbbJKEcbocBMXFZQEbeo4/YKCO2Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfsgrH3SMlpXclec4LXG3aVHYCne7hjhWYnr9J2hSzpirlFWcP
	QqFJGCMFVRcNAS03yOfpYJH/hYsmXyiMvlSycEagDNPNA58JrCBWYCdrcygyQcA=
X-Gm-Gg: ASbGncugPZeQiOqyCjdjOQ2rZNDs4h7W8eq3ZUDqPAS30ZE0pGFBpX1Tx3AwflPVv9N
	fLxI3xeWehWIVNeL2w9mbuP1eNqUs7MkSUfLuAI8xXqwBuBA7cXAcG2WpTYOXA404eP7y8YdVQR
	1IqGCmxnqjqxPMJflbmW5YoQJnIaeP9hws+7npNpcYMpM+giLm897DkncoirTlUpwwgZgBOuGrq
	WxObB4JTqHxMmXC/+Q2qONmKsUbsxXeD442+lCxCwfhG7d4j/L6jVBurp3p4QS7e7FgoO2Eu/IX
	ZBu1F8AkjVPM0689pCLGKMXzjZGw2zFW3FdZPRj06kZrkAX8koO27PvPtgeM3aevw1G+jg==
X-Google-Smtp-Source: AGHT+IH5civrRZQb+4W/qlkknAb8yEWjaptfeFOtCfZg94sm3+noPuJFyjA5fde/QqxXj6in5KcNBw==
X-Received: by 2002:a17:902:ecd0:b0:21f:542e:dd0a with SMTP id d9443c01a7336-22307e6586fmr93275905ad.41.1740525087342;
        Tue, 25 Feb 2025 15:11:27 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:18cb:90d0:372a:99ae? ([2620:10d:c090:500::4:6a61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a00abfasm19847055ad.82.2025.02.25.15.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 15:11:26 -0800 (PST)
Message-ID: <1c263479-43a4-40ec-94ae-987c7da7d43d@davidwei.uk>
Date: Tue, 25 Feb 2025 15:11:24 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: drv-net: Check if combined-count exists
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250225181455.224309-1-jdamato@fastly.com>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250225181455.224309-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-02-25 10:14, Joe Damato wrote:
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
>  tools/testing/selftests/drivers/net/queues.py | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
> index 38303da957ee..baa8845d9f64 100755
> --- a/tools/testing/selftests/drivers/net/queues.py
> +++ b/tools/testing/selftests/drivers/net/queues.py
> @@ -45,10 +45,13 @@ def addremove_queues(cfg, nl) -> None:
>  
>      netnl = EthtoolFamily()
>      channels = netnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> -    if channels['combined-count'] == 0:
> -        rx_type = 'rx'
> +    if 'combined-count' in channels:
> +        if channels['combined-count'] == 0:
> +            rx_type = 'rx'
> +        else:
> +            rx_type = 'combined'
>      else:
> -        rx_type = 'combined'
> +        rx_type = 'rx'

Logic is good but minor nit in reducing nestiness:

rx_type = 'rx'
if channels.get('combined-count', 0) > 0:
	rx_type = 'combined'

>  
>      expected = curr_queues - 1
>      cmd(f"ethtool -L {cfg.dev['ifname']} {rx_type} {expected}", timeout=10)
> 
> base-commit: bc50682128bde778a1ddc457a02d92a637c20c6f

