Return-Path: <netdev+bounces-99683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056798D5D2D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286461C2506B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB24155A25;
	Fri, 31 May 2024 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bzTAE0yH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5BF15572F
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145596; cv=none; b=Ebox67kYIsd7rBw2o2pUCFLAR99rw+D1bieeICf6A2uC7RNf6IMD21gvPuFa69WesaOnjN/2UzexQBRV839Q1FSzmrd6o4I9xFf86AMGBuYpMBToqoqkhfvxFsbPK/aqs8HNO6GZvJHe461bUcXlm9sqU8ln1SIy3LWOmp30D5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145596; c=relaxed/simple;
	bh=wjxwO1kfN3yLpkkRp9LD0DqZb/dGb3ArQrnPmLdb+Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=V8C4TMBepM7pxuTYBWP4Gzdn5UMiWVoe1mrTTVOiMVrU0lHcQk/8hZKEvGjLE35fm3i424+gc7gaPmEMg142So9vPlIzbWFfBae6J/9W4VHnOr9krDygE0/RbTfo2nuYejyysQb04c4SM6PLAyBTmncySIR0VxUzHTpliCvve6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bzTAE0yH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-420180b5897so8030635e9.3
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 01:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717145592; x=1717750392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JO32U3KVcULAzpdxL+s1aYhejtsLxraKgEysFJcK3U=;
        b=bzTAE0yH1MjSOg7YP6zDs5RD/WnBQ0YqbkqCHvI1W6XEz95Np4ryE3oDbTNBLHI0c5
         683uKyX2GyL1Ixrm6cGvcF3naA9elTa1GOBwEF7TVW477As3Jucocfk9MEkc3XchUarp
         VECT9pQeZs2b9OMR82VK9vT7AlI2PpfoetUQp0ZG2ZJ4YjcMbCMnYkF8YM3KwmyDnx7u
         QUQqtIzWMJc30eoL2xgmQICjokE7jf9pArIjgODy3WTHC/sig2ZGBO8fPmSfoa1/BuqY
         UyVoWRzYVmRoWOh89MxdfiNQ/mIB97nQsqrt9AiFx+FnyFkpmcXQe2xaMD/zz8gLyiWb
         RAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717145592; x=1717750392;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JO32U3KVcULAzpdxL+s1aYhejtsLxraKgEysFJcK3U=;
        b=GKdRWLygovSwBKVxGWBmxLAm7Mwq+Ed8eDPGGZlw2lQYH5WJ66lmQhPc3X7DXAnvcl
         QPf5+Oq/e54TOJptqEf7njV7iH8I6kCLm2p2RFAiwOXsxeS/QTVo4D2g2p+AmIlN0GNX
         KSdedcjj7a9vRI3HelasxHP3XKzHmosCVIvNPajIYtDb+LBG7tmkNREMborHoQwr7KkE
         mc59r4QJqiPNAKKm8YrtkOo6K5XDFAyz0b02zFgQih8msRIBY1mNsnGTxnQPAXG2bPQo
         6yEKAdHWLzpP5463J7wG8hLkmmaV5iKSneeHdzjFnabH1PLh4JlneNKohp/CK3wCzMvK
         VUlQ==
X-Gm-Message-State: AOJu0Ywf2QQ9uWI8JqgYsUcMYsc0NW9ZaIeucfdkGpCi825Q2Op/z6l8
	lUnNBVy0Z9aVKT8CKrd2HeL9sykSpWuq+SK9xnVrUwWNRcY8wHO9wcMElfaM6wYqAtbGn6dnpTT
	d
X-Google-Smtp-Source: AGHT+IERNdT26Dww0h4W5Ue6l90E4GnjttzPoLc6Dk1OkGcpVZkyLEu7R7eu1EfcvPGRqpmBHR6DDA==
X-Received: by 2002:adf:f9c7:0:b0:35d:bf0d:c818 with SMTP id ffacd0b85a97d-35e0f289a88mr820036f8f.34.1717145592376;
        Fri, 31 May 2024 01:53:12 -0700 (PDT)
Received: from [10.100.51.161] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04cc0b6sm1358119f8f.44.2024.05.31.01.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 01:53:12 -0700 (PDT)
Message-ID: <cbd56289-c9e9-4cd1-87d8-623ae7e39347@suse.com>
Date: Fri, 31 May 2024 10:53:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/ipv6: Fix the RT cache flush via sysctl using a
 previous delay
Content-Language: en-US
To: Kuifeng Lee <sinquersw@gmail.com>
References: <20240529135251.4074-1-petr.pavlu@suse.com>
 <CAHE2DV1S4oKved063WaYzqsoiEe1hY=ZoRxjFfPX1m0-N0MsdQ@mail.gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CAHE2DV1S4oKved063WaYzqsoiEe1hY=ZoRxjFfPX1m0-N0MsdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[Added back netdev@vger.kernel.org and linux-kernel@vger.kernel.org
which seem to be dropped by accident.]

On 5/30/24 17:59, Kuifeng Lee wrote:
> On Wed, May 29, 2024 at 6:53 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> The net.ipv6.route.flush system parameter takes a value which specifies
>> a delay used during the flush operation for aging exception routes. The
>> written value is however not used in the currently requested flush and
>> instead utilized only in the next one.
>>
>> A problem is that ipv6_sysctl_rtcache_flush() first reads the old value
>> of net->ipv6.sysctl.flush_delay into a local delay variable and then
>> calls proc_dointvec() which actually updates the sysctl based on the
>> provided input.
> 
> If the problem we are trying to fix is using the old value, should we move
> the line reading the value to a place after updating it instead of a
> local copy of
> the whole ctl_table?

