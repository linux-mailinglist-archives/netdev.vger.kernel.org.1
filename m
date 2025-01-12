Return-Path: <netdev+bounces-157492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A648A0A722
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 05:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27179164D88
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 04:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E851E502;
	Sun, 12 Jan 2025 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EXCBQ1Rc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06B2941C
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736655016; cv=none; b=fSupEeSUNsetG74tEt0UrdMEFH8AhOyDTrrUjClNW1bvv0UhbAXBKhf9CXLwpDX+kGixxDceOUNMC/4j2AxtILa9v9FnnPZ4Gj7Hac2mqWcD62GpKY07jfCOnjHWcQp7Bebkn0xSgZ9dO/Z9CsId/nPD2EeIezrSHqECGBmsYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736655016; c=relaxed/simple;
	bh=0Ap47lpyfQBoMXsC4C5t0FTb9u7+ECgci6hK7CBTaMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+cfHrNAvGmA4tmqdVTIkM7P/vNKp4H/FOQ5j7cAnLJChtLzw33ubdirnXPwA3TH0H/2QdFzW73DL37gFLLps6aWQZjL1E7cKc3YBPDXPmvLG1Jo7b8P2I6Sj3L37J0h4TZ7px42aW3R1qPbUItlY50h0sXhfU3Hx/9yr2GMChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EXCBQ1Rc; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736655015; x=1768191015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WRvz/jt2K+XR/8BEV3sbpF+J4ezyxNZwPZiP0vIZEyk=;
  b=EXCBQ1RcF0Y7jOd/uAJqoqq5b3STXQFTKVTJrQiv/e4QeXUtR3mP0Gli
   P2u4cn3V37Vkni6A+m6E2R9leay9K3/KSjjmA0jMGOmXbh+Nn4FlHd5t1
   F22sdVJHxFBSSRJV+7qsZuqXpTu2T31VCZK8YOdJ1y9DO+Hsu4VlSs4b+
   E=;
X-IronPort-AV: E=Sophos;i="6.12,308,1728950400"; 
   d="scan'208";a="57045646"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 04:10:11 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:41166]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.12:2525] with esmtp (Farcaster)
 id 369e3303-9c9d-43b2-a845-918e1ee6291c; Sun, 12 Jan 2025 04:10:11 +0000 (UTC)
X-Farcaster-Flow-ID: 369e3303-9c9d-43b2-a845-918e1ee6291c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:10:10 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.156) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:10:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 04/11] af_unix: Set drop reason in __unix_gc().
Date: Sun, 12 Jan 2025 13:08:03 +0900
Message-ID: <20250112040810.14145-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112040810.14145-1-kuniyu@amazon.com>
References: <20250112040810.14145-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
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


