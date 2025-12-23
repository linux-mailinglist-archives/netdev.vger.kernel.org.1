Return-Path: <netdev+bounces-245868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAEDCD996A
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 15:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1C73300C283
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 14:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D88926B756;
	Tue, 23 Dec 2025 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxXfUXnU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0C2pMk+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982413128D7
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499188; cv=none; b=fGxfAcchOQVxOk3J8w7E3Qn3z/xAj6i7UPKRpZDHvd6HK4NfNKOnXEudAN1j0AY6nWKdjXu3I1egPQGIUnmOzl47qoFazIvU9tOVxCKCbi+7XTD244JJKLAt3fryhdI04abj+CXAIBnBuPODlwwIa02tsw69OfQ/Bjd+cAh6QKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499188; c=relaxed/simple;
	bh=npo998vyw91hSEqyr83yySfdDZvwpdc37NOZXBUKUh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZ6lv0/JrUuZi9LQtPLP6gPv8wUnvVPNosXDr3tCoaPPASbdotM4GYsZUKyMU/n0NNSOYz03DN6kKBFOAJeDMsJPRfmEmqzrTppDa0wlape5X4CtC6c+d9itKHUyKvIohDJXmypdMRzwubAuSSA5+pmm4fvWLmJeQ/hcON5grBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxXfUXnU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0C2pMk+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766499185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tnt9HsgJu0ejswucQziIfqB6VQPJ8jxDsIeAyekFBzs=;
	b=cxXfUXnU32MfBWAJ40h6t+wTdNZb7z8sWQC10Oxsspae/duLdGXLMlz6f6T1ZExBBRNqDG
	hKL6swrpv4scGb846TjnmHl9qBpebCc1CAwZ7J+WwXS1lV/IEzng4UPYsO+SJHckwB1ZMq
	XOfzIOXLd/e1TOM/G7ajC3zhE3WGeYk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-jdRXhIBcOS6LoMcn-0nCvg-1; Tue, 23 Dec 2025 09:13:03 -0500
X-MC-Unique: jdRXhIBcOS6LoMcn-0nCvg-1
X-Mimecast-MFC-AGG-ID: jdRXhIBcOS6LoMcn-0nCvg_1766499182
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so36424705e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 06:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766499182; x=1767103982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tnt9HsgJu0ejswucQziIfqB6VQPJ8jxDsIeAyekFBzs=;
        b=F0C2pMk+yxcx7iFZgwfjPAeEhqg9o70zj+y86L89a98ESWuCazF6BtPZ1eSvEqHe4H
         r6cgQWgQVHOp0bTdyx/X1eA+aQWAAL5+GFOkLke4LlmCP0tHwRsIyRdFrC0E7cWgEUrr
         4s1bmRi9M4bFMwxXTy4HEaVPWpk6/23ZrItK5ryShizTjBcTJzuSBdexW1swEU5glIA0
         oxhiwiKTgqFvhjQwcuLmTlBoX0nbEKYeyudZXHnxZU+hHa20MNFTXYBJL/9i6wXvTJmp
         rzA3s0dEYMZ/hQfNhOTWwAo7s7v5eB4XU5PaMFetmFFARRHNYrl63M4VkT0uk4cKgW6i
         moow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766499182; x=1767103982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tnt9HsgJu0ejswucQziIfqB6VQPJ8jxDsIeAyekFBzs=;
        b=eXye0JU9iOKuy1r4hT28NFwKU55/ODZvIyoeevy7YOtzyMgZzxFz2+DFoFY/F9xvOD
         RXHgLzuTTeFBsCXils8x5EWexQ2msh9zUrzFI1QzIksl3yKqQxtXc5fj/gTRWsueKCFh
         8v+gMOAtfZHMbScsksjEhO2cFGjlWQY57uHsEWRG1ktg6WwVqG9baofhNrWX2qlzlfQf
         Qc21N+760mfuoZKY49ndfa5Pp3cHiLglJdsrnhkz/3tL1ZPs0GvrLqB6PAmYHmnXlUq7
         sbluVltQDG+iVXPm0NeP02IWvA58qBZXhNAk0fmh+I2aZoqsQ1GhUMkLeCkbk0foy8/T
         XoAA==
X-Forwarded-Encrypted: i=1; AJvYcCUKj/q2EPE+aiKTJU2zg08FCVcZd0V52GmTvOKtqlk0m/5gYaygRS5jvtuRWYb7opAu28weCmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7rQgKh4LgbSBdGcPbKkLAcZ8AZpJC80u3NquiXQF3/yYzMeuo
	gAf+gd8eL2LJRrGzM/96Uv7pBrSMz9H5He2xYQmefg0jLY5MHHudE/LRw9xm9e8dtqaVA8peCZs
	T2iMFB33B8HxrnK9aQO2QXM6gwfXScY4tWVjcH1vHJzoEjtMeJZc9g/3INg==
