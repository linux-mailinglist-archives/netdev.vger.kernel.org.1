Return-Path: <netdev+bounces-111726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F15C932589
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F88C1C2245F
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D467D198E60;
	Tue, 16 Jul 2024 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8Lk+DDz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553411953A8
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129083; cv=none; b=IQUo9ny/+UjI6hjaejwOEaa0x9NlFLryuDAHLtVUHt3i8SIMX8tVBUWTO2WIptSjkA+1n6IPK72x3i0Hee1UoM3d9m5EM7rxg4HQUQOzei4fJUwS+47PjaMy/dPhmF8VcCvNjp70rToi+361c+iXHVot/zmwXETp33DHWoU6icE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129083; c=relaxed/simple;
	bh=DgKuKRTEZ4elrnLxiUiV49PCVL1/62eRHniBrw+ImiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDAXr7qla/UhFB5CKxlk9yn4viR3WgEjIrqZrW36301ssTjEs2WzXKZhQi2v78s8PBiXtcRgr+YiKY2MCPVIGJB5NmsSJFM44XtFkpzgz7smsMLD+cniPIswjUFAuE6rPd78CacSyBAQx7LVAYJTfeRd7twPqNQ2s7OgFA7rM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8Lk+DDz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721129081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xigDHiuKg1vf2r9wLNcMWu6wRFVXSmz8+urmcNUTy4=;
	b=c8Lk+DDzv9DeaGNnh8kUHmDT7J9J5k+Wxnk5N1LCUaElPtoyIavNz9zEqxdgolErOTLpYu
	3E1xALkoRNCmgV3J6fGY3O7iqUgipwQ/VM1OhZbeTvuEF6qjLn/xlF+8a7I2kmHkzHlhPt
	PlkAhHftrrI6+XJSiVPUI+zY1MU1Q4o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-BvBQb2WePbeVtV2iZlNhvA-1; Tue, 16 Jul 2024 07:24:39 -0400
X-MC-Unique: BvBQb2WePbeVtV2iZlNhvA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee88b1c3e9so11463201fa.0
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 04:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129078; x=1721733878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xigDHiuKg1vf2r9wLNcMWu6wRFVXSmz8+urmcNUTy4=;
        b=t0f/VwJmlZnNHrIMXKdXykPAWh4uHHq2R4A/HHLv5MBhoe0kDvxk3kzWZKOeRyKDZu
         ykojdINYFq0vz+kgCH6VejDAfAxzaU9014k94yVM9FSOjsM1Uy/rTvyuecmFbyNqQUVk
         9rM60CpAe5N4m1VAAZrGip4przp0yKEMi3ItnMCrEAejMs0KIWIYe3fJkX4qgU2qTXW4
         OjNPG9yzTM402giym5SmOPw8NjJYpL8uHriOJU0ZGU4J9ym74rZSKBzMcrxBWNKGg82j
         JpJaw9t6uSTOhn+zu42Syh1NRYv4tqf0f7ih3Q6LRiebfMOHn3Ot7XBjejQxsOUml00b
         s+sw==
X-Forwarded-Encrypted: i=1; AJvYcCVshjRSmylPQnPLlst+VvoQ9h5+6Fo3qA0uLIkr836d4LQ+/GPYWur0dmuy0d4kSQ5Hc59wpePfLSQebFD6/QHFqKxpr4f0
X-Gm-Message-State: AOJu0YzucLpybtYBjbq/5CyYNjjnEOS45xGvIwS7eiOUBuNSZIoMFQ1g
	PruJuv99rIQLj5ZpmetW1XXN6TT6YQlu64Oojue3XUDLIi3ECVMK/N005cSz0HWYlJV/hywWbvD
	Pfcgg6k0Wp1lq9zUNPcUBQCarBJ2U4yD1F/GcwXPXZpatwkYk2hIfHg==
X-Received: by 2002:a05:651c:2213:b0:2ed:59fa:551e with SMTP id 38308e7fff4ca-2eef2dbf4d6mr13944921fa.4.1721129078256;
        Tue, 16 Jul 2024 04:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEC6ZKy2OwDqLzG5ygo5Ts8XnTEGW3eK1A1I6PdcCUOGLjny3/tsLCx7Haj/ejGp6zed7Bdw==
X-Received: by 2002:a05:651c:2213:b0:2ed:59fa:551e with SMTP id 38308e7fff4ca-2eef2dbf4d6mr13944781fa.4.1721129077826;
        Tue, 16 Jul 2024 04:24:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3? ([2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f259761sm154663685e9.11.2024.07.16.04.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 04:24:37 -0700 (PDT)
Message-ID: <596fd758-11ad-46c0-b6f1-2c04aeba5e06@redhat.com>
Date: Tue, 16 Jul 2024 13:24:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
To: Shigeru Yoshida <syoshida@redhat.com>, tung.q.nguyen@endava.com
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240716020905.291388-1-syoshida@redhat.com>
 <AS5PR06MB8752BF82AFB1C174C074547DDBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
 <20240716.164535.1952205982608398288.syoshida@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240716.164535.1952205982608398288.syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 09:45, Shigeru Yoshida wrote:
> On Tue, 16 Jul 2024 07:35:50 +0000, Tung Nguyen wrote:
>>> net/tipc/udp_media.c | 5 ++++-
>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c index b849a3d133a0..439f75539977 100644
>>> --- a/net/tipc/udp_media.c
>>> +++ b/net/tipc/udp_media.c
>>> @@ -135,8 +135,11 @@ static int tipc_udp_addr2str(struct tipc_media_addr *a, char *buf, int size)
>>>                 snprintf(buf, size, "%pI4:%u", &ua->ipv4, ntohs(ua->port));
>>>         else if (ntohs(ua->proto) == ETH_P_IPV6)
>>>                 snprintf(buf, size, "%pI6:%u", &ua->ipv6, ntohs(ua->port));
>>> -       else
>>> +       else {
>>>                 pr_err("Invalid UDP media address\n");
>>> +               return 1;
>> Please use -EINVAL instead.
> 
> Other addr2str functions like tipc_eth_addr2str() use 1, so I followed
> convention. But -EINVAL is more appropriate, as you say.

I think that consistency with other tipc helpers here would be more 
appropriate: IMHO no need to send a v2.

@Tung: please trim your replies to only include the relevant quoted text 
and fix your configuration to avoid inserting the long trailer, quite 
unsuitable for messages sent to a public ML.

Thanks,

Paolo


