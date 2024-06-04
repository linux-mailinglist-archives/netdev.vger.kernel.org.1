Return-Path: <netdev+bounces-100689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4571D8FB993
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2AD1F24F8C
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D648214883F;
	Tue,  4 Jun 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LCetpOgL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BBA146D71
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520001; cv=none; b=E93Fy7ooAwFHCfdmqc/f6xp06MM4VWnGyUkM3iRHM4sdW6Bs6ABTnR8VyleeODoH6PAm2ORuKEhbWR782lO6Ewr3EOygfmn0iePwjT2hNKdIedMM8Ncvkb5bt/PNm1NfR4UqCa+XdfhM+V22hJbdCMC3U2y7VXkd/hQ7EvJsFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520001; c=relaxed/simple;
	bh=wRuOKWfU6wp0gkX0ECizns+0HwZcYhiXvplX1v8oET8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlTZGzUqdx4GL9L+vapmgL08JWlTtHtHr1UQx3t88WZPlIVv0a8PXBWnKksEL2MDbcMS764D6IsrFWXXk7LwAoAxjRfStdmRLx9Y+02bnfl6SB/a9DObXz4Pgzqe8iBNe+npnhBW1XqtSc0w+Nw3yTmTBNqKBvBTfd6W9S/HM28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LCetpOgL; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717520000; x=1749056000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x6NQk/Vl4BGkVzzcqiCVdwrVM6R4SEd3igy91h8wJSI=;
  b=LCetpOgLZI87A2sQTqxTI+QD7coxh/VuAQoiIFxP7BX0k4udHyncAzXy
   kc/3BCkWdcihrlEjd3TaGXGPDKBcCXZsxw9v9KX/m6USOiVvVcoPj407z
   TaPfkXhayaQf/hB/TUpZPdtqQStT/VVHC6gyyo97EHyNPmzbcb9AqV3i2
   o=;
X-IronPort-AV: E=Sophos;i="6.08,214,1712620800"; 
   d="scan'208";a="94166907"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 16:53:18 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:47481]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.213:2525] with esmtp (Farcaster)
 id 6b6c476f-e72f-4328-a171-3a8a4f31db6c; Tue, 4 Jun 2024 16:53:18 +0000 (UTC)
X-Farcaster-Flow-ID: 6b6c476f-e72f-4328-a171-3a8a4f31db6c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Jun 2024 16:53:17 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 4 Jun 2024 16:53:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Cong Wang
	<cong.wang@bytedance.com>
Subject: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
Date: Tue, 4 Jun 2024 09:52:27 -0700
Message-ID: <20240604165241.44758-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240604165241.44758-1-kuniyu@amazon.com>
References: <20240604165241.44758-1-kuniyu@amazon.com>
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
  u_dgr UNCONN 0      0       @A 641              * 0
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
index 25b49efc0926..b162164b7a42 100644
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
+			unix_state_unlock(old_peer);
+		}
+
 		sock_put(old_peer);
 	} else {
 		unix_peer(sk) = other;
-- 
2.30.2


