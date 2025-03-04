Return-Path: <netdev+bounces-171432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2BDA4CFE3
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7843D171C15
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F08837;
	Tue,  4 Mar 2025 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YqdI5loV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C650D3C17
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047664; cv=none; b=e4PgIDvzDKHVKJYPx0GxjV5d1pvq/QLOglc8idc4aOcjexmuvGSBOWJdEHIpZg53rRx1HP94TJzkCnBQOFo/7QLH9cswip2ufKlZHFr3O34de1kWy9X6T2svWcQr/uGRC/jOwYDJiTc7u+zkSE+zGao1eZZ3M27w4w4BkUYr7HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047664; c=relaxed/simple;
	bh=Uzq6jb/WCZttbdM88Nao4M8dXjC2CJHw3Um69kwgmzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaGd6gvC1iu2idI5Cc9g8Xw9NngscDQUoVhyoWufIOd4f41cPbw8wgNMQ725iBvBdzRcI3rEXswdPzOZWrG2Whd3zPBSfrdPlEbZx7phr9EEIrh30S7fyx44BZvf9pOgWsxgbqChDf+sdteOtk4NrfU6MN4JRC+WbOlVJ9KDRy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YqdI5loV; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741047662; x=1772583662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ftVfc4IQl6J3YjERyHvXdXchfGhR3fKPQYlD3VYRBsQ=;
  b=YqdI5loVCzJIuSz/WkIbgXHLxmK05lYasmLQxOsmy6QB2pJ+Mnwj8Pmx
   Celokmbyehb2qv9vvZ3J7IM8D17lfOLg2AYXBAEuZxMtzXP21TnqcJHOl
   JgZP02DXzIPxQ6ngDdJfzTl5C83IV9QHUeqiD6reyhCM2y86CcaDMpaU1
   E=;
X-IronPort-AV: E=Sophos;i="6.13,331,1732579200"; 
   d="scan'208";a="175181926"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:21:01 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:22962]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.61:2525] with esmtp (Farcaster)
 id d2c1ac32-d587-4b90-8bd2-753a961620bd; Tue, 4 Mar 2025 00:21:00 +0000 (UTC)
X-Farcaster-Flow-ID: d2c1ac32-d587-4b90-8bd2-753a961620bd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 00:20:58 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 00:20:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kerneljasonxing@gmail.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/4] tcp: use RCU in __inet{6}_check_established()
Date: Mon, 3 Mar 2025 16:20:44 -0800
Message-ID: <20250304002044.60686-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250302124237.3913746-2-edumazet@google.com>
References: <20250302124237.3913746-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Sun,  2 Mar 2025 12:42:34 +0000
> When __inet_hash_connect() has to try many 4-tuples before
> finding an available one, we see a high spinlock cost from
> __inet_check_established() and/or __inet6_check_established().
> 
> This patch adds an RCU lookup to avoid the spinlock
> acquisition when the 4-tuple is found in the hash table.
> 
> Note that there are still spin_lock_bh() calls in
> __inet_hash_connect() to protect inet_bind_hashbucket,
> this will be fixed later in this series.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

