Return-Path: <netdev+bounces-157235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3E1A0990A
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678083A203E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 18:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C069F212B01;
	Fri, 10 Jan 2025 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ScqNB5Kf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE84205AA2
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736532201; cv=none; b=plvPf0RbcQkmmmFkTt5cu6lUMswtBnWYTpbd/l8Nxsc4cAA56JZH0fmmt38Ypi4vbPjgwUxRTvMC5HQAeM+t8YDOr9ela/oiaaHJR/4tO/ZDGrBM4HfyqFn/T1fUbIfWyg6fXjXPQunSs5sbePHZ86V9ki9GY2nn1INtoRBtzqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736532201; c=relaxed/simple;
	bh=vYJvsNgIMO4TZNsHRvF01icPWLc3+Qn4oCgTmDYRfm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0t7nFbvF84JcmdGSIUo7H5gQR7uHPyA3Lhv/L66dnaIHBDyOyTj1Yv6KbLQYpHBwZ2nZ4aOjxfogcerZMTwUpKruSj0Bci9x3azbpVxdzD3Zubb5I/0H2hWpKzLD0SerIyPPHsGA/CyrOlZ/6e4aDXsocm7qIxdUaxlL2NOYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ScqNB5Kf; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736532201; x=1768068201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5jqGfIIh2UOuA6X4QKCWVs/Jqx/TV7C9oLDSSUAP/OI=;
  b=ScqNB5KfkIVI51wap4p1zKRRf4W7zfSn0GGLDvycljslKFYG5w/Ab2Vv
   zmCw46Eisc/KyJGtRLmA85sTMCr51vY3Gkd9/hQIjdWbBO0f+JDU88uYv
   g/RQTRAoGtOx+nBgVbJZJDMb5MpXoPwBI2J8nHSarto5sa+cKC860T4kE
   k=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="463227448"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 18:03:16 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:57668]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.22:2525] with esmtp (Farcaster)
 id 2ce4409a-1404-4332-84e5-8e81f610ad04; Fri, 10 Jan 2025 18:03:15 +0000 (UTC)
X-Farcaster-Flow-ID: 2ce4409a-1404-4332-84e5-8e81f610ad04
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 18:03:15 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 18:03:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] tcp: add TCP_RFC7323_PAWS_ACK drop reason
Date: Sat, 11 Jan 2025 03:03:01 +0900
Message-ID: <20250110180301.57516-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250110143315.571872-3-edumazet@google.com>
References: <20250110143315.571872-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Jan 2025 14:33:15 +0000
> XPS can cause reorders because of the relaxed OOO
> conditions for pure ACK packets.
> 
> For hosts not using RFS, what can happpen is that ACK
> packets are sent on behalf of the cpu processing NIC
> interrupts, selecting TX queue A for ACK packet P1.
> 
> Then a subsequent sendmsg() can run on another cpu.
> TX queue selection uses the socket hash and can choose
> another queue B for packets P2 (with payload).
> 
> If queue A is more congested than queue B,
> the ACK packet P1 could be sent on the wire after
> P2.
> 
> A linux receiver when processing P2 currently increments
> LINUX_MIB_PAWSESTABREJECTED (TcpExtPAWSEstab)
> and use TCP_RFC7323_PAWS drop reason.
> It might also send a DUPACK if not rate limited.
> 
> In order to better understand this pattern, this
> patch adds a new drop_reason : TCP_RFC7323_PAWS_ACK.
> 
> For old ACKS like these, we no longer increment
> LINUX_MIB_PAWSESTABREJECTED and no longer sends a DUPACK,
> keeping credit for other more interesting DUPACK.
> 
> perf record -e skb:kfree_skb -a
> perf script
> ...
>          swapper       0 [148] 27475.438637: skb:kfree_skb: ... location=tcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [208] 27475.438706: skb:kfree_skb: ... location=tcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [208] 27475.438908: skb:kfree_skb: ... location=tcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [148] 27475.439010: skb:kfree_skb: ... location=tcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [148] 27475.439214: skb:kfree_skb: ... location=tcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [208] 27475.439286: skb:kfree_skb: ... location=tcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
> ...
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

