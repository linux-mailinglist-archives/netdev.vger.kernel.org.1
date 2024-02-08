Return-Path: <netdev+bounces-70298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A3E84E4AD
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458EB1F265AD
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760617C0A9;
	Thu,  8 Feb 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTPrPJgR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D3269305
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408443; cv=none; b=X91cEwK1S5rWSiZMaom0iD0P8ZNNuAvZrQmWLqGbH0GAcYRxRit1jcYrvkiYkyxn1CE/2ze9b5MKOLXC7mOT4CvnBCNYyq0Kcql07vcXsy0RRZ0mTG8ndB6BqGSNlzAmssUHbC4BoKZlWLxm5V52IjONdPFbJqWlc/6ZBE2vQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408443; c=relaxed/simple;
	bh=1r6VUdKBbQEYwO0Ao0Aw/FqnDqDwbu8HuWqKBHtLg1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDDsdIudrSxsYUqKkslOdiu9bIYNkPxm7BoLs99Eqjd0e0iMFy/KS7QFZm7Eof3HhmXqDjrncPRoC+XNXwpqQBY7m6VmnpyxGjePQvVJEuMEuawEL6nZ4FML5auaHmxoU4FgeWvbmMcuPjRSdbPgyuc0wbDkbWE8/Xmo5hKloKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTPrPJgR; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60403c28ff6so217827b3.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 08:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707408440; x=1708013240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5EtOsSKKI2gSBdQl9PpJNPt3mKbwtnjEvDRBrjywXM=;
        b=LTPrPJgRN1GDxYJJjFEOtmiT2d7tPKaVlAdkBzAkWyY3iLR+fgNhV9ksFNxJSOzvcP
         SdJFHmrUzCZEkCTLBHXAK5HWaCxc9lmAlnhpReqpzjDqFxdNaqBi0T9KpqXi7MoLU5EX
         HUkmyw5wi0xHnhcn8P9VDcuNWE/NezmHlL3CIeo743o8IEYbthasy09TFnOMELXG2Ulc
         h5rthTdhaeUz/qjIve9Jc81GI93YG2n/9FTOr7nT3XYXHjiP8SNaDDpetnGKJ00hnC74
         Fo0R8GLdf3HLuSyPSKABipqS8TLkqS/4fyyZuFIIparTx4QsjEiHoJoMrF8F1iAl7KzD
         Xvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707408440; x=1708013240;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5EtOsSKKI2gSBdQl9PpJNPt3mKbwtnjEvDRBrjywXM=;
        b=tEegC/ZOSveaOqGXz8JiL1Jmm8LRBHJf4xlQhRtUGZZZZZpC1OQ9LQoHQme4x8pfcE
         v7FNOHHvpRW8WVpgZ+Hgn7RO9PCvCn9n3QRuryJ3zoOj9sAE0k6LygxVvTDmgzOEZvT8
         OP2strAjUczdQXsxu/mOH0vTO05hSWUMTs/xJc0QJKD1BoyOzvLTFFPdVxWhgcuGr5Cs
         k5bQi0rsUP1sgKmXg0hdRSIUpZNxBkjP0EJRS7OiUVO3cgIj4Py3QUiTxNayq+Yp19RX
         m3c3R0rkW5g97NUCPHQ35rNxd7Zy0a1cPEc1xTJYM9qYvMauh1Eo8pLskUV7SXC9Q/Ql
         erEg==
X-Gm-Message-State: AOJu0Yzz4kTSxkgtaMzupDMFNCaB5DRLJ9tb2LFYhzcIOdexGTDE2MsV
	v4yPgtwJ5E8qoEONUPcV9nWmtPrEjC5jWeB1MI3aOsr6mppv8Ibt
X-Google-Smtp-Source: AGHT+IFbriOYqcn4TAKBuvoomFfxLVvPdGB0s+Q5tcmrAgfa6Zi0/qPwohGtM1BuKf9xdT3XkZMrIA==
X-Received: by 2002:a81:6c8b:0:b0:604:33eb:14b0 with SMTP id h133-20020a816c8b000000b0060433eb14b0mr1819638ywc.4.1707408440315;
        Thu, 08 Feb 2024 08:07:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWttH1mxfGbtqLs7TY0NoRNDgxd0bV8ie7nscvCAz7Sgvvh2nm0x7n/6k0Pl8wi39ICINx0zzSXkbeZaG7Rmk4ekCzIMfH2kXePrtoe0lwKBpEFKHfYXgIpLyyIGbkykAgP/raqcLUXT9m20i5LhVfCyMqy/ivub4xOm1GfvYDezE8rE9kuD1GEO4RwRCpp8E7NWGD34zw4OZT2maucyziluD9j2UyqYSGXvR3GwW9PkjbFjf5GHEl7dnxYXnt+EpTOoHSnoaeVlBWvo8kim5qJVFHUaK08fMJwp7L8qwr+o2mJ2WxsLT/bYR72duPE3CItI6oFPXFtsp863UCf
Received: from ?IPV6:2600:1700:6cf8:1240:5e6:c5a5:2276:a32? ([2600:1700:6cf8:1240:5e6:c5a5:2276:a32])
        by smtp.gmail.com with ESMTPSA id bd3-20020a05690c010300b0060485f86449sm731718ywb.69.2024.02.08.08.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 08:07:19 -0800 (PST)
Message-ID: <c99707bc-cf86-4fb4-8474-5e19f835ed50@gmail.com>
Date: Thu, 8 Feb 2024 08:07:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/5] Remove expired routes with a separated
 list of routes.
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, thinker.li@gmail.com,
 netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, liuhangbin@gmail.com
