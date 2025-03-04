Return-Path: <netdev+bounces-171463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC5A4D068
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D0717044B
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261736AAD;
	Tue,  4 Mar 2025 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rGtKAFqC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D72118D
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 00:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741049493; cv=none; b=sQK9uyra1++osu1Sang7SNoxp8MjskVRred0IsfabX5ZPhOoka6n5eOI5XiP7/KIRE7Ke8ROMNsopFBoXXGskMStzcpQLeXSTaWoCfskiAHfnLZYglV1xNWtUWzglM7KGrstkRmijdCMLKxS+1nJwkuFxbKzWsS1yOxPMX7CT4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741049493; c=relaxed/simple;
	bh=NVXC0uTkcvghYn8SiU8IATsXOT8o5L/UrtwZMvoCPfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O28hTbr9+B0VClAPVREVLXxnfTiKiqsATaV14y0xnRx5Ps1x+0M2jrCNHXtWCJO+xxcSOZmWSf9GxVFQa6zi2uxQemLl3xm0nSspXWS8V578PUWiTeVPjBnOyijV09ya6wafWSqeoI5xin+z4TT0/oHbHLxT1ceGDTnuEC284QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rGtKAFqC; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741049492; x=1772585492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zs+iHnbdUuPfAlQNXsrGcI2tr1PxPfLADJDmrhkKEeM=;
  b=rGtKAFqCixuEbsZZa5Y3+Se9NBfhtMDtK13N0kIo7I21BJSG8woVIq2x
   3QrgJovpBiCX6llWlryqNOhhGAG7wyk/tuinsAH/UgDOF3lWUIdxqY1S4
   1pf/MwvrOBx0Qt0G44cB3oDBoiK9ey85yeQRRiOC0oi6VFutNFR1QJUPG
   0=;
X-IronPort-AV: E=Sophos;i="6.13,331,1732579200"; 
   d="scan'208";a="701862929"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:51:28 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:56227]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.61:2525] with esmtp (Farcaster)
 id 4d98e19d-e81f-4ee5-8430-e1f09be1bbe4; Tue, 4 Mar 2025 00:51:27 +0000 (UTC)
X-Farcaster-Flow-ID: 4d98e19d-e81f-4ee5-8430-e1f09be1bbe4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 00:51:27 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 00:51:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kerneljasonxing@gmail.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 4/4] tcp: use RCU lookup in __inet_hash_connect()
Date: Mon, 3 Mar 2025 16:51:14 -0800
Message-ID: <20250304005114.64041-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250302124237.3913746-5-edumazet@google.com>
References: <20250302124237.3913746-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Sun,  2 Mar 2025 12:42:37 +0000
> When __inet_hash_connect() has to try many 4-tuples before
> finding an available one, we see a high spinlock cost from
> the many spin_lock_bh(&head->lock) performed in its loop.
> 
> This patch adds an RCU lookup to avoid the spinlock cost.
> 
> check_established() gets a new @rcu_lookup argument.
> First reason is to not make any changes while head->lock
> is not held.
> Second reason is to not make this RCU lookup a second time
> after the spinlock has been acquired.
> 
> Tested:
> 
> Server:
> 
> ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog
> 
> Client:
> 
> ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog -c -H server
> 
> Before series:
> 
>   utime_start=0.288582
>   utime_end=1.548707
>   stime_start=20.637138
>   stime_end=2002.489845
>   num_transactions=484453
>   latency_min=0.156279245
>   latency_max=20.922042756
>   latency_mean=1.546521274
>   latency_stddev=3.936005194
>   num_samples=312537
>   throughput=47426.00
> 
> perf top on the client:
> 
>  49.54%  [kernel]       [k] _raw_spin_lock
>  25.87%  [kernel]       [k] _raw_spin_lock_bh
>   5.97%  [kernel]       [k] queued_spin_lock_slowpath
>   5.67%  [kernel]       [k] __inet_hash_connect
>   3.53%  [kernel]       [k] __inet6_check_established
>   3.48%  [kernel]       [k] inet6_ehashfn
>   0.64%  [kernel]       [k] rcu_all_qs
> 
> After this series:
> 
>   utime_start=0.271607
>   utime_end=3.847111
>   stime_start=18.407684
>   stime_end=1997.485557
>   num_transactions=1350742
>   latency_min=0.014131929
>   latency_max=17.895073144
>   latency_mean=0.505675853  # Nice reduction of latency metrics
>   latency_stddev=2.125164772
>   num_samples=307884
>   throughput=139866.80      # 190 % increase
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
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks for the great optimisation!

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

