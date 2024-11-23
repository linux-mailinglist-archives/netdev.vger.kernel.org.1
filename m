Return-Path: <netdev+bounces-146903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE109D6A9E
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 18:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69868B20D55
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA0613635B;
	Sat, 23 Nov 2024 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pgug6xJ+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718A1804A
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732383772; cv=none; b=segwWvjY9/KZ9xdZ+PmxrNYjavOn2muNIaDtkp/0IH8iJ3e9q44hSYl1sIrZM6meAJnTceY+CHplGsgO36ebfta676I2yg4nCyQOOBDnf1ZS4sgPBLVHCOn9FbGm4dKqqIUMhHyRgOt56tEKDp56mbjrM9t6ZqrznAx2YKI+1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732383772; c=relaxed/simple;
	bh=dmxcL1gAbiMoEmTaiXcyOAfFnuGPWcS9J+WyGaLGWtI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uGaLdSwLQhK5I6n2ETF3xbKJi516f946ZJVf+mL7zMihz58Okd14pgyg7hYIX2XnOE6Cnx/m/6ZxAk1htSf62CG893SSWGjk64plyy8mKsgvO1fDvA64bAXvOrpXO9k4lmF7fmvXrtkNML2aYUc+AP6oGvWO9FC0OHwCfd2jDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pgug6xJ+; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732383770; x=1763919770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0gitUXPTNKu6s1bJVLonH9AFIqRpntLSKUE+HB2o4Jk=;
  b=pgug6xJ+wnPD8CZzNaMRbaBvVFx87EqgE6jvLU3gKVAQbgvaMUd2ahqx
   RJwjX03bjwsc/WCpzqHbotYtQN+Ec4gGHKAIJYMOgQd9rc5Dzz7JcnI+a
   6ZNVrbxxwF3QoCZbY1ogyYMae5obwnZS3diAxaP9Fv317WUZrl7PxLDSw
   0=;
X-IronPort-AV: E=Sophos;i="6.12,179,1728950400"; 
   d="scan'208";a="445451387"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2024 17:42:47 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:11556]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.94:2525] with esmtp (Farcaster)
 id dedc20ef-3991-48ed-a10f-64fc307be814; Sat, 23 Nov 2024 17:42:45 +0000 (UTC)
X-Farcaster-Flow-ID: dedc20ef-3991-48ed-a10f-64fc307be814
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 23 Nov 2024 17:42:45 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sat, 23 Nov 2024 17:42:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Liu Jian
	<liujian56@huawei.com>
Subject: [PATCH v1 net] tcp: Fix use-after-free of nreq in reqsk_timer_handler().
Date: Sat, 23 Nov 2024 09:42:36 -0800
Message-ID: <20241123174236.62438-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The cited commit replaced inet_csk_reqsk_queue_drop_and_put() with
__inet_csk_reqsk_queue_drop() and reqsk_put() in reqsk_timer_handler().

Then, oreq should be passed to reqsk_put() instead of req; otherwise
use-after-free of nreq could happen when reqsk is migrated but the
retry attempt failed (e.g. due to timeout).

Let's pass oreq to reqsk_put().

Fixes: e8c526f2bdf1 ("tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().")
Reported-by: Liu Jian <liujian56@huawei.com>
Closes: https://lore.kernel.org/netdev/1284490f-9525-42ee-b7b8-ccadf6606f6d@huawei.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_connection_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 491c2c6b683e..6872b5aff73e 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1191,7 +1191,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 
 drop:
 	__inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
-	reqsk_put(req);
+	reqsk_put(oreq);
 }
 
 static bool reqsk_queue_hash_req(struct request_sock *req,
-- 
2.39.5 (Apple Git-154)


