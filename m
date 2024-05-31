Return-Path: <netdev+bounces-99681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CAD8D5D22
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897E21F23A78
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1591A15572F;
	Fri, 31 May 2024 08:50:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC94E1C8;
	Fri, 31 May 2024 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145442; cv=none; b=ceEdFPh3xyh2z+vxKZ9JiaWbpY0EcndUUWKlI1LOFa1MFEgBkJu46EFlquV69eDCmG9wYSjecugGzawMZE0CreianMehPb86+WHvLTDF/lwP2CeYlg6bdSpQJXbV6BNcvzhGqJqBMc8cnqNE+2rxtyjsjPOpqAWgbShC5XXF+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145442; c=relaxed/simple;
	bh=C/ba5gRMkM4226fI4VyWjhkUH2G8JbjEXdYERVwgzZU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SQSpXWpPZexS3WZWAQNhUaUrJakl4lCgJTC2E9BEPyDp02tLlvw/YHDaeEQbUSUdNORTMS4TjjXv/VzfqeAPGmmRdSCFpv3BfdUx/HmZfMTTNbh0h4dFVWQsZOwPjvHx0iUMTRkdcviyv69WpoJpJ9NyRjmfQiyPwrx5sqibkEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VrGtV6tjwzmWrx;
	Fri, 31 May 2024 16:46:10 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 73D4318007A;
	Fri, 31 May 2024 16:50:36 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 31 May
 2024 16:50:36 +0800
Subject: Re: [PATCH net-next v5 01/13] mm: page_frag: add a test module for
 page_frag
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240528125604.63048-1-linyunsheng@huawei.com>
 <20240528125604.63048-2-linyunsheng@huawei.com>
 <20240529172938.3a83784d@kernel.org>
 <1cba403b-a2c7-5706-78b7-91ccc6caa53b@huawei.com>
 <20240530081653.769e4377@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <24240fe0-00ca-a9cc-6087-1de720951896@huawei.com>
Date: Fri, 31 May 2024 16:50:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240530081653.769e4377@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/5/30 23:16, Jakub Kicinski wrote:
> On Thu, 30 May 2024 17:17:17 +0800 Yunsheng Lin wrote:
>>> Is this test actually meaningfully testing page_frag or rather
>>> the objpool construct and the scheduler? :S  
>>
>> For the objpool part, I guess it is ok to say that it is a
>> meaningfully testing for both page_frag and objpool if there is
>> changing to either of them.
> 
> Why guess when you can measure it. 
> Slow one down and see if it impacts the benchmark.

Before the slowing down on arm64 system:

 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17' (500 runs):

         19.420606      task-clock (msec)         #    0.001 CPUs utilized            ( +-  0.82% )
                 7      context-switches          #    0.377 K/sec                    ( +-  0.30% )
                 1      cpu-migrations            #    0.038 K/sec                    ( +-  2.82% )
                84      page-faults               #    0.004 M/sec                    ( +-  0.06% )
          50423999      cycles                    #    2.596 GHz                      ( +-  0.82% )
          35558295      instructions              #    0.71  insn per cycle           ( +-  0.09% )
           8340405      branches                  #  429.462 M/sec                    ( +-  0.08% )
             20669      branch-misses             #    0.25% of all branches          ( +-  0.10% )

      24.047641626 seconds time elapsed                                          ( +-  0.08% )


And there are 5120000 push and pop operations for each iteration,
so roughly each push and pop operation costs about 4687ns.

By adding 50ns delay in *__page_frag_alloc_va_align()
@@ -300,6 +297,8 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 {
        unsigned int remaining = nc->remaining & align_mask;

+       ndelay(50);
+
        if (unlikely(fragsz > remaining)) {


We have:
 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17' (500 runs):

         18.012657      task-clock (msec)         #    0.001 CPUs utilized            ( +-  0.01% )
                 7      context-switches          #    0.395 K/sec                    ( +-  0.20% )
                 1      cpu-migrations            #    0.052 K/sec                    ( +-  1.35% )
                84      page-faults               #    0.005 M/sec                    ( +-  0.06% )
          46765406      cycles                    #    2.596 GHz                      ( +-  0.01% )
          35253336      instructions              #    0.75  insn per cycle           ( +-  0.00% )
           8277063      branches                  #  459.514 M/sec                    ( +-  0.00% )
             20558      branch-misses             #    0.25% of all branches          ( +-  0.07% )

      24.313647557 seconds time elapsed                                          ( +-  0.07% )


(24.313647557 - 24.047641626) * 1000000000 / 5120000 = 51ns, so the
testing seems correct.

> 
>> For the scheduler part, this test provides the below module param
>> to avoid the the noise from scheduler.
>>
>> +static int test_push_cpu;
>> +module_param(test_push_cpu, int, 0600);
>> +MODULE_PARM_DESC(test_push_cpu, "test cpu for pushing fragment");
>> +
>> +static int test_pop_cpu;
>> +module_param(test_pop_cpu, int, 0600);
>> +MODULE_PARM_DESC(test_pop_cpu, "test cpu for popping fragment");
>>
>> Or is there any better idea for testing page_frag?
> 
> .
> 

