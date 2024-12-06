Return-Path: <netdev+bounces-149629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6500C9E6852
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD67280E7C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 07:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444591DDC35;
	Fri,  6 Dec 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EnJSLkEP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8511DCB0E
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471903; cv=none; b=eO9x32Fc5L94Y2DoPVuzg14poGNfDvh5HDUP0zJWM8e0frLRr9LgcDU1ogR3RgQ99STp69sx463E629Sq/PLv9McOv/PGhU9cEXf6ZyQAWpNud9nO81fPy8m/G8WImWIe3IDs41qQSW7YsFunzJ1DFwFVfHyAxihnAtiFQQ0bLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471903; c=relaxed/simple;
	bh=Zm9Jq7/V9XZzH/Uk0XlPQKc117CUqd7wpFFdyxWlAVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZP7KNmOrOa3Z/D24zEw9AvQJqCeHOGBNR4cugxJeBzJKgGUS02v4Nj6qtG0DFoHv57Z3UrnqCnUwNV3+B2lkB7cnzjdJcwK2y2S3PYT+gMbiKrbufXUw6zhtVvZoPxWVKWmrTlwRaljAiuLFyiYNikHb3KCGW5hmBnm1QT4VakQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EnJSLkEP; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733471901; x=1765007901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MpC9Ly06tWsEP+CE7s+uh4xvlVu/hDAy6+FXQn72DoY=;
  b=EnJSLkEPW7BSo/mmwTO438WzClbFk7lDwCKWQTBYUC0HLgsJXPrv9Jc5
   17yApArUzN/aAt/lf/oz0jPUgrGNfjvamCSTJuwE6r1Sz7th0JpqXPdGz
   Hyquu5Dc650m42C1wayXi79N1IfyiT+UcZXHUT6BjUYnkRNaYeVoeUrNt
   k=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="47151313"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:58:19 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:6789]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.230:2525] with esmtp (Farcaster)
 id 06437cdb-47c4-4f33-ba01-71a5fc73f3f3; Fri, 6 Dec 2024 07:58:19 +0000 (UTC)
X-Farcaster-Flow-ID: 06437cdb-47c4-4f33-ba01-71a5fc73f3f3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 07:58:18 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 07:58:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 09/15] socket: Respect hold_net in sk_alloc().
Date: Fri, 6 Dec 2024 16:54:58 +0900
Message-ID: <20241206075504.24153-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241206075504.24153-1-kuniyu@amazon.com>
References: <20241206075504.24153-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
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


