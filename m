Return-Path: <netdev+bounces-164542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ED4A2E207
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 02:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DD13A6E11
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C0C17BD6;
	Mon, 10 Feb 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lGfrVjYL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C8835953
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739150989; cv=none; b=tzgZQUpC34T+90DrAo+lpZUgPLtU+prORyJFzUBHLTqRuwGljXyxk3bakHD3bAi92C9FKBUNDmBtkJuB8eTGBpmCFvrE0LCIjJZuPOxIrfWBIqKzbplVnN1sRVlyW0krGf8Em6nZbXNxdQNs9fcBu9LK5AzAH4zOfxhDJGXCiVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739150989; c=relaxed/simple;
	bh=3gM3O2B6ynOG6j6M5Y9n5SSpAj9MIXFVwDg6z4EsrdQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFRLNsmwQiYTaMfUTaT+WRYam7rdO3GjOJcNXvgXfksIHOUA15TUVljM5rIL+GI8OC9qaGluQMzM7gV1JUuiumAUKimb+9FqZ/zhhjUrbiShlmqSjQwC3HSIam4EnJvInVcjQ4QHmjqDVztH/lUr7xqmU1I9lkiGpc6z7ms4/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lGfrVjYL; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739150988; x=1770686988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UlhKQtxsCNYEwu9Txa/4B1eAEzFM5+7pEahAExTDr2Y=;
  b=lGfrVjYLEjUKzCvkCeSn1n/Zhr8EMYdyd/N+IWeJuZDetBjNxuSUPqf1
   i2DTqgNhSivxjdMGaMj81qXWp05U+KN7mOP6xOxLOEN7+uEhuKZRN2g3x
   SE0qA9x4FFoYnuph1q1KeO4/KniGO/1mCgxdZMwodpMGzqU2bc7EfqbXp
   k=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="375883083"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:29:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:32502]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.236:2525] with esmtp (Farcaster)
 id 21371507-39c8-46f4-9f6a-459015ff214a; Mon, 10 Feb 2025 01:29:47 +0000 (UTC)
X-Farcaster-Flow-ID: 21371507-39c8-46f4-9f6a-459015ff214a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 01:29:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 01:29:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net 7/8] ndisc: extend RCU protection in ndisc_send_skb()
Date: Mon, 10 Feb 2025 10:29:31 +0900
Message-ID: <20250210012931.56257-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207135841.1948589-8-edumazet@google.com>
References: <20250207135841.1948589-8-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  7 Feb 2025 13:58:39 +0000
> ndisc_send_skb() can be called without RTNL or RCU held.
> 
> Acquire rcu_read_lock() earlier, so that we can use dev_net_rcu()
> and avoid a potential UAF.
> 
> Fixes: 1762f7e88eb3 ("[NETNS][IPV6] ndisc - make socket control per namespace")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

