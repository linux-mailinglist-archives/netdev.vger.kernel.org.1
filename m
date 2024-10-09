Return-Path: <netdev+bounces-133973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D360997967
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FEA1C2209E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBB61E47A8;
	Wed,  9 Oct 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kdkt2x9+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6AC1922C4
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518164; cv=none; b=F5FtMTdFeTByKPN89yhgdIuPUqa93Vk3rJa8C3azF8WMEm1tFArKBwxurhPaUwFCyVVMQauVz8pro4qNhd3ETLE7LBt/H+ycUoQj+K2c8jTD4jTirXdLQkYn9Tx6oVkWSuORzDb/jEXUU1uJi+bMWHTK3R82Ix+JMjvBv9a4XaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518164; c=relaxed/simple;
	bh=xXZbtGJtLc07uGlE3N8yHQwNnh7p4cPmYsUfUUXTjO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rx+f6M+AlODv5aq1MIjGIAhPrAbLcpNesvReaH2B6IQinxauVujKIobiZoJY03Gzf5eGj6rw9gr6KD/x/NvUKnOe8y+Pwx+lT9iEfeMRULKESDSbEdWREbJRpOkKxdxoXKD8NOFTSkSPx4qhKVhaYnxgG7pFH4wZoLUMB4/GDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kdkt2x9+; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728518163; x=1760054163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m4GqJITGFF1M3OR4neAxOfA+fHuu7Se3JzpTRGMbcAA=;
  b=kdkt2x9+woSP7725felDZGD5JmMTHiq9MOq9u4cq/KYUSjoNqKx1BUL7
   yKrBIJWSGOrqitex7uEe9zq0uuWlgbPW4VPIfwfQNs8b3pyXUzfnb1w29
   lb0bE+Uv48fm64u9EmSDU9LICK9mHeqylGHYFv8HnuKoD+iJXTkbxLS7o
   I=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="374833351"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:55:57 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:7376]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id 4cf194b3-5437-4e3a-9916-fd0a41721056; Wed, 9 Oct 2024 23:55:57 +0000 (UTC)
X-Farcaster-Flow-ID: 4cf194b3-5437-4e3a-9916-fd0a41721056
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:55:57 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:55:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<jiri@resnulli.us>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/5] ipv6: use READ_ONCE()/WRITE_ONCE() on fib6_table->fib_seq
Date: Wed, 9 Oct 2024 16:55:51 -0700
Message-ID: <20241009235551.60988-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009184405.3752829-4-edumazet@google.com>
References: <20241009184405.3752829-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed,  9 Oct 2024 18:44:03 +0000
> Using RTNL to protect ops->fib_rules_seq reads seems a big hammer.
> 
> Writes are protected by RTNL.
> We can use READ_ONCE() when reading it.
> 
> Constify 'struct net' argument of fib6_tables_seq_read() and
> fib6_rules_seq_read().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

