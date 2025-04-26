Return-Path: <netdev+bounces-186241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B97BA9D9FC
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 12:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0AF11BC202A
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 10:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F2A224AF0;
	Sat, 26 Apr 2025 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nN+8CViK"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA21EE021
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745661935; cv=none; b=jjGRX0Ri7pk7/SMB62o6qpch3nkhSZXOWzdg4FQOm7b8hkhfrTZZtritN6bOJvw2FBV9C1lQiOqiGUKEeM8bpyOvszD5wBxlaMOOlrvA8ML7es1EXDyNyknY+WumnKkU/mQknFzN4RCyS6u5kaWHNNtFvh1weyY+jT33olfkc34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745661935; c=relaxed/simple;
	bh=h5nDQI4JyGOjMxhPbRkAI1pqnBTIqjl9/FBQRi4VPGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XU33eVYGa0Utn1/RZabY9GK1+fGISv1PPO1Q4kf8tED4Sr9OrdKvpCiqJ5a9RyMrR+/gfx/cTo9Kxxdlm7cTyPXU2FdCRXfOPWvOhg+dPFbm5Z7CA8d3d78fL+5rMMeTYEvSAxbLBoJ0FvqxIzLHKfyY5/F4p2fN4bxdAqMl7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nN+8CViK; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745661920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tsXNwk53+3Gu5tZw/HRtX0kZWtSs7hie+/fyzm0FRPE=;
	b=nN+8CViKIByaAP4gQ2WEeblprOTXu2XVUZJvsbe6TGuHyxYG9Jc1+A65ihYAS5af8hGlAE
	wQE3TzwNcD9XP6lcmeuoSFLw6UhY+w4BTVfL93SXIypxW0dY3nxjWQVUGmrXzTBsC8lcgh
	5AZ5dlRnpPG3T0hM438QHHSpSeB9d08=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] tipc: Replace msecs_to_jiffies() with secs_to_jiffies()
Date: Sat, 26 Apr 2025 12:04:44 +0200
Message-ID: <20250426100445.57221-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use secs_to_jiffies() instead of msecs_to_jiffies() and avoid scaling
'delay' to milliseconds in tipc_crypto_rekeying_sched(). Compared to
msecs_to_jiffies(), secs_to_jiffies() expands to simpler code and
reduces the size of 'tipc.ko'.

Remove unnecessary parentheses around the local variable 'now'.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/tipc/crypto.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index c524421ec652..45edb29b6bd7 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -41,10 +41,10 @@
 #include "msg.h"
 #include "bcast.h"
 
-#define TIPC_TX_GRACE_PERIOD	msecs_to_jiffies(5000) /* 5s */
-#define TIPC_TX_LASTING_TIME	msecs_to_jiffies(10000) /* 10s */
-#define TIPC_RX_ACTIVE_LIM	msecs_to_jiffies(3000) /* 3s */
-#define TIPC_RX_PASSIVE_LIM	msecs_to_jiffies(15000) /* 15s */
+#define TIPC_TX_GRACE_PERIOD	secs_to_jiffies(5)
+#define TIPC_TX_LASTING_TIME	secs_to_jiffies(10)
+#define TIPC_RX_ACTIVE_LIM	secs_to_jiffies(3)
+#define TIPC_RX_PASSIVE_LIM	secs_to_jiffies(15)
 
 #define TIPC_MAX_TFMS_DEF	10
 #define TIPC_MAX_TFMS_LIM	1000
@@ -2348,7 +2348,7 @@ static void tipc_crypto_work_rx(struct work_struct *work)
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct tipc_crypto *rx = container_of(dwork, struct tipc_crypto, work);
 	struct tipc_crypto *tx = tipc_net(rx->net)->crypto_tx;
-	unsigned long delay = msecs_to_jiffies(5000);
+	unsigned long delay = secs_to_jiffies(5);
 	bool resched = false;
 	u8 key;
 	int rc;
@@ -2418,8 +2418,8 @@ void tipc_crypto_rekeying_sched(struct tipc_crypto *tx, bool changed,
 	}
 
 	if (tx->rekeying_intv || now) {
-		delay = (now) ? 0 : tx->rekeying_intv * 60 * 1000;
-		queue_delayed_work(tx->wq, &tx->work, msecs_to_jiffies(delay));
+		delay = now ? 0 : tx->rekeying_intv * 60;
+		queue_delayed_work(tx->wq, &tx->work, secs_to_jiffies(delay));
 	}
 }
 
-- 
2.49.0


