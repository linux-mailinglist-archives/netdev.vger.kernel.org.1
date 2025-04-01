Return-Path: <netdev+bounces-178504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6306A775D3
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8D2188BAD4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 08:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8FC1519B8;
	Tue,  1 Apr 2025 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVlTbT8J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFA82CCDB
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743494466; cv=none; b=CaxH4dWDFpipPnewln4eWvoFK4j/TXqdeHWu6BI3hKA8WSsmGl1rhmBBsq3MrUlFH8ygmoJIsmPe3FjiCHHMCQt42QleUOyCLSqSlLHQvGbuEkKijYQUspVA4Nro65rnzn+dVTWvAIj2UVpJ1mgmlo/AeW6dfOgB0/rV9gBf+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743494466; c=relaxed/simple;
	bh=vF0MLQK/lzrdP1WnaEHxCSElnMUTw4/1RrrdbDJIibI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgXonxjDACnQC2DAPpss2NlKV+eKFuIZh/cXgBc/zmhxsEHQtWj/0BlFGjMrq3+dp8vEuziwTD1Y1CPI4VmmJPilEZO51aXLon5qYVdZrd/kHhhJ1uC3q8O6io2U9s/r0n+0XHQI7EEBdxc3HT0Q9qJRzYO7tfqjLrG1lSLcb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVlTbT8J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743494461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9U+s9lfa+BQ/cjnWbSMSKcFL39z1ZZN+/5kr/bKe5o4=;
	b=bVlTbT8JhS6E3HswLn3R12BnTWmUBn4NxinpKMwSMKXLuKOMLgU3HAG/xjTNXmiSiYPsSQ
	YT9BoXjtwBdUc12DLc1ZzNe5PVvX++0aa9+uiop0KP87+hOMfH18H8nMhrRDuQrCo1FJDr
	2HZW8iGIejXQHK+Dgls3qQLGh3AtkQs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-J9GYgW57M6OG8piLkbTM0A-1; Tue, 01 Apr 2025 04:01:00 -0400
X-MC-Unique: J9GYgW57M6OG8piLkbTM0A-1
X-Mimecast-MFC-AGG-ID: J9GYgW57M6OG8piLkbTM0A_1743494459
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so28946835e9.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 01:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743494459; x=1744099259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9U+s9lfa+BQ/cjnWbSMSKcFL39z1ZZN+/5kr/bKe5o4=;
        b=nzH55Oad6vsb6TGXaAu8u4XuQziyKX/drzgVgDO+bBfKXXcQqrm+AaNN2OmiAXYwWX
         Kj5E5HIPrIWj9R5VOMjp2c3TwBvbncr32nvmO5itH0DwbHwOMz7RPx/ssi8HnVqD1ZHq
         zLyr/0O2F1x2GBNc3CV9ja0YuF+946wJSTsusZY6oFujmhAJ4Lsf2X7c6z1iaq8FkQ0W
         3hBs//TfUGPdiu2C0L8iDCRb58vD7j3eA6LHDG5WyLa2ucyWAMyTetr+FPzfXy5cS18R
         7Ge4r6WUamq/WWZmpiS8lHMzUMjUBjoAB28g1VepUVCwaxeBN1TdfcvSs0a8u/sTrIM/
         +YDA==
X-Gm-Message-State: AOJu0YwaGWE8B8ji28+VJ2F7FlPJw/s8LEAaIGG9Sg3hkJMypZZcLznl
	eRdzOomt5hlCjrRgFudH9Sj3T87CPJjAR9kAV9EtnMsNbZiTeqsX371QT2HrtqrQSSxXnzk8r9e
	6YsczutX7zfJ3DJ4HCGmIjgkYPTxUed6JXmTqsXpi1TpobKY1YqL8LnBDegmJNg==
