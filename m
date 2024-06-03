Return-Path: <netdev+bounces-100249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB978D851D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1AE1F21C84
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA89312F360;
	Mon,  3 Jun 2024 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cMVHjAq/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785F482D8E
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425207; cv=none; b=PuHj8Z98+vL28s6QIhFhFyFgUxINfYbIwbccbmnno4pZhX2kEoBtavY9cpkoM1P38dTdrrYqkDKHiHI1Y1hrXkVCqd/+dtXheFdcfPKnUtcI11pCDoSrDUNV+Q67UVmuxl/b4Uh58qmW92NekL5dmnLYNuTlXtS3Jjb87lL/O3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425207; c=relaxed/simple;
	bh=vQ4cnvE/P9WN3SiQDv+6ChuRIDkJixhs/F8S35oUQSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jo3ptITrHX+2K20cmBdqVj0+d2rn40KPO34El7PdZGRVcbu1utcbwHY0iqa2x1TjKmRJJul9JVRqb+ZZacg5lJ0kI1T1Q4MRC/JHRdoGxKRUJGAVc6Qs0goEpeDXSVatMHFG18IIi5MGG+mHq7dDt6ZrGNzCxEyIsHw5EaBZvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cMVHjAq/; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717425206; x=1748961206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N9/Wqkyb5MN4k29DLfSa6SJQmaJ+TBjkJgt2/RRENO0=;
  b=cMVHjAq/CfgWRkPSgvzjiflmGcNPAZyf73JMHyB6hVcUw+H1PU5VvbVG
   /lntEaaEMRa8CUiA04+vEZmOFtPC6Aukb2X/PR2bUEZeHYPgWMckdNFyX
   uMlFX1deki3X1z3es3yjAcj5g9GPvNcodoRSw8nGqlyqMWPP9gU4dnjNS
   I=;
X-IronPort-AV: E=Sophos;i="6.08,211,1712620800"; 
   d="scan'208";a="730707721"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:33:20 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:3132]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.238:2525] with esmtp (Farcaster)
 id c8519a5f-9c95-48ed-bc0e-edddf8be5e27; Mon, 3 Jun 2024 14:33:19 +0000 (UTC)
X-Farcaster-Flow-ID: c8519a5f-9c95-48ed-bc0e-edddf8be5e27
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 3 Jun 2024 14:33:19 +0000
Received: from 88665a182662.ant.amazon.com (10.88.143.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 3 Jun 2024 14:33:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Cong Wang
	<cong.wang@bytedance.com>
Subject: [PATCH v1 net 01/15] af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
Date: Mon, 3 Jun 2024 07:32:17 -0700
Message-ID: <20240603143231.62085-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240603143231.62085-1-kuniyu@amazon.com>
References: <20240603143231.62085-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When a SOCK_DGRAM socket connect()s to another socket, the both sockets'
sk->sk_state are changed to TCP_ESTABLISHED so that we can register them
to BPF SOCKMAP.

When the socket disconnects from the peer by connect(AF_UNSPEC), the state
is set back to TCP_CLOSE.

Then, the peer's state is also set to TCP_CLOSE, but the update is done
locklessly and unconditionally.

Let's say socket A connect()ed to B, B connect()ed to C, and A disconnects
from B.

After the first two connect()s, all three sockets' sk->sk_state are
TCP_ESTABLISHED:

  $ ss -xa
  Netid State  Recv-Q Send-Q  Local Address:Port  Peer Address:PortProcess
  u_dgr ESTAB  0      0       @A 641              * 642
  u_dgr ESTAB  0      0       @B 642              * 643
  u_dgr ESTAB  0      0       @C 643              * 0

And after the disconnect, B's state is TCP_CLOSE even though it's still
connected to C and C's state is TCP_ESTABLISHED.

  $ ss -xa
  Netid State  Recv-Q Send-Q  Local Address:Port  Peer Address:PortProcess
  u_dgr UNCONN 0      0       @A 641              * 642
  u_dgr UNCONN 0      0       @B 642              * 643
  u_dgr ESTAB  0      0       @C 643              * 0

In this case, we cannot register B to SOCKMAP.

So, when a socket disconnects from the peer, we should not set TCP_CLOSE to
the peer if the peer is connected to yet another socket, and this must be
done under unix_state_lock().

Note that we use WRITE_ONCE() for sk->sk_state as there are many lockless
readers.  These data-races will be fixed in the following patches.

Fixes: 83301b5367a9 ("af_unix: Set TCP_ESTABLISHED for datagram sockets too")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
CC: Cong Wang <cong.wang@bytedance.com>
---
 net/unix/af_unix.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 25b49efc0926..541216382cf5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -570,7 +570,6 @@ static void unix_dgram_disconnected(struct sock *sk, struct sock *other)
 			sk_error_report(other);
 		}
 	}
-	other->sk_state = TCP_CLOSE;
 }
 
 static void unix_sock_destructor(struct sock *sk)
@@ -1424,8 +1423,15 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 
 		unix_state_double_unlock(sk, other);
 
-		if (other != old_peer)
+		if (other != old_peer) {
 			unix_dgram_disconnected(sk, old_peer);
+
+			unix_state_lock(old_peer);
+			if (!unix_peer(old_peer))
+				WRITE_ONCE(old_peer->sk_state, TCP_CLOSE);
+			unix_state_lock(old_peer);
+		}
+
 		sock_put(old_peer);
 	} else {
 		unix_peer(sk) = other;
-- 
2.30.2


