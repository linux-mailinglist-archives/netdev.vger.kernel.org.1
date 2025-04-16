Return-Path: <netdev+bounces-183183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64863A8B4E4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A1B3BD88D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F29621348;
	Wed, 16 Apr 2025 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYXFKxWg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E90233D7B
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794825; cv=none; b=Qn9hajqdEqVe6taSRtZs49pfKGk7gC1g6uoanKxiQr0ii/g3AB9bQANS5LtOCVjmnjx8/6jmYyy9ZX6WYv45IMge/IxGc3u4X7kViOj06h30F9C9CzcbXfG5It0+2q50gfW7biHR3CURJfKSK5vLXoRSuZRVZiEnQZwOayiawWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794825; c=relaxed/simple;
	bh=1pCpjKGQrA4A8Sx9e1mDtYC2ppHwHr+Iv3fJRBiUo4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n22fzIVTkCXrWz7K6XfrTFHPOLvPL4TseFKKmhUTyvo0OVfv95LdXfNSNCzNKfiTY0heeH9+cxauXrGkyRAqULBn1e94gX23vGDKj8RRCfyNLmiRD3rafHMz9I6q7bE/nffDqQqthl9F5ppDMakjHThjTnPlJsrn2pIfwcbTpss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYXFKxWg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744794822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvCVmxNSJLqdG6xiuVPZpYQtkVRsxxGzg4o7yJUPVaI=;
	b=fYXFKxWgDBWHopN8qRxnXvUqkoVvYD3K4BVn8LCeS+Ljz8riDrRXv9X75Cj5VeSppBJbpO
	nokseTG+/opi10JHUAgnVjet60fxw+FG56d3BhHSZxwysJaNc14PRqq3Xn+zWIhoNq7dSc
	UrRq4IivkN5CrMJSb3ITtPBIA54GpKQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-z0SrRcAFOBm4UA8lmVkCKw-1; Wed, 16 Apr 2025 05:13:40 -0400
X-MC-Unique: z0SrRcAFOBm4UA8lmVkCKw-1
X-Mimecast-MFC-AGG-ID: z0SrRcAFOBm4UA8lmVkCKw_1744794820
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso38763005e9.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 02:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744794820; x=1745399620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvCVmxNSJLqdG6xiuVPZpYQtkVRsxxGzg4o7yJUPVaI=;
        b=Scrx6qTHkYUU20a947ya2y3qE4bidzZuulYGFWKvg3wzJlgbRWfEIHySQ+ZUSH2TDW
         rOs1StSef4N1UWP0WHsR2LazwDunxxnw5bkFJmnvjXEwMqXehI5Vc5fRp7Vhp1X2K8Bq
         vX4Hn74vyKQfDTG2+vGq9gJOHHkXQ2TPw/imR8BqonG/VKf/xhpD/zhp4sXQ6fWKb8gM
         sxr5ZZA962AuXMyFuEJN8Z18jhWL6jlOjvp6tBhtem/NuaDyt/o+4qe9X61Dq0XbEhJ0
         zdKzRegxi8ERzo3NtiZg+7QZq69umvAFb2Lf9gKKTBfF+rfBQucNbuIDSPBJzXzmz8yq
         rKkA==
X-Forwarded-Encrypted: i=1; AJvYcCWIccqjPKJRDfKYOfCzuWm4dRoqWOWcJi3YkBdoYoEm9SUJVIhthrgqbOqFmzzCQJQpKGY9Ga4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhJt/owreYNjlBZyETIzlUv6AwLJnUJsovE+drpRG0O46skv7u
	YAd0/2mlmIk0M9ebwL6lnWm3sEeGsQOBQEYsfOkjYbn6WuyQZXBGq84MtOlw7VGfKD3TxVgHxpZ
	6yz7bojNqFMCCoG0Opt1y/TlBp2d6xeXrwYMXJxEoCYjjz7ZdG8IjTA==
X-Gm-Gg: ASbGncu8RREfmH32x10HstCIdhn4RMqDkkA4RNuEfve6exKbSQYjI2q7+AM/xf6F+CG
	ue92ZRYGQaE+HcEuXXFKjf7CnBz2wH0lfEdf4Ln1aS0lRvlysuPmJxZUmrBYlkkdoP3BWmXWhJb
	uOQn+7tmcorfipR9o+qSAoKYZ4bDPpaehwU+Fu0LmvjWmSCQtZpqMUAITA9QGh/k3Lmy2IEVlCv
	QrufBV7gUoEf9e1VVuvFanFNBVFSo4GEBKT5mQ4/vMF9SzZD9nNMaBEX9CEBR9rzr5A9Ngx5jXq
	85g5Q5pOOfjoryzk0eBCpHQBmcF52zTHMH7oHMQ=
X-Received: by 2002:a5d:6d83:0:b0:391:4999:776c with SMTP id ffacd0b85a97d-39ee5ba00a8mr1037617f8f.40.1744794819833;
        Wed, 16 Apr 2025 02:13:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdqEISuOOHaPFl1UFIGCdx+GyfBJY216X9t/2yGkeLjF4tkEGeNZIM0E8clzxQAd7Knyoa/A==
X-Received: by 2002:a5d:6d83:0:b0:391:4999:776c with SMTP id ffacd0b85a97d-39ee5ba00a8mr1037587f8f.40.1744794819468;
        Wed, 16 Apr 2025 02:13:39 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b58cb6csm15256555e9.27.2025.04.16.02.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 02:13:39 -0700 (PDT)
Message-ID: <f27f9cd5-6823-4aa8-90c8-5c24c9d30a8d@redhat.com>
Date: Wed, 16 Apr 2025 11:13:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 05/14] ipv6: Move nexthop_find_by_id()
 after fib6_info_alloc().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-6-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414181516.28391-6-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT.
> 
> Then, we must perform two lookups for nexthop and dev under RCU
> to guarantee their lifetime.
> 
> ip6_route_info_create() calls nexthop_find_by_id() first if
> RTA_NH_ID is specified, and then allocates struct fib6_info.
> 
> nexthop_find_by_id() must be called under RCU, but we do not want
> to use GFP_ATOMIC for memory allocation here, which will be likely
> to fail in ip6_route_multipath_add().
> 
> Let's move nexthop_find_by_id() after the memory allocation so
> that we can later split ip6_route_info_create() into two parts:
> the sleepable part and the RCU part.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


