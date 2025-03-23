Return-Path: <netdev+bounces-176958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A756FA6CF13
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 13:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB101898923
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 12:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B6A15ADA6;
	Sun, 23 Mar 2025 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMus6Kc8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D95A35946
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742731237; cv=none; b=rIG7k4Gb1Fm8ZTHwc4cuBG1gCr7UVg2hNmXVQAV0tpvZDzy0blqnVRy+rA+ctyJIUepZegiszOOe4tUkNj8RFuWzz8nCaJ/XuIP6yNXqMYcSMQ5oF1w/m59P3NdfM2LtVwPYq2F4NjOaq6fpGvr/b4eL5u5DFlQFSq95tjAU81Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742731237; c=relaxed/simple;
	bh=RK982kP+vjLi2j2YW7xuvNEetW88FBBH/65hHb7HTTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSkpbd9VkJTO787ZVz6XHfODCX1t+/KerHkieNeoFyiD5KjZcqGj6xKWnQwb8grWGeGXRuMNMqKMKzWVY9spRq5guggFwiQSqq5rVuQKA+Jwi/lX7I0ijayhYkv8kw0fp+0pvmbpAdQp9qrpllT7YBa+jGN16FVbf13XSSSY/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMus6Kc8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so31758265e9.1
        for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 05:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742731234; x=1743336034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SC6n7pBcoKIKMkgC8L2ETa8tP/mWNcZ+x59kUXrDb2w=;
        b=MMus6Kc8rnCfaKamcJ59wBbpA71ob4TpmLDNVKARpRWaiIlTzNxTZBzP7auDEosSH/
         ODgCmghUEHq+c6xBq0AlXndNjjLuNaSEyyqcUucV4ihZOlka8IGGLK0pJ2zdOGLuw4TX
         D92oNTLa7VrT8Dl1C+4zDf3EOMlKAi1QWbBeY9u3KCWeo19wCEhwEMLh9nKgeEFr4HyI
         04kwbziWgh1A7Wb2aKwg6YzAThl1GOCAuHshoFAUFgJwYZ/9kqmCPHfaMO58TaViZNwx
         NW2uKzTr5VMBDbN4n+X6sfTA7pNm/SkcvhmrMWBCAm87eAe5He4yGhzX9aOwL0U2hsJ4
         6sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742731234; x=1743336034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SC6n7pBcoKIKMkgC8L2ETa8tP/mWNcZ+x59kUXrDb2w=;
        b=SdiM5HeT+C7uD6O9T4/gVgsIcYxLHrS8KZqCgYXsrruCQUjr3Ai2CGDYKKITN2LMz5
         misXVR0n1YD1xHhtcZrAuEjxnNR9A5B0o/x2y0DLlJuJgIRQc8+nfYDHNh39wBDAoRTX
         bl7ouGmmRZ3HkTQEt8DKka+ZBF8Dvsjx8kKWJV9zjotfbcGlHgThjDlII3+oFnlMlqaa
         Uew9X3riBIdnhwWpzS/h0yz4wynlWn+DmuivZNgaOpYnSE7KdOtdT8p8oQAKCZ764Rtb
         waj4r0VRQEUpPN5SaRCk0L/KRZAYyCU87CFsqWE0XI/UhJtKZN7nxq8k9rma3/DvFsTz
         ClPw==
X-Forwarded-Encrypted: i=1; AJvYcCWs2Zlv0F0N5SjPt04dXReYTq3VruOXM6wJxVBX/ToR6T+ELH6NWV9zApU/VYxixmIv/JsAYkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEAHRxnMoenxxLsVstCKzg9og+Yi7LoR+pjqZxjMEwz9wsZ98q
	wIHJ2zXjezfN2E5/lVFPsI/RuSvgPOoRuhg4ckD47nFpKc7ZaFkL