Cc: kuifeng@meta.com
References: <20240207192933.441744-1-thinker.li@gmail.com>
 <f8f40c760f274a7780c5ab491e7eb75e9ca0098b.camel@redhat.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <f8f40c760f274a7780c5ab491e7eb75e9ca0098b.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/8/24 03:55, Paolo Abeni wrote:
> On Wed, 2024-02-07 at 11:29 -0800, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> This patchset is resent due to previous reverting. [1]
>>
>> FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
>> can be expensive if the number of routes in a table is big, even if most of
>> them are permanent. Checking routes in a separated list of routes having
>> expiration will avoid this potential issue.
>>
>> Background
>> ==========
>>
>> The size of a Linux IPv6 routing table can become a big problem if not
>> managed appropriately.  Now, Linux has a garbage collector to remove
>> expired routes periodically.  However, this may lead to a situation in
>> which the routing path is blocked for a long period due to an
>> excessive number of routes.
>>
>> For example, years ago, there is a commit c7bb4b89033b ("ipv6: tcp:
>> drop silly ICMPv6 packet too big messages").  The root cause is that
>> malicious ICMPv6 packets were sent back for every small packet sent to
>> them. These packets add routes with an expiration time that prompts
>> the GC to periodically check all routes in the tables, including
>> permanent ones.
>>
>> Why Route Expires
>> =================
>>
>> Users can add IPv6 routes with an expiration time manually. However,
>> the Neighbor Discovery protocol may also generate routes that can
>> expire.  For example, Router Advertisement (RA) messages may create a
>> default route with an expiration time. [RFC 4861] For IPv4, it is not
>> possible to set an expiration time for a route, and there is no RA, so
>> there is no need to worry about such issues.
>>
>> Create Routes with Expires
>> ==========================
>>
>> You can create routes with expires with the  command.
>>
>> For example,
>>
>>      ip -6 route add 2001:b000:591::3 via fe80::5054:ff:fe12:3457 \
>>          dev enp0s3 expires 30
>>
>> The route that has been generated will be deleted automatically in 30
>> seconds.
>>
>> GC of FIB6
>> ==========
>>
>> The function called fib6_run_gc() is responsible for performing
>> garbage collection (GC) for the Linux IPv6 stack. It checks for the
>> expiration of every route by traversing the trees of routing
>> tables. The time taken to traverse a routing table increases with its
>> size. Holding the routing table lock during traversal is particularly
>> undesirable. Therefore, it is preferable to keep the lock for the
>> shortest possible duration.
>>
>> Solution
>> ========
>>
>> The cause of the issue is keeping the routing table locked during the
>> traversal of large trees. To solve this problem, we can create a separate
>> list of routes that have expiration. This will prevent GC from checking
>> permanent routes.
>>
>> Result
>> ======
>>
>> We conducted a test to measure the execution times of fib6_gc_timer_cb()
>> and observed that it enhances the GC of FIB6. During the test, we added
>> permanent routes with the following numbers: 1000, 3000, 6000, and
>> 9000. Additionally, we added a route with an expiration time.
>>
>> Here are the average execution times for the kernel without the patch.
>>   - 120020 ns with 1000 permanent routes
>>   - 308920 ns with 3000 ...
>>   - 581470 ns with 6000 ...
>>   - 855310 ns with 9000 ...
>>
>> The kernel with the patch consistently takes around 14000 ns to execute,
>> regardless of the number of permanent routes that are installed.
>>
>> Major changes from v4:
>>
>>   - Fix the comment of fib6_add_gc_list().
>>
>> Major changes from v3:
>>
>>   - Move the checks of f6i->fib6_node to fib6_add_gc_list().
>>
>>   - Make spin_lock_bh() and spin_unlock_bh() stands out.
>>
>>   - Explain the reason of the changes in the commit message of the
>>     patch 4.
>>
>> Major changes from v2:
>>
>>   - Refactory the boilerplate checks in the test case.
>>
>>     - check_rt_num() and check_rt_num_clean()
>>
>> Major changes from v1:
>>
>>   - Reduce the numbers of routes (5) in the test cases to work with
>>     slow environments. Due to the failure on patchwork.
>>
>>   - Remove systemd related commands in the test case.
>>
>> Major changes from the previous patchset [2]:
>>
>>   - Split helpers.
>>
>>     - fib6_set_expires() -> fib6_set_expires() and fib6_add_gc_list().
>>
>>     - fib6_clean_expires() -> fib6_clean_expires() and
>>       fib6_remove_gc_list().
>>
>>   - Fix rt6_add_dflt_router() to avoid racing of setting expires.
>>
>>   - Remove unnecessary calling to fib6_clean_expires() in
>>     ip6_route_info_create().
>>
>>   - Add test cases of toggling routes between permanent and temporary
>>     and handling routes from RA messages.
>>
>>     - Clean up routes by deleting the existing device and adding a new
>>       one.
>>
>>   - Fix a potential issue in modify_prefix_route().
> 
> Note that we have a selftest failure in the batch including this series
> for the fib_tests:
> 
> https://netdev-3.bots.linux.dev/vmksft-net/results/456022/6-fib-tests-sh/stdout
> 
> I haven't digged much, but I fear its related. Please have a look.
> 
> For more info on how to reproduce the selftest environment:
> 
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
> 
> Thanks,
> 
> Paolo
> 
I will check it.


