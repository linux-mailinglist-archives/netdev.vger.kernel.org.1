Return-Path: <netdev+bounces-213082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47666B2382B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 21:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CA96E1091
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C45529BD9A;
	Tue, 12 Aug 2025 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stegemann.de header.i=@stegemann.de header.b="IMhMeYmJ"
X-Original-To: netdev@vger.kernel.org
Received: from dd41718.kasserver.com (dd41718.kasserver.com [85.13.145.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F106217F35;
	Tue, 12 Aug 2025 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.145.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026375; cv=none; b=tQh02jF86dY/VXZq/IHZt1Y8NX1CbyuI1rpjZFdloBYxusyG22qMPA+4eLmenWlFRz6acr90gVh8vLlLrgHekTBKxgugjUjr4vlQTBePp9CZsysu3CAMndZHktogNBxNyRzmilnZN/eKIIuaYQTnYEv+nMaFz0yYLkEX/ofzMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026375; c=relaxed/simple;
	bh=D2Xk4OH+6m3wLaeHRW4xK72zqMuMS4FXJH5QUHiQQXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiCjHRtT0wv89qQ9tOqqQPh64T5Np+qEefzquVGw7bnszHU8JCnfs2ori2TkcLvegke+3vb9bgTW0mKjW3picittDkZtFBQlW+MWPZQVhhDvbccIQUUdqzZ1605WrqqtXtqoKgHvL6aETL4h5R+Jh9JaBcKolSGWzu81rlAtiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stegemann.de; spf=pass smtp.mailfrom=stegemann.de; dkim=pass (2048-bit key) header.d=stegemann.de header.i=@stegemann.de header.b=IMhMeYmJ; arc=none smtp.client-ip=85.13.145.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stegemann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stegemann.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stegemann.de;
	s=kas202307141421; t=1755026364;
	bh=6NC/zPC58MOV+2MGBQRnLpJTHomDbA820tZUXXHCrnw=;
	h=From:To:Cc:Subject:Date:From;
	b=IMhMeYmJIwQWhsUr+3a6aOU1/YvirqR7eLouKmCBhA+gpu/PseCQOwTNJkN+hj2Af
	 b4fHLBcknwipPXh/gLGbh4fTDoGnMRXxxzqYwsuZDvjHawf8sydw1tiREPvZYpQQcZ
	 ox3xHx6chZdp7oxwUiwmhr+LmYizscfk605QeODcRokuIFLzh/vvn+J8UQgZ6EH3Ob
	 IQxPQwVVDeBnNxK+dUHH+1JgCqBzbTA6uJ706fVOZKiNMm8TNbIzvS8aCnVXalsY57
	 gNp5XOBewxccswABCFs5UDwuyxtvd3E+eV8KqioTZm9gi/Hzs4qbHvw5DNiYB5zpOA
	 B+hm6lSWWfbvQ==
Received: from DESKTOP-I55TJV0.localdomain (p5b2eae0a.dip0.t-ipconnect.de [91.46.174.10])
	by dd41718.kasserver.com (Postfix) with ESMTPSA id 818DD55E02B1;
	Tue, 12 Aug 2025 21:19:23 +0200 (CEST)
From: Sven Stegemann <sven@stegemann.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sven Stegemann <sven@stegemann.de>,
	syzbot+e62c9db591c30e174662@syzkaller.appspotmail.com,
	syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com,
	syzbot+be6b1fdfeae512726b4e@syzkaller.appspotmail.com
Subject: [PATCH net v2] net: kcm: Fix race condition in kcm_unattach()
Date: Tue, 12 Aug 2025 21:18:03 +0200
Message-ID: <20250812191810.27777-1-sven@stegemann.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++

syzbot found a race condition when kcm_unattach(psock)
and kcm_release(kcm) are executed at the same time.

kcm_unattach() is missing a check of the flag
kcm->tx_stopped before calling queue_work().

If the kcm has a reserved psock, kcm_unattach() might get executed
between cancel_work_sync() and unreserve_psock() in kcm_release(),
requeuing kcm->tx_work right before kcm gets freed in kcm_done().

Remove kcm->tx_stopped and replace it by the less
error-prone disable_work_sync().

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Reported-by: syzbot+e62c9db591c30e174662@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e62c9db591c30e174662
Reported-by: syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d199b52665b6c3069b94
Reported-by: syzbot+be6b1fdfeae512726b4e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be6b1fdfeae512726b4e
Signed-off-by: Sven Stegemann <sven@stegemann.de>
---
v2:
 - merge disable_work() and cancel_work_sync() into disable_work_sync()
v1: https://lore.kernel.org/netdev/20250809063622.117420-1-sven@stegemann.de/
---
 include/net/kcm.h |  1 -
 net/kcm/kcmsock.c | 10 ++--------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/net/kcm.h b/include/net/kcm.h
index 441e993be634..d9c35e71ecea 100644
--- a/include/net/kcm.h
+++ b/include/net/kcm.h
@@ -71,7 +71,6 @@ struct kcm_sock {
 	struct list_head wait_psock_list;
 	struct sk_buff *seq_skb;
 	struct mutex tx_mutex;
-	u32 tx_stopped : 1;
 
 	/* Don't use bit fields here, these are set under different locks */
 	bool tx_wait;
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index a4971e6fa943..b4f01cb07561 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -430,7 +430,7 @@ static void psock_write_space(struct sock *sk)
 
 	/* Check if the socket is reserved so someone is waiting for sending. */
 	kcm = psock->tx_kcm;
-	if (kcm && !unlikely(kcm->tx_stopped))
+	if (kcm)
 		queue_work(kcm_wq, &kcm->tx_work);
 
 	spin_unlock_bh(&mux->lock);
@@ -1693,12 +1693,6 @@ static int kcm_release(struct socket *sock)
 	 */
 	__skb_queue_purge(&sk->sk_write_queue);
 
-	/* Set tx_stopped. This is checked when psock is bound to a kcm and we
-	 * get a writespace callback. This prevents further work being queued
-	 * from the callback (unbinding the psock occurs after canceling work.
-	 */
-	kcm->tx_stopped = 1;
-
 	release_sock(sk);
 
 	spin_lock_bh(&mux->lock);
@@ -1714,7 +1708,7 @@ static int kcm_release(struct socket *sock)
 	/* Cancel work. After this point there should be no outside references
 	 * to the kcm socket.
 	 */
-	cancel_work_sync(&kcm->tx_work);
+	disable_work_sync(&kcm->tx_work);
 
 	lock_sock(sk);
 	psock = kcm->tx_psock;
-- 
2.50.1

