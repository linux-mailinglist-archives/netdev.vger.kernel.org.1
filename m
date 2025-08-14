Return-Path: <netdev+bounces-213703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF0FB26671
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E957BDE1A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28763009E0;
	Thu, 14 Aug 2025 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeKUzaNW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031313002DE
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177003; cv=none; b=NcbQAFszUbfX52aKqlF7IKyfY2jaTO1bE6f/oJq3QD25Tl7m2Jx7U6EJN/DHzbUYnzUodRtMV/ChI7nVKyfW2h1642optK9Cf5xyg+4zLolcdnwhCxg+FbJ6/DCQ+ksG7pJHvc9fenN2UBTKm+x7hnL2hjOfq1XmHCDHvMEOHmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177003; c=relaxed/simple;
	bh=tVdJcOeW/X3njIPoHAy5bw4nf10JcXCp6M0mtPPjGc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Om5mv1OSLhH8u5kakDT/n0PrLEZEJ3IKm1Cpq/YpbUv3LKI0e9f/Ygrsy5Ldu2lMqaE3stOkSBj96J2+4ZzNfgCG0jv7g4sHpHYhkKKvQ0d3cJmkxuxW4cl9dIDmVAR4G8EtpP+SK8PthcOWkZov7DW9lTXj1N1r0YRW8t5c2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DeKUzaNW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755177000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yM4rTyyYMflFWIC6xAzvtFOvRoOr4ZDa9UdfvlAbTNk=;
	b=DeKUzaNWMYzhtgq2r7ZgNWb1Hrah7aCDrx8lo2Dhz3roUT1UjfXtmpxOpNs5te9aft4ePT
	1yePoFW9hXiOLEQDS3CL5k579dWc01WZUIIBJ2+PJFkBp4A7TvG67SQPtlRBktr441ORib
	jQOvEtRByUwr6TxD1HZVbRvzWjtDbbM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-twoK0NPVN2OLQmDNAIyxjA-1; Thu, 14 Aug 2025 09:09:59 -0400
X-MC-Unique: twoK0NPVN2OLQmDNAIyxjA-1
X-Mimecast-MFC-AGG-ID: twoK0NPVN2OLQmDNAIyxjA_1755176998
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9d41e5125so546060f8f.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 06:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755176998; x=1755781798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yM4rTyyYMflFWIC6xAzvtFOvRoOr4ZDa9UdfvlAbTNk=;
        b=dIYb2GaV6BUHo3rvEMONT2QQhv2QIkzIqPkiu6t4RP19ZTiDoP9FxIvS7fKl/qPY53
         69O6CHApHdSTVa0ARH7MjNW3HesLNWXaBgNZGYuUvzumATvsnnAsGHoM5Aj+n/fyVLsO
         +j6O0nS+yPfaDpVcsYG4P6CyzYqHogq/kIdnlZcZQuEb2yFYWk8+KnvKoizgwk7o1wAs
         dYAzOIk7qqJB3xiE9iX6nw8fdnjbsBrnRhBRwcOGia4NZD1aTwsIiQJf52/9JoPDIxLn
         YxO8gFdAH6sGRH38OQNFiHkUSxJ+3TlEkYrkZgi42495ARnvXAODDQ/SZlEOEb+I1Z2M
         2ioA==
X-Forwarded-Encrypted: i=1; AJvYcCWidx59Sd5+aqUZRvu1o2jyDlBFYRllLKYN5zafIzzN7WOooldxXCFS5ZzB94X7np93olbj1rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAcBWcJK4bRl0fRd/P01zRMJ6iypPy+FSqjLy5p+KvmvNL4UHq
	zABBkTX0qTz0km+KygDJ1vEanFLdNcbQ/67tFjyM5UKtgKa+1R6gWfE1HkqVqdPBGtRqsqunUx9
	1e29sqhxPlGXT67bJdgNOfdGm7gQzFouU9OJkp2RJzAZ8rX49IDUOoloF8w==
X-Gm-Gg: ASbGncsO+gHOCA/rCMhjil7tZ6Jw2p1QFzIpSV4YuQxn3ThPNDM2htSSyCfFDw67hAh
	Xw/ir8fy2iUcsriNwuw4s6OYa2MTSIny9QNF4eFq2HVed69/st3JC2YjhfLmlV8KylahG+/s4Td
	1knqDLRdz8NUCqyjc6QHhIE673vyeylC8BDGSdaHUCjkBuQwLpssU07PVxVvptDtG4gEIsn9FB4
	VprBONdUYn9gY1MIf6M8YPEhqD35V39HmrdVyyxGiB+PDiyu0bxPmvH9Si8W+nhiV11jGgpJ/zH
	cwXJp4X0ZWfNvK68y3YMZs2Y+F+G8FRfXqZixpCCE4uquKge7lX+0fArBmrvOk6gfPTRE962axk
	oqsRd+xd7wk0=
X-Received: by 2002:a05:6000:178d:b0:3b7:8dd1:d7a1 with SMTP id ffacd0b85a97d-3b9e41785a6mr2156072f8f.19.1755176998191;
        Thu, 14 Aug 2025 06:09:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOItmJv919kv1xUwu6DXJzN2u5P5qF4xpoviPenWqYdzbR0O2J2Z6h9OmL1CUP/s8o/1+x5A==
X-Received: by 2002:a05:6000:178d:b0:3b7:8dd1:d7a1 with SMTP id ffacd0b85a97d-3b9e41785a6mr2156050f8f.19.1755176997769;
        Thu, 14 Aug 2025 06:09:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abed3sm50640055f8f.10.2025.08.14.06.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 06:09:57 -0700 (PDT)
Message-ID: <bdd670a7-6447-40f0-a727-37832a8ccc5b@redhat.com>
Date: Thu, 14 Aug 2025 15:09:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 03/19] net: modify core data structures for
 PSP datapath support
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
 <20250812003009.2455540-4-daniel.zahka@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250812003009.2455540-4-daniel.zahka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 2:29 AM, Daniel Zahka wrote:
@@ -446,6 +447,9 @@ struct sock {
>  	struct mem_cgroup	*sk_memcg;
>  #ifdef CONFIG_XFRM
>  	struct xfrm_policy __rcu *sk_policy[2];
> +#endif
> +#if IS_ENABLED(CONFIG_INET_PSP)
> +	struct psp_assoc __rcu	*psp_assoc;
>  #endif
>  	__cacheline_group_end(sock_read_rxtx);

This cacheline group is apparently undocumented in
net_cachelines/inet_sock.rst, but perhaps it's worthy to start adding
the info for the newly added fields?

/P


