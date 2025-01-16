Return-Path: <netdev+bounces-158763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C165A132A9
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBF03A7F0E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4D7155389;
	Thu, 16 Jan 2025 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kUmpMOuB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF45C2AE99
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005826; cv=none; b=BNt5dvDiMqhrDoeH6f1eZdoC3b9B6uU5ECIJwG2dkGkB1/P5Mnm2rBirCGjv8NXQMFd7pblvWNZBVnAKTpNJXlBS7eYk2h7ynxPlaVqMzNQl0quxqG8TBVv76ckknTeA2yB+n3kPXK3mR7dIGLhwZtf3GHL6N94JkUgJz1cupso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005826; c=relaxed/simple;
	bh=0Ap47lpyfQBoMXsC4C5t0FTb9u7+ECgci6hK7CBTaMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8IeP7yMy+jgWlkzsWqgQihmxSIyH/JfedmD98K6z0qD5OCd/GtXlUoA1fwh8u2v0ubjS3Q5ftZkBDuKJyFkDM3SsJWUWLNq5r2yHMAbAP6KpF0oZHFwk73AEvYNnp7h4OIIzN9ZZsJBw9QpVJGL66EXP1xtqw3aEv2sPiSb2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kUmpMOuB; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737005825; x=1768541825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WRvz/jt2K+XR/8BEV3sbpF+J4ezyxNZwPZiP0vIZEyk=;
  b=kUmpMOuBbPtApolk9pvyoaXqTad8uldrmm+qQ8wEcI6UWOgg0fuiBEur
   cVQkyrQ+QdgdkQErqNbGs9gfccwKzN6WWo64FqkIMVrTjIvnR9ooOy7qZ
   MYkpeLDm3ETfcodb+6yIQ9Dep+sddwlRxm6YBa7rEjKLuh0HCeTXVsQZS
   g=;
X-IronPort-AV: E=Sophos;i="6.13,208,1732579200"; 
   d="scan'208";a="464483694"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:36:56 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:9148]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.205:2525] with esmtp (Farcaster)
 id 827ed17f-f3fa-4657-b0ac-cc9a5e2031a3; Thu, 16 Jan 2025 05:36:55 +0000 (UTC)
X-Farcaster-Flow-ID: 827ed17f-f3fa-4657-b0ac-cc9a5e2031a3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:36:55 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.84.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:36:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 4/9] af_unix: Set drop reason in __unix_gc().
Date: Thu, 16 Jan 2025 14:34:37 +0900
Message-ID: <20250116053441.5758-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250116053441.5758-1-kuniyu@amazon.com>
References: <20250116053441.5758-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Inflight file descriptors by SCM_RIGHTS hold references to the
struct file.

AF_UNIX sockets could hold references to each other, forming
reference cycles.

Once such sockets are close()d without the fd recv()ed, they
will be unaccessible from userspace but remain in kernel.

__unix_gc() garbage-collects skb with the dead file descriptors
and frees them by __skb_queue_purge().

Let's set SKB_DROP_REASON_SOCKET_CLOSE there.

  # echo 1 > /sys/kernel/tracing/events/skb/kfree_skb/enable

  # python3
  >>> from socket import *
  >>> from array import array
  >>>
  >>> # Create a reference cycle
  >>> s1 = socket(AF_UNIX, SOCK_DGRAM)
  >>> s1.bind('')
  >>> s1.sendmsg([b"nop"], [(SOL_SOCKET, SCM_RIGHTS, array("i", [s1.fileno()]))], 0, s1.getsockname())
  >>> s1.close()
  >>>
  >>> # Trigger GC
  >>> s2 = socket(AF_UNIX)
  >>> s2.close()

  # cat /sys/kernel/tracing/trace_pipe
  ...
     kworker/u16:2-42 ... kfree_skb: ... location=__unix_gc+0x4ad/0x580 reason: SOCKET_CLOSE

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 0068e758be4d..9848b7b78701 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -573,7 +573,7 @@ static void __unix_gc(struct work_struct *work)
 			UNIXCB(skb).fp->dead = true;
 	}
 
-	__skb_queue_purge(&hitlist);
+	__skb_queue_purge_reason(&hitlist, SKB_DROP_REASON_SOCKET_CLOSE);
 skip_gc:
 	WRITE_ONCE(gc_in_progress, false);
 }
-- 
2.39.5 (Apple Git-154)


