Return-Path: <netdev+bounces-144849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C719C88A1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA601F21AC3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A06B1F9AA2;
	Thu, 14 Nov 2024 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWuUu8dR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007851FA834
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582984; cv=none; b=F3amsEQ9nSERxd7J0KL58BipF24xFpqlzzgqM9INVyCRhkhw+yW6w/ygvGdHmzlXO3AwO3RBTtiCC77IjMobb+Nay5N8I1GIL/TNy9oMljk8hbm8ErecLsS7stU1eozhULPvPWMisdxjdhsHGFo1RSl64TDeWw1GyL5lTgccSuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582984; c=relaxed/simple;
	bh=gk2l5sQFFKnhaG1D4gYES9olyQ8lhf5lWKrvLozEITQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pu//yvSfdAWucmZq2UlmM7rw4givAcTIRpn6Rbg5VUaiipH00grG9gKIODvGcpKDCDRPyuzisRytMFasYNrsHOC136bazI6+mziH9uFa1S7em4sDYdq+X84NF5sjA9bwNx5Ahe7phi5Mz4OtGA4l80sbUgfjjB0U5PIdZcjrKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWuUu8dR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731582978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLq3a7+mKSraWJiNtbJpeO3G7vZEMjGcLidVBCyH6BE=;
	b=hWuUu8dR3NIqyuLd2nxSU4f9EwsBIzb2CJ7z9ac7yvEycA3gss77aQUB67xtnOx2flU21H
	BqbNEkaJeYnNsYpatLwI9Qal0CdWOiQViXEuw8ZpOsKN8+5/ZBpwkNuF1FSJ5VuS8z1pIm
	a9QavsPECeLx6q99P1BaKQaZGfZMICg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-ftSmKqJOOQeZeA9IGsZTwQ-1; Thu, 14 Nov 2024 06:16:15 -0500
X-MC-Unique: ftSmKqJOOQeZeA9IGsZTwQ-1
X-Mimecast-MFC-AGG-ID: ftSmKqJOOQeZeA9IGsZTwQ
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3e60dde7edcso456498b6e.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 03:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582975; x=1732187775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLq3a7+mKSraWJiNtbJpeO3G7vZEMjGcLidVBCyH6BE=;
        b=PuX/VI+ZKsERRU03PrDsP3x2WYXL7UBzCsBiltZYz/xsaz5EgFwBgRmmQKMqX8qa5v
         W3oYqp4QXpOOzasjWVRVMfcAc4r/OXea7MXU1KArjr7rcw2eCK32mbaxNItwpj8qBMSY
         F07wGbrSZpHBnehxL8nGichlH+nFdhW0n/dFBjDdCA24PQwZOAhg2aO4ZaAQ05Wn0h14
         wDHHJ7Ru8A+eo31r02hejmCAVCZjoFeXJVs5L4wZ/1CnXhTpTUxVQgecsFOXinrTffm+
         tF0B9rDPRY9l77cka2KSTxWeS7UXjrjcM10Alksc+PWwsc3QZeLf3t5tFy+f9tRm2Oi9
         R+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxadvFrSo1xzTwvIPT7I8CfKFqtd0ytjSWLzhi+zGurpFqPu/sGz9na8mgbfERhpnblSi2C3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/XwIZVtIrihw7FWbL4ZfC5WFKVXoAPm8COeGZ40ZC10gVCdyi
	J1g47khRe4RgNkAvwltNLjthQhrXZ0bZ5ppI53CwOWeOAIrILYZhhDDP1gaLwfNANzjIkdXXhiQ
	QzeH8K9Uzg7wHXQaEOHZM4jgkT76q6s9pwq8wewtPSSKHzBwUSmOzhg==
X-Received: by 2002:a05:6808:1910:b0:3e6:3777:76a7 with SMTP id 5614622812f47-3e7b7b7c5acmr1841166b6e.23.1731582974987;
        Thu, 14 Nov 2024 03:16:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4pAxUMKrHi9s3UrZnkGK2XpTHT3Y6BDqRKhAS2gb8zkg4dLyu8qzcBRI0Gp9UnRDRh8BwGg==
X-Received: by 2002:a05:6808:1910:b0:3e6:3777:76a7 with SMTP id 5614622812f47-3e7b7b7c5acmr1841151b6e.23.1731582974700;
        Thu, 14 Nov 2024 03:16:14 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee7ce954sm4244376d6.60.2024.11.14.03.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 03:16:13 -0800 (PST)
Message-ID: <93a2d882-022f-47fd-a17c-e4d45b182cea@redhat.com>
Date: Thu, 14 Nov 2024 12:16:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ipv4/proc: Avoid usage for seq_printf() when reading
 /proc/net/snmp
To: David Wang <00107082@163.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241111045623.10229-1-00107082@163.com>
 <406c545e-8c00-406a-98f0-0e545c427b25@redhat.com>
 <5db8d6bc.9fe1.1932a2f5ce9.Coremail.00107082@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5db8d6bc.9fe1.1932a2f5ce9.Coremail.00107082@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 11:19, David Wang wrote:
> At 2024-11-14 17:30:34, "Paolo Abeni" <pabeni@redhat.com> wrote:
>> On 11/11/24 05:56, David Wang wrote:
>>> seq_printf() is costy, when reading /proc/net/snmp, profiling indicates
>>> seq_printf() takes more than 50% samples of snmp_seq_show():
>>> 	snmp_seq_show(97.751% 158722/162373)
>>> 	    snmp_seq_show_tcp_udp.isra.0(40.017% 63515/158722)
>>> 		seq_printf(83.451% 53004/63515)
>>> 		seq_write(1.170% 743/63515)
>>> 		_find_next_bit(0.727% 462/63515)
>>> 		...
>>> 	    seq_printf(24.762% 39303/158722)
>>> 	    snmp_seq_show_ipstats.isra.0(21.487% 34104/158722)
>>> 		seq_printf(85.788% 29257/34104)
>>> 		_find_next_bit(0.331% 113/34104)
>>> 		seq_write(0.235% 80/34104)
>>> 		...
>>> 	    icmpmsg_put(7.235% 11483/158722)
>>> 		seq_printf(41.714% 4790/11483)
>>> 		seq_write(2.630% 302/11483)
>>> 		...
>>> Time for a million rounds of stress reading /proc/net/snmp:
>>> 	real	0m24.323s
>>> 	user	0m0.293s
>>> 	sys	0m23.679s
>>> On average, reading /proc/net/snmp takes 0.023ms.
>>> With this patch, extra costs of seq_printf() is avoided, and a million
>>> rounds of reading /proc/net/snmp now takes only ~15.853s:
>>> 	real	0m16.386s
>>> 	user	0m0.280s
>>> 	sys	0m15.853s
>>> On average, one read takes 0.015ms, a ~40% improvement.
>>>
>>> Signed-off-by: David Wang <00107082@163.com>
>>
>> If the user space is really concerned with snmp access performances, I
>> think such information should be exposed via netlink.
>>
>> Still the goal of the optimization looks doubtful. The total number of
>> mibs domain is constant and limited (differently from the network
>> devices number that in specific setup can grow a lot). Stats polling
>> should be a low frequency operation. Why you need to optimize it?
> 
> Well, one thing I think worth mention, optimize /proc entries can help
> increase sample frequency, hence more accurate rate analysis,
>  for monitoring tools with a fixed/limited cpu quota.
> 
> And for /proc/net/*, the optimization would be amplified when considering network namespaces.

I guess scaling better with many namespace could be useful.

Please try to implement this interface over netlink.

Thanks,

Paolo


