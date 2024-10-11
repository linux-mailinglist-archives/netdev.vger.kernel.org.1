Return-Path: <netdev+bounces-134446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D77999992
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 03:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9A61C20B91
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 01:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3373FDF59;
	Fri, 11 Oct 2024 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FuXJ6vPS"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30DD299;
	Fri, 11 Oct 2024 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610628; cv=none; b=F/U6z52LNm+euPcSz9fCfaManDGS+GGOlgUINyjxLyNkqoXF8xq69/j/DtkmucFdbgFjEjxQmoTkQXQZlnMwhhpX4f1zWJkaLiFDu7b61+E0AqONG92rKD0iptE5muTmpIjkMAjL5SpSPRd5TLDZLOc1iysZUJc26mJ7yZt3KJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610628; c=relaxed/simple;
	bh=kOGES8owTgc20k8URxFyuZEPC1CBLKRtaL6O1DNIGLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFDYLS/ILj6UItQZbSbO51SWmN+3ZX9tPts6Othzk8HEsOzQ47idIrEVTr3dHwi0xUZmwEAtLYX90oDWC8UyBN6B6we9xuI7Dlau38uaERTEEYawhVMxmYllqWeuuNt4dyg+BwTSNhyCLBHZ9hsv9XlGDvh7ErcbpfJYZIw4MQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FuXJ6vPS; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728610623; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YE6PjnGZ2TnG7QSSqG69QpCAmDp0fM8otZposExFM28=;
	b=FuXJ6vPSZPdvQkhlKkS++6dJLWyoFygaZ02mTZKdFP5oahCJRxTmgZ4NQ5tfdJunWio9DE89OHFkzH4K9Z3nX8uDIcPJ9/8bXYvGWf0YsTNOZmweqfP8Yf6PxKP0ng2MgdPDMRwerHb/6UGah2bCJXx2VJKEPcwksFpCWeRCARc=
Received: from 30.221.128.133(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WGo74jJ_1728610621 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 09:37:02 +0800
Message-ID: <7e92c879-d449-4a5d-9f82-ebc711e6bd1b@linux.alibaba.com>
Date: Fri, 11 Oct 2024 09:37:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 3/3] ipv4/udp: Add 4-tuple hash for connected
 socket
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, antony.antony@secunet.com,
 steffen.klassert@secunet.com, linux-kernel@vger.kernel.org,
 dust.li@linux.alibaba.com, jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241010090351.79698-1-lulie@linux.alibaba.com>
 <20241010090351.79698-4-lulie@linux.alibaba.com>
 <6707db74601d9_20292129449@willemb.c.googlers.com.notmuch>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <6707db74601d9_20292129449@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/10 21:49, Willem de Bruijn wrote:
> Philo Lu wrote:
>> Currently, the udp_table has two hash table, the port hash and portaddr
>> hash. Usually for UDP servers, all sockets have the same local port and
>> addr, so they are all on the same hash slot within a reuseport group.
>>
>> In some applications, UDP servers use connect() to manage clients. In
>> particular, when firstly receiving from an unseen 4 tuple, a new socket
>> is created and connect()ed to the remote addr:port, and then the fd is
>> used exclusively by the client.
>>
>> Once there are connected sks in a reuseport group, udp has to score all
>> sks in the same hash2 slot to find the best match. This could be
>> inefficient with a large number of connections, resulting in high
>> softirq overhead.
>>
>> To solve the problem, this patch implement 4-tuple hash for connected
>> udp sockets. During connect(), hash4 slot is updated, as well as a
>> corresponding counter, hash4_cnt, in hslot2. In __udp4_lib_lookup(),
>> hslot4 will be searched firstly if the counter is non-zero. Otherwise,
>> hslot2 is used like before. Note that only connected sockets enter this
>> hash4 path, while un-connected ones are not affected.
>>
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>> Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
>> Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
>> Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
> 
>> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
>> index bbf3352213c4..4d3dfcb48a39 100644
>> --- a/net/ipv6/udp.c
>> +++ b/net/ipv6/udp.c
>> @@ -111,7 +111,7 @@ void udp_v6_rehash(struct sock *sk)
>>   					  &sk->sk_v6_rcv_saddr,
>>   					  inet_sk(sk)->inet_num);
>>   
>> -	udp_lib_rehash(sk, new_hash);
>> +	udp_lib_rehash(sk, new_hash, 0); /* 4-tuple hash not implemented */
> 
> What is the plan for IPv6?
> 

iiuc, udp6 shares the same udptable with udp4, and the hash-related 
implementations are almost the same, so there is no obvious obstacle for 
udp6 hash4 as long as udp4 hash4 is ready. And I'll do it right after 
udp4 hash4.

Thanks.
-- 
Philo


