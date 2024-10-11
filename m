Return-Path: <netdev+bounces-134440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B981C999929
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 03:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E951A1C224CF
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 01:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911895227;
	Fri, 11 Oct 2024 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uFu2hozB"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D239BE40;
	Fri, 11 Oct 2024 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609803; cv=none; b=epmjXmLsUt69q28k88Ey9m6ZzKBVzz3hLVNTA3ncLp1v9qZdl3nXavUmE477osVM6k1p6SrmtbNUN6y/vgI4qOGtPBRBDiXNiCf4V9ioXQlwBHB4wB48sgi6FKVPzXHJsKmSDXgh2L37GYajqJxrnI2mExXIvu3z+6nbc3OHzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609803; c=relaxed/simple;
	bh=MVt0xbd6/cjDBSCOCoTMD45L1cxpTSJ185fP46lFIWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBh+lp85CI3dH1ahFYDHoSjWOrmN1PtpuIt0RFQqx/BFph88AcK4aC2u6YcOqw+hJG0+6Ayjo7hq+6hL7Z0tqUznuGO33S6taiVrn6Gx2fcBWaA35yzmGrbCJ11YYM6fwuafO5z0tmJthVNJwkMPktmESQ4hunOm3lpxbKAWMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uFu2hozB; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728609796; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TWqDwm7DtiHSTja+8n7rwlJMkkPCYhrvVsLMz86o+qE=;
	b=uFu2hozBa8bxKhxX0lU07/MgySMuN6VC2QqYBU3bUBdZbZ65yJAGU+qTGYKZpkkgiY4s10n1VPlCYQHbP5TBlRzMqsOVYphRe/DyhelkbC2azOYSn1F+pS6FCQ6Utp/0hJfeoMV/+fS+DgCJRGQGNqPRILA/fqKKOKrKehnZUgY=
Received: from 30.221.128.133(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WGo6zqk_1728609795 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 09:23:16 +0800
Message-ID: <ff81f918-527f-4114-abaf-0d3f9e207363@linux.alibaba.com>
Date: Fri, 11 Oct 2024 09:23:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 2/3] net/udp: Add 4-tuple hash list basis
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, antony.antony@secunet.com,
 steffen.klassert@secunet.com, linux-kernel@vger.kernel.org,
 dust.li@linux.alibaba.com, jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241010090351.79698-1-lulie@linux.alibaba.com>
 <20241010090351.79698-3-lulie@linux.alibaba.com>
 <6707db425cc49_202921294a9@willemb.c.googlers.com.notmuch>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <6707db425cc49_202921294a9@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/10 21:48, Willem de Bruijn wrote:
> Philo Lu wrote:
>> Add a new hash list, hash4, in udp table. It will be used to implement
>> 4-tuple hash for connected udp sockets. This patch adds the hlist to
>> table, and implements helpers and the initialization. 4-tuple hash is
>> implemented in the following patch.
>>
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>> Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
>> Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
>> Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
> 
>> @@ -3480,16 +3486,15 @@ static struct udp_table __net_init *udp_pernet_table_alloc(unsigned int hash_ent
>>   	if (!udptable)
>>   		goto out;
>>   
>> -	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
>> +	slot_size = 2 * sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
>>   	udptable->hash = vmalloc_huge(hash_entries * slot_size,
>>   				      GFP_KERNEL_ACCOUNT);
>>   	if (!udptable->hash)
>>   		goto free_table;
>>   
>>   	udptable->hash2 = UDP_HSLOT_MAIN(udptable->hash + hash_entries);
>> -	udptable->mask = hash_entries - 1;
>> +	udptable->hash4 = (struct udp_hslot *)(udptable->hash2 + hash_entries);
> 
> Unintentional removal of the mask assignment?
> 

Will fix. Sorry for the mistake.

>>   	udptable->log = ilog2(hash_entries);
>> -
> 
> Unnecessary whitespace line removal
> 

Ditto.

Thank you for review, Willem.
-- 
Philo


