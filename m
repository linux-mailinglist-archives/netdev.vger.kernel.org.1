Return-Path: <netdev+bounces-96923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49418C8398
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 11:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1264B1C21B0F
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA54219E1;
	Fri, 17 May 2024 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Dwvx0H+d"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA72722324
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938330; cv=none; b=R+JtcqBcwDqMBwXFglI8wwaKYRj7BsfG+8DNh8YoR5KKeNIDbxhn318oupbGHiaanK4/1qgmufgKivdjYf1WaUyHy8vSw4vJjEPr/uMFK/BhTZzicM54GIjv/wGNulTWnJJf+KWNupgH86EahFujPIZkB8jukEoEasMZnY7UwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938330; c=relaxed/simple;
	bh=kXzSCaoHprIm7lNjKNUMgvG3ZWiIZOpe+OGbnRBrq5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4F905smPLR7UlNqGzHrawjCiSYqJZb0UeA4rpmjLvJWsTb+S5cKx0sGAuNI1s0Y0UfYFTdHOVOub1NTL2k4OhndaZUPb5XRH4+t1gl4tthLOrNvHecvOlMbjoE88FAuKbvBWcrHV7V2iI3wizQs9iTgqMI3uqwsUleBizfwLf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Dwvx0H+d; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s7twa-005L3x-HT; Fri, 17 May 2024 11:32:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From;
	bh=yokzBYS17hWADW2KY3nlMvcWNr12nOM5EuszZJW34Xw=; b=Dwvx0H+dAnU1WYspSfgAi9j/kw
	bcWbACXXEIWvdEaPnjzzIEA84Thty2gZQ5c8ktXZV7GU5ESHOxaYelyQOEJZTzPOxS2x9Ra/yOxpD
	ipCp4vnQDP3H5gZZPRQh035m+K5gY3Q1kjM96kakA8I+L4qpwWmKb7Q5RnwAVb6WhrJ5Oxn1CAVep
	eqmhMwEp0CnOEi49rs8vy8zEXPqYFJuX+8i69F29uM7jxTSfyTjSJD2eDt7XmstXPloc6QzX2aNqx
	ahnwtkXKN8RZMgtNeGaaIAj9WwSWsXlB5LmO172OWxjUcb0xAh+gTmXjQL5/6R3zU1ZdCPE+l5qbQ
	GVIeI/RQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s7twV-0000b4-5E; Fri, 17 May 2024 11:31:59 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s7twQ-0042Jz-2t; Fri, 17 May 2024 11:31:54 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	shuah@kernel.org,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH v3 net 1/2] af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
Date: Fri, 17 May 2024 11:27:01 +0200
Message-ID: <20240517093138.1436323-2-mhal@rbox.co>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240517093138.1436323-1-mhal@rbox.co>
References: <20240517093138.1436323-1-mhal@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GC attempts to explicitly drop oob_skb's reference before purging the hit
list.

The problem is with embryos: kfree_skb(u->oob_skb) is never called on an
embryo socket.

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
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


