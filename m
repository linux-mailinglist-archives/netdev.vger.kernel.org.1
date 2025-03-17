Return-Path: <netdev+bounces-175443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6278A65F15
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F864189DDAE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491331F462D;
	Mon, 17 Mar 2025 20:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iq09KKlU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B61AA782
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243295; cv=none; b=KJMoKElU8OiWY8ebDrYnszdWV/Im0TlSeLDNdgjkqGKkuAK6daYZCGJC5jqSJ3mSGMQp8itccWblYm3697U0D6WL9oLh8Jw0bdCJ4RXM/S9qBB31PpPeXj8BY3mz/LbyMbdF7efWEueYN7M+2pHeE6qqRkd6C/uCYYMWQuxtXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243295; c=relaxed/simple;
	bh=zLL0jXEXMrt+pnXt4cxgPUgpdmdvOtndXaXQPcP/ksk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1XcoJSpGaUqfNVlVAsQ1y581DoBamG3HIB1i3Cmi2WjyUoMTChzo6fNiR5hY55J0cYBSq/OLxdaQiW7rawMJ+/zP58+kJpthcpgF53JnZCw0wNAeCXqMgYdUlAwDnb3b1DDF07mn0Az9rjx2Lk4soEHSTSYf+fbv6AA+BFtdyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iq09KKlU; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742243293; x=1773779293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WkhHVdpj7b0/JHwekw96h07HK6MTELFfDovpEU+wZtQ=;
  b=iq09KKlUKyzrfuRSfj4eEnYK8TFDX987TBHZostpLqLtCEmJS9oeavjZ
   sseSnc+fPvZZbaWZ2jeJ2CaUawFQW8c67ja8hkjwQUCOr10V9ZkBVE/gQ
   9HqeF4z6szpHWYhCLdyjCbkPOJxiuKzd4xRSvTUszQw4gv73X6Hf2L0Ua
   Y=;
X-IronPort-AV: E=Sophos;i="6.14,254,1736812800"; 
   d="scan'208";a="387469479"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 20:28:11 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:21920]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.151:2525] with esmtp (Farcaster)
 id 847d888c-792f-40fb-879e-0d9013872d44; Mon, 17 Mar 2025 20:28:11 +0000 (UTC)
X-Farcaster-Flow-ID: 847d888c-792f-40fb-879e-0d9013872d44
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Mar 2025 20:28:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.54) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Mar 2025 20:28:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] tcp/dccp: remove icsk->icsk_ack.timeout
Date: Mon, 17 Mar 2025 13:27:49 -0700
Message-ID: <20250317202751.24641-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317151401.3439637-3-edumazet@google.com>
References: <20250317151401.3439637-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Mar 2025 15:14:01 +0000
> icsk->icsk_ack.timeout can be replaced by icsk->csk_delack_timer.expires
> 
> This saves 8 bytes in TCP/DCCP sockets and helps for better cache locality.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

