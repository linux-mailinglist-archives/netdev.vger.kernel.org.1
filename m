Return-Path: <netdev+bounces-117958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD2495012C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190CE1F21E26
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642CE170A24;
	Tue, 13 Aug 2024 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kl9MmtgF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639FC1586D3
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541224; cv=none; b=i2e0b92pfnGFzFGFLdg5zFE9j/+tEYs49PAIE4vJw5CFThr1Z4rg2HCIB/Q9tjsxAoJIeMt9+Hx1sk9pyT51FuaIUb124Gke74USt9Hr7DMs5A1GwMwJZuho5RUecv9Dwq6osOSUG2XLH4XcF+ZOGZnH5BgNWKbxDbAfiDKHti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541224; c=relaxed/simple;
	bh=/m0piTiG6iG2PAH5pweRgitv97w+trJaOOgSnj36HyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oz2L4DU4BCHWlwKEJrhijWZfKA3ig31ta15tcgur/cOWH92Q4ebZVPCPNR/ZsHVFUTY2NIWEei4xb8KjP0GM3ZYmrx5qdQDEgbYd3CJTe8F/3wJExUKUVeuiuSeaEM45EeE8O10HsagiNR4zRqwqhxcL+CR/4gOLk8ulkfIGbNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kl9MmtgF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723541221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0MTZQA2wVKiLRyLY6V1l2YumcTTO/xdYi6zjbu1WN1k=;
	b=Kl9MmtgFElp21gdfy4UXgi7EymScGPpQvbRcXSRw6gpX2LwNXmE3A/4/YPDv0ljzbmWyXF
	W34PT1qTTqYoP35cviz7SRc1Z/QeaNaGjlmpUDvztPzm/8lRfhPR+mVBA9WBXR/epjysKB
	XwYwi7DkA7IHm6MQit29ImTEClMmf4g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-A49IYokEMyS-jYso6Lq1Jw-1; Tue, 13 Aug 2024 05:26:59 -0400
X-MC-Unique: A49IYokEMyS-jYso6Lq1Jw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-429d7db5e22so869815e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 02:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723541218; x=1724146018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MTZQA2wVKiLRyLY6V1l2YumcTTO/xdYi6zjbu1WN1k=;
        b=fKnfyOvvMsIECuzKaV9BkyHZ6fm+EBMMHrw9NeIYtlDhgIN/SeMWIa7J3BmqGnUsBU
         iI4JEZqm2Pks/mrH55OG2OhORMiEdTOuw8Smk7P+E+jUXOBcrR3vUTEArK5GCCoD+I1e
         PA8jKrVBAOSF4vxGScY3L+zRWeoVMiigwypcpVhKoIA7WJtwoftD7VDdgGLv0EjrURNE
         yZk1Kp3vTUHVGk+S8B7JdtCTUewpwzCeqBIt6AtpjXA8uj8xDABNdHkR+M5BXqQ1m/Tn
         z+XZFAgJFtbEJFKwzXVA0qEW10iIQ+wN896PhdBB+t6Fd0WZXma5DOKJbumB9A7QDLlR
         +uhw==
X-Forwarded-Encrypted: i=1; AJvYcCWiQEq+tKqwAsCbE0qH9zSvKQ/RqIvMR7BFEIyVkONfXxu27CxprD7BmObCPtm3vZHr2nRaYD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJ3toOp8OfCAsqLwxmK/kryRQB6iC37iLqd6hJq58CFu8y8ai
	FidA8rvkFN2qEEf4OlhEtxpI8zrbmgNZtvpBWGKKZi7o2vtkl6dA+lwnLA0VQpMIsxtLB69ySuN
	kBDvXMqo7kD3qbA2hVZnlu349Y9GBvvspI7v3gyQdojNCXgEjonVRPw==
X-Received: by 2002:a05:600c:3c8a:b0:427:9f6c:e4bd with SMTP id 5b1f17b1804b1-429d763a8efmr7337995e9.6.1723541218319;
        Tue, 13 Aug 2024 02:26:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyioYYn8mVbrcn3hTYX/9gYGbEuDTYrXJ7rUhx1biqPcUdL2ccf9LuhGJhNOQuR1kxzL3wQQ==
X-Received: by 2002:a05:600c:3c8a:b0:427:9f6c:e4bd with SMTP id 5b1f17b1804b1-429d763a8efmr7337885e9.6.1723541217820;
        Tue, 13 Aug 2024 02:26:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1708:9110:151e:7458:b92f:3067? ([2a0d:3344:1708:9110:151e:7458:b92f:3067])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c79f345sm214304245e9.39.2024.08.13.02.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 02:26:57 -0700 (PDT)
Message-ID: <40795735-028e-4838-8275-958407f1305d@redhat.com>
Date: Tue, 13 Aug 2024 11:26:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: Update window clamping condition
To: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
 edumazet@google.com, soheil@google.com, ncardwell@google.com,
 yyd@google.com, ycheng@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, dsahern@kernel.org
Cc: Sean Tranchetti <quic_stranche@quicinc.com>
References: <20240808230640.1384785-1-quic_subashab@quicinc.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240808230640.1384785-1-quic_subashab@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 01:06, Subash Abhinov Kasiviswanathan wrote:
> This patch is based on the discussions between Neal Cardwell and
> Eric Dumazet in the link
> https://lore.kernel.org/netdev/20240726204105.1466841-1-quic_subashab@quicinc.com/
> 
> It was correctly pointed out that tp->window_clamp would not be
> updated in cases where net.ipv4.tcp_moderate_rcvbuf=0 or if
> (copied <= tp->rcvq_space.space). While it is expected for most
> setups to leave the sysctl enabled, the latter condition may
> not end up hitting depending on the TCP receive queue size and
> the pattern of arriving data.
> 
> The updated check should be hit only on initial MSS update from
> TCP_MIN_MSS to measured MSS value and subsequently if there was
> an update to a larger value.
> 
> Fixes: 05f76b2d634e ("tcp: Adjust clamping window for applications specifying SO_RCVBUF")
> Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
> Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
> ---
>   net/ipv4/tcp_input.c | 28 ++++++++++++----------------
>   1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index e2b9583ed96a..e37488d3453f 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -238,9 +238,14 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
>   		 */
>   		if (unlikely(len != icsk->icsk_ack.rcv_mss)) {
>   			u64 val = (u64)skb->len << TCP_RMEM_TO_WIN_SCALE;
> +			u8 old_ratio = tcp_sk(sk)->scaling_ratio;
>   
>   			do_div(val, skb->truesize);
>   			tcp_sk(sk)->scaling_ratio = val ? val : 1;
> +
> +			if (old_ratio != tcp_sk(sk)->scaling_ratio)

Should we do this only for sk->sk_userlocks & SOCK_RCVBUF_LOCK ?

I think that explicitly checking for an ratio increase would be safer: 
even if len increased I guess the ratio could decrease in some edge 
scenarios.

Thanks!

Paolo


