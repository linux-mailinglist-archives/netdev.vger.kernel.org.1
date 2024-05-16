Return-Path: <netdev+bounces-96742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C5B8C78C2
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 16:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FFA1F238AD
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 14:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10014B965;
	Thu, 16 May 2024 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="aIMAJkjx"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2B147C77
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871370; cv=none; b=UlULbYfTQwXbr+QO/TPhYGPz3wiY1dMXSYUlNl2k+z0JtmzeQDFwQwi1qDXUiA6Vi68GTuVdaXnT1mTRPO9JRcFh0/OSAQh4v8cilTLHFl8OSUcZjcIGbG2DKxvJPEzSAddiJQRzsd/a82PN0pnJD/f4M9lof3EXbSSe8szv8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871370; c=relaxed/simple;
	bh=UvEMDoEskkrb8PTU8San+gck2ocf1oXdDH2rewNETwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZS6UHKkAb6C5tYCQyQOYMxgcAu4FtQyLIDrHnRovjJ167J9yuVSB+7nJKl6VXU+jJzXnf+dpuGlpXfAf7WH4SKaEZmPw5CMfcmRilC1abT7MWj71kORM3LSnXTVKLn6Kad5ZyeFuoZgmrlhBGjcANem3V4UPCmz3fMug3xyrvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=aIMAJkjx; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s7cWW-0030RR-7R; Thu, 16 May 2024 16:56:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From;
	bh=RaW+5qfz0YHC/9NJr/iWaBlW5djn61H2HuiWRRF/D6Q=; b=aIMAJkjxrQnQNXi/XfZatrz0Iu
	oeM4vyj3u0Zx2Qh5t7JNPumLMy9LbeEN/0FrFs1T6mWGwbwVCSnP3wCTmIe1n0oKgUTTj+lyFhOAa
	oqqEDCYQhUNaVTQ5LrN9xi+XUrAppPkQkC2Eqcw0QEX4O/vNHPGHFL6X11CtMkLgcaVa7aW7P5lAG
	PjVlygw2EQyS3zxSlY6ZrAMywXbgqFWdm/zaBoTdAFLwkMEHz8aO61vgC1sf82xLgVh4aOyuEhVPH
	wZQc/uGXZBh6HirNIQy/Cq7rs8I4qjiTjAQ/Mz14jiRFcrldu3cODu/OyCbdLekWhKUpHtlcCEnNh
	PR+tBmnQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s7cWV-0008CA-Ls; Thu, 16 May 2024 16:55:59 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s7cWP-000xkA-Cj; Thu, 16 May 2024 16:55:53 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	shuah@kernel.org,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v2 1/2] af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
Date: Thu, 16 May 2024 16:50:09 +0200
Message-ID: <20240516145457.1206847-2-mhal@rbox.co>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516145457.1206847-1-mhal@rbox.co>
References: <20240516145457.1206847-1-mhal@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GC attempts to explicitly drop oob_skb before purging the hit list.

The problem is with embryos: kfree_skb(u->oob_skb) is never called on an
embryo socket, as those sockets are not directly stacked by the SCC walk.

The python script below [0] sends a listener's fd to its embryo as OOB
data.  While GC does collect the embryo's queue, it fails to drop the OOB
skb's refcount.  The skb which was in embryo's receive queue stays as
unix_sk(sk)->oob_skb and keeps the listener's refcount [1].

Tell GC to dispose embryo's oob_skb.

[0]:
from array import array
from socket import *

addr = '\x00unix-oob'
lis = socket(AF_UNIX, SOCK_STREAM)
lis.bind(addr)
lis.listen(1)

s = socket(AF_UNIX, SOCK_STREAM)
s.connect(addr)
scm = (SOL_SOCKET, SCM_RIGHTS, array('i', [lis.fileno()]))
s.sendmsg([b'x'], [scm], MSG_OOB)
lis.close()

[1]
$ grep unix-oob /proc/net/unix
$ ./unix-oob.py
$ grep unix-oob /proc/net/unix
0000000000000000: 00000002 00000000 00000000 0001 02     0 @unix-oob
0000000000000000: 00000002 00000000 00010000 0001 01  6072 @unix-oob

Fixes: 4090fa373f0e ("af_unix: Replace garbage collection algorithm.")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/unix/garbage.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 1f8b8cdfcdc8..dfe94a90ece4 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -342,6 +342,18 @@ enum unix_recv_queue_lock_class {
 	U_RECVQ_LOCK_EMBRYO,
 };
 
+static void unix_collect_queue(struct unix_sock *u, struct sk_buff_head *hitlist)
+{
+	skb_queue_splice_init(&u->sk.sk_receive_queue, hitlist);
+
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+	if (u->oob_skb) {
+		WARN_ON_ONCE(skb_unref(u->oob_skb));
+		u->oob_skb = NULL;
+	}
+#endif
+}
+
 static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist)
 {
 	struct unix_vertex *vertex;
@@ -365,18 +377,11 @@ static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist
 
 				/* listener -> embryo order, the inversion never happens. */
 				spin_lock_nested(&embryo_queue->lock, U_RECVQ_LOCK_EMBRYO);
-				skb_queue_splice_init(embryo_queue, hitlist);
+				unix_collect_queue(unix_sk(skb->sk), hitlist);
 				spin_unlock(&embryo_queue->lock);
 			}
 		} else {
-			skb_queue_splice_init(queue, hitlist);
-
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-			if (u->oob_skb) {
-				kfree_skb(u->oob_skb);
-				u->oob_skb = NULL;
-			}
-#endif
+			unix_collect_queue(u, hitlist);
 		}
 
 		spin_unlock(&queue->lock);
-- 
2.45.0


