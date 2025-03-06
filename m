Return-Path: <netdev+bounces-172301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF08BA541A8
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 05:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170D31890983
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 04:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596F919AD8C;
	Thu,  6 Mar 2025 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BvFIG8js"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC818FDAA
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 04:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741235245; cv=none; b=fYC2gSBaL/79FIS4pCZ6pb4BLLGpIaqfE1GFhcgNJt0Bc5/RGMiNPZvnQixMlmEVgGd1yP7XVIMMnWzco2BZaFjQLGTIE3IxAo7JI6N2F5VUH4mcwFT98QWEqKftojFfIe6/JM4i/xm1STeJ4bP6C2YRrPALMEvnArKRPwNQgsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741235245; c=relaxed/simple;
	bh=TAWjmN/UFr5r8rncF27YX5IQTX+lsSk4Bw+bg787l2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DV1aXbtKxc4oCLE7UoXzwabZ6gBpwJ2egXaPShEIEU2hX429LmxItOf2c0akT80ueAlD6lMzqAqYtpwzpfqPVD+68m6WZAQFBbm7khCgQeVdE8rmv6kQ4d4i68G7ZABGvuAxuZCWjeAaAu2yXBKIso/VPXfCnXujMllC9bc+edc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BvFIG8js; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741235243; x=1772771243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ajo9dw/DhF2J/VSLR5Wh3TYG0v4/vW9wdpZYpwX9fhs=;
  b=BvFIG8js4q0PvU6CKuIpHaAKWvPrSw1I6lLDnsyE8zrw4juoiNYze3f0
   rs6EUw14CNUMU+UoEQu637F6vHoox+FH5pcRjs9TqxUYf/ZuNFlgCYnY6
   s4/kyatQd2nK+WKovjC5IDs2o3IuoEJBy2xGRj1JvRV3lTrYvJOOgKNBd
   U=;
X-IronPort-AV: E=Sophos;i="6.14,225,1736812800"; 
   d="scan'208";a="702621806"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 04:27:20 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:24138]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.107:2525] with esmtp (Farcaster)
 id 23f63f23-1651-4e50-8d02-7e7ce151c495; Thu, 6 Mar 2025 04:27:20 +0000 (UTC)
X-Farcaster-Flow-ID: 23f63f23-1651-4e50-8d02-7e7ce151c495
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 6 Mar 2025 04:27:19 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.191.155) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 6 Mar 2025 04:27:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] inet: call inet6_ehashfn() once from inet6_hash_connect()
Date: Wed, 5 Mar 2025 20:26:43 -0800
Message-ID: <20250306042707.70115-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305034550.879255-3-edumazet@google.com>
References: <20250305034550.879255-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed,  5 Mar 2025 03:45:50 +0000
> inet6_ehashfn() being called from __inet6_check_established()
> has a big impact on performance, as shown in the Tested section.
> 
> After prior patch, we can compute the hash for port 0
> from inet6_hash_connect(), and derive each hash in
> __inet_hash_connect() from this initial hash:
> 
> hash(saddr, lport, daddr, dport) == hash(saddr, 0, daddr, dport) + lport
> 
> Apply the same principle for __inet_check_established(),
> although inet_ehashfn() has a smaller cost.
> 
> Tested:
> 
> Server: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog
> Client: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog -c -H server
> 
> Before this patch:
> 
>   utime_start=0.286131
>   utime_end=4.378886
>   stime_start=11.952556
>   stime_end=1991.655533
>   num_transactions=1446830
>   latency_min=0.001061085
>   latency_max=12.075275028
>   latency_mean=0.376375302
>   latency_stddev=1.361969596
>   num_samples=306383
>   throughput=151866.56
> 
> perf top:
> 
>  50.01%  [kernel]       [k] __inet6_check_established
>  20.65%  [kernel]       [k] __inet_hash_connect
>  15.81%  [kernel]       [k] inet6_ehashfn
>   2.92%  [kernel]       [k] rcu_all_qs
>   2.34%  [kernel]       [k] __cond_resched
>   0.50%  [kernel]       [k] _raw_spin_lock
>   0.34%  [kernel]       [k] sched_balance_trigger
>   0.24%  [kernel]       [k] queued_spin_lock_slowpath
> 
> After this patch:
> 
>   utime_start=0.315047
>   utime_end=9.257617
>   stime_start=7.041489
>   stime_end=1923.688387
>   num_transactions=3057968
>   latency_min=0.003041375
>   latency_max=7.056589232
>   latency_mean=0.141075048    # Better latency metrics
>   latency_stddev=0.526900516
>   num_samples=312996
>   throughput=320677.21        # 111 % increase, and 229 % for the series
> 
> perf top: inet6_ehashfn is no longer seen.
> 
>  39.67%  [kernel]       [k] __inet_hash_connect
>  37.06%  [kernel]       [k] __inet6_check_established
>   4.79%  [kernel]       [k] rcu_all_qs
>   3.82%  [kernel]       [k] __cond_resched
>   1.76%  [kernel]       [k] sched_balance_domains
>   0.82%  [kernel]       [k] _raw_spin_lock
>   0.81%  [kernel]       [k] sched_balance_rq
>   0.81%  [kernel]       [k] sched_balance_trigger
>   0.76%  [kernel]       [k] queued_spin_lock_slowpath
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Interesting optimisation, thanks!

