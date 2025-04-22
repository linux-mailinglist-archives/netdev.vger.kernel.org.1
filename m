Return-Path: <netdev+bounces-184611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39070A96611
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76EDB18994CA
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056EC1E5200;
	Tue, 22 Apr 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RU9ruP9p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B31DDA24
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318220; cv=none; b=kP5pGVDjT2OZgFMdI/15w/NRy7fz1VNlJ/lRy44Nxis3WOWhkjSUHzRgY9mzQe/5Ouryo8WXozegsa5q9mfWAZO1dzAMU0qCgiDoThgF0HsFWJBwuFW0IEayip8+whApLyTEiTMNybZaEhfEQc1CSiNcYae7o8g2brKzCyplCTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318220; c=relaxed/simple;
	bh=lISL3NiWw4mvoLJ62jQX5IcFRZEuxeHYsVe/7mScNZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ngxk4P5SStRVexL+XqGPRVVUIQwe3YrpGwqxrTpiWr6h1fJAL5ZKHHCqh+z4V2I7cSHZfgfLh4e2yN4TpRgpupjqrHvoVxWAJBERSQvWH6SEGUzmCutfb74WYzfYre/fvxCdMvegEblB19PvVU/qhvvXjZVxMX18TRjp+DV3G08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RU9ruP9p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745318217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3XBRVopizL05RbM7mWrrbeHqC8XI4fazOIg42s2uyw=;
	b=RU9ruP9piDrBf4nDt8v1PXr7rjmYTP98hyLJ4noV2aKRhu8VMe/NS1ikXYfqMa3nKe4UB2
	ExAwAXS7mjkDfAs6XiVLR28yjCWZkNh4Hh6hdaL6x89a6jqAIeR/WC1snxGWcW21uQ67tq
	zk0W52ZNAZCOLwEx7OnEf1QozNFU7FQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-W-FOc022OZC1q5ZKzof5AQ-1; Tue, 22 Apr 2025 06:36:55 -0400
X-MC-Unique: W-FOc022OZC1q5ZKzof5AQ-1
X-Mimecast-MFC-AGG-ID: W-FOc022OZC1q5ZKzof5AQ_1745318214
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43efa869b19so30288635e9.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 03:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745318214; x=1745923014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3XBRVopizL05RbM7mWrrbeHqC8XI4fazOIg42s2uyw=;
        b=jN3CyZeL74BnV/H59spV0jtkKgXEgG0/KnpRjUw444Ex/DI4q6NVTfYHqQa4HMj+kV
         s4X/FzO7B/UTt2BaVpPeM/fgFxR4R34ylfooYTM4FQQ1JFCzCePW6Cj0iJ3L682rs6h8
         M7GoH6BLCYhNFKdbzkjiOFuAOsxZPS0g8a8ruzBxFR+YMQ06UHwJxR4A+jXgeFgSZZRB
         gQtSYM8vSMXmc9ivhWIjvnfHW8NU2BVf72+GEACfHA+lIPBPPYopdW25PXvSe5j9fMko
         SQNbuD06Jg1T0URtED1bZLV1cb/dJ3rSfhRkKu/64tqlhpEyak/ZciXhD5OTLG9J9Ixj
         4IPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC1O3Tyk5yw9gXM3Md7v3bvNHhODNrKAOTPqd/WEzqRTp17ju9QcLIKIW7vIY3b6e6azxmxnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpBZuUcJcvrujKRkVnw5cAm0OZ98KpuJAmEjdUnsOQHhC/Y/Pv
	VmsyJgAgiFF8GradzzjbCw1a/jxfsHX5UiJbWmQTKhRUxoLYH6oxFr0BD7OWxs45kcDnM2bn2Zb
	GglZVSZ5U1smWnGLcgY/Il/VOTJjszTj/MqNkQP6nUu+mRFi+GZy/5A==
X-Gm-Gg: ASbGnctcmD3+GMroAyeJYSEhbeuVcPErnUpZ6aXufPrQfH6dkC1Ak8ZHkKfvw09ms6H
	qcwFvT+l9wu0IxNXNRcUxH3bhAMYeTZsfiqBvhjMAauN39pd49YWS8S9/LoFzkNFW0KOV/20k8U
	gw2t1QragSV/HMwsN0VsGd6T1VrfHn/CLOlwQQ6Ira+TLnOoPGdGRafptlOB7iuWGRZKGevZPST
	s80kpPiFkNTK82VMbJLpynOhnjC8zljN/5G+U5X+kVFhAPboYtLmpaFU5WfFBE+l15i4AnctDNm
	h95RPECge0Und9HOqA0CY7zWc4MAGtni/XcL
X-Received: by 2002:a05:600c:a088:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-4406ab9767bmr174966365e9.10.1745318214298;
        Tue, 22 Apr 2025 03:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPrwg9VkOHDbgQPuydQXO/FAlkVS9kR0/xcjl/pevPw2FccxA7aaeSvgcnpK7uvnK2aFmoIg==
X-Received: by 2002:a05:600c:a088:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-4406ab9767bmr174966015e9.10.1745318213813;
        Tue, 22 Apr 2025 03:36:53 -0700 (PDT)
Received: from [192.168.88.253] (146-241-86-8.dyn.eolo.it. [146.241.86.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5ccc97sm170734155e9.25.2025.04.22.03.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 03:36:53 -0700 (PDT)
Message-ID: <f5d244d2-acd4-4dfc-8221-93d2a714b97f@redhat.com>
Date: Tue, 22 Apr 2025 12:36:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] TCP: note received valid-cookie Fast Open
 option
To: Jeremy Harris <jgh@exim.org>, netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com
References: <20250416090836.7656-1-jgh@exim.org>
 <20250416091513.7875-1-jgh@exim.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250416091513.7875-1-jgh@exim.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 11:15 AM, Jeremy Harris wrote:
> Signed-off-by: Jeremy Harris <jgh@exim.org>

The commit description is missing.

> ---
>  include/linux/tcp.h     | 3 ++-
>  net/ipv4/tcp_fastopen.c | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 1669d95bb0f9..a96c38574bce 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -385,7 +385,8 @@ struct tcp_sock {
>  		syn_fastopen:1,	/* SYN includes Fast Open option */
>  		syn_fastopen_exp:1,/* SYN includes Fast Open exp. option */
>  		syn_fastopen_ch:1, /* Active TFO re-enabling probe */
> -		syn_data_acked:1;/* data in SYN is acked by SYN-ACK */
> +		syn_data_acked:1,/* data in SYN is acked by SYN-ACK */
> +		syn_fastopen_in:1; /* Received SYN includes Fast Open option */

Worth mentioning in the commit message that this will fill a bit hole.
>  
>  	u8	keepalive_probes; /* num of allowed keep alive probes	*/
>  	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 1a6b1bc54245..004d0024cd98 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -401,6 +401,7 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
>  				}
>  				NET_INC_STATS(sock_net(sk),
>  					      LINUX_MIB_TCPFASTOPENPASSIVE);
> +				tcp_sk(child)->syn_fastopen_in = 1;

Likely you need to reset the bit on disconnect().

/P


