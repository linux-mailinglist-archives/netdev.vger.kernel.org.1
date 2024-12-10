Return-Path: <netdev+bounces-150547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AEF9EA9CB
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF6218862DA
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A4322CBD2;
	Tue, 10 Dec 2024 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HMW5Kxez"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C31172BD5
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816514; cv=none; b=eFTZ3cVAo3ORsoqMSYKAnxuFRaY2GC0DMAlbkslKplC+xzHnjhnRqGO7azSBZtNzCkcBvawLOLLMdLELz8R4LPToZ5V6h3SgdgcqpxKWwzGzmBvaDu8bAOKQiho9vVtzU7BdkmT86LvHc5QaaRwH2XgonS58EWtUHg2+7/0+lFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816514; c=relaxed/simple;
	bh=Zm9Jq7/V9XZzH/Uk0XlPQKc117CUqd7wpFFdyxWlAVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tg5xWTg5CCSzJigISnMdIpZaZCUz/1p3Plm+hkmYCVMFPv5aYpgbVK7ao7nHySjKJmZ8nQcFaZgZ3+ERwT2AS5y5yyo2koNu+1McDB9AjLxdGGCQw6QVaFF2Qwkqa5MIhmFPzbg1oKTpnPIN0fPjZE13zRxpuawPySARJHlciOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HMW5Kxez; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733816513; x=1765352513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MpC9Ly06tWsEP+CE7s+uh4xvlVu/hDAy6+FXQn72DoY=;
  b=HMW5Kxezir2QRltQM90QDF8EGQwkN9D6HgNHJbv/P77Rae6zvMLL/ypI
   9a4VR/wLdE+bVOHhMAFijb6n9SUMo0sV+Ss1ZSvWHYBJA9KI/00wut+aq
   HFSk1Ckbdp4sjTEot0qeeWppI9hBAxOhoIJWHeB5KHYZyZwcfaDm+pqHb
   w=;
X-IronPort-AV: E=Sophos;i="6.12,221,1728950400"; 
   d="scan'208";a="47984905"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:41:49 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:59567]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.73:2525] with esmtp (Farcaster)
 id 1395d3af-59f2-4c56-863a-c77bc6834c04; Tue, 10 Dec 2024 07:41:48 +0000 (UTC)
X-Farcaster-Flow-ID: 1395d3af-59f2-4c56-863a-c77bc6834c04
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 07:41:48 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.88.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 07:41:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 09/15] socket: Respect hold_net in sk_alloc().
Date: Tue, 10 Dec 2024 16:38:23 +0900
Message-ID: <20241210073829.62520-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241210073829.62520-1-kuniyu@amazon.com>
References: <20241210073829.62520-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will introduce a new API to create a kernel socket with netns
refcnt held.

sk->sk_net_refcnt was set to 0 when kern was 1 in sk_alloc().

Now we have the hold_net flag in sk_alloc().

Let's set it to sk->sk_net_refcnt and add an assertion to catch
only one illegal pattern.

No functional change is introduced for now because currently
hold_net == !kern.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/sock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 8546d97cc6ec..11aa6d8c0cdd 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2224,9 +2224,12 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		 * why we need sk_prot_creator -acme
 		 */
 		sk->sk_prot = sk->sk_prot_creator = prot;
+
+		DEBUG_NET_WARN_ON_ONCE(!kern && !hold_net);
 		sk->sk_kern_sock = kern;
 		sock_lock_init(sk);
-		sk->sk_net_refcnt = kern ? 0 : 1;
+
+		sk->sk_net_refcnt = hold_net;
 		if (likely(sk->sk_net_refcnt)) {
 			get_net_track(net, &sk->ns_tracker, priority);
 			sock_inuse_add(net, 1);
-- 
2.39.5 (Apple Git-154)


