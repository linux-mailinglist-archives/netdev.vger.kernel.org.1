Return-Path: <netdev+bounces-164547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 606D7A2E280
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 04:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428F23A198D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 03:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8E743AA1;
	Mon, 10 Feb 2025 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dOXmNOot"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F35C46B8
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739156892; cv=none; b=H9FDy9ZzqRz8cH4eXfjqqfLDlENeVlonpwjmpdAIH7wIo9e47vGp1v5BTzqa0Kz2se330JUHytRksdAPa99Bf81ZyohpcUW9mxQvSjiE+ktFVmwe+AL0XntEvysnuIVwkPtf8ylu0Gwgyi+B49CFycVkU8ZeGgGdN1yv8URIrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739156892; c=relaxed/simple;
	bh=ZxZ5kAw/Tri0LtfU2n49/matL/1dAU6gzSMoKf0RHrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avVSluvsYMHEej3ZKoXJPDyCn1Vm8/8MxR3yky6bU1Ifk6Rbqerwl8OAnTeUUb9vAM/nf7vhalNxjqC+e7RRVKekFUOtHxukGYkOW1iYitC9XZng04x2IZP/a+D/TNVyOV3mPBmpxZFCQYMFyXVxNG2H7bIWPiQOOr8jPpUunWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dOXmNOot; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739156891; x=1770692891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Kdf3jMkXrHa6R0G3GizZT2zJuGxT2/1T/mWvpvOzhM=;
  b=dOXmNOotC4U/uWXibZiJZpNywDKy/YjdA2GrfigURwCwbe2GLECmMrBL
   d0MiIU39hQNw538mMG4HZbmZTS8C5MM5PwqqkdGi4Ikd5EbsCDeirqPpm
   fKL4XhqLOvIyS0k8ZRkNqCgkfxK4UINeQoPMbBCdvm9FHADj5yu2txCQx
   g=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="168269882"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 03:08:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:30500]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.117:2525] with esmtp (Farcaster)
 id 09ae0769-c808-4cab-beef-f0a2ca625800; Mon, 10 Feb 2025 03:08:05 +0000 (UTC)
X-Farcaster-Flow-ID: 09ae0769-c808-4cab-beef-f0a2ca625800
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 03:07:59 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 03:07:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net 8/8] ipv6: mcast: extend RCU protection in igmp6_send()
Date: Mon, 10 Feb 2025 12:07:46 +0900
Message-ID: <20250210030746.57432-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207135841.1948589-9-edumazet@google.com>
References: <20250207135841.1948589-9-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  7 Feb 2025 13:58:40 +0000
> igmp6_send() can be called without RTNL or RCU being held.
> 
> Extend RCU protection so that we can safely fetch the net pointer
> and avoid a potential UAF.
> 
> Note that we no longer can use sock_alloc_send_skb() because
> ipv6.igmp_sk uses GFP_KERNEL allocations which can sleep.
> 
> Instead use alloc_skb() and charge the net->ipv6.igmp_sk
> socket under RCU protection.
> 
> Fixes: b8ad0cbc58f7 ("[NETNS][IPV6] mcast - handle several network namespace")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