X-Gm-Gg: ASbGnct/vekjU58ZNu70Cfv23otClKYKp78SxNrHGbY5JfHT//KcKM4IcNzcn48vcQ9
	g1/FhQ5dVkAlVtCGJ7meiSvGAuAmpFoDNFTkS7ALsjrGZYH8B+A/sa+wF/pTFwQtL0EkfYKHcBH
	DaxJS5aLoED4tFuFHxTWrRaHYTDgH0lipgHj/zxVN0Z11Gj+cYkkqjKfk7uE6o12kuIhulYj1P/
	xWEvbQWtCxB4Mvy95GNQO3k+Sci+gid0SrhM0LW60k1r4RHPpjTMfWFeoFLjvV+3DGkmLubzZIM
	yEG8d7UWz1K34ExXaLsSGlF64jhKA6DmrpTEhw26yYoRS9jZds7GLX7mtAn+9TpyfQ==
X-Google-Smtp-Source: AGHT+IEYx9LS1F7Gh9og5K/ONUZVZiuesl+3d4bfZoHyQPrC1uKivN0aQtRY/sNPfm6OlJwhScm+Eg==
X-Received: by 2002:a5d:6485:0:b0:391:4231:414 with SMTP id ffacd0b85a97d-3997f9397e6mr9782095f8f.40.1742731233906;
        Sun, 23 Mar 2025 05:00:33 -0700 (PDT)
Received: from [172.27.48.118] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f556afsm133837355e9.19.2025.03.23.05.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 05:00:33 -0700 (PDT)
Message-ID: <26aed6e2-a728-4084-a31a-37b88fe3e24b@gmail.com>
Date: Sun, 23 Mar 2025 14:00:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/4] net/mlx5: Expose additional devlink dev
 info
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 parav@nvidia.com
References: <20250320085947.103419-1-jiri@resnulli.us>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250320085947.103419-1-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/03/2025 10:59, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This patchset aims to expose couple of already defined serial numbers
> for mlx5 driver.
> 
> On top of that, it introduces new field, "function.uid" and exposes
> that for mlx5 driver.
> 
> Example:
> 
> $ devlink dev info
> pci/0000:08:00.0:
>    driver mlx5_core
>    serial_number e4397f872caeed218000846daa7d2f49
>    board.serial_number MT2314XZ00YA
>    function.uid MT2314XZ00YAMLNXS0D0F0
>    versions:
>        fixed:
>          fw.psid MT_0000000894
>        running:
>          fw.version 28.41.1000
>          fw 28.41.1000
>        stored:
>          fw.version 28.41.1000
>          fw 28.41.1000
> auxiliary/mlx5_core.eth.0:
>    driver mlx5_core.eth
> pci/0000:08:00.1:
>    driver mlx5_core
>    serial_number e4397f872caeed218000846daa7d2f49
>    board.serial_number MT2314XZ00YA
>    function.uid MT2314XZ00YAMLNXS0D0F1
>    versions:
>        fixed:
>          fw.psid MT_0000000894
>        running:
>          fw.version 28.41.1000
>          fw 28.41.1000
>        stored:
>          fw.version 28.41.1000
>          fw 28.41.1000
> auxiliary/mlx5_core.eth.1:
>    driver mlx5_core.eth
> 
> The first patch just adds a small missing bit in devlink ynl spec.
> 
> ---
> v1->v2:
> - patch#2:
>    - fixed possibly uninitialized variable "err"
> 
> Jiri Pirko (4):
>    ynl: devlink: add missing board-serial-number
>    net/mlx5: Expose serial numbers in devlink info
>    devlink: add function unique identifier to devlink dev info
>    net/mlx5: Expose function UID in devlink info
> 
>   Documentation/netlink/specs/devlink.yaml      |  5 ++
>   .../networking/devlink/devlink-info.rst       |  5 ++
>   .../net/ethernet/mellanox/mlx5/core/devlink.c | 62 +++++++++++++++++++
>   include/net/devlink.h                         |  2 +
>   include/uapi/linux/devlink.h                  |  2 +
>   net/devlink/dev.c                             |  9 +++
>   6 files changed, 85 insertions(+)
> 

For the mlx5 parts:
Acked-by: Tariq Toukan <tariqt@nvidia.com>

Thanks,
Tariq

