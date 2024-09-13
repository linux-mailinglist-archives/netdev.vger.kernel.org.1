Return-Path: <netdev+bounces-128124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76011978272
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6154BB2314D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E1CC8C0;
	Fri, 13 Sep 2024 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dIurOK4X"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08404BA27;
	Fri, 13 Sep 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237328; cv=none; b=n59oXI8uWImmWhQPQkJjqiastbKQ3f/onaprsiWxABjin7RD9tbPlldbqv6k54mhFytDcFgK45hDtyesCZMCte8AGNPOE8me7Bdg/mmS4A+xhdEKEQV7k2GrsWktCT4KzOQeGMLiJNlJEfsUd9CnI87fPV/OayVY1tlYI04HcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237328; c=relaxed/simple;
	bh=lKVbms35qW+nSv1H9lTWRSiwTD3g3t+96VKvPWgNiQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S30DnpmkRhLjE9WK8j4hK+BTBjC00ApXzw2mCiHh4hb68XDF5I8DNGXgjVGJpVxa8b+XZC15gRYRg1/1DTSJ4nS2YHzTJq6ANn5LJRGvThRYsAi2MtC5PzJFry9MoWJh+/9HPw+Cui3oSx5AeOJJvRtZ3IdwY2uoe+O4o85wgOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dIurOK4X; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726237316; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=lKVbms35qW+nSv1H9lTWRSiwTD3g3t+96VKvPWgNiQo=;
	b=dIurOK4XH9NPrTijG5AlG/eithnsesollPJZkrbJmZRQyE6lGUM0mUet1MbTUOp65mxjWoG0255pCBhKAL1lYK3v4vT0sPgmtMBmimllfD270G36rPCoPTq2+I7WfMOxE8Inr2ECbGuRz7HzonQDqoPea6URCRGaRJlrptVtjwk=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WEv8DZa_1726237315)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 22:21:55 +0800
Date: Fri, 13 Sep 2024 22:21:55 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Eric Dumazet <edumazet@google.com>, Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, antony.antony@secunet.com,
	steffen.klassert@secunet.com, linux-kernel@vger.kernel.org,
	jakub@cloudflare.com
Subject: Re: [RFC PATCH net-next] net/udp: Add 4-tuple hash for connected
 socket
Message-ID: <20240913142155.GA14069@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20240913100941.8565-1-lulie@linux.alibaba.com>
 <CANn89iJuUFaM5whtsqA37vh6vUKUQJhgjV9Uqv6_ARpVGFjB2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJuUFaM5whtsqA37vh6vUKUQJhgjV9Uqv6_ARpVGFjB2w@mail.gmail.com>

On 2024-09-13 13:49:03, Eric Dumazet wrote:
>On Fri, Sep 13, 2024 at 12:09 PM Philo Lu <lulie@linux.alibaba.com> wrote:
>>
>> This RFC patch introduces 4-tuple hash for connected udp sockets, to
>> make udp lookup faster. It is a tentative proposal and any comment is
>> welcome.
>>
>> Currently, the udp_table has two hash table, the port hash and portaddr
>> hash. But for UDP server, all sockets have the same local port and addr,
>> so they are all on the same hash slot within a reuseport group. And the
>> target sock is selected by scoring.
>>
>> In some applications, the UDP server uses connect() for each incoming
>> client, and then the socket (fd) is used exclusively by the client. In
>> such scenarios, current scoring method can be ineffcient with a large
>> number of connections, resulting in high softirq overhead.
>>
>> To solve the problem, a 4-tuple hash list is added to udp_table, and is
>> updated when calling connect(). Then __udp4_lib_lookup() firstly
>> searches the 4-tuple hash list, and return directly if success. A new
>> sockopt UDP_HASH4 is added to enable it. So the usage is:
>> 1. socket()
>> 2. bind()
>> 3. setsockopt(UDP_HASH4)
>> 4. connect()
>>
>> AFAICT the patch (if useful) can be further improved by:
>> (a) Support disable with sockopt UDP_HASH4. Now it cannot be disabled
>> once turned on until the socket closed.
>> (b) Better interact with hash2/reuseport. Now hash4 hardly affects other
>> mechanisms, but maintaining sockets in both hash4 and hash2 lists seems
>> unnecessary.
>> (c) Support early demux and ipv6.
>>
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>
>Adding a 4-tuple hash for UDP has been discussed in the past.

Thanks for the information! we don't know the history.

>
>Main issue is that this is adding one cache line miss per incoming packet.

What about adding something like refcnt in 'struct udp_hslot' ?
if someone enabled uhash4 on the port, we increase the refcnt.
Then we can check if that port have uhash4 enabled. If it's zero,
we can just bypass the uhash4 lookup process and goto the current
udp4_lib_lookup2().

That should avoid the cache line miss per incoming packet ?

Best regards,
Dust