X-Gm-Gg: AY/fxX4aTR97K5troxqqvR0C/dWvAe8UXBDjF+Jsf3oHKxaQ9ZgwQrua4nqMbXvNtOo
	6jhfJJabPkurVaeMk8VzZHk/C2J6lUP02AsAvmLZRlnRPl7wE9exj8/v07mnIjixTa1sj/sBR8/
	LkbbHL2h643DZ1xPtlYvQnAiZ6uAgi9Rip4n9d25D+8rKdugnl7lqZfkj0tfDnws3kXs2TfKX+K
	C8cNRqac+PKMLXm1bdfc8W1/GUD5G/Kyx9l5fm71ybmMeOriUImXOJJ7Kwasdl7tirCQUSMFGih
	TZPVJ9uG9EDPakUNnCYfZoZhZMewgKvFOV4k8QGEYfqJPSPQxbFUeM1MxZts+CMZJVPSvBDgnqh
	5P8kUN1CaAkgI
X-Received: by 2002:a05:600c:a00b:b0:477:7b9a:bb0a with SMTP id 5b1f17b1804b1-47d1957e4e0mr139227675e9.21.1766499181634;
        Tue, 23 Dec 2025 06:13:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd2F5z4wbLe3efZdpRSf3+bxZeFuR7kdHFUh/07zOmiOvBJ9uVUehgrpT1q45jZN+DWyz2Gg==
X-Received: by 2002:a05:600c:a00b:b0:477:7b9a:bb0a with SMTP id 5b1f17b1804b1-47d1957e4e0mr139227375e9.21.1766499181248;
        Tue, 23 Dec 2025 06:13:01 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm238919555e9.0.2025.12.23.06.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 06:13:00 -0800 (PST)
Message-ID: <aab6c515-12e4-48ca-8220-c0797dae781f@redhat.com>
Date: Tue, 23 Dec 2025 15:12:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fix segmentation of forwarding fraglist GRO
To: Jibin Zhang <jibin.zhang@mediatek.com>, Eric Dumazet
 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: wsd_upstream@mediatek.com, shiming.cheng@mediatek.com,
 defa.li@mediatek.com
References: <20251217035548.8104-1-jibin.zhang@mediatek.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251217035548.8104-1-jibin.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/25 4:55 AM, Jibin Zhang wrote:
> This patch enhances GSO segment checks by verifying the presence
> of frag_list and protocol consistency, addressing low throughput
> issues on IPv4 servers when used as hotspots
> 
> Specifically, it fixes a bug in GSO segmentation when forwarding
> GRO packets with frag_list. The function skb_segment_list cannot
> correctly process GRO skbs converted by XLAT, because XLAT only
> converts the header of the head skb. As a result, skbs in the
> frag_list may remain unconverted, leading to protocol
> inconsistencies and reduced throughput.
> 
> To resolve this, the patch uses skb_segment to handle forwarded
> packets converted by XLAT, ensuring that all fragments are
> properly converted and segmented.
> 
> Signed-off-by: Jibin Zhang <jibin.zhang@mediatek.com>

This looks like a fix, it should target the 'net' tree and include a
suitable Fixes tag.

> ---
>  net/ipv4/tcp_offload.c | 3 ++-
>  net/ipv4/udp_offload.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index fdda18b1abda..162a384a15bb 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -104,7 +104,8 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
>  	if (!pskb_may_pull(skb, sizeof(struct tcphdr)))
>  		return ERR_PTR(-EINVAL);
>  
> -	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
> +	if ((skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) && skb_has_frag_list(skb) &&
> +	    (skb->protocol == skb_shinfo(skb)->frag_list->protocol)) {
>  		struct tcphdr *th = tcp_hdr(skb);
>  
>  		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 19d0b5b09ffa..704fb32d10d7 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -512,7 +512,8 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  		return NULL;
>  	}
>  
> -	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
> +	if ((skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) && skb_has_frag_list(gso_skb) &&
> +	    (gso_skb->protocol == skb_shinfo(gso_skb)->frag_list->protocol)) {
>  		 /* Detect modified geometry and pass those to skb_segment. */
>  		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
>  			return __udp_gso_segment_list(gso_skb, features, is_ipv6);

I guess checks should be needed for ipv6.

Also it looks like this skips the CSUM_PARTIAL preparation, and possibly
break csum offload.

Additionally I don't like the ever increasing stack of hacks needed to
let GSO_FRAGLIST operate in the most diverse setups, the simpler fix
would be disabling such aggregation.

/P


