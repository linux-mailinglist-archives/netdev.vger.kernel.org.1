Return-Path: <netdev+bounces-20056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2168175D82D
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFC82824FD
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 00:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04D1366;
	Sat, 22 Jul 2023 00:26:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EE77C
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 00:26:35 +0000 (UTC)
Received: from out-10.mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88DE35AB
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:26:33 -0700 (PDT)
Date: Fri, 21 Jul 2023 17:20:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1689985248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A7C+8fr0BBPGVeSyRwGjl6x7NUz9yaHHzvCjQiFNnwk=;
	b=reFwmzSJKDypmXEH61HXIerGh6JIYZnQqxTMEmPW+WGdsJVV2gP66kkp6rKtbHLPm4hu0e
	yvBiZt6XWYSXhyo/57SYZv/ujqH6Tu6OfJrUrvcVzIB7aKgM1WpQnyOWZfA/3AOr4Recow
	xRrMKjl726QaHrI7xqB5PF1dcABIDi4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Ahern <dsahern@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yu Zhao <yuzhao@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Breno Leitao <leitao@debian.org>,
	David Howells <dhowells@redhat.com>,
	Jason Xing <kernelxing@tencent.com>,
	Xin Long <lucien.xin@gmail.com>, Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <linux-mm@kvack.org>
Subject: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators of
 sockmem pressure
Message-ID: <ZLsg1wklldKkVI2Z@P9FQF9L96D.corp.robot.car>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711124157.97169-1-wuyun.abel@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 08:41:43PM +0800, Abel Wu wrote:
> Now there are two indicators of socket memory pressure sit inside
> struct mem_cgroup, socket_pressure and tcpmem_pressure.

Hi Abel!

> When in legacy mode aka. cgroupv1, the socket memory is charged
> into a separate counter memcg->tcpmem rather than ->memory, so
> the reclaim pressure of the memcg has nothing to do with socket's
> pressure at all.

But we still might set memcg->socket_pressure and propagate the pressure,
right?
If you're changing this, you need to provide a bit more data on why it's
a good idea. I'm not saying the current status is perfect, but I think we need
a bit more justification for this change.

> While for default mode, the ->tcpmem is simply
> not used.
> 
> So {socket,tcpmem}_pressure are only used in default/legacy mode
> respectively. This patch fixes the pieces of code that make mixed
> use of both.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  include/linux/memcontrol.h | 4 ++--
>  mm/vmpressure.c            | 8 ++++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 5818af8eca5a..5860c7f316b9 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1727,8 +1727,8 @@ void mem_cgroup_sk_alloc(struct sock *sk);
>  void mem_cgroup_sk_free(struct sock *sk);
>  static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
>  {
> -	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg->tcpmem_pressure)
> -		return true;
> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		return !!memcg->tcpmem_pressure;

So here you can have something like
   if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
        do {
            if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
                  return true;
        } while ((memcg = parent_mem_cgroup(memcg)));
   } else {
	return !!READ_ONCE(memcg->socket_pressure);
   }

And, please, add a bold comment here or nearby the socket_pressure definition
that it has a different semantics in the legacy and default modes.

Overall I think it's a good idea to clean these things up and thank you
for working on this. But I wonder if we can make the next step and leave only
one mechanism for both cgroup v1 and v2 instead of having this weird setup
where memcg->socket_pressure is set differently from different paths on cgroup
v1 and v2.

Thanks!

