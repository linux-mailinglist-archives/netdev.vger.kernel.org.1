Return-Path: <netdev+bounces-17058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0074FF9E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 08:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82CC1C20FDF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 06:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B725B1FD2;
	Wed, 12 Jul 2023 06:45:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6031C29
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:45:40 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AD719B
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 23:45:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6687096c6ddso3885147b3a.0
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 23:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689144338; x=1691736338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8WhpdF8/RW8zGFH/BZgsqEuwmUxTSnkz6bmGMUpKLg=;
        b=W/GvKFglSlPxZ7GDe3SBJk00S68EMh1nVTwsJAwhPkQ3MT365bsUjoqdqE+/sA7CSN
         NRbg4zl/wx1Ls0jXTms3+eFHtQJyUHaiDmc3++U9grS799Xvv+6VfZ7rUTRs7OMQTQAB
         FWp2o073tH2I2V2BGGYkcvq9X9akSwkleCwtv4Cgn9Gl0v/0cXvmNCmhRYQdPENheFEs
         xGjTHkxJaBaShbI/QBVm5k2nSoBimFca0JrTPTEOBCnwYyet961sXcDsDzRAZpzsM6Db
         MLVmvFZEDnKOJT+7M+5szD2mCWMufCAeW02SnLCg9kpv0jB3gHFFeTNQKSCl0J7aqjAE
         5n8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689144338; x=1691736338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8WhpdF8/RW8zGFH/BZgsqEuwmUxTSnkz6bmGMUpKLg=;
        b=LRWHaVtvYYrfrgX9+PHXWyxnAxb1N0X6Utd28Y12rCp4J7wPzux25FzjQeWSabZasU
         6o6Ou2PLNxsWDwdawX+2vFZRavTnlA+4RCEErZ+x3Ao3WO++Ys0O4sPbnvz8E/dYuhMw
         K3cBoZuKVah+ubd5efHjH1D70uc15YigpsoWEzVUvyt8GrA9q7IpyPRjI40cdwLNnxZe
         NUf4txf5VCV9TbopRWYoJDNrXfnakZo+pThhZu9Q8JhBFZLgQIW95oc9C1XnaNAF/o9K
         dyXe9SgVl72OiYacv9WBtuQDiY+vVPhRu25JH3EcftgAmfkBBTS8UwNqftsPJF0jq/Re
         2TWg==
X-Gm-Message-State: ABy/qLYwrm/khfVH6EigP5seS9J+DZPHDBpfG9iaYBJ2jOkqChNv+yuu
	pCHFHikaxyuzf7x6R4CPJxSmNw==
X-Google-Smtp-Source: APBJJlF4k1pkoB3GqDRrCOhh7latAjS6/d0b535BaPunB3YtROa/Y2UxTSwoSRKXrxX78yz7cfx0Xg==
X-Received: by 2002:a05:6a20:7f94:b0:12f:dc60:2b9e with SMTP id d20-20020a056a207f9400b0012fdc602b9emr17247332pzj.48.1689144338323;
        Tue, 11 Jul 2023 23:45:38 -0700 (PDT)
Received: from [10.94.58.170] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902cb0b00b001aaf2e8b1eesm3085131ply.248.2023.07.11.23.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 23:45:36 -0700 (PDT)
Message-ID: <987f7855-8b1e-ad1a-29d3-8511ccaa00b2@bytedance.com>
Date: Wed, 12 Jul 2023 14:45:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators
 of sockmem pressure
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, David Ahern <dsahern@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Yu Zhao
 <yuzhao@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yafang Shao <laoar.shao@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Breno Leitao <leitao@debian.org>, David Howells <dhowells@redhat.com>,
 Jason Xing <kernelxing@tencent.com>, Xin Long <lucien.xin@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Alexei Starovoitov <ast@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)"
 <cgroups@vger.kernel.org>,
 "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)"
 <linux-mm@kvack.org>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
 <20230711204537.04cb1124@kernel.org>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230711204537.04cb1124@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub,

On 7/12/23 11:45 AM, Jakub Kicinski wrote:
> On Tue, 11 Jul 2023 20:41:43 +0800 Abel Wu wrote:
>> Now there are two indicators of socket memory pressure sit inside
>> struct mem_cgroup, socket_pressure and tcpmem_pressure.
>>
>> When in legacy mode aka. cgroupv1, the socket memory is charged
>> into a separate counter memcg->tcpmem rather than ->memory, so
>> the reclaim pressure of the memcg has nothing to do with socket's
>> pressure at all. While for default mode, the ->tcpmem is simply
>> not used.
>>
>> So {socket,tcpmem}_pressure are only used in default/legacy mode
>> respectively. This patch fixes the pieces of code that make mixed
>> use of both.
> 
> Eric Dumazet is currently AFK, can we wait for him to return
> (in about a week) before merging?

Sure, thanks for providing this information!

Best Regards,
	Abel

