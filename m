Return-Path: <netdev+bounces-144164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B39C6116
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 20:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 548B1B82146
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C15820F5B6;
	Tue, 12 Nov 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/LrAtiP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0820EA5B
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430425; cv=none; b=AVTPtTpjFoxD+QXUBHgNTlS74aWumARxTxf9nlcx2hOnItV08SCQZ77lJlY19o+F8XXHfNtsfCqZu7cUbgKhx9FSP4syM9s2c8iYse0JekCF/iQz1lNUtrIorhMcRJH7zEgW0mWPIgtpV1TSyuAYWO8tYXM08rSfYeXsRiqYAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430425; c=relaxed/simple;
	bh=NetM12MdiqjEomNiBQ1R7rE3/8PUPvggUBu0004nbH4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m4O8vEEWQN26TmcOyiJdjzoyZdGWp0l38adZFFisYkGDn8503opNEcB16WxWHczLwGtTUspjm3bHs6Njz3FnHN6tdlxdErqUEmKORnDH1aYGL1v8w+pgevSMKMBKesLM8K3snyMdbwXLazr5CRtzCoizHz/ybXboYWYGOkr4H4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/LrAtiP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731430421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fopx7SDjvtxGI9bqsHPVJpNSF9ZEcMOMcCEBQCKpPyw=;
	b=S/LrAtiP3jYD0KyxQIpMW4OGH/tQhPXu+nxl/0p0wYLsBPqGiDaZMQk+TGTWMlXFVzRpHK
	LzefD+1/nN2uyRUaD4TYyRPqhPenb4ImmdtT1cna4NVg32NuQ7ZGu+IVfWjKlXVRGUWTk7
	wwJ/jn6bq8Q4jxBMMQnz1FP6sZVZzfI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-rHAvgu1OP82fCfCrbhYunA-1; Tue, 12 Nov 2024 11:53:40 -0500
X-MC-Unique: rHAvgu1OP82fCfCrbhYunA-1
X-Mimecast-MFC-AGG-ID: rHAvgu1OP82fCfCrbhYunA
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-71807a67145so5130366a34.2
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 08:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430419; x=1732035219;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fopx7SDjvtxGI9bqsHPVJpNSF9ZEcMOMcCEBQCKpPyw=;
        b=TGy4XBOvWMBHn2CYSpjU1LV2Fw0BoCJKddw8G9Ebrvpls8zc3RE1DxySb36+jLG+qI
         fQOVHx+tbVzmPModvlfQEQSyoVfFQDZF/SehU7HQB11KJzoPErcaVax5IL2SEnZTx5Wp
         zdMwySs447l24tyYj0P186NdHj8GBBTR+7YbT6Fy624tg0gmUl1yaDvOm8mKSJmyZ8DC
         wYa+tFiaj25XWE8IWII3OssVnhqJTi1xN+9jKZ/MmdghRVON+kpFnSYCLG4k81OphMh9
         hJrBjV89XSxwPknWIE38Mg+EJ6HNefN06sKpK47U6PP+V5y2OVCkpTN3Bvbv3dMho5ZX
         hN8g==
X-Gm-Message-State: AOJu0YxIwyZ22+xAtkm51TnRkkAw1xPaiZ9nZHH9/ryJihXoRgCCrkec
	zaXYXfiqIZiXa1/SuXpD6j7IkA6tb6LAMC+n9EuB53KOsPM+Sj1urxOhbcGCh7NU4Q1Mg5pGojY
	YER8hRdZkH4jaGF0K7m/8dqNqNtKcfbFSo9nK8l9TZZvLtqxt8WhS1A==
X-Received: by 2002:a05:6830:6788:b0:718:1987:24cb with SMTP id 46e09a7af769-71a5156ba4bmr3665886a34.10.1731430419512;
        Tue, 12 Nov 2024 08:53:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgZtjLql6MHKR3M7oCEP4Gi8JZUpYTaI4yxGOfRyQLbxRfrzvqrhtRE9/k7PQMyZ0lcGC4Dw==
X-Received: by 2002:a05:6830:6788:b0:718:1987:24cb with SMTP id 46e09a7af769-71a5156ba4bmr3665870a34.10.1731430419244;
        Tue, 12 Nov 2024 08:53:39 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac427cfsm604785585a.30.2024.11.12.08.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 08:53:38 -0800 (PST)
Message-ID: <a6bd2ee8-c732-4922-9e7c-ae89a1ad8056@redhat.com>
Date: Tue, 12 Nov 2024 17:53:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] geneve: Use pcpu stats to update rx_dropped
 counter.
From: Paolo Abeni <pabeni@redhat.com>
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <c9a7d3ddbe3fb890bee0c95d207f2ce431001075.1730979658.git.gnault@redhat.com>
 <231c2226-9b16-4a10-b2b8-484efe0aae6b@redhat.com>
Content-Language: en-US
In-Reply-To: <231c2226-9b16-4a10-b2b8-484efe0aae6b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/24 11:53, Paolo Abeni wrote:
> On 11/7/24 12:41, Guillaume Nault wrote:
>> Use the core_stats rx_dropped counter to avoid the cost of atomic
>> increments.
>>
>> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> 
> It looks like other UDP tunnels devices could benefit from a similar
> change (vxlan, bareudp). Would you mind to also touch them, to keep such
> implementations aligned?
> 
>> ---
>>  drivers/net/geneve.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
>> index 2f29b1386b1c..671ca5260e92 100644
>> --- a/drivers/net/geneve.c
>> +++ b/drivers/net/geneve.c
>> @@ -235,7 +235,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
>>  					 vni_to_tunnel_id(gnvh->vni),
>>  					 gnvh->opt_len * 4);
>>  		if (!tun_dst) {
>> -			DEV_STATS_INC(geneve->dev, rx_dropped);
>> +			dev_core_stats_rx_dropped_inc(geneve->dev);
> 
> How about switching to NETDEV_PCPU_STAT_DSTATS instead, so there is a
> single percpu struct allocated x device (geneve already uses
> NETDEV_PCPU_STAT_TSTATS): stats fetching will be faster, and possibly
> memory usage lower.

I was not aware of the previous discussion on this same topic:

https://lore.kernel.org/netdev/20240903113402.41d19129@kernel.org/

and I missed the previous change on bareudp.c

I still think that avoiding the double per-cpu traversal when fetching
the stats could be useful, especially on large multi-numa nodes systems.

I guess it's better to be consistent and keep geneve and bareudp
aligned. We can eventually consolidate the stats later.

/P