Just moving the read of net->ipv6.sysctl.flush_delay after the
proc_dointvec() call was actually my initial implementation. I then
opted for the proposed version because it looked useful to me to save
memory used to store net->ipv6.sysctl.flush_delay.

Another minor aspect is that these sysctl writes are not serialized. Two
invocations of ipv6_sysctl_rtcache_flush() could in theory occur at the
same time. It can then happen that they both first execute
proc_dointvec(). One of them ends up slower and thus its value gets
stored in net->ipv6.sysctl.flush_delay. Both runs then return to
ipv6_sysctl_rtcache_flush(), read the stored value and execute
fib6_run_gc(). It means one of them calls this function with a value
different that it was actually given on input. By having a purely local
variable, each write is independent and fib6_run_gc() is executed with
the right input delay.

The cost of making a copy of ctl_table is a few instructions and this
isn't on any hot path. The same pattern is used, for example, in
net/ipv6/addrconf.c, function addrconf_sysctl_forward().

So overall, the proposed version looked marginally better to me than
just moving the read of net->ipv6.sysctl.flush_delay later in
ipv6_sysctl_rtcache_flush().

Thanks,
Petr

> 
>>
>> Fix the problem by removing net->ipv6.sysctl.flush_delay because the
>> value is never actually used after the flush operation and instead use
>> a temporary ctl_table in ipv6_sysctl_rtcache_flush() pointing directly
>> to the local delay variable.
>>
>> Fixes: 4990509f19e8 ("[NETNS][IPV6]: Make sysctls route per namespace.")
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>>
>> Note that when testing this fix, I noticed that an aging exception route
>> (created via ICMP redirect) was not getting removed when triggering the
>> flush operation unless the associated fib6_info was an expiring route.
>> It looks the logic introduced in 5eb902b8e719 ("net/ipv6: Remove expired
>> routes with a separated list of routes.") otherwise missed registering
>> the fib6_info with the GC. That is potentially a separate issue, just
>> adding it here in case someone decides to test this patch and possibly
>> run into this problem too.
>>
>>  include/net/netns/ipv6.h |  1 -
>>  net/ipv6/route.c         | 13 ++++++-------
>>  2 files changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
>> index 5f2cfd84570a..2ed7659013a4 100644
>> --- a/include/net/netns/ipv6.h
>> +++ b/include/net/netns/ipv6.h
>> @@ -20,7 +20,6 @@ struct netns_sysctl_ipv6 {
>>         struct ctl_table_header *frags_hdr;
>>         struct ctl_table_header *xfrm6_hdr;
>>  #endif
>> -       int flush_delay;
>>         int ip6_rt_max_size;
>>         int ip6_rt_gc_min_interval;
>>         int ip6_rt_gc_timeout;
>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>> index bbc2a0dd9314..f07f050003c3 100644
>> --- a/net/ipv6/route.c
>> +++ b/net/ipv6/route.c
>> @@ -6335,15 +6335,17 @@ static int rt6_stats_seq_show(struct seq_file *seq, void *v)
>>  static int ipv6_sysctl_rtcache_flush(struct ctl_table *ctl, int write,
>>                               void *buffer, size_t *lenp, loff_t *ppos)
>>  {
>> -       struct net *net;
>> +       struct net *net = ctl->extra1;
>> +       struct ctl_table lctl;
>>         int delay;
>>         int ret;
>> +
>>         if (!write)
>>                 return -EINVAL;
>>
>> -       net = (struct net *)ctl->extra1;
>> -       delay = net->ipv6.sysctl.flush_delay;
>> -       ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
>> +       lctl = *ctl;
>> +       lctl.data = &delay;
>> +       ret = proc_dointvec(&lctl, write, buffer, lenp, ppos);
>>         if (ret)
>>                 return ret;
>>
>> @@ -6368,7 +6370,6 @@ static struct ctl_table ipv6_route_table_template[] = {
>>         },
>>         {
>>                 .procname       =       "flush",
>> -               .data           =       &init_net.ipv6.sysctl.flush_delay,
>>                 .maxlen         =       sizeof(int),
>>                 .mode           =       0200,
>>                 .proc_handler   =       ipv6_sysctl_rtcache_flush
>> @@ -6444,7 +6445,6 @@ struct ctl_table * __net_init ipv6_route_sysctl_init(struct net *net)
>>         if (table) {
>>                 table[0].data = &net->ipv6.sysctl.ip6_rt_max_size;
>>                 table[1].data = &net->ipv6.ip6_dst_ops.gc_thresh;
>> -               table[2].data = &net->ipv6.sysctl.flush_delay;
>>                 table[2].extra1 = net;
>>                 table[3].data = &net->ipv6.sysctl.ip6_rt_gc_min_interval;
>>                 table[4].data = &net->ipv6.sysctl.ip6_rt_gc_timeout;
>> @@ -6521,7 +6521,6 @@ static int __net_init ip6_route_net_init(struct net *net)
>>  #endif
>>  #endif
>>
>> -       net->ipv6.sysctl.flush_delay = 0;
>>         net->ipv6.sysctl.ip6_rt_max_size = INT_MAX;
>>         net->ipv6.sysctl.ip6_rt_gc_min_interval = HZ / 2;
>>         net->ipv6.sysctl.ip6_rt_gc_timeout = 60*HZ;
>>
>> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
>> --
>> 2.35.3
>>
>>

