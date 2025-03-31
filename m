Return-Path: <netdev+bounces-178382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B666A76CD9
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95741654FB
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7F4189528;
	Mon, 31 Mar 2025 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="McjMFnPH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141321859F
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743445341; cv=none; b=WNoH9Uym6gGp38klGdJvlYAYg86ER6nqkxBsvtVKIXNaORjliB7ttg/EVN1qESGTa1jY8hUAmsYHE2i+ZbJtVCSVvbJfuKP4QMO2Bi+zjna0tfc9+7qRv5lM8mtRylUnBUUA+tRh/XYPI7lPHfwIJTUDct46QulwE7LvpKG6o04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743445341; c=relaxed/simple;
	bh=gyfZ0dU3klyEE36Mi6RWWpcQ7bq7zvBhqScsBSUilBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMsAvB8q0KAO7r8PdjEAdfJcamT35sYjuu+ss77ThtrCi0l5flBRtldcPIXo/esHNSR2cvK8THZZslslW09J0PJ95XFwkGFdJ2Jmc0D0Zrrl4rBOQbkIgtkJdUJJKL7QvQmuOFlIBiBuysWFZQFM6awz5PvQyakUuXeENaZr79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=McjMFnPH; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743445340; x=1774981340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BjkTnIzADyvzBAKQ6Mk8B2bjlzgVpYN2lKvlhi35Oto=;
  b=McjMFnPHhvKuBThc3r/LTdPtvilnK6qrioXyzGnSPk2gaCmPs1WC45BV
   UpLm/P5OWj61nq92VWzGNY7W3Kteln57vvpj90RPLO9S8lzYSDW5zhChk
   pjot0NUCg6jFjGJzXuDOXKuIHmR5GvGpBl2HyNKWBfGrzmQ7/rcWYAdVr
   4=;
X-IronPort-AV: E=Sophos;i="6.14,291,1736812800"; 
   d="scan'208";a="6099139"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 18:22:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:33788]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.48:2525] with esmtp (Farcaster)
 id e9097118-372f-4800-a4a2-c187b91b8e40; Mon, 31 Mar 2025 18:22:11 +0000 (UTC)
X-Farcaster-Flow-ID: e9097118-372f-4800-a4a2-c187b91b8e40
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 31 Mar 2025 18:22:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.186.82) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 31 Mar 2025 18:22:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v4 net 0/3] udp: Fix two integer overflows when sk->sk_rcvbuf is close to INT_MAX.
Date: Mon, 31 Mar 2025 11:21:34 -0700
Message-ID: <20250331182142.1108-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331065109.45dddd0d@kernel.org>
References: <20250331065109.45dddd0d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 31 Mar 2025 06:51:09 -0700
> On Sat, 29 Mar 2025 11:05:10 -0700 Kuniyuki Iwashima wrote:
> > v4:
> >   * Patch 4
> >     * Wait RCU for at most 30 sec
> 
> The new test still doesn't pass
> 
> TAP version 13
> 1..1
> # timeout set to 3600
> # selftests: net: so_rcvbuf
> # 0.00 [+0.00] TAP version 13
> # 0.00 [+0.00] 1..2
> # 0.00 [+0.00] # Starting 2 tests from 2 test cases.
> # 0.00 [+0.00] #  RUN           so_rcvbuf.udp_ipv4.rmem_max ...
> # 0.00 [+0.00] # so_rcvbuf.c:151:rmem_max:Expected pages (35) == 0 (0)
> # 0.00 [+0.00] # rmem_max: Test terminated by assertion
> # 0.00 [+0.00] #          FAIL  so_rcvbuf.udp_ipv4.rmem_max
> # 0.00 [+0.00] not ok 1 so_rcvbuf.udp_ipv4.rmem_max
> # 0.01 [+0.00] #  RUN           so_rcvbuf.udp_ipv6.rmem_max ...
> # 0.01 [+0.00] # so_rcvbuf.c:151:rmem_max:Expected pages (35) == 0 (0)
> # 0.01 [+0.00] # rmem_max: Test terminated by assertion
> # 0.01 [+0.00] #          FAIL  so_rcvbuf.udp_ipv6.rmem_max
> # 0.01 [+0.00] not ok 2 so_rcvbuf.udp_ipv6.rmem_max
> # 0.01 [+0.00] # FAILED: 0 / 2 tests passed.
> # 0.01 [+0.00] # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
> not ok 1 selftests: net: so_rcvbuf # exit=1
> 
> 
> Plus we also see failures in udpgso.sh

I forgot to update `size` when skb_condense() is called.

Without the change I saw the new test stuck at 1 page after
udpgso.sh, but with the change both passed.

Will post v5.

Thanks!

