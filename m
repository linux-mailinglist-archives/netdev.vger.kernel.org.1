Return-Path: <netdev+bounces-172300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 605B4A541A2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 05:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F7918907DB
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 04:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E6A19ABD8;
	Thu,  6 Mar 2025 04:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LFrCrmW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE4192D9A
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 04:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741235103; cv=none; b=DvLORMgkhf1/Z3tmwi9lorcZauy2K/B6UD0PiAsstiL/3DvwMcNntfC9hX8OtwxG9rGwkt75UExh+qWtKZHoeGqYAMA0gT69HdYYAjz6KKd26PUJYVUyEP4afBtWnhMqHIwunkONJYRiP8328R6ly21a9jCClvOPaXxU7MT1enk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741235103; c=relaxed/simple;
	bh=0BrLpzTIDvTMlAfxwv+VCfKWZTragTBy1WWRTGOKUHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlSHiVo9qZF9Lzq4Oj1uzeX4DNNGx7759ZJyuhAmXnDMwuSDWl6HZn088/9dzHVpfyAWF1FN9qyMBN/oxjYJ3ja3v5MQ3TBaREeNcspDig48BvL0fThhNwYdgph9QnHqJRHG/lat9m3qrwfhU5eo7jR02IemnGe+yFlIrqbjdNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LFrCrmW2; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741235102; x=1772771102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NPy5GQ6Y41XlgNBn2OobCAASomVwo12iHoey5n0hqvg=;
  b=LFrCrmW2eGzgUxJaU9l1sZ3nSrkFzWiEJXg2A/dGPGc8esc6G0NQa810
   CBApMsF8ewIsG7gjdSVUl+E+ZJ+k5jyzXGeboEy928BjNDXfvt2NVQEIo
   HZ72UpoIWwgzQT41S6F3LJyw4hI3WkDhL4yE9tdPndy0nkGtgIKop9DGx
   4=;
X-IronPort-AV: E=Sophos;i="6.14,225,1736812800"; 
   d="scan'208";a="477811282"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 04:24:58 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:36505]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.107:2525] with esmtp (Farcaster)
 id d8d43171-3e6c-4889-a555-9a65e8df8847; Thu, 6 Mar 2025 04:24:57 +0000 (UTC)
X-Farcaster-Flow-ID: d8d43171-3e6c-4889-a555-9a65e8df8847
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 6 Mar 2025 04:24:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.191.155) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 6 Mar 2025 04:24:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: [PATCH net-next 1/2] inet: change lport contribution to inet_ehashfn() and inet6_ehashfn()
Date: Wed, 5 Mar 2025 20:24:39 -0800
Message-ID: <20250306042445.69938-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305034550.879255-2-edumazet@google.com>
References: <20250305034550.879255-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed,  5 Mar 2025 03:45:49 +0000
> In order to speedup __inet_hash_connect(), we want to ensure hash values
> for <source address, port X, destination address, destination port>
> are not randomly spread, but monotonically increasing.
> 
> Goal is to allow __inet_hash_connect() to derive the hash value
> of a candidate 4-tuple with a single addition in the following
> patch in the series.
> 
> Given :
>   hash_0 = inet_ehashfn(saddr, 0, daddr, dport)
>   hash_sport = inet_ehashfn(saddr, sport, daddr, dport)
> 
> Then (hash_sport == hash_0 + sport) for all sport values.
> 
> As far as I know, there is no security implication with this change.
> 
> After this patch, when __inet_hash_connect() has to try XXXX candidates,
> the hash table buckets are contiguous and packed, allowing
> a better use of cpu caches and hardware prefetchers.
> 
> Tested:
> 
> Server: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog
> Client: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog -c -H server
> 
> Before this patch:
> 
>   utime_start=0.271607
>   utime_end=3.847111
>   stime_start=18.407684
>   stime_end=1997.485557
>   num_transactions=1350742
>   latency_min=0.014131929
>   latency_max=17.895073144
>   latency_mean=0.505675853
>   latency_stddev=2.125164772
>   num_samples=307884
>   throughput=139866.80
> 
> perf top on client:
> 
>  56.86%  [kernel]       [k] __inet6_check_established
>  17.96%  [kernel]       [k] __inet_hash_connect
>  13.88%  [kernel]       [k] inet6_ehashfn
>   2.52%  [kernel]       [k] rcu_all_qs
>   2.01%  [kernel]       [k] __cond_resched
>   0.41%  [kernel]       [k] _raw_spin_lock
> 
> After this patch:
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
> There is indeed an increase of throughput and reduction of latency.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