X-Gm-Gg: ASbGncuiiXmnKphKdyVOD7aVG/9YJ64KITK16OpqB6n2rOwS4qYTeVrPVKkPX57ImIS
	pT8NV7QG+w3ai3ua2ZcDWqutonejlVSOGb5cuHY57OythlOoPlJ1u6b02BrKFXzodCgbHGC3deF
	KXTBBj8D9lfRTXTkm8e1aikp3LRjkVMUHx+C1Q1W8la3U5KGDgfRwAKLRskra1oYpVYGO5wDgKL
	FQgAylFVA/n0ieyaqNSdbZ4rCo8kc81t5psQrT18LtyL/JtpQ6pyLZZD4C+TKrsFhyKovBe0Kk5
	gWF2A+w6mrFztYlksrcwbBUIqa/DD8vABc/kC/lhtIQj6w==
X-Received: by 2002:a05:600c:3b0d:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-43ea7bf5717mr21708335e9.0.1743494458314;
        Tue, 01 Apr 2025 01:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGZ7ksymd6aGSbSGOSjlkINGtj/6UYjuZp9xMQsKN37O9NglmzIKwhyn/osx0EX1vdPjqXhg==
X-Received: by 2002:a05:600c:3b0d:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-43ea7bf5717mr21707955e9.0.1743494457953;
        Tue, 01 Apr 2025 01:00:57 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e33asm13588688f8f.66.2025.04.01.01.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 01:00:57 -0700 (PDT)
Message-ID: <89dcde93-8e5a-4193-aa01-fde5dd5ee1fd@redhat.com>
Date: Tue, 1 Apr 2025 10:00:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: decrease cached dst counters in dst_release
To: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com
Cc: netdev@vger.kernel.org
References: <20250326173634.31096-1-atenart@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250326173634.31096-1-atenart@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/26/25 6:36 PM, Antoine Tenart wrote:
> Upstream fix ac888d58869b ("net: do not delay dst_entries_add() in
> dst_release()") moved decrementing the dst count from dst_destroy to
> dst_release to avoid accessing already freed data in case of netns
> dismantle. However in case CONFIG_DST_CACHE is enabled and OvS+tunnels
> are used, this fix is incomplete as the same issue will be seen for
> cached dsts:
> 
>   Unable to handle kernel paging request at virtual address ffff5aabf6b5c000
>   Call trace:
>    percpu_counter_add_batch+0x3c/0x160 (P)
>    dst_release+0xec/0x108
>    dst_cache_destroy+0x68/0xd8
>    dst_destroy+0x13c/0x168
>    dst_destroy_rcu+0x1c/0xb0
>    rcu_do_batch+0x18c/0x7d0
>    rcu_core+0x174/0x378
>    rcu_core_si+0x18/0x30
> 
> Fix this by invalidating the cache, and thus decrementing cached dst
> counters, in dst_release too.
> 
> Fixes: d71785ffc7e7 ("net: add dst_cache to ovs vxlan lwtunnel")
> Signed-off-by: Antoine Tenart <atenart@kernel.org>


> ---
>  net/core/dst.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/core/dst.c b/net/core/dst.c
> index 9552a90d4772..6d76b799ce64 100644
> --- a/net/core/dst.c
> +++ b/net/core/dst.c
> @@ -165,6 +165,14 @@ static void dst_count_dec(struct dst_entry *dst)
>  void dst_release(struct dst_entry *dst)
>  {
>  	if (dst && rcuref_put(&dst->__rcuref)) {
> +#ifdef CONFIG_DST_CACHE
> +		if (dst->flags & DST_METADATA) {
> +			struct metadata_dst *md_dst = (struct metadata_dst *)dst;
> +
> +			if (md_dst->type == METADATA_IP_TUNNEL)
> +				dst_cache_reset_now(&md_dst->u.tun_info.dst_cache);

I think the fix is correct, but I'm wondering if we have a similar issue
for the METADATA_XFRM meta-dst. Isn't:

	dst_release(md_dst->u.xfrm_info.dst_orig);

in metadata_dst_free() going to cause the same UaF? Why don't we need to
clean such dst here, too?

Thanks!

Paolo


