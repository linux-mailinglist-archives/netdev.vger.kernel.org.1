Return-Path: <netdev+bounces-86306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E712189E5CA
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2035E1C21288
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E38158D86;
	Tue,  9 Apr 2024 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sd1Wmmv+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B02158D99
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712703179; cv=none; b=ZBpsumlTkMaMi9jVHahT7Sun5gS23zc5p+5I4biQV6TwtPRl9P2KLGhQWsge/G37hmE/X24gRjkslvHXlRauNtGLZCZD+fyImcCcaEHyyc2W/EYn7HgVomq6Ntdp2dlIxAUYzZJTPv5DPaKmal3ONhkV+EMu+oIqKCFe6+F5qn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712703179; c=relaxed/simple;
	bh=3DTl/U6C4+1nLY26IsYDt2KiRp/Ij0PXdwyqXSdMz7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8UOVj4v11GxFEDz8eNU/aOgHI0ifV2dKvcpLhGzU/BI36kuaarmRLCbiJzR/ofaPEYTbK/ZG8SYmyDwRJ7L4hb+ML2EEnUVu1kdhIfxC4ZTHDa4SSZS9ZjRkI5MpT4SgDuYNjUOHB9c3nkHpSghYZBIOGDvOuHVhz3wABBLcpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sd1Wmmv+; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712703178; x=1744239178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QYH7nc8crhLZJB6pl/pvZvHXOC0SPwVWlVX7SNz8QrY=;
  b=sd1Wmmv+aP6YnckdXWuTTU34exjHlML24z8GrWDOltj7IrpRdX3LWIAr
   ITi2c8bn5t8xk50vdUUPXZft+ZrH1cuyfHa2Ev/LZuszaKJZezqcj7Aoh
   ntNb4SaGhQljT26lf6IB9olUseyvnHF7mF2S5A957EstApsZVliXKjtUb
   E=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="388632821"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:52:54 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:52890]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.49:2525] with esmtp (Farcaster)
 id e638c553-297a-4402-846c-00474f40cb84; Tue, 9 Apr 2024 22:52:53 +0000 (UTC)
X-Farcaster-Flow-ID: e638c553-297a-4402-846c-00474f40cb84
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 22:52:53 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Tue, 9 Apr 2024 22:52:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao shoaib <rao.shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 1/3] af_unix: Call manage_oob() for every skb in unix_stream_read_generic().
Date: Tue, 9 Apr 2024 15:52:07 -0700
Message-ID: <20240409225209.58102-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240409225209.58102-1-kuniyu@amazon.com>
References: <20240409225209.58102-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When we call recv() for AF_UNIX socket, we first peek one skb and
calls manage_oob() to check if the skb is sent with MSG_OOB.

However, when we fetch the next (and the following) skb, manage_oob()
is not called now, leading a wrong behaviour.

Let's say a socket send()s "hello" with MSG_OOB and the peer tries
to recv() 5 bytes with MSG_PEEK.  Here, we should get only "hell"
without 'o', but actually not:

  >>> from socket import *
  >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
  >>> c1.send(b'hello', MSG_OOB)
  5
  >>> c2.recv(5, MSG_PEEK)
  b'hello'

The first skb fills 4 bytes, and the next skb is peeked but not
properly checked by manage_oob().

Let's move up the again label to call manage_oob() for evry skb.

With this patch:

  >>> from socket import *
  >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
  >>> c1.send(b'hello', MSG_OOB)
  5
  >>> c2.recv(5, MSG_PEEK)
  b'hell'

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index d032eb5fa6df..f297320438bf 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2741,6 +2741,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		last = skb = skb_peek(&sk->sk_receive_queue);
 		last_len = last ? last->len : 0;
 
+again:
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 		if (skb) {
 			skb = manage_oob(skb, sk, flags, copied);
@@ -2752,7 +2753,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			}
 		}
 #endif
-again:
 		if (skb == NULL) {
 			if (copied >= target)
 				goto unlock;
-- 
2.30.2


