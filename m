Return-Path: <netdev+bounces-85976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F339389D235
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 08:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54858B22C78
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 06:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566556A033;
	Tue,  9 Apr 2024 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1grfUGz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EA54C69
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643480; cv=none; b=TBcPp4AYhbjJDM1NYCxwSdZcOrk/6RNmmaxd+1WxnvMSV6sV1Nudab+wNvnMNStX+LalCnZQMtjmLM9PjQ8RNqxGbxCH31CYmai2m5c8cRU5oC4Fx2vndiMl593z9EZVS5D4McM3tnNLjNzbToY7rvUyMgzW0VRK2onH38v4w9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643480; c=relaxed/simple;
	bh=KKblre57fOpKBuy7xLzgHz2+nTegVIpU12jxc6i7Rw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+K3EOVzNi3LOzmCcAoQle6AlZMxYMxr9DVn/RjvLO8t5dDc3u5LcS4IQbSx/IbWG7cTE1kzhFTpaq9yCZCRMxayWHEKbIk8kwITvAZtNdp5CGckqUQIxGbFe85YvyeWIIgEE7DWxN7V07z8FLftS8fNsloBHdF4oALKOhunpn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q1grfUGz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4165d03308fso19829285e9.2
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 23:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712643476; x=1713248276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kSfXauAiRAJsClBqi1cyavfA14mZNgMU3URvqE57gWw=;
        b=Q1grfUGzrh8At33bZ618YH1tY0283At12qAwEu4HBchAbPUUcy4MC9mTzmlIyDwBpc
         PaM4k0UIWDxwAgP2H/MJ/6/YGmpkzWbuTwCuggDwmnfNyj+yUVcWW7bCdChSEiA8n068
         51HI21UWjVxKlAVuhSfrVkY0ph/UZuvXWhDEKRK8Bho3N6uSFjRnq0IIPB8D/gp3th1Q
         EK98AwFn2e4IJUkloCAUf2H8XI1bT+cdqAPRTB+N04Rw0chBYRKvWxkUFSTu97ijM9BQ
         0bctrGIA0wrEdYa1N9z9c9nUjAknxuuiO6BeLl4aQ6u80ZOtg7hqs5L7Zhx+hWyHo/Pz
         E6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643476; x=1713248276;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSfXauAiRAJsClBqi1cyavfA14mZNgMU3URvqE57gWw=;
        b=HsBsni24+Kqdmt1LeHJ9f+nQI8S0bUI+HxC2VI7NcgrEgrMEdaFD8lREgZzV4yms+l
         Sz1twMKpMv569HN8vH8ig1gcQ8xnFHwAJxpWH1HeR9QJjXzLkSrfbgP1glzsS16Z1UHi
         2otHG1j3Wv17D4/r7YgG6Ad0Appbk/04kr/lymyNOZuzsA0XCG9icPypeJDxarM5TtGJ
         nxAnO4jssYhkEXa1jVjRLoANBaQh9/n2j7xoXnc03QEoMzLzvxFdwARWiAsOBoSW9CRO
         t/dL6+pWd7ObKSPlxaKXc1wBZ1dNBrnQFLB8hhDOXsVGd0GQ/Cqye0Mn+4KxfyleuPVp
         xQcA==
X-Forwarded-Encrypted: i=1; AJvYcCWIfW66S7EKIJP+lBb8Y/mPGs6LtquZ4wVO5Sxk3WwPcwyZGERegp6aS1BcA4SkBPPkvBcTRGqmKOiXX4tRQMdBi26KSnNc
X-Gm-Message-State: AOJu0YxIef5CfZPzpyWcoSULpLFa0ob8pWAmHwRbInfyjvmLpr3nBMri
	3OBzVRbcjrNfsYDJL0OXuGxXHSJMllTjJX31ysNHEWHGPOig4a7JcbwnMbeOjVY=
X-Google-Smtp-Source: AGHT+IEGieePSGtgAEeXzmHug9zAaq6Yct09lgaKXVxIi+OuFFkAQ4xw53JeEo8u5bOfOYETIuAP3g==
X-Received: by 2002:a05:600c:1553:b0:416:3416:205 with SMTP id f19-20020a05600c155300b0041634160205mr8258466wmg.23.1712643476477;
        Mon, 08 Apr 2024 23:17:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id z2-20020a05600c0a0200b0041624ddff48sm19474722wmp.28.2024.04.08.23.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 23:17:55 -0700 (PDT)
Message-ID: <9a2f087c-7008-498d-9fed-3e9653a4e5ca@linaro.org>
Date: Tue, 9 Apr 2024 08:17:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] nfc: llcp: fix nfc_llcp_setsockopt() unsafe
 copies
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
References: <20240408082845.3957374-1-edumazet@google.com>
 <20240408082845.3957374-4-edumazet@google.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240408082845.3957374-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 10:28, Eric Dumazet wrote:
> syzbot reported unsafe calls to copy_from_sockptr() [1]
> 
> Use copy_safe_from_sockptr() instead.
> 
> [1]
> 
> BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
>  BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
>  BUG: KASAN: slab-out-of-bounds in nfc_llcp_setsockopt+0x6c2/0x850 net/nfc/llcp_sock.c:255
> Read of size 4 at addr ffff88801caa1ec3 by task syz-executor459/5078
> 
> CPU: 0 PID: 5078 Comm: syz-executor459 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>  <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>   print_address_description mm/kasan/report.c:377 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:488
>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>   copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
>   copy_from_sockptr include/linux/sockptr.h:55 [inline]
>   nfc_llcp_setsockopt+0x6c2/0x850 net/nfc/llcp_sock.c:255
>   do_sock_setsockopt+0x3b1/0x720 net/socket.c:2311
>   __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
>   __do_sys_setsockopt net/socket.c:2343 [inline]
>   __se_sys_setsockopt net/socket.c:2340 [inline]
>   __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
>  do_syscall_64+0xfd/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7f7fac07fd89
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff660eb788 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7fac07fd89
> RDX: 0000000000000000 RSI: 0000000000000118 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
> R10: 0000000020000a80 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I received only this patch, so I don't know what
copy_safe_from_sockptr() is doing, but I guess it respects amount of
data in optval, so looks reasonable.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


