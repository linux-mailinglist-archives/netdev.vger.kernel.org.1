Return-Path: <netdev+bounces-157027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC06A08C28
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AF43A95F0
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644642080E1;
	Fri, 10 Jan 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BSzJgeyH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF2620A5F5
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501331; cv=none; b=DREM+Oo1/ca01eE/lF7osT0zPl3g6Czcwdgh5NIroih9pdbkJqvMi1B6Eje4LLcUF+UJUUSWQ3Di6EzRoFQOAhp/vCVTqV1B+ACUlXE2Z3h3V+mWaE4QiPr9j7HL8M+9G3ZrsivFgPybsQpw1d1CIf6jHS/o5Ns6zcBlla6M8xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501331; c=relaxed/simple;
	bh=0Ap47lpyfQBoMXsC4C5t0FTb9u7+ECgci6hK7CBTaMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VC5lscJTnGjZH5ITb3QaG0+kzUbEdzgdJPcxP7nqjT9edIdL2x3Q9d0S0EVWBf/6SgHRbPlVK5f87vqNiQl6JXGQEmFbr9i2eNCNf+qixySvPbrZQWX+lTIpYnwWr8jGJAgqzsUKGYo+DIpwOzNfWVKrnX5OvtHkkHQYuD7nDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BSzJgeyH; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736501329; x=1768037329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WRvz/jt2K+XR/8BEV3sbpF+J4ezyxNZwPZiP0vIZEyk=;
  b=BSzJgeyH0BfvTZWv+1DnkBobFEVm40HqD80Oj18eaGiM1kR/LjlrXNtK
   BG1dyvMnhVGNt90lI2NerPtaAW5iW2mHWTFXchQxaIQamOJN4hnkL/G1Z
   X2MNarThGCIGIUhTlbvamdzBZYJOC+JllnjweOx1UkcoNh7+QIwJQ8A9W
   4=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="790117096"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:28:44 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:42245]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.9:2525] with esmtp (Farcaster)
 id 35e9a0d8-ccbd-4c07-8857-3bd9908dd81b; Fri, 10 Jan 2025 09:28:44 +0000 (UTC)
X-Farcaster-Flow-ID: 35e9a0d8-ccbd-4c07-8857-3bd9908dd81b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:28:43 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:28:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 04/12] af_unix: Set drop reason in __unix_gc().
Date: Fri, 10 Jan 2025 18:26:33 +0900
Message-ID: <20250110092641.85905-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250110092641.85905-1-kuniyu@amazon.com>
References: <20250110092641.85905-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
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


