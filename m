Return-Path: <netdev+bounces-180576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2ACA81BAF
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D043A65FA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F26A7082A;
	Wed,  9 Apr 2025 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="uQRCMYhN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE1C442C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 03:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744170412; cv=none; b=YjyL1bqohtfrDwu5zdKtNr9YgaJWnw1pHS0YZIY0e9nB/LlXnJB10krQ0tPTvTYcZzNVphZ3unOe2h3Feo9weD3FFIfxGIEIIOBOn0TB6omDrPu6cCdg8oRwEBiUhDhgUXwq+RATFxC2IbugapwkB9zCLsXwpvOxeiLryM4is1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744170412; c=relaxed/simple;
	bh=c38k5NxC5UTvrWESclciIp/0Wma2BRjeEb0TWCoh9Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eG+mIsPKp7oCyAja2bGzrGF+reMU0fyWHR98SJ9eqAm8gYupb0K7QJGwvkk20VvJZeWq/CloZCKPzeIVEw6d8yP1iTL1X0elKZ18KOWHzcuykFdBI02Fw2m/tqcT0riqBzO+LBTJhCmurfjP5RqtMSd0c7w/T1YhT2VsF8PmdP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=uQRCMYhN; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af523f4511fso4994922a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 20:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1744170410; x=1744775210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=py3mENGKXJzMS1z0Ezu0V0tIhaLvQv6W38y8yd1FgSY=;
        b=uQRCMYhNzliybHs0bFAn/4VDQne1Eov/xeJvhMrXypCwWEhylodemuxBcEixzTNK0M
         p9P+XmEQCirTi5NiwBUN9twF3vKB79vFOwKwlGudiJ70frG29rp+7VAr8rrjVJTmidvS
         EY3038/yklorol5CQCqwbkwfC0yV+6zeLA4U2QVf/ZX2l35/nDBW+UEkR3YG2UE9MOe3
         pa3fkK3T1yShjcP01A9I6NtRAJriPuoQJ0pisFjoYrDU98BwgDU6YoqHZHm6J0k9joeY
         h5i8XOVHPCqGEYPWw7hPViyVv0U2L+KpPb2/FpiCscMsN9b5kuimHbJgWc9Njee7ScZV
         1Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744170410; x=1744775210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=py3mENGKXJzMS1z0Ezu0V0tIhaLvQv6W38y8yd1FgSY=;
        b=k4Cpkz61IsjIZ8aV2FiCsZazuvtmOjAJdte1NmZTZdHmKPOlFKt1zb+x5c8FyhJqcU
         b+GGvZJJ38SgOFeX6yuFNF6kUhHTnt6tQcecfTy7AyN03JzdxX291JCuDInUnWGu4TYb
         jBzob+mDvFDS+esmdLXPbRAuQMFiiT0AK9BSnb9FSQ0sf0l3FFhmH0E7BwLOd/pRxI8d
         VIkqm7hieeTOfLgcJO87yN0N9uIyNlADplitMfkM9F2vHOyhLbxwoOiCMKb/oCuWZzcE
         HqVoEwRB7qAC026niuxpR9W9+c/ggR7V4HyltmMdMWzbXEbM65xX3dPd+8Dx5fDuPxau
         EYqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWWjNXJ3WrydoqrpmxPw+C/MiKqRxC+sZY4KPmwAKEUR3+lpt8JIP7xKKNCUDCKEFYI8zEODU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvP09HY0TauSrpqAJ2+MmUvtrx4NFMwsBwT4KzNXzH8JSxy6Y/
	nUFxiUJ/BUiOaaTWmM6565z8ZbfPYoLyixfGTZCaJcmEz/4dM95vIhn4bRgoVlI=
X-Gm-Gg: ASbGnct9876hhKrvrAkXhAa+D6TLF6CV7uSIe4Ktoc8EwBv8WqutCjiSPSuMDmRQ8md
	+i4r0OGNdGThryAPO0ug0dUm1dKwe9pW2vRZGuKVDWfj1HP/+gI1ZD0K+CZ0KM1OplNyUSoMYDA
	DzCAT4Tq+WEyYSjHbWBT0mtNriNNWRC8jSHzUMdS4jYBQ5RIZj2YLeeQjGoSL/rO5Oaac/OLvvD
	Zv3PlAZSOL9Eriv+fT08EhF2BcTzUS0Ta+k0a5uliiGyMfnwM/V9Cf9h/vkV1V2Bvg2ZLdqBRKr
	LG5f6RAyg5Y9EuJLLtZ8Qo5htgThdYtRq/Mkaa0vg20tM8uwzpg=
X-Google-Smtp-Source: AGHT+IE/VCko3c/0Pi9VEv7XOV/shf3GrZe3RmbTpVPt9s39kr91Xiw3J/4eier15E7yTl+vv+624Q==
X-Received: by 2002:a17:90b:582f:b0:2fc:b40:339a with SMTP id 98e67ed59e1d1-306dbb90e5emr2526295a91.10.1744170410325;
        Tue, 08 Apr 2025 20:46:50 -0700 (PDT)
Received: from [192.168.1.12] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df2fae34sm254138a91.39.2025.04.08.20.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 20:46:50 -0700 (PDT)
Message-ID: <7c7dd9fa-40ab-4a3b-83e9-4dc338d02e60@davidwei.uk>
Date: Tue, 8 Apr 2025 20:46:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: bnxt: add support rx side device memory TCP
Content-Language: en-GB
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org
Cc: kuniyu@amazon.com, sdf@fomichev.me, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com
References: <20250408043545.2179381-1-ap420073@gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250408043545.2179381-1-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-04-07 21:35, Taehee Yoo wrote:
> Currently, bnxt_en driver satisfies the requirements of the Device
> memory TCP, which is HDS.
> So, it implements rx-side Device memory TCP for bnxt_en driver.
> It requires only converting the page API to netmem API.
> `struct page` of agg rings are changed to `netmem_ref netmem` and
> corresponding functions are changed to a variant of netmem API.
> 
> It also passes PP_FLAG_ALLOW_UNREADABLE_NETMEM flag to a parameter of
> page_pool.
> The netmem will be activated only when a user requests devmem TCP.
> 
> When netmem is activated, received data is unreadable and netmem is
> disabled, received data is readable.
> But drivers don't need to handle both cases because netmem core API will
> handle it properly.
> So, using proper netmem API is enough for drivers.
> 
> Device memory TCP can be tested with
> tools/testing/selftests/drivers/net/hw/ncdevmem.
> This is tested with BCM57504-N425G and firmware version 232.0.155.8/pkg
> 232.1.132.8.
> 
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> RFC -> PATCH v1:
>  - Drop ring buffer descriptor refactoring patch.
>  - Do not convert to netmem API for normal ring(non-agg ring).
>  - Remove changes of napi_{enable | disable}() to
>    napi_{enable | disable}_locked().
>  - Relocate a need_head_pool in struct bnxt_rx_ring_info due to
>    an alignment hole.
>  - Remove *offset parameter of __bnxt_alloc_rx_netmem().
>    *offset is always set to 0 in this function. it's unnecessary.
>  - Get skb_shared_info outside of loop in __bnxt_rx_agg_netmems().
>  - Drop Tested-by tag due to changes of this patch.
> 
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 201 +++++++++++++---------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |   3 +-
>  include/linux/netdevice.h                 |   1 +
>  include/net/page_pool/helpers.h           |   6 +
>  net/core/dev.c                            |   6 +
>  5 files changed, 137 insertions(+), 80 deletions(-)

Tested to work with io_uring zero copy receive.

Tested-by: David Wei <dw@davidwei.uk>

