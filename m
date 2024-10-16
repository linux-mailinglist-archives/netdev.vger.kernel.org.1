Return-Path: <netdev+bounces-136055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C729A028D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15E11F267FD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 07:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF8B1B652B;
	Wed, 16 Oct 2024 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jLSBKOJO"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934641B218C;
	Wed, 16 Oct 2024 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063703; cv=none; b=a/59Ua6I16w4yYabFSVFGNVAN2rSXJHAkbgvGKAz64lwRaGoiEHY4Q5UXdd7v6rVuB5ZG/QiQPEDTjW1KX5W37lVqFXvJ/r+R2GJE8cfhSLFrBYxUdRLhNk3diCA5wmGrvLgT76rFMbRmYzKeA24Y3+sM0R9Hw3+mqtR2Rnulb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063703; c=relaxed/simple;
	bh=JcM+9pWXeAegDo4OG0mB7GirtHWlPzLRq2vIje6fn6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMlgx0Yb9jb2L4uJMgmuxSpVu2nHysJgMzTlnSUhDbNwRxYAgzLipo49kiS7xQJH2HJk6lvEvWcVsItcYi6ZXv8g5DPFPwwxarv8zk56T28YPvQFTQ1kXbJkZYoTkWY1/1LUkG61yMUbBvWPuOwXGrOxdIBbqzdCpx8tc67ciWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jLSBKOJO; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729063696; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lp6IQeJ5GDXVaA1KkIbKbWF4AL7Kg5dWxIeMCGlMYYY=;
	b=jLSBKOJOLk4cDpiZ37YbIMNtXd2O58Y4J/ynXEkiZcn/++FeTzQFWh3VsFimvzbWVkMY2tkstBtdmOVsx+NpL3ZKweed2tC2lpYyvByXpEusjWun45rJ5zZ9gf9x1fWCEDThS+TcmhdDRevWBVXbjHYFDAf2vWD4K61J6XQ7aNw=
Received: from 30.221.128.116(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WHGWwEo_1729063695 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 15:28:15 +0800
Message-ID: <bf6e0548-7cb3-41b4-b90e-57538e8303ff@linux.alibaba.com>
Date: Wed, 16 Oct 2024 15:28:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 3/3] ipv4/udp: Add 4-tuple hash for connected
 socket
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241012012918.70888-1-lulie@linux.alibaba.com>
 <20241012012918.70888-4-lulie@linux.alibaba.com>
 <9c636d54-4276-4e28-abd3-0860bc738640@redhat.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <9c636d54-4276-4e28-abd3-0860bc738640@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/14 18:19, Paolo Abeni wrote:
> On 10/12/24 03:29, Philo Lu wrote:
>> Currently, the udp_table has two hash table, the port hash and portaddr
>> hash. Usually for UDP servers, all sockets have the same local port and
>> addr, so they are all on the same hash slot within a reuseport group.
>>
>> In some applications, UDP servers use connect() to manage clients. In
>> particular, when firstly receiving from an unseen 4 tuple, a new socket
>> is created and connect()ed to the remote addr:port, and then the fd is
>> used exclusively by the client.
> 
> How do you handle the following somewhat racing scenario? a 2nd packet 
> beloning to the same 4-tulpe lands into the unconnected socket receive 
> queue just after the 1st one, before the connected socket is created. 
> The server process such packet after the connected socket creation.
> 

One method is to address it in application. Application maintains the 
information of connections, and it knows which connection to deliver 
incoming packets.

If the 2nd packet comes from the "listen" socket (i.e., the initial 
unconnected socket), app can search for the connection of it. Note that 
upon the 1st packet receiving, the connection is already created though 
the socket is not ready, so it can be found for the 2nd packet.

In this case, maybe several packets are processed with this method until 
the new connected socket created. Then it runs as we expect.

So I think it cannot be prevented but can be handled, depending on how 
applications use it.

> How many connected sockets is your system serving concurrently? Possibly 

About 10000 conns in general. So current same-sized hash4 table is 
enough for us now.

> it would make sense to allocate a larger hash table for the connected 
> UDP sockets, using separate/different min/max/scale values WRT to the 
> unconnected tables.
> 

Agreed that it's a good idea. But imo it could be left as future work 
when we definitely need it.

Thanks.
-- 
Philo


