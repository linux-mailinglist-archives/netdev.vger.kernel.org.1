Return-Path: <netdev+bounces-114078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A393940DEE
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF3B1F2375D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041819599C;
	Tue, 30 Jul 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JC7w+CcX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B227C194ACE
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332328; cv=none; b=cLNIrIWQn7TpFw4fdiKjJeZINd34h+QQ0AYZjGDhOldjvMAY3JZCfSUXiJgACzzxJdEMY1HJCYyUaWSkN/5/qE6az9G/1YbX2BtMtcbP8irj9G6l3awpRLyGPsl/iUsHt/wlYsB8TUUStGJZfP2gSgr8uFWW9o9TCkJFX5s6Zj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332328; c=relaxed/simple;
	bh=qL1kDyOGD1HYav/k1nxuKAfnluklrq97MHHt7d7K1fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8jSxWBfdluoXjm1cPESDAmazL/8m1u0nLjUVIxI+CqgOwqP2eAAp53Gp6eaP/9PkZirRxxkzUqNF5trL7N75YNl4Omz3GFTmdDsq6+hI1pP3Azy07nGbz1nNyZzbID2rEh6MEU2rJL0rqCibPO/035evyMhUTCgPJJOKOPpjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JC7w+CcX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722332325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phDzjKwp80MM13n6avUktQX++fQYwsEM9HCzCsqBDFE=;
	b=JC7w+CcXauyfHGck5B7USLvhkMQKTuetTdtiRRI3MuDajVuURXwLzl0ulZOJGZDye/R1T6
	zzOENwNKwYLkNpjtCJwsMZ9wYUVrI3FRmmCFp9WMB/ifBxbekG+XSC3lHgPASO03GTMISn
	0J5kPVdewghaMdlUZu0Fmyo3RX2JAWU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-SAJS-AWNP0moG5sGY9oNaA-1; Tue, 30 Jul 2024 05:38:41 -0400
X-MC-Unique: SAJS-AWNP0moG5sGY9oNaA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef2b4482e5so9524261fa.3
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 02:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722332320; x=1722937120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phDzjKwp80MM13n6avUktQX++fQYwsEM9HCzCsqBDFE=;
        b=uk4PM8jbSVTOgZxlzUfd5zKZIE6u9WoGKsFJTufzV8fP1VwNul2cSM8CCAXidL+6CQ
         15+5VYWvgal5dc9vACIY8pUxq8P5EI5ak6WFNQctclOaYH3PwdBcnaNS5X0bPacMpQpE
         eFGm1vSUlrFLXsaeOUbOWk4zsmdGNicTbQlNvbhaHs8y5eYNYddwzEvyHT2UpLoL4QQs
         Qnt7X0S4eDKtQlS61J17veV5jirVOzqmEdVxa+n0vslTXkQnjzDjIGyVyHW1ZPR6alDd
         V2HwixP6aLnfhlpHlIcLlYDocdWCDk9NmvgPIKiGj3W75F3rvDJcp8qFpZNCBACR1oyG
         BORw==
X-Forwarded-Encrypted: i=1; AJvYcCWvT2XulwkOi6/MxCjv3GiiRbx3P9AE0MVtXjJRyWpNLsRPoux2nKPdRxZFWdbybdWjIAPZaCLxPG0RnVra/TrQOnmw2dNl
X-Gm-Message-State: AOJu0YwNvwRU0eACRUfZ+0wFrM3bjGqXD9SKEXubie7SztwbGaS/xj9q
	+65WH9zsO0zgLrF57H2Q8yssKE0cPV52T3bFsB0pvMcoREK8yKR++kkkkid1aq1f9ET3/aPedMr
	OMTNqg7svq5z9x4p8+TFSXQF8Q9zTVsIbX2E4Vlg2lZ5umd4I4mQTcQ==
X-Received: by 2002:a2e:2a01:0:b0:2ef:2e9b:c6ee with SMTP id 38308e7fff4ca-2f03c6fe714mr53276071fa.1.1722332320291;
        Tue, 30 Jul 2024 02:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHGD7olFlSvG+Qr52zWtWC/ZDZv4AwGJ7lv8JG1gCZkEE5xqwlmhK+iKXwURU29ge5pfiarw==
X-Received: by 2002:a2e:2a01:0:b0:2ef:2e9b:c6ee with SMTP id 38308e7fff4ca-2f03c6fe714mr53275941fa.1.1722332319861;
        Tue, 30 Jul 2024 02:38:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410:9110:ce28:b1de:d919? ([2a0d:3344:1712:4410:9110:ce28:b1de:d919])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730c3dsm210213075e9.7.2024.07.30.02.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 02:38:39 -0700 (PDT)
Message-ID: <e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>
Date: Tue, 30 Jul 2024 11:38:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: skbuff: Skip early return in skb_unref when
 debugging
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: leit@meta.com, Chris Mason <clm@fb.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240729104741.370327-1-leitao@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240729104741.370327-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/24 12:47, Breno Leitao wrote:
> This patch modifies the skb_unref function to skip the early return
> optimization when CONFIG_DEBUG_NET is enabled. The change ensures that
> the reference count decrement always occurs in debug builds, allowing
> for more thorough checking of SKB reference counting.
> 
> Previously, when the SKB's reference count was 1 and CONFIG_DEBUG_NET
> was not set, the function would return early after a memory barrier
> (smp_rmb()) without decrementing the reference count. This optimization
> assumes it's safe to proceed with freeing the SKB without the overhead
> of an atomic decrement from 1 to 0.
> 
> With this change:
> - In non-debug builds (CONFIG_DEBUG_NET not set), behavior remains
>    unchanged, preserving the performance optimization.
> - In debug builds (CONFIG_DEBUG_NET set), the reference count is always
>    decremented, even when it's 1, allowing for consistent behavior and
>    potentially catching subtle SKB management bugs.
> 
> This modification enhances debugging capabilities for networking code
> without impacting performance in production kernels. It helps kernel
> developers identify and diagnose issues related to SKB management and
> reference counting in the network stack.
> 
> Cc: Chris Mason <clm@fb.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   include/linux/skbuff.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 29c3ea5b6e93..cf8f6ce06742 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1225,7 +1225,7 @@ static inline bool skb_unref(struct sk_buff *skb)
>   {
>   	if (unlikely(!skb))
>   		return false;
> -	if (likely(refcount_read(&skb->users) == 1))
> +	if (!IS_ENABLED(CONFIG_DEBUG_NET) && likely(refcount_read(&skb->users) == 1))
>   		smp_rmb();
>   	else if (likely(!refcount_dec_and_test(&skb->users)))
>   		return false;

I think one assumption behind CONFIG_DEBUG_NET is that enabling such 
config should not have any measurable impact on performances.

I suspect the above could indeed cause some measurable impact, e.g. 
under UDP flood, when the user-space receiver and the BH runs on 
different cores, as this will increase pressure on the CPU cache. Could 
you please benchmark such scenario before and after this patch?

Thanks!

Paolo



